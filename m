Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E962179B7D
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgCDWCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbgCDWCB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so3980974wmb.0;
        Wed, 04 Mar 2020 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/l0focuCxU+0lWxK9yvmCbc/6KKaIJvq1+i8TBaK8g=;
        b=ajmDo6wH9aduuzFZRphrtOLa+jl30EGDPklWmmfDte8+9N+cSnNu0V7DXDBjipjMBU
         Nd+hvpvkn1ikWs6dL5YYPKKRhcNJ4B7S+cMKjXlpF9/0tDuyxPYOPbHaBKC5Ku8NSN7R
         /j/I8etoksIS3XMU9bB+6g6R04LcG62b6+mB/rN4OrBpSLONkvCnpRU2sI9jklPlfNJz
         ckPIRJZdoSWkhn4JfI+klM5119iY4HIBTUfmiGNSmEN6wlyueI8q65ykZ8Vfi0IrS/n2
         oqGkDfc5IOqtG2W/Ja419uyC27HzUwnZwIewtxpYVR+lVjPx9SgSpDuL/MBwp5ccN/kd
         dYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/l0focuCxU+0lWxK9yvmCbc/6KKaIJvq1+i8TBaK8g=;
        b=WO++NQ3YIK2VpxoE+HwrrPIk1YBobRkENFOBhqHrhHnHt/mnnS8rZaLYsvdwgQtA0p
         VANK2Q4buTHUuD51sdbVYq5ycyKgoEX1CagYME6nKsRkvnUnnFx8VIs22vdAgYaiMxIJ
         CsqEi8W1gM3IbLG02tov/YLR35mSBNuioL3qpypwGqsSq7Vb2ZhYRTPHXf9JMEF2RLaY
         fWxgd7Nb04nMkSXUX6BTKgaDCU2Az2yXxCzWHdUjCle6BFo0oZDMX2jdTiK4G8kjZf5i
         nWcjR4jq8hq+mwztzD1GI/IUSNinKUG9uh3s6gX2GRn23/mZwvAPuVjlHjnuuhJGn/uK
         D72Q==
X-Gm-Message-State: ANhLgQ0g3Ep8HQFy0rsZerCAXtKb5oNAzzhG1VIKsmC+Jb/wsUD2DGr4
        sR+SlHaqzIkbNUdKeQr56X+00ayb
X-Google-Smtp-Source: ADFU+vtLjzFP70YoMuO9LYP02avhUML631vsNZch4eudLOzu7eOEacvy5fJcyroV37UmvHxi6oDc+A==
X-Received: by 2002:a1c:e206:: with SMTP id z6mr5184526wmg.141.1583359319182;
        Wed, 04 Mar 2020 14:01:59 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:58 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 04/12] spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx functions
Date:   Thu,  5 Mar 2020 00:00:36 +0200
Message-Id: <20200304220044.11193-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Their names are confusing, since dspi_pop_tx prepares a word to be
written to the PUSHR register, and dspi_push_rx gets a word from the
POPR register.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b92c2b84a94b..a8077d4903c7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -245,6 +245,10 @@ struct fsl_dspi {
 	struct fsl_dspi_dma			*dma;
 };
 
+/*
+ * Pop one word from the TX buffer for pushing into the
+ * PUSHR register (TX FIFO)
+ */
 static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
 	u32 txdata = 0;
@@ -257,6 +261,7 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+/* Prepare one TX FIFO entry (txdata plus cmd) */
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
@@ -269,6 +274,7 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+/* Push one word to the RX buffer from the POPR register (RX FIFO) */
 static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 {
 	if (!dspi->rx)
-- 
2.17.1

