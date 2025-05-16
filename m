Return-Path: <linux-spi+bounces-8149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAFAB99B5
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366FC4E3AC0
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB9381C4;
	Fri, 16 May 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WT6kdhLB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98148231839;
	Fri, 16 May 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390056; cv=fail; b=eGcUSmwXtN35nrRwpJ7aAUtlB/Nx/2AzCwCwa5o0o2V87PHOW6AvZBcEouIkd9qXsugJYOKGwfJKVOvEoqyx0TJtR5gS16TNTaHpIL8y7+9QPAhtSH4VJSenVYIFxor9jdoqkDe/Ud9Uh+uOMY+YUc1pLBAD8nZ3nO42XcZDq9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390056; c=relaxed/simple;
	bh=CQM5v2r8Xox3fmjW51lCxcrgp+B1IKL1VbK+aW5LTrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKREmS4zodSG3wuGLQjBVU4ekVcwiBN/Rw0uiaBgd2+qUzB8AbnV2MuYITm/KJx8AkCUmreNfM5AyxLLPDVo/33bsYJJx4G6wauBHQLAph7QwqN4qiPpZ9hyyc48GWy4Qykrjv2gHJ+XButLFkvMLd+fQ8V2Kn+kGzzi0/3APVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WT6kdhLB; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfCt9AJVI8yqJB1neiQzBnoaVTs7b+JV3ySVSiyCYwXs9h6AdGMCTsJt6W3KKVbLP6fnz7H09qSp03kgsQI8Nx/jPZK0NYB9kyVQaZDmDa32iI6XXHbGxslo7lMSu8nWKIPLHqHXb5aBBN1yDoiuCXzgHMIbu6qhfuj6A7Tm3zQaEeZVroEubBDqICvC875QjEHBW3UyyOADeBssrMLEIM65NcM7SnI/8pezCVHKhkRH7HWABYTpE1gZG4871e6RQkZ28nYIQsY4CblrdBtYCHmZHhsrUGUStbOR9B8Eot+S83WUvFruJIwrVxzHaNnvxMIHccNz7EALSFA05NjwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wJ06sJotHs+12v0ZyGmuf/tZyolROxcDLLYuW2J6Y0=;
 b=Eo5flIxd8GpuYb8Ffod5TGFxhmNO5NIFW2cF2MsogV7dOLG7ZezG9Bp/fyJ95Wq2WJy51XDrK8JPv3HXtikyX5wihOCii9SyZmS5D5E/hYllhO3eNmVByf1RB1PAfMqKNrDyEDJRsQaJuMRVSmE/cQWQ8XYqEQojBu+Bovd89SEzq1jYmjQEow7OhMukVuDaFEYFnheRcUNvOZexv+EdnJCvOgxG4z0z3KxCeA1+BXqi2HWz7X15VmlTLFxntrJ+vrXSN07xpKK1YH65NgVI5GlTtIPNadVUuTv/7X/fny4a6pE6eezz9cQD+QcXsm5Qhi6tcvkOakAURDhn8bnVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wJ06sJotHs+12v0ZyGmuf/tZyolROxcDLLYuW2J6Y0=;
 b=WT6kdhLBUwQwSBvbTqNuTpxjfAFrOZCZcRQ9TKa8elYhBveCTglQ8rwL2tcnM9G+mNJwiKYI05p6r9yRCcJNIS0vSnZJ1ePuadUDW11i8TfFyf+ZS8Md2fRkFD7xO+TbagRkqp/u1e9KyOjAEvUTsANbB5u9qynXTA4ZdHvIbYA=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 10:07:31 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::7f) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 16 May 2025 10:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 10:07:31 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:07:28 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 1/3] spi: spi_amd: Remove read{q,b} usage on DMA buffer
