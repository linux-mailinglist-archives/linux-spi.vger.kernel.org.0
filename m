Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9722E2D6E
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 07:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLZGlr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Dec 2020 01:41:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:55890 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgLZGlr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 26 Dec 2020 01:41:47 -0500
Received: from [10.130.0.71] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axecn42uZfK4gFAA--.12155S3;
        Sat, 26 Dec 2020 14:40:57 +0800 (CST)
Subject: Re: [PATCH v4 2/4] spi: ls7a: Add YAML schemas
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
 <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
 <99ab96cc-6169-19c2-04ef-d023d4427f55@gmail.com>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <70ab4b0c-1dab-d62f-f829-11b1c57257c1@loongson.cn>
Date:   Sat, 26 Dec 2020 14:40:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <99ab96cc-6169-19c2-04ef-d023d4427f55@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axecn42uZfK4gFAA--.12155S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15AF48GFWrKw1UtrWDArb_yoW8ZF4UpF
        13Ca4avF4IqF1xCw4SqFykCw1YqryFk3Z8JFW7tr1UCF90k3Z0q343Kw1Uu34fJF18AFyx
        ZFy8Wr43KF10yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcmiiDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi，Sergei

Thank you for your reply and suggestion .

I will use extra indentation levels and send v5 in the soon.

Thanks,

-Qing


On 12/25/2020 08:19 PM, Sergei Shtylyov wrote:
> On 12/25/20 1:35 PM, Qing Zhang wrote:
>
>> Switch the DT binding to a YAML schema to enable the DT validation.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>
>> v4: fix warnings/errors about running 'make dt_binding_check'
>>
>> ---
>>   .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 46 ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>> new file mode 100644
>> index 0000000..8cc9bc5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/loongson,spi-ls7a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson LS7A PCH SPI Controller
>> +
>> +maintainers:
>> +  - Qing Zhang <zhangqing@loongson.cn>
>> +
>> +description: |
>> +  This controller can be found in Loongson-3 systems with LS7A PCH.
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls7a-spi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - num-chipselects
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pci {
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        spi@16,0 {
>> +        compatible = "pci0014,7a0b.0",
>> +                        "pci0014,7a0b",
>> +                        "pciclass088000",
>> +                        "pciclass0800";
>> +
>> +        reg = <0xb000 0x0 0x0 0x0 0x0>;
>> +        num-chipselects = <0>;
>      The above lines after { need extra indentation level.
>
>> +        };
>> +    };
>> +
>> +...
> MBR, Sergei

