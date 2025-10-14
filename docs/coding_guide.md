# Coding Guide

This document describes some general rules and gives a guide on how to structure the code for this project. As a base please make use of the Godot best practices. For a more indepth guide please take a look at [Godot best practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/introduction_best_practices.html).

## VS Code Config

Add the following to the vs code config and make sure to use tabs.

```
"[gdscript]": {
        "editor.detectIndentation": true,
        "editor.insertSpaces": false,
},
```

## Naming

| Member       | Casing     |
| ------------ | ---------- |
| Folder names | snake_case |
| File names   | snake_case |
| Class names  | PascalCase |
| Node names   | PascalCase |

## Sandbox Scenes Testing

Inside the same folder of the scene place another scene with the suffix "sandbox" like "main_sandbox.tscn" to test it in isolation. Make sure to include as little references to other scenes than the one being tested to keep refactoring changes to a minimum.

