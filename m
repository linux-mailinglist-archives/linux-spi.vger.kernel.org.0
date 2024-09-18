Return-Path: <linux-spi+bounces-4852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFE97BB3C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAE42893B8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837D172BD6;
	Wed, 18 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZyidXOo"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C14F9E4;
	Wed, 18 Sep 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657228; cv=fail; b=rVnZDZYt/ZmnPZNwh5FFBiFMNBb4IEkOw0NDCDQtQj9mhBnGoZys6lhJXggEAY12KYEr+gIrSmgEqATxrsb2AQtdy5PP2G7SLpgbvI/I8gJLpTMJ9NdHO5gia+RU2A5Yba9SOOTx9NSnVj/WIPc3N/3kj2ohKX777F7npkBEP8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657228; c=relaxed/simple;
	bh=T1WBBlENekmNm1+3P0QP1VG3FxhaF37d52O3NSvRToU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK0EO26wzDYTk1IXNMGhclIdjtLUTHc6gVMJ0v39q4Ijtzveme+FBwIbxmL6bH+/Dwor6X8GPSwujlNl5N/z/A6rjwlHs+Iy83O2xI8A9nRFaiOjLPH2NRtkLP+9UnfLwCvy5sFuYzyiVQz++Uie57rH90QUcYhgc6rHnsjpb7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZyidXOo; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMxQjg4dtJU3rY+Jp8gzbSYHKr+CdZArBf4XO8pz2HoBZyosaeZvWKL8BuizkLDYDJEsG5ehijRMKeHx9HHaIvdo0SHHcT2TkcSBlSKKnOE2EjydyNdTuS5YIwXNWBH4QVq/QoAV3757/5HLPFTg7xVQrZ8A+Lg6xqJhtrARgX3QCvULTk7S4hHlogxNjYJFD6tCMZgwBV9ocCwacu0L97+btVuTzGQJXfovS1d/YBc+hH77yh77bOF+ko4ee0DRbsMMDmQlKxPdY9qr7qLOR++QBT5Xg92iqVEbl5EMWTJ/c9wP+xK3DSEn8VP4SnmWNH+A8PdbJX9ZF0JHQZ3i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BdVuzbL2D+alHG7nUTDPxI61FWIzoKqkJ/9uIblQUU=;
 b=w0fn1j3Q8uCcN/pxsngSqxVTX61+Y2z4rYO8DouU4EFQgNG/KWZ7wJsO1jyoygjkZmeodLhkKEq8/q0fkLj/teCEptk7JVH9DLmGaPBfzQJ0a7cLsF2yiFdz6Uyofyewxhd1HZcI5xiqBflOdjRN3woeoeEwwx6wh0JcVtU28C9Y8IhxR3GlvW2C2Cecg4LNjK6OV/5Tx0TaVF04pMqnUrY8OGGCmlRun4NIj5yJ4S9btLIKp2VG+ijO4Vh0jER4pE1NJHbZuE0izi6dHdJq8r6bWBP3XtoNUWkU+R6aZFKXPQp3WlrHdgNP5Z9B/Kcafr5rfwCiyLdJIraa+Sg3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BdVuzbL2D+alHG7nUTDPxI61FWIzoKqkJ/9uIblQUU=;
 b=iZyidXOonsYkHp8or7J1+T/UpAGQp1jD3WInPMZgD2O2VsaPGg4z3nnuqd6SWLdzTYhHxabrLzxq0Ol50ey6GbPH2hgPYhJPGJctLGk3SUNJwD3lL0XmA1YN8rZ6DAQNu7MeRpxmk30R56+WRWQEtAbbK4nRr+qkwyDbjzjGAZk=
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 11:00:21 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::8a) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Wed, 18 Sep 2024 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 11:00:20 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:58:38 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 8/9] spi: spi_amd: Set controller address mode
Date: Wed, 18 Sep 2024 16:20:36 +0530
Message-ID: <20240918105037.406003-9-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f87a0e7-84bb-4eab-3125-08dcd7d116a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kGyrEG1KN8GSDclEvPoBgqOnyL6PJ0i0v+4soWzQl6wiBt5Eyf1SZkHZTO2O?=
 =?us-ascii?Q?XJx9soSt6SfPORnv+nwO3iv5wVifrBg649gCoDYwEqoKVFWCkTVi15/ygTTH?=
 =?us-ascii?Q?CBDIl1qzxdGYvKP38DmFAKG9hqJxDU9UEBWsRD8vCu4R45KEBZmG0UB98aoi?=
 =?us-ascii?Q?IolEf8lXNFH2h5ZFBep9XcRST1mHR5HRP5MT9G3xgiUgYzi1IdcbmRnE+dbL?=
 =?us-ascii?Q?ER7mTyqb8daja+zy7JSo8+phHYCgI1Cq0neV5T8BO+lPe0AAYEIoBtJ4zKB8?=
 =?us-ascii?Q?4egwCMGNNefk21Z7ZM5+IWBoh6S9xt1gapPv8/YxahSDKXo5A3EB6EsVDZNY?=
 =?us-ascii?Q?d0Bnh3tOxXu02p9+Bjh9Kum+X0aPbE2/qjlRcEFjgmx8IOaEieuMhx9H2ula?=
 =?us-ascii?Q?U2XdGaS9Bxp5tj4TYf2eE14KGdqT8JzWKpg55TyK47ln1oDGsZuHV1MRnMhC?=
 =?us-ascii?Q?4tmwqxFa56ngPh3cLLWhDLwjv4dAc74Ivwo3+sFza9LQ1kTo328X9hoqKqhE?=
 =?us-ascii?Q?2JZFgyjh5jB2YvpU1JpMt6xua0nP03mEzYIX59MlRFWqjzeQnEE309neBMbG?=
 =?us-ascii?Q?ZeMVaKkGDk63VbyFKvWsBoaLvPL6dv8EzEQ+osMqOheZSyFuah5ErrT+fKUr?=
 =?us-ascii?Q?/BCNBXWVUXK7xIQKGCyiPR9IEQkfFn8RdTn6K3zRYSfGGifp0nh/kmRtJe7G?=
 =?us-ascii?Q?keJFG3RNdHGg8XCxbrgdm5MB3ejGuar0YI3T8av9O1tF8dEZ6ZMnCNYXqWyZ?=
 =?us-ascii?Q?7QnHDKBzlES83g7c1+jCvv2+os4OgeBxVYpZ9PdIqaOLPdOYnzRBXt4aGYud?=
 =?us-ascii?Q?auE4brq6VF9b4YRuHOwb0A+cnkQqj08noSQDM4AdH9cOnCsqnrsSByaOry5v?=
 =?us-ascii?Q?E64QvwCSudWWUsnj/OZOpIYZp4Vb+h1kFrxz7MzUvfUvP8JxhoXzUCwxpCgO?=
 =?us-ascii?Q?zkcqS1/a0ZgdC3ZynHZykuJKxZ4Du0/qinlbh+RVG6x710YuAia8ixC+aXfP?=
 =?us-ascii?Q?ubRKoX5aDyofS5Tg1OWXufTHpg8+1HacDrTHnW9y9dK9kPSQGBzdl7P9P0Bl?=
 =?us-ascii?Q?tUfi0m04xssy76xt8pBILnFE5Mqn/8wlj2zaLM3Iot+ybyPVViEJj6Juasti?=
 =?us-ascii?Q?lxzOGEAY5fxqDAapTQRSS5FmDddH2aI65CIga7/dmOBbTO3F8+QCay6ImNcb?=
 =?us-ascii?Q?nbjXQtbYDBQqYaX+oacJrctmn98q/6/ulb2IQTNOHR/7FfYKEp2L2Q0PAhvc?=
 =?us-ascii?Q?cjKRccV1EQqKalqcGujVZEieLrenF4nHRPh4sNy6dkEeWut3nSFfzC/Ar/eV?=
 =?us-ascii?Q?xTQWBdzzmO6kjPaOrqmZ9memxJe3zwmz/jRnGCbVBXbxwSA6qOSXtCm4inLJ?=
 =?us-ascii?Q?9BFuYr7EFuhlaDybcMhS9dUfkNzAqGNzgyTdlDEbwqyFz+sGxQg2dNInIM71?=
 =?us-ascii?Q?yBMT+UKHrv9NmimjeZrz92+f08AUZPdM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 11:00:20.6891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87a0e7-84bb-4eab-3125-08dcd7d116a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

