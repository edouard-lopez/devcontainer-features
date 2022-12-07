# Features

> Some devcontainer features I find useful.

* [bats](src/bats/README.md): Install `bats` (Bash Automated Testing System)
* [x] prettier

## Usage

In your IDE, add the features to your `devcontainer.json` (e.g. [VSCode][vscode]). Each feature has a `README.md` that details options.

```json
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
      "bats": {}
    }
}
```

## Notes

> This repo follows the [**proposed**  dev container feature distribution specification](https://containers.dev/implementors/features-distribution/).

## License

[MIT](./LICENSE)

[vscode]: https://code.visualstudio.com/docs/devcontainers/containers