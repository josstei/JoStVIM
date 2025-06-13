![Stable](https://img.shields.io/badge/status-in_development-orange) ![License](https://img.shields.io/badge/license-MIT-blue)
# JoStVIM

**JoStVIM - Fast setup, faster coding**

JoStVIM is a tailored Vim/Neovim configuration that boosts productivity for developers across languages and stacks. It brings together a rich set of plugins, sensible defaults, custom mappings, and a ready-to-use project structure. Designed for general development workflows and flexible enough for specialized needs.

---

## Features & Purpose

- **Enhanced coding experience:** Sensible defaults for editing, navigation, and file management.
- **Modern Vim/Neovim features:** True color, system clipboard, improved window and buffer management.
- **Productivity plugins:** FZF fuzzy finder, NERDTree file explorer, smooth scrolling, advanced statusline, and more.
- **Custom mappings and menus:** For file, buffer, window, and code operations.
- **Multiple color schemes:** Popular themes for a visually appealing and comfortable environment.
- **Easy extensibility:** Relies on [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.
- **Portable and self-contained:** Use the provided install.sh script — no need to touch your global Vim/Neovim config.

---
## Installing Vim/Neovim

This plugin requires either Vim or Neovim to be installed on your system.

- [Download Neovim](https://github.com/neovim/neovim/releases)
- [Download Vim](http://www.vim.org/download.php)

## Installing JoStVIM

**Requirements:**  
- Bash shell (Linux/macOS/WSL)
- Vim or Neovim (preferably recent versions)
- curl

**Steps:**

1. **Clone this repository:**
   ```sh
   git clone https://github.com/josstei/JoStVIM.git
   cd JoStVIM
   ```

2. **Run the install script:**
   ```sh
   ./install.sh
   ```

   - This will:
     - Download vim-plug to `autoload/plug.vim`
     - Install all plugins for Vim and Neovim
     - Add convenient aliases (`jostvim`, `jost`) to your shell profile

3. **Restart your shell** or run `source ~/.bashrc` (or `~/.zshrc`, depending on your shell) to load the aliases.

4. **Launch JoStVIM:**
   - For Vim: `jostvim`
   - For Neovim: `jost`

   These will use the project’s `.vimrc` and plugins, leaving your global setup untouched.

---

## Key Customizations

- **Window and buffer navigation:** Custom mappings for splitting, jumping, and managing buffers.
- **File operations:** Quick save, quit, and force-quit mappings.
- **Fuzzy search:** Fast file and text search via FZF.
- **NERDTree integration:** Toggle file explorer with `<leader>e`, auto-open on start.
- **Custom commenting:** Mappings for quickly commenting/uncommenting code, language-aware.
- **Statusline and menus:** Advanced statusline and popup menus for productivity.

---

## Key Mappings

| Mapping             | Mode        | Action/Description                        |
|---------------------|-------------|-------------------------------------------|
| `<space>`           | Normal      | Leader key (remapped to space)            |
| `<leader>wv`        | Normal      | Split window vertically                   |
| `<leader>wh`        | Normal      | Split window horizontally                 |
| `<leader>1-6`       | Normal      | Jump to window 1-6                        |
| `<leader>e`         | Normal      | Toggle NERDTree file explorer             |
| `<leader><leader>`  | Normal      | Fuzzy open file in current directory      |
| `<leader>t`         | Normal      | Fuzzy search text in current directory    |
| `<leader>fs`        | Normal      | Save file                                 |
| `<leader>fq`        | Normal      | Quit file                                 |
| `<leader>FQ`        | Normal      | Force quit file                           |
| `<leader>bye`       | Normal      | Force quit all                            |
| `<leader>cc`        | Normal/Visual| Comment line(s)                          |
| `<leader>cu`        | Normal/Visual| Uncomment line(s)                        |
| `<Ctrl-/>`             | Normal/Term | Toggle TidyTerm terminal                  |
| `jk`                | Insert      | Exit insert mode                          |

---

## Included Plugins

Below is a list of core plugins used in JoStVIM, with links and descriptions:

- [vim-plug](https://github.com/junegunn/vim-plug)  
  *Minimalist Vim plugin manager. Handles installation and updates of all listed plugins.*
  
- [josstei/vim-jostline](https://github.com/josstei/vim-jostline)  
  *Custom statusline for Vim/Neovim with rich information and a clean appearance.*

- [josstei/vim-easyops](https://github.com/josstei/vim-easyops)  
  *Quick menus for common operations such as git, window, file, and code management.*

- [josstei/vim-easyenv](https://github.com/josstei/vim-easyenv)  
  *Helpers for managing and switching development environments within Vim.*

- [josstei/vim-tidyterm](https://github.com/josstei/vim-tidyterm)  
  *Integrated terminal management in Vim/Neovim with easy-to-use mappings.*

- [junegunn/fzf](https://github.com/junegunn/fzf)  
  *Fuzzy file finder. Quickly search and open files by name with blazing speed.*

- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)  
  *Integrates fzf with Vim for fuzzy searching files, buffers, lines, and more.*

- [psliwka/vim-smoothie](https://github.com/psliwka/vim-smoothie)  
  *Smooth scrolling for Vim. Makes navigation visually pleasant.*

- [preservim/nerdtree](https://github.com/preservim/nerdtree)  
  *Tree-style file explorer. Easily browse, open, and manage files and directories.*

---

### Color Schemes

| Name       | Link                                                                          | Description                                          |
|------------|-------------------------------------------------------------------------------|------------------------------------------------------|
| Dracula    | [dracula/vim](https://github.com/dracula/vim)                                 | Dark, vibrant, and visually appealing.               |
| Gruvbox    | [morhetz/gruvbox](https://github.com/morhetz/gruvbox)                         | Popular earthy dark/light color scheme.              |
| Nord       | [arcticicestudio/nord-vim](https://github.com/arcticicestudio/nord-vim)       | Arctic, north-bluish hues.                           |
| Solarized  | [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) | Balanced, low contrast.                  |
| Catppuccin | [catppuccin/vim](https://github.com/catppuccin/vim)                           | Pastel, eye-friendly.                                |
| Monokai    | [crusoexia/vim-monokai](https://github.com/crusoexia/vim-monokai)             | Vivid, high contrast.                                |
| Everforest | [sainnhe/everforest](https://github.com/sainnhe/everforest)                   | Warm, greenish, soft.                                |
| PaperColor | [NLKNguyen/papercolor-theme](https://github.com/NLKNguyen/papercolor-theme)   | Light and dark variations inspired by Google’s Material colors. |

---

## Updating Plugins

Inside JoStVIM, run:
```
:PlugUpdate
```

---

## Customizing

You may edit `.vimrc` to add/remove plugins or change settings as you like. To add your own Vim scripts, put them in the `plugin/` directory.

---

## Uninstallation

To remove JoStVIM, simply delete the cloned directory and remove the aliases from your shell profile.

---

## License

- JoStVIM: MIT (see LICENSE)
- Included plugins: See individual plugin repositories for their licenses.
