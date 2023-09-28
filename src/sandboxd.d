module sandboxd;

import std.file;
import std.path;
import std.stdio;
import std.exception;

class Directory {
    private string name;
    private string path;

    this(string name, string path) {
        this.name = name;
        this.path = path;
        sandboxd_createDirectory(buildPath(path, name));
    }

    void sandboxd_createFile(string filename, string content) {
        string filePath = buildPath(path, name, filename);
        try {
            sandboxd_write(filePath, content);
        } catch (Exception e) {
            writeln("Error creating file: ", e.msg);
        }
    }

    void sandboxd_createSubdirectory(string dirname) {
        string subDirPath = buildPath(path, name, dirname);
        try {
            sandboxd_createDirectory(subDirPath);
        } catch (Exception e) {
            writeln("Error creating subdirectory: ", e.msg);
        }
    }
}

class Sandbox {
    private string rootPath;

    this(string rootPath) {
        this.rootPath = rootPath;
        sandboxd_createDirectory(rootPath);
    }

    Directory sandboxd_createDirectory(string dirname) {
        return new Directory(dirname, rootPath);
    }
}

void sandboxd_write(string filePath, string content) {
    try {
        std.file.write(filePath, content);
    } catch (Exception e) {
        writeln("Error writing to file: ", e.msg);
    }
}

void sandboxd_createDirectory(string dirname) {
    try {
        std.file.mkdir(dirname);
    } catch (Exception e) {
        writeln("Error creating directory: ", e.msg);
    }
}
