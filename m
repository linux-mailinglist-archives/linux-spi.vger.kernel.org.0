Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400462EBFFF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFPAY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 10:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFPAY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 10:00:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F05FC22B45;
        Wed,  6 Jan 2021 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609945183;
        bh=9N8TfJsEA7J2oir+XxY6pt6ih2/gDFppXOSBqjRFQOs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LQs3UkTF5XQpfKOdKGHBK3cwfbvmsE0Ls7v4mQkI4g4TSuZFkqTfWOpneqE5DLMDJ
         BrKEH8mGCJkLuIwswM8W5kkgRZikYv8MOWSPASgB4CkKd1wtRtRLv6X3FpOEwLNz97
         h8FtG0cbhqHEHKTVvU0cecybvehPnYzC1VwsEiIsh7Q7UFsGDO1xn7PJv8ffJES8Mo
         D3S4PGchojs+uFaWGgdJ9kigr54BsB6cymwSPv3NyaynRkXQTZ2qqDpYzym6zKke15
         yD2qaCWdx52rKAQEQnfZKpSim0y1eCmpNilRiAZQV+B9JO2MFn3xi5PCfipmJePwJO
         Yusqz6Qij+OvA==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com, lukas@wunner.de, robh+dt@kernel.org,
        jonathanh@nvidia.com, Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     devicetree@vger.kernel.org, tudor.ambarus@microchip.com,
        bbrezillon@kernel.org, linux-tegra@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
Subject: Re: (subset) [PATCH v5 0/9] Add Tegra Quad SPI driver
Message-Id: <160994515510.52247.6457410235851345560.b4-ty@kernel.org>
Date:   Wed, 06 Jan 2021 14:59:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Dec 2020 13:17:30 -0800, Sowjanya Komatineni wrote:
> This series adds Tegra210, Tegra186, and Tegra194 Quad SPI driver and
> enables Quad SPI on Jetson Nano and Jetson Xavier NX.
> 
> QSPI controller is available on Tegra210, Tegra186 and Tegra194.
> 
> Tegra186 and Tegra194 has additional feature of combined sequence mode
> where command, address and data can all be transferred in a single transfer.
> Combined sequence mode is useful only when using DMA mode transfer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
      commit: b499779761278d6f5339daa230938211d98861ef
[2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
      commit: 9684752e5fe3989b45f686a4e0202a683038be4a
[3/9] MAINTAINERS: Add Tegra Quad SPI driver section
      commit: e5c92bb924ce4bda9c4312b8596cf62ad7b07e2e
[4/9] spi: tegra210-quad: Add support for Tegra210 QSPI controller
      commit: 921fc1838fb036f690b8ba52e6a6d3644b475cbb
[5/9] spi: spi-mem: Mark dummy transfers by setting dummy_data bit
      commit: 98621ed011c57ba6e52e01a5982b221c9943b6d9
[6/9] spi: tegra210-quad: Add support for hardware dummy cycles transfer
      commit: 6a8a8b51703c69fa2d6adbbcbf731ce9b991c696

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
