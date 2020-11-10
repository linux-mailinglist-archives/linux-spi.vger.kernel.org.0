Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B142AE1FF
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 22:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJVrn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 16:47:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJVrn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Nov 2020 16:47:43 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AALjdG8054992;
        Tue, 10 Nov 2020 16:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fWNuh/RWn7nJYNmvvejOiDVQ5IzNrZ3RaYxmZNKCRjY=;
 b=MYqvAYtuWXtzOxRB58nKUhoVQqi/uUGWfxgFwSt5gzXpqMe0xyGoqm7Qdrn7S9ddQ3el
 vbvP0+gxp4dckvUtlP0ao3EuTSi4GTA3vw+NiMYJDc8PxvsUcgjItJR+LFhlCBP00ExO
 MXLQna9IwHzjPrdOS0RqjmaG5I22SNMOsUw9+Qz6IUfqCDoLq5PKRby+QoHirQR9opnU
 2UMkZSkDsBWSsx91Y5XkS2WJarpAuDTv9lKX0AXXFluTM9OwJR/SdcGn+hNQzaBNTCS0
 vC+QcxXwfQcqlxhp0/eTNwoj1vwk1jG+EeRmnkzVFyKBMSys7wv8d+XhZnHfgDECBUhS 8A== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qpjs75gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 16:47:40 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AALg3Pq024551;
        Tue, 10 Nov 2020 21:47:39 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 34q5nen3ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 21:47:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AALlWjN11010812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 21:47:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44AF76A047;
        Tue, 10 Nov 2020 21:47:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DAF36A04D;
        Tue, 10 Nov 2020 21:47:37 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.65.201.129])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 21:47:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, broonie@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH] spi: fsi: Fix transfer returning without finalizing message
Date:   Tue, 10 Nov 2020 15:47:36 -0600
Message-Id: <20201110214736.25718-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_08:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=826 bulkscore=0 suspectscore=1
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100143
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the case that the SPI mux isn't set, the transfer_one_message
function returns without finalizing the message. This means that
the transfer never completes, resulting in hung tasks and an
eventual kernel panic. Fix it by finalizing the transfer in this
case.

Fixes: 9211a441e606 ("spi: fsi: Check mux status before transfers")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 8a440c7078ef..3920cd3286d8 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -477,7 +477,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 	rc = fsi_spi_check_mux(ctx->fsi, ctx->dev);
 	if (rc)
-		return rc;
+		goto error;
 
 	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
 		struct fsi_spi_sequence seq;
-- 
2.26.2

