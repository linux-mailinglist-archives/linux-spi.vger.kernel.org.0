Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029401AFD71
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgDST0j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D2C061A0C;
        Sun, 19 Apr 2020 12:26:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b8so3867982pfp.8;
        Sun, 19 Apr 2020 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=lpQPoGP4sSuN9BOnLgX6l3QtHRrFIChBDmplJ++Qin3OrDe/KRWlOLKowP19c9hgcP
         7+8X10P5ogvOFrqOT4r2UQkhDEhLaAEETFHNAGMn+rXiBcLx6d2Ifr+L2ax00//UHLTo
         4ZrOxCRwKB95ghv0d9+Wj/pi0NWPhNpZWSQRsP+0y2A2za3TKaJRBLwa9OjfZr+Tel4e
         KxlCbM1HX6QBU7mdERGvblNZim73WtXyvIe6YY65Ia2QnGB2aM0PEtDaFKwFtNqahBJZ
         iKQQxuQdMPjAjuuUIvIhXP2WLERyb24mbHcknjxv8zilqjjTflDfTARkKfCPdmk8EdwL
         LcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=qYUExDJ6a9GxZtMjNogYlJz/lyN3R6IOs8bHmedbSTwB4t7HVyJNQd2Uy1u48YFb5M
         bF2AMD3q53OA2LPNqIvzzMWYmV9MBNIxLPNDBYV+6YZd/ucjZVyU5Rs7RlV5NIoPN10F
         bQnEZ1FrBkUzLt8LRcz4UEZrsY08HwI0fL1oRyBQmi55xHM2V0Cwj0IXO//Z++BicfEo
         NCDLbIsIpgYATPAa7G4Xi4cm0mOcmWN6IWGSHXoVHC42TrCP9V6mDtIWDo+xsKAVZMAZ
         P9MPmS1hlvo5jxqkEyF7hEE7d96ZRPwFBDetGl5ISIT6jP4z5Jy9TF13yL8fLvDM3SfB
         bP4w==
X-Gm-Message-State: AGi0Pubac326E6Fki24LTwuKnCrc9aA3hnyUbCAQ2z/AxaLgspygEK45
        gkFU8jcPGMtssyuhRMHwBqUsfY3qhnQ=
X-Google-Smtp-Source: APiQypIN48L/jVi9aEb2qodYvtrNzFJyIefmIMSrZWapjBe8dFtWmtBhPRQifVBEuf9Tm0pO+lKQVw==
X-Received: by 2002:a63:ff49:: with SMTP id s9mr13479049pgk.46.1587324398385;
        Sun, 19 Apr 2020 12:26:38 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:38 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
Date:   Sun, 19 Apr 2020 15:23:36 -0400
Message-Id: <20200419192339.32023-8-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
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

