Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64E72A2D3F
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 15:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKBOqS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 09:46:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7446 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKBOqR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 09:46:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CPwhf2tp2zhbN3;
        Mon,  2 Nov 2020 22:46:10 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 22:46:06 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: img-spfi: fix reference leak in img_spfi_resume
Date:   Mon, 2 Nov 2020 22:56:51 +0800
Message-ID: <20201102145651.3875-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to pm_runtime_put_noidle will result in
reference leak in img_spfi_resume, so we should fix it.

Fixes: deba25800a12b ("spi: Add driver for IMG SPFI controller")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-img-spfi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index b068537375d6..5f05d519fbbd 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -731,8 +731,10 @@ static int img_spfi_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_noidle(dev);
 		return ret;
+	}
 	spfi_reset(spfi);
 	pm_runtime_put(dev);
 
-- 
2.17.1

