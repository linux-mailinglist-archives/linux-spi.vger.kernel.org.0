Return-Path: <linux-spi+bounces-9524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C8B2BD3B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41AF5A1D7B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D10320CA7;
	Tue, 19 Aug 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YOl/4wqq"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012025.outbound.protection.outlook.com [52.101.126.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA883203B0;
	Tue, 19 Aug 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595312; cv=fail; b=rqqbU73i10J/m3uEfEwXhjwi/5R+o+pbMJmpY27NY/e3X80Sgg3wvCtRykSC51jZlbAEucGXiXa6gID1x47PSLNqxs5pC8pTywxO3FK4lVz1TwkIQ9OvYAA9m8rDAY7XjLBLyjwj+HkKx+9HRXMqlgm+9khgsCIMibboBqoxpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595312; c=relaxed/simple;
	bh=4cqbk+ARN5yP+S8CC+cCZc/UWXSgCqt1LedbSKd9rHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeVPo8xV56+nc0h6fpDJ0hYqtiOaTI9F3t4JS/y7D4kfGmLQBUO5o9wc2FhMC3uKl9DkqQPTWzWtxRtA7/67Yc6zP+JVkuGggtkBa7MlTlX5QscjZbMmaz+Nd7SdJ1QDU5oXumIaO2SQxRCIgds03T9djBt4RFZTelhV0vhgC6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YOl/4wqq; arc=fail smtp.client-ip=52.101.126.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYkebP5u5Sc3hYeBnqWe3TICqCedwtonsESK6O/U3eHuKJKfkeJgwu7u76+GvbdTx1ltz+HnJqMJjYy9eMA7saeuG5Q+xa7eIdhoLIxJu0MnaCtsr4QRb/OVhPjU5M13ap6btTMkNAljm66PKLjZaqZzlJRkwu3q4mnVr8wv8g9cJdubXZLWNTfzg1PIiMCGghzxHt/d9s8id1GIXAGE4nAlaeCVjkFAgWZesjppk308OHC0ZqQwAhvyGCJR0t/3ea53K8ow3FPPqPxNf+3cBONoPSB3iwQM9WloFY/ONGUJfp2He2ZVMmXMX2gFudluyTJVWaj8uke24GU4d0y9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcImajXGnTBltKUvCIXAHJYnDnl62dQ3aDPeZT8Pz18=;
 b=rBknJZnE8VhRs8Ecb5/Hiafx0Ab8/K8/eBzCIarC+oHDW3GMbVM91L/cf85lzgQ1UjNOIUo2aIiY+fkC+q1lvVQcOZdHfI6Jgdgn/I0KJHrnf2DsCxQJwAty3PMs2Usx+YMAhtooVg0qyI0o6lYpGPPO6JzXwkGSxcVpBNkip1gJAc3yBhszY4R6lBBJUWBhxyhvpupRsIdyiisQQMV+Fvcw7sZixQyyZOAxPeLV+3i5OGTGHgiKrj9z89yl2CWv0/R0f/v2zYsKuRrBMi5WMH0b8PJGDbGPbge25KlEIFaqhCFdStOFXP7bLJkTuzZF7/NVIBTNiDEuFZHORxN3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcImajXGnTBltKUvCIXAHJYnDnl62dQ3aDPeZT8Pz18=;
 b=YOl/4wqqEry1ogQtTz7xOB0lkuln8jw4S81XApce0sJVFmHyoeByhPZe4RtjClDQKC4s1VGzCccnhuhMsjX5PMFUdrqz94op28dAWNKhLSNqKSO6yzJidK1pvzl7tAomOIqfMLZtjlIbtEMDeQW59Xg5q5k/LD4End2zWjUvm7F8MtCyGeMK0CQZCQO6Nq87mfIgAI+1UtOmmwHGabo9XLmpE0TgbKrALu5rLlYY1im0eVEtGPfoY7fi5D55XwiUHkJnrqCbheKkCRH3optUFhVCQ95T3A3ZdTvEB9KN24LYmYw/YZZrZQ1h0xYgRqDH28WyBHHXTjsiEoreWlA4dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5054.apcprd06.prod.outlook.com (2603:1096:400:1bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:21:47 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:21:45 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:AMD SPI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v1 1/6] spi: spi_amd: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:20:38 +0800
