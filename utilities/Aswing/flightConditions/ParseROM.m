%   Copyright (C) 2018-present, Facebook, Inc.
% 
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; version 2 of the License.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with this program; if not, write to the Free Software Foundation, Inc.,
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%
%   Developer:  Abe Martin
function sys = ParseROM (NumInputs, NumOutputs, case_name, eas)

% Construct A matrix
fid = fopen(strcat(case_name,'.e00'));
R = textscan(fid,'%f %f %f','HeaderLines',3,'Delimiter','\t');
eigs = conj_sort(R{2},R{3},'row');
A = diag(eigs);
[~, idx] = unique(diag(A));
A = A(idx,idx);

save(strcat('./data/EAS',num2str(eas),'_aswingEigs.mat'),'eigs');

% Construct B,C,D matrices 
NumModes = length(unique(real(eigs)));
fid = fopen(strcat(case_name,'.rom'));
B=[];
C=[];
D = [];
for j = 1:NumModes
R = textscan(fid,'%f %f %s',NumInputs,'CommentStyle','#','Delimiter','\t');
B = [B;conj_sort(R{1},R{2},'col').'];
R = textscan(fid,'%f %f %s',NumOutputs,'CommentStyle','#','Delimiter','\t');
C = [C,conj_sort(R{1},R{2},'col')];
end
B = B(idx, :);
C = C(:, idx);
for j = 1:NumInputs
R = textscan(fid,'%f %f %s',NumOutputs,'CommentStyle','#','Delimiter','\t');
D = [D,[R{1}+R{2}*i]];
end

% [~,bad] = max(real(eigs))

% % Remove pole manually
% A(1,:) = [];
% A(:,1) = [];
% B(1,:) = [];
% C(:,1) = [];

% Construct state-space object
sys_red = ss(A,B,C,D);
% sys_red = modred(sys_orig,1,'Truncate');
% sys_red2 = modred(sys_orig,2,'Truncate');
sys = LTI_Complex2Real(sys_red);
end

function vec = conj_sort(x,y,method)
%x: real part
%y: imaginary part 
len = length(x);
switch method
    case 'row' 
    vec = zeros(len*2,1);
    vec(1:2:end) = complex(x,y);
    vec(2:2:end) = conj(complex(x,y));
    
    case 'col'
    vec = zeros(len,2);    
    vec(:,1) = complex(x,y);
    vec(:,2) = conj(complex(x,y));  
end
end