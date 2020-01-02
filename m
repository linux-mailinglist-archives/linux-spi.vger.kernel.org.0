Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686C212E703
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 15:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgABOEw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 09:04:52 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:59766 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgABOEn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 09:04:43 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id lS4g2100N5USYZQ01S4gmy; Thu, 02 Jan 2020 15:04:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-GR; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eX-I8; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/6] spi: rspi: Add support for multiple native chip selects
Date:   Thu,  2 Jan 2020 14:38:21 +0100
Message-Id: <20200102133822.29346-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RSPI variants on some SuperH or R-Mobile SoCs support multiple native
chip selects. Add support for this by configuring the SSL Assert Signal
Setting.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9eabef3d6cc478ff..2f5a856a93192702 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -159,7 +159,7 @@
 #define SPCMD_SPIMOD_DUAL	SPCMD_SPIMOD0
 #define SPCMD_SPIMOD_QUAD	SPCMD_SPIMOD1
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
-#define SPCMD_SSLA_MASK		0x0030	/* SSL Assert Signal Setting (RSPI) */
+#define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
@@ -933,6 +933,9 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
 
+	/* Configure slave signal to assert */
+	rspi->spcmd |= SPCMD_SSLA(spi->chip_select);
+
 	/* CMOS output mode and MOSI signal from previous transfer */
 	rspi->sppcr = 0;
 	if (spi->mode & SPI_LOOP)
-- 
2.17.1

