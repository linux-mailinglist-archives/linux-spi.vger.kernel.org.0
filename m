Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37504268E7C
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgINOzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgINOxG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B32821974;
        Mon, 14 Sep 2020 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095186;
        bh=wFRtAkm92+CiciVb/0PUPWMniyetimzjLe18WaACIiY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=q0/fycbQcL99f7nQ24keB9sWkauckBgmSOIfdfpAICTQ9dLaxv+R/f8bAUqeJfdJz
         Fuc86DUSK0AtQzi0/3G+keLrGQHTzyr/YZkTz8Y4/MXzSWqysbT1NA85VUpIykUehu
         +UFjYmWnZc9YsXmyVEFQj+v4IsuOVhKtV/Zt1Y00=
Date:   Mon, 14 Sep 2020 15:52:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     qiang.zhao@nxp.com, linux-spi@vger.kernel.org
In-Reply-To: <20200910121532.1138596-1-olteanv@gmail.com>
References: <20200910121532.1138596-1-olteanv@gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs
Message-Id: <160009511833.5702.11020491701673491686.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 15:15:32 +0300, Vladimir Oltean wrote:
> The arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi device tree lacks DMA
> channels for DSPI, so naturally, the driver fails to probe:
> 
> [ 2.945302] fsl-dspi 2100000.spi: rx dma channel not available
> [ 2.951134] fsl-dspi 2100000.spi: can't get dma channels
> 
> In retrospect, this should have been obvious, because LS2080A, LS2085A
> LS2088A and LX2160A don't appear to have an eDMA module at all. Looking
> again at their datasheets, the CTARE register (which is specific to XSPI
> functionality) seems to be documented, so switch them to XSPI mode
> instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs
      commit: 505623a2be48b36de533951ced130876a76a2d55

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
