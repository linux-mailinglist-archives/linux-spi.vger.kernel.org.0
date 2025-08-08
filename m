Return-Path: <linux-spi+bounces-9329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4AB1F01B
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023971C81DA5
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C75255F4C;
	Fri,  8 Aug 2025 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kA2WLsYr"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023080.outbound.protection.outlook.com [52.101.72.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872224DCF7;
	Fri,  8 Aug 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686927; cv=fail; b=bRjnsqQp9UaHLQ6PMqRCfuhJeibLNpk+Ft+kNji7VGNENS/0JqkvBYrgRryr4kwVCRcLzPu+JL7s+TfoZLFt/LsK94ci5zW+pEP02eGWPff2rYdAfL/Y6kXe6a4dx+SleN1W5EEO/QfpfNhgxFvIVck20zv9ZDMMtO/41PTyf0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686927; c=relaxed/simple;
	bh=bHd73FH3ShticCv1/VZLIZI5cLPD4ah798qI1LE4YOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MSt5zpmqbv3jKNgxGJp0KiT/r8Xysvp9QAC5+3C8ggUb/2pYyQr0lEhAj/dqsCRyk38iwuXyxyg5Pe4CRU4JhzlM6tdpvqC+0C5AY8Q862GW/vxW1TiMILs5StpV/tnoXaR4R7o/3Ufn9leMs1O9fonfkIpUdaW21ue/ZNW3GZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kA2WLsYr; arc=fail smtp.client-ip=52.101.72.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyQZtXnDD9qknltY01Nra2n+Rs0lJhKpzvkTQf+NyO8nnJ0xsl7d44ogLqGIrd84e5x3oaw+pMAuv2huQ02GoPyDRfimdnWWfYk1W53o1QoLw7liamWM/C9Ikgv20DJxWhNXg1/WJExq+OeVY87WNGICa6ufinIj5ZJZ5dHmGCPSYxzISro0aUimdCMnkKV7hB3cZp2nmJIdGYwNGuzcKsl4lD4hkbdNv7fEa7Yrlv2HO8LXbN/KeoHhjy37lpJxL+/MgAun9arUvgaPD42sV+ow286fLp1TGYMIeIQb6O/4jqQLbjPKE94mEPpVRcQ0hBqUBFx4u7Yd2fMZMNXxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chJSfyvchPGWmWmLZbmavzUkHLrqr+y2WPMPZIsTx9I=;
 b=QQme8CAZc57DRM59FlKN3+Ep0So5RoeR1+oPkfpGnlrBYycByK7xE0oLl2/olxasDrYX8yEJUTY/BWKpXryDLF82uIlx1k4RUYQhaGUrlqilw3qKlX6/16zh37RlfKKT4GKoTBokL/kbfPOosqMQzWKoqFwIa/sLMoJSqB3FBWBPZUtYzfVfcdBxnc7DaGdKH1cu05oxJCKV8XmVtHYTN+I6Sq3QSM3/uhpS8+0XG94WblKV6jaCSoMWRZ4h2RAiyAmQfTi5SL5E/zwjuxB9wk3+n031wGwQGxZczs8XVO6ldoosBa6v24LrnMhu5IdKi9VCMC4/hFszjo6hAIAtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chJSfyvchPGWmWmLZbmavzUkHLrqr+y2WPMPZIsTx9I=;
 b=kA2WLsYrlqPPKyOYI5KC4KKPQKcZupfuMhlibOTsqjXlNB5iUExXu2yXmvt5HuGHOYtWaN1Hn8w1QB2vWycHrcUR8shPf4DW1mm0fbOMgngukmOBlONZuso5+c4qqY3qAgNmJM2rMjNgXF9aPa8Kz6haMuPE9JgNlwlbkHrcULSJ3Gj6DVatuEEs8wSHnhf1mToXkMUBoOHsOIa0EYCK/GtIifPorEhhFCqopVHKXU+3FD/q7Nt02LpEp3VIn9x/x0sEtrxSUw1glCDhC9//uHHCdX/4N7X5mPZD4DFmXPJTJWOXl5anULb5wnA5dGNI9xpz68YN5zqisAJLjjhgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9739.eurprd08.prod.outlook.com (2603:10a6:20b:605::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 21:02:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 8 Aug 2025
 21:02:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/4] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Sat,  9 Aug 2025 00:01:45 +0300
