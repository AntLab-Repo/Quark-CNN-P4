
#if __TARGET_TOFINO__ == 2
#include <t2na.p4>
#else
#include <tna.p4>
#endif

#include "quark_pipeline_a.p4"
#include "basic_forward_pipeline_b.p4"


Pipeline(SwitchIngressParser_a(),
         SwitchIngress_a(),//
         SwitchIngressDeparser_a(),//
         SwitchEgressParser_a(), //
         EmptyEgress<header_t, metadata_t>(),
         EmptyEgressDeparser<header_t, metadata_t>()) pipea;


Pipeline(MyIngressParser_b(),
         MyIngress_b(),
         MyIngressDeparser_b(),
         MyEgressParser_b(),
         MyEgress_b(),
         MyEgressDeparser_b()
         ) pipeb;

Switch(pipea, pipeb) main;
