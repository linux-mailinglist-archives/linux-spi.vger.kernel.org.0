Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A22C0F38
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgKWPqd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 10:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgKWPqd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 10:46:33 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2212080A;
        Mon, 23 Nov 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606146392;
        bh=uFXizMsOcVj6m8x/dC8hl3bI1e0YaciGymvQWesAjnc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iMhjm7hNCcc8s6eyNdUB8mVNxJ7fR1PFXlENL5WDZs1g2Jwv64oiU6sRgoEhoTJCK
         Cxk7G1tMXGQUId7Ht62UTSHy+iYjlViDgWadCI1bIqJftRYD/duzdzpHnYpa+Lv/yK
         eViGuGtgtdOpzla2e7/M1KUqE1foucoKAqj+Q+Io=
Date:   Mon, 23 Nov 2020 15:46:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201123025715.14635-1-ran.wang_1@nxp.com>
References: <20201123025715.14635-1-ran.wang_1@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts
Message-Id: <160614636910.30914.5128110420712253812.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 23 Nov 2020 10:57:15 +0800, Ran Wang wrote:
> Given the case that bootloader(such as UEFI)'s FSPI driver might not
> handle all interrupts before loading kernel, those legacy interrupts
> would assert immidiately once kernel's FSPI driver enable them. Further,
> if it was FSPI_INTR_IPCMDDONE, the irq handler nxp_fspi_irq_handler()
> would call complete(&f->c) to notify others. However, f->c might not be
> initialized yet at that time, then cause kernel panic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts
      commit: 71d80563b0760a411cd90a3680536f5d887fff6b

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
