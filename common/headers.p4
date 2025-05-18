#ifndef _HEADERS_
#define _HEADERS_

const bit<16> TYPE_IPV4 = 0x800;
const bit<8>  TYPE_UDP  = 17;
const bit<8>  TYPE_TCP  = 6;

typedef bit<32> timestamp_type;
typedef bit<16> len_type;
typedef int<32> var_type;
typedef int<8> flag_type;

typedef bit<48> mac_addr_t;
typedef bit<32> ipv4_addr_t;

typedef bit<16> ether_type_t;
const ether_type_t ETHERTYPE_IPV4 = 16w0x0800;

typedef bit<8> ip_protocol_t;
const ip_protocol_t IP_PROTOCOLS_TCP = 6;
const ip_protocol_t IP_PROTOCOLS_UDP = 17;

header ethernet_h {
    mac_addr_t dst_addr;
    mac_addr_t src_addr;
    bit<16> ether_type;
}

header ipv4_h {
    bit<4> version;
    bit<4> ihl;
    bit<8> diffserv;
    bit<16> total_len;
    bit<16> identification;
    bit<3> flags;
    bit<13> frag_offset;
    bit<8> ttl;
    bit<8> protocol;
    bit<16> hdr_checksum;
    ipv4_addr_t src_addr;
    ipv4_addr_t dst_addr;
}

header tcp_h {
    bit<16> src_port;
    bit<16> dst_port;
    int<32> seq_no;
    int<32> ack_no;
    bit<4> data_offset;
    bit<4> res;
    bit<1>  cwr;
    bit<1>  ece;
    bit<1>  urg;
    bit<1>  ack;
    bit<1>  psh;
    bit<1>  rst;
    bit<1>  syn;
    bit<1>  fin;
    bit<16> window;
    bit<16> checksum;
    bit<16> urgent_ptr;
}

header udp_h {
    bit<16> src_port;
    bit<16> dst_port;
    bit<16> hdr_length;
    bit<16> checksum;
}

header hdr_metadata_t {
    bit<8> level;  
    bit<8> channel_index;
    bit<8> conv2_flag;
    bit<8> result_index;
    bit<8> recirculate;
    flag_type quan_temp_2;  

    flag_type ab_1;
    flag_type ab_2;
    flag_type ab_3;
    flag_type ab_4;
    flag_type cd_1;
    flag_type cd_2;
    flag_type cd_3;
    flag_type cd_4;
    flag_type ef_1;
    flag_type ef_2;
    flag_type ef_3;
    flag_type ef_4;
    flag_type gh_1;
    flag_type gh_2;
    flag_type gh_3;
    flag_type gh_4;
    flag_type abcd_1;
    flag_type abcd_2;
    flag_type abcd_3;
    flag_type abcd_4;

    int<16> ab_temp;    
    int<16> cd_temp;
    
    flag_type quan_temp_1;  
    int<8> maxnum;
    //bit<4> nouse; 
}

struct header_t {
    ethernet_h ethernet;
    ipv4_h ipv4;
    tcp_h tcp;
    hdr_metadata_t hdr_metadata;
}

parser SimplePacketParser(packet_in pkt, inout header_t hdr) {
    state start { // parse Ethernet
        pkt.extract(hdr.ethernet);
        transition parse_ipv4;
        /*transition select(hdr.ethernet.ether_type) {
            ETHERTYPE_IPV4 : parse_ipv4;
            default : reject;
        }*/
    }

    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        transition parse_tcp;
        /*transition select(hdr.ipv4.protocol) {
            IP_PROTOCOLS_TCP : parse_tcp;
            IP_PROTOCOLS_UDP : parse_udp;
            default : accept;
        }*/
    }

    /*state parse_udp {
        pkt.extract(hdr.udp);
        transition accept;
    }*/

    state parse_tcp {
        pkt.extract(hdr.tcp);
        transition parse_meta;
    }

    state parse_meta {
        pkt.extract(hdr.hdr_metadata);
        transition accept;
    }
}

#endif /* _HEADERS_ */
