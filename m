Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A62760B4
	for <lists+linux-spi@lfdr.de>; Wed, 23 Sep 2020 21:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWTBo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Sep 2020 15:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTBo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Sep 2020 15:01:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9E92145D;
        Wed, 23 Sep 2020 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887703;
        bh=wYOx2809fD9zFTQpfYTklRI/JU7zt4lSWqWJw2Q/IZI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=unYUsaQipRjJ62Fj12oq/D52mBr7GCvcDC5ateYLhkCykMVnkpKiN9crPomCmxuEq
         SrAyPlpt4s94l/HmOHQRweaC/jtlFeAYzv/ijoNhA42rbYOl5TYeb1twXIPpJ2RVLf
         sr2AzTT8imR/BtIF3ORuyFpijq0+WVMEqkR1Uitw=
Date:   Wed, 23 Sep 2020 20:00:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
In-Reply-To: <20200917202420.1914104-1-mkl@pengutronix.de>
References: <20200917202420.1914104-1-mkl@pengutronix.de>
Subject: Re: [PATCH] spi: spi-imx: spi_imx_transfer(): add support for effective_speed_hz
Message-Id: <160088764365.36195.12331903743837990814.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 17 Sep 2020 22:24:20 +0200, Marc Kleine-Budde wrote:
> This patch implementes the reporting of the effectivly used speed_hz for the
> transfer by setting tfr->effective_speed_hz.
> 
> See the following patch, which adds this feature to the SPI core for more
> information:
> 
>     5d7e2b5ed585 spi: core: allow reporting the effectivly used speed_hz for a transfer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: spi_imx_transfer(): add support for effective_speed_hz
      commit: bf253e6bf6b876a4ce74db7dcf8a13b80d84aa5f

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
