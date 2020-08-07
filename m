Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18A23EE13
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHGNXt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:23:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9036 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726015AbgHGNXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 09:23:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077DMlKn021979;
        Fri, 7 Aug 2020 15:23:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=mE1wqTxELRNPQTfYyhL4N0dM8TmqK0GssCG2esZg2As=;
 b=nOkBad9EIPgQ072yeVaO8IE2Wx2kICo9Cehm76ZFBoGpGUVRUaZ2dADQBGevJicdTfqk
 oVyipLx7VA/XyNbo4DnRkKVzwu+MJaJbIKdyKRPTt+JP3qPE/CEzkLXI/NBiNevfj44F
 nD/HFTSfjF0DorqfaBkd6LYxsa4kCgB9/6Sv+vYhU3x1HDUnJZQXu3PD+PZZqmdtoLf4
 Q+jWqvkSCpD1JcQ6onobClffx1NiDRuX5hJPHXXcLbTh8unp3cqUYEK9HKohZgVfzzlA
 XgPYJ5qHHS7h9mJ/ZAzyNoXtuF9D3qpRP1ZAVErA4M1oAPrnis+gUb8Nj22kUq7foudM 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6j02e9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:23:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63932100038;
        Fri,  7 Aug 2020 15:23:31 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 592BC2B8A02;
        Fri,  7 Aug 2020 15:23:31 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug 2020 15:23:31
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 4/5] spi: stm32: fixes suspend/resume management
Date:   Fri, 7 Aug 2020 15:21:24 +0200
Message-ID: <1596806485-3810-5-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
References: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

This patch adds pinctrl power management, and reconfigure spi controller
in case of resume.

Fixes: 038ac869c9d2 ("spi: stm32: add runtime PM support")

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index bdd4e70c3f10..e196dbc5c432 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -13,6 +13,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
@@ -2004,6 +2005,8 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
+	pinctrl_pm_select_sleep_state(&pdev->dev);
+
 	return 0;
 }
 
@@ -2015,13 +2018,18 @@ static int stm32_spi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(spi->clk);
 
-	return 0;
+	return pinctrl_pm_select_sleep_state(dev);
 }
 
 static int stm32_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
 
 	return clk_prepare_enable(spi->clk);
 }
@@ -2051,10 +2059,23 @@ static int stm32_spi_resume(struct device *dev)
 		return ret;
 
 	ret = spi_master_resume(master);
-	if (ret)
+	if (ret) {
 		clk_disable_unprepare(spi->clk);
+		return ret;
+	}
 
-	return ret;
+	ret = pm_runtime_get_sync(dev);
+	if (ret) {
+		dev_err(dev, "Unable to power device:%d\n", ret);
+		return ret;
+	}
+
+	spi->cfg->config(spi);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 #endif
 
-- 
2.7.4

