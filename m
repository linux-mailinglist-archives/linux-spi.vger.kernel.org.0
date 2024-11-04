Return-Path: <linux-spi+bounces-5602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D79BAC7B
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 07:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77F41F22132
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 06:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068A1791EB;
	Mon,  4 Nov 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HCG/uGsw"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805A17583;
	Mon,  4 Nov 2024 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701462; cv=fail; b=iXj+JMP/prMJsplTtmyV9cpQC2pKr8p/LZ6K9RDQGNM/fyS4HS/nh6R53QMAZ08nDBeaYpx4DOt/Q0JUcAjHdj5T94MCgzETFtolzhI0YZ/GVhaEjPjbpqKbluyrlHjcoQYF0lL4gG+jgXDPTSZk0vH01FFoTUnwX1bu2mLF07I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701462; c=relaxed/simple;
	bh=FQKpwQVImZ+NXQYCfcqlNEOU2bYbZpz0fKzU8zeTX5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qop89TXNSHDujTpYR6322i1U4+mB79z43zklrMG6DZTxZnK2VGhcLI1HLhij4UuQ8q9alQ5sfhr9w1hnY1Xo4DcFkIGiFMKdNJgk+YzSrVJDdIMrfrM1xmTjKo1SCJB0xSj2gQZHLk+8Rgm/CE+p9VamRXwZxQsIRhb8kFr5LPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HCG/uGsw; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq2G+3vC2ZOERJnIes4AfDfaJTb33nmRy6GhuepZkAxoBG1p27gqSwAVQ88lMX4qFk/B+O0dlBl3RomyzmLkjrNP4VLVG22ESGrp+Jt8+BMFgkxrGpQJ0ECPF1Cjplaxn2hCL8xE3lYuGQGhH7KJNPmHHY0CwCidCTksVcC3GNohICwp0KzLIcgLO4J5aho0IS9I1tUqC583huxzs/oYtqSDNGrRs9HqItwLn287+FUhVmMwsJW0oxMJlfZxMBkdldDjgLNXwK4xE1rUTIK6F4J8B83K+c1Kl71rO3hOzs3fucmGUN41dGsGQUOPhoSoH8FCRjKX9OY39tcD43ohoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36T3lrvrvcP3FmqzvU5AYse+nSNu8ozkVickEPcgZY4=;
 b=D/YI5XVR/D7lo0x3lPvN876r7e/HN4EDvA3oXkp4n1w1CFuZPdQzbfFBGtDW3TOeuf3bSfanT6PTlYC9OlyFsIUnORJKc3aYQNqm7P/3a55fXBxDQkdcj+CvW4sxSi1PxCa2bfmkUdWGsTphDrpeT5LCm+z9rZzU24M3D04P1oKAHILHVc0J2EkhKHERKl5S6yRDpGsF7eaGl41QbAbvWqxPSxNMM69066QEVUK6eHeo1WwRIGm3BIlqgWMmCP1RteJHzRhvseEZzlfZ+od4fhTA2ir0Lqi59X+ScNnuQ8w1QIeZ/jw36hf+qlNcdqtd6ttS8nLUrCvMxt2/jV1BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36T3lrvrvcP3FmqzvU5AYse+nSNu8ozkVickEPcgZY4=;
 b=HCG/uGswNQ4Tb3h/8PeM0TR9xYqKzeEvfTpWhngyRFZT/D8SUSo4Ybg7fZIsXJTE91q7ft4gz7Aq8bAJ2OpXiWLohLExnARtBfv0LlB7/J9ZaqotoCn50/lrUOiwnEw7GzJfyYAlggGKppPjUAdDixQ4GSqAYpeHRYsgtpPtQJU=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.25; Mon, 4 Nov 2024 06:24:16 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::dc) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 06:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 06:24:16 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 00:24:13 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH] MAINTAINERS: update AMD SPI maintainer
