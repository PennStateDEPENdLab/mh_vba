function [theta_trans] = transform_theta(theta, inF, is_varcov)
% This function applies the desired transformations to parameters in theta (evolution).
% If is_varcov is true, or if phi is a matrix, assume we are transforming SigmaTheta,
% in which case we need to use the SDs (sqrt of the diagonal) to transform the matrix

%need an argument for varcov because input could be a scalar if there is only one theta parameter
if nargin < 3, is_varcov=0; end %assume a parameter, not a covmat

if is_varcov || (ismatrix(theta) && ~isvector(theta))
    asymm_check = abs(theta - theta') > 1e-5; %if ~issymmetric(theta) %this objects to tiny floating point imprecision??
    if any(asymm_check), error('Non-symmetric matrix passed to transform_theta'); end
    
    vars = diag(theta)'; %make sure this is a row vector
    sds_trans = m_transform_theta(sqrt(vars)); %model-specific parameter transformation
    theta_trans = transform_covmat(theta, sds_trans);
    
else
    theta_trans = m_transform_theta(theta); %model-specific parameter transformation
end

end