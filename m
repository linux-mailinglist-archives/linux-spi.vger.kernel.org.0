Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0412F360A
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403943AbhALQog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 11:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbhALQog (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Jan 2021 11:44:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D39223107;
        Tue, 12 Jan 2021 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610469836;
        bh=g4E+bclw7/LIvnoXNckYeAd/7C3OTd2i42XOkzm/MVY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iHs07gX/5trwO15bYCQc1FYHvfza0jIyYDTz+nivAmXoEEfsyJGm00YW9QID6Rn7/
         ic1zxpx9Txg8qjN/1Rz+rEKO4pCyhrZStQR9/THYbi/6aBLYFBKycRrt6s1jfTq8yV
         OP2eJS9yUYkaOtRv3qlTp5aFEAv4ReGkz5T0Tne3AiYykWon1bNP/jMUZFnEcKj8yK
         DNa/yaJBcfdsJQUagvAnpqDC+KV08LYqdlXBYRn/ZB/0tp783Mkp7O6Ecot35/bSrf
         Bkv4Am3JXCCnV6SWJMrtIGV5LbXSNBz+N1XttBki7YlDJxEZSD9+b4TMB8WUR0VJ8U
         6vdBRl7jz5gQg==
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@denx.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
In-Reply-To: <20210107145329.27966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210107145329.27966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] spi: rpc-if: Gaurd .pm assignment with CONFIG_PM_SLEEP #ifdef check
Message-Id: <161046980299.975.8508169983614840511.b4-ty@kernel.org>
Date:   Tue, 12 Jan 2021 16:43:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Jan 2021 14:53:29 +0000, Lad Prabhakar wrote:
> With CONFIG_PM_SLEEP disabled the rpcif_spi_pm_ops variable is still
> referenced and thus increasing the size of kernel.
> 
> Fix this issue by adding CONFIG_PM_SLEEP #ifdef check around the .pm
> assignment (image size is critical on RZ/A SoC's where the SRAM sizes
> range 4~5 MiB).

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rpc-if: Gaurd .pm assignment with CONFIG_PM_SLEEP #ifdef check
      commit: bfeccc6a18de52529ada66ea3afe934004b4b36e

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
