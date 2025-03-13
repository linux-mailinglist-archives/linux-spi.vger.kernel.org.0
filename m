Return-Path: <linux-spi+bounces-7136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FBA5FF7A
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F99A19C3E91
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A71F3BA4;
	Thu, 13 Mar 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QimfJAUb"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8E1F3BB3;
	Thu, 13 Mar 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890988; cv=fail; b=QjTIUCOowDKI1191N2IOoEE7ntLQ4Q5sMqB1vIRgAOLrUYFT0qed4sHn68fXDYFb2Um/z21lMNu42Jk99yFiUhg0mnWzI73uFU6jBgdz62+xy4DzfMsN22AvTjX7B9M93vdFgMW4+o6qkM+CtthhGcXoVhn+Gj2k8nO6KdDrEAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890988; c=relaxed/simple;
	bh=qCHbn0jljENjFOTYbv5MDM3F4Zbo+q/vwYYlQW6/E5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghd2j+ItO2/1T1FMA3YFjM/EROZZLQs3/13+PMGknXS+t4HEOpXvmLhqVkr8jUJ0eFjG/pcm34XZniYDF2Cwh14mZPtgLbXtGeE+o6eE88KK9uXGm4FQVZ8AjfOoQ2HevEbEexgLzC97yscajsubyZE/tbRsdQn1kP+dnPWZw+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QimfJAUb; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKG/r0Xuh2M+F08b0jbjHrqAxBwhtohGboMAzVdVxkQrAnqEH01VTmXbcxa8tbBZmGYq6L4jfmOEqddLSkxhZmyUK5wAXdMxe/3JX4x/pv75lwvv0pXF4vKM2EtOkInMQqA8HTlnLn3ioH8WrFpLFiu+GcDoOwR+DoqsoqeoXRRkrWzxQxefBJuguJv4gnhbquENPf6GkJ3Z9MnWyR1jEsFswU5zqgb+VavZNELOeDyacwXlGGkm8GNI+EEqv1/blvoSnqZZBeNH9XGVBb79p74LlIEHY9aW3yWDMAfpwIjJ2R1LBmeh9gAk85a3c0oGFG2AX1NjZJYQIm2+tjiW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/NGWAQb2kMafGowR5NVG9VlftpZtSA/BYQHec2dauw=;
 b=urLcot3mzCdyP3jH9GwZEYSXAk61eFFszC2PAI4c3boo0YLvYZdEgpZqDWjqTGEHfTg5T47HCwG4NvkZzs0Ine6pgAtbNqRLNrQtvJLnq01uhnp/4i++8JBlAuJuikW6AL1wi90JHnI4tzv3EVRk/x404PZWGF5WBC629Grh5esx0K4K3P5cmWMJinIzDXICqxPa3oxn/UTuJ+HtYG2bZkGzBdZwIwzzSrXYiloX7mp17IsE2GDja7Y9CLRH5ZLEph3hvPXDQAVLE2yOblW72U+41uyHpJ0/Qi5I2Fyru4Wsjd8ny+oWDOafiOstybUmsXItxqe0ALFW4ZtPIb1mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/NGWAQb2kMafGowR5NVG9VlftpZtSA/BYQHec2dauw=;
 b=QimfJAUbRd2uJHEWxHpbw6FpcstQ1HYxOhuHsjhaLSY8icFxd8AUt/3usbWrKFjd1bfAGFYaJEbLy4ved/gIoydwupUMJ7QxHHF58AlYL3RoNIvkcNnFu1Ijf29sp5gYPMpAraWFiPWj/RGt3dCRkThGEqhEqCqz3rgsoD2+Q8U=
Received: from SA9PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:6e::35)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:36:22 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::c5) by SA9PR11CA0030.outlook.office365.com
 (2603:10b6:806:6e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Thu,
 13 Mar 2025 18:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:36:22 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:36:20 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 10/10] spi: espi_amd: Add eSPI PC channel MMIO read/write IOCTL commands
