Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2291892
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRSBZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRSBZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so1080807wma.1
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKv1a00k54xMi+VcwQI/DKzgx6XPCirHutxBlqKVmpk=;
        b=oRLMn4lkCV7Fa2KAQSTbcFGLE3EeHO92O8zcgPssLfI69jwUyf7rVnAIFZm+wLzkAY
         l/MniLyWBcg2+pFZ2gV3Tuq5LDZcudWs/kBi/+JwY1U8wsq57XlY7K8UblnoPM/uNpnG
         Z3JHGnb4DM5sbxVFd0/BqJ2kQAHURZVduntOM8w4XH8Y1IdhdNDyuXA+zSKj//KAHlT1
         /E/XuMHoyNmr+BXeu3xpvkG89/mYfdN3+6jae1Cvyx7+989VuNa6NTWhjcggX+/WGTCC
         A4yIJ5uBYfPDPIuDfebGkEf2FFTEP4rqcBDLa9T/l9rqam7YYtjK4T2lGfc7qu9ElS9M
         y2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKv1a00k54xMi+VcwQI/DKzgx6XPCirHutxBlqKVmpk=;
        b=aIjI/XmZA062fdo321Fu+ALNIa9rCK6Rn/IkpsBfSybEF2NoGLKX/aNOe2EleXGlB9
         G2+akW+n6yhJfnVnXxSswo78V2pY8wtD5rNbBCM1ExieNLDr9lN+vhe38Cus2XVUqFej
         qI/iCFMbsKlV46bZCL6igvmkcaulVM5hf9t9wKx32eiURjP5ywa8MWsnyFAXOoeVylXk
         sq1vLsa7pWfksqJyQ0nOXORZjOEhKY+5Zz/DAvyIizPjB2jk00HWWKq4gFz6zF38x+U8
         fosZkLxwFVU6nsa9PZTTRAloCPC058BuGsnattp3ef+wVGvkYLQI/rcYqst33dLBnU5F
         tlIg==
X-Gm-Message-State: APjAAAUgcqKiMqZzeWDhB700NRWIt4GWv9DPD/qzysY1LhaqkSRxErVl
        ebmXiVMXMDnvXbQc+avJHw0=
X-Google-Smtp-Source: APXvYqwhvIlvhf9XQItVjUT/qtj3q0B/gw36Uzo/YGAvgblnt5EnlE1uE8xdF+0FnQ63MK8g3QVUAQ==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr16535756wmf.115.1566151283409;
        Sun, 18 Aug 2019 11:01:23 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:23 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 03/14] spi: spi-fsl-dspi: Use BIT() and GENMASK() macros
Date:   Sun, 18 Aug 2019 21:01:04 +0300
Message-Id: <20190818180115.31114-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to using more idiomatic register field definitions, which makes
it easier to look them up in the datasheet. Cosmetic patch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 58 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 358b381839fb..179a9818619f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -28,35 +28,35 @@
 #define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
 
 #define SPI_MCR				0x00
-#define SPI_MCR_MASTER			(1 << 31)
+#define SPI_MCR_MASTER			BIT(31)
 #define SPI_MCR_PCSIS			(0x3F << 16)
-#define SPI_MCR_CLR_TXF			(1 << 11)
-#define SPI_MCR_CLR_RXF			(1 << 10)
-#define SPI_MCR_XSPI			(1 << 3)
+#define SPI_MCR_CLR_TXF			BIT(11)
+#define SPI_MCR_CLR_RXF			BIT(10)
+#define SPI_MCR_XSPI			BIT(3)
 
 #define SPI_TCR				0x08
