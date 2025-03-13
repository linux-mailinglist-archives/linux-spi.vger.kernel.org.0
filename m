Return-Path: <linux-spi+bounces-7135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C8A5FF78
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF31422739
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC381F3B93;
	Thu, 13 Mar 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ziny6r5v"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AA1F3BA7;
	Thu, 13 Mar 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890983; cv=fail; b=be12YA0KkvxxoueSeW42ZbtAJovZjkuEtDBe8CWUIKzI+79duZjRG60j+/BNkIsMdPWQsSIQJNXjJlnK7D0Q8NgP945T1VfitDIruCI28Fj0cwBZCDov5IYxjwJ/qkBjc2Ox6TUZDE+jc431nCro8R2w5CzB8gmqmKPabo7zNjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890983; c=relaxed/simple;
	bh=MoP1+I/gRjbKp/NJORLMJFt3237v1OA8EcpL/JgstRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhqzZjLLluDwGIE3ZFRqXpsFtLm3rc9M8VH25S+pE4jNKQRSMncruRSlb8Ks9of5MHn+of8QvvvApCW76raXGu1YhC4eeq28Ckmyo5fVZ/AY0RzAS5eDYZvUjopWUDlRpUgZEfVXlJqVDu5H2yackP1xMi1J7ZWbirEQunlbiPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ziny6r5v; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLe1uBq9OcOZTt3VazANZiAC0g0o5zxAHLiGTH9o8Q6JQrrUgy/feHzf1lV2v7gjeYx0a0F6SgQ1Yq3BdAWC2kfi3r2Poj4IlPRPXZTIFSrQchezZfDyi/pjo69g0FcYvb7vPUHpmlUtJxzib/osyFT3etwgEeaSlVkaYaRtr/qw/G362s8kXrLGHYnX7xypuDzUhR7Tl2J9GsRw4RHxoFa3TS1U5o5SiDsQb3SHC+Sq/ZxKMTKodSdc9Hr5kQckRLLFm3uvu+jjk5+hFd0/3KD4AFT8v5HeKq08RkkeFdTkDFuzMWRfMnW8vIIAWiBVxnpN0SolykdZShWoFzuT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3o/tevFk48fWdeHWjscsEpgKBHgGgy23zvzRLt2Jrw=;
 b=OOJO3krsw9hUjf1QWXH8jeUmXG/qOAFJLZrOtxD/tSWdVZYOMV87fh+11cqvL8Fil040woDrCK3yXCk/nJxcGiy4581gHHlXAvdvZ7iV3yq8R034n0seOn//78SiAyM+Vy+WA27ZcHIeaNvsFXWzKgK2kTO+N5DX8b7JydWLOHwvnJbn3EOzRYdfZICRlwfxXF3H5W4+uLZBYi1tjYoznV4l9WGyxdJoIh/N79Mpo/91SI851UHGrKo2fJWNPrpvV3smMBL76dxYma0wc68Eo0Z2PqWl5QDPXKajEiWtrCI2lABmaEk0WsqfFPE7P9ErP1vcgwECq4KaJHP5+OCtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3o/tevFk48fWdeHWjscsEpgKBHgGgy23zvzRLt2Jrw=;
 b=Ziny6r5v6iyQDbtGP+cpT2xP6SGIwLMhDs8e8ttDq2eLdxrcrdsPTsevUt5ASRgO2mjrWnIBvVRq8zdQVDop+G98iA3BQ7q0KCTquJlmngmS/vr6JsJCkX+LSelq0ITtrsWmHpu2xUMYFBWPu958wYnEOe/fIPHiH5U33f3fIfg=
Received: from SA9PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:6e::31)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:36:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::f) by SA9PR11CA0026.outlook.office365.com
 (2603:10b6:806:6e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 18:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:36:14 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:36:12 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 09/10] spi: espi_amd: Add eSPI PC channel IO read/write IOCTL commands
