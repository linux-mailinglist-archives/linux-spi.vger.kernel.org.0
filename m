Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46F318FF5
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBKQaB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 11:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhBKQ1s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98D7364E95;
        Thu, 11 Feb 2021 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613060826;
        bh=tw9ZxcZmOUYy92B+IooOB7mfJ8Ub+KW+ZN8JlTS9YGM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OQMCbMwSVvawyRHbxbg3CPIbAr+LX9StLZqrnaPyQ2PVpN6kWa8Q6ZGj5l9xBSt2v
         OdhK0zCBjY2U+TvFXO3fYqgu6m+u1SxAj1mDTDyZelY6egYgxu490umFZB/k5sy35Q
         6Uumm8dVLERNNUwKvELQsZinjYPXKOAkLNTUcF92gNWTslxKw/dZDIOjoO3s80A58u
         /joY/SATay94+JyPZtMSr4gH7dPmtlRuLB9rHsIkfyWD1YaqdRodHbRJXGe5QKPDjf
         kpu2EiztUt0BYOEH5gcEqfFs2d+nYusyU9dCkeKsK6qoFyf9T2uQV71chiakj5n2wy
         HTRNpQzWQN/tQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     zhengxunli@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20210204141218.32229-1-p.yadav@ti.com>
References: <20210204141218.32229-1-p.yadav@ti.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: add spi_mem_dtr_supports_op()
Message-Id: <161306077271.51686.18172352701549316815.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 16:26:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 4 Feb 2021 19:42:17 +0530, Pratyush Yadav wrote:
> spi_mem_default_supports_op() rejects DTR ops by default to ensure that
> the controller drivers that haven't been updated with DTR support
> continue to reject them. It also makes sure that controllers that don't
> support DTR mode at all (which is most of them at the moment) also
> reject them.
> 
> This means that controller drivers that want to support DTR mode can't
> use spi_mem_default_supports_op(). Driver authors have to roll their own
> supports_op() function and mimic the buswidth checks. See
> spi-cadence-quadspi.c for example. Or even worse, driver authors might
> skip it completely or get it wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-mem: add spi_mem_dtr_supports_op()
      commit: 539cf68cd51bfcd2987ce1c44e628e9da69de7c8
[2/2] spi: cadence-quadspi: Use spi_mem_dtr_supports_op()
      commit: d2275139649bc34b8b5c3e33d26d991ab8a1364c

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
