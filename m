Return-Path: <linux-spi+bounces-9452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CCB272D5
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ABF567E9B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7D2882B6;
	Thu, 14 Aug 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="0mtPWAKz"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51912877D6;
	Thu, 14 Aug 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213149; cv=fail; b=KsSAurHoFGhqoLM2EE8C86KA7MacGsdqVJJxRk8Zt7KY26/iRkHXnqAJjrR2wu4T/K62prQ9X8tkEyUZYdop1jt1FpLT9uWoq/QiW5Rkb896y/xTxLjI/vmI3UexWOYE0ObyBC8dui5If80uQ6GwTQMPie3/RZEBrrq+Q/2g1Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213149; c=relaxed/simple;
	bh=bmpbYjDxiYfb4EA7+R/Ez+ldMKo9hr1PLeadZBZPugs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAvRmn3nDnydocjZiwL3nZ6I9m4SR2Ix9K7hA0jF+eIKBzRIYqu1cLVeRmfDmjLBFe/XhGWzKuBk5ILNUvv3gY2QvZAifW6+SqIJuga86Ti7hMhxV2zKBvg+X6zRfP58+epKiislFujOeAsDQTSX9XmxnnoaQiuF54+7DKKSH7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=0mtPWAKz; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfssESWUYs8L+SxqsoVMAZNV2aGmy+/x5/RIHEn19xk2ollzDzBlRuJVvtFo6SFWlYKc2LSy0DzboHVk7+jHiklxQppdpmbYmpcIdetICnJ5uY7QWenlAtSC0WbEoTCWIPQ/RxVRPhm427ytxPlGFMpBQitkEiNe2N0vOjuBoi1/+dBIx/rB0PJMrvbP8tcy3gHKCNoPeg5sqPDjDHxOQ0rv/5tWrAZAqvbzbJj+ddUKvtHLZaM3ZhOTZr7eVXlMwsLsJi6qFmfxPu8QWdLcFffHtL9iZ7pXltRIgrFIOlevwvhjtB18OjjYGp44YA4/9dqj08mGsalRv+ydkkeJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE4cyGhR8hgr7gJEQqVEIqHGU4Hv6HZIfeYIyR6SwNM=;
 b=hHRT7XXwhfUMktsmrk/NdNSR0bPXJLeD/r/q5teq7C5l7PExDMmDrCKP/EU1O8aCOqzwburXkUhMc0KS8kgjC+dLIizFRmfUUhW0TH2uv06uZ+wfB3izwaeJHNj8uQO4gBu4GbUsHdbDJeYloucjD9jFi2pNWpbvXMRVyQm10whq9FH0TGCoKbUVTbE5xKZZUuFQWRElmGiSo4Z6EZfp8d3dFqO5k/Gy625xV24i7sUsY1T1QuRak0EEDxPD6UIuXoeq9aPxvhEUMklvne7DYNlq3vQ8fmsMuIMqruTgHI2lTJdSrMNevpFWMth0dowbCwKC8MkdUCowqMun2jvg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE4cyGhR8hgr7gJEQqVEIqHGU4Hv6HZIfeYIyR6SwNM=;
 b=0mtPWAKzH4dNpliUf+8HQ2Xud2NHs5ZLXy+16ML7Y6AUN8syCyQNxil+MBnZNnCFElDr5NVjYAuCRi5XFDlN/fnu4XWWHtMI7WVgc9igJ0Kwyp3nLQ0B2b69alMA//B2WYCgt8lJGrWzK/Qre72NymZur3/DQEaIYBa21/BdBHjdK+KaUaLRqQB2TWfIh6CHnMr4HKykMYyI9baQvahBu9BwWQVBXwnPkij7DleBEhlF3n30tuj8PoWm3ZqNlaYgMoKR1vL1jYaMv/jHeg+AcKN/r3Jnt7OrtzQhZdjVeXCTC6nTfr4SwRJ6WPsAm7brHkaftljarYZ4UoUlHZy2tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 03/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Fri, 15 Aug 2025 02:12:00 +0300
