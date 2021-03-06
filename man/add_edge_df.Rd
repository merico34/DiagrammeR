% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_edge_df.R
\name{add_edge_df}
\alias{add_edge_df}
\title{Add edges from an edge data frame to an existing
graph object}
\usage{
add_edge_df(graph, edge_df)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph} that is created using
\code{create_graph}.}

\item{edge_df}{an edge data frame that is created
using \code{create_edges}.}
}
\value{
a graph object of class \code{dgr_graph}.
}
\description{
With a graph object of class
\code{dgr_graph} add edges from an edge data frame
to that graph.
}
\examples{
# Create a graph with nodes and no edges
nodes <-
  create_node_df(
    n = 4,
    type = "letter",
    color = c("red", "green", "grey", "blue"),
    value = c(3.5, 2.6, 9.4, 2.7))

graph <- create_graph(nodes_df = nodes)

# Create an edge data frame
edges <-
  create_edge_df(
    from = c(1, 2, 3),
    to = c(4, 3, 1),
    rel = "leading_to")

# Add the edge data frame to the graph object to create a
# graph with both nodes and edges
graph <-
  add_edge_df(
    graph = graph,
    edge_df = edges)

get_edges(graph, return_type = "vector")
#> [1] "1 -> 4" "2 -> 3" "3 -> 1"
}

