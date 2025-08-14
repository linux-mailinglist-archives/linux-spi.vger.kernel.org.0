Return-Path: <linux-spi+bounces-9459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21065B272DF
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4AF1CC3DC2
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5E28D8CD;
	Thu, 14 Aug 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Pfjaphoq"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52DB2877C4;
	Thu, 14 Aug 2025 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213157; cv=fail; b=cBSNQI7Tqphg4UtyasLgBS4rn10TuzZgFEbYR31MCEQHWVWm5QenB14WuYqcsilbjN82nrVQddgFWOl4yUYd11Ma5BAWmzMYLqI+7JppTQDks4RcaKztjYYBQgdX8coiYbasDAwgxx3KP+NjfSf2ASIbDduh1B027CQnW6gE40U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213157; c=relaxed/simple;
	bh=1RzHGhjUM4gLLLVzIv2h4pAX/nOVhMiFtA6TlnJbn60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsJzM6brd4w9CvG8Zskrn6p+UkuP57JreHilCq06DEHzvvF1KdkloEcuQyThdrDxhShgDWsUbjaKkpJzimZB1THbz90RS8Kq6VJ7BL53eKHaH1SLX6zP0uuo5SUpcXdzHzSMw7p4o1pl3yhegzVpMCvrBiEYIaqCHbXJsFyO7To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Pfjaphoq; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEhKZCpGe+66RnoGX6dfbwWIq9OwLjAjmcl7y0nyAO3N6UMrer1BDfBrPerZSwl3n9ADkxibpqwQrZyObKzxkO5cmatRDMmoaA10kGqKJOIIuEFY/1opaOX/MbUa6pK1QJ4PYrD7wm6h4phnbYAQ09AR8/W9anlZ2K8KIWp2jYJOtLaNFIFEERD4P7GZXC0X6ClOFuQBFwJnaR511F8H+QItCLQvD7yKll+n5AC37Fp98wqYqujdNo9K84SL8yCVf7rjIl8FBgocXUHXgj/OIkFgVbCySxnIQvsQyS3wxVFPt5+CT4A+nvxZjX8EFWiFV8NQwuxS8fE1IuX9zDQ5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epzhUJRBhFC8fajH3auPheXHY5zsCFiYs7ebXj3GRVA=;
 b=OrhbL8Ha96B8FlT31lA3iJ/Xxfj3fu3Kfo9HwL5Fcu7hPxfx8Nmp9NBQSut0z1vYLFDWRLhCiglZOS9GTU/Zf51aGkhfoCk0LBooeYfOj/qzYjcLbcItWreWibOHQzN0b0tRlYCj78ByhYoarTLibPzsTG38wEGK8CW2b/teym3R67ansUVDTlFjuhchG+bTn9lWWxv0NVYiaNz8jPpz11OJkmO+XGqi5ZktyjDFMUHsL7pxlJ9/gA1IikxnG7pvUFqol2lhj9Hu2ngcVWrICR+1TCI+R7SRVT2XsOaCeVEj86BW2nSCbpUE7jFXC6btZdBPZuTkLOy9Gtnnt7DeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epzhUJRBhFC8fajH3auPheXHY5zsCFiYs7ebXj3GRVA=;
 b=Pfjaphoq1OSKTQlZ7jWaX8qk6lG4RPdY7YA3WrUWoIrpUaRRTF1lFFUmD1Uar1i7UZv9bHeDAPkoPkdY9SW581i4hP1lSszsNp/1IkHV4eCV65lURSc60Pfns5TFys8G8jICY7jvJq67btoKivOjFPMRpFSFCXJVw2GOXWyLicSz6k18ffsaafHTOzYCpT3B0KKIk+/s8RYeYjogaIo5pn4yPlsVWE5ArIrdnMMKAp7pB+8aIbbRLL92JOcLU9aqYyC2rY3URAXhQK9gs5XvWKYX2n4OORYsQm6wQv5lzstGvy/l4F3wB+qZmaRBN2xhaktEIhRXFvvvDXt1ARSfCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 09/13] spi: airoha: buffer must be 0xff-ed before writing
