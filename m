Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98D21AA1F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGIWAu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 18:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWAu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 18:00:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C2420720;
        Thu,  9 Jul 2020 22:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332050;
        bh=KagsJECioR/VwbPqLfS0a+cLYi6dXsf1AAcz3lZeIZ0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VqZuVJj54UWguShKNtaG4m2UfCx4iUYJt2mCY9o48xbnxunNc0dKtAxbPv0gTTNSh
         uS7P/Bnja/bk//W2WAHIGfKUA1kEHrD/kqsFGwoPPGc9Rf40W5JgPdzj5JqQatMb1D
         dOujyK4HKnDvEKOTlhAzapLOFhj+ahOA/d5pBIhU=
Date:   Thu, 09 Jul 2020 23:00:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Zhang Qiang <qiang.zhang@windriver.com>,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>
In-Reply-To: <20200708123349.6797-1-m.szyprowski@samsung.com>
References: <CGME20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e@eucas1p1.samsung.com> <20200708123349.6797-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] spi: use kthread_create_worker() helper
Message-Id: <159433204447.479.6720731252136894316.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Jul 2020 14:33:49 +0200, Marek Szyprowski wrote:
> Use kthread_create_worker() helper to simplify the code. It uses
> the kthread worker API the right way. It will eventually allow
> to remove the FIXME in kthread_worker_fn() and add more consistency
> checks in the future.

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
