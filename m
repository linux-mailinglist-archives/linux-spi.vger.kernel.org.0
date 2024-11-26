Return-Path: <linux-spi+bounces-5841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C79D98BE
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 14:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D4B16568D
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9E1CCEE7;
	Tue, 26 Nov 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uqh51lHB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B4DDCD;
	Tue, 26 Nov 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628758; cv=fail; b=GHr+iL/MNPnU6o0UPQtQR7HjRpEuSYYUyBOlxGmbOPvvzFAS3HMDu9eJ0JoJTvh//Sv6E9nQL/d8Gg2+wMy1OghPd2YB5agPS3MtrNd2UbvoBtJkixIqq1F1De89h2bKuoCv+Z9FdhSGCKJEDaeFINobQTnGyJmloXoynqOSwAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628758; c=relaxed/simple;
	bh=0/LVlvMqJR7uutpIpRrKjp5Sp1WrnBdIdLMhvprbXeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I23P+28iJgPOe07x5XbHPIC/ef8nKwrleJJWMl9Zj6U9V/3pQvmcbQmEP+QQ58yvslfO5ErC1+4Av/eZxg04xY5Rfay+DXK/X6TPK0g4sPCf44bIj3bb6RistNv+e6UWvXgvOEu8Pa/p5Ff3gWWZgonO4m1WPx319oCTzFhczKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uqh51lHB; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX8OTmsvdkSqpCUD058VjTn9ON0sTih5FzbMpeHP/ad/e9g5I7rqdxxthiqk6Q5wvXSr2ragjabMCHeYZlhgjcMlY29b5C5Y/gfHP7jbVnWjxZGeiApoQfApw5ALYHJB4a7hCQbMjfgNnvSoKZg54sVVkfnOmVv54JkNC1ztx6/lbqvFjiYmDxQ8HjWZtZ1S6Vr3jxdFdLa3YtJOMP4JIBIPX1NtmSPLLCAS9zjfJ9S4XbT6iTrXMd7klsfyaU9Hs/I93cK1QiaNIjar+Vot9U3LVI0DNEW//lP1p5qkAOWq1QC1lCqMdIZh5LeJT9SQpp7u6YnJGa8LS6Cme/2xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlU4tQu6JBaAItTVaMvjooh2YOKU4DrBhEhtS8Xv/Ro=;
 b=vL8a6YZ4qFBeLqeGZW87ccdy/V0MdnKHVJZOCLWPZd4jJ8zYzlA6T3EoBO9X/eG6gepiasBV9kVA8KJpOVSkCf3/bJo6f8mnHNmcOatJ2KqjnVLU0X05puydShXwPI8oiU8ShWibYyOjdQCDTij6WX2GWTPtUMUFD3OSllQ6ctYNatBN1VoIicwMyuB7O5zo/cocWWm8vH5SHFjfcnC8537kAtATQfiPJTpZEpPWprsy6bEOFVTxUAMX36UD9qPURF+z7+DsbTDDI73CwpNB2MaHXeB4LJgzsEH3dq2X8noMMiGEp/2LOoDol6Uc9ZjJE6Y6gj+DCc25jTppT6hBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlU4tQu6JBaAItTVaMvjooh2YOKU4DrBhEhtS8Xv/Ro=;
 b=Uqh51lHB9Wu8HCcEwfvNgrfxlsVAAI9Kx4/QpBcJuNKgAzN74TicZKok6Unqa+5D3OhGnI94f171AC2/limcSrGmjlDgpvl2BqdTTu8ZCuU7GmflpUqpDxUPm6jX18jiAZp9Jb+FMCfGqwOHSiV7aRiAlnMQ7TQo4m6MPB22vp5BwTOZP2ESe2El7FFIwUZ163oL13Y4OlYkGaSnv3uQLdDkXh3e9JyeLK1fVkMVrIcr4CubpyNftTH4GydaLpMYBsts2uBI0w5HFtXT6PvlVI+3Pkuuvawb8krLPREVm9bEBUAtQLNhVx/X0xWcb8VoF+D5ptPOC6LHXQKVL6Z/Aw==
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Tue, 26 Nov 2024 13:45:51 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::5d) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.11 via Frontend Transport; Tue,
 26 Nov 2024 13:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 13:45:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:36 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 05:45:32 -0800