Date: Fri, 14 Mar 2025 00:04:39 +0530
Message-ID: <20250313183440.261872-10-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e90072d-b62d-4aab-e8ca-08dd625defbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MG8ERoEPC9tFX5KBg2REyoOv7EU7/cLYO8VCdPj3SNx8rVpmVY8SQuHhebZz?=
 =?us-ascii?Q?+RBVfHnb4kyWwKqfixYtjtkQUfdypTi0hJqcEsZoqzuNlstacmam8MP1+3iD?=
 =?us-ascii?Q?mKV9CRt9E++SS+TKGN7a73tJKUSirVxNALRxyyKLjGI1B4xofmNKoo3gy4nJ?=
 =?us-ascii?Q?9PHBt0M7S5kgbp17csabO+b+BmHr1bj0Hq970Pgk3TOf3isn4caXJpUIJoc3?=
 =?us-ascii?Q?a0ik8EPbch1y8iS0UJYDSU63+49VR+TSOua1w1Z/Ojmm78Poa1ygQM7RYUBy?=
 =?us-ascii?Q?Mz+/mMztJCiU2sMrWQS4qNNYPYrno7YgWlX9tFnCZnJpNC+24099xx8zbQYw?=
 =?us-ascii?Q?dHWJXJw5F7kV1k+Oz9tlO3+zP3BkpEv06iPsaRk4WcrPkvLGx6JRXigWFjSY?=
 =?us-ascii?Q?pBrKLHL6tOfa3p7mslye2Eq7ztQr5QpAAYFe6bEuhC9Qn4brHjP2Oc+w9w+/?=
 =?us-ascii?Q?oDSKonaIA8L/rIQDxVjomoCSg3SUSx0zAWiPL83h/X8vPWAXa/HuT1thdhpu?=
 =?us-ascii?Q?dBetXXGS6Q1P5z9MQNuGoKUZbID4c5mXOek3I42IuKK/maHz0gkdSvKrJbiQ?=
 =?us-ascii?Q?Y3gjLK7HUtcxIGAWgmdtXVLoKso6uFjX/PT9wXrfgH6oYmnYTmCXm6wpSNPb?=
 =?us-ascii?Q?Q2hdiQxNa1H+zXfAgG61n3CZBCn/NnMIfGPEQBGBbtueroAAN6bTkfdYwDGj?=
 =?us-ascii?Q?QAL9k8X60dBGlKSZTXSVzlF3BLLkvCDUv1B2W0StFb1rcPdT0148AJoEz77f?=
 =?us-ascii?Q?T/g4tsoPcPgR72i749cgSp1BbFG7wGEfEm2EQQ/F7KQ+A/1OagLaRLvUM6GF?=
 =?us-ascii?Q?HDRFCEUcSAODQCcKeMFF96GX7HG9rOboKCMNxmNChIMs8dxoBdHA+xtAp9aS?=
 =?us-ascii?Q?CM3ga1KTnfB8QzLY0jbmxLxNpW/01JGQjywFNok5pav9qjKk9xtgPJSYD1Fc?=
 =?us-ascii?Q?kBs4p09BPgjRqoYFUDeHoTKyxTdZ/iWRv/43iJmbBDKlmnUZH6mGFlfMr3uz?=
 =?us-ascii?Q?ISHuPjCH21zmFzjiL0h+KjckFDJoz/90Jd68u+UmcvzcOqbZ3kaam6yk4Ck6?=
 =?us-ascii?Q?NCn9IBk4wzPQ5Ca5Gw1dCAUC+sBUfU/6i2SCPYoKUbUlqdqEUj2iClIZ5TRh?=
 =?us-ascii?Q?1aVWn4EpKWW4pVN44Cxg+bsvGLh1LeN2IdTbcM3uFqfDHIXgsXobsQlG8AWt?=
 =?us-ascii?Q?mCRlfZfkwSbB4seBJTYp9C1rUZy4ywSigjjzfx67leuubepHQeiNHRyt5dIQ?=
 =?us-ascii?Q?me7EdYBV9h1Qah6mEB35y1gQwrubb9SDLso3MvL4fIHNQW7zvG/Vy+3cj/7r?=
 =?us-ascii?Q?bw+scexghI6Cu/Qmy9EIf8kTYu/ohnR8YkmN8Qh6PWdpOkr5vYMHiD7kORLR?=
 =?us-ascii?Q?IzAUUmixFa/wvjA5HL87Oij2kalluidlK7bDkY/Y5f9OqPjIxVIG2SWn4CSd?=
 =?us-ascii?Q?SY7FX2FAdQ5G7hsos5fSyeDXLXg181zdHYUY8gCb3rqB0wIHsZpemQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:36:14.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e90072d-b62d-4aab-e8ca-08dd625defbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

Add new IOCTL commands to perform eSPI peripheral channel(PC) IO
read/write operations with peripherals connected to eSPI slave0.
The changes include validation of IO configuration before initiating
the read/write operations.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-core.c | 95 +++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd-dev.c  | 53 +++++++++++++++++++++
 drivers/spi/espi-amd.h      | 16 +++++++
 3 files changed, 164 insertions(+)

