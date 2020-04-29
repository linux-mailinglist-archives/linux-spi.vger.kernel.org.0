Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6D1BD990
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD2K04 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 06:26:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37054 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbgD2K0v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Apr 2020 06:26:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TAIPhm031773;
        Wed, 29 Apr 2020 12:26:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=KfrwcIEAAxzZTZPX1fo//g25aXA6YdvAOUL28w3PuTE=;
 b=Lay7I5hExdMtnFVTkpr+NIhd2XgmCPQPOzT27AEFV99+bVAqiBZeiUB2Joj3M3RjD/xs
 Jy5QZWjLgUavyRTcgyeWCs8MLApjdeKbDWfpXV8/GRXeGKgWEB+LKgl4K9ssk3PfEWe5
 Di141+m41OY8nri1Hk0XZSVbHYbIT9tKBehSUNqbwLXyrDpNFOHem4N7nngpN4GxCsWO
 obcIPKI6Q3XfDkYvGbRslEO6zM8XRrO8X6KyyWJf+BPcVRT1NI/fEJF6LJiYpkbeOFLc
 fLgsmYw/hPbaoTnJYxjzIIlZK67iaFk1i4ui3Ze39c4Qt4Nz1/6fZXMgFteDXo2PrNu6 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjwwrfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 12:26:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3BA0100034;
        Wed, 29 Apr 2020 12:26:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A44F820C7A6;
        Wed, 29 Apr 2020 12:26:28 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr 2020 12:26:28
 +0200
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: spi: stm32-qspi: Fix unbalanced pm_runtime_enable issue
Date:   Wed, 29 Apr 2020 12:26:25 +0200
Message-ID: <20200429102625.25974-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_03:2020-04-29,2020-04-29 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Issue detected by unbinding/binding the stm32 qspi driver as following:

root@stm32mp2:~# echo 40430000.spi > /sys/bus/platform/drivers/stm32-qspi/404300
00.spi/driver/unbind
root@stm32mp2:~# echo 40430000.spi > /sys/bus/platform/drivers/stm32-qspi/bind
[  969.864021] stm32-qspi 40430000.spi: Unbalanced pm_runtime_enable!
[  970.225161] spi-nor spi0.0: mx66u51235f (65536 Kbytes)
[  970.935721] spi-nor spi0.1: mx66u51235f (65536 Kbytes)

Fixes: 9d282c17b023 ("spi: stm32-qspi: Add pm_runtime support")

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 2f2ea2c42d6e..3c44bb2fd9b1 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -555,10 +555,15 @@ static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
 
 static void stm32_qspi_release(struct stm32_qspi *qspi)
 {
+	pm_runtime_get_sync(qspi->dev);
 	/* disable qspi */
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	stm32_qspi_dma_free(qspi);
 	mutex_destroy(&qspi->lock);
+	pm_runtime_put_noidle(qspi->dev);
+	pm_runtime_disable(qspi->dev);
+	pm_runtime_set_suspended(qspi->dev);
+	pm_runtime_dont_use_autosuspend(qspi->dev);
 	clk_disable_unprepare(qspi->clk);
 }
 
-- 
2.17.1

