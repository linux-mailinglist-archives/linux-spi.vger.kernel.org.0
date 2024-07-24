Return-Path: <linux-spi+bounces-3985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7193B43A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347131C23474
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19615F32D;
	Wed, 24 Jul 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NQwVIiot"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2615ECE5;
	Wed, 24 Jul 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836098; cv=none; b=JsBzC4+73PbFDNXhr/yxMq0dWQb7yAAKLosq6IfaZsfRl6/oO6vmXyYJGWevZgYP7muEI+WjwK28M1/WKtc6iRY/w0tcf0XpFQOV26CvuO89G5m2RMzRq52c7ZdnlZtSRaubfnZ7YCZbaMigZLEPMJiOO/D4UY2YNNsgY+59sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836098; c=relaxed/simple;
	bh=0hka1Q/YW4sPUENc9NChjiU6ewG1veLdVtkqLaO3Is4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trds7TqZ1tS+K4wef865NtDQYOqaAeTqCov3ExcaH0iRjpUHVNf3DzTGsO39pidy25K/EtnryGUJimA3LPq6xpAYPNpeapzs/t2RLKx+fWAzU03PK+hu07aS0WXujzllwauiLtKv6lnVK3hzvjIwhFHhqo8g8MOfCss2qxRIX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NQwVIiot; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEGNFS001424;
	Wed, 24 Jul 2024 08:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	ZeG6EuOMWJPL4yaX+o6Im7eemlAgKgKQaSh4USPRdA=; b=NQwVIiotoKwGiDhRG
	MTT/UCBuV2XPeS5X/HM05fcZa3HJGMGJBx4IFwyNN2H3fyuyeOH9hWttz9nUWuhd
	bQZh1bnBE0KCshb1sZeYhe0vASiu62TiOKFy3RITvQEE3g+EHBAuABR4f9fFH073
	7SgFc26tclT2eYqHHyVpC27RNc42cXP5C75X+6FmBLXto2BhYnOHO/ZWeHnLs7Mp
	XTGkvSIIayAhGd6kmieIUHX221y/KE+YwRrjb5yqGelqqDTzOwIeppmHT/wf1qO8
	LcJKxFj8HxYbrSphNJh2T6D4W/+u5Ay1RBXAi/bOqPzaz1DWgZjMZ5i52zJFmxp+
	3nJFg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40k0yh1d6c-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:48:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 08:47:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Jul 2024 08:47:57 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id D2FC53F7071;
	Wed, 24 Jul 2024 08:47:56 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v11 8/9] spi: cadence: Change cs property reading.
Date: Wed, 24 Jul 2024 08:47:38 -0700
Message-ID: <20240724154739.582367-9-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xGf7X60n379gKpClJMPmPdOqCE6hM4cY
X-Proofpoint-ORIG-GUID: xGf7X60n379gKpClJMPmPdOqCE6hM4cY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

In current implementation cs property can be read only from
device-tree(for_each_available_child_of_node_scoped). Change it to fwnode
based read to allow property reading in ACPI case too.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index a129f33bfd38..28c1aea01743 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -837,15 +837,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
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


