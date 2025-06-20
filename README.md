![Stable](https://img.shields.io/badge/status-in_development-orange) ![License](https://img.shields.io/badge/license-MIT-blue)
# JoStVIM

## 🚧 Work in Progress

This environment is available for use, but is still under active development.  
Feedback, contributions, and patience are welcome.

## JoStVIM - Fast setup, faster coding

JoStVIM is a tailored Vim/Neovim configuration that boosts productivity for developers across languages and stacks. It brings together a rich set of plugins, sensible defaults, custom mappings, an intuitive dashboard, and much more.

---

## Features & Purpose

- **Enhanced coding experience:** Sensible defaults for editing, navigation, and file management.
- **Modern Vim/Neovim features:** True color, system clipboard, improved window and buffer management.
- **Productivity plugins:** FZF fuzzy finder, NERDTree file explorer, smooth scrolling, advanced statusline, and more.
- **Dashboard menu:** Dashboard with quick actions for new file, recent files, project search, and quit.
- **Recent Files (Backtrack):** Access to recently opened files from the dashboard or via custom mappings.
- **Functional buffer/window navigation:** Skip help, quickfix, and terminal windows with custom logic.
- **Custom mappings and menus:** For file, buffer, window, and code operations.
- **Multiple color schemes:** Popular themes for a visually appealing and comfortable environment.
- **Easy extensibility:** Relies on [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.
- **Portable and self-contained:** Use the provided install.sh script — no need to touch your global Vim/Neovim config.

---

## Installing Vim/Neovim

This plugin requires either Vim or Neovim to be installed on your system.

- [Download Neovim](https://github.com/neovim/neovim/releases) (recommended)
- [Download Vim](http://www.vim.org/download.php)

If you are new to Vim or Neovim see [Vim & Neovim Quick Reference](#vim--neovim-quick-reference) to get started.

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

   On launch, you’ll see the dashboard with quick actions for new files, recent files, project-wide search, and quit.

---

## Key Mappings

| Mapping             | Mode           | Action/Description                                 |
|---------------------|----------------|----------------------------------------------------|
| `<space>`           | Normal         | Leader key (remapped to space)                     |
| `<leader>wv`        | Normal         | Split window vertically                            |
| `<leader>wh`        | Normal         | Split window horizontally                          |
| `<leader>1-6`       | Normal         | Jump to window 1-6                                 |
| `<leader>e`         | Normal         | Toggle NERDTree file explorer                      |
| `<leader>m`         | Normal         | Open EasyOps Menu                                  |
| `<leader><leader>`  | Normal         | Fuzzy open file in current directory (FZF)         |
| `<leader>t`         | Normal         | Fuzzy search text in current directory             |
| `<leader>fs`        | Normal         | Save file                                          |
| `<leader>fq`        | Normal         | Quit file                                          |
| `<leader>FQ`        | Normal         | Force quit file                                    |
| `<leader>bye`       | Normal         | Force quit all buffers                             |
| `<leader>cc`        | Normal/Visual  | Comment line(s)                                    |
| `<leader>cu`        | Normal/Visual  | Uncomment line(s)                                  |
| `<Ctrl-/>`          | Normal/Term    | Toggle TidyTerm terminal                           |
| `jk`                | Insert         | Exit insert mode                                   |
| `n`, `r`, `s`, `q`  | Dashboard      | New file, recent files, search, quit               |

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
- [josstei/vim-backtrack](https://github.com/josstei/vim-backtrack)  
  *Recent files manager. Integrates with the dashboard for quick access to recent files.*
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

You may edit `.vimrc` to add/remove plugins or change settings as you like.  
To add your own Vim scripts, put them in the `plugin/` directory.

You can customize dashboard options, recent file limits, and menu actions in `.vimrc` variables such as `g:dashboard_options`, `g:dashboard_menu_fzf`, etc.

---

## Uninstallation

To remove JoStVIM, simply delete the cloned directory and remove the aliases from your shell profile.

---

# Vim & Neovim Quick Reference

A minimal cheat sheet for everyday use. Focused on:
- Moving around
- Editing (inserting, deleting)
- Modes: Normal / Insert / Visual

---

## 🔄 Modes

| Mode   | Key to Enter | Description                      |
|--------|--------------|----------------------------------|
| Normal | `<Esc>`      | Default mode for navigation      |
| Insert | `i`          | Start typing before the cursor   |
|        | `I`          | Start typing at line start       |
|        | `a`          | Start typing after the cursor    |
|        | `A`          | Start typing at line end         |
| Visual | `v`          | Character-wise selection         |
|        | `V`          | Line-wise selection              |
|        | `Ctrl+v`     | Block/column selection (Visual Block) |

---

## 🚶 Cursor Movement (Normal Mode)

| Key(s)   | Action                          |
|----------|---------------------------------|
| `h`      | Left                            |
| `l`      | Right                           |
| `j`      | Down                            |
| `k`      | Up                              |
| `0`      | Start of line                   |
| `^`      | First non-whitespace character  |
| `$`      | End of line                     |
| `w`      | Next word                       |
| `b`      | Previous word                   |
| `gg`     | Go to top of file               |
| `G`      | Go to bottom of file            |
| `:n`     | Go to line `n`                  |

---

## ✏️ Inserting Text

| Key   | Action                             |
|--------|------------------------------------|
| `i`    | Insert before cursor               |
| `I`    | Insert at line start               |
| `a`    | Append after cursor                |
| `A`    | Append at line end                 |
| `o`    | Open new line below                |
| `O`    | Open new line above                |

---

## ❌ Deleting Text

| Key     | Action                              |
|---------|-------------------------------------|
| `x`     | Delete character under cursor       |
| `dd`    | Delete current line                 |
| `d$`    | Delete to end of line               |
| `D`     | Same as `d$`                        |
| `dw`    | Delete word                         |
| `d0`    | Delete to start of line             |
| `d^`    | Delete to first non-whitespace char |
| `v + d` | Delete selected text in visual mode |

---

## 📋 Copy & Paste (Yank & Put)

| Key     | Action                             |
|---------|------------------------------------|
| `yy`    | Yank (copy) current line           |
| `yw`    | Yank word                          |
| `y$`    | Yank to end of line                |
| `p`     | Paste after cursor                 |
| `P`     | Paste before cursor                |
| `v + y` | Yank selected text (Visual Mode)   |

---

## 🔁 Undo / Redo

| Key     | Action            |
|---------|-------------------|
| `u`     | Undo              |
| `Ctrl+r`| Redo              |

---

## 🏁 Saving & Exiting

| Key          | Action              |
|---------------|---------------------|
| `:w`          | Save                |
| `:q`          | Quit                |
| `:wq` or `ZZ` | Save and quit       |
| `:q!`         | Quit without saving |

---

> 💡 Tip: Start in Normal mode and build muscle memory with movement and `d`, `y`, `p`, `u`, and mode switches.

## License

- JoStVIM: MIT (see LICENSE)
- Included plugins: See individual plugin repositories for their licenses.
