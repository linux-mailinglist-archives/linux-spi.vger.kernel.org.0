Return-Path: <linux-spi+bounces-8234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2FAC0A13
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 12:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AFB172E7C
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863BD266562;
	Thu, 22 May 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gSl93Vei"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F61EF387;
	Thu, 22 May 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910880; cv=fail; b=FvXoLlB2O8ef4mu7A2HXBZBHDMrZN/oyqhK66ae2gw26PHjXP+zPZgZP7vVbaD6NZTan5oZph1vFd8bPnDeh+NzYaiqV9pLb9R1r2Cw7GG5QtLdSq65hF5RK1C9LOJNio/CRKV8REoIwTuX3ZN3UoNY7OcOqDSrC4WvyjERqHv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910880; c=relaxed/simple;
	bh=y4L3JQm95jtRBfnsiN+gXzOLMirJxE7v+IJfWdyZW9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDV9hMVlwe2iVo5bcSsbn8VgO66/Abp5QEK2Pb0IUHVOdBKyCrrGXlX2ozuyuSoM+GsxnmKhr3X+lr0n0MxzPShiTgp89NjBp9fY3rcWQj6Zp2kPntfnH4/yVsNELyUI+o9iJn0a9gpzwF45ksIrV+bQQYnundDGea8/0lsqZKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gSl93Vei; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOFYEmWPlotI4B/SvAfEue7wB9xro13UgGQ9j8A3KSeWnu6ZTr9SjFcYegfgT68Q1RtGYyk0jl9RZCiV5XyuKIdPDNLLT+6pLv1eM7HW019Yxj/HxWIRf7XEpCsz/5OJctBu5cNcN9qq9oT9HCzQSKvYEIKvcbmrFU3pQB0JnBo3Z1OBcs8OXsz0kEWh1yW2dRBl1wQZppzx7gv9xa1I9YSfnc3CiembaEeN24k7GX2OJN7BfLwftB4SENFpjnL4LPmy3jVD3zkWB7DJTfJLFk54iXwdKbI0+GR88E0vockm8VOpGABHJViqDvU4BGoHuZapEIbWN4fy2+dgrbRDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmJ+XezZ+nm8AU174cDLAPXzY78+9/cxBlWApK27btE=;
 b=zIA2G7M78vX2mOF8i0ax7qdUSpcaMGutNe4UT4bkisGL9+1cXgrDLf7xzt/KSgK3PCmfGPS54NzpYygXPnwMFEqMdVtc76DvbpBnrZA7R1JlSEoSeLgWZ5mzyf9QxFNKWsQIIhpKYPgNIeO1Sho4Vvvm4FhJ9SvKPE4twR5FWztTSB3j/5TC1MUWqftsubi2fpWxFrPEZiSiEr30IFPMdS95En1zrO/9bN4E1ffoWW41/263Q/X7v7Yq5v3W2lmbaUVFeA1IAt6MFipiLpKHDxnntluCla6q+kT7mQF9dePsTIXs9Xt0nFgoZ6urcgEHL7Qac+wJ4MAw8KGJGVjeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmJ+XezZ+nm8AU174cDLAPXzY78+9/cxBlWApK27btE=;
 b=gSl93VeiPKoHIxUoXGGkyNvHgfTDt9YA7s5IX5Xjp98mmjn4kxTnpVlyQ+hiV89v2DHQK/BijlVyvQfkppVb5anB0TrRfiR1275Uz/oxoKfskJkYRbNGf4iybxgfl1MDSctR1F+YXYDi3bH/gnBB6wjpx4qBsRxEKvQAO6X5QGg=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 10:47:52 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::f9) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 10:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:47:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:47:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:47:50 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:47:47 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller
