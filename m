Return-Path: <linux-spi+bounces-7132-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80102A5FF6E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED087ACDA4
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE651F03C2;
	Thu, 13 Mar 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dslDcyGz"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8F1EFFB8;
	Thu, 13 Mar 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890952; cv=fail; b=NrbPXjboI5BpDBLxsLQcIVBG35fGCMKfgG704Rf58DQLHVdt7NftavGu1Sjl2ZcgnMUusynppMw8EwNb7NyaTOoxOUbnV8Cm4S3Io/3C1Umalk2BgRpsKL/IStK0ma4eEyQGtuxl6XH144YsiQjh68MSuao3moX6/gsxJelgsiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890952; c=relaxed/simple;
	bh=vrsdyV67dbH7lqDgBT5321evSM9/fW7oy9YKW88k/e0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX9156ZdYFT9D/R56CDHCZ1NHWJPeZSAftVMwqor3uf71H+UsDuWiDFlSdKCc4gbLEJArAoIfw1QvemTnvDm0gYpCjrxjkyWEuT+0/WyHXad47t92iSVgvCvc81o/sftRCZMjEzlxumgzZ6oz6WHWzB0AjGMRo/r+vmaXhhEXRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dslDcyGz; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjDY5O95seApcmywBLw7Wq928o/s/RYBcpNqjoSSGNqQzk5XoqeUtCcObeVJNO6rR7kQ9+3vukrebbXC+K4YZzI11pIFd8RLI55cTu/RiofJpfNjrLMXALbJ1tN0LZMlMVxfQC5wzZ6rU+een2m0Vq2bTwDDycbhU5ww967QhG5Dp++O79zPMoGsQQN9F7nfMHvjKEbgkTwQ/QW2OYRIXVLBrxdkaiFFfH2VmpWbIZnmtPSRBn4hsRN5MGjJaez2sUnvj1SzEb+2cCqAw19PNq8pirrepmBID1LlO7vRNjYcYaMRiZxWgvrER75rKBMsNCu+sQZO7LhxKCxZONdu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Dx/k7A8UTk29uhZRnTdTCbm9/Um+mK0rwmjZQa9t4=;
 b=f8d83ox52+N4/pNpXj9XSyKm0AYxE5S5nmjnNdd9k4tKuSxbLcqlpGUQfIG4zFVqv6/AlRm5ByQhcyyqP839FKu/JKUXtumhTuSRUuHy7/Jd+D/ap7i7ip8WjU0heb1sQoJBYRlP/eYc1BdzyZJavyXI91azEtsnuSvKzq76Cij7gMvgOFRT1G+r85sNp8p0+BRXsvgAyuGtFxjQY976mDCRG8nkf62FV7E1Dj/geYmKE4ID/2V4rYLJFeK/UqyBMDi6Jlj2XUMBlJaRhcRbn1cw+6My4dhK6X/2B30FlJcJwwsv4gLOfuOBgwSAA0ElilqPnzU1ICWV2OSaNT30AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Dx/k7A8UTk29uhZRnTdTCbm9/Um+mK0rwmjZQa9t4=;
 b=dslDcyGzFDJaQR6tniN9D7niZR9n7aBVnYXU9aILm9Pi3fpx616QfL4QOMvlmqy+18TXOvexhhDZVySIPXBsJTzWRF4mjFE92b8mep2cLCOBFuvdbFzJSfyVK/l4qhuHC927GJ4Z/GX6MDUMt3wp+a8ok+mouJ5xdkYRkqMwXJw=
Received: from SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 18:35:45 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::30) by SA9PR11CA0005.outlook.office365.com
 (2603:10b6:806:6e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 18:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:45 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:43 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 06/10] spi: espi_amd: Add eSPI set channel IOCTL command
