function load_npxutils
% Load the npxutils library

repoDir = npxutils_repo_root;
mcodeDir = [repoDir '/Mcode'];
addpath(mcodeDir);

fprintf('Loaded Neuropixel Utils from %s (with dev-kit)\n', repoDir);