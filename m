Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB978089D
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359240AbjHRJf7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359295AbjHRJf2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF2121
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:27 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRxTZ4vFVztSFM;
        Fri, 18 Aug 2023 17:31:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v3 23/23] spi: spi-sn-f-ospi: switch to use modern name
Date:   Fri, 18 Aug 2023 17:31:54 +0800
Message-ID: <20230818093154.1183529-24-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 drivers/spi/spi-sn-f-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 85e4a01bc8b0..a7c3b3923b4a 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -501,7 +501,7 @@ static int f_ospi_indir_write(struct f_ospi *ospi, struct spi_mem *mem,
 
 static int f_ospi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct f_ospi *ospi = spi_controller_get_devdata(mem->spi->master);
+	struct f_ospi *ospi = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
 	switch (op->data.dir) {
@@ -606,7 +606,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 	u32 num_cs = OSPI_NUM_CS;
 	int ret;
 
-	ctlr = spi_alloc_master(dev, sizeof(*ospi));
+	ctlr = spi_alloc_host(dev, sizeof(*ospi));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

