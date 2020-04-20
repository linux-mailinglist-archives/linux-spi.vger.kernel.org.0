Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792AF1B1567
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgDTTJ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTJ1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE23C061A0C;
        Mon, 20 Apr 2020 12:09:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so13597940wrx.4;
        Mon, 20 Apr 2020 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNXXP9lApG7Pk0uGqQrG6GURUNsMnY9APjKnGgFUYtI=;
        b=jnLPYLJFSOGueoqhGy8wWNiltsZkyz/8oFgGLGdF0s0BzXqzL/FiUI4XSkI/yupSAk
         yErE23wuv+Sb7TO8cbIjH1RSOXQD/wjxMT6FLEKQN+aNhTnbswn4G2CyGFj7KiBNSBRu
         WvRmkSwZDQ5KqiDTso06crrYXAsbwyDNclx/sOQ15KS02+yHZgFYQz5KkEiFFxK4SAhj
         8FyxWuNKR7N2Dv+waroC/XKL7WMkA54s5GsjgfCKQ2CugmJQVmmbkdP0BEriNqUsNsFA
         7RO/ez3MnXQyRTsTy0Uo9/wSRsLGLMw6WWZWcX6FmusPVKOldx+3oMXPLMhSjqqZEQEL
         iUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNXXP9lApG7Pk0uGqQrG6GURUNsMnY9APjKnGgFUYtI=;
        b=tUjhT+T1Q8QHaFPbCedSgz6kzy2LAJW8hiic6bDeltZKTh3KtIsShgWIVLNch++RCt
         tmI730wQcsD2T5RCB05YiuBMGMZMWtislTtaxo54A3wD/g7G+/MjfChpL6aqJAq/d1rV
         bZ+bdfd/MdTMMNLbXLT2KaQJzwyOaSm1uV85dPGgze2kNAMkIq0+HwL5A2QyLr8O5t4x
         UXhHv5RJswzllUatbAT+nE5JOmm/szJu8iiz4cZIH7aO+JrYwb7TKL3C5xB6sZVr0D1h
         w2SPr++EMKPpe1f4FsThfTPLApe8F90qqHEN0XVpYaUAjrEelQT5t9wODQJlUlPHHOU9
         0S4w==
X-Gm-Message-State: AGi0PuZQ3BvGMeK+FBH7GTpbwXnBzHWMcy75n7986hIN3a1ODOmxEcoB
        Sq6bfUN5LfB+7Pjvt5G4TM0=
X-Google-Smtp-Source: APiQypJPsUGIGkPZOlQoxwNaIpeAdaUmrjme32ArI3P3nIDnhDslvzQpkwv1604559gZo2/vgMtWoA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr20763243wru.203.1587409764772;
        Mon, 20 Apr 2020 12:09:24 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:24 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v3 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
Date:   Mon, 20 Apr 2020 15:08:47 -0400
Message-Id: <20200420190853.45614-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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

