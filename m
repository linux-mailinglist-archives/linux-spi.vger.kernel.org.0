Return-Path: <linux-spi+bounces-8148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585FAAB99B3
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB13F16D2B8
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C623184F;
	Fri, 16 May 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F+Nbhxpd"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1E231839;
	Fri, 16 May 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390047; cv=fail; b=JKnPYl6UMNbhPbV47DgIc6jSklGbH012A3N4r0PxYYohz5F+MlwoKXKKZREfmHXzqqpAZUWsAsw2DQ62MP5Al5AKnkcWTSYompu4O4bBPuHPjFqW5EBK5vpGbhhLGcHpQgwOP3trd55IB/OTTJF+brYUU/t6712dt4mVxiXl9kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390047; c=relaxed/simple;
	bh=xelfLMhUyZehhaN47l2cpJksqTp0C+nA4NiEJNGrZWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kwr2kUq54NX7O604bwDeee3EuScFcFhXM43GMuwjUg8AQ+Zm02ObpDPOIwzlVkoEv56rpudESjtk+DJKv8SVxygJzTJjRNLFtPeC9DaeT0dyWMBmjMAJo7iNL4Zyl+Fy8gTj2pXpYTxuS/2eCTcrwmXS94BIVZJ1F3Qb4v0DTG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F+Nbhxpd; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFTr1b9VDP5N2yJ6BtsUN+4RO+GfPnGY88nYLp+8FJ6bM6lDMUT891fO7ocw/Z7snVzmoyVk6lpEvLxC2YdU1TpQMOU+X3HU/GKdBl+gWeV7t7fNC8WUbxYElqMu7Qw85HuY2zxaVq2MtEKgqn/7dFR26qfLx7xV69KzKoXLGLY+AUEeW49esV8hwIhIrY0hnZM4GBEDfN8P2kZz7jPC76LqEyywDKZbX3QqD9zVLWf/bPIlUd+DMyodr3PUYILjgf+v4Lwaw4RB8PTcYlq9jMvX4F82MmKQfNd/1nifHVthZL5v+qQ51gxupq8E43zrvcFF4+TFQideTpBIhllaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18x7KOa9ly6xOj9jGca/Gkvs3jquJWqeO9oWl41z358=;
 b=JM4BY0Pls/3BJduHbJOJc+HuXZv9VdRQuYJnzmPhidGhUunICNmaLdUSjuB84gf3RpCFISX7STEg5FAsVTU5YRZlkgRL1agpgtRgqFMRM6Yhp/CykRvAfcttE2VGOBVCHkeYH7wdxvG/q+BCSb22uZ1ZpeMONvUIgPe30CJLs1UIm7q48rHusYlsL8nlTJgHt+7OnNZJ5UiERi1/omkM4U5RrQ6HVRWKCw1iDhpP+RhJr1B0dIjMFdbTvIyBCMnzJvqYQy/2hmcfX/Oc+dPxi25v6YbiXgdpXpUFMxM/9FnStA+TrpY2iSWnDslRtvgwWrvXu2pm4lKjfPTfn3KnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18x7KOa9ly6xOj9jGca/Gkvs3jquJWqeO9oWl41z358=;
 b=F+Nbhxpdbj0oqCbsTJjSqwaK6bVjjIzp10f+lXGYQ/bgV3/OdepHgLTmAzk8a6Q+s3hfH4evKXZTp4OEIhGkfyt4w4I5V1iDfHu2gdYpaHEpyXBmr7HmG0InyymEFxISJ0mZebBkeYCX1PDNDc7GFVxseScxjqP3NG9VihTeQEI=
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 10:07:23 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::71) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Fri,
 16 May 2025 10:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:07:23 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:07:21 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 0/3] spi: spi_amd: Add DMA write and Kconfig changes
