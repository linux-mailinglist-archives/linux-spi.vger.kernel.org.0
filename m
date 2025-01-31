Return-Path: <linux-spi+bounces-6598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DFCA2439F
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2025 21:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3789D188A6AC
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2025 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641D1F37CC;
	Fri, 31 Jan 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmXPy5zk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174261F37D6
	for <linux-spi@vger.kernel.org>; Fri, 31 Jan 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353731; cv=none; b=dQ8L1NGBr2JfSeOSxCmv6GpfM/82xZOQpzranS3EHExanyDbKWhLZL9fizRBHfKoUMhM1nry2xC1SyFkpdMLJFEhvyEGsLAMV8p3PTdAoSewbZos5CtEOXIsp4gm9m6ceOJ2H0q1ZSB24Femp7H3/vfsxedv7hzq3GNqTTh0bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353731; c=relaxed/simple;
	bh=NMlIcZ7RZEob7hoxiAHZUNM1xx91oUaxZV8VA06rm8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISMswMwc0Pqmxbkti7AEecQnrBeoTfJxeoIzo6vqvLInHgq7DqGOH6ViXekOh3KlXlX0TDlelCbBbscBjGjeYeDDjhbeQA75zURin6DHy0GnN9m6lTUHZbmQ7whvsOlnHM4bxILRu1m8yd+Zqt1MOkoUByjBco4eyTb5XAoyG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmXPy5zk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGDFVr010223;
	Fri, 31 Jan 2025 20:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Uqi2MRj/oqO8pS1hhWwT40Eho57mzV19fmSz+z9g6
	oo=; b=CmXPy5zkClCwRVIFVVeCvHSfvQax7ntw34DpNbYVF7mm+QPX6PBvq+ewt
	wza2mpbylwZVd/06WpMv5M6cYPdj5JRGl7Sn9yFRkHYFhHPVpK/YCSeN4Gh8iiI8
	PCIaq75Lfvr/eQnzZLAzpwE3nnF7J8/RySiifEp4YW/6SDVaezPIAv4A8dFaQyP6
	rH1UEa4kb9CNTuRw/RwdgeL69EX1oLotpqfXacCUDdPMx56i1hupYWB0meNb1fCP
	3gPcyL4A7IwKIIGNfTOfvXChCdgbJOPEfuk7+rOz5adEfQVv+9XetmIvRXW2ye/H
	4eqCuHSCpVunemM5vYTP3UTGnfFmg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gt7nb62d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 20:02:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGYxuS015957;
	Fri, 31 Jan 2025 20:02:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfaud7yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 20:02:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VK24ev32571922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 20:02:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C103558065;
	Fri, 31 Jan 2025 20:02:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78CA35805B;
	Fri, 31 Jan 2025 20:02:04 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.92.209])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 20:02:04 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Batch TX operations
Date: Fri, 31 Jan 2025 14:01:58 -0600
Message-ID: <20250131200158.732898-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jGG9UYq06R3SwGLyyS-ndq2qrXHnt91A
X-Proofpoint-ORIG-GUID: jGG9UYq06R3SwGLyyS-ndq2qrXHnt91A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=720
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310151

Batch sequential write transfers up to the max TX size (40 bytes).
This controller must specify a max transfer size of only 8 bytes for
RX operations.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index fc9e33be1e0e7..e01c63d23b64d 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -479,6 +479,19 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 				shift = SPI_FSI_SEQUENCE_SHIFT_IN(next->len);
 				fsi_spi_sequence_add(&seq, shift);
+			} else if (next->tx_buf) {
+				if ((next->len + transfer->len) > (SPI_FSI_MAX_TX_SIZE + 8)) {
+					rc = -EINVAL;
+					goto error;
+				}
+
+				len = next->len;
+				while (len > 8) {
+					fsi_spi_sequence_add(&seq,
+							     SPI_FSI_SEQUENCE_SHIFT_OUT(8));
+					len -= 8;
+				}
+				fsi_spi_sequence_add(&seq, SPI_FSI_SEQUENCE_SHIFT_OUT(len));
 			} else {
 				next = NULL;
 			}
-- 
2.43.5


