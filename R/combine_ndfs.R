#' Combine multiple node data frames
#' @description Combine several node data frames
#' into a single node data frame.
#' @param ... two or more node data frames, which
#' contain node IDs and associated attributes.
#' @return a combined node data frame.
#' @importFrom dplyr bind_rows
#' @export combine_ndfs

combine_ndfs <- function(...) {

  ndfs <- list(...)

  for (l in 1:length(ndfs)) {
    if (l == 1) {
      df1 <- ndfs[l][[1]]
      df2 <- ndfs[l + 1][[1]]
    }

    if (l > 1 & l < length(ndfs)) {
      df1 <- ndf_new
      df2 <- ndfs[l + 1][[1]]
    }

    # Bind rows from df1 and df2
    ndf_new <- dplyr::bind_rows(df1, df2)

    if (l == length(ndfs)) {
      break
    }
  }

  # Create montonically-increasing integer id
  # values for new table based on input order
  ndf_new[, 1] <- as.integer(1:nrow(ndf_new))

  return(ndf_new)
}
