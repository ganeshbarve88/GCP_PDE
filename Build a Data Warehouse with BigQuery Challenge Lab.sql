CREATE OR REPLACE TABLE `qwiklabs-gcp-01-fa5cb49988e7.covid.oxford_policy_tracker`
 PARTITION BY date
 OPTIONS (
   partition_expiration_days=2175,
   description="covid data"
 ) AS
 select * from `bigquery-public-data.covid19_govt_response.oxford_policy_tracker` 
 where  alpha_3_code not in ('GBR','BRA','USA','CAN')


 UPDATE
`qwiklabs-gcp-01-fa5cb49988e7.covid_data.consolidate_covid_tracker_data` t0
SET
t0.population = t2.pop_data_2019
FROM
(SELECT DISTINCT country_territory_code, pop_data_2019 FROM `bigquery-public-data.covid19_ecdc.covid_19_geographic_distribution_worldwide`) AS t2
WHERE t0.alpha_3_code = t2.country_territory_code;


UPDATE `qwiklabs-gcp-01-fa5cb49988e7.covid_data.consolidate_covid_tracker_data` t0
set t0.country_area= t1.country_area
from 
`bigquery-public-data.census_bureau_international.country_names_area` t1
where t0.country_name=t1.country_name