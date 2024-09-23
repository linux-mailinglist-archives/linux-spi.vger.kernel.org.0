Return-Path: <linux-spi+bounces-4922-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679697E57E
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 06:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC21F215C3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 04:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80DDDA8;
	Mon, 23 Sep 2024 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NQ0uJXUg"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9E4437;
	Mon, 23 Sep 2024 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066755; cv=fail; b=EV22xJWnDHLNUHmnCtnZQCf8xeZLrNu1vQ2DLnSmSpDJLtsJ4WZIfmHk4GLBkjYbYIFgp8oUn7mExUmguiQRu1zcgUwhbKfbS9gKMl6YNUcda4RcdlIybkTXuEEpTtmWFwx9y1gf9mKaI0qmjXaBXmWcLWCtyMdz0IqFxZczy94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066755; c=relaxed/simple;
	bh=e7WnnrLHmThc9dM182W92ZlXgG4dIofUSasVeiuyDAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMOIiWpnyZ2Tz3gKWxWZPgxmLU0QiG48dcnpdlLbwfa2mtICd3ta2tdmRVUlbj5wgEXzXvTz6yen1Jql+Qt05ZdH4Kzl3vOKp26S3iz2cHHn1G+ncrAJWWe30Qmf78IxoXp3XVqlws+rU9fIJLm+nT7cSegObxXyUIDe23kC4k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NQ0uJXUg; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmAzBywm8hSrS+qCQdFqiH1gh6fBSYszDWmOjnDh4vlNGGlLE6lpKGAUBJ4GQ+nh/bBWBQ1NRydR6cLOJR6672bAytN3x9KenBfXNX3JKsQOqBOFlJW0BXzel6l8qTv2iQDijZWfrIXmED0+md57/D4HwrkO3FWX+dLqCXoqktFNaiiPMLeX2BHwgrgwteC4/QAH48//Uwyb0O3abx6HHJeMtc+f3GBf7psvJT56nynXoWU+mR42JC8ElqDUyV4JNUVQyEcX/IgP77sFKUOgXhx5qzCjpAj/NAE2PSXwYvuFSbPN+EO8ktFl90S1c8IJcDjeLqS2+u2dlu/JLsXOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L96Fym9Aw1e0JKU5xfuwV3taU7LwRkH/gZNb67lFJuM=;
 b=IYGbj75zHf3cLKa+23BzoNjcZtYWLce/NVNdFbOoUNxqtQR4nnn7Fi8aLotnFkeCRUYBuLLH0xvGfAgOgt67u4zX1xl7t9FupST1qhbTQ8f7b99sLnbQX+zDeg/eBFMx8SmIKy3Fn8gOB/RZHjwtZGO/o5it8BFGUKeBfWoStdEJMDiEPtgaddQKK56JkTRN2WTBbURdMs2uiy1sRz8HmfjJ1MO/CTUAKgW3veeAzlYv7zQK2Dk+0kqy/WxWJK0FntIrSLi/Lz+Vm8gKP1+wqZ7NASSF1PeOD7Ew5pCT3im2JuvHN1eLN2vkatocKBnQ7aPnLKiom2FLDUhOenm/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L96Fym9Aw1e0JKU5xfuwV3taU7LwRkH/gZNb67lFJuM=;
 b=NQ0uJXUgl78hsiTtH0D2ZYLFEbYB0jFncg4BITofwYEDwLaG7dYrBG3oObE0QxpOd9d85FFld5djOQtFtHTdkjaO6oJQSG5lFJrLuTMUQRWmGaPO0tMi9I5LLYEeFCu21BbMk4zfdBv1b9aWxIh4/YzMPOIHis66bKmx2ZLjkdI=
