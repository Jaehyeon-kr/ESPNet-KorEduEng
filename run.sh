#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train"
valid_set="dev"
test_sets="test1"
expdir="exp_ex3"

asr_tag="train_asr_conformer_raw_en_bpe5000_sp"
asr_config=conf/train_asr_conformer.yaml
lm_config=conf/tuning/train_lm_transformer2.yaml
inference_config=conf/decode_asr.yaml


./asr.sh \
    --ignore_init_mismatch true\
    --pretrained_model "exp_ex3/lm_train_lm_transformer2_en_bpe5000/checkpoint.pth" \
    --use_lm true\
    --skip_stages "7 8 9" \
    --lang en \
    --expdir ${expdir} \
    --ngpu 3 \
    --nbpe 5000 \
    --max_wav_duration 30 \
    --speed_perturb_factors "0.9 1.0 1.1" \
    --asr_config "${asr_config}" \
    --lm_config "${lm_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --lm_train_text "data/${train_set}/text data/local/other_text/text" \
    --bpe_train_text "data/${train_set}/text" "$@"
