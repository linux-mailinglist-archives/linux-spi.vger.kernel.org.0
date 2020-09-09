Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B115263905
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIW3N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 18:29:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17646 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729129AbgIIW3I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 18:29:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089MCs6o022033;
        Wed, 9 Sep 2020 18:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cavpwU+lDo/Lusli5lDuTBdkFJ7dYxcQtjslIDI5oyk=;
 b=lsAGbK/h6awd2q5TdFl1rtAop1ccJz+Z8kF+omv1TfSE0VzHupfQ/9z/uGucOSIajroV
 iCcu+R4nBsSOL+I3pGdvU6U0JaZMNKUIZnY9C71fIlx/G4r/++TnylhGiczM4q0YS9mS
 KRp1WbiWndMPwhd5lEJa53CxWQo8tSBFynJgW2GN/wg5HgTiQX74mqkKTsJJ2ko5TBH+
 TWd/UR9WHXWDFBDM1cz0ZkypR7QQ49EezxDR30bYVfz47DNRYK1cR+vKujWvgZEqy47s
 KTBKR/U0ib4XpH6mOxoL9WT23Vye03lbNhE0CB1iKwNjf+7e3RU9uqGYfykWpMBiGHc+ JQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7n4099y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:29:02 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MS90M015071;
        Wed, 9 Sep 2020 22:29:02 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 33c2a9kd7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:29:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MT01j58065216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:29:00 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C538136060;
        Wed,  9 Sep 2020 22:29:00 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19E22136053;
        Wed,  9 Sep 2020 22:29:00 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.76.239])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:29:00 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, broonie@kernel.org, bradleyb@fuzziesquirrel.com,
        robh+dt@kernel.org, arnd@arndb.de, eajames@linux.ibm.com
Subject: [PATCH v2 3/6] spi: fsi: Fix use of the bneq+ sequencer instruction
Date:   Wed,  9 Sep 2020 17:28:54 -0500
Message-Id: <20200909222857.28653-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909222857.28653-1-eajames@linux.ibm.com>
References: <20200909222857.28653-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=1 bulkscore=0 mlxlogscore=532
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090192
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Brad Bishop <bradleyb@fuzziesquirrel.com>

All of the switches in N2_count_control in the counter configuration are
required to make the branch if not equal and increment command work.
Set them when using bneq+.

A side effect of this mode requires a dummy write to TDR when both
transmitting and receiving otherwise the controller won't start shifting
receive data.

It is likely not possible to avoid TDR underrun errors in this mode and
they are harmless, so do not check for them.

Fixes: bbb6b2f9865b ("spi: Add FSI-attached SPI controller driver")
Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/spi/spi-fsi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 559d0ff981f3..c31a852b6a3e 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -29,6 +29,10 @@
 #define SPI_FSI_ERROR			0x0
 #define SPI_FSI_COUNTER_CFG		0x1
 #define  SPI_FSI_COUNTER_CFG_LOOPS(x)	 (((u64)(x) & 0xffULL) << 32)
+#define  SPI_FSI_COUNTER_CFG_N2_RX	 BIT_ULL(8)
+#define  SPI_FSI_COUNTER_CFG_N2_TX	 BIT_ULL(9)
+#define  SPI_FSI_COUNTER_CFG_N2_IMPLICIT BIT_ULL(10)
+#define  SPI_FSI_COUNTER_CFG_N2_RELOAD	 BIT_ULL(11)
 #define SPI_FSI_CFG1			0x2
 #define SPI_FSI_CLOCK_CFG		0x3
 #define  SPI_FSI_CLOCK_CFG_MM_ENABLE	 BIT_ULL(32)
@@ -61,7 +65,7 @@
 #define  SPI_FSI_STATUS_RDR_OVERRUN	 BIT_ULL(62)
 #define  SPI_FSI_STATUS_RDR_FULL	 BIT_ULL(63)
 #define  SPI_FSI_STATUS_ANY_ERROR	 \
-	(SPI_FSI_STATUS_ERROR | SPI_FSI_STATUS_TDR_UNDERRUN | \
+	(SPI_FSI_STATUS_ERROR | \
 	 SPI_FSI_STATUS_TDR_OVERRUN | SPI_FSI_STATUS_RDR_UNDERRUN | \
 	 SPI_FSI_STATUS_RDR_OVERRUN)
 #define SPI_FSI_PORT_CTRL		0x9
@@ -238,6 +242,7 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 	int rc;
 	u8 len = min(transfer->len, 8U);
 	u8 rem = transfer->len % len;
+	u64 cfg = 0ULL;
 
 	loops = transfer->len / len;
 
@@ -258,8 +263,14 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 	if (loops > 1) {
 		fsi_spi_sequence_add(seq, SPI_FSI_SEQUENCE_BRANCH(idx));
 
-		rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG,
-				       SPI_FSI_COUNTER_CFG_LOOPS(loops - 1));
+		cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
+		if (transfer->rx_buf)
+			cfg |= SPI_FSI_COUNTER_CFG_N2_RX |
+				SPI_FSI_COUNTER_CFG_N2_TX |
+				SPI_FSI_COUNTER_CFG_N2_IMPLICIT |
+				SPI_FSI_COUNTER_CFG_N2_RELOAD;
+
+		rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG, cfg);
 		if (rc)
 			return rc;
 	}
@@ -275,6 +286,7 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 {
 	int rc = 0;
 	u64 status = 0ULL;
+	u64 cfg = 0ULL;
 
 	if (transfer->tx_buf) {
 		int nb;
@@ -312,6 +324,16 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 		u64 in = 0ULL;
 		u8 *rx = transfer->rx_buf;
 
+		rc = fsi_spi_read_reg(ctx, SPI_FSI_COUNTER_CFG, &cfg);
+		if (rc)
+			return rc;
+
+		if (cfg & SPI_FSI_COUNTER_CFG_N2_IMPLICIT) {
+			rc = fsi_spi_write_reg(ctx, SPI_FSI_DATA_TX, 0);
+			if (rc)
+				return rc;
+		}
+
 		while (transfer->len > recv) {
 			do {
 				rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS,
-- 
2.26.2