-#define SPI_TCR_GET_TCNT(x)		(((x) & 0xffff0000) >> 16)
-
-#define SPI_CTAR(x)			(0x0c + (((x) & 0x3) * 4))
-#define SPI_CTAR_FMSZ(x)		(((x) & 0x0000000f) << 27)
-#define SPI_CTAR_CPOL(x)		((x) << 26)
-#define SPI_CTAR_CPHA(x)		((x) << 25)
-#define SPI_CTAR_LSBFE(x)		((x) << 24)
-#define SPI_CTAR_PCSSCK(x)		(((x) & 0x00000003) << 22)
-#define SPI_CTAR_PASC(x)		(((x) & 0x00000003) << 20)
-#define SPI_CTAR_PDT(x)			(((x) & 0x00000003) << 18)
-#define SPI_CTAR_PBR(x)			(((x) & 0x00000003) << 16)
-#define SPI_CTAR_CSSCK(x)		(((x) & 0x0000000f) << 12)
-#define SPI_CTAR_ASC(x)			(((x) & 0x0000000f) << 8)
-#define SPI_CTAR_DT(x)			(((x) & 0x0000000f) << 4)
-#define SPI_CTAR_BR(x)			((x) & 0x0000000f)
+#define SPI_TCR_GET_TCNT(x)		(((x) & GENMASK(31, 16)) >> 16)
+
+#define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(1, 0)) * 4))
+#define SPI_CTAR_FMSZ(x)		(((x) << 27) & GENMASK(30, 27))
+#define SPI_CTAR_CPOL(x)		(((x) << 26) & GENMASK(26, 26))
+#define SPI_CTAR_CPHA(x)		(((x) << 25) & GENMASK(25, 25))
+#define SPI_CTAR_LSBFE(x)		(((x) << 24) & GENMASK(24, 24))
+#define SPI_CTAR_PCSSCK(x)		(((x) << 22) & GENMASK(23, 22))
+#define SPI_CTAR_PASC(x)		(((x) << 20) & GENMASK(21, 20))
+#define SPI_CTAR_PDT(x)			(((x) << 18) & GENMASK(19, 18))
+#define SPI_CTAR_PBR(x)			(((x) << 16) & GENMASK(17, 16))
+#define SPI_CTAR_CSSCK(x)		(((x) << 12) & GENMASK(15, 12))
+#define SPI_CTAR_ASC(x)			(((x) << 8) & GENMASK(11, 8))
+#define SPI_CTAR_DT(x)			(((x) << 4) & GENMASK(7, 4))
+#define SPI_CTAR_BR(x)			((x) & GENMASK(3, 0))
 #define SPI_CTAR_SCALE_BITS		0xf
 
 #define SPI_CTAR0_SLAVE			0x0c
 
 #define SPI_SR				0x2c
-#define SPI_SR_EOQF			0x10000000
-#define SPI_SR_TCFQF			0x80000000
+#define SPI_SR_TCFQF			BIT(31)
+#define SPI_SR_EOQF			BIT(28)
 #define SPI_SR_CLEAR			0x9aaf0000
 
 #define SPI_RSER_TFFFE			BIT(25)
@@ -65,15 +65,15 @@
 #define SPI_RSER_RFDFD			BIT(16)
 
 #define SPI_RSER			0x30
-#define SPI_RSER_EOQFE			0x10000000
-#define SPI_RSER_TCFQE			0x80000000
+#define SPI_RSER_TCFQE			BIT(31)
+#define SPI_RSER_EOQFE			BIT(28)
 
 #define SPI_PUSHR			0x34
-#define SPI_PUSHR_CMD_CONT		(1 << 15)
-#define SPI_PUSHR_CMD_CTAS(x)		(((x) & 0x0003) << 12)
-#define SPI_PUSHR_CMD_EOQ		(1 << 11)
-#define SPI_PUSHR_CMD_CTCNT		(1 << 10)
-#define SPI_PUSHR_CMD_PCS(x)		((1 << x) & 0x003f)
+#define SPI_PUSHR_CMD_CONT		BIT(15)
+#define SPI_PUSHR_CMD_CTAS(x)		(((x) << 12 & GENMASK(14, 12)))
+#define SPI_PUSHR_CMD_EOQ		BIT(11)
+#define SPI_PUSHR_CMD_CTCNT		BIT(10)
+#define SPI_PUSHR_CMD_PCS(x)		(BIT(x) & GENMASK(5, 0))
 
 #define SPI_PUSHR_SLAVE			0x34
 
@@ -88,7 +88,7 @@
 #define SPI_RXFR2			0x84
 #define SPI_RXFR3			0x88
 
-#define SPI_CTARE(x)			(0x11c + (((x) & 0x3) * 4))
+#define SPI_CTARE(x)			(0x11c + (((x) & GENMASK(1, 0)) * 4))
 #define SPI_CTARE_FMSZE(x)		(((x) & 0x1) << 16)
 #define SPI_CTARE_DTCP(x)		((x) & 0x7ff)
 
-- 
2.17.1

