Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844A953B59F
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jun 2022 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiFBI7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jun 2022 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiFBI7g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jun 2022 04:59:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9761FE391;
        Thu,  2 Jun 2022 01:59:35 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2528Q8qb013105;
        Thu, 2 Jun 2022 10:59:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=MXrgzl/V2YRiK3xTeuYKtDlVPXp3ezbyqB7OhN2g5iU=;
 b=wLK/B92XOCyFo41zmwpZ5UtgxdajKrIDCC1zT8csBSe/acwE3LdCgxtSk16adcs5I6oa
 Zx40ryNCH6a4ssR14HLuwi+5Fa5kE3smlDzOcFmJTXxGUOfNHt7vpPJ6oyzyKYzcxYpk
 FuRc6URDUnEbaFTQmw4rywNE1+eQosu9OSOq9LIYgEe2A8DN0GElpv50tB//+anUiLz2
 AV+KTIBeE2iyUhxKoMr2TfTzLEnzswd9aCMf9Dfq3j/aF00GFZISQeHNtcyiYHh7JxQC
 ynOVmaWJW3U9LApT54+NSZu/Pc+KGge9n5xXGLjmWJf8QPwcy4Kcrw02O/hSB7MDFCsm Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gespq077t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:59:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0F0E100034;
        Thu,  2 Jun 2022 10:59:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CAF16216EF5;
        Thu,  2 Jun 2022 10:59:27 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 10:59:27 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 2/2] spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
Date:   Thu, 2 Jun 2022 10:59:18 +0200
Message-ID: <20220602085918.350613-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602085918.350613-1-patrice.chotard@foss.st.com>
References: <20220602085918.350613-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

struct spi_mem_op *op parameter is no more used, remove it.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 2ad43c2f0526..e5068e694ca5 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -299,8 +299,7 @@ static int stm32_qspi_wait_nobusy(struct stm32_qspi *qspi)
 						 STM32_BUSY_TIMEOUT_US);
 }
 
-static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
-			       const struct spi_mem_op *op)
+static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
 {
 	u32 cr, sr;
 	int err = 0;
@@ -420,7 +419,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 		goto abort;
 
 	/* wait end of tx in indirect mode */
-	err = stm32_qspi_wait_cmd(qspi, op);
+	err = stm32_qspi_wait_cmd(qspi);
 	if (err)
 		goto abort;
 
-- 
2.25.1

