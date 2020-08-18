Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB58E248C45
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgHRQ7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 12:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgHRQ5q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C9920786;
        Tue, 18 Aug 2020 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769866;
        bh=7fq14wHHhu6xjH2/CvQck4ytpZ8RfuTFyeu3QT9h5VM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xdL+ErVeh97osumX07BL5rOURsDixw8aS0CW2OSyv2Eb6pvusumyVstwHcuz5k0lN
         UMufnOa1atT5r9DyPTR+anmN9X/ghzHDdfOFdIbTNzYuZSbOhoT6iQN/nJLqrQX5pY
         g8s3acy4rLf95nsd+TV2uw/gktO3Qm8zrse4LvLo=
Date:   Tue, 18 Aug 2020 17:57:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200816094635.1830006-1-angelo.dureghello@timesys.com>
References: <20200816094635.1830006-1-angelo.dureghello@timesys.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: set ColdFire to DMA mode
Message-Id: <159776983047.56565.2211910399770285522.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 16 Aug 2020 11:46:35 +0200, Angelo Dureghello wrote:
> Set DMA transfer mode for ColdFire.
> 
> After recent fixes to fsl edma engine, this mode can be used
> also for ColdFire, and from some raw mtd r/w tests it definitely
> improves the transfer rate, so keeping it selected.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: set ColdFire to DMA mode
      commit: b09058bbf5f083e2670186a02f5be05baf1190d7

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
