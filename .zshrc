CONFIG_DIR=${HOME}/.config/zsh
for file in ${CONFIG_DIR}/*; do
  if [[ -f ${file} ]]; then
    source ${file}
  fi
done

