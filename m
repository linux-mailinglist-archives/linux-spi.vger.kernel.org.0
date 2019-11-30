Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9048910DC15
	for <lists+linux-spi@lfdr.de>; Sat, 30 Nov 2019 02:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3BuP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Nov 2019 20:50:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfK3BuP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 Nov 2019 20:50:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 756CDFABC129D1FBD040;
        Sat, 30 Nov 2019 09:50:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:50:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <broonie@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] gpiolib: of: Make of_gpio_spi_cs_get_count static
Date:   Sat, 30 Nov 2019 09:28:28 +0800
Message-ID: <20191130012828.14504-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
References: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix sparse warning:

drivers/gpio/gpiolib-of.c:35:5: warning:
 symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: This is caused by commit 71b8f600b034 ("gpio: Handle counting of Freescale chipselects"),
	should be applied to spi tree.
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 610c6622f62d..b696e4598a24 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -32,7 +32,7 @@
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 {
 	struct device_node *np = dev->of_node;
 
-- 
2.20.1


