#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ ${cuda_compiler_version} != "None" ]]; then
    export FORCE_CUDA="1"
    # https://github.com/conda-forge/conda-forge.github.io/issues/1901
    if [[ ${cuda_compiler_version} == 11.8 ]]; then
        export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9+PTX"
    elif [[ ${cuda_compiler_version} == 12.0 ]]; then
        export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0+PTX"
    else
        echo "Unsupported CUDA version ${cuda_compiler_version}"
        exit 1
    fi
fi
$PYTHON -m pip install ./mask2former/modeling/pixel_decoder/ops/
$PYTHON -m pip install . --no-deps
