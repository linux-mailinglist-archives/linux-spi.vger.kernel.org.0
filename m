Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9920C41F898
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhJBAS2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 20:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhJBAS1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5002C61A50;
        Sat,  2 Oct 2021 00:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133803;
        bh=FAHNruiPBJHkiOhP3ADabNJIv3piS44QSqgeKIUNfSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovWmlxMB+/E4sFlSgLK7AWNWp54y6ZOi8anXMV+m0rSAZgZLD1Q93pFGVkfoGbRts
         Yg4oEcGsHDrQ3/kipA4MaYClEerX43vG5VBPfv9I62gK3+ulBzB3CeMqXjD1Bd89Gk
         tm5dMc15aQrHhpe9X4lqJP7+UKHe1RHPJCERVLLC/PywdmHXrFMr931ogeeWdns20P
         OYkgx59MWmo/egCvNwG6A2MooKaWCZPm8HUivGgQsM9M+Qw5T6b2IQqjRKMPGghw1N
         XRlkV0JNCjvZdk4EAiekC9lM+pY/GpKMW/MmszkKFlex32TS27MyGbK3vKmu5WlsqR
         7I2OKfDgEcqEg==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ville Baillie <villeb@bytesnap.co.uk>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4] spi: atmel: Fix PDC transfer setup bug
Date:   Sat,  2 Oct 2021 01:16:24 +0100
Message-Id: <163313375302.13893.9699202705978455237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921072132.21831-1-villeb@bytesnap.co.uk>
References: <20210921072132.21831-1-villeb@bytesnap.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Sep 2021 07:21:32 +0000, Ville Baillie wrote:
> Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
> method") refactored the code and changed a conditional causing
> atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
> driver to silently fail.
> 
> This patch changes the conditional to match the behaviour of the
> previous commit before the refactor.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Fix PDC transfer setup bug
      commit: 75e33c55ae8fb4a177fe07c284665e1d61b02560

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
