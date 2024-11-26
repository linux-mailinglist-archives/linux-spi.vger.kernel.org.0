Return-Path: <linux-spi+bounces-5844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA569D98C9
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701B91620CA
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D41D515D;
	Tue, 26 Nov 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6Tg1XuK"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818E193408;
	Tue, 26 Nov 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628785; cv=fail; b=X3OpVuf87I3be7r/1KRCfs0/OaNwUWlSdbcTkUtVehOGWojYAy7LG+mTMHmuTuB0Jx3N1Isuus02IpbMYGtAjEunV4SWSaJLDUaCZzKgPb+C+dpMIO29BnP7kG6gbyBcFdo5fU+XQWCZJ1CJPc0JiKGHcC7w7Za1TQgSdW85uBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628785; c=relaxed/simple;
	bh=q6MqAJjHYgeN+AjLqgGwE+AmQmqXhJlM31Clfd0IoTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6WywLD13WCNkljcdmEB4tk4f3MJ9Hk9EHOExcyRjWWIhlFV6qgZw2/HnRXX6JUnDNXvVHFRqN2sva1F6B1o1Rrwrs2fy67K4UIIMiDsj6thyzUqb9XoaySX4RNDqfeJvtDbQWnglflpsT/YkGQ+TEGBAP2PAIpLgPd2GIM4Poo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6Tg1XuK; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFXkrumXIzoS7oSudpmFPQylCfxSCForw8qJryPJtFWAyNL/oOI6HkjPEZcLaatY9+tuz6EgIUrkD7PN+m3bf1Mz7pQWlI+SNmZNMMj4na8vn6jIj7sg8gkzbzSYwCvfPQLjN2oc2tqVJhwK6/0SaZSx/UyE3QkpLHMQinTuHsO2gZi28btWcchMwQFLOIyYZWbpP3977TCzZ+yVjLZUzbGeDuCUvk+AaFBpX5qF6u13TOBeCHXFx58oVgjff+VDTW8xqfmU3ywS8THa+5GbOFQ98L2Rceh2P0QwK+gIjAzXCUI0qLOLSV7ebtGSAg8fuFvC7gZpZxUpyqX8Bgwvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LSp+G1hL+cmXjhKj7Cb064FC3jglpctZjXqEHZIzk0=;
 b=rOBrISPEIdLxgkD200ltFbGEPqZq/xp1OZmVfMrgxzWEDZ324T2YKv0A7JmyGtrNr2Y5wHK/6UQtrO2Bu4UJ4Y/y2iBLoWTpvo5ojBJNMBPDUHO6oCFdCUvBjJAdjCkvy+i3fgNY70WVplZGnbOgKyLfe2e4U7eHclfcoYJTr4mHogSJS7v7XZtFaVCW3TPnDXVEGFm3daMcNJMRA+pCtizyek4U5Ldbh8D/hSVNNOvuZXO5MEdbv21sxiIwqxRLNtiSF/wkN5HJXneOwFxUXjtRh6ELtzfGnX8wpNwxM24ZjaI+aK8Hk9CjyI02Vzbt8yVpJAQV9N9se7zRcCtBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LSp+G1hL+cmXjhKj7Cb064FC3jglpctZjXqEHZIzk0=;
 b=O6Tg1XuK+5XOZQAx/P7ynDwqP2w5ZIAxxMEQm85MwrYwBnfi4BiAX82wtlOC6tLtSv+B4znZz0xh/FuTbR4CTXsdCzKpC7j6lTTM8j0kBL67xlA/1YMS1cDCUuaZJHAIvvscWXpkaKzGuUhK+auNeZmS9voe7GjyTeLUgplk37nCEkgpkzSJBwppml40bQx3EwveXuUhDrqGpXCVLkiS7g4iFPAB4yI/NfFJGtURikuUjk3BOUrS5SAiujFyiSauGdPhDxKBHpIGnO97T6O+xj8+YyItOknOQgJ6qa4lKJJxEmKx0361oHtnHeW8UHaOzx8zcY3Ib9f4Z6unfa44QQ==
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 13:46:19 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::da) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Tue,
 26 Nov 2024 13:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 13:46:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:46:03 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:46:02 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 05:45:59 -0800
