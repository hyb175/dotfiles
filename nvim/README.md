# LazyVim Configuration

This is a [LazyVim](https://www.lazyvim.org/) configuration with custom plugins and settings.

## Features

- Full LazyVim setup with language support for:
  - Ruby, TypeScript, YAML, Terraform, Docker, Go, Java, Rust, SQL, and more
- AI/LLM integrations:
  - Avante
  - Claude Code
  - CodeCompanion
  - LLM.nvim
- Custom colorscheme configuration
- Kulala for REST API testing
- Render-markdown for enhanced markdown viewing

## Plugin Management

### Consistent Versions Across Machines

The `lazy-lock.json` file is tracked in git to ensure all machines use the exact same plugin versions. This provides:

- **Reproducible installs**: Everyone gets the same plugin versions
- **Stability**: No surprises from plugin updates on different machines
- **Team consistency**: All team members work with the same environment

### Updating Plugins

To update plugins:

1. Open Neovim
2. Run `:Lazy update` to update all plugins (or `:Lazy` to open the UI)
3. Test that everything works correctly
4. Commit the updated `lazy-lock.json` file:
   ```bash
   git add nvim/lazy-lock.json
   git commit -m "chore: update neovim plugins"
   ```

### Fresh Install Without Lock File

If you want to install the latest versions of all plugins (ignoring the lock file):

1. Delete or move the `lazy-lock.json` file
2. Start Neovim (plugins will install latest versions)
3. Run `:Lazy` to ensure all plugins are installed
4. Optionally commit the new `lazy-lock.json` if you want to update the locked versions

## Customization

- Add custom plugins in `lua/plugins/`
- Modify settings in `lua/config/`
- See [LazyVim documentation](https://www.lazyvim.org/) for more customization options