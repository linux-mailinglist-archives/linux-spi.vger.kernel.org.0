Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36927370D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgIVAHL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 20:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgIVAHL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 20:07:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EEFD207C4;
        Tue, 22 Sep 2020 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733230;
        bh=yc4ZdBYVnhX0vOR1hst8S+NVO/p2/2pfSEqt6t7Tv84=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MnrqwCOcaARBJsHVQTM5D8H32R5hvnl5+CWPWoCgPsRWL5gPn+rF6x7ejg73TwMoD
         OacvCb7fFnimO2lvnqo1aOKWSMJskTzubZbb+Bg+OIjtdaq+65xOFe2QgZ54s0pEcK
         oiBooqFp45WNvRma/yXEUPRbx3z8H+J3gikvCnvU=
Date:   Tue, 22 Sep 2020 01:06:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh R <vigneshr@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
In-Reply-To: <20200910122624.8769-1-a-govindraju@ti.com>
References: <20200910122624.8769-1-a-govindraju@ti.com>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Switch to readl_poll_timeout()"
Message-Id: <160073317818.6418.1953400870521393245.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 17:56:24 +0530, Aswath Govindraju wrote:
> This reverts commit 13d515c796adc49a49b0cd2212ccd7f43a37fc5a.
> 
> The amount of time spent polling for the MCSPI_CHSTAT bits to be set on
> AM335x-icev2 platform is less than 1us (about 0.6us) in most cases, with
> or without using DMA. So, in most cases the function need not sleep.
> Also, setting the sleep_usecs to zero would not be optimal here because
> ktime_add_us() used in readl_poll_timeout() is slower compared to the
> direct addition used after the revert. So, it is sub-optimal to use
> readl_poll_timeout in this case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Improve performance waiting for CHSTAT
      commit: 7b1d96813317358312440d0d07abbfbeb0ef8d22

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
