Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8360338A48
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhCLKfu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 05:35:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6564 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233666AbhCLKfk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 05:35:40 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CAR5hm019095;
        Fri, 12 Mar 2021 11:35:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=jeeT0fYtdjbqH8XvYs0z6C68jKHV25fKAFrzPTK3EuE=;
 b=Ls8bwc+rDnh8dHDhMWklEWpPDf+Qlr5p9sbhAZi3tcjVQ3iyRWhG4CExXtJD+qPWK1ih
 femoawGZw7OUiVnzFSscO6Xi7So5k0G+MrgmP5cgDzi0UFUPPAz3LuLkahQwI3iVDDF0
 bhL7uUqUVkWqPwx/JPPfWRmMt2oA4Lg/0PrZTARpmiv4WKXzM9iTns3mo7CM+SfqTwrH
 hlzKHLVay/uuEQLbcv9H+pda4hJeW4h5epLLjDgrQ2h7Csz4fnmbM6w5eKgcUkDoMmhB
 UP3/h73ES9byzjrelsrPR5DRgLGYtMYaNw1RsTUUNrfdu95xXg0SRWcBTWr0epCt3m+8 FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 373yrf58ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 11:35:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55F7E10002A;
        Fri, 12 Mar 2021 11:35:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47DCE234BA5;
        Fri, 12 Mar 2021 11:35:30 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Mar 2021 11:35:29
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH] spi: stm32: avoid ifdef CONFIG_PM for pm callbacks
Date:   Fri, 12 Mar 2021 11:35:29 +0100
Message-ID: <1615545329-5496-1-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_03:2021-03-10,2021-03-12 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Avoid CONFIG_PM preprocessor check for pm suspend/resume
callbacks and identify the functions with __maybe_unused.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 25c076461011..3cc978e477a2 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1976,8 +1976,7 @@ static int stm32_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int stm32_spi_runtime_suspend(struct device *dev)
+static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1987,7 +1986,7 @@ static int stm32_spi_runtime_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int stm32_spi_runtime_resume(struct device *dev)
+static int __maybe_unused stm32_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1999,10 +1998,8 @@ static int stm32_spi_runtime_resume(struct device *dev)
 
 	return clk_prepare_enable(spi->clk);
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int stm32_spi_suspend(struct device *dev)
+static int __maybe_unused stm32_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	int ret;
@@ -2014,7 +2011,7 @@ static int stm32_spi_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int stm32_spi_resume(struct device *dev)
+static int __maybe_unused stm32_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -2044,7 +2041,6 @@ static int stm32_spi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops stm32_spi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_spi_suspend, stm32_spi_resume)
-- 
2.17.1

