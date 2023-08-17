Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463677F018
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbjHQFH7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348080AbjHQFHf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B6269E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:34 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRCZz25CjztSBJ;
        Thu, 17 Aug 2023 13:03:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 15/23] spi: rzv2m-csi: switch to use devm_spi_alloc_host()
Date:   Thu, 17 Aug 2023 13:03:24 +0800
Message-ID: <20230817050332.1274751-16-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use modern name function devm_spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-rzv2m-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index d098aefa370d..d0f51b17aa7c 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -555,7 +555,7 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	controller = devm_spi_alloc_master(dev, sizeof(*csi));
+	controller = devm_spi_alloc_host(dev, sizeof(*csi));
 	if (!controller)
 		return -ENOMEM;
 
-- 
2.25.1

