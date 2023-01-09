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


# File management


# Source functions


# Define variables


# 1. Construct the data library ####

# Read in data
# Construct as table/matrix
# Add DSA elements (i.e. col to inc in DSA 1/0)
# Add in PSA elements (se, dist)

# Write out initial_data.csv


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





