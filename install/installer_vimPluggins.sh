#!/bin/sh
#ycm
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --clang-completer

#color Coded
# cd ~/.vim/bundle/color_coded
# mkdir build && cd build
# cmake ..
# make && make install # Compiling with GCC is preferred, ironically
# # Clang works on OS X, but has mixed success on Linux and the BSDs

# # Cleanup afterward; frees several hundred megabytes
# make clean && make clean_clang
#etc