Message-Id: <20250819092044.549464-2-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ad5f88-d442-466e-b84d-08dddf01d11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9spCaQpssfMLm3yGWjoxC/JmYWW7BJ/XDV7P53fGf7CyKTt+0Gp5J9Ot2Wx?=
 =?us-ascii?Q?cVfAAlcM4wla1KPmRa5danjE7cQR80blhS4dg+mG+3+FXyD1UhZP5elTUfrf?=
 =?us-ascii?Q?kEHC36sDtnLxFG225bqEgBc4mXdwdyvB8LGxPBIkmTHlhg/JXA2w3Srhhy1u?=
 =?us-ascii?Q?BGX637GyznieUWLal2dU7T5skKtPr0wLMAKDwAOkRum/CQV48kVXSJowyJfo?=
 =?us-ascii?Q?L6tdRIepw4yEYVc+JAZs7R8Fb+OyWCkK9mHMCBoW09CT4IEuQo6xTFXgqGBi?=
 =?us-ascii?Q?VXPeeIeJf5BbrVC422KK8u6JjxfULNDtbI+VdMZ4LzqVYBwNHMFVFgcHuj6r?=
 =?us-ascii?Q?gO1BfNRL/R3Hzl7WjjoAKiltxWc/ZQifkQWkP2owg7M3u5QWb6xiFi1ExY96?=
 =?us-ascii?Q?cOoJsBRqU7gAmLe2PNfimMZB53EAWrRTei0rXoG+9AAWzo4BdycBHSfpDTnf?=
 =?us-ascii?Q?OpHNqkFsjkwg8DcqUcGw9TQj8Z7SWUXXOXHZUxPbgkUjakkH7WsNvF7GdY93?=
 =?us-ascii?Q?Z82sfoCU8I56mfdY0hagbre3Xblw0bbTBG9ildBhSxgLNlbYi4FPb1jKubsn?=
 =?us-ascii?Q?Ivx/Axzf308wcnan1E6vR11/jpD+J05j1/NbDxdBB8CTBPhrzMOZM4rqS7zp?=
 =?us-ascii?Q?NDnUuopRek5hMICpdn3EelCUQsBSY11dZo6n4rnno82yDOsi2W9C4ZM+XWhU?=
 =?us-ascii?Q?jfd/uH3NxuPBK4SvLbZ7bKFf4TMQWsuUlqWvBDAs9RpJix+z084eLtn5RQUn?=
 =?us-ascii?Q?eL0iSPL/vIvsvtwkjteNl0RSRgzVeqTCZG2akKFEQ+VJ4ARh3KQi70+TJipX?=
 =?us-ascii?Q?N6XgDQDGAdwdmCUTfagk8Xn44KXQv442TtbXrxjre3Q6fUWcH0NDOkRQaQsf?=
 =?us-ascii?Q?9bccJFdA2ZNRz/srqwzLCMe16EqYAv79ZdQIY8yo0NKPEIFHOOQJvaSKqcdm?=
 =?us-ascii?Q?jH02uP1b4Wz6UMN2kcU39kJKdBPwo1g5efezSiCAtOzSF/zgZEzQXKloWT8Y?=
 =?us-ascii?Q?yKqvJPY3CvzPvkS/1hQykl39cFEAQxgrow6r8RAZQAUf3INCSmKA50RbaMIx?=
 =?us-ascii?Q?NscV9mKznnDtRcWj13EKR0weus/DB37GWNuah5AMAEvAIIHUHyzOm3Q9nyZV?=
 =?us-ascii?Q?U6VL0mJmEQBAyF1sgYhyQFakTUdzS06+cMYBQjuoK2jTn8RDmuuVPAFq1Q/0?=
 =?us-ascii?Q?Ngz2XmMFbdN9w3mcky5ZsxAlYXWmrz/hWlgKrNTiaCGQ4EGACmiNC0VRWcLf?=
 =?us-ascii?Q?fQ3FHIhgHVnweg6BE5VUnCNo1lVgiVaZTb+PMUU8W7gWzz1o0X+WsDo8mlvJ?=
 =?us-ascii?Q?38lX1yBwFGgM68vq6epATaPf13pg63u4dgVYGvNxjlfMB1eaKw1ntR3OWmE7?=
 =?us-ascii?Q?h/zxtEy+92QdMng2uaWOAOaXEuArMXtUqezPmhq0jyFnKuT1441DyOll3Mnc?=
 =?us-ascii?Q?xVeT4kuQm1cvAjWuG58OXW34jq2HUMAQhJqJzcgeP1fGz/50t6b9sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jyq38N9O6uT2crq7DfNaO6cHXvMm5vY6uJt94zuSFM3DWQKg5j7WSgDVN4dO?=
 =?us-ascii?Q?tHqQkz7YrUl3lqGbG3yMkPo001QSW5W7LvOc8ZNvUTJTGFznS1+RKPQyUjvG?=
 =?us-ascii?Q?At1YnmDyLEXEEk0fRJYOpQUkhtwKbQUVLPJFgdS3GuG7s58i8q8eGSV5W+yj?=
 =?us-ascii?Q?cUtm4/CbvPj5BmS4cxKkzFpQDOJ577J5UPu16Jme8Hv9h1GPKmPSy50XEF0m?=
 =?us-ascii?Q?9s0/eNiYYW9QfUlG9j3DWIjQqpffuIH4kFYC1O49VEfQToeG2VE81RAa1zLs?=
 =?us-ascii?Q?aD0nE/kLBLPYhxmk7y2rcO09FS0g+ldnr/bkDMz7r9COv50oInjVd2knl8lF?=
 =?us-ascii?Q?xZw3HFxm7lbSZ4JSrdY33B4BUSc/bTDT+qtZ/QwD0GYi+3Mcz4AOQeRmt9qA?=
 =?us-ascii?Q?17XdNqlsiVf/PES46m5kgLnQ40vFnYl3vEEzJebiaZi95TsFdV6kvhN7QSSz?=
 =?us-ascii?Q?bkbykQmPDeE7Y+iuP1jEo60atSBXClfDjVsGBiGBT8bnqmoDmS+mecuJRwN6?=
 =?us-ascii?Q?vkcPg+39nop3/iqdqyT1PqmfbXGULka5jZYN34LMIAuisHRff+c1P7zLNdYx?=
 =?us-ascii?Q?I46AE1fWX2j9zw+A1ywfKsvF1JvW3AmL0qQkSQ3klF4sv95TAEW4RnDQAxyN?=
 =?us-ascii?Q?nQR+GYOFnmtEVumJtCCaxM9cGsSuLUZLhhIfe1dcYCFtNXywgtVt0LXDmXjc?=
 =?us-ascii?Q?rFuhGlNvaV/tWNYJ/GOLY5DSck+G/tiBc88P/GSKusaRe4g9ZXaEegKZ2WJt?=
 =?us-ascii?Q?sy4jVV+qN1g0t8YQgPg0ERIqN9I2Y3Op3wB8QH8i1PrVpdr/4k4upqjM1bcr?=
 =?us-ascii?Q?6fXqVKD74+5HWQmbs3R0vqnRmPQ1DVAJezwztkTBhMCRFeTgqdQ3z11sfmow?=
 =?us-ascii?Q?VFKCOeJ75t/XEWorDswTpDZ0hTTJEAWBbQ27dZbIbymdeSoKaxY051/xiewn?=
 =?us-ascii?Q?OtQPpAB3eiMHS2XNCz0W8a88a8/LfUTN4tvWW7oe9BhnnK6DzwSYnzNlsua6?=
 =?us-ascii?Q?Ox74/kF+tTxalZDiynJNwAyfhddVaDGzw20ESEmG31nAOmCvgsd7aKztA3Wp?=
 =?us-ascii?Q?F8lwp0gBJd2ERN12R9Qp/lZhFa9PacoIc58/FM76gwxPCTzPGeqJqmL9S1yz?=
 =?us-ascii?Q?OI5mLWIHU+YcfZLwagwZcAJiNTstJxQuS3YL45XpuZvngwMusfhHDR1ilWfF?=
 =?us-ascii?Q?kecs3eXdLl5LF9ivR1oJgR6J+Rh8KDc6p/LagO0U5WlqU44BzQSkIiBimFxg?=
 =?us-ascii?Q?uKk87DYOqBiKmnKOOSPrLbaGnGGTZ/iCEUsRfl1TliinxKzzL5fYzGfEAw4K?=
 =?us-ascii?Q?b1h0nqbf8qte6fzfjQ1IEGbGSO1vNQWLuKJsN+5xG2+8hgJ8UKt9414XjzsP?=
 =?us-ascii?Q?ChckVdoB7I7ykEFCfLz9rmwPUNwfmXrz8F2VMjVBUleOSaesVxY9tmGqbfWC?=
 =?us-ascii?Q?/laF2VmA40Jg5llGxT6gIpq7V49rCWk5Ztk7rADUuB7m9xeQQF5m5nOZB7i4?=
 =?us-ascii?Q?MSizWnos0YHna2Lu7025nz3RxMnygmn8NItAY2GITlo0mgn8p6LQK7aV4ozX?=
 =?us-ascii?Q?hbeEOFuum7LHAdcBQYqKHq+Xd0eaEfqnc4bAlY7E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad5f88-d442-466e-b84d-08dddf01d11f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:21:45.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/n2lDTC3thIhlOYYKjS+Id6Ks8UzRD43g3jQjyMUEl+v9GmRwrsN+dKOVBVCkWPNDZBlCfv4/c9ZPx9Psr1ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5054

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/spi/spi-amd-pci.c | 5 ++---
 drivers/spi/spi-amd.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd-pci.c b/drivers/spi/spi-amd-pci.c
index e5faab414c17..d48c3a5da303 100644
--- a/drivers/spi/spi-amd-pci.c
+++ b/drivers/spi/spi-amd-pci.c
@@ -38,7 +38,7 @@ static int amd_spi_pci_probe(struct pci_dev *pdev,
 	/* Allocate storage for host and driver private data */
 	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
 	if (!host)
-		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
+		return -ENOMEM;
 
 	amd_spi = spi_controller_get_devdata(host);
 
@@ -47,8 +47,7 @@ static int amd_spi_pci_probe(struct pci_dev *pdev,
 	amd_spi->io_remap_addr = devm_ioremap(dev, io_base_addr, AMD_HID2_MEM_SIZE);
 
 	if (!amd_spi->io_remap_addr)
-		return dev_err_probe(dev, -ENOMEM,
-				"ioremap of SPI registers failed\n");
+		return -ENOMEM;
 
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 02e7fe095a0b..4d1dce4f4974 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -857,7 +857,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	/* Allocate storage for host and driver private data */
 	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
 	if (!host)
-		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
+		return -ENOMEM;
 
 	amd_spi = spi_controller_get_devdata(host);
 	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.34.1


