Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE71C5549
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEEMRp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 08:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgEEMRp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 08:17:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBE2206B9;
        Tue,  5 May 2020 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588681064;
        bh=bfdG2Z2jSgxqFge6DMBuiuW/QwY8D6K/rHpHUmAX5x0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xp486BAlXWrtsD9sRsErCIW+MVk/8Bnv/VDJoUSddzD20smRnQooLV1twJ1KTTMwL
         qVRZYhm71T7MwR5IWiL13sinqTBtj9q/KT9GHIwQ8Ai18eNRxy0NtBodXsttsQ0cio
         690jwwTXk0q3xKKqF355EW1Iyd4H6YBMGj50ns1c=
Date:   Tue, 05 May 2020 13:17:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
Subject: Re: [PATCH 0/5] Grab bag with AMD SPI fixes
Message-Id: <158868106200.51760.1618031684869987217.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 May 2020 13:12:00 +0200, Lukas Wunner wrote:
> Here's an assortment of drive-by fixes for the new AMD SPI driver.
> All of them are compile-tested only.
> 
> Lukas Wunner (5):
>   spi: amd: Fix duplicate iounmap in error path
>   spi: amd: Pass probe errors back to driver core
>   spi: amd: Drop duplicate driver data assignments
>   spi: amd: Fix refcount underflow on remove
>   spi: amd: Drop superfluous member from struct amd_spi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/5] spi: amd: Fix duplicate iounmap in error path
      commit: 2b60c49f3ca0648c5b02b60dc0f5b9e2c274bfb5
[2/5] spi: amd: Pass probe errors back to driver core
      commit: cc17fbec2e785926dafce65d014f8301847dff40
[3/5] spi: amd: Drop duplicate driver data assignments
      commit: 4332ea8f40c80d51a534f194291bf3b7738a7beb
[4/5] spi: amd: Fix refcount underflow on remove
      commit: 7b9c94bd13cc9dc9c0c4932ebacf756ae612d52a
[5/5] spi: amd: Drop superfluous member from struct amd_spi
      commit: 36c72a58d472b4032e09f165ea064a0251c9df07

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