Add changes to set the controller address mode before initiating commands.
The AMD SPI0 controller(AMDI0062) supports both 24-bit and 32-bit address
modes, while the HID2 SPI controller(AMDI0063) supports only the 24-bit
address mode. So this change is applicable only for SPI0 controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index f146366a67e7..50dfdf2ab6ee 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -34,6 +34,7 @@
 #define AMD_SPI_TX_COUNT_REG	0x48
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
+#define AMD_SPI_ADDR32CTRL_REG	0x50
 
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
@@ -548,6 +549,17 @@ static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 					  nbytes + i - left_data);
 }
 
+static void amd_set_spi_addr_mode(struct amd_spi *amd_spi,
+				  const struct spi_mem_op *op)
+{
+	u32 val = amd_spi_readreg32(amd_spi, AMD_SPI_ADDR32CTRL_REG);
+
+	if (amd_is_spi_read_cmd_4b(op->cmd.opcode))
+		amd_spi_writereg32(amd_spi, AMD_SPI_ADDR32CTRL_REG, val | BIT(0));
+	else
+		amd_spi_writereg32(amd_spi, AMD_SPI_ADDR32CTRL_REG, val & ~BIT(0));
+}
+
 static int amd_spi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -560,6 +572,9 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 	if (ret)
 		return ret;
 
+	if (amd_spi->version == AMD_SPI_V2)
+		amd_set_spi_addr_mode(amd_spi, op);
+
 	switch (op->data.dir) {
 	case SPI_MEM_DATA_IN:
 		amd_spi_mem_data_in(amd_spi, op);
-- 
2.34.1


