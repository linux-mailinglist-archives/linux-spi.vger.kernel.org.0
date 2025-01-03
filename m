Return-Path: <linux-spi+bounces-6210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D5A00404
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABF91883E1B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CA1B4247;
	Fri,  3 Jan 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajeNiJ7f"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A813B2A4;
	Fri,  3 Jan 2025 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884289; cv=fail; b=M1ruiVLg0PtgOCEh7YtJXZ4jIZ5jauzka/R00FMt92sgi8eet3/e5yFG4MmvUFwZJO0s24o7nhqzUe84zyn4HJyRPoL1FoZGW+YS5iTu4h++Zi544Ezu1aAe/aW/15zSawvI+9niO3xaEjHqPf/76DYlp/30egzKft8++jfBGq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884289; c=relaxed/simple;
	bh=4kaJY8q9FAhBZcx/7L5l123mY5sYYEKau5kVSxHaRR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXW19NVljRNzdH7VDg6644N63RvOKs5cl1eclKlRkulF+Ktz+I00rVtguOhmx+2EGI/uRQgXACx4KwnUd0ZzIAEuN9/V5RvC98sE7/X0joa8HJqHcJGL1JJYSo1ziH8+Eb9h/poNwVppgGQHBlsOVaEEkxVwWlxt75Iwx6uPBHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajeNiJ7f; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi/BwosY2+g5GJuzHPXyW3WYsB2ECzyZSDAjjUpsiF1+qVV2cuSMUbnOzNOjOMeNrnB456Uf+HDYXoWxz4MRAjAcC01852v9wA0TjpKd+gwQj+W0QfjEmCm03ZldeXR/VasSmAPwKvRgxJA++jfepOik85kkrIwIPxS+R5HfAoHK3mvBL+h/S7XK38xZTcPI6+Jv8C+tcmtirWeg8B/vzT5iwtrBGJr4JhReSJhZUC58j0smD0v3TL2oeWfqGeZD+zXeeD0NDntHkS0QIegpnFLkiuhVcnH7nGPphJloFO8Q31upOt9RRCP6OszQYlp9uC9Y1mWiKw7oJupb3NHadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6UpUd9yyKwF5dVgltUuKkugUuKM24a5sAlTMF8TBE0=;
 b=sTlnDgQ6QWA9U3hkkC3IgMtprUfNS8MeD3Z3cucEGQJGWFlGAhRZvmeKYUJ0cPvnv+/NkSSLOzEtiCXLkVww21hpAm36lmq2PyGmFpFleidnR/Wqa0dvdjAkG/+HsHR1W56UztMd8sjbs8f7fjPdDJGLUMzPa0u1IYStu+QFLnGiXMiVKwAM1v0ZR6BWps8/GZt+aVhClD/A7qh4v3VjnoVH2RPpXGXKxTfI0GGB3I9m9eCyTDm7IC9hVhYbEN8b1tP2vaOkCJC5MTlUMKNbo13+Qj4QubWuqpzEosuxObOpppxjzQ75iex/95KCqhpfVubVVROEWotnRSIk3RZviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6UpUd9yyKwF5dVgltUuKkugUuKM24a5sAlTMF8TBE0=;
 b=ajeNiJ7fFOYYFo9Q5BcTsNR/+TCKhfVFM52uCtEdN/gRPePuJik3pDQpfbkXMXIYcvFotiBcc87BVY8YwVrVKphWYsIpi8Tzxfr8W3hOz4Gc0hJz/eVB4igfM3+GspnJ92OZeKtIUAojz0zIUwkirL7GYFEzEbfkti9CmHKzXhmUPHMO77iAbnRHEhbqEAk++772gH0sp4vPICI5IEq+bvfm3mgq8w5SwY4TWYe85V151uZJxBzk840cl99uVHvpmNYuiXYaaUwF8XxwbQFVL428CkN9IEA31VO9LgAojgP6Wv90dDwFU1NAHQlzvr9zcQF75U2JEArlY7Bbon1NPQ==
Received: from SN7PR18CA0010.namprd18.prod.outlook.com (2603:10b6:806:f3::9)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 06:04:37 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::5e) by SN7PR18CA0010.outlook.office365.com
 (2603:10b6:806:f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 06:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:27 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:24 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH V1 2/6] spi: tegra210-quad: Update dummy sequence configuration
