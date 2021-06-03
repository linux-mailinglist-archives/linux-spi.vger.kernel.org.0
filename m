Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6A39AA3C
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jun 2021 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFCSoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Jun 2021 14:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSoH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA21C613F1;
        Thu,  3 Jun 2021 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745742;
        bh=xKaG2pH2TD0bHEMiFecF7yskodJI26NYH6Xk5pWAnhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYH5KbYIbW6PQNNvZb9WEAvDTUmjCz8Y/0IA+7jcVKz2kinNk+XUCLneNstQtpGpX
         6cGi9lMCRBskuekHWyQpZb0zu64T/hGL5r9nToj+/r/geB9lPG3ico1WIpLZTZ3Iwb
         D/O/oOb/yfxByowy9YK+UxETIhQaL7lDi8UNx2s2f5YnaJaZO/0hWg95JcE0gCsIoj
         AeIwRrZLTB/jCzHpJABplafXvdGYNAS0Cu8UFfs2MO9LGUa0R5WnxyS8H7CH3w4Vyn
         KUcz/tLzJMp764RU/tSIQi9/8wxsULbOt04yKL4zQ+PvJiwRVUud7VxDCR3fav5/cX
         fYdeoxl5+1ixw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, Dan Sneddon <dan.sneddon@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/2] spi: atmel: Switch to transfer_one transfer method
Date:   Thu,  3 Jun 2021 19:41:46 +0100
Message-Id: <162274571327.15050.7169168930168648183.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602160816.4890-1-dan.sneddon@microchip.com>
References: <20210602160816.4890-1-dan.sneddon@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 2 Jun 2021 09:08:14 -0700, Dan Sneddon wrote:
> Switch from using our own transfer_one_message routine to using the one
> provided by the SPI core.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel: Switch to transfer_one transfer method
      commit: 5fa5e6dec762305a783e918a90a05369fc10e346
[2/2] spi: atmel: Reduce spin lock usage
      commit: 4abd641501663493764949f045ebf9f8c0da0307

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
