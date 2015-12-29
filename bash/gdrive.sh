# site: https://github.com/astrada/google-drive-ocamlfuse

.gdrive.mount() {
    google-drive-ocamlfuse ~/gdrive/
}

.gdrive.unmount() {
    fusermount -u ~/gdrive/
}

.gdrive.backup() {
    if [ ! "ls -A ~/gdrive" ]; then
        .gdrive.mount
        # TODO: wait when gdrive will be mounted
        sleep 3
    fi

    cp ~/*.txt ~/gdrive/
    cp ~/.bashrc_spi ~/gdrive/_bashrc_spi
}