Message-ID: <20250808210147.3085391-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
References: <87cy98g6ts.fsf@bootlin.com>
 <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cd157b-612d-4678-7e88-08ddd6bed16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlVsFa/P4naK82al6UfmC0+rxMhLjp4OLnW1vf8q9LBODOmEscfn93cq0Rv5?=
 =?us-ascii?Q?UgKdfAtQpbZAmmxJYKl0WUNrppcZ2pSf/oz5hIFHVUt2SEd20u0maLu/evUb?=
 =?us-ascii?Q?sf8McucXH+sKtLkKXf1fvtICtBS3yBizO3d39SO3tCBr6FSLQTEsr5S01rL2?=
 =?us-ascii?Q?bUgYDSmE1jHeLzGhP4IQ+G58ysKYu1dzfCngp3VRsmI9TNTnpM8860Wnd9Rs?=
 =?us-ascii?Q?vUHh6Ruux9sdb20VeWwZSm9lE56+6inq6ks8hEscDsIa7LNet8/zz1FBxSu3?=
 =?us-ascii?Q?roPwCpDzZUdS7vMm+XV6vtz1gpytjaol2T4jJnf7YmBh8Ra/GeD09QQvvxRY?=
 =?us-ascii?Q?frjCtSi/TID/YX+fK0Vm+rC+/+e66GSmBhh3eoUALaWZ/4OqhPIQ6YPsS8yI?=
 =?us-ascii?Q?54kP5A8E9RgeXQj/9cTM9QkVvMpYhtDVQx0LqP2U6nv9fSPxofJf67opu1Zc?=
 =?us-ascii?Q?AYC+dbd2UMbkfn9YKayfEc96RUcz9nP7r/uAqRNM0XR+vWRkileqie9pEIzF?=
 =?us-ascii?Q?6Pz+qd34W+73/3tGUk1CZamg74tSwJrT1Ntd7zo36NmHAYxxkGsGS0Afya9I?=
 =?us-ascii?Q?feiWTjlsWu4GmMrH+NENmbiWbOJTT64vCH5QHRMUeTsD7VBBIU+Al+rvAD2u?=
 =?us-ascii?Q?UvvMIC8uqhVkwTKeM9Ae1rgxgYYygPzCL3vZVMRISDDb/NEOXcgo/T4aPne0?=
 =?us-ascii?Q?ye3xlNqH4waLE7GE0e94NWwBH1emLm0/CDcWznHuO+tqHVdRy3xf+Q9tvzjB?=
 =?us-ascii?Q?LcJNFzgPqLeLwFMKiHvQcNRAr/V1bUGIsJivtbeSVgiKDGGkp/TsSq3HkFfe?=
 =?us-ascii?Q?ZLGsKV6Fet9UX5YQ90r/oPvzb7mFKjzqFQskncwd4nO4ymPjspUIxLD5VNxH?=
 =?us-ascii?Q?w9tqxwjSQz7ghvJO0/L2ZgQEgctMfBGc468EpHOWqQ/gS1qyULD5JJ/2AXwr?=
 =?us-ascii?Q?WAqrne9dQOnbrfYa44/JXwQQ6jAnGFarVx+yV8Mu8i7HGwCbOmQ5khHYBQ+1?=
 =?us-ascii?Q?RChmTY4EJx+s8QOHksrMyWK5uDnNeht7JADttOKALRSLToASG5BGe/1o9WQS?=
 =?us-ascii?Q?IT5crY+tY4ZcNwOwKWoSjNSkngAL8d96bfeHbOCeGaG5KC/QykHb3d4Owmox?=
 =?us-ascii?Q?e7VyzqJSmcxPeGcRRIccQ7OWd3l8sWI9nRAdSfuz/Q/oow+sUFvvNA0iSSGx?=
 =?us-ascii?Q?jfE+MsEuTJzeiDDYYbmE+VcbXlhae8AOG1wFXuMEaGE35Z+tayadnYeBOYTF?=
 =?us-ascii?Q?2zt0sG1itPC6ZQnZaZbW3tbGiaCbN43jOIEBuQODCt49oMewuVFFelyIus92?=
 =?us-ascii?Q?paEZP29o/aNvL5jQiIb0BBlrgyvGPpgoMXJTpQY31bSTiJph6pq415/sfe98?=
 =?us-ascii?Q?M0NBhpZHXcol0orxjTg5jlaaJ/tsZPlSTNsPmz0Z7YvSrLMM8U2QCO1Zln6h?=
 =?us-ascii?Q?H1oA9ZJ5NONpub3SG8U7cK0yIrFSdXcvXzo/9TH/Q6R9Uay/7w1rxuFGX4NZ?=
 =?us-ascii?Q?POvl1VGoWgrpqH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQ/x+oBsiidCkEdfILzMrJvmTZGwFD92rwX3SrqaSVg4oNV1mC3HoENbMc0n?=
 =?us-ascii?Q?/QUxjmIa3gMXANnSz8S6GJPXkyGNCkRoDGxEf6HiB2YTeqm70kZjjGJjh03H?=
 =?us-ascii?Q?WvUFvRnmhb4KdsQqxihrvjFDvBZk4vkSyL3bPkwAAnQjDXy/facFskGlvY8Q?=
 =?us-ascii?Q?RWjg/hUwggIHdExgEfqspaeiqPRuKYr1x2pB7RV7ERAZhs1OxQXOskK1wKjG?=
 =?us-ascii?Q?g/afn339XcQ5iY7uv+PLiu9bsbhxcMcFgWyJRiL7P1LVGgYHaeC1NTqyF2UB?=
 =?us-ascii?Q?RX5xhWKb26eaMiyZBFfG/wNpnbSOsXlk8SJlM0yMmeMyvDjGD21spdDxmhbf?=
 =?us-ascii?Q?E5Ez4+qX1QJcjrSmzbfNJUcQQ+/ZZT9U5q/HsJvlZ2rePEUMmL++xf459rLn?=
 =?us-ascii?Q?xDlrJAf61JcfBxhdszZW2qcSJVhGqkIrrvkVZoyJ5EonA8jwsLwK1h9uX+bC?=
 =?us-ascii?Q?4Ht4ekSVIHrwGRLE0GJv+z0NA2MKeliItaFAxHlil8BLCWU70sJLY2YBrVTa?=
 =?us-ascii?Q?Mvkpw3+Ayg3DSHtJksf2LU52RL3wt++kzW1VFgocBAYiPE8lCNXAK1s1M3XY?=
 =?us-ascii?Q?KdjI3bhkbvgKDrMtz1nDRrCs6UAH++EBuTNQPu9pVBa6P0NCjrzXXm71czMU?=
 =?us-ascii?Q?Dc2/+Flf4cwup2e0zTw9sk/PvpL5cvV152w11bbGKvYgNA3mDMGxq980bLe/?=
 =?us-ascii?Q?GCcVx9Hd9N+MRIiXjeGZCSLcjkjNdl7jRDuEbXiJnf9hQ/DxtU9m2OD9bLaD?=
 =?us-ascii?Q?BYrFLEwFNK2DoZWWTbcst8p5Y80iP+yZLP9Hk+50S93kjxziaXeKzjZwmzRd?=
 =?us-ascii?Q?gPTzBX6ern9amzZbjC7O0bo90/xStSCSkciFvi4uRZXlMImXC9TszSoQZxYf?=
 =?us-ascii?Q?BxgcgJ8iaOA3BYoSqMlhGFDEx/hGQz3Fe/MVhIxfLM81B5zCnHwxYep8PXI9?=
 =?us-ascii?Q?M7KqTsHg5CVcueAb+NQi4EWorld/w8TZxUSeCbMgLzfmH1VPJ3pWi56jT9Wq?=
 =?us-ascii?Q?+0Me5pe++RQSI9b9sSpaRfJ6Y0wjysVLvT9BLC4UlbhZRNhERyiU4gg1dG+i?=
 =?us-ascii?Q?myaumoQpzRvbyNShOrnF2aGSAAF29vpsaeyQYs8i/TOrVfy3HwWMdgmg6/uS?=
 =?us-ascii?Q?P/QvwA9ImPtuFgovfYUqCut5PxjZQVngdyR6r4pTEZeGpJPZ1wV3P5oQWml2?=
 =?us-ascii?Q?6I4IpXhf3OqbSDlwFJwW5nYS8534H+j1Ttr3j46LJ/RR89xkS2dvhFTxRaSi?=
 =?us-ascii?Q?E2IfBcje5iDzkH6Qpb+6lG3MPtv+5S1pORzhiEAiU8iyZS/xSYqGOv3X6sU5?=
 =?us-ascii?Q?bySAZe3l2EHvRZnwzuiNwELoPfwuITRKoh4oJqmfyatjEQMqmgum6KGaMFHk?=
 =?us-ascii?Q?KYaMJfDQlfdNrkpg8GhmIzzI002eswixzJFLFbKBIKIHHuOY8YUKJY8tbrI8?=
 =?us-ascii?Q?RxXsP21cQLDjelLG0VJhNXlsv+JCIRscqhuaCoh5Z7gvDyTwHNylntOQc47b?=
 =?us-ascii?Q?O7r6POxdGDylhNi48KCC1yy2Psb+kA+MME5vconWdiqnF+zxrTz3TlDq6G0w?=
 =?us-ascii?Q?9qVIvRJdM2HrULJO2/iMeA4XKdnWgwco6RzYQj+44hS3MFIb3w5X0R5x81rf?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cd157b-612d-4678-7e88-08ddd6bed16c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:02:00.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrinpludueNLgdE5Nra6j4wHezaRYIZXZh1JMgeb/Ld8VRAs+LwrDnxCXR2+KkRWQKLaF1GX7AP7C+uExQbbALKA23DI6EWitwPtSWAmEX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9739

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 09dd6e40e308..0f8636047365 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1112,11 +1145,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -1139,12 +1169,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.47.2