Date: Thu, 22 May 2025 16:17:45 +0530
Message-ID: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 640f1a86-8345-4fca-08fc-08dd991e1a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6JQ5jlnMcR+EgcR7mYrFHqZ1Dy495eIBeXDh+SzMqR59RFTbNNLFFcX6vzOp?=
 =?us-ascii?Q?cacxH5JKQAkmzVcXbNYwYtQZ4RdXc+U6NtlBzVk5Fvrpk/SXyKKQuIybn1rz?=
 =?us-ascii?Q?jWkUV9AIMGSlr5fU0NJS5f8p5F7fOsidC719nlUMygz0UjjeHt3D0QRG3Rp1?=
 =?us-ascii?Q?xuznZkFFe3IY/U0CB0fGrvCTYASdhUu8aGpKJah6vB8rtGA879Ux50HEKT5x?=
 =?us-ascii?Q?N2HqGWqeRF6yLOWapqQA66/dg/shDx55dvH1Ibv9e6hxpzZlK2NlG7Vfujfv?=
 =?us-ascii?Q?rbzMmCCDOeAnk64ikVIQdGPgmEkwXKVLK6mZc4GXJOpcqo5xgcxzlCWd4nWw?=
 =?us-ascii?Q?tl6jFNfGxIlgTeJJhOJ4xdchHvx0w7nPXgu5R9iI+sGBwBjrYhSkRpgDR/4d?=
 =?us-ascii?Q?CyqxjD0WG2DA9UZNQU+VdDJR9G9W4ny5KwVFpiJHnO2opbgSjYrLyApYym1r?=
 =?us-ascii?Q?Ntv0rnDxjJBnVK6Fbymogp0usUUhNFuHyDg57jMTZC6H+wDylf1lt3XNZkgE?=
 =?us-ascii?Q?0KhDTXZPkttGnITs/cuN5Q5v6e5oQyAM93xMl+y3BN6BVGxeEX7ky5udyYkB?=
 =?us-ascii?Q?TDQ66pIKA6jBmOoimDHZA1lG2M28Wp3YMjUdaXvwRk7DWSkSfCwKauPTCnqu?=
 =?us-ascii?Q?SDISpsF5KkM/d2E2A1xV4kW+8OBnYb6cswndGB2xqGUOik865YFnJZT+/6pn?=
 =?us-ascii?Q?YSOINeVv0G7C8av7BVMioFwzXRSlyuTeaFIaZMOq4VWyGpo2aV4HUbpd8/e9?=
 =?us-ascii?Q?ZIYw71iEHN3E/4O038hVxrVHhE1lQ16Xi8HQGeVgEBs8kyJJd/QRG2ZuOKEd?=
 =?us-ascii?Q?wpmV1IeP+3MUaVF8zjuia5kUgVJVqp+KmFDGI88MJ164p7VHZtR9GQARed/M?=
 =?us-ascii?Q?jfwqSq6iOEWBepNwUFZZZSmPAXVuoHrX01fyGeYIKERgi07uc5WDqy7DdYjB?=
 =?us-ascii?Q?lg09tS82kLgC2OqcttDk9TZf5C7lH23A+BPbyAdaVXHpOnxRBQnQe8D7i3s8?=
 =?us-ascii?Q?NxxOJeVPT26KQuXX8NwtToSAssUeSI+ko4kvPNakN+sAH3ImQ2yH9FCSTE8n?=
 =?us-ascii?Q?9M3f3/9ijRBPclpcNlNG2lXnEi94gK/TDM3G1hgWhfuXjl1WeaT6yHJWGKMh?=
 =?us-ascii?Q?qpZi/rjq1koqUGMuWA9LJuXHBcSNgeDbJ8GjCVmxnJSwUTckYNFctgXbv9I8?=
 =?us-ascii?Q?RJdS+hMD5wxS9tdRtMXImht6SHGW+bCwViNqsJMM4/0yyxExRyOSKIFF63eV?=
 =?us-ascii?Q?ABQqkr3Cc/goI3xYgKjzrwnK+1rEMIFN5vYH/0wq5B8GoscDIKZYXOYH2445?=
 =?us-ascii?Q?Tx8Kc6MjFvDkcxFC5LqPHljeWhhMATJJgWqUIezdrzDRmRTuDUtCvoWU6GCu?=
 =?us-ascii?Q?cKe2wsoXuq/AiANamgHF/sWduiPgCxQvBrrSeCJli6kKzETIF8P3FnPEDr0c?=
 =?us-ascii?Q?2z21MkXUDE+/0fn3j94eTzh5ppi2EtoYjZcJ+Ntj/1lDpBCee+ThNxFFZM9k?=
 =?us-ascii?Q?1Wt1+IK2x2INJHkiNfX3boy9y9q4v80h9rT4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:47:52.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f1a86-8345-4fca-08fc-08dd991e1a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
one reset entry. To reflect this, the maxItems for "resets" and
"reset-names" has been set to 1 for AMD Versal SoCs, and the minItems for
these properties has also been updated to 1.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: mtd/next

Changes in v2:
 - Removed "resets" & "reset-names" from required properties.
 - To address review comments, removed "maxItems" from "reset-names".
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index d48ecd6cd5ad..648b8452877c 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -17,6 +17,13 @@ allOf:
           contains:
             const: xlnx,versal-ospi-1.0
     then:
+      properties:
+        resets:
+          maxItems: 1
+
+        reset-names:
+          items:
+            enum: [ qspi ]
       required:
         - power-domains
   - if:
@@ -132,11 +139,11 @@ properties:
     maxItems: 1
 
   resets:
-    minItems: 2
+    minItems: 1
     maxItems: 3
 
   reset-names:
-    minItems: 2
+    minItems: 1
     maxItems: 3
     items:
       enum: [ qspi, qspi-ocp, rstc_ref ]
-- 
2.34.1


