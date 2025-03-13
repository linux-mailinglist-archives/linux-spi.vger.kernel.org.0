Return-Path: <linux-spi+bounces-7129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4094A5FF63
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A0D3BF654
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7461F03DA;
	Thu, 13 Mar 2025 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qCy04Y1w"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898A1F12EB;
	Thu, 13 Mar 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890928; cv=fail; b=PzL5BM19Bwr4Zk7KTP4fA0dt8B8QpW2+elzPdHgZAwiYZw15LrUPH3WflmMc6+KDUxFJLYDtlW1iYyiszw0nO9pNXXwoTOeklQFQimmeumcWtEOugUQr5e6vUokVIrv+t9Moopp5BUYBrcfBIVYM/NCJRFuvZZsVP800SERCVKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890928; c=relaxed/simple;
	bh=WvQbbq7ty/Jjn47sm0wQduOqpRPbb4cBD57nl/RcfAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+GhwbaqiA7gPv1VA+dn4+yPt9HbL5LazlROOIHrFWmo8bJYe24WR7vI/9dtdWGR+iDYYwGcFYlH0hoMapn4jJuL17ys9pF8JPP/texteg9ShhXsPqZOHgwJY7sOTo6pe/dtkI8kXMS3DXsbk4Bfxr1m/6gJG6H8RzvExI1Sg1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qCy04Y1w; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6gOvY0e2pC2ouUMCYakXJHR/d4AG8jMfw3AUiWr7mGEivh9007h2sUBGcNNe+RJ7+Sj+rouB43Ljinbk7hR4PM3KNWfmdnzJxUfPLGlQG+5w7sjnhCcb9/dNdfXLqbmOP/MnXFZcdzzONwz1iriuW16JPNYx6JSy61mvpXwv4C8JmCY5zIa6201c2OruUsXiaQE9QHL3tM2QdMzwU3c1nty+rky4eo3XMnyp4/1rXpgU0h+5ZuA5URV4M8OdrZ3k7bknB0NQqPhZ7bV5Ra+0OILVLVGo6JtEDuJJ3V8HnVfgBf1Ala4r91x/o5omfk87vbipyodknYkTBY0QRO/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcmMzMTVNOg/FuNrokoqPJudv6bOErcQ+qpNd7xpllI=;
 b=Q0pfqABF2DnPcFTBfbkPfOatYVYUqYnLlQD/AP4Y3U4eRQAX2xa9wojrWClfmSfJE2FDfVFnSrUHjo+5A2flKVV0zSvAnK+zg3vrADHHkSZHed+K5B5NJh8gfXzj1DuBPn5KyDIlvEIvZM6gWieCSomQmsyY9U4MbFXMm5gNmnC7H6a2GQ5AnV/I1V+MKz/SM5fvz28W5cTbsFWT8i24l41T34UKleHTAPvbQdaDwgjWinSekNZdFVZ/IPBlJAnwK6BJ38QQ7jjFJw3j7hIsPvNeKrSYJ30MUqCdXm/QJfvfhUAxuMCwtkaFxwnkf96mwZf/4wZNKGTcp2fWpolHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcmMzMTVNOg/FuNrokoqPJudv6bOErcQ+qpNd7xpllI=;
 b=qCy04Y1whQE6QkQ2J8v5CPmRjV8Bpotf6NtjosHXkThIWPsTAA1xzlmrmgL8YV1n56nF/bd6eQYsUV0C9UWO4uUiylgp+ZbJ8v/pyh01oxYX7bqhsoPgAaE/LX6dGBi6dC8bXg38CJksZ2q1So2d5TsXqnrR2MPmGD37f/MV+eI=
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:35:21 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e1) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 18:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:21 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 03/10] spi: espi_amd: Add eSPI get config IOCTL command
Date: Fri, 14 Mar 2025 00:04:33 +0530
Message-ID: <20250313183440.261872-4-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0449a52d-1bb6-40a6-62bd-08dd625dcfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZ4HY1/VaA4guU4iQE3d2qg8lB+Rhv8ax8PfKAHWigUkvDV3e/OaCuFhqQV4?=
 =?us-ascii?Q?tMh7t7VUjQ/bf5vWjC4y27c4Zv/9xHwLtnrtn+osfaR1T84AjpGlD4gFaIFO?=
 =?us-ascii?Q?3Ydim5yzeeD95ZFta9Mng4UHeej/4JZj1BtFuTk2tiFDv45dXPdm2J58J8Aa?=
 =?us-ascii?Q?idQzcFWoJbYT4kxyU+hddne8gjk+MBcsgmj/dHSl6Jo2zUfH5ettSmyyHNFB?=
 =?us-ascii?Q?1PyTM/2asl3/48nyStWkdWL+16IR6LB7O9KHP14vlvgBSlX0loro5EgDfWRo?=
 =?us-ascii?Q?rs2pSYIqtNtFbHgTiEPlCmzeiJYeN9yu9gaxynjWBfLvwl0zLLxVIxiOMgjM?=
 =?us-ascii?Q?omZ7JF44v1sjZOQAyaqbSBGNiIo4v2tu8rgUvCLcbR+kXrtKYyD//M0YZv+a?=
 =?us-ascii?Q?a9CfC9JfjczXAnPAgKcvbKvdIzM0pkeWs63FNRmOgqgG23W0YzRJ7TNeUGbU?=
 =?us-ascii?Q?DhrPTLHE7PwcYR3MS26VQ6kZXt/IOmlJ7UbGfJUBB17lOAWiMzsvloMNCerq?=
 =?us-ascii?Q?O38KH3O27zN1ud4fMxuVVJ9sX+Y7fNUf+zYF45cYERhIGa63Yf7/mOH2x5Nr?=
 =?us-ascii?Q?Cvr3jtHKDCOPjSwQHvrspHGiZllZ8FhIzem6Pnj9LctbLG7jKc7FJqEg7eLr?=
 =?us-ascii?Q?lDoFvugmYrKo9la8bnM369zp24MiELbdcyoKhkK0+IuJkiQufrxjJkKXNOXf?=
 =?us-ascii?Q?WkcRMlSLoVgvlPmjVyi4zGrTWl+1PoljlAoxAjprTe/sq+QvgK9naVlVT/af?=
 =?us-ascii?Q?Gak4A2XQ/UJ59n+5cEngrMguaf9TtNc3/AWmKZHOuxt8KSXynSGjfenRuC76?=
 =?us-ascii?Q?izMwRlrBkg8hv4pJUbxoscniqBQfTM1BrWL9lOBo5hCQM1pazZE1Sp+0rgAC?=
 =?us-ascii?Q?PFaEs3JVjhQFbRp+BP7zV26dAEdiIo+Q62xubY////vtc3ROpEgqnGM4bmNX?=
 =?us-ascii?Q?mORyKTGcH/YQ47PNViTI27fMoc0ctmZS7/keF7smkYFzp9V0l4Z/4mjycX4k?=
 =?us-ascii?Q?OxkjbPdH0IFH8GuFc8VtNHjPyqWaULKIKN0GAeDfRMR1GCQzUYXmL29ZjJyo?=
 =?us-ascii?Q?SgodLU0sZfboVZZvmWEUax5WNspF0boPtSRjrjQoITRLIqRY+leVVx3y7A5u?=
 =?us-ascii?Q?E7MkLsBTIi59hCLGtzUyz9l+r5FY/rVcE//D7zuGVOsgOJmMGGwcYo+eovqR?=
 =?us-ascii?Q?i96Ius/nDUx8n+KluTgac+KVcbZ7k8dQ+MC1LXvHgHCDEYPTrn8oKGyZhCNx?=
 =?us-ascii?Q?sKujObU6NI62V54j6/vnY3Jx/NZtgY621irCpVNX80c/1mIulgSbzy7V7foB?=
 =?us-ascii?Q?TfSouitrvJf+Yd9vLS4CCjTWKQwYbBpzlu5qPQqXipijWtZ/cx0WaTfB9BLu?=
 =?us-ascii?Q?lmbzLEkDRJxG2ZeQK760CcANSJ9Qdkn1fpEfICfMIYCJCRwL4FFuBskp7CqD?=
 =?us-ascii?Q?iZkvapWkKbtImujdDNJOLwUX8svEEZXLbOgF6397NSCvjJsKzCt2CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:21.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0449a52d-1bb6-40a6-62bd-08dd625dcfd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

