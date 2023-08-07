Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020B677272E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHGOK1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjHGOKX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F892
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:21 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJ7n58CyzVjth;
        Mon,  7 Aug 2023 22:08:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 09/21] spi: butterfly: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:05 +0800
Message-ID: <20230807140717.3484180-10-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-butterfly.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index cceae816cebc..289b4454242a 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -178,7 +178,7 @@ static void butterfly_attach(struct parport *p)
 	struct pardevice	*pd;
 	int			status;
 	struct butterfly	*pp;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct device		*dev = p->physport->dev;
 	struct pardev_cb	butterfly_cb;
 
@@ -189,12 +189,12 @@ static void butterfly_attach(struct parport *p)
 	 * and no way to be selective about what it binds to.
 	 */
 
-	master = spi_alloc_master(dev, sizeof(*pp));
-	if (!master) {
+	host = spi_alloc_host(dev, sizeof(*pp));
+	if (!host) {
 		status = -ENOMEM;
 		goto done;
 	}
-	pp = spi_master_get_devdata(master);
+	pp = spi_controller_get_devdata(host);
 
 	/*
 	 * SPI and bitbang hookup
@@ -202,10 +202,10 @@ static void butterfly_attach(struct parport *p)
 	 * use default setup(), cleanup(), and transfer() methods; and
 	 * only bother implementing mode 0.  Start it later.
 	 */
-	master->bus_num = 42;
-	master->num_chipselect = 2;
+	host->bus_num = 42;
+	host->num_chipselect = 2;
 
-	pp->bitbang.master = master;
+	pp->bitbang.master = host;
 	pp->bitbang.chipselect = butterfly_chipselect;
 	pp->bitbang.txrx_word[SPI_MODE_0] = butterfly_txrx_word_mode0;
 
@@ -280,7 +280,7 @@ static void butterfly_attach(struct parport *p)
 clean1:
 	parport_unregister_device(pd);
 clean0:
-	spi_master_put(pp->bitbang.master);
+	spi_controller_put(host);
 done:
 	pr_debug("%s: butterfly probe, fail %d\n", p->name, status);
 }
@@ -308,7 +308,7 @@ static void butterfly_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	spi_master_put(pp->bitbang.master);
+	spi_controller_put(pp->bitbang.master);
 }
 
 static struct parport_driver butterfly_driver = {
-- 
2.25.1

