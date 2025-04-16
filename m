Return-Path: <linux-spi+bounces-7615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C523A8B757
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2CA189FA06
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A123E32E;
	Wed, 16 Apr 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dR49k8e+"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34B23BCEF;
	Wed, 16 Apr 2025 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801606; cv=fail; b=bmjJudX2GsGfADwjAqyCZ/Ngf40PyGBgeg2Tu3jrK+o/e+EGrH/I0x4YgU9fV26RXF/5e9mWsjL04DtcPwuIJgEow+UaqQtP2rAmRprd5DIB10bBBzjohCjsTan33ew7u+Sbn47t5+jLnJggF4VLncH6BUEw5ySSnh62WVvsLzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801606; c=relaxed/simple;
	bh=UNy+mPzmKjsbJtk8a0Ul3KjBngS8ly8q87LJCgqfhy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN5YSwJeQwnBewysoow8f9d+G0IMvPsc+/DLgrhSMN4oweJCifBFT4qgVzWEXsfcjKTWaSlzTR6rbmqKdHPsrtyslor5rV7Fz3+mKD/ikq2ZjnDaXundnr1WdAGoTMLmJ06OJEo/C0MTyUyokDMxF8gUMusDlNazI3mk/XXsDGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dR49k8e+; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEqcNlg4e/UU4/0YWEI2IzE7MqmraTU8Hv90j41Hko1PTZk+5951JfIIFKd4aLIfXXoVIVFyLY3WmbTXnIE0yxWu6NL7ia3u8t5SLNb6Lg5Q3voQy6GAFmnRKWXKN5QSyuayXlwBtN3Yy/LLXuCeXoPOL3dx3Ol6LTYSKVY5oT9mC3zaqm+JS8lbFoO+E0qqge1Fa589T1EOdyg9QToTLen2HDg5MC0mvHsKC70PbXt/f4zbzVNV2eLOS9bVY786eZ04pEUmehc7BehnwvJixQiOl1JZb3Hj8J6bsVksVtd6QrM9Xa0vV4bMzvZRV+eMPM8bvuY7MPu//EsCNGiFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTiGAvaW8FskL4xStQPXREwoZwcQA6Q1vDFXBlgrusA=;
 b=RFh09B0UxCytEmcCp4PI7yhmVLho7tMs6E77ae8LC/k2oB1cyShWFzflimTqBZNmup/d68nBAP+qcuyQ23cFct8ddcZIhc6nM9DdhNsqVY49uEvV3BdfmPTKFLhQXSkdlYqCn0NwujQ1OYElcmcSFvPj73hbLAXWqTksUYW7x75dRzCigxBkcWnl9wySRzIdGzDBD1A6Xx5BGTG7IB/w6zv0mRQFq9NLV6PheWxYyszha6BD888oX0znsoUfdOtavWnqkmsM/KcX+QRczumg/4eUu//J8ViBGRy/0cPZdSlCAJ6sa5uaiTY9AjVuVTgiDx2Vf5CTy+Ju8wE0Ccf7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTiGAvaW8FskL4xStQPXREwoZwcQA6Q1vDFXBlgrusA=;
 b=dR49k8e+C96QujBa6es08EX7PZSJIHxhczqRYzWlfMKPwG0vMGhXVKGzulBpbUzMFOeaGUQXK4Ri2hG9uNsgMsB1fRmsbX5hi1j0mphK/CsljjzPfXRkUKEuVew5gmKo8KTd4OYx6NTzwhVz3csEBBHUgR4pSMi1j8k2QI7wUErkdYGz07q6vJ3cJvdxXVdEix/z8e8G2t8twtTED+dj3HwhZHm9vG7VaEi3IKzCn+huFx2aZoy1ExdKGMNdmOgh6syUShXgkX9W8abkXJjV69eDsgW47/VDFPlsyQeeQStZnq01PfSnW8r9Q0Whn4EUdJ6rzcG9YgUTqyLKseqcEw==
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 11:06:39 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::6c) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Wed,
 16 Apr 2025 11:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:23 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:20 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 2/6] spi: tegra210-quad: remove redundant error handling code
