Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49969118965
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 14:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLJNRv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 08:17:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47750 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJNRv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 08:17:51 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBADHlRe034968;
        Tue, 10 Dec 2019 07:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575983867;
        bh=Rj0Cs8glKp3UpUTvKbL3zzNW/xSDOM9hLNN54uAyTbE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tdfQnXRPu4qlKgXYagMuB/5M2ojV4EywdeWoD3PhyFoB/t+EU52eMWSa/qT6eDYD8
         ugItoaNfNV7Y+kSm+Ue2WxAsxjgcKuHoPOsWUjp2wmh1zOjzWp+W8OfZKCib2Ssxyj
         gItX+UTWw/6BEYhdO4P438RwhCJkaXmMYqJPnadM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBADHlNu029233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 07:17:47 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 07:17:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 07:17:47 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBADHiGX065319;
        Tue, 10 Dec 2019 07:17:45 -0600
Subject: Re: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
To:     Jean Pihet <jean.pihet@newoldbits.com>
CC:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com>
 <2efd2981-73d1-6975-a385-871809ec43f1@ti.com>
 <CAORVsuU8b1-50STYAbY7CJ-VkLWXHbEz0dDCfLYfS4YM36vSgg@mail.gmail.com>
 <6d6808af-77b3-72b2-b247-58ed033cb4dc@ti.com>
 <CAORVsuXehEMi0xy6bm_OZuUowvx0K_Ogp2tXAjeruck3mYX=PQ@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b56f079f-9fc0-c745-6c39-384e76896d21@ti.com>
