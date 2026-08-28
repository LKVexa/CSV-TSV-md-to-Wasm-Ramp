# TabFlow Pixel One-Click 1.1.0 — equal parts

Download these three files into the same folder:

1. `TabFlow-Pixel-One-Click-1.1.0-equal-part-01.tfp`
2. `TabFlow-Pixel-One-Click-1.1.0-equal-part-02.tfp`
3. `TabFlow-Pixel-One-Click-1.1.0-assemble-and-compile.cmd`

Both `.tfp` package parts are exactly **22,616,092 bytes**, or **21.568 MiB**. They are byte-for-byte equal in size and remain below the requested 24 MiB limit.

Run `TabFlow-Pixel-One-Click-1.1.0-assemble-and-compile.cmd`. It will:

1. verify both part sizes and SHA-256 hashes;
2. concatenate them in the correct order;
3. verify the complete package hash;
4. extract the Apache-2.0 source, NOTICE, and pre-existing Pixel components; and
5. run the packaged `compile-one-click.cmd` compiler.

The finished executable will be written to:

```text
TabFlow-1.1.0-build\
  TabFlow-Pixel-One-Click-1.1.0\
    dist\
      TabFlow-Pixel-Virtual-Program-One-Click-1.1.0.exe
```

If Windows reports a legacy path-length error, place the three downloaded files in a short folder such as `C:\TabFlowBuild` and run the command again.

Hashes:

```text
Part 01
5ab7427d41fb5ecf3175f8b4d1fbd1e5b6a5822675dba16619a87eaf55bd2a75

Part 02
65587a78d07acb41c1fb187056556ade334b52d517e406da5a5a550973bd50b1

Reassembled package
24bca69865b9274dfa271b00e840717172dd2114b2dec4c220930cb5fecdcf34
```
