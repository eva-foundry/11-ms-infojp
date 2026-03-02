# Project Plan

<!-- veritas-normalized 2026-02-25 prefix=F11 source=README.md -->

## Feature: Overview [ID=F11-01]

## Feature: Deployment Information [ID=F11-02]

## Feature: ?? Quick Start with GitHub Codespaces (5 Minutes) [ID=F11-03]

### Story: 1. Create Codespace [ID=F11-03-001]

### Story: 2. Run Deployment [ID=F11-03-002]

### Story: 3. Start Development Servers [ID=F11-03-003]

## Feature: MVP Goal [ID=F11-04]

### Story: Advanced Features Roadmap [ID=F11-04-001]

## Feature: Scope [ID=F11-05]

### Story: In-Scope for MVP [ID=F11-05-001]

### Story: Out-of-Scope for MVP [ID=F11-05-002]

## Feature: Architecture Overview [ID=F11-06]

### Story: Logical Architecture (ABRG-aligned) [ID=F11-06-001]

### Story: Key Components [ID=F11-06-002]

## Feature: Data Ingestion & CanLII CDC Approach [ID=F11-07]

### Story: Change Data Capture (CDC) Strategy [ID=F11-07-001]

- [ ] Tier 1 ? Registry Polling (Metadata-based) [ID=F11-07-001-T01]
- [ ] Tier 2 ? Artifact Verification (Content-based) [ID=F11-07-001-T02]

### Story: CDC Core Principles [ID=F11-07-002]

### Story: Deterministic Re-runs [ID=F11-07-003]

## Feature: UX Principles and Improvements [ID=F11-08]

### Story: Current State (Baseline) [ID=F11-08-001]

### Story: MVP UX Enhancements [ID=F11-08-002]

### Story: Design Philosophy [ID=F11-08-003]

## Feature: Success Criteria (Testable) [ID=F11-09]

### Story: Functional Criteria [ID=F11-09-001]

### Story: UX Criteria [ID=F11-09-002]

### Story: Non-Functional Criteria [ID=F11-09-003]

## Feature: Project Structure [ID=F11-10]

### Story: Why Fresh Clone Instead of EVA-JP-v1.2? [ID=F11-10-001]

## Feature: Developer Quickstart [ID=F11-11]

### Story: Prerequisites Status [ID=F11-11-001]

### Story: Quickstart: GitHub Codespaces (Recommended) [ID=F11-11-002]

### Story: Alternative: Local Development Setup [ID=F11-11-003]

### Story: Key Configuration Files [ID=F11-11-004]

## Feature: Post-Deployment: Cherry-Picking from EVA-JP-v1.2 [ID=F11-12]

### Story: 1. RAG Approach Enhancements [ID=F11-12-001]

### Story: 2. Jurisprudence-Specific Prompts [ID=F11-12-002]

### Story: 3. Testing with ESDC Enhancements [ID=F11-12-003]

## Feature: Delivery Phases [ID=F11-13]

### Story: Phase 0: Baseline Setup (Week 1) [ID=F11-13-001]

### Story: Phase 1: JP Ingestion Pipeline (Weeks 2-3) [ID=F11-13-002]

### Story: Phase 2: RAG with Citations (Weeks 4-5) [ID=F11-13-003]

### Story: Phase 3: UX Polish and Prompt Tuning (Week 6) [ID=F11-13-004]

### Story: Phase 4: Hardening and Handoff (Week 7) [ID=F11-13-005]

## Feature: Risks and Mitigations [ID=F11-14]

### Story: Risk 1: CanLII API Limitations [ID=F11-14-001]

### Story: Risk 2: Citation Accuracy [ID=F11-14-002]

### Story: Risk 3: Response Time Exceeds 30 Seconds [ID=F11-14-003]

### Story: Risk 4: Insufficient Azure OpenAI Quota [ID=F11-14-004]

