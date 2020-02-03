Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680051507BA
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 14:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBCNvS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 08:51:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbgBCNvR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 08:51:17 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013Dm0TG027673;
        Mon, 3 Feb 2020 14:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=iQYO7+a/h34kuhzW119oibDsZebUw/DJEcwPucsHISw=;
 b=HLRs4ZEd9Rfv9dMNU1CZUUYioMYzjCoSKRUhnj7jON1zON1/cxEPPJrDDerMGvYq2hO3
 MKTE0IxuitpriIe9un4KIcvKPS0flxksWa0a3rQiT1dr9/qrp44+h9vGAu93yjmbEzJM
 lV9jk8w/0VBNJcWTCy5uQafk87mwUqELUHh1n3PKdWlWdHzG2c9+t0N4V+71a+WVE7IP
 +CZ/XIfptPJ4IvYA586/a9e7vDc5S4kkfXVVVB7Xq/blTmkYc5DTsKFVPDuMhH7yc4UM
 /32K0yE24ZV01IMr9v24UtbEjm3u+HZE8skxlkyhTmxlmZNJWBOdZEChvLdfAbPcwnP/ Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybdsmtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 14:51:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C4CC10002A;
        Mon,  3 Feb 2020 14:51:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DB9A2BC7CF;
        Mon,  3 Feb 2020 14:51:07 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb 2020 14:51:07
 +0100
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@st.com>, <christophe.kerello@st.com>,
        Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH 1/2] spi: stm32-qspi: defer probe for reset controller
Date:   Mon, 3 Feb 2020 14:50:47 +0100
Message-ID: <20200203135048.1299-2-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203135048.1299-1-patrice.chotard@st.com>
References: <20200203135048.1299-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Changes stm32 QSPI driver to defer its probe operation when a reset
controller device have not yet probed but is registered in the
system.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 4ef569b47aa6..13bb64bf4c8f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -615,7 +615,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(rstc)) {
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret == -EPROBE_DEFER)
+			goto err;
+	} else {
 		reset_control_assert(rstc);
 		udelay(2);
 		reset_control_deassert(rstc);
-- 
2.17.1

