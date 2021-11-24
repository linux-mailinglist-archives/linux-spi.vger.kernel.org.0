Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A045CD4C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351377AbhKXThi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Nov 2021 14:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351386AbhKXTh1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Nov 2021 14:37:27 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7BC06173E;
        Wed, 24 Nov 2021 11:34:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g19so3603870pfb.8;
        Wed, 24 Nov 2021 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCHp1Lcs8S1SXdSfepI4jxNdAk2DlPFZbhtpgChIs7k=;
        b=AhdkVoxf1EJ9155BXODN+pah4uFdbNuhWBvwVzh5mhDJMPxVxXRLbcC4Eeu/h/jf6L
         PoFtjNQFJy/3uHPKHzrYb09wlKgc+0kMPW4u0kS3ZxGtiktu4bmCeXDE0AIZKUUWbVjW
         nP0LLabxs6XvBAkX0qz8CuF6zaihXS/eelLny9bW93iHIg4jELRyt6PuZXtlL5yzDsNX
         cHbFSx7a5ZVgQVePeyb2U98aKpezW31w5RTHbecufhn7V5yLJbYCXcoxKDbdUL5u7ArY
         5ZuAE0dRtfOvFwNjZfxUKYEk5S/7pYUZPD+LvnXbg9PfphAkdPY9+dHlkXYTzGJMgHR7
         RENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DCHp1Lcs8S1SXdSfepI4jxNdAk2DlPFZbhtpgChIs7k=;
        b=npuAhIo4dmfqjSjbjEhW9pSruho9yIEhIyktvJztVbY0yPPqOHItD0v/qb74OGQl41
         wqc0ODE87xL6E73j4wUZe00bNJ4e87T3RiwNR2icvSuZ+6nGOFBKgFBdUHaQrbil0eKE
         /oB+gnvTJDkbb7uTxkBRlK4G/oNHY8Mx74RxWuNN0A8DLyKo2D5drSNtZl3QnnLVBYIs
         QEPWWC0YMyiiYptj2db5RxbVbK5skHwll4WB+qFdRB5yEl2FtWLNAAdKcXDaVfxgvWz1
         PycMcJuVuLhV8Wg4IcYhr6qV7ey8u3bFoMeC6lS0hLD05Cd88/lbWqBZX2apsyyM8s+R
         oL0g==
X-Gm-Message-State: AOAM532aHVlxTHFQcCzpcxAlBtQil2CYB/9dkfxiiNkwnaCp+t+RZTv1
        XP6D5lpuAsCPHToAepivCts=
X-Google-Smtp-Source: ABdhPJyzE/mxdh5YvE8CJWHgThqRsDXM5bmDDW6HosQG2qsKffcrD9rJOfpm7/8SOBOPscLNuo+nEw==
X-Received: by 2002:a63:374c:: with SMTP id g12mr12089545pgn.35.1637782457419;
        Wed, 24 Nov 2021 11:34:17 -0800 (PST)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id v38sm349510pgl.38.2021.11.24.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:34:17 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 1/2] spi: bcm-qspi: choose sysclk setting based on requested speed
Date:   Wed, 24 Nov 2021 14:33:52 -0500
Message-Id: <20211124193353.32311-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124193353.32311-1-kdasu.kdev@gmail.com>
References: <20211124193353.32311-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check requested speed for a given transfer before setting
27MHz or 108Mhz sysclk on SoCs that support both. This way
for baud rates below 212Khz we can use 27Mhz clock.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index f3de3305d0f5..38e6e2cb62ca 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -287,6 +287,18 @@ static inline int bcm_qspi_spbr_min(struct bcm_qspi *qspi)
 		return 8;
 }
 
+static u32 bcm_qspi_calc_spbr(u32 clk_speed_hz,
+			      const struct bcm_qspi_parms *xp)
+{
+	u32 spbr = 0;
+
+	/* SPBR = System Clock/(2 * SCK Baud Rate) */
+	if (xp->speed_hz)
+		spbr = clk_speed_hz / (xp->speed_hz * 2);
+
+	return spbr;
+}
+
 /* Read qspi controller register*/
 static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type type,
 				unsigned int offset)
@@ -621,9 +633,17 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 			spcr |= MSPI_SPCR3_HALFDUPLEX |  MSPI_SPCR3_HDOUTTYPE;
 
 		if (bcm_qspi_has_sysclk_108(qspi)) {
-			/* SYSCLK_108 */
-			spcr |= MSPI_SPCR3_SYSCLKSEL_108;
-			qspi->base_clk = MSPI_BASE_FREQ * 4;
+			/* check requested baud rate before moving to 108Mhz */
+			spbr = bcm_qspi_calc_spbr(MSPI_BASE_FREQ * 4, xp);
+			if (spbr > QSPI_SPBR_MAX) {
+				/* use SYSCLK_27Mhz for slower baud rates */
+				spcr &= ~MSPI_SPCR3_SYSCLKSEL_MASK;
+				qspi->base_clk = MSPI_BASE_FREQ;
+			} else {
+				/* SYSCLK_108Mhz */
+				spcr |= MSPI_SPCR3_SYSCLKSEL_108;
+				qspi->base_clk = MSPI_BASE_FREQ * 4;
+			}
 		}
 
 		if (xp->bits_per_word > 16) {
@@ -649,9 +669,9 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 		bcm_qspi_write(qspi, MSPI, MSPI_SPCR3, spcr);
 	}
 
-	if (xp->speed_hz)
-		spbr = qspi->base_clk / (2 * xp->speed_hz);
-
+	/* SCK Baud Rate = System Clock/(2 * SPBR) */
+	qspi->max_speed_hz = qspi->base_clk / (bcm_qspi_spbr_min(qspi) * 2);
+	spbr = bcm_qspi_calc_spbr(qspi->base_clk, xp);
 	spbr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spbr);
 
-- 
2.17.1

