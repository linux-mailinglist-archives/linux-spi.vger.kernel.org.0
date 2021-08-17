Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A590C3EEE65
	for <lists+linux-spi@lfdr.de>; Tue, 17 Aug 2021 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHQOXb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Aug 2021 10:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhHQOXb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Aug 2021 10:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7758260FD7;
        Tue, 17 Aug 2021 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629210178;
        bh=6FJLsHWGhCXNnGMIy1qZpzrJFMhBYFoGAIzuJAUWN4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZFC3jWYXQYZ0MkWa+cX5aDIJ/wGtkLimDf8ewNNLwjx99Ar5roxN0hls+7n2A3KZ
         qNzQ/l6GTw8+H7I7Mw/Xvmdt9imB4HwiAoCFPxLgV3h0x80eV5OGk0duC5hk8HRSbU
         0foyZnVTWKwTKnCsSLsbVY8Hb2v9yvXe8LGmacLAGzRIYbjRO34EE8uKwT77860FrO
         PJOgVQw2w71NcsbETJ4K6qm3WJUQcSO0+kKpefgFC0wNXsiEy8dAnU7tadHwwv99tD
         qb/gpm/J6n4Ko1+2ZgdMiE9ZRxK5VYrs01za8l9Umb+zoSslFzkHF5qKdrqFttlaLl
         rabOOaFTYkusQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, hjc@rock-chips.com,
        linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        sugar.zhang@rock-chips.com, yifeng.zhao@rock-chips.com,
        robh+dt@kernel.org, heiko@sntech.de, p.yadav@ti.com,
        macroalpha82@gmail.com, linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v13 0/6] Add Rockchip SFC(serial flash controller) support
Date:   Tue, 17 Aug 2021 15:22:32 +0100
Message-Id: <162921014496.3711.7793277648760166515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210812134546.31340-1-jon.lin@rock-chips.com>
References: <20210812134546.31340-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 12 Aug 2021 21:45:40 +0800, Jon Lin wrote:
> Changes in v13:
> - Provide independent interfaces to obtain RX TX FIFO status respectively
> - Add more debug information
> - Depress DMA limitation
> 
> Changes in v12:
> - Remove useless oneOf lable
> - Add sfc controller discription
> - Remove the limitation of SFC_MIN_SPEED_HZ
> - Add IRQ_NONE method for irq handler
> - Add SPI_MASTER_HALF_DUPLEX flags
> - Add sfc interrupt mask bits and status register initial progress
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
      commit: 538d7c2ed73098850fe80be14eed2739d37e419b
[2/6] spi: rockchip-sfc: add rockchip serial flash controller
      commit: 0b89fc0a367edab09065af722894d186bd0ccb0d

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
