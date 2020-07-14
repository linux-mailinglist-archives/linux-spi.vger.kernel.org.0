Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C721F77C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNQkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 12:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgGNQkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 12:40:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7496D22518;
        Tue, 14 Jul 2020 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594744813;
        bh=5ROMkjndgTXBfRd8iNvaYi1+yKgNxf3IbZnmlJVZUIE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eJOIHq8tP1EqHl27xdM5g/trk8Z94WPTDIHKZvJBwbDi3UheUV7gZH6sCZCmhvU9T
         /ONV8HJJw2woP2n2D7DqQJXBnmVDMNg3tL3+3jQIDB3EA5CqCjQD4COUD/MS5fuZ0k
         Nb05ynAV8BWSB318JQGlrf7OSTd8ndAqzaLP/3fc=
Date:   Tue, 14 Jul 2020 17:40:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Sekhar Nori <nsekhar@ti.com>
In-Reply-To: <20200623183030.26591-1-p.yadav@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
Subject: Re: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Message-Id: <159474480413.1281.3968081256686085875.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Jun 2020 00:00:13 +0530, Pratyush Yadav wrote:
> This series adds support for octal DTR flashes in the spi-nor framework,
> and then adds hooks for the Cypress Semper and Mircom Xcella flashes to
> allow running them in octal DTR mode. This series assumes that the flash
> is handed to the kernel in Legacy SPI mode.
> 
> Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-mem: allow specifying whether an op is DTR or not
      commit: 4c5e2bba30e49b970a0fd07b43e0b7a3b5fd5ea7
[2/4] spi: spi-mem: allow specifying a command's extension
      commit: caf72df48be32c39f74287976ae843501ae06949
[3/4] spi: atmel-quadspi: reject DTR ops
      commit: 5c81c275582c9d9c66d2f928591a2065f2528231
[4/4] spi: spi-mtk-nor: reject DTR ops
      commit: 4728f073bfc66b8b555274ef0d7741d7f5a48947

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
