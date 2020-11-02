Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA72A2337
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKBDDw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Nov 2020 22:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbgKBDDw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 1 Nov 2020 22:03:52 -0500
Received: from [10.0.0.28] (cpe-70-114-140-30.austin.res.rr.com [70.114.140.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6967B20773;
        Mon,  2 Nov 2020 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604286231;
        bh=Dak7xTSbex0tqxcRXv/lfFZMhw2wC7Af/NDVajmsiXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KzEqun9yafmycBwN8LZfxK2NBre5NvcJmSZXyUddZXQj1ImrdvT9NkeVA4CPtlqDV
         r/nAbvo2foLHKwqmHUhq+uY0W7QTdo/zjT3u4gLPf3WzqVV4jqYPFb9c2t88D3DX50
         1u3eghwXJCwxyY9SOVW5ebT3UHsyEzEuCbXOJYQI=
Subject: Re: [RFC] Accessing QSPI device under mtd
To:     Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Tudor.Ambarus@microchip.com, Mark Brown <broonie@kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
 <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
 <3d216597-c7d5-be37-2008-abd0dc2ea75e@kernel.org>
 <70ffca2c-f454-625e-5c87-4d30441763e9@ti.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5261561d-17ad-2053-19fb-ae5301546b48@kernel.org>
Date:   Sun, 1 Nov 2020 21:03:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <70ffca2c-f454-625e-5c87-4d30441763e9@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/31/20 12:24 AM, Vignesh Raghavendra wrote:
> 
> 
> On 10/31/20 12:53 AM, Dinh Nguyen wrote:
>> Hi Vignesh,
>>
>> I'm using the standard arm64 defconfig. Attached are 2 bootlogs, v5.8
>> and v5.9. On the v5.8, I can see the QSPI devices under /dev/mtdX, and
>> has this in the bootlog:
>>
>> [    1.073562] cadence-qspi ff8d2000.spi: mt25qu02g (262144 Kbytes)
>> [    1.079865] 2 fixed-partitions partitions found on MTD device
>> ff8d2000.spi.0
>> [    1.086917] Creating 2 MTD partitions on "ff8d2000.spi.0":
>> [    1.092401] 0x000000000000-0x000003fe0000 : "Boot and fpga data"
>> [    1.103073] 0x000003fe0000-0x000010000000 : "Root Filesystem - JFFS2"
>>
>> In v5.9, I don't see the above output in the bootlog, and there are no
>> /dev/mtdX. I did a bisect and it resulted in commit "a314f6367787ee mtd:
>> spi-nor: Convert cadence-quadspi to use spi-mem framework". If I revert
>> this patch, then QSPI device is under /dev/mtdX.
>>
>> There were no changes in the Stratix10 DTS files between v5.8 and v5.9
>> that should have any affect on QSPI.
>>
> 
> I think I found the problem. Looking at
> arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts:
> 
> 	&qspi {
>         	...
> 	        flash@0 {
>         	        compatible = "n25q00a";
> 			...
> 		};
> 	};
> 
> Flash node is using non standard compatible "n25q00a". Per
> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt, SPI NOR flash
> node must include "jedec,spi-nor" as compatible.
> 
> Old driver under drivers/mtd/spi-nor/ worked because, it directly called
> spi_nor_scan() w/o looking at compatible string.
> 
> Could you try adding "jedec,spi-nor" to flash node's compatible list and
> see if everything works?
> 
> 

Yes, that fixed it! I have a question though, if I also change it to
"jedec,spi-nor" on the v5.8 kernel, prior to the spi-mem commit, I get
this error:

[    1.075268] cadence-qspi ff8d2000.spi: unrecognized JEDEC id bytes:
d0 5d 91 08 22 00
[    1.083091] cadence-qspi ff8d2000.spi: Cadence QSPI NOR probe failed -2
[    1.089761] cadence-qspi: probe of ff8d2000.spi failed with error -2

Do you know why that is?

Thanks,
Dinh
