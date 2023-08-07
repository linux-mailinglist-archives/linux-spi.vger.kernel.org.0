Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93D2772484
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHGMoa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHGMoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21636172B
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:15 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCR4nClz1Z1WN;
        Mon,  7 Aug 2023 20:41:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 12/20] spi: gxp: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:57 +0800
Message-ID: <20230807124105.3429709-13-yangyingliang@huawei.com>
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
 drivers/spi/spi-gxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index 88ab3032736b..fd2fac236bbd 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -199,7 +199,7 @@ static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op
 
 static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct gxp_spi *spifi = spi_controller_get_devdata(mem->spi->master);
+	struct gxp_spi *spifi = spi_controller_get_devdata(mem->spi->controller);
 	struct gxp_spi_chip *chip = &spifi->chips[spi_get_chipselect(mem->spi, 0)];
 	int ret;
 
@@ -235,7 +235,7 @@ static const struct spi_controller_mem_ops gxp_spi_mem_ops = {
 
 static int gxp_spi_setup(struct spi_device *spi)
 {
-	struct gxp_spi *spifi = spi_controller_get_devdata(spi->master);
+	struct gxp_spi *spifi = spi_controller_get_devdata(spi->controller);
 	unsigned int cs = spi_get_chipselect(spi, 0);
 	struct gxp_spi_chip *chip = &spifi->chips[cs];
 
@@ -257,7 +257,7 @@ static int gxp_spifi_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	ctlr = devm_spi_alloc_master(dev, sizeof(*spifi));
+	ctlr = devm_spi_alloc_host(dev, sizeof(*spifi));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

