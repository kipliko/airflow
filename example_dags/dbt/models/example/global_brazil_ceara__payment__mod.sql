{{ config(materialized='ephemeral') }}

SELECT cdc_contract_id, cdc_customer_id, cdc_bill_id, sds_country, sds_status_local, sds_status_global, 
fln_fractional_payment, cdc_fractional_payment_id, sds_enel_company, sds_segment, sds_market, 
sds_commodity, sds_concept_l1, cdc_concept_l2, qty_amount_concept_l2, qty_total_amount_payed, 
dtc_dt_customer_payment, dtc_dt_batch_payment, dtc_dt_accounting, cdc_id_collection_channel, 
sds_collection_channel, cdc_id_collection_partner, cdc_collection_partner, cdc_id_deposit
FROM {{ source('global_brazil_ceara', 'bt_global_payment_brazil_ceara') }}