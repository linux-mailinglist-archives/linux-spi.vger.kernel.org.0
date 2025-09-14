Return-Path: <linux-spi+bounces-10008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15462B5643F
	for <lists+linux-spi@lfdr.de>; Sun, 14 Sep 2025 04:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC4F17C358
	for <lists+linux-spi@lfdr.de>; Sun, 14 Sep 2025 02:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF724501B;
	Sun, 14 Sep 2025 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXNQOL9l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C11FC3
	for <linux-spi@vger.kernel.org>; Sun, 14 Sep 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757816508; cv=none; b=QooJy1cdG/5jfBoLwYMQMO24tat/r4TSWNURHJke+laqPp6flQ89lXSff8v1OsSJtblfeEDjU4TbJDsSy3OBY9kQadBBqRtRWvUmV1OLsxQ3fX94vOtZLGUEbi6G32l20bmXHR6Evgw2Npr2Eq8q1gNGVM3CDwsUEOmgXJ2Qfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757816508; c=relaxed/simple;
	bh=kS8JHpcfhYM5CdW9CB6tUor9f9vwCDwkONQoLHpHv6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P04YUNOW971SZGjx4H8rq3KPdX7tMtP9RfI2rn7xZsfuOAwG3HjwhFko3HGCG/K4yeS68own7Puvln+5VhT+fyzrI5SzGs8amiFWe5wRZ0hNV8mnR0sS9OKjPfOojyUzaFDOoE/EQL7cIaY4GUHTLfUkhPDnP4ZZVp6Y0E6Lkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXNQOL9l; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso2119590a12.0
        for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 19:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757816506; x=1758421306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqdYb43+ykEUj742mo0iH3T4ooAsVFSgAqPeQX3wifY=;
        b=nXNQOL9lJIyPmLivfpjw89AdGKte0lgQ27JkFImHvIckSTUzDB+glOuS6UaPclGGC2
         ERhHHEYsTIcnZF7upX03AuGF4DFkCZG9rHPczcy6BvVWAE/dg2Qsi19G1yaS+xm0D28t
         xail3/NNkVQQQpnOUutyr7Esq9RQx2uQrKTj6gZHN9wL6vZw+08zYRzGGaiyH7Mkisu8
         XBXRa7WcGgW00JQ78xwPxE9yMaIx17rCPiQyMpxb3wdx7gwy5vJgW3Kj14wPXeA7rpv5
         2H5+4yCD6dYB5DA+XcfvFdZs5o9DGXJeYeV4OeEEyxWpWiOhLWBB2asi3AuiuYAVku9G
         srnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757816506; x=1758421306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqdYb43+ykEUj742mo0iH3T4ooAsVFSgAqPeQX3wifY=;
        b=Fdq2r3D0cg9QXFBZw5YFxolZYloqwVoVRxTf9lUzWzrCpARjG/CC3XmT56QdQig71R
         3GmsHlQ9ekCTRv4/hXG5PuXFQACSXm58CpwJOgmHrjS894PQG4GI/22AWlOoLYvhYQdQ
         ed4/SmRc+OokdizGazsMMuY2Bx46JgVeN7+tCzkFxCSK02Z3WBwknnwjj6SqfgFVLoQq
         XM2BPnHdF5FMH4r9y9MTiuRCYzaCfnIj/kcpDxLfdMbHgj93g2XW/Yffwxox93mHZcNa
         0ssuC9ykvpwiYbQt6wzSY7lB1jk8MhvlPkgEF4R+f6Td9DC44+ggsFr8qDgmZ18OIBcn
         7jPQ==
X-Gm-Message-State: AOJu0YwWv/NBokIUDTA7uEFnO89bVNKW5TCEUoQcuaJ0Vc6SsVJjlyI/
	KzrjvBd9mj/6s9RNMk2ASrpdnkf/JYWgozNZHwzRTi8D0M4XY890SmU6
X-Gm-Gg: ASbGncu6vi778P+6QBmLjskKxHpBMQuBlhjf9okrsKn08X6V8kLyH1TK9pGWzC6zZQ4
	nMiz/7xWUK9C94XvcYNirszfv3hfEUgFL2Pp9Pyvx9N7IE2kJDy8BbCW7IiH87Tnp8Y4E+BfYUH
	ZAZc3rf7yqdTygPLmWJ71xpYe0OXmpv4hknuMqiu/ma6KXDaFYbKtRlwAJZLzRPr/8Xd19evDHH
	5TTKo8FCNlpuAUfXqrGOsXOL/CH5FC/UPiUz+AljKhEFstGLPw2c0zmFolJmqbZJxR7sne6sl3d
	jBYJuO+0KMXc+iVOSTnVaKHnERWTPJEbp+02Jnb4zgivExuyfsArotFWm+sT/bVD1TFb2bcfprC
	dK2v2AsgWsAdsxnwU0KT1//Azg/FPH//DKw==
