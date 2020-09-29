Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F727D406
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgI2Q5z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 12:57:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgI2Q5z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 12:57:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TGvgCN072729;
        Tue, 29 Sep 2020 11:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601398663;
        bh=ZjsMCRxqgZfNl/B8Bnf/B0HPPXkHxOxgRdvcoJ1EHs4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Xh8+aOwVV9+lh0mvVMUcKcfgTIYokgwRlJLO/XnsYWOrTo1QISttpld+a9HZMFyYN
         zKChsbfnpxLLmI4u//ArR1Igyqvrj9UvLjii0/GwpUdzRpMljWwf2OcSqTdrOsTucW
         G6OfERD2O1pTSKTO730J+dwDfVUOJf0N5srSj2Ac=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TGvgtu067181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 11:57:42 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 11:57:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 11:57:42 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TGvabf047655;
        Tue, 29 Sep 2020 11:57:36 -0500
Subject: Re: [PATCH v10 05/17] mtd: spi-nor: add support for DTR protocol
To:     <Tudor.Ambarus@microchip.com>, <me@yadavpratyush.com>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <nsekhar@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-6-p.yadav@ti.com>
 <fbb3d7e7-75ed-dbf6-a975-2ae871bc9fbf@microchip.com>
 <20200721112951.rngfk7njubcsahzp@yadavpratyush.com>
 <f9a22bc5-35f6-9507-b0e7-dcbad51caea7@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <df262497-028e-83a7-eb4e-25c20fc7e216@ti.com>
Date:   Tue, 29 Sep 2020 22:27:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f9a22bc5-35f6-9507-b0e7-dcbad51caea7@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/29/20 9:12 PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush,
> 
> I'm replying to v10 so that we continue the discussion, but this applies to v13 as well.
> 
> On 7/21/20 2:29 PM, Pratyush Yadav wrote:
> 
>>>> @@ -2368,12 +2517,16 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
>>>>         struct spi_nor_flash_parameter *params = nor->params;
>>>>         unsigned int cap;
>>>>
>>>> -       /* DTR modes are not supported yet, mask them all. */
>>>> -       *hwcaps &= ~SNOR_HWCAPS_DTR;
>>>> -
>>>>         /* X-X-X modes are not supported yet, mask them all. */
>>>>         *hwcaps &= ~SNOR_HWCAPS_X_X_X;
>>>>
>>>> +       /*
>>>> +        * If the reset line is broken, we do not want to enter a stateful
>>>> +        * mode.
>>>> +        */
>>>> +       if (nor->flags & SNOR_F_BROKEN_RESET)
>>>> +               *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
>>>
>>> A dedicated reset line is not enough for flashes that keep their state
>>> in non-volatile bits. Since we can't protect from unexpected crashes in
>>> the non volatile state case, we should enter these modes only with an
>>> explicit request, i.e. an optional DT property: "update-nonvolatile-state",
>>> or something similar.
>>
>> I wrote this patch with the assumption that we won't be supporting> non-volatile configuration as of now. In the previous discussions we
> 
> I think we have to take care of the stateful flashes now, otherwise we'll risk
> to end up with users that let their flashes in a mode from which they can't recover.
> I made some small RFC patches in reply to your v13, let me know what you think.
> 
>> came to the conclusion that it is not easy to detect the flash if it
>> boots in any mode other than 1S-1S-1S [0]. So if we update non-volatile
>> state, the flash would be useless after a reboot because we won't be
>> able to detect it in 8D mode. It doesn't matter if the reset line is
>> connected or not because it will reset the flash to the non-volatile
>> state, and we can't detect it from the non-volatile state.
> 
> correct, so a reset line for stateful modes doesn't help and the comment from the
> code should be updated. s/stateful/stateless

Entering an IO mode even using volatile bits (which gets cleared on SW
or HW reset) creates a "state" that SW needs to keep track of which is
why "stateful" term is used. I think that's what is implied here

AFAIU, Boris's original RFC[1] introducing X-X-X mode also used
"stateful mode" term in the same context .


>>
>>> For the volatile state case, we can parse the SFDP SCCR map, save if we
>>> can enter stateful modes in a volatile way, and if yes allow the entering.
>>
>> If we are not support volatile configurations, the reset line is enough
>> to take care of unexpected resets, no? I don't see any need to parse
> 
> the reset line is excellent for the stateless flashes, it guarantees that the
> volatile bits will return to their default state. Disabling the clock, waiting
> for a period and re-enabling it again should do the trick too, but probably
> a dedicated reset line is safer.
> 

I don't think disable-wait-enable sequence of clock input to flash will
trigger a reset... You have to take down the power and thus force flash
to go through power-down/power-up sequence or use HW or SW reset sequences

[1]
https://patchwork.ozlabs.org/project/linux-mtd/cover/20181012084825.23697-1-boris.brezillon@bootlin.com/

Regards
Vignesh
