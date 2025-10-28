Return-Path: <linux-spi+bounces-10892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B4C15660
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5993505B28
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006233C53E;
	Tue, 28 Oct 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HgiY6RPK"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2333DECB;
	Tue, 28 Oct 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664572; cv=fail; b=QTNfxtrQ9Ypd0atdzpZiw8CRU1+vYWbecOlSeHHW7BEdH806mu9X7+Sl3KdOVZJmAto1jhK8qzp7H6Nq7ND9aVDBrVa92VTG6JETAhTqScCGn3SKfV0TaNTm9sX9Aw4ekPGyNuQv5b1yr1afcBL5kQUx9FcLZ214nfJhPtMbRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664572; c=relaxed/simple;
	bh=IGJwx5jK6OrH2M+NWR/c/WMMpQtLjfOir2T4kGyAkIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUZJWVG3Nz/w96+gvxwF3mkg4y7cxTonrsQOo+wcbtDYndac9LZoQhcBMSdot+qDepBeel8um9RosZKV3XyDLfKOBrgbfDvWuTcl9WUyNbia/C2AR0jEUU8OjMsX+9CfdwDsyj9hZOEnqkFYGlE+XLMjBxCGUKRE60tDcz9CyZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HgiY6RPK; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUCaDKi7KPx5Kul/S6h33HNb1233EFFSWr2DATsihXkJSvuvZVY6oc463yjSquWYJJ/7pBC/cTwzeLq+Bi/h9jyVA1vYQ8WeKytIb/X2gjfby19+hvJcRFS/fi+kVrcSkMryXn3dI2sn5gLrpU2ZmziE1bZOBQOD0gwHX8b001KqbDMMC0dMeU0LdhWRHJD6Esx6kLx0SZ3cJyZvAPFPVlVguiR89hK8iI7i37yGOE7kw0HCkMKC4noK6FsKkClFqldh6/oR3zd71sz1zN5dmGaOEN8230LCRjggK/6CFJRJyTuMYELRdZtT/cl5o0PRiWj2CXh3dvpK5ng52ImQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=WKUrLGOZ29+2E0Z5c4phH3alxdCA3faje2To79u7V9i1GD8JZkMTMK29AJTzRT+8//vK0WNxKYfTjjLy1UyMRAHqRp/uZ/UU34fRcHVXBiX2SnyI6T0mhmH/7P3FXGirhGONe/DsgOsh6hM4cLZ+kXiDlSWAtDEbSTMjxkIDw7JI6w3dxnS825yfgUJNsTj7tv6m8LmY8Y3hUEhNtwBdGljOkmnahy64e+RYp/JHUKgAm5ruBBHN0VgH2BE9Hz4bXSmpSNRZj5Y1dDr749DT6KtJ6x2UNH7qZ/bwcvo4iYwnfG2mg2845ZfXbVhxFgl+GJeqEMIAvcDWqRlS0kNTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=HgiY6RPKowx360vuYho6w7ZzjJp2vcfntddido25chIGlP6IOyjOPdR3t+iYMSXpTsf6V02cJ5O1Tyo5ktG67P/ACZAGsU8q6Ecoun5jdlS8W7egwZXsrxeG+H/tGQZQOsSI5Qwl6EJC6pEqrok0FUAiK8l3CGpw8Pev8GfQAO/nU8nckurg6pr48yMR4nasaoMwEBrk7m+3/YVcHwoVFFsQv3cM6j5hBPTB4c2pGRjG+bnlTwb00uudXVWyauVfrK+YxTgeFqEijdh50aZC6o7McBXHnj84y9iueMSeev4b8YC0JG4oGBLEAQCLmKG+uTHvW1fHywUjgC73mgtOFA==
Received: from PH8PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:2d0::16)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:16:01 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1c) by PH8PR02CA0024.outlook.office365.com
 (2603:10b6:510:2d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 15:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:16:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:15:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:15:29 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:15:25 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v3 1/3] spi: tegra210-quad: Fix timeout handling
