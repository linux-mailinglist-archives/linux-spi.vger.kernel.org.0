Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852AB3001A4
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 12:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbhAVLcy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 06:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbhAVLcF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jan 2021 06:32:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54870C0613D6;
        Fri, 22 Jan 2021 03:31:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c127so4030878wmf.5;
        Fri, 22 Jan 2021 03:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UtKHtNpBZjEuHd6aKkGs7s/LKu1xlwebERl/VisAQM=;
        b=rZ+62y0lEb0Ivj5CZRg54wFWA8hsE3iHyZsK0fu4L0iYYhswdIYHVmbjmvZaPeZyu8
         avvOoDrJ+QT+S/DqvVTTuGSpPR5aRKnW+8E4ZZuhYGz0TVdRDfvWHCRDQLQyTvsJAylm
         xtNh9L9iTv2tnnbMQ72zYu8zaw71JRghSSTrMva+2tZl1s7GUWNBvwki+6tg+Gw4xK0Q
         PARxt1TEeItSSNITVxot05/i8dcc7vq514k8F4dosnC8QrkdZ7vLsfhoM8Zbpzsy+2k4
         FDdkxS74SHCHVowC8UGemHWXRb73DEhI5tD4wVTR7duDsysqsL2Hz48u58JU9KdekSXu
         PZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UtKHtNpBZjEuHd6aKkGs7s/LKu1xlwebERl/VisAQM=;
        b=R3me/d66LSNbN60oH/pT/Jze3HSri5NRwavlbT2q/IF1eDL1QkPGWfMfYdbq5VyJms
         EYrgLeyx5LMX6MulKVO71VScCWRXSeBkIkpOvrm39iJZEHxRWrrHoROVqSAebaCuu1JY
         oxSUUTqyAAu0F3cOcC524WWK8MXVL5Ym2Vpi8q7xW+E1OkD5HnQhye330hmwCULR+ffK
         d0V19GD/7NsC5D1Z6+ksvqurg0KrlyZEO2Mj0Nxre2YRxpovaSuPNHxD8FvKmp7oLdMp
         UjbnVPb0wghbHAc/mQH6mkl4kGifCjNjdhEbRdcWuLE7Z8fjXbR2KVdTznkhw1/QZPcG
         XW9Q==
X-Gm-Message-State: AOAM532IymM9PghsNfR5notHPtMq0lhsC5BzUexlRYe/zfA4GXfGy+Di
        n8hdkjUXcTY1oFF5Ue2HWs4=
X-Google-Smtp-Source: ABdhPJwoNIZIK69jzqzq0hOQYQ1r08m0p0syE8q0NqZFMejIR2GyvOFGoyh84CNz4xCv2VVJuUzw5Q==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr3596188wmb.187.1611315083021;
        Fri, 22 Jan 2021 03:31:23 -0800 (PST)
Received: from localhost.localdomain ([37.166.244.59])
        by smtp.googlemail.com with ESMTPSA id x1sm857953wmi.14.2021.01.22.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 03:31:22 -0800 (PST)
From:   corentin <corentin.noel56@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        corentin <corentin.noel56@gmail.com>
Subject: [PATCH] drivers: spi: spi-au1550: quoted string break
Date:   Fri, 22 Jan 2021 12:30:52 +0100
Message-Id: <20210122113052.40429-1-corentin.noel56@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: corentin <corentin.noel56@gmail.com>
---
 drivers/spi/spi-au1550.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index dfb7196f4caf..cbb6604ba8f7 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -447,8 +447,8 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 				"dma transfer: receive FIFO overflow!\n");
 		else
 			dev_err(hw->dev,
-				"dma transfer: unexpected SPI error "
-				"(event=0x%x stat=0x%x)!\n", evnt, stat);
+				"dma transfer: unexpected SPI error (event=0x%x stat=0x%x)!\n",
+				evnt, stat);
 
 		complete(&hw->master_done);
 		return IRQ_HANDLED;
@@ -567,8 +567,8 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 		au1550_spi_mask_ack_all(hw);
 		au1550_spi_reset_fifos(hw);
 		dev_err(hw->dev,
-			"pio transfer: unexpected SPI error "
-			"(event=0x%x stat=0x%x)!\n", evnt, stat);
+			"pio transfer: unexpected SPI error (event=0x%x stat=0x%x)!\n",
+			evnt, stat);
 		complete(&hw->master_done);
 		return IRQ_HANDLED;
 	}
@@ -972,8 +972,7 @@ static int __init au1550_spi_init(void)
 	if (usedma) {
 		ddma_memid = au1xxx_ddma_add_device(&au1550_spi_mem_dbdev);
 		if (!ddma_memid)
-			printk(KERN_ERR "au1550-spi: cannot add memory"
-					"dbdma device\n");
+			printk(KERN_ERR "au1550-spi: cannot add memory dbdma device\n");
 	}
 	return platform_driver_register(&au1550_spi_drv);
 }
-- 
2.25.1

