Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9623CB4F6
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbhGPJDq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 05:03:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhGPJDq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 05:03:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16G90hJN038541;
        Fri, 16 Jul 2021 04:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626426044;
        bh=CPP6+OjXGjy+B2E1w0nN/WB29zQhf1443gxz81JEHaE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YwinUfOdiEgKG/c294+8vqnqOzSl7I6iEFYspYjinFDp9PVUvuiTAivhXjfdFT397
         LpVJDkAqXKrj8HQFqKUSYkmC37ywNxUfFtHdE8s3rbIlFd4WVBLd6+oPR8rBzbWL/d
         CcgWk5kV1NBB6OXkaOIoiMPe44Yllu6vAT0pqF1k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16G90hUx032518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 04:00:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 04:00:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 04:00:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16G90gBY053635;
        Fri, 16 Jul 2021 04:00:43 -0500
Date:   Fri, 16 Jul 2021 14:30:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>
Subject: Re: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero warning
Message-ID: <20210716090042.l25ds5lsl642dieo@ti.com>
References: <ed989af6-da88-4e0b-9ed8-126db6cad2e4@nskint.co.jp>
 <162637883862.27669.8312292236828094283.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <162637883862.27669.8312292236828094283.b4-ty@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 15/07/21 08:53PM, Mark Brown wrote:
> On Thu, 15 Jul 2021 16:21:32 +0000, Yoshitaka Ikeda wrote:
> > Fix below division by zero warning:
> > - Added an if statement because buswidth can be zero, resulting in division by zero.
> > - The modified code was based on another driver (atmel-quadspi).
> > 
> > [    0.795337] Division by zero in kernel.
> >    :
> > [    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
> > [    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_exec_op+0x3b0/0x3f8)
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: spi-cadence-quadspi: Fix division by zero warning
>       commit: 55cef88bbf12f3bfbe5c2379a8868a034707e755

FYI, I commented on the patch yesterday and Yoshitaka re-rolled it [0]. 
Your call whether you want to replace this patch with v4. In either 
case, I think this patch should be backported to stable so it needs a 
Fixes tag (which v4 has).

[0] https://lore.kernel.org/linux-spi/958bb93b-db83-b685-5fa1-8e5dc40a5975@nskint.co.jp/

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
Texas Instruments Inc.
