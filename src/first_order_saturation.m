function [Abound, Afree] = first_order_saturation(MTtot, Atot, KAM, N)
% A function which calculates the biding of A to MT assuming first order
% binding where the total concentrations of A and MT are Atot and Btot and
% the disassociation constant is KAM for an expeiment where [A] is varied
% and [MT] is held constant.

% This file is part of MTBindingSim.
%
% Copyright (C) 2010-2013  University of Notre Dame
%
% MTBindingSim is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% MTBindingSim is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with MTBindingSim.  If not, see <http://www.gnu.org/licenses/>.

% Author:
%   Julia Philip <jphilip@nd.edu>
%
% Version history:
% - 0.5: Initial version


% Gets the size of Atot and creates an empty vector of the same size for
% Afree
[a, b] = size(Atot);
Afree = zeros(a,b);


% Steps through Atot, calculating Afree at each value
for n = 1:b
    
    % Sets the x interval for fzero
    Xint = [0,Atot(n)];
    
    % Sets us the function to calculate Afree and calculates Afree
    f = @(A)A + (1/KAM)*A*MTtot/(1 + (1/(KAM*N))*A)- Atot(n);
    [Afree(n), y, exit] = fzero(f,Xint);
    
    % Checks to make sure that fzero has successfully calculated Afree and
    % exits calculation if it has not
    if exit ~= 1 || isnan(Afree(n))
        Abound = 0;
        Afree = 0;
        return
    end
    
end

% Calculates Abound
Abound = Atot - Afree;


end
