get_PFS <- function(surv_data, time, T_unit){
  # Gets PFS from the survival data
  if (T_unit == 'weeks'){
    PFS <- surv_data$S[PFS$time_weeks == time]
    
  } else if (T_unit == 'months'){
    PFS <- surv_data$S[PFS$time_months == time]
    
  } else if (T_unit == 'years'){
    PFS <- surv_data$S[PFS$time_years == time]
    
  } else{
    simpleError('Invalid time unit chosen')
  }
  
  return(PFS)
}