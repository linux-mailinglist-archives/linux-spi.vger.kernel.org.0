Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D921724C751
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHTVtG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 17:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgHTVtF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 17:49:05 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FC921734;
        Thu, 20 Aug 2020 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960145;
        bh=ReZwAAZm3UOKz42MdCB4u+6ks2mEXqu90QQhuiu2Gc8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zH+ygSPbibxF8P17B7l0NpvdtpBXDc8s59z9eKsIh/tRh8wwbeljySYeqYi4aAunc
         Mv5Hz27gSlcNma4B2gvRi2wSWcmuFpUFLT8cx3IvWF0rA1AxPIa+UpkDZgU+SN/jNg
         j2ZgIxoGtLz0plWcriOkmDX9Jc67/+c05aLhP/7Q=
Date:   Thu, 20 Aug 2020 22:48:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
Subject: Re: [PATCH v2 0/7] spi: rspi: Bit rate improvements
Message-Id: <159796010778.44514.12060590763849397055.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Aug 2020 14:58:57 +0200, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch series contains several improvements for the Renesas SPI/QSPI
> driver related to bit rate configuration.
> 
> Changes compared to v1
> (https://lore.kernel.org/r/20200608095940.30516-1-geert+renesas@glider.be):
>   - Drop accepted patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: rspi: Remove useless .set_config_register() check
      commit: 7ffe363bb2a25f0760127657f88243647f49bd5c
[2/7] spi: rspi: Clean up Bit Rate Division Setting handling
      commit: 8dd71698607f822c3675c366a8a79bc82f7621f8
[3/7] spi: rspi: Increase bit rate accuracy on RZ/A
      commit: feace90233a8cd44a18902216657279c3932d471
[4/7] spi: rspi: Increase bit rate range for RSPI on SH
      commit: 4e71d926abbe9ec23415f2ec8685a7bc26c1ceed
[5/7] spi: rspi: Increase bit rate range for QSPI
      commit: 6a195f24f3e88b9242268da79547fe4a61f30910
[6/7] spi: rspi: Fill in spi_transfer.effective_speed_hz
      commit: cb588254140802dbef0b29e4d0a1212cbe5e61e3
[7/7] spi: rspi: Fill in controller speed limits
      commit: c31979747b7090e8d255caecf5bb314436dd90ef

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
