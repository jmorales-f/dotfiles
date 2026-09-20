# Zsh configuration entry point.
# Imports every module from the modules/ directory.

zsh_config_dir="${${(%):-%x}:A:h}"

for module in "$zsh_config_dir"/modules/*.zsh(N); do
	source "$module"
done
