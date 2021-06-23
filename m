Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73733B1E4A
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWQLl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 12:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWQLk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8B446102A;
        Wed, 23 Jun 2021 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464563;
        bh=bOVsSWZOWPwWjIygRzUXx6bADV+DwhY//u9cvEOSFz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L73/0MuegwZuHAChajYH8mmfAdsTFzk7CDpNsQc27xRMxYkQvDgubxqBN4vDmYQ7A
         ns1B8FXxU6Bea40uYaH9bpqlvxlPaa4x1d6KHx/inNqmsBkfrPpdSmVVE9efEqr4WI
         0u4OX0QXjja63j3sBDnQbVBXrAYZFcmI24Oi2pXDGhJoERKNZccldDAVh4JHbwsCLF
         QxH/jJGl+er/QvnM7layxjd1+7MbUVAKBrxEr9rWpQ9C1mtGHGqqzqzuNj3rY9fW5T
         acK3347FMiQZtVLwhEy4bdBPE1acNnbhvcicCvifXb/2I0+kUmjKXbm98QiKTi8HpR
         kTlcNz9OyA2aw==
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/6] Support ROCKCHIP SPI new feature
Date:   Wed, 23 Jun 2021 17:08:49 +0100
Message-Id: <162446446390.55587.6401502942889105025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621104800.19088-1-jon.lin@rock-chips.com>
References: <20210621104800.19088-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Jun 2021 18:47:54 +0800, Jon Lin wrote:
> Changes in v10:
> - The internal CS inactive function is only supported after VER 0x00110002
> 
> Changes in v9:
> - Conver to use CS GPIO description
> 
> Changes in v8:
> - There is a problem with the version 7 mail format. resend it
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
      commit: c58c7e9bf55ced301fdd9c8c1841361cc5fc8458
[2/6] spi: rockchip: add compatible string for rv1126
      commit: 0f4f58b847b23d79185ad20ecf629c9f913f4f41
[3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
      commit: 4a47fcdb5f8b220a396e896a4efed51c13e27d8b
[4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
      commit: 2758bd093ac35ca5b62dbecfd30dab60e8b59790
[5/6] spi: rockchip: Support cs-gpio
      commit: b8d423711d1870c5e1280d5bbb0639fe6638a60e
[6/6] spi: rockchip: Support SPI_CS_HIGH
      commit: 736b81e075172f1e6cd7a8bc1a1374a2dee9e4dc

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
