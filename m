Return-Path: <linux-spi+bounces-7133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12AA5FF6F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF72819C3E17
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3111EFFB8;
	Thu, 13 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAfOIlXF"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AB1F03E5;
	Thu, 13 Mar 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890961; cv=fail; b=DDRsr8foZ/Qu6zZDIhBRDEtn0Fm7DSxnnzeTpqs311ZlqfmJ7l9OdDxbSljLXTQJA5H2Y56UrDAYAcDTjj+Z5lez8kvQiTknmI1Wk7FC8eHoMGKiKRkUh3A4T8wPM9dGD6EU6h8s68WYqUfruyLXh0s4h+yhykJKaA7IF1s6r8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890961; c=relaxed/simple;
	bh=5b7ZkO9cerk/DdyhUKUfCfM2ryLFah7BrKfxz6ns8I4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsPbxco0UJRnbS3VZ4WBL8eUFL+DcPgnGjRtiFxjwsNhze30bO/vr7hpS/50SGeuInwUrnuTPMFh6G2dR35c12KjOOuUfNehYV+mWowL4rTrS0IqZuZQkIOlf1yDpsZW0KSWsLXB30tIhyVFN1OwwkV9dniySqJFR4ookNjXzVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAfOIlXF; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjRS+O4aFejXc0fQJHndzSnhk5IjKVCGBJsC27re5ETwxJxNojYu2lDMta2i9epeNVHYJHZxtESqmcVMe1Kuwnzxn5PATkX7XyepXCAMWgTUf4uGDMH8LdPRHK3+uAshmTPmjplDE8p/w4lKqeIpFPaWg0fpTOXXLHTTQmpiGsvFhtK0kN2R4bSXg3l8TZLUs+GPjHJVvSPhSL2ODnjq5/EXU8qx5JBEQNiUHGblSo5uG1PuqHsJcAHIFp53TCFCuoqYGBxjg9T7ejLAtiYcOxcHehfSjrLH9jOf/p0th18JHcHv3Clt1cX14kik9LZizgbghglfMEdAS8eBFFwlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4NLPVRNjIqENFlmpIOZI+Xs0LZThu+Do0vfhWWsQms=;
 b=mGD9GLOZg/q24o+MM6B0MqOWaoK6P8zjLu2tRwqBYJlsAEYsEKPifeiOh8ojVBtGrW+OFvlL3uicT6FmZQPFtxxHSFOyPlmL3W3XnoZDY7fbKrUZee4qRlEhGtm1QHgW/rnxYFVFDbKJpRG3MZot92cPSsDaf4O075TUn3LVmsQPA5hbwsuaqgzhzUvuBaj6q5x0TQRQxDC/atsXKHFRrQterleZ5cG5zI44cKHBJFPz1IpD2D3jPDdWUVYFaKda12EB2XdpOiEMRU3olD3KwFm0Wtw3gUye9WKRkHfjyM2SUjTu9ZhQooRxmClvrpkrRKD0DPi34wSfi/zSdYL0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4NLPVRNjIqENFlmpIOZI+Xs0LZThu+Do0vfhWWsQms=;
 b=WAfOIlXFq+nkMe3RlqSurOElx8o5z1CaTa9pDt2GxSTI++Q0Juv5QIESF9E0MsTaqYuf9PWHVbVj07nAHA2br+d/zo9/ZgtSlBEUNLX49nktXNfT64VBKZjoAZvzh9eNRYRjGX3FgW0kSTyv+JmGiodAAOTXIFRAQbqVO9B38aE=
Received: from SN7PR04CA0220.namprd04.prod.outlook.com (2603:10b6:806:127::15)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:35:55 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::72) by SN7PR04CA0220.outlook.office365.com
 (2603:10b6:806:127::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 18:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:53 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 07/10] spi: espi_amd: Add eSPI set frequency IOCTL command
