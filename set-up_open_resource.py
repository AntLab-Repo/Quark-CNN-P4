p4 = bfrt.two_pipe

p4.pipea.SwitchIngress_a.quanti_tbl.clear()
p4.pipea.SwitchIngress_a.quanti_tbl_2.clear()
p4.pipea.SwitchIngress_a.quanti_tbl_l4.clear()
p4.pipea.SwitchIngress_a.quanti_tbl_l5.clear()
p4.pipea.SwitchIngress_a.weight_tbl.clear()
p4.pipea.SwitchIngress_a.add_wei_l1_tbl.clear()
p4.pipea.SwitchIngress_a.get_level_1_tbl.clear()
p4.pipea.SwitchIngress_a.get_level_2_tbl.clear()
p4.pipea.SwitchIngress_a.get_level_3_tbl.clear()
p4.pipea.SwitchIngress_a.get_level_5_tbl.clear()
p4.pipea.SwitchIngress_a.add_multi_l1_tbl.clear()
p4.pipea.SwitchIngress_a.add_multi_l5_tbl.clear()
p4.pipea.SwitchIngress_a.add_multi_tbl.clear()
p4.pipea.SwitchIngress_a.multi_tbl_1.clear()
p4.pipea.SwitchIngress_a.multi_tbl_2.clear()
p4.pipea.SwitchIngress_a.maxpooling_tbl.clear()
p4.pipea.SwitchIngress_a.compare_ret_tbl.clear()
p4.pipea.SwitchIngress_a.bias_tbl.clear()

# You should fill in your model’s weights and biases at the ‘?’ position
# p4.pipea.SwitchIngress_a.weight_tbl.add_with_weight_act(level = ?, channel_index = ?, w1 = ? , w2 = ? , w3 = ?, w4 = ?)
# p4.pipea.SwitchIngress_a.bias_tbl.add_with_bias_act(level = ?, channel_index = ?, w1 = ?)

