 docker run -it --rm ^
    -v "%cd%\packer":/workspace --workdir=/workspace ^
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins ^
    -e AWS_ACCESS_KEY_ID="%AWS_ACCESS_KEY_ID%" ^
    -e AWS_SECRET_ACCESS_KEY="%AWS_SECRET_ACCESS_KEY%" ^
    hashicorp/packer:latest ^
    init .

 docker run -it --rm ^
    -v "%cd%\packer":/workspace --workdir=/workspace ^
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins ^
    -e AWS_ACCESS_KEY_ID="%AWS_ACCESS_KEY_ID%" ^
    -e AWS_SECRET_ACCESS_KEY="%AWS_SECRET_ACCESS_KEY%" ^
    hashicorp/packer:latest ^
    build .