Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B22F6656
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbhANQt4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 11:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbhANQty (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 11:49:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F088F23B1C;
        Thu, 14 Jan 2021 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610642954;
        bh=U0sUa3xcw+nv1r0BXLuDbjLhcPC9SFZOwZMxI/KdD18=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=emFi/wRHv5ubdJF5628DkJv6eLXUljJ8BAW4RShoa60ykQH8J2E4whvZjX74yAnxm
         eZ4QOe4oO+bitt8xiY+D7ecq3cTdZMVyy61NrSpxtSyccEd5JvCJSfu21fHpDqS7bl
         ecOWws+/6t/KeR/AO3fN1bA3pWHZe51wPRaweguUFP6Kp3Fj92h5qW+pNYAFXOAx0g
         Ef3NZMs8EToNJjazAvIVBiGepVk/LZjGC3rrkQrTPakdarBtVwtkVlaKqzRMMTtR6/
         1MNe+bwbWfbUSgGf5p/IA3+Qm55Vz+Ewn0V6/P606f5BYR8C4LVhwGnxNx7ttZtK0Y
         ytHMOJ9EwgK1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Scott Branden <sbranden@broadcom.com>
In-Reply-To: <2636096a3b40febf680f9fff33944a5480561df9.1610062884.git.plr.vincent@gmail.com>
References: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com> <2636096a3b40febf680f9fff33944a5480561df9.1610062884.git.plr.vincent@gmail.com>
Subject: Re: [2/3] spi: bcm2835aux: Call the dedicated transfer completion function.
Message-Id: <161064292108.43781.4666703203666297942.b4-ty@kernel.org>
Date:   Thu, 14 Jan 2021 16:48:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Jan 2021 23:58:31 +0000, Vincent Pelletier wrote:
> spi_finalize_current_transfer currently only calls "complete", so no
> functional change is expected.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: bcm2835aux: Call the dedicated transfer completion function.
      commit: 7dfa69af2b5a57fcd48c96752818c1fa9925a8de

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
