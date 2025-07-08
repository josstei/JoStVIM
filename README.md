![Stable](https://img.shields.io/badge/status-in_development-orange) ![License](https://img.shields.io/badge/license-MIT-blue)
# JoStVIM

## 🚧 Work in Progress

This environment is available for use, but is still under active development.  
Feedback, contributions, and patience are welcome.

## JoStVIM - Fast setup, faster coding

JoStVIM is a tailored Vim/Neovim configuration that boosts productivity for developers across languages and stacks. It brings together a rich set of plugins, sensible defaults, custom mappings, and a comprehensive suite of custom-built productivity tools designed to create a seamless development experience.

---

## Features & Purpose

- **Enhanced coding experience:** Sensible defaults for editing, navigation, and file management.
- **Modern Vim/Neovim features:** True color, system clipboard, improved window and buffer management.
- **Productivity plugins:** FZF fuzzy finder, NERDTree file explorer, smooth scrolling, advanced statusline, and more.
- **Custom Dashboard:** Interactive start screen with ASCII logo, quick actions for new file, recent files, project search, and quit.
- **Unified Command Menu:** Comprehensive operations menu for files, projects, Git, and development tasks.
- **Recent Files Management:** Quick access to recently opened files from dashboard or custom mappings.
- **Environment Management:** Easy switching between development environments and configurations.
- **Integrated Terminal:** Lightweight terminal buffer management with quick toggle functionality.
- **Smart Commenting:** Intelligent comment/uncomment functionality across multiple languages.
- **Advanced Statusline:** Rich information display with clean, customizable appearance.
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

   These will use the project's `.vimrc` and plugins, leaving your global setup untouched.

   On launch, you'll see the dashboard with quick actions for new files, recent files, project-wide search, and quit.

---

## Key Mappings

| Mapping             | Mode           | Action/Description                                 |
|---------------------|----------------|----------------------------------------------------|
| `<space>`           | Normal         | Leader key (remapped to space)                     |
| `<leader>wv`        | Normal         | Split window vertically                            |
| `<leader>wh`        | Normal         | Split window horizontally                          |
| `<leader>1-6`       | Normal         | Jump to window 1-6                                 |
| `<leader>e`         | Normal         | Toggle NERDTree file explorer                      |
| `<leader>m`         | Normal         | Open EasyOps unified command menu                  |
| `<leader><leader>`  | Normal         | Fuzzy open file in current directory (FZF)         |
| `<leader>t`         | Normal         | Fuzzy search text in current directory             |
| `<leader>fs`        | Normal         | Save file                                          |
| `<leader>fq`        | Normal         | Quit file                                          |
| `<leader>FQ`        | Normal         | Force quit file                                    |
| `<leader>bye`       | Normal         | Force quit all buffers                             |
| `<leader>cc`        | Normal/Visual  | Comment line(s) with EasyComment                   |
| `<leader>cu`        | Normal/Visual  | Uncomment line(s) with EasyComment                 |
| `<Ctrl-/>`          | Normal/Term    | Toggle TidyTerm terminal                           |
| `jk`                | Insert         | Exit insert mode                                   |
| `n`, `r`, `s`, `q`  | Dashboard      | New file, recent files, search, quit               |

---

## JoStVIM Custom Plugins

JoStVIM includes a comprehensive suite of custom-built plugins designed to work seamlessly together:

### Core Navigation & Interface
- **[josstei/vim-easydash](https://github.com/josstei/vim-easydash)**  
  *Lightweight, customizable dashboard with ASCII logo and interactive menu. Provides a clean start screen with quick access to common actions.*

- **[josstei/vim-backtrack](https://github.com/josstei/vim-backtrack)**  
  *Quick navigation to recent files. Run a single command to view recently opened files and instantly jump to any with a number key.*

- **[josstei/vim-easyline](https://github.com/josstei/vim-easyline)**  
  *Advanced statusline with rich information display and clean, customizable appearance.*

### Development Operations
- **[josstei/vim-easyops](https://github.com/josstei/vim-easyops)**  
  *Unified, extensible menu for common development tasks. Provides context-aware commands for Git, project management, file operations, and language-specific build tools.*

- **[josstei/vim-easyenv](https://github.com/josstei/vim-easyenv)**  
  *Lightweight environment variable management for projects. Easily switch between development configurations and manage project-specific settings.*

### Terminal & Editing
- **[josstei/vim-tidyterm](https://github.com/josstei/vim-tidyterm)**  
  *Integrated terminal buffer management with easy toggle functionality. Quick access to a dedicated terminal without disrupting your workflow.*

- **[josstei/vim-easycomment](https://github.com/josstei/vim-easycomment)**  
  *Intelligent comment/uncomment functionality that automatically detects file types and applies appropriate comment syntax.*

### Theme Support
- **[josstei/voidpulse.nvim](https://github.com/josstei/voidpulse.nvim)**  
  *Modern dark theme for Neovim with carefully crafted colors optimized for extended coding sessions.*

---

## Third-Party Plugins

JoStVIM also integrates essential third-party plugins for enhanced functionality:

- **[vim-plug](https://github.com/junegunn/vim-plug)**  
  *Minimalist Vim plugin manager. Handles installation and updates of all listed plugins.*

- **[junegunn/fzf](https://github.com/junegunn/fzf)**  
  *Fuzzy file finder. Quickly search and open files by name with blazing speed.*

- **[junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)**  
  *Integrates fzf with Vim for fuzzy searching files, buffers, lines, and more.*

- **[psliwka/vim-smoothie](https://github.com/psliwka/vim-smoothie)**  
  *Smooth scrolling for Vim. Makes navigation visually pleasant.*

- **[preservim/nerdtree](https://github.com/preservim/nerdtree)**  
  *Tree-style file explorer. Easily browse, open, and manage files and directories.*

---

## EasyOps Command Menu

The unified EasyOps menu provides quick access to development operations:

### Available Menus
- **Git Operations:** Status, pull, push, add, commit, log, branches, checkout
- **File Management:** Save, quit, force quit with intelligent handling
- **Project Tools:** Context-aware commands based on project type (Maven, npm, Rust, etc.)
- **Environment Switching:** Quick environment configuration changes
- **Window Management:** Split, resize, and navigate between windows

### Project Detection
EasyOps automatically detects your project type and provides relevant commands:
- **Java/Maven:** Compile, test, package, install, deploy
- **Node.js/npm:** Install, build, test, start, dev scripts
- **Rust/Cargo:** Build, run, test, check, clippy
- **Python:** Run, test, format, lint operations
- **Docker:** Build, run, compose operations
- **And many more...**

---

### Color Schemes

| Name       | Link                                                                          | Description                                          |
|------------|-------------------------------------------------------------------------------|------------------------------------------------------|
| VoidPulse  | [josstei/voidpulse.nvim](https://github.com/josstei/voidpulse.nvim)          | Modern dark theme optimized for coding.             |
| Dracula    | [dracula/vim](https://github.com/dracula/vim)                                 | Dark, vibrant, and visually appealing.               |
| Gruvbox    | [morhetz/gruvbox](https://github.com/morhetz/gruvbox)                         | Popular earthy dark/light color scheme.              |
| Nord       | [arcticicestudio/nord-vim](https://github.com/arcticicestudio/nord-vim)       | Arctic, north-bluish hues.                           |
| Solarized  | [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) | Balanced, low contrast.                  |
| Catppuccin | [catppuccin/vim](https://github.com/catppuccin/vim)                           | Pastel, eye-friendly.                                |
| Monokai    | [crusoexia/vim-monokai](https://github.com/crusoexia/vim-monokai)             | Vivid, high contrast.                                |
| Everforest | [sainnhe/everforest](https://github.com/sainnhe/everforest)                   | Warm, greenish, soft.                                |
| PaperColor | [NLKNguyen/papercolor-theme](https://github.com/NLKNguyen/papercolor-theme)   | Light and dark variations inspired by Google's Material colors. |

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

### Customizing EasyOps Menus

Add custom commands to EasyOps in your `.vimrc`:

```vim
" Add custom Python menu
let g:easyops_commands_python = [
      \ { 'label': 'Python: Run', 'command': 'python3 ' . expand('%') },
      \ { 'label': 'Python: Format', 'command': 'black ' . expand('%') }
      \ ]
let g:easyops_menu_python = { 'commands': g:easyops_commands_python }

" Add to main menu
if exists('g:easyops_commands_main')
  call add(g:easyops_commands_main, { 'label': 'Python', 'command': 'menu:python' })
endif
```

### Environment Management

Configure project environments with vim-easyenv by using a `.easyenv.json` file in your project root:

#### Using vim-easyenv

1. **Create environment file in your project:**
   ```
   :EasyEnvCreate
   ```
   This creates a `.easyenv.json` file with default structure in your project root.

2. **Edit `.easyenv.json` to define your variables:**
   ```json
   {
     "environment": {
       "API_URL": "https://dev.local/api",
       "DEBUG": "1",
       "DATABASE_URL": "localhost:5432",
       "NODE_ENV": "development"
     }
   }
   ```

3. **Load environment variables into your Vim session:**
   ```
   :EasyEnvLoad
   ```
   Your environment variables will be available as `$API_URL`, `$DEBUG`, etc.

#### Features
- **Automatic Project Root Detection**: Detects project root by scanning for manifest files (package.json, Cargo.toml, pom.xml, go.mod, Dockerfile, and many more)
- **Automatic Variable Management**: Previously loaded variables are automatically unset before new ones are loaded
- **Wide Ecosystem Support**: Supports JavaScript, Python, Rust, Java, .NET, Go, Docker, Kubernetes, and major frontend frameworks
- **Simple JSON Configuration**: All environment variables defined under a single `environment` key

The plugin automatically finds your project root and manages environment variables through the simple `.easyenv.json` configuration file, making it easy to keep project-specific environment variables isolated and under version control.

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
