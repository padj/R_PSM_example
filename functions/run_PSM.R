run_PSM <- function(data_library, 
                    model_controls,
                    abridged = FALSE){
  
  # creates empty traces
  trt_trace <- build_trace()
  ctrl_trace <- build_trace()
  
  
  # Model controls
  T <- model_controls$value[model_controls$var_name == 'T']
  t <- model_controls$value[model_controls$var_name == 't']
  T_unit <- model_controls$detail[model_controls$var_name == 'T']
  cohort <- model_controls$value[model_controls$var_name == 'cohort']
  
  # Populate the control trace
  for (i in t:T){
    # Calculate the next row in the trace
    
    # Time:
    cycle <- i
    
    if (T_unit == 'weeks'){
      T_w <- i
      T_m <- i/4.3452381
      T_y <- i/52.1428571
      
    } else if (T_unit == 'months'){
      T_w <- i*4.3452381
      T_m <- i
      T_y <- i/12
      
    } else if (T_unit == 'years'){
      T_w <- i*52.1428571
      T_m <- i*12
      T_y <- i
      
    } else{
      simpleError('Invalid time unit chosen')
    }
    
    # Discounting:
    discount_cost <- 1/(1+model_controls$value[model_controls$var_name == 'cost_discount'])^T_y
    
    discount_benefit <- 1/(1+model_controls$value[model_controls$var_name == 'benefit_discount'])^T_y
    
    # health state occupancy:
    ctrl_PFS <- get_PFS(data_library$trt_PFS, cycle, T_unit)
    ctrl_OS <- get_OS(data_library$trt_OS, cycle, T_unit)
    ctrl_PD <- OS-PFS
    ctrl_PFS_cohort <- ctrl_PFS*cohort
    ctrl_OS_cohort <- ctrl_OS*cohort
    ctrl_PD_cohort <- ctrl_PD*cohort
    #ctrl_dead_new <-
    #ctrl_dead_acm <- 
    #ctrl_dead_total <- 
    
    # health state costs:
    # 'PFS utility (undiscounted)',
    # 'PD utility (undiscounted)',
    
    # AE occurrences 
    ctrl_AE1 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE1'] * ctrl_OS_cohort
    ctrl_AE2 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE2'] * ctrl_OS_cohort
    ctrl_AE3 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE3'] * ctrl_OS_cohort
    ctrl_AE4 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE4'] * ctrl_OS_cohort	
    ctrl_AE5 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE5'] * ctrl_OS_cohort
    ctrl_AE6 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE6'] * ctrl_OS_cohort	
    ctrl_AE7 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE7'] * ctrl_OS_cohort	
    ctrl_AE8 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE8'] * ctrl_OS_cohort	
    ctrl_AE9 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE9'] * ctrl_OS_cohort
    ctrl_AE10 <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_prob_AE10'] * ctrl_OS_cohort
    
    # AE costs
    ctrl_AE1_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE1'] * ctrl_AE1
    ctrl_AE2_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE2'] * ctrl_AE2
    ctrl_AE3_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE3'] * ctrl_AE3
    ctrl_AE4_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE4'] * ctrl_AE4	
    ctrl_AE5_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE5'] * ctrl_AE5
    ctrl_AE6_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE6'] * ctrl_AE6	
    ctrl_AE7_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE7'] * ctrl_AE7	
    ctrl_AE8_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE8'] * ctrl_AE8	
    ctrl_AE9_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE9'] * ctrl_AE9
    ctrl_AE10_cost <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_cost_AE10'] * ctrl_AE10
    ctrl_AE_total_cost <- (ctrl_AE1_cost + ctrl_AE2_cost + ctrl_AE3_cost +
                          ctrl_AE4_cost + ctrl_AE5_cost + ctrl_AE6_cost +
                          ctrl_AE7_cost + ctrl_AE8_cost + ctrl_AE9_cost + 
                          ctrl_AE10_cost)

    'Age utility (undiscounted)',
    'AE1 utility (undiscounted)',
    'AE2 utility (undiscounted)',
    'AE3 utility (undiscounted)',
    'AE4 utility (undiscounted)',
    'AE5 utility (undiscounted)',
    'AE6 utility (undiscounted)',
    'AE7 utility (undiscounted)',
    'AE8 utility (undiscounted)',
    'AE9 utility (undiscounted)',
    'AE10 utility (undiscounted)',
    'Total AE utility (undiscounted)',
    'PFS utility (discounted)',
    'PD utility (discounted)',
    'Age utility (discounted)',
    'AE1 utility (discounted)',
    'AE2 utility (discounted)',
    'AE3 utility (discounted)',
    'AE4 utility (discounted)',
    'AE5 utility (discounted)',
    'AE6 utility (discounted)',
    'AE7 utility (discounted)',
    'AE8 utility (discounted)',
    'AE9 utility (discounted)',
    'AE10 utility (discounted)',
    'Total AE utility (discounted)',
    'Life years',
    'Total QALY (undiscounted)',
    'Total QALY (discounted)'
    
    
    
    # costs
    PFS_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_PFS']*ctrl_PFS_cohort
    PD_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_PD']*ctrl_PD_cohort
    death_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_death']*ctrl_dead_new
    #treat_cost <- 
    
    
    new_row_treatment <- data.frame('Cycle' = cycle,
                                    'Time (Weeks)' = T_w,
                                    'Time (Months)' = T_m,
                                    'Time (Years)' = T_y,
                                    'Discounting (Costs)' = discount_cost,
                                    'Discounting (Benefits)' = discount_benefit,				
                                    'PFS' = ctrl_PFS,
                                    'PD' = ctrl_PD,
                                    'OS' = ctrl_OS,
                                    'PFS (cohort)' = ctrl_PFS_cohort,
                                    'PD (cohort)' = ctrl_PD_cohort,
                                    'OS (cohort)' = ctrl_OS_cohort,
                                    'Dead (new)',
                                    'Dead (ACM)',
                                    'Dead (total)',
                                    'AE1',
                                    'AE2',	
                                    'AE3',	
                                    'AE4',	
                                    'AE5',
                                    'AE6',	
                                    'AE7',	
                                    'AE8',	
                                    'AE9',
                                    'AE10',
                                    'PFS cost (undiscounted)',
                                    'PD cost (undiscounted)',
                                    'Death cost (undiscounted)',
                                    'Treatment cost (undiscounted)',
                                    'AE1 cost (undiscounted)',
                                    'AE2 cost (undiscounted)',	
                                    'AE3 cost (undiscounted)',	
                                    'AE4 cost (undiscounted)',	
                                    'AE5 cost (undiscounted)',
                                    'AE6 cost (undiscounted)',	
                                    'AE7 cost (undiscounted)',	
                                    'AE8 cost (undiscounted)',	
                                    'AE9 cost (undiscounted)',
                                    'AE10 cost (undiscounted)',
                                    'Total AE cost (undiscounted)',
                                    'PFS cost (discounted)',
                                    'PD cost (discounted)',
                                    'Death cost (discounted)',
                                    'Treatment cost (discounted)',
                                    'AE1 cost (discounted)',
                                    'AE2 cost (discounted)',	
                                    'AE3 cost (discounted)',	
                                    'AE4 cost (discounted)',	
                                    'AE5 cost (discounted)',
                                    'AE6 cost (discounted)',	
                                    'AE7 cost (discounted)',	
                                    'AE8 cost (discounted)',	
                                    'AE9 cost (discounted)',
                                    'AE10 cost (discounted)',
                                    'Total AE cost (discounted)',
                                    'PFS utility (undiscounted)',
                                    'PD utility (undiscounted)',
                                    'Age utility (undiscounted)',
                                    'AE1 utility (undiscounted)',
                                    'AE2 utility (undiscounted)',
                                    'AE3 utility (undiscounted)',
                                    'AE4 utility (undiscounted)',
                                    'AE5 utility (undiscounted)',
                                    'AE6 utility (undiscounted)',
                                    'AE7 utility (undiscounted)',
                                    'AE8 utility (undiscounted)',
                                    'AE9 utility (undiscounted)',
                                    'AE10 utility (undiscounted)',
                                    'Total AE utility (undiscounted)',
                                    'PFS utility (discounted)',
                                    'PD utility (discounted)',
                                    'Age utility (discounted)',
                                    'AE1 utility (discounted)',
                                    'AE2 utility (discounted)',
                                    'AE3 utility (discounted)',
                                    'AE4 utility (discounted)',
                                    'AE5 utility (discounted)',
                                    'AE6 utility (discounted)',
                                    'AE7 utility (discounted)',
                                    'AE8 utility (discounted)',
                                    'AE9 utility (discounted)',
                                    'AE10 utility (discounted)',
                                    'Total AE utility (discounted)',
                                    'Life years',
                                    'Total QALY (undiscounted)',
                                    'Total QALY (discounted)') 
  }
  
}
  


  
#   Returns:
#     trt_trace
#     ctrl_trace
#     summary_results_table
#     cost_breakdown_table
#     cost_breakdown_chart (stacked bar chart)
#     qaly_breakdown_table
#     qaly_breakdown_chart (stacked bar chart)
#     CE_plane
#     (Discounted & undiscounted)
#   abridged=TRUE returns only the traces and summary results (used for DSA&PSA)