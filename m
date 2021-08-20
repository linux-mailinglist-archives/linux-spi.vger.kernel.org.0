Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FE3F2CF8
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhHTNPf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 09:15:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47470 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbhHTNPe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 09:15:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KDEabO079205;
        Fri, 20 Aug 2021 08:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629465276;
        bh=zjV2VV/W/R/LlnVIjGzbmQRZCHArbsyZBGSViRrmZLY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nvbK7Sln3P6qZvNkZSrpRqy0ZeCZEa+Mw7g3tXLqpHoen6tzx1nishrOL3dlg99yr
         3CVhsqLYPg9xsJ3NM6AAmDOrdrrNJZlMH+wv3kQKf+HyaL9m2sInEK796AvMCmkIXJ
         qxU9JjBM4E2qk8zeGIvHLunusHBRtgiyNgGMVG/Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KDEaQr109892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 08:14:36 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 08:14:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 08:14:35 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KDEV4o056759;
        Fri, 20 Aug 2021 08:14:32 -0500
Subject: Re: [PATCH 13/13] mtd: spinand: Add support for Winbond W35N01JW SPI
 NAND flash
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-14-a-nandan@ti.com> <20210806211423.5c9d3e96@xps13>
 <64f130dc-1d87-5657-ae93-09bfdb7e93a1@ti.com> <20210820140210.47d348dc@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <949d3af1-1513-e606-bc9e-7265cbf97e58@ti.com>
Date:   Fri, 20 Aug 2021 18:44:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820140210.47d348dc@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 20/08/21 5:32 pm, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 17:21:33
> +0530:
> 
>> Hi Miquèl,
>>
>> On 07/08/21 12:44 am, Miquel Raynal wrote:
>>> Hi Apurva,
>>>
>>> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:38
>>> +0000:
>>>    
>>>> Winbond W35N01JW is SPI NAND flash supporting Octal DTR SPI protocol.
>>>
>>>                        a
>>>    
>>>> Add op_vairants for W35N01JW, which include the Octal DTR read/write
>>>
>>> variants
>>>    
>>>> page ops as well. Add W35N01JW's oob layout functions for the
>>>
>>>                                      OOB
>>>    
>>
>> Okay, will correct these.
>>
>>>> mtd_ooblayout_ops. Add all op adjustments required for Octal DTR SPI
>>>> mode using the adjust_op(). Finally, add an entry for W35N01JW in
>>>> spinand_info table.
>>>>
>>>> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
>>>>   
>>>
>>> Maybe we can split this into two parts:
>>> 1/ support the chip
>>> 2/ add 8-D support
>>>    
>>
>> I can split the patch into:
>> 1/ Add implementation of manufacturer_ops: adjust_op() to handle variations of ops in 8D-8D-8D mode
>> 2/ Add support/entry for Winbond W35N01JW SPI NAND flash chip
>>
>> As 8-D support has already been added in a previous patch.
> 
> I also don't want the renaming to happen in the patch adding more
> logic.
> 

Okay, got it. Will amend this.

> Thanks,
> Miquèl
> 

Thanks,
Apurva Nandan
