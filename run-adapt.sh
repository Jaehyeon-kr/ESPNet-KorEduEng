#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="trainFix.example" # trainFix.example 
valid_set="devFix.example" # devFix.example
test_sets="test1Fix.example" #"test1Fix.example"
expdir="exp_ex3"
asr_tag="train_asr_conformer_raw_en_bpe5000_sp"
lm_tag="train_lm_transformer2_en_bpe5000"
asr_config=conf/train_asr_conformer.yaml
lm_config=conf/tuning/train_lm_transformer2.yaml
inference_config=conf/decode_asr.yasml
pretrained_model="exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth"
skip_stages="1 "

./asr.sh \
    --expdir ${expdir} \
    --asr_tag ${asr_tag} \
    --use_lm true \
    --gpu_inference true \
    --lm_tag ${lm_tag} \
    --lang en \
    --ngpu 4 \
    --nbpe 5000 \
    --pretrained_model $pretrained_model \
    --skip_stages "$skip_stages" \
    --max_wav_duration 60 \
    --asr_config "${asr_config}" \
    --lm_config "${lm_config}" \
    --speed_perturb_factors "0.85 0.9 0.95 1.0 1.05 1.1 1.15" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --inference_tag ver4 \
    --ignore_init_mismatch true \
    "$@"

