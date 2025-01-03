Return-Path: <linux-spi+bounces-6208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D9A003FF
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D4C3A1E07
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EE13B293;
	Fri,  3 Jan 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frW3VCUK"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2129CA;
	Fri,  3 Jan 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884280; cv=fail; b=iYxZWmok8TLaZHF4DmeVQNoXbXbOiHdKEONP4UYXSMiIgDmRPt6QSFYPT+bnLOJ6e7SOLpcF+289NB9ibFn1pde/jAknNX2/kGEbr7E/bNlEkiCVcTx0h2FSR0BcTXbSLnUMfZHipiycOnH0t85kvCrZgEd0dpu3oxvrHu/4e8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884280; c=relaxed/simple;
	bh=HA2sOpk/hkZZ1dE6IrVYwh2jhouGDs3VYnxwdyDpUxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mh6TDMDqrURZQJQJPxMWJRz6TvqissbpceCjOlaZmK01r5ce1a8TNrd2y0NNfLUc+kyTcq+nc+ZhM28HdMUCsD9LPy17dwl8XHOzMmVYQDKOMRPU+UD7hh1chcZWPLw7EMa2+QvWopKGka+8SNRHwR9RvnaGUE+10GKyh5Z/F7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frW3VCUK; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq3huGBZVuHkZWK7u9RVNnf5qW12Vce83s4+wIa11laypxyGGmtyAUtDKP/7N1MEWugmZNOTSzz7yDN0o00TWRrdARoSn3+5/EdDLcHXP2a1oxaKlxUySps6q5H2M2f5FN+i2a7aGc5NKeGB1qOVVPGH8qT2ypXItXwLqyER6RE5thBY3gI503Fu3xqo2qieAwQIn7leJ+irQeNO8wj849GOe8OS2t9y7uVr8EAKdvXKyQEfJJHVECTXzoSJ7A4dzzwW6ffgh5CQS5c2f9QlpDD0YTBN4LbK/l74enfqWhfySoypJfH/s+W2OSA4cagsGkl+naAx0OBEu6O3Iza8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLGAWfLN4ybbNM4YBcJDJr0XIdu5utqjWL8TJGDeM1g=;
 b=s7L/CJw3GiAkXFfOP5uMlyXUJak261tHn/een792OgslOWWZs328ls2KD7aiu76sLcie129mdhivGs7lm3qzEiO5cm2DGIAy1Mwq4yRquUmE+9q+WdbwULSbnuoIOjsdGVYFboWgHBT+lcw3pulvU/5eEfTiz/Drcis+Gbnna1FAsGIZgufwV3PcsyxYF1TpoCHB9tAXp+pDKF3ZckawYUxfMJJTrRuYTMSfNG18g01qekiHEyQcXngg8BdUU+q5L/XT2sVBjEFrxz/WbT6JfUmrKcYAFQCFMZwtmhIXzAkgwYCXKPwTYB+JWBwsKFKInp4fvMBtaBqDsxSV2J0KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLGAWfLN4ybbNM4YBcJDJr0XIdu5utqjWL8TJGDeM1g=;
 b=frW3VCUK+JIxoqQKaIAa66nTX0f1DRUBtMIjz0XDNK8HIaVWmQRBEC6co43XxkfWEymV5yhy1ViOe6oQL9lB5e8kuwmyLp90UpWODbMecosKublkHnog6wyWLZ5HeZm5s5i6hKTkrWjHauea9l1eH2Gsn4rbg9A1jhi8IdBfye7rPyrO2Yum+PRrVB7fRoj/riFNU08Otxkx0h7pKvMMkSHZkKW6F0LUxgH8U9Pkeq/cnifCdOGBf1k3vjqRa1QbU6D1slxT9HyaP+NaxVRuzF1w3WFR+AGJ83xZhw5PyyIVHZ14pPt69OmaLUqaGTefw0FFlS0Rtx7pfuDx4f8pcQ==
Received: from BN0PR04CA0200.namprd04.prod.outlook.com (2603:10b6:408:e9::25)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 06:04:30 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::9) by BN0PR04CA0200.outlook.office365.com
 (2603:10b6:408:e9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:15 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:15 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:12 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH 0/6] Configure Clocks, Add Native Dma support.
