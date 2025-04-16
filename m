Return-Path: <linux-spi+bounces-7616-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6EAA8B758
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB083BBD2B
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC72243947;
	Wed, 16 Apr 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPT6wzEB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871632441A0;
	Wed, 16 Apr 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801611; cv=fail; b=s+pIwNEbDJaYY+S8mrayclABLsdwSxPpTxOQk3jiQBkeDbk5je//DSZ6mSsupWHDF6wR4s/YqfQ4WRrSscE1caO5K+zN2mOrhpMd7rQI7mJ/+zxFktBDaBN5RRV1V6aVujxc93tR4wtXJ0APU6e3mUXe6EGj0HJAOOKxBbGHDF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801611; c=relaxed/simple;
	bh=Y5583duQuHmRpHaRDNWhgEf1ZpRumPRNbCcjr459/h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QECvVh7KxUzyO/IlX2pVW49BreGmn6F01HX9jyjZGhu63ZWjB1nzwhjp2geil3REkcdxFUKpmzEaNRjb2jd2tA/jgTw1Ulu3/1kSyFrL6GPWm17fBgbsj/MUWzecWt6SjqCIVJNlpliCh2NjvmyxpuqLHw6OAWTSihfpJX9tlEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPT6wzEB; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmoCEOEZOEd/Q77aJkZpEPOQic/RZ0yqTxubHUb8KmY9kJl01hnZVozvSTg2PUOs9SRs6uBpQxJGpcb4omEcjM7pbyWtS+yOnWz90Q9ahV3tIRnPCTYh/pMBRhtduLuBTHSiPmIcbhr89/eM7Nqo9dZ8lXp9CRs6nG8tQ7zaOcIX9SFN+kw+fWZzZ6n0nOilZhmZQHHfo//LdgeaBiUw+HqybfKqE8gYJypqG1PoPzoWCQYoazNTJdG/QbXW3mwN/H7pmSQXWfFaMDNLwoZej5JI1serRizX4crdvzxb/2wqLstQ6TVQUpZFsNA+vR/3Nu5TsxwCoJFQK3559iTkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaKh4umcN8wTJOFm7OLxlTzd/qVFw6y2MfaHSbRCI2Y=;
 b=Qrz2VTcSGLJRy9j70qH7e9gMGjzqmhXVjUbkQa4rGNcGX6JlnK/6lShR3s9MKluk56DNuXwaZpKR5iDXn2r2qWBSVpfo/3bRlCuSvM3AAXTtQtQDLiEt2hJvwe1n7/qrHAR/1UVl1z4N7VSxR/2VCoZCuyimbKY/0RFAmc6IwCuJ3FbnEIPB50Su2XoQ9xAqTwf6P+3psKFGCvvKezCOqyvI8m/i96GqFIXJ6tWAPFrPLTP3dY8fpHyun97U1KaBN5TnllqsEH6SkvSKpC90nF7TjUBNpuMsyD32sqe2HgPuw3rwvcGJeQ3WpMmJ98ZtzJQa71/oHtByilxi0ku+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaKh4umcN8wTJOFm7OLxlTzd/qVFw6y2MfaHSbRCI2Y=;
 b=nPT6wzEBiPrb+7M10TAMmKpO/8jnJn65VHrqKBThbv0EMfEVDyfQTCEwQe41F7ChLcfY5/dynUDFClMQrPzqIHtL49GgISDEhkB6KO44uQgWJzA9LX3ghKoGcVmmnfUu35j2aH8ouyedtPotMXfNCWnIXwRswPcjVyXEwtO4UgEQARtXqJzygSKIL2cOokcxT0i5M+NTKXrjSY2d9wn+33shtgfD1yN529HWf2fkzEVW9H+iOX/fk4KGxJQlAM2TnK325iRAhoyixbSLcoFDr+QK3xANrU90c+EU2lfCRQ2xjvlyy2Ewit82AeCmfB5BK/UpFW7F9M8zg2TU04NSoQ==
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 11:06:43 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::9d) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Wed,
 16 Apr 2025 11:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:06:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:28 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:25 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 3/6] spi: tegra210-quad: modify chip select (CS) deactivation