### Story: Risk 5: Security / Authentication Issues [ID=F11-14-005]

### Story: Risk 6: Data Quality Issues [ID=F11-14-006]

### Story: Risk 7: Scope Creep [ID=F11-14-007]

## Feature: References [ID=F11-15]

## Feature: Contact and Support [ID=F11-16]

## Feature: License [ID=F11-17]

## Feature: API API [ID=F11-API]

### Story: GET / [ID=F11-API-001]

### Story: GET / [ID=F11-API-002]

## Feature: HEALTH API [ID=F11-HEALTH]

### Story: GET /health [ID=F11-HEALTH-001]

### Story: GET /health [ID=F11-HEALTH-002]

## Feature: CHAT API [ID=F11-CHAT]

### Story: POST /chat [ID=F11-CHAT-001]

## Feature: GETALLUPLOAD API [ID=F11-GETALLUPLOAD]

### Story: POST /getalluploadstatus [ID=F11-GETALLUPLOAD-001]

## Feature: GETFOLDERS API [ID=F11-GETFOLDERS]

### Story: POST /getfolders [ID=F11-GETFOLDERS-001]

## Feature: DELETEITEMS API [ID=F11-DELETEITEMS]

### Story: POST /deleteItems [ID=F11-DELETEITEMS-001]

## Feature: RESUBMITITEM API [ID=F11-RESUBMITITEM]

### Story: POST /resubmitItems [ID=F11-RESUBMITITEM-001]

## Feature: GETTAGS API [ID=F11-GETTAGS]

### Story: POST /gettags [ID=F11-GETTAGS-001]

## Feature: LOGSTATUS API [ID=F11-LOGSTATUS]

### Story: POST /logstatus [ID=F11-LOGSTATUS-001]

## Feature: GETINFODATA API [ID=F11-GETINFODATA]

### Story: GET /getInfoData [ID=F11-GETINFODATA-001]

## Feature: GETWARNINGBA API [ID=F11-GETWARNINGBA]

### Story: GET /getWarningBanner [ID=F11-GETWARNINGBA-001]

## Feature: GETMAXCSVFIL API [ID=F11-GETMAXCSVFIL]

### Story: GET /getMaxCSVFileSize [ID=F11-GETMAXCSVFIL-001]

## Feature: GETCITATION API [ID=F11-GETCITATION]

### Story: POST /getcitation [ID=F11-GETCITATION-001]

## Feature: GETAPPLICATI API [ID=F11-GETAPPLICATI]

### Story: GET /getApplicationTitle [ID=F11-GETAPPLICATI-001]

## Feature: GETALLTAGS API [ID=F11-GETALLTAGS]

### Story: GET /getalltags [ID=F11-GETALLTAGS-001]

## Feature: GETTEMPIMAGE API [ID=F11-GETTEMPIMAGE]

### Story: GET /getTempImages [ID=F11-GETTEMPIMAGE-001]

## Feature: GETHINT API [ID=F11-GETHINT]

### Story: GET /getHint [ID=F11-GETHINT-001]

## Feature: POSTTD API [ID=F11-POSTTD]

### Story: POST /posttd [ID=F11-POSTTD-001]

## Feature: PROCESS_TD_A API [ID=F11-PROCESS_TD_A]

### Story: GET /process_td_agent_response [ID=F11-PROCESS_TD_A-001]

## Feature: GETTDANALYSI API [ID=F11-GETTDANALYSI]

### Story: GET /getTdAnalysis [ID=F11-GETTDANALYSI-001]

## Feature: REFRESH API [ID=F11-REFRESH]

### Story: POST /refresh [ID=F11-REFRESH-001]

## Feature: STREAM API [ID=F11-STREAM]

### Story: GET /stream [ID=F11-STREAM-001]

## Feature: TDSTREAM API [ID=F11-TDSTREAM]

### Story: GET /tdstream [ID=F11-TDSTREAM-001]

