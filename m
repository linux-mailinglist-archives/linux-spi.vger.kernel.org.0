Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60958283DD6
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJERzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 13:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgJERzn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656EF207EA;
        Mon,  5 Oct 2020 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920542;
        bh=ItfLLw2+vNr2ji+ODmGYqxcQS7KfC6wQ0sqQErFx7+4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YTeXAAX6dWlIwrE4UjCo/de+iktEoPEJ5AF1yxw4vIvsgTBnW0jfo9hkfcMQDOG9K
         RY3WupE+b+iXzbVgEYMWZ1T437Efpu/mqaKE5hFMr48kXd79zQn36TvmouqFywVVt7
         x2Ulq910M1Frzp5PJr2c8mmxzLTqHoC+LCn6ycpI=
Date:   Mon, 05 Oct 2020 18:54:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Robin Gong <b38343@freescale.com>
In-Reply-To: <20201005132229.513119-1-marex@denx.de>
References: <20201005132229.513119-1-marex@denx.de>
Subject: Re: [PATCH] spi: imx: Fix freeing of DMA channels if spi_bitbang_start() fails
Message-Id: <160192047990.23319.3690375960587172147.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 5 Oct 2020 15:22:29 +0200, Marek Vasut wrote:
> If the SPI controller has has_dmamode = true and spi_bitbang_start() fails
> in spi_imx_probe(), then the driver must release the DMA channels acquired
> in spi_imx_sdma_init() by calling spi_imx_sdma_exit() in the fail path.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Fix freeing of DMA channels if spi_bitbang_start() fails
      commit: 45f0bbdafd26d6d772172563b30bff561cec9133

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
