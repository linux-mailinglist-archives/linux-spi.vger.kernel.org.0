Return-Path: <linux-spi+bounces-8306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D0AC4875
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 08:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F43B298C
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B251DF749;
	Tue, 27 May 2025 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KXuSTbIK"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D81FDA;
	Tue, 27 May 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748327691; cv=fail; b=YgSJP7DB6jxR/emKFZzCZc9Do6PUovX0wPyfH8u3E5DZZaQHZtjbZTw1PVnjOYl7xLfJKvodb2OdlYKuF/GEGOYiOlTiEVeoGku57556M/U/9+mLH0kps3XCe+zK4QxxrnKSR5vNMq/Cg9+ZbgIMIg83LSSx/oeu41wlDq+qFyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748327691; c=relaxed/simple;
	bh=+qJcdWKjQHOAYPDWLkSPZauKReaJXn0Cu2gPJPW6TVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPF8m5KFLbGIspJ45v3Yl8hSI+5LBnGG2QoiV2eFc5XgkhDjYStJar8tq9NIpQ+t7Vvp0Mz6ZmuftdE2HTwbHYhrs5zaoZ6iSs8N0xy6LUo9bYUTfRtmzn4kNa2aL+FWMQC4QixAEjx+Fyv1Dw+SpkO+Am5UrcKjMOTSsi4zANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KXuSTbIK; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPzGqzLOXjX9IBWWn7FGpzWE/G4IhvXsNctmNSYJfSqokHbDc5dfGFWb97WL1o5Cp4gS2DUok0bqIaauS9xgpZ1qzGXkjlxEb+fNKZyeWxuW4tScqe7l55BUoqrGqTNWUXyXm5i+J5miDMQKEg3n81DfZ/9cdtF8dWtQTRNpYjO7+bpCBx9+2GSCqB4wLSfhaw7t6tMAXqzUmm5/XMKajLmJwuQID0+Ri4Nf3qWRx3M68Hv6sK7aLxJFuUMhzh1afsw4XEIoP5rI82mT1lXOZiUPpzbsxZ4oanXL9otRkildT4IeeKV3mjj1axvNGQ1CvQ0eggdBZbHSTbD9YpiP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImBGRzZf4IoThCUIB0kjPtK+OUtd0ttYEnWD1aHlSU8=;
 b=JIa3Wpef8e4iUdudrMyt3nDtFtFTIoP9rgUGBfqt4hmutvVv9s80fJlPOKpLuNJWGn68/el4bOcZkWsQHVLA8H2RCufJ/peh2PW+VnDjtiIriGqKQtCjG+K50IZNTfNJJaG3mB3KwjEFiRtLJ3iy2NeFPieUEPAFqyAAYKy5eXPiKiOCBJzoXr0HSNGAm2EoLsBtno3VE7eDQoQJBqCRA0IALzHU1UfysSr84lsJEJLmc1BBvRaFWCR4tdX/XWDTst/aSs0Rh9i5KDqfVNX6lBva0ZTVRqSQVxFTcKTDXph7Blm73fdPy96BuPtKOsecfs+nwfo261U2+rXxFQASSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImBGRzZf4IoThCUIB0kjPtK+OUtd0ttYEnWD1aHlSU8=;
 b=KXuSTbIKC18YjXxgroiSznTx+1WHi6lLLl5J4kxlN9xDCH7dXBh4uCmSh7aV8Tmz2HuZsi5XjR2icYVvSXCMizIw5j/Xzcom5Y2glHTJ5v8/RvB3J1kfWIU+KcX3NxsSehP6k93lpsY7uAIKp4t/uT8O1pxF/2pm7X+XYwInOQM=
Received: from MW4PR03CA0299.namprd03.prod.outlook.com (2603:10b6:303:b5::34)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 06:34:45 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::33) by MW4PR03CA0299.outlook.office365.com
 (2603:10b6:303:b5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 06:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 06:34:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 01:34:43 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 01:34:40 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v3] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller
