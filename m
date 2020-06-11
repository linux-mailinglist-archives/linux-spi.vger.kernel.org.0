Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD941F6404
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFKIxk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 04:53:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60336 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbgFKIxk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 04:53:40 -0400
Received: from [10.130.0.99] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb2oL8eFebdlAAA--.1310S3;
        Thu, 11 Jun 2020 16:53:33 +0800 (CST)
Subject: Re: [PATCH 2/2] spi: tools: Fix build errors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
 <1591846947-14252-2-git-send-email-zhangqing@loongson.cn>
 <CAMuHMdW9RDbBV+MVG52229xhpaWyO_hxXJv_to=SqbDHjxz3VA@mail.gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <bf4ba67a-1b4e-81c2-d03c-675baef6c8f1@loongson.cn>
Date:   Thu, 11 Jun 2020 16:53:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW9RDbBV+MVG52229xhpaWyO_hxXJv_to=SqbDHjxz3VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb2oL8eFebdlAAA--.1310S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw18ZF4rAw1fuF1fAFyrZwb_yoW5GF17pF
        n8ZF18tFs0kayUC3Z3Za1rCw13AFyFkryFv395Kr10yr13W3WxJF47Kr9YgFyxuF12va93
        A3W7W347Kw4jyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq38
        nUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/11/2020 04:02 PM, Geert Uytterhoeven wrote:
> Hi Qing,
>
> Thanks for your patch!
>
> On Thu, Jun 11, 2020 at 5:43 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>> Fix the following build errors:
>>
>> include/linux/spi 2>&1 || true
>> ln -sf /home/zhangqing/spi.git2/tools/spi/../../include/uapi/linux/spi/spidev.h include/linux/spi/spidev.h
>> make -f /home/zhangqing/spi.git2/tools/build/Makefile.build dir=. obj=spidev_test
>> make[1]: Entering directory '/home/zhangqing/spi.git2/tools/spi'
>>    CC       spidev_test.o
>> spidev_test.c: In function ‘transfer’:
>> spidev_test.c:131:13: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
>>    if (mode & SPI_TX_OCTAL)
>>               ^
>> spidev_test.c:131:13: note: each undeclared identifier is reported only once for each function it appears in
>> spidev_test.c:137:13: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
>>    if (mode & SPI_RX_OCTAL)
>>               ^
>> spidev_test.c: In function ‘parse_opts’:
>> spidev_test.c:290:12: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
>>      mode |= SPI_TX_OCTAL;
>>              ^
>> spidev_test.c:308:12: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
>>      mode |= SPI_RX_OCTAL;
>>              ^
>>    LD       spidev_test-in.o
>> ld: cannot find spidev_test.o: No such file or directory
>> /home/zhangqing/spi.git2/tools/build/Makefile.build:144: recipe for target 'spidev_test-in.o' failed
>> make[1]: *** [spidev_test-in.o] Error 1
>> make[1]: Leaving directory '/home/zhangqing/spi.git2/tools/spi'
>> Makefile:39: recipe for target 'spidev_test-in.o' failed
>> make: *** [spidev_test-in.o] Error 2
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> Oops, somehow I forgot I had made a similar change on the target
> when adding Octal mode support to spidev_test.c.
> Sorry for that.
>
> Fixes: 896fa735084e4a91 ("spi: spidev_test: Add support for Octal mode
> data transfers")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> --- a/include/uapi/linux/spi/spidev.h
>> +++ b/include/uapi/linux/spi/spidev.h
>> @@ -48,6 +48,8 @@
>>   #define SPI_TX_QUAD            0x200
>>   #define SPI_RX_DUAL            0x400
>>   #define SPI_RX_QUAD            0x800
>> +#define        SPI_TX_OCTAL            0x2000
>> +#define        SPI_RX_OCTAL            0x4000
> Probably we should add SPI_CS_WORD and SPI_3WIRE_HIZ, too?

Hi Geert,

Thanks for your reply and suggestion.
Maybe SPI_CS_WORD and SPI_3WIRE_HIZ will be used in the future.
I will do it and then send v2.

Thanks,
Qing

>
> Gr{oetje,eeting}s,
>
>                          Geert
>

