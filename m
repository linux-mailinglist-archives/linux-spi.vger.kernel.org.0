Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C43D68B9
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGZUyY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 16:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGZUyY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Jul 2021 16:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2842E60F6B;
        Mon, 26 Jul 2021 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627335292;
        bh=Ow3mxBxOWa12qDFWs2NqraXAPHzlT/wTmF0VB5nfdog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2iZBYgLJsbyAgP8rtK+ftUZ7k2yyE1fZe9BixDfddYIaINp7kIPwjbJj7pYOh/Oh
         VE9z4nAHSzuC2N3p4K0EO+8y4+DCEyxZslJzgahY7mOw1Z+1dOF2wlAJ0hOwgouEKi
         vgyEYwja/g4gKnGHPXgZf/pqKlwROsZcrREvnBf2bt+Nk2vDJ71PTzw7eTe3goYV+n
         djgGMfb6e/d/McRsZrq8FEisXH3IdMRiSHJNGUXF7/9FkP2Nk86cChWC+bNoJf/0fY
         tQdeX/xqwtcyBR0FsF0tNOoyJCb8UKhKDqzMXVlIA33bFzE4UHIcBERU4m/CzA1BP/
         i99PXuGp9rLcA==
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
Date:   Mon, 26 Jul 2021 22:34:41 +0100
Message-Id: <162733516851.3630.7508631745836446993.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726100102.5188-1-marex@denx.de>
References: <20210726100102.5188-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 26 Jul 2021 12:01:02 +0200, Marek Vasut wrote:
> The spi_imx->spi_bus_clk may be uninitialized and thus also zero in
> mx51_ecspi_prepare_message(), which would lead to division by zero
> in kernel. Since bitbang .setup_transfer callback which initializes
> the spi_imx->spi_bus_clk is called after bitbang prepare_message
> callback, iterate over all the transfers in spi_message, find the
> one with lowest bus frequency, and use that bus frequency for the
> delay calculation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
      commit: 53ca18acbe645656132fb5a329833db711067e54

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
