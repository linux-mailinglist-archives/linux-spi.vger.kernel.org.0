Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912392CA4BD
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgLAN7c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 08:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAN7c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:32 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7D2208DB;
        Tue,  1 Dec 2020 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831131;
        bh=ZF9xwEX02wFAkXjf4yY9/SPdkc3Y3tnZlXjjV9aCBZ4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rYrN8Ju17M1ogr3cZuE6eyz32fAxq8Ym/lwKyJ0LpAWNCEzFI0WdHlRWAGFsSRL9G
         PxzvHq3MEVxs0AClDKGbG/2Suwt9LidBEcdBiW5EFSLmAfBw8ooeTQhq/16uKHxfAS
         P64RhPKMMcf5v59Xgf/VfxCBIopNPXfb8po5FPGs=
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     olteanv@gmail.com, linux-spi@vger.kernel.org
In-Reply-To: <20201201085916.63543-1-fido_max@inbox.ru>
References: <20201201085916.63543-1-fido_max@inbox.ru>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR
Message-Id: <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Dec 2020 11:59:16 +0300, Maxim Kochetkov wrote:
> If cs-gpios property is used in devicetree then ctlr->num_chipselect value
> may be changed by spi_get_gpio_descs().
> So use ctlr->max_native_cs instead of ctlr->num_chipselect to set SPI_MCR

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR
      (no commit info)

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
