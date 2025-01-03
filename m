Return-Path: <linux-spi+bounces-6213-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71367A0040D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 07:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB2162F8C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2025 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F31B4130;
	Fri,  3 Jan 2025 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJN4w1bN"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358001B3930;
	Fri,  3 Jan 2025 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884311; cv=fail; b=NYoZLHslLxeU7bjbJHjqLRdCACcjqkpzqonzMTwR/YJTKIoKbzFrysLDhm43rrv7VV0CA7XxSpF7YJMEq+XuwBjr39/GttUiQ8TB4/XiLQcSnux1lr1TxHSy8mul9X4IDw9mh/Cm94OeY2qJ9sp52bFH1lELWl0EPSOaOzWT13s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884311; c=relaxed/simple;
	bh=eGSKwWH0gK+SWfM/cKFHxW8nmCht+Kb1D9ADG3gAPj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JK5dFbs/QU6YJVbL1dtyPzYkGzWUrIi7bEDZoNeUdczV0sfGDVvnk44waAMefAV5cUvdKX00b/iW743bAt7RuMcsTdXlqxsrTFmHoOEjG569OcwwTpSm8z4qtzldJg0sK05wlYaa8FPro0/R/2PK9vLATQDa+chiXklpPvVTr3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJN4w1bN; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEhqGNvLkA+hgzf7M6YuIb5+rcdWISeBlLmnYrFXh5mViVaugvsAiUyxTkc55JcmHvjRcJFg5A57ry2o1bLjR5TbyR9jqBflvwnKOyQYx//Jiwj7QPAvKkkRyLHu0o6COgSDUx5PeNaclFPdgqG1mIzyqQa8+qyB6LsALeqHjaXw+Xy4rCIskE+TPJhjpe5iesUnPLEbDu+7g44X9dZvgM0kUMFSkKU4xFTcwuW48qEaayDcvuQAkrIwvQkuhkCIsGFVQfs/dTtueSHwlKwIW4GyH748nJgmjXSz82odVBQJysCQ9nzNJ1s4U0ZhzyONKLRL1aUIIV3YyX/BP6h1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fygm+Bx9ew+rJAmIl57Div+wMoH33N9OM+SZQZH5hqU=;
 b=f+KJM1XpZGpikbU20bgdttoAUUT/54wgtQuTQSNSzAwtG4jBRQIxcn35pH0E/4VrxwiPI8xtZF1b2bKQQeqDfwbfH2VFHv5QtqdDFNULdWufEqIqw3a/ZqwQ8a9eiQS1Xuhi3Xp6OQjOq7TjzCuLjP8LLnX+dIGcEeVnlhk6ESX01ERk/TyWQB0cXZeFh2e2br3Id+OFAgw0xcqPf9EFI3KZv+xQecfqHwqk8mvMOeyl94lg8+1LLPSqcgLoNn+4JAZmV3rrO/Xnp0nAbn8CNGdZ7nBdcOTIa9xruHA7VK8lBSExrLqXMSiw+1Efqo1ZWr0IICxvX8VL5zevqONM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fygm+Bx9ew+rJAmIl57Div+wMoH33N9OM+SZQZH5hqU=;
 b=DJN4w1bNM4AjKgedbc2ZJteGea8WgD5Y4BIU9wAGPoa5UF7KI81720qRvjK5aMuuVk7YtL2naRF7nWCFCYmlSAMgzXcRXxlE/AMBVNTjZ2oSgEDY+S3Lsj0+W0kR+d/fk0c8n5Yl4kxPH5g7DMrrdy7/fgmEKj7gxfw4TNcB9EGCQOupjg5pllLTjwMIXRsx+256XSiu1hvLETLuQce7y9GMx1ETpHk7MBl3B+v+GVtsck+h9V2QSfvRUwkvzgF44+mAA6lQbGSAfxXEEBB2T05VHbig90r/2rpZLhWkUklTZeZGKfktCM56UcTZJng9brW2dx0HYisZ9eZn37Sppw==
Received: from LV3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::17)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 06:04:59 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::e8) by LV3P220CA0012.outlook.office365.com
 (2603:10b6:408:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Fri,
 3 Jan 2025 06:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 06:04:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:45 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 22:04:45 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Thu, 2 Jan 2025 22:04:41 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH V1 5/6] spi: tegra210-quad: modify chip select (CS) deactivation
