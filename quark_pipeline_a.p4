/* -*- P4_16 -*- */ 
#include <core.p4>
#if __TARGET_TOFINO__ == 2
#include <t2na.p4>
#else
#include <tna.p4>
#endif
#include "common/util.p4"
#include "common/headers.p4"

#define REGISTER_SIZE 1;

const bit<32> FLOW_ENTRIES = 1024;
const bit<32> IAT_limit = 32w9155273;

#define ADD_WEI_ACTION(x)\
    action add_wei_action_l1_##x(){multi_m1 = o_wei##x;}

#define ADD_MULTI_ACTION(x)\
    action add_multi_action_abcd_##x(){multi_m1 = o_wei##x; multi_m2 = hdr.hdr_metadata.ab_##x; multi_m3 = hdr.hdr_metadata.cd_##x;}\
    action add_multi_action_efgh_##x(){multi_m1 = o_wei##x; multi_m2 = hdr.hdr_metadata.ef_##x; multi_m3 = hdr.hdr_metadata.gh_##x;}\
    action add_multi_action_ababcd_##x(){multi_m1 = o_wei##x; multi_m2 = hdr.hdr_metadata.abcd_##x; multi_m3 = hdr.hdr_metadata.ab_##x;}

#define WRITE_RET_ACTION(x)\
    action write_ab_##x(){hdr.hdr_metadata.ab_##x = hdr.hdr_metadata.quan_temp_1;}\
    action write_cd_##x(){hdr.hdr_metadata.cd_##x = hdr.hdr_metadata.quan_temp_1;}\
    action write_ef_##x(){hdr.hdr_metadata.ef_##x = hdr.hdr_metadata.quan_temp_1;}\
    action write_gh_##x(){hdr.hdr_metadata.gh_##x = hdr.hdr_metadata.quan_temp_1;}\
    action write_abcd_##x(){hdr.hdr_metadata.abcd_##x = hdr.hdr_metadata.quan_temp_1;}




