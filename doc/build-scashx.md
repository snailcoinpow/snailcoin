# SCASHX BUILD NOTES

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
If you prefer to compile ScashX yourself the build process is similar to that of Bitcoin Core (see install instructions detailed below) and takes approximately 5-15 minutes depending on your system performance. Detailed, step-by-step guidance can be also be found in [build-unix.md](https://github.com/scashx/scashx/blob/scashx_master/doc/build-unix.md) but there should be no need to refer to this for the default install on Linux (Ubuntu).

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

# Getting Started 

Update your system and install the following tools required to build software.

```bash
sudo apt update
sudo apt upgrade
sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git cmake bison
```

## WSL for Windows

Ignore this step if building on native Linux. The following only applies when building in WSL for Windows.

Open the WSL configuration file:
```bash
sudo nano /etc/wsl.conf
```
Add the following lines to the file:
```
[interop]
appendWindowsPath=false
```
Exit WSL and then restart WSL ('wsl --shutdown' from Windows Command Prompt).

## Downloading the code

Download the latest version of ScashX.

```bash
git clone https://github.com/scashx/scashx.git
cd scashx
```

## Building for Linux

ScashX requires building with the depends system.

When calling `make` use `-j N` for N parallel jobs, as many as compatible with your processor. Type 'nproc' to see the available processors on your computer.

### Node software

To build the node software `scashxd`:

```bash
./autogen.sh
make -C depends NO_QT=1
./configure --without-gui --prefix=$PWD/depends/x86_64-pc-linux-gnu --program-transform-name='s/bitcoin/scashx/g'
make
make install
```
### Executables

The compiled executables will be found in `depends/x86_64-pc-linux-gnu/bin/` and can be copied to a folder on your path, typically `/usr/local/bin/` or `$HOME/.local/bin/`.

## Building for Windows (by cross-compiling on Linux)

Build on Linux and generate executables which run on Windows.

```
sudo apt install g++-mingw-w64-x86-64-posix
cd depends/
make HOST=x86_64-w64-mingw32
cd ..
./autogen.sh
./configure --prefix=$PWD/depends/x86_64-w64-mingw32 --program-transform-name='s/bitcoin/scashx/g'
make
make install
```

The windows executables will be found in `depends/x86_64-w64-mingw32/bin/`.

To generate a Windows installer:

```
sudo apt install nsis
make deploy
```

## Config file

The ScashX configuration file is the same as bitcoin.conf, a default ScashX configuration file is provided below.

### Unix

By default, ScashX looks for a configuration file on unix here:
`$HOME/.scashx/scashx.conf`

### Windows

ScashX stores its data (your blockchain, wallet, and configuration files) in a hidden folder within your user profile. This is standard practice for applications.

You can quickly access this folder which will also contain your wallets and blockchain data by following these steps:

* Open File Explorer (you can press Win + E).

* Type `%APPDATA%\ScashX` into the address bar at the top of the File Explorer window. Press Enter.

This will directly open the ScashX data folder where the scashx.conf should be placed, typically: `\C:\Users\YourUsername\AppData\Roaming\ScashX`

(where YourUsername will be your specific Windows user profile name).

Note: The AppData folder is usually hidden by default in Windows. If you need to navigate to it manually, ensure you enable "Hidden items" under the "View" tab in File Explorer.

After running the GUI you can check that the correct config setting is loading in the Settings menu.

### Sample config (default)

The following is a sample `scashx.conf`:

```
# This is the main ScashX configuration file.
# Lines starting with '#' are comments.

# --- GLOBAL SETTINGS ---
# These settings apply to all networks (mainnet, testnet, regtest)
# unless specifically overridden in their respective sections below.

rpcuser=user
rpcpassword=password
#rpcallowip=0.0.0.0/0         # Uncomment to allow RPC connections from any IP address

daemon=1                      # Run the node as a background daemon process (1=enabled, 0=disabled)
debug=0                       # Disable debug logging (0=off, 1=on, higher numbers for more verbose)
listen=1                      # Enable listening for incoming peer-to-peer connections (1=enabled, 0=disabled)
txindex=1                     # Enable transaction indexing (required for certain RPC calls like getrawtransaction by txid)
randomxfastmode=1             # Enable fast mode for RandomX (relevant for mining/CPU utilization)
fallbackfee=0.01              # Set a fallback fee rate (in coins per kB) for transactions

# --- MAINNET CONFIGURATION ---
# This section defines settings specific to the ScashX mainnet.
[scashx]
# DNS seeds help your node find initial peers on the network.
dnsseed=1
adddnsseed=seed.scashx.io
adddnsseed=seed2.scashx.io

# --- TESTNET CONFIGURATION ---
# This section defines settings specific to the ScashX testnet.
[scashxtestnet]
addnode=45.76.143.162

# --- REGTEST CONFIGURATION ---
# This section defines settings specific to the ScashX regtest (regression test) network.
[scashxregtest]
addnode=45.76.143.162
```

### Connecting to the network

To help find other nodes on the network, a [DNS seed](https://bitcoin.stackexchange.com/questions/14371/what-is-a-dns-seed-node-vs-a-seed-node) has been specified. Users are can also ask the community for a list of [reliable DNS seeds](https://github.com/bitcoin/bitcoin/blob/master/doc/dnsseed-policy.md) to use, as well as the IP addresses of stable nodes on the network which can be used with the `-addnode` and `-seednode` RPC calls.

If you intend to use the same configuration file with multiple networks, the config sections are named as follows:
```
[btc]
[btctestnet3]
[btcsignet]
[btcregtest]
[scashx]
[scashxregtest]
[scashxtestnet]
```

## Running a node

Note: The first time you run the node it may take several minutes to synchronise with the ScashX network (check the GUI status in Windows). Synchronisation must complete before commencing mining.

### Unix

To run the ScashX node:
```bash
scashxd
```

To send commands to the ScashX node:
```
scashx-cli [COMMAND] [PARAMETERS]
```

### Windows

Run the GUI app from the start menu or:
```
scash-qt
```

On WSL for Windows, launching `scash-qt` may require installing the following dependencies. Also see [WSL Gui Apps](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps).

```
sudo apt install libxcb-* libxkbcommon-x11-0
```

Also note that in WSL for Windows, by default only half of the memory is available to WSL. You can [configure the memory limit](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#main-wsl-settings) by creating `.wslconfig` file in your user folder.
```
[wsl2]
memory=16GB
```

## Connecting to different chains

When running executables with the name `bitcoin...` if no chain is configured, the default chain will be Bitcoin mainnet.

When running executables with the name `scashx...` if no chain is configured, the default chain will be ScashX mainnet.

Option `-chain=` accepts the following values: `scashx` `scashxtestnet` `scashxregtest` and for Bitcoin networks: `main` `test` `signet` `regtest`

## Mining ScashX

There are a few ways to mine ScashX.

### Main network and Testnet chain

Mining takes place inside [cpuminer-scashx](https://github.com/scashx/cpuminer-scashx) which is dedicated mining software that connects to the ScashX node and retrieves mining jobs via RPC `getblocktemplate`. The 'randomxfastmode' configuration option is not required for the ScashX node, since mining occurs inside `cpuminer-scashx` which always runs in fast mode.

Build instructions for [cpuminer-scashx](https://github.com/scashx/cpuminer-scashx/blob/master/README.md).

### Testnet and Regtest chain

Mining takes place inside the ScashX node, using the RPC `generatetoaddress` which is single-threaded. For example:
```bash
scashx-cli createwallet myfirstwallet
scashx-cli getnewaddress
scashx-cli generatetoaddress 1 newminingaddress 10000
```

To speed up mining in the ScashX node, at the expense of using more memory (at least 2GB more), enable the option `randomxfastmode` by adding to the `scashx.conf` configuration file:

```
randomxfastmode=1
```

### Mining Pools

Third-party software exists for mining at pools.

Getting Help
---------------------

Please file a Github issue if build problems are not resolved after reviewing the available ScashX and Bitcoin documentation.
