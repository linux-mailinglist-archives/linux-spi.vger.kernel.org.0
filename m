Return-Path: <linux-spi+bounces-12344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69311D19719
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6EB93058C31
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98784298CAB;
	Tue, 13 Jan 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NXj01vrs"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319581DEFE9;
	Tue, 13 Jan 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313869; cv=fail; b=jl60vwNHS8WwKM+dVbcjw8HuS0bwXqtIwG2FOuJ1NBdvVOPYtZjZv5d3mssH0hicomd6FvuQMBDIFWMJ6s+EvgcElSiiAMXGrtDI7mckP6r6fx58XrH7yTK8vNxUBM5dwha244Mqt0uKbLsamSQPH7KKzBt0ednev/5TxU+QTA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313869; c=relaxed/simple;
	bh=RHSCor05LAPjXyUtrZ9GLqJARP3FS8qz/OwpgTt9dB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfUQkD6v6PIVYXI/AyXGNFDy03ju2FB3M6QYAKKZMES+zWaX4gR78GXxQkpw0RzmDQ7AAhpg4j9jI2IdcG1/9EMSfbaYsUsqRut2BgqJs81skFGIX71LlMY5sPW/rzTAzDrfOFByTeQh5117Qv4l1tBLiAeYPpdr1LWWW1K24To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NXj01vrs; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk/11IzNox7x8fMqrCQ5m/5inPiAucf4Z2w7FZmb+C7aL8VbaNF4VmOxurBFKt6jrph6WWLHzFE6/JKvr/zNOujcpSwi6al0zsEgnvvQhlTFRk3oAYgW6J4ja+5zVlYW7Nn+t6tGzhOiWTbXOnC4yfkJZiWU8+5xujWELx6kFV0UZR3dKlpYJ/LTw+BVaoJ0gSQ/k+B3SB8bYIy6x1N0893NjDGi1/D09Wgerl3YO5ysKQ3p3QLo+SFMha+uHXzfIPxrs6fAyJx2isV8z0NcJyyeXJZ2JIqvBf1pRhWYa1gmbD1OAymQ8P3eY70K+qilACpu4RiwSRlFJ6VYgrqe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDhwtjzWcJSnJUnV/SpOMLeerjmBMjcA4EkuS+nS7Ao=;
 b=icussO6BXddeJrZA+Nb+Eab9YVU686nvQ3iP0K44W5NjGnxRXuhFzKn3Feq0Ivxq22BinaBghcpcKLWh/9mzXUXBWF7aZ9NNmjiBp9KLYPRI9mdUr0+4czZ9eesNG6UUwSuxGSlNgcbNgviGUnm4CX4F72fVqce3zqzxAPJ6qB8g2wt325RW1Q9riqlMBPa7COFHoFFJlzzd67zvh4q76OJSCP1U3YYUnfPpf7T/c6EFWdHHMGmIsBPPcM+eYfmi3FK5T/ZauJUIhBlGLH9ZHjPQommy8Tv3u1y8VtJXeLYprU9KFDb6b6i4O+i+f80K3xn/WNCDCUw15BasCmtlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDhwtjzWcJSnJUnV/SpOMLeerjmBMjcA4EkuS+nS7Ao=;
 b=NXj01vrsDVom9BgHCo7BD6dcsVzseXJJrqJISEJkcn0duEXhLjtVmIeItzpL5ARNyd/7xAPKwX7g+yyC28/6oU4WN0dCd7bWw89ZI74fregoyDQvfrLyTTj7jn746MC8/khwDQTWhpvzRagtUWozSumKZB7vSB0B8u1RveL1c6E=
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Tue, 13 Jan 2026 14:17:46 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::50) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Tue,
 13 Jan 2026 14:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:44 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:13 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:13 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:13 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLor2381510;
	Tue, 13 Jan 2026 08:17:07 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 08/12] spi: cadence-quadspi: read 'has-dqs' DT property
