Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3279351891
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDARqF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 13:46:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15521 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDARkA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 13:40:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FB4Wv5kvkzNrp3;
        Thu,  1 Apr 2021 21:58:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:00:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] spi: fsl: add missing iounmap() on error in of_fsl_spi_probe()
Date:   Thu, 1 Apr 2021 22:03:50 +0800
Message-ID: <20210401140350.1677925-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the missing iounmap() before return from of_fsl_spi_probe()
in the error handling case.

Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-fsl-spi.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e4a8d203f940..d0e5aa18b7ba 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -707,6 +707,11 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct resource mem;
 	int irq, type;
 	int ret;
+	bool spisel_boot = false;
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	struct mpc8xxx_spi_probe_info *pinfo = NULL;
+#endif
+
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -715,9 +720,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	type = fsl_spi_get_type(&ofdev->dev);
 	if (type == TYPE_FSL) {
 		struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-		bool spisel_boot = false;
 #if IS_ENABLED(CONFIG_FSL_SOC)
-		struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
+		pinfo = to_of_pinfo(pdata);
 
 		spisel_boot = of_property_read_bool(np, "fsl,spisel_boot");
 		if (spisel_boot) {
@@ -746,15 +750,24 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		return ret;
+		goto unmap_out;
 
 	irq = platform_get_irq(ofdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto unmap_out;
+	}
 
 	master = fsl_spi_probe(dev, &mem, irq);
 
 	return PTR_ERR_OR_ZERO(master);
+
+unmap_out:
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	if (spisel_boot)
+		iounmap(pinfo->immr_spi_cs);
+#endif
+	return ret;
 }
 
 static int of_fsl_spi_remove(struct platform_device *ofdev)
-- 
2.25.1