Date:   Tue, 10 Dec 2019 18:48:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAORVsuXehEMi0xy6bm_OZuUowvx0K_Ogp2tXAjeruck3mYX=PQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/12/19 6:31 pm, Jean Pihet wrote:
> On Tue, Dec 10, 2019 at 1:55 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>>
>>
>> On 10/12/19 5:55 pm, Jean Pihet wrote:
>>> Hi Vignesh,
>>>
>>> On Tue, Dec 10, 2019 at 9:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>>>
>>>>
>>>>
>>>> On 06/12/19 9:30 pm, Jean Pihet wrote:
>>>>> By reading the 32 bits data register and copy the contents to the
>>>>> receive buffer, according to the single/dual/quad read mode and
>>>>> the data length to read.
>>>>>
>>>>> The speed improvement is 3.5x using quad read.
>>>>> ---
>>>>>  drivers/spi/spi-ti-qspi.c | 48 ++++++++++++++++++++++++++-------------
>>>>>  1 file changed, 32 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>>>>> index 13916232a959..65ec3bcb25ae 100644
>>>>> --- a/drivers/spi/spi-ti-qspi.c
>>>>> +++ b/drivers/spi/spi-ti-qspi.c
>>>>> @@ -313,24 +313,25 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>>>>>  static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>>>>>                        int count)
>>>>>  {
>>>>> -     int wlen;
>>>>>       unsigned int cmd;
>>>>> +     u32 rx;
>>>>>       u8 *rxbuf;
>>>>> +     u8 xfer_len;
>>>>>
>>>>>       rxbuf = t->rx_buf;
>>>>>       cmd = qspi->cmd;
>>>>> +     /* Optimize the transfers for dual and quad read */
>>>>>       switch (t->rx_nbits) {
>>>>> -     case SPI_NBITS_DUAL:
>>>>> -             cmd |= QSPI_RD_DUAL;
>>>>> -             break;
>>>>>       case SPI_NBITS_QUAD:
>>>>> -             cmd |= QSPI_RD_QUAD;
>>>>> +             cmd |= QSPI_RD_QUAD | QSPI_WLEN(32);
>>>>
>>>> Why does QUAD mode mean 32 bit words?
>>> This is based on the assumption that every transfer is multiple of 8
>>> clock cycles.
>>> For SPI flash devices where bits_per_word is 8, the original code
>>> always reads data by 1 byte, which
>>> can be optimized.
>>>
>>>>
>>>> IO mode and word size are independent of each other. If you want to
>>>> optimize for speed, why not set FLEN field to max and WLEN to max and
>>>> use ti_qspi_adjust_op_size to clamp max read size to 4096 words when
>>>> required. This should work irrespective of IO modes.
>>>> Driver already does something similar to this in the write path.
>>>
>>> Ok! A new patch series is coming.
>>>
>>>>
>>>>> +             break;
>>>>> +     case SPI_NBITS_DUAL:
>>>>> +             cmd |= QSPI_RD_DUAL | QSPI_WLEN(16);
>>>>>               break;
>>>>>       default:
>>>>> -             cmd |= QSPI_RD_SNGL;
>>>>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
>>>>>               break;
>>>>>       }
>>>>> -     wlen = t->bits_per_word >> 3;   /* in bytes */
>>>>>
>>>>>       while (count) {
>>>>>               dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
>>>>> @@ -342,19 +343,34 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>>>>>                       dev_err(qspi->dev, "read timed out\n");
>>>>>                       return -ETIMEDOUT;
>>>>>               }
>>>>> -             switch (wlen) {
>>>>> -             case 1:
>>>>> -                     *rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
>>>>> +
>>>>> +             /* Optimize the transfers for dual and quad read */
>>>>> +             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
>>>>> +             switch (t->rx_nbits) {
>>>>> +             case SPI_NBITS_QUAD:
>>>>> +                     if (count >= 1)
>>>>> +                             *rxbuf++ = rx >> 24;
>>>>> +                     if (count >= 2)
>>>>> +                             *rxbuf++ = rx >> 16;
>>>>> +                     if (count >= 3)
>>>>> +                             *rxbuf++ = rx >> 8;
>>>>> +                     if (count >= 4)
>>>>> +                             *rxbuf++ = rx;
>>>>> +                     xfer_len = min(count, 4);
>>>>>                       break;
>>>>> -             case 2:
>>>>> -                     *((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
>>>>> +             case SPI_NBITS_DUAL:
>>>>> +                     if (count >= 1)
>>>>> +                             *rxbuf++ = rx >> 8;
>>>>> +                     if (count >= 2)
>>>>> +                             *rxbuf++ = rx;
>>>>> +                     xfer_len = min(count, 2);
>>>>>                       break;
>>>>> -             case 4:
>>>>> -                     *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
>>>>> +             default:
>>>>> +                     *rxbuf++ = rx;
>>>>> +                     xfer_len = 1;
>>>>>                       break;
>>>>
>>>> This will fail in case of t->rx_nbits = 1 and t->bits_per_word = 32
>>>> (1 bit SPI bus bit slave with 32-bit addressable registers)
>>> I do not see why this would fail. If bits_per_word is 32, count (in
>>> bytes) is a multiple of 4 and 1 byte will be read every time the loop
>>> runs.
>>> Is that correct? Can you elaborate more on why this would fail?
>>>
>>
>> With t->rx_nbits = 1 and t->bits_per_word = 32, controller should always
>> read in 4 byte chunks on the SPI bus, but we have:
>>
>>>>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
>>
>> which sets word size to 8 bits and thus breaks the transaction to 1 byte
>> chunks on the bus, which is bad.
> 
> In that case there are 4 1-byte reads on the bus, which succeeds. The
> trace on the logic analyzer shows 4 times 8 clock cycles.
> 

Ah, sorry, there is no CS toggle, so this case will work. Although its
less efficient as you could have set WLEN to 32 and read entire
QSPI_SPI_DATA_REG in one transaction.

But this patch definitely changes the behvior when t->rx_nbits = 4 and
t->bits_per_word = 32. Previous code did:

               *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);

This patch does:

+             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
		[...]
+             case SPI_NBITS_QUAD:
+                     if (count >= 1)
+                             *rxbuf++ = rx >> 24;
+                     if (count >= 2)
+                             *rxbuf++ = rx >> 16;
+                     if (count >= 3)
+                             *rxbuf++ = rx >> 8;
+                     if (count >= 4)
+                             *rxbuf++ = rx;


So there is change in the endianess...

-- 
Regards
Vignesh
