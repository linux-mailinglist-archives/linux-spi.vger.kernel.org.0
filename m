Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16500451DC3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 01:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbhKPAeF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 19:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345113AbhKOT0e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 060A1604D1;
        Mon, 15 Nov 2021 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637004071;
        bh=+MNd2K34GfmPk64cwTdXCuxqzUoEccPFFBMKwNKvMlY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rYDbvjRnpUBy99XFwq8T0C8FdyrqdFFRTvl0+bPODoPb72QoZdZT1rGPnahDbG4b7
         Vpb/EI78RhMYhh0CJCeyBvE2G++Y7efSzM3s8kp2/pe7vqB4Mn1Rl75IZJ0jQH/TaY
         zVLLqzH6KbVOWyjAFnVojh2CbQCskQVVbn8hNNIfN4rA+NS+Zy82khnWVI01S/o858
         wAAU4T+MiPwOVLtZj+dYG6SXuXSHY1gBDdtdH7LYLqtEwXFdZwFcTPpfFtn72+lquw
         h69Nvqtf4CLThu7dx0dkj+JenXb/CvYD7wBZc/WPqLPrQU3XPJNADSKz+0Gaz0avHg
         BINpWGs4EUVGg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211109161325.2203564-1-robh@kernel.org>
References: <20211109161325.2203564-1-robh@kernel.org>
Subject: Re: [PATCH] spi: xlp: Remove Netlogic XLP variants
Message-Id: <163700406969.683472.16319570545022971002.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 19:21:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 9 Nov 2021 10:13:25 -0600, Rob Herring wrote:
> Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
> support"). With those gone, the single platform left to support is
> Cavium ThunderX2. Remove the Netlogic variant and DT support.
> 
> For simplicity, the existing kconfig name is retained.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xlp: Remove Netlogic XLP variants
      commit: f7d344f2188c9f16e434cadf2a954b5d40365c14

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
