# ESPNet-KorEduEng

# ESPnet 기반 음성인식 최적화 프로젝트

## Project Summary
- Following are results of a study on the "Convergence and Open Sharing System" Project, supported by the Ministry of Education and National Research Foundation of Korea
- This project aims to optimize a speech recognition model using ESPnet, improving performance based on the Librispeech, KorEduEng, and Gravo datasets.
- We fine-tuned the LibriSpeech pretrained model with the KorEduEng dataset and applied beam search optimization, data augmentation, and hyperparameter tuning, reducing the Word Error Rate (WER) from 34.0% to 4.3%.
- This document provides a detailed explanation of the step-by-step model improvement process and performance enhancement techniques.


## Project Summary
- 본 과제(결과물)는 교육부와 한국연구재단의 재원으로 지원을 받아 수행된 첨단분야 혁신융합대학사업의 연구결과입니다
- 이 프로젝트는 ESPnet을 활용한 음성 인식 모델 최적화를 목표로 하며, Librispeech, KorEduEng, Gravo 데이터셋을 기반으로 성능을 개선하였습니다.
- 우리는 LibriSpeech 사전 학습 모델을 KorEduEng 데이터셋으로 Fine-Tuning하고, 빔 서치(Beam Search) 최적화, 데이터 증강, 하이퍼파라미터 튜닝을 적용하여 WER(단어 오류율)을 34.0%에서 4.3%로 감소시켰습니다.
- 이 문서는 단계별 모델 개선 과정과 성능 향상 기법을 상세히 설명합니다.

## 성능 개선 과정

| Step | Model | WER (%) | Explain |
|-----------------|-----------------------|------|-------------------------------------------------|
| Baseline        | LibriSpeech Pretrained| 33.7 | KorEduEng 데이터에서 직접 테스트 (Zero-shot)|
| Fine-Tuning 1-0 | KorEduEng Fine-Tuning | 16.1 | KorEduEng 데이터셋으로 Fine-Tuning |
| Fine-Tuning 1-1 | KorEduEng Fine-Tuning | 8.0 | KorEduEng 데이터셋으로 Fine-Tuning & Parmeter tuning|
| Fine-Tuning 1-2 | KorEduEng Fine-Tuning | 7.9 | KorEduEng 데이터셋으로 Fine-Tuning & Parmeter tuning|
| Fine-Tuning 2   | 최적화된 KorEduEng 모델  | 5.3 | 모델 구조 조정 및 학습 최적화 |
| Final model     | Hugging Face 기반 모델  | 4.3 | 사전학습된 강력한 모델 활용 및 Fine-Tuning |



