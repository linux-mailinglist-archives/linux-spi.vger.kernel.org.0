Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381711B156B
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDTTJf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727953AbgDTTJe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538CC061A0C;
        Mon, 20 Apr 2020 12:09:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so13609071wrq.2;
        Mon, 20 Apr 2020 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=OMMAVUyBDJP+KFHWCoSsdWuf67ugu0h1aOcdG92e9Rk2nRnFxxm2PEp0aAX/tYuOEc
         wR5AkOMJp+xAsI60sMbTGZ9TAgnE1q9F2huBaA2dkn0XuTdXt5rFo4O0BoVmF9kUFE8e
         c1S7MVNi0nnK7PzrffD3UtA2lMQNYrJk4L++4FxOx8oGsmfqqtIcjTG4qpXkFOJBKX0Q
         bAmcvNDlkNlmJJlfDzYJNISNW7kN46xksRSOdy13wIGLvW96Uhs/vbk27z1KgdU1Iidd
         RjNNQl/iksd/co0em1TIwAOH8xfJZVpPGtRLGHW7/mY3K0tjY5ZPtK1+TlUffGtE77Ig
         e2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=ONhCy6M97/tI+hVgN8wX8L3FUTz1JikAd/BCQ2SxB2BqZhV7SWxdGKmea19e0HMDVP
         aba6xc31wEFledIzIYFicqn6yrrcjJMruiQjXtr8sgGBQ+0lfM9OlUm1p7wsJobAL6zZ
         1G7VU3nTQMOQqIQTcvG+UWlxOAcufVbBCnQZH36KXpbVcSwBK9MFCYdqObKjFuv8BwPH
         NeGujN2bV2U5e5aujIJLvfF4Yzd6eNVS/kNSsLFgY2iwcb7ZPvOPkQ818giCnFWLoT4g
         wnifX/zmpRWctHTzklVTsEKiZz0kV04pEoF7JkKnNhftKsYTcfAxG140hUx0repl0Hr+
         idnA==
X-Gm-Message-State: AGi0PuZdx9XQXFp4+j1zQIPt4ysB/P7VnPItOBGb2i7fw/22+18lnwXR
        76AF2puqjiS8xf1bjg+sRNg=
X-Google-Smtp-Source: APiQypI+/BCVqeRq7QtED9MoxzHJxEBtobaZ5O/7EtxqFKhAxsE2XNO3e80+wWFUCImWNvU6kcfUCw==
X-Received: by 2002:a5d:6b89:: with SMTP id n9mr14890993wrx.356.1587409772866;
        Mon, 20 Apr 2020 12:09:32 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:32 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
Date:   Mon, 20 Apr 2020 15:08:51 -0400
Message-Id: <20200420190853.45614-8-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Setting MSPI_SPCR3.fastbr=1 allows using clock divider (SPBR) values of
1-7, while the default value prohibits these values and requires a minimum
clock divider value of 8.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a3936ae5a860..edc601dbf221 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -107,13 +107,15 @@
 #define MSPI_SPCR2_SPE				BIT(6)
 #define MSPI_SPCR2_CONT_AFTER_CMD		BIT(7)
 
+#define MSPI_SPCR3_FASTBR			BIT(0)
+#define MSPI_SPCR3_FASTDT			BIT(1)
+
 #define MSPI_MSPI_STATUS_SPIF			BIT(0)
 
 #define INTR_BASE_BIT_SHIFT			0x02
 #define INTR_COUNT				0x07
 
 #define NUM_CHIPSELECT				4
-#define QSPI_SPBR_MIN				8U
 #define QSPI_SPBR_MAX				255U
 
 #define OPCODE_DIOR				0xBB
@@ -227,6 +229,25 @@ static inline bool has_bspi(struct bcm_qspi *qspi)
 	return qspi->bspi_mode;
 }
 
+/* hardware supports spcr3 and fast baud-rate  */
+static inline bool bcm_qspi_has_fastbr(struct bcm_qspi *qspi)
+{
+	if (!has_bspi(qspi) &&
+	    ((qspi->mspi_maj_rev >= 1) &&
+	     (qspi->mspi_min_rev >= 5)))
+		return true;
+
+	return false;
+}
+
+static inline int bcm_qspi_spbr_min(struct bcm_qspi *qspi)
+{
+	if (bcm_qspi_has_fastbr(qspi))
+		return 1;
+	else
+		return 8;
+}
+
 /* Read qspi controller register*/
 static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type type,
 				unsigned int offset)
@@ -534,7 +555,7 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 	if (xp->speed_hz)
 		spbr = qspi->base_clk / (2 * xp->speed_hz);
 
-	spcr = clamp_val(spbr, QSPI_SPBR_MIN, QSPI_SPBR_MAX);
+	spcr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spcr);
 
 	spcr = MSPI_MASTER_BIT;
@@ -544,6 +565,14 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 	spcr |= xp->mode & 3;
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_MSB, spcr);
 
+	if (bcm_qspi_has_fastbr(qspi)) {
+		spcr = 0;
+
+		/* enable fastbr */
+		spcr |=	MSPI_SPCR3_FASTBR;
+		bcm_qspi_write(qspi, MSPI, MSPI_SPCR3, spcr);
+	}
+
 	qspi->last_parms = *xp;
 }
 
@@ -1388,7 +1417,6 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	}
 
 	qspi->base_clk = clk_get_rate(qspi->clk);
-	qspi->max_speed_hz = qspi->base_clk / (QSPI_SPBR_MIN * 2);
 
 	if (data->has_mspi_rev) {
 		rev = bcm_qspi_read(qspi, MSPI, MSPI_REV);
@@ -1400,6 +1428,8 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->mspi_maj_rev = (rev >> 4) & 0xf;
 	qspi->mspi_min_rev = rev & 0xf;
 
+	qspi->max_speed_hz = qspi->base_clk / (bcm_qspi_spbr_min(qspi) * 2);
+
 	bcm_qspi_hw_init(qspi);
 	init_completion(&qspi->mspi_done);
 	init_completion(&qspi->bspi_done);
-- 
2.17.1

