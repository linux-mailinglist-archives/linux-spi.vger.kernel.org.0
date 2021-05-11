Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808737A00C
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 08:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhEKGw6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 02:52:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKGw6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 02:52:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfT6Z6j0rz1BKfg;
        Tue, 11 May 2021 14:49:10 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:51:39 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] spi: altera: Remove redundant dev_err call in dfl_spi_altera_probe()
Date:   Tue, 11 May 2021 15:08:42 +0800
Message-ID: <1620716922-108572-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/spi/spi-altera-dfl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 3e32e4f..39a3e1a 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -148,10 +148,8 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 
 	base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
 
-	if (IS_ERR(base)) {
-		dev_err(dev, "%s get mem resource fail!\n", __func__);
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	config_spi_master(base, master);
 	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
-- 
2.6.2