Date: Fri, 16 May 2025 15:36:55 +0530
Message-ID: <20250516100658.585654-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaa7011-65e4-4ae0-2548-08dd9461740b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pAOXUCdTOqztQAsQlBx2U9IHxLgfZE5K5gle1Zcb3z/4WPIMm+FiDv2LIvUi?=
 =?us-ascii?Q?HBwfnw49NoZVruYaQuOfARldnr5/cLpGPqSez7NAQXnF6WdyZX16d9dPb/fe?=
 =?us-ascii?Q?9M2o0QATuuenVGpAhHCxwMJ3Mu979A9qR2FpglfZoR6H16Wb7xZR9pLH3dBS?=
 =?us-ascii?Q?zytjYYYfmWF7Kj4xH9GGKafSJPMgpzVO2SbtHUtpC0NOYQHH7BNzyI2g3VCS?=
 =?us-ascii?Q?5eoRWt8HpkqYYzmrb+KfuL/E6beumPDU+Wi2aWSfkuhRUStnMoE59d8swt+5?=
 =?us-ascii?Q?qbvVk/D3+O8IlwXhw3c5lh83X5Sq+wF8t9RKaU7vTaPrB7yySFdTc/PGb7ae?=
 =?us-ascii?Q?uMUBF70l2/kTx8qIjSAD+NkU+MGnjZOrzcVdjLzKpp3+JZeF58n48C2mFPJ0?=
 =?us-ascii?Q?0iZjqGs14V+/Cnds/PInGK/GhhiQeQz5YnNsjXjYOFawSGVmeuDOX91NKyHV?=
 =?us-ascii?Q?zxoZIgZyitfKmGI/bno88PPhW6SAI9TMdQ12bsKYl8P0l7HbB8dKvOBRR7mm?=
 =?us-ascii?Q?vl+239ntkaHEqj0jipLDzB1qz6HYEwpJJx4FJ1wEVymjGBjeKdAopI/KCVeY?=
 =?us-ascii?Q?UcvNaplhSKEAHdYQHyzKS89TfhZfFNyEZ5dOs44HYgXn5srnT00cTEgZ08u7?=
 =?us-ascii?Q?75t8iH+bzaD2ZL99i70r3GQn/77OZACOJ4SVjaZR0VSBUBG7KznRdtntKzpb?=
 =?us-ascii?Q?nzYYHvsTS6y09Frc2c+PUQ9lk1yqpuZkSdwL9kcSTA10KsY/C82M9sE9bLUF?=
 =?us-ascii?Q?wTN1JGQWSLLoIIe3fUnTQzFtyyHhsEOhw5yWfXrkRNzwjuHIyDInHAfwQCzz?=
 =?us-ascii?Q?JQuiBZlaDJg0w8syujDlcfyESl3LsGjBUCazFoWGibg4lMpCz9bKdG8zbl5f?=
 =?us-ascii?Q?fEWwrKYE8qiY0ulVkIjK/HsZkEus7zoGs5JPwLf/fuiZz1EF4/azjICsq5VD?=
 =?us-ascii?Q?wt4T++0AFSTPrphZV79ZM7jbZRSOjhl80dMRIc7GR+nDngGF2rZx3AYbblGx?=
 =?us-ascii?Q?/D7IqI3hmO4WmYDktoo5IItxPOWC+ivyFZgmtpuwXUajSU3t588/aFEDF3wh?=
 =?us-ascii?Q?/lLYv0qIneZwq9P8sdmuwNJUC7Kbuh2zLDTiIeegNwrVy3LmOa++pFWxCVAO?=
 =?us-ascii?Q?VqxJc9S//LCxUSqQXOr9LAndZlZigV0Er7XLf7n4p37oU/yi/IJWJdac4z/A?=
 =?us-ascii?Q?P1s7xDohDf73aOpQx4PrYwkoSpZ37txipTciz7KUojeBpfTBO3jM+GTa8tzs?=
 =?us-ascii?Q?UVN6Gltjmno0TO9/4nIqKmSmsYLNVi8yCzFpn68P/j539eJ6FAxw9Um1isWU?=
 =?us-ascii?Q?fU75swakasfdT9GU3pyecmuTDeiX+kVrzuh06eSbM6yHLoY1nhjbjz8ocIuB?=
 =?us-ascii?Q?TuqesgCIPO75Gdfl2ksoA+FtzSRzVMEIi7L/KEUVCDwvJtiiX+FFwsWyuIhW?=
 =?us-ascii?Q?TrLQaEEgwFDuxGo69ZMcZSTY4gYDVZHQzbeTWJUeZjOD6UJN3QDZHeoyT+2i?=
 =?us-ascii?Q?u07blROpL5X76zX5ZLX2HGRf3wvKsPnyKUmz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:07:23.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaa7011-65e4-4ae0-2548-08dd9461740b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

This series include following changes to spi_amd driver:
- Changes to replace read{q,b} functions with direct memory copy logic on
  DMA buffer.
- Support for HID2 DMA single mode basic write operation for the HID2
  SPI controller.
- Changes to add missing Kconfig dependencies.

v1->v2:
-------
- Add a new patch to replace read{q,b} functions on DMA buffer.
- Address the review comments by replacing write{q,b} functions
  with manual data copy on DMA buffer.
- Add a new patch to address missing Kconfig dependencies.

Raju Rangoju (3):
  spi: spi_amd: Remove read{q,b} usage on DMA buffer
  spi: spi_amd: Add HIDDMA basic write support
  spi: spi_amd: Update Kconfig dependencies

 drivers/spi/Kconfig   |   3 +-
 drivers/spi/spi-amd.c | 151 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 125 insertions(+), 29 deletions(-)

-- 
2.34.1


