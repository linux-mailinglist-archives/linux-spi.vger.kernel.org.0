Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B122AE855
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 06:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKKFpO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 00:45:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgKKFpN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 00:45:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AB5iXSg013527;
        Tue, 10 Nov 2020 23:44:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605073473;
        bh=J16Pr44C8yDfBtifBxjlrA5S3HKGKiZWQWjzHZlCq8o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bTARTyNxpscSUSYPETYc1WqcktlW8afxs479YkFRqGV/2w5m4bpOEZbMT1+vcRf73
         yZT9RJz2QbMccCwQtW5ktNBteg+drmhhZZVW9DDnVuWx9SpyYo47mfITgLjzGzPOUg
         LvlVzMlCRBFoVtbzNM9tJdpVLQ6mK8masLjhlVm0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AB5iX8n097991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 23:44:33 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 23:44:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 23:44:32 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AB5iSCr008845;
        Tue, 10 Nov 2020 23:44:29 -0600
Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
 <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106100539.62fc5249@collabora.com>
 <HK0PR06MB27865F0C5B2A4F680ED0D400B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106123015.3248d478@collabora.com>
 <HK0PR06MB2786AE097106FC322D625BBFB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7e959d0d-1626-9816-c5cb-1b16c5ffba25@ti.com>
Date:   Wed, 11 Nov 2020 11:14:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <HK0PR06MB2786AE097106FC322D625BBFB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chin-Ting,

On 11/6/20 11:57 PM, Chin-Ting Kuo wrote:
> Hi Boris,
> 
>> -----Original Message-----
>> From: Boris Brezillon <boris.brezillon@collabora.com>
>> Sent: Friday, November 6, 2020 7:30 PM
>> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
>> driver
>>
>> +Tudor and Vignesh
>>
>> On Fri, 6 Nov 2020 10:21:06 +0000
>> Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:
>>
>>> Hi Boris,
>>>
>>> Thanks for your comments and suggestions.
>>>
>>>> -----Original Message-----
>>>> From: Boris Brezillon <boris.brezillon@collabora.com>
>>>> Sent: Friday, November 6, 2020 5:06 PM
>>>> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>>>> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory
>>>> controller driver
>>>>
>>>> On Fri, 6 Nov 2020 08:58:23 +0000
>>>> Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:
>>>>
>>>>> Hi Boris,
>>>>>
>>>>> Thanks for your quick reply.
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Boris Brezillon <boris.brezillon@collabora.com>
>>>>>> Sent: Thursday, November 5, 2020 11:12 PM
>>>>>> To: Cédric Le Goater <clg@kaod.org>; robh+dt@kernel.org
>>>>>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>;
>>>>>> broonie@kernel.org; joel@jms.id.au; andrew@aj.id.au;
>>>>>> bbrezillon@kernel.org; devicetree@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; linux-aspeed@lists.ozlabs.org;
>>>>>> linux-spi@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
>>>>>> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory
>>>>>> controller driver
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, 5 Nov 2020 15:09:11 +0100 Cédric Le Goater
>>>>>> <clg@kaod.org> wrote:
>>>>>>
>>>>>>> Hello Chin-Ting,
>>>>>>>
>>>>>>> Thanks for this driver. It's much cleaner than the previous
>>>>>>> and we should try adding support for the AST2500 SoC also. I
>>>>>>> guess we can keep the old driver for the AST2400 which has a
>> different register layout.
>>>>>>>
>>>>>>> On the patchset, I think we should split this patch in three :
>>>>>>>
>>>>>>>  - basic support
>>>>>>>  - AHB window calculation depending on the flash size
>>>>>>>  - read training support
>>>>>>
>>>>>> I didn't look closely at the implementation, but if the read
>>>>>> training tries to read a section of the NOR, I'd recommend
>>>>>> exposing that feature through spi-mem and letting the SPI-NOR
>>>>>> framework trigger the training instead of doing that at dirmap
>>>>>> creation time (remember that spi-mem is also used for SPI NANDs
>>>>>> which use the dirmap
>>>> API too, and this training is unlikely to work there).
>>>>>>
>>>>>> The SPI-NOR framework could pass a read op template and a
>>>>>> reference pattern such that all the spi-mem driver has to do is
>>>>>> execute the template op and compare the output to the reference
>> buffer.
>>>>>>
>>>>>
>>>>> I agree it. Before, I were not able to find a suitable location to
>>>>> implement
>>>> read training feature.
>>>>> I think that I can add a SPI timing training function in
>>>>> "spi_controller_mem_ops" struct and call it by a wrapper function
>>>>> called at
>>>> the bottom of spi_nor_probe() in spi-nor.c.
>>>>> Maybe, SPI-NOR framework does not need to pass reference buffer
>>>>> since calibration method depends on each SoC itself and buffer
>>>>> size may be
>>>> variant.
>>>>> The detail calibration method may be implemented in each SoC SPI
>> driver.
>>>>
>>>> That's a real problem IMO. What makes this pattern SoC specific? I
>>>> can see why the location in flash could be *board* specific, but the
>>>> pattern should be pretty common, right? As for the spi-mem operation
>>>> to be executed, it's definitely memory specific (I can imagine some
>>>> flash vendors providing a specific command returning a fixed pattern
>>>> that's not actually stored on a visible portion of the flash).
>>>
>>> You are right, the pattern should be pretty common. The thing I was
>>> worried about is the size of that buffer since, maybe, some
>>> controllers need to read more data than others in order to get good training
>> result.
>>
>> It would be good to see how other controllers implement that. I know that the
>> Cadence controller had something similar. Vignesh might be able to share his
>> thoughts on this.
> 

