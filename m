Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D571752F
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEHJfH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:35:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfEHJfH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cwjgt3LWAecjUe1gad06+8+vUQlYe5AecFK/x5RLNLc=; b=VW3Z0OU+M4kZ
        g/TC48/ZPWJAx0WNwGL+e4a8FvW4kFJWfJn2s2CqkJ8fgrK+qs99ZA2lCebdcoPo1VA94lm/fnkeZ
        8Axwtgk9UZdiD8av43/26dNqfn96XCwWYWagTCAM7ZHMltE2L0pd/hvi848xVAQTRcaHAjJEDsJAn
        cUEnQ=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIyZ-0007l8-QK; Wed, 08 May 2019 09:35:00 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7780444000C; Wed,  8 May 2019 10:34:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: core: allow defining time that cs is deasserted as a multiple of SCK" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190508093454.7780444000C@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:34:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: core: allow defining time that cs is deasserted as a multiple of SCK

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

From d5864e5bed96db7230da45463d6ae7af5b3b4399 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Sat, 23 Feb 2019 08:49:50 +0000
Subject: [PATCH] spi: core: allow defining time that cs is deasserted as a
 multiple of SCK

Support setting a delay between cs assert and deassert as
a multiple of spi clock length.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 8 ++++++++
 include/linux/spi/spi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7e8ffe3fdc00..cfa3c3decb8a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1111,6 +1111,7 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 {
 	u32 delay = xfer->cs_change_delay;
 	u32 unit = xfer->cs_change_delay_unit;
+	u32 hz;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay && unit != SPI_DELAY_UNIT_USECS)
@@ -1126,6 +1127,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
 	default:
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 023beb9e9e4b..e552a036cb4d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -831,6 +831,7 @@ struct spi_transfer {
 	u8		cs_change_delay_unit;
 #define SPI_DELAY_UNIT_USECS	0
 #define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

