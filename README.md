# Quark: Implementing Convolutional Neural Networks Entirely on Programmable Data Plane

## Overview
Quark is a machine learning based scheme for fully implementing Convolutional Neural Network (CNN) entirely on the programmable data plane. This repository contains the source code for our paper published on **IEEE INFOCOM 2025**:  

* Zhang M., Cui L. (Corresponding author), Zhang X., Tso F. P., Zhang Z., Deng Y. and Li Z., “Quark: Implementing Convolutional Neural Networks Entirely on Programmable Data Plane”, Accepted by IEEE INFOCOM 2025.

## About the code


### Tofino ASIC

The core is written by P4<sub>16</sub> running in programmable switches (i.e., Tofino AISC).

The Tofino-version code implements the CNN, whose model consists of three convolutional layers (c1=4, c2=4, c3=4) and two fully connected layers (l1=4, l2=4). Each convolutional layer is followed by a ReLU layer and a MaxPooling layer, while each fully connected layer is followed by a ReLU layer.

A single Tofino can support more than two pipelines. The `two_pipe.p4` file provides two main functions for the two pipelines: `pipea` is the CNN inference pipeline, and `pipeb` is the feature data pipeline. You can implement the code for feature collection in the following section:

```
Pipeline(MyIngressParser_b(),
         MyIngress_b(),
         MyIngressDeparser_b(),
         MyEgressParser_b(),
         MyEgress_b(),
         MyEgressDeparser_b()
         ) pipeb;
```

When you want to use it, please compile the `two_pipe.p4` file.

## Citations

Quark is an innovative architecture designed to enable efficient data plane inference. 

Quark's primary contribution lies in addressing the challenges of resource-constrained hardware environments by optimizing inference performance, ultimately achieving the complete deployment of CNNs on PDP.

The previous work, **IN3**, is the first step of model compression in PISA, envisioning an automatic model compression for training process and discussing resource limitations of the data plane pipeline for CNN inference.

 If you find this code useful in your research, please consider citing the following papers:

* Zhang M., Cui L. (Corresponding author), Zhang X., Tso F. P., Zhang Z., Deng Y. and Li Z., “Quark: Implementing Convolutional Neural Networks Entirely on Programmable Data Plane”, in IEEE Conference on Computer Communications (IEEE INFOCOM), 2025.
```bibtex
@INPROCEEDINGS{10621341,
  author={Zhang, Mai and Cui, Lin and Zhang, Xiaoquan and Tso, Fung Po and Zhang, Zhen and Deng, Yuhui and Li, Zhetao},
  title={Quark: Implementing Convolutional Neural Networks Entirely on Programmable Data Plane},
  booktitle={IEEE Conference on Computer Communications (IEEE INFOCOM)},
  year={2025},
  volume={},
  number={}
}
```

* X. Zhang, L. Cui, F. P. Tso, W. Li, and W. Jia, “IN3: A framework for in-network computation of neural networks in the programmable data plane,” IEEE Communications Magazine, vol. 62, no. 4, pp. 96–102, 2024.
```bibtex
@article{zhang2024in3,
  title={IN3: A Framework for In-Network Computation of Neural Networks in the Programmable Data Plane},
  author={Zhang, Xiaoquan and Cui, Lin and Tso, Fung Po and Li, Wenzhi and Jia, Weijia},
  journal={IEEE Communications Magazine},
  volume={62},
  number={4},
  pages={96--102},
  year={2024},
  publisher={IEEE}
}
```