Cadence controllers requires to read fixed length calibration pattern
multiple times (while tuning PHY registers) from non zero address
location. Pattern is Flash independent and SoC independent. Hence, can
be hard coded in driver (no need to read at slower speed).

> Oh, maybe, I misunderstood your meaning and I did not describe clearly early.
> As you mentioned before, for some SPI-NOR flashes, there indeed exists a command used for
> read timing training with high SPI clock frequency.
> When this specific command is sent, an almost common pattern with fixed length will be outputted to controller.
> (This pattern is not stored on a normal read/write area.)
> 
> But, unfortunately, many flash parts we used did not support this feature. Thus, our read timing training strategy is:
> Step 1: Use the lowest SPI clock frequency to read normal flash content with specific length as reference data.
> Step 2: With a fixed high SPI clock frequency, adjust different timing delay cycle, then, read the same flash region for each timing delay.
> Step 3: Compare each data read from step 2 to the reference data gotten from step 1. Then, we will get a suitable timing delay window.
> 

Using dirmap_create() to actually calibrate controller is abusing the
interface IMO.  It is not guaranteed that flash is configured to use
right number of dummy cycles values and mode for high speed operation
before call to dirmap_create(). This is true today but may change in the
future. So, there should at least be a separate callback dedicated for
calibration along the lines Boris suggested.

Max frequency that read cmd may support would not be supported by other
cmds such as write or read SFDP. This would need to be taken into
account before and post calibration probably by extending spi_mem_op to
specify freq of operation per op.

I see that calibration pattern is assumed to be at offset 0 in the
flash. This may not be the ideal position as offset 0 is typically used
to store bootloader. So, there should be a way to specify offset at
which calibration pattern is present.

Regards
Vignesh


>>
>>>
>>>>>
>>>>> Besides, I am thinking about the possibility for adding a
>>>>> "spi_mem_post_init" function in spi-mem framework sine for some
>>>>> SoCs, SPI controller needs to adjust some settings after getting
>>>>> SPI flash
>>>> information.
>>>>
>>>> I don't think that's a good idea. The spi-mem interface should stay
>>>> memory-type agnostic and doing that means we somehow pass NOR
>>>> specific info. What is it that you need exactly, and why?
>>>
>>> Yes, as you mention, the spi-mem interface should stay memory-type
>> agnostic. Thus, currently, I just think about this, not implementation.
>>>
>>> Why did I need this exactly?
>>> Take ASPEED SPI controller for example, ASPEED SPI controller is designed
>> for SPI NOR flash especially.
>>> When ASPEED SoC powers on or reset, MCU ROM will fetch SPI NOR flash
>> through SPI controller.
>>> But, MCU ROM does not know the current address mode of SPI NOR flash
>> when SoC was reset (SPI flash is not reset).
>>> Therefore, SPI flash driver needs to set related flag to notify MCU ROM when
>> flash is set to 4B address mode and 4B read opcode is used.
>>
>> Oh, that's ugly! The SPI NOR framework tries hard to not change the
>> addressing mode exactly for this reason. On most NORs there should now be
>> READ/WRITE variants allowing you to address more than 2^24 bytes without
>> changing the addressing mode. This being said, those problem exists on other
>> platform which can't even let the boot ROM know that addressing mode
>> changed. I don't have a proper solution for your use case, but I definitely don't
>> like the idea of exposing such details to spi-mem controllers...
>>
> 
> Certainly, most of new SPI NOR flashes larger than 16MB support dedicated
> 4B command without change flash address mode. Originally, I want to take
> all flashes into consideration. But, now, the number of flashes, larger than 16MB and
> without 4B dedicated command, decreases. Perhaps, I can ignore them currently.
> 
>> We usually recommend to connect the NOR reset pin to the global reset to
>> addressing mode gets back to known state when you reboot the board and
>> need to go back to the boot ROM.
> 
> I agree with this.
> 
>>
>>>
>>> Besides, for other SoCs connected to ASPEED SoC, they can read/write SPI
>> NOR flash connected to ASPEED SoC by a pure HW channel without any
>> interaction of SW driver.
>>> But, before trigger this feature, flash read/write/erase opcode, dummy
>>> cycle and other information should be filled in the related registers in
>> advance because that HW channel does not know accurate information about
>> connected SPI NOR flash.
>>
>> While I can see a valid reason to allow that for READs (if we decide to support
>> XIP), I really don't like the idea of allowing destructive operations
>> (WRITE/ERASE) on the flash that don't go through the MTD layer. This sounds
>> like risky business to me, so I'd just forget about that if I were you. Regarding
>> the XIP use case, why not, but we'll need to extend the dirmap API to support it:
>> mappings need to stay around and you need to return a pointer to the mapped
>> memory region, which we don't allow right now (because we want to let
>> controllers move their dirmap window if they have to).
> 
> Yes, for SPI(-flash) driver, I think I just needs to focus on the scenario where all flash operations go through MTD layer.
> Other application may be implemented on the other driver, not here.
> 
> 
> Best Wishes,
> Chin-Ting
> 
> 
