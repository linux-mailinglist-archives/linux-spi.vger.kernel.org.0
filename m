Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78AE2C006B
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 08:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKWHCi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 02:02:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7965 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgKWHCh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Nov 2020 02:02:37 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CfdPn3tPkzhgHy;
        Mon, 23 Nov 2020 15:02:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Nov 2020 15:02:32 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <fancer.lancer@gmail.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: fixed missing resource_size
Date:   Mon, 23 Nov 2020 15:02:55 +0800
Message-ID: <1606114975-31362-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

fixed the coccicheck:
drivers/spi/spi-dw-bt1.c:220:27-30: ERROR: Missing
resource_size with mem.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/spi/spi-dw-bt1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index f382dfad..da4f4d8 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -217,7 +217,7 @@ static int dw_spi_bt1_sys_init(struct platform_device *pdev,
 	if (mem) {
 		dwsbt1->map = devm_ioremap_resource(&pdev->dev, mem);
 		if (!IS_ERR(dwsbt1->map)) {
-			dwsbt1->map_len = (mem->end - mem->start + 1);
+			dwsbt1->map_len = resource_size(mem);
 			dws->mem_ops.dirmap_create = dw_spi_bt1_dirmap_create;
 			dws->mem_ops.dirmap_read = dw_spi_bt1_dirmap_read;
 		} else {
-- 
2.7.4

