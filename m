Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B924C402
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgHTRDz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:03:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18086 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728549AbgHTRDC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:03:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KH2u77148439;
        Thu, 20 Aug 2020 13:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QLypQFjUTvvvtCxKgcqL+KzCyCI4lsRC1pRhw9KMExU=;
 b=rg7IyGpL2Nj3K7NMuINvqNiY68enyP1bnJeHmIXcdGBbrvRNyRSmzjgjeNq9EQdsNpBT
 BEQDyraUVv8rO+hFSdqLhRK1B/aORoya/Aa/DsP9FjlwMaF9P9TUZ0w5ErnoTcHWn4V1
 oVbJKH4EeVhb2x+PSEa4fdPrGRYxZC6DfTkpxJQObEZCMyZfgT/ZCJrvVD8uOBXhKYAt
 KsT9ySpbAVwVsQWAS6IUseezHCQ+S7gx4WpYWoxV00PJsK77OqtRPpSryC/FsN02WWj0
 R/yi7EYapuYOZVREgIi5UoiKZv7WnDymoswmj5yFam2ETWE5WbuBrjGDYXniTM04r6O/ vw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3314mwv9ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:02:55 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KH0m7A005412;
        Thu, 20 Aug 2020 17:02:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3304tkwpyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:33 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2WxD13632254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BAC8AE05C;
        Thu, 20 Aug 2020 17:02:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D49AE05F;
        Thu, 20 Aug 2020 17:02:31 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 2/7] spi: fsi: Fix clock running too fast
Date:   Thu, 20 Aug 2020 12:02:23 -0500
Message-Id: <20200820170228.42053-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820170228.42053-1-eajames@linux.ibm.com>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=1 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200137
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Brad Bishop <bradleyb@fuzziesquirrel.com>

Use a clock divider tuned to a 200MHz FSI clock.  Use of the previous
divider at 200MHz results in corrupt data from endpoint devices. Ideally
the clock divider would be calculated from the FSI clock, but that
would require some significant work on the FSI driver.

Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/spi/spi-fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 8f64af0140e0..559d0ff981f3 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -350,7 +350,7 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 	u64 status = 0ULL;
 	u64 wanted_clock_cfg = SPI_FSI_CLOCK_CFG_ECC_DISABLE |
 		SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
-		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
+		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 19);
 
 	end = jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
 	do {
-- 
2.26.2

