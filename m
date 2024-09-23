Return-Path: <linux-spi+bounces-4932-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C600097EB86
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E58D1F218A3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F680043;
	Mon, 23 Sep 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o7z9l6kI"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A51714DF;
	Mon, 23 Sep 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094780; cv=fail; b=uxT0juARBgOTuAyQNzdSRTVsfIsq8TDyBEl7O58SIcdd+c5yPZqFDa0uT3PvN48P04IRvuPoGjGaKbBVkk1E4zmfUtFZXe6X+Qt0xpNtu5B0jIlprU2NcHuE3leSQvVMGQiz4RmrZpqpo0qii9FUNA2n3tEf9ir/4w+rHYBFnoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094780; c=relaxed/simple;
	bh=wT5bZiKKoW3L/ffG7RX5UbbaU1c2Deb/nXGLHSKePVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgRsJDqoiuiCVpJfAK9/VRwcX0zxBEqSJmmmmP8pyQh49AV6RKKfQtINgY/9bX8wb8fhB7MD/9NpzUPMhVVrr9NarEFCTMdhOafbFFA9ft70ug2/WSda/W2zuD5RTgAViGcsUds0QELx30LKz06wpmUKSiCRUTb8Ro23Fgr3ykQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o7z9l6kI; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypZsqzgCUXZCpXHcWQxTxmFjypXKw3dQbuR+5VjuMQ7X8RDcvpaEvNA7hjF8GB4THbBCW2NRyy4Pi31RHJbFshOmAJu8wpcU99ZdJUfK5ltt40hkfkZSG5yYrfJaWzTPVKPnbYJuX2aZSnkGWVTDclSVgiwLHA+SYvfufqbyfp9AGWOI5SRDkZrF67llt1GF6wD3wqkNZ57qKI7BZanbmVKabR+Qns23vW3mXaNQrORg98yTe+5+2i9upFp6X3lZYUpVAQR8rAqttK45cBRntpYITtDiDdI5nk/B1m7kHWggEiXZ9TgEEOgaIz4mewg5yu81GegxKmk6eYKxqQkowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekd7HZB+CGDSsjupV/qJVcGpPDLen7CAMpIeKRBAJOE=;
 b=D2eRiMxWH8XiNrjHoUXYaut067hQjneH88zldtA7VlkGvw3hL6ibi7d6I4XOn3XCxpEk2tY96lllmUVr8kAUNfX61UF7w56zusnEXgH1vy249UYIWFJIFcdFUEIy+zfsFlDG3dQwNtiF7cQogQ45JAttQ978wFbS3QQ9Qb3rzLrO/U0MeKZvjBzwD3zOHk8Z+D0YNLJgvN+9txALNC3DZ1RaA4rbh8yD6PhMXSxMEkZbpqMg/Mm7HvnLOQxFfn5pWqsRhGNaHWX0Wpw8476+Au1HLA5n5lyw7a4Wdc9o3tKdZaZkRbD/kqAtIzUt9HjQ3obktaQcXrcOxiAm2EHZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekd7HZB+CGDSsjupV/qJVcGpPDLen7CAMpIeKRBAJOE=;
 b=o7z9l6kIpvarDsVkJoGRgzmS3r9wTP2rsLJdcgKqyV7ds1ggQThxJVmSnJMQZ4+qqKzfeduAtgESH5sXD5VoDi3cdU2b7GmP68U/Hl9cOVKrWPh/B5nM4/eqab1tttwQQbek+PgYeehkCznH7jQYbFv99OfmMZ2d/u6VfROeIc0=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:32:51 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::5d) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 23 Sep 2024 12:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 12:32:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 07:32:48 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Sep 2024 07:32:44 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names properties
