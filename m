Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E92D4BD2
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbgLIU3c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbgLIU3X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 15:29:23 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20201206011817.11700-1-damien.lemoal@wdc.com>
References: <20201206011817.11700-1-damien.lemoal@wdc.com>
Subject: Re: [PATCH v3 0/3] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC
Message-Id: <160754571619.44147.530194118865445386.b4-ty@kernel.org>
Date:   Wed, 09 Dec 2020 20:28:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 6 Dec 2020 10:18:14 +0900, Damien Le Moal wrote:
> The Canaan Kendryte K210 RISC-V SoC includes a DesignWare apb_ssi V4
> SPI controller implemented with a maximum data frame size of 32-bits
> (SSI_MAX_XFER_SIZE=32 synthesis parameter).
> 
> This series of patches adds support for this SoC by implementing support
> for the 32-bits xfer size configuration. This is done in patch 2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
      commit: 7b14a272f9ac2438a85e59571fdb5a653d86430b
[2/3] spi: dw: Add support for 32-bits max xfer size
      commit: a51acc2400d47df0f87e1f011c63266421c594b9
[3/3] spi: dw: Add support for the Canaan K210 SoC SPI
      commit: b0dfd948379c79b8754e224e29b99d30ce0d79b8

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
