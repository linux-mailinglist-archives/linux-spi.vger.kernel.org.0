Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D532638FE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIIW3P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 18:29:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbgIIW3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 18:29:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089M3DDD183868;
        Wed, 9 Sep 2020 18:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=idlvgwGq0L5gVIChTX8J5i+iGSAiTqdOo2r6/m3Cebc=;
 b=tr8bt4XKqIP71RfixUNGSEoiyHyk1gqhkuDy6TwS6levZB6vUnSZUIY40ckckzdOTJYR
 0Y0/r6cCuHZKocJwhnq75f53jDKq53Sp6XilK+nBJVmCBfPP2gKvy7mqbLbSqdXYx9K3
 lEUjTUQyATWkLox9ZPOtQBcyjwIKnoIb/DAP2VY+mepBPj6yfF1wTjlL4RCwNavZjb/g
 TPhnl4p1CZIS80B8VrLs8uM9sADSBa+4+8XAGeL2uk5aK8ZsYWTGYE1LBXS3yXGwq8Mm
 +XKvLJQoBFB9gtX9ldbQlNqjB/N1ZfhM+cnyTf2XYo56LizYQ88f2oeLpY3ww24WdoOh Dg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7abgxm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:29:02 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MS9tN015047;
        Wed, 9 Sep 2020 22:29:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 33c2a9kd7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:29:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MT0Us62915054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:29:00 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FDD136051;
        Wed,  9 Sep 2020 22:29:00 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82B2A136055;
        Wed,  9 Sep 2020 22:28:59 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.76.239])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:28:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, broonie@kernel.org, bradleyb@fuzziesquirrel.com,
        robh+dt@kernel.org, arnd@arndb.de, eajames@linux.ibm.com
Subject: [PATCH v2 2/6] spi: fsi: Fix clock running too fast
Date:   Wed,  9 Sep 2020 17:28:53 -0500
Message-Id: <20200909222857.28653-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909222857.28653-1-eajames@linux.ibm.com>
References: <20200909222857.28653-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=1 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090192
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Brad Bishop <bradleyb@fuzziesquirrel.com>

Use a clock divider tuned to a 200MHz FSI bus frequency (the maximum). Use
of the previous divider at 200MHz results in corrupt data from endpoint
devices. Ideally the clock divider would be calculated from the FSI clock,
but that would require some significant work on the FSI driver. With FSI
frequencies slower than 200MHz, the SPI clock will simply run slower, but
safely.

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

