"""
Created on 1st March 2023 19:35

@author: Caroline Gasten

credits to Albrecht Weerts for similar python script to download SEAS5 data
"""

import os
path = r'C:\\Users\\gasten\\OneDrive - Stichting Deltares\\Documents\\02_Data\01_Meteorological_Data\\ERA5\\01_raw\\HoA'
os.chdir(path)
import cdsapi

variables= ['surface_net_solar_radiation', '2m_temperature', 'total_precipitation', '10m_v_component_of_wind', '10m_u_component_of_wind', 'mean_sea_level_pressure', '2m_dewpoint_temperature', 'surface_net_thermal_radiation']
variables_short = ['ssr', 't2m', 'tp', 'v10', 'u10', 'msl', '2d', 'str']
year_range = range(1993, 2024)

c=cdsapi.Client()

for year in year_range:
    print(year)
    for i in range(0, len(variables)):
        print(variables[i])
        target = "ERA5_%s_%04d"% (variables_short[i],year)
        target = target+'.nc'
        c.retrieve(
            'reanalysis-era5-single-levels',
            {
                'product_type': 'reanalysis',
                'variable': variables[i],
                'year': str(year),
                'month': [
                    '01', '02', '03',
                    '04', '05', '06',
                    '07', '08', '09',
                    '10', '11', '12',
                ],
                'day': [
                    '01', '02', '03',
                    '04', '05', '06',
                    '07', '08', '09',
                    '10', '11', '12',
                    '13', '14', '15',
                    '16', '17', '18',
                    '19', '20', '21',
                    '22', '23', '24',
                    '25', '26', '27',
                    '28', '29', '30',
                    '31',
                ],
                'time': [
                    '00:00', '01:00', '02:00',
                    '03:00', '04:00', '05:00',
                    '06:00', '07:00', '08:00',
                    '09:00', '10:00', '11:00',
                    '12:00', '13:00', '14:00',
                    '15:00', '16:00', '17:00',
                    '18:00', '19:00', '20:00',
                    '21:00', '22:00', '23:00',
                ],
                'area': [
                    16, 22.5, -5,
                    52,
                ],
                'format': 'netcdf',
            },
            target) 
        