Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842977247A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjHGMoW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjHGMoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133210FE
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:12 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKGDV2hxczVk7h;
        Mon,  7 Aug 2023 20:42:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 09/20] spi: fsl-qspi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:54 +0800
Message-ID: <20230807124105.3429709-10-yangyingliang@huawei.com>
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
 drivers/spi/spi-fsl-qspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index e3de81248893..79bac30e79af 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -367,7 +367,7 @@ static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width)
 static bool fsl_qspi_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
+	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
 	int ret;
 
 	ret = fsl_qspi_check_buswidth(q, op->cmd.buswidth);
@@ -640,7 +640,7 @@ static int fsl_qspi_readl_poll_tout(struct fsl_qspi *q, void __iomem *base,
 
 static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
+	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
 	void __iomem *base = q->iobase;
 	u32 addr_offset = 0;
 	int err = 0;
@@ -702,7 +702,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 static int fsl_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
+	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		if (op->data.nbytes > q->devtype_data->txfifo)
@@ -808,7 +808,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 
 static const char *fsl_qspi_get_name(struct spi_mem *mem)
 {
-	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
+	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &mem->spi->dev;
 	const char *name;
 
@@ -848,7 +848,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	struct fsl_qspi *q;
 	int ret;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*q));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*q));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