Date: Fri, 14 Mar 2025 00:04:40 +0530
Message-ID: <20250313183440.261872-11-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313183440.261872-1-Raju.Rangoju@amd.com>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 42409f58-a5ff-4f0b-db99-08dd625df43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UG0GgNZDNfz7vdZ/tGZbSa9+2lbBOG9cXX+IsbQ5pKBMAWr/bY1F9+3SLHk?=
 =?us-ascii?Q?A/xZHnf/wYyXF5NJZkb89MWCytfckoViWn+sqwICRO9L3bMkeor1R4HG0JNE?=
 =?us-ascii?Q?OcpTmVnyLMF1QV6PfuNUTl+aKTRAV1cKjZQbaSlpl4CYU2T4TRMbUyearI+u?=
 =?us-ascii?Q?dbe8HeDaP/5Qn9wnsh6mURcy7NY+0By9jS5JPQ4Tuk83dbA6Uq2pUIjbT5nE?=
 =?us-ascii?Q?8H2LJUiStij/ute75OqS2Ly0FGc9/qR0nfieG0ET5d9Yh+gwHaGA8Y7EK06Y?=
 =?us-ascii?Q?j4RSvqK6I/doxakLoLaPXib3GlIAJ/5DrPVMH3Qm7dEZ7PtVkw/94h/sgBcD?=
 =?us-ascii?Q?8NST1LK1UEbdZoahgnJmgPs0P5+JigN856Sp1q3tnFoWjlbU+7VPZOTVdUME?=
 =?us-ascii?Q?dK99kFJTtDdws57BqbdI1iGUUnHiCoU/6IArq9qUB73+E96E3M0JvOBjRdml?=
 =?us-ascii?Q?dN6g0wcWN00jTnjjTrFKgnLbbNN6VIA2xoBIn9YerARZoaDEiCYXavYNq07f?=
 =?us-ascii?Q?0cBkI/UsmvKGR1d5zQiEmsnmZV8Oa7SiVq1eA8GH5hVW0zREZAmfqfsLYS9Z?=
 =?us-ascii?Q?GE8wu+zxEgAA3KTk0uqGoBgIzLlcTnsGmHlzMYzPxOUlXRYDp96hK1YpLUUZ?=
 =?us-ascii?Q?3var4aEJDhD1zhD6kdpOpxy5zXUC25Ab09Gh6Mm/KvGvvrKlnA32jlh8c38i?=
 =?us-ascii?Q?rQHBXa6s6C9TEvXuA+5vuOw1/U+8tSp9A87BwUT7Ojk+moyPQgUgfHYX0QtA?=
 =?us-ascii?Q?qSfssOtVtJqdBQEw73ay/8MU7xcInNXODL8qyrS7i0La4KeD8nwfa3vSIfOb?=
 =?us-ascii?Q?spYJJcmDBzWzeGt3FZ7+x7HlBYaE4LlJMffBjjQuTrnN08iQsNCnPvBWQe7z?=
 =?us-ascii?Q?Abh0lYvEpze3+hKM16yo1XckMjhpCfPDjA42iqCXMJJD6Br6rTnREGDgMzlS?=
 =?us-ascii?Q?a6qhIDRDmL1uC2puwledGPj4wcC6kF5hy9NY/C4h415tZ2XB1XOwWo+qnW/G?=
 =?us-ascii?Q?Fyu/ySCtp2MWSegeOueLZ0ZoyEsAIwgkBfNay6qRwrNIzPh9icmPGv9cLtI+?=
 =?us-ascii?Q?wQpb0o28Q6PB91GfaK1aWMnQFXXuwTg5S3peTnFm8MVf6Yy2Q3prskjXkWbH?=
 =?us-ascii?Q?9y6ZGuWUpVYreSwl6KS0N0H1PrNPk18KsAKIWkvvlOQG+T7ingbeVInGUC3I?=
 =?us-ascii?Q?7WkpYHoj0XY0mRbFfPZlpMlB08D+3AnJdc/V8MwAEkKrK6/Nh0PDe98laHn7?=
 =?us-ascii?Q?7Al4aspzunNaNU+urNmVLuy4LqORNJdY0v+ebtqNpk+Vp++7zYMA9MO4r3Ew?=
 =?us-ascii?Q?YeUo5eavX6bYRmzfouDpmkcRErn37N9APHle1TubQJtAHuuaF6rWcA1IbsOR?=
 =?us-ascii?Q?tKa2gW0RHdoKEc9C7muMzrb77CxS8KMx0c+TOdxUquh8jCQ8h9IUu5XnNmIA?=
 =?us-ascii?Q?kHyJtEu6KZLcvkAIjylsoVJ1efxOrKNknU2ObSxEHcJK7RJQO1+weQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:36:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42409f58-a5ff-4f0b-db99-08dd625df43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

