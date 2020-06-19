Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09B200A16
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgFSN2i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 09:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbgFSN2Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 09:28:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55A62166E;
        Fri, 19 Jun 2020 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573296;
        bh=Zlz05WKmcUJTYXlIz5yl2H2syQ5FgQ4vwLVGbolffuk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KPk1NJwhF3h9BXiQXEbwEs/ZhjAPrfR3osy0dtW+Jpygxkl+kyMBz6EiRUiZ3IZuT
         KiwGpZBrx5Rp3NwBP6xwTrJJn311rfVhw0HcI/0hsnbUrh/WHeWs9w4/QFdmJFyVxW
         fhvT+vIF6jzKSqu5k6uW6u40NbS3zLc15j75Fms4=
Date:   Fri, 19 Jun 2020 14:28:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     dinguyen@kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        linux-spi@vger.kernel.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        simon.k.r.goldschmidt@gmail.com, linux-kernel@vger.kernel.org,
        marex@denx.de, linux-mtd@lists.infradead.org
In-Reply-To: <20200526093604.11846-1-vigneshr@ti.com>
References: <20200526093604.11846-1-vigneshr@ti.com>
Subject: Re: [PATCH v2 0/6] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework
Message-Id: <159257327821.5984.8587819746986520265.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 26 May 2020 15:05:58 +0530, Vignesh Raghavendra wrote:
> This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
> support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
> cadence-quadspi driver to spi-mem framework
> 
> Those patches were trying to accomplish too many things in a single set
> of patches and need to split into smaller patches. This is reduced
> version of above series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      commit: 834b4e8d344139ba64cda22099b2b2ef6c9a542d
[2/6] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
      commit: a99705079a91e6373122bd0ca2fc129b688fc5b3
[3/6] mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      commit: 48aae57f0f9f57797772bd462b4d64902b1b4ae1
[4/6] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
      commit: c61088d1f9932940af780b674f028140eda09a94
[5/6] mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
      commit: a314f6367787ee1d767df9a2120f17e4511144d0
[6/6] spi: Move cadence-quadspi driver to drivers/spi/
      commit: 31fb632b5d43ca16713095b3a4fe17e3d7331e28

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
