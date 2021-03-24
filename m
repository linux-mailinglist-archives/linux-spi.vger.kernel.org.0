Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33E347179
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCXGQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:16:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14443 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhCXGQX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd035WQzkf3N;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:14 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 02/11] spi: sprd: Fix checkpatch spacing error
Date:   Wed, 24 Mar 2021 14:16:33 +0800
Message-ID: <1616566602-13894-3-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix checkpatch error:

  ERROR: space prohibited before that close parenthesis ')'
  #213: FILE: spi-sprd-adi.c:213:
  +	rd_addr = (val & RD_ADDR_MASK ) >> RD_ADDR_SHIFT;

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 392ec5c..ab19068 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -210,7 +210,7 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	 * address. Then we can check the returned register address to validate
 	 * data.
 	 */
-	rd_addr = (val & RD_ADDR_MASK ) >> RD_ADDR_SHIFT;
+	rd_addr = (val & RD_ADDR_MASK) >> RD_ADDR_SHIFT;
 
 	if (rd_addr != (reg_paddr & REG_ADDR_LOW_MASK)) {
 		dev_err(sadi->dev, "read error, reg addr = 0x%x, val = 0x%x\n",
-- 
2.7.4