Add new IOCTL commands to perform eSPI peripheral channel(PC) MMIO
read/write operations with eSPI slave0. The changes include validation
of MMIO address ranges before initiating the read/write operations.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-core.c | 80 +++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd-dev.c  | 53 ++++++++++++++++++++++++
 drivers/spi/espi-amd.h      |  9 +++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/spi/espi-amd-core.c b/drivers/spi/espi-amd-core.c
index 18bfd2ca2316..31069e86c704 100644
--- a/drivers/spi/espi-amd-core.c
+++ b/drivers/spi/espi-amd-core.c
@@ -805,6 +805,86 @@ int amd_espi_periph_io_read(struct amd_espi *amd_espi, struct periph_io_rw *msg_
 	return CB_SUCCESS;
 }
 
+static int is_mmio_address_valid(struct amd_espi *amd_espi,  struct periph_mem_rw *mem_data)
+{
+	struct io_mmio_decode_config io_conf;
+	u32 mmio_end_addr = mem_data->addr + 3;
+
+	amd_espi_get_io_mmio_decode_info(amd_espi, &io_conf);
+	if (mem_data->addr >= io_conf.mmio_target_range0 &&
+	    (mmio_end_addr <= ((u32)io_conf.mmio_target_range0 +
+			       io_conf.mmio_range4.mmio_range0_size))) {
+		if (!(io_conf.io_mmio_dc_enable & MMIO_DECODE_RANGE0)) {
+			dev_err(amd_espi->dev, "MMIO range0 not enabled for address: 0x%x\n",
+				mem_data->addr);
+			return -EINVAL;
+		}
+	} else if ((mem_data->addr >= io_conf.mmio_target_range1) &&
+		   (mmio_end_addr <= ((u32)io_conf.mmio_target_range1 +
+				      io_conf.mmio_range4.mmio_range1_size))) {
+		if (!(io_conf.io_mmio_dc_enable & MMIO_DECODE_RANGE1)) {
+			dev_err(amd_espi->dev, "MMIO range1 not enabled for address: 0x%x\n",
+				mem_data->addr);
+			return -EINVAL;
+		}
+	} else if ((mem_data->addr >= io_conf.mmio_target_range2) &&
+		   (mmio_end_addr <= ((u32)io_conf.mmio_target_range2 +
+				      io_conf.mmio_range5.mmio_range2_size))) {
+		if (!(io_conf.io_mmio_dc_enable & MMIO_DECODE_RANGE2)) {
+			dev_err(amd_espi->dev, "MMIO range2 not enabled for address: 0x%x\n",
+				mem_data->addr);
+			return -EINVAL;
+		}
+	} else if ((mem_data->addr >= io_conf.mmio_target_range3) &&
+		   (mmio_end_addr <= ((u32)io_conf.mmio_target_range3 +
+				      io_conf.mmio_range5.mmio_range3_size))) {
+		if (!(io_conf.io_mmio_dc_enable & MMIO_DECODE_RANGE3)) {
+			dev_err(amd_espi->dev, "MMIO range3 not enabled for address: 0x%x\n",
+				mem_data->addr);
+			return -EINVAL;
+		}
+	} else {
+		dev_err(amd_espi->dev, "Address 0x%x is invalid\n", mem_data->addr);
+		return -EINVAL;
+	}
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_periph_mem_write(struct amd_espi *amd_espi, struct periph_mem_rw *mem_data)
+{
+	void __iomem *mmio_addr;
+
+	if (is_mmio_address_valid(amd_espi, mem_data) != CB_SUCCESS)
+		return -EINVAL;
+
+	mmio_addr = ioremap(mem_data->addr, 4);
+	if (!mmio_addr)
+		return -ENOMEM;
+
+	writel(mem_data->data, mmio_addr);
+	iounmap(mmio_addr);
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_periph_mem_read(struct amd_espi *amd_espi, struct periph_mem_rw *mem_data)
+{
+	void __iomem *mmio_addr;
+
+	if (is_mmio_address_valid(amd_espi, mem_data) != CB_SUCCESS)
+		return -EINVAL;
+
+	mmio_addr = ioremap(mem_data->addr, 4);
+	if (!mmio_addr)
+		return -ENOMEM;
+
+	mem_data->data = readl(mmio_addr);
+	iounmap(mmio_addr);
+
+	return CB_SUCCESS;
+}
+
 static int amd_espi_get_master_cap(struct amd_espi *amd_espi, struct espi_master *master)
 {
 	u32 master_cap_reg, info;
diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 184ffdad4a48..7e4477dd17e5 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -372,6 +372,53 @@ static int amd_espi_ioctl_io_read(struct amd_espi *amd_espi, unsigned long arg)
 	return ret;
 }
 
+static int amd_espi_ioctl_mem_write(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct periph_mem_rw *mem_data;
+	int ret;
+
+	mem_data = kzalloc(sizeof(*mem_data), GFP_KERNEL);
+	if (!mem_data)
+		return -ENOMEM;
+
+	if (copy_from_user(mem_data, (void __user *)arg, sizeof(struct periph_mem_rw))) {
+		ret = -EFAULT;
+		goto mem_write_free;
+	}
+
+	ret = amd_espi_periph_mem_write(amd_espi, mem_data);
+
+mem_write_free:
+	kfree(mem_data);
+	return ret;
+}
+
+static int amd_espi_ioctl_mem_read(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct periph_mem_rw *mem_data;
+	int ret;
+
+	mem_data = kzalloc(sizeof(*mem_data), GFP_KERNEL);
+	if (!mem_data)
+		return -ENOMEM;
+
+	if (copy_from_user(mem_data, (void __user *)arg, sizeof(struct periph_mem_rw))) {
+		ret = -EFAULT;
+		goto mem_read_free;
+	}
+
+	ret = amd_espi_periph_mem_read(amd_espi, mem_data);
+	if (ret != CB_SUCCESS)
+		goto mem_read_free;
+
+	if (copy_to_user((void __user *)arg, mem_data, sizeof(struct periph_mem_rw)))
+		ret = -EFAULT;
+
+mem_read_free:
+	kfree(mem_data);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -422,6 +469,12 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case ESPI_IO_READ:
 		ret = amd_espi_ioctl_io_read(amd_espi, arg);
 		break;
+	case ESPI_MEM_WRITE:
+		ret = amd_espi_ioctl_mem_write(amd_espi, arg);
+		break;
+	case ESPI_MEM_READ:
+		ret = amd_espi_ioctl_mem_read(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index 4c67aa9f45a6..9e084bec8ff5 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -178,6 +178,8 @@
 #define ESPI_DS_IODECODE_CONFIG      _IOWR(ESPI_MAGIC_NUMBER, 0x9, u32)
 #define ESPI_IO_WRITE                _IOWR(ESPI_MAGIC_NUMBER, 0xa, struct periph_io_rw)
 #define ESPI_IO_READ                 _IOWR(ESPI_MAGIC_NUMBER, 0xb, struct periph_io_rw)
+#define ESPI_MEM_WRITE               _IOWR(ESPI_MAGIC_NUMBER, 0xc, struct periph_mem_rw)
+#define ESPI_MEM_READ                _IOWR(ESPI_MAGIC_NUMBER, 0xd, struct periph_mem_rw)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
@@ -382,6 +384,11 @@ struct periph_io_rw {
 	union io_data data;
 } __packed;
 
+struct periph_mem_rw {
+	u32 addr;
+	u32 data;
+};
+
 /* Function prototypes */
 int amd_espi_device_create(struct amd_espi *amd_espi, struct device *dev);
 void amd_espi_device_remove(struct amd_espi *amd_espi);
@@ -404,4 +411,6 @@ void amd_espi_set_io_mmio_decode_config(struct amd_espi *amd_espi,
 void amd_espi_disable_io_decode_range(struct amd_espi *amd_espi, u32 io_range);
 int amd_espi_periph_io_write(struct amd_espi *amd_espi, struct periph_io_rw *message_io);
 int amd_espi_periph_io_read(struct amd_espi *amd_espi, struct periph_io_rw *message_io);
+int amd_espi_periph_mem_write(struct amd_espi *amd_espi, struct periph_mem_rw *mem_data);
+int amd_espi_periph_mem_read(struct amd_espi *amd_espi, struct periph_mem_rw *mem_data);
 #endif
-- 
2.34.1


