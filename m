Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B60267884
	for <lists+linux-spi@lfdr.de>; Sat, 12 Sep 2020 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgILHXH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 03:23:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbgILHXF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 12 Sep 2020 03:23:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58747D021E3E6450AA49;
        Sat, 12 Sep 2020 15:23:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 15:22:55 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <nsaenzjulienne@suse.de>, <linux-spi@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] spi: bcm2835: Make polling_limit_us static
Date:   Sat, 12 Sep 2020 15:22:11 +0800
Message-ID: <20200912072211.602735-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This eliminates the following sparse warning:

drivers/spi/spi-bcm2835.c:78:14: warning: symbol 'polling_limit_us' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 5519f1eda238..b87116e9b413 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -75,7 +75,7 @@
 #define DRV_NAME	"spi-bcm2835"
 
 /* define polling limits */
-unsigned int polling_limit_us = 30;
+static unsigned int polling_limit_us = 30;
 module_param(polling_limit_us, uint, 0664);
 MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");
-- 
2.25.4

