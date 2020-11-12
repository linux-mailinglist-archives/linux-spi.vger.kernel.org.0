Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A92B0E39
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKLTkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKLTkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:40:13 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE5D2223F;
        Thu, 12 Nov 2020 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605210012;
        bh=OkAHhuFFyGUpTrg3aFLI9ulV2DW0cw+fwNPtghh7Cw8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rtcXNMMhVa/3kzvXC+kv0fHPCHyZGRmwjmvfRx4c6hFBSJaNxc0sFLLFNmuO5e0pa
         idf3tUeA2hFvtcNAmFZeTuO2wHWU/8OrUJzq/YLTs1rv4871wIBdqhJ9vKVh3rwqYc
         cAaf4Hwfmw7rnuUKHL2dTb5H9cguuIB9fAKtn5TA=
Date:   Thu, 12 Nov 2020 19:39:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <cover.1605121038.git.lukas@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com> <cover.1605121038.git.lukas@wunner.de>
Subject: Re: [PATCH 0/4] Use-after-free be gone
Message-Id: <160520996933.38820.13515952414392141063.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 11 Nov 2020 20:07:00 +0100, Lukas Wunner wrote:
> Here's my proposal to fix the use-after-free bugs reported by
> Sascha Hauer and Florian Fainelli:
> 
> I scrutinized all SPI drivers in the v5.10 tree:
> 
> * There are 9 drivers with a use-after-free in the ->remove() hook
>   caused by accessing driver private data after spi_unregister_controller().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Introduce device-managed SPI controller allocation
      commit: 5e844cc37a5cbaa460e68f9a989d321d63088a89
[2/4] spi: bcm2835: Fix use-after-free on unbind
      commit: e1483ac030fb4c57734289742f1c1d38dca61e22
[3/4] spi: bcm2835aux: Fix use-after-free on unbind
      commit: e13ee6cc4781edaf8c7321bee19217e3702ed481
[4/4] spi: bcm-qspi: Fix use-after-free on unbind
      commit: 63c5395bb7a9777a33f0e7b5906f2c0170a23692

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