## Feature: PROCESS_AGEN API [ID=F11-PROCESS_AGEN]

### Story: GET /process_agent_response [ID=F11-PROCESS_AGEN-001]

## Feature: GETFEATUREFL API [ID=F11-GETFEATUREFL]

### Story: GET /getFeatureFlags [ID=F11-GETFEATUREFL-001]

## Feature: FILE API [ID=F11-FILE]

### Story: POST /file [ID=F11-FILE-001]

## Feature: GETFILE API [ID=F11-GETFILE]

### Story: POST /get-file [ID=F11-GETFILE-001]

## Feature: MODELS API [ID=F11-MODELS]

### Story: GET /models [ID=F11-MODELS-001]

### Story: GET /models/{model} [ID=F11-MODELS-002]

### Story: POST /models/{model}/embed [ID=F11-MODELS-003]

## Feature: Infrastructure Resources [ID=F11-INFRA]

### Story: azurerm_resource_group "rg" [ID=F11-INFRA-001]

### Story: azurerm_cosmosdb_sql_role_assignment "user_cosmosdb_data_contributor" [ID=F11-INFRA-002]

### Story: azurerm_cosmosdb_sql_role_assignment "webApp_cosmosdb_data_contributor" [ID=F11-INFRA-003]

### Story: azurerm_cosmosdb_sql_role_assignment "functionApp_cosmosdb_data_contributor" [ID=F11-INFRA-004]

### Story: azurerm_cosmosdb_sql_role_assignment "enrichmentApp_cosmosdb_data_contributor" [ID=F11-INFRA-005]

### Story: azurerm_resource_group_template_deployment "customer_attribution" [ID=F11-INFRA-006]

### Story: azurerm_container_registry "acr" [ID=F11-INFRA-007]

### Story: azurerm_private_endpoint "ContainerRegistryPrivateEndpoint" [ID=F11-INFRA-008]

### Story: azurerm_cosmosdb_account "cosmosdb_account" [ID=F11-INFRA-009]

### Story: azurerm_cosmosdb_sql_database "log_database" [ID=F11-INFRA-010]

### Story: azurerm_cosmosdb_sql_container "log_container" [ID=F11-INFRA-011]

### Story: azurerm_private_endpoint "cosmosPrivateEndpoint" [ID=F11-INFRA-012]

### Story: azurerm_search_service "search" [ID=F11-INFRA-013]

### Story: azurerm_private_endpoint "searchPrivateEndpoint" [ID=F11-INFRA-014]

### Story: azurerm_resource_group_template_deployment "sharepoint_logicapp" [ID=F11-INFRA-015]

### Story: azurerm_storage_account "storage" [ID=F11-INFRA-016]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs" [ID=F11-INFRA-017]

### Story: azurerm_monitor_diagnostic_setting "blob_diagnostic_logs" [ID=F11-INFRA-018]

### Story: azurerm_monitor_diagnostic_setting "file_diagnostic_logs" [ID=F11-INFRA-019]

### Story: azurerm_monitor_diagnostic_setting "queue_diagnostic_logs" [ID=F11-INFRA-020]

### Story: azurerm_monitor_diagnostic_setting "table_diagnostic_logs" [ID=F11-INFRA-021]

### Story: azurerm_resource_group_template_deployment "container" [ID=F11-INFRA-022]

### Story: azurerm_resource_group_template_deployment "queue" [ID=F11-INFRA-023]

### Story: azurerm_private_endpoint "blobPrivateEndpoint" [ID=F11-INFRA-024]

### Story: azurerm_private_endpoint "filePrivateEndpoint" [ID=F11-INFRA-025]

### Story: azurerm_private_endpoint "tablePrivateEndpoint" [ID=F11-INFRA-026]

### Story: azurerm_private_endpoint "queuePrivateEndpoint" [ID=F11-INFRA-027]

