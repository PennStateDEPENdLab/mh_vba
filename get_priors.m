function [priors] = get_priors(dim, vo)

if isfield(vo, 'priors')
    priors = vo.priors; %copy across prior setup from vo
else
    priors=[];
end

% multisession = vo.multisession;
% fixed = vo.fixed;

%gamma math:
% mean = alpha / beta
% variance = alpha / beta^2

% precision on state and measurement noise
% default to deterministic (ODE) system with Jeffrey's prior on measurement noise

if ~isfield(priors, 'a_alpha'), priors.a_alpha = Inf; end % infinite precision prior on state noise
if ~isfield(priors, 'b_alpha'), priors.b_alpha = 0; end

if ~isfield(priors, 'a_sigma'), priors.a_sigma = 1; end  % Jeffrey's prior on measurement noise
if ~isfield(priors, 'b_sigma'), priors.b_sigma = 1; end  % Jeffrey's prior

%default to zero priors on hidden states if not specified upstream in vo
if ~isfield(priors, 'muX0')
    priors.muX0 = zeros(dim.n,1);
end

%default to zero variance and covariance on hidden states if not specified upstream in vo (i.e., default to no uncertainty)
if ~isfield(priors, 'SigmaX0')
    priors.SigmaX0 = zeros(dim.n);
end

% TODO: not currently returning the options structure
% if multisession
%     options.multisession.split = repmat(vo.n_t/vo.n_trustees,1,vo.n_trustees); %splitting the sessions
%     % fix parameters
%     if fixed == 1
%         options.multisession.fixed.theta = 'all';
%         options.multisession.fixed.phi = 1:2;   %fixing the beta and kappa (subject-specific bias) parameters to be the same across all sessions
%         priors.SigmaX0 = diag([.3 0]);  %X0 is allowed to vary between sessions
%     elseif fixed == 2
%         options.multisession.fixed.theta = 'all';
%         options.multisession.fixed.phi = 1;    %fixing the beta parameter to be the same across sessions; subject-wise kappa varies between sessions
%         options.multisession.fixed.X0 = 'all';
%         priors.SigmaX0 = diag([0 0]);   %infinite precision priors set on the initial value and PEs
%     elseif fixed == 3
%         options.multisession.fixed.theta = 'all';
%         options.multisession.fixed.phi = 1:2;   %fixing the beta and kappa (subject-specific bias) parameters to be the same across all sessions
%         options.multisession.fixed.X0 = 'all';
%         priors.SigmaX0 = diag([0 0]);   %infinite precision priors set on the initial value and PEs
%     end
% end


end