Date: Tue, 28 Oct 2025 15:15:13 +0000
Message-ID: <20251028151515.4142618-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028151515.4142618-1-va@nvidia.com>
References: <20251028151515.4142618-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b9b876-55c6-4bc5-a58d-08de1634e6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYeNIzlzKhjdTIzGWZMeCpkiVJ04gSs4gobafyMHs1pf87TH6N0v1XW9vK40?=
 =?us-ascii?Q?zKtFf8bBlJ3E8DBzg2tKqSuiabTcpUVjdVDCTIc6/RtEZYjDDkNFVAtm7gZt?=
 =?us-ascii?Q?1FKeKGcs9O23H62QPzKImHJF2tNsxCq/4/Pl5QDygtl5gUUA8/m7LxogmPJR?=
 =?us-ascii?Q?GWfajliTlAIE9h9ZuXiyoZDMXe8US7GJrp2obJI63Xv7j2cNTMfxZcTm5feh?=
 =?us-ascii?Q?YKCu/NO5L9WhosbVmr2Cyou6YYqffL9l2+v3G51DoCvi3/naB8OmAtF2SZPw?=
 =?us-ascii?Q?v1kLXyFpdaazpz1ydvzpfj9BTe2G+3Ayiiod+vSk0oM+kyQ8Na/GEW5ESxhn?=
 =?us-ascii?Q?u7MkqoxpEVE5ZDSPTX9F0l4pwW/UPNb7KtfUV2tS9jbLU6bqi7/hxE/Ayu6Y?=
 =?us-ascii?Q?dUP/Z/fL/pjnlPD6MSCJ1fBc/oJEElhFYfLi/0l7g0dioqrRnuZ/pS8Na0wh?=
 =?us-ascii?Q?Pwvue1pdGJuyx7hP+vF/88A2v8KPLN76BhyZnG0LP69SKmzpv5ldYpOinLmQ?=
 =?us-ascii?Q?XAndTITSqskOgr/j3/I+evCEHnxzpoxxEHzzOiAr2Xe9Rm8jKOkUtQlmmDMY?=
 =?us-ascii?Q?vQrpDE0NxG9vDrVIcIyk97yJ/2B4YvAX1xGvg44oDVqvMMUvvPup9f8/UcCV?=
 =?us-ascii?Q?wHZtYB/o00xbboUniX8/NeGlnTxTMx6afHh8TA4ZosK0jbK75H3w9hMJwhiz?=
 =?us-ascii?Q?eU7HHW9vWl4R/KnDBe7nkkPvP1nTkRki0BlieaeiKK7+iimDphYnOmBEHV+m?=
 =?us-ascii?Q?5qEPCB5xy6mbPQDGiNDzRC8vydKTJx6IGf+sXmWubjXeSaB1HNGZlC7ouSKB?=
 =?us-ascii?Q?pr6r1WrLVOaTfJz++Ly0UGEfo2HqTq3mtLOwp/5I6tfz3XCPFvalyM2mz6WU?=
 =?us-ascii?Q?G3NDmNW5aZA3oy9NOYSCW8ye+lnF3KEFBGqhjkUJh+EmqxDp9SN2tUxXbpo9?=
 =?us-ascii?Q?Vv4Z7cTTL57WGkqQDOqtdUx4hAhyqxbomUAsAz58F/ZZHvtZq80Y2mTAC498?=
 =?us-ascii?Q?SEnQOnUzfldwxm4nQWAVPT2cWXo9rZ3oZe9LRIH5WetlWm6wvKpbeb3fWDjC?=
 =?us-ascii?Q?DHSeaUuqxI44qps37MxEP5z3Ig/uS1tDqZkYsN8U7ksiocM6wuY30aPiolze?=
 =?us-ascii?Q?3xpOmnXST1pxuHCwsq2dOMgedFM634XwBdSsyshrtTMOa6Uj/MGgQhKcPtPx?=
 =?us-ascii?Q?ojgPu5RIsJPADkOfB2RbSlrbmnW6rScLgF89p9YyY+QJW8cePOjBaCCQgs1/?=
 =?us-ascii?Q?ERQ/Z3M2YTByWLwCBb2zPZIdlPSZd5nH/Trey3CY6lgBMgluOwY2rhotTiOE?=
 =?us-ascii?Q?z80tuXABSEzBEZgZ2VDB+3U9q2djsWGfxWrj8/RXzvLSc0wJbGyQuXWO46Ue?=
 =?us-ascii?Q?87+h1yTr+CfbOfRCiEQGb7WLZE8nIx8eyMg/thm76Hl+JMyxcpeRsTGeflso?=
 =?us-ascii?Q?VjR61Mh3WkamRrXS6sP8KFs+GDdr62aJ5fnUKN/3Q5BlgzEyokvJ+2UTCRSi?=
 =?us-ascii?Q?btm36RJB0wKobYCWgLdIzwlbbNnDkMiQ4oiahxDuTBMvb4ggZgudiXUOPOaY?=
 =?us-ascii?Q?g8EBDWS93pqB9K2HXNY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:16:00.0680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b9b876-55c6-4bc5-a58d-08de1634e6f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
is excessively busy, it can lead to rare cases of the IRQ thread not
running before the transfer timeout is reached.

While handling the timeouts, any pending transfers are cleaned up and
the message that they correspond to is marked as failed, which leaves
the curr_xfer field pointing at stale memory.

To avoid this, clear curr_xfer to NULL upon timeout and check for this
condition when the IRQ thread is finally run.

While at it, also make sure to clear interrupts on failure so that new
interrupts can be run.

A better, more involved, fix would move the interrupt clearing into a
hard IRQ handler. Ideally we would also want to signal that the IRQ
thread no longer needs to be run after the timeout is hit to avoid the
extra check for a valid transfer.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..d9ca3d7b082f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
+		tegra_qspi_mask_clear_irq(tqspi);
+	}
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1176,9 +1178,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				}
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset(tqspi->dev) < 0) {
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
+					tegra_qspi_mask_clear_irq(tqspi);
+				}
 				ret = -EIO;
 				goto exit;
 			}
@@ -1200,11 +1204,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		tqspi->curr_xfer = NULL;
 		transfer_phase++;
 	}
 	ret = 0;
 
 exit:
+	tqspi->curr_xfer = NULL;
 	msg->status = ret;
 
 	return ret;
@@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		tqspi->curr_xfer = NULL;
+
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1395,6 +1403,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
+	tqspi->curr_xfer = NULL;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -1480,6 +1489,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (!tqspi->curr_xfer)
+		return IRQ_NONE;
+
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
-- 
2.17.1


