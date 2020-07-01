Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932F2115E9
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGAWYc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgGAWYa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B97207E8;
        Wed,  1 Jul 2020 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642270;
        bh=TW5PQPclJiwa+OQ6f0OZFhtat4XveCrFk1WVPM79oMc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BH5EJrNlTGmCRsvIJIBkzCqoy1EWY7FftdUKquE+FX+YQruobhe0qUZsbYBIk8lxe
         ABQNEScug9B/MlIYyDTOGh5Hzbw1c8MydlRr9x7Rc1l2Z1FapVjwdGB/PUJzJMatUp
         qTVGUiVeQblrW73/pqbhMQ4AuI1pFBpSPc4ktFkY=
Date:   Wed, 01 Jul 2020 23:24:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <20200701090020.7935-1-leilk.liu@mediatek.com>
References: <20200701090020.7935-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH] spi: mediatek: use correct SPI_CFG2_REG MACRO
Message-Id: <159364224815.10988.5483931944893565732.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 1 Jul 2020 17:00:20 +0800, Leilk Liu wrote:
> this patch use correct SPI_CFG2_REG offset.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: use correct SPI_CFG2_REG MACRO
      commit: 44b37eb79e16a56cb30ba55b2da452396b941e7a

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
