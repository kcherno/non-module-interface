# non-module-interface

This script is designed to automate the process of converting C++ modules into header files. It takes a C++ module input file, a header file name, and optionally a custom guard name for the header file. If the guard name is not specified, the script will use the #pragma Once directive instead.

## Usage

To use the script, simply call it from the command line and pass the required arguments:

```
non-module-interface.sh module header [guard name]
```

## Error Handling

If the script encounters any lines that could not be processed (for example, you have imported some section of a module), it will print those lines to the console along with the corresponding line numbers. This allows you to easily identify and replace raw strings.
