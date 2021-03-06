% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edge_present.R
\name{edge_present}
\alias{edge_present}
\title{Determine whether a specified edge is present in an
existing graph object}
\usage{
edge_present(graph, from, to)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph} that is created using
\code{create_graph}.}

\item{from}{a node ID from which the edge to be
queried is outgoing.}

\item{to}{a node ID to which the edge to be queried
is incoming.}
}
\value{
a logical value.
}
\description{
From a graph object of class
\code{dgr_graph}, determine whether a directed edge
(defined by a pair of node IDs extant in the graph)
is present.
}
\examples{
# Set a seed
set.seed(24)

# Create a node data frame (ndf)
nodes <-
  create_node_df(
    n = 26,
    label = TRUE,
    type = c(rep("a", 7),
             rep("b", 9),
             rep("c", 8),
             rep("d", 2)))

# Create an edge data frame (edf)
edges <-
  create_edge_df(
    from = sample(1:26, replace = TRUE),
    to = sample(1:26, replace = TRUE),
    rel = c(rep("rel_a", 7),
            rep("rel_b", 9),
            rep("rel_c", 8),
            rep("rel_d", 2)))

# Create a graph using the ndf and edf
graph <-
  create_graph(
    nodes_df = nodes,
    edges_df = edges)

# Is there any edge between nodes with IDs
# `1` and `2`?
edge_present(graph, from = 1, to = 2)
#> FALSE

# Verify that there is an edge between nodes
# `18` and `26`
edge_present(graph, from = 18, to = 26)
#> TRUE
}

