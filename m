Return-Path: <linux-spi+bounces-4960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00322985A60
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7208D1F23CA9
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45991B5339;
	Wed, 25 Sep 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FqllnbbT"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A41B532F;
	Wed, 25 Sep 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264537; cv=fail; b=GSoPusOfNOBGybqqcAbiOLLbOspdQZkJu1yDk+2tl+0haCnKLRGYf7Lc4h7Au1f5tlqRoMGZpJNMYJ6GT5XyJQpzxjQPAA4sNVdB/jTjcdk+IanNDbgEZcghzJVhIhISDjAUU7BzDj+RpLxHgZxw7d9Nsnfo1vViq4Rs3pAUgsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264537; c=relaxed/simple;
	bh=nioz/Ed0XzIvKn8k7lHWushH1sJ50T6hQJn5zgBFZW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PmeptdFIHzBsx5HkBX3a50GvCUc6OE/j89VWdeytQp2980HX9lMVR4swrtz8eVWUGNpnBl657TfQ+NbKKWDnAaJb45p3H1HK3nNpvNWTfRSNwhK0nCZrY15xUxijJtWlrEzrdNc6UbuJRKfZ7iL+RtkX+wcEIIh5yZhMSBNYWTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FqllnbbT; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUVNj5p3r/kkcSDZ3I0FJ+opA0shrd5+wjeK6660X5bE1enK9c2PmcNeEwfNBRIZH4Rd4UmchgjVa653+wKJSLe6QI0pM8f9mdXmwMjP6y3EuurY2jhhKe89FEQAL9ko34JrM4RO30IPkHH5LWqfpFFqfe7Rj4pseE+0YAf120TrxkChh2NhvRHh1eWyf9DzFVPBhhmU2SGz192KImtd/uPu1ntaNBhA+R/eIRCPEylcjpPy3EDkkKBJD6U3yMQXRHV57Ad9CpxATeagAHL1RGKMqNNfFutRSaBdXY1rAlIs92Cl97vJAgZhLVClSZ0+za2UziABGlReZYtk8iv9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVueAqTjXInYSbLxcMt6A7IN37qdvCLjhxlk5XsEAPE=;
 b=FSTr2L8fMhb41gP7oQTcus+Qr9hZeTXEBC/mV74D9laXEHw1trm9HYb6+EdZngue7imHKOAcukZpRAPJwjRbNlYfZ02O48IMYK7d34FMwOnZOpxYrPr6fsed9c2wVjTDV/+Ey/KKKFb8QrHGSY6ZF1zAAeZnR7L6h0XE9Oj6m0PPVojh1D2Ia/Bqf36O6mlFab+sQAHNyMcsWukfgpB6yMclBo5Ndd4pMLJVqcWCH+jfknuNG+9FOsSrxsNaNtbeDzy+kZzU+3EOd7AHzZ3UhxWgCbZdVqHSmE1keHQYDmScwDWFfvDCZJx2Kgs/IaQD12yBAlQNYN5+pOxKK2WjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVueAqTjXInYSbLxcMt6A7IN37qdvCLjhxlk5XsEAPE=;
 b=FqllnbbTbBP9LhkPMsVmz+ySWmsyLVetyQAA2KkjUZ0q/aGBIuVgYLO750firkBHHBOLqgHTipYgHEu9gpEY8P55qQqSkQf6lP5CF+7IWACyZrFqbCeNm0T3VJ4XHGjGMhteHprR+8sphny4jp6yKMiQMltQJYr+Mdix8WFIiWs=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 11:42:11 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::53) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 11:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 11:42:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 06:42:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 06:42:09 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 06:42:05 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI
Date: Wed, 25 Sep 2024 17:12:03 +0530
Message-ID: <20240925114203.2234735-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: d6521310-d77f-496f-6d1e-08dcdd5717b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhYttNbCTcEBUKxgonPq+83rHXQdYXH9HcRdgpaudoACmdCxntQRElM9WQDc?=
 =?us-ascii?Q?TLaN1n+1pPMeTGJktiRbYTrqz0BIJGkW6BTMEwqeV68oETGvejEBtvW1hFhh?=
 =?us-ascii?Q?vkVL+WMlMk/6WRDGv9N1ZUe2FiOwtsJh/wWOkZW8vbvCgvzkhGGr5yWY8i6Q?=
 =?us-ascii?Q?pmx+WIfDCQgWTzfJoMQ8gulAX47NSwnqePh3Lz7vGkq3g09aQPMjlE2D6NMR?=
 =?us-ascii?Q?TkqVnh5tqWyWyA017vobSzekhLdiN88JS6hCgvaw6dZZxwODk+9ae4acuGYx?=
 =?us-ascii?Q?/JrTid6vb9B8O1RRyCXISxOog76hUSGo/2wpAogRJEnxFCJY7Iy/fXi/z+nD?=
 =?us-ascii?Q?r/BPDPAv9ndAHzkeBHkIyyFluecgGurzKhaap1wy0Nmkp3555Ah94QwUDYlA?=
 =?us-ascii?Q?CMS0F4IFQwbMCL+ZyuPdvzXm3QjuepeQnyL9b0YpRggY8p87kfSJTGjcmvf3?=
 =?us-ascii?Q?HTgBnkZderEVSbqIAcoCX38nCPOGTW3RlvmeK0Qeo7uJYJZQQTCGHamaul87?=
 =?us-ascii?Q?nezo4JO+7OCjTIl9ejMrcANiM18bbSgOztLHdwas690+04AJx6GL+Pl/hGFy?=
 =?us-ascii?Q?FobqWXmQpAEjBdg0FB0d0fxd+wy8XGer+Ey4N0fSdgg8irGZvBx6/TU3be2F?=
 =?us-ascii?Q?UdKGlDfn04zKfAsphJFDNxwh9TVEDysc/kVHAf5o74Yv/FogZRfdt/fbplay?=
 =?us-ascii?Q?eYJMR1cl0a3mtrdr1baON5GncY7Qxcbk7cYqQjuO7W7RzcmGrqYnS+5g+QpG?=
 =?us-ascii?Q?vMQUEaN2vkGEID0eZnOUUvmLrFMlomtzHNcfVULOFiTWlNA4FqGoy3+BkogA?=
 =?us-ascii?Q?tgzSIQohW+KfQssl2y4yRAG8xu4eQSQqoXQlWZ/R909B4tv8DUloaxwMrwpF?=
 =?us-ascii?Q?XqDv+2vDswbJhOAzvwbG2wp7svhGxBz6XYTuFYars07HuUawI9zK9O+/cJJA?=
 =?us-ascii?Q?kgZgKnpieI2hpT1CR1l1FtBOOtnqZrUf67KXVRgMySpEJaeyfVOwbEie/aiY?=
 =?us-ascii?Q?45peiKRROEZC8imABKDv6fX+ZA0grEtXDxaRNi8Wn4Efde7+Rst6Qp5/8hzQ?=
 =?us-ascii?Q?c85YRVSvkWJY+FtM1H20Vqx5VUzQJHEiyZ+tbqrlu1kx54skT6zJewe/E9Ma?=
 =?us-ascii?Q?MZuoPsCkEvnGdP2eG9tKhiOE5CfLM7MiOhFhikh+DKsp/LoqJMCV16eCesXp?=
 =?us-ascii?Q?zFiWp20gmIHVtC5rA6MDPSFaF3VSxA1DdUJjXkxbVXqje/4X4NgkcRegMV6g?=
 =?us-ascii?Q?L4vpN+2rSJVsxUsfYAX5AdqAxbmfwYOA9ibYAapjvmyzcbwmud/Q1NR298dC?=
 =?us-ascii?Q?qQfzt0yOL6UW9ipbXDlGa9oyuKpbuegY06ZKUtLKZ27h/mQRixgHtMMaYw7m?=
 =?us-ascii?Q?EVaORetkCLotqKS+d7nUyrPKZj/f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 11:42:10.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6521310-d77f-496f-6d1e-08dcdd5717b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

Linear mode is only supported by the Zynq UltraScale QSPI controller,
so update the bindings to include two 'reg' properties only for the
Zynq UltraScale QSPI controller.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next

Changes in v2:
 - In the if block changed 'maxItems' to 'minItems'.
 - Retained 'reg' property definition and added 'minItems'.
 - Moved the allOf block down to the end of the binding.
---
 .../bindings/spi/spi-zynqmp-qspi.yaml         | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index e5199b109dad..04d4d3b4916d 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -9,9 +9,6 @@ title: Xilinx Zynq UltraScale+ MPSoC GQSPI controller
 maintainers:
   - Michal Simek <michal.simek@amd.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     enum:
@@ -19,6 +16,7 @@ properties:
       - xlnx,zynqmp-qspi-1.0
 
   reg:
+    minItems: 1
     maxItems: 2
 
   interrupts:
@@ -47,6 +45,24 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: spi-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,zynqmp-qspi-1.0
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
-- 
2.34.1


