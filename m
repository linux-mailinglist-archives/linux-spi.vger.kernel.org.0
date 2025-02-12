Return-Path: <linux-spi+bounces-6783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C13A32908
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645E818856B3
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02D212B1B;
	Wed, 12 Feb 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biu9Dx4N"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2221170B;
	Wed, 12 Feb 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371668; cv=fail; b=m6KSs7EdUzgP3/HCStOgaTA/cMBZs+wPMLW44+1m64Mfh7zwZcmxbRlnYOILdnNJ5glccQF6gCxLiMslaO7aNLIcEixCTLQPxrbVThCqYYPswRy5phI2h85t1XCXLKHicfiAmyYtRK64CsI801XYOXd0ACBriNEbvwd6qQoOV7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371668; c=relaxed/simple;
	bh=kfTWKZoZm+Ids9s9wno1wrLMbPfsDQJ18NAd1a45Lcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYPrek4hTLPAsPIjkkTLTfAsWpTFiz6j5GI9IGHkwvcOQpn3zoIR+HHV3iRx3hscZLhIarPF+DfaWGx1oMsuyMvIRhKojcoAYN/wQ0C+TKvgUBgH93Ldy5uduviUuABeRoJ4MxhEQLcNvg2DtFKEP/pLYCWf0NYYaYmY+G/CVMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biu9Dx4N; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu7qoLnmCtz7iOOyCPBj43H5xCeAyD/TM7v6e5V4gDKQFu/xant9ekb+HTH4mY644lgJJ2za4u7s9XzAA0N531m2wI32xK6Yzzb97YG093222SoDz46XHRfhTcQtPSik4L63vGxrnFyfL4nFS4iLMiqBEtbOIx85h/730TMDEC41MgeQ198hAOMvgMQfrTDYpmJxdDmu46pr002yQMwpAW3sqRN0lfH35SYXJzTy27xzBNBgJqaOK3b4c2uVUBkijg/tlWPVo62256/aoi9CUJv34p702NbmTHBhJAMNGCPzS5x/8w805obLFtccLENOAhA4wV79CtQxDkbUaRta6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De28/O4XCTMzQdjpG3r8keHtwZH+rHCmLNT446XPBAk=;
 b=X4LlApNeYKkhhnJfmb2UJkwOUL36qfCjdm7o5x2TJn/oLlBrSSZFDKIvNPq8fo6wvPWzPDtlwUpnFV+XcA5SkROyedMqOlW39BlAOLoNLeg8G+r0yIWq858YiAyPwxeYh0Co7/oSVFYnO4Dr1Z8PdzL5ABE4BAfqnjzuKrmPWCOypPCsxfBgvge7+QDQ9aogk9l8UzmjwmsxdVTCGVls3Y5T1rrIQiVVH4rL1NLH5MzpkXLvFbF0tkbQvUBvAsR7kUmy5zH5ul8Up+F+uc6YibwYpQVcEWhUyQhj9MAsP9uqJlbmNFX3PDqxLSGtSJO2adg531jXkR+rSpGtiyzhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De28/O4XCTMzQdjpG3r8keHtwZH+rHCmLNT446XPBAk=;
 b=biu9Dx4NDJFBp+mAmxMrtcp09b5ljL/9diSA+w+8zYaRxdNTxRE9aHfGYNkvNJjzRUWi4Wv1ZSy8IDYJGrBnl8TKckAVwPdnmW9eOHEv9icMUOZ5WAmXfkyl/h3DqbQgM2qt4MmQXB7HZI36SjFbpskUsnO0pagU7RGnIAPnSUaSIgNrF5tqUwD8T959tmXsAZBi1F/E5Q3zhnp/4zLh9debTwOH4CgUA7vDHMrloiPaozcx550FT2NZg2iFQsVQ4wcpP8wVhUCqeuGtCCZbvIqDrjhbq9Il+xRAZl3epBSgfZ7syhwSj4Vj+sH3CWPyuLxBouOFIaDs61EDgoAsCw==
Received: from BYAPR11CA0076.namprd11.prod.outlook.com (2603:10b6:a03:f4::17)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 14:47:43 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::36) by BYAPR11CA0076.outlook.office365.com
 (2603:10b6:a03:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.15 via Frontend Transport; Wed,
 12 Feb 2025 14:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:25 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:22 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 5/6] spi: tegra210-quad: modify chip select (CS) deactivation
