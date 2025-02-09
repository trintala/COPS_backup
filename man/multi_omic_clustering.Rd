% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multi_omics.R
\name{multi_omic_clustering}
\alias{multi_omic_clustering}
\title{Multi-omic clustering via multi-view clustering or integration}
\usage{
multi_omic_clustering(
  dat_list_clust,
  non_data_cols,
  multi_view_methods = "iClusterPlus",
  n_clusters = 2,
  distance_metric = "euclidean",
  correlation_method = "spearman",
  standardize_data = FALSE,
  non_negativity_transform = rep_len("none", length(dat_list_clust)),
  icp_view_types = rep_len("gaussian", length(dat_list_clust)),
  icp_bayes_burnin = 1000,
  icp_bayes_draw = 1200,
  nmf_maxiter = 200,
  nmf_st.count = 20,
  nmf_n.ini = 30,
  nmf_ini.nndsvd = TRUE,
  mofa_scale_views = FALSE,
  mofa_likelihoods = rep_len("gaussian", length(dat_list_clust)),
  mofa_convergence_mode = "medium",
  mofa_maxiter = 1000,
  mofa_environment = NULL,
  mofa_lib_path = NULL,
  anf_neighbors = 20,
  kernels = rep_len("linear", length(dat_list_clust)),
  kernels_center = TRUE,
  kernels_normalize = TRUE,
  kernels_scale_norm = FALSE,
  kernel_gammas = rep_len(0.5, length(dat_list_clust)),
  pathway_networks = NULL,
  pamogk_restart = 0.7,
  kkmeans_maxiter = 100,
  kkmeans_n_init = 100,
  mkkm_mr_lambda = 1,
  mkkm_mr_tolerance = 1e-08,
  mkkm_mr_initialization = TRUE,
  mkkm_mr_mosek = FALSE,
  ecmc_a = 1,
  ecmc_b = 1,
  ecmc_eps = 1e-06,
  ecmc_maxiter = 100,
  ecmc_solver = "MOSEK",
  ecmc_mkkm_mr = TRUE,
  data_is_kernels = FALSE,
  foldwise_zero_var_removal = TRUE,
  mvc_threads = 1,
  gene_id_list = NULL,
  ...
)
}
\arguments{
\item{dat_list_clust}{List of input \code{data.frame}s for input.}

\item{non_data_cols}{List of \code{data.frame}s that include meta data for 
each view. At the moment only the first element is used by appending to 
clustering output.}

\item{multi_view_methods}{Vector of algorithm names to be applied. See details.}

\item{n_clusters}{Integer vector of number of clusters to output.}

\item{distance_metric}{Distance metric for clustering factorized data 
(only for MOFA).}

\item{correlation_method}{Correlation method for \code{distance_metric}, 
if applicable.}

\item{standardize_data}{If set, standardizes data before clustering.}

\item{non_negativity_transform}{Vector of transformation names for IntNMF. 
See details below.}

\item{icp_view_types}{iCluster view types. 
See \code{\link[iClusterPlus]{iClusterPlus}} or 
\code{\link[iClusterPlus]{iClusterBayes}}.}

\item{icp_bayes_burnin}{iClusteBayes burn in. 
See \code{\link[iClusterPlus]{iClusterBayes}}}

\item{icp_bayes_draw}{iClusteBayes draw. See 
\code{\link[iClusterPlus]{iClusterBayes}}}

\item{nmf_maxiter}{Maxiter for IntNMF. See 
\code{\link[IntNMF]{nmf.mnnals}}.}

\item{nmf_st.count}{Count stability for IntNMF. 
See \code{\link[IntNMF]{nmf.mnnals}}.}

\item{nmf_n.ini}{Number of initializations for IntNMF. 
See \code{\link[IntNMF]{nmf.mnnals}}.}

\item{nmf_ini.nndsvd}{If set, IntNMF uses NNDSVD for initialization. 
See \code{\link[IntNMF]{nmf.mnnals}}.}

\item{mofa_scale_views}{MOFA scaling. 
See \code{\link[MOFA2]{get_default_data_options}}.}

\item{mofa_likelihoods}{MOFA likelihoods. 
See \code{\link[MOFA2]{get_default_model_options}}.}

\item{mofa_convergence_mode}{MOFA convergence threshold. 
See \code{\link[MOFA2]{get_default_training_options}}.}

\item{mofa_maxiter}{MOFA maximum iterations. 
See \code{\link[MOFA2]{get_default_training_options}}.}

\item{mofa_environment}{If set, uses the specified Python environment 
(with mofapy). Defaults to basilisk.}

\item{mofa_lib_path}{Path to libpython. May be required if using non-default 
\code{mofa_environment}.}

\item{anf_neighbors}{Number of neighbours to use in knn-graph.}

\item{kernels}{Character vector of kernel names to use for different views. 
See details.}

\item{kernels_center}{Logical vector specifying which kernels should be 
centered. Repeated for each view if length 1.}

\item{kernels_normalize}{Logical vector specifying which kernels should be 
normalized Repeated for each view if length 1.}

\item{kernels_scale_norm}{Logical vector specifying which kernels should be 
scaled to unit F-norm. Repeated for each view if length 1.}

\item{kernel_gammas}{Numeric vector specifying gamma for the gaussian kernel.}

\item{pathway_networks}{List of \code{igraph} objects containing pathway 
networks. Required for pathway kernels.}

\item{pamogk_restart}{Restart probability for PAMOGK RWR.}

\item{kkmeans_maxiter}{Maximum number of iterations for kernel k-means.}

\item{kkmeans_n_init}{Number of initializations for kernel k-means.}

\item{mkkm_mr_lambda}{Regularization parameter for \code{\link{mkkm_mr}}.}

\item{mkkm_mr_tolerance}{Convergence threshold for \code{\link{mkkm_mr}}.}

\item{mkkm_mr_initialization}{If set, uses \code{\link{mkkm_mr}} result to 
initialize kernel k-means, otherwise runs kernel k-means++ on combined kernel.}

\item{mkkm_mr_mosek}{If set, uses \code{Rmosek} for convex optimization 
instead of \code{CVXR} for \code{\link{mkkm_mr}}.}

\item{ecmc_a}{Regularization parameter for \code{\link{ECMC}}.}

\item{ecmc_b}{Regularization parameter for \code{\link{ECMC}}.}

\item{ecmc_eps}{Convergence threshold for \code{\link{ECMC}}.}

\item{ecmc_maxiter}{Maximum number of iterations for \code{\link{ECMC}}.}

\item{ecmc_solver}{SDP solver for \code{\link{ECMC}}. Set to either "MOSEK" 
or "CVXR".}

\item{ecmc_mkkm_mr}{If set, uses \code{\link{mkkm_mr}} on consensus kernels 
obtained from \code{\link{ECMC}}. Otherwise uses the average kernel and 
  kernel k-means.}

\item{data_is_kernels}{If set, input data is assumed to be kernel matrices. 
Otherwise kernels are computed based on input data based on the 
\code{kernels} parameter.}

\item{foldwise_zero_var_removal}{If set, removes all zero variance features 
from the data. It is called fold-wise, because this is assumed to be run 
inside CV.}

\item{mvc_threads}{Number of threads to use for supported operations.}

\item{gene_id_list}{List of gene/feature names for each view. If set, matches 
pipeline standardized feature names ("dim1", "dim2", ...) to names on the list. 
Required for pathway kernels.}

\item{...}{Arguments are passed to \code{\link{clustering_analysis}} when using MOFA.}
}
\value{

}
\description{
Multi-omic clustering via multi-view clustering or integration
}
\details{
Supported methods:
\itemize{
  \item "ANF" - Affinity Network Fusion \code{\link[ANF]{ANF}}
  \item "iClusterPlus" - \code{\link[iClusterPlus]{iClusterPlus}}.
  \item "iClusterBayes" -  code{\link[iClusterPlus]{iClusterBayes}}.
  \item "IntNMF" - Integrative Non-negative Matrix Factorization 
    \code{\link[IntNMF]{nmf.mnnals}}.
  \item "kkmeans" - kernel k-means initialized on spectral approximation, 
    uses average kernel.
  \item "kkmeanspp" - kernel k-means++ initialized randomly 
    \code{kkmeans_n_init} times, uses average kernel.
  \item "mkkm_mr" - Multiple Kernel K-Means with Matrix-induced Regularization 
    \code{\link{mkkm_mr}}.
  \item "ECMC" - Enhanced Consensus Multi-view Clustering \code{\link{ECMC}}.
  \item "MOFA2" - Multi-Omics Factor Analysis. 
    See \code{vignette("getting_started_R", "MOFA2")}. 
    Resulting factorization is clustered with single-view algorithms by using 
    \code{\link{clustering_analysis}}.
}

Supported kernels: 
\itemize{
  \item "linear" - Linear kernel based on standard dot product. 
  \item "gaussian", "rbf" - Gaussian kernel, a.k.a. radial basis function.
  \item "jaccard" - Kernel based on Jaccard index. Used for binary features. 
  \item "tanimoto" - For now, this is identical to "jaccard".
  \item "BWK" - Betweenness Weighted Kernel. Uses pathway networks to compute 
    betweenness centrality which is used to weight features in a linear 
    pathway kernels. 
  \item "PAMOGK" - PAthway Multi-Omics Graph Kernel (Tepeli et al. 2021). 
    Uses z-scores, RWR and shortest paths in pathway networks to create 
    pathway kernels. 
  \item "PIK" - Pathway Induced Kernel (Manica et al. 2019). Uses pathway network adjacency matrices (specifically normalized Laplacians) to define pathway kernels. 
}
Please note that for pathway kernels, the input data must always be mapped to 
genes and that the names must match with the gene names in the pathways. 
The default set of pathways is KEGG molecular pathways with gene symbols. 

NMF non-negativity transform may be necessary if non-negativity was not 
considered while pre-processing the data. There are a few convenience 
functions included to transform the data as needed: 
\itemize{
  \item "logistic" - \code{1/(1 + exp(-x))}, maps input from (-Inf,Inf) to [0,1]. 
    Used for e.g. microarray data or methylation M-values. 
  \item "rank" - ranks values and divides by length, maps input from 
    (-Inf,Inf) to [0,1].
  \item "offset2" - adds 2 to input. Useful for e.g. copy number alterations 
    (assuming no alterations lower than -2). 
}
}
