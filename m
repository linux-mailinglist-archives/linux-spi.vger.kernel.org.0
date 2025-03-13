Return-Path: <linux-spi+bounces-7131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D0A5FF6B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434863BF5AA
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EA1F0E44;
	Thu, 13 Mar 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glRM6pDA"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF61F2BAD;
	Thu, 13 Mar 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890944; cv=fail; b=luzieCqyzQh0ghfFWYyit+xCWPY1nf7cOCLPb4cGYrAiTv5NpcDo3ALPkxjmJxGfPZX2+4v6jzskAGAiFf911M/q6acOUPcPtoMfWIewA8OlgJGLmifelpHYwKfw6R+QDSXSW6kXkcOOTrRNR0lQl8GYIvFYuT5fXJcS91OcVns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890944; c=relaxed/simple;
	bh=i1QxYbHD/e/CuDf8e2+/vBR6uwxdqYNhjckKZmuvEEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUp4oYmhXiKq+Y6Ga74fvljilyFwJtie8UVLJfSleDULJ93pD12vhfm7eWmNjMpmEw7pm+fOLnxZ/Wj6S/GXN3wtui6UBXTaXOQ50q41wqR/JZKi+eVU4RvRN+6VRTkneiw3OG1QTHUmqnypsr5J1F/6fRCVCHSk077dr8epdmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=glRM6pDA; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNbeMuN6md3C/cyb8RIPb4tTXNF5j0PhS9yOWb7PMPs7VfTDtugs78vkKuWMv9b6Qqw01towMFYJIRbXvyiR1CWqPRY+KfxYbyBTHsVR2zFkegvJhFsWwbOEp/Ke76AADxWQTYPGMaPi6QydGuWWKYsVxRZFGHeHpaZiJHbbUCJ612Z65MfijktV4xN9ioGE2ffSK7rte3q1gEOSTlSBS+vANQHiGWbrq9/QedYNTWhJBzPP+vcUjpN/U8L5RPoL4PLmNkUgcVkjA5z0DrY8qPeX4bpg5oKojtH9WHtHv/Dy79R3AoYZD1j+LNr/Jwatr4yaLHaSLjEgMcle2CKggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnsRLvT1WuALmKJeuoBBHZb3siqg0EMnYqQkWLOQUMk=;
 b=Ks+sUbvhvjChXtHRlikYgppIltw0LOXBBxJWIn963fUYnCJ1J5YHPjODhttS5QgDdpr2t7av+/7K6E6ytqlwnLdzA9Bhs9O1fOEaOTauUgPReHi6Uea+/N5kd9OFJQfY0UpShPhwSmTCc92Zjt6JPY3Q/qG3QkUy7SYQI/GvElx2oUTqmxbcS/Ez0wPhMwTpkzG9VlDF4ZTxOTRjgxvHnUWNxW1kskwAL6CMH2jlzanug5tvTG33vvNiq8eVF/3BvRHqOxSNwzervz9dZ0KLu2uvvvaXdPJb358KbXSQCqodSe50+V1hEtSvDNZwhH14lbI/elIX+OT0WU3t9GDrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnsRLvT1WuALmKJeuoBBHZb3siqg0EMnYqQkWLOQUMk=;
 b=glRM6pDAn6OsVPsO5+Oe82HHenOG6oK5pH/ahAnPHSNG59UqhQprGRxllo1hjLmN7MaLeM20AZQyheBBb4KZ8b+O+KiVS9ziuIwy8RSWQFT5tLv83DyKdtRnRHx+SCaAhQh3R+9vwtCa9kHSDJw4Lf/YjHFSJ58pV6P53uvOaUE=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:35:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::b9) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 18:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:36 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 05/10] spi: espi_amd: Add eSPI set IO mode IOCTL command
