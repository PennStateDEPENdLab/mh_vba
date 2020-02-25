function [phi_trans] = transform_phi(phi, inG, is_varcov)
% This function applies the desired transformations to parameters in phi (observation).
% If is_varcov is true, or if phi is a matrix, assume we are transforming SigmaPhi,
% in which case we need to use the SDs (sqrt of the diagonal) to transform the matrix

%need an argument for varcov because input could be a scalar if there is only one phi parameter
if nargin < 3, is_varcov=0; end %assume a parameter, not a covmat

if is_varcov || (ismatrix(phi) && ~isvector(phi))
    asymm_check = abs(phi - phi') > 1e-5; %if ~issymmetric(phi) %this objects to tiny floating point imprecision??
    if any(asymm_check), error('Non-symmetric matrix passed to transform_phi'); end
    
    vars = diag(phi); %make sure this is a column vector
    sds_trans = m_transform_phi(sqrt(vars), inG); %model-specific parameter transformation
    phi_trans = transform_covmat(phi, sds_trans);
    
else
    phi_trans = m_transform_phi(phi, inG); %model-specific parameter transformation
    
end

end
