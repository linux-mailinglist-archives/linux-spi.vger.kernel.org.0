Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183C77248D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjHGMof (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjHGMo0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B431988
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:16 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCV0404z1Z1WG;
        Mon,  7 Aug 2023 20:41:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 18/20] spi: intel: switch to use modern name
Date:   Mon, 7 Aug 2023 20:41:03 +0800
Message-ID: <20230807124105.3429709-19-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-intel.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index bc6d22149e7e..98ec4dc22b81 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -143,7 +143,7 @@
  * @base: Beginning of MMIO space
  * @pregs: Start of protection registers
  * @sregs: Start of software sequencer registers
- * @master: Pointer to the SPI controller structure
+ * @host: Pointer to the SPI controller structure
  * @nregions: Maximum number of regions
  * @pr_num: Maximum number of protected range registers
  * @chip0_size: Size of the first flash chip in bytes
@@ -161,7 +161,7 @@ struct intel_spi {
 	void __iomem *base;
 	void __iomem *pregs;
 	void __iomem *sregs;
-	struct spi_controller *master;
+	struct spi_controller *host;
 	size_t nregions;
 	size_t pr_num;
 	size_t chip0_size;
@@ -747,7 +747,7 @@ intel_spi_match_mem_op(struct intel_spi *ispi, const struct spi_mem_op *op)
 static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 				      const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	struct intel_spi *ispi = spi_controller_get_devdata(mem->spi->controller);
 	const struct intel_spi_mem_op *iop;
 
 	iop = intel_spi_match_mem_op(ispi, op);
@@ -778,7 +778,7 @@ static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 
 static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	struct intel_spi *ispi = spi_controller_get_devdata(mem->spi->controller);
 	const struct intel_spi_mem_op *iop;
 
 	iop = intel_spi_match_mem_op(ispi, op);
@@ -790,7 +790,7 @@ static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 static const char *intel_spi_get_name(struct spi_mem *mem)
 {
-	const struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	const struct intel_spi *ispi = spi_controller_get_devdata(mem->spi->controller);
 
 	/*
 	 * Return name of the flash controller device to be compatible
@@ -801,7 +801,7 @@ static const char *intel_spi_get_name(struct spi_mem *mem)
 
 static int intel_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop;
 
 	iop = intel_spi_match_mem_op(ispi, &desc->info.op_tmpl);
@@ -815,7 +815,7 @@ static int intel_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
 				     size_t len, void *buf)
 {
-	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop = desc->priv;
 	struct spi_mem_op op = desc->info.op_tmpl;
 	int ret;
@@ -832,7 +832,7 @@ static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
 static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs,
 				      size_t len, const void *buf)
 {
-	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop = desc->priv;
 	struct spi_mem_op op = desc->info.op_tmpl;
 	int ret;
@@ -1332,14 +1332,14 @@ static int intel_spi_read_desc(struct intel_spi *ispi)
 
 	nc = (buf[1] & FLMAP0_NC_MASK) >> FLMAP0_NC_SHIFT;
 	if (!nc)
-		ispi->master->num_chipselect = 1;
+		ispi->host->num_chipselect = 1;
 	else if (nc == 1)
-		ispi->master->num_chipselect = 2;
+		ispi->host->num_chipselect = 2;
 	else
 		return -EINVAL;
 
 	dev_dbg(ispi->dev, "%u flash components found\n",
-		ispi->master->num_chipselect);
+		ispi->host->num_chipselect);
 	return 0;
 }
 
@@ -1365,7 +1365,7 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	snprintf(chip.modalias, 8, "spi-nor");
 	chip.platform_data = pdata;
 
-	if (!spi_new_device(ispi->master, &chip))
+	if (!spi_new_device(ispi->host, &chip))
 		return -ENODEV;
 
 	ret = intel_spi_read_desc(ispi);
@@ -1373,13 +1373,13 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 		return ret;
 
 	/* Add the second chip if present */
-	if (ispi->master->num_chipselect < 2)
+	if (ispi->host->num_chipselect < 2)
 		return 0;
 
 	chip.platform_data = NULL;
 	chip.chip_select = 1;
 
-	if (!spi_new_device(ispi->master, &chip))
+	if (!spi_new_device(ispi->host, &chip))
 		return -ENODEV;
 	return 0;
 }
@@ -1396,31 +1396,31 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 int intel_spi_probe(struct device *dev, struct resource *mem,
 		    const struct intel_spi_boardinfo *info)
 {
-	struct spi_controller *master;
+	struct spi_controller *host;
 	struct intel_spi *ispi;
 	int ret;
 
-	master = devm_spi_alloc_master(dev, sizeof(*ispi));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(*ispi));
+	if (!host)
 		return -ENOMEM;
 
-	master->mem_ops = &intel_spi_mem_ops;
+	host->mem_ops = &intel_spi_mem_ops;
 
-	ispi = spi_master_get_devdata(master);
+	ispi = spi_controller_get_devdata(host);
 
 	ispi->base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(ispi->base))
 		return PTR_ERR(ispi->base);
 
 	ispi->dev = dev;
-	ispi->master = master;
+	ispi->host = host;
 	ispi->info = info;
 
 	ret = intel_spi_init(ispi);
 	if (ret)
 		return ret;
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		return ret;
 
-- 
2.25.1

