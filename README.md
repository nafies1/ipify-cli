# ipify-cli

A tiny, dependency-free command-line tool that prints your public IP address, using the free [ipify.org](https://www.ipify.org) API.

```sh
$ ipify
203.0.113.42
```

## Features

- Zero dependencies beyond `curl` (already on every Mac)
- Works with IPv4, IPv6, or force a specific family with `-4` / `-6`
- `--json` output for scripting
- Installs in seconds, no `sudo` required

## Requirements

- macOS (or any Unix-like system with `sh` and `curl`)
- An internet connection

## Installation

1. Clone or download this repository.
2. Run the installer from inside the project folder:

   ```sh
   ./install.sh
   ```

   This symlinks `ipify.sh` to `~/.local/bin/ipify`. It does **not** require `sudo`.

3. Make sure `~/.local/bin` is on your `PATH`. Most modern shell setups already include it; if `ipify` isn't found after installing, add this to your `~/.zshrc` (or `~/.bashrc`) and restart your terminal:

   ```sh
   export PATH="$HOME/.local/bin:$PATH"
   ```

## Usage

```
ipify [-4 | -6] [--json]
```

| Flag          | Description                                      |
|---------------|---------------------------------------------------|
| *(none)*      | Print your public IP (IPv4 or IPv6, whichever your connection uses) |
| `-4`          | Force the lookup over IPv4                        |
| `-6`          | Force the lookup over IPv6                         |
| `--json`      | Print output as JSON: `{"ip":"203.0.113.42"}`      |
| `-h`, `--help`| Show usage                                         |

### Examples

Plain lookup:

```sh
$ ipify
203.0.113.42
```

Force IPv4:

```sh
$ ipify -4
203.0.113.42
```

Scripting with `--json` and [`jq`](https://jqlang.org):

```sh
$ ipify --json | jq -r .ip
203.0.113.42
```

Flags can be combined:

```sh
$ ipify -6 --json
{"ip":"2001:db8::1"}
```

## Exit codes

| Code | Meaning                                      |
|------|-----------------------------------------------|
| `0`  | Success                                        |
| `1`  | Network/lookup failure, or invalid arguments   |

On failure, an explanatory message is printed to stderr (e.g. no network, or no IPv6 connectivity when `-6` is used).

## Uninstalling

```sh
rm ~/.local/bin/ipify
```

## How it works

`ipify` is a thin wrapper around a single `curl` request to `https://api64.ipify.org` (or `https://api64.ipify.org?format=json` for `--json`), forcing the IP protocol version with curl's own `-4`/`-6` flags when requested. No data is stored or sent anywhere beyond that one request to ipify.org.

## Credits

Public IP lookups are provided by the free [ipify.org](https://www.ipify.org) API. This project is not affiliated with ipify.org.

## License

[MIT](LICENSE)
