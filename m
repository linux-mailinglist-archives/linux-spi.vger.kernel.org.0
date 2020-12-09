Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF92D382E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 02:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLIBRU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 20:17:20 -0500
Received: from mail.loongson.cn ([114.242.206.163]:37516 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgLIBRU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 20:17:20 -0500
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxitBrJdBfB90aAA--.43975S3;
        Wed, 09 Dec 2020 09:16:29 +0800 (CST)
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
 <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
 <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
 <3f5a7d26-e78a-b02e-5fc2-c241547c683d@gmail.com>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <0732b18d-cff4-6556-cf80-395ff8e9b15b@loongson.cn>
Date:   Wed, 9 Dec 2020 09:16:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3f5a7d26-e78a-b02e-5fc2-c241547c683d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxitBrJdBfB90aAA--.43975S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr48Aw1DuF4xGF48CF17Wrg_yoW8Kr1kpF
        1UCF45tF4kJw17Ca1aq3WxCwnxtr95uF4UWFn2qryUAryDK3Zxt3W5trWUury8WF48AFW0
        vrZ7GFWfKry5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLiSPUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 12/08/2020 10:48 PM, Sergei Shtylyov wrote:
> On 12/8/20 1:47 PM, zhangqing wrote:
>
>>>> Add spi-ls7a binding documentation.
>>>>
>>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>>> ---
>>>>    Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 ++++++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-ls7a.txt b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>>> new file mode 100644
>>>> index 0000000..56247b5
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>>> @@ -0,0 +1,31 @@
>>>> +Binding for LOONGSON LS7A SPI controller
>>>> +
>>>> +Required properties:
>>>> +- compatible: should be "pci0014,7a0b.0","pci0014,7a0b","pciclass088000","pciclass0880".
>>>> +- reg: reference IEEE Std 1275-1994.
>>>> +- #address-cells: <1>, as required by generic SPI binding.
>>>> +- #size-cells: <0>, also as required by generic SPI binding.
>>>> +- #interrupts: No hardware interrupt.
>>>     You say it's a required prop, yet yuoe example doesn't have it...
>>          I want to emphasize here that LS7A SPI has no hardware interrupts, and DT is not actually used.
>     The why document the property at all?
           Thank you for your reply again,

           I will remove the #interrupt attribute in the third edition.
>
>>>> +
>>>> +Child nodes as per the generic SPI binding.
>>>> +
>>>> +Example:
>>>> +
>>>> +            spi@16,0 {
>>>> +                compatible = "pci0014,7a0b.0",
>>>> +                        "pci0014,7a0b",
>>>> +                        "pciclass088000",
>>>> +                        "pciclass0880";
>>>> +
>>>> +                #address-cells = <1>;
>>>> +                #size-cells = <0>;
>>>> +                reg = <0xb000 0x0 0x0 0x0 0x0>;
>>>> +                num-chipselects = <0>;
>>>> +                spiflash: s25fl016k@0 {
>>>> +                #address-cells = <1>;
>>>> +                #size-cells = <1>;
>>>     Once more?
>>>
>>>> +                compatible ="spansion,s25fl016k","jedec,spi-nor";
>>>     Once more?
>>>
>>>> + spi-max-frequency=<50000000>;
>>>> +                reg=<0>;
>>>     Once more? Did you mean this for a child node?
>>         Yes, these are child node attributes, the child node splash is not necessary.
>     You should indent the child nodes with 1 more tab...
         I will do it and send the v3 in the soon.
>
>>>> +                };
>>>> +            };
>>       Thanks
>>
>>       -Qing
> MBR, Sergei

