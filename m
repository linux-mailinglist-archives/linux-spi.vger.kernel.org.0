Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042CF347183
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhCXGRL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:17:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14517 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhCXGQ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4yc31DmrzPlb4;
        Wed, 24 Mar 2021 14:13:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:16 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 09/11] spi: spi-mem: Fix code indent should use tabs where possible
Date:   Wed, 24 Mar 2021 14:16:40 +0800
Message-ID: <1616566602-13894-10-git-send-email-f.fangjian@huawei.com>
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

Fix checkpatch errors:

  ERROR: code indent should use tabs where possible
  #624: FILE: spi-mem.c:624:
  ERROR: code indent should use tabs where possible
  #626: FILE: spi-mem.c:626:
  ERROR: code indent should use tabs where possible
  #627: FILE: spi-mem.c:627:

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index dc713b0..1513553e 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -621,10 +621,10 @@ EXPORT_SYMBOL_GPL(devm_spi_mem_dirmap_create);
 
 static int devm_spi_mem_dirmap_match(struct device *dev, void *res, void *data)
 {
-        struct spi_mem_dirmap_desc **ptr = res;
+	struct spi_mem_dirmap_desc **ptr = res;
 
-        if (WARN_ON(!ptr || !*ptr))
-                return 0;
+	if (WARN_ON(!ptr || !*ptr))
+		return 0;
 
 	return *ptr == data;
 }
-- 
2.7.4