Date: Mon, 23 Sep 2024 18:02:42 +0530
Message-ID: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: c62ad539-2d5e-43f5-1567-08dcdbcbd691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEImL5ZPRzhyAAV3Pdr9ZTs/ySzRDSodJMlHMkN3GUy+tLDSE5cOz+nvCD+0?=
 =?us-ascii?Q?KShJOg7TH7oMV/P/NtZJ4VHmcOikeBs18CGkHUMWcHSYBP1lfbFEehWQTAPm?=
 =?us-ascii?Q?hWmTZFqQdJrtydFoWuNTs3TytztRDnIDgxAUXs16Norkk/8pdvPVqMml3iel?=
 =?us-ascii?Q?vo7IH/Xh1eYotBzHyYRKTkBQodbYzji8z7OnkK2L5US2rz8oWmgV3sYq0GFS?=
 =?us-ascii?Q?3J+OfoaivSHSqLaSGh7RnnKnVl3xVk8gMM0uQ3Bhxgc6oQrfhayo4YWPsmMh?=
 =?us-ascii?Q?za/B/KyV652nduuFjFwu2VxQAB43Fag9R5BKDHcL01c0TX1KXsLBPFlhsVP9?=
 =?us-ascii?Q?dmuhfjhrrlVUyC1fJKzDzc+PTxJh9YpbwIzIZi4ECzisZ+1aKhObVzqLcJKj?=
 =?us-ascii?Q?1S79pWCNrthtlVNdsF5eDUos+elQ4eNHUMHdW1GBMQ2lAqjtohOplw03WV1+?=
 =?us-ascii?Q?EbyGveM8w3IaHy/DD/ac+ApNQVKZQrGec3ZI2LyiTUHAhhmicNTdKuwNcB/H?=
 =?us-ascii?Q?iTC2PsmJTOpMZmvLLcH4A71mUu6JF8HLccxyK8VCvsMrgFHcrOYq9hrgzBfz?=
 =?us-ascii?Q?PYwWK6R37ECP5aq1pzeNgk3I5vXm96jotu860MBo6EGZAp++Ntd5u/WZCQWu?=
 =?us-ascii?Q?VLFFsffWXA6T2t6eF2kBewFq0fZ/o0F7oV7DwZmbr9F0jayOpfY5haVJ711G?=
 =?us-ascii?Q?2NViSmih2DgC/INhdm8RE6Y+4h2xy9lnf0sQqa/hTS0noN56U8lOCgb4mYZA?=
 =?us-ascii?Q?yV+LzWifa1LfYcq9Pef94dMJfBl1416ydEH9w/nnDrMWyYmZ/oexVyEgTXCe?=
 =?us-ascii?Q?oHVRXHjqY9m0fHxmeNYvOsgWs98nL7KUA39IvKKNRNVInkbddknqKhMMajDf?=
 =?us-ascii?Q?Cdh2J6YL9ZyVQLFpS6mM2FHHs3v/vgEiXDNczk6Aedy+LNWZo1/+4w5W4BR+?=
 =?us-ascii?Q?D+Ns1QeKs4Z1JNtCNbmm6pBEpep7RBAYFICpo18o2InSH4CY65OXBdY/rw7O?=
 =?us-ascii?Q?7DwY1GNxCzoLrIcSlgoPKU5waWoor+rssbnKKbIltSygbllzbpybubR4hqHJ?=
 =?us-ascii?Q?CEHsqyBtlx9nyM/PB7F+QJTKl6nkhsIU4XtkPsndGYUCnhMO0Ez7DZ31KhzG?=
 =?us-ascii?Q?96+fHrs0qjwCXipza1O5rI2Ma1fR3eAHjgp9llrSnRtHbDbByr6DUeMD8RLK?=
 =?us-ascii?Q?ZKVtaTM/25VI4TfVM6EysSD6gZ9jpvdTMAKSyXStluhDQ6fWmh+n1bKiiKnF?=
 =?us-ascii?Q?KWJzi1eXTg2f5Ut9v5BSA/a9fzCXquCvrA9T/i5SdQTSzKK77rg19wB2QiMw?=
 =?us-ascii?Q?xFRMfJZ6I5iDTcbbr3Oa4U4t3sR1Vrf9K1J2BwQlVFPfgWLJf0i7FKDYLT90?=
 =?us-ascii?Q?hJ/JtwnHKA/SAR6ng/10p6b9RAU+AeCp+i7wJynJProzZr/GR1o5U28ESxbj?=
 =?us-ascii?Q?ACCu8/HdgiLYle67h8Lxc8AhNL2swY0l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:32:50.2569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ad539-2d5e-43f5-1567-08dcdbcbd691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

Include the 'clocks' and 'clock-names' properties in the AXI Quad-SPI
bindings. When the AXI4-Lite interface is enabled, the core operates in
legacy mode, maintaining backward compatibility with version 1.00, and
uses 's_axi_aclk' and 'ext_spi_clk'. For the AXI interface, it uses
's_axi4_aclk' and 'ext_spi_clk'.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 .../devicetree/bindings/spi/spi-xilinx.yaml   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index 4beb3af0416d..9dfec195ecd4 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -12,6 +12,25 @@ maintainers:
 allOf:
   - $ref: spi-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,axi-quad-spi-1.00.a
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: s_axi_aclk
+            - const: ext_spi_clk
+
+    else:
+      properties:
+        clock-names:
+          items:
+            - const: s_axi4_aclk
+            - const: ext_spi_clk
+
 properties:
   compatible:
     enum:
@@ -25,6 +44,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    maxItems: 2
+
   xlnx,num-ss-bits:
     description: Number of chip selects used.
     minimum: 1
@@ -39,6 +64,8 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -49,6 +76,8 @@ examples:
       interrupt-parent = <&intc>;
       interrupts = <0 31 1>;
       reg = <0x41e00000 0x10000>;
+      clocks = <&clkc 72>, <&clkc 73>;
+      clock-names = "s_axi4_aclk", "ext_spi_clk";
       xlnx,num-ss-bits = <0x1>;
       xlnx,num-transfer-bits = <32>;
     };
-- 
2.34.1


