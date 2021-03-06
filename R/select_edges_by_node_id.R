#' Select edges in a graph using node ID values
#' @description Select edges in a graph object of class
#' \code{dgr_graph} using node ID values. All edges
#' associated with the provided nodes will be included
#' in the selection. If nodes have IDs that are
#' monotonically increasing integer values, then
#' numeric ranges can be provided for the selection.
#' @param graph a graph object of class
#' \code{dgr_graph} that is created using
#' \code{create_graph}.
#' @param nodes a vector of node IDs for the selection
#' of nodes present in the graph.
#' @param set_op the set operation to perform upon
#' consecutive selections of graph nodes. This can
#' either be as a \code{union} (the default), as an
#' intersection of selections with \code{intersect},
#' or, as a \code{difference} on the previous
#' selection, if it exists.
#' @return a graph object of class \code{dgr_graph}.
#' @examples
#' # Create a graph with a tree structure that's
#' # 3 levels deep (begins with node `1`, branching
#' # by 3 nodes at each level); the resulting graph
#' # contains 13 nodes, numbered `1` through `13`
#' graph <-
#'   create_graph(graph_attrs = 'layout = twopi') %>%
#'   add_node("a") %>%
#'   select_nodes %>%
#'   add_n_nodes_ws(3, "from", "b") %>%
#'   clear_selection %>%
#'   select_nodes("type", "b") %>%
#'   add_n_nodes_ws(3, "from", "c") %>%
#'   clear_selection
#'
#' # Create a graph selection by selecting edges
#' # associated with nodes `1` and `2`
#' graph <-
#'   graph %>%
#'   select_edges_by_node_id(1:2)
#'
#' # Get the selection of edges
#' graph %>% get_selection
#' #> "1 -> 2" "1 -> 3" "1 -> 4"
#'
#' # Perform another selection of nodes, with nodes
#' # `1`, `2`, and `4`
#' graph <-
#'   graph %>%
#'   clear_selection %>%
#'   select_edges_by_node_id(c(1, 2, 4))
#'
#' # Get the selection of edges
#' graph %>% get_selection
#' #> [1] "1 -> 2" "1 -> 3" "1 -> 4" "4 -> 5"
#' #> [5] "4 -> 6" "4 -> 7"
#'
#' # Get a fraction of the edges selected over all
#' # the edges in the graph
#' graph %>%
#' {
#'   l <- get_selection(.) %>%
#'     length(.)
#'   e <- edge_count(.)
#'   l/e
#' }
#' #> [1] 1
#' @export select_edges_by_node_id

select_edges_by_node_id <- function(graph,
                                    nodes,
                                    set_op = "union") {

  # Extract the edge data frame from the graph
  edge_df <- get_edge_df(graph)

  from <-
    edge_df[
      unique(c(which(edge_df$from %in% nodes),
               which(edge_df$to %in% nodes))),][,1]

  to <-
    edge_df[
      unique(c(which(edge_df$from %in% nodes),
               which(edge_df$to %in% nodes))),][,2]

  # Create selection of edges
  graph$selection$edges$from <- from
  graph$selection$edges$to <- to

  # Remove any selection of nodes
  graph$selection$nodes <- NULL

  return(graph)
}
