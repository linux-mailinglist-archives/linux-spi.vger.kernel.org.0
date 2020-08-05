Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B975923C68A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHEHEa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:04:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728036AbgHEHE3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572QI6030148;
        Wed, 5 Aug 2020 09:04:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=txpQKcJSLN0fnVsFX5CP1pGZZW9Gb+vsfcA5W7IA0mk=;
 b=vf5fMNnKU6ljIs+bqH5kDjrIVpSdpgNlyZXyXjIegU8+yiLEe9GU1JGBoDKEBJEjuxjD
 wRXlWqWfpGWbYornQKlMQ6RUxdEIpq0pHGte6ThptSPoZlZcxkgn6vUIEqpeJvfRaNFl
 gK1MMW04NDHeFxM36VuGxWfBBK4e3TbewlXpVRwn3hR+AH3sqK+slyPElD0hbfIu0NL9
 c+Ax29INsd8PovXDOOrjH7BeGbfWVz6i24FPHbi6W/W6VMT3monYoMcs8Tm9TsOstsiy
 6BOXTON3UwwgAVhFYRg+AgfqJCgcPKqzn8T0GQ78X2cfwzKlJ0lClxDVCOnyNvwCn349 VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6hyq7ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CE9F100038;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6151C2A4D8E;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:14
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 02/18] spi: stm32-spi: defer probe for reset
Date:   Wed, 5 Aug 2020 09:01:57 +0200
Message-ID: <1596610933-32599-3-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Defer the probe operation when a reset controller device is expected
but have not yet been probed.

This change replaces use of devm_reset_control_get_exclusive() with
devm_reset_control_get_optional_exclusive() as reset controller is
optional which is now explicitly stated.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 838d3ce3ebae..eaa416c551c9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1886,8 +1886,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (rst) {
+		if (IS_ERR(rst)) {
+			ret = PTR_ERR(rst);
+			if (ret != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "reset get failed: %d\n",
+					ret);
+			goto err_clk_disable;
+		}
+
 		reset_control_assert(rst);
 		udelay(2);
 		reset_control_deassert(rst);
-- 
2.7.4

