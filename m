Return-Path: <linux-spi+bounces-6782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1317A32904
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E723A8F28
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9D2116EE;
	Wed, 12 Feb 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SMI7ZkXf"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148E21148A;
	Wed, 12 Feb 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371665; cv=fail; b=Jgy7SCDwdPpPtraf0x2O10Q8v16X4Klbs7mu71qilA+xnXgCUCwRzPVr0cV9h2qAwxErqwbNdxDiB023F31YDtMOgsnHDivWwbw3JkBQLg8OyGSoXQVctiNNn+bBb7hsSZvSlCo+JIh9gNZpXVeCy++rpmRIkthnJWQCUpvO1cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371665; c=relaxed/simple;
	bh=RyYQAkp7/yTwPWTlSqMcKp6W/Ne3uJ500zFGv2y24jY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcnLdbHJAnVlH01bOqTG0AVFk8K3aX8fPxkP1z8Tcs6Abv8F6vZ/1A/v2pT3guJRKkErt6MmaMYTpDek2IStXbs95q3alnjTWBP7Me9Drp0EFEaqGHrZSfIzcoD6Jg+dM9+xXDGcrUmFqHiTVU1GfeAPbBxHAbi3StRjz91c1fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SMI7ZkXf; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI89S2LziE/UXJluUO+awJ4M12X0En1H1L75ZPeh514DFcpSlPBiFGisCYjNqMLDUAEvdncwdfdXf6pJfcqpWTDSAE71wUPcXm8kZP0pzXIbfx5HutYUW/Lr8CwGyOZ70p+fyOntxlUdqamSYcy4I48vyJtuHq2nE/HNaxVf/dHqBYTq/Gi8RZhqMsRsMXWIjaX1QasgjpKo+X+QLib1iESo5pQjq2RitPMdSAQZxVfqC5Lpy9Ufd5LH6Zl8huassMKXewPiPZu9/3C+JTrJfJvZ0LB7l73blLAXhJhlEXI/pZigAHiJMOcLRe1zWgqChibbZIddhQhxPKnwMplANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrhItI6uy21NUbVvwkUzxG64Fqybb38Yt8J9mw+HTGc=;
 b=EHKs7yrf8+ggAqKC0C1tCOMNEcTY/yWqsMBxVdTQMA6WllHS+NRqw5HoVjY+Orf2fkV2u7IUSCl7EBEXkx1GqE0dlbs5chUBJykGeajlFtCr7FQipGEbIAiEqOeGjWmWTbd9opTJDYAeI9J4yg9F/EReWlJtZDDfGS4UJ8oCNa0pY+HnmgpDwG1lJk+IiMJT842ERYfURlWEYOdPbCHuC0AXlhYWcchHhMK9I/GTp1NOh6959z4kRgxDb80Vc43DB2qL0W8jUWiRN4nYaYHO85IqOeaUYSoFN8kmye5zbLdgp/pIMw2lpLbQABPoIIjiviwzVZNAPEfpnWnRI5B7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrhItI6uy21NUbVvwkUzxG64Fqybb38Yt8J9mw+HTGc=;
 b=SMI7ZkXfH6c1L1JL8CcwxUbQpazw5qGvZcFc79MXHd48zqetUsgglmJ8sKGyeU0+qbWZq2dHnvdeqVHkheizx46h4J6DdVffLrriFFoD7Z39QTT48AZpbd1IPpk34qqJu+ZJxPOIyMaF5GTk6ZPBKTBeVHrKSF4mj97B8u626YjjBeWLPaL6YHu5uqIDtM64cAWtlw0MIVHUBxMUb6y27UDCxXw6ZOwfCX9ryh7yk21CyBJLm82YdboDk1AF5g3EdLHqGWecMJMA6DggOCjAvRHaIwqgPo42OvJyV+nanpZeZ+w6+HhSS8P1lQzhL5mO9g27Qx9vPd9AJ0b5U6HZ4A==
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 14:47:39 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::8e) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 14:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:21 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:20 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:17 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 4/6] spi: tegra210-quad: remove redundant error handling code
Date: Wed, 12 Feb 2025 14:46:49 +0000
Message-ID: <20250212144651.2433086-5-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1bddeb-3d67-4ccf-e941-08dd4b743299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hf02dKcY2ctvJ99fpV+YzqBMa3rin4gdowSvC/dD5Tzi7CuVMBI/IETS/AdJ?=
 =?us-ascii?Q?E1bSYAtRP5EUfls3UQIhrxWxLHeHYC8yEf66FREVjqKIV6GDqL4brobdDXRM?=
 =?us-ascii?Q?GEM5/HtHt83h/8jOt5eSjA9lREuY5BsYEsEgPbMqOFa8XXO71DSNPsI+kQRv?=
 =?us-ascii?Q?JPTXkWi9a3STnYeITt+kBW8jJORdW0bmWz4yp2xddwvi9hizhMfNjTtCUz1J?=
 =?us-ascii?Q?/zSsdCg+gPq5ylWeV9xHe/ESDxB4oSsJ3fm69NTTtDUhaIRTuMq//gNmBpgv?=
 =?us-ascii?Q?++dygplDZ+s4yc33rsaD0M/tLrglBSx5jS//MC7egEzPmkLuULXJvENR+pSF?=
 =?us-ascii?Q?SD2VrkI7meW+ODYAXcp1dp5aCxEUNYIgnWnBdgwCETrDYNgXeAmbMrUi87Jg?=
 =?us-ascii?Q?uTPkuagG9X4nJ4ze8Ww6OtylUL5trpvCsy/8+xCYHBJEVvm377RwUsAmWMxz?=
 =?us-ascii?Q?U3G152ls9nThg3juXziLeISckeNfFdLT5m1WOHKHvtD54L3EaE4z2XJznA8S?=
 =?us-ascii?Q?bRMFilNsIaKStJknMMIi16xnvVZTNPDc2iiofKdVIjOLaLIEbu9pZGV3MSdt?=
 =?us-ascii?Q?lgnVdH+daOM6xPBT0c7nkaRmUZ3ZNs9FORdW9g9C33rYjg5+yEcIYvugT0yo?=
 =?us-ascii?Q?ChRDdFkc/1sq9ag3aecqdmAWYehj9sI6sQgjnRvEcAMgrGkOZoXvEUmuyWSK?=
 =?us-ascii?Q?07hwpeYakt6rUYFyRHYwsyK6m/1j7TrCrxMtcD4qOPudyIO93RNOyOkQu/dM?=
 =?us-ascii?Q?5cglTjy02R5ZrYrtiuXd+yJyw65eMsMapYIDw0xqBG7fhQpW9s+gMaWjWLaD?=
 =?us-ascii?Q?sscTp8EDTMFi0eyhr+YdO8DesJ9HXZVFtRbBQjUU7hEZN2hRY4zenjh8fSqY?=
 =?us-ascii?Q?82Mel3yfxjeL9Z65B4h5P3iqZBsEiondHIEPyuhSDljPJY5jQhl4/itizzWt?=
 =?us-ascii?Q?qNiTxdEkHX/xXO2+l7nGjVjSImUNNvWO4KpbqZMnloMt/O+DRf2aMEqkbDo9?=
 =?us-ascii?Q?dpQB7Pa0UTaBIwaJA8fCrBkvMMziPOMNu6/f/AXaBleMu3xcPp3zioiAUgbO?=
 =?us-ascii?Q?2d3s6q9tVR3gmjLD0H/bIRbLsg8e74YBgdiJhhMziGMFa1q7044RzqnMA/wM?=
 =?us-ascii?Q?7+bOnR9SfNgRtbzLkKbYZORzXzhUQMBMy9jF2HaIZmIW776EIGDELiuSi0/Z?=
 =?us-ascii?Q?AtYok9nQirfvI3EJaaec6mnXteSAHpcbAKCJHUhQnuMxOc2/tfXtLQu8rRbB?=
 =?us-ascii?Q?M/NED+4eelrfjzKTQ20EB+qO9zE5BXzi/89f4ca/xQ5nn3JwLgw5lRF0CV3Q?=
 =?us-ascii?Q?cHtgP2gYHyTZW9v53Ax38i0gPk4k3ocOq/JtMWVV0uJUFmb+9z8aPlb3jWNx?=
 =?us-ascii?Q?CQ40/2D1igJxNkWq16NqQFLieKA728GW2DYw81f4EM6PuWM+VenRKRMel4hf?=
 =?us-ascii?Q?KcHFofAWHKDGwKPkSdL4wcF1h2eaTU1t94O/60MbYcNHH4JCm7bRfSU0Vz5s?=
 =?us-ascii?Q?urxGjL7uMUTkaEfE7ATO+DZrd0dpyuPVOO2D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:39.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1bddeb-3d67-4ccf-e941-08dd4b743299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Remove unnecessary error handling code that terminated transfers and
executed delay on errors. This code was redundant as error handling is
already done at a higher level in the SPI core.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 43d6587fad09..2d7a2e3da337 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1187,10 +1187,6 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 exit:
 	msg->status = ret;
-	if (ret < 0) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 
 	return ret;
 }
-- 
2.17.1


