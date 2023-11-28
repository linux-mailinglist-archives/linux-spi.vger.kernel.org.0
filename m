Return-Path: <linux-spi+bounces-55-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE17FB5A5
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4ED2826C6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF546457;
	Tue, 28 Nov 2023 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928DCC
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:22 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcS43C6Hz1P8vd;
	Tue, 28 Nov 2023 17:22:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:20 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 04/26] spi: stm32-qspi: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:09 +0800
Message-ID: <20231128093031.3707034-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

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


