Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD52E8034
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgLaNbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 08:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgLaNbB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 31 Dec 2020 08:31:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BC47223E8;
        Thu, 31 Dec 2020 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421421;
        bh=1JDPYS3ihLPHyM4tLMRmn+UG7cyoF+sYLY0WHFFxA2I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bkj6IQzfOWKbbd7MtpMuuMvB1YlLN/LPYFB08zG280q1mCK782R5LfPNfmbIVLgTe
         SgHHsJpmFYVGsKZrAygS+nkJpIh8lv2Xup3Cn0hhG57inQM6P5YHFqFgpLl2tycIW7
         EMErk1+eemgm+1c9xSmYD4F3jkHiEMPOKYnoqeSRpTWsaRw96bw2e9YpeWdv/ZKUi9
         OqGstcrk4HVRl1dYivUF4crWuCbjP4z+tz2NnDmWvFgR8OUbpcbu5GuWB9C/3Q729Z
         rR6kb0HbEqNSGic3upP5WI4Ap8vnqBoCDr5qA4Q/0BYNxuC7L1yx6rIkzKI6VwctfL
         WCC+7PKpe3j7w==
From:   Mark Brown <broonie@kernel.org>
To:     geert@linux-m68k.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201216092321.413262-1-tudor.ambarus@microchip.com>
References: <20201216092321.413262-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: Fix the clamping of spi->max_speed_hz
Message-Id: <160942139227.56552.10180693102119888422.b4-ty@kernel.org>
Date:   Thu, 31 Dec 2020 13:29:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Dec 2020 11:23:21 +0200, Tudor Ambarus wrote:
> If spi->controller->max_speed_hz is zero, a non-zero spi->max_speed_hz
> will be overwritten by zero. Make sure spi->controller->max_speed_hz
> is not zero when clamping spi->max_speed_hz.
> 
> Put the spi->controller->max_speed_hz non-zero check higher in the if,
> so that we avoid a superfluous init to zero when both spi->max_speed_hz
> and spi->controller->max_speed_hz are zero.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix the clamping of spi->max_speed_hz
      commit: 6820e812dafb4258bc14692f686eec5bde6fba86

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
