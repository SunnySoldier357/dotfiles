echo "~~~~~ Sandeep's C++ Project Generator ~~~~~"

mkdir .vscode
cd .vscode/

tee tasks.json <<-EOF
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build",
            "type": "shell",
            "command": "g++",
            "args": [
                "main.cpp",
                "-o",
                "main"
            ]
        },
        {
            "label": "run",
            "type": "shell",
            "command": "./main"
        },
        {
            "label": "build and run",
            "type": "shell",
            "command": "g++",
            "args": [
                "main.cpp",
                "-o",
                "main",
                "&&",
                "./main"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        },
    ]
}
EOF

cd ..
tee main.cpp <<-EOF
#include <iostream>

int main(int argc, char* const argv[])
{
    std::cout << "Hello World" << std::endl;

    return 0;
}
EOF

echo "Successfully created a new C++ project!"