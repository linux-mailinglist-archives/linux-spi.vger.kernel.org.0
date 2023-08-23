Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3664784F4D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjHWDdn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjHWDdl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23AE4A
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:39 -0700 (PDT)
Received: from dggpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVsGH6Yd0zrSd5;
        Wed, 23 Aug 2023 11:32:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500010.china.huawei.com (7.185.36.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:37 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 13/21] spi: mtk-snfi: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:55 +0800
Message-ID: <20230823033003.3407403-14-yangyingliang@huawei.com>
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
 drivers/spi/spi-mtk-snfi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 4433a8a9299f..43659014bef8 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1255,7 +1255,7 @@ static bool mtk_snand_supports_op(struct spi_mem *mem,
 
 static int mtk_snand_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->master);
+	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->controller);
 	// page ops transfer size must be exactly ((sector_size + spare_size) *
 	// nsectors). Limit the op size if the caller requests more than that.
 	// exec_op will read more than needed and discard the leftover if the
@@ -1282,7 +1282,7 @@ static int mtk_snand_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 
 static int mtk_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->master);
+	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->controller);
 
 	dev_dbg(ms->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
 		op->addr.val, op->addr.buswidth, op->addr.nbytes,
@@ -1382,7 +1382,7 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	if (!dev_id)
 		return -EINVAL;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*ms));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*ms));
 	if (!ctlr)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, ctlr);
-- 
2.25.1

