export UD_English
module UD_English

    using DataDeps
    using ..MLDatasets
    using ..datafile
    using ..download_dep

    export

        traindata,
        testdata,

        download

    const DEPNAME = "UD_English"
    const TRAINFILE = "en-ud-train.conllu"
    const DEVFILE   = "en-ud-dev.conllu"
    const TESTFILE  = "en-ud-test.conllu"

    download(args...; kw...) = download_dep(DEPNAME, args...; kw...)

    traindata(; dir = nothing) = traindata(dir)
    devdata(; dir = nothing)   = devdata(dir)
    testdata(; dir = nothing)  = testdata(dir)

    traindata(dir) = readdata(dir, TRAINFILE)
    devdata(dir)   = readdata(dir, DEVFILE)
    testdata(dir)  = readdata(dir, TESTFILE)

    function readdata(dir, filename)
        path = datafile(DEPNAME, filename, dir)
        CoNLL.read(path)
    end

    function __init__()
        register(DataDep(
            DEPNAME,
            """
            Dataset: Universal Dependencies - English Dependency Treebank Universal Dependencies English Web Treebank
            Authors: Natalia Silveira and Timothy Dozat and
                     Marie-Catherine de Marneffe and Samuel
                     Bowman and Miriam Connor and John Bauer and
                     Christopher D. Manning
            Website: https://github.com/UniversalDependencies/UD_English

            A Gold Standard Universal Dependencies Corpus for
            English, built over the source material of the
            English Web Treebank LDC2012T13
            (https://catalog.ldc.upenn.edu/LDC2012T13).

            You are encouraged to cite this paper if you use the
            Universal Dependencies English Web Treebank:

                @inproceedings{silveira14gold,
                    year = {2014},
                    author = {Natalia Silveira and Timothy Dozat
                        and Marie-Catherine de Marneffe and Samuel
                        Bowman and Miriam Connor and John Bauer and
                        Christopher D. Manning},
                    title = {A Gold Standard Dependency Corpus for {E}nglish},
                    booktitle = {Proceedings of the Ninth
                        International Conference on Language Resources
                        and Evaluation (LREC-2014)}
                }

            The files are available for download at the github
            repository linked above. Note that using the data
            responsibly and respecting copyright remains your
            responsibility. Copyright and License is discussed in
            detail on the Website.
            """,
            "https://raw.githubusercontent.com/UniversalDependencies/UD_English/master/" .* [TRAINFILE, DEVFILE, TESTFILE],
            "2311e260488453d5ba170cfd94e58ac4bd536263ea9545c7b25f0804e87b28a2",
        ))
    end
end
