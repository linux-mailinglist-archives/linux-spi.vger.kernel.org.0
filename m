Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6F2115E7
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGAWY0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgGAWY0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E202082F;
        Wed,  1 Jul 2020 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642265;
        bh=P9Rt9oYURSV01v5eWDCi3jteNrlbySxJSwxngoAfxZg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pOaSMgqCZhMj0pC3L/KoLfhwqCnHDfbx0yl1Npdomz4CVjbTDoDwZBE+yBNDBV8vb
         6jRzYL/6WPptmjo5kLVUkn6tYna8HpadV5jrerf64IK+Y4yJBADHYa0g8cfN5s7ZoR
         R3dmwo6LPf5toOweaeSwB3d54+1IfpjHPfZhL92I=
Date:   Wed, 01 Jul 2020 23:24:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     f.fainelli@gmail.com, rjui@broadcom.com, nsaenzjulienne@suse.de,
        sbranden@broadcom.com, Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        kernel@martin.sperl.org, linux-rpi-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
In-Reply-To: <cover.1592261248.git.robin.murphy@arm.com>
References: <cover.1592261248.git.robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] spi: bcm2835: Interrupt-handling optimisations
Message-Id: <159364224814.10988.12578129991432190226.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Jun 2020 01:09:26 +0100, Robin Murphy wrote:
> Although Florian was concerned about a trivial inline check to deal with
> shared IRQs adding overhead, the reality is that it would be so small as
> to not be worth even thinking about unless the driver was already tuned
> to squeeze out every last cycle. And a brief look over the code shows
> that that clearly isn't the case.
> 
> This is an example of some of the easy low-hanging fruit that jumps out
> just from code inspection. Based on disassembly and ARM1176 cycle
> timings, patch #2 should save the equivalent of 2-3 shared interrupt
> checks off the critical path in all cases, and patch #3 possibly up to
> about 100x more. I don't have any means to test these patches, let alone
> measure performance, so they're only backed by the principle that less
> code - and in particular fewer memory accesses - is almost always
> better.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: bcm3835: Tidy up bcm2835_spi_reset_hw()
      commit: ac4648b5d866f98feef4525ae8734972359e4edd
[2/3] spi: bcm2835: Micro-optimise IRQ handler
      commit: afe7e36360f4c981fc03ef07a81cb4ce3d567325
[3/3] spi: bcm2835: Micro-optimise FIFO loops
      commit: 26751de25d255eab7132a8024a893609456996e6

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
