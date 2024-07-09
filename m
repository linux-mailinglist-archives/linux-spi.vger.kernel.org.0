Return-Path: <linux-spi+bounces-3822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556592C60C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 00:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC6DB22155
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF318C196;
	Tue,  9 Jul 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gWSs6plR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBC189F39;
	Tue,  9 Jul 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563145; cv=none; b=YZFRcjtyPdqWMWP1w6QuCol4XW1CH8uY/nmVCtyBl4efzF3P49N7UCPpnKnV3fbKj+ywAPJwsStleGMF9UO7KClRbOBw9J+YPcTj37ObaLf1l8+GKxz0pcXpwxf7EwxWhtkHoGk3E0+pKXtIHjCNHOOGP1TCHxFRRQKm6CWBaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563145; c=relaxed/simple;
	bh=ZJcaWpMFbqqwFJxU/TmgHyrO11l6EHtYK5256zEpomI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIasmcOp4JYvBvIQeKg3ywpmE8mk/sst1cTzX82iJZ2AzsxEaYIIHEtzvAAMw+l7Q6b92DzrqVSjSU98bKADoOxR9lzMJMG5gsMk/SxtCm3Q4r062vVwlT8+Bwcd3+0x++xCwpRghQa/OGaY33J/wdHvePeQ+AFCEUWQCACOvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gWSs6plR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KH3Lo020309;
	Tue, 9 Jul 2024 15:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	FcBEu97hG1jVrV8wnfJepMJc7CAZrtnds+NSoAV/GU=; b=gWSs6plRyYMn4MPY0
	oz9usUfIUZYsnDqdTXBMbxeqtgN43ZCCgcly2Ef/4fij8zg9qi+xlophyLjgSbgM
	OL9jClWEWTjrb8ccWTB4lQXe5mY4jtpEVfCVVrJ6k886tvjL5uSiBQ0CMo3HeSPP
	XXw7h240Jgvqd5TSns1JIst7QvNskmUaWe8ukDDi07t953N1LqWhOFVYy0kzZOpF
	9UU+iGyoGbhDEXojueUHZ7V9MOZ0WvrVMVuSuA+5FdsMIPrSNQHTkWFT/LCcdUBZ
	UQqNKgH+6DZmZ38sv6Bx+jNyRd/U+0nzoNqQAST0ZUaSm143ibf1HiM8NcE56wPc
	vmnag==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntymyxg-7
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
	by maili.marvell.com (Postfix) with ESMTP id 2F5715B6925;
	Tue,  9 Jul 2024 15:12:16 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v10 8/9] spi: cadence: Change cs property reading.
Date: Tue, 9 Jul 2024 15:12:10 -0700
Message-ID: <20240709221211.2130456-9-wsadowski@marvell.com>
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
X-Proofpoint-ORIG-GUID: pXh_OQHc12x9GIS4P5ImFwSfGKYYiqkP
X-Proofpoint-GUID: pXh_OQHc12x9GIS4P5ImFwSfGKYYiqkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01

In current implementation cs property can be read only from
device-tree(for_each_available_child_of_node_scoped). Change it to fwnode
based read to allow property reading in ACPI case too.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index a1ecd9ca07f0..db267a2ded5d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -827,15 +827,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
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


