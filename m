Return-Path: <linux-spi+bounces-7128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF535A5FF60
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762AF19C3C34
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0901F0E39;
	Thu, 13 Mar 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cDrQGblk"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC01EFF89;
	Thu, 13 Mar 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890925; cv=fail; b=SPfEnS8Cj089mRCgAlTvdnpjakkoO8P9uu/10MqwCPsmgT0/ltuze5ZGryooIyC53I4gHdHRyby92Mqp+xPd0hPr1MOTjnlfznmS8wileatNv6cb2YaNbRSTNllqW7DqvVr43RxwgpJpaAWdwdJsLoVQj+bh73ILsu+1zx4Jufo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890925; c=relaxed/simple;
	bh=SDOhMpvv5CUWxLc4n+Mtd2YfN7WjD53fJtdJiqRpVso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtPHY5z212+GTsPY1Ax+0IhxUUFUQFOCuLsYhcea3b6cr5vzMHqYgL9vnGcED7JJYqNhw+kJMvM1lYqzPWIYdNvm2nXB7VfdM6v10zG/2KuP+j4wn4hBgNkrIjRwmpoJQqt3p4ibeuHTFAxs64S8Ww6XS3acpUbrkM9kSukOvNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cDrQGblk; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHH0JK2jfNupzqCzGnQ/2tmhpEY8Ncf3HQtI0qBXyVW0g4UEBzAHU4wP6u8ZburhukTQc+Sf2j7+Mxl8XHarA+bSIy67E/QQulWzlXqdYwSb6vY34QhTnmeGNVBPrtwTkSHDzxYxRlaAlSJsNQC8+WL+R9bXlyjAblTvcLh+DZG4/z4uJVfAQm8M45mo3MCDe+KbxtBqfQYmxlrUUWFIT0xyBvOKVCNx50qVbbtjvAdmTBAnwEKMFPTw/YAIRNfUPlqnNb94uHISeM5dqg19rg7YNmVezmFylEZXkHKOfImBVpedm9WZZXuzpk3WbPH6ulrczYFQErD5uD/27Y1njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv14Kbfg9WAS3y5Hg+bwFR79F6jjD+TByaxPf6LLv9M=;
 b=HEN/4N+HwKdWiRUziiYI0b9C+D8wIAYIJNfkHLuLQjVnZ8F4F4KQh6THyEj42/cYvL5R3bXAz4ZwnzpbD8IJYai94JgfhSd8V7W0tVC5XEfebfy3vC/fY/vzJvEB76jGTnjPqif1jaxbe1l9O7Go4i8NSkMAup1IM+lraCe+vq66mk1emVZWCJlrnJOE13+3Au2Q2lHHhoGIADRSfFZ09CCTfkW9GSG4E9oTT9KENaBMnWbB/uKXW6L3tRMX02BhfFdncGJ3LLARDwQ67JpH5VGnMP1K2NDHOvuKOlceN4xNnZAhd9xkcg+A3OqBK3UjcFFJmLrBbkrAnBLFEZMiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv14Kbfg9WAS3y5Hg+bwFR79F6jjD+TByaxPf6LLv9M=;
 b=cDrQGblkrfJC4gE0IwU5XW6fx1UXS+S9xs1cEfn7P3BnqCIVsAFjJ3zDRW4wYTNKOZfNHHr3deJaPGaivcYGcEbt3RXwiZlAeVkkQjntaDJPBLbFCtn8FrkP4W/jdgRGlrS+1yKFO8TtuKZJWTVwabt0bgAMob5N9dq1uG2OigA=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:35:18 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::c1) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 18:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:17 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:15 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 02/10] spi: espi_amd: Add eSPI set config IOCTL command
