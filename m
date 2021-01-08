Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780AC2EF5FB
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhAHQtN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 11:49:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57192 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhAHQtN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 11:49:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108GmVF9077119;
        Fri, 8 Jan 2021 10:48:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610124511;
        bh=IQ6c6TEgxh89EfD2jzKuI2hDt60lwX6bPkqrrRsFPqE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Qx6dTEcVH9uNjj9dSxO6toMnsW7/Bkt3jGT/m1hNKfUiyupyYe/A63mBxRXNctmib
         Ea48Zljon9qdxjc376pQK7k2QpfYdq47YOCFrWPDEagUtzuO0O6WYJlzG2qcgcXA2b
         ZziVID4miDkNrUo7wooJvI161DOTBvHWoDIAjhw8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108GmVvb000437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 10:48:31 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 10:48:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 10:48:31 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108GmU2S058156;
        Fri, 8 Jan 2021 10:48:30 -0600
Date:   Fri, 8 Jan 2021 22:18:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 0/7] spi: cadence-quadspi: Add Octal DTR support
Message-ID: <20210108164829.llziqunksj2iaopm@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
 <160994515510.52247.9169476392444387381.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <160994515510.52247.9169476392444387381.b4-ty@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 06/01/21 02:59PM, Mark Brown wrote:
> On Wed, 23 Dec 2020 00:14:18 +0530, Pratyush Yadav wrote:
> > This series adds support for Octal DTR mode now that SPI NOR supports
> > these flashes. Patches 1/7 to 4/7 and 6/7 fix some minor bugs and issues.
> > Patche 5/7 lays some groundwork by implementing the supports_op() hook.
> > Patch 7/7 adds the Octal DTR mode support.
> > 
> > While the main aim of this series is to support 8D-8D-8D mode, other
> > modes like 4D-4D-4D or 2S-2S-2S should also now be supported, though
> > they have not been tested.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!

:-)
 
> [1/7] spi: cadence-quadspi: Set master max_speed_hz
>       commit: 3a5c09c8d1ed9a7323f0e5c435021531f0865c16
> [2/7] spi: cadence-quadspi: Abort read if dummy cycles required are too many
>       commit: ceeda328edeeeeac7579e9dbf0610785a3b83d39
> [3/7] spi: cadence-quadspi: Set dummy cycles from STIG commands
>       commit: 888d517b992532df2b6115fbdc9620673ca7c651
> [4/7] spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1
>       commit: 7512eaf54190e4cc9247f18439c008d44b15022c
> [5/7] spi: cadence-quadspi: Implement a simple supports_op hook
>       commit: a273596b9b50c76a9cc1f65d3eb7f8ab5c3eb3e3
> [6/7] spi: cadence-quadspi: Wait at least 500 ms for direct reads
>       commit: 0920a32cf6f20467aa133a47b776ee782daa889f

The kernel test robot reported some build warnings on this patch on 
32-bit platforms and I was planning on re-rolling it soon. Now that it 
is in your tree, I will send a follow-up patch to fix it.

> [7/7] spi: cadence-quadspi: Add DTR support
>       commit: f453f293979fb648d2e505c132887811acb6bde6
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

-- 
Regards,
Pratyush Yadav
Texas Instruments India
