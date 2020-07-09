Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807A421AA23
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGIWBA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 18:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWBA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 18:01:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8069F20672;
        Thu,  9 Jul 2020 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332060;
        bh=msWKTE4BCZLc4U8L8+qfw1QtifkqgBy8zjRli3eD2ew=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=syuGpFMQ8lkvg+TYPNjreEjKnslsdX0KJ9eSpVKsqW/oJCygfjvLKf3d4XZJqTlb0
         vWu1fTgSt2PuGhIZDxL4G0MKpqYIKT6u2fyNS+seFX/E25Xjgr+gg2xII2R4H2BqjY
         QpVNZjSOcJ6J5lHGzJX40IqbDvkKPoa8rEAFxtVY=
Date:   Thu, 09 Jul 2020 23:00:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Zhang Qiang <qiang.zhang@windriver.com>,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>
In-Reply-To: <20200708070900.30380-1-m.szyprowski@samsung.com>
References: <CGME20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af@eucas1p2.samsung.com> <20200708070900.30380-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] spi: use kthread_create_worker() helper
Message-Id: <159433204447.479.16222670499567811271.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Jul 2020 09:09:00 +0200, Marek Szyprowski wrote:
> Since commit 4977caef05aa ("kthread: work could not be queued when worker
> being destroyed") there is a warning when kworker is used without the
> internal 'task' entry properly initialized. Fix this by using
> a kthread_create_worker() helper instead of open-coding a kworker
> initialization.
> 
> This fixes a following warning during SPI controller probe, observed on
> the Samsung Exynos 5420-based Peach-Pit Chromebook with recent linux-next
> kernel:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use kthread_create_worker() helper
      commit: 60a883d119ab9ef63f830c85bbd2f0e2e2314f4f

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
