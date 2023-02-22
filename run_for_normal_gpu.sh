dataset_name="FB15k-237N"
model_name="t5-base"
current=`date "+%Y-%m-%d-%H-%M-%S"`
out_file="./outlog/KGS2S-$dataset_name-$model_name-$current.log"

nohup python3 main.py -dataset $dataset_name \
                -pretrained_model $model_name\
                -lr 0.001 \
                -epoch 50 \
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