Date: Fri, 14 Mar 2025 00:04:32 +0530
Message-ID: <20250313183440.261872-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5082b9-c418-447d-f0c5-08dd625dcdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ho2/5ErI5Nja8+HdZvEWbcD2zY6S1Ppd2ra8biadYjCvWlpq0+ayfylY7je1?=
 =?us-ascii?Q?9nvwzI7cZFX6w7yqsfsVXhK++WtXL9a+Tif11ugIbDDPWblJDq1ogBs4yttj?=
 =?us-ascii?Q?qnVUQ48EhS+sXvAxzNYI1qMBXJPTRyQAWJ9fq7O/9uXAfvK0HBY5bfFXxilv?=
 =?us-ascii?Q?LVc6aBPhLleqP6OauNFoOh30G6WJxfx4sdLnxMaGog5AmoZpZ8AUywbJaSLb?=
 =?us-ascii?Q?tZ2bI0cygP4SMlhp6hGFhKOfgyfWfz9u0SHE0KsEVD9jjgX0zPyiqnWQdOjj?=
 =?us-ascii?Q?+HeYk12FslyN9T1zoPBDR16xg7BsDdHw9+MipkSoZjkFNsgxPzCath/oDDBh?=
 =?us-ascii?Q?VdPsKPcf0wY1tKu1XwQTMEJG3gJJSxOPJaTeOrx3m/bdKJPoO9PGJoIRWzjV?=
 =?us-ascii?Q?aU03ISWL3nJG2wloEAtOdooRAnSJjnPXsJxa3CLIVnxNgontQ+AC9vZ6H3V2?=
 =?us-ascii?Q?GwES3WkVpzzI+D3HnB1SOi6EgdhY9+xUxOUXkqPxmhbZWb8irPia/EU2MHW6?=
 =?us-ascii?Q?/elp6yL5+0U4QGwuP6nj1ww6P3MtMZFwp54xuVWFEIOY7rqBzWFF7aUqAChC?=
 =?us-ascii?Q?Ll5a2wivVe9/61FLQT5pDDhPPKYN9jDPY4gtZAfbbfthkj8C84cXJ/D5RtP6?=
 =?us-ascii?Q?SWurx2XzbMqSQIfKiRIwbGIyOlsaqlcSCRPWruSgGC1MGMhgkVGsa6qaaMOW?=
 =?us-ascii?Q?u81MhwdVdhE6XJaQTW/+QCAupepqBgVkJULP8WDbK2K/wpzbJARwSWG/OxAr?=
 =?us-ascii?Q?ox7ATP+EgTpXoX+NL7w+rDERJYwgI3TYo0dBt/LXcT6GYpryhjc9uKsWwTxM?=
 =?us-ascii?Q?PpHJQrKZiVVWEj5o0Ftxru14TOSHO0a/M56RslItVtGf3rQ1c0T8bQmDrzoi?=
 =?us-ascii?Q?MHVqPS+6oRTEmCbUVDDZSViGqgyCpcpAyPaeqPX+m8njUC8IxVbIyIO5sGyU?=
 =?us-ascii?Q?Ao7vTnakirrtZrEMWrSbvbV44J6wetvmM/TaAXNZVrI+3aY/tvmMMufCoLBB?=
 =?us-ascii?Q?NINEKyXLj0nD9Dd3ZV72eFDctAVPVn0Lw9CffvWD1WS2ISSIDNbc1HAp0XNc?=
 =?us-ascii?Q?LM+lfP5X5pTg5e12pvMQprm4C+IjQgi1OzcwpADZrz5ywuLOU6NXozE4TSJS?=
 =?us-ascii?Q?XDOp8dpO7VcdKAs6wpgLQLRB2J+TtQnlfuHG9vmaKPO1kjoZsfj4T0DGZf3M?=
 =?us-ascii?Q?8a5Ph+DpUR5TDA7bH1pQm1JNBKoSn7KxjoP+QPUOrH4lo/x14+gsc1ODj+nt?=
 =?us-ascii?Q?L4oxb8QinTweIsuEHNjDhVnnxKqDNHEHDVlwCfgd0nXvfgHOJv88NCakUeY3?=
 =?us-ascii?Q?BEXDxY+bkkO6fKh048gDEoMS5+wO3Xu34iFyXgWErlx+FlM1UTn0oX8zOsn1?=
 =?us-ascii?Q?COHGt19qFIHP9ZEGufPCxQ5v0ELbHt/luF/UpOKs09VRnz9mjMbVTmN4mqHf?=
 =?us-ascii?Q?dUHGSNeIRrNUIkDWgoQgKAqgdWRtxINlkSCsOoRupBDr5718sF4x6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:17.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5082b9-c418-447d-f0c5-08dd625dcdb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

