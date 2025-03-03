# ESPNet-KorEduEng

## Project Summary
- The following results are from a study conducted as part of the "Convergence and Open Sharing System" Project, supported by the Ministry of Education and the National Research Foundation of Korea.
- This project was awarded the grand prize (prize money: 3,000,000 KRW) at the 2024 Winter AI SCI Bootcamp, hosted by the AI Innovation Convergence University Project.
- The project aims to optimize a speech recognition model using ESPnet, enhancing its performance on the Librispeech, KorEduEng, and Gravo datasets.
- We fine-tuned the LibriSpeech pretrained model on the KorEduEng dataset and applied beam search optimization, data augmentation, and hyperparameter tuning, reducing the Word Error Rate (WER) from 34.0% to 4.3%.
- This document provides a detailed explanation of the step-by-step model improvement process and the performance enhancement techniques applied.

## 프로젝트 요약
- 본 연구(결과물)는 교육부와 한국연구재단의 지원을 받아 수행된 첨단분야 혁신융합대학사업의 일환으로 진행된 연구 결과입니다.
- 본 프로젝트는 인공지능혁신융합대학사업단 주최의 2024 동계 인공지능 SCI 부트캠프에서 대상(상금 300만원)을 수상하였으며, ESPnet을 활용한 음성 인식 모델 최적화를 목표로 진행되었습니다.
- 본 연구는 Librispeech, KorEduEng, Gravo 데이터셋을 기반으로 음성 인식 모델의 성능을 향상시켰습니다.
- LibriSpeech 사전 학습 모델을 KorEduEng 데이터셋으로 Fine-Tuning한 후, 빔 서치 최적화, 데이터 증강, 하이퍼파라미터 튜닝을 적용하여 단어 오류율(WER)을 34.0%에서 4.3%로 대폭 감소시켰습니다.
- 이 문서는 단계별 모델 개선 과정과 성능 향상 기법을 상세히 설명합니다.


## Advance

| Step         | Model                      |  WER  | Explanation                                             |
|---|---|---|---|
| Baseline     | LibriSpeech Pretrained     | 33.7  | Zero-shot evaluation on the KorEduEng dataset           |
| Fine-Tuning1 | KorEduEng Fine-Tuning      | 16.1  | Fine-tuning on the KorEduEng dataset                    |
| Fine-Tuning2 | KorEduEng Fine-Tuning      | 8.0   | Fine-tuning with parameter tuning (variant 2)           |
| Fine-Tuning3 | KorEduEng Fine-Tuning      | 7.9   | Fine-tuning with parameter tuning (variant 3)           |
| Fine-Tuning4 | Optimized KorEduEng Model  | 5.3   | Architecture adjustments & training optimizations       |
| Final Model  | Hugging Face-based Model   | 4.3   | Fine-tuning using a powerful Hugging Face pretrained model|


