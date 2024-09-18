Return-Path: <linux-spi+bounces-4848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBF97BB2D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DEFB21A20
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37141176ABB;
	Wed, 18 Sep 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3d6dpNh"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88D381D5;
	Wed, 18 Sep 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657121; cv=fail; b=rq7Vg351blDYz3wqVXY57DYLlnF3qRUQwVHgDCKzoqm5pXubD8oXS1r9gy/g9YwwQXr1xd8Zq3UY5CAir+96Va+y5Wq5N0tCTDNn8vAnLGrDN1CnQcIGEWDi8HHtpIb6BWvk4zCk/Q4s+b/NzJ/1QoreTeJHkmjvCeLaRfnB2IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657121; c=relaxed/simple;
	bh=Emaa2qRpS9zYt8X7EtCUAd7pVZ/tsqx8i9np7MIHS5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay9hmFlTyusEqQ5dHb0lbZ31k6/nai5zE3tjVoY8rZ85TEovAXMXqmqX+wNpvaSN+Wdmhjh+tdsrjSVcUMgW0VYf5PVUspRLncGb/43PpnEh3Uv2rQBlgDaPPIl4qlVxmHTDrN2qWsDbWUSbBIsdVJwxrtCHAIS8XL4KmrIBdpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3d6dpNh; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYvDNwXLD7vV1fWQupRABF938F1EdZ4QEOqhViwnFP7em6yzB10750RJHi8BF80P2X/TPd5jkdCih131f0Uulrj/rZ0d7gvH7QitWHZoLncsy1WrWF2Ywn5/oQmz9Ww+Ps6WuLNyR7PxKSUNzxpxjo9BkYB1EMwE2x5U+9JCe4Tv/SEL1Z48+EAMu5l1VHCuVvj5SniBuwghVgyB/uPq8uPNt1wF/6ZxWPA5C1v8/8RDP7PDCKW4WJQnbffvnyr/u2oQrQjbv5YEDkE+DKVVd4zAX4xEFrZYjgMw/liFMGKMYAYtvt1I37OCuuOgtJ2QigMvLBQC0CKw9muhYPJXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdRIIz2zmYoiwGVAIXtdOSfmtuwK9PJ9YQsOVo83YdI=;
 b=XDrOAKsnyMeD7kg8Fd1GVruwDCOl/Fmv0AeOTnQIiPUIyHeGKI1BIh3/ly3+iiBc57l02UmRdukEbryO80M9ziK2U2sDd/5MBtJoYggpBmqyt9vBPCNvhTnnYKwUUNVX71JRiNch3PnQbhuuejbjOu2ka+KvwifQWl6orsX3JgKCVpB6Pt0vGVodg41I1Ysh9hNdMKK3lRZardZvHF1+e8Natvbk+8vvmXPcBqpRB1QGBYN5LuIrU8fWJ5Uvf9Qow2hoTMgYDnjljH39RIr+5WIuhmjoqcOla1bsScjTrNW77jpMTarTLEW8RjQiO8lZXAfb/AK93HpTg400zIUM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdRIIz2zmYoiwGVAIXtdOSfmtuwK9PJ9YQsOVo83YdI=;
 b=p3d6dpNh+AdhD09XbyZdlrOhcSQO8c1NJC++Ak5/JtxYDTlMtsTz89r7jXA/L/zJTFZ9L2f5WgPoUj9NnCjCimZBQPxynX7QgHEnPdSbiuaYRo1+M9B4/wyNVGAUR7Qt1AztGX9Vc1IpasUY0AFClRcsYdHoNTLdX3C5xX10w0o=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 10:58:35 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::5) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 18 Sep 2024 10:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:58:34 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:56:15 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 4/9] spi: spi_amd: Updates to set tx/rx count functions
