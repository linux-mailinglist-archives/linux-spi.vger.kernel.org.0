Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9F2F4EB8
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAMP3u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbhAMP3u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:29:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF0332339F;
        Wed, 13 Jan 2021 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551749;
        bh=tigmSALSmnpPhwSMEXEk1CkqDvI2zvR/FIet9q8saxs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MoKBqM/0cAcRdDNmglVs+rFdRPUNbzgcXYCqbrdI0E8S7QxdvYgDlOI+H5/EMcuwM
         bxDx42I8DuZCQKpR34X1vfjGwAUecMfNeTynJiV/t3TZ9U+wQ5bpquctU7F9aIClX9
         2rbjacg/OlVcf01A7TzO6TXp0E49uU3KaYvyyRfhpVcurQc6PpKzpyGstOh0K3ToYJ
         25fczjxS9wZCXQbAlYTdHA6cE8OzAa/KFCmBPlrojktAMXvKZKz1hLoIRXk8mBETlM
         CQuA4Iz6WKlS2qfshnANjPSgAkJRyiaA0MYKhl6ARPFryq54zanQks0Z+S7zSRa3d0
         PGVGIkwD4Cmyw==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20210113101916.1147695-1-geert+renesas@glider.be>
References: <20210113101916.1147695-1-geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] spi: sh-msiof: Advertize bit rate limits and actual speed
Message-Id: <161055171029.21847.2841921385275436977.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Jan 2021 11:19:14 +0100, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch series makes the Renesas MSIOF SPI driver fill in actual
> transfer speeds and controller limits, so the SPI core can take them
> into account.
> 
> This has been tested on R-Car Gen2 and Gen3.
> Thanks!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: sh-msiof: Fill in spi_transfer.effective_speed_hz
      commit: 9a133f7b72f0b8d8896cbc7e4149c763b59168bb
[2/2] spi: sh-msiof: Fill in controller speed limits
      commit: 81f68479ec4ec91c0b0d7fb20db433be28e00497

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