Date: Fri, 14 Mar 2025 00:04:35 +0530
Message-ID: <20250313183440.261872-6-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e4fcb-db18-46e0-c0a3-08dd625dd90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4yN6VB3s+YAj+ytQSyuaOB7DzOO+PAB8LfKcVZW+saUu5mIyjkfKKen1iDG?=
 =?us-ascii?Q?W8BTP0y32wAmU5M6sQ3nhdS4AtZJ7zS+W8Dif4D599BK1DTu1BvNf2IbD+LT?=
 =?us-ascii?Q?VX1Z4bZePsRy0xUuxvNC7GvOYjXq/0jfFgdE85XFwB/7weCmbtwxI5zR7GDo?=
 =?us-ascii?Q?/iacy3K8iBHUkLFTadW6ZMrYbIKNq8v7kLCRdnmMF1zMQHM/GA136UeA/C4i?=
 =?us-ascii?Q?HFmUoHhDyUt9bn17sELiLMtGKah3b0DcS2j2xSRjlzDwG2onPojSkfZnnsZg?=
 =?us-ascii?Q?sVfLAbJACLqaw23vL5VohNuozioU7/EiNQUS517+c2MDStEG14Sy8DBma/yn?=
 =?us-ascii?Q?kCultCgaVzr/pXsMZIxkOzarnRAIKHHW2nWUMZph0FRh6EUo4QJZL+pOz++f?=
 =?us-ascii?Q?wmk+bEXuo6wMjs34ku1r2vaWTMiljbTtjVnl3/omXa+xnOo/8kCW0Yh0XGJR?=
 =?us-ascii?Q?I+IixOUGXdjWZgkqz+PzNLD86QR8kbRnEnlWTcKKxcXOjcmsRL6AMByzfYfM?=
 =?us-ascii?Q?Gw5fW3qadf6vUKevXZcAPBn6wWi298pQP7wNQvrXnphvSPkeDwGPvw51tlDk?=
 =?us-ascii?Q?lQaPY+rigKifbE7rEapvvamxxWuyjhtoQhn5fZFEykT1CkANboMZhpPxA9iR?=
 =?us-ascii?Q?eo8WLi6zxQ3ZTCPLfTzKSarVCBoH0nHulIqML7jgtbqGlmJsnjxrQRM9y6Rc?=
 =?us-ascii?Q?W2F3sIj+ZkWNdwsnNhwz43TCBHoy+W0LmfZ9KoqRe+YWrC8+zS1QuqGtOQNo?=
 =?us-ascii?Q?tUuJ1yOiEDgULef26O84Rn/jYHU8fyKC8N6PaEEyZ9KkTstNkdFZKr7EtuRt?=
 =?us-ascii?Q?dPrFqL5kcRaewgvz81KSLb5UUAKvJrMJ4+jbp2KW8+4yA5Ya1JS8v7/Fighd?=
 =?us-ascii?Q?wPBwLyGZ1g5SILN9ZO3CeezCaOD4U/p3degsqFp1+PR4zeSv/XJp0JyBt704?=
 =?us-ascii?Q?8l46GHT633f60IOIVi6dXzYwYOHI31/ZPLLHNJL7dVd1LwpTeAxM4YXLbV99?=
 =?us-ascii?Q?e0wF8HfUO0xB2tH6yHdiiPttsun2iHQFQNoKRBLadKFCDePtJgEcEHJhuioX?=
 =?us-ascii?Q?7hlrxSJ+sDj4KK0tpGkcF7hrZRzKqN6X9Hm0Jun2Nx2VBskaURW4zH3DrULv?=
 =?us-ascii?Q?x7QMy5YEIex/VYC2UVPol5Br2opfozc7FecOgRMPPsVjekxPaWfIj2LbZz2h?=
 =?us-ascii?Q?XdHP/gSszSIxfe1FSRXLc58gpfr1oOx38C6amsyMkoH0OBIM6NW5uwm6jIqF?=
 =?us-ascii?Q?fL9iFyYjnQhvlLbn8vGbLy9rqIhVJ5d6L2kPxhnJLN6WfEGzOYHJ1JnVVhTH?=
 =?us-ascii?Q?0cfX7BWQFHnPkeFOiCyW53FMmiz57cjGgnpnD/rBT9Miw/y0J4Lo440dSTk6?=
 =?us-ascii?Q?0WhRdQnumSbun+z3u/pyDPvxqR5HooHyLeMtsMQPyoSuBGXzOhDhw90U/7Wk?=
 =?us-ascii?Q?eDmOKKrUzn55n/fZIF/WkevmhNtO8mz77Re9aBwj0TShiLrVjxd5Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:36.8694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e4fcb-db18-46e0-c0a3-08dd625dd90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

This patch introduces an IOCTL command to allow users to dynamically
configure the supported IO modes such as single, dual and quad modes.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-dev.c | 40 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd.h     |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index ba2becdec8e6..821cc0486657 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -166,6 +166,43 @@ static int amd_espi_ioctl_get_conf(struct amd_espi *amd_espi, unsigned long arg)
 	return ret;
 }
 
+static int amd_espi_ioctl_set_io_mode(struct amd_espi *amd_espi, unsigned long arg)
+{
+	u32 ctrlr_config, slave_config;
+	struct config *config;
+	int ret;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	if (copy_from_user(config, (void __user *)arg, sizeof(struct config))) {
+		ret = -EFAULT;
+		goto set_io_mode_free;
+	}
+
+	ctrlr_config = readl(ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	ret = amd_espi_get_general_config(amd_espi, &slave_config);
+	if (ret != CB_SUCCESS)
+		goto set_io_mode_free;
+
+	ret = amd_espi_set_iomode(amd_espi, &slave_config, &ctrlr_config, config->io_mode);
+	if (ret != CB_SUCCESS)
+		goto set_io_mode_free;
+
+	ret = amd_espi_set_config(amd_espi, slave_config, ESPI_SLAVE_GENERAL_CAPS_CFG);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Set IO mode failed\n");
+		goto set_io_mode_free;
+	}
+	writel(ctrlr_config, (ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG));
+
+set_io_mode_free:
+	kfree(config);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -187,6 +224,9 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 		if (ret != CB_SUCCESS)
 			dev_err(amd_espi->dev, "In-band reset failed!\n");
 		break;
+	case ESPI_SET_IO_MODE:
+		ret = amd_espi_ioctl_set_io_mode(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index 3c6e9b92c08d..f1185f877a05 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -143,6 +143,7 @@
 #define ESPI_SET_CONFIG              _IOW(ESPI_MAGIC_NUMBER, 0x1, struct config)
 #define ESPI_GET_CONFIG              _IOR(ESPI_MAGIC_NUMBER, 0x2, struct config)
 #define ESPI_INBAND_RESET            _IO(ESPI_MAGIC_NUMBER, 0x3)
+#define ESPI_SET_IO_MODE             _IOW(ESPI_MAGIC_NUMBER, 0x4, struct config)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
-- 
2.34.1


