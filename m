Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAA784F4B
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjHWDdm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjHWDdk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D2CF2
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:38 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsGJ2LPhz1L9Zr;
        Wed, 23 Aug 2023 11:32:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:37 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 12/21] spi: mtk-nor: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:54 +0800
Message-ID: <20230823033003.3407403-13-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-mtk-nor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index cf4ee8b19e42..62b1c8995fa4 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -275,7 +275,7 @@ static void mtk_nor_adj_prg_size(struct spi_mem_op *op)
 
 static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
+	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->controller);
 
 	if (!op->data.nbytes)
 		return 0;
@@ -598,7 +598,7 @@ static int mtk_nor_spi_mem_prg(struct mtk_nor *sp, const struct spi_mem_op *op)
 
 static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
+	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->controller);
 	int ret;
 
 	if ((op->data.nbytes == 0) ||
@@ -639,7 +639,7 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 static int mtk_nor_setup(struct spi_device *spi)
 {
-	struct mtk_nor *sp = spi_controller_get_devdata(spi->master);
+	struct mtk_nor *sp = spi_controller_get_devdata(spi->controller);
 
 	if (spi->max_speed_hz && (spi->max_speed_hz < sp->spi_freq)) {
 		dev_err(&spi->dev, "spi clock should be %u Hz.\n",
@@ -651,10 +651,10 @@ static int mtk_nor_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int mtk_nor_transfer_one_message(struct spi_controller *master,
+static int mtk_nor_transfer_one_message(struct spi_controller *host,
 					struct spi_message *m)
 {
-	struct mtk_nor *sp = spi_controller_get_devdata(master);
+	struct mtk_nor *sp = spi_controller_get_devdata(host);
 	struct spi_transfer *t = NULL;
 	unsigned long trx_len = 0;
 	int stat = 0;
@@ -696,7 +696,7 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
 	m->actual_length = trx_len;
 msg_done:
 	m->status = stat;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -844,7 +844,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
 		return -ENOMEM;
-- 
2.25.1

