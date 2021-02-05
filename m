Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264E43110A7
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBERU6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 12:20:58 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbhBERSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 12:18:30 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115IqUdl022920;
        Fri, 5 Feb 2021 19:59:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=OkZFHNYnhjbbf1kCBZcnGUNg3u7g/BZ3dQTwhvXRqmc=;
 b=Qgkt1pVGd7fexyKuFYD4rt9iRqsFwG2LjQdNECroZViX/7lT373U09DZpctfOcV/3OFC
 uWzsln7zHeGtAWl77dT6BWFG3UvqWrOnf6/aWT8hs0q1Ln+vAu36IHP+5FeRcH314RhD
 hVhsqtLJbrXIuTD/HxOD+R+J6PI2CZoQax/xLNXkax9rg65rEpO4K/fpqiu1fR9Ajpl/
 spBpe+5lqPaVD3Elu/jUV+YZEHBnA5j2LUtHd8gG8aZ6iITJJ3+yglY3hgbQwhlbpArA
 js4hgnh/Gk6iP7DMmvIB2oe0IrHSlR/T6H/9AAKVgJi5ZkJSBM0onKlKx03KsHuJVLyo aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fsgjqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 19:59:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B429D10002A;
        Fri,  5 Feb 2021 19:59:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A79652C38D3;
        Fri,  5 Feb 2021 19:59:47 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 19:59:47
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 6/8] spi: stm32: defer probe for reset
Date:   Fri, 5 Feb 2021 19:59:30 +0100
Message-ID: <1612551572-495-7-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
References: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Defer the probe operation when a reset controller device is expected
but have not yet been probed.

This change replaces use of devm_reset_control_get_exclusive() with
devm_reset_control_get_optional_exclusive() as reset controller is
optional which is now explicitly stated.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
v2: reordered within the serie

 drivers/spi/spi-stm32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 561234829110..54196cecfe2e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1871,8 +1871,14 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (rst) {
+		if (IS_ERR(rst)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(rst),
+					    "failed to get reset\n");
+			goto err_clk_disable;
+		}
+
 		reset_control_assert(rst);
 		udelay(2);
 		reset_control_deassert(rst);
-- 
2.17.1

