function [posterior,out]=VBA_refit_fixed(y, u, evo_fname, obs_fname, dim, options, muPhi, muTheta)
% This function refits a model at fixed values of phi and theta by setting
% the variances on the parameters, and on the hidden states, to zero.
% It is useful for obtaining trial-wise predictions for all subjects at
% fixed parameter values derived from the group posterior (usually mean parameter values).

    options.priors.muPhi = muPhi; %set priors to values passed into function
    options.priors.muTheta = muTheta;
    
    options.priors.SigmaPhi = zeros(length(muPhi));
    options.priors.SigmaTheta = zeros(length(muTheta));
    
    options.priors.SigmaX0 = zeros(dim.n);
    
    options.DisplayWin = 0;
    
    %options.isYout = zeros(length(y));
    [posterior,out] = VBA_NLStateSpaceModel(y,u, evo_fname, obs_fname, dim, options);

end