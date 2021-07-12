Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D63C5AEB
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhGLKtl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhGLKti (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F400C610FA;
        Mon, 12 Jul 2021 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086810;
        bh=5gadTNE2SjLldmP0GxQKzQmCe9E+I0kzV7crHNIpCOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkPxDfq42yEWwO9crtsgAMIv3EkIenFUxkPQS3oAB+kD0YH5RGVzqnDa0FlXeuUsj
         9wSb7JdYjT+XEMCu0sNTmPX3ayVLJ3bb6aGXbcviinA0ANGlEVMoTRCX37RXse6+YL
         uJ3utMTfKb81BXy8EbkH9tSFj6ib699spWC5hEDcsmUGAN9Jfq8XYhLQQVZxyjBeiT
         LmTlpsLX99Sr/A4zMrxpsr5x2JAQazLiOupcXGBqRRszkCiMpTb3beoaSvp6TWM1+T
         1VsAxUwbw/vEnEMh2m2s5Akp4e6HflasmUBM1gp7pQ0zET3JGn46mlY1TrHKmRbZ2g
         bzM1ubTC1TyxA==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        fabrice.gasnier@foss.st.com
Subject: Re: (subset) [PATCH v2 0/7] spi: stm32: various fixes & cleanup
Date:   Mon, 12 Jul 2021 11:45:39 +0100
Message-Id: <162608669456.4543.12090183716809322116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 7 Jul 2021 10:26:59 +0200, Alain Volmat wrote:
> This series contains fixes & cleanup mainly regarding fifo
> and the way end of transfer triggered, when used with or
> without DMA.
> An additional patch cleans up the pm_runtime calls and another
> one enables the autosuspend.
> 
> v2: - split pm_runtime fix patch into two
>     - correct revert commit subject line
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/7] spi: stm32: enable pm_runtime autosuspend
      commit: 9d5354145104cf392568a948c5ce2cb97f373fd7
[3/7] spi: stm32h7: fix full duplex irq handler handling
      (no commit info)
[4/7] spi: stm32: Revert "properly handle 0 byte transfer"
      commit: 70526e0b7601792bf546044fff92c368112f1d3f
[5/7] spi: stm32h7: rework rx fifo read function
      commit: d87a5d64b5037cfedd7eb47d785b5c159ace8d9b
[6/7] spi: stm32h7: don't wait for EOT and flush fifo on disable
      commit: dc6620c31326bc50fa22fd8900a9f995d0a04bc1
[7/7] spi: stm32: finalize message either on dma callback or EOT
      commit: 7ceb0b8a3ceddc36ae4ef1cba6c25a0e28ed65fc

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
