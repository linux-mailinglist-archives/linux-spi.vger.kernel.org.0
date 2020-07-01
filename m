Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19E2115E5
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGAWYV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgGAWYU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060E2207E8;
        Wed,  1 Jul 2020 22:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642260;
        bh=QpfcSfKWy9C3V8mmWe1sZKzhQku8+Nt8IfsJomXmTq8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UyH+IBJQSDVbglCOUNSUO0lId+1jIXcAbdSbQXXvCbSBKwMuqtkbjOmf/sevpTudS
         Ad/3eoRRfsbj92ty3g3MXA8kwKUuf4N0/BXvsyPIss7MYkylqMoLnK6Wm6Mvj5nOVd
         x5CbahXenMMBwL2fgph9poUvyFnkhRFYwLEUSfn4=
Date:   Wed, 01 Jul 2020 23:24:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20200625202149.209276-1-linus.walleij@linaro.org>
References: <20200625202149.209276-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: lantiq-ssc: Convert to use GPIO descriptors
Message-Id: <159364224815.10988.10586686671491650670.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Jun 2020 22:21:49 +0200, Linus Walleij wrote:
> This switches the Lantiq SSC driver over to use GPIO descriptor
> handling in the core.
> 
> The driver was already utilizing the core to look up and request
> GPIOs from the device tree so this is a pretty small change
> just switching it over to use descriptors directly instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lantiq-ssc: Convert to use GPIO descriptors
      commit: 95f2fd2e52a49b76f896e03802123567b8a89912

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
