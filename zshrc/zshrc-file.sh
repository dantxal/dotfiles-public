      echo "Successfully installed fzf"
    fi
  fi

  cd ~

  # Check if the Meslo Nerd Font is already installed
  if ! fc-list | grep -qi "Meslo"; then
    echo
    echo "Installing Meslo Nerd Fonts..."

    # Download the font archive
    curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz 2>&1 >/dev/null

    # Ensure the fonts directory exists and extract the fonts
    mkdir -p ~/.local/share/fonts
    tar -xvf Meslo.tar.xz -C ~/.local/share/fonts 2>&1 >/dev/null
    rm Meslo.tar.xz

    # Refresh the font cache
    fc-cache -fv 2>&1 >/dev/null

    echo "Meslo Nerd Fonts installed."
  fi

  # Check if Neovim is already installed, otherwise install it
  if ! command -v nvim &>/dev/null; then
    echo
    echo "Installing neovim, please wait..."
    # Install latest version of neovim
    # Debian repos have a really old version, so had to go this route
    # switched to wget as was having issues when downloading with curl
    cd ~
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 2>&1 >/dev/null
    # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    # After downloading it, you have to make it executable to be able to extract it
    chmod u+x nvim.appimage
    # I'll extract the executable and expose it globally
    ./nvim.appimage --appimage-extract 2>&1 >/dev/null
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm nvim.appimage
    # Remove any cached files that may exist from a previous config
    echo "removing backup files.."
    mv ~/.local/share/nvim{,.bak} >/dev/null 2>&1
    mv ~/.local/state/nvim{,.bak} >/dev/null 2>&1
    mv ~/.cache/nvim{,.bak} >/dev/null 2>&1
    echo "Downloaded neovim"
  fi

  # These below ones are neovim dependencies
  # Check and install lazygit if not installed
  if ! command -v lazygit &>/dev/null; then
    cd ~
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget -O lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" 2>&1 >/dev/null
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -rf lazygit
    rm lazygit.tar.gz
    echo "Downloaded lazygit"
  fi

  # Check and install the C compiler (build-essential) if not installed
  if ! gcc --version &>/dev/null; then
    echo "Installing C compiler (build-essential) for nvim-treesitter..."
    sudo apt install build-essential -y 2>&1 >/dev/null
    echo "Installed C compiler"
  fi

  # Check and install ripgrep if not installed
  if ! command -v rg &>/dev/null; then
    echo "Installing ripgrep..."
    sudo apt-get install ripgrep -y 2>&1 >/dev/null
    echo "Installed ripgrep"
  fi

  # Check and install fd-find if not installed
  if ! command -v fdfind &>/dev/null; then
    echo "Installing fd-find..."
    sudo apt-get install fd-find -y 2>&1 >/dev/null
    echo "Installed fd_find"
  fi

  # Check and install fuse if not installed
  if ! command -v fusermount &>/dev/null; then
    echo "Installing fuse..."
    sudo apt install fuse -y 2>&1 >/dev/null
    echo "Installed fuse"
  fi

  # Initialize kubernetes kubectl completion if kubectl is installed
  # https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#enable-shell-autocompletion
  if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
  fi
fi

. /opt/homebrew/etc/profile.d/z.sh
