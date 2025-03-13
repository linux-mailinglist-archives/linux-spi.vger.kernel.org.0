Return-Path: <linux-spi+bounces-7130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C260AA5FF69
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF477A9923
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12731CAA6E;
	Thu, 13 Mar 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KtstruO5"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B391EB9F4;
	Thu, 13 Mar 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890939; cv=fail; b=Pjrg8zFo8pQ5NcT5maky8R+mX6EztzweMt977Ckkb1Svqy79IMP0TPcOAiKhXJ3tqz2QnB4hz+Na8YmFEBIYoJTFKp1Qu/+bFVPUpHWO4bZyE8/OG1K3PZO17Z0dphcug1LJsB8slk56jhDq1I1cuiZlehMRpPq67NCe3/aU4K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890939; c=relaxed/simple;
	bh=aNz1RDWbRXMU1F38VVZFbthlSxVb917nxXOb4UN+nYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0pmPbs7PUhJaHiicC26nF9h/JoJklx8u6iumFb1GAY4VFGZsGpOuDGs7xaJW4rh9pY62VRUuK8HFKll5PbbyvYB0MgBuUCogLQUlrb/i3RsYe4c8tuE3gShuuzUPFH/7vrAVv4RDzwbFWVwPAoudo/ELIfGMZYWWVYeyI3tJ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KtstruO5; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEV9TzQJ8th4P2UwXQa70Rbpptk/Sk8OZn0h1lZ5vPAItZkzozRqeqrh4ZeYtFtuMd0CFS4rdDh356JqU4BLtsCFBhW6BU6HfNY8wL1Gqst6HyILgPH/4q31LJpF92Cj3QafZa5rNkqPtrsktE5hJoPsVDYvjrDZnap2bZzkIuugpm/f+fvX6S/9V5ZgHMGMta7DEs9JBSI4ws0KDWOGn/aiu5RmPhBv/2FZuUSaNFZ5NhbJdulUHfz1unpnK9jfGvV+5ceKoBobDYqj/Z1eRUpQpz/tLOERu2AMBlNSH7K5DAab2qzrWTauxmVS04oZgczJYXKbQr7vEJijUxPeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qT6iUzxCKilk7BnVrJodT0718iVMqX2khfYvWglEFw=;
 b=pCpjfn7+IEPbofb/NRoxfCoUTsRvoz9ouR133aqpaz8urdhX2KZbmXhjCXb24Ir7706JHwArah1qlj2/lBf5Xnlhyp+fntvstDWwtGgwyiAGjjBRRQ3uH7TW3pa7yRsxSRbt2wRx/ApSeNhkzuSj/vq8pU5Fyx83CC0V7Yl3gIRqgy0GaHL2JcCy05Fmv7va88HuvIkFJqKrUg/7vlz8EVAqb86vd6opIiomxGddOK9BgiSD5MnVSS7WVNn+Wvvkgwxnd6QinXlRak+NdXoBQpTf0ByBaHQnN8wJ3fAZfZia/XBXi4VecXavaoIWb3J7kiOgYzxvGTMUm6WJn+AoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qT6iUzxCKilk7BnVrJodT0718iVMqX2khfYvWglEFw=;
 b=KtstruO5FALJ1AXCrDcyKs8McNtFUy9fipiSRcx8HQHgZLXIwmmWyJck+uGP6+M4qecrELtneEo3UdqznAs4tYLbqNKuPDOMqDmAJ+B3pFbQNOVF82AD6wITueE48Qzr3YUMWsr2KDVuA1b2rHU3nI2eQCPS2M4cNmfPDznW4BA=
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 18:35:29 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::20) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Thu,
 13 Mar 2025 18:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:28 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:26 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 04/10] spi: espi_amd: Add eSPI inband-reset IOCTL command
