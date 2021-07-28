Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0F3D9964
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jul 2021 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhG1X2N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Jul 2021 19:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1X2M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31FF961039;
        Wed, 28 Jul 2021 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514890;
        bh=pnFtFboIOn3p8gL7TUOKhv77bJPNbvh3pz0TzJ6aLYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlGDQ0V3CZCd7da3VU4cUuoYL87NOBj/dgVIkORNTLs47tWSVelVW4e33elZBv2cS
         u6SZ9TqfZlNF4vPM10LBPE/K3VZuthDCYRfZhbZDmuHpZMqeB+vdXb7z76G3ToKba2
         jZchSgTbPoGRqVHmzDOtfFks6i5XO7JKQ63NJuqgeeTMX4AzOlzrJeIp8Atr+4UqKG
         fS8fkG1qD16S0Up7djOUMhHZLlbs4pz6MF1r4x5+0JKXxkgMhpMMnK/K4f3Owe7Fqm
         V/ywmZUxejbbbxQN8oJr6VfKrkQ+KgdYRFtLU9jOgUaKdQJydwqKzLcchydbFDYOra
         6s1b96nFK7FqQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Date:   Thu, 29 Jul 2021 00:27:52 +0100
Message-Id: <162751436507.10613.9391364899039168790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726101502.6803-1-marex@denx.de>
References: <20210726101502.6803-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 26 Jul 2021 12:15:02 +0200, Marek Vasut wrote:
> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
> the min_speed_hz must above 222222. Update the comment. No functional
> change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
      commit: 36c2530ea963884eeb0097169f853fdc36f16ad7

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