## Environments
- date: `Sun Jan 26 23:19:13 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
  - Commit date: `Tue Feb 6 02:46:40 2024 +0000`  
- ASR config: [conf/train_asr_conformer.yaml](conf/train_asr_conformer.yaml) 
- Decode config: [conf/decode_asr.yaml](conf/decode_asr.yaml) 
- Pretrained model: [https://huggingface.co/espnet/librispeech_multiblank_transducer_8421](https://huggingface.co/espnet/librispeech_multiblank_transducer_8421) 

## TARGET : LibriSpeech WER
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000(LibriSpeech -> LibriSpeech Test) (NO TARGET, JUST BASELINE)  
### Epoch LM : 20, AM : 30 , Beamsize 60
### Environments
- date: `Sun Jan 21 17:00:15 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config: [conf/train_asr_conformer.yaml](conf/train_asr_conformer.yaml)
- Decode config: [conf/decode_asr.yaml](conf/decode_asr.yaml)
- Pretrained model: [https://huggingface.co/espnet/librispeech_multiblank_transducer_8421](https://huggingface.co/espnet/librispeech_multiblank_transducer_8421)

### WER 

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Errl
|decode_asr_asr_model_valid.acc.ave/test_clean|2620|52576|97.5|2.3|0.2|0.3|2.9|32.81
|decode_asr_asr_model_valid.acc.ave/test_other|2939|52343|93.9|5.5|0.6|0.7|6.8|52.71

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_asr_model_valid.acc.ave/test_clean|2620|281530|99.3|0.4|0.3|0.3|0.9|32.8|
|decode_asr_asr_model_valid.acc.ave/test_other|2939|272758|97.9|1.2|0.9|0.8|2.9|52.7|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_asr_model_valid.acc.ave/test_clean|2620|65818|96.8|2.2|1.0|0.4|3.5|32.8|
|decode_asr_asr_model_valid.acc.ave/test_other|2939|65101|92.7|5.2|2.1|0.9|8.2|52.7|

## TARGET : KorEduEng WER
## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 33.7))
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000 (LibriSpeech -> KorEduEng Test) BASELINE (WER 33.7)
### Epoch LM : 20, AM : 30 , Beamsize 60
### Environments
- date: `Sun Jan 21 17:00:15 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex2/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`

### WER 

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Errl
|decode_asr_asr_model_valid.acc.ave/test1|5692|151728|72.9|22.5|4.6|6.5|33.7|88.6|


## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 16.1))
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000 (LibriSpeech -> KorEduEng Test) BASELINE (WER 16.1)
### Epoch LM : 20 →90 , AM : 30 → 38 WER(16.1) , Beamsize : 60 -> 27
### Environments
- date: `Thu Jan 23 03:49:40 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex2/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`


## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp
### WER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|151729|85.5|8.5|6.0|1.6|16.1|54.9|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|828121|89.7|2.3|8.0|1.4|11.7|54.9|
### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|186919|84.8|7.6|7.6|2.3|17.5|54.9|


## TARGET : KorEduEng WER
## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 8.0))
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp (WRONG TEST FILE FIX ver1) (WER 8.0)
### Epoch LM : 90 → 150, AM : 38 → 55 WER(8.0) , Beamsize : 27
### Environments
- date: `Thu Jan 23 17:47:42 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`

### WER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|151729|93.6|4.9|1.5|1.6|8.0|28.5|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|828121|96.4|1.5|2.0|1.5|5.1|28.5|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|186919|92.9|4.4|2.7|1.9|9.0|28.5|


## TARGET : KorEduEng WER
## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 7.9))
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp (WER 7.9)
### LM weight : 0.6 -> 0.8 Beasize : 27 -> 60, WRONG TEST FILE TEXT FIX ver1
### Environments
- date: `Thu Jan 23 17:47:42 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`

### WER (test1 -> testFix.example) 

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave.250124_00/test1Fix.example|5692|151729|93.6|4.8|1.7|1.4|7.9|29.1|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|151729|93.6|4.8|1.7|1.4|7.9|29.1|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave.250124_00/test1Fix.example|5692|828121|96.3|1.5|2.2|1.4|5.1|29.1|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|828121|96.3|1.5|2.2|1.4|5.1|29.1|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave.250124_00/test1Fix.example|5692|186919|92.9|4.2|2.9|1.8|8.9|29.1|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|186919|92.9|4.2|2.9|1.8|8.9|29.1|


## TARGET : KorEduEng WER
## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver2 (WER 5.3))
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp  
## Epoch LM : 120 -> 250, ASR : 55 -> 80 , specaug 수정 (x3 → x5), freq mask range 확장
## Environments
- date: `Sun Jan 26 23:19:13 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`

### WER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|ver3_maxepoch/test1Fix.example|5692|151911|95.6|3.6|0.9|0.9|5.3|26.5|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|ver3_maxepoch/test1Fix.example|5692|829099|97.8|1.0|1.2|0.9|3.1|26.5|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|ver3_maxepoch/test1Fix.example|5692|187118|94.7|3.0|2.2|1.0|6.3|26.5|


## TARGET : KorEduEng WER
## LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver2 (WER 5.3))
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp  
## Epoch LM : 120 -> 250, ASR : 55 -> 80 , specaug 수정 (x3 → x5), freq mask range 확장
## Environments
- date: `Fri Jan 31 05:09:39 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:
- Decode config:
- Pretrained model: `exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`(https://github.com/espnet/espnet/tree/master/egs2/grabo/asr1)

## exp_ex4_finetun/asr_train_asr_conformer_raw_en_bpe5000_sp
### WER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|151962|96.3|3.0|0.7|0.6|4.3|23.8|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|829379|98.3|0.8|0.9|0.7|2.4|23.8|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example|5692|187150|95.8|2.5|1.6|0.7|4.8|23.8|