Date: Fri, 15 Aug 2025 02:12:06 +0300
Message-ID: <20250814231210.4174427-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c5dd1f-84f3-4afb-eb58-08dddb880847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOCXqEQ3pYPloFU+Jv22F7ydLLHOdZYEOhywWHFPWTpq8NXvdQv3dpGYBwVd?=
 =?us-ascii?Q?Sc8dKsOA4aKvLlQ/qMKZPG428xssurZ2BWWLmJq/fySu+988On5zSJbQf44p?=
 =?us-ascii?Q?oY3oj5PUy3GJL7pdBJfr2hpCQ1IgZqoep/4KrDjElcbY4x62lkKAqZREbBa8?=
 =?us-ascii?Q?3yfZbILBX+Fy+7/s7FVlfrWSiD74vPq61B1N+OBZ3xeltWb/+4MJdepQkXJK?=
 =?us-ascii?Q?4BAUVfdCjeEH8ze9VB6QtHaBlsUX1q1mvTfcDdUN07RmTbdo0iJsD/gcfKnn?=
 =?us-ascii?Q?mXbTC9nfybBJn17FZUdBNt+HndrG/6mJ8wYPlL2HK492IYBPX5TBtoC0FyNw?=
 =?us-ascii?Q?7TXLETB6KUUCrqEhAM+0TddYkR8XaieM9GC3qMevTcPLMr5UfzfaOGQMcaF1?=
 =?us-ascii?Q?nHwqLwfuvxq0LPo6cVZgiVALwHbxZaKLPe82FL3meagGsOO0jcU9I4tjwCVV?=
 =?us-ascii?Q?C7bQzzU0w/AEcPizDz0AICpJcSxkVStZY9P6wumnsaY8NSp9dtW5CypDubGg?=
 =?us-ascii?Q?sLQeknzRKi5LLkpyU/k32fKbO9KbhqeYoPluh3AUq5KSHPUhn93mYKMSt1kx?=
 =?us-ascii?Q?TjpLv++AG0pa8a8CAcIa50Uo0D2WEMw06prQDx3ho/1iYb18L/9SA8o5OtnL?=
 =?us-ascii?Q?rUIx1V+Pc+rDUkAgwAGmnnlOooqOYnWfJe4VIuq2/mlvPfMpZhghhi6nihs4?=
 =?us-ascii?Q?2AZWQZZIfY/zZcfQgVLP0Jxyemzaws7GTLAgC19M2NM0xyPsxqMu9944rIk8?=
 =?us-ascii?Q?yOepQN/SfsFaaIpAZgUcIuRdwj8ivJZbBI528BqZ0795vdRweLv50hmNwW2h?=
 =?us-ascii?Q?Pi3eH/iagiFyWDkAxx3sYS5BYkz3FlP7RS/fRwVyStxmxsFMuKIYZN5cR67+?=
 =?us-ascii?Q?ObOx8jx4FGNhBF+pdaMbN6wsdLxG5qnQtBOFXGrane7YDZC2PMTiS4BBIb7n?=
 =?us-ascii?Q?nPdnHGaX0rUcJfy+QPh82uOcd4nNbWEfWT2zfkaeg7tCkgQakjglbyGsi9o8?=
 =?us-ascii?Q?KMnbROQD7KnwuNJWYpzD6+9SMcErQs0t7FvTi9bdm3LXAqDzLrsvkM/78qF6?=
 =?us-ascii?Q?YRJIrsopg6Gvkgwk8C4pD3M4ZdlR4zXjL2OUu/iTamnFa+C3omc/uQ+ildjW?=
 =?us-ascii?Q?We/B0CLxEwWdQcWYEGzD1PWfp2of8vlnlGxrA6ps+kC3RxEz1KrDyQBWPsju?=
 =?us-ascii?Q?vE6vn+iAngBXHZtTC+NiVMxd116wKOkilyBuNBYNbPZptKk5z9jM/FQtNK03?=
 =?us-ascii?Q?uATb5ERPXDZqfi5s1iyoV1/06aeR8kJxh2ti3dKeZnQyHOHJvHK/EI+ZimrN?=
 =?us-ascii?Q?mEuafcG44YISMC4ccBjpYij48KGF1XzDwu/acoLu3PT4Bk/qxeTc7D1Frq/N?=
 =?us-ascii?Q?lYl19sgYJcay014Yl17jdR6psOwf15RgM9DGxCOTe5E/Q6rckCgWbfrwQpM1?=
 =?us-ascii?Q?30X/uWtD9MLx9PHid/+QmgdmMQ2bPltxaRbtfjpPz/es67iV8FHRcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWfTpmwYV9ALTG9UQZYsgBd9vcFAh684pxFZNfjefrpNp7SIgzDK+bW58OsD?=
 =?us-ascii?Q?0mDFn8eRZp4J8DG3FjRUXG8O/7siGia5NQEHbLHVg3FnHkAWN/Dl4XDLOh22?=
 =?us-ascii?Q?SSWzHaMomOKl+ZE8EE5B/Gd8TyS2ieD01oh5gmKRwSrGGtL1Ejxe2kD1YJku?=
 =?us-ascii?Q?eaY9F8mqqMqGRcmjLc0Aal29uB1avSs2lmzAeSuAZL5mkelodDpq6XCVAkOW?=
 =?us-ascii?Q?z2Yx9/A4njMYdEwibM7ca/WcCmujVbG7h6HYz3WD7YuBKDklYcwtxVNs66Yk?=
 =?us-ascii?Q?kHL2esAbCSgnyD/zLI/YKx+pRKS3j7xoGaEJY98Hd/mw/wTsRCmLBMTtmW2i?=
 =?us-ascii?Q?xqlB129onzB1lBKjjgOy1NVuDD7sGnErKc8TvVmM7Sp5Yh8IACl+IrGTdnEf?=
 =?us-ascii?Q?2dChhCNPZZ3b/uR92U6tLvgNa+tLESZQUbqNM9Cy3SbRr5nho3qBiBiiqi9K?=
 =?us-ascii?Q?PmNn8PVwqYqqiMfkg+uot6qBrdZOFzUobaKIsw+3aG370Im+P0YPGIWYILPk?=
 =?us-ascii?Q?CYJr7weULhn7CQwMDadAYwIeZnG20DIJTfc9Mef7iKxGaTdsi7k3xHltM+NF?=
 =?us-ascii?Q?Hsw9OwDDOlsFFMbPR8sxqfFm/KaZZ6jNIlQsdK8bMJI79fxHGh5dEocrHVrC?=
 =?us-ascii?Q?TCF2YhVmtLUakkHE9wBAI18cx2X7ht3pjHmyOWg/56ewrAv+Bw+gSl20BoMd?=
 =?us-ascii?Q?s0+uLwVM4UGnvKvzBM/LfQOaFS09MgeLDtWeTRD0KyCez0aqdKxN2sx00ptw?=
 =?us-ascii?Q?FHInVKjNKookalZvQFaq689gzEMrT7UidFssgktYK83tPXGwlyipTZ0fw+qW?=
 =?us-ascii?Q?VVUpb4QVeSqh9ABJrQKScAnCONJQwKc8kJYfxgFcELOjfXL6wSccY4McpeDy?=
 =?us-ascii?Q?dqHOnrcQHzlrCiaGCnDowiCcb0mMmbGoFJnTG6Qsm2GdMvDwD01QU9f/XE4v?=
 =?us-ascii?Q?WFf1hAGRAEgz1yEYD+d2vhfNGnkQ7h56J/4lYkTLGi1Xl0zR66woIghuFSy8?=
 =?us-ascii?Q?fLpKvg8Y5QVmhE9o5OGx9SHRCSFtXTinx0+rTrw29fT54cEcrtlPr96ifQkz?=
 =?us-ascii?Q?Knl7wUM/GjygAgIdWqmV+moOpSz/s9lMQxQ4X1qWUSEclm6ZKmkRu+Ifyskz?=
 =?us-ascii?Q?z7vYT7PzLcNOckxlaC6MxBWwJS7F2oCovphXYhnHSp67iggzhBzFxySQZgew?=
 =?us-ascii?Q?qKZ4egUDOtGGzkF6etFowloBRxYG8nzg7tk6OwML8n/grhhefj5HV5WCLnoo?=
 =?us-ascii?Q?T4r9PCNHlAb/75pOcmPdlvcdKAwGNRPv/0SAM0u763BxmHGj7DVr6uZOQ+kW?=
 =?us-ascii?Q?ju8YAg7HcoPI5ApA3o9Ms3ZKci8X6dSWAkPuZhVxfF7UcMr0K6ugfTv65nfT?=
 =?us-ascii?Q?28CRXZdaSZEmul77Snrtb3YpFLrEJRrNdEYrS9xYTtFfNEIwnAP2eo+T9QwO?=
 =?us-ascii?Q?uC0iYcOW85v6cU6NVZKsV0NL26UReyM3rfU2OdP5vQpUFOKXK720ZSBZIlSL?=
 =?us-ascii?Q?l1hgPIJ19JnDJJQlVB8qbfsW7o0SxJ7asU3eGmuoMosjY849y7OJ6Bc0iGLf?=
 =?us-ascii?Q?1EhMcNoCjdmDGjkArTDR8m3dId5K57OvB++ztHLRrfLXnT4jNNr3QV9bzWk+?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5dd1f-84f3-4afb-eb58-08dddb880847
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:25.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgaRdxiwMCvfZ2MLiU9hbemzR5OKmSXzzkJ7Jfbkmawr57vx3HTTkCI1vEd2zrNtRMt/YFnHfUoopbf/zJbki58nIMXV6thklEwymYHEfzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bf29de9dad7a..7cef38c6f823 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -842,6 +842,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	memset(txrx_buf, 0xff,
+	       (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	       as_ctrl->nfi_cfg.sec_num);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
-- 
2.50.1


