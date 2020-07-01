Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418E72115F1
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGAWYl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbgGAWYl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F66207E8;
        Wed,  1 Jul 2020 22:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642280;
        bh=5CJe11u+pnt7FQN6RdoHB/GXSb1IcyLbIPIIlmSVaHI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BIVFEvapgjk2/mWT6PcEMb1Nn0BiOqg+O6TvABaWETae2XaBVCi9ZxEAsHbfbEZ2u
         IIQLJcf/RTzTKr/NIocuCzttSsIfDhH8gSP7MIoUqydyyjm7gx5S0syuSaqV0t70PI
         yfaTlrNsdPhYaRqghjdVaG7GUgIkgcrvezNoUCa8=
Date:   Wed, 01 Jul 2020 23:24:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Sifan Naeem <sifan.naeem@imgtec.com>
In-Reply-To: <20200625201422.208640-1-linus.walleij@linaro.org>
References: <20200625201422.208640-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: img-spfi: Convert to use GPIO descriptors
Message-Id: <159364224815.10988.16343118107430433134.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Jun 2020 22:14:22 +0200, Linus Walleij wrote:
> This converts the IMG SPFI SPI driver to use GPIO descriptors
> as obtained from the core instead of GPIO numbers.
> 
> The driver was already relying on the core code to look up
> the GPIO numbers from the device tree and allocate memory for
> storing state etc. By moving to use descriptors handled by
> the core we can delete the setup/cleanup functions and
> the device state handler that were only dealing with this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: img-spfi: Convert to use GPIO descriptors
      commit: 27e23ca806c6fe08613330bb35e1f502ffd2d3a8

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
