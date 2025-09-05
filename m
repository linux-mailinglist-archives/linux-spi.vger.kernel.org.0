Return-Path: <linux-spi+bounces-9923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43314B46306
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64737B65A5F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACF274B41;
	Fri,  5 Sep 2025 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wauCF+lg"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF2271458;
	Fri,  5 Sep 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098847; cv=none; b=NUaVlWQtUbw8txUsoP8/osjGjG3xslbRRoQGHjzkM3MVKZqIReRrBF68nGrt33sTOEfy1WZrGaDP6YNClRwPb9h+f5nlVO/msM+eg1zYNLoeLESictWChNKjRnYN4NcyJPla6Hf2yuvfhbSssGjNKMzysYkiQylf1aMwW+Qr1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098847; c=relaxed/simple;
	bh=aKz5RerzJ0535jV+VWO23TW+VuegWL1IAuAoQFZ3CAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKdR4G/o8WOfv+DVoMLu4Jxu4GAS95UmPwAt+xX4edEscsJO32kygvX6Hdtf4cCSPeeJSxog8reBW2F49+cm8hYRARF6H2+418ZYIAQDrdrlnCXZH4qW5X2QpfR7D5DhZLufOwwZMGkpEGqYlRearoPe92BZBeBBx8R07OrxrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wauCF+lg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J0S5O3385094;
	Fri, 5 Sep 2025 14:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757098828;
	bh=ja+VhWgnaezlhzQbc00MksF1Bt+kqV49jtmkDfOdRXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wauCF+lgH8ETzGv6NT3pohG628irK5Us2c9tbZjkgZVvlrUhg/8LjEmiylElAqC7P
	 Olx34A1vAwS3514a2xPn9xILAiQSiBcqIHLnnKJ7+Tg70FvTWygUFVTBROnBIuYD6w
	 ecBhT8vNZ8zxoJVjS6thBLP/xJdluZH8h1hKjS08=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J0Sc6562025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:00:28 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:00:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:00:27 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J09kR887531;
	Fri, 5 Sep 2025 14:00:23 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>,
        Pratyush Yadav
	<pratyush@kernel.org>
Subject: [PATCH v2 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
Date: Sat, 6 Sep 2025 00:29:57 +0530
Message-ID: <20250905185958.3575037-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905185958.3575037-1-s-k6@ti.com>
References: <20250905185958.3575037-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'max_cs' stores the largest chip select number. It should only
be updated when the current 'cs' is greater than existing 'max_cs'. So,
fix the condition accordingly.

Also, return failure if there are no flash device declared.

Fixes: 0f3841a5e115 ("spi: cadence-qspi: report correct number of chip-select")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447a32a08a93..6627a3059ea3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1722,12 +1722,10 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
-	unsigned int max_cs = cqspi->num_chipselect - 1;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
-	unsigned int cs;
-	int ret;
+	int ret, cs, max_cs = -1;
 
 	/* Get flash device data */
 	for_each_available_child_of_node_scoped(dev->of_node, np) {
@@ -1740,10 +1738,10 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
 			return -EINVAL;
-		} else if (cs < max_cs) {
-			max_cs = cs;
 		}
 
+		max_cs = max_t(int, cs, max_cs);
+
 		f_pdata = &cqspi->f_pdata[cs];
 		f_pdata->cqspi = cqspi;
 		f_pdata->cs = cs;
@@ -1753,6 +1751,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 			return ret;
 	}
 
+	if (max_cs < 0) {
+		dev_err(dev, "No flash device declared\n");
+		return -ENODEV;
+	}
+
 	cqspi->num_chipselect = max_cs + 1;
 	return 0;
 }
-- 
2.34.1


