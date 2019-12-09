Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE17116A39
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLIJxm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 04:53:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53352 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLIJxm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 04:53:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99r2HG035917;
        Mon, 9 Dec 2019 03:53:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575885182;
        bh=HQh1TZLTVm5G5fKhCiTmdkbn5flX3Vcfi7oF9Gtg2R4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uPwVdXa2LkR+h/TtP/tEcgRZoUneHHW98+jKZPQe69fHca2oDmJcsHSz7bNu3UKtD
         tEuH5/DB8L3Nqbsj3qr7qkfdSwRRJ4F6bNuKRtjYxjy1WUaUEVtbJfyugIR3rBAOU7
         OiUfdkwiW4r2RVFkTyNifIx2jF4XJg34xfyr67Fw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99r24P091285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:53:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:53:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:53:02 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99qwcX097397;
        Mon, 9 Dec 2019 03:52:58 -0600
Subject: Re: [PATCH 2/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
To:     <masonccyang@mxic.com.tw>
CC:     <bbrezillon@kernel.org>, <juliensu@mxic.com.tw>, <richard@nod.at>,
        <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <miquel.raynal@bootlin.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
 <1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw>
 <3f514579-d3a4-1319-a55a-265a3f1ce00e@ti.com>
 <OFFE6363DF.95763BC3-ON482584CB.002A47E5-482584CB.002BAA8C@mxic.com.tw>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <20f3873f-66eb-3af9-c50d-1321a859093d@ti.com>
Date:   Mon, 9 Dec 2019 15:23:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <OFFE6363DF.95763BC3-ON482584CB.002A47E5-482584CB.002BAA8C@mxic.com.tw>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 09/12/19 1:26 pm, masonccyang@mxic.com.tw wrote:
> 
> Hi Vignesh,
> 
>>
>> On 15/11/19 2:28 pm, Mason Yang wrote:
>>> According to JESD216C (JEDEC Basic Flash Parameter Table 18th DWORD)
>>> Octal DTR(8D-8D-8D) command and command extension (00b: same, 01b: 
> inverse)
>>> to add extension command mode in spi_nor struct and to add write_cr2
>>> (Write CFG Reg 2) for 8-8-8/8D-8D-8D mode sequences enable.
>>>
>>
>> But I don't see any code setting "nor->ext_cmd_mode" based on BFPT?
>>
>> Any new feature that we add to spi-nor should make use of autodiscovery
>> feature made possible by SFDP tables. Could you modify the patch to
>> discover capabilities supported by flash and opcodes to be used from
>> SFDP table?
> 
> Got it but our device will return a empty SFDP table.
> 

If flash you tested on does not support JEDEC 216C then don't mention
about it. Above commit message gives an impression that flash in JEDEC
216C compliant.

>>
>>
>>> Define the relevant macrons and enum to add such modes and make sure
>>> op->xxx.dtr fields, command nbytes and extension command are properly
>>> filled and unmask DTR and X-X-X modes in 
> spi_nor_spimem_adjust_hwcaps()
>>> so that DTR and X-X-X support detection is done through
>>> spi_mem_supports_op().
>>>
[...]
>>> @@ -404,6 +436,30 @@ static int read_sr(struct spi_nor *nor)
>>>                 SPI_MEM_OP_NO_DUMMY,
>>>                 SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>>>
>>
>> This is not based on the latest tree.
>>
>>> +      if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
>>> +         op.cmd.buswidth = 8;
>>> +         op.addr.buswidth = 8;
>>> +         op.dummy.buswidth = 8;
>>> +         op.data.buswidth = 8;
>>> +         op.cmd.nbytes = 2;
>>> +         op.addr.nbytes = 4;
>>> +         op.dummy.nbytes = 4;
>>> +         op.addr.val = 0;
>>
>> This is not scalable... There will be bunch of if...else ladders when we
>> want to support other X-X-X modes... Can't these be derived from
>> nor->reg_proto? And then borrow the logic from 
> spi_nor_spimem_read_data()?
>>
> 
> Got it !
> 
>>
>> Could you have a look at Boris's initial submission to add 8-8-8 mode at
>> https://patchwork.kernel.org/cover/10638055/ ?
>> You could use that series as the base for your changes/additions.
> 
> Got it.
> My idea is to support 8D-8D-8D mode with a minimum patches because 
> there is no define for 1D-1D-1D, 2D-2D-2D and 4D-4D-4D mode in JEDEC 
> if I am right.
> 

JESD251-A1 does talk about 4S-4D-4D right? Also none of the JEDEC
standards prohibit flash vendors from supporting other X-X-X modes.

I think you haven't thought about bigger picture here. Flash devices
that support other mode exist today and we would need the framework to
be built such that these modes can be added in future.

I suggest you start with Boris's series [1] as base and port it to
latest kernel. Isn't that series alone enough to support Macronix Octal
flashes at least?
If required, you could also always include additional patches adding new
features.

[1] https://patchwork.kernel.org/cover/10638055/

-- 
Regards
Vignesh
