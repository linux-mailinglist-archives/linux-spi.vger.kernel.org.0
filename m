Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4D1BB375
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgD1BeN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 21:34:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgD1BeM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Apr 2020 21:34:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0A9999B00C42AE7E8BD;
        Tue, 28 Apr 2020 09:34:09 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 09:34:07 +0800
Subject: Re: [PATCH v4 05/16] mtd: spi-nor: default to address width of 3 for
 configurable widths
To:     Pratyush Yadav <me@yadavpratyush.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-6-p.yadav@ti.com>
 <6b6384ad-d37a-eea6-af29-322e83924912@hisilicon.com>
 <20200427172336.ihezwq3wn75m7k3l@yadavpratyush.com>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <f6a593ab-8685-18e0-04c8-25edd1cab11a@hisilicon.com>
Date:   Tue, 28 Apr 2020 09:34:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200427172336.ihezwq3wn75m7k3l@yadavpratyush.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,


On 2020/4/28 1:23, Pratyush Yadav wrote:
> Hi Yicong,
>
> On 26/04/20 11:53AM, Yicong Yang wrote:
>> On 2020/4/25 2:43, Pratyush Yadav wrote:
>>> JESD216D.01 says that when the address width can be 3 or 4, it defaults
>>> to 3 and enters 4-byte mode when given the appropriate command. So, when
>>> we see a configurable width, default to 3 and let flash that default to
>>> 4 change it in a post-bfpt fixup.
>>>
>>> This fixes SMPT parsing for flashes with configurable address width. If
>>> the SMPT descriptor advertises variable address width, we use
>>> nor->addr_width as the address width. But since it was not set to any
>>> value from the SFDP table, the read command uses an address width of 0,
>>> resulting in an incorrect read being issued.
>>>
>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>> ---
>>>  drivers/mtd/spi-nor/sfdp.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>>> index f917631c8110..5cecc4ba2141 100644
>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>> @@ -460,6 +460,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>>>  	/* Number of address bytes. */
>>>  	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
>>>  	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
>>> +	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>>>  		nor->addr_width = 3;
>>>  		break;
>> Should we also assign address width to 3 in default condition. At least we should not
>> leave it uninitialized here.
> The default condition would be taken when this field is 3. The value 3 
> is reserved, and so no current device should use this value. That said, 
> I don't see any downsides of doing so. If the value 3 means something 
> else in later revisions of the standard, this code would need to change 
> anyway. If not, we would use a relatively sane default for devices with 
> a faulty BFPT.

The purpose is to set one possible value which may be used later in parsing smpt.
In current driver, if we do nothing with the post-bfpt fixup, then the width will
be unset. Otherwise, maybe the width can also be set in spi_nor_smpt_addr_width()

    default:
   +    if (!nor->addr_width)
   +        nor->addr_width = 3;
        return nor->addr_width;

But set when parsing bfpt seems more reasonable.

> I haven't received any comments on my series so far. If end up having to
> re-roll it, I will add this change. Otherwise, I'm not sure if it is a 
> good idea to re-roll a 16-patch series for a one liner that isn't fixing 
> some major bug. In that case, maybe you can send an independent patch 
> that does this after mine is merged?

Fine. :)

Regards,
Yicong



