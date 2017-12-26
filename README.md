# Dotfiles
This is the main repository for managing my dotfiles. It does not contain very much data, as most of
my dotfiles are handled in separate repositories, as it sometimes does not make sense to pull in all
my dotfiles at once. See the **install.sh** script for more information about these module
repositories

## Requirements
To use this installation script it is necessary to have gnu stow installed, which you really should
if you want to manage your dotfiles with git.

## Installation
To install all dotfiles at once, clone this repository and run the `install.sh` script.

```
cd
git clone https://github.com/fmauch/dotfiles
cd dotfiles
# You might want to have a look at this to see which modules this will pull.
./install.sh
```
