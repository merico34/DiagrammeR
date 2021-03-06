#' Add a star of nodes to the graph
#' @description With a graph object of class
#' \code{dgr_graph}, add a node star to the graph.
#' @param graph a graph object of class
#' \code{dgr_graph} that is created using
#' \code{create_graph}.
#' @param n the number of nodes comprising the star.
#' The first node will be the center of the star.
#' @param type an optional string that describes the
#' entity type for the nodes to be added.
#' @param label either a vector object of length
#' \code{n} that provides optional labels for the new
#' nodes, or, a boolean value where setting to
#' \code{TRUE} ascribes node IDs to the label and
#' \code{FALSE} yields a blank label.
#' @param rel an optional string for providing a
#' relationship label to all new edges created in the
#' node star.
#' @return a graph object of class \code{dgr_graph}.
#' @examples
#' # Create a new graph and add 2 stars of varying
#' # numbers of nodes
#' graph <-
#'   create_graph() %>%
#'   add_star(4, "four_star") %>%
#'   add_star(5, "five_star")
#'
#' # Get node information from this graph
#' node_info(graph)
#' #>   node label      type deg indeg outdeg loops
#' #> 1    1     1 four_star   3     0      3     0
#' #> 2    2     2 four_star   1     1      0     0
#' #> 3    3     3 four_star   1     1      0     0
#' #> 4    4     4 four_star   1     1      0     0
#' #> 5    5     5 five_star   4     0      4     0
#' #> 6    6     6 five_star   1     1      0     0
#' #> 7    7     7 five_star   1     1      0     0
#' #> 8    8     8 five_star   1     1      0     0
#' #> 9    9     9 five_star   1     1      0     0
#' @export add_star

add_star <- function(graph,
                     n,
                     type = NULL,
                     label = TRUE,
                     rel = NULL) {

  # Stop if n is too small
  if (n <= 3) {
    stop("The value for n must be at least 4.")
  }

  # Get the number of nodes ever created for
  # this graph
  nodes_created <- graph$last_node

  # Get the sequence of nodes required
  nodes <- seq(1, n)

  # Create a node data frame for the star graph
  star_nodes <-
    create_nodes(
      nodes = nodes,
      type = type,
      label = label)

  # Create an edge data frame for the star graph
  star_edges <-
    create_edges(
      from = rep(nodes[1], n - 1),
      to = nodes[2:length(nodes)],
      rel = rel)

  # Create the star graph
  star_graph <- create_graph(star_nodes, star_edges)

  # If the input graph is not empty, combine graphs
  # using the `combine_graphs()` function
  if (!is_graph_empty(graph)) {

    graph <- combine_graphs(graph, star_graph)

    # Update the `last_node` counter
    graph$last_node <- nodes_created + nrow(star_nodes)

    return(graph)
  } else {
    return(star_graph)
  }
}
