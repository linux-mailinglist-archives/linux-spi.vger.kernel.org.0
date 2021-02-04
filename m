Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C412630F1B3
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhBDLLP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 06:11:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12399 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhBDLLN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Feb 2021 06:11:13 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWbQv2v9xz7gPS;
        Thu,  4 Feb 2021 19:09:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 19:10:19 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <shc_work@mail.ru>,
        <linux-spi@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH] spi: clps711xx: remove redundant white-space
Date:   Thu, 4 Feb 2021 19:08:06 +0800
Message-ID: <1612436886-42839-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Remove redundant white-space, no functional change.

Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-clps711x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 5e900f2..0bef5ce 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -104,7 +104,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	master->use_gpio_descriptors = true;
 	master->bus_num = -1;
 	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(1, 8);
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->prepare_message = spi_clps711x_prepare_message;
 	master->transfer_one = spi_clps711x_transfer_one;
-- 
2.8.1

