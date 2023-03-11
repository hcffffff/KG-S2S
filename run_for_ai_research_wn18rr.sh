#!/bin/bash

#SBATCH --job-name=WN18RR-t5-base-epoch-20-03021222
#SBATCH --partition=2080ti
#SBATCH -N 1
#SBATCH --mem=32G
#SBATCH --gres=gpu:1
#SBATCH --output=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.o
#SBATCH --error=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.e

dataset_name="WN18RR"
model_name="t5-base"

python3 main.py -dataset $dataset_name \
                -pretrained_model $model_name \
                -epoch 20 \
                -pretrained_model "models/pretrained_model/$model_name/" \
                -batch_size 4 \
                -val_batch_size 2 \
                -src_descrip_max_length 40 \
                -tgt_descrip_max_length 10 \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -seq_dropout 0.1 \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -skip_n_val_epoch 15 \