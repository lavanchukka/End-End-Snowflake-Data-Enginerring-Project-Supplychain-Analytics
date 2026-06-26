-- Run as Admin
use role accountadmin;

----------------------------------Databases---DEV & PROD-------------------
-- Create Dev database
Create database Supplychain_dev_db
comment = 'Supplychain Project -Developer Database';

-- Create Prod database
Create database Supplychain_prod_db
comment = 'Supplychain Project - Production Database';

---------------------------------Schmeas------------------------------------

-----------------------------Dev-Schemas--------------

Create Schema if not exists supplychain_dev_db.bronze_schema
comment = 'Raw data ingestion layer' ;

Create Schema if not exists supplychain_dev_db.silver_schema
comment = 'Transformation layer' ;

Create Schema if not exists supplychain_dev_db.gold_schema
comment = 'Aggregation/metrics layer' ;

Create Schema if not exists supplychain_dev_db.serving_schema
comment = 'Final/Serving layer' ;

-----------------------------Prod-Schemas--------------

Create Schema if not exists supplychain_prod_db.bronze_schema
comment = 'Raw data ingestion layer' ;

Create Schema if not exists supplychain_prod_db.silver_schema
comment = 'Transformation layer' ;

Create Schema if not exists supplychain_prod_db.gold_schema
comment = 'Aggregation/metrics layer' ;

Create Schema if not exists supplychain_prod_db.serving_schema
comment = 'Final/Serving layer' ;

-----------------------------Warehouses------------------------------------------
-----Common for DEV&PROD

 --------------Warehouse for Pipeline Activities---------
 
Create warehouse if not exists supplychain_pipeline_wh
   warehouse_size = 'x-small'
   auto_suspend = 500
   auto_resume =true
   comment = 'Warehouse for Pipeline tasks - ingestion/transformations/tasks' ;

    --------------Warehouse for Analytics---------
 
Create warehouse if not exists supplychain_analytics_wh
   warehouse_size = 'x-small'
   auto_suspend = 500
   auto_resume =true
   comment = 'Warehouse for Analytics tasks - Dashboard/querying/data sharing' ;

-------------------------Resource Monitors-----------------------------------------------

-------Pipleine Warehouse Monitor----

Create resource monitor supplychain_pipeline_rm
  with credit_quota = 25
  frequency = monthly
  start_timestamp = immediately
  triggers 
         on 85 percent do notify
         on 95 percent do notify
         on 100 percent do suspend ;

-------Analytics Warehouse Monitor----

Create resource monitor supplychain_analytics_rm
  with credit_quota = 25
  frequency = monthly
  start_timestamp = immediately
  triggers 
         on 85 percent do notify
         on 95 percent do notify
         on 100 percent do suspend ;


---------Assign Monitors to Warehouses

Alter warehouse supplychain_pipeline_wh set resource_monitor = supplychain_pipeline_rm ;
Alter warehouse supplychain_analytics_wh set resource_monitor = supplychain_analytics_rm ;


------------------------------GRANT ACCESS/PRIVILEGES TO SYSADMIN-----------------------

use role accountadmin;

grant execute task on account to role sysadmin;

--------Grant usage access on WAREHOUSES------

grant usage on warehouse supplychain_analytics_wh to role sysadmin;
grant usage on warehouse supplychain_pipeline_wh to role sysadmin;

---------Grant usage access on Databeases & Schemas---------------------

grant all privileges on database supplychain_dev_db to role sysadmin ;
grant all privileges on database supplychain_prod_db to role sysadmin ;

grant all privileges on all schemas in database supplychain_dev_db to role sysadmin ;
grant all privileges on all schemas in database supplychain_prod_db to role sysadmin ;

------------------Verify--------------------
show databases like 'supplychain_%' ; 
show warehouses like 'supplychain_%' ; 