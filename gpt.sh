#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="trainFix.example" # trainFix.example 
valid_set="devFix.example" # devFix.example
test_sets="test1Fix.example" #"test1Fix.example"
expdir="exp_ex4_finetun"
asr_tag="train_asr_conformer_raw_en_bpe5000_sp"
lm_tag="train_lm_transformer2_en_bpe5000"
asr_config=conf/train_asr_conformer.yaml
lm_config=conf/tuning/train_lm_transformer2.yaml
inference_config=conf/decode_asr.yaml
pretrained_model="exp_ex4_finetun/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.best.pth"

# 추가: 디코딩 시 사용할 ASR 모델 지정
inference_asr_model="exp_ex4_finetun/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.best.pth"

skip_stages="1 "

./asr.sh \
    --expdir ${expdir} \
    --asr_tag ${asr_tag} \
    --use_lm true \
    --gpu_inference true \
    --lm_tag ${lm_tag} \
    --lang en \
    --ngpu 1 \
    --nbpe 5000 \
    --pretrained_model $pretrained_model \
    --skip_stages "$skip_stages" \
    --max_wav_duration 60 \
    --asr_config "${asr_config}" \
    --lm_config "${lm_config}" \
    --speed_perturb_factors "0.9 0.95 1.0 1.05 1.1" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --ignore_init_mismatch true \
    --inference_asr_model "${inference_asr_model}" \  # 추가됨
    "$@"