From: Vishwaroop A <va@nvidia.com>
To: <robh@kernel.org>, <jonathanh@nvidia.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 0/3] Add spidev nodes for SPI controllers
Date: Tue, 26 Nov 2024 13:45:26 +0000
Message-ID: <20241126134529.936451-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c62a9a9-1990-4a36-2493-08dd0e20a423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGmZ3g/h5WgczznQ262kNqKTwUbS+obURAVv9BBVvo55PTFEUFrLKOQ7gCDF?=
 =?us-ascii?Q?5Q8YVak0C58QI4Olos2CREKeVStUtuq1WcNL9g5N8RLTVGm3bMLoaYJBiv9J?=
 =?us-ascii?Q?My6DQnPxv29879SxboJ1fEFeCl0034bT0fIj7SfGoq/oXM7VPv1BuF5Q1izI?=
 =?us-ascii?Q?ix2s102xYgeMGOZQfvYdlK2UzTazcpu2dHSYrFwa+W6RLr0vi9XnnrcoWuqM?=
 =?us-ascii?Q?rnvugyq8yj7vQ6CSe9UfK5LeiNg+BlWsRhykb7fNkh0QN23aMb4ODhNsUJpf?=
 =?us-ascii?Q?sFHSCUmZln9cR1H/f/UX7OmG5URc6cPtTrqj/0a9lTbV+EQo7O8aG9cc6/XT?=
 =?us-ascii?Q?MlQkpY9jZpYBK6aJKjntBcsXobgP4HqiqWzl7AxI/0PqISfDQ4n90dZbODF4?=
 =?us-ascii?Q?qObOBKzu7frZ/6cbJ2bIZzYkDEkTvVnXX7HTZnJTLxIz/TvYScN1C6IU/5gG?=
 =?us-ascii?Q?/Xlee+VO8ejUQWRIDlB+3L0RL5UG3EnTJx3JaCTzeQ5R7sGDSGIq0TR4G/Wi?=
 =?us-ascii?Q?MwdPcNExPrDCzAsjledp2kHk1yR0cNg84lDAPEdakSBGxr64keMJBg2jh4Gz?=
 =?us-ascii?Q?Hlw6MwDXal1on4VfIcUG4j4++FKzcjpt+eV7sNdt9nWLTwlMPFt1qms/gnvt?=
 =?us-ascii?Q?FCaO6W17/aL9zv19vagyekhAsbrGpwxgADOo2Jpl5B6YJ0Bo2WhtrAz/xrMQ?=
 =?us-ascii?Q?2tc2J88a1DROVy0A/HWl79rpi7sUgbaOOVoa97M7Q2ssahl2YZqrLssqYYts?=
 =?us-ascii?Q?AmAngSGPsVIKO+kUSenUbRt3bTTIlbiOtjqJ5NOkzqcyr7dpprijmvqXK7M6?=
 =?us-ascii?Q?VXzjwg6LZzp0gCA8Ffxk80Va9te1P3Bc6LpVoFsGpwBSGcS15x9ri48xINrH?=
 =?us-ascii?Q?fm0MDsgKBhNcknTQrhXKSon/bc6Mi10KwILV2pAL7H47do5OF1BLpPrqtBHi?=
 =?us-ascii?Q?mmUC6E3Ah3oHyoQLgpG29zYiiocsQ4HXeekB9X8H/uXutSjRh3rxUCgNTLvj?=
 =?us-ascii?Q?qWTzcCgP+lxjtPYKshn5cdzP8iIYXqIK1lMlyxPu3uI8NwLMzMC7N6d1beQF?=
 =?us-ascii?Q?YwWiu6UHUWK9x76tH8IrwOka+xmEri4nmMkLECyqy9MB5muQLqZJyIGSR9nR?=
 =?us-ascii?Q?mQgN9RNV/stcZXdvEMCYUhv3H2JEhR8EpL6rJkdD1FzXKczbxmCaBYokKLEH?=
 =?us-ascii?Q?i/RLGPAAWQudZuiX/fFZC0p3ezx5H/zRQHB5ZIzEiBTtuy6Vn4guzK36nPv3?=
 =?us-ascii?Q?uFAD7YYM/0FEjB9ZbMePpevk/61uwU0uaDW7KGSbt9qHsU8j7kZfIwQWJVin?=
 =?us-ascii?Q?85AhRt0+mJUZK1Xoc0AK76Eu8llqypSujO49+wVaDWagxJFslZnkZBI2wX/P?=
 =?us-ascii?Q?nR7CNTKtIyZ/a+svH9cxCQonFN58V9XFtCl3Nc5v0o8G57vNutcildUuUqLO?=
 =?us-ascii?Q?mImiZmOv5K7stpDundGzSfkWPPU48y7ncDApx+hQwBZH36/UzZGV7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:45:51.0893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c62a9a9-1990-4a36-2493-08dd0e20a423
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

The patchset contains spidev node support for SPI Controllers, adds
DT schema and "tegra-spidev" name string in the spidev driver.

Vishwaroop A (3):
  arm64: tegra: Add spidev nodes for SPI controllers
  dt-bindings: spi: Add DT schema for Tegra SPIDEV controller
  spi: spidev: add "tegra-spidev" name string

 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 .../dts/nvidia/tegra234-p3737-0000+p3701.dtsi | 28 +++++++++++++++++++
 drivers/spi/spidev.c                          |  2 ++
 3 files changed, 32 insertions(+)

-- 
2.17.1


