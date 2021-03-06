#' Add nodes from a node data frame to an existing
#' graph object
#' @description With a graph object of class
#' \code{dgr_graph} add nodes from a node data frame to
#' that graph.
#' @param graph a graph object of class
#' \code{dgr_graph} that is created using
#' \code{create_graph}.
#' @param node_df a node data frame that is created
#' using \code{create_node_df}.
#' @return a graph object of class \code{dgr_graph}.
#' @examples
#' # Create an empty graph
#' graph <- create_graph()
#'
#' # Create a node data frame
#' nodes <-
#'   create_node_df(
#'     n = 4,
#'     type = "basic",
#'     color = c("red", "green", "grey", "blue"),
#'     value = c(3.5, 2.6, 9.4, 2.7))
#'
#' # Add the node data frame to the graph object to
#' # create a graph with nodes
#' graph <- add_node_df(graph, nodes)
#'
#' get_node_df(graph)
#' #>   id  type label color value
#' #> 1  1 basic         red   3.5
#' #> 2  2 basic       green   2.6
#' #> 3  3 basic        grey   9.4
#' #> 4  4 basic        blue   2.7
#'
#' # Create another node data frame
#' nodes_2 <-
#'   create_node_df(
#'     n = 4,
#'     type = "basic",
#'     color = c("white", "brown", "aqua", "pink"),
#'     value = c(1.6, 6.4, 0.8, 4.2))
#'
#' # Add the second node data frame to the graph object
#' # to add more nodes with attributes to the graph
#' graph <- add_node_df(graph, nodes_2)
#'
#' get_node_df(graph)
#' #>   id  type label color value
#' #> 1  1 basic         red   3.5
#' #> 2  2 basic       green   2.6
#' #> 3  3 basic        grey   9.4
#' #> 4  4 basic        blue   2.7
#' #> 5  5 basic       white   1.6
#' #> 6  6 basic       brown   6.4
#' #> 7  7 basic        aqua   0.8
#' #> 8  8 basic        pink   4.2
#' @importFrom dplyr bind_rows
#' @export add_node_df

add_node_df <- function(graph,
                        node_df) {

  # Get the number of nodes ever created for
  # this graph
  nodes_created <- graph$last_node

  # If the `nodes_df` component of the graph is not
  # NULL, combine the incoming node data frame with the
  # existing node definitions in the graph object
  if (!is.null(graph$nodes_df)) {

    node_df[, 1] <-
      as.integer(nodes_created + seq(1:nrow(node_df)))

    node_df[, 2] <- as.character(node_df[, 2])
    node_df[, 3] <- as.character(node_df[, 3])

    graph$nodes_df <-
      dplyr::bind_rows(
        graph$nodes_df, node_df)

    # Update the `last_node` counter
    graph$last_node <-
      nodes_created + nrow(node_df)

    return(graph)
  }

  # If the `nodes_df` component of the graph is NULL,
  # insert the node data frame into the graph object
  if (is.null(graph$nodes_df)) {

    # Add the node data frame to the graph
    graph$nodes_df <- node_df

    # Update the `last_node` counter
    graph$last_node <- nrow(node_df)

    return(graph)
  }
}
