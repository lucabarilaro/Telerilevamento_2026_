
// ==============================================
// Sentinel-2 Surface Reflectance
// Isola del Giglio - Vegetation analysis
// Years: 2020 - 2023 - 2026
// ROBUST LAND-ONLY VERSION (R-safe export)
// ==============================================



// ==============================================
// Cloud masking using QA60
// ==============================================

function maskS2clouds(image) {

  var qa = image.select('QA60');

  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image
    .updateMask(mask)
    .divide(10000);
}



// ==============================================
// MULTI-YEAR PERMANENT WATER MASK
// ==============================================

var s2All = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2020-01-01', '2026-12-31')
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);


// NDWI multi-year mean
var ndwiMulti = s2All.map(function(img) {
  return img.normalizedDifference(['B3', 'B8']);
}).mean();


// permanent sea mask
var waterMaskPermanent = ndwiMulti.gt(0.05);



// ==============================================
// DYNAMIC WATER MASK (per image)
// ==============================================

function maskWater(image) {

  var ndwi = image.normalizedDifference(['B3', 'B8']);
  var scl = image.select('SCL');

  var dynamicWater = ndwi.lt(0.0).and(scl.neq(6));

  var waterMask = dynamicWater.and(waterMaskPermanent.not());

  return image.updateMask(waterMask);
}



// ==============================================
// Create seasonal composite
// ==============================================

function getComposite(startDate, endDate) {

  var collection = ee.ImageCollection(
    'COPERNICUS/S2_SR_HARMONIZED'
  )

  .filterBounds(aoi)
  .filterDate(startDate, endDate)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))

  .map(maskS2clouds)
  .map(maskWater);

  print('Number of images:', startDate, collection.size());

  return collection
    .median()
    .clip(aoi.buffer(100));
}



// ==============================================
// Images
// ==============================================

var img2020 = getComposite('2020-04-01', '2020-06-30');
var img2023 = getComposite('2023-04-01', '2023-06-30');
var img2026 = getComposite('2026-04-01', '2026-06-30');



// ==============================================
// Select bands
// ==============================================

var bandsAnalysis = ['B2', 'B3', 'B4', 'B8'];

img2020 = img2020.select(bandsAnalysis);
img2023 = img2023.select(bandsAnalysis);
img2026 = img2026.select(bandsAnalysis);



// ==============================================
// FORCE CLEAN MASK (CRUCIAL FOR R EXPORT)
// ==============================================

img2020 = img2020.selfMask();
img2023 = img2023.selfMask();
img2026 = img2026.selfMask();



// ==============================================
// Visualization RGB
// ==============================================

Map.centerObject(aoi, 11);

var rgb = {
  bands: ['B4', 'B3', 'B2'],
  min: 0,
  max: 0.3
};

Map.addLayer(img2020, rgb, 'RGB 2020');
Map.addLayer(img2023, rgb, 'RGB 2023');
Map.addLayer(img2026, rgb, 'RGB 2026');



// ==============================================
// EXPORT (R-SAFE)
// ==============================================

Export.image.toDrive({

  image: img2020,
  description: 'Giglio_Sentinel2_2020',
  folder: 'GEE_exports',
  fileNamePrefix: 'Giglio_2020_B2_B3_B4_B8',
  region: aoi,
  scale: 10,
  crs: 'EPSG:32632',
  maxPixels: 1e13
});

Export.image.toDrive({

  image: img2023,
  description: 'Giglio_Sentinel2_2023',
  folder: 'GEE_exports',
  fileNamePrefix: 'Giglio_2023_B2_B3_B4_B8',
  region: aoi,
  scale: 10,
  crs: 'EPSG:32632',
  maxPixels: 1e13
});

Export.image.toDrive({

  image: img2026,
  description: 'Giglio_Sentinel2_2026',
  folder: 'GEE_exports',
  fileNamePrefix: 'Giglio_2026_B2_B3_B4_B8',
  region: aoi,
  scale: 10,
  crs: 'EPSG:32632',
  maxPixels: 1e13
});
