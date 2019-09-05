Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A301DA9BBB
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 09:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfIEH0H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 03:26:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730716AbfIEH0H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 03:26:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 791E84E5E855BABD024E;
        Thu,  5 Sep 2019 15:26:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 15:25:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] spi: npcm-fiu: remove set but not used variable 'retlen'
Date:   Thu, 5 Sep 2019 15:24:36 +0800
Message-ID: <20190905072436.23932-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

drivers/spi/spi-npcm-fiu.c: In function npcm_fiu_read:
drivers/spi/spi-npcm-fiu.c:472:9: warning:
 variable retlen set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-npcm-fiu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index d9e2f58..cb52fd8 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -469,7 +469,6 @@ static int npcm_fiu_read(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	u8 *data = op->data.buf.in;
 	int i, readlen, currlen;
-	size_t retlen = 0;
 	u8 *buf_ptr;
 	u32 addr;
 	int ret;
@@ -494,8 +493,6 @@ static int npcm_fiu_read(struct spi_mem *mem, const struct spi_mem_op *op)
 		currlen -= 16;
 	} while (currlen > 0);
 
-	retlen = i;
-
 	return 0;
 }
 
-- 
2.7.4


