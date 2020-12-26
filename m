Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D452E2D68
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 07:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLZGct (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Dec 2020 01:32:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54746 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgLZGct (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 26 Dec 2020 01:32:49 -0500
Received: from [10.130.0.71] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axicnb2OZftYcFAA--.14190S3;
        Sat, 26 Dec 2020 14:31:57 +0800 (CST)
Subject: Re: [PATCH v4 2/4] spi: ls7a: Add YAML schemas
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
 <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
 <7d26a91a-f463-9ae4-8420-28a1b591053b@flygoat.com>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <4f83176f-64a9-ebf1-8446-bac9f9ee9c59@loongson.cn>
Date:   Sat, 26 Dec 2020 14:31:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7d26a91a-f463-9ae4-8420-28a1b591053b@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axicnb2OZftYcFAA--.14190S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8Gr1DCr1fJrW8Wry7GFg_yoW8ZFWfpF
        17CasIvF4IqF1xCw4fta4kCw1YqryFk3Z8JFW7tr1UAF90k3Z5t343Kw1Uu3yfJF18AFyI
        vFWUWr43KF48JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi，Jiaxun

Thank you for your reply.

I will also delete the num chipelects attribute in the device tree.

And I will send v5 in the soon.

Thanks,

-Qing

On 12/26/2020 11:31 AM, Jiaxun Yang wrote:
> 在 2020/12/25 下午6:35, Qing Zhang 写道:
>> Switch the DT binding to a YAML schema to enable the DT validation.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>
>> v4: fix warnings/errors about running 'make dt_binding_check'
>>
>> ---
>>   .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 46 
>> ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml 
>> b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
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
>
> num-chipselects never parsed in code?
>
> Thanks.
>
> - Jiaxun
>
>
>
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
>> +        };
>> +    };
>> +
>> +...

