%
% Copyright (c) The acados authors.
%
% This file is part of acados.
%
% The 2-Clause BSD License
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.;

%

function simulink_opts = get_acados_simulink_opts_mocp()
    acados_folder = getenv('ACADOS_INSTALL_DIR');
    addpath(fullfile(acados_folder, 'external', 'jsonlab'))
    simulink_opts_default_filename = fullfile(acados_folder, 'interfaces',...
                            'acados_template','acados_template','simulink_default_opts.json');
    simulink_opts = loadjson(fileread(simulink_opts_default_filename));

    % turn off non supported options
    nonsupported_mocp_inputs = {'y_ref', 'lbx', 'ubx', ...
    'lbx_e', 'ubx_e', 'lg', 'ug', 'lh', 'uh', 'cost_W_0', 'cost_W', 'cost_W_e'};

    for i=1:length(nonsupported_mocp_inputs)
        simulink_opts.inputs.(nonsupported_mocp_inputs{i}) = 0;
    end

    % turn off by default, although they are supported
    default_off_mocp_opts = {'lbx_e', 'ubx_e', 'y_ref_0', 'y_ref_e'};
    for i=1:length(default_off_mocp_opts)
        simulink_opts.inputs.(default_off_mocp_opts{i}) = 0;
    end
end
