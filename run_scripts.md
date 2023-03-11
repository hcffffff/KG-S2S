## run for train
slrum 提交任务

SBATCH 中的选项每次需要修改 job-name 中的数据集/backbone/epochs数量/运行时间，下面的也要修改。

python参数中需要注意

1. dataset和pretrained_model在shell参数中修改，
2. batch_size 过大会导致显存爆炸。。
3. skip_n_val_epoch 适当小于 epoch，表示前 n 个epoch不执行val步骤，如果此项大于 epoch 会导致不会保存任何模型，因为设置的评价标准是 val_mrr。只会保存最后一个模型。

```bash
#!/bin/bash

#SBATCH --job-name=FB15k-237N-t5-base-epoch-20-02271054
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
                -batch_size 8 \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -seq_dropout 0.2 \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -skip_n_val_epoch 12
```


非 slurm 提交任务
```bash
dataset_name="FB15k-237N"
model_name="t5-small"
current=`date "+%Y-%m-%d-%H-%M-%S"`
out_file="./outlog/KGS2S-$dataset_name-$model_name-$current.log"

nohup python3 main.py -dataset $dataset_name \
                -lr 0.001 \
                -epoch 1 \
                -pretrained_model "models/pretrained_model/$model_name/"\
                -batch_size 16 \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -seq_dropout 0.2 \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -skip_n_val_epoch 30 > $out_file 2>&1 &
```


## run for test

需要与训练shell同步数据集、length、pretrian_model(small/base)、等选项，更改的部分为model_path参数中的路劲

```bash
python3 main.py -dataset 'FB15k-237N' \
                -src_descrip_max_length 80 \
                -tgt_descrip_max_length 80 \
                -pretrained_model 'models/pretrained_model/t5-base' \
                -use_soft_prompt \
                -use_rel_prompt_emb \
                -num_beams 40 \
                -eval_tgt_max_length 30 \
                -model_path './checkpoint/{folder}/{checkpoint}.ckpt' \
                -use_prefix_search  
```


