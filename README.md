ScashX Introduction
===================

(For Bitcoin Core see [README_BTC.md](https://github.com/scashx/scashx/blob/scashx_master/README_BTC.md) in this directory or [bitcoincore.org](https://bitcoincore.org)).

## ScashX: Bitcoin Fork for Accessible Home Mining

**ScashX (Satoshi Cash-X)** is a cryptocurrency project forked from Bitcoin Core v28.1. Its primary innovation is the introduction of a new chain option designed to make cryptocurrency mining viable and efficient on standard home computer hardware.

## Technical Foundation

ScashX is built upon the robust and secure foundation of Bitcoin Core v28.1, inheriting its core features and fundamental consensus rules. The key distinction lies in ScashX's modified protocol, which facilitates a more accessible mining experience, enabling individuals to participate effectively without requiring specialized, high-power mining equipment.

For detailed information on the specific technical modifications the new chain option, and protocol details, please refer to the [ScashX Protocol Specification](https://github.com/scashx/scashx/blob/scashx_master/doc/scashx-protocol-spec.md).

## Availability and Buiilding

### Binary Releases (Recommended for most users)

Pre-compiled binaries are the quickest way to set up and run ScashX. Single click install available for Windows.

**Download:** https://github.com/scashx/scashx/releases

* **Supported Platforms for Binaries:**
  * **Windows** (GUI application 'scashx-qt', single click install).
  * **Windows WSL** (The Linux binaries can also be run on [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/about)).
  * **Linux** (daemon 'scashxd')
* **Currently Unsupported**
  * **maxOS+**

### Building from Source
If you prefer to compile ScashX yourself the build process is similar to that of Bitcoin Core and takes approximately 5-15 minutes depending on your system performance. Quick install instructions are in the [build doc]([doc/build-scashx.md](https://github.com/scashx/scashx/blob/scashx_master/doc/build-scashx.md))). More detailed, step-by-step guidance can be found in [build-unix.md](https://github.com/scashx/scashx/blob/scashx_master/doc/build-unix.md) but there should be no need to refer to this for the default install on Linux (Ubuntu).

* **Supported Platforms for Building:**
  * **Linux:** (Ubuntu is recommended, although other Unix-like distributions may also work).
  * **WSL on Windows:** Users can build the Linux version from source by running an Ubuntu environment within WSL and following the Linux build instructions (below).

### Platform-Specific Information

* **Windows:**
  * `scashx-qt`: The graphical user interface (GUI) wallet and node. This is typically cross-compiled on Linux for Windows.
* **Linux / WSL:**
  * `scashxd`: The command-line daemon for running a node.
  * `scashx-cli`: The command-line client for the node.

## Further Information
For the latest updates, new features, bug fixes, and detailed changes in each version, please consult the [ScashX Release Notes](release-notes/scashx/).




For an immediately usable, binary version of the Bitcoin Core software, see
https://bitcoincore.org/en/download/.

What is Bitcoin Core?
---------------------

Bitcoin Core connects to the Bitcoin peer-to-peer network to download and fully
validate blocks and transactions. It also includes a wallet and graphical user
interface, which can be optionally built.

Further information about Bitcoin Core is available in the [doc folder](/doc).

License
-------

Bitcoin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see https://opensource.org/licenses/MIT.

Development Process
-------------------

The `master` branch is regularly built (see `doc/build-*.md` for instructions) and tested, but it is not guaranteed to be
completely stable. [Tags](https://github.com/bitcoin/bitcoin/tags) are created
regularly from release branches to indicate new official, stable release versions of Bitcoin Core.

The https://github.com/bitcoin-core/gui repository is used exclusively for the
development of the GUI. Its master branch is identical in all monotree
repositories. Release branches and tags do not exist, so please do not fork
that repository unless it is for development reasons.

The contribution workflow is described in [CONTRIBUTING.md](CONTRIBUTING.md)
and useful hints for developers can be found in [doc/developer-notes.md](doc/developer-notes.md).

Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test on short notice. Please be patient and help out by testing
other people's pull requests, and remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write [unit tests](src/test/README.md) for new code, and to
submit new unit tests for old code. Unit tests can be compiled and run
(assuming they weren't disabled in configure) with: `make check`. Further details on running
and extending unit tests can be found in [/src/test/README.md](/src/test/README.md).

There are also [regression and integration tests](/test), written
in Python.
These tests can be run (if the [test dependencies](/test) are installed) with: `test/functional/test_runner.py`

The CI (Continuous Integration) systems make sure that every pull request is built for Windows, Linux, and macOS,
and that unit/sanity tests are run automatically.

### Manual Quality Assurance (QA) Testing

Changes should be tested by somebody other than the developer who wrote the
code. This is especially important for large or high-risk changes. It is useful
to add a test plan to the pull request description if testing the changes is
not straightforward.

Translations
------------

Changes to translations as well as new translations can be submitted to
[Bitcoin Core's Transifex page](https://www.transifex.com/bitcoin/bitcoin/).

Translations are periodically pulled from Transifex and merged into the git repository. See the
[translation process](doc/translation_process.md) for details on how this works.

**Important**: We do not accept translation changes as GitHub pull requests because the next
pull from Transifex would automatically overwrite them again.