Date: Wed, 16 Apr 2025 11:06:02 +0000
Message-ID: <20250416110606.2737315-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e2f307-89f4-4f67-57d7-08dd7cd6c306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CjJAsRD4QGExWkxJXrs7iucLgx63/HM4cCxMsEkjsWMLXZJWi9nIHHqAMx79?=
 =?us-ascii?Q?/ims2ZIYXlHeYUMPZU3BEPzA1yvuY5CU8mnvQSHNeHjli489oAcTJv6YonNc?=
 =?us-ascii?Q?RG3vFV9mfPOWq5hK0FlIkHxId3vs6jJWdPwMi/ZELgB+5X2AYzYAtflp6AoS?=
 =?us-ascii?Q?YpgsrYziBeFXkl3+Qf2wo88ANnCWbAs6Bt11tKFguNRMjo9cPSM/3UbVcTMD?=
 =?us-ascii?Q?IYGMr0lHSGZnSeayGztrCdV210gnbbV1YpcZCiWMXpN2LPxh13wdTrc40uz3?=
 =?us-ascii?Q?xdXqNfQv2KX4ykhimJYm1FDemc7ccd2Zt8ckkkESVht1Qi4DsSj3YCLAwp+D?=
 =?us-ascii?Q?yXxnZPx3yNwGxJ2kPA4FMQGDvrrCtrVNa5NlpnPw9gqNwZMQTv5PpxRVj22W?=
 =?us-ascii?Q?ihQgn4X5F3weGEmPsfa+UWkEXAlJKQKC9P5TWeW/FLYlRlTJYm0/03brqZn3?=
 =?us-ascii?Q?Rb7MNcH0WVsZ7hsvDmrAz8zNgLJuVYQz99wef/RiLGDb1Gfn+Msr2Xcw2r0M?=
 =?us-ascii?Q?OyUzJDQTnfGokusngLQ4aIdvEDVQLA5p3hKiV4g+H+NWxZgrasHfDgiJK+9f?=
 =?us-ascii?Q?sYaamXc+CfsRHbodxDVA8LRys5YKDSnsy0aTrbJsVPFmU9ZI6xEgbBvzC+MC?=
 =?us-ascii?Q?dFG2F1hKy+nSTH0OkKoGdtcmZeSkjjBFrQt+tZ+4vpCB7yXJS4Gb1L8tekqj?=
 =?us-ascii?Q?YxtwYbzychso3/5Mm/8PaiLHU5NcgjBLcCnBEwlI2+F1Q+Kd5vtw4GxkgKJC?=
 =?us-ascii?Q?Y51iMQAeHspVfQKMJTI+aLMbIFjPHJ0cks0MPMHXlEL2rFkXmSbdKBGFru1E?=
 =?us-ascii?Q?g0ulzPKAtyayBQ21zT5/JaEF8V+QVXJQ+oKG8x7BDK4MX3zij2UPlDXrkadP?=
 =?us-ascii?Q?4wJqVd/EvXoOt4pmc/+bB5esusowelwIdRhzuRtpv/JbPUZ+zQ8MDqGa8ZLr?=
 =?us-ascii?Q?QL/5sl1k4PYxeHY8auMhtROslyxpobMCDBh8jLZYt5D4SgMDdhoW9VE1Hw8t?=
 =?us-ascii?Q?eH3uQNftoARMI+v2isn4NQz7QEZmanIY3btM5ylZyrM2p6NWIHt981YtP/xg?=
 =?us-ascii?Q?xAL8CdHksTisLlPMnaEztVkCcVAgpVpSuTmSOM35fQFux6NoW8s344G+ZQGA?=
 =?us-ascii?Q?RiuVuzpvPnhlRDFD/D5KeY7ELe7a92X4vMlslCi1bmwdUPt6j5uHbzbU/xeX?=
 =?us-ascii?Q?GUlZMX4cZwOSrjPrYf1RVQi461hVXBO+zgLTarRzLBOQjdtF2weSRwa3GUeb?=
 =?us-ascii?Q?JK1FDxXrvCL8E2VwXzQ1boIg3C1t6/EJdAa0idHQBHDTI4XPpAZVFXsihw0J?=
 =?us-ascii?Q?PxzCFKFTLflO6mT71f7hE5BCuNfzcN/HYBxgmfp3oTDj1IybkMPsYSokXeMd?=
 =?us-ascii?Q?dtacJTckkCuS+y83aA35QB2mS8mIr4Ah9BZtcSWZ1r2lF7MQaKXGYLu9T16+?=
 =?us-ascii?Q?+97UGyv2/D1afzL7s5Id5rc6cSP44tfQ2X0kc6Xh/m7tjMFEmStzfILv9yxf?=
 =?us-ascii?Q?ZupHHTGWQ9vb48ieMmhfWNY33x+1vyyhpV6dsjZkN1H/ZrzH0MdSVupFGw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:39.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e2f307-89f4-4f67-57d7-08dd7cd6c306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

Remove unnecessary error handling code that terminated transfers and
executed delay on errors. This code was redundant as error handling is
already done at a higher level in the SPI core.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 4983b1f705b8..a9359b005ee8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1175,10 +1175,6 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 exit:
 	msg->status = ret;
-	if (ret < 0) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 
 	return ret;
 }
-- 
2.17.1


