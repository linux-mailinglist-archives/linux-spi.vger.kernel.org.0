Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E229427263
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbhJHUiP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbhJHUiK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 16:38:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB3C061570;
        Fri,  8 Oct 2021 13:36:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so8431246pjb.4;
        Fri, 08 Oct 2021 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVmxm9Ikv3xnVC2UFy2AvZ69N3e5sKTdTcODgs7Rngw=;
        b=L9IHrkfiQR5sjpv2/Q5KBoaGe1C213u1QtOloaGhGLvRXG9J3GykOgTwd1Jl6imvQa
         swD2p0fkUYsfctr/uT84rSDIyPYFhZzcdL9DSzoJxG3QWYA1HG5eOJDXcfxxrhv4XF4Q
         Weox3GPVH4b5K5lYEPQ65EhT7laco0Jbbg0qjnrRWm87ITV0e3vsHL0WLmyZSz8b4Xfc
         9ptNXv3lJ/0nBz41ThR+HIfBowy5sGbRoz4eb2WQ0FbYTg39lZxc29T/TuTO8DtZkDqj
         NHH+liiMlR1z+jJP+oMCfhWbe+N8cOFr6JlpsCphwdmOg+3BEMtC5pK8PhE7PJVka/dw
         ByCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qVmxm9Ikv3xnVC2UFy2AvZ69N3e5sKTdTcODgs7Rngw=;
        b=btujPfFlrHnAy7K2Exw6B28XX48+PCyqIT8aeIDD/mn5rnJ3p+I+92MH8QmROlkXnf
         o+gL2K/t1Nn73aI5hiwoRnkeQMCP7y44S+fCc7tmNKYMoyH15V7elrqigg9YSekys6Ib
         sT7YDv3elgt2S4csaERvQ3t7TwM6SmD6XcnDGpzsEPJ6+M99/izS14qDHB5lV4S3f1mb
         nxlHA2pC0cM9eHzMeo3iP0e6SaRgFOqDh3Ax4HDGCwQ7m9XeKl+CQQg/NEueg3hcpXyK
         1foOPA8FEphjR7dE4GUwK/NDHSUWqUaCV333zGbnoAix457QRql7RPoC4s8RMEq1XDKk
         9Dgg==
X-Gm-Message-State: AOAM533P1AWhAF1GD+Dhy3IYU7kXZN/LbFnJWmYwYTbPzJ4T/GZTH6xz
        PgkRity1ZtJaBvKG5y/UtgDukqaasW0=
X-Google-Smtp-Source: ABdhPJz6erZ7X+cwFfu4PxMAHUl0lGwEnrRc2DpumhoC0QwDfRKOaYNQ2cpgfEbL8jK9/it5+RIrmw==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr13746820pjb.159.1633725374345;
        Fri, 08 Oct 2021 13:36:14 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q6sm117615pjd.26.2021.10.08.13.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:36:14 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 2/3] spi: bcm-qspi: clear MSPI spifie interrupt during probe
Date:   Fri,  8 Oct 2021 16:36:02 -0400
Message-Id: <20211008203603.40915-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008203603.40915-1-kdasu.kdev@gmail.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Kamal Dasu <kdasu@broadcom.com>

Intermittent Kernel crash has been observed on probe in
bcm_qspi_mspi_l2_isr() handler when the MSPI spifie interrupt bit
has not been cleared before registering for interrupts.
Fix the driver to move SoC specific custom interrupt handling code
before we register IRQ in probe. Also clear MSPI interrupt status
resgiter prior to registering IRQ handlers.

Fixes: cc20a38612db ("spi: iproc-qspi: Add Broadcom iProc SoCs support")
Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 77 ++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 9a2d12e7650c..c7c467f15e63 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1380,10 +1380,14 @@ static void bcm_qspi_hw_init(struct bcm_qspi *qspi)
 
 static void bcm_qspi_hw_uninit(struct bcm_qspi *qspi)
 {
+	u32 status = bcm_qspi_read(qspi, MSPI, MSPI_MSPI_STATUS);
+
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR2, 0);
 	if (has_bspi(qspi))
 		bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
 
+	/* clear interrupt */
+	bcm_qspi_write(qspi, MSPI, MSPI_MSPI_STATUS, status & ~1);
 }
 
 static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
@@ -1527,6 +1531,47 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	if (!qspi->dev_ids)
 		return -ENOMEM;
 
+	/*
+	 * Some SoCs integrate spi controller (e.g., its interrupt bits)
+	 * in specific ways
+	 */
+	if (soc_intc) {
+		qspi->soc_intc = soc_intc;
+		soc_intc->bcm_qspi_int_set(soc_intc, MSPI_DONE, true);
+	} else {
+		qspi->soc_intc = NULL;
+	}
+
+	if (qspi->clk) {
+		ret = clk_prepare_enable(qspi->clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			goto qspi_probe_err;
+		}
+		qspi->base_clk = clk_get_rate(qspi->clk);
+	} else {
+		qspi->base_clk = MSPI_BASE_FREQ;
+	}
+
+	if (data->has_mspi_rev) {
+		rev = bcm_qspi_read(qspi, MSPI, MSPI_REV);
+		/* some older revs do not have a MSPI_REV register */
+		if ((rev & 0xff) == 0xff)
+			rev = 0;
+	}
+
+	qspi->mspi_maj_rev = (rev >> 4) & 0xf;
+	qspi->mspi_min_rev = rev & 0xf;
+	qspi->mspi_spcr3_sysclk = data->has_spcr3_sysclk;
+
+	qspi->max_speed_hz = qspi->base_clk / (bcm_qspi_spbr_min(qspi) * 2);
+
+	/*
+	 * On SW resets it is possible to have the mask still enabled
+	 * Need to disable the mask and clear the status while we init
+	 */
+	bcm_qspi_hw_uninit(qspi);
+
 	for (val = 0; val < num_irqs; val++) {
 		irq = -1;
 		name = qspi_irq_tab[val].irq_name;
@@ -1563,38 +1608,6 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		goto qspi_probe_err;
 	}
 
-	/*
-	 * Some SoCs integrate spi controller (e.g., its interrupt bits)
-	 * in specific ways
-	 */
-	if (soc_intc) {
-		qspi->soc_intc = soc_intc;
-		soc_intc->bcm_qspi_int_set(soc_intc, MSPI_DONE, true);
-	} else {
-		qspi->soc_intc = NULL;
-	}
-
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		goto qspi_probe_err;
-	}
-
-	qspi->base_clk = clk_get_rate(qspi->clk);
-
-	if (data->has_mspi_rev) {
-		rev = bcm_qspi_read(qspi, MSPI, MSPI_REV);
-		/* some older revs do not have a MSPI_REV register */
-		if ((rev & 0xff) == 0xff)
-			rev = 0;
-	}
-
-	qspi->mspi_maj_rev = (rev >> 4) & 0xf;
-	qspi->mspi_min_rev = rev & 0xf;
-	qspi->mspi_spcr3_sysclk = data->has_spcr3_sysclk;
-
-	qspi->max_speed_hz = qspi->base_clk / (bcm_qspi_spbr_min(qspi) * 2);
-
 	bcm_qspi_hw_init(qspi);
 	init_completion(&qspi->mspi_done);
 	init_completion(&qspi->bspi_done);
-- 
2.17.1