Date: Fri, 3 Jan 2025 06:04:01 +0000
Message-ID: <20250103060407.1064107-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f9b1be-a8d3-47ad-c2d1-08dd2bbc7c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECmtvhBFDIAL62hJq6wOKeQ2SacUimaO/6bytyLYDzWt27R7+a9hKSFE4c9n?=
 =?us-ascii?Q?efp9QcG9UXVCSzfXTdzGPyJQpwQz0ejYp2XMEyvXI69EFRDQzKit9vhB3evs?=
 =?us-ascii?Q?gYQjUhV1VspVXQDjAAydJl9yriquaJq7L68h0zUlwm8aLCe84fXlHm1Imw86?=
 =?us-ascii?Q?85WBcZfuqrIJRLf91K3c5UFrRd437SJGP8t2+u8n2BbF5ttPrdyFN7BfOC//?=
 =?us-ascii?Q?8QLEa44cBrLOfOXJNFSDDpz7LddXfmS06BmmUhVxiA+Z7jy0oZ9TyyA/KrsX?=
 =?us-ascii?Q?jLOyJt2lyjEDYcg4yW5nFE1sJtlhqFah/76Ic4ZbwA0iNkDIcTZFrL8SyRNt?=
 =?us-ascii?Q?MqPASyB7EB22yTf+q29EzeMZNFbaFAjXm0gud4DOk5BjZ/vjLEAYBIJ3IkWE?=
 =?us-ascii?Q?PsaJ5C22GeSXrjBP42OvWqrI95xIazZjpghj2WajCql/Iaq73hbTxrXXxk57?=
 =?us-ascii?Q?FAi/+DTS6AIqioKsNxzm52luFqG+3jdZZPnRUvoLyFGqixPm197Qy+Lop+0Z?=
 =?us-ascii?Q?Wu7ci4Sx+A3CXpZ/LBFsN2LL7UWCqfsIbj6gKHv1OHo1k+0nUPSB2RrYoDG2?=
 =?us-ascii?Q?pOcrLyVUBHNaF4APvJnXKFC2N7qsb69v8MOVeIrW6281Ujipl7dQCER+7HGT?=
 =?us-ascii?Q?O0ZhTXlXBn+/+PvnFHHYIHefnkRJnRBPtrn8ANUk+Ug4821vyN2YLOo0rXJt?=
 =?us-ascii?Q?9tnRSqUg7nTNRpsKn8cyxsIwNaonAyzXCdbKXjuvAJxU5H60aaJIIW9YAuoo?=
 =?us-ascii?Q?qQlOpCCvaW7c6Ey6DI3VCXKpgPiPpSzgKnaRrAyqhitLtjWBXOVWKdoJteb0?=
 =?us-ascii?Q?2QI//CRHAq2W2BBTKmuDOo4YHUzDm2cf/1bGcPMSiKdLYy9QdQKws3TyGbtK?=
 =?us-ascii?Q?alTIwlmDpul0+JGwd60rRHekzW6Z+bju2nmOdzbqtCOSn32NBPNERm6Bqhhp?=
 =?us-ascii?Q?O/Exl9IInXcaM2xv6YftPdA5rjg2TANZenInVmNmhKtFIvALLuK8tvXhFcJx?=
 =?us-ascii?Q?9zcN4QJJVa0m03Oy6A/EnCzBWY6AIWmpqPWfScgDvYUPI0IEPkRNxIFV15d5?=
 =?us-ascii?Q?6L0Bafrwx4uRfN4wTjeytDrK06okVmZntTKfsXr4SVxvD3mf7TnzirgjmV/u?=
 =?us-ascii?Q?eiZheBf8AJRSYyoGRoQoJtZAolN+cof606fgbwD7Bal4MQ7kwLPqH4EV8tBA?=
 =?us-ascii?Q?s5ACe+XKL8AbfBvljQ0BwrMutLWJZ6ViWVOM/P4p3tgRQAbjCLh4j8Ew9HBk?=
 =?us-ascii?Q?PdGGD0D4j2SOI9VmulPzx/jfa0OeMfvX4Uas9jvOPyZe/IeAV+tEtmv492E5?=
 =?us-ascii?Q?G5LBEQv5hwv3+gbf/Xr+Db97E9xkTcsUqzxnL4IejTbX9HzgT6wVYdfiZmTF?=
 =?us-ascii?Q?jkTGNoZukfnqdScS4YCJNJIlAfT0OtESdFl2ZBYtJX5b/64KhOIETFezXCMh?=
 =?us-ascii?Q?jfEvqUh4GTEkJsGjkpQe1C1lG4EFc5+fvI2J1DILp6+jylZbrhWfv9A7qrmQ?=
 =?us-ascii?Q?eaozp82Z+RK9bl4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:29.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f9b1be-a8d3-47ad-c2d1-08dd2bbc7c99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

This patch series configures qspi clocks, fixes combined sequence
programming and introduces native dma support. 

Vishwaroop A (6):
  arm64: tegra: Configure QSPI clocks and add DMA
  spi: tegra210-quad: Update dummy sequence configuration
  spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
  spi: tegra210-quad: remove redundant error handling code
  spi: tegra210-quad: modify chip select (CS) deactivation
  spi: tegra210-quad: Introduce native DMA support

 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  14 ++
 drivers/spi/spi-tegra210-quad.c          | 273 +++++++++++++----------
 2 files changed, 174 insertions(+), 113 deletions(-)

-- 
2.17.1


