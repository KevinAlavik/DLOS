import std.stdio;
import sandboxd; // Import the sandboxd module

void main() {
    string rootPath = "./DLOS";

    sandboxd.Sandbox sandbox = new sandboxd.Sandbox(rootPath);

}
