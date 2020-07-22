Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24682228D50
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgGVA5o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 20:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbgGVA5o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9893C20771;
        Wed, 22 Jul 2020 00:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379464;
        bh=+h+FsY9O0cP/cZ84GngkSGODjVnPpI1wi4YukMbO2Hg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kW6wag5xKIXSTHBhUWabWkAyobTmu31J/cHJiQWKLrp8IjJvY7I9IBa8KNEYkfSBT
         ZHolByK4OlVmjyan0cAuL9Z/oZ8oiqhgt2FiDszi380QyhnyehdsJGVurNJantEblF
         oYCkmxxt1qjPL3bzttiZBGz6Zs0mN5JJwSB8FRKg=
Date:   Wed, 22 Jul 2020 01:57:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20200721203951.2159-1-Sergey.Semin@baikalelectronics.ru>
References: <20200721203951.2159-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] spi: dw-dma: Fix Tx DMA channel working too fast
Message-Id: <159537945107.49691.8779347106169318267.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Jul 2020 23:39:51 +0300, Serge Semin wrote:
> It turns out having a Rx DMA channel serviced with higher priority than
> a Tx DMA channel is not enough to provide a well balanced DMA-based SPI
> transfer interface. There might still be moments when the Tx DMA channel
> is occasionally handled faster than the Rx DMA channel. That in its turn
> will eventually cause the SPI Rx FIFO overflow if SPI bus speed is high
> enough to fill the SPI Rx FIFO in before it's cleared by the Rx DMA
> channel. That's why having the DMA-based SPI Tx interface too optimized
> is the errors prone, so the commit 0b2b66514fc9 ("spi: dw: Use DMA max
> burst to set the request thresholds") though being perfectly normal from
> the standard functionality point of view implicitly introduced the problem
> described above. In order to fix that the Tx DMA activity is intentionally
> slowed down by limiting the SPI Tx FIFO depth with a value twice bigger
> than the Tx burst length calculated earlier by the
> dw_spi_dma_maxburst_init() method.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-dma: Fix Tx DMA channel working too fast
      commit: affe93dd5b35bb0e7b0aa0505ae432dd0ac72c3f

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
