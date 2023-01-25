get_OS <- function(surv_data, time, T_unit){
  # Gets OS from the survival data
  if (T_unit == 'weeks'){
    OS <- surv_data$S[PFS$time_weeks == time]
    
  } else if (T_unit == 'months'){
    OS <- surv_data$S[PFS$time_months == time]
    
  } else if (T_unit == 'years'){
    OS <- surv_data$S[PFS$time_years == time]
    
  } else{
    simpleError('Invalid time unit chosen')
  }
  
  return(OS)
}