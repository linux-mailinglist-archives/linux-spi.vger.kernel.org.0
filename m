Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46C1ACEF6
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbgDPRn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388620AbgDPRnz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01555C061A0C;
        Thu, 16 Apr 2020 10:43:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x25so5543429wmc.0;
        Thu, 16 Apr 2020 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=F5uk01PTx7OgePgWOdB7X5sgC484GyNH/8lT6Y9IzSqeX2dlmm2b/XyeFRS3a0hv0T
         RB6AAlg8FfN4XmrA3cvm6YOP0zFpb2CUvNOdJX3NM8v0mhpij1UsCPPeSGKdcIOxGvpW
         NfIkpQQspceu4fTbywFRgePYWFSragLml+A2fPNYkw1uTGsc4QtySXBqyerEIO8EsBJS
         ImI/VcbPZX92g5FIJtspkGtx4Ki4TOCfLULdY4oW5goGyvmFTHXoONIXRlvfPfBAm4gq
         EXU4pzdJIbTUiDlfDA/O8sSFSCqZhjKlSAJ3YM02uiKQCvCCUIKwcmnVwS9t/YQ6XF6y
         a6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwQZbSyo/ooB+KPpLKSrh54aVWxFR91fOhXcxwQ1VWs=;
        b=QBJ8h68bFInt7x15qR+cDf5+BUFk/2TXImLJ5VLsclfSfgKwMlGLoo6ZMWIUBt2HSa
         nTZbWZh2GwMdFuN/Cy0FNvOrl84MQfgP9OzBG7NuyiMAyKz34v3Rlkp0pvxydIhZ+Lk3
         ezsOA9KzPooITF8ucDPPUJFWE4H5TTB7mWJCXV0Yqus3F0U77E5g4WnPoYhFHNHChcUc
         ljFFsydH23S+4vdzg6agP58HJXlUHAJc08v1vADAOuKxVEqNXg0HDZZYKg0JmrkEx2YS
         F/Urid8oqG+leKcpaOap+URQdNovtcPM5ELF5tffU8zgYvLnyiTbMAg1CZ9xZpCtTu0t
         c3dw==
X-Gm-Message-State: AGi0PuZnxfUVT0dkxxz7OX/Td37a8+gtTC7rI5cyPN0sGgCxpudfJYy9
        k+wX10kwkkCD+Hu7+nSkpD8=
X-Google-Smtp-Source: APiQypK74wH8XE0aC+pn74KAzAbUH/8IRXOAY9sYOulz7KFi8NppFhsYiJ5DxlgRr1pcRZdL2x9tzg==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr5680822wmb.112.1587059033748;
        Thu, 16 Apr 2020 10:43:53 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:53 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch 8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
Date:   Thu, 16 Apr 2020 13:43:08 -0400
Message-Id: <20200416174309.34044-8-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
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

