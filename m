Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C572FED8F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbhAUOxt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbhAUOxe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jan 2021 09:53:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFEC061786;
        Thu, 21 Jan 2021 06:52:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v184so1781503wma.1;
        Thu, 21 Jan 2021 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAuOHqNvw5LrpRMcJxDvIcXZ7AE5uKAtyIkRUHEvlHs=;
        b=pabi6FPEw7Cq6K88ztgcFDlZU7ArdrS9Uqcg2TsmZLOCnmP+dYK5YcZ5soglaqF51y
         kYyMVRtSjgUZzEJ/kKOyoJNAJ18NYGAvBETKo1aqsOwKPAH7OKfEBDVXun/VpDMiz9dB
         791en1OGGNGAIIxsHSw0CUNf+hqJqoOVQ+7BegvKfkcxujP0EZJx1QStzsZkV8IF3vTT
         6WBqnxqwTAQV8HlGi2zvebKra4YRZIz0vhX1u0lMJi0hONvTe9+27I91LNBl6uBNxegy
         sPXYJTpkLxAZFLvXs7ZUO6ylCs/4Il90JSvt2TnGLTr4MUX9kCOwpbrdsMXTmDrFOolE
         fs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAuOHqNvw5LrpRMcJxDvIcXZ7AE5uKAtyIkRUHEvlHs=;
        b=cLYnENcOoavA2nJlBMFEADAFAm6f9NLdJbD7jKRGg6w+qtwn9qqG9TFlTmAuDuY4e2
         tBXQjNe5oNs+jMlSrv4ZFq+p/05dwUf6shmBcRfWZahGLnWwf4S14ejMmHZ1QZS4JTkc
         mN0/qK6t8shf13MwnZtbqccFVO7exC3WZnRi/sGuHIk62Zs7cw9IGMdiDU30R/LEBIk+
         I5YOTFCAcfJvfvBZ3jiOHFOurN7SHg6FUNsDDINN8uIdMBTn8+w+uO4laV3DSeGbUkTJ
         J11Ripq2wjPtmFlyhKOaiyOt0YpZI9xhZ/Z+IvpTldfcpJVR1Lh4dKXxOlY6rWrkw01C
         LpYQ==
X-Gm-Message-State: AOAM530xOl5c1fySflpFBDbvgqzYW40UqROqolCVncf1FIxRycVwaoLS
        N+5xqTGJzFY/4CiWrC3pGnU=
X-Google-Smtp-Source: ABdhPJz4X8WbDb8Cbd5dbXJqW/DlyoXHfzQ+hohZ4WTi0o9uOgVdn3tLe4tvyn8CTVogIm+K2aY1xw==
X-Received: by 2002:a1c:3d56:: with SMTP id k83mr9301050wma.25.1611240769655;
        Thu, 21 Jan 2021 06:52:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:cc:9f0:5e81:68ba:d485:b4e3])
        by smtp.googlemail.com with ESMTPSA id v4sm8851475wrw.42.2021.01.21.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 06:52:48 -0800 (PST)
From:   corentin <corentin.noel56@gmail.com>
X-Google-Original-From: corentin <corentin.noel.external@stormshield.eu>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        corentin <corentin.noel56@gmail.com>
Subject: [PATCH] drivers: spi: spi-au1550: Add suffix "int" to all "unsigned"
Date:   Thu, 21 Jan 2021 15:52:36 +0100
Message-Id: <20210121145236.26460-1-corentin.noel.external@stormshield.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: corentin <corentin.noel56@gmail.com>

Signed-off-by: corentin <corentin.noel56@gmail.com>
---
 drivers/spi/spi-au1550.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index dfb7196f4caf..13ee3a95078d 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -26,7 +26,7 @@
 
 #include <asm/mach-au1x00/au1550_spi.h>
 
-static unsigned usedma = 1;
+static unsigned int usedma = 1;
 module_param(usedma, uint, 0644);
 
 /*
@@ -43,9 +43,9 @@ struct au1550_spi {
 	volatile psc_spi_t __iomem *regs;
 	int irq;
 
-	unsigned len;
-	unsigned tx_count;
-	unsigned rx_count;
+	unsigned int len;
+	unsigned int tx_count;
+	unsigned int rx_count;
 	const u8 *tx;
 	u8 *rx;
 
@@ -56,14 +56,14 @@ struct au1550_spi {
 
 	struct completion master_done;
 
-	unsigned usedma;
+	unsigned int usedma;
 	u32 dma_tx_id;
 	u32 dma_rx_id;
 	u32 dma_tx_ch;
 	u32 dma_rx_ch;
 
 	u8 *dma_rx_tmpbuf;
-	unsigned dma_rx_tmpbuf_size;
+	unsigned int dma_rx_tmpbuf_size;
 	u32 dma_rx_tmpbuf_addr;
 
 	struct spi_master *master;
@@ -99,7 +99,7 @@ static void au1550_spi_bits_handlers_set(struct au1550_spi *hw, int bpw);
  *    BRG valid range is 4..63
  *    DIV valid range is 0..3
  */
-static u32 au1550_spi_baudcfg(struct au1550_spi *hw, unsigned speed_hz)
+static u32 au1550_spi_baudcfg(struct au1550_spi *hw, unsigned int speed_hz)
 {
 	u32 mainclk_hz = hw->pdata->mainclk_hz;
 	u32 div, brg;
@@ -161,7 +161,7 @@ static void au1550_spi_reset_fifos(struct au1550_spi *hw)
 static void au1550_spi_chipsel(struct spi_device *spi, int value)
 {
 	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
-	unsigned cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
 	u32 cfg, stat;
 
 	switch (value) {
@@ -221,7 +221,7 @@ static void au1550_spi_chipsel(struct spi_device *spi, int value)
 static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
-	unsigned bpw, hz;
+	unsigned int bpw, hz;
 	u32 cfg, stat;
 
 	if (t) {
@@ -276,7 +276,7 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
  * spi master done event irq is not generated unless rx fifo is empty (emptied)
  * so we need rx tmp buffer to use for rx dma if user does not provide one
  */
-static int au1550_spi_dma_rxtmp_alloc(struct au1550_spi *hw, unsigned size)
+static int au1550_spi_dma_rxtmp_alloc(struct au1550_spi *hw, unsigned int size)
 {
 	hw->dma_rx_tmpbuf = kmalloc(size, GFP_KERNEL);
 	if (!hw->dma_rx_tmpbuf)
-- 
2.25.1

