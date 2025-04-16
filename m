Return-Path: <linux-spi+bounces-7614-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30413A8B74D
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492CE189611C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0EE23642E;
	Wed, 16 Apr 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y1Gtqfor"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E31EF380;
	Wed, 16 Apr 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801601; cv=fail; b=DrFLz+Q5YkD6jqG7f3xvtcvStNweBV7T/biJ+2beCSG8BKEefnzFCcANWcV+q0A9Z87mZojweyk050p1JKp4DEF87uGRtFVglslc6SpDA0832oWM5PVlSoJW1gGJBDDWgE85GWZFrb2HozW70P+042czsf1o+r+JePpFsnX/aRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801601; c=relaxed/simple;
	bh=499x3GbmQ7WBz6PTbm2Ravm6OmWRIXeBjQX9ZAWOu14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXlPzQk3fLi7dGdt/43tjTdaddM3VhXDGbrtQO4Fx8CSvKCpVkJQq4/GAg5BTTaOG3h7nTH70/HBaIpFRpXLeIVyGWzphJnncrlQCY1cuNpn+x/ebbWcsBKWY3b2LcMcjEdl+gdrzdyZ5lK1tGz0ezJuaewsX32p/9XFqujnKl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y1Gtqfor; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Q3rW0SFqiGUP5F5/BK3uLQCV8S2YV8BVOr3gIFYmy3QDOJOvDSZogLqTz9b1gxjehHzfPRYmx8B821dwdLEtNGe0nx+xL0YnrBt+CXLayn1zgpi55T5HpqDBybAa7BY8h5MyYW7lCb8SJKbBM9Tv8LmhT3AAFUN1SVwxMnVivaHw59grCYUqhzrBq5pLBtUnOp21GPWrw7HqjU8nAjDctUuEMRDcaQMbXc4ac1q1b3PYTa3Ad3RVT7NqfzVgprRXrVJigSUx3RH7bT06s6Sj0GA4eUVNwuTtU5hiacXGiY6rV1jESe4TCp+Zx6eZ9AaH+DeeBviBT7tFkhrY86eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDUQeJ9H4ROsmvM0YwlCi90TytoxzVSqQIUTwrKGLFQ=;
 b=ywx8LIhOIOOFzhkhqsrIou0HLmCdIH2kh3eczJ6HjLBTYBkk/SUAE6BwKqBCi75C+gxqIoMzv4WCw0COi3xKFSMfl4HJRdZutebzE/kGTPuaZk4+qFy9CphGY/yzldWmD5qqAQ052TStIRp7K2gbDzQeyeexW0gYT2G6Igwunx1fSCavM6EzU8h0xMa8LPb2+tzMeOBgf1TMz2fTdUmxfhHqiUSjIMmRSV2qGa/Yduf3/M0CkjFbhmguwtsLP1VRPR/jxGK5srExUnwfzc0D3hqPE1QaNLVFiloNpBqR0ntrVSRAmkhTBvmXr22DHuolaNB3LUDlcXqjzE+vg/o0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDUQeJ9H4ROsmvM0YwlCi90TytoxzVSqQIUTwrKGLFQ=;
 b=Y1Gtqforklce6LOk2KFFJduMY5GArrX/b34qRHPXBS+A2YoBdJinE7R7NekQ15ERAe5R+owkhf4drFfFIMMB5QNNuQHCQzT/08Qh+gWWOkwbJXHSt0ZnlGfTqK+nqpJRSs0twCbfpuWD/u+T18wxYfNemIOCoeeHKXvem3AZzu+zh74Wx9LhDA56v4QnC65dxF6FjW3p/oxuoh3uxUa4sw311r2OF14iaWAQ9eWUAdSOwSofcvSv4rvcbTRq1rvQm6gijNlrG0Iimroswma0T8QR3gatco5VYcWTCl/S8ZLcxTzQnIhCRHxxWEnmkp0em/0mRC0Z+EKC6XeXW2kR7A==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.46; Wed, 16 Apr
 2025 11:06:33 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::34) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 11:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:18 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:14 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 1/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