Date: Fri, 3 Jan 2025 06:04:06 +0000
Message-ID: <20250103060407.1064107-6-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103060407.1064107-1-va@nvidia.com>
References: <20250103060407.1064107-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bfc7b7-9df1-435e-779c-08dd2bbc8db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sOanVymH8b1PYgmxQNx3jET7Zr/m2D3wqvp8OX/w070rJvsToHm/cWHClcW2?=
 =?us-ascii?Q?8xSqebBfqtLR9kJ5s2avIUV0URbAr9TFhJBs6Mp+kdNn2Ndb4mBn5FkZbuWl?=
 =?us-ascii?Q?lw0CrYkP24A5c/tCW+BdUhPLvh5Ef51TigZZbDGpb0rhedOIE3LIJSh0hrPf?=
 =?us-ascii?Q?WOclCN2TiTuKi2hjvEzdETna6fXqhlv/29y3DD0qOJgGRk8xaR+wLRwhQjhc?=
 =?us-ascii?Q?1Eo+8rcqFnbzTYWaBWLLV8PvTdV8wS5VEIM3ALuLedZs+S85fG0uf1dKfd9P?=
 =?us-ascii?Q?9v6sVto5/qM6VVP+uLTr9MVir/EjSQ8aVWuMd6SPcYiSugCDm9p0FgxlmvEp?=
 =?us-ascii?Q?P6/m75u87ZyT4g9TcQpR+JbMxVKTsEHP2ix6M1gj6ZGBQ1beTTah6JXysURH?=
 =?us-ascii?Q?OFl3LkjBfU3aZ1qltohedDbQG4qKGpVWHRAtz3UN9aDgCzI1EBpDeD4+0o8i?=
 =?us-ascii?Q?YOu5S88GhhL89jqcAYeVkqPlktYLFIn5HN4KFcASGB1U65M9vkkzzKLGiHol?=
 =?us-ascii?Q?/cPTEqD70Tge6lZqATfMtrjvano1xoJJqIuE58MWg92MyMtiXpfkWkDHDG4P?=
 =?us-ascii?Q?069TocWcwwhxmp1jKDtPidLQfGvoHAfvHfwwbutISGJWF8EpfIBqUzdE/NO9?=
 =?us-ascii?Q?A3si8gS1l6WplJiFX0UPQIvwHBanm8YIQtsw1+MwZti3fSTzN5uD9ucSdqXw?=
 =?us-ascii?Q?3bGU2E7qEazRoiMMO0b+xo8P5sRNa/790PXoHJ1U4CbOAVeIgVctf1CNBqlu?=
 =?us-ascii?Q?RSml/E0jgcSnRL3WIap1a9Ik3mzf94VUoa6hvH5KxIG6jUU6cUqSHi/lEM3n?=
 =?us-ascii?Q?RSK7zr9aZUaY9N41WUvH1VNtFcBGoHDH7Hs8KGXyLv3EntgjYgaTXWMXJdH0?=
 =?us-ascii?Q?ohpQPtu58agxav6YZDCon5L0vRKkZduo6JYIYFrGb5qoV9rwQCjBr8dTyIgv?=
 =?us-ascii?Q?A1uxkFBUg7V6rsTpmzmvKCSRJrZ2/2J+z80qe//JuZLP5FbwwD9PltFktXln?=
 =?us-ascii?Q?FAkzybICI9MeS2w9iQaz814FP4s6yfIbKwGWwcDx70ezuO6b9rBhZ5gHuqRQ?=
 =?us-ascii?Q?4ojXzpybsBE+hfgJ0z7eacC17q5L2cBhrQoM0K8PLXE1/Bq4QJqOz9O8xgDC?=
 =?us-ascii?Q?YL1VLpish2q1jEkQLV60YjVIzmcKbf2WetAXJcOw5gIGoVBoJ+GWmH6jCLdV?=
 =?us-ascii?Q?qox9w25bOr4hcIAnlGe/5k7qxrOIW3jPL1+pTbvhvwZDxrqWn0CyF0IhOEx8?=
 =?us-ascii?Q?Kxo/hmROveF4ytgCiJvTYflojSK08DHGWHByIpkEd47AgMdf30PU5+JLzNaP?=
 =?us-ascii?Q?5zuUtuFL3ip+OhSVxRZcODKuMQX8Z2sHYQl+ePREfn/p4Mqnjbit1ngjmh6/?=
 =?us-ascii?Q?cpHaDYqall+QDSbWDVciSQ4hFXgnaCRFtYKjfUWhld6U+E57F8entkmfEE5Y?=
 =?us-ascii?Q?iC1I/XAMROlpnTD1G+5WhIDxZF3O9ceUv+rjz9AQQTGW0qipeIuVYHjlICtW?=
 =?us-ascii?Q?NePdTp6d1YhrQO0j/AOXHRUb+d/VqnOXV/5i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:04:58.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bfc7b7-9df1-435e-779c-08dd2bbc8db1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

Modify the chip select (CS) deactivation and inter-transfer delay
execution to be performed only during the DATA_TRANSFER phase when
the cs_change flag is not set. This ensures proper CS handling and
timing between transfers while eliminating redundant operations.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Change-Id: I58670873bee222311e3c2251fad98d7f28cdca14
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


