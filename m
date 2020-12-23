Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072B32E1B0F
	for <lists+linux-spi@lfdr.de>; Wed, 23 Dec 2020 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgLWKjT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Dec 2020 05:39:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37084 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728439AbgLWKjS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Dec 2020 05:39:18 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNAabn4012298;
        Wed, 23 Dec 2020 02:38:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=cmpKQIV/Uylw9g8gT3MGMfcdbSPga/B3o0I2DYWgzyo=;
 b=IMYBFLqjAbvy8ikrYcwuOqrKplIBB5rnWEPQDHs+jdINJSIXvpvnNP5nmWnDmhWKKKS6
 /RpBc/cgvHWoeGmIWblIPKacmydegwQIf9iJqi+EGMq4u2Yx3GDmxFVqRkPPN3FEpOtq
 zoSPZIers8wvAWFS8ONfw2caeyaJryE1ZNFz4Ei+WwgDrjcGW8D08UDPsRJA3KHy31Yz
 XTISNhFCWVWOBRqp9uB37IB/iuCppoYfYJDZRQczpVKL+LDB2zZYcAtujX/ncUYrGcY4
 +p0cMMWWd24a4p6NE7To2eaQLnNNg8mWGXi7nB85gguVe/pfTrEoZo+OIkzNx5VLLQ2I Zw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebdw48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 02:38:37 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 02:38:36 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 02:38:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 02:38:35 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 4D7E63F703F;
        Wed, 23 Dec 2020 02:38:33 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v3 1/2] spi: orion: enable clocks before spi_setup
Date:   Wed, 23 Dec 2020 12:38:26 +0200
Message-ID: <20201223103827.29721-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223103827.29721-1-kostap@marvell.com>
References: <20201223103827.29721-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_04:2020-12-22,2020-12-23 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

The spi-orion driver disables its clocks whenever it is not used.
In usual case during boot (i.e. using SPI flash) it is not a problem,
as the child device driver is present and probed along with
spi_register_master() execution.

However in case the child device driver is not ready
(e.g. when its type is module_spi_driver) the spi_setup() callback
can be called after the spi-orion probe. It may happen,
that as a result there will be an attempt to access controller's
registers with the clocks disabled.

Prevent such situations and make sure the clocks are on,
each time the spi_setup() is called.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/spi/spi-orion.c | 23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b57b8b3cc26e..133727552e99 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -96,10 +96,16 @@ struct orion_spi {
 	struct clk              *clk;
 	struct clk              *axi_clk;
 	const struct orion_spi_dev *devdata;
+	struct device		*dev;
 
 	struct orion_child_options	child[ORION_NUM_CHIPSELECTS];
 };
 
+#ifdef CONFIG_PM
+static int orion_spi_runtime_suspend(struct device *dev);
+static int orion_spi_runtime_resume(struct device *dev);
+#endif
+
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
 {
 	return orion_spi->base + reg;
@@ -507,7 +513,21 @@ static int orion_spi_transfer_one(struct spi_master *master,
 
 static int orion_spi_setup(struct spi_device *spi)
 {
-	return orion_spi_setup_transfer(spi, NULL);
+	int ret;
+#ifdef CONFIG_PM
+	struct orion_spi *orion_spi = spi_master_get_devdata(spi->master);
+	struct device *dev = orion_spi->dev;
+
+	orion_spi_runtime_resume(dev);
+#endif
+
+	ret = orion_spi_setup_transfer(spi, NULL);
+
+#ifdef CONFIG_PM
+	orion_spi_runtime_suspend(dev);
+#endif
+
+	return ret;
 }
 
 static int orion_spi_reset(struct orion_spi *orion_spi)
@@ -630,6 +650,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
+	spi->dev = &pdev->dev;
 
 	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
 	devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
-- 
2.17.1

