function [covmat_trans] = transform_covmat(covmat, sds_trans)
%helper function to a transform a covariance matrix in VBA's Gaussian distributed parameter values
%to a covariance matrix in the units of the transformed parameters actually used by the model.
%
%this basically converts the original (VBA-internal) covmat to a correlation matrix (standardization),
%then multiplies the correlation matrix by the transformed SDs of the parameters involved in each cell.
%
%sds_trans must be a column vector

if isempty(covmat) %if there is no covariance matrix to speak of (e.g., if phi or theta are empty), just return an empty
    covmat_trans=[];
    return;
end

if size(sds_trans,2) ~= 1
    error('in transform_covmat, sds_trans must be a column vector');
end

corrmat=VBA_cov2corr(covmat); %standardize matrix
covmat_trans = corrmat .* (sds_trans*sds_trans'); %cf corr2cov in MATLAB finance package

end
