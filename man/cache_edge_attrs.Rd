% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cache_edge_attrs.R
\name{cache_edge_attrs}
\alias{cache_edge_attrs}
\title{Cache edge attributes in the graph}
\usage{
cache_edge_attrs(graph, edge_attr, mode = NULL, from = NULL, to = NULL)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{edge_attr}{the edge attribute from which to
obtain values.}

\item{mode}{a option to recast the returned vector
of edge attribute value as \code{numeric} or
\code{character}.}

\item{from}{an optional vector of node IDs from
which the edge is outgoing for filtering the list of
edges present in the graph.}

\item{to}{an optional vector of node IDs to which
the edge is incoming for filtering the list of
edges present in the graph.}
}
\value{
a graph object of class \code{dgr_graph}.
}
\description{
From a graph object of class
\code{dgr_graph}, get edge attribute properties for
one or more edges and cache those values in the
graph for later retrieval using \code{get_cache}.
}
