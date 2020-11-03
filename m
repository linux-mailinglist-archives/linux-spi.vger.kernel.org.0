Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009FE2A3D18
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 08:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKCHAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 02:00:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49902 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCHAU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 02:00:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A370Djb090159;
        Tue, 3 Nov 2020 01:00:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604386813;
        bh=Kv4sOox9MUvV+JdjdYBy+JrerDCJLm77nhE6CZpVXJg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rF0y/kIX7n7NuZnOkdZ16zWaahhtMELN1qVFY2iwqfQ248eysGqQF/f9Lf9LUdzyq
         J5/ygkd6y756/+StPDOB7U/MoawZqt1bT5QWPA5d3ES8Gs6b0pRBIPIWrd+VQJ+rul
         a1dFkOSIVKPrqF1npBVM2929jJUpQbvyVsnd5Eqg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A370Dav005594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 01:00:13 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 01:00:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 01:00:13 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A370ACW052815;
        Tue, 3 Nov 2020 01:00:11 -0600
Subject: Re: [RFC] Accessing QSPI device under mtd
To:     Dinh Nguyen <dinguyen@kernel.org>, <linux-spi@vger.kernel.org>
CC:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <Tudor.Ambarus@microchip.com>, Mark Brown <broonie@kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
 <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
 <3d216597-c7d5-be37-2008-abd0dc2ea75e@kernel.org>
 <70ffca2c-f454-625e-5c87-4d30441763e9@ti.com>
 <5261561d-17ad-2053-19fb-ae5301546b48@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b1359615-a3c5-3609-76fb-ce1d35c5c1ee@ti.com>
Date:   Tue, 3 Nov 2020 12:30:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5261561d-17ad-2053-19fb-ae5301546b48@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/2/20 8:33 AM, Dinh Nguyen wrote:
> 
> 
> On 10/31/20 12:24 AM, Vignesh Raghavendra wrote:
>>
>>
>> On 10/31/20 12:53 AM, Dinh Nguyen wrote:
>>> Hi Vignesh,
>>>
>>> I'm using the standard arm64 defconfig. Attached are 2 bootlogs, v5.8
>>> and v5.9. On the v5.8, I can see the QSPI devices under /dev/mtdX, and
>>> has this in the bootlog:
>>>
>>> [    1.073562] cadence-qspi ff8d2000.spi: mt25qu02g (262144 Kbytes)
>>> [    1.079865] 2 fixed-partitions partitions found on MTD device
>>> ff8d2000.spi.0
>>> [    1.086917] Creating 2 MTD partitions on "ff8d2000.spi.0":
>>> [    1.092401] 0x000000000000-0x000003fe0000 : "Boot and fpga data"
>>> [    1.103073] 0x000003fe0000-0x000010000000 : "Root Filesystem - JFFS2"
>>>
>>> In v5.9, I don't see the above output in the bootlog, and there are no
>>> /dev/mtdX. I did a bisect and it resulted in commit "a314f6367787ee mtd:
>>> spi-nor: Convert cadence-quadspi to use spi-mem framework". If I revert
>>> this patch, then QSPI device is under /dev/mtdX.
>>>
>>> There were no changes in the Stratix10 DTS files between v5.8 and v5.9
>>> that should have any affect on QSPI.
>>>
>>
>> I think I found the problem. Looking at
>> arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts:
>>
>> 	&qspi {
>>         	...
>> 	        flash@0 {
>>         	        compatible = "n25q00a";
>> 			...
>> 		};
>> 	};
>>
>> Flash node is using non standard compatible "n25q00a". Per
>> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt, SPI NOR flash
>> node must include "jedec,spi-nor" as compatible.
>>
>> Old driver under drivers/mtd/spi-nor/ worked because, it directly called
>> spi_nor_scan() w/o looking at compatible string.
>>
>> Could you try adding "jedec,spi-nor" to flash node's compatible list and
>> see if everything works?
>>
>>
> 
> Yes, that fixed it! I have a question though, if I also change it to
> "jedec,spi-nor" on the v5.8 kernel, prior to the spi-mem commit, I get
> this error:
> 
> [    1.075268] cadence-qspi ff8d2000.spi: unrecognized JEDEC id bytes:
> d0 5d 91 08 22 00
> [    1.083091] cadence-qspi ff8d2000.spi: Cadence QSPI NOR probe failed -2
> [    1.089761] cadence-qspi: probe of ff8d2000.spi failed with error -2
> 
> Do you know why that is?
> 

Hmm, that should not happen.. Flash nodes "compatible" line as no effect
with old driver (even deleting it won't matter). Is this change on top
of plain v5.8 or do you have some other changes to spi-nor or controller
driver?

Only way to debug would be to see difference in controller register
configuration with and without "jedec,spi-nor"


