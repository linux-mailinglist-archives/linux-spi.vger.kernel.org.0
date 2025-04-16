Return-Path: <linux-spi+bounces-7618-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34CA8B762
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EA317FA2F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410423D282;
	Wed, 16 Apr 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWSfSxZk"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DF23C8CD;
	Wed, 16 Apr 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801625; cv=fail; b=CISikV9pafZtaM4/ie/sx1823FzVbhA1cnjBvCUQdsDMpBN43sgWctQ69sls9V3apdjWl7c2tPQsSe3SZSi/q60ekbcFRkuNaY5IZmlQ9+xrgW7LA1rJdFci/1rfPltwy3SRZRIHY9Cj6+zLR38T94Hw2l23ejXL/zj/XKcZbmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801625; c=relaxed/simple;
	bh=s6aIeev3yjJw5DMoplNGlYFxTjsy2JoMzQuTkI10m38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCbipjeg37XeWlh5o1yo0MEd/Dm+2a8mdnS9oC6sKddJWBEavJECDsr9uGUFf/FSuPIvj5BgBFx1nOVakZesM9kFXiR6FGFO/OjXTmifWV/dzdU4sbhFxxot2e2rS7h5wD6R0fG24GsGKVOCT2wL71fWEvf+Ik2ZksBSLYOkV+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWSfSxZk; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfZNt1Tyn+U92iKW4eoOO/+/5ujqTanzPFdC3wK5vl2kA6arFFZdYw+sqKYwpY4hSAJ2kA4kJZS0RcoIEdQPKPdO5M5QUT5Qni0H8wmgZ+27318CRiFArqkQWG7bctLl4OiH1VXk84Fi9+nC4/upv1/mu2Sjxg3XU2Lp/0WKo0WGPAyZGDu7jgDvWQmvFwPZxeNpYnqYJn0isimUGG5Xqryjc+bqkatTZf6yw1bEeRaQFSPjfv6RohgILL6eHaQ5TtaywqUgAfWTFOiOxKEIiRXE1gj8H+S8jjRyuQ54j0sjpUksDhsvtUg788gfTQyXOhxJaTvz0twiCuoXXWfr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHsefJNBufNJoCmWmZbqtWSm/Y8kIMX6JMbv36h5hLQ=;
 b=E12wE5KnH3pLZnBARKVjl+UWYR2BC2NOwpWk/2sRY7Hd7kc6TWPbz9qni1Uqb7OuBJRTNtSUEFWIcVn00PEbmKF2wJz7TmI7q/MsUtmpAHdYakQ81kC2ZIYmfUC5chWshcKUgH76/uelCceG7asrKWK95znUVR0LThBPFvYnpb1Y1Q7ZnRxGlCSnNdaT8+kG7aG/Bt4BT38SbEzMj9qQIbTPzXSoUZW5Xca7UILff6V7G1VqAFWEs+RZBPdsrpUupLJtDvWvQz73Sx688aHNd/+HH6FlCDLxXMwv5zOmtA6AwXZZF3clyGQRoe0mZxCi4nN4YwAsnplT7HmB4iRHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHsefJNBufNJoCmWmZbqtWSm/Y8kIMX6JMbv36h5hLQ=;
 b=FWSfSxZksVRxp0LY2BPCbHgV5/SAV1H9QlOcaBUhAdh1xLtKpCl98S5W8XyZNMz/pw2UVIr11WLEmdSXFyb7olw+716iGL8hTBJzMJsPR1hPPSECABn7SorUFFCW/igMZJhmBCUS2qSH7/rCUG3BiRrbJcvGb5XubcK0OOkFiPLE2cbiIY+9zAMysdsudzFhw8UAFbzPC422dFRpu526SIB0lhexgypsbZ+X/pIJP7xN35mJGpVX8PRnZJCADahnMLTjPaBMaVbeQ7B0Vw6lUdodIrzKYvwv+U6CW60VdtuAd0pcfJRcK43PwPxtIBXgij+Zu2gVYpSWep3XbzAwow==
