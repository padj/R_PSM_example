############################################################################## #
# Project:    R_PSM_example
# Detail:     A partitioned survival model (PSM) in R
#
# Name:       main.R
# Date:       2023-01-01
# Author:     Thomas Padgett
#
############################################################################## #

# 0. Preamble ####

# Package management
renv::restore()

library(readxl)

# File management
data.loc <- 'data/'
func.loc <- 'functions/'
BCout.loc <- 'outputs/BC_outputs/'
DSAout.loc <- 'outputs/DSA_outputs/'
PSAout.loc <- 'outputs/PSA_outputs/'
script.loc <- 'scripts/'

# Source functions
source(paste0(func.loc, 'source_all.R'))
source_all(func.loc)

# Define variables
model_controls <- read_excel(path = paste0(data.loc, 'data.xlsx'), 
                             sheet = 'model_controls')

# 1. Construct the data library ####
# Read in data
data_library <- list()
data_library$demo <- read_excel(path = paste0(data.loc, 'data.xlsx'), 
                                sheet = 'demo')
data_library$costs <- read_excel(path = paste0(data.loc, 'data.xlsx'), 
                                 sheet = 'costs')
data_library$ae <- read_excel(path = paste0(data.loc, 'data.xlsx'), 
                              sheet = 'ae')
data_library$utils <- read_excel(path = paste0(data.loc, 'data.xlsx'),
                                 sheet = 'utils')

# Read in life tables
data_library$life_table <- read_excel(path = paste0(data.loc, 'life_table.xlsx'))

# Read in utility tables
data_library$util_table <- read_excel(path = paste0(data.loc, 'util_table.xlsx'))

# Read in survival data
data_library$trt_PFS <- read_excel(path = paste0(data.loc, 'trt_PFS.xlsx'))
data_library$trt_OS <- read_excel(path = paste0(data.loc, 'trt_OS.xlsx'))
data_library$ctrl_PFS <- read_excel(path = paste0(data.loc, 'ctrl_PFS.xlsx'))
data_library$ctrl_OS <- read_excel(path = paste0(data.loc, 'ctrl_OS.xlsx'))


# 2. Base case ####

# Call run_PSM(abridged=FALSE)
#   input data_library
#   creates empty traces (trt + ctrl)
#   populates each trace row by row
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

# Write out results


# 3. DSA ####

# Call run_DSA(verbose=FALSE)
#   input data_library
#   internally calls run_PSM()
#   Returns:
#     DSA_results_table
#     DSA_tornado_plot
#   verbose=TRUE additionally returns:
#     DSA_trt_trace_array
#     DSA_ctrl_trace_array

# Write out results


# 4. PSA ####

# Call run_PSA(verbose=FALSE)
#   input data_library
#   create PSA_data_library by randomly drawing values
#   internally calls run_PSM() using PSA_data_library
#   Returns:
#     PSA_results_table
#     PSA_CE_plane
#     PSA_convergence_plot

# Write out results





