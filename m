Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC801B156C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgDTTJh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727985AbgDTTJg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E06FC061A0F;
        Mon, 20 Apr 2020 12:09:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so765624wmk.5;
        Mon, 20 Apr 2020 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=RwFLpx1l8uegfDKUqFMecesRs+bMBFquuhcu7wdDWUUG1+sTg3lM6YgHCQgENobSxA
         Z48fmWtWLs+aeePjSeRRyci7rPmWm2aXOKFPvfwsGzasqqbBPE4jCoQse488/GWsOFIi
         fM+tImLEE384mae+9Z+0ZPSQcWKsPe2Ui6LDk+dd6cGU+G9k1nh1YUL0XO2qzgfzFn1f
         nW7lRs/KxTEleC+mstHpnFbRT0irEpudGwyWNkRQopYYfz64wCEeoVH+NIaRihHy3xUV
         c+cH9+RRqrBlXRIKsTO4TsH/LK6JFEsa38uGfrUKt5XerXzwi6lVqhPcoP+DmtxxQTsZ
         7Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=Y2+kTfrTuDd49vgsYwpdpH+V9nbBGo7pOm2DwuGMe9Sb+Kx1LxxFOjh8ZXDGL9x6uW
         AtBNuvJqGj2uMNy8cP9l82YF0yYjZg1DtB9X/e1X0bhTJAc37JJIAJjsKyKfufpZ+uYB
         YL3WPbGlBA6E4/+9XtqjIqJCsk+8KohPCpZXkhQvmZUq3TRmoLAU5j8xQKMio9WWvUZ/
         saM444kVSSD+5lPn42nMKXMZ01QoMk3CXtH0GRMkRj28gEW9f3YhiMMkWgyYxvHeETWf
         o9ApdIGK3yf1OUo67u6wr9pAva9k8kpcVXlWuwZfsL/BILLfgR1NQRK0jcdCCCGGmXrB
         0V4g==
X-Gm-Message-State: AGi0PuZ4H42Cu9XaOpIjhCxkBlQ6Ctx6j3E8GC9qq9RCC7xaf2R89Nja
        7MQ7T903VSzzYpO0WGl0Ibs=
X-Google-Smtp-Source: APiQypJYNY3iD8Jn/EHLbCVKIpvCKhuz18FHQmlaD64SVyU1VvBD+3VWvq08ybNhVRYjLZou0zxQUA==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr829753wmc.132.1587409774803;
        Mon, 20 Apr 2020 12:09:34 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:34 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
Date:   Mon, 20 Apr 2020 15:08:52 -0400
Message-Id: <20200420190853.45614-9-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
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