Received: from DS7PR03CA0037.namprd03.prod.outlook.com (2603:10b6:5:3b5::12)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.37; Wed, 16 Apr
 2025 11:06:57 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::bf) by DS7PR03CA0037.outlook.office365.com
 (2603:10b6:5:3b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Wed,
 16 Apr 2025 11:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:41 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:38 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 5/6] spi: tegra210-quad: Update dummy sequence configuration
Date: Wed, 16 Apr 2025 11:06:05 +0000
Message-ID: <20250416110606.2737315-6-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: ff736bf0-0b59-42f5-85e9-08dd7cd6cd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4azlvpX7Fi1+mgdS30Kjy8L3plBnPICd3WKAaaJ5jijF5S3GpeUhtsvNsnkE?=
 =?us-ascii?Q?G4Wd8OJ+UUFimVeQsODlyRjRv0eKXD6c77x2dnNOHMAewrwGEbjmBBS5tFnp?=
 =?us-ascii?Q?ez1C3/scImjjWhoZ0/SKERis5g9EcRV2ZgPV8g770xzFs/IiEYZWEAUWH4YS?=
 =?us-ascii?Q?MJJz6cuY344XlyGTGimw7TTikpInFtMyziZ1nPl0RrUyINBNnZFL5svXd3+g?=
 =?us-ascii?Q?NGKRJ2M8GbejgymiRanse3sUNYnXa6qIOuNY+CGJst+lijpLyrwBJLXIcJrm?=
 =?us-ascii?Q?fTMFojHxY0wp8KCmkufry9dlKd+wqvOc4JUMgUZfMbsCv6+jWuRe8E1fSi2G?=
 =?us-ascii?Q?VLMz5re4H6l6Ec2ou+bqRsjhv+LXBk5DRIGgmAvTSGb+ScEVVGCQPnmeDGw7?=
 =?us-ascii?Q?SjCalbVoLkRv8RB+O+6Hx36pld3WszbcxmNsFEnNQsAIn4eTTwMV4ug8QjKF?=
 =?us-ascii?Q?Hz56sf1gkcfbOZQ4EOaTyZz2YX8tUVRrWKilYhZ4JgnKwbTO/ltK72CzFQzR?=
 =?us-ascii?Q?XvyRAwF4FJMhpk9pH2HuXpRQfO709otV88X2CFHoCWbVD1z5ThNGyvxWc4pU?=
 =?us-ascii?Q?/8U/PxYD+QYr5u0dyplmrDVvXPB6JQnMFW6yVE2TA0y4SNwO204kxy+v/wo7?=
 =?us-ascii?Q?Ytr64urJRtzXAlcn27PgyNhOzh93MMk4iVP1hT+3blNeHxsl3sQj4ETp7qmb?=
 =?us-ascii?Q?ZfRlptaETTcpJNL0CAMXvWv9sqj1q/lCmagxNt2uu5HW5+CWFFeIgeNcSE4F?=
 =?us-ascii?Q?w9XjzDwdxfHmrV/8IwDwQz1sjQrBIcyhJncbNgm4tE3CDZPJXzF72I3FbykW?=
 =?us-ascii?Q?mfJGa7XbnmF8Vmg+mwmqOHrcoZVS5BtTHKZhBI13kK0dzXUHIP+zdE3AXMto?=
 =?us-ascii?Q?i/O+WvfKv12rx2oKZAtDec2fjxHEPapFKeO7/IxwHt2hvnxh3UFuQgyNM1WK?=
 =?us-ascii?Q?TdZVe3bVrC2x6QIQDx+R32FORPBzs0eb1baUYqKpI4/Jhl1GBZSnoyxQ1Lmt?=
 =?us-ascii?Q?C+/5yC3JFW2XrBzAkRsRIYltCma/aFBVSarPY4Fy/FF/f2raCAp0r7mWGvk8?=
 =?us-ascii?Q?uW8J6+pEE5IDj7vfRY089jSIAsQX8O6e8zWW1iR4e3jQsMeItAgamo0zlN84?=
 =?us-ascii?Q?/FkGdaodZ3d0rIcl2pE8nvFk3/VbZWgOKqxVcSNn9VcRhW71VXAnak4DhcAs?=
 =?us-ascii?Q?jpfVDlVUj6yzBBw+UwdUVi0U6hQbBIYcBQhlViTBZgUVoNxqWKsazOhz1HdK?=
 =?us-ascii?Q?VqbSGdLDnSt1eU0iCyMGK79AEsVldeCX064+Ty3C9Lptg/M3JPLgIo79ZPW7?=
 =?us-ascii?Q?ceImLkb6TX5YaxKuz3UXUyNU6A4FH89iV+SuREHId/dUJs1NsYBeyQJYMAax?=
 =?us-ascii?Q?Eiqc2oeaaR8YUH34qgQUYymnESUvEYPjrNK5WlAwbxswwp1t51zWCbQNZkTn?=
 =?us-ascii?Q?GPKKuJ9jH3KY7PxEI0IWgUJJwXPNyrlAqn2LN+CkH471WRav9jkVpwaLuvri?=
 =?us-ascii?Q?zim0aElaMWdJkKgHsT+cVXVWxXYjKZGf2/57FV/lJOlgtN3LHaKqswLgpA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:56.8310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff736bf0-0b59-42f5-85e9-08dd7cd6cd85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Adding support for the dummy sequence configuration. The dummy sequence