Date: Tue, 27 May 2025 12:04:38 +0530
Message-ID: <20250527063438.504207-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3ea830-c91f-4d79-f387-08dd9ce89218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YmzrAoDWZsfSslZcoaREkj5l9BZ/z/+TVzzgioRlO1aXHt2U/K1yEHKyg5c?=
 =?us-ascii?Q?+LpUDhab4C4Si+e2m7huM1pUv8j96SwlVHSZjtlptSZwc4GCoX+FUS1u3veC?=
 =?us-ascii?Q?z6hNbkTZjg/iL9J76q8+Aydd8QFvsENPr0wluwWWwAZ08EfxB7ZFbKHgs9IN?=
 =?us-ascii?Q?EB0EkV0kn3OdctavlqYo2d1ZokwkPsnKou6IUr2bGZgTp9n4fuChWIyqWwuf?=
 =?us-ascii?Q?74paTfNsMRgQ07jEg5q+5C1h/POHFFRmalFDSwuDhIOOFQge2ArJGU3d/Tc8?=
 =?us-ascii?Q?mKhIh76sBcVO82St3x8BoOJbCgnNZQzCdEtyVFGjL5LLlrMk8w4SOVKTiSdI?=
 =?us-ascii?Q?xj8nQpLFuTsQuz/o68Kg32/QdFQCCpqBjtMm+lHRuCT8c3RSaPKqXz6H0sED?=
 =?us-ascii?Q?5dX38H0AHJIjtFspmKwU5q5KobbDOIe55wrllyFnmOgY/pkeLkUjNs05+VC0?=
 =?us-ascii?Q?kHXsUgamxgw1sO6cbtc2tIzn9OLgOzk0kjavG9U3DLAMFHudtfYcfd7+Qryt?=
 =?us-ascii?Q?eS060fAwR0fnh9SKopDoKUxr+AS7wZ1CBOpgvyzxHsad75pvOLqIRMXJ3ANN?=
 =?us-ascii?Q?oCf65VCIuf9kdEV8c0snvyAv3njqdB9n1xAr+nUsFjzYl4DtIKO/ccy2xfPJ?=
 =?us-ascii?Q?yfEAcIhstBMlQy1fTaI/xnQos/RyiZyxB1hw/a/XnezqFfHndtJQ+bIZyVpb?=
 =?us-ascii?Q?5Ujl4IIvQpNzcNvalLedpegUMvNhukBDeXW2oeV/Qe+rhoyn+KFbzej3oQk7?=
 =?us-ascii?Q?SYxAfhN3yX1kNWSNVXDJckU941KdRSfDXCWIH1rnNgDQx8iGNpv1htRZFhuI?=
 =?us-ascii?Q?gIF7mGm90VTvi6tfIZIeeGx+77xn/gHoDtaUpl0fVfm+R6WxmtFISwrrV6Qy?=
 =?us-ascii?Q?DAgNRh0S1fytkW5uPQCbkeERGACNfiiG/h5rmTlbsGzy8M9Ss4sLw3K6/s+n?=
 =?us-ascii?Q?0xwpWHpXQS7ltj/OCCJ0o5fE8+apbZN8z7N1ck8XNnG2GQwoPXCkUjVDo8L5?=
 =?us-ascii?Q?Svpk9yHZMVxn9EVCKvxq2w3KBCieKX3uUT+H01CuvU7WQROLdeXoQDMXvyUl?=
 =?us-ascii?Q?LgwtHi7igLXzhVQkI0snpjxV3xk1+7+lJ+sPzJ4asKQbflfX4Xheg+olXNdM?=
 =?us-ascii?Q?WwKGxUwafG8kHWwYEf1s9c6EFfVNKX4pNX+wUtUH5tF4DHomJ1iYHAxd8aSm?=
 =?us-ascii?Q?UCDKihdKQnairppYBLGmVqodsogyNPPUJ65n7FHOx+sdHvhxqGOlXoUvblTP?=
 =?us-ascii?Q?nBMy3Y0QBXxTyTYwxM3q0YB2U9iYsZxKmVGjJVHyKrV6Oel6Y0k5T9c1QbLv?=
 =?us-ascii?Q?pjrgNWte1Je5f2juJhywssaCn74cPHxeehQkn1W6EU7NE9+THX9RSO6aAuIt?=
 =?us-ascii?Q?I78QdZh54/I8yCx7pYthZTsf1imAdtguAFdSrKczf+UyXKqGNQg7GeGhoksD?=
 =?us-ascii?Q?07BWOudaww48CQ3xJ1MsOgLvfHBT/fU+qBSrU6pgjQUSoEMZ7DX0DsIfmEBz?=
 =?us-ascii?Q?KW6ZbFCNQ993ocgd0d6iZM0G4eBfatLWDxrG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 06:34:45.2391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3ea830-c91f-4d79-f387-08dd9ce89218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
one reset entry. To reflect this, the maxItems for "resets" and
"reset-names" has been set to 1 for AMD Versal SoCs.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: mtd/next

Changes in v3:
 - Updates to 'resets' and 'reset-names' removed for non-Versal platforms.
 - Updated patch description.
 - Added Mark's Acked-by tag.

Changes in v2:
 - Removed "resets" & "reset-names" from required properties.
 - To address review comments, removed "maxItems" from "reset-names".
 ---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index d48ecd6cd5ad..81e8342db4bc 100644
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
-- 
2.34.1


