Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768AE1AFD69
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDST0Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1AC061A0C;
        Sun, 19 Apr 2020 12:26:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so3109204plk.10;
        Sun, 19 Apr 2020 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIIHKZMgTWABWvESzFrAqsSQGXH1JTpkYBryS5d6Pco=;
        b=XT+jzKHaK5SVWB6gicZu+lr91WVIW4wWf0r+vrst293ul4N0j0jjek4P0QbjtGL4GF
         Y/xaBs23rrJbRn+SlLDP4T3wOuO0Vcq5XwjaIyXpKNsWOcK23VQ3XRtDs0gvWxneBFIR
         QwQgvDhVGFucgrxOhHGRk0ln58AP6hHZXxpJW5c3RqDJZfloIpO5EBWmPpl8pnFadUSZ
         PMF6Wc9+YptU/hPKuqMogc6cHh19RIo2SFtSvOFPS6CY011wfwMGucigRngWhuaVKzip
         71CB4osOMiMLPNl9fqZisXnCmc/n4yW1rWPXQ4TrMTeIN+aVZdfPqmoGwTvEPYMyCh9n
         wDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIIHKZMgTWABWvESzFrAqsSQGXH1JTpkYBryS5d6Pco=;
        b=uXNhGAWluGFfPeteru0Oc6fTWrunvi8o8HXpyqUbj7qS4mHQxWXRgZqFN5Yr6/slnf
         3XbN3+op/aVRDeo56h/gFjwT6emJvRy1D9+/wPOA92c+Jvl3vD3esj5GO0sIvkEsX6GI
         b/aDhue4/jndZeE/OaJeGVaKLNbgF49+tvZY32WdjuzghPrcowR3j+sC+XHHADO7CiLC
         XIW9QbsuEIctNeWlIhBFmndNluatFcq7+cjBOftxd422/Sc+eg10ymItuKpjK1z/Hr1P
         hmzyIXaJj4vPl6uSI0MKncWvevCsjTq/ktcD3QhEvKAtFnZFaDcWOnOWJKUDw8iw0++S
         ZNDw==
X-Gm-Message-State: AGi0PuYw8c0cbrSqkmeLPvBCwbOjNT2/7v5dBiRS5jVjeWlGXNJK2sKa
        zxEzIfeQ3xRXh1u6XEH60c2x7HSb7DY=
X-Google-Smtp-Source: APiQypLyQ5do3SL+G7zAadYK6KCsVBohPJxwZuNCSVdeZkRJeBDto2hYQNAv3EcNORlBYQUvvPkMjA==
X-Received: by 2002:a17:90a:94c8:: with SMTP id j8mr17770173pjw.155.1587324384521;
        Sun, 19 Apr 2020 12:26:24 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:24 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
Date:   Sun, 19 Apr 2020 15:23:32 -0400
Message-Id: <20200419192339.32023-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Older MIPS chips have a QSPI/MSPI controller that does not have the
MSPI_REV offset, reading from that offset will cause a bus error. Match
their compatible string and do not perform a read from that register in
that case.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 74f4579c3f6a..d901dcb10d06 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -91,6 +91,7 @@
 #define MSPI_MSPI_STATUS			0x020
 #define MSPI_CPTQP				0x024
 #define MSPI_SPCR3				0x028
+#define MSPI_REV				0x02c
 #define MSPI_TXRAM				0x040
 #define MSPI_RXRAM				0x0c0
 #define MSPI_CDRAM				0x140
@@ -217,6 +218,8 @@ struct bcm_qspi {
 	struct bcm_qspi_dev_id *dev_ids;
 	struct completion mspi_done;
 	struct completion bspi_done;
+	u8 mspi_maj_rev;
+	u8 mspi_min_rev;
 };
 
 static inline bool has_bspi(struct bcm_qspi *qspi)
@@ -1190,8 +1193,35 @@ static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
 	.exec_op = bcm_qspi_exec_mem_op,
 };
 
+struct bcm_qspi_data {
+	bool	has_mspi_rev;
+};
+
+static const struct bcm_qspi_data bcm_qspi_no_rev_data = {
+	.has_mspi_rev	= false,
+};
+
+static const struct bcm_qspi_data bcm_qspi_rev_data = {
+	.has_mspi_rev	= true,
+};
+
 static const struct of_device_id bcm_qspi_of_match[] = {
-	{ .compatible = "brcm,spi-bcm-qspi" },
+	{
+		.compatible = "brcm,spi-bcm7425-qspi",
+		.data = &bcm_qspi_no_rev_data,
+	},
+	{
+		.compatible = "brcm,spi-bcm7429-qspi",
+		.data = &bcm_qspi_no_rev_data,
+	},
+	{
+		.compatible = "brcm,spi-bcm7435-qspi",
+		.data = &bcm_qspi_no_rev_data,
+	},
+	{
+		.compatible = "brcm,spi-bcm-qspi",
+		.data = &bcm_qspi_rev_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);
@@ -1199,12 +1229,15 @@ MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);
 int bcm_qspi_probe(struct platform_device *pdev,
 		   struct bcm_qspi_soc_intc *soc_intc)
 {
+	const struct of_device_id *of_id = NULL;
+	const struct bcm_qspi_data *data;
 	struct device *dev = &pdev->dev;
 	struct bcm_qspi *qspi;
 	struct spi_master *master;
 	struct resource *res;
 	int irq, ret = 0, num_ints = 0;
 	u32 val;
+	u32 rev = 0;
 	const char *name = NULL;
 	int num_irqs = ARRAY_SIZE(qspi_irq_tab);
 
@@ -1212,9 +1245,12 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	if (!dev->of_node)
 		return -ENODEV;
 
-	if (!of_match_node(bcm_qspi_of_match, dev->of_node))
+	of_id = of_match_node(bcm_qspi_of_match, dev->of_node);
+	if (!of_id)
 		return -ENODEV;
 
+	data = of_id->data;
+
 	master = spi_alloc_master(dev, sizeof(struct bcm_qspi));
 	if (!master) {
 		dev_err(dev, "error allocating spi_master\n");
@@ -1349,6 +1385,16 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->base_clk = clk_get_rate(qspi->clk);
 	qspi->max_speed_hz = qspi->base_clk / (QSPI_SPBR_MIN * 2);
 
+	if (data->has_mspi_rev) {
+		rev = bcm_qspi_read(qspi, MSPI, MSPI_REV);
+		/* some older revs do not have a MSPI_REV register */
+		if ((rev & 0xff) == 0xff)
+			rev = 0;
+	}
+
+	qspi->mspi_maj_rev = (rev >> 4) & 0xf;
+	qspi->mspi_min_rev = rev & 0xf;
+
 	bcm_qspi_hw_init(qspi);
 	init_completion(&qspi->mspi_done);
 	init_completion(&qspi->bspi_done);
-- 
2.17.1

