Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA64CE61
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfFTNOF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 09:14:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19924 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfFTNOE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 09:14:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KD6pbC021627;
        Thu, 20 Jun 2019 15:13:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=AqEt1HjWRKgGGIYLNysj/iOUGva1/k0fnnA1DQfj/Nc=;
 b=1i2iITqjSzxjPDA0v34j1gyK2boQJeVzaXxp+3wBomDQ3gQiYTCFRnctwfbFI4hR7YO3
 ZabYwttKVrPzJ0COcQfryFixiLRLA7qvHsMT1LROqmgrPg1+QYAc9uEEkIIzSvvIxrXe
 VWA88QCqoUODGiKSlccTHZp8WEyR+Wh8vce4WBxoKn6ANShoXgSFeGGv3MbGlVA1JJ3j
 JuK1mx5iBqhoBEtg8ng2Pf6Z7/2JkcOka3Ncrc9E614228EYHyTJSKjy+ADBxfQK0lu0
 g3r9CUxF74F+pRGz7NyLXjzUI+PLXlAD4TeCNwnV2aVZJInur0W44tAM21BxACrkAEC1 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813hq5j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Jun 2019 15:13:52 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F58B38;
        Thu, 20 Jun 2019 13:13:51 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16B4E27F7;
        Thu, 20 Jun 2019 13:13:51 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun 2019 15:13:50
 +0200
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@st.com>, <christophe.kerello@st.com>
Subject: [PATCH 1/1] spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage
Date:   Thu, 20 Jun 2019 15:13:23 +0200
Message-ID: <20190620131323.5955-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_09:,,
 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

On STM32 F4/F7/H7 SoCs, FTHRES is a 5 bits field in QSPI_CR register,
but for STM32MP1 SoCs, FTHRES is a 4 bits field long. CR_FTHRES_MASK
definition is not correct.

As for all these SoCs, FTHRES field is set to 3, FIELD_PREP() macro
is used with a constant as second parameter which make its usage useless.

CR_FTHRES_MASK and FIELD_PREP() can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 42f8e3c6aa1f..5dbb6a8e893c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -29,7 +29,7 @@
 #define CR_SSHIFT		BIT(4)
 #define CR_DFM			BIT(6)
 #define CR_FSEL			BIT(7)
-#define CR_FTHRES_MASK		GENMASK(12, 8)
+#define CR_FTHRES_SHIFT		8
 #define CR_TEIE			BIT(16)
 #define CR_TCIE			BIT(17)
 #define CR_FTIE			BIT(18)
@@ -463,7 +463,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	qspi->cr_reg = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
+	qspi->cr_reg = 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
-- 
2.17.1

