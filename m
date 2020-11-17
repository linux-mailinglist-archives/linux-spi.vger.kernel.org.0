Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3E2B71B6
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgKQWik (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 17:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWij (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:39 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C27206E0;
        Tue, 17 Nov 2020 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652719;
        bh=vILjhSWwMhfSHXOq6DY+7hG8MW09zNf3uZxuRd/5cNY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=klOp3GTLcro2EGF4J5btw7KN/m95MW2EkFF7zhDqNpqkU37AR5fw7p6Bw5s7ZVct6
         zf4XunnqWy53oznHQ34AIBH+x7xHzXEENXH3pLcWpTiZDaIc9x5AuySDzNuSZA3dkc
         4hPzK/AEKoFqAuFkWi2yvnfGX6efe14G8jvTik3I=
Date:   Tue, 17 Nov 2020 22:38:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
In-Reply-To: <20201117094054.4696-1-Sergey.Semin@baikalelectronics.ru>
References: <20201117094054.4696-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] spi: dw: Set transfer handler before unmasking the IRQs
Message-Id: <160565269952.23908.7875361978634320011.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Nov 2020 12:40:54 +0300, Serge Semin wrote:
> It turns out the IRQs most like can be unmasked before the controller is
> enabled with no problematic consequences. The manual doesn't explicitly
> state that, but the examples perform the controller initialization
> procedure in that order. So the commit da8f58909e7e ("spi: dw: Unmask IRQs
> after enabling the chip") hasn't been that required as I thought. But
> anyway setting the IRQs up after the chip enabling still worth adding
> since it has simplified the code a bit. The problem is that it has
> introduced a potential bug. The transfer handler pointer is now
> initialized after the IRQs are enabled. That may and eventually will cause
> an invalid or uninitialized callback invocation. Fix that just by
> performing the callback initialization before the IRQ unmask procedure.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Set transfer handler before unmasking the IRQs
      commit: a41b0ad07bfa081584218431cb0cd7e7ecc71210

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
