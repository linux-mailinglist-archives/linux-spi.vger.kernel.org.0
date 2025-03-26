Return-Path: <linux-spi+bounces-7312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98DA715E9
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878A77A0FE7
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D031DD539;
	Wed, 26 Mar 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aadnlcle"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D531DC9A8;
	Wed, 26 Mar 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989066; cv=fail; b=qQZS7Xfb8qmSKela+RjAq6XLwNFn68RUwsszatz5V/xISh209dalVT1Hzwj5gATgd4mOB+IRuy0KoPP/7upMb8NhQ0y8hz1C2OY5GmrGzaRHMGUGlbLOFb1DV1jO2YVx4EQyGBSO3EE0N/8iIrzU8fPMZD24lhPIQHlghcqw99E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989066; c=relaxed/simple;
	bh=WSdca+p089Yrp9XYmWyMEeBFwBBgL/spJKpfnQjveQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VgUFIGVPaZjr061vfatqDivK9g3c5y3Dy9Ypl/6sGmZZeSkvRIuU68ObShNZNHBC48gLvIOfv4ftJc7dXRWzxv0aQt7mjpsErUXz/PVX2LzoDjMDxykQ4X9Fk0D4Zar2PQvY/SSo41KffXjBR9LoZxr7Qw3BVylItxr26989IJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aadnlcle; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbxchlAncjJtHicpFlOL4uK/kWa7F4pfbdTgKJVA24rMi/qkNwGUAOUxaQz7qkfewXSgz9SvDRSduV82DfJU6l/F9L//cfh2fzMosp4Z7JiVi/CKFDqoyBw5OojRtf8z2MkSL4KJqiEtiDIDZPOErn/uJs93i8o4H0hDx0JTm/GYjBM6Odlprc69ASfa/juZ9ez2VNL9z4OkfnrLCOQmC3FKabpAufpUSr9dQskJgBcaKIFKeQtm3CXXAY9SpmlNtGVr0iR6A45Qs8xGGXBV+EDJ+5t+9hJsI7ZfsalY8KSzfEuXqfG4pTQpsUz4xfvW9k1vJpNG1GwppD85PIYygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJLiPXkOVFfRboqmTGr+OemzQK93tG0l1uRxwySse50=;
 b=NwnyiC6SOTwHLeT1nQyUlhC2lY5vGZq4H0NK5Mjfw7XJClNYoY9WVEsrDZOFrozvGNDQTt9H3Y9MFfSsoFNCWvqEXX8EIAMZns1qd0fMUiDLG6171NMmrng1tjeAsjiZupzqmLuhNG1kgNtbSI5BYKz+ZFwlI54pVzHZkq5DhsjI5NtjZelrNYLpo/lBrDVLlNHI3682iZpBk1cmX/6Lsk4geFw4J7ssFwqPJHvoHLWWiddMag1qPBHdTFA0sp6tfEhML6WM0oErEWoHJ8mC6p1nM18PM2F8DYJF/4tj6AZgGkpg1kX1msSuZwQOAvW9SnI7pdtUeOuU+JYQcnVd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJLiPXkOVFfRboqmTGr+OemzQK93tG0l1uRxwySse50=;
 b=aadnlcleXbbCL77z344eW0wTwdRLW+4XAti6IwoYOBabS8My+Keb4/kwZTvftvnFbyi2UhKu+ldieUqCEjqdJAaXJRNX8QFt2at5N7OTS6unQGZ7eygSEH3JQP/QlGIM4qqQLqaAN3lTnFJ5hr+bDmV3Lcml4xEbzAeuqTiNA4I=
Received: from DS2PEPF00004551.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::517) by PH8PR12MB6937.namprd12.prod.outlook.com
 (2603:10b6:510:1bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:37:38 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:92f::1004:0:12) by DS2PEPF00004551.outlook.office365.com
 (2603:10b6:f:fc00::517) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.9 via Frontend Transport; Wed,
 26 Mar 2025 11:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 11:37:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 06:37:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 06:37:35 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 06:37:33 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller
Date: Wed, 26 Mar 2025 17:07:31 +0530
Message-ID: <20250326113731.1657593-1-amit.kumar-mahapatra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e71723d-5a77-4a6c-7bf3-08dd6c5a9bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blCAOHDzqDAYy3iWJSAdLhy2oyTfrjr9SaSep7G4kWN8eZyRg8NpfF2K2JMD?=
 =?us-ascii?Q?hxLq9MQiv/tqN1+vSp3wq8UUUiVi/zPd1c9H01pcis55Th3UXD59Ei5NtLQm?=
 =?us-ascii?Q?W2AjPSWkYBFaG7BE7iODQRDEyRND6NiTpfN76aR0eAm/8OjOtLSMspzkePOm?=
 =?us-ascii?Q?dXF6pD8Hrh/Irc3mhxyMDJfwQEYkCjPARccyFFi6ubaq3nLSyNb/RHgUj9DD?=
 =?us-ascii?Q?APnRn/n38VMqpZMygybDaYbOTxdRh92+NMgVlD+YowDz8a/D8oLdfET0p5PS?=
 =?us-ascii?Q?ufhDrjpfqMWU21ClgHSLXtUp6hcQanqOh7cQ3PDf5tPv7VVHfDk2kArT2j+c?=
 =?us-ascii?Q?PCOBKGXasYPDn6reA+oJnJniJRGw68FN7l8vQWSql+xJkLjgjwBamRzR5VM2?=
 =?us-ascii?Q?5Tf2m5FhkYkGEk4o3p0r44HdTviBOgK4pxfHoQUy1a3uWbeeRP0UtcwM/nh+?=
 =?us-ascii?Q?zMK0j4f5W11rlv4p85N/zmZeGklDBI3lvhwO2yBrlp0KQctaTrnEP8Wudg2g?=
 =?us-ascii?Q?ZxfXHkdwhFVSt3hcE3svHa0l1orReLYQFPAh5lKIqUAlH8NO+VA2OTkckZ5w?=
 =?us-ascii?Q?z0Q9YMofdZLMTYo73MDg8ZaRyRAFoGrZf6SNg7NJl9qyU/pDtqELY6JUD9lm?=
 =?us-ascii?Q?1+TOGy7Y38SH5sTGYBDZIKhKmG6qDXD1BZlvNHUS/DFgC7fzzrf1vDwsHVbZ?=
 =?us-ascii?Q?cL3OObOGwAvs5V51AHj105WYGkqzAA/qz+puuqyR7IEHkL0M4VzcGxW+4BFg?=
 =?us-ascii?Q?ii14cuwnwvardM0kq/Ri/TaXzMdtZU4SK9N5O9eZJ5DvSFvJOD/E/l5bs3Mj?=
 =?us-ascii?Q?enDmqd0reb+km/bWAbSFlH2jzxr4fY9WWivzydXtvhA8CY6n95b6DKdkLPat?=
 =?us-ascii?Q?xHZCpn+tc3bNaXkNUocIupxlPQNOSicYf7cPqTYUvx+q1cvKtveDbdi1V3D4?=
 =?us-ascii?Q?njSlYznU8Q0qW43U/EYWuC4GSwgtM3nLZsSZXbRLJ80dmps1R+xzQisbpZ0S?=
 =?us-ascii?Q?EBHDB7B9HzoROerqxVvSopnu/I2xi70Dj5m1YW18vg8KsO1CNG3j7bP2pjOr?=
 =?us-ascii?Q?jtDr1mxh1x+KX/xi7eq73vKf9HIIdo0Taix3BXIo9x81835B2KkB1yhg018q?=
 =?us-ascii?Q?c6SyWg8+LQsuPsPuKQFOdSQq3tgdyFWkZ1MjMOU3+v55t8uVeC44LG2FLl9D?=
 =?us-ascii?Q?PtyeiVe3MG9oskIjHdSnut6naoSlBmgXlK4kmlwrf+jCDkXRzzrXoRm8en+L?=
 =?us-ascii?Q?PnbtnSg2uJr1lu02SUbL6g0A1lhKZsFkqFGxkA3Q1HjzXFi+Zu5YhW02eXo2?=
 =?us-ascii?Q?no0NjgNFddKtrv0Hd650S46LsRr1eAomGYrsWEdrOjXVDJ9O7hpdMe5Ukoao?=
 =?us-ascii?Q?d1VTQ37mdCj/nVGTVNFpT9qKlK4RxdUsdCE/4OHnc2bsZc/u2bV7AW35Kkox?=
 =?us-ascii?Q?lvafnCZ3L0mJvtXzQVCrh4Bv7qYBUNiBO+L/1GmSM1X5msUmrkxDdNtE6r4K?=
 =?us-ascii?Q?d7Q/A/vrvg+4yyw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 11:37:37.4197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e71723d-5a77-4a6c-7bf3-08dd6c5a9bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
one reset entry. To reflect this, the maxItems for "resets" and
"reset-names" has been set to 1 for AMD Versal SoCs, and the minItems for
these properties has also been updated to 1. Additionally, these properties
have been added to the required property list for Versal SoCs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: mtd/next
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index d48ecd6cd5ad..cc94c59280a1 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -17,8 +17,18 @@ allOf:
           contains:
             const: xlnx,versal-ospi-1.0
     then:
+      properties:
+        resets:
+          maxItems: 1
+
+        reset-names:
+          maxItems: 1
+          items:
+            enum: [ qspi ]
       required:
         - power-domains
+        - resets
+        - reset-names
   - if:
       properties:
         compatible:
@@ -132,11 +142,11 @@ properties:
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