Date: Tue, 13 Jan 2026 19:46:13 +0530
Message-ID: <20260113141617.1905039-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbb856a-7abc-4a7d-67b8-08de52ae8527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|34020700016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mkuLna0/owF8ikBkxBDCEGZqYSuzWVPhfXca1ZbSsN1ah27BoPjckO9sQuU?=
 =?us-ascii?Q?eoswlnIihmGoEe7b8omMzE9Kf2z6LNnryF0udfC9AKB63L99qh3ktcrC2eSn?=
 =?us-ascii?Q?wMMeDDAXaPWXZRxpOPGc6hV36HC0kfe8DpZUDcVHpAaAizs0/5y6ZwUJgBcz?=
 =?us-ascii?Q?6+iYG3h9F5pEjOrF4kP6Qt+rOF44CL0nuX3NYcmE8VLVK1OTrwB6wXn63Lel?=
 =?us-ascii?Q?WFAjdYOCwwN3MlVc/GRRrYJESZby+mZFKHHdzqm5V9rAhZdzUakc27rSqW4l?=
 =?us-ascii?Q?ChC63WhJvdyHZK15OcNcff/xHfjVTxeUqk++mKqZ/jWlpf15t4OmHYZAL22X?=
 =?us-ascii?Q?00MNJGCf/MZAK2D8yyO9UEEznnK0eBeqT9JmpMxZ1VJnaOZDnLnYip7JUfAC?=
 =?us-ascii?Q?TCiBaWz1B7gxGEgb3iLRBNaGfv/W4pL0ARMDIR0lRN41Da3hs6Hu9sTlaPk9?=
 =?us-ascii?Q?GUDSyElpteLs3CEhKo2U3DJHOwtI7CcbyWu8FPWLHZNOpPO32E8lBOz3wU/R?=
 =?us-ascii?Q?2D6DWKXh2MMo9ryvQ/YtHEtxh4BE6xYduIU8LwGrsN7Y5JLoiS9bZ+FV/OJX?=
 =?us-ascii?Q?eDZYJf7wHCWrC8ly0lWmxhX2WONUh1J2ec5viUxX2En6dAi40+GTiC3hOxP+?=
 =?us-ascii?Q?MwtN7tU9QWYzqhBdJtUL2r/N3QOXdwQxOYY9QnodI+xPJx+d9AQvsMwNpM19?=
 =?us-ascii?Q?ZWq8luvJNCYUiFlg/FeD6fELOs9XulQkl3/0cnzDZxS4eaj0Q/pV2sGQQ/bD?=
 =?us-ascii?Q?j3Yb7pq9nzUoAX90blWTvNz4K3a9jDud9FmaRYOGJHQ6wPKXB74KVlEnM1VA?=
 =?us-ascii?Q?1ySw0KyBSxP1iZywOnoXytO0XTjJNl9oVaXJpSuSL5xm1XH4wfIH2z6Z/6c6?=
 =?us-ascii?Q?uTe9xcm5jjRfuTqOgCGXBBo1CiDPoja2zE17lxLsNLlf771Xk1talclnM6/E?=
 =?us-ascii?Q?c3mSONxta+ensXV2xY/xCfjch7nKaWWYdqEEMHGQmI6vvYTjMMndxVqElpf6?=
 =?us-ascii?Q?GIPnLHOb3MKIdejdP4/+gP/Ei8N92kvFGQ1KtycEtd9wgplL8Aq8K3MQVlNl?=
 =?us-ascii?Q?YWN4A9moBTRoV8mBPxXvJ+Y1W8N8M57A9LaUvG0QJSWBJunGU6Gyd1UEGNGJ?=
 =?us-ascii?Q?r0IadlXaHEJ0nZt27h1NUE5q1VwllyM0Ya2N8vXKP+4f9Y4Qc/xnlCiYNKCM?=
 =?us-ascii?Q?tVF0pxTGIrg8ExJIIslMo3X/N3RSUTL/0tWvhC9COK/lUTEAQf3Ep4U821FJ?=
 =?us-ascii?Q?n8EuOsY3xvBGfN6ouafx8VSn5IwXSEcPIeHHJAMqm+5lpNwzSXUg/q/FlaFd?=
 =?us-ascii?Q?1nhf4lJo6ieOeg37ehsPsD5qh5hSvN1/LBGeWcupKzRFQ1efnc5gHjeNyW4F?=
 =?us-ascii?Q?CeWhq2znv9I90VUfm768qac36uOcWo67jAwN1qVaD7DiJqDaM/qd+CFxuJVZ?=
 =?us-ascii?Q?xcGMwj1dSMo6QXFooEAgGp+BpENVrswYS7IV26lRh0SwvV7Xe9IXsHLR3Mmp?=
 =?us-ascii?Q?011kkOWbXpa/5ywdX+SNKUymAlh4LuGAEwfqTcU6gWND2qFSsuhtw8XUSL/+?=
 =?us-ascii?Q?9F06QdDMLKKJsdnb0hsWwQ/2fXF8+wFHzGDKwP82?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(34020700016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:44.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbb856a-7abc-4a7d-67b8-08de52ae8527
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156

Add a boolean field to struct cqspi_flash_pdata to store whether the
attached flash device supports DQS (Data Strobe) mode. Read this from
the 'spi-has-dqs' device tree property during flash node parsing.

This is preparatory infrastructure for PHY tuning support. The field
will be used by subsequent patches to configure read data capture timing
with DQS enabled for improved margins in high-speed operations.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1d708dde4463..0df286d24256 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -70,6 +70,7 @@ struct cqspi_flash_pdata {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	bool		has_dqs;
 	u8		cs;
 };
 
@@ -1583,6 +1584,8 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
+	f_pdata->has_dqs = of_property_read_bool(np, "spi-has-dqs");
+
 	return 0;
 }
 
-- 
2.34.1


