Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7501B2AF563
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKKPsS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 10:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbgKKPsQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:48:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5563A20709;
        Wed, 11 Nov 2020 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109695;
        bh=4FyYTPrcjfov8uVxWO+lV4RZNcUdpL+czV3Jpu9qS10=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qiHrtdno+fnP8pYUypCfv+DIuk1Rg61uPTCTX92SF2sunsczkVW3Fz1OUgAUG1RME
         ATeWDxPQ/mGskCFYM2YrgWcIJcnhVkHdFJ2IwhbuMoxh2zIzf4QwJ+OHJWrZL8NwSL
         qgbX8yHRES4ko9hpfRW3sMXAaKmm0pThNKnvbEDk=
Date:   Wed, 11 Nov 2020 15:48:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        David Jander <david@protonic.nl>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027095724.18654-1-o.rempel@pengutronix.de>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] SPI/ Input: ads7846: properly handle spi->mode flags
Message-Id: <160510968063.12304.8588707844414426791.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Oct 2020 10:57:22 +0100, Oleksij Rempel wrote:
> changes v2:
> - add SPI_MODE_X_MASK macro
> - ads7846: clear SPI_MODE_X_MASK bits to set driver specific mode.
> 
> Oleksij Rempel (2):
>   spi: introduce SPI_MODE_X_MASK macro
>   Input: ads7846: do not overwrite spi->mode flags set by spi framework
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: introduce SPI_MODE_X_MASK macro
      commit: 029b42d8519cef70c4fb5fcaccd08f1053ed2bf0

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
