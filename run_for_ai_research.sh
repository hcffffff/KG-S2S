#!/bin/bash

#SBATCH --job-name=FB15k-237N-t5-base-0221
#SBATCH --partition=gpu
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --mail-type=all
#SBATCH --mail-user=nafoabehumble@sjtu.edu.cn
#SBATCH --output=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.o
#SBATCH --error=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/KGS2S-%x.e

dataset_name="FB15k-237N"
model_name="t5-base"
# current=`date "+%Y-%m-%d-%H-%M-%S"`
# out_file="./outlog/$dataset_name-$model_name-$current.log"

python3 main.py -dataset $dataset_name \
                -pretrained_model $model_name\
                -lr 0.001 \
                -epoch 20 \
                -pretrained_model "models/pretrained_model/$model_name/"\
                -batch_size 8 \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -seq_dropout 0.2 \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -skip_n_val_epoch 30