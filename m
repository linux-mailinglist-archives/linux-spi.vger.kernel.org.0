Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3820D867
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgF2Tit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 15:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgF2Tir (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 15:38:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A4020809;
        Mon, 29 Jun 2020 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593459527;
        bh=FXu6VEQFvtj85e0o8jHQt37JSlx7+YvMjmWkyrl0mFk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TY+A8ovGITEVcPug2AEt6kltCXPhyD/nEzn8sFhEihZmvz+3ogw3nSuIvYmoeQnjT
         FwXJQOTVA6D/crVNSbaqMsqOAHaGXkKH2AgMS4gMRS52xJhaF+jEkOgLGE6m6zw/Xq
         Ib7uNCCXTaFWtZgCRacVByNB+aGJVJLauuk8fCwM=
Date:   Mon, 29 Jun 2020 20:38:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20200625231257.280615-1-linus.walleij@linaro.org>
References: <20200625231257.280615-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Convert to use GPIO descriptors
Message-Id: <159345952500.3556.5402410471594940721.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Jun 2020 01:12:57 +0200, Linus Walleij wrote:
> The OMAP2 MCSPI has some kind of half-baked GPIO CS support:
> it includes code like this:
> 
>   if (gpio_is_valid(spi->cs_gpio)) {
>         ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> 	(...)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Convert to use GPIO descriptors
      commit: f27b1dc6412547fac256957e22d6889fb56a5470

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