Message-ID: <20250814231210.4174427-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a38a1974-329b-4801-e329-08dddb88057e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1uHXk230U11Ck5A0yuf+hKIfW15QQxXnaiJvVjpQyjijtnIQdnXBc0PSLwFT?=
 =?us-ascii?Q?Yrto5hPOHZbbVdAK/z602YCVLN5+SSsTTDI8iuHwgcKwq3VPrLmgvyPXgdWI?=
 =?us-ascii?Q?rtaXuFRV49qxe3T9gWmLaIdJ2huFRrMWON1aqGOgex8EAlQIl1/l/cm0hvFG?=
 =?us-ascii?Q?syXa3Cxg88kM1mqaTccwqMmPEYZhNSEiLXBnJ/8DAyegSrxZ7i6qbtBSbuTR?=
 =?us-ascii?Q?K8DjZI0p/CO0LfYB0lDc824/pZQhiQWGjEiLL7qU3VYLe/jS7Rm1DNDkEZrU?=
 =?us-ascii?Q?6LYbj1Xs0SoVPyQNIcchdZBVrEKiAAWLt+fKMtvC899NUSDaavIDqUrBiPyZ?=
 =?us-ascii?Q?i8acM7vSo1ON8chw0+PdEM5OA7I7jWfV2ZVDM2tOiumK8PIr3dYfTVew2fkF?=
 =?us-ascii?Q?XY3Amxsaxs/7c1Nk5vVioYCj5yV9RPX90DMLzi7ynnF1jesjcDsMRdCdx+rl?=
 =?us-ascii?Q?rx5Kr14FpvOcBNMyhpm5s1/qfSdR+QXW4lO9YnDich9hchT/eFdd+nHq3Sql?=
 =?us-ascii?Q?+CiQNocD+dmHEHCMemVBNHZ2Xsa87LOdobOjQZ1tQUjy7EF6TGyHI9hL54zi?=
 =?us-ascii?Q?NMssvYlEsmDxIKYKzpTLs1mU39SPKc3o1ByTgZmCAsGtpwPa60v9quIQJcOD?=
 =?us-ascii?Q?TVLJ/6CtRqGo3N/LpugYuZ0ozMK0oN/N7cJgrxeYnTdMS8+zYKIN3l4jjPuU?=
 =?us-ascii?Q?DAjqcGaX92TRZ/afPjyzbPxNdrMcZ/GsJCyfMkLoX8/FgM6OU+nFHDsw6pSR?=
 =?us-ascii?Q?SP/d9fB1Ey1llizlkEBha5Sm4++wH23At4+ThrkdQH4WcyfR6AKfbn6TfSKh?=
 =?us-ascii?Q?dma2Qa8LA+9Cqu3t+TNidfumVOnl1mVG+t4PfOs42TIHoG0oJqlHq3d3aGS2?=
 =?us-ascii?Q?oXJs3e9ihb0rLpdxVfLjuTosuxUoo1aP0iEBP9NousWbCp+4oNDne/MwdpPv?=
 =?us-ascii?Q?gXExhgF1cB+B3Io/USkoKEHyAyGy+RhtpmIWaTVv3WIJGgDSCGKz7CZ4klSw?=
 =?us-ascii?Q?Rf1FYabZHlNofmnxOcYVOG5NwlGeR0UmUX/AjwXIYjZxfWwHa7VLAG7/RchN?=
 =?us-ascii?Q?P9SrPLE0g/fvg5MxL/9uglJS5fJbxrKH5avz7DO0ZNymI/TBMh9doEU/wN0O?=
 =?us-ascii?Q?r1RbD4wntWjD7UclCExW8Looz0Wf3l+Su6eau/OXuTkYqtpqxoVjX5UBkce/?=
 =?us-ascii?Q?Aq5axDAsD5pBJRd3R3o9oCI/nK3XGpOl1MOQkLVkj1V3sdkqlZE3hoYeIVvL?=
 =?us-ascii?Q?GWvD4Q+sBJD0umNnbGv2eLq751yFwXb/7DoF7GXfqY86ieLjShRaM+GgK/Nq?=
 =?us-ascii?Q?/pTOHlbIhrjI+dOrvpc9b47VJZpzlUL+fPa+d/MUoQH7mdfMk95hWvGNV+xO?=
 =?us-ascii?Q?iQfblOlOiwQD1Pa8ckGZ+9EwViK9waq6odBDNkJaG4ePBy76x8GQX5lW3M3g?=
 =?us-ascii?Q?C/J2sQaNA7Q+Qo9qycEyhYjo0Cakc3B5iVldJKh6CZ3jpeylxnWu8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cl4u7mcy/dNGHbGiUcgBAHvytGyXmR7A8Ge8wtIpDP+sgRTXHpHoRUelE7Lc?=
 =?us-ascii?Q?sIKN8QgGHJsg2x0TwC/IvnAhZnUbrjfI42lL5YQ2ZgrATYGm2uTqBHxa1Jjg?=
 =?us-ascii?Q?0PHzUESFAhuZIdItN1YGNX/4WXGGcGeT5vk/Oz0SyosxHpLo8ZzGy/S4Oqy4?=
 =?us-ascii?Q?8oPz5+Oxw1HbKYJeVhGkfKzzyu+DvPCnU2FGJOg+vUt8U3lkSN1WCQshok6E?=
 =?us-ascii?Q?82/9CrHa3b/b21FFIzfAUKmK3tNy03f8RWrAzTAGqpew5YbucDF9hIY5KLGk?=
 =?us-ascii?Q?CR536793N1G3XsFruX4e5Y81QIF5WCPlU13e+YKhfL6Fk3jTt1bFukSr+vMV?=
 =?us-ascii?Q?Jidq9jfd2qO2gUCoMLpqGaGP7kvymlowH7KD3nr7LaXyE+lbPymPH7RQKWFY?=
 =?us-ascii?Q?civh+A99Z0p9XN6Ogh8lv/vUucWTvkMcdKH/crb5Y0WejZgfWanzrtOeicfN?=
 =?us-ascii?Q?eQYQR0xYSNJ+RB+tfoOFPwMFX4nzaZdZlM8ohlxge/6JybZWdxzt7MxsY6Gi?=
 =?us-ascii?Q?K8+xRmYOxETAqxDQxIBkR7sgFvGuOf7l1W/Qp12oVDOqNmVWjrf7q31zuM8m?=
 =?us-ascii?Q?t1FWejLOy874Sy0vgmj040EAT9r9M1udA5qnrMUGgAdDr9ulVDaXJV8o9V5s?=
 =?us-ascii?Q?0o+xLTPh1b9dB+kXG/9Jpri3liWJ7Cpah/D5hldVDrpKY0khnZrcRNP1eLue?=
 =?us-ascii?Q?K8bsP8QWNwwCmjaZ3kPSLEKV0/OD1ovOa4bfSRjjLjHhuvft+Vh9vYxVYYhe?=
 =?us-ascii?Q?uafmFLxtlVsqiHkIYfDZ+LT9hDKYXtuRinfSrR75PfRFFZM7idFPYglMsr7W?=
 =?us-ascii?Q?Bk4GDY4VasrE/aUjSEYqNFcQRvS9CYMCjyOrf8tbMEFdaPBJj/IBUnYVP5qR?=
 =?us-ascii?Q?OThm2wqh6HeXtF3czT/H0SQgHW5jJlfIz5HLgEoe/hlXmjeBw1eOS3AGkfn7?=
 =?us-ascii?Q?KzgK26+z2izor7Bb82m9Ay3dRMxZwcePV7mNUhyaN1BSm44b40psf1ea7QZ+?=
 =?us-ascii?Q?M87yj+bypRuGuXfZ5e6H3w0M6MTj2qUzAcQNNXArEN3nEuJJwCopU7nRZAt6?=
 =?us-ascii?Q?W1dpGCNUaAmWy1m4hd2FuvvE4IQqc2PDotJop01VfsAWbc91oHacHn+n39ch?=
 =?us-ascii?Q?NZ6vwEVs5BzScJbZbxM4RaPkcOqMu/Hz2at4V/0UMs1k1FIEjmbEcKJV3yld?=
 =?us-ascii?Q?NzHSS8eySy/nJOsMRGnzzK8h1hKxOY1tmz/mkqhr/IIaCVxgfcABC9QhcaoL?=
 =?us-ascii?Q?0eTtrr/SolJOUUVa2M+wEmiLQwgOLI1DZi7iB7ZFezyR71K4UPdH3XpSwZid?=
 =?us-ascii?Q?GMF4A8sG1SJfsk1cfXzYG/DjG3xVOOZ+Qx4q/sK65glP9f1hCLa3cgMSFKyK?=
 =?us-ascii?Q?Zu7EzcmB5UoKfXfBH2NMRiZO5PrCGQkiXJ3Z6TiiyBULqmb6qJj7RqcpbVYt?=
 =?us-ascii?Q?Lre0FKGYgFb2a0rZxxoYlDp34H/MWQaNnmfwA8U0VqcXaiHW/JMzICrc3uET?=
 =?us-ascii?Q?RMQExkmHaIL+gWavCNJdh5YimW3U+GYMrNBg7vrIlzzywQcRBFFM2wmIJkVR?=
 =?us-ascii?Q?4v6soEqjxScgbZozS3VMly7+R8eVSwVNjlJ1t2jvtJc+AIWnUmLBn0xVhp9N?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a38a1974-329b-4801-e329-08dddb88057e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:21.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3Cr1/VSL0TvDdtuNmEQwkd74BivZhecvo8u0P2pi1fWGRGwAUkpBugqWR9qO4drewI/DElKFGPT6MwymeCFFoQUtTcUxwiGLv5HNeZu+Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 70855975c2f3..049dbb406779 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -804,9 +804,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.50.1


