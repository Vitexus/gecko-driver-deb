# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Debian packaging project that repackages Mozilla's geckodriver as a `.deb` package. It does NOT build geckodriver from source—instead, it downloads pre-built binaries from the upstream GitHub releases and wraps them in Debian packaging.

## Build Commands

### Building the Package Locally
```bash
debuild -us -uc
```
This creates `geckodriver_VERSION_amd64.deb` in the parent directory.

### Update to Latest Upstream Version
```bash
./upver.sh
```
This script fetches the latest geckodriver release version from GitHub API and updates `debian/changelog` accordingly using `dch`.

### Download Upstream Binary
```bash
./download.sh
```
This script:
- Fetches the latest release version from GitHub API
- Detects system architecture (x86_64/aarch64)
- Downloads the appropriate pre-built geckodriver tarball
- Extracts it to `debian/tmp/`
- This is automatically called during the build process via `debian/rules`

### CI/CD Build
The Jenkinsfile defines parallel builds for multiple Debian/Ubuntu distributions:
- debian:trixie (Debian 13), debian:forky (Debian 15)
- ubuntu:noble (24.04 LTS), ubuntu:oracular (24.10)

Build artifacts are published to Aptly repository.

## Architecture & Key Files

### Packaging Workflow
1. **debian/rules** - The build orchestration file
   - `override_dh_auto_install` calls `download.sh` to fetch the upstream binary
   - `override_dh_strip` is disabled (empty override) because geckodriver is a pre-built binary

2. **download.sh** - Fetches upstream geckodriver binary
   - Uses GitHub API to get latest release tag
   - Architecture detection: converts `uname -m` to geckodriver naming (linux64/arm64/linux32)
   - Downloads and extracts to `debian/tmp/`

3. **upver.sh** - Version management script
   - Queries GitHub API for latest release
   - Strips 'v' prefix from version tag
   - Updates `debian/changelog` with new version using `dch`

4. **debian/install** - Installation mapping
   - Simply installs `geckodriver` binary to `/usr/bin`

5. **debian/Jenkinsfile** - Multi-distribution CI pipeline
   - Uses `vitexsoftware/multiflexi-*` Docker images for each distro
   - Builds with `debuild-pbuilder`
   - Tests installation on each target distribution
   - Archives artifacts and publishes to Aptly

### Important Constraints
- This is a **repackaging project**, not a source build
- The binary is downloaded during build time from GitHub releases
- Architecture support depends on upstream geckodriver releases (typically linux64 and arm64)
- Version numbers should match upstream releases (use `upver.sh` to sync)
- The package depends only on `${misc:Depends}` and `${shlibs:Depends}` (runtime dependencies)

## Development Notes

### Version Updates
When updating to a new geckodriver version:
1. Run `./upver.sh` to update the changelog
2. Verify the new version is available on https://github.com/mozilla/geckodriver/releases
3. Build and test locally with `debuild -us -uc`

### Modifying the Packaging
- **debian/control** - Package metadata and dependencies
- **debian/install** - Installation paths for files
- **debian/rules** - Build process customization
- The `download.sh` script can be modified if upstream changes their release naming scheme

### Jenkins CI
The Jenkins pipeline uses `vitexsoftware/multiflexi-{distrocode}:latest` images for consistent builds. If adding new distributions, update the `distributions` array in the Jenkinsfile.
