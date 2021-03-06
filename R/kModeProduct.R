#' kModeProduct

#'@export
#'@param tnsr simple_sparse_array 
#'@param mat simple_sparse_array or simple_triplet_matrix or matrix. nrow(mat) should be equal to dim(tnsr)[m] 
#'@param m mode 
#'@return product. simple_sparse_array.

kModeProduct <- function(tnsr,mat,m){
	
	stopifnot(dim(tnsr)[m]==ncol(mat))
	tnsr.mat <- kModeUnfold(tnsr,m)
	tnsr.mat <- as.simple_triplet_matrix(tnsr.mat)
	if(class(mat)!='simple_triplet_matrix') mat <- as.simple_triplet_matrix(mat)
	res.mat <- as.simple_sparse_array(crossprod_simple_triplet_matrix(t(mat),tnsr.mat))
	res.tnsr.dim <- dim(tnsr)
	res.tnsr.dim[m] <- nrow(mat)

	#         tnsr.mat <- as.simple_sparse_array(tnsr.mat)
	#         browser()
	res <- Refold(res.mat,res.tnsr.dim,m)
	return(res)
}