This patch introduces an IOCTL command to set the configuration of the
eSPI controller and eSPI slave0. The configuration options include
parameters like frequency, channel, and IO mode. The new IOCTL command
allow users to dynamically configure the eSPI controller and slave.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-dev.c | 94 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd.h     |  4 ++
 2 files changed, 98 insertions(+)

diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 4e46c30d3405..5f25ad2b1eef 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -28,6 +28,99 @@ static DEFINE_MUTEX(device_list_lock);
 static struct class *amd_espi_dev_class;
 static struct cdev cdev;
 
+static int amd_espi_ioctl_set_conf(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct config *dev_conf, *config;
+	u32 slave_config;
+	int ret;
+
+	dev_conf = kzalloc(sizeof(*dev_conf), GFP_KERNEL);
+	if (!dev_conf)
+		return -ENOMEM;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config) {
+		kfree(dev_conf);
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(config, (void __user *)arg, sizeof(struct config))) {
+		ret = -EFAULT;
+		goto set_config_free;
+	}
+
+	/* IO mode configuration */
+	if (config->io_mode != IO_MODE_SINGLE && config->io_mode != IO_MODE_DUAL &&
+	    config->io_mode != IO_MODE_QUAD) {
+		dev_err(amd_espi->dev, "Invalid IO mode\n");
+		ret = -EOPNOTSUPP;
+		goto set_config_free;
+	} else {
+		dev_conf->io_mode = config->io_mode;
+	}
+
+	/* Set operating frequency configuration */
+	if (config->op_freq != SLAVE_OP_FREQ_16 && config->op_freq != SLAVE_OP_FREQ_33 &&
+	    config->op_freq != SLAVE_OP_FREQ_66) {
+		dev_err(amd_espi->dev, "Invalid operating frequency\n");
+		ret = -EOPNOTSUPP;
+		goto set_config_free;
+	} else {
+		dev_conf->op_freq = config->op_freq;
+	}
+
+	ret = amd_espi_set_general_conf(amd_espi, dev_conf);
+	if (ret != CB_SUCCESS)
+		goto set_config_free;
+
+	/* Set channel configuration */
+	ret = amd_espi_get_general_config(amd_espi, &slave_config);
+	if (ret != CB_SUCCESS)
+		goto set_config_free;
+
+	if (config->channel_mode == CHANNEL_MODE_PC) {
+		ret = amd_espi_setup_periph_channel(amd_espi, slave_config);
+		if (ret) {
+			dev_err(amd_espi->dev, "Peripheral channel setup failed\n");
+			goto set_config_free;
+		}
+	} else if (config->channel_mode == CHANNEL_MODE_VW) {
+		ret = amd_espi_setup_vw_channel(amd_espi, slave_config);
+		if (ret) {
+			dev_err(amd_espi->dev, "Virtual wire channel setup failed\n");
+			goto set_config_free;
+		}
+	} else {
+		ret = -EOPNOTSUPP;
+	}
+
+set_config_free:
+	kfree(dev_conf);
+	kfree(config);
+	return ret;
+}
+
+static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct amd_espi *amd_espi = filp->private_data;
+	int ret = 0;
+
+	/* Check type and command number */
+	if (_IOC_TYPE(cmd) != ESPI_MAGIC_NUMBER)
+		return -EINVAL;
+
+	switch (cmd) {
+	case ESPI_SET_CONFIG:
+		ret = amd_espi_ioctl_set_conf(amd_espi, arg);
+		break;
+	default:
+		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int amd_espi_open(struct inode *inode, struct file *filp)
 {
 	struct amd_espi *espi;
@@ -68,6 +161,7 @@ static int amd_espi_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations amd_espi_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = amd_espi_ioctl,
 	.open = amd_espi_open,
 	.release = amd_espi_release,
 };
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index 57b156fb0a05..1de53426059b 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -138,6 +138,10 @@
 
 #define ESPI_BASE		((u8 __iomem *)amd_espi->io_remap_addr)
 
+/* IOCTL calls */
+#define ESPI_MAGIC_NUMBER            'i'
+#define ESPI_SET_CONFIG              _IOW(ESPI_MAGIC_NUMBER, 0x1, struct config)
+
 /*
  * enum amd_espi_versions - eSPI controller versions
  * @AMD_ESPI_V1:		AMDI0070 hardware version
-- 
2.34.1


