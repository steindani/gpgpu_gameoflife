/* -*- mode: c++ -*- */

__kernel
void tick(int width, int height, __global unsigned char *from, __global unsigned char *to) {
    int gid = get_global_id(0);
    if (gid <= width * height) {

        int x = gid % width;
        int y = gid / width;

        // y values are pre-multiplied, x and y values are multiplied by 4 and alpha (3) offset is added to x

        int x0 = (x == 0 ? width - 1 : x - 1) * 4 + 3;
        int x1 = x * 4 + 3;
        int x2 = ((x + 1) == width ? 0 : x + 1) * 4 + 3;

        int y0 = (y == 0 ? height - 1 : y - 1) * width * 4;
        int y1 = y * width * 4;
        int y2 = ((y + 1) == height ? 0 : y + 1) * width * 4;

        int neighbours = from[y0 + x0] / 255 + from[y0 + x1] / 255 + from[y0 + x2] / 255 +
                         from[y1 + x0] / 255 + from[y1 + x2] / 255 +
                         from[y2 + x0] / 255 + from[y2 + x1] / 255 + from[y2 + x2] / 255;

        int prevR = from[y1 + x1 - 3];
        int prevA = from[y1 + x1];
        bool alive = (neighbours == 3 || (neighbours == 2 && prevA == 255));

        // coloring
        // idea from: http://www.marekfiser.com/Projects/Conways-Game-of-Life-on-GPU-using-CUDA/5-Display#5-3-Texture-post-processing
        // if just born -> 255
        // else if alive get older
        // else fade red
        to[y1 + x1 - 3] = alive ? (prevA == 255 ? 10 + prevR * 0.90f : 255) : prevA * 0.90f; // R
        to[y1 + x1 - 2] = alive ? (prevA == 255 ? 10 + prevR * 0.90f : 255) : prevA * 0.45f; // G
        to[y1 + x1 - 1] = alive ? (prevA == 255 ? 10 + prevR * 0.90f : 255) : prevA * 0.45f; // B
        to[y1 + x1] = alive ? 255 : prevA * 0.75f; // A
    }
}
