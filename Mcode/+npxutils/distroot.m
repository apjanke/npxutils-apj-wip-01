function out = distroot
% The path to the root directory of this distribution of Neuropixel Utils
%
% This is the path to the installation directory that this instance of the
% Neuropixel Utils library is running from.
%
% Returns a scalar string.

persistent val
if isempty(val)
    val = string(fileparts(fileparts(fileparts(mfilename('fullpath')))));
end

out = val;

end