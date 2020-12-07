Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0A2D1779
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgLGRXG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 12:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgLGRXG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Dec 2020 12:23:06 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org
Cc:     ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, bugalski.piotr@gmail.com
In-Reply-To: <20201207135959.154124-1-tudor.ambarus@microchip.com>
References: <20201207135959.154124-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/4] spi: atmel-quadspi: Fix AHB memory accesses
Message-Id: <160736172966.53398.17804745115147014736.b4-ty@kernel.org>
Date:   Mon, 07 Dec 2020 17:22:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 7 Dec 2020 15:59:55 +0200, Tudor Ambarus wrote:
> Starting with the move of the atmel-quadspi driver under SPI,
> the following error could be seen when mounting a 16MByte ubifs:
> UBIFS error (ubi0:0 pid 1893): check_lpt_type.constprop.6: invalid type (15) in LPT node type
> 
> 1/4 fixes AHB accesses. The rest of the patches are small optimizations.
> Tested on both sama5d2 and sam9x60.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: atmel-quadspi: Fix AHB memory accesses
      commit: cac8c821059639b015586abf61623c62cc549a13
[2/4] spi: atmel-quadspi: Drop superfluous set of QSPI_IFR_APBTFRTYP_READ
      commit: a6ff3a784ff9975dc77676827a2f448203511d19
[3/4] spi: atmel-quadspi: Write QSPI_IAR only when needed
      commit: d00364b6a60475cd75fd07e847ad6f955952638b
[4/4] spi: atmel-quadspi: Move common code outside of if else
      commit: c066efb07d1e8b801ea9d0727119958c9904e63d

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
