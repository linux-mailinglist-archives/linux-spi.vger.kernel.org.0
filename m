Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A4766902
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjG1JfY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjG1JfQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF93198A
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:14 -0700 (PDT)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC2TS6YwgztRg6;
        Fri, 28 Jul 2023 17:31:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 21/21] spi: npcm-fiu: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:21 +0800
Message-ID: <20230728093221.3312026-22-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-npcm-fiu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 9e8c914ff26c..0ca21ff0e9cc 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -287,7 +287,7 @@ static ssize_t npcm_fiu_direct_read(struct spi_mem_dirmap_desc *desc,
 				    u64 offs, size_t len, void *buf)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(desc->mem->spi->master);
+		spi_controller_get_devdata(desc->mem->spi->controller);
 	struct npcm_fiu_chip *chip = &fiu->chip[spi_get_chipselect(desc->mem->spi, 0)];
 	void __iomem *src = (void __iomem *)(chip->flash_region_mapped_ptr +
 					     offs);
@@ -314,7 +314,7 @@ static ssize_t npcm_fiu_direct_write(struct spi_mem_dirmap_desc *desc,
 				     u64 offs, size_t len, const void *buf)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(desc->mem->spi->master);
+		spi_controller_get_devdata(desc->mem->spi->controller);
 	struct npcm_fiu_chip *chip = &fiu->chip[spi_get_chipselect(desc->mem->spi, 0)];
 	void __iomem *dst = (void __iomem *)(chip->flash_region_mapped_ptr +
 					     offs);
@@ -335,7 +335,7 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 			      bool is_address_size, u8 *data, u32 data_size)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 	u32 uma_cfg = BIT(10);
 	u32 data_reg[4];
 	int ret;
@@ -390,7 +390,7 @@ static int npcm_fiu_uma_write(struct spi_mem *mem,
 			      bool is_address_size, u8 *data, u32 data_size)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 	u32 uma_cfg = BIT(10);
 	u32 data_reg[4] = {0};
 	u32 val;
@@ -439,7 +439,7 @@ static int npcm_fiu_manualwrite(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 	u8 *data = (u8 *)op->data.buf.out;
 	u32 num_data_chunks;
 	u32 remain_data;
@@ -544,7 +544,7 @@ static void npcm_fiux_set_direct_rd(struct npcm_fiu_spi *fiu)
 static int npcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 	struct npcm_fiu_chip *chip = &fiu->chip[spi_get_chipselect(mem->spi, 0)];
 	int ret = 0;
 	u8 *buf;
@@ -604,7 +604,7 @@ static int npcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static int npcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct npcm_fiu_spi *fiu =
-		spi_controller_get_devdata(desc->mem->spi->master);
+		spi_controller_get_devdata(desc->mem->spi->controller);
 	struct npcm_fiu_chip *chip = &fiu->chip[spi_get_chipselect(desc->mem->spi, 0)];
 	struct regmap *gcr_regmap;
 
@@ -665,7 +665,7 @@ static int npcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 
 static int npcm_fiu_setup(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
+	struct spi_controller *ctrl = spi->controller;
 	struct npcm_fiu_spi *fiu = spi_controller_get_devdata(ctrl);
 	struct npcm_fiu_chip *chip;
 
@@ -701,7 +701,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	void __iomem *regbase;
 	int id, ret;
 
-	ctrl = devm_spi_alloc_master(dev, sizeof(*fiu));
+	ctrl = devm_spi_alloc_host(dev, sizeof(*fiu));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -755,7 +755,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = fiu->info->max_cs;
 	ctrl->dev.of_node = dev->of_node;
 
-	ret = devm_spi_register_master(dev, ctrl);
+	ret = devm_spi_register_controller(dev, ctrl);
 	if (ret)
 		clk_disable_unprepare(fiu->clk);
 
-- 
2.25.1

