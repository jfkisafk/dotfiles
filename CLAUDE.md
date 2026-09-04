# CLAUDE.md

Personal dotfiles, GNU `stow` → `~/.config` (`stow .` to apply, `stow -D .` to undo; `.stowrc` holds the target and ignore list). Covers only what Nix/home-manager can't or shouldn't own: `nvim/`, `karabiner/`, `herdr/`, `posting/`.

- `nvim/` is deliberately outside Nix so plugins/LSPs update without rebuilding the home-manager generation.
- The companion home-manager repo (`jfkisafk/nix`) is separate — don't reconcile it here.
- No build/lint/test suite. CI runs gitleaks only.

## `nvim/`

`init.lua` loads `neo.core` (options, then keymaps) → `neo.lazy` (bootstraps lazy.nvim, imports `neo.plugins{,.code,.ui,.explorer}`) → `neo.lsp` (LspAttach keymaps, diagnostic signs).

- One file per plugin under `lua/neo/plugins/{code,ui,explorer}/`, returning a lazy.nvim spec. New plugin = new file in the right directory; `import` picks it up, no registration.
- `mason.lua` only declares what gets *installed* (`ensure_installed`, mason-tool-installer). Per-server settings go in `after/lsp/<server>.lua` (native `vim.lsp.config`). New LSP: add to `ensure_installed`, then add `after/lsp/<server>.lua` only if defaults don't suffice.
- `lazy-lock.json` is a lockfile — never hand-edit.
