Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8C347185
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhCXGRK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:17:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14516 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhCXGQ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4yc31bPfzPlfp;
        Wed, 24 Mar 2021 14:13:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:17 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 11/11] spi: pl022: Fix trailing whitespace
Date:   Wed, 24 Mar 2021 14:16:42 +0800
Message-ID: <1616566602-13894-12-git-send-email-f.fangjian@huawei.com>
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

  ERROR: trailing whitespace
  #1198: FILE: spi-pl022.c:1198:

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index fd74ddf..d7ed188 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1195,7 +1195,7 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 err_no_rxchan:
 	return err;
 }
-		
+
 static void terminate_dma(struct pl022 *pl022)
 {
 	struct dma_chan *rxchan = pl022->dma_rx_channel;
-- 
2.7.4