Date: Wed, 18 Sep 2024 16:20:32 +0530
Message-ID: <20240918105037.406003-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918105037.406003-1-Raju.Rangoju@amd.com>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 341c52f6-cd08-475b-9f76-08dcd7d0d7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oF7hYARwVEiFjOJQLiUPB9822LkBH9D+bUzVW/130CXQhtbcLOMPVVz63D04?=
 =?us-ascii?Q?9jVXgg238nYVAc4gmEnraXyskIECRI+nP6awZ1lTzI6wIGnLlqFUIVdH0dwN?=
 =?us-ascii?Q?Wt2jWNto6KbSleqz2YZk7yJT1V7pDl6aSnc3rMpQwEv62byv6R+27Xc9+Pp/?=
 =?us-ascii?Q?Kqm9oDFuu2MIMXKSAuZZKjPZCf3OlzgmfsvTkpel/W1ZdURy15lvvCtofkKg?=
 =?us-ascii?Q?RqScMMzwO+SUspeZy/4COLQHnlsqd6pIfRH+yc5pXAl8fsJM6gDBxDzdN2wA?=
 =?us-ascii?Q?ERG0JJ64LEwSGPolJtJ/WM+zp9U1QfHORsBPRaJueiejaNtpnvSqS5KD+KUn?=
 =?us-ascii?Q?TREq2QkBR8jZwkerdRNaewJ2PxLyKULoo4BcZNn/la25hOnQ41gvGY2Sv7Hg?=
 =?us-ascii?Q?fRt4Ee6dTNh1XHfa+3yxN3S3jqshIMfjSZJFhrjZJbwArgDcRRrBMVn8DW4y?=
 =?us-ascii?Q?+6XKJknthp8f+fVr25SmB7NPJxm+LkULsUNZr8ugzFpGu8ZCE0wZ/napbeu9?=
 =?us-ascii?Q?YPUJ4UVO+25DawrSzQixRJe50dtrMQ0TL3PNiGLI3WmnRh6SHq6uR/q9GuAm?=
 =?us-ascii?Q?7AfMlUP/XZ26UIi3ZyyYgPqtDcqcjpjQPGw132BxAkne9Zpt/lCRMcSJ4TsW?=
 =?us-ascii?Q?Of4KFiuM5aoYIXY/ov9f14a7WZWe4mYgLtwcsDq3b2jHZzgknfuuwHSwEZpO?=
 =?us-ascii?Q?ryy5Q2N6sfC22P/1oNYS0gxP08xKFoG5TpqrQBJC6qlQ6ZTMNivZHOZ5vcAQ?=
 =?us-ascii?Q?UhvhFcpt3l3LfD8lTdHv8Yr/+gt6cvtigwSaFCkNFWa+UY14AADBL2Zp1k3c?=
 =?us-ascii?Q?X5VKdM6f+M84+Y6spVow+BJd9NvvPHjBitBXE0Hnh6gNRFC5AekPdOy8qXT3?=
 =?us-ascii?Q?7C1ThtIfMXQd5SBah5vI/hNwzC0GcRYvK+r1NDvK040PYg8Eps85IsFWGOH8?=
 =?us-ascii?Q?Zf4HCDPLeordSyuBn1zDeiXGFFdejiT0uCQzDzVmE52E9ZwQpLYNjw9CsMi+?=
 =?us-ascii?Q?6r4jStkiPtLrKBuK8SJqMsJcJNRpKiTiCFxTSA2xTTx6RZqz0WuTl67eAeET?=
 =?us-ascii?Q?Q+OodeG42ARqSXjgjkgVEMBeCb6trcK2gckBRUsEUnTZKcj7xVfCbGDlmgjI?=
 =?us-ascii?Q?cPS/WAw7mTxh4jfaVhIvyIy+sw4eUfOvM1iQRGCC30OH7MVVyYuQU46wH25u?=
 =?us-ascii?Q?VF9Jcjz9UXFOtcKXop5BOVwvqNAvVeaJs5RXuE0LzpVyJKP9topBs3Pi1bHM?=
 =?us-ascii?Q?NMWUtMYzLjPr1ntqyxthjSgJ4xFITD4ZECgkur+rfsslrjns+oQOutjvVXUq?=
 =?us-ascii?Q?rEG7kyjHD3MyO9fBa9KDRNs6S9DvWohHZDoz2phLBOCeeQnSd7Um+xEG3lAa?=
 =?us-ascii?Q?u/PypYz/LSyOrj7Vve8HiWaBRZ/GrBOh7xXbyPppL5rVdNvox1dfnENW1rel?=
 =?us-ascii?Q?x319OfQ4u0fs4kjIlE7wgzcGXGTo2PRL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:58:34.9355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341c52f6-cd08-475b-9f76-08dcd7d0d7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

AMD SPI TX and RX counter registers are 1-byte length registers. The
existing value will be overwritten during register write, so masking is not
required.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 11ae910bb420..eb16063ba121 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -165,12 +165,12 @@ static int amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 
 static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
 {
-	amd_spi_setclear_reg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
+	amd_spi_writereg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count);
 }
 
 static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 {
-	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
+	amd_spi_writereg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count);
 }
 
 static int amd_spi_busy_wait(struct amd_spi *amd_spi)
-- 
2.34.1


