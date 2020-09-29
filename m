Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAB27D38E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgI2QYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 12:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgI2QYU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 12:24:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FD020936;
        Tue, 29 Sep 2020 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601396658;
        bh=O/Nv4rl6OydXabIfmzgYwwEd2klLQr4+M4bWzpv2Ir4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Zj1wnEm/vcZ2AlT5iWP4QHJh5raIM3XMdZKzRMyAAY351G+OvT5LMDgrbJaHGbmK8
         yeuF4qeSza3Hn3r5EizJkgk2YtoEkrok/mcfxBOZHt8A4KvQ3mzyG//pCo89Ucz3R+
         Cnw7fBsCm+gTUliSSZcUjBcU+eR2WJksWzeL83gE=
Date:   Tue, 29 Sep 2020 17:23:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 00/11] spi: dw-dma: Add max SG entries burst capability support
Message-Id: <160139659999.766.1874252053451820647.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 20 Sep 2020 14:23:11 +0300, Serge Semin wrote:
> Mainly this series is about fixing a very nasty problem discovered in the
> DW APB SSI driver working in a couple with DW DMAC, which doesn't have
> multi-block capability support (a.k.a. accelerated SG list entries
> traversal/burst, or automatic LLP entries reload, etc.).
> 
> DW DMA IP-core and its DMA channel on the synthesize stage can be tuned by
> setting a vast number of the model parameters, some of which are provided
> to create a more optimized/performant controller. In particular two of
> those parameters are DMAH_CHx_MULTI_BLK_EN and DMAH_CHx_HC_LLP. If at
> least one of them is set to zero (false) then the target DMA controller
> will be smaller and faster but will lack of the DMA blocks chaining
> support. In the kernel notation it means that the controller won't be able
> to automatically reload a next SG-list entry, when a current one is
> finished. Since Linux kernel DMA subsystem interface requires to have the
> SG-lists execution supported, the DW DMA engine driver is developed in a
> way so to resubmit each SG-list entry one-by-one by software means: each
> SG-list entry execution finish is tracked by the DW DMA controller
> interrupt, which handler executes a tasklet, which then re-charges a DW
> DMA channel with a next SG-list entry if one is available. Such
> implementation is a normal design and works well for the most of the DW
> DMAC client devices. But it may cause problems for devices, which send and
> receive data by means of internal FIFOs. That requires having several DMA
> channels working synchronously in order to prevent the FIFOs overflow.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: dw-dma: Set DMA Level registers on init
        commit: 01ddbbb0b0af255d93b279f83c4ff91d494397d9
[02/11] spi: dw-dma: Fail DMA-based transfer if no Tx-buffer specified
        commit: 7ef30385b05fa8bc13f473c9b0b3ecc7dfb2b208
[03/11] spi: dw-dma: Configure the DMA channels in dma_setup
        commit: a874d811f0c2d285fd7409b5fc569c454c05c835
[04/11] spi: dw-dma: Check rx_buf availability in the xfer method
        commit: be3034d9f9f3ea28588932d10bba6d06b71489a7
[05/11] spi: dw-dma: Move DMA transfers submission to the channels prep methods
        commit: ab7a4d758b278fe44ded648e731c0638b6fa7fd3
[06/11] spi: dw-dma: Check DMA Tx-desc submission status
        commit: 9a6471a1a2c24964838a5bfa4d374e644e9daf07
[07/11] spi: dw-dma: Remove DMA Tx-desc passing around
        commit: 7a4d61f1dc94871154b2d06d671a5c20aea16ff2
[08/11] spi: dw-dma: Detach DMA transfer into a dedicated method
        commit: b86fed121fe6bf5bcac1c258472791ca352f47cf
[09/11] spi: dw-dma: Move DMAC register cleanup to DMA transfer method
        commit: 945b5b60f7110a81d1fd8145b197793edef3282d
[10/11] spi: dw-dma: Pass exact data to the DMA submit and wait methods
        commit: 917ce29ef559630cfeaea5b05f93d8744a6e9d97
[11/11] spi: dw-dma: Add one-by-one SG list entries transfer
        commit: ad4fe1264b396e94b78d91c49ecea425a593b28d

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
