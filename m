Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BF318F0A
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhBKPoF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 10:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBKPl4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Feb 2021 10:41:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80F7A64E9A;
        Thu, 11 Feb 2021 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613058052;
        bh=KQNzTZZgEk2YLxXuy5hmyB3R3k6WHpCdU4PEwQbAo3o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V3sRrr1ZDTgVDtJ2VMo0baraI1RWjmzWu7ZZvZ2FRmT92fm+KChq1Bl1FwaHIQt9O
         22xLSW6Kx9k0yD8/Uugd5nQaIZZD43A5eqxSbvfVst0S6Wl/ADFbRGgPzOtYl8HaHe
         zM/ZBJQPCQaixM9BCMlPQpdpx01BMyqFidtqfRgbzb+4Baq3ZXm1C623L5JMuWNzGl
         V9oAyIpaWOdGE4jqvXQR0HmyKS+soqrvGjng9WoJWw1Q2coYuqKubJ0x1lfn9gFzuv
         RdNqntMBkOLdYiofE/aL76t1NGR1kN8skbjYN/GNRtwqS23LvifNNMuPqvynFaOAcj
         2ut+sj/4RyJdw==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-spi@vger.kernel.org, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210210135428.204134-1-tudor.ambarus@microchip.com>
References: <20210210135428.204134-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Disable the QSPI IP at suspend()
Message-Id: <161305799890.12648.15037245423068627644.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 15:39:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 10 Feb 2021 15:54:28 +0200, Tudor Ambarus wrote:
> It is safer to disable the QSPI IP at suspend, in order to avoid
> possible impact of glitches on the internal FSMs. This is a theoretical
> fix, there were no problems seen as of now. Tested on sama5d2 and
> sam9x60 versions of the IP.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Disable the QSPI IP at suspend()
      commit: df6978b7ea6349eb32078c42b917559f5510aebd

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
