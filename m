Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8C252212
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHYUn7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 16:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUn7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 16:43:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4E020738;
        Tue, 25 Aug 2020 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598388238;
        bh=WLo42XVgbe/Ed9YV+TS1fYp52SFu68G5Rn4m4YhTSr4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FkxhDRJ/FP6BR5O3GwCn3nSiyAfeSV5IOW0nsfuZOpur/u8GeUzieoOKoO69wHkFy
         lmYEorXVo/spfmEstcYf6liWUv0wJ0mJ8OMDblo5SoRmPKvlHRV1DjqtfGmag04K1R
         VKMo/5zPp5ql6F6+gWXIt4j9AawjXSGeraSUj/mw=
Date:   Tue, 25 Aug 2020 21:43:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-spi@vger.kernel.org
In-Reply-To: <20200825172506.14375-1-vigneshr@ti.com>
References: <20200825172506.14375-1-vigneshr@ti.com>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Populate get_name() interface
Message-Id: <159838820300.25561.6639515580662716386.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Aug 2020 22:55:06 +0530, Vignesh Raghavendra wrote:
> Implement get_name() interface of spi_controller_mem_ops so as to avoid
> changing of mtd->name due to driver being moved over to spi-mem
> framework from SPI NOR. This avoids breaking of MTD cmdline args being
> passed by bootloaders which maybe using old driver name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Populate get_name() interface
      commit: 2ea370a9173f4a3c80b24221049359a5d1518bc0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
