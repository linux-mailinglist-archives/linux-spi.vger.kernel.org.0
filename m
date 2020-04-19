Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B01AFD73
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDST0p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACFC061A0C;
        Sun, 19 Apr 2020 12:26:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q16so3957805pje.1;
        Sun, 19 Apr 2020 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=IRX+3z0igOb23aRnmiSGW997ZcR0dpRnr7Qoay5x69Lr9X5G1bU1H8EcSjALbWvvJ7
         XkUz8HFZbFSekK+Qe3TXvTykyjVLcbuz2gaOL6Xz+NSLr8eyckgguYOdr2NuLnMk9mPv
         64QGo5wCHfwz48uq9v690eHShaKZGEDtJLg9TfDluEpaRuA2TLylKu3BZu1lnhVcWgZk
         b+VoTcDa+ekcYkKziPa9Rrz/QrQwID/8wM2g2HHl4VpN5gP2ojJ+PQp8QNQOcKHoImIK
         pMTKqSfD//cKqnBbxtuHt6bJneq8/DL7h7fE1c+zf4Vy1hhNjjP4wT6VvzPbq6mKko8/
         MTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=AJauoK5d/2T8oX7DQHnQ9qrjiNLVd47Z9x35X6XnunA9VOIkG2smXFWMLVV0C3hy3b
         WoKV31J/CTnDDMcFzQenHV1RTLsV/84fWHBMGH/fFl2wM8eECImMNVmAepLbugbaCBEt
         ZpgHEIVc9NDgtOoil7jZutdj419IbfHRaTC+JiOtNNBXOgjAAP06SAr5ZYBHkjVJNy6x
         yKEaDks5rjJvJ/icM2qC9leW3BreZQOpNvPzRiNyBZjcxtaAdyQGL3OQYMzezeVwkIuq
         NA+9+4yR36awbT8M7tQUCHYsI0C3sB2PAEQC3RZnyTdQEPoGjUPuewPymF7ihT5GQQXT
         aFMw==
X-Gm-Message-State: AGi0PuZ0nsy47/+QqBS3SBmURNYy39jYDGRqvwInkr6rRvJq17Y53FTp
        4fjLHETQTwjRjwVnlbpcWTQ=
X-Google-Smtp-Source: APiQypI3ruvV8bmB2oQILAgyXtv+2pc8V6oCcdLWEFbDTiL0NnoP/m/R83DaAfriHtRmf0FTdj/KZA==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr17286561pjv.17.1587324401507;
        Sun, 19 Apr 2020 12:26:41 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:41 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
Date:   Sun, 19 Apr 2020 15:23:37 -0400
Message-Id: <20200419192339.32023-9-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Adding support for MSPI sys clk 108Mhz available on 7216
and 7278 BRCMSTB SoCs.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index edc601dbf221..99f2cfcbb50c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -109,6 +109,11 @@
 
 #define MSPI_SPCR3_FASTBR			BIT(0)
 #define MSPI_SPCR3_FASTDT			BIT(1)
+#define MSPI_SPCR3_SYSCLKSEL_MASK		GENMASK(11, 10)
+#define MSPI_SPCR3_SYSCLKSEL_27			(MSPI_SPCR3_SYSCLKSEL_MASK & \
+						 ~(BIT(10) | BIT(11)))
+#define MSPI_SPCR3_SYSCLKSEL_108		(MSPI_SPCR3_SYSCLKSEL_MASK & \
+						 BIT(11))
 
 #define MSPI_MSPI_STATUS_SPIF			BIT(0)
 
@@ -117,6 +122,7 @@
 
 #define NUM_CHIPSELECT				4
 #define QSPI_SPBR_MAX				255U
+#define MSPI_BASE_FREQ				27000000UL
 
 #define OPCODE_DIOR				0xBB
 #define OPCODE_QIOR				0xEB
@@ -222,6 +228,7 @@ struct bcm_qspi {
 	struct completion bspi_done;
 	u8 mspi_maj_rev;
 	u8 mspi_min_rev;
+	bool mspi_spcr3_sysclk;
 };
 
 static inline bool has_bspi(struct bcm_qspi *qspi)
@@ -240,6 +247,17 @@ static inline bool bcm_qspi_has_fastbr(struct bcm_qspi *qspi)
 	return false;
 }
 
+/* hardware supports sys clk 108Mhz  */
+static inline bool bcm_qspi_has_sysclk_108(struct bcm_qspi *qspi)
+{
+	if (!has_bspi(qspi) && (qspi->mspi_spcr3_sysclk ||
+	    ((qspi->mspi_maj_rev >= 1) &&
+	     (qspi->mspi_min_rev >= 6))))
+		return true;
+
+	return false;
+}
+
 static inline int bcm_qspi_spbr_min(struct bcm_qspi *qspi)
 {
 	if (bcm_qspi_has_fastbr(qspi))
@@ -570,6 +588,15 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 
 		/* enable fastbr */
 		spcr |=	MSPI_SPCR3_FASTBR;
+
+		if (bcm_qspi_has_sysclk_108(qspi)) {
+			/* SYSCLK_108 */
+			spcr |= MSPI_SPCR3_SYSCLKSEL_108;
+			qspi->base_clk = MSPI_BASE_FREQ * 4;
+			/* Change spbr as we changed sysclk */
+			bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, 4);
+		}
+
 		bcm_qspi_write(qspi, MSPI, MSPI_SPCR3, spcr);
 	}
 
@@ -1229,14 +1256,22 @@ static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
 
 struct bcm_qspi_data {
 	bool	has_mspi_rev;
+	bool	has_spcr3_sysclk;
 };
 
 static const struct bcm_qspi_data bcm_qspi_no_rev_data = {
 	.has_mspi_rev	= false,
+	.has_spcr3_sysclk = false,
 };
 
 static const struct bcm_qspi_data bcm_qspi_rev_data = {
 	.has_mspi_rev	= true,
+	.has_spcr3_sysclk = false,
+};
+
+static const struct bcm_qspi_data bcm_qspi_spcr3_data = {
+	.has_mspi_rev	= true,
+	.has_spcr3_sysclk = true,
 };
 
 static const struct of_device_id bcm_qspi_of_match[] = {
@@ -1256,6 +1291,14 @@ static const struct of_device_id bcm_qspi_of_match[] = {
 		.compatible = "brcm,spi-bcm-qspi",
 		.data = &bcm_qspi_rev_data,
 	},
+	{
+		.compatible = "brcm,spi-bcm7216-qspi",
+		.data = &bcm_qspi_spcr3_data,
+	},
+	{
+		.compatible = "brcm,spi-bcm7278-qspi",
+		.data = &bcm_qspi_spcr3_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);
@@ -1427,6 +1470,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 
 	qspi->mspi_maj_rev = (rev >> 4) & 0xf;
 	qspi->mspi_min_rev = rev & 0xf;
+	qspi->mspi_spcr3_sysclk = data->has_spcr3_sysclk;
 
 	qspi->max_speed_hz = qspi->base_clk / (bcm_qspi_spbr_min(qspi) * 2);
 
-- 
2.17.1

