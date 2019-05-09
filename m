Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663CE183C8
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 04:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfEICbV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 22:31:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEICbV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 22:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sNbASCaFxX4qBVcQaeshn1ChOdIBFiLGoZST0aLrrbw=; b=V+ogtBCYM2Ne
        SZdD2K96ejcseHwzLEy5tRxTO47nCbgMYp1TKGJQI9kUDnQjtDlrGIRusvlu+tJfAtUA1WYFmlXQe
        vHqcf2Kn+C5pBfLrmQvdHJR7Ighk3ttXhMqyRMA0N/8ouARU0wiB6UpdYYSBfA+hHXnQgNdkNIjaZ
        MuxfM=;
Received: from [2001:268:c0e3:9e6d:fb20:4124:5afd:9c02] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOYpw-0001R6-0B; Thu, 09 May 2019 02:31:08 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 51BBA44000C; Thu,  9 May 2019 03:31:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: Applied "spi: Fix Raspberry Pi breakage" to the spi tree
In-Reply-To:  <20190509023005.19290-1-broonie@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190509023100.51BBA44000C@finisterre.sirena.org.uk>
Date:   Thu,  9 May 2019 03:31:00 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Fix Raspberry Pi breakage

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 0ed56252c9567351344cb7b5cff6140e1bcec943 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 9 May 2019 11:27:17 +0900
Subject: [PATCH] spi: Fix Raspberry Pi breakage

This reverts commit c9ba7a16d0f1 (Release spi_res after finalizing
message) which causes races during cleanup.

Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..8eb7460dd744 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1181,10 +1181,10 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);
 
-	spi_finalize_current_message(ctlr);
-
 	spi_res_release(ctlr, msg);
 
+	spi_finalize_current_message(ctlr);
+
 	return ret;
 }
 
-- 
2.20.1

