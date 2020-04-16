Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFAD1ACEED
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgDPRnf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731594AbgDPRne (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCEBC061A0C;
        Thu, 16 Apr 2020 10:43:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so5813544wrw.12;
        Thu, 16 Apr 2020 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIIHKZMgTWABWvESzFrAqsSQGXH1JTpkYBryS5d6Pco=;
        b=phzdgga1mZGif3iDH4ooykTD9HfRkTtyO9mld+hknhko9waPiSyG+fm9tgXz3eiy4U
         n06vUNGnTIaNdawZ1AkU0166AqW42Pc2kAQlG8NTcIOyt/Awlk/eu13PCzkelrHu/5XG
         iKd0ThS3fuWFxUDK8GRul7Tzl96Jv5gI8q9Ppwk3fwWkzGQrd/7XNO26DtDIkwQOXMQi
         pj8M+lhlFAgRpxLhbsJ9D0LmkWyxuAcdxZiP73hV6b7YLLRkFTjVZrOfQDvNnfz+2pcH
         RpjI63TcMcu0KCeJ1ONVIhXdVRpyUUzmS3ly/60AZvo++B16opJoEkEuOvdO1tAcSuYO
         fTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIIHKZMgTWABWvESzFrAqsSQGXH1JTpkYBryS5d6Pco=;
        b=Y9qO+SS7KB9bK8seGEFZvCXGFvSYqB7m49EfhLZxQTO7Es6H6Kus9qvXVNTAP+pPUJ
         HqqMIRiYYu79KKCtuW+8/BJYpnbM529BUcLtlB/C4+hldoP/iAfAIj9ufn6a0PmLHmum
         Bkqu4S1nyjGLM6f53PLOP4R69hDw0KNQei907rSm4HJuHpYTU5GYcksIWMbhPhMTVoyW
         eTewGSb8HtscaAdRkCNBl288SaVpDW7F7JnZiLpfsnLASuC55jfkLu8BOq1q5hHITjRj
         ZmIYRygj5q5PFBiXrtD2TDcucbgIRNBIiI0iLsYeK4ANX88HTGGNkJT0fmcl6EFUCnIU
         4uQQ==
X-Gm-Message-State: AGi0PubH6QHI/MW/Wsy0qhM8OjD60uvZj8ygFKyq85J/bNHP1SVdiXdX
        gp7vm7BeCLgiuNy5OE30o7s=
X-Google-Smtp-Source: APiQypI0ucS2+aa5ts9CY4CGNKZLriSVtcdZsPeTi/cm2780LgC5U6bE54m7KNyU0aYe0cS0yMcX0g==
X-Received: by 2002:adf:e486:: with SMTP id i6mr33972183wrm.377.1587059011390;
        Thu, 16 Apr 2020 10:43:31 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:30 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
Date:   Thu, 16 Apr 2020 13:43:03 -0400
Message-Id: <20200416174309.34044-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
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