### Story: azurerm_storage_blob "config" [ID=F11-INFRA-028]

### Story: azurerm_resource_group_template_deployment "bing_search" [ID=F11-INFRA-029]

### Story: azurerm_cognitive_account "cognitiveService" [ID=F11-INFRA-030]

### Story: azurerm_private_endpoint "accountPrivateEndpoint" [ID=F11-INFRA-031]

### Story: azurerm_cognitive_account "docIntelligenceAccount" [ID=F11-INFRA-032]

### Story: azurerm_private_endpoint "docintPrivateEndpoint" [ID=F11-INFRA-033]

### Story: azurerm_cognitive_account "openaiAccount" [ID=F11-INFRA-034]

### Story: azurerm_cognitive_deployment "deployment" [ID=F11-INFRA-035]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs" [ID=F11-INFRA-036]

### Story: azurerm_private_endpoint "openaiPrivateEndpoint" [ID=F11-INFRA-037]

### Story: azurerm_service_plan "appServicePlan" [ID=F11-INFRA-038]

### Story: azurerm_monitor_autoscale_setting "scaleout" [ID=F11-INFRA-039]

### Story: azurerm_linux_web_app "enrichmentapp" [ID=F11-INFRA-040]

### Story: azurerm_role_assignment "acr_pull_role" [ID=F11-INFRA-041]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_commercial" [ID=F11-INFRA-042]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_usgov" [ID=F11-INFRA-043]

### Story: azurerm_private_endpoint "privateEnrichmentEndpoint" [ID=F11-INFRA-044]

### Story: azurerm_key_vault_access_policy "policy" [ID=F11-INFRA-045]

### Story: azurerm_service_plan "funcServicePlan" [ID=F11-INFRA-046]

### Story: azurerm_monitor_autoscale_setting "scaleout" [ID=F11-INFRA-047]

### Story: azurerm_role_assignment "acr_pull_role" [ID=F11-INFRA-048]

### Story: azurerm_linux_function_app "function_app" [ID=F11-INFRA-049]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_commercial" [ID=F11-INFRA-050]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_usgov" [ID=F11-INFRA-051]

### Story: azurerm_key_vault_access_policy "policy" [ID=F11-INFRA-052]

### Story: azurerm_private_endpoint "privateFunctionEndpoint" [ID=F11-INFRA-053]

### Story: azurerm_service_plan "appServicePlan" [ID=F11-INFRA-054]

### Story: azurerm_monitor_autoscale_setting "scaleout" [ID=F11-INFRA-055]

### Story: azurerm_role_assignment "acr_pull_role" [ID=F11-INFRA-056]

### Story: azurerm_linux_web_app "app_service" [ID=F11-INFRA-057]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_commercial" [ID=F11-INFRA-058]

### Story: azurerm_monitor_diagnostic_setting "diagnostic_logs_usgov" [ID=F11-INFRA-059]

### Story: azurerm_key_vault_access_policy "policy" [ID=F11-INFRA-060]

### Story: azurerm_private_endpoint "backendPrivateEndpoint" [ID=F11-INFRA-061]

### Story: azurerm_network_security_group "nsg" [ID=F11-INFRA-062]

### Story: azurerm_network_ddos_protection_plan "ddos" [ID=F11-INFRA-063]

### Story: azurerm_resource_group_template_deployment "vnet_w_subnets" [ID=F11-INFRA-064]

### Story: azurerm_private_dns_resolver "private_dns_resolver" [ID=F11-INFRA-065]

### Story: azurerm_private_dns_resolver_inbound_endpoint "private_dns_resolver" [ID=F11-INFRA-066]

### Story: azurerm_private_dns_zone "pr_dns_zone" [ID=F11-INFRA-067]

### Story: azurerm_private_dns_zone_virtual_network_link "pr_dns_vnet_link" [ID=F11-INFRA-068]

### Story: azurerm_log_analytics_workspace "logAnalytics" [ID=F11-INFRA-069]

