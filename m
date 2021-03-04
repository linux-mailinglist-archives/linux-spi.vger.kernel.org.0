Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D689532D118
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 11:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCDKsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 05:48:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13057 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhCDKsD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 05:48:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DrnZH3hq3zMhf8;
        Thu,  4 Mar 2021 18:45:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 18:47:11 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <dan.carpenter@oracle.com>,
        <huangdaode@huawei.com>
Subject: [PATCH] spi: cadence-quadspi: Silence shiftTooManyBitsSigned warning
Date:   Thu, 4 Mar 2021 18:47:52 +0800
Message-ID: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

drivers/spi/spi-cadence-quadspi.c:267:18: warning: Shifting signed 32-bit
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
                    ^

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 442cc7c..9a2798a5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -264,7 +264,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
 {
 	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
 
-	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
+	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
 }
 
 static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
-- 
2.7.4

