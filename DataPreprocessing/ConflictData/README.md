The directory contains three scripts for analysing and preprocessing the conflict data from UCDP-GED.

1. 01_ConflictDataAnalysis_Kenya.ipynb has been the base for the data processing steps. It analyses the data structure, issues with temporal and spatial precision codes and the different conflict types in Kenya and the study area.
2. 02_ConflictDataPreprocessing_HoA.ipynb retrieves monthly event count and binary conflict occurrence variables for each admin-1 level in the wider study area (Kenya, Ethiopia, South Sudan, Somalia, Uganda) and for the dominant conflicting ethnic groups in North-Western Kenya.
3. 03_QGIS_SpatialQueryAdjacent.txt contains the spatial query used in QGIS to retrieve adjacent administrative units from GADM3.6 data for: 'Kenya', 'Ethiopia', 'South Sudan', 'Sudan', 'Somalia', 'Uganda', 'Djibouti', 'Eritrea', 'Tanzania', 'DR Congo (Zaire)', 'Central African Republic', 'Rwanda'
4. 04_ConflictDataPreprocessing_RF.ipynb contains the necessary steps to construct the three conflict-related input variables for the RF model: time since last communal conflict and spatially lagged variables for communal conflict or other conflict in adjacent administrative units
