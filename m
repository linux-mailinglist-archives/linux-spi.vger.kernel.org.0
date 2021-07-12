Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BC3C5AF0
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhGLKtv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhGLKtq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9BB0610CD;
        Mon, 12 Jul 2021 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086818;
        bh=QnOSbClophtpi3Z4SUtpJN9si6VKstW5mU2tbr2eog8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyqHWXyUma1sEpuzng/VqVYmcJSeuaWCL4P7E94Q93+m6wpoD7rRqOiuha8aCEcKZ
         6zcuhfgCnMFkUFc23IkPUgyCysWE885ywgyLE1VyIQn969as6LSs54Ty5/HCD7Z7k6
         XPrKP7UsKAELHUur2NE+ZBaiE5W/D+1m7yuNQtZfWO1+RxBQwQKMGNmMiqB5P6CJva
         7PY1lp3zA+5CcuQpBBCEAZ8Zj1uxJVe4v7cLa2xvRIF3mf0POyVKIF059JZfmBm5s9
         X6NYX7U5CUkmOThYS3/XkcNyG9E5BA+Tr6pXvDO0HDPXisXoH8Y09HSfwM2+hSuYq4
         Dwr5tits4+w4w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Sneddon <dan.sneddon@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] spi: atmel: Fix CS and initialization bug
Date:   Mon, 12 Jul 2021 11:45:42 +0100
Message-Id: <162608669456.4543.2373510962331003503.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629192218.32125-1-dan.sneddon@microchip.com>
References: <20210629192218.32125-1-dan.sneddon@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 29 Jun 2021 12:22:18 -0700, Dan Sneddon wrote:
> Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
> method") switched to using transfer_one and set_cs.  The
> core doesn't call set_cs when the chip select lines are gpios.  Add the
> SPI_MASTER_GPIO_SS flag to the driver to ensure the calls to set_cs
> happen since the driver programs configuration registers there.
> 
> Fixes: 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer method")

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Fix CS and initialization bug
      commit: 69e1818ad27bae167eeaaf6829d4a08900ef5153

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
