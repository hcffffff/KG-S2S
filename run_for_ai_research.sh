#!/bin/bash

#SBATCH --job-name=FB15k-237N-t5-base-pure-model-epoch-20-03191350
#SBATCH --partition=2080ti
#SBATCH -N 1
#SBATCH --mem=12G
#SBATCH --gres=gpu:1
#SBATCH --output=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.o
#SBATCH --error=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.e

dataset_name="FB15k-237N"
model_name="t5-base"

python3 main.py -dataset $dataset_name \
                -pretrained_model $model_name \
                -lr 0.001 \
                -epoch 20 \
                -pretrained_model "models/pretrained_model/$model_name/" \
                -batch_size 4 \
                -val_batch_size 2 \
                -src_max_length 256 \
                -src_descrip_max_length 128 \
                -tgt_descrip_max_length 0 \
                -seq_dropout 0.2 \
                -num_beams 40 \
                -eval_tgt_max_length 32 \
                -skip_n_val_epoch 12
                -use_prefix_search