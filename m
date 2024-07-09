Return-Path: <linux-spi+bounces-3820-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41492C605
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9592282086
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7318C163;
	Tue,  9 Jul 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R0eMZCPF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BF018785F;
	Tue,  9 Jul 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563144; cv=none; b=trj4L4mUcdvl+/CDvLv3+QKB+dIWbiau7QXKFvt2n1lx9+Q+9V3IAlZXus14Yk1p6oZE5aSBa3oplg4q8EzrlqMtzTYYtg4TLDsPQEBVZXV8lr1RyaB56b7537aBWQCQeLT+WyGXfmDMC+KIWPg6agaqRtyp5fVaJctqZdo5Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563144; c=relaxed/simple;
	bh=0xW3jvPvPKDwgO+2+o5V5l77qRW8IycWtgEsxCQAUJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYyVYmQotYdvK9B/3uDFRvNqY3D/peCffsQbQT30jUiLQtqYDxF4eIkFOpHSC4q38w770pN4ed04xnuQwd1Xod8+ipMOthoMzmnqLOgiFBLcV1po5qwiXmVJ50lj7XSEeN1cQ/WmVvlFEF/zaUwYp5+Dhj0cK+y7PIvcajWGKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R0eMZCPF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KH3Ln020309;
	Tue, 9 Jul 2024 15:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	Wu0MTMOU3AXLcsQ1g1athrLWJ1A/JKdc/tSdTCqpdk=; b=R0eMZCPFe0/9poqax
	qw2OjmzEOkRAwAo7xJEt4vKdjFSKkLURRiRBQI1n2Qv8Rtk55utgqh9lLsngUU9e
	lTp7vlWaTCik5C6R3YQfqbRT74ebnL+w/wJQac9OOgxmvudC2GbVF0Ig3rFhNR59
	O4M/5Xl/AtK2Ds5eVB0u9CDlJ1ru6eP8a8WQqYMH22+CS0akp7RKIA8qMwAvIEpj
	jSoSfWVVtiohDYNs2UgFb2NviF6I37PchYdaobB1ygrnxHsXEWdQ1TWrZMxleiwh
	tmBuklvxDHRILE1ZXwf4NfeuiPpFz6OGyfKwxMMC/3uj+ZHEd5G6kDbJRoHBZeSB
	t5jCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntymyxg-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:12:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 15:12:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 15:12:16 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id EDE3B3F7066;
	Tue,  9 Jul 2024 15:12:15 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v10 7/9] spi: cadence: Change resource mapping
Date: Tue, 9 Jul 2024 15:12:09 -0700
Message-ID: <20240709221211.2130456-8-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709221211.2130456-1-wsadowski@marvell.com>
References: <20240709221211.2130456-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 72QVa5VZmpZ48APNlYTvdev1dwlXRHkW
X-Proofpoint-GUID: 72QVa5VZmpZ48APNlYTvdev1dwlXRHkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01

If mapping resource by name will fail try to map resource by number.
Such situation can occur in ACPI case.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index ad64ed42c4c1..a1ecd9ca07f0 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1108,28 +1108,41 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
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


