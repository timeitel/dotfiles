# @param $1 - The filename to symlink.
# @param $2 - The target directory to symlink.
create_symlink () {
  FILE_NAME=$1
  TARGET_DIRECTORY=$2
  TARGET_FILE_PATH=$TARGET_DIRECTORY/$FILE_NAME

  # check if file exists and is a symlink
  if [ -L $TARGET_FILE_PATH ] ; then
     if [ -e $TARGET_FILE_PATH ] ; then
        echo "Valid existing symlink for $FILE_NAME"
     else
        echo "Broken existing symlink for $FILE_NAME"
     fi
    rm $TARGET_FILE_PATH
    ln -s $PWD/$FILE_NAME $TARGET_DIRECTORY
    echo "Re-created symlink, new link: $TARGET_FILE_PATH -> $PWD/$FILE_NAME"
  elif [ -e TARGET_FILE_PATH ] ; then
    echo "$FILE_NAME exists in $TARGET_DIRECTORY but not as a symlink"
  else
    ln -s $PWD/$FILE_NAME $TARGET_DIRECTORY
    echo "Created symlink: $TARGET_FILE_PATH -> $PWD/$FILE_NAME"
  fi
}
# TODO: bug where file already exists without symlink, doesn't get symlinked / recreated

# include hidden files
shopt -s dotglob

cd home
echo "\nSymlinking to ~\n"

for FILE in *;
do
  create_symlink $FILE ~
done

cd ../xdg_config
echo "\nSymlinking to ~/.config\n"

for FILE in *;
do
  create_symlink $FILE ~/.config
done

