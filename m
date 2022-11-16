Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098B62B621
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 10:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKPJNw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 04:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiKPJNv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 04:13:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC942DDC
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 01:13:49 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBy263l6gzJnY5;
        Wed, 16 Nov 2022 17:10:38 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:13:47 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:13:46 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <fancer.lancer@gmail.com>, <broonie@kernel.org>,
        <feng.tang@intel.com>, <linus.walleij@stericsson.com>
CC:     <linux-spi@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()
Date:   Wed, 16 Nov 2022 17:32:04 +0800
Message-ID: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev. Since 'dma_dev' is only used to filter the channel in
dw_spi_dma_chan_filer(). After using it, we need to use pci_dev_put() to
decrease the reference count. Also add pci_dev_put() for the error case.

Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/spi/spi-dw-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 1322b8cce5b7..ababb910b391 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -128,12 +128,15 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_sg_burst_init(dws);
 
+	pci_dev_put(dma_dev);
+
 	return 0;
 
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
 err_exit:
+	pci_dev_put(dma_dev);
 	return -EBUSY;
 }
 
-- 
2.20.1

