Return-Path: <linux-spi+bounces-3480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28A90F014
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F42C1C22034
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101532374E;
	Wed, 19 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UO/YCk3r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8E1F947;
	Wed, 19 Jun 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806653; cv=none; b=ureah3WVHwXaTIvR+O4X6ijTCjMizvssW2HtSV0z5yWMC+zdQ8N8djMNbh3y2r+CNvSyCeOgkREJPHS0UQqevnDKUym4SbNtlyR+UGtMS0TXnaf2tIn/JbEKllvhb+LRQCjblkNnTpUEVPMnVvZGUz0umQEZd/Uyvzw5grzvHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806653; c=relaxed/simple;
	bh=8+B1Z/cRAmYyFjCa24tS7ylXGVVbbhrXj+UeSMx3/Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmlOdEz7XbdK1CDFUPP+FUUXXfuIHuYyTnSDMVi8PTOcHXfQDlnYTITiSJziAalpraI/6Of8vYXildy4sqVeBgZkbMR7fp7Z93aGyPsgCZEUjY6+RxPM/z9amtJqsqcf+baMxrBFZq44mSz7R3kDt/p3qghhfFE+mV1n37tipdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UO/YCk3r; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8ih011743;
	Wed, 19 Jun 2024 07:17:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	ZUMugq7TiGV0N8srj8eJuG1yeghFqkGWtUuxSAIhKQ=; b=UO/YCk3rxMfvJ4wZN
	nlzhUiau0mcaWSG6hR7qOPSSp2wu7V05diLqU/pmXS29VTiBKwXMk8LEPzfprgoD
	/nJxaiRkFR7/+31yBlkMK1/ZHzFTcfWQaK7cHeQpSn7/bAR6a4/YHPqemS8M9GCU
	GiaFIoXHXCOr7/In8H2vtoq5Gfpp0x5mTd2Cbfp3wsNKEpR55wdzlDrIDbksSI6+
	tqO5kBdBHO5vG4QA0ia+UNlrjmruePs11XiG9p60CuWse0WcgQI1sxy1FcQu6xZj
	vA1SsLA9UktQqUZgJ9SQeSBBIJGWpfciO62xQZd4gMREdQ/lmY8IMedTYxq8PN0v
	9U8Dg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrudr-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:22 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 0D3563F7086;
	Wed, 19 Jun 2024 07:17:22 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v9 8/9] spi: cadence: Change cs property reading.
Date: Wed, 19 Jun 2024 07:17:14 -0700
Message-ID: <20240619141716.1785467-9-wsadowski@marvell.com>
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
X-Proofpoint-GUID: IZ-r-oLxrQQqUVqLnhwPDIbkf-qu6kMt
X-Proofpoint-ORIG-GUID: IZ-r-oLxrQQqUVqLnhwPDIbkf-qu6kMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

In current implementation cs property can be read only from
device-tree(for_each_available_child_of_node_scoped). Change it to fwnode
based read to allow property reading in ACPI case too.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 9cf3624595ea..4edac7c8d73c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -811,15 +811,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
 static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 {
-	struct device_node *node_prop = pdev->dev.of_node;
+	struct fwnode_handle *fwnode_child;
 	unsigned int cs;
 
-	for_each_available_child_of_node_scoped(node_prop, node_child) {
-		if (of_property_read_u32(node_child, "reg", &cs)) {
+	device_for_each_child_node(&pdev->dev, fwnode_child) {
+		if (!fwnode_device_is_available(fwnode_child))
+			continue;
+
+		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
 			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		}
 	}
-- 
2.43.0


