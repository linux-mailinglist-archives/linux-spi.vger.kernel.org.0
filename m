Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B642386F6B
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbhERBlB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 21:41:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345939AbhERBk7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 21:40:59 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkdrC4FwPzQnlB;
        Tue, 18 May 2021 09:36:11 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:39 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhiqi Song <songzhiqi1@huawei.com>,
        "Kaiwan N Billimoria" <kaiwan@designergraphix.com>
Subject: [PATCH 1/7] spi: lm70llp: add parenthesis for sizeof
Date:   Tue, 18 May 2021 09:38:16 +0800
Message-ID: <1621301902-64158-2-git-send-email-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
References: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix missing parenthesis of sizeof reported by checkpatch.pl:
 WARNING: sizeof *pp should be sizeof(*pp).

The kernel coding style suggests thinking of sizeof as a function
and add parenthesis.

Cc: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/spi/spi-lm70llp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index f914b8d..ead0507 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -202,7 +202,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * the lm70 driver could verify it, reading the manf ID.
 	 */
 
-	master = spi_alloc_master(p->physport->dev, sizeof *pp);
+	master = spi_alloc_master(p->physport->dev, sizeof(*pp));
 	if (!master) {
 		status = -ENOMEM;
 		goto out_fail;
-- 
2.7.4

