Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94D42F665C
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 17:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhANQuK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 11:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbhANQuK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 11:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2065923B40;
        Thu, 14 Jan 2021 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610642969;
        bh=kh+EMdAVaiZX6MYoUtUwlmZYZYChel/nYSoIGsGDHWc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Y1WPlKYggloBG6xjslS6XpLMsjDmQcnRwHI2fMOYiYDBqvtOEKrtJZq/MfHSY+Qpw
         Olr2oQBzHJd8hPTABZ29nRF9wdZTv03ryCkN/cGYQp/Z5K7mRTjF5WO/AHDqlvYoi3
         F0mwzY3mJQhWZPWysaojJwnsrozWR9UHOLnBlgYmFWDqpqWgky6Crp+OSm3tuhHz8l
         FvjfQBdLYhFDeA1P+yrVxQSq82VwL9WNUwNHYb3l3y1B7c9IueNlKfueGzwv1NWD4l
         2KtcQvvInTpjpedGbQKqXsLg2igSJugMX1s6V92ZNM0P4MmXmdGlRhkQgUoesa835H
         3PyJ5Kh1KsdDg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Scott Branden <sbranden@broadcom.com>
In-Reply-To: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
References: <20210107235832.839221-1-plr.vincent@gmail.com> <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
Subject: Re: [1/3] spi: bcm2835: Call the dedicated transfer completion function.
Message-Id: <161064292108.43781.9781211725257862178.b4-ty@kernel.org>
Date:   Thu, 14 Jan 2021 16:48:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Jan 2021 23:58:30 +0000, Vincent Pelletier wrote:
> spi_finalize_current_transfer currently only calls "complete", so no
> functional change is expected.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: bcm2835: Call the dedicated transfer completion function.
      commit: ccae0b408ba08203d5f50a301b105284374217a5
[3/3] spi: rockchip: Call the dedicated transfer completion function.
      commit: 6bd2c867cd6e03d88dfa21f9fc8c610159061152

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