### Story: azurerm_application_insights "applicationInsights" [ID=F11-INFRA-070]

### Story: azurerm_monitor_diagnostic_setting "nsg_diagnostic_logs" [ID=F11-INFRA-071]

### Story: azurerm_monitor_private_link_scope "ampls" [ID=F11-INFRA-072]

### Story: azurerm_monitor_private_link_scoped_service "ampl-ss_log_analytics" [ID=F11-INFRA-073]

### Story: azurerm_monitor_private_link_scoped_service "ampl_ss_app_insights" [ID=F11-INFRA-074]

### Story: azurerm_private_endpoint "ampls" [ID=F11-INFRA-075]

### Story: azurerm_private_dns_zone "monitor" [ID=F11-INFRA-076]

### Story: azurerm_private_dns_a_record "monitor_api" [ID=F11-INFRA-077]

### Story: azurerm_private_dns_a_record "monitor_global" [ID=F11-INFRA-078]

### Story: azurerm_private_dns_a_record "monitor_profiler" [ID=F11-INFRA-079]

### Story: azurerm_private_dns_a_record "monitor_live" [ID=F11-INFRA-080]

### Story: azurerm_private_dns_a_record "monitor_snapshot" [ID=F11-INFRA-081]

### Story: azurerm_private_dns_zone_virtual_network_link "monitor-net" [ID=F11-INFRA-082]

### Story: azurerm_private_dns_zone "oms" [ID=F11-INFRA-083]

### Story: azurerm_private_dns_a_record "oms_law_id" [ID=F11-INFRA-084]

### Story: azurerm_private_dns_zone_virtual_network_link "oms-net" [ID=F11-INFRA-085]

### Story: azurerm_private_dns_zone "ods" [ID=F11-INFRA-086]

### Story: azurerm_private_dns_a_record "ods_law_id" [ID=F11-INFRA-087]

### Story: azurerm_private_dns_zone_virtual_network_link "ods-net" [ID=F11-INFRA-088]

### Story: azurerm_private_dns_zone "agentsvc" [ID=F11-INFRA-089]

### Story: azurerm_private_dns_a_record "agentsvc_law_id" [ID=F11-INFRA-090]

### Story: azurerm_private_dns_zone_virtual_network_link "agentsvc-net" [ID=F11-INFRA-091]

### Story: azurerm_private_dns_a_record "blob_scadvisorcontentpld" [ID=F11-INFRA-092]

### Story: azurerm_application_insights_workbook "example" [ID=F11-INFRA-093]

### Story: azurerm_key_vault "kv" [ID=F11-INFRA-094]

### Story: azurerm_key_vault_access_policy "infoasst" [ID=F11-INFRA-095]

### Story: azurerm_private_endpoint "kv_private_endpoint" [ID=F11-INFRA-096]

### Story: azurerm_resource_group_template_deployment "kv_secret" [ID=F11-INFRA-097]

### Story: azurerm_role_assignment "role" [ID=F11-INFRA-098]

## Feature: Operations Scripts [ID=F11-OPS]

### Story: command_exists() [ID=F11-OPS-001]

### Story: install_azure_cli() [ID=F11-OPS-002]

### Story: write_array_block() [ID=F11-OPS-003]

### Story: printInfo() [ID=F11-OPS-004]

### Story: set_yellow_text() [ID=F11-OPS-005]

### Story: reset_text_color() [ID=F11-OPS-006]

### Story: escape_string() [ID=F11-OPS-007]

### Story: import_resource_if_needed() [ID=F11-OPS-008]

### Story: get_secret() [ID=F11-OPS-009]

### Story: set_yellow_text() [ID=F11-OPS-010]

### Story: reset_text_color() [ID=F11-OPS-011]

### Story: show_usage() [ID=F11-OPS-012]

### Story: printInfo() [ID=F11-OPS-013]
