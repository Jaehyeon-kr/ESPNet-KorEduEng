#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="trainFix.example"
valid_set="devFix.example"
test_sets="test1Fix.example"
expdir="exp_ex2"
asr_tag="train_asr_conformer_raw_en_bpe5000"
asr_config=conf/train_asr_conformer.yaml
lm_config=conf/tuning/train_lm_transformer2.yaml
inference_config=conf/decode_asr.yaml
./asr.sh \
    --expdir ${expdir} \
    --asr_tag ${asr_tag} \
    --use_lm false \
    --lang en \
    --ngpu 4 \
    --nbpe 5000 \
    --gpu_inference true \
    --skip_stages "1 " \
    --skip_train true \
    --max_wav_duration 30 \
    --asr_config "${asr_config}" \
    --lm_config "${lm_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    "$@"