Date: Fri, 14 Mar 2025 00:04:34 +0530
Message-ID: <20250313183440.261872-5-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e49a84-df34-448a-f6b0-08dd625dd44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ri35u7InIs85lDQiefbBXjuLHxZDesfo7WYTk6LcsQ7yRVLf0D7WZ0wdqDxG?=
 =?us-ascii?Q?L3H3v+wWpREayRBG98X0vfTjH553qTzo1mNlKKxjK6ZoT/ZPuFMpgNx8gv3p?=
 =?us-ascii?Q?E8LjA0cj/gbuzHG4BixFAslSCg6izr7GZdpW+5gieC33Uov9vM5U2kvnEtbl?=
 =?us-ascii?Q?GWxCHeYfTKG6pphnri7UlpeVlyqOZtnChr07MZOnnWmgGyTY1qNPOpgdVduh?=
 =?us-ascii?Q?3oGoWWi31olpbvYQHNCF9dSpGkKNcOBUvA5+vWJiX9Hiy1Cm9ocvBLyIveYk?=
 =?us-ascii?Q?E3nhoo2hGQyrv05C0f0N0YgEl/VKiW6Y1GKOTJ/IM+c/WS6TmK6C7sUhtpBP?=
 =?us-ascii?Q?3RjOaXhYbg+9jDqWatb2e9N51oDyPqG/m9ZJfx4LnA5d5T0CzGicR0eBNEY1?=
 =?us-ascii?Q?N3VsGtHGOZsA2M5K+Ajecxk1acOoQOcFbxDY6JwzG2YXtpWG/Zx57BjdxaXn?=
 =?us-ascii?Q?4hII0W7JQioEpUs/GMWWrIig9ee3sMKWDyqSR6B570C5m5rpbw9gt1EDeB5e?=
 =?us-ascii?Q?tppAgvi2Q9T8CayIs3l6khbJmZRWPOtY26LpD9SOnxaZ9VjY4mf4LZymyX1x?=
 =?us-ascii?Q?fgvW1xrGs+kkcJMFIgTtUn3U/uhcpFku/PCcmRumH2FBzYH1baQ7D+5d9BHO?=
 =?us-ascii?Q?VriZofQIUnMMg1bOxUXHad1a1of6bEBXF42ULGMbs5nRoifZTJFG6X6DMtsx?=
 =?us-ascii?Q?Rt3YDBT3WC1+371G8G7ONBSN4+qExk/uwGF3UmeMoPHWDZ7eKhqDo5pgLcMi?=
 =?us-ascii?Q?PXPykvR5cRxvrMxGcNFfB1YA0aoAbnyrmzza/KWTrDfLQ+9193+M5Qm4/PPu?=
 =?us-ascii?Q?HGsP7naEJC5OpjLug7X3JZ2aLl5VJ5X0vFVS7xBZS42cVU59Xm3zAg1pKK8Z?=
 =?us-ascii?Q?ObwJaAHs02Ba6ya3vlYkrFWx7EO5DdYo/T42clhtMV+XHg3hyHDcyA+THw79?=
 =?us-ascii?Q?HFGMSL9u99hPqdQTh01rz0W5M4k/LFqzzT/jpCRPfynxf/XLythKE71lfLgg?=
 =?us-ascii?Q?9wDtWlWk3Ldbo6OSOD1lPqaYQqIBMEoM6Coc4Xv+3vgiMbeiL4ok7JwZi9Z9?=
 =?us-ascii?Q?6bT+pzqrg/diz2unx8dHJms9qn6wS9mDo1f3fHqGnA88bjwxEPRFaAXIxKy8?=
 =?us-ascii?Q?2UXXAMK/Sa7ifD4ud4g2KLtOtydWK5kNqXNDOBJlMdPfY01uOyR2NxN9lZox?=
 =?us-ascii?Q?mACDmUnsmKAtoUpLO/o5EFAC3z3Qw5wBNH4ONW+GSQKBAOczeTTx4El/+Q/k?=
 =?us-ascii?Q?fy9UA+ofQapTJQVV1oQ02SGJcImOv1yl5D9o70L6Awa9pXlAkF93AdA9XsOq?=
 =?us-ascii?Q?Itlny53/0vKmxsJ1b7WulPEXxkVZe0WuY1f0z+jSvP0HD6XHS/qYV5AiQyau?=
 =?us-ascii?Q?okl7rSPlwNONxyOdIz2rM172jM03GeGPYLxlWLBVgYSobheRTRnG82/akVry?=
 =?us-ascii?Q?hQPk8n8Ht/tvCjrblolmAhVAKpHEHS/YAYBu8gM+bs5r4a3PNUSsTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:28.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e49a84-df34-448a-f6b0-08dd625dd44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

This patch adds support for a channel-independent IOCTL command to
dynamically reset the configuration settings of the eSPI controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-dev.c | 5 +++++
 drivers/spi/espi-amd.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 79224f4f86fa..ba2becdec8e6 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -182,6 +182,11 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case ESPI_GET_CONFIG:
 		ret = amd_espi_ioctl_get_conf(amd_espi, arg);
 		break;
+	case ESPI_INBAND_RESET:
+		ret = amd_espi_inband_reset(amd_espi);
+		if (ret != CB_SUCCESS)
+			dev_err(amd_espi->dev, "In-band reset failed!\n");
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index bc15f7417c37..3c6e9b92c08d 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -142,6 +142,7 @@
 #define ESPI_MAGIC_NUMBER            'i'
 #define ESPI_SET_CONFIG              _IOW(ESPI_MAGIC_NUMBER, 0x1, struct config)
 #define ESPI_GET_CONFIG              _IOR(ESPI_MAGIC_NUMBER, 0x2, struct config)
+#define ESPI_INBAND_RESET            _IO(ESPI_MAGIC_NUMBER, 0x3)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
-- 
2.34.1


