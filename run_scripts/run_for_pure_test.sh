#!/bin/bash

#SBATCH --job-name=just_test
#SBATCH --partition=2080ti
#SBATCH -N 1
#SBATCH --mem=12G
#SBATCH --gres=gpu:1
#SBATCH --output=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/test-%x.o
#SBATCH --error=/mnt/lustre/sjtu/home/cfh77/remote/KG-S2S/outlog/test-%x.e

python3 main.py -dataset 'FB15k-237N' \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -pretrained_model 'models/pretrained_model/t5-base' \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -model_path './checkpoint/FB15k-237N-2023-03-19 13:54:00.990368/FB15k-237Nepoch=019-val_mrr=0.0009.ckpt' \
                -use_prefix_search