p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ab_1(result_index = 1, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ab_2(result_index = 1, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ab_3(result_index = 1, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ab_4(result_index = 1, channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_cd_1(result_index = 2, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_cd_2(result_index = 2, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_cd_3(result_index = 2, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_cd_4(result_index = 2, channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ef_1(result_index = 3, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ef_2(result_index = 3, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ef_3(result_index = 3, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_ef_4(result_index = 3, channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_gh_1(result_index = 4, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_gh_2(result_index = 4, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_gh_3(result_index = 4, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_1_tbl.add_with_write_gh_4(result_index = 4, channel_index = 4)

p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_abcd_1(result_index = 1, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_abcd_2(result_index = 1, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_abcd_3(result_index = 1, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_abcd_4(result_index = 1, channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_ab_1(result_index = 2, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_ab_2(result_index = 2, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_ab_3(result_index = 2, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_2_tbl.add_with_write_ab_4(result_index = 2, channel_index = 4)

p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_cd_1(level = 3, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_cd_2(level = 3, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_cd_3(level = 3, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_cd_4(level = 3, channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_ab_1(level = 4, channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_ab_2(level = 4, channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_ab_3(level = 4, channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_3_tbl.add_with_write_ab_4(level = 4, channel_index = 4)

p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_cd_1(channel_index = 1)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_cd_2(channel_index = 2)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_cd_3(channel_index = 3)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_cd_4(channel_index = 4)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_ef_1(channel_index = 5)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_ef_2(channel_index = 6)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_ef_3(channel_index = 7)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_ef_4(channel_index = 8)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_gh_1(channel_index = 9)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_gh_2(channel_index = 10)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_gh_3(channel_index = 11)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_gh_4(channel_index = 12)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_abcd_1(channel_index = 13)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_abcd_2(channel_index = 14)
p4.pipea.SwitchIngress_a.get_level_5_tbl.add_with_write_abcd_3(channel_index = 15)

p4.pipea.SwitchIngress_a.add_wei_l1_tbl.add_with_add_wei_action_l1_1(channel_index = 1)
p4.pipea.SwitchIngress_a.add_wei_l1_tbl.add_with_add_wei_action_l1_2(channel_index = 2)
p4.pipea.SwitchIngress_a.add_wei_l1_tbl.add_with_add_wei_action_l1_3(channel_index = 3)
p4.pipea.SwitchIngress_a.add_wei_l1_tbl.add_with_add_wei_action_l1_4(channel_index = 4)

p4.pipea.SwitchIngress_a.add_multi_l1_tbl.add_with_add_multi_action_l1_1(result_index = 1)
p4.pipea.SwitchIngress_a.add_multi_l1_tbl.add_with_add_multi_action_l1_2(result_index = 2)
p4.pipea.SwitchIngress_a.add_multi_l1_tbl.add_with_add_multi_action_l1_3(result_index = 3)
p4.pipea.SwitchIngress_a.add_multi_l1_tbl.add_with_add_multi_action_l1_4(result_index = 4)

p4.pipea.SwitchIngress_a.add_multi_l5_tbl.add_with_add_multi_action_l4_1(level = 4, conv2_flag = 0)
p4.pipea.SwitchIngress_a.add_multi_l5_tbl.add_with_add_multi_action_l4_2(level = 4, conv2_flag = 2)
p4.pipea.SwitchIngress_a.add_multi_l5_tbl.add_with_add_multi_action_l5_1(level = 5, conv2_flag = 0)
p4.pipea.SwitchIngress_a.add_multi_l5_tbl.add_with_add_multi_action_l5_2(level = 5, conv2_flag = 2)

p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_abcd_1(level = 2, result_index = 1, conv2_flag = 0)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_abcd_2(level = 2, result_index = 1, conv2_flag = 1)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_abcd_3(level = 2, result_index = 1, conv2_flag = 2)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_abcd_4(level = 2, result_index = 1, conv2_flag = 3)

p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_efgh_1(level = 2, result_index = 2, conv2_flag = 0)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_efgh_2(level = 2, result_index = 2, conv2_flag = 1)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_efgh_3(level = 2, result_index = 2, conv2_flag = 2)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_efgh_4(level = 2, result_index = 2, conv2_flag = 3)

p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_ababcd_1(level = 3, result_index = 1, conv2_flag = 0)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_ababcd_2(level = 3, result_index = 1, conv2_flag = 1)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_ababcd_3(level = 3, result_index = 1, conv2_flag = 2)
p4.pipea.SwitchIngress_a.add_multi_tbl.add_with_add_multi_action_ababcd_4(level = 3, result_index = 1, conv2_flag = 3)


for i in range(-128,128):
    for j in range(-128,128):
        tmp = i*j
        j_d = j
        i_d = i
        tmp_d = tmp
        if(j < 0):
            j_d = j + 256
        if(i < 0):
            i_d = i + 256
        if(tmp < 0):
            tmp_d = tmp + 65536
        p4.pipea.SwitchIngress_a.multi_tbl_1.add_with_multi_act_1(multi_m1 = i_d, multi_m2 = j_d, w_quan = tmp_d)
        p4.pipea.SwitchIngress_a.multi_tbl_2.add_with_multi_act_2(multi_m1 = i_d, multi_m3 = j_d, w_quan = tmp_d)

for i in range(128):
    for j in range(i):
        p4.pipea.SwitchIngress_a.maxpooling_tbl.add_with_smaller(quan_ovar_1 = j, quan_ovar_2 = i)
        p4.pipea.SwitchIngress_a.compare_ret_tbl.add_with_ret_greater(quan_temp_1 = i, maxnum = j)

def multiply_and_clip_with_constant(M):
    result = []
    for res in range(-128, 128):
        res_t = res + 0.5
        val = res_t / M
        val = int(val)
        result.append(val)
    result.append(32767)
    return result

M_1 = ?
M_2 = ?
M_3 = ?
M_4 = ?
M_5 = ?

result = multiply_and_clip_with_constant(M_1)
print(result)
for i in range(1,len(result)): 
    for j in range(result[i-1]+1, result[i]+1):
        j_d = j 
        if(j < 0):
            j_d = j + 65536
        p4.pipea.SwitchIngress_a.quanti_tbl.add_with_quanti_act(o_var1 = j_d,level = 1, w_quan=(i - 128))  
        p4.pipea.SwitchIngress_a.quanti_tbl_2.add_with_quanti_act_2(o_var2 = j_d,level = 1, w_quan=(i - 128))  
        
result = multiply_and_clip_with_constant(M_2)
print(result)
for i in range(1,len(result)): 
    for j in range(result[i-1]+1, result[i]+1):
        j_d = j 
        if(j < 0):
            j_d = j + 65536     
        p4.pipea.SwitchIngress_a.quanti_tbl.add_with_quanti_act(o_var1 = j_d,level = 2, w_quan = (i - 128))  
        p4.pipea.SwitchIngress_a.quanti_tbl_2.add_with_quanti_act_2(o_var2 = j_d,level = 2, w_quan = (i - 128))  
        
result = multiply_and_clip_with_constant(M_3)
print(result)
for i in range(1,len(result)): 
    for j in range(result[i-1]+1, result[i]+1):
        j_d = j 
        if(j < 0):
            j_d = j + 65536     
        p4.pipea.SwitchIngress_a.quanti_tbl.add_with_quanti_act(o_var1 = j_d,level = 3, w_quan = (i - 128))  
        p4.pipea.SwitchIngress_a.quanti_tbl_2.add_with_quanti_act_2(o_var2 = j_d,level = 3, w_quan = (i - 128))  

bias_41 = ?
bias_42 = ?
bias_43 = ?
bias_44 = ?

bias_51 = ?
bias_52 = ?
bias_53 = ?
bias_54 = ?

def multiply_and_clip_with_constant_with_bias(M, bias):  
    result = []  
    for res in range(-128, 128):
        res_t = res + 0.5
        val = res_t / M - bias 
        val = int(val) 
        result.append(val)
    result.append(32767) 
    return result 

#   
result1 = multiply_and_clip_with_constant_with_bias(M_4, bias_41)  
result2 = multiply_and_clip_with_constant_with_bias(M_4, bias_42)  
result3 = multiply_and_clip_with_constant_with_bias(M_4, bias_43)  
result4 = multiply_and_clip_with_constant_with_bias(M_4, bias_44)  

count = 0
for i in range(1, len(result1)):  
    for j in range(result1[i - 1] + 1, result1[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l4.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 1, w_quan = (i - 128))  


for i in range(1, len(result2)):  
    for j in range(result2[i - 1] + 1, result2[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l4.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 2, w_quan = (i - 128)) 

for i in range(1, len(result3)):  
    for j in range(result3[i - 1] + 1, result3[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l4.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 3, w_quan = (i - 128))  

for i in range(1, len(result4)):  
    for j in range(result4[i - 1] + 1, result4[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l4.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 4, w_quan = (i - 128))   

result1 = multiply_and_clip_with_constant_with_bias(M_5, bias_51)  
result2 = multiply_and_clip_with_constant_with_bias(M_5, bias_52)  
result3 = multiply_and_clip_with_constant_with_bias(M_5, bias_53)  
result4 = multiply_and_clip_with_constant_with_bias(M_5, bias_54)  

for i in range(1, len(result1)):  
    for j in range(result1[i - 1] + 1, result1[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l5.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 1, w_quan = (i - 128)) 

for i in range(1, len(result2)):  
    for j in range(result2[i - 1] + 1, result2[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l5.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 2, w_quan = (i - 128)) 

for i in range(1, len(result3)):  
    for j in range(result3[i - 1] + 1, result3[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l5.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 3, w_quan = (i - 128)) 

for i in range(1, len(result4)):  
    for j in range(result4[i - 1] + 1, result4[i] + 1):  
        j_d = j  
        if j < 0:  
            j_d = j + 65536  
        p4.pipea.SwitchIngress_a.quanti_tbl_l5.add_with_quanti_act_l4(o_var1 = j_d,channel_index = 4, w_quan = (i - 128)) 

print(count)  
