#' Get node eccentricities
#' @description Get a named vector or data frame with
#' node eccentricity values.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @param nodes an optional vector of node IDs for
#' filtering the list of nodes present in the graph.
#' @param return_type using \code{vector} (the default)
#' will provide a named vector of eccentricity values
#' (the node IDs serve as names). With \code{df},
#' a data frame containing node IDs and eccentricity
#' values is provided.
#' @return a either a named vector or a data frame
#' containing eccentricity values by node, depending
#' on the value supplied to \code{return_type}.
#' @examples
#' # Get the eccentricities for all nodes in
#' # a randomly-created graph
#' get_eccentricity(
#'   graph = create_random_graph(
#'             15, 20, set_seed = 20))
#' #>  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
#' #>  4  7  1  6  0  0  6  6  0  5  1  1  7  6  8
#' @export get_eccentricity

get_eccentricity <- function(graph,
                             nodes = NULL,
                             return_type = "vector") {

  if (is.null(nodes)) {
    nodes_to_process <- get_node_ids(graph)
    node_ids <- nodes_to_process
  }

  if (!is.null(nodes)) {

    # Stop function if nodes provided are not all
    # in the graph
    if (any(!(as.character(nodes) %in% get_node_ids(graph)))) {
      stop('Not all nodes specified are present in the graph.')
    }

    nodes_to_process <- nodes
    node_ids <- nodes_to_process
  }

  for (i in 1:length(nodes_to_process)) {

    if (i == 1) {
      eccentricity <- vector(mode = 'integer')
    }

    longest_path <-
      max(
        lengths(
          get_paths(
            graph,
            from = get_node_ids(graph)[i],
            longest_path = TRUE))) - 1

    eccentricity <-
      c(eccentricity, longest_path)

    if (i == length(nodes_to_process)) {
      names(eccentricity) <- node_ids
    }
  }

  if (return_type == 'vector') {
    return(eccentricity)
  }

  if (return_type == 'df') {

    # Create a data frame with node ID values
    # and eccentrity values
    eccentricity <-
      data.frame(id = names(eccentricity),
                 eccentricity = eccentricity,
                 stringsAsFactors = FALSE)

    return(eccentricity)
  }
}
