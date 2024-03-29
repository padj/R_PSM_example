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
    ctrl_PFS <- get_PFS(data_library$ctrl_PFS, cycle, T_unit)
    ctrl_OS <- get_OS(data_library$ctrl_OS, cycle, T_unit)
    ctrl_PD <- ctrl_OS-ctrl_PFS
    ctrl_PFS_cohort <- ctrl_PFS*cohort
    ctrl_OS_cohort <- ctrl_OS*cohort
    ctrl_PD_cohort <- ctrl_PD*cohort
    #ctrl_dead_new <-
    #ctrl_dead_acm <- 
    #ctrl_dead_total <- 
    
    # health state costs:
    PFS_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_PFS']*ctrl_PFS_cohort
    PD_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_PD']*ctrl_PD_cohort
    #death_cost <- data_library$costs$mean[data_library$costs$var_name == 'cost_death']*ctrl_dead_new
    
    # health state utilities
    # age related utility
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
    
    # AE utilities
    ctrl_AE1_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE1'] * ctrl_AE1
    ctrl_AE2_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE2'] * ctrl_AE2
    ctrl_AE3_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE3'] * ctrl_AE3
    ctrl_AE4_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE4'] * ctrl_AE4
    ctrl_AE5_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE5'] * ctrl_AE5
    ctrl_AE6_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE6'] * ctrl_AE6
    ctrl_AE7_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE7'] * ctrl_AE7
    ctrl_AE8_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE8'] * ctrl_AE8
    ctrl_AE9_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE9'] * ctrl_AE9
    ctrl_AE10_disutil <- data_library$ae$mean[data_library$ae$var_name == 'ctrl_disutil_AE10'] * ctrl_AE10
    ctrl_AE_total_disutil <- (ctrl_AE1_disutil + ctrl_AE2_disutil + ctrl_AE3_disutil +
                              ctrl_AE4_disutil + ctrl_AE5_disutil + ctrl_AE6_disutil +
                              ctrl_AE7_disutil + ctrl_AE8_disutil + ctrl_AE9_disutil + 
                              ctrl_AE10_disutil)
    
    # 
    
    
    #'Life years',
    #'Total QALY (undiscounted)',
    #'Total QALY (discounted)'
    
    
    
    # costs
    
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
                                    'Dead (new)' = 0,
                                    'Dead (ACM)' = 0,
                                    'Dead (total)' = 0,
                                    'AE1' = 0,
                                    'AE2' = 0,	
                                    'AE3' = 0,	
                                    'AE4' = 0,	
                                    'AE5' = 0,
                                    'AE6' = 0,	
                                    'AE7' = 0,	
                                    'AE8' = 0,	
                                    'AE9' = 0,
                                    'AE10' = 0,
                                    'PFS cost (undiscounted)' = 0,
                                    'PD cost (undiscounted)' = 0,
                                    'Death cost (undiscounted)' = 0,
                                    'Treatment cost (undiscounted)' = 0,
                                    'AE1 cost (undiscounted)' = 0,
                                    'AE2 cost (undiscounted)' = 0,	
                                    'AE3 cost (undiscounted)' = 0,	
                                    'AE4 cost (undiscounted)' = 0,	
                                    'AE5 cost (undiscounted)' = 0,
                                    'AE6 cost (undiscounted)' = 0,	
                                    'AE7 cost (undiscounted)' = 0,	
                                    'AE8 cost (undiscounted)' = 0,	
                                    'AE9 cost (undiscounted)' = 0,
                                    'AE10 cost (undiscounted)' = 0,
                                    'Total AE cost (undiscounted)' = 0,
                                    'PFS cost (discounted)' = 0,
                                    'PD cost (discounted)' = 0,
                                    'Death cost (discounted)' = 0,
                                    'Treatment cost (discounted)' = 0,
                                    'AE1 cost (discounted)' = 0,
                                    'AE2 cost (discounted)' = 0,	
                                    'AE3 cost (discounted)' = 0,	
                                    'AE4 cost (discounted)' = 0,	
                                    'AE5 cost (discounted)' = 0,
                                    'AE6 cost (discounted)' = 0,	
                                    'AE7 cost (discounted)' = 0,	
                                    'AE8 cost (discounted)' = 0,	
                                    'AE9 cost (discounted)' = 0,
                                    'AE10 cost (discounted)' = 0,
                                    'Total AE cost (discounted)' = 0,
                                    'PFS utility (undiscounted)' = 0,
                                    'PD utility (undiscounted)' = 0,
                                    'Age utility (undiscounted)' = 0,
                                    'AE1 utility (undiscounted)' = 0,
                                    'AE2 utility (undiscounted)' = 0,
                                    'AE3 utility (undiscounted)' = 0,
                                    'AE4 utility (undiscounted)' = 0,
                                    'AE5 utility (undiscounted)' = 0,
                                    'AE6 utility (undiscounted)' = 0,
                                    'AE7 utility (undiscounted)' = 0,
                                    'AE8 utility (undiscounted)' = 0,
                                    'AE9 utility (undiscounted)' = 0,
                                    'AE10 utility (undiscounted)' = 0,
                                    'Total AE utility (undiscounted)' = 0,
                                    'PFS utility (discounted)' = 0,
                                    'PD utility (discounted)' = 0,
                                    'Age utility (discounted)' = 0,
                                    'AE1 utility (discounted)' = 0,
                                    'AE2 utility (discounted)' = 0,
                                    'AE3 utility (discounted)' = 0,
                                    'AE4 utility (discounted)' = 0,
                                    'AE5 utility (discounted)' = 0,
                                    'AE6 utility (discounted)' = 0,
                                    'AE7 utility (discounted)' = 0,
                                    'AE8 utility (discounted)' = 0,
                                    'AE9 utility (discounted)' = 0,
                                    'AE10 utility (discounted)' = 0,
                                    'Total AE utility (discounted)' = 0,
                                    'Life years' = 0,
                                    'Total QALY (undiscounted)' = 0,
                                    'Total QALY (discounted)' = 0) 
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