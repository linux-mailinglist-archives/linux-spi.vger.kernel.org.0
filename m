Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCF2A137E
	for <lists+linux-spi@lfdr.de>; Sat, 31 Oct 2020 06:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJaFYw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Oct 2020 01:24:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50012 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgJaFYw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Oct 2020 01:24:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09V5OVAb016785;
        Sat, 31 Oct 2020 00:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604121871;
        bh=7QZYP3Fkmns+ZS3BaGOm50P9gDWBVi9Bv50zxJzTdzY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C9UAhrJnY3GJ+m4mihYu3r/qgfOvw4Ne5m44Pp90SoW5x2vlL5ozL0KKMWEIeFari
         DWbu7x4UwHSYDXurMAMGBjAB4fh2l7UN/3D/b8bNBLu0JQwchGqq2RTj1yX61uxnG7
         wFd+vEjE+gMm2JcGWkeBasuD6D2uhRSGEhCNqnps=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09V5OVE5086911
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 31 Oct 2020 00:24:31 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 31
 Oct 2020 00:24:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 31 Oct 2020 00:24:30 -0500
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09V5OR62081123;
        Sat, 31 Oct 2020 00:24:28 -0500
Subject: Re: [RFC] Accessing QSPI device under mtd
To:     Dinh Nguyen <dinguyen@kernel.org>, <linux-spi@vger.kernel.org>
CC:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <Tudor.Ambarus@microchip.com>, Mark Brown <broonie@kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
 <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
 <3d216597-c7d5-be37-2008-abd0dc2ea75e@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <70ffca2c-f454-625e-5c87-4d30441763e9@ti.com>
Date:   Sat, 31 Oct 2020 10:54:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d216597-c7d5-be37-2008-abd0dc2ea75e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/31/20 12:53 AM, Dinh Nguyen wrote:
> Hi Vignesh,
> 
> I'm using the standard arm64 defconfig. Attached are 2 bootlogs, v5.8
> and v5.9. On the v5.8, I can see the QSPI devices under /dev/mtdX, and
> has this in the bootlog:
> 
> [    1.073562] cadence-qspi ff8d2000.spi: mt25qu02g (262144 Kbytes)
> [    1.079865] 2 fixed-partitions partitions found on MTD device
> ff8d2000.spi.0
> [    1.086917] Creating 2 MTD partitions on "ff8d2000.spi.0":
> [    1.092401] 0x000000000000-0x000003fe0000 : "Boot and fpga data"
> [    1.103073] 0x000003fe0000-0x000010000000 : "Root Filesystem - JFFS2"
> 
> In v5.9, I don't see the above output in the bootlog, and there are no
> /dev/mtdX. I did a bisect and it resulted in commit "a314f6367787ee mtd:
> spi-nor: Convert cadence-quadspi to use spi-mem framework". If I revert
> this patch, then QSPI device is under /dev/mtdX.
> 
> There were no changes in the Stratix10 DTS files between v5.8 and v5.9
> that should have any affect on QSPI.
> 

I think I found the problem. Looking at
arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts:

	&qspi {
        	...
	        flash@0 {
        	        compatible = "n25q00a";
			...
		};
	};

Flash node is using non standard compatible "n25q00a". Per
Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt, SPI NOR flash
node must include "jedec,spi-nor" as compatible.

Old driver under drivers/mtd/spi-nor/ worked because, it directly called
spi_nor_scan() w/o looking at compatible string.

Could you try adding "jedec,spi-nor" to flash node's compatible list and
see if everything works?


[...]
