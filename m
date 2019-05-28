Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743742C99E
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfE1PHa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 11:07:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfE1PH3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 11:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LoZEWGcak24f+2R8BSnDVZaJoSe5u7tIU54xxb61pjk=; b=lVMVifvy8qRU
        HQ36W9DZRRRfMc6MRaTrRKwZKo++pYkdrUF7BX8C01jv7YIVGLalDRUwvpG7qnRNv9AuDDbRLbeHQ
        iTUyVEbHQAQPXM48oOmiyLp8bBI/NYZJAck+xkpSofr45TfxAVjpLQS5SWTn3EUo9i1aWjmus4eVR
        5UTxM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVdhE-0002qV-3i; Tue, 28 May 2019 15:07:24 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 46DD7440046; Tue, 28 May 2019 16:07:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Applied "spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()" to the spi tree
In-Reply-To: <20190527121935.5370-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190528150723.46DD7440046@finisterre.sirena.org.uk>
Date:   Tue, 28 May 2019 16:07:23 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 635bdb7a3e1fe1531573ff87b92c2506adafe7f7 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 May 2019 14:19:35 +0200
Subject: [PATCH] spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While the Hardware User Manual does not document the maximum time needed
for modifying bits in the MSIOF Control Register, experiments on R-Car
Gen2/Gen3 and SH-Mobile AG5 revealed the following typical modification
times for the various bits:
  - CTR.TXE and CTR.RXE: no delay,
  - CTR.TSCKE: less than 10 ns,
  - CTR.TFSE: up to a few hundred ns (depending on SPI transfer clock,
    i.e. less for faster transfers).
There are no reasons to believe these figures are different for
SH-MobileR2 SoCs (SH7723/SH7724).

Hence the minimum busy-looping delay of 10 µs is excessive.
Reduce the delay per loop iteration from 10 to 1 us, and the maximum
delay from 1000 to 100 µs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6aab7b2136db..b50bdbc27e58 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -229,7 +229,7 @@ static int sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
 	sh_msiof_write(p, CTR, data);
 
 	return readl_poll_timeout_atomic(p->mapbase + CTR, data,
-					 (data & mask) == set, 10, 1000);
+					 (data & mask) == set, 1, 100);
 }
 
 static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
-- 
2.20.1

