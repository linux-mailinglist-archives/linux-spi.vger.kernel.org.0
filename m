Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F771B569
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfEMMB0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 08:01:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfEMMBZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2U9UTMwlbnOzCVkVyvFY8C+ElBTGuKoTwgg7Mw8xZY4=; b=eI4NTkH0rPVT
        t+dYnZPZOHLPrehkcE0BqaA1mNwa9uPjQzJ/MObxrSCbQEEL3aMF4af9yA1wA244EABZQO+eLGft2
        U24ekzLQux2D3cf1VzU5+sF+HsCCpzfboOfFBjOb+8HzhJ2xiJujzb34QtIEvuKdDz13YpWy7If1A
        iTFk0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQ9dr-0006U4-MF; Mon, 13 May 2019 12:01:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0FFE344000C; Mon, 13 May 2019 13:01:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: core: Fix build" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190513120112.0FFE344000C@finisterre.sirena.org.uk>
Date:   Mon, 13 May 2019 13:01:11 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: core: Fix build

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

From 7ef39a69b9c6c84885a86eef4e4ba5c161c44366 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Sun, 12 May 2019 17:13:21 +0900
Subject: [PATCH] spi: core: Fix build

This reverts d5864e5bed96 (spi: core: allow defining time that cs is
deasserted as a multiple of SCK) as it breaks the build.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 8 --------
 include/linux/spi/spi.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cfa3c3decb8a..7e8ffe3fdc00 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1111,7 +1111,6 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 {
 	u32 delay = xfer->cs_change_delay;
 	u32 unit = xfer->cs_change_delay_unit;
-	u32 hz;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay && unit != SPI_DELAY_UNIT_USECS)
@@ -1127,13 +1126,6 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
-	case SPI_DELAY_UNIT_SCK:
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
-		 */
-		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
-		delay *= DIV_ROUND_UP(1000000000, hz);
-		break;
 	default:
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f55b20254612..c0b2a61bcced 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -831,7 +831,6 @@ struct spi_transfer {
 	u8		cs_change_delay_unit;
 #define SPI_DELAY_UNIT_USECS	0
 #define SPI_DELAY_UNIT_NSECS	1
-#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

