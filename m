Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B521C78376E
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjHVBin (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjHVBin (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0D12C
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:40 -0700 (PDT)
Received: from dggpemm100022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBlF05x3zVkGF;
        Tue, 22 Aug 2023 09:36:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100022.china.huawei.com (7.185.36.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 04/24] spi: stm32-qspi: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:51 +0800
Message-ID: <20230822013511.4161475-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-stm32-qspi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index def74ae9b5f6..385832030459 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -357,7 +357,7 @@ static int stm32_qspi_get_mode(u8 buswidth)
 
 static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(spi->master);
+	struct stm32_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	struct stm32_qspi_flash *flash = &qspi->flash[spi_get_chipselect(spi, 0)];
 	u32 ccr, cr;
 	int timeout, err = 0, err_poll_status = 0;
@@ -448,7 +448,7 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 				  unsigned long polling_rate_us,
 				  unsigned long timeout_ms)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	int ret;
 
 	if (!spi_mem_supports_op(mem, op))
@@ -476,7 +476,7 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 
 static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(qspi->dev);
@@ -500,7 +500,7 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 static int stm32_qspi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->controller);
 
 	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
 		return -EOPNOTSUPP;
@@ -518,7 +518,7 @@ static int stm32_qspi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->controller);
 	struct spi_mem_op op;
 	u32 addr_max;
 	int ret;
@@ -640,7 +640,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 
 static int stm32_qspi_setup(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
+	struct spi_controller *ctrl = spi->controller;
 	struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
 	struct stm32_qspi_flash *flash;
 	u32 presc, mode;
@@ -775,7 +775,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 
-	ctrl = devm_spi_alloc_master(dev, sizeof(*qspi));
+	ctrl = devm_spi_alloc_host(dev, sizeof(*qspi));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -861,7 +861,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 
-	ret = spi_register_master(ctrl);
+	ret = spi_register_controller(ctrl);
 	if (ret)
 		goto err_pm_runtime_free;
 
@@ -892,7 +892,7 @@ static void stm32_qspi_remove(struct platform_device *pdev)
 	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(qspi->dev);
-	spi_unregister_master(qspi->ctrl);
+	spi_unregister_controller(qspi->ctrl);
 	/* disable qspi */
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	stm32_qspi_dma_free(qspi);
-- 
2.25.1

