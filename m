Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CA1ACEF5
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgDPRn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729252AbgDPRnx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298BC061A0C;
        Thu, 16 Apr 2020 10:43:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so5842279wmf.5;
        Thu, 16 Apr 2020 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=pkR7bMbd/nbASMOpMKJ+a4qCQ6/poc7lIW7LbNVFTW+mf0T3IW3Ct+a/43TpHO4EnT
         hueTAnQsLxbZbeNCgOOileSs36x79BNaOpkFQZFt1ehtysy2kg3odHYJv7ppYPKnpGC4
         wt6KD3wOZxakmA/qP1OnxqfyAbACL++EWURo1Tpcb2GODGRlWPze+i4KppI54rCU/Sgc
         F7bWTRxi2OTEgMux4XnX5MC8FGy0HGqJ7v3L06UyAd3qgGpX00yS4Zr8T4hR/uJQmtQN
         y2pASjPqye+VWN9A14dA2YNkKHr7erYdjSeFlU2EzyT2T/sm+xue0fHGO9q9bZ4VVS0M
         z9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OZ96LAcwn+BELPZteh+FF1ZZG0PwSRcuJ8BBRDIlsU=;
        b=lRv+XqXV6n2hsZ5tUwFpnOozO+F3NbhwLaiuCg1W6zjFHMoCk7MbIjvmmHPuRsYmnj
         LyKAIGl5/NdegshJMyUvDno8osNhkqaYS4OdDlgsFiOFQj0i/Mi3MGr4tNn6cUcYI81j
         qUZfXR3Cej7t0XTUEJmqUkUCFDAfY7Rwa8epBBW7wxqvD0JKR53OLwbwsgAvr+SSm83g
         noNcXzzCyjve3r3NTrLaqiV1YFGrBCiBIz1Fn31rUm2GquwWX7mcgJQno3xR7DVSZx+1
         GICK+OwG2Sj3J0eYSLmm0cQ6PNuwyDiamup0hTMTHyt0ANJcfOxSwYsFO+/O7Z46jBhx
         yZkQ==
X-Gm-Message-State: AGi0PuZCovQ5HYTBasELpcwzKOA3/NP0me404tCnDWBjXxZQE/4kmLrr
        geMFnOeAEyX0YN+Xod0oDNE=
X-Google-Smtp-Source: APiQypKYNwLnBbdY/fFSnFE9nzSzFaHjKQi4OXnXowBqj4DelxYMkCtj9koNkJoDO7SouXLQpZ8tAg==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr5844291wmj.22.1587059030074;
        Thu, 16 Apr 2020 10:43:50 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:49 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch 7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
Date:   Thu, 16 Apr 2020 13:43:07 -0400
Message-Id: <20200416174309.34044-7-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
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