struct metadata_t {

}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/
parser SwitchIngressParser_a(
        packet_in pkt,
        out header_t hdr,
        out metadata_t ig_md,
        out ingress_intrinsic_metadata_t ig_intr_md) {
        
    TofinoIngressParser() tofino_parser;
    
    state start {
        tofino_parser.apply(pkt, ig_intr_md);
        transition parse_ethernet;
    }

    state parse_ethernet {
        pkt.extract(hdr.ethernet);
        transition select(hdr.ethernet.ether_type) {
            ETHERTYPE_IPV4: parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        transition select(hdr.ipv4.protocol){
            IP_PROTOCOLS_TCP: parse_tcp;
            //IP_PROTOCOLS_UDP: parse_udp;
            default: accept;
        }
    }

    // state parse_udp {
    //    pkt.extract(hdr.udp);
    //    transition accept;
    // }

    state parse_tcp {
       pkt.extract(hdr.tcp);
       transition parse_meta;
    }

    state parse_meta {
        pkt.extract(hdr.hdr_metadata);
        transition accept;

    }
}
/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/
/*
control MyVerifyChecksum(inout headers hdr, inout metadata meta) {   
    apply {  }
}
*/

/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/
control SwitchIngress_a(
        inout header_t hdr,
        inout metadata_t ig_md,
        in ingress_intrinsic_metadata_t ig_intr_md,
        in ingress_intrinsic_metadata_from_parser_t ig_prsr_md,
        inout ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md,
        inout ingress_intrinsic_metadata_for_tm_t ig_tm_md) {    
    
    int<8> multi_m1 = 0;
    int<8> multi_m2 = 0;    
    int<8> multi_m3 = 0;
    int<8> multi_m4 = 0;
    int<8> qi_zeropoint = 0;
    int<8> qo_zeropoint = 0;

    int<16> t_0 = 0;
    int<16> t_1 = 0;

    int<16> o_var1 = 0;
    int<16> o_var2 = 0;

    bit<2> multi_flag = 0;

    int<8> o_wei1 = 0;
    int<8> o_wei2 = 0;
    int<8> o_wei3 = 0;
    int<8> o_wei4 = 0;

    int<8> quan_ovar_1 = 0;
    int<8> quan_ovar_2 = 0;

    int<16> bias = 0;

    // maxpooling_tbl performs the maxpooling operations for the convolutional layers
    action greater(){ hdr.hdr_metadata.quan_temp_1 = quan_ovar_1; }
    action smaller(){ hdr.hdr_metadata.quan_temp_1 = quan_ovar_2; }
    table maxpooling_tbl{
        key = {
            quan_ovar_1 : exact;
            quan_ovar_2 : exact;
        }
        actions = {
            greater;
            smaller;
            NoAction;
        }
        default_action = greater;
        size = 10000;
    }

    // compare_ret_tbl performs argmax to retrieve the index and maximum element
    action ret_greater(){
        hdr.hdr_metadata.maxnum = hdr.hdr_metadata.quan_temp_1;
        hdr.hdr_metadata.result_index = hdr.hdr_metadata.channel_index;
    }
    table compare_ret_tbl{
        key = {
            hdr.hdr_metadata.quan_temp_1 : exact;
            hdr.hdr_metadata.maxnum : exact;
        }
        actions = {
            ret_greater;
            NoAction;
        }
        default_action = NoAction;
        size = 10000;
    }

    // weight_tbl stores the weights of CNN
    action weight_act(int<8> w1, int<8> w2, int<8> w3, int<8> w4) {
        o_wei1 = w1;
        o_wei2 = w2;
        o_wei3 = w3;
        o_wei4 = w4;
    }
    table weight_tbl{
        key = {
            hdr.hdr_metadata.level : exact;    
            hdr.hdr_metadata.channel_index : exact;
        }
        actions = {
            weight_act;
            NoAction;
        }
        default_action = NoAction;
        size = 32;
    }

    // bias_tbl stores the biases of CNN
    action bias_act(int<16> w1) { bias = w1;}
    table bias_tbl{
        key = {
            hdr.hdr_metadata.level : exact;  
            hdr.hdr_metadata.channel_index : exact; 
        }
        actions = {
            bias_act;
            NoAction;
        }
        default_action = NoAction;
        size = 32;
    }

    // quanti_tbl and quanti_tbl_2 performs the (iv) quantization of convolutional layers
    action quanti_act(int<8> w_quan){ quan_ovar_1 = w_quan; }
    action quanti_default_act(){ quan_ovar_1 = -128; }
    table quanti_tbl{
        key = {
            o_var1: exact;
            hdr.hdr_metadata.level: exact;
        }
        actions = {
            quanti_act;
            quanti_default_act;
            NoAction;
        }
        size = 150000;
        default_action = quanti_default_act;
    }

    action quanti_act_2(int<8> w_quan){ quan_ovar_2 = w_quan; }
    table quanti_tbl_2{
        key = {
            o_var2: exact;
            hdr.hdr_metadata.level:exact;
        }
        actions = {
            quanti_act_2;
            quanti_default_act;
            NoAction;
        }
        size = 150000;
        default_action = quanti_default_act;
    }

    // quanti_tbl_l4 and quanti_tbl_l5 performs the (iv) quantization of fully connnected layers
    action quanti_act_l4(int<8> w_quan){ quan_ovar_1 = w_quan; }
    table quanti_tbl_l4{
        key = {
            o_var1: exact;
            hdr.hdr_metadata.channel_index : exact;
        }
        actions = {
            quanti_act_l4;
            quanti_default_act;
            NoAction;
        }
        size = 155000;
        default_action = quanti_default_act;
    }
    table quanti_tbl_l5{
        key = {
            o_var1: exact;
            hdr.hdr_metadata.channel_index : exact;
        }
        actions = {
            quanti_act_l4;
            quanti_default_act;
            NoAction;
        }
        size = 155000;
        default_action = quanti_default_act;
    }

    // get_level_1_tbl, get_level_2_tbl, get_level_3_tbl and get_level_5_tbl performs the (vii) storage
    WRITE_RET_ACTION(1)
    WRITE_RET_ACTION(2)
    WRITE_RET_ACTION(3)
    WRITE_RET_ACTION(4)
    table get_level_1_tbl{
        key = {
            hdr.hdr_metadata.result_index: exact;
            hdr.hdr_metadata.channel_index: exact;
        }
        actions = {
            write_ab_1;  write_ab_2;  write_ab_3;  write_ab_4;  
            write_cd_1;  write_cd_2;  write_cd_3;  write_cd_4;  
            write_ef_1;  write_ef_2;  write_ef_3;  write_ef_4;  
            write_gh_1;  write_gh_2;  write_gh_3;  write_gh_4;  NoAction;
        }
        size = 16;
        default_action = NoAction;
    }

    table get_level_2_tbl{
        key = {
            hdr.hdr_metadata.result_index: exact;
            hdr.hdr_metadata.channel_index: exact;
        }
        actions = {
            write_ab_1;  write_ab_2;  write_ab_3;  write_ab_4;  
            write_abcd_1;  write_abcd_2;  write_abcd_3;  write_abcd_4;  NoAction;
        }
        size = 16;
        default_action = NoAction;
    }

    table get_level_3_tbl{
        key = {
            hdr.hdr_metadata.level: exact;
            hdr.hdr_metadata.channel_index: exact;
        }
        actions = {
            write_cd_1;  write_cd_2;  write_cd_3;  write_cd_4;  
            write_ab_1;  write_ab_2;  write_ab_3;  write_ab_4;  NoAction;
        }
        size = 16;
        default_action = NoAction;
    }

    table get_level_5_tbl{
        key = {
            hdr.hdr_metadata.channel_index: exact;
        }
        actions = {
            write_cd_1;  write_cd_2;  write_cd_3;  write_cd_4;  
            write_ef_1;  write_ef_2;  write_ef_3;  write_ef_4;  
            write_gh_1;  write_gh_2;  write_gh_3;  write_gh_4;  
            write_abcd_1;  write_abcd_2;  write_abcd_3;  write_abcd_4;  NoAction;
        }
        size = 16;
        default_action = NoAction;
    }

    // add_multi_tbl Assists in controlling the weights and features for computations in current convolutional unit
    ADD_MULTI_ACTION(1)
    ADD_MULTI_ACTION(2)
    ADD_MULTI_ACTION(3)
    ADD_MULTI_ACTION(4)    
    table add_multi_tbl{
        key = {
            hdr.hdr_metadata.level: exact;
            hdr.hdr_metadata.result_index: exact;
            hdr.hdr_metadata.conv2_flag: exact;
        }
        actions = {
            add_multi_action_abcd_1;  add_multi_action_abcd_2;  add_multi_action_abcd_3;  add_multi_action_abcd_4;
            add_multi_action_efgh_1;  add_multi_action_efgh_2;  add_multi_action_efgh_3;  add_multi_action_efgh_4;
            add_multi_action_ababcd_1;  add_multi_action_ababcd_2;  add_multi_action_ababcd_3;  add_multi_action_ababcd_4;  NoAction;
        }
        size = 16;
        default_action = NoAction;
    }

    // add_multi_l1_tbl Assists in controlling the weights and features for computations in first unit layer
    action add_multi_action_l1_1(){multi_m2 = (int<8>)hdr.ipv4.diffserv; multi_m3 = (int<8>)hdr.ipv4.ttl;}    
    action add_multi_action_l1_2(){multi_m2 = hdr.hdr_metadata.gh_4; multi_m3 = hdr.hdr_metadata.abcd_1;}    
    action add_multi_action_l1_3(){multi_m2 = hdr.hdr_metadata.abcd_2; multi_m3 = hdr.hdr_metadata.abcd_3;}    
    action add_multi_action_l1_4(){multi_m2 = hdr.hdr_metadata.abcd_4; multi_m3 = hdr.hdr_metadata.maxnum;}
    table add_multi_l1_tbl{
        key = {
            hdr.hdr_metadata.result_index: exact;
        }
        actions = {
            add_multi_action_l1_1;
            add_multi_action_l1_2;
            add_multi_action_l1_3;
            add_multi_action_l1_4;
            NoAction;
        }
        size = 8;
        default_action = NoAction;
    }

    // add_multi_l1_tbl Assists in controlling the weights and features for computations in current fully connected unit
    action add_multi_action_l4_1(){ multi_m1 = o_wei1; multi_m2 = hdr.hdr_metadata.cd_1; multi_m4 = o_wei2; multi_m3 = hdr.hdr_metadata.cd_2;}
    action add_multi_action_l4_2(){ multi_m1 = o_wei3; multi_m2 = hdr.hdr_metadata.cd_3; multi_m4 = o_wei4; multi_m3 = hdr.hdr_metadata.cd_4;}
    action add_multi_action_l5_1(){ multi_m1 = o_wei1; multi_m2 = hdr.hdr_metadata.ab_1; multi_m4 = o_wei2; multi_m3 = hdr.hdr_metadata.ab_2;}
    action add_multi_action_l5_2(){ multi_m1 = o_wei3; multi_m2 = hdr.hdr_metadata.ab_3; multi_m4 = o_wei4; multi_m3 = hdr.hdr_metadata.ab_4;}
    table add_multi_l5_tbl{
        key = {
            hdr.hdr_metadata.level: exact;
            hdr.hdr_metadata.conv2_flag: exact;
        }
        actions = {
            add_multi_action_l4_1;
            add_multi_action_l4_2;
            add_multi_action_l5_1;
            add_multi_action_l5_2;
            NoAction;
        }
        size = 8;
        default_action = NoAction;
    }

    ADD_WEI_ACTION(1)
    ADD_WEI_ACTION(2)
    ADD_WEI_ACTION(3)
    ADD_WEI_ACTION(4)
    table add_wei_l1_tbl{
        key = {
            hdr.hdr_metadata.channel_index: exact;
        }
        actions = {
            add_wei_action_l1_1;
            add_wei_action_l1_2;
            add_wei_action_l1_3;
            add_wei_action_l1_4;
            NoAction;
        }
        size = 8;
        default_action = NoAction;
    }

    // multi_tbl_1 and multi_tbl_2 performs the (iii) multiplication operation
    action multi_act_1(int<16> w_quan){ t_0 = w_quan; }
    table multi_tbl_1{
        key = {
            multi_m1: exact;
            multi_m2: exact;
        }
        actions = {
            multi_act_1;
            NoAction;
        }
        size = 65536;
        default_action = NoAction;
    }
    action multi_act_2(int<16> w_quan){ t_1 = w_quan; }
    table multi_tbl_2{
        key = {
            multi_m1: exact;
            multi_m3: exact;
        }
        actions = {
            multi_act_2;
            NoAction;
        }
        size = 65536;
        default_action = NoAction;
    }

    apply{

        ig_tm_md.ucast_egress_port = 65;
        /****************************************************************************************
        ******************* (ii) Retrive the weights and biases from the MATs *******************
        *****************************************************************************************/
        bias_tbl.apply();
        weight_tbl.apply();
        if(ig_intr_md.ingress_port == 68){
            ig_tm_md.ucast_egress_port = 68;
            hdr.hdr_metadata.recirculate = hdr.hdr_metadata.recirculate - 1;
            if(hdr.hdr_metadata.recirculate == 1){
                // Reach the recirculate limit, should be forward or drop
                hdr.ethernet.dst_addr = ig_intr_md.ingress_mac_tstamp;
                ig_tm_md.ucast_egress_port = 65;
            }
            /****************************************************************************************
            ************************* (i) Retrive the inputs from the header ************************
            *****************************************************************************************/
            if(hdr.hdr_metadata.level == 1){ 
                // The first CAP-UNit level of CNN
                add_multi_l1_tbl.apply();
                add_wei_l1_tbl.apply();
                multi_m2 = multi_m2 - qi_zeropoint;
                multi_m3 = multi_m3 - qi_zeropoint;
                hdr.hdr_metadata.ab_temp = 0;
                hdr.hdr_metadata.cd_temp = 0;
            }else if(hdr.hdr_metadata.level <= 3){
                // The remaining CAP-UNit levels of convolutional levels
                add_multi_tbl.apply();
                if(hdr.hdr_metadata.conv2_flag == 0){
                    hdr.hdr_metadata.ab_temp = 0;
                    hdr.hdr_metadata.cd_temp = 0;
                }
                hdr.hdr_metadata.conv2_flag = hdr.hdr_metadata.conv2_flag + 1;  
            }else if(hdr.hdr_metadata.level <= 5){
                // The fully connected CAP-Unit layers of CNN
                add_multi_l5_tbl.apply();
                if(hdr.hdr_metadata.conv2_flag == 0){
                    hdr.hdr_metadata.ab_temp = 0;
                    hdr.hdr_metadata.cd_temp = 0;
                }
                hdr.hdr_metadata.conv2_flag = hdr.hdr_metadata.conv2_flag + 2;
            }else{
                // CNN inference is completed.
                // hdr.hdr_metadata.result_index is the inference result
                // Operations that need to be performed on the inference results can be executed here...
            }
            
            /*****************************************************************************************
            ** (iii) Computing two sets of features and storing the accumulated convolution results **
            ******************************************************************************************/
            multi_tbl_1.apply();
            hdr.hdr_metadata.ab_temp = hdr.hdr_metadata.ab_temp + t_0;
            if(hdr.hdr_metadata.level >= 4){
                multi_m1 = multi_m4;
            }
            multi_tbl_2.apply();
            hdr.hdr_metadata.cd_temp = hdr.hdr_metadata.cd_temp + t_1;
            
            // When all channels have been accumulated, proceed with steps (iv)~(vii)
            if(hdr.hdr_metadata.conv2_flag == 4){
                hdr.hdr_metadata.conv2_flag = 0;

                /****************************************************************************************
                ***************************** (iv) Quantize accumulation results ************************
                *****************************************************************************************/
                if(hdr.hdr_metadata.level < 4){
                    o_var1 = hdr.hdr_metadata.ab_temp + bias;
                    o_var2 = hdr.hdr_metadata.cd_temp + bias;

                    quanti_tbl.apply();
                    quanti_tbl_2.apply();

                    /****************************************************************************************
                    ************************************* (v) ReLU module ***********************************
                    *****************************************************************************************/
                    if(quan_ovar_1 < 0){
                        quan_ovar_1 = 0;
                    }
                    if(quan_ovar_2 < 0){
                        quan_ovar_2 = 0;
                    }

                    /****************************************************************************************
                    ********************************* (vi) Maxpooling module ********************************
                    *****************************************************************************************/
                    maxpooling_tbl.apply();
                }else if(hdr.hdr_metadata.level == 4){
                    // Fully connected layers 1
                    /****************************************************************************************
                    ******************************** (iv)~(v) Quantize and ReLU *****************************
                    *****************************************************************************************/
                    o_var1 = hdr.hdr_metadata.ab_temp + hdr.hdr_metadata.cd_temp; 
                    quanti_tbl_l4.apply();
                    if(quan_ovar_1 < 0){
                        quan_ovar_1 = 0;
                    }
                    hdr.hdr_metadata.quan_temp_1 = quan_ovar_1;
                }else{
                    // Fully connected layers 2
                    /****************************************************************************************
                    ******************************** (iv)~(v) Quantize and ReLU *****************************
                    *****************************************************************************************/
                    o_var1 = hdr.hdr_metadata.ab_temp + hdr.hdr_metadata.cd_temp; 
                    quanti_tbl_l5.apply();
                    if(quan_ovar_1 < 0){
                        quan_ovar_1 = 0;
                    }
                    hdr.hdr_metadata.quan_temp_1 = quan_ovar_1;
                }
        
                /****************************************************************************************
                ************************************* (iv) Storage outputs ******************************
                *****************************************************************************************/
                if(hdr.hdr_metadata.level == 1){
                    get_level_1_tbl.apply();
                    hdr.hdr_metadata.conv2_flag = 4;
                    if(hdr.hdr_metadata.channel_index == 4){
                        hdr.hdr_metadata.channel_index = 0;
                        hdr.hdr_metadata.result_index = hdr.hdr_metadata.result_index + 1;
                        if(hdr.hdr_metadata.result_index == 5){
                            hdr.hdr_metadata.result_index = 1;
                            hdr.hdr_metadata.level = 2;
                            hdr.hdr_metadata.conv2_flag = 0;
                        }
                    }
                }else if(hdr.hdr_metadata.level == 2){
                    get_level_2_tbl.apply();
                    if(hdr.hdr_metadata.channel_index == 4){
                        hdr.hdr_metadata.channel_index = 0;
                        hdr.hdr_metadata.result_index = hdr.hdr_metadata.result_index + 1;
                        if(hdr.hdr_metadata.result_index == 3){
                            hdr.hdr_metadata.result_index = 1;
                            hdr.hdr_metadata.level = 3;
                        }
                    }
                }else if(hdr.hdr_metadata.level <= 4){
                    get_level_3_tbl.apply();
                    if(hdr.hdr_metadata.channel_index == 4){
                        hdr.hdr_metadata.channel_index = 0;
                        hdr.hdr_metadata.level = hdr.hdr_metadata.level + 1;
                        hdr.hdr_metadata.maxnum = 0;
                    }                    
                }else if(hdr.hdr_metadata.level == 5){
                    // compare_ret_tbl performs argmax to retrieve the index and maximum element
                    // the index will be stored in hdr.hdr_metadata.result_index
                    // the maximum output will be stored in hdr.hdr_metadata.maxnum
                    compare_ret_tbl.apply();
                    get_level_5_tbl.apply();
                    if(hdr.hdr_metadata.channel_index == 15){
                        hdr.hdr_metadata.channel_index = 0;
                        hdr.hdr_metadata.level = 6;    
                        hdr.hdr_metadata.recirculate = 1;  
                        ig_tm_md.ucast_egress_port = 65;   
                        hdr.ethernet.dst_addr = ig_intr_md.ingress_mac_tstamp;
                    }                    
                }
                hdr.hdr_metadata.channel_index = hdr.hdr_metadata.channel_index + 1;
            }
        }else{
            /****************************************************************************************
            **************************** Initialize the control parameters **************************
            *****************************************************************************************/
            hdr.hdr_metadata.level = 1;
            hdr.hdr_metadata.channel_index = 1;
            hdr.hdr_metadata.conv2_flag = 4;
            hdr.hdr_metadata.result_index = 1;
            hdr.hdr_metadata.recirculate = 105;
            
            hdr.ethernet.src_addr = ig_intr_md.ingress_mac_tstamp;
            ig_tm_md.ucast_egress_port = 68;
        }        
        ig_tm_md.bypass_egress = (bit<1>)true;
    }
}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/
/*
control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}
*/

control SwitchIngressDeparser_a(
        packet_out pkt,
        inout header_t hdr,
        in metadata_t ig_md,
        in ingress_intrinsic_metadata_for_deparser_t ig_intr_dprsr_md) {
        
    apply {
        pkt.emit(hdr);
    }
}

// ---------------------------------------------------------------------------
// Egress parser
// ---------------------------------------------------------------------------

parser SwitchEgressParser_a(
        packet_in pkt,
        out header_t hdr,
        out metadata_t eg_md,
        out egress_intrinsic_metadata_t eg_intr_md) {

    TofinoEgressParser() tofino_parser;

    state start {
        tofino_parser.apply(pkt, eg_intr_md);
        transition accept;
    }
}