X-Google-Smtp-Source: AGHT+IFoR2P5g3/f0mGeIuy3+0+zAJUbfdsUl2n3PtZNSOt3j4dOvKJKtvTfVzY7igk5GaUMCr6Mew==
X-Received: by 2002:a17:903:1b4c:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-25d26077175mr98369385ad.31.1757816505822;
        Sat, 13 Sep 2025 19:21:45 -0700 (PDT)
Received: from fedora ([172.59.162.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261d3dd0285sm27968685ad.8.2025.09.13.19.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 19:21:45 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] spi: spi-omap2-mcspi: fallback to PIO when DMA transfer fails
Date: Sat, 13 Sep 2025 19:21:32 -0700
Message-ID: <20250914022132.319227-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fallback to PIO mode when DMA preparation fails.
Allows SPI transfers to complete successfully, even
on a DMA preparation failure.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 46 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6dc58a308..0b3b7ff0c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -414,9 +414,8 @@ static void omap2_mcspi_tx_callback(void *data)
 	complete(&mcspi_dma->dma_tx_completion);
 }
 
-static void omap2_mcspi_tx_dma(struct spi_device *spi,
-				struct spi_transfer *xfer,
-				struct dma_slave_config cfg)
+static int omap2_mcspi_tx_dma(struct spi_device *spi, struct spi_transfer *xfer,
+			      struct dma_slave_config cfg)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
@@ -436,13 +435,15 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 		tx->callback_param = spi;
 		dmaengine_submit(tx);
 	} else {
-		/* FIXME: fall back to PIO? */
+		dev_warn(mcspi->dev, "%s: failed to prepare DMA engine\n", __func__);
+		return -EINVAL;
 	}
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);
+	return 0;
 }
 
-static unsigned
+static int
 omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 				struct dma_slave_config cfg,
 				unsigned es)
@@ -522,7 +523,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		tx->callback_param = spi;
 		dmaengine_submit(tx);
 	} else {
-		/* FIXME: fall back to PIO? */
+		dev_warn(mcspi->dev, "%s: failed to prepare DMA engine\n", __func__);
+		return -EINVAL;
 	}
 
 	dma_async_issue_pending(mcspi_dma->dma_rx);
@@ -589,13 +591,13 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	return count;
 }
 
-static unsigned
-omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
+static int omap2_mcspi_txrx_dma(struct spi_device *spi,
+				struct spi_transfer *xfer)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count;
+	int		count;
 	u8			*rx;
 	const u8		*tx;
 	struct dma_slave_config	cfg;
@@ -642,13 +644,19 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 			mcspi_write_reg(spi->controller,
 					OMAP2_MCSPI_IRQENABLE,
 					OMAP2_MCSPI_IRQSTATUS_EOW);
-		omap2_mcspi_tx_dma(spi, xfer, cfg);
+		if (omap2_mcspi_tx_dma(spi, xfer, cfg) < 0) {
+			count = -EINVAL;
+			goto pio_fallback;
+		}
 	}
 
-	if (rx != NULL)
+	if (rx) {
 		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
+		if (count < 0)
+			goto pio_fallback;
+	}
 
-	if (tx != NULL) {
+	if (tx) {
 		int ret;
 
 		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
@@ -695,6 +703,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_err(&spi->dev, "EOT timed out\n");
 		}
 	}
+
+pio_fallback:
 	return count;
 }
 
@@ -1206,7 +1216,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 	mcspi_write_chconf0(spi, chconf);
 
 	if (t->len) {
-		unsigned	count;
+		int count;
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
 		    spi_xfer_is_dma_mapped(ctlr, spi, t))
@@ -1220,10 +1230,16 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 					+ OMAP2_MCSPI_TX0);
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    spi_xfer_is_dma_mapped(ctlr, spi, t))
+		    spi_xfer_is_dma_mapped(ctlr, spi, t)) {
 			count = omap2_mcspi_txrx_dma(spi, t);
-		else
+			if (count < 0) {
+				dev_warn(mcspi->dev,
+					 "%s: falling back to PIO\n", __func__);
+				count = omap2_mcspi_txrx_pio(spi, t);
+			}
+		} else {
 			count = omap2_mcspi_txrx_pio(spi, t);
+		}
 
 		if (count != t->len) {
 			status = -EIO;
-- 
2.51.0