diff --git a/drivers/spi/espi-amd-core.c b/drivers/spi/espi-amd-core.c
index 3704cbd816ae..18bfd2ca2316 100644
--- a/drivers/spi/espi-amd-core.c
+++ b/drivers/spi/espi-amd-core.c
@@ -114,6 +114,8 @@ static int amd_espi_alloc_cmd_data(struct espi_txcmd *cmd)
 	case GET_CONFIGURATION:
 	case IN_BAND_RESET:
 		size = 1;
+		break;
+	case PERIPHERAL_CHNL:
 	default:
 		break;
 	}
@@ -710,6 +712,99 @@ void amd_espi_disable_io_decode_range(struct amd_espi *amd_espi, u32 io_range)
 	writel(io_mmio_dc_enable, (ESPI_BASE + AMD_ESPI_SLAVE0_DECODE_EN_REG));
 }
 
+static int is_port_address_valid(struct amd_espi *amd_espi, struct periph_io_rw *msg_io)
+{
+	struct io_mmio_decode_config io_conf;
+	u16 port_end_addr = msg_io->port + msg_io->len - 1;
+
+	amd_espi_get_io_mmio_decode_info(amd_espi, &io_conf);
+
+	if (msg_io->port >= io_conf.range0.base_addr_range0 &&
+	    (port_end_addr <= ((u16)io_conf.range0.base_addr_range0 +
+			       io_conf.range2.io_range0_size))) {
+		if (!(io_conf.io_mmio_dc_enable & IO_DECODE_RANGE0)) {
+			dev_err(amd_espi->dev, "IO range0 not enabled for port address: 0x%x\n",
+				msg_io->port);
+			return -EINVAL;
+		}
+	} else if ((msg_io->port >= io_conf.range0.base_addr_range1) &&
+		   (port_end_addr <= ((u16)io_conf.range0.base_addr_range1 +
+				      io_conf.range2.io_range1_size))) {
+		if (!(io_conf.io_mmio_dc_enable & IO_DECODE_RANGE1)) {
+			dev_err(amd_espi->dev, "IO range1 not enabled for port address: 0x%x\n",
+				msg_io->port);
+			return -EINVAL;
+		}
+	} else if ((msg_io->port >= io_conf.range1.base_addr_range2) &&
+		   (port_end_addr  <= ((u16)io_conf.range1.base_addr_range2 +
+				       io_conf.range2.io_range2_size))) {
+		if (!(io_conf.io_mmio_dc_enable & IO_DECODE_RANGE2)) {
+			dev_err(amd_espi->dev, "IO range2 not enabled for port address: 0x%x\n",
+				msg_io->port);
+			return -EINVAL;
+		}
+	} else if ((msg_io->port >= io_conf.range1.base_addr_range3) &&
+		   (port_end_addr <= ((u16)io_conf.range1.base_addr_range3 +
+				      io_conf.range2.io_range3_size))) {
+		if (!(io_conf.io_mmio_dc_enable & IO_DECODE_RANGE3)) {
+			dev_err(amd_espi->dev, "IO range3 not enabled for port address: 0x%x\n",
+				msg_io->port);
+			return -EINVAL;
+		}
+	} else {
+		dev_err(amd_espi->dev, "Port address 0x%x is invalid\n", msg_io->port);
+		return -EINVAL;
+	}
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_periph_io_write(struct amd_espi *amd_espi, struct periph_io_rw *msg_io)
+{
+	if (is_port_address_valid(amd_espi, msg_io) != CB_SUCCESS)
+		return -EINVAL;
+
+	switch (msg_io->len) {
+	case 1:
+		outb(msg_io->data.data_b, msg_io->port);
+		break;
+	case 2:
+		outw(msg_io->data.data_w, msg_io->port);
+		break;
+	case 4:
+		outl(msg_io->data.data_l, msg_io->port);
+		break;
+	default:
+		dev_err(amd_espi->dev, "Length of IO packet is not valid\n");
+		return -EINVAL;
+	}
+
+	return CB_SUCCESS;
+}
+
+int amd_espi_periph_io_read(struct amd_espi *amd_espi, struct periph_io_rw *msg_io)
+{
+	if (is_port_address_valid(amd_espi, msg_io) != CB_SUCCESS)
+		return -EINVAL;
+
+	switch (msg_io->len) {
+	case 1:
+		msg_io->data.data_b = inb(msg_io->port);
+		break;
+	case 2:
+		msg_io->data.data_w = inw(msg_io->port);
+		break;
+	case 4:
+		msg_io->data.data_l = inl(msg_io->port);
+		break;
+	default:
+		dev_err(amd_espi->dev, "Length of IO packet is not valid\n");
+		return -EINVAL;
+	}
+
+	return CB_SUCCESS;
+}
+
 static int amd_espi_get_master_cap(struct amd_espi *amd_espi, struct espi_master *master)
 {
 	u32 master_cap_reg, info;
diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 31fb06f4a3ff..184ffdad4a48 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -325,6 +325,53 @@ static int amd_espi_ioctl_enable_io_decode_conf(struct amd_espi *amd_espi, unsig
 	return ret;
 }
 
+static int amd_espi_ioctl_io_write(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct periph_io_rw *message_io;
+	int ret;
+
+	message_io = kzalloc(sizeof(*message_io), GFP_KERNEL);
+	if (!message_io)
+		return -ENOMEM;
+
+	if (copy_from_user(message_io, (void __user *)arg, sizeof(struct periph_io_rw))) {
+		ret = -EFAULT;
+		goto io_write_free;
+	}
+
+	ret = amd_espi_periph_io_write(amd_espi, message_io);
+
+io_write_free:
+	kfree(message_io);
+	return ret;
+}
+
+static int amd_espi_ioctl_io_read(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct periph_io_rw *message_io;
+	int ret;
+
+	message_io = kzalloc(sizeof(*message_io), GFP_KERNEL);
+	if (!message_io)
+		return -ENOMEM;
+
+	if (copy_from_user(message_io, (void __user *)arg, sizeof(struct periph_io_rw))) {
+		ret = -EFAULT;
+		goto io_read_free;
+	}
+
+	ret = amd_espi_periph_io_read(amd_espi, message_io);
+	if (ret != CB_SUCCESS)
+		goto io_read_free;
+
+	if (copy_to_user((void __user *)arg, message_io, sizeof(struct periph_io_rw)))
+		ret = -EFAULT;
+
+io_read_free:
+	kfree(message_io);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
@@ -369,6 +416,12 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 		}
 		amd_espi_disable_io_decode_range(amd_espi, io_range);
 		break;
+	case ESPI_IO_WRITE:
+		ret = amd_espi_ioctl_io_write(amd_espi, arg);
+		break;
+	case ESPI_IO_READ:
+		ret = amd_espi_ioctl_io_read(amd_espi, arg);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index ae76243786f0..4c67aa9f45a6 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -176,6 +176,8 @@
 #define ESPI_GET_IODECODE_CONFIG     _IOWR(ESPI_MAGIC_NUMBER, 0x7, struct io_mmio_decode_config)
 #define ESPI_EN_IODECODE_CONFIG      _IOWR(ESPI_MAGIC_NUMBER, 0x8, struct io_mmio_decode_config)
 #define ESPI_DS_IODECODE_CONFIG      _IOWR(ESPI_MAGIC_NUMBER, 0x9, u32)
+#define ESPI_IO_WRITE                _IOWR(ESPI_MAGIC_NUMBER, 0xa, struct periph_io_rw)
+#define ESPI_IO_READ                 _IOWR(ESPI_MAGIC_NUMBER, 0xb, struct periph_io_rw)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
@@ -368,6 +370,18 @@ struct io_mmio_decode_config {
 	union mmio_target_range5 mmio_range5;
 };
 
+union io_data {
+	u8 data_b;
+	u16 data_w;
+	u32 data_l;
+};
+
+struct periph_io_rw {
+	u8 len;
+	u16 port;
+	union io_data data;
+} __packed;
+
 /* Function prototypes */
 int amd_espi_device_create(struct amd_espi *amd_espi, struct device *dev);
 void amd_espi_device_remove(struct amd_espi *amd_espi);
@@ -388,4 +402,6 @@ void amd_espi_get_io_mmio_decode_info(struct amd_espi *amd_espi,
 void amd_espi_set_io_mmio_decode_config(struct amd_espi *amd_espi,
 					struct io_mmio_decode_config *config);
 void amd_espi_disable_io_decode_range(struct amd_espi *amd_espi, u32 io_range);
+int amd_espi_periph_io_write(struct amd_espi *amd_espi, struct periph_io_rw *message_io);
+int amd_espi_periph_io_read(struct amd_espi *amd_espi, struct periph_io_rw *message_io);
 #endif
-- 
2.34.1


