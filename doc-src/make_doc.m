function make_doc
% Build these doc sources into the final doc/ directory
%
% make_doc
% make_doc --preview
% make_doc --build-only
%
% This will require special configuration on Windows to get it working.
%
% Requires mkdocs to be installed. See https://www.mkdocs.org/.

action = "install";
args = string(varargin);
if ismember("--preview", args)
  action = "preview";
elseif ismember("--build-only", args)
  action = "build";
end

%#ok<*STRNU>

RAII.cd = withcd(fileparts(mfilename('fullpath')));

if action == "preview"
  % Use plain system() and quash because we expect this to error out when user Ctrl-C's it
  system('mkdocs serve');
else
  system2('mkdocs build');
  if action == "install"
    rmdir2('../docs', 's');
    copyfile2('_site/*.*', '../docs');
  end
end

end

function out = withcd(dir)
% Temporarily change to a new directory
origDir = pwd;
cd(dir);
out = onCleanup(@() cd(origDir));
end
