#!/bin/bash

#SBATCH --job-name=FB15k-237N-t5-base-epoch-20-02281623-last-test
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
                -model_path './checkpoint/FB15k-237N-2023-02-28 16:23:36.697135/last.ckpt' \
                -use_prefix_search

python3 main.py -dataset 'FB15k-237N' \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -pretrained_model 'models/pretrained_model/t5-base' \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -model_path './checkpoint/FB15k-237N-2023-02-28 16:23:36.697135/FB15k-237Nepoch=012-val_mrr=0.2937.ckpt' \
                -use_prefix_search