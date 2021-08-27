{{ config(materialized='view', bind=False) }}

SELECT distinct cdc_contract_id, cdc_customer_id, cdc_pod_id, cdc_bill_id, cdc_pseudo_bill_id, sds_country, sds_contract_status, 
sds_customer_status, sds_segment_l1, qty_factoring, qty_installmentplan, sxt_customerdisconnectivitiy, sxt_distribution_company, 
sds_sales_channel, sds_enel_company, sds_document_type, sxt_status_local, sds_status_global, sds_segment, sds_market, 
sds_commodity, qty_energy_billed, qty_power_billed, sds_unity_measure, dtc_dt_reading_prev, dtc_dt_reading_act, 
dtc_dt_bill_from, dtc_dt_bill_to, dtc_dt_issue_date, dtc_dt_first_due, dtc_dt_second_due, sds_voltage_level, 
sds_tariff_l1, sxt_tariff_l2, sds_concept_l1, sxt_concept_l2, qty_amount_concept_l1, qty_amount_concept_l1_tax, 
qty_amount_concept_l1_total, qty_amount_billed_without_tax_first_due_date, qty_amount_billed_total_first_due_date, 
qty_amount_billed_without_tax_second_due_date, qty_amount_billed_total_second_due_date, fln_e_bill, sxt_typeofdelivery,
GETDATE() last_update
FROM {{ source('global_brazil_ceara', 'bt_global_billing_brazil_ceara') }}