**Describe the bug**
<!-- A clear and concise description of what the bug is.  -->

In a highly customized setup (details of the setup are shown later), Starting the `tedge-mapper c8y` triggers multiple `te/device/main///cmd/software_list` commands on startup, 29 **software_list** commands were created within 1 second.

For example, the following topics were created:

```sh
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.893595279Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.894731237Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.895986612Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.897403279Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.898662695Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.899841445Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.900913403Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.901975486Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.903152694Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.904377861Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.905543861Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.906903694Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.90813136Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.909227068Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.910274943Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.911272818Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.912283985Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.913332985Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.914694693Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.916071984Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.917349984Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.918492192Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.919662234Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.920877775Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.922001275Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.923084441Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.924247525Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.925334524Z
te/device/main///cmd/software_list/c8y-mapper-2024-06-19T18:06:24.926390358Z
```

**Note** the bug has been observed in a highly customized environment, and it is currently unclear what is the root cause of the error:

* The rootfs is read-only except for, `/data`, `/tmp` and `/run` partitions
* tedge is installed under a custom location:
    * binaries are stored under `/data/bin`
    * tedge configuration is stored under `/data/etc/tedge`
* tedge components are started manually and run under the **root** user (as the tedge user does not exist, and can't be added)
* nanomq is used for the local MQTT broker
* the tedge-mapper is used with the built-in mapper function enabled


**To Reproduce**
<!-- Steps to reproduce the behavior. The more detail you add here, the better we can reproduce the bug. -->

The following requires following repository, [debug-readonly-setup](https://github.com/thin-edge/debug-readonly-setup) as there are a lot of customizations:

It also currently relies on a `aarch64/arm64` host to run the example (though once the example is better understood, an system test case can be created).

1. Start up the docker container

    ```sh
    just up
    ```

2. Open a shell in the container, and configure the

    ```sh
    just shell
    ./entrypoint.sh
    ```

    You should follow the on-screen instructions to then upload the device certificate

3. Start the custom MQTT broker

    ```sh
    ./bin/nanomq start
    ```

4. Open a new shell

    ```sh
    just shell
    ```

5. Start both the tedge-mapper and tedge-agent processes (not this is starting wrappers)

    ```sh
    source ./entrypoint.sh
    tedge_agent &
    tedge_mapper_c8y &
    ```

**Expected behavior**
<!-- A clear and concise description of what you expected to happen. -->

**Screenshots**
<!-- If applicable, add screenshots to help explain your problem. -->

**Environment (please complete the following information):**
 - OS [incl. version]
 - Hardware [incl. revision]
 - System-Architecture [e.g. result of "uname -a"]
 - thin-edge.io version [e.g. 0.1.0]

**Additional context**
<!-- Add any other context about the problem here. -->
