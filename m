Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216242A06BE
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3NtE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 09:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3NtE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 09:49:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A782076E;
        Fri, 30 Oct 2020 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604065743;
        bh=gAOAzJ+EvPOQGcYrP5tBVHcQPsPaGVH/vBEbdOwHmU0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=n/YM+51sL37qLvcTLOh6AUalZqHvELlYPaB+nAR9BFllz5CHISDp9fYiIJDLNCUps
         h5x5tBZXwy4r1dB3RRIDDsHITTOgNre8iYDjh6mYX1+IOjqDQkxJYnD+hU78Cokh5I
         I1wVMewtJZhk1jUSeEwXD2J7qVc4R7m0x/qrlOzk=
Date:   Fri, 30 Oct 2020 13:48:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
In-Reply-To: <20201030121116.869105-1-tudor.ambarus@microchip.com>
References: <20201030121116.869105-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: atmel: Downgrade to dev_dbg when dma_request_chan() fails
Message-Id: <160406573670.21358.15332693887628851701.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 30 Oct 2020 14:11:16 +0200, Tudor Ambarus wrote:
> The IP's DMA capabilities are described in the SoC dtsi, to spare
> users duplicating the DMA bindings in their board device tree. Users
> that don't want to use DMA, have to overwrite the DMA bindings in
> their board device tree. An example is:
> commit ddcdaeb88242 ("ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and UART flx4 functions")
> 
> When the DMA bindings are overwritten, one could see on the console:
> atmel_spi fc018400.spi: error -ENODEV: No TX DMA channel, DMA is disabled
> atmel_spi fc018400.spi: Atmel SPI Controller using PIO only
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Downgrade to dev_dbg when dma_request_chan() fails
      commit: 23fc86eb2f30fc975e5705bb1a2cf92956d2edd7

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
