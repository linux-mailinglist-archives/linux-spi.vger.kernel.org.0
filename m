Return-Path: <linux-spi+bounces-4087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDAB94111B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E11B258DD
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DB1A2542;
	Tue, 30 Jul 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aziakrqT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1851A08BD;
	Tue, 30 Jul 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339949; cv=none; b=AhxF803eoXMaP6QZBFJDKWW8Lu5/XVrNu47oehUBLy0g3qRV0bK5yDalfuKNjN6OqAzs9RvrdOTJC5vmNtxGqZeQJNEtRgunvdcL63HQ2ru36RcwZUIJC/mIMZw8G7xz671sw6BBakHb45/wldNX2SEn2iG5RSJsmZNU+y/UW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339949; c=relaxed/simple;
	bh=P9PB0QducXEx6KxHbeCiB5/zPooqQ5aaw3Uk7iDrVQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD1zV6xDcjxIdlAm1M658m4o6NcslS87K8++wdHpaK+4tV/yDCFNlHn6AATTgF1Ug/9UVEuVS5YpxB8n8Y+iuGAAkTCDnViN/E00VrM9rSzVfcImBKOC4r+DT+iq/vSch/bACTNsasSguSAxhLuIIewJgOdRtQeTjkRKUscxHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aziakrqT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7ucLT030420;
	Tue, 30 Jul 2024 04:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	XTrupazN0lbtDt+nXU9Sp6/Syqz6jDub2M414Gwrgs=; b=aziakrqTeWG8ThroI
	u72pwbTo7Avjobh2idAJ4D12C+dT/xowIIMXIwtV0UWsnUnhavSAL5I6vJ/Y43+X
	p5msIZ4bRCxDPGRN5DE4hR72EVVF5mBFqOUpRZbZeZQJm/60Jn7xVsj4yTsLNhlj
	uqxMgya7UHRBx22rgV1H9VUanDrBBoWCDYxv+QXbiSqcyTaQ5rYZsv01XxlH0C6E
	dEFVxbjobznyTaJubWSd4DtRvGixE9GoABmPLNLZzYwWNGA05UF6v/oYzWXbj/bQ
	4YrRy7NTG465U3c+ThcQhj4CzeNSKNDJx8Fn95RtllFHsKdTazj/rRvTTObiDXq5
	ld/vQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqsk96-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:45:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 04:45:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 04:45:40 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 94F005B692D;
	Tue, 30 Jul 2024 04:45:39 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v12 7/9] spi: cadence: Change resource mapping
Date: Tue, 30 Jul 2024 04:45:31 -0700
Message-ID: <20240730114534.1837077-8-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730114534.1837077-1-wsadowski@marvell.com>
References: <20240730114534.1837077-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: U-Nm6nSfPKv2gwMkEhrfStzWE0XIV0qB
X-Proofpoint-ORIG-GUID: U-Nm6nSfPKv2gwMkEhrfStzWE0XIV0qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

If mapping resource by name will fail try to map resource by number.
Such situation can occur in ACPI case.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 69c08bae7628..a129f33bfd38 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1118,28 +1118,41 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
 	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
 	if (IS_ERR(cdns_xspi->iobase)) {
-		dev_err(dev, "Failed to remap controller base address\n");
-		return PTR_ERR(cdns_xspi->iobase);
+		cdns_xspi->iobase = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(cdns_xspi->iobase)) {
+			dev_err(dev, "Failed to remap controller base address\n");
+			return PTR_ERR(cdns_xspi->iobase);
+		}
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
 	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(cdns_xspi->sdmabase))
-		return PTR_ERR(cdns_xspi->sdmabase);
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
+		if (IS_ERR(cdns_xspi->sdmabase))
+			return PTR_ERR(cdns_xspi->sdmabase);
+	}
 	cdns_xspi->sdmasize = resource_size(res);
 
 	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
 	if (IS_ERR(cdns_xspi->auxbase)) {
-		dev_err(dev, "Failed to remap AUX address\n");
-		return PTR_ERR(cdns_xspi->auxbase);
+		cdns_xspi->auxbase = devm_platform_ioremap_resource(pdev, 2);
+		if (IS_ERR(cdns_xspi->auxbase)) {
+			dev_err(dev, "Failed to remap AUX address\n");
+			return PTR_ERR(cdns_xspi->auxbase);
+		}
 	}
 
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
 		if (IS_ERR(cdns_xspi->xferbase)) {
-			dev_info(dev, "XFER register base not found, set it\n");
-			// For compatibility with older firmware
-			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+			cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
+			if (IS_ERR(cdns_xspi->xferbase)) {
+				dev_info(dev, "XFER register base not found, set it\n");
+				// For compatibility with older firmware
+				cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+			}
 		}
 	}
 
-- 
2.43.0