This patch introduces an IOCTL command to retrieve the configuration of
the eSPI controller and eSPI slave0. The configuration parameters include
the frequency, channel, and IO mode.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-dev.c | 69 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd.h     |  1 +
 2 files changed, 70 insertions(+)

diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 5f25ad2b1eef..79224f4f86fa 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -100,6 +100,72 @@ static int amd_espi_ioctl_set_conf(struct amd_espi *amd_espi, unsigned long arg)
 	return ret;
 }
 
+static int amd_espi_ioctl_get_conf(struct amd_espi *amd_espi, unsigned long arg)
+{
+	u32 op_freq, io_mode, slave_conf;
+	struct config *config;
+	int ret;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	ret = amd_espi_get_general_config(amd_espi, &slave_conf);
+	if (ret != CB_SUCCESS)
+		goto get_config_free;
+
+	/* Get IO mode configuration */
+	io_mode = (slave_conf & GENMASK(27, 26)) >> ESPI_SLAVE_IO_MODE_SEL_SHIFT;
+	switch (io_mode) {
+	case IO_MODE_SINGLE:
+	case IO_MODE_DUAL:
+	case IO_MODE_QUAD:
+		config->io_mode = io_mode;
+		break;
+	default:
+		dev_err(amd_espi->dev, "Invalid IO mode\n");
+		ret = -EOPNOTSUPP;
+		goto get_config_free;
+	}
+
+	/* Get operating frequency configuration */
+	op_freq = (slave_conf & GENMASK(22, 20)) >> ESPI_SLAVE_OP_FREQ_SEL_SHIFT;
+	switch (op_freq) {
+	case SLAVE_OP_FREQ_16:
+	case SLAVE_OP_FREQ_33:
+	case SLAVE_OP_FREQ_66:
+		config->op_freq = op_freq;
+		break;
+	default:
+		dev_err(amd_espi->dev, "Invalid operating frequency\n");
+		ret = -EOPNOTSUPP;
+		goto get_config_free;
+	}
+
+	/* Get channel configuration */
+	ret = amd_espi_get_channel_config(amd_espi);
+	config->channel_mode = 0;
+
+	if (ret == -EOPNOTSUPP) {
+		config->channel_mode = CHAN_NOT_ENABLED;
+	} else {
+		if (ret & CHANNEL_MODE_PC)
+			config->channel_mode |= CHANNEL_MODE_PC;
+		if (ret & CHANNEL_MODE_VW)
+			config->channel_mode |= CHANNEL_MODE_VW;
+	}
+
+	if (copy_to_user((void __user *)arg, config, sizeof(struct config))) {
+		ret = -EFAULT;
+		goto get_config_free;
+	}
+	ret = 0;
+
+get_config_free:
+	kfree(config);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -113,6 +179,9 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case ESPI_SET_CONFIG:
 		ret = amd_espi_ioctl_set_conf(amd_espi, arg);
 		break;
+	case ESPI_GET_CONFIG:
+		ret = amd_espi_ioctl_get_conf(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index 1de53426059b..bc15f7417c37 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -141,6 +141,7 @@
 /* IOCTL calls */
 #define ESPI_MAGIC_NUMBER            'i'
 #define ESPI_SET_CONFIG              _IOW(ESPI_MAGIC_NUMBER, 0x1, struct config)
+#define ESPI_GET_CONFIG              _IOR(ESPI_MAGIC_NUMBER, 0x2, struct config)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
-- 
2.34.1


