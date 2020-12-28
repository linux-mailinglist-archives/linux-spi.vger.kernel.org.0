Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD752E66B7
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgL1QPa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 11:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504348AbgL1QPa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 11:15:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F8D620829;
        Mon, 28 Dec 2020 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172089;
        bh=CvSNZalc4wcOTPDlOspKMUbWgHrDqrEWFC5ZbaBWD8s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XC1W7H6O9Yt1efHwvCnkTMvgJigHMa0sQ9fXI4Rp8CC31Ymh8I7g1eSovx56dN/NQ
         KA9m5dEeuYZ+wpwbI2xzgVA3X4XNS2f66j6GI8N+Pdx9Z2KiPCg4Sx9PnOZL6WwGeX
         NbVaiuThXsOQaEJ0wHEqnM8hmeMnsGaTF/8GwV3eH/llxylMYmBWm9wN6609XVhTX0
         j7+OOYANun7fiAa66U1dyjO37MbICxOp30W20cY5yvD5EreUoqjA5l2OGi/IlrZv0G
         +F+wzyt531pBODx3DTDDPb+NZL8tgfDgCJeWgdKCfQn2Z0+J/CPKLO62ohcIG5eNIn
         n7nfhGEi2FrAw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        "kostap@marvell.com" <kostap@marvell.com>
Cc:     stefanc@marvell.com, nadavh@marvell.com, mw@semihalf.com,
        bpeled@marvell.com, jaz@semihalf.com
In-Reply-To: <20201223103827.29721-1-kostap@marvell.com>
References: <20201223103827.29721-1-kostap@marvell.com>
Subject: Re: [PATCH v3 0/2] spi: new feature and fix for Marvell Orion driver
Message-Id: <160917206868.51989.15664919641655362525.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:14:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Dec 2020 12:38:25 +0200, kostap@marvell.com wrote:
> This patch set contains the following changes:
> - support for switching CS for every transferred byte
> - fix for the clock by enabling it for every call to spi_setup()
> 
> v2:
> - remove DTS entry for single byte CS, use existing SPI_CS_WORD flag
> - drop changes to core SPI driver
> - fix the wrong first patch signature
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: orion: enable clocks before spi_setup
      commit: e2be70318d7b0ad9446d8a64ed1bc73e3316ee39
[2/2] spi: orion: enable support for switching CS every transferred byte
      commit: 22a6d41c871225bdd269a80fe04236071f429e2b

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
