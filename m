Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A935DCD0
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhDMKvP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 06:51:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhDMKvN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Apr 2021 06:51:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAj1fY015775;
        Tue, 13 Apr 2021 10:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rEmqSMLQlKdr8i/yVs/kmYn6MYPqJZf1Db+LrridPCE=;
 b=gvFdZErDowU8+SmscltPnxhcCtAJxaZJzOTs9SWt1mVHSqQ3LZeBB3j296QTL1FKMxuy
 iZ8Tga/vs0dgCNgMfsfkz5qpExvZsFUeUcFUfXkbREQOxY+9i7S4tHr1cbldS4pXFewM
 etfkKm9eS0369kRvYnUKkfJDkL5zwSGzYizG2f4QFKTfroSaIMe6H/fA7HadtY30g+bT
 ErfsAH2Z9U6WyU5/9RQ5WodAIwDW9PjjcqyKEBjuqxeHDvMUY3lTu1PgX95txNphxtHM
 TD811ogiUVCWKtJT7LSUegvqpLmSWwKxD3Ww3U77quEPfekup6og77yWDserVLRphtN+ ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymek9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:50:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAoS7B089128;
        Tue, 13 Apr 2021 10:50:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37unkpbxf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:50:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DAoose006521;
        Tue, 13 Apr 2021 10:50:50 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 03:50:49 -0700
Date:   Tue, 13 Apr 2021 13:50:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Quanyang Wang <quanyang.wang@windriver.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: spi-zynqmp-gqspi: unlock on error path in exec_op
Message-ID: <YHV3gkc3RFcBZVAK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130075
X-Proofpoint-GUID: T-I6Rs3m37aj8ccDMRKzIdArUNFrpxvY
X-Proofpoint-ORIG-GUID: T-I6Rs3m37aj8ccDMRKzIdArUNFrpxvY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130074
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the allocation fails then we need to drop the &xqspi->op_lock mutex
before returning.

Fixes: a0f65be6e880 ("spi: spi-zynqmp-gqspi: add mutex locking for exec_op")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9494da9aea40..d08ca6d5670c 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -965,8 +965,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 
 	if (op->cmd.opcode) {
 		tmpbuf = kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
-		if (!tmpbuf)
-			return -ENOMEM;
+		if (!tmpbuf) {
+			err = -ENOMEM;
+			goto return_err;
+		}
 		tmpbuf[0] = op->cmd.opcode;
 		reinit_completion(&xqspi->data_completion);
 		xqspi->txbuf = tmpbuf;
-- 
2.30.2

