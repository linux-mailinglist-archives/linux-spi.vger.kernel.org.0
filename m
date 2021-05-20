Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0338AFD4
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhETNX2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 09:23:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4772 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhETNX1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 May 2021 09:23:27 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm9Kj4pFVzqV8L;
        Thu, 20 May 2021 21:18:33 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:22:04 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 21:22:04 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] spi: Use pm_runtime_resume_and_get() to replace open coding
Date:   Thu, 20 May 2021 21:22:01 +0800
Message-ID: <1621516921-52438-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. boilerplate reduction and easier to understand
flow as the new function has no side effects if it returns an error. it
also avoids the problem of positive return values so we can change
if (status < 0) to if (status).

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/spi/spi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57120de..7d25010 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1486,9 +1486,8 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	mutex_lock(&ctlr->io_mutex);
 
 	if (!was_busy && ctlr->auto_runtime_pm) {
-		ret = pm_runtime_get_sync(ctlr->dev.parent);
-		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
+		ret = pm_runtime_resume_and_get(ctlr->dev.parent);
+		if (ret) {
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			mutex_unlock(&ctlr->io_mutex);
@@ -3426,10 +3425,9 @@ int spi_setup(struct spi_device *spi)
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
-		status = pm_runtime_get_sync(spi->controller->dev.parent);
-		if (status < 0) {
+		status = pm_runtime_resume_and_get(spi->controller->dev.parent);
+		if (status) {
 			mutex_unlock(&spi->controller->io_mutex);
-			pm_runtime_put_noidle(spi->controller->dev.parent);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
 			return status;
@@ -3491,10 +3489,9 @@ int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 		mutex_lock(&spi->controller->io_mutex);
 
 		if (spi->controller->auto_runtime_pm) {
-			status = pm_runtime_get_sync(parent);
-			if (status < 0) {
+			status = pm_runtime_resume_and_get(parent);
+			if (status) {
 				mutex_unlock(&spi->controller->io_mutex);
-				pm_runtime_put_noidle(parent);
 				dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 					status);
 				return status;
-- 
2.7.4