Date: Fri, 14 Mar 2025 00:04:37 +0530
Message-ID: <20250313183440.261872-8-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 969d2c78-9bac-4a1c-f15d-08dd625de437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W89zPNkdHP8Ffau66vW43ifufCEVWRv0LHdLEh5vu6GvCxSX84yhRh3PTFVu?=
 =?us-ascii?Q?JdVS+p0Wde9G/YsUacd/FgZ+ZouDz4BiDASJ/SQaX/URUdWGUFwERZ3XbHKK?=
 =?us-ascii?Q?Hpg9uhP6MuoefNkHxmD5SgVfeHHCU29psSyMoESMRdssx/KjBiUQ5J5Dr0Xi?=
 =?us-ascii?Q?q6g/qM3OJyaWQAwAMPSP5elYLOZN5V4UBRzb3XUDvHWDObLyP6BRJ3WE4iLM?=
 =?us-ascii?Q?TUjrlDRmBkvGkonj+Z24JMw+O3h9aB0JhSdb6s10YjoW4BEP0NVhPklhiaqJ?=
 =?us-ascii?Q?Ih0rhPlssSBQpTFtWq20JXpe+Eg1yP/8Z0F3Kvhlq3M2Fqkg8Qq5Ra9imDqc?=
 =?us-ascii?Q?OZESPr4Cy9IPQsNOEurO7P7kMH0YCpu1YGy+QeZ/Bebcmfi3tYv53dDqxGTR?=
 =?us-ascii?Q?ju6LotPmHFJH4YnAmCGc/obAedmchztOvT0Wai+tFunjEerScWmHTheAiK5f?=
 =?us-ascii?Q?B4hzONZWyABEfLQ1PipzzqrPA2j1nfTqkd5GScSkb+y2HejUN1k4Wd/TxwU1?=
 =?us-ascii?Q?6lhycDbykkrlx7YJCitChqNAMkDvOpDhH1rPOpYI4ZXY8CdY0DkPV7RWiXUw?=
 =?us-ascii?Q?T4vEh8PQKqMyAaIuwh0vXhdoYx9QN5SIgyS6SUSuUog3wABNa5d/x94ZUVYh?=
 =?us-ascii?Q?6mNZO07wViAt9gJfAe4J7qJgXNxARz4VkFebubtrxNpgiKvazZD6/zNRJFNo?=
 =?us-ascii?Q?o6Rhei3D5hYHJL0qbxavNQJxS04lgNJCKnnsetXv9RBOz95i2YD+527hjtt2?=
 =?us-ascii?Q?BYX6QYfZYcdWIZgiU9ZGTf5hexDz/0K5t32u9xA9SE36TSAqv5qj8JkwH95y?=
 =?us-ascii?Q?hYlRRYhxI/tr7VmncFTVoxnFmChuVDZrpNdzMunBiTGtbogIxopHaCFtxsNa?=
 =?us-ascii?Q?1QYotSWEHj60PdvggjCMWR63w2WJ3Q5TYcOlIRceNT3UFOqUxad1lvFaLQoK?=
 =?us-ascii?Q?hFP4Z/2IrEMBV7vMLBBMYFBc0p3F/aFnia9NkDdLlhv5wzUZhmZ1apNbOXyG?=
 =?us-ascii?Q?6yn7e/pjEuKWRXKM12eSl1VzjK1HZLipgvyeCdOzosS7eK02tM6IyL78phNb?=
 =?us-ascii?Q?7mSdwcA9o28CcmM8p8tLsATTAEd+DzBsWT+w8i34yiXyQLZVtbvqD7xquxpN?=
 =?us-ascii?Q?QaePAwX4Ohhkftg9vcmu8hsasJwTVNeEw0Dpi0Ulpu1pFtZbGD22IpeL6eYu?=
 =?us-ascii?Q?AYnrWycZDNXHhioWVBxxrciGLEETznK6HI0pac63TFBnqCZvrubRVoMABXLK?=
 =?us-ascii?Q?c0URKUGbVs8+q1lAiotMM/+3zejtcRJlGW9bGgkF1/VUchvgt2/MI1PfxCXI?=
 =?us-ascii?Q?GQcTOCyWm1VDuBeFJ2lzXjGJZnOhL+I/JmmbiHBwWLekbMZ+efY2a4BHIbqN?=
 =?us-ascii?Q?0TP6J/z3Lo3MR5gmCBl2iWvBe7+UFfYliD3tYNGbZ9iXhu91V/DJGE1dCJFk?=
 =?us-ascii?Q?zvf9GrlAsOJDOhdfboi+QITCNDSk9c3oRUQsWA6KE7mU3LSjSejYzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:55.5736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969d2c78-9bac-4a1c-f15d-08dd625de437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

This patch adds support for a new IOCTL command in the espi_amd driver to
set the operating frequency of the eSPI controller. The frequency value
can be one of the following supported options: 16MHz, 33MHz or 66MHz.

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
index c78a9b2b059b..9f1968566980 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -249,6 +249,43 @@ static int amd_espi_ioctl_set_channel_mode(struct amd_espi *amd_espi, unsigned l
 	return ret;
 }
 
+static int amd_espi_ioctl_set_freq(struct amd_espi *amd_espi, unsigned long arg)
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
+		goto set_freq_free;
+	}
+
+	ctrlr_config = readl(ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	ret = amd_espi_get_general_config(amd_espi, &slave_config);
+	if (ret != CB_SUCCESS)
+		goto set_freq_free;
+
+	ret = amd_espi_set_freqmode(amd_espi, &slave_config, &ctrlr_config, config->op_freq);
+	if (ret != CB_SUCCESS)
+		goto set_freq_free;
+
+	ret = amd_espi_set_config(amd_espi, slave_config, ESPI_SLAVE_GENERAL_CAPS_CFG);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Set operating frequency failed\n");
+		goto set_freq_free;
+	}
+	writel(ctrlr_config, (ESPI_BASE + AMD_ESPI_SLAVE0_CONFIG_REG));
+
+set_freq_free:
+	kfree(config);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -276,6 +313,9 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case ESPI_SET_CHAN_MODE:
 		ret = amd_espi_ioctl_set_channel_mode(amd_espi, arg);
 		break;
+	case  ESPI_SET_FREQ:
+		ret = amd_espi_ioctl_set_freq(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index 3774918d994f..e5760db7c1d3 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -145,6 +145,7 @@
 #define ESPI_INBAND_RESET            _IO(ESPI_MAGIC_NUMBER, 0x3)
 #define ESPI_SET_IO_MODE             _IOW(ESPI_MAGIC_NUMBER, 0x4, struct config)
 #define ESPI_SET_CHAN_MODE           _IOW(ESPI_MAGIC_NUMBER, 0x5, struct config)
+#define ESPI_SET_FREQ                _IOW(ESPI_MAGIC_NUMBER, 0x6, struct config)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
-- 
2.34.1


