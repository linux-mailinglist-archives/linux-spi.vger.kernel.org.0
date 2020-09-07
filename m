Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B23260434
	for <lists+linux-spi@lfdr.de>; Mon,  7 Sep 2020 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgIGSGx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Sep 2020 14:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731414AbgIGSGt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C952078E;
        Mon,  7 Sep 2020 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599502009;
        bh=W1iDqsIlJuCF7NJOcqH4rH5wkAbpEm3VAXrL3oEGahU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VNsOcR5f4UVfNytv+yIwc1owalt4qghz9kIWh/kqV/OVlRvVddQxSkeSuHR+k51hs
         oYYkFsr0+49wR76K0YR1TeXpF3/EuGh3OIsZA7LquyNqzF9E7Vo2JFXv2DmQ3/hMcS
         4m/v0NMTDNbS+KI20AWUMaPNNPhsem5x15dIbYAU=
Date:   Mon, 07 Sep 2020 19:06:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20200905151913.117775-1-marex@denx.de>
References: <20200905151913.117775-1-marex@denx.de>
Subject: Re: [PATCH] spi: stm32: Rate-limit the 'Communication suspended' message
Message-Id: <159950195999.52926.14905827506055172230.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 5 Sep 2020 17:19:13 +0200, Marek Vasut wrote:
> The 'spi_stm32 44004000.spi: Communication suspended' message means that
> when using PIO, the kernel did not read the FIFO fast enough and so the
> SPI controller paused the transfer. Currently, this is printed on every
> single such event, so if the kernel is busy and the controller is pausing
> the transfers often, the kernel will be all the more busy scrolling this
> message into the log buffer every few milliseconds. That is not helpful.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Rate-limit the 'Communication suspended' message
      commit: ea8be08cc9358f811e4175ba7fa7fea23c5d393e

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