Date: Wed, 16 Apr 2025 11:06:01 +0000
Message-ID: <20250416110606.2737315-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a1701f-8a0d-40c8-c99b-08dd7cd6bf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pgdpvQgvkS7PfDbF5MWJZIy4qLthi0Gnd3mcJoz6XmA+MCwyBZrNku29RKw?=
 =?us-ascii?Q?UOXFtLKSMfe1gpHBcGXSM73glXqKS4eyawCvoyxbzmpJVRwe1dZiPq12BfxS?=
 =?us-ascii?Q?JyxzdFFmvr3fPKu0mBsph4W1oP4wTTf0qWSZcrdCJRuPDTxkSzccKOkEQwAs?=
 =?us-ascii?Q?iXLK1U1DBwLEoM2XWytwrl8s7Bl/jDV6+HqZSkVOxkP0O/AI5gbGLwIjdxeW?=
 =?us-ascii?Q?NUiae5W1swIhPSfS9lRCYzxAngdcGWUsD2OjGFK4pdN4Kte/Dd5x041/1Cti?=
 =?us-ascii?Q?iDJPZ2Xxxvyx2yx02oWQTYAG1oglK0076YsitX36awEFAP4wDrMaIZDSt5pX?=
 =?us-ascii?Q?ykqtQlBUM217T3xYGoxtBKPHvvcOmQ911QSRZLxzqeT369cgCitnrZQlpKU2?=
 =?us-ascii?Q?FepHgCOOJOT1f6TP/ZGVXNYvxcNeqUOPG/mw060WCCU/2TBQot0CZGUZfMfj?=
 =?us-ascii?Q?OgXXsgQFQjLQnJrTd3XNyPOlGXs/u7ZkifzxctDzxHTby/+F6lothzkh4HiY?=
 =?us-ascii?Q?RrhUfumFu2aHhnN30wMSGnMD+o9Bk7Z/bnZ0Mb+q79Tnmpo7arUgLGNp6C1S?=
 =?us-ascii?Q?OpbanKNE7LC5TNELzx8bHuQajcnIc4cnrsJ+978ANnhvzVAlRa4SOn4AnaPa?=
 =?us-ascii?Q?65CrX4mrV009KZZlBuzEBTsas093vqvUMt3tmzYo9e5MoEPKeV/cJ2BPpjBq?=
 =?us-ascii?Q?GqX+PgFAOY3ETe3vwZ/T1V4XaTMCAtpuwxEdWWjrbi5IklOo7Q3Y+r8OwgC9?=
 =?us-ascii?Q?QmSy9vtKPKThQB/+sk0Fvoo42GNlciY38SYeLDL5YSW+UNx8at5FUl+YbHPD?=
 =?us-ascii?Q?P8JybRx3lFWq8MDSM9ef9P9zjUFm3piJ7iWzvmLN+GLOAiD4/cpN2kBqXu3r?=
 =?us-ascii?Q?wFryouo6lKAqivI8+CAFMoZBeOlTmbUdU+Iq+e1zFkP6BJujQcVBy70aGvhG?=
 =?us-ascii?Q?Uma3SWnm21R46/HJhNGO67FDEMkx0CKsOR8pNDQknL8ezJWWoCBSRO1e0Hmp?=
 =?us-ascii?Q?LbiS+zZOvy6xjqhUOw26brEMMNDR1KJ1JLEJfDgwciLTuKUEfnrOx2Ws1yGS?=
 =?us-ascii?Q?RFD1fnaHkWxElJcWaretSxleXIjTXu2SMrmyWVdlcW8VcfxHG/vgQ5sntUBU?=
 =?us-ascii?Q?znHQ4zTygXOoLhvFHfVepHxo55QneuBf+6aXuMWUd+IhkA9lIOF7L9QyRR7S?=
 =?us-ascii?Q?0Cw3phGMnCKQEaFxysjGwx/Wopxc+X/1ik1iLGvb7NoDth97ZTqVMeKhJWie?=
 =?us-ascii?Q?EKeUfwCKEOCjvJT5UU/gQYeIRKsT54owG10chlLgLvRDcJ2rDMqD26foodvQ?=
 =?us-ascii?Q?TVHwv9L6DI3wOd1po6sw9G11KQq+Hkfp7BQ9r/NUnrhkNn2fDgmbY0grjYJV?=
 =?us-ascii?Q?W4r7DJUEYtrseIxXUEDLgYzNIg3DMPg+F6jisGOf/tXnXlp4vG5/SnX9VMFI?=
 =?us-ascii?Q?XAhzBQGWejuZ1B7Ut05/YQL9ayb6Xjyf+mnWeSfimhyCDBIlAVbnKRZIno0A?=
 =?us-ascii?Q?2JeXYfCl2Nt2PKY+j7PSYAQtjdaY8fezi/dMSM/R4tgjvUXcGL4vXWGrVA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:32.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a1701f-8a0d-40c8-c99b-08dd7cd6bf19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

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
index 08e49a876894..4983b1f705b8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -134,7 +134,7 @@
 #define QSPI_COMMAND_VALUE_SET(X)		(((x) & 0xFF) << 0)
 
 #define QSPI_CMB_SEQ_CMD_CFG			0x1a0
-#define QSPI_COMMAND_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_COMMAND_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_COMMAND_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_COMMAND_SDR_DDR			BIT(12)
 #define QSPI_COMMAND_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -147,7 +147,7 @@
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
 
 #define QSPI_CMB_SEQ_ADDR_CFG			0x1ac
-#define QSPI_ADDRESS_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_ADDRESS_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_ADDRESS_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_ADDRESS_SDR_DDR			BIT(12)
 #define QSPI_ADDRESS_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -1036,10 +1036,6 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 addr_config = 0;
 
-	/* Extract Address configuration and value */
-	is_ddr = 0; //Only SDR mode supported
-	bus_width = 0; //X1 mode
-
 	if (is_ddr)
 		addr_config |= QSPI_ADDRESS_SDR_DDR;
 	else
@@ -1079,13 +1075,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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


