Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47043972F2
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFAMEs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 08:04:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6116 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhFAMEl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 08:04:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvW1q0hF2zYpP1;
        Tue,  1 Jun 2021 20:00:15 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 20:02:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 20:02:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] spi: spi-mem: fix doc warning in spi-mem.c
Date:   Tue, 1 Jun 2021 20:07:21 +0800
Message-ID: <20210601120721.3198488-1-yangyingliang@huawei.com>
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

Fix the following make W=1 warning:

  drivers/spi/spi-mem.c:819: warning: expecting prototype for spi_mem_driver_unregister_with_owner(). Prototype was for spi_mem_driver_unregister() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1513553e4080..d5f019064dca 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -810,7 +810,7 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *memdrv,
 EXPORT_SYMBOL_GPL(spi_mem_driver_register_with_owner);
 
 /**
- * spi_mem_driver_unregister_with_owner() - Unregister a SPI memory driver
+ * spi_mem_driver_unregister() - Unregister a SPI memory driver
  * @memdrv: the SPI memory driver to unregister
  *
  * Unregisters a SPI memory driver.
-- 
2.25.1