Date: Wed, 16 Apr 2025 11:06:03 +0000
Message-ID: <20250416110606.2737315-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: a388fa61-881e-415e-1394-08dd7cd6c58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjnCa5hwWpdWHKozXc2LGChfe8dywqRTaSnmksZu0OKvZEvi6yZh8wVHgJ68?=
 =?us-ascii?Q?zCm8mDfNd0seKqJwZQSqUQcQpkqBYB6wzgdpZM0gHWjX/oMgEEMOeTBysYBi?=
 =?us-ascii?Q?FyMSlJDu+kj7VPGU5EjN0o+XSIsSCYCoocFLR+NGAFjrfs6Uwd0wm+o1m3xv?=
 =?us-ascii?Q?WW1NWi2Jwm309ulLlf2LklS24j9v5GLe8iXOVGKq7mXG7EmHBU5fljEoXhbn?=
 =?us-ascii?Q?CRJOJL/N1nywhnhkJ6UskKYPG5Nb9JpKogIEsGQKwYSmNwX+E4PU8SwFAT+f?=
 =?us-ascii?Q?GrXz0uHeacRVYtPXxjnktZlLmugYrDvW8wqD14zkcpNL120p/tjwsEsW20Hs?=
 =?us-ascii?Q?ET9FdRHMCqrbktgMFYOeYalcM7qTIL5Y1rFcWbdTbGzbj1gkIlg9P0soL/Ly?=
 =?us-ascii?Q?hjSwQR17ZIMN3Xt3twG8Nd19XaOlhNQ0MPRxbcHrdV++FZ7c592yF+gTT6Ze?=
 =?us-ascii?Q?Qht9ERszfHRx8mL65+flbAdlcdByHVQJCV0MG37RQDuYbpahCoK7gH7BhuZQ?=
 =?us-ascii?Q?HtWNnmZmCN8mYOuisf5kG0UQzTgyRUaSHmmNCmdk8inXB5AwgFZg3d6bY7ht?=
 =?us-ascii?Q?Rxv0VeFbcDt4ZcJtEXDl6w0Lz/RW8VEvi1XIGV8XhF7ZgAJ2yEhPu+ZRJT6y?=
 =?us-ascii?Q?JGxr50ZooDw7EHCap/WeHhaild2k2N1Yq80kVdGerOFmdOME04oDO+lHTB1H?=
 =?us-ascii?Q?FkPLOce/BqFo0j23xl1qb5bDj/HorkGNvcbwQAv0vyF9pmLwJNXK2yqYeHYt?=
 =?us-ascii?Q?mb8kp+eaMpJjzp4Y4RfBOXZEwpmdWyskvCOXbLz4efxksne8sZK+ba+VB0uN?=
 =?us-ascii?Q?GqtApOuJZxNIw25oz4xoA+TvdGf5P0J0CsAsdp8gtYTE+qzBebBsNt8PQkDZ?=
 =?us-ascii?Q?BajA+zkbLR2Hj/hG+wQ5v3j2dq2VNhQp8OE09+HiKwRpYqakuM+6wQAAVl1h?=
 =?us-ascii?Q?Dw+U0TsLtNeEfJ0wCAarTmFYmd6Nb1S1P9xtjfRnifx33ctxwrKULiGc4x5l?=
 =?us-ascii?Q?BKqHzRxNq3I9bkobgCseCziY4fGDL7YfdIdQsg4K1COEYmz6IhxniTuSGEss?=
 =?us-ascii?Q?ndHHhL1eiFkFoWPmhxD15E1wZ3Eut0NaeMQHGDO3kIE4g+1vowdxXGnTHw55?=
 =?us-ascii?Q?V72yB662WVH8Z9NQmm18RGVdFca4bS0lZiKnAjPjqq4O+A8XreQ8wJFR6HGM?=
 =?us-ascii?Q?+YjeKvng0/8FeCyoWnQtG22Le4RZJzkjMpqZJUMejxDz6tUxUCeLDte7Rfvk?=
 =?us-ascii?Q?1p0uE4o11ZSntImt6ChNxtIx77tUmQ9cmS32pvP0eu9dm0SqDaB7IUUA/rS6?=
 =?us-ascii?Q?sYXApOKU8e2Kl2839qi6gLiR5tElrFFwWE3FXCaldvVuBGWN0Lo3058nziDo?=
 =?us-ascii?Q?+R6V2xL9xUq1zgzF2JUtX6gTtwVy+2V1KWNAz4QMRLB7QyD17DUvWTdVQ5Dt?=
 =?us-ascii?Q?nKEmeDGD5Pt6poDfBh1v3PUX7Fxnlncq1QfYp0zD0Xa/BFLGtpY5yH+FaS/j?=
 =?us-ascii?Q?uG/A20FcKSUgnZzSe4Ww9+O0U6rpvUBgNVpi3Ai47+lglgwZHetF5+S3mg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:06:43.4340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a388fa61-881e-415e-1394-08dd7cd6c58e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Modify the chip select (CS) deactivation and inter-transfer delay
execution only during the DATA_TRANSFER phase when the cs_change
flag is not set. This ensures proper CS handling and timing between
transfers while eliminating redundant operations.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a9359b005ee8..159fbbfd4a38 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1159,16 +1159,16 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				ret = -EIO;
 				goto exit;
 			}
-			if (!xfer->cs_change) {
-				tegra_qspi_transfer_end(spi);
-				spi_transfer_delay_exec(xfer);
-			}
 			break;
 		default:
 			ret = -EINVAL;
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
+		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER) {
+			tegra_qspi_transfer_end(spi);
+			spi_transfer_delay_exec(xfer);
+		}
 		transfer_phase++;
 	}
 	ret = 0;
-- 
2.17.1


