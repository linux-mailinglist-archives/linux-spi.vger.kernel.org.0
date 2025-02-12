Return-Path: <linux-spi+bounces-6781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B9A32907
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142561604D8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DA211295;
	Wed, 12 Feb 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmwwS1WU"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA3211473;
	Wed, 12 Feb 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371664; cv=fail; b=aHw0bO4q65gFmID8jjEu0RZbAuvDkLMig5cb7EN1l3bKnuCp64Ib49GuBaNiIjauR106QEwjjRWy11opC832utm31GSAIkHUHYmmsPvbZKasJjPQChdO3Mujfyh+Fl4voLpImKVRw9aupHJs7jvOc5KX26Q4/Vy3PKFUVNN/hNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371664; c=relaxed/simple;
	bh=6qJXUt3e6og6dzUFSOeRP9C2/r0hO3P2chofM/GWuMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f771VzSNQZglSpqLjaLsphRlF/4N2mIJrk7NFt9HiEA6LOg2/0d/HMmigfVGK02zEKuhuq6XinXMVld9Es7jrMY64j4NIkB9Vu8NDFIR3UTxxUEcxixIvLaP1qy6EhGmE4nTxUV4sh4g1NVGa9KL5hd0/wjrmfgGwEqJ7OviJMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmwwS1WU; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln+UTDcxvrnZspUetAQQDTVXVQfxoQ4CV/di8WeH8IvvJWxuuDmfH7MSvvZs1m2XNE9XFIMc0vPsTvH3pMsQLG6mtLqWrMx6nwsXN1uZHzrDz15hDZFH1nMG/YEctgLjldj8WFf6j/dok2vLglxo3ypA2oklZSzWe1oHAXAdhBpZ0XNujhWJwo8cS9DiktnZubCFPklQlbOChGDmu1wRUqlkw23BCl54vXZ3wLOFBEl/uRtmL5mVtxqAdEewOj1d4hkJkqTlX0U/q0vRwr53M4whyAPjaPGoiVH963ZvJ+j6LaQxlzqmzu4i4WvcrX1Oj/C1JJ1K0dhm877p500/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GqRzP6lH6mhMGoqv/zA0pyWtg/OiTH/VnXe4QhrAhc=;
 b=cUZPZx6KLFeQ2AJRXTLquQsKJ+X3vLLeABZnOvHg80GrI2bbFWtgKLFGi6bBDv6P7ntmx5qC8fXoenW7MUqCOGNt32G9Os/rVYLiekrSKONxiDVERfTLShfM0hYtjLIQosfm/NkXZg7y7o0FNiIw2Sa7ZOMccpiY+AZLwKxYk+qN4S2+6WRCJdy8OKoEMgjzZLeZSPPJ5Z5/KunRS3wk/tDP0PX0ETE7VOcXwgR1suBxHxt+aMmYDSlcoT666GmETxdKtRm+Y/a/jcOPP0JbjOFD/tA0CF+hUq5bl30lAO5GRHTZCaSwVKr/zIMwXmYCu5n/6kAF4n4zxEZI424tJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GqRzP6lH6mhMGoqv/zA0pyWtg/OiTH/VnXe4QhrAhc=;
 b=dmwwS1WU8IbWUGfDExMoYxjBtWmVo9VtD4WqEeSXFiOeCfaKmAR3E65ivAe+DSm5V/UwhuxAcqYaE5RyMxBRB9oaH+RdR79db6JhB2a4wMFQ8suaVin/taR9adVcni+UD007z2cO4awNPXmFLHuzGLpOd9rtdun6mapPNXdEKI/T3wjzo82ipbYz+jAOkDzeg2ncww8GPPUwp1Y1w2nIotBxoRD5DiPDJAX8DTsYXyTBSHhS8yb6pSr1PNoZgR1jKtb5uqBBwRId8fXTmFE2VrAnlUfjd4WHbNxYtBf7Jb6PJVSmMOhMYtx+H9Hb5hy1r6r+3CDlKr8SRQJy6gfCDQ==