Date: Fri, 3 Jan 2025 06:04:03 +0000
Message-ID: <20250103060407.1064107-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 74809e57-8ac4-4806-1576-08dd2bbc8091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tx8jC+ZumRFkmcBTfqctk1Sfii3jSl4n4pusxiYIEvsqxfPYQvOcMDq/f/Te?=
 =?us-ascii?Q?9xhJtajP/1HHqZcuwSczY6UjAzT1l94uz8P4P86zoyjrLaVlrldGG+5hHSJs?=
 =?us-ascii?Q?Tk9M17NFZlzKEBRmjYMK49fbBXHzucSSK5gVxpxQgmAlyWXPSROakt8iyqmv?=
 =?us-ascii?Q?BnYdHW1j2I8gDXYlC7VY4JHMoWrXNeNN1NjaqRlaFkVbU+iiRDNf+Yp1j1f/?=
 =?us-ascii?Q?bz856CX9FZ+AluTz7fC7oXg7S2qD8gqgtZiEjFG5LhsqqEsOYTn9+YDtgNXO?=
 =?us-ascii?Q?6QGL1PdoMK3DsR70ph0biIkJZXZ8xkUtNhYweu52WnNqSRlgBAhFTYlklPeF?=
 =?us-ascii?Q?0XA07mGVq6+nlDyhRYmP8a3y696B24RMbunAjIRtku/FK8GgPjoXNZO110q6?=
 =?us-ascii?Q?mlA8Y2fbtJQWu3Ox+j3pmtQ2Pm4sK6nPYRQwZgS+jgBzevM2kxJoMAbMW82Y?=
 =?us-ascii?Q?VeSP4csiVMOafVZPuuMYQYsgLe18Ywx2wrFnhxQquTXzWDPasc+ZyvziaW+5?=
 =?us-ascii?Q?7dPUDepQBfIUFxKPxEljOCKG1d1cg8kLoGXooEBUEVlfpIj6lJyoXODRtPsS?=
 =?us-ascii?Q?+g3EbSYEgxM65/B4kwEkhFJrDUdDeE8YQN4L5vLM4/nbzgLQ87ie1DhKUAo5?=
 =?us-ascii?Q?eRTqzg06I+p31URHmzpAWF5meoxc8YDKlAu+TLSFDpQri50rOPAQD0KpAV8g?=
 =?us-ascii?Q?RgaTj4PbMtVtfYYFtIlnV/L8cpHtW2lIYzHv8JooMe213/QG1/tlBjJEJaEj?=
 =?us-ascii?Q?gJ6aC/hsIAaW/U4A0AFBTKhotxFAklC4jTW4y5d1wEo/Z+e5IKNuDyTxnVjT?=
 =?us-ascii?Q?AuQPuUNq24Mja7qT46kYBQdkNkU1JSwURMf8LgmxDw/QNqWWCdFsYGAdx+xm?=
 =?us-ascii?Q?cmFa7jdZPs5slYhKvF3E4rHef6Whk/Re9/6DCWHwfbuSEQzectDwGO5gsx70?=
 =?us-ascii?Q?vwMMv2UK9/IT3zKND0cbWBDCRCVGoo+i6DXCBmG01OssJnJe6CFJQkojjqBG?=
 =?us-ascii?Q?Vhzr2HBYpcljjoh6XxqzCKPumByhANyo2w8I17HKIYUt12HUlYI0tSr5aHH1?=
 =?us-ascii?Q?12rOgqAqfeGCRjbYVPRWzPhpmO1xWq8udEiJQo1lR02yALUwO2t18HBeob+p?=
 =?us-ascii?Q?FQMRtDrTl3t4cyXDk3ZUL8M9CMy/lVljUbm1JasvXZzYlL5xukR7UA8FADU4?=
 =?us-ascii?Q?Td/6yUTk8+wbVEVpsisj+c5fpiD9+ZrzQmGZFWQx9mWc6wi9zvHyiY1xJclu?=
 =?us-ascii?Q?EAjJdKNUyOer9UAptYrQKutAQ2gGi0wgQFS9ANdFrohDrkg7p4ka1SZpM4ch?=
 =?us-ascii?Q?6s2e80pkUfDd39Dd9OzioGtTwKmhFGYUlKZ6Q89VYJ1WhdB9U2QxZeVDDOGL?=
 =?us-ascii?Q?EjRFoY2DlYdPBKWG7EA7gUJ1CUt/EAzGWVGfZrFEd8fqvZX20foQWA5Rrp5r?=
 =?us-ascii?Q?pFQtius38sBCzrxgw25k/jxwyMh/ZX7gBzIf/fdM3O11aGd2RMmrh07CFG6c?=
 =?us-ascii?Q?mlx5SoywKmUuiUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:36.6066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74809e57-8ac4-4806-1576-08dd2bbc8091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

Adding support for the dummy sequence configuration. The dummy sequence
introduces a delay between the command and the data phases of a
transfer. This delay, measured in clock cycles, allows the slave
device to prepare for data transmission, ensuring data integrity and
proper synchronization.

Change-Id: I4dc347a247830452754f83e88aa95a7d231722cd
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 08e49a876894..02478e8efc8f 100644
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
@@ -1089,6 +1094,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1300,7 +1312,9 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
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
@@ -1310,6 +1324,13 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
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


