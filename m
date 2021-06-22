Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A383B0867
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jun 2021 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhFVPQu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Jun 2021 11:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFVPQt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Jun 2021 11:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6152061289;
        Tue, 22 Jun 2021 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374873;
        bh=KS3KXpd8Dci6bRa37VEJAqaBu7XL57Vjx13ZSsmsgxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBmGF05M/wKQ0u7YNmBjoJANPJA8cwDOC/SzvktcvYkdEyWhR6gSiauo+ZJimMtcr
         KXJl8IjJdJgypXTcel33S1y6blaQwsGBlCUd6b3k70L4dkrZF+nuIE2yjfY34dACtK
         v0ySKBVvmpo4Yf+No6SgJqHc7txLPyhqig6bPweqPHsO1q+8NNJkv5U2c25x0m9mKX
         5eiNqieZDuraHJ2rcMWy+MzMWdJFV8qbN2gnu/Qrrj4o6TzHzWCbjR6SVduhebe/CG
         ha0V3aWCe1gGusbYB4gz8mwUlErJIZ5roPUgLNt9keul8eJyRoMv+uPFuF5Kefjit2
         hSJjMT1I+QYSA==
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, Ian Ray <ian.ray@ge.com>,
        linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCHv5 0/5] GE Healthcare PPD firmware upgrade driver for ACHC
Date:   Tue, 22 Jun 2021 16:14:02 +0100
Message-Id: <162437400237.2387.4945369084350111189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621175359.126729-1-sebastian.reichel@collabora.com>
References: <20210621175359.126729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Jun 2021 19:53:54 +0200, Sebastian Reichel wrote:
> The PPD has a secondary processor (NXP Kinetis K20), which can be
> programmed from the main system. It is connected to the main processor
> by having it's EzPort interface connected to the SPI bus. Currently
> both (normal and EzPort) interfaces are simply exposed to userspace.
> This does not work for the EzPort, since EzPort usage requires a device
> reset. The proper solution is to do the flashing from kernel space
> with properly timed toggling of EzPort chip-select and reset line. In
> PATCHv2 it was suggested, that this should happen via an SPI ancillary
> device, so this is how it has been implemented now.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: add ancillary device support
      commit: 0c79378c01999bd60057c475f163ec807c24891f
[2/5] spi: dt-bindings: support devices with multiple chipselects
      commit: d90609a4b72dbfe42da2a55f3078c35e669948e0

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
