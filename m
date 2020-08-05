Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1423D256
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHEULj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 16:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgHEQ1m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 029A72311F;
        Wed,  5 Aug 2020 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596642942;
        bh=qLO2o0mSxwMb9NIevBlzz6FtAr3nJ1YFHl9EQ14dEfk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1+HKfGAolToUv+Ni+OR9LVDesgAhGSjLcKeUX1k8GZsyM5zBJXiuKR7yXqfwLIMTi
         7/ZTxgyDcDBXPUkCvOkWpAJEdiIlQwsJb7yBQ0q/uFOA/Fyq8tuHqXrqdgXMR4NQ+t
         KypJKPv8fTULKS1OojELAnTGF+2jHMt75kb7GcRs=
Date:   Wed, 05 Aug 2020 16:55:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200804195136.1485392-1-t.schramm@manjaro.org>
References: <20200804195136.1485392-1-t.schramm@manjaro.org>
Subject: Re: [PATCH] spi: stm32: clear only asserted irq flags on interrupt
Message-Id: <159664291990.49398.7013081287878568700.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 4 Aug 2020 21:51:36 +0200, Tobias Schramm wrote:
> Previously the stm32h7 interrupt thread cleared all non-masked interrupts.
> If an interrupt was to occur during the handling of another interrupt its
> flag would be unset, resulting in a lost interrupt.
> This patches fixes the issue by clearing only the currently set interrupt
> flags.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: clear only asserted irq flags on interrupt
      commit: ae1ba50f1e706dfd7ce402ac52c1f1f10becad68

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
