#import "../index.typ": template, tufted
#show: template.with(
  title: "逐层分解Transformer",
  description: "逐层分解Transformer，理解Transformer的原理。",
)

= Transformer整体结构
首先介绍_Transformer_的整体结构，下图是Transformer用于中英文翻译的整体结构：
#image("imgs/image.png", caption: "Transformer整体结构，左图Encoder和右图Decoder")
可以看_Transformer_由`Encoder`和`Decoder`两个部分组成，`Encoder`和`Decoder`都包含6个`block`。
- _Transformer_的工作流程大体如下：
  + 获取输入句子的每一个单词的表示*向量X*，X由单词的`Embedding`（Embedding就是从原始数据提取出来的`Feature`）和单词位置的`Embedding`相加得到。
  #image("imgs/image-1.png", caption: "Transformer的输入表示")
  + 将得到的单词表示*向量矩阵*（如上图所示，每一行是一个单词的表示x）传入`Encoder`中，经过6个`Encoder block`后可以得到句子所有单词的*编码信息矩阵C*，
    - 如下图。单词向量矩阵用$X_(n times d)$表示，*n*是句子中单词个数，*d*是表示向量的维度`（d=512）`。每一个`Encoder block`*输出的矩阵维度与输入完全一致*。
    #image("imgs/image-2.png", caption: "Transformer Encoder编码句子信息")
  + 将Encoder输出的*编码信息矩阵C*传递到`Decoder`中，`Decoder`依次会根据当前翻译过的单词`1~i`翻译下一个单词`i+1`，如下图所示。在使用的过程中，翻译到单词`i+1`的时候需要经过`Mask`（掩盖）操作遮盖住`i+1`之后的单词。
  #image("imgs/image-3.png", caption: "Transformer Decoder预测")
  上图`Decoder`接受了`Encoder`的*编码矩阵C*，然后首先输入一个翻译开始符`"<Begin>"`，预测第一个单词`"I"`；然后输入翻译开始符`"<Begin>"`和单词`"I"`，预测单词`"have"`，以此类推。这是_Transformer_使用时候的大致流程，接下来是里面各个部分的细节。