From: Vishwaroop A <va@nvidia.com>
To: <robh@kernel.org>, <jonathanh@nvidia.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 3/3] spi: spidev: add "tegra-spidev" name string
Date: Tue, 26 Nov 2024 13:45:29 +0000
Message-ID: <20241126134529.936451-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241126134529.936451-1-va@nvidia.com>
References: <20241126134529.936451-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd586ab-059a-4767-eafe-08dd0e20b499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMT3KP3BXqkBJ7zgSrkoytknQQFLKSE+q02st93EpB7iwmOZg2KMXFVmga75?=
 =?us-ascii?Q?XWkOoXrvnCWjuU4YlB791E6mSQHTDOycKIUY9Txh/5oClVWkcjSIpOJtnt37?=
 =?us-ascii?Q?oPIr/RyW0BvNg8kMqJg4nuQstkL+gwRJHF33nN1IZ1CD1dG1ZpCMfbcAYRLW?=
 =?us-ascii?Q?4ZPMoDQtRSB5I3kPnFdbOUmA8T9oXi4ELyj9RL6YV+T2xYnchwtmMmFVcPa0?=
 =?us-ascii?Q?Mpy8Ze/4f2ikDQLEwtfNtCYsJIgVmy2u2fWC8Shxu29v0Djuvx/+iAUwqdxJ?=
 =?us-ascii?Q?bwSLS4dvyjoPDx8AsWV+0ushtK7nqkeMGNAlPl/19tXCVeTeSraiLsFBhbMZ?=
 =?us-ascii?Q?MsyMn8ajMLW/oC50pl0I8o1zXW1a1lPPPXg7fm2dLUHEpovEIsPVGj02W6Q2?=
 =?us-ascii?Q?7ytkjqlBFMP2LMqg4UFh7VwH9HNHEreL/5tsRO43UiGwo2uNgv768vW0tf+4?=
 =?us-ascii?Q?30jZsFAmCMJs1IiVyAThK9F7Tf1mSmo/xRroRpCTbuls61ATFgsztDEECGIB?=
 =?us-ascii?Q?IvwhKr27o+cq7+ZxMukfIr7NpeVpTvd6KsLJj7U2gsVbGLWrcQK0A5afu6Mf?=
 =?us-ascii?Q?PYglBuydKykAXa3LMA1rlW7d9L5KpBwsj2pFYgtzI1/atsHo8v6j0fxOoe71?=
 =?us-ascii?Q?35T5BzjYAuEu5ysnmfcbwbjzgJJLCzN3K3iRCorPUJkceCuoGRb/HRvaytrr?=
 =?us-ascii?Q?Liv5ph4OostAmqDPwfCVF2qXMDqrzgv3o0/WdRZSIdGBvHljdSOu8xz9SzoW?=
 =?us-ascii?Q?J9YwR7IuQPuRkc2aUoS7HuCzRaKF0qcVVAcRe5as1vhBXbNNa9unmcDIalRH?=
 =?us-ascii?Q?zAhctK0YDn6011NzsxIHC7yvpuz1oOAQQ9N5d+N5p2DXbHteHzKJuc0+gn2v?=
 =?us-ascii?Q?/O33NwSH/dYGpO9Oz5rojYG+NlAdm2ER1DU0La+wJXz4vJY6U6qf3VdrjYAC?=
 =?us-ascii?Q?W9enisT5LnYeO0iBTN+J/CMyPpoTRsY3AxYZlzppImmmcWiIFHHIqSSQKW8G?=
 =?us-ascii?Q?b1JqdGogeuSsc2lcf3XB/IJblY9Epbaui6rxuGyW6wlhvJwRF3FtT2T0NSZs?=
 =?us-ascii?Q?ioCJ/0TCC+Xw0hdg3E51qxMeaBb8vBqvmsfFekb+h4a73kL/QEW7bXbiITXM?=
 =?us-ascii?Q?Pv22zXD5ToLiN9Aa4JMoAUCSbTUj4iGxKp9ooBORUBMBh0Myn0ksoPVn1L45?=
 =?us-ascii?Q?1zyHJ16aO3bEyFknqYstot4rlf6JKYmGkGSt/euxu16PkDWMoyMN/tkzUNfT?=
 =?us-ascii?Q?+l+8IDZ5+H013Najg3GV6f+gBS1ZfX+yBCDh5iLQKRARojDnoYNEX6oW41oA?=
 =?us-ascii?Q?2/KAGo67h8EmeoWG2tOWCiq7d1oqB4dO7U7qjcEpQewFAIkY6ZVZ5vjnGFmp?=
 =?us-ascii?Q?cnayGZcYpJZShGB9cmCuTHHOYw0lbowLNvPtqrnYzw3BKD+YnuWgDEKLfNvw?=
 =?us-ascii?Q?yExZcwpSsLvL/w67Limv8f23wOLkOCaVSIUIpuBA+ytG0M6rcWcw5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:46:18.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd586ab-059a-4767-eafe-08dd0e20b499
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

Add "tegra-spidev" name string to load spidev driver
which allows user-space programs to access and communicate
with SPI devices connected to the system.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 653f82984216..1d2c01bd76a9 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -711,6 +711,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "spi-authenta" },
 	{ .name = "em3581" },
 	{ .name = "si3210" },
+	{ .name = "tegra-spidev" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -741,6 +742,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
+	{ .compatible = "nvidia,tegra-spidev", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1


