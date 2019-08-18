Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2340991891
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfHRSBY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43518 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfHRSBY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so6338062wrn.10
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtGWY0mHTURwl7XYauU89A6Y3tevBVRcOouKJkyS4dI=;
        b=otNhR2RmdSisjDCIZSb7RngOupUFhZDfdM8gMME+pDavipKmAFVHaXTAR77RVc7+n9
         HmhbZwq+L07pPe0wzw5ihPx+AvNt+EpKwYf9v79AUfry1Z1KCLASdTyZHjMZEUFcDw+4
         u79YYfM/Vyv1Xow5lb+gub9L/YbJQJ5EeK8957VQGBTjut6K3WKCj2v97wTAU2F76Iau
         wRK9Ggjpb7CZBwtJA0PaCyCqIsLKdL8MklainaJ4GgkC+2a+VMc1k6sOn3RDHsrQ8pYT
         hrWgcEH1MeQuWTslFLQysZFu7cG3xyWD0mxtaExwVyXGvYmic6XqOb50ZqnhUYffhqXA
         NuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtGWY0mHTURwl7XYauU89A6Y3tevBVRcOouKJkyS4dI=;
        b=W+XFcxWoYX1I2AUcg74FgLU1qGEch//q86Ey6fgJ8MaN0r5uumeCZ72uYRIz7WE2kg
         G3Qdxjha4KBuoHPOb+fGPoVgpoOLYzyZTWaQ1iBgyD5tkRLV7jOTVZGtraGzfRaCfquY
         AM5IVTODDREvWirWzX97ssYYJhr6k/RlYHIUtFw0JLQgbdySUkiDOJjdOKQVd2PUXgxh
         J3Ru1Y3EBigx27PlUVRFpSDyXQf1Q7+hpk899lIys9dtaa8veg3wOye7dC5lRL00SI0D
         Xa62ZHGlj1x0eGLcmE67YHFu/98acVcC+RlDKiHNzX/o6LRFnsk5emutceH/PPZiOjLB
         EUEg==
X-Gm-Message-State: APjAAAVNqdCVp2MZX3y+lwBfXSXWO9/028HRKSsYoGYmV8FJeHf/lGcY
        8Q7ECuBWEWBWcyBdn82kYgs=
X-Google-Smtp-Source: APXvYqzw8h0lBV10peTpJkXNS7B+2mcFNz/NoSENjw8oFhLuz7BhE5FktAfpNcw5T1w7O1YAs3rvLQ==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr10431136wrr.324.1566151282572;
        Sun, 18 Aug 2019 11:01:22 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:22 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 02/14] spi: spi-fsl-dspi: Remove unused defines and includes
Date:   Sun, 18 Aug 2019 21:01:03 +0300
Message-Id: <20190818180115.31114-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a cosmetic patch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0adfff9cedd1..358b381839fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -9,24 +9,14 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-fsl-dspi.h>
-#include <linux/spi/spi_bitbang.h>
-#include <linux/time.h>
 
 #define DRIVER_NAME			"fsl-dspi"
 
@@ -80,21 +70,14 @@
 
 #define SPI_PUSHR			0x34
 #define SPI_PUSHR_CMD_CONT		(1 << 15)
-#define SPI_PUSHR_CONT			(SPI_PUSHR_CMD_CONT << 16)
 #define SPI_PUSHR_CMD_CTAS(x)		(((x) & 0x0003) << 12)
-#define SPI_PUSHR_CTAS(x)		(SPI_PUSHR_CMD_CTAS(x) << 16)
 #define SPI_PUSHR_CMD_EOQ		(1 << 11)
-#define SPI_PUSHR_EOQ			(SPI_PUSHR_CMD_EOQ << 16)
 #define SPI_PUSHR_CMD_CTCNT		(1 << 10)
-#define SPI_PUSHR_CTCNT			(SPI_PUSHR_CMD_CTCNT << 16)
 #define SPI_PUSHR_CMD_PCS(x)		((1 << x) & 0x003f)
-#define SPI_PUSHR_PCS(x)		(SPI_PUSHR_CMD_PCS(x) << 16)
-#define SPI_PUSHR_TXDATA(x)		((x) & 0x0000ffff)
 
 #define SPI_PUSHR_SLAVE			0x34
 
 #define SPI_POPR			0x38
-#define SPI_POPR_RXDATA(x)		((x) & 0x0000ffff)
 
 #define SPI_TXFR0			0x3c
 #define SPI_TXFR1			0x40
@@ -112,21 +95,12 @@
 #define SPI_SREX			0x13c
 
 #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
-#define SPI_FRAME_BITS_MASK		SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_16		SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_8		SPI_CTAR_FMSZ(0x7)
-
 #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
-#define SPI_FRAME_EBITS_MASK		SPI_CTARE_FMSZE(1)
 
 /* Register offsets for regmap_pushr */
 #define PUSHR_CMD			0x0
 #define PUSHR_TX			0x2
 
-#define SPI_CS_INIT			0x01
-#define SPI_CS_ASSERT			0x02
-#define SPI_CS_DROP			0x04
-
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
-- 
2.17.1

