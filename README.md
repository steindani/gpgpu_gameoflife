# Game of Life using OpenCL
The well known game of Conway as a homework assignment for the GPGPU course at Budapest University of Technology and Economics, 2016.

## Dependencies and Compilation
The game was developed and run on Arch Linux, with CMake, OpenGL and OpenCL preinstalled.

```
pacman -S ocl-icd opencl-headers opencl-nvidia libtinfo-5
```

For Intel processors the `intel-opencl-runtime` from AUR is also required.

To compile and run the program, install CMake and navigate to the root directory:

```
pacman -S cmake
cd gpgpu_gameoflife
mkdir bin
cd bin
cmake ..
./gpgpu_gameoflife
```

## Usage
After starting the application, a white playfield is present. At this point the game reacts to the following user input:

 * `W` `A` `S` `D` keys move the playfield in four directions.
 * `Q` and `E` keys zoom in and out, while `0` resets zoom to 1.
 * Drag-n-drop movements with the mouse also move the field.
 * Any other key input makes the field step one.

## Legend
 * Newborn cells are completely white.
 * As cells age, they become darker.
 * Dying cells are bright red.
 * Long dead cells fade away.