Date: Wed, 12 Feb 2025 14:46:50 +0000
Message-ID: <20250212144651.2433086-6-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ec5797-a518-4254-9b6f-08dd4b743515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tbiEvXNhPIjmD7o1h7ecqFJ3UsHDZev0MoDRvivsMCCaEQO+IlKOoeh7gVoJ?=
 =?us-ascii?Q?NowlzOO1i9UgW0mPMjdAi3mcJrzITqWlFKbAKAo2ATtJ+Zn9PUYX1p82GR6E?=
 =?us-ascii?Q?COCQBrNO8/xrEUqGnjqQGOsdW15XLbsPZ9w94moJcOF0CRRucVrgbVgarEhI?=
 =?us-ascii?Q?rGDd3vT0V2c1A76TEj6DqL7paWR1LXAsNP0yZ8pJobqyjT8WEEMJuelc2swD?=
 =?us-ascii?Q?UzENAmb/uKchcmj6uJOaESsb7q+PvdXEokuQ7deT5Zj1VgTqoiT4bG5jawcN?=
 =?us-ascii?Q?OOHXXsn6EAnujcQFJYKTLEDEDrGxjvvz2jFqGB/5YxsSP/R/GT6rY9Fqbnb6?=
 =?us-ascii?Q?wT2it370EoVtPU8BhaTx6abSCw8QXUuS1ptdhThGSK+F+uAQU/JzqYgEeNLJ?=
 =?us-ascii?Q?UQXMXsxEzfqjr4ZYcwE4rG83JDMsdRhdRqv8461mUSkE1Fx9wfSL1J7vOM7u?=
 =?us-ascii?Q?0A3OyirnTUIChWAGSnOVkuaZDHCELHpoPAiISQy/8Dbew43sGXBkBceCBp55?=
 =?us-ascii?Q?cMpSyf1yUR8TST0d2ODc6OP1rAvqt5zbMKwnCGnoIimxwNMtie83bptMD01v?=
 =?us-ascii?Q?ktZlVQoD/rm+kz8W6RTTfY489bp2B4PypjFOrzlz7ozVIXrwR+/bHPGCqClF?=
 =?us-ascii?Q?qU1VMIWoy7ML9EltK/5HcH/cEqvZ0XW1Sqnmmx0TD+kfyMGKBJZ5l9PWBUoP?=
 =?us-ascii?Q?dz+ycLTEQt66RsRLGlWrBfC8lXL6ZPByiwKNUyigTnMXn0Rji2hAKHnduPXn?=
 =?us-ascii?Q?FyhU/zc2viUmefS1WZBHqytzMrks/HvSR6oHqX401G+yie32ILRRX83wS9HI?=
 =?us-ascii?Q?745t6wDHeQTK4KANMqQRqmlMVeR68uQ0Vkrigfl4Z2MyrN4Qa/XcltqJeJxT?=
 =?us-ascii?Q?XuMU1jFlTcthLl78HWJK5ZXCDj8mrEblY1zKPRVAUg1Z+nmD5BsOtRC/RQ5m?=
 =?us-ascii?Q?gZWaUYz/LZeNCMYygVyv1D8LU9dFWNWBMWm+fwD2JopxIOw6dQAXsYZpH/q9?=
 =?us-ascii?Q?Hhw4E25mf+MmDfFmhvzsnqqdZQsi+uw66NUndzokScj4YEjpd4g7p6WF+u9r?=
 =?us-ascii?Q?iFy/BbWrfWKTfcbJrldpRdg0vTYh6XfOvKBtt16KFTVn/43EIrFhBOcPkkLO?=
 =?us-ascii?Q?leTaqCqTzisFnqHS0DWFPtScubh/wvyioyzsizm/jy9Nj4iQEh8iyymPTa8u?=
 =?us-ascii?Q?nMIiAxCzl1NqGsc0fW8ny4RmDrZZWAJs44j0e2zrqKdf4atdniz1m4uNUslO?=
 =?us-ascii?Q?bgDV+aCYbq39CBlX6XnbIKkOohka/oqZBV92etEYaM7NgMJXzugrnVopc46R?=
 =?us-ascii?Q?yx1/6wQRjUHbf7xH0fZYTXi/SCztEER0n14Ahhaaed5WyJZC5yok4f3LFRWp?=
 =?us-ascii?Q?wvo7DGwgYkTptkaV/MViO7Oa+HmYOWFhocVmVvwVgcI9m223uviGj9TCbKSm?=
 =?us-ascii?Q?xmeWYM5YEqxCFHuUXa2iUgBYBkb1vk7seoN1LaHx/MU25TsnZcioEDYyrwXJ?=
 =?us-ascii?Q?7FlGb2cEa6YBEyECiqYXu6U9P2QpKcxOKLGy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:43.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec5797-a518-4254-9b6f-08dd4b743515
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

Modify the chip select (CS) deactivation and inter-transfer delay
execution to be performed only during the DATA_TRANSFER phase when
the cs_change flag is not set. This ensures proper CS handling and
timing between transfers while eliminating redundant operations.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2d7a2e3da337..04f41e92c1e2 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1171,16 +1171,16 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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


