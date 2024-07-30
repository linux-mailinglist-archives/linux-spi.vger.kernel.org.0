Return-Path: <linux-spi+bounces-4089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB1941121
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BA9282A32
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B261A2578;
	Tue, 30 Jul 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PN4HBhmA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BB1A0B06;
	Tue, 30 Jul 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339950; cv=none; b=Iwzv5NOakRv6hhhEID4Zurl0s5a+ssiL+rCmDna4Ec2jO+MecgjyRo2iw74cOJMCC5XFe7qRhS1pxlTCJIyTUamWcNDb4LfA8C01xFQLYw45a1hlf5YhZRiExpbcya5BIKbWVT6Tv8PcAI4MNDrD6U4zW+d4pZqkUkhTnWT9Aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339950; c=relaxed/simple;
	bh=0hka1Q/YW4sPUENc9NChjiU6ewG1veLdVtkqLaO3Is4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q72Ge7Zd0nDK8JyWmxfOTDiOFyNMDNYkjcZMuQHgwvZCb9wF8kg/p+6FVNZaE11naV4rbys5yWAS7MFHYjyBs5T3J6b9qQadm0IZh9RLy7ikDtHJKoEdkQaxFOenVDhtLIy6zTGcfUWp3mHkRgFOsessF94zZqgA+gCb1WanbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PN4HBhmA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7ucLU030420;
	Tue, 30 Jul 2024 04:45:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	ZeG6EuOMWJPL4yaX+o6Im7eemlAgKgKQaSh4USPRdA=; b=PN4HBhmASpxKqacXe
	mvHlF++SsxlZyHuH1uVVyNl+39jn0AhLypXuO/eMrdPCRaFurYTP3rAhdE+Goovb
	Q8ydPpkklmSLPEgl946pHdD8aB29EPdJOawXFDcJ2zQ3d/nEhpJUPDGx6a2XKKDW
	J6LUsF+EGdrQPTUNKXZUMc8hSHEdkZirVgguwk9bCOn1FNiT83YJrcaJqjdJme5O
	boJCXVGgj5ourzgO2nDVLkeQME1AZwFQkb7pVIwVX94r6PuKzIYX6nD+6gW38UUS
	Eb8761EKDsXVbMoSLdTCjLn2HrrQSYw1AXDobgqC1rrvFwGSckSZnOJcHyakMlIF
	Z1Hrw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqsk96-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:45:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 04:45:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 04:45:40 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id E93C85B692C;
	Tue, 30 Jul 2024 04:45:39 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v12 8/9] spi: cadence: Change cs property reading.
Date: Tue, 30 Jul 2024 04:45:32 -0700
Message-ID: <20240730114534.1837077-9-wsadowski@marvell.com>
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
X-Proofpoint-GUID: _3Qz0heItY4kVfBqlDObxb861V6ZH_uL
X-Proofpoint-ORIG-GUID: _3Qz0heItY4kVfBqlDObxb861V6ZH_uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

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