Date: Mon, 4 Nov 2024 11:53:27 +0530
Message-ID: <20241104062327.1228521-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: da21283a-f5e9-477d-0f65-08dcfc994ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cy9+4EKCte6S5TE8BXzjrg6+dW33FAb07DDzM3EpKEjG46Q6WJCN/d4dLnHa?=
 =?us-ascii?Q?EAXSxD58WLUnHYxR9FTDrMiF3Sh5yMYrWmYreqCwq210DhX/juG6oI5gmRWO?=
 =?us-ascii?Q?qPvPylWP0VwQptxG7R4dRUVmGs9QwDO60867emA/0bWDDWJmrFXfFj0Nxi4p?=
 =?us-ascii?Q?bJH205Qa9crh5uOb2efOJSx5c0RIL3DTDqh/WAGaYn8OiBZ9DwKJwSrP3dk0?=
 =?us-ascii?Q?4EDluagpf/X52/NtBLgvy3ieXcsmrfVELepZK3kXQyhZqqeoZSrkBcvfZ8WB?=
 =?us-ascii?Q?UdIYqkVeT+3pUZe9LPnC08NFbhf+6UwMZ/OW1+r5n1UFg/e46sFaFVDqlE2a?=
 =?us-ascii?Q?3Zz2zKDyet4j9CmvRWYi9Zppc+WbgNz3dlEFDvSyjHPof2rI6KZz/O+pjvuy?=
 =?us-ascii?Q?vlyLQf/r5yblRglZrUKfjDSzwJhuj72JPQY/d4pRhJEBzKtKMCM11y82PVHN?=
 =?us-ascii?Q?EPHUBmLjoTdG7TxKD3vXuEcSGFkY7i9v8PpkOI9NkdGpoA6LRW6ex4QBkyX0?=
 =?us-ascii?Q?vtWIV0mAYCJHpwMnZqbjKSw0HzLdAsls7ewpqJuTU9pKy41OfPfR86vx5XS2?=
 =?us-ascii?Q?nmc5L2fcFig/HB+hO+iQgiI6bPlwA4ecovehSoirUT1gezGX65VWSKtZOcY4?=
 =?us-ascii?Q?Biq2Nn3Bof/M8UuZPAuV5JQC97oI7zs+PPFaMlZvo60B5OzJFGFLjMXWdPQn?=
 =?us-ascii?Q?45xzZW9Zd5hb8KT9CdrzHpkWkEzel7UNG4rDJX01onyyuyUYwJhCPvYSVqSV?=
 =?us-ascii?Q?muoMd4SgiG/IVDBGbH6WNK3LbAnTBU6lMLbLjHRtzosKrqL6XVa8gSWqjMP/?=
 =?us-ascii?Q?rxlgIiYfEtc8Yz1X7NdD8wbjMOAXSEJOHwJhS+IgXVPOsY2mM51TrHyvT2i7?=
 =?us-ascii?Q?wR6y9ZHdEPBbAfmYHAkJfSXKGXD+Ut6cqH+nPOBxAaaTSP+s5k4UlJNqN9N7?=
 =?us-ascii?Q?waLnJ4AgbT3CgvBIO+iExhP0R+D58eqsd8059czCin38R02x+tM+3XR8dQzg?=
 =?us-ascii?Q?k9P3MQgsX13948hqd0B3HnFFE/OcDHwkwjSlwOnbORcboWll+wnPlvgZbEeG?=
 =?us-ascii?Q?1KLrCc2cEnmANczkAjzPzeAbboI7E+IWT/GeFc/YY7C7/A6rw0rj7kZcWcY5?=
 =?us-ascii?Q?QUdT9afRgFqmtq7hSG/+O8TyNYKPiMg1rZ18uOUX4rL5lHXxPqjMOa249JzW?=
 =?us-ascii?Q?tE7OLjzHpGLTYyrCfEfMy1dH5x7m/kYWojVRJNJ6ZNAEOvLUTIVOSoW5tVkr?=
 =?us-ascii?Q?RN1/A4XZ54Pp38eyFH4tqDVGRQVfQlF6JgLoYsfebcH3rV6S/swCNk6vKijN?=
 =?us-ascii?Q?lhp26eu3pmlWc99ufIvZdgYTVFaiaLd1V/OwrLtjnpojjSZwB5nhoHrFjTOm?=
 =?us-ascii?Q?RDmQlYTUhCdPutfZEQZwU+JhoNomCJaDfwYRKcdGZ2IEjw8n2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 06:24:16.0659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da21283a-f5e9-477d-0f65-08dcfc994ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

'Sanjay R Mehta' is no longer with AMD, I will take over as the
maintainer of the AMD SPI driver moving forward.

I request to be added as the new maintainer.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6880a8fac74c..43ca83e67400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1174,8 +1174,9 @@ F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
 AMD SPI DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
-S:	Maintained
+M:	Raju Rangoju <Raju.Rangoju@amd.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
 F:	drivers/spi/spi-amd.c
 
 AMD XGBE DRIVER
-- 
2.34.1


