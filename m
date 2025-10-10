Return-Path: <linux-spi+bounces-10545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9738BCE5DF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8AC19A703A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B5302CD8;
	Fri, 10 Oct 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="jOdTcEd+"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021121.outbound.protection.outlook.com [52.101.70.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA044302CC8;
	Fri, 10 Oct 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124076; cv=fail; b=AUEXx+9vPv3/d+ib6/NOD4bIcz3Tv4q868DMVXqixh0qEbMBRHV4ncMT1VrE7sUU/qDU4zYUi5Csfi0FTncLjGtFt+41CAXWYgABBRGVs7GoZPvE6NG8cdcufXOfej4opj/mF0PGnC4L4OIQ3el40Zftdwu9WoLm34AquCYBO48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124076; c=relaxed/simple;
	bh=RiKbo/qwhlU6jP31RsuFL9gEwPwjUa/P/53eg/G8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZiuXA8E402IsLo+jUAVeQD+4XVPAjbOyNrJrl14jkWxJdpNuMCCCAhTNSN4vXZ+nm3hCUJPqrUoHJ282mG5bVRr3YIi6TJjfFyFAQBf0DzXkkwof2i/HfeFunauJ3FaJBhWc97tsH+AKdX/ktG44+dugmDJlIKRKKwUq7f0jsZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=jOdTcEd+; arc=fail smtp.client-ip=52.101.70.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLCyHhu8kRDWKvKbSdHq2j2uiMsmDQOiWs5A4MtArEi7deFuPRN51ZQkk1cfOzkoELXRBvq3XKG/Bb8SmZZgw9fV6/P5zbDguGSWgneoNGWvGhba3sK6bd8vK7ZsgtEFYCKa13Fi8//J4kl+ZiY0mLC+9KAtQ+FH4OzKqtl2wX4ZWykj8ETGInaxwDpImWucWdQ84yzXgqoTmyNVG3IRBiqG1LfM+ZggUinmGyLf1vyiUbmQaSsjSg4tBqKxbW2xHdD3pLJXQTypoEqssQmolwS0Yia8wg5o+3sH52+WyjGmwfUKwlsH7JAyNA4Ejg9l+Dc41baxwOABcYqE1+Sz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=s6fyW4CuyU/x2TWVyEsQf4U2kr9lot6rYzCT+7GOZNZYQNwCTBK9silXp+nW8JlpQrfLCTah11FDYc5qfdbsDEEN2VMX1HGpUsKIolFBlzpCFiXRpSdlFnIkzTeFAhGbwYp0gOes1TvqchDp5/7TcjZLkjtVBN537mn5pBEyF0w7K1dwWHvf8RdREY2VQkEP6fkHohQe0Z9WCoO6Oj014p+mf83cqXdwg0hsCXr/wLfYE8GdGRo+UYJd8jIsaG8FfankM4bPqOZFKw+ZzAODqnuP69gA3K3n4ZSRvLSLudlQyJh+OLqGR6RyHSlDjRu6ocRqNIENAGHZ8u4vLf7r1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=jOdTcEd+fKnCzZdvREs12MpI+X89g1Yapf5Qb6Efug1vkjOEsgBmFnTEOQQThr+8I5K4dNfQef9Rep7PQGZqOHH9O+gaf/BfEy0UQjm1QIB24dFthFwSdBe8iDHNPiJYJzO1eCMJn0yKtFz3TYeLEi/DDdg78Ylr1m0Iu7pJvwojDY9viBH0cFfriWmCRu6JlfJNuX156w+eMwinF//uYYRodWYQ2jhtZ+ZKpw9IDUM+0TmU9x+dnasEbLUoXs36BVuho0RFD8lJYyL2itClKXdvQ8D6sF/y7G7iBWQb6ox4Krw3g/zvsxvEANV+SayXzfEu9Yz2aMcgeLnTFZZekw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 11/15] spi: airoha: set custom sector size equal to flash page size
Date: Fri, 10 Oct 2025 22:20:34 +0300
Message-ID: <20251010192038.1592889-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b5aa0f-abe1-411c-8be3-08de08322681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jUCux1xZ3YqzS3IXXLb5d+nRxGmJmh+rOfkbTXyI2Em2Om2xqNmYWFh67eRb?=
 =?us-ascii?Q?/TQuiN/MJGXlg9InFbsKBH1OAbD3ZaCHoHyZU+XJlZx13dzxdhUBaAvqjFYn?=
 =?us-ascii?Q?CX4ClrLl4S8D5ai/qs8Io4OapRG5WcbKW8d6QwFCE5Qen1elFvS1rLgt1xQP?=
 =?us-ascii?Q?XxztNpvUulb2n3eo77msrITrgg76sveXIXu9B/kxYaaIPpIAsI/wPrd6KuPA?=
 =?us-ascii?Q?G73F5E7z2BkweCNFjeFg0bKKPisB5+VNo8S1SaZG13bWMki1iefWmoB5jH64?=
 =?us-ascii?Q?Uk/VB2jzi8/00eOU78H/mZpOQ683qOd+kg1PPxk3Zvj9n+LC+TfgPxZ1kXqC?=
 =?us-ascii?Q?ZyfSEu/dUdWPKrVe2f2Q7Z5TkGNMg45GzhVUWm08zS3302br4ZgaIWmG/45Y?=
 =?us-ascii?Q?X8NO1t4fGOe9a+oAeG2IP2Jn41PLNzQJbLfeA5iHAj8EzKExTKqha+VqabGz?=
 =?us-ascii?Q?r64iUtl+SIdh3+tN62EdjXTJBzqBb+vTrO4k4SkfB0aHxdtjOVYtseJgFlWu?=
 =?us-ascii?Q?Alz5w7Jk6YEzaEQtCBdz0iXtZiIKmmDyVt4mbET/hEuQuDw9kqfcBR9vxqND?=
 =?us-ascii?Q?LtoPhxKYNa7HmFW9ElIGgVrOa+g91MMkqQfTo6xrZzhubg40H+2sQA49iKKm?=
 =?us-ascii?Q?AHMWEs72knGjKp2b4y2pfFwK90hqUvvFe18MDDJnmVZaEv1Iq9KgkJepNq+B?=
 =?us-ascii?Q?TcW7/jBlWtnvKD0iycNbtayLmFYE8KFINC+dAXPPTV+ht2xuO1cN1+6FIqUE?=
 =?us-ascii?Q?hUpHJNbllEXIWA4u5lbb5z93hVcIXdMTNwRqNSS4r3KR6SVYycP2sBMnqKG9?=
 =?us-ascii?Q?XoHSOy5XeAoIVONUPaJYYPckl384Gwo0wqHtqZ88irwQdRDeo4M+KxVR1gbP?=
 =?us-ascii?Q?lQyCvs0rsnWtcEXnZzrWA4FXjgr+3sdPyBxvlwqw4hPfurqsrdRR88UjSwKv?=
 =?us-ascii?Q?LiEHeNhGKwInSd4+0lv1vPrQtKUFtAfQS7XF/XAd1HTeZAvaTj+J+R/yZTbR?=
 =?us-ascii?Q?rwYLNsvAWM4JiQ3il43pWu8X+u8+asdTsAUslS01bNK3dfJSA58nMWMe3pfd?=
 =?us-ascii?Q?JMD0Jz8zjvnx50uwFg+MHp4MbupSIM+KYmTcBZk1pGe7HfMIAKMtswRA4m3A?=
 =?us-ascii?Q?DbJwR0jh6UZ5310N5CKu7wMHye283k/WO1DRnqF1WSHjYdQ/KWo9KpPjUZur?=
 =?us-ascii?Q?Cx0wtKp4pKF8QPwEJZqaGOLnFqiinVu1BtlZh1v+8y4iN394WNbg9OPLEbrl?=
 =?us-ascii?Q?q0J/ooFOXIB9633hRGI4icJIBXyhzmn0sQ6Zabcon15xA5a4TdBp9pFNBrR3?=
 =?us-ascii?Q?G8SFIABZOSrv63ZdYPJo5yeIFUoKjT+qsopYIBTZL13qxtYOa0zF5Mjm7tdz?=
 =?us-ascii?Q?HW5bVg4cFU3ltowzUh4XInSd+Ulmv67WxCPBC1bBSQ2odOvfaCVhOWVPGWdQ?=
 =?us-ascii?Q?4uf26sxz9aObGSwGCrJ6TLUwALS/hUAKLMFZbkCCM3YmEUnkrUDNTT6lkkAM?=
 =?us-ascii?Q?3/lRU91v2DtGHKl5Ce8cYTjFOZMrPFSokOvgPIZTF+Tmzm6r0BDe2ydKug?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCSV+omeGETmQGrbPaT0ztz9OtmWqhbD2Tj7qUqG//25bXGWz8eHuIf/RpDs?=
 =?us-ascii?Q?sKAKA5epraVSaoQ9Oyej+QoJnzwbSfFHXa9a3AjQp/zdzxqbTEmyt+L5qHDk?=
 =?us-ascii?Q?kfMAmXvV2aXK8Rx4YhAKxL1RNy78hHNhe/miJIDu6Nc+2FVU8nHFHh7hbxGm?=
 =?us-ascii?Q?tivZZsbs9IrfedOCumAqFyhLOedz18Fl9+ZHTFGQkZz3yYNF5gLRnLjHyPdn?=
 =?us-ascii?Q?+RCNMYqbpX88d7RIcoPUk2ZnGjph909MpdQvBOXF/KSV1e5zHkPiK4S3OL1C?=
 =?us-ascii?Q?iE17uLBOMv4G5jBMYB1II6oZuY+KwTqjSrwTWAjFz66SeWokYqwMpTJfo6c1?=
 =?us-ascii?Q?rsNuTmHQS4L9bQ3g89wQ8XQPyU3XcfTEUOiCo0fogQiEZFKaBmWDq1Hb7sCd?=
 =?us-ascii?Q?5O034cl9YV7HWNijun4rG2iObtCJtpvD6yPBrbMWsP9l23r4gYP4UyrJdb5g?=
 =?us-ascii?Q?ywsrYNo1qZJe9y3f+sU0CA2cs+3ggdI+ZC9XC1kpqO22Yoe5ZUYzPL5nfLTk?=
 =?us-ascii?Q?I0ZdTVr57BS37llLkxnJkX4YVxP/VNle1bPiqynva4WQpo99enDm2oEOOZKT?=
 =?us-ascii?Q?1AhMDuBqCtcproKJIGNs88z3Uot4ioG/wTvxYUHbJwxRLRyl/oKPAGYkUOgs?=
 =?us-ascii?Q?YP440eZPgNkdk4YTyX9G0O7tyFXK+eu0lMLAAVyUbi4DPnSVFOIIGWlfYyXY?=
 =?us-ascii?Q?Ldj38BrAAeMqKkV0Tw+bgEuIdczXTrqKI/fYecqPgPuSeLwS0fjFnVdEAfFp?=
 =?us-ascii?Q?uWE2KcAOQ+qCK/jf8EvnKhLyZHB6YT6zqVClYJ9hdA30XiSmd87NjWiZPGRq?=
 =?us-ascii?Q?pUYnbp4kgUzkc3T+aRQYBraEjNbJ/PE7uz78IQ6c15bx07zToXQ5Z7Kh8/2N?=
 =?us-ascii?Q?uycd92i+5y3ollwhoDAWYB39L49Vyy9ot1xKY+8v05lADqxNuEdjvf/p2pI4?=
 =?us-ascii?Q?MRl3qRv4Yf6pMfqZWW2BhunKzAQ+8sfva/PWfcqbAABkv/kHjrnFlpQcuLqA?=
 =?us-ascii?Q?Nb8JvSKY0GubUu2yWnph1RNfuf4OFx+pKtvM2oTNrFjYG5V82U7o75daP2g1?=
 =?us-ascii?Q?1Y53XYqZ4ZEINpwt9FiT9RW7QD0266HDGY+EA1YvyhNHnCSB9G3B1E6VvK4m?=
 =?us-ascii?Q?ERhhGlh+mD+gAwPrbb/Wi+X/J6Ce517x7cVBuyRJ1wucB0G2cej5uNYcondT?=
 =?us-ascii?Q?pf2MgX7tc7q5PCMzsMlJhKNtTZf7zl5QO1ftwLt66ghYD4JKHdhscJ96ETb+?=
 =?us-ascii?Q?aPdpxiJsnQ43kAnlMAnJ+LFyhB61uwHWDSFeDp5P0DohbU40juob+zmP+h36?=
 =?us-ascii?Q?GCyl8ZewQi1dTj14gfz7IJ5Hy5/jyTfxlawkds17FdKKGVwSb2pyvMONJdnh?=
 =?us-ascii?Q?oGzOWavYjDXl7/0zlv9MK1XIn4M2OGwfDxL9kk5QKxrRpU0Dnb0vJ6ot27YO?=
 =?us-ascii?Q?M7YMNn4yhH1VkBhzKNIKVp5aZw1msxjYySESf+mcsCpSrpzACx+19pqkMmc6?=
 =?us-ascii?Q?4F3Q5ZHpN7pxpU9alEfmwJuGqqweIIcwMOJT4d0j66yBDo1kXc21XNA+wdws?=
 =?us-ascii?Q?c3/PwRFIr+Y3BGVUXD1WJT5SBdGWXEeE8GzFQ7wcUAOyiRpZE+O5jEmgckOb?=
 =?us-ascii?Q?9jL0nV7RVpCdiHIhl+iCdF4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b5aa0f-abe1-411c-8be3-08de08322681
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:02.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PFOK07bqeso5tfOM5CcbrVMaCcNsWYoGkhgpmMBUWFklq3A59/lDkpZp0tfvpaQG7M2awAwyoi1fZHAYHTvZ/YQ+Y3UkKkdxT7ksmCcOT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