## LibriSpeech Pretrained
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000
- (LibriSpeech -> LibriSpeech Test) (NO TARGET, JUST BASELINE)  
- Epoch LM : 20, AM : 30 , Beamsize 60
### Environments
- date: `Sun Jan 21 17:00:15 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config: [conf/train_asr_conformer.yaml](conf/train_asr_conformer.yaml)
- Decode config: [conf/decode_asr.yaml](conf/decode_asr.yaml)


### WER 

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
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

## Baseline
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000 
- (LibriSpeech -> KorEduEng Test) BASELINE (WER 33.7)
- Epoch LM : 20, AM : 30 , Beamsize 60
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

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|decode_asr_asr_model_valid.acc.ave/test1|5692|151728|72.9|22.5|4.6|6.5|33.7|88.6|

## Fine-Tuning 1
## exp_ex1/asr_train_asr_conformer_raw_en_bpe5000
- LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 16.1))
- (LibriSpeech -> KorEduEng Test) BASELINE (WER 16.1)
- Epoch LM : 20 →90 , AM : 30 → 38 WER(16.1) , Beamsize : 60 -> 27
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
- decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/test1Fix.example
### WER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|151729|85.5|8.5|6.0|1.6|16.1|54.9|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|828121|89.7|2.3|8.0|1.4|11.7|54.9|
### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|186919|84.8|7.6|7.6|2.3|17.5|54.9|


## Fine-Tuning 2
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp
- LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 8.0))
- (WRONG TEST FILE FIX ver1) (WER 8.0)
- Epoch LM : 90 → 150, AM : 38 → 55 WER(8.0) , Beamsize : 27
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
- decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave
|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|151729|93.6|4.9|1.5|1.6|8.0|28.5|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|828121|96.4|1.5|2.0|1.5|5.1|28.5|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|186919|92.9|4.4|2.7|1.9|9.0|28.5|


## Fine-Tuning 3
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp (WER 7.9)
- LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver1 (WER 7.9))
- LM weight : 0.6 -> 0.8 Beamsize : 27 -> 60
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
- decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave.250124_00/test1Fix.example 

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|151729|93.6|4.8|1.7|1.4|7.9|29.1|

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|828121|96.3|1.5|2.2|1.4|5.1|29.1|

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example|5692|186919|92.9|4.2|2.9|1.8|8.9|29.1|


## Fine-Tuning 4
## exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp  
- LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver2 (WER 5.3))
- Epoch LM : 120 -> 250, ASR : 55 -> 80 , 'specaug' (x3 → x5), 'freq mask range' expansion
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
- ver3_maxepoch/test1Fix.example
|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
| test1Fix.example | 5692 | 151911| 95.6 | 3.6 | 0.9 | 0.9 | 5.3 | 26.5  |

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
| test1Fix.example | 5692 | 829099 | 97.8 | 1.0 | 1.2 | 0.9 | 3.1 | 26.5  |

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
| test1Fix.example | 5692 | 187118 | 94.7 | 3.0 | 2.2 | 1.0 | 6.3 | 26.5  |



## Final model
## exp_ex4_finetun/asr_train_asr_conformer_raw_en_bpe5000_sp
- LibriSpeech -> KorEduEng Test (WRONG TEST FILE TEXT FIX ver2 (WER 5.3))
- Epoch LM : 120 -> 250, ASR : 55 -> 80 , 'specaug' (x3 → x5), 'freq mask range' expansion
## Environments
- date: `Fri Jan 31 05:09:39 KST 2025`
- python version: `3.8.20 (default, Oct  3 2024, 15:24:27)  [GCC 11.2.0]`
- espnet version: `espnet 202402`
- pytorch version: `pytorch 2.1.0`
- Git hash: `6ddbdf3fd5ab113f2849104812df6e93a236130a`
- ASR config:  [conf/train_asr_conformer.yaml](conf/train_asr_conformer.yaml)
- Decode config:
- Pretrained model: `exp_ex3/asr_train_asr_conformer_raw_en_bpe5000_sp/valid.acc.ave_10best.pth`
 `https://github.com/espnet/espnet/tree/master/egs2/grabo/asr1`(https://github.com/espnet/espnet/tree/master/egs2/grabo/asr1)

## exp_ex4_finetun/asr_train_asr_conformer_raw_en_bpe5000_sp
### WER
-decode_asr_lm_lm_train_lm_transformer2_en_bpe5000_valid.loss.ave_asr_model_valid.acc.ave/
|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example | 5692 | 151962 | 96.3 | 3.0 | 0.7 | 0.6 | 4.3 | 23.8  |

### CER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example | 5692 | 829379 | 98.3 | 0.8 | 0.9 | 0.7 | 2.4 | 23.8  |

### TER

|dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err|
|---|---|---|---|---|---|---|---|---|
|test1Fix.example | 5692 | 187150 | 95.8 | 2.5 | 1.6 | 0.7 | 4.8 | 23.8  |
