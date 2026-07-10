# End-End-Snowflake-Data-Engineering--Supplychain-Analytics
This Project is an end-end implementation of data engineering in snowflake on supplychain data utilizing all of its services like Integrations, Warehouses, Schemas, Databases, Snowpipe, Streams, tasks, Streamlit, Zero Clone, Access Control and Governance.

───────────────────────────────────────-------------─
SNOWFLAKE OBJECTS COVERED
────────────────────────────────────────-------------
Database · Schema · Warehouse · Resource Monitor · Storage Integration · Notification Integration · External Stage · File Format · Snowpipe · Transient Table · Permanent Table · Temporary Table · Variant · Stream · Task · Stored Procedure · Sequence · Dynamic Table · Secure View · Streamlit · Alert · Data Share · Reader Account · Zero-Copy Clone

📦 DATA GENERATION
→ Python + Faker generates nested JSON supply chain orders
→ Azure SDK uploads files to Azure ADLS Gen2
→ Historical mode: 300 records at once 
→ Continuous mode: 100 records every 30s 

☁️ AZURE SETUP
→ Azure ADLS Gen2 — landing zone for JSON files
→ Azure Event Grid + Storage Queue — triggers Snowpipe on file arrival

❄️ SNOWFLAKE ACCOUNT SETUP
→ 2 Databases (DEV + PROD), 4 Schemas each
→ 2 Virtual Warehouses + 2 Resource Monitors
→ Storage Integration + Notification Integration

🥉 BRONZE LAYER
→ External Stage + JSON File Format
→ Transient table stores raw JSON as Variant with metadata
→ Snowpipe — auto-ingest on file arrival. No polling.
─────────────────── PART-1 ─────────────────────

─────────────────── PART-2 ─────────────────────
🥈 SILVER LAYER — STAGE 1
→ Append-Only Stream + Task
→ Stored Procedure — flattens JSON, validates, cleans data
→ Permanent table for clean records + Transient table for rejected records

🥈 SILVER LAYER — STAGE 2 — STAR SCHEMA
→ Standard Stream + Task
→ Stored Procedure — Temporary table, 6 MERGEs, Sequences for surrogate keys
→ 5 Permanent Dimension tables — surrogate keys, SCD Type 1
→ Permanent Fact table — 5 FKs, measures, dedup

🥇 GOLD LAYER — DYNAMIC TABLES
→ Base Dynamic Table — LAG = 1 MIN, joins all Silver tables
→ 4 Downstream Dynamic Tables — Order Fulfillment, Supplier Performance, Inventory Turnover, Shipment Delays
→ Silver queried once. Half the compute cost.

🔭 SERVING LAYER
→ 4 Secure Views on Gold Dynamic Tables
→ Analysts query views not tables. Required for Data Sharing.
─────────────────── PART-2 ─────────────────────

─────────────────── PART-3 ─────────────────────
📊 STREAMLIT DASHBOARD
→ Built natively in Snowflake. 60-second refresh.
→ Trends, Breakdown and Suppliers tabs. Live KPIs.

🔐 GOVERNANCE
→ Email Notification Integration
→ Pipeline Health Alert — Bronze + Silver + Gold every 5 mins
→ Data Share + Reader Account — partners query live data

🚀 DEV TO PROD
→ Zero-copy clone — full promotion in 60 seconds
→ PROD Snowpipe, Streams, Tasks and Alerts recreated
─────────────────── PART-3 ─────────────────────
