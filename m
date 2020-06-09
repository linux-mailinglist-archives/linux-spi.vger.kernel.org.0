Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF351F3B2B
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFIMyu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 08:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgFIMyt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jun 2020 08:54:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C2720820;
        Tue,  9 Jun 2020 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591707289;
        bh=2MPHkxwzXyONifMaPM7sXNmQR9wT77/yj06LmZf+Jb0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DIF86yhHwT5I1CvFf89UUgertwlbpk7lVYisk5QSauuw25o1Kd87gyzW33YCHVIie
         d++esUMQkMN4rq8pFAPrfipMQGPh6IJKxfwFfssjVA0s++m6B8aTzQCbvMnadJSdQ+
         UmFD/RQ+0c0bouWh2xAGKWoTLT71ufcrQLQKwTus=
Date:   Tue, 09 Jun 2020 13:54:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Subject: Re: [PATCH 0/8] spi: rspi: Bit rate improvements
Message-Id: <159170728714.39829.17212206680435918911.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Jun 2020 11:59:32 +0200, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch series contains several improvements for the Renesas SPI/QSPI
> driver related to bit rate configuration.
> 
> This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
> using a scope and logic analyzer, except for the by-one divider on QSPI.
> This has not been tested on legacy SuperH, due to lack of hardware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rspi: Use requested instead of maximum bit rate
      commit: e0fe70051f12c25c4afb04cb10ca8648c6e761cf

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
