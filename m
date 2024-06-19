Return-Path: <linux-spi+bounces-3482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C699E90F01A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2221C227E0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23945009;
	Wed, 19 Jun 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UuwOkrnC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85903A8CE;
	Wed, 19 Jun 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806656; cv=none; b=fDkR0xzXTtPqAewjhm3r0ZaujJM+8R+xWP+a0KSvktv+PugegSHWT7tnhWGlXnF8368gcIfIF2mGUaKbftnMh7LNNVn0OuXUrMIiKubQukqQCOFRDGpgQWGCqIVUnf+hId78TpvuLTlpHRPIVbNPXz2wwFn0QvW04zartSZxQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806656; c=relaxed/simple;
	bh=Fk5zZSAZwtHhrWBthgXisBzfR+90ZNcxhqi/Ew8b+4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1SUunCExEw6hsSMj1/iOYfvx6s+lHXHrKt0GA4et9jZ5UQsmydyNCIR5YtuyVReRt9I95GKGGGUj4Rta3/FH5bOGt3jy+zFpcjMe/hYjgL0fFd755f+f4lckYBu01mk5LBgBjP1a1hkTnuJrtm+2QVyl0wJ3b3cKa7wquyxCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UuwOkrnC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7Rs9B022901;
	Wed, 19 Jun 2024 07:17:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
	IVj4L3Sbqj18MwPepNAF2VvSPce+eXm2/bgoZL60ko=; b=UuwOkrnCK9f6672UV
	ZuPWPstJcpZH4eOw3uQ+6Av8x1xlpFpq7K5tocV497+zUbJLfn/vrYB7/2uTpFUk
	aAFL7V8gYjScmBMuq42z3KqXF1i/p0zR0YHXdIi30TfwJnylKZAmFl6QizteqKmx
	zLemlVb5TQUHmDS4R9qhHVeXQ2Ataym3eXv0VOjcLP/5LMRrgo4pQZZ8eKyjYgQe
	pEyD9psOoVp7HR0ozVvgC+fob7PYJrLjek8n00HYIRxoBvo12MgNweV+8KgaH18B
	Pn0ts3m98zDYkSTBTZ7YajZa3BTIz2S0JyD8wrFMZcIjDvqGMcI02Y6kA6sNjp1i
	Ac9ew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yutyc1602-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:22 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id CBEF33F7044;
	Wed, 19 Jun 2024 07:17:21 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v9 7/9] spi: cadence: Change resource mapping
Date: Wed, 19 Jun 2024 07:17:13 -0700
Message-ID: <20240619141716.1785467-8-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141716.1785467-1-wsadowski@marvell.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7jz75porVyx-r2rtKVLwINavMHFalg8D
X-Proofpoint-GUID: 7jz75porVyx-r2rtKVLwINavMHFalg8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

If mapping resource by name will fail try to map resource by number.
Such situation can occur in ACPI case.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index fd40f00c3ab0..9cf3624595ea 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1091,28 +1091,41 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
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