Date: Fri, 14 Mar 2025 00:04:36 +0530
Message-ID: <20250313183440.261872-7-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c795d5-cccb-46fc-f0c6-08dd625dde29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPis81+b0Xwsg3CKkDQKHB/iJiY2mUW8pV/tTqzi+pHIXGujIdSEDK36SP/S?=
 =?us-ascii?Q?ZMUvrHsMNqVQdZg9bj7bChmy+gYH3BBuG8SCPvMxQL14VcD9AAG82xAm3PSV?=
 =?us-ascii?Q?Szzz0xswOZoei6KnS6X4KWZWL63tXg5NI//aiP/IB2rwdgcHeQ8ydy/wZLSg?=
 =?us-ascii?Q?nsUhli2oqDIVkP/h7yQV4/P/n1zz1uHOAp2HA1vcU3ZA7onsqvacl+SKPy9E?=
 =?us-ascii?Q?9Ri6MdSMe7LTlnElT2wU1Jhf/3ZG/cCErIIWCFiuPSjPRrEiU8fu8DjuBGV8?=
 =?us-ascii?Q?tiKzuHyoXi9HpAf7xaOCvCHEioVRgLd624aAxoTFYgrvmWwJBLX/A/9bvzWj?=
 =?us-ascii?Q?0asAhaPRNx6KafWWnKyrlRC9nvsX64jL9j+Dw6prqpc64NepH5WLCdEke5MR?=
 =?us-ascii?Q?fuyJEH976yq2NW3Z75KemkUnREK9/5k/HWgI/pmVMsm+OK+M/wkxbnFtUmbg?=
 =?us-ascii?Q?fOApWRfbeIYaV/wbBXYCbNY1MwSPK7PEhXiripyz7AAi8bP4ZTExzQsqlSyL?=
 =?us-ascii?Q?cuEFO3ry5VHHGCE7CuRPKIDMD3wsd+TAOHQzjv9gZToF+qp+qtFLzHNiwQcx?=
 =?us-ascii?Q?vE49jK4oFXXScDDOMI/jv/hwyYAWTI0d4+F8L2DmjAznmwT7jXe5HVT/Arfb?=
 =?us-ascii?Q?MCz8s8/21ly47YKMu4EsPK46Zr8DSTsahSx26dkriYvuNK/1XCuy/3aaW+S6?=
 =?us-ascii?Q?G7dQktnqAZIJUyQua6DttiwVmfLwQRLphUNpZwKNiQslyePil0GGMS2c6V6o?=
 =?us-ascii?Q?xxMdjDGVL6I9rmJPCay7nlbNmTbZ4tq0dsMfUgcNaSuQXAU/q32VbcEtoI8h?=
 =?us-ascii?Q?+Za/VaBZ9VQ4Zlcx8EEmD+V7AXbCyfNbyOGzp3En/ITqaTsQ2FX1VNJDk35R?=
 =?us-ascii?Q?IxZjKZfepJ7qhjNlWXG4XZ1C+suvRyCnv01iL6VVKV0pJvn/XGLh/IIgZNC9?=
 =?us-ascii?Q?dmZwxLqvGQVS1C9gV816+OJAXd2Jft08e/w0Np9xHIF+aJeVvhEyjm2+1WGx?=
 =?us-ascii?Q?TQrdfmuuShpkaivbXt077MHNHSVhIFox7xXhG2JCCunmzXxDwhRn1zZBUZ5l?=
 =?us-ascii?Q?AJ1pVRzxIfvdpMp/EXVWexGYaPTwS7JKtOZ9AzmB76d8KHLhVyr9rZmAG4/H?=
 =?us-ascii?Q?dIMHGg8bVE8S2UNx25VygylJQh4aTdCQWPNTFiup7LNMXNQ7AJWFz1FwbqO/?=
 =?us-ascii?Q?tZ4ZOIKOoqFG14s6K189vKgePPZPKw8U/rATT59A6RYlZcnkO7558I4k+zjB?=
 =?us-ascii?Q?mP6LOLrgjmwUu8fthQXBcZRLyWgCuk2HNIwdEswJ7Dv62jVBxAVo0uLv2n+d?=
 =?us-ascii?Q?ZPZ99pOKqwP0whlby7pTp6OSrH7Bbfgp8QuX56RYOH6MKSnkNkeJ8N7C5AQb?=
 =?us-ascii?Q?7ixFJWS/qQF7zoQjGzwzhXpLB/JNj9RYBm2z59/O7zJdUZTbYKqQ1KQUlYkc?=
 =?us-ascii?Q?oj4xU4oou0DHw6fSbmGiRzwDtmxEyhZK2/8o4FBKiKRCxiKSRI4+ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:45.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c795d5-cccb-46fc-f0c6-08dd625dde29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

This patch introduces support for a new IOCTL command to set the channel
of eSPI controller. Currently espi_amd driver supports to enable
peripheral and virtual wire channels.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-dev.c | 49 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd.h     |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 821cc0486657..c78a9b2b059b 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -203,6 +203,52 @@ static int amd_espi_ioctl_set_io_mode(struct amd_espi *amd_espi, unsigned long a
 	return ret;
 }
 
+static int amd_espi_ioctl_set_channel_mode(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct config *config;
+	u32 slave_config;
+	int ret;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	if (copy_from_user(config, (void __user *)arg, sizeof(struct config))) {
+		ret = -EFAULT;
+		goto set_chan_mode_free;
+	}
+
+	ret = amd_espi_get_general_config(amd_espi, &slave_config);
+	if (ret != CB_SUCCESS) {
+		dev_err(amd_espi->dev, "Get configuration failed\n");
+		goto set_chan_mode_free;
+	}
+
+	switch (config->channel_mode) {
+	case CHANNEL_MODE_PC:
+		ret = amd_espi_setup_periph_channel(amd_espi, slave_config);
+		if (ret != CB_SUCCESS) {
+			dev_err(amd_espi->dev, "Setup peripheral channel failed\n");
+			goto set_chan_mode_free;
+		}
+		break;
+	case CHANNEL_MODE_VW:
+		ret = amd_espi_setup_vw_channel(amd_espi, slave_config);
+		if (ret != CB_SUCCESS) {
+			dev_err(amd_espi->dev, "Setup virtual wire channel failed\n");
+			goto set_chan_mode_free;
+		}
+		break;
+	default:
+		dev_err(amd_espi->dev, "Channel: not supported\n");
+		ret = -EOPNOTSUPP;
+	}
+
+set_chan_mode_free:
+	kfree(config);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -227,6 +273,9 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case ESPI_SET_IO_MODE:
 		ret = amd_espi_ioctl_set_io_mode(amd_espi, arg);
 		break;
+	case ESPI_SET_CHAN_MODE:
+		ret = amd_espi_ioctl_set_channel_mode(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index f1185f877a05..3774918d994f 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -144,6 +144,7 @@
 #define ESPI_GET_CONFIG              _IOR(ESPI_MAGIC_NUMBER, 0x2, struct config)
 #define ESPI_INBAND_RESET            _IO(ESPI_MAGIC_NUMBER, 0x3)
 #define ESPI_SET_IO_MODE             _IOW(ESPI_MAGIC_NUMBER, 0x4, struct config)
+#define ESPI_SET_CHAN_MODE           _IOW(ESPI_MAGIC_NUMBER, 0x5, struct config)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
-- 
2.34.1


