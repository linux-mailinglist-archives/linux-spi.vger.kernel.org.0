Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0DC2BB869
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 22:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKTVgV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 16:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKTVgV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Nov 2020 16:36:21 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0720F2237B;
        Fri, 20 Nov 2020 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605908180;
        bh=1rzRLgdpZdI/PWxav/ixRoMIL2da2T/gEM+OQBevwqY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CIZEaTqeAUy4sehhHduWQSnyEpi4pM2TWmjPaIyZDGAmEJNv1GMd/FPufJreF2xoS
         O2nwVi2iS1WmWUMCGDnKMfCIto23AU3zT+U9/br1RPw3sgrKPZjbAlr3CTabqjkKP1
         X6vIOhd8p5Ed0hDEgEieOy6SvSti5HQAAv82NA+c=
Date:   Fri, 20 Nov 2020 21:35:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
In-Reply-To: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-Id: <160590815903.48662.5764722048038617376.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Nov 2020 12:45:17 +0300, Serge Semin wrote:
> I've discovered that due to the recent commit 49d7d695ca4b ("spi: dw:
> Explicitly de-assert CS on SPI transfer completion") a concurrent usage of
> the spidev devices with different chip-selects causes the "SPI transfer
> timed out" error. The root cause of the problem has turned to be in a race
> condition of the SPI-transfer execution procedure and the spi_setup()
> method being called at the same time. In particular in calling the
> spi_set_cs(false) while there is an SPI-transfer being executed. In my
> case due to the commit cited above all CSs get to be switched off by
> calling the spi_setup() for /dev/spidev0.1 while there is an concurrent
> SPI-transfer execution performed on /dev/spidev0.0. Of course a situation
> of the spi_setup() being called while there is an SPI-transfer being
> executed for two different SPI peripheral devices of the same controller
> may happen not only for the spidev driver, but for instance for MMC SPI +
> some another device, or spi_setup() being called from an SPI-peripheral
> probe method while some other device has already been probed and is being
> used by a corresponding driver...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Take the SPI IO-mutex in the spi_setup() method
      commit: 4fae3a58ab59d8a286864d61fe1846283a0316f2

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
