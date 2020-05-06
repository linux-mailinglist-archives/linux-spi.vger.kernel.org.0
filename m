Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC81C7367
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgEFOza (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 10:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgEFOza (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 10:55:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5092B20936;
        Wed,  6 May 2020 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588776929;
        bh=7qSC3unUadnWLT0T0vGXVNh94unqRwu+xgvlnuuF6u8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dBRpbNrT2j5gbwU5a3t9S+DDLfalw8ZW37dN2ZwmkpSrew4oOwpy9R8Gc5HyDPhgf
         a5z44ZpXJuCAHUy2Jt8T55HFUGA0OzSY2kDbgIwXU1M4aPiDHh1jV773Mr/dPoBBY3
         r8X2RBShfrJI8/2o6tA1mgLmbHBqXMxD684WhbKs=
Date:   Wed, 06 May 2020 15:55:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        kernel-janitors@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200506125607.90952-1-weiyongjun1@huawei.com>
References: <20200506125607.90952-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] spi: bcm2835: Fix error return code in bcm2835_dma_init()
Message-Id: <158877692139.14713.15107842057895225626.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 6 May 2020 12:56:07 +0000, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the dma mapping error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/spi/spi-bcm2835.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: bcm2835: Fix error return code in bcm2835_dma_init()
      commit: dd4441ab1fa1e2787a5f218f92d8ead1aa5ce6b5

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
