Return-Path: <linux-spi+bounces-6211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D4DA00407
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34E0163036
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6581B4138;
	Fri,  3 Jan 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+clIyrb"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FF1B4124;
	Fri,  3 Jan 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884290; cv=fail; b=SaHREp6AH9ERY4DBxZ0aJhGqv+LMLKYRL+3TK/RUZAyahwTeDI9BI56tvzIB9vAwt+fcDaQ2qHZLwUSNjjebOJCpdzStLhBmIHqZzKh/KFT3DMCVZpK/slxDnhzcHkZIJxqmbvJdab5ga88iHZkw3ae7FMbO+4pvYLJDk8ya6gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884290; c=relaxed/simple;
	bh=KOH9o5FYZ3j/lwFhcwvmtGP1MCMkiLSCap3GZOxnc5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZS1YzfqZ0U2/XesYbkTC+Rnj53Vxn1bZsoh/Zrkw5dgE+kr+y3wriNb3O5SJqtlQ6X8K8MqcPHcGLybg1v45Rx9fdubJuFux9CGeMuuh/1q6ziRlFF+dMXA5i6PFrOPanv0ckd0kREvsXPNFtTrkI4sDKZtoQyao2prKuEA4aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+clIyrb; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9garhJXdz7taDCQZLq45nOQS43M57liYZjQU47zLiEJ3RHI3oCDvAg7dYakWbt/K7LqeDP/zgnRSbRcESZyx571OckQL886SoqPkel3A9fZWwa7n3gzGI3UnKvxZ74gBhgaHV6LlWHs51ckT5oDOgrbqY4yIGOE3c+nlVhojCaaLQhbjsb0L2zX8e0iHN6h+8hkcmxinblaVxjU/g5pk79dB9XTk88lNmQIIkWQdJRP+WxtCF3ULK3RIAUQRySXNecavZqjp7BunqlF9igDd9JTkrgM42WXhZj0+lTI1M5EgKQTdqAZJ7EJYxa/f/IenMmX5PeocjLYE/Kqoh0pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB51yNRAkrPt03eMcukh6xKxNS9Q17pKsiplGGNdpvc=;
 b=NA6/9A5Uam/FQ3niBp35jBzxw8bhSqUu8EMSv9AtXC4CvKqNGrTii+VPGYzrzBk2cIV5Qff/FqcJy0j/LszDVN+vUIaB/2KPLAD/QNdHYPwJ//rQqtN7Vawd17OCi+Pf1gn3jdG7OCLIL0Kz9YjUbnYJUnXKHNlo/OFOTg5hvAmLYxKp3fyJ9/NKnpaeZP2ysALWKxvOE1/HpF4GDcKqzcDj2nwbeFrKZPnspNmoDTV0Cesyo+xiszwJDrZI5tnzNeYYCB2isUJPK9inpq8JvpRWY9MJvP2EjHcxYg1IddWQb5wCx/uL47exSrjCoHHBFckkYwDPTS5TH4P+Vs8bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB51yNRAkrPt03eMcukh6xKxNS9Q17pKsiplGGNdpvc=;
 b=L+clIyrburfslp0YM2lw4jWX6KFdqHtPHxHWVDmT8rMfUwRTFTRglfUISBVehtcms1eJMiDwY9Dn9Fb1/emNi7WZvlLXTteM8C95wLKTLelYosKgePHTJ7un76cRgkP8JZkQbfh8Otgnwmum0uVSlqZGu4Rm0ElpXACPTw4n2wqt7KwGT3I0Z+jQbOvN2V9P+Zfyc060GcoCZ4ROTxH5Ph8upfFsGvPpQUwLthZKaxHzZv3V2DzHjJ6xSku5RZB3G2qubXKJwtWeT2522wsAti6+wF47Ge6UKCZx9mjQHLN1b6PSKmmShkXXPw1mFNlpa1uR8pC8uF6ZAsiP0HEoiQ==
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:04:42 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::da) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Fri,
 3 Jan 2025 06:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:35 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:34 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:31 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH V1 3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