Date: Fri, 16 May 2025 15:36:56 +0530
Message-ID: <20250516100658.585654-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516100658.585654-1-Raju.Rangoju@amd.com>
References: <20250516100658.585654-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a69741-01a8-4d40-61c5-08dd946178c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5OWPVE77+lMOeG5polnYLQjElvgCG4vO8BTdyvbOmRR3ejJaJwdoriPfxJM?=
 =?us-ascii?Q?tILGwaSEbfsIcC727F53bbd93tovCV1osT56iY+DPcmeO27K7yz/y5ZXiTi6?=
 =?us-ascii?Q?PGbOjtYMCnadmxYxI/hCILIW7TYsUGL9QkzpVEX7ccifF5Sy2B5jGnLNby4v?=
 =?us-ascii?Q?TiUKJ1eEwoLSY7DzxVoT8r0UHbHnFry5WmMJp/5GLzQFS8b5NUSGv30OSMM9?=
 =?us-ascii?Q?D80zl0y2zVCFo/8BKW0ayOLvbkSyV5lRntaF+MQcFdHerrn3dE31DVnX4USH?=
 =?us-ascii?Q?BRE2DNXGIRqZbpHFa70LcdgqYXvW5ddGFXiThyaV6JvNhg0ZsSgk3dDopD+u?=
 =?us-ascii?Q?I7IpMoTW8n1m8PA0NdvvoLUdm0uEDE0vUZJmTLyj2qCKsHPc9h/rEL/neVRL?=
 =?us-ascii?Q?N4AXJ7nLcvrQsKXmTawKE2kNX3jONuwWvxio1RPlnMHffaT4fay47QxicZm5?=
 =?us-ascii?Q?RRiWftclowhmy9g8TFxKKZg3WHxtp5mjoqzDxtn4esKSn9Tt4bGOSef0Y3Ni?=
 =?us-ascii?Q?yQHL1N1BJV3qKb0ZRUphBeAYERWTeTu/pie3Z2MBRmFsAoEcbv4y6VYLq0fV?=
 =?us-ascii?Q?2avFRQ9eFseX3RAqJX6nPa3hCmPnJtTMjpd5Am/h9JDs371ZAixkXv12i97N?=
 =?us-ascii?Q?Ly/mcKYhXWUUWu0UNgAM8cwosqtfAwCpGXDKC0mASq9U7IIPn0skbLf3IP8c?=
 =?us-ascii?Q?yEwA0S4SbqucKCF2y2rgvU+Z6Cik0uFyZPFYGADk+ljI+kgAjrgIAcwgro4w?=
 =?us-ascii?Q?jFm4FwQjQ+77y3tpU3SylV5HO2VitoBVYSZ9d7jI6ArCQBCY/45ld64794Ox?=
 =?us-ascii?Q?S7DdPHXo0vbVbJ+3v3dk9TPM18jLWnMh6FCdhvAQBtPdl6Re0NP+JgGdp89L?=
 =?us-ascii?Q?npJeY2ebkPIq1NhyAElSQcPZ6BWh+7Tx6f40aS+9z9SI1gApfChEvl0EoKOa?=
 =?us-ascii?Q?uyGARK6HEDn8fHkQL6/lptJvLX7kFsOqZhY5xl2v8baDpGpmi2TV4OIl70fI?=
 =?us-ascii?Q?qB/tHlqN3XZJRFsLyyCPl79zJWj8jfuowuhyrM4LrMDfIamiilU4xRVX+sAn?=
 =?us-ascii?Q?IMGhmVxUuRsFAnrOE6smA6fAIC+cl7EStlKpfx+x40GTklgrcfBQaiP1i2e0?=
 =?us-ascii?Q?y0qSodWVcYKjCXnFnoamHhPAbgeVXnhjfrufb/kL93jml5JQDiTSnA1LE6v3?=
 =?us-ascii?Q?JX52QwunQdE869ijGecwlkscmorDVq69k/f/GZaXvhl7K6Wd7YrcxMi3gNDQ?=
 =?us-ascii?Q?ZC8nL5HKH/D0E5ur6i2Cbsu1aKTEyt1aLNv2SidGxKcSFvyvI92k3Jw9hEqk?=
 =?us-ascii?Q?WvfdWUy/E4YFAcineLzFxTazrsOu0ODFqo4YSMEA084v3/u0xj37Fzdu4+LZ?=
 =?us-ascii?Q?foYFE8vqkeJ/VFzpjdSDertDn7BuIv/OjoqS138M9wQtZtW90QgMwdA8wDEU?=
 =?us-ascii?Q?sogfgGUOIewfXFKSj1mlgcEMZ2XUk47ddOjIQDM99FRyj55bPZg6Tq0xG1Gc?=
 =?us-ascii?Q?5Y09pPX1WWtZvswsx7N7aVkIs8A3dk8XgMr9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:07:31.3953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a69741-01a8-4d40-61c5-08dd946178c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

Add changes to replace the usage of read{q,b} MMIO accessors with direct
memory copy logic for reading data from DMA buffer.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 90b1f7daa072..52d893d41b12 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -590,15 +590,21 @@ static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 	 * Use index mode otherwise.
 	 */
 	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode)) {
+		u64 *dma_buf64 = (u64 *)amd_spi->dma_virt_addr;
+		u8 *dma_buf;
+
 		amd_spi_hiddma_read(amd_spi, op);
 
-		for (i = 0; left_data >= 8; i++, left_data -= 8)
-			*buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));
+		/* Copy data from DMA buffer */
+		while (left_data >= 8) {
+			*buf_64++ = *dma_buf64++;
+			left_data -= 8;
+		}
 
 		buf = (u8 *)buf_64;
-		for (i = 0; i < left_data; i++)
-			buf[i] = readb((u8 __iomem *)amd_spi->dma_virt_addr +
-				       (nbytes - left_data + i));
+		dma_buf = (u8 *)dma_buf64;
+		while (left_data--)
+			*buf++ = *dma_buf++;
 
 		/* Reset HID RX memory logic */
 		data = amd_spi_readreg32(amd_spi, AMD_SPI_HID2_CNTRL);
-- 
2.34.1