Received: from MN2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:208:e8::31)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 04:45:51 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::51) by MN2PR20CA0018.outlook.office365.com
 (2603:10b6:208:e8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Mon, 23 Sep 2024 04:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 04:45:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 23:45:48 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 22 Sep 2024 23:45:45 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI
Date: Mon, 23 Sep 2024 10:15:43 +0530
Message-ID: <20240923044543.2222-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0978ab1a-6c17-491e-8f7d-08dcdb8a9954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8feBS05lO8OIZUH+ZL3Ax/yBPNe7EWgWKZFfz47snVUlrPC7AOgHTsxCnKuk?=
 =?us-ascii?Q?CEG2ChAIq/qF9MbPtgQhQWjcLwIyDIxi5kdZ1B3yWEIbMSDC5TjN54DBA+Li?=
 =?us-ascii?Q?RQFhWQjV6o/3f7DJxir+qv6DXLQZdWkl6CEB3p0xLLbrWwVNDcaIgESsKZNz?=
 =?us-ascii?Q?b2ZJHKM0xr3ELcUj9k+E8zQy5bbN+OS4oqwtZH5onoW0MsWHZCDOa/XFm9N8?=
 =?us-ascii?Q?IrXdwf74Ff5KKfug4SJU3xHIz7Gx5TewTvqu+aSs3xdQuQQCNFIO3c6Aw5DN?=
 =?us-ascii?Q?fLQhQPaezWwC+4OYTnOHDXFb+eQhfo5NWJYWkDZv/SYabcMWUkGezDC0gAry?=
 =?us-ascii?Q?fOuNF2CJ7oNteSBUn55fcGM+k7q4MvL3HgUAL2HZkmRvxZvnPGVwRb5uv9lU?=
 =?us-ascii?Q?/2ihvUeMhW7fMmOg936BZvguwlrRRqK0S4DoIi2B7igAafIDBTQ/ex8tBG1Z?=
 =?us-ascii?Q?XQUOrszdV8/uNJlckTFNP/RfFOv4TjdVSCqGf7pUahOlP7zAjNVW4fYbfXSb?=
 =?us-ascii?Q?m7myEwVkGu0y2tdfslclqGT7TAL7T77PmlzIaGWaaPi8FnpNfdTzvGeqs6ou?=
 =?us-ascii?Q?n/c6/8M5w5LIom90S9i4BXBxb9B1EBE1K8OoaxdQ0kvUx7BW7Cj9xulocjUu?=
 =?us-ascii?Q?ShGTiYdKzz7MRtyzoKaiT/Sj8HQx0nbZsyfHVE4RVbnspGjlXlISKN17AFl3?=
 =?us-ascii?Q?i5oXlnYKFsjQiuQZK4dokp9ud7YIxfbuCIvn8Tli09zc5G8kUtXKE58ztVb+?=
 =?us-ascii?Q?SSgmEdiAjhh+cbtQwRpGyt/+mHAuoFcorIOCb1IZxMxliTpWDs9GjVZ+EpEP?=
 =?us-ascii?Q?YDvgGGLaFZWCIIFbVZqesVteWXbRDYb1ZYTHo1nywY8nxKgJ9gNfkoNx+6dp?=
 =?us-ascii?Q?xChq9N+ZRHzbpXNaT5QOEy2l1lQaBqRSDRS2OVeaJfUU7fqOQVdxsxlfpQvp?=
 =?us-ascii?Q?yu4h4/f9BXzefJDBgex3a3V0Q/rBKCaVd1s4Z1f0cyOB6tA/F0HYLivHmY4M?=
 =?us-ascii?Q?U/K578mfhgJFrTYW3AHu7ihFsN2zy+7DGWPYFRdL0rzq7GJQsayKYy0WMBos?=
 =?us-ascii?Q?JforW7c3aWeTotSiVVPQgD91+OR+4nicksiL6zWq1YiiGKABWEebRIcwE6qU?=
 =?us-ascii?Q?fUvS6W8O7KuhfeoQrVCpwzBMm0Ch5gRc7jO6N9bowiNiwfIbsyG24PL5zotf?=
 =?us-ascii?Q?Wrklr8tWDWTN9OZyIleUgSM4rlUz0tzlFjbjPY5sDswQcOqbXPGjuEYL3b+U?=
 =?us-ascii?Q?w/tOP2aByZNpHKOCfummIfepVk+V8meTVbifXTi15tEXsOxBwvHvqxxTpGYz?=
 =?us-ascii?Q?wCIt0NYfdv14Tca6HxlpY92ztk9iKeUThoLTdcnWofoAxhKwYdPECxhfkm9Q?=
 =?us-ascii?Q?+MRZEBUF0CX59e9KhnJvdAqDSVxl0pHxrWUkQN4A+eQifyDgFlHgFjbKlAEt?=
 =?us-ascii?Q?Gnn/BEYJ9SMr5dftNhZdOBu9QLwF0CJR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 04:45:50.3568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0978ab1a-6c17-491e-8f7d-08dcdb8a9954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237

Linear mode is only supported by the Zynq UltraScale QSPI controller,
so update the bindings to include two 'reg' properties only for the
Zynq UltraScale QSPI controller.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 .../bindings/spi/spi-zynqmp-qspi.yaml          | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index e5199b109dad..2f1fca137cd3 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -12,15 +12,27 @@ maintainers:
 allOf:
   - $ref: spi-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,zynqmp-qspi-1.0
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
 properties:
   compatible:
     enum:
       - xlnx,versal-qspi-1.0
       - xlnx,zynqmp-qspi-1.0
 
-  reg:
-    maxItems: 2
-
   interrupts:
     maxItems: 1
 
-- 
2.34.1


