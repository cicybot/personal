
Run Electron in ubuntu headless

    sudo apt-get install xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps
    sudo apt install libgconf-2-4

    sudo npm install electron
    sudo apt-get install libasound2
    xvfb-run electron .

Run code inside a hidden Electron window

- https://github.com/mappum/electron-eval