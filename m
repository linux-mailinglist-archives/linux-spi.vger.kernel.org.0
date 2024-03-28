Return-Path: <linux-spi+bounces-2087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7E890BFC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F73428FD44
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EF139598;
	Thu, 28 Mar 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PaSNHWG5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C17FBB0
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659170; cv=none; b=GGzBsxwb6tgiJjW3/sg0LuOEiYV1BhU7FIGTWPkOl6BhjOdh0JgFGuti8jRKry/BKd3oraBcTk1Ef65l1SVeM4b5talJOCIFnGNfx5ALbet4klmTcynZtZX25csUWIs/sV13+7W9ZEx68FuYWM78bxnzqzG5/aBNdOQVugU49zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659170; c=relaxed/simple;
	bh=GeMYE1tfKAVoMVZLat41QykjcobP/pX5nbPP5nlFDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFWAvXcY98qtpsIvvTMSW7+cItOs+U3IEJvw6quwQbhhjZkBFW/iZ3nkqpPydx/Swbotl0qd+qYI65uSIKIY+EVX4zI3xYBSFLxF+q1HpbqhiXkzihoZQWV07cpiwEtYWPXH1O61QVGSzmiSXpXYmZX5BU2gnEH/5D/Nrmnvz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PaSNHWG5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a5272035d3so755765eaf.1
        for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711659167; x=1712263967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02QukKA7rGv689sMEnY5Waa2GxmfCRYMmefB+eiHwtw=;
        b=PaSNHWG5HD6j+WPHD8wLgj5iRrFYweQ8S76xWWlZ9HpMEXUGlrGH1MGOv62UrKFVYW
         e+2gQOcAR7TxKun9CqicBWPPzFB8zSDYPdfl8N4ykmg1t31DUDLjfdhm6pXHXRDqR6nU
         SnDzxl9+t+dgyZHUCGlIIwbyVhPXxVkTKKEFDi3nxa28sBEsDHphnCsTTsQjEMtXHluF
         Q/BVX3Hlzl5Iuhml51uyFojHWZB5NTkmOxd06SsvSeMBGPPbTxcz9N0fgffpmXaFR5O7
         IXec/hpknlPHjva+gmKYt5beOTKQ6x/LIuJll0KaM/jEpFYooxNB7tOFuLsaakZaHrNZ
         rJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659167; x=1712263967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02QukKA7rGv689sMEnY5Waa2GxmfCRYMmefB+eiHwtw=;
        b=k2CDFz166B418BQFKGVe1pqg/gZyYiuaArW3Ie3SPMt3B0UKIh5O0mN9PAQXMPoLDN
         W9lOE2kiU2cxF9am9zVjiruonpwlXNLES4mr4R59SoWG2caEz97rg+zp1faVS6dhKjOd
         k+XHPX1uZMLzSgpsKmHRkKjyzhVFL8RKnc/4lvFqnOGYU5osEl9hmiqckP9IUdlupT3n
         s5y6PgPIDf+cCVHBL2vE/27ArF89X+pPN9xEsCsQrh/RvvpmyA44E+9VWusylfqvOb0p
         MnHKB6j6f5lgrNbZpzw11GyD37AJxb+yB+mVEF6vCpqvj/aKeta9ZybLAxVw8tFud7il
         N+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmxQTB41hoqaArol3iHOb5tt/iCFiQ0IDftEpq1WmZz5+hDZNNq+3ymq5dixe5ucGty98AN2YTP4Rt+fFl3t+2afvWork5g2Jc
X-Gm-Message-State: AOJu0YzzZF22a1zeTss0jZLi1e1FtMHppRhU47Fzd2okgyv9k4t533GV
	Au+n0I7fmC5ly/FIZs3/JFWNjsxexMEnD4uK2WNPmEsztk16ekeDJk/TehhG3xA=
X-Google-Smtp-Source: AGHT+IGxxiP+qq0jVjWIwgc+9slYwS5wp9XffdmBw/yeJyXyzaCNvqDCbJlkHDpqDAINcXYxMa9pFA==
X-Received: by 2002:a05:6870:96a4:b0:229:f2a0:5f4d with SMTP id o36-20020a05687096a400b00229f2a05f4dmr378247oaq.1.1711659167493;
        Thu, 28 Mar 2024 13:52:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6c50000000b006e7011fea78sm293335otq.41.2024.03.28.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:52:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: au1550: t->{tx,rx}_dma checks
Date: Thu, 28 Mar 2024 15:51:45 -0500
Message-ID: <20240328-spi-more-tx-rx-buf-cleanup-v1-1-9ec1ceedf08c@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

There are no more peripheral drivers that set t->tx_dma or t->rx_dma so
these will always == 0. Therefore, we can remove these checks since
they are always true.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-au1550.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 825d2f1cdff8..16f200bb3d17 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -314,11 +314,8 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
-	dma_tx_addr = t->tx_dma;
-	dma_rx_addr = t->rx_dma;
 
 	/*
-	 * check if buffers are already dma mapped, map them otherwise:
 	 * - first map the TX buffer, so cache data gets written to memory
 	 * - then map the RX buffer, so that cache entries (with
 	 *   soon-to-be-stale data) get removed
@@ -326,23 +323,17 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	 * use temp rx buffer (preallocated or realloc to fit) for rx dma
 	 */
 	if (t->tx_buf) {
-		if (t->tx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
-			dma_tx_addr = dma_map_single(hw->dev,
-					(void *)t->tx_buf,
-					t->len, DMA_TO_DEVICE);
-			if (dma_mapping_error(hw->dev, dma_tx_addr))
-				dev_err(hw->dev, "tx dma map error\n");
-		}
+		dma_tx_addr = dma_map_single(hw->dev, (void *)t->tx_buf,
+					     t->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(hw->dev, dma_tx_addr))
+			dev_err(hw->dev, "tx dma map error\n");
 	}
 
 	if (t->rx_buf) {
-		if (t->rx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
-			dma_rx_addr = dma_map_single(hw->dev,
-					(void *)t->rx_buf,
-					t->len, DMA_FROM_DEVICE);
-			if (dma_mapping_error(hw->dev, dma_rx_addr))
-				dev_err(hw->dev, "rx dma map error\n");
-		}
+		dma_rx_addr = dma_map_single(hw->dev, (void *)t->rx_buf,
+					     t->len, DMA_FROM_DEVICE);
+		if (dma_mapping_error(hw->dev, dma_rx_addr))
+			dev_err(hw->dev, "rx dma map error\n");
 	} else {
 		if (t->len > hw->dma_rx_tmpbuf_size) {
 			int ret;
@@ -398,10 +389,10 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 			DMA_FROM_DEVICE);
 	}
 	/* unmap buffers if mapped above */
-	if (t->rx_buf && t->rx_dma == 0)
+	if (t->rx_buf)
 		dma_unmap_single(hw->dev, dma_rx_addr, t->len,
 			DMA_FROM_DEVICE);
-	if (t->tx_buf && t->tx_dma == 0)
+	if (t->tx_buf)
 		dma_unmap_single(hw->dev, dma_tx_addr, t->len,
 			DMA_TO_DEVICE);
 

-- 
2.43.2


