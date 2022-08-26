Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57C5A240D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Aug 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbiHZJTX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Aug 2022 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiHZJTW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Aug 2022 05:19:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC5D741B;
        Fri, 26 Aug 2022 02:19:21 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q8XnIa002217;
        Fri, 26 Aug 2022 11:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=9gvdPpfWhML/QsrMl+pD+HweNQ2GBnbJdkoZ5Iv84OE=;
 b=IlHC48Br61AxoVupam3KG+mMws0m+4cuyJJuqO6jZaumyW1J63/3QX/ztiGEinlX3D5x
 eqzvb0PwBgphdSI/lmaQYfzOKFzd04VDFCKqf5Tv4pXwCj/UtpH+2GUA7ay9THduvBJ/
 uZlOWjd4Esx1e35VPX+35kk91pBFSJ2OPxopUQsnIzkQb6lf/ZCsWpIFFxbTqaz/HUuA
 Ez7VeImJ8GRGI84bmjnq/kf3sxAgLfHQfnFfZAtIfhLs/07It/WmOXm5MpTl0gzfOjES
 uLCrk09mcekEk2IwvEeHFe+P3cLt7WBbcWeQQFO7OCjboWGPY9mVNWCtfDj9jli5L5uR pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j5h4wn6g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:19:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 172CE10002A;
        Fri, 26 Aug 2022 11:19:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90099217B72;
        Fri, 26 Aug 2022 11:19:03 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 26 Aug
 2022 11:19:03 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
Date:   Fri, 26 Aug 2022 11:18:51 +0200
Message-ID: <20220826091851.1393266-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

The patch a557fca630cc: "spi: stm32_qspi: Add transfer_one_message()
spi callback" from Aug 23, 2022, leads to the following Smatch static
checker warning:

drivers/spi/spi-stm32-qspi.c:627 stm32_qspi_transfer_one_message()
error: uninitialized symbol 'ret'.Fix the following Smatch static checker warning:

Fixes: a557fca630cc ("spi: stm32_qspi: Add transfer_one_message() spi callback")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 92459daca95f..679fd1c34f7e 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -562,7 +562,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 	struct spi_transfer *transfer;
 	struct spi_device *spi = msg->spi;
 	struct spi_mem_op op;
-	int ret;
+	int ret = 0;
 
 	if (!spi->cs_gpiod)
 		return -EOPNOTSUPP;
@@ -592,8 +592,10 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 			dummy_bytes = transfer->len;
 
 			/* if happens, means that message is not correctly built */
-			if (list_is_last(&transfer->transfer_list, &msg->transfers))
+			if (list_is_last(&transfer->transfer_list, &msg->transfers)) {
+				ret = -EINVAL;
 				goto end_of_transfer;
+			}
 
 			transfer = list_next_entry(transfer, transfer_list);
 		}
-- 
2.25.1