Date: Fri, 3 Jan 2025 06:04:04 +0000
Message-ID: <20250103060407.1064107-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103060407.1064107-1-va@nvidia.com>
References: <20250103060407.1064107-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a0e492-0892-47b5-ce4d-08dd2bbc83ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcOcTbwh220Ku3JmUsjyJgHZVlpsHSPQ0PjLuvbc9U1AwD+GxgA+hM1mzbSO?=
 =?us-ascii?Q?uaccTiEK0xiNtSY9Vqi2MBWfFpo36+NogN1CTHeF7QflBI6cMsdQvG/8FRwA?=
 =?us-ascii?Q?niBiCM1s88VZY94j5UOBqS+Ocp8eW83gsXEhK8gFqJSW9rQSsH6V1pJKbE0w?=
 =?us-ascii?Q?Mi6IAle+bqOCSaKA5i9PR9x+B1TBAfE3FloKjYhTEbA/XMWJfuPZA9VD0Q9f?=
 =?us-ascii?Q?JxVdL1wtsWLK37TFGowFgKU1BltITq4L6l1lzdqd/y9fIKtQnGYdpapDIAnl?=
 =?us-ascii?Q?dPl1iWXzRxAjd5hGK7U8QLxrV1frDL+S39ZallD+GV4gusj8XgNvNVo2KmQ7?=
 =?us-ascii?Q?OOIpALkck7NrvlbhoFNa3FN9k2UF2rTX//Rx4P3vfTWx8oKhz+xNGaMoB4Js?=
 =?us-ascii?Q?3APV1lP2Qdu25SxrYpOMfqvkU2XrnqESq83U5brpt6j7vb9CeFTTqWxZTG5W?=
 =?us-ascii?Q?Gf+sC4LpEFGA2sfXxLKIQt1olUl50eI/jruY33O8h0Rhr4fJv9+pcniMXJSN?=
 =?us-ascii?Q?Me1yocBm9BsiuhzMDnHemjeHmF6U76bbk1C+f8p6vCd72mPTf9bOYfKaLgEw?=
 =?us-ascii?Q?pR/uAAmtt64QMUBnRp4WYW67bSwp+0MF1mo62GMIqTfduumxMpoSSfR0+FGt?=
 =?us-ascii?Q?RHIcOurWHPVyh9/AB8dWVzP1V+XjWn4+KVpoY/tTAyZdINq26xWDL6s0RZN8?=
 =?us-ascii?Q?aXQbaH2oiHaPI681HsliE8zaEzH0STGpdKSSUW4QrpgFrkrDVFtglZd6XShv?=
 =?us-ascii?Q?3d53UfB4ErNGyqV+sgp6U+nfqQKZQ1GRFkEuar5IAFzjt5km99AjDJe3uWzS?=
 =?us-ascii?Q?kSz5eM72ZdP2FhuT0mPqTlS65vbGc3T3qtTfIFVQ/d2Gd2s+0RKzMNlxSSeG?=
 =?us-ascii?Q?0+R7ZGhYDoaGDUJJlORdxMsYf8lAvEXpVnOOTXbjFC7TAV/sF5GH7UXl7wgx?=
 =?us-ascii?Q?g+PNkeNCVQ1Ii3YUwloRKiudKZEydr572NMKP21WUitbk1Uo1iB3Chql6XUF?=
 =?us-ascii?Q?+ajhjDjkqXJiz0uIzoWzwrY/+/YshVxCqyLQFYqg37E+jvfmGWHE2YUOp92L?=
 =?us-ascii?Q?bmmMi0JlQG/tjiss/EzAleiD9JvftqgcGYEU19ErAMeHZyQJPevwAoBLi9dF?=
 =?us-ascii?Q?9XbXxfukMMtiJIkur49JBAmFiIrktB+XcnmwxklaGjGXeuDFXIkRVxaTJhJw?=
 =?us-ascii?Q?4x5jxTaWktAMHeWKbWu2nXV7+V4H0P0oe4uCtT/f6oIRa5fzij/E3LPgndF5?=
 =?us-ascii?Q?/PS1VJt/81gsojkv3Y2c3lRWaKzda/6WXbr9wMvvKsoelBJL7vbL1HCN5vQI?=
 =?us-ascii?Q?IlaPkPQbLLDRAvjUq9DKXXWCtihC38wC/mwOGWmADMFHGbxNvWDf1zQJeMx+?=
 =?us-ascii?Q?zGb/aHi2nIFGnQTxCGdr9uLVdJWpgC9KdBDBEL87GPXotrjM5XcVMXA5vsf6?=
 =?us-ascii?Q?/U6HxROeftmo3klx7JZ82Fa5KllRlWFkYBOxGCjz0Ouv8uFlESS7K5I9wgMN?=
 =?us-ascii?Q?Z4lZHPNMmMxId2k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:41.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a0e492-0892-47b5-ce4d-08dd2bbc83ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

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

Change-Id: Ic650c919535a99aa02f52c25e2a200d1b301381e
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