introduces a delay between the command and the data phases of a
transfer. This delay, measured in clock cycles, allows the slave
device to prepare for data transmission, ensuring data integrity and
proper synchronization.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 159fbbfd4a38..04f41e92c1e2 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
 #include <linux/property.h>
+#include <linux/sizes.h>
 
 #define QSPI_COMMAND1				0x000
 #define QSPI_BIT_LENGTH(x)			(((x) & 0x1f) << 0)
@@ -156,10 +157,14 @@
 #define DATA_DIR_RX				BIT(1)
 
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
-#define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
-#define CMD_TRANSFER				0
-#define ADDR_TRANSFER				1
-#define DATA_TRANSFER				2
+#define DEFAULT_QSPI_DMA_BUF_LEN		SZ_64K
+
+enum tegra_qspi_transfer_type {
+	CMD_TRANSFER   = 0,
+	ADDR_TRANSFER  = 1,
+	DUMMY_TRANSFER = 2,
+	DATA_TRANSFER  = 3
+};
 
 struct tegra_qspi_soc_data {
 	bool has_dma;
@@ -1085,6 +1090,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
+		case DUMMY_TRANSFER:
+			if (xfer->dummy_data) {
+				tqspi->dummy_cycles = xfer->len * 8 / xfer->tx_nbits;
+				break;
+			}
+			transfer_phase++;
+			fallthrough;
 		case DATA_TRANSFER:
 			/* Program Command, Address value in register */
 			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
@@ -1292,7 +1304,9 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		transfer_count++;
 	}
-	if (!tqspi->soc_data->cmb_xfer_capable || transfer_count != 3)
+	if (!tqspi->soc_data->cmb_xfer_capable)
+		return false;
+	if (transfer_count > 4 || transfer_count < 3)
 		return false;
 	xfer = list_first_entry(&msg->transfers, typeof(*xfer),
 				transfer_list);
@@ -1302,6 +1316,13 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	if (xfer->len > 4 || xfer->len < 3)
 		return false;
 	xfer = list_next_entry(xfer, transfer_list);
+	if (transfer_count == 4) {
+		if (xfer->dummy_data != 1)
+			return false;
+		if ((xfer->len * 8 / xfer->tx_nbits) > QSPI_DUMMY_CYCLES_MAX)
+			return false;
+		xfer = list_next_entry(xfer, transfer_list);
+	}
 	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
-- 
2.17.1