Received: from SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::15)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 14:47:37 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::75) by SA1P222CA0189.outlook.office365.com
 (2603:10b6:806:3c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 14:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:16 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:15 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:12 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
Date: Wed, 12 Feb 2025 14:46:48 +0000
Message-ID: <20250212144651.2433086-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 655adc39-f136-463e-0a72-08dd4b743110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEUqeBVqKpAIs7teLgU1MMJKTPFdXpcTQUAPK+HspEVU7WwNwk7y6zqan6pA?=
 =?us-ascii?Q?lUy4W2747nEO+LkpXoS72eGRidgquZQs5EyV5BU22+BB2ioeH23KPY4iR+rY?=
 =?us-ascii?Q?HK4yGdhzBwLoT2h86+lKFgiU1lm7mM/oVUmjC4HUO1NhZlIL2eRCx27nZ6Wb?=
 =?us-ascii?Q?OlDLd1keTzVQX0ECDjywY2JLSLTm1kzty4vQGWO5QmLuvbVTSyIaDolmCGsJ?=
 =?us-ascii?Q?pi1eVxXDK1kv9Sw8e+vGbzG8zFk0RXHo64Na7Nb6SYG0hHnLBe3U/xhO7Erl?=
 =?us-ascii?Q?AjricHgC2yOMT33/sXGfZpcHVgGvP3QeJ8jKCC+3gVmacorM4lUSEop39pSY?=
 =?us-ascii?Q?hw+aPW3M/GiPXMIZv/02XL3/cgS815iVnsqyrBPLhHJhRU94i4VZysVI9pq9?=
 =?us-ascii?Q?T9j8LHRU/yDtzSDnlVzjXmICBvXM+3dAQ0gXpdte198OVkovRs7tfTkfv4Uv?=
 =?us-ascii?Q?4PMeHSgXTxhg7+MHXslyIYEmirqhdP02oU0dEsDPuzw5CT/lxqmMt0B2ewIF?=
 =?us-ascii?Q?7MWFnDy1B60WHEbdzWjmok1guoZFnPoaaUL0Ev1yZJyemAZ3T83XtIbXH4Da?=
 =?us-ascii?Q?dSM5s0jUkYSM2dq647zL9WAS/IiKt5FOZoZAWEsV8A0r9kqUfpeEOiATBHsg?=
 =?us-ascii?Q?BcyM+zEoiiWkW4KXu8sWY2zxRQpr+D5ID+blhBrNuwtxZrbg/6TzXKSIbUsU?=
 =?us-ascii?Q?at/KLM8KBrPP1b+/7HGEZszGVwgPhNhf7Aytr/gp8wH87+fsv+do0KqnMGqe?=
 =?us-ascii?Q?cqsgzgvg0R+qGfQ8HyO33sxqHyp9KphXXtYDxL3TTCi1csTcM4cGZKr4ysNT?=
 =?us-ascii?Q?Nn63t6av/BUz6WM9KY08PGigjYcTwYR4QH7C79CZ4ORXHoiHvtyH4JkUAYOt?=
 =?us-ascii?Q?JGjmYvcIBMVh1c4YCNKZhHip/E4K6r+mKX0hCMoqzXj7R77CDTXYUVE2y0Bm?=
 =?us-ascii?Q?/1SHgtWhxUbrSnej9DOn7706ig+0xZkEnyTZhh2TwG1HsW0+XNZhOI8/GnIY?=
 =?us-ascii?Q?s+r1lgg9Mx8vlnEb7X68p8FfwEdif94fvo7dvPsSoLLUvDShRsrIUCEUjQNV?=
 =?us-ascii?Q?nybyZ45ti0NP00fLQ/hFUTCl6YfvirXMkklIXNQ5orU1D1IPDvTeO7UHckag?=
 =?us-ascii?Q?MbwA0myj/KFPVPY45xK1afMuhQ57M3LSJ1dRVHMxyA/H5s1CLGSJNb5jWMb7?=
 =?us-ascii?Q?ziTW/c72mmfanE6t95KI67G0g70NWv4TmDLltMuR60mxBNXjo56Ew98khod+?=
 =?us-ascii?Q?M64f3cO1ghCyiUOocgWkKY4rPFWFdCxZU0M1P/+MYwhR4e4IIkZ9TG/ps+u2?=
 =?us-ascii?Q?l2wYF6mrD+HeCVzcSe5WsfZvDwEEoVXESfdPlNBUqu+S8sSHvjHy5uDshuJb?=
 =?us-ascii?Q?HMQJblT5dC22pIuofWuTeJL+tQ3EU4Wz4SIlTbBSpnR7xG3Hh2jt/71CSME3?=
 =?us-ascii?Q?isSS0sKTOSc/nwplGivUXyQnuz37WPd/wWuO2cK/kAoZi9bY0gUaIo2JvD6b?=
 =?us-ascii?Q?FsyyAl8faJxa7R7lJ0Cc92FDgxQUKVhFg8MI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:36.6340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655adc39-f136-463e-0a72-08dd4b743110
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

This patch corrects the QSPI_COMMAND_X1_X2_X4 and QSPI_ADDRESS_X1_X2_X4
macros to properly encode the bus width for x1, x2, and x4 transfers.
Although these macros were previously incorrect, they were not being
used in the driver, so no functionality was affected.

The patch updates tegra_qspi_cmd_config() and tegra_qspi_addr_config()
function calls to use the actual bus width from the transfer, instead of
hardcoding it to 0 (which implied x1 mode). This change enables proper
support for x1, x2, and x4 data transfers by correctly configuring the
interface width for commands and addresses.

These modifications improve the QSPI driver's flexibility and prepare it
for future use cases that may require different bus widths for commands
and addresses.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 02478e8efc8f..43d6587fad09 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -135,7 +135,7 @@
 #define QSPI_COMMAND_VALUE_SET(X)		(((x) & 0xFF) << 0)
 
 #define QSPI_CMB_SEQ_CMD_CFG			0x1a0
-#define QSPI_COMMAND_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_COMMAND_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_COMMAND_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_COMMAND_SDR_DDR			BIT(12)
 #define QSPI_COMMAND_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -148,7 +148,7 @@
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
 
 #define QSPI_CMB_SEQ_ADDR_CFG			0x1ac
-#define QSPI_ADDRESS_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_ADDRESS_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_ADDRESS_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_ADDRESS_SDR_DDR			BIT(12)
 #define QSPI_ADDRESS_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -1041,10 +1041,6 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 addr_config = 0;
 
-	/* Extract Address configuration and value */
-	is_ddr = 0; //Only SDR mode supported
-	bus_width = 0; //X1 mode
-
 	if (is_ddr)
 		addr_config |= QSPI_ADDRESS_SDR_DDR;
 	else
@@ -1084,13 +1080,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		switch (transfer_phase) {
 		case CMD_TRANSFER:
 			/* X1 SDR mode */
-			cmd_config = tegra_qspi_cmd_config(false, 0,
+			cmd_config = tegra_qspi_cmd_config(false, xfer->tx_nbits,
 							   xfer->len);
 			cmd_value = *((const u8 *)(xfer->tx_buf));
 			break;
 		case ADDR_TRANSFER:
 			/* X1 SDR mode */
-			addr_config = tegra_qspi_addr_config(false, 0,
+			addr_config = tegra_qspi_addr_config(false, xfer->tx_nbits,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
-- 
2.17.1


