Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8841BF298
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 10:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3IWY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 04:22:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33482 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3IWY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Apr 2020 04:22:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03U8LrEh097577;
        Thu, 30 Apr 2020 03:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588234913;
        bh=AYxtuoLqXspkAlbbuxwgQGFo0lQ+7/nBtXslPekKiAo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KCExCER3cp2qgW+lAMedwGFKDkq5Mhvwsj5w0yZUJXjAWYSRr7a4mkcrBpqU1ccKY
         0YJtT98vgiu8FMR2MgvQykPqSfJO7lgPDDhIC5mUj5uM6ql+TcvTW1hT78Q3hQ2bJ2
         K/nkUxvpgqIYhGwg8lXUErnFF1kkmp7yVY67wOgM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03U8LrhL054832;
        Thu, 30 Apr 2020 03:21:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 03:21:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 03:21:53 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03U8Lmf3069558;
        Thu, 30 Apr 2020 03:21:49 -0500
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
To:     <masonccyang@mxic.com.tw>, Pratyush Yadav <me@yadavpratyush.com>
CC:     <tudor.ambarus@microchip.com>, <juliensu@mxic.com.tw>,
        <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
 <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
 <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3e33ffae-3267-015a-8535-6e1667b03e39@ti.com>
Date:   Thu, 30 Apr 2020 13:51:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 29/04/20 1:01 pm, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
>  
>>>>> On Tue, 21 Apr 2020 14:39:42 +0800
>>>>> Mason Yang <masonccyang@mxic.com.tw> wrote:
[...]
>>>
> https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/
>>>
>>>
>>> Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI 
> profile 
>>> 1.0,
>>> and it comply with BFPT DWORD-19, octal mode enable sequences by write 
> CFG 
>>> Reg2 
>>> with instruction 0x72. Therefore, I can't apply your patches.
>>
>> I didn't mean apply my patches directly. I meant more along the lines of 
> 
>> edit your patches to work on top of my series. It should be as easy as 
>> adding your flash's fixup hooks and its octal DTR enable hook, but if my 
> 
>> series is missing something you need (like complete Profile 1.0 parsing, 
> 
>> which I left out because I wanted to be conservative and didn't see any 
>> immediate use-case for us), let me know, and we can work together to 
>> address it.
> 
> yes,sure!
> let's work together to upstream the Octal 8D-8D-8D driver to mainline.
> 
> The main concern is where and how to enable xSPI octal mode?
> 
> Vignesh don't agree to enable it in fixup hooks and that's why I patched
> it to spi_nor_late_init_params() and confirmed the device support xSPI 
> Octal mode after BFPT DWORD-19 and xSPI pf 1.0 have been parsed.
> 

My suggestion was to use SFDP wherever possible.. E.g: it is possible to
get opcode extension type from BFPT...

But using BFPT DWORD-19 is not correct for switching to 8D-8D-8D mode:

Per JESD216D.01 Bits 22:20 of  19th DWORD of BFPT:

Octal Enable Requirements:

This field describes whether the device contains a Octal Enable bit used
to enable 1-1-8 and 1-
8-8 octal read or octal program operations.

So, this cannot be used for enabling 8D-8D-8D mode... Flashes that only
support 1S-1S-1S and 8D-8D-8D will set this field to 0.

There is a separate table to enable 8D mode called
"Command Sequences to Change to Octal DDR (8D-8D-8D) mode". But if flash
does not have the table or has bad data, fixup hook is the only way...

If mx25* supports above table, please build on top of Pratyush's series
to add support for parsing this table. Otherwise, macronix would have to
use a fixup hook too...

> I can't apply your patches to enable xSPI Octal mode for mx25uw51245g 
> because your patches set up Octal protocol first and then using Octal 
> protocol to write Configuration Register 2(CFG Reg2). I think driver
> should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make sure
> write CFG Reg 2 is success and then setup Octa protocol in the last.
> 
> As JESD216F description on BFPT DOWRD 19th, only two way to enable 
> xSPI Octal mode;

Where is JESD216F? Latest I can find is JESD216D.01

> one is by two instruction: issue instruction 06h(WREN) and then E8h.
> the other is issue instruction 06h, then issue instruction 72h (Write
> CFG Reg2), address 0h and data 02h (8D-8D-8D).
> 
> Let our patches comply with this. you may refer to my patches
> [v2,3/5] mtd: spi-nor: Parse BFPT DWORD-18, 19 and 20 for Octal 8D-8D-8D 
> mode

As I pointed out earlier using above DWORDS seems wrong for 8D-8D-8D,
they can be used for 1-1-8 and 1-
8-8

> 
>                  /* Octal mode enable sequences. */
>                  switch (bfpt.dwords[BFPT_DWORD(19)] & 
> BFPT_DWORD19_OCTAL_SEQ_MASK) {
>                  case BFPT_DWORD19_TWO_INST:
> +       ----> to patch here.
>                                  break;
>                  case BFPT_DWORD19_CFG_REG2:
>                                  params->xspi_enable = 
> spi_nor_cfg_reg2_octal_enable;
>                                  break;
>                  default:
>                                  break;
>                  }
> 
> 
>>
>>> I quickly went through your patches but can't reply them in each your 
>>> patches.
>>>
>>> i.e,.
>>> 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
>>>
>>> -                                u8 opcode;
>>> +                                u16 opcode;
>>>
>>> big/little Endian issue, right? 

Is the big/little Endian issue a quirk of the flash or controller? If
its controller specific then it needs to handled in controller driver.

If this is a flash quirk, please point to the waveforms in the flash
datasheet...

>>> why not just u8 ext_opcode;
>>> No any impact for exist code and actually only xSPI device use 
> extension 
>>> command.
>>
>> Boris already explained the reasoning behind it.
> 
> yup, I got his point and please make sure CPU data access.
> 
> i.e,.
> Fix endianness of the BFPT DWORDs and xSPI in sfdp.c
> 
> and your patch,
> +                                ext = spi_nor_get_cmd_ext(nor, op);
> +                                op->cmd.opcode = (op->cmd.opcode << 8) | 
> ext;
> +                                op->cmd.nbytes = 2;
> 
> I think maybe using u8 opcode[2] could avoid endianness.
> 
> Moreover, Vignesh think it's fine to use u8 ext_opcode in my v1 patches.
> please check his comments on
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw/ 
> 
> 
> 
> Let's open this discussion and maybe Vighesh and Tudor could have some 
> comments on it.
> thanks a lot.
> 

Sorry , but others clearly see having single variable to store cmd +
extension is beneficial here. So, I take back my suggestion.

Regards
Vignesh
