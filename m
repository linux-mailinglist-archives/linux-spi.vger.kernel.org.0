Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2A3E5D48
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhHJOS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 10:18:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8002 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbhHJOQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Aug 2021 10:16:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GkZkT2X8PzYly6;
        Tue, 10 Aug 2021 22:16:17 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 22:16:31 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 22:16:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <ldewangan@nvidia.com>, <broonie@kernel.org>
Subject: [PATCH -next] spi: tegra20-slink: remove spi_master_put() in tegra_slink_remove()
Date:   Tue, 10 Aug 2021 22:22:30 +0800
Message-ID: <20210810142230.2220453-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_master_put() is already called in spi_unregister_master(), or it
will lead a double decrement refcount.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-tegra20-slink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index deff16ba6d58..ebd27f883033 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1154,8 +1154,6 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
 
-	spi_master_put(master);
-
 	return 0;
 }
 
-- 
2.25.1

