% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_graph.R
\name{render_graph}
\alias{render_graph}
\title{Render the graph in various formats}
\usage{
render_graph(graph, output = NULL, layout = NULL, title = NULL,
  width = NULL, height = NULL)
}
\arguments{
\item{graph}{a \code{dgr_graph} object, created
using the \code{create_graph} function.}

\item{output}{a string specifying the output type;
\code{graph} (the default) renders the graph using
the \code{grViz} function, \code{vivagraph}
renders the graph using the \code{vivagraph}
function, and \code{visNetwork} renders the graph
using the \code{visnetwork} function.}

\item{layout}{a string specifying a layout type for
a \code{vivagraph} rendering of the graph, either
\code{forceDirected} or \code{constant}.}

\item{title}{an optional title for a graph when
using \code{output = "graph"}.}

\item{width}{an optional parameter for specifying
the width of the resulting graphic in pixels.}

\item{height}{an optional parameter for specifying
the height of the resulting graphic in pixels.}
}
\description{
Using a \code{dgr_graph} object,
render the graph in the RStudio Viewer.
}
\examples{
\dontrun{
# Set a seed
set.seed(24)

# Create a node data frame (ndf)
nodes <-
  create_node_df(
    n = 26,
    type = "basic",
    shape = sample(c("circle", "square"),
                   length(1:26),
                   replace = TRUE),
    fillcolor = sample(c("aqua", "orange",
                         "pink", "lightgreen",
                         "black", "yellow"),
                       length(1:26),
                       replace = TRUE))

# Create an edge data frame (edf)
edges <-
  create_edge_df(
    from = sample(1:26, replace = TRUE),
    to = sample(1:26, replace = TRUE),
    rel = "to_node")

# Create a graph object using the ndf and edf, and,
# add a few attributes for the graph appearance
graph <-
  create_graph(
    nodes_df = nodes,
    edges_df = edges,
    graph_attrs = "layout = twopi",
    node_attrs = c("fontname = Helvetica",
                   "style = filled"),
    edge_attrs = c("color = gray20",
                   "arrowsize = 0.5"))

# Render the graph using Graphviz
render_graph(graph)

# Render the graph using VivaGraph
render_graph(graph, output = "vivagraph")

# Render the graph using visNetwork
render_graph(graph, output = "visNetwork")
}
}

