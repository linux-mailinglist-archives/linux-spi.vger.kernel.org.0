Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A22D292D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgLHKsD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 05:48:03 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54492 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728735AbgLHKsD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 05:48:03 -0500
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn3+uWc9fcqsaAA--.664S3;
        Tue, 08 Dec 2020 18:47:12 +0800 (CST)
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
 <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
Date:   Tue, 8 Dec 2020 18:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn3+uWc9fcqsaAA--.664S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Gr4UtFy8CF43ZF1rtFb_yoW8ZF48pF
        1UCF4rtF4ktw1xCa1aqFn7C3W3JF4kuF4UGF4Iqr1jy3s0kFn3tw15KrsrZrZ5WF48AFWI
        qFZ7CF1fKry2q3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei Shtylyov,


On 12/08/2020 04:40 PM, Sergei Shtylyov wrote:
> Hello!
>
> On 08.12.2020 10:44, Qing Zhang wrote:
>
>> Add spi-ls7a binding documentation.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 
>> ++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-ls7a.txt 
>> b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>> new file mode 100644
>> index 0000000..56247b5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>> @@ -0,0 +1,31 @@
>> +Binding for LOONGSON LS7A SPI controller
>> +
>> +Required properties:
>> +- compatible: should be 
>> "pci0014,7a0b.0","pci0014,7a0b","pciclass088000","pciclass0880".
>> +- reg: reference IEEE Std 1275-1994.
>> +- #address-cells: <1>, as required by generic SPI binding.
>> +- #size-cells: <0>, also as required by generic SPI binding.
>> +- #interrupts: No hardware interrupt.
>
>    You say it's a required prop, yet yuoe example doesn't have it...
         I want to emphasize here that LS7A SPI has no hardware 
interrupts, and DT is not actually used.
>
>> +
>> +Child nodes as per the generic SPI binding.
>> +
>> +Example:
>> +
>> +            spi@16,0 {
>> +                compatible = "pci0014,7a0b.0",
>> +                        "pci0014,7a0b",
>> +                        "pciclass088000",
>> +                        "pciclass0880";
>> +
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                reg = <0xb000 0x0 0x0 0x0 0x0>;
>> +                num-chipselects = <0>;
>> +                spiflash: s25fl016k@0 {
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>
>    Once more?
>
>> +                compatible ="spansion,s25fl016k","jedec,spi-nor";
>
>    Once more?
>
>> + spi-max-frequency=<50000000>;
>> +                reg=<0>;
>
>    Once more? Did you mean this for a child node?
        Yes, these are child node attributes, the child node splash is 
not necessary.
>
>> +                };
>> +            };
>
      Thanks

      -Qing
> MBR, Sergei

