function makeSymLink(target, source, relative)
% Create a symlink.
%
% npxutils.internal.makeSymlink(target, source, relative)
%
% Create a symlink. Clobbers any existing symlink at source.
%
% Target (charvec) is the path the created symlink should point to.
%
% Source (charvec) is the path where the symlink should be created on the
% filesystem.
%
% Relative (boolean, false*) indicates whether to use a relative path in
% the newly created symlink definition.
%
% If target itself is a symlink, that symlink is read, and the newly
% created symlink points to target's target instead of target itself.
% Any nonexistent parent directories of source are created automatically.
%
% Raises an error on failure.

arguments
    target
    source
    relative (1,1) logical = false
end

finalTarget = resolveSymLink(npxutils.internal.GetFullPath(target));
if ~exist(finalTarget, 'file')
    % TODO: The wording of this message is bogus; it assumes that target
    % itself is a symlink, which may not be the case. Add an islink() call
    % here.
    error(['makeSymLink: target is itself a dangling symlink; creating a symlink to it ' ...
        'would be bogus; not creating.\n  Source: %s\n  Target:  %s\n' ...
        'Target''s target: %s'], ...
        source, target, finalTarget);
end

source = npxutils.internal.GetFullPath(source);
npxutils.internal.mkdirRecursive(fileparts(source));
% Can't use exist() on symlinks since it tests for existence of the file it points to
% TODO: Can we replace this with an isfile() call, or a call down to Java?
sWarn = warning('off', 'MATLAB:DELETE:FileNotFound');
try
    delete(source);
catch
end
warning(sWarn);

if relative
    target = npxutils.internal.relativepath(target, fileparts(source));
end

if ispc
    cmd = sprintf('mklink "%s" "%s"', source, target);
else
    cmd = sprintf('ln -s "%s" "%s"', target, source);
end
[status, output] = system(cmd);

if status ~= 0
    error('Failed creating symlink from "%s" to "%s": status=%d; output: %s', ...
        source, target, status, output);
end

end

function target = resolveSymLink(file)

if ispc
    % This is incorrect behavior, but I don't know how to resolve symlinks
    % on Windows.
    target = file;
else
    target = readLink(file);
end

return;

% BUG: This code cannot be reached, and is probably not necessary, because
% the "-m" option to readlink takes care of this, doesn't it?

if ~exist(file, 'file')
    % try recursively on its parent
    [parent leaf ext] = fileparts(file);
    parent = resolveSymLink(parent);
    target = fullfile(parent, [leaf ext]);
else
    target = readLink(file);
end

end

function result = readLink(file)
cmd = sprintf('readlink -m "%s"', npxutils.internal.GetFullPath(file));
[status, result] = system(cmd);
if status || isempty(result)
    fprintf(result);
    error('Error resolving sym link');
end

if result(end) == newline
    result(end) = [];
end
end