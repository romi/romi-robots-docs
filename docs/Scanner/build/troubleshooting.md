# Troubleshooting

## Serial access denied
If you get an error about permission access:

1. Check in what group you are with:
    ```bash
    groups ${USER}
    ```

2. If you are not in `dialout`:
    ```bash
    sudo gpasswd --add ${USER} dialout
    ```

3. Then log out and back in to see changes!