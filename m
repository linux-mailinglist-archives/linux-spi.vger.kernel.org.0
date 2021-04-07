Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384EA356169
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 04:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348102AbhDGCa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Apr 2021 22:30:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15144 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhDGCa4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Apr 2021 22:30:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFSwv683tzpVg0;
        Wed,  7 Apr 2021 10:27:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 10:30:37 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <sfr@canb.auug.org.au>, <huangdaode@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH-next] spi: hisi-kunpeng: Fix Woverflow warning on conversion
Date:   Wed, 7 Apr 2021 10:31:00 +0800
Message-ID: <1617762660-54681-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix warning Woverflow on type conversion reported on x86_64:

  drivers/spi/spi-hisi-kunpeng.c:361:9: warning: conversion from 'long unsigned int' to 'u32'
  {aka 'unsigned int'} changes value from '18446744073709551600' to '4294967280' [-Woverflow]

The registers are 32 bit, so fix by casting to u32.

Fixes: c770d8631e18 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index abc0cd5..3f986ba 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -358,7 +358,7 @@ static int hisi_spi_transfer_one(struct spi_controller *master,
 	smp_mb();
 
 	/* Enable all interrupts and the controller */
-	writel(~IMR_MASK, hs->regs + HISI_SPI_IMR);
+	writel(~(u32)IMR_MASK, hs->regs + HISI_SPI_IMR);
 	writel(1, hs->regs + HISI_SPI_ENR);
 
 	return 1;
-- 
2.7.4

