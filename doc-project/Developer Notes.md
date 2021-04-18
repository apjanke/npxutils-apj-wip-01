# Neuropixel Utils Developer Notes

## Repo layout

* `Mcode/` – Matlab source code for the Neuropixel Utils library itself
* `doc-project/` – developer-oriented doco for people working on the library itself
* `doc-src/` – Source for user-facing doco
* `docs/` – Built user-facing doco and GitHub Pages site
  * This is generated from `doc-src/`. Don't edit it directly here!
* `dev-kit/` – Developer tools for working on the library
* `examples/` – Example code to go with the library, and for building into the `docs/` stuff

## Working with the repo

When working on Neuropixel Utils as a developer, you'll want both the NeuroPixel Utils library and its dev kit loaded on to your path. Run this to load it up:

```matlab
% Edit this to reflect where you put your copy of the repo
npxutilsRepoPath = '~/local/repos/neuropixel-utils';

addpath(fullfile(npxutilsRepoPath, 'dev-kit'))
load_npxutils
```

It can be handy to stick that code in a Favorite in your Matlab. Select Home > Favorites > New Favorite from the toolstrip.

## Building the project

### Building the web site

The project web site is a GitHub Pages site, but it uses MkDocs instead of the default Jekyll as its static site generator.

To build the site with MkDocs:

First, get MkDocs installed. With Homebrew:

```bash
brew install mkdocs
```

Or generically, with Anaconda Python:

```bash
conda create --name mkdocs pip
conda activate mkdocs
pip install mkdocs mkdocs-material
```

Then, to build the docs using MkDocs:

```bash
mkdocs serve # test local
mkdocs gh-deploy # deploy to master
```

### Building the distribution

With the dev-kit loaded as described above, run this in Matlab to build the library as a Matlab Toolbox `.mltbx` file:

```matlab
npxutils_make toolbox
```

And run this to build the distribution zip files:

```matlab
npxutils_make dist
```

This will produce the distribution Matlab Toolbox .mltbx file.

## Style Guide

### Prose Style

* "Matlab", not "MATLAB"
  * Yes, we know "MATLAB" is the official styling; we just don't like it.
* Oxford commas

### Code Style

* 4-space indents
* Auto-format everything using the Matlab Editor
* Naming
  * `camelCase` variable and function names
  * `TitleCase` class names
