Return-Path: <linux-spi+bounces-9871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD30B41222
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561071A85864
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0D1E3DDB;
	Wed,  3 Sep 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gkvS1sV4"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012051.outbound.protection.outlook.com [40.107.75.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82890145346;
	Wed,  3 Sep 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865046; cv=fail; b=ehDp5OJjWKeJg7mL1CMyL96pHQY+zOwefetjz6ycYqGiqf3U1PpcGY709rzdS0aoLk4LSlxJt1mo2b//df1MZLiA9eRilq6Wy6ymt4d0R3ZAxN4iFRLSpZqoT6qMcLNEXWM2rg6Nf7AhjYekM3qN9oJAVpdlDdi5EJwuaoWuukc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865046; c=relaxed/simple;
	bh=EgRfl7JvYuD55Yi+4WC4Hfw+YX8+01T8nXYTRjgXA2g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kRkYA3UmvMdrYbNuCRGwZv5fj4gdc7SqggEcL4pHKxIz0/5TMO1V5KvuZGD4MV8xFEgQohqZAsrWVpbvYIswL32/uhPkx8UxUYu38vbSZB16AAVygZDQaBnBZqetQKDCNo5VUVHjgXofmZ1YgV+XUScAL/WXoKklCJWWn8c5GFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gkvS1sV4; arc=fail smtp.client-ip=40.107.75.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmzKj/aTX67XWbTJAH9THNFs2Nn3THfiBZ/ZaQADuQO5iwbx0MiSxcLvfn8Xrn0i3h81LgyFl1VER19rGqeo6QIziG8hSaww852QTfMZLd3DBnxHpGUoLCkQysAHVwl8KG5GcUqa33XHt6jsfMHNDuRq7Wl78dlGtX3ck2A1dkrYpzJbOZyqT39AI2TUMfbVG0xLiZxF6HogMoTKOoD4yAai4P9Xq1ICYNBKVOq58ioELLFPJkUcA/ylXnUR83jKZoBLBG9vi5xequUL77ii91KHyuQS+0388LI+O0KZiEs31SprwUCI7y9actf+W8M2BDbaKpo/DjlVhduCyO2X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZS2iG8QR5736fCEjJ6mIxdZVSoi1sVkw3/CClekQVQ=;
 b=bwLnLCu6dmagyK76lHfcd7JQvDA2Sb1TVAWreZ/fjOjdmoUBvsDJgwS/TXmxcjKOYFZXDsJKIxzyT6xtXSkqeoXbdoJj9wljLvU0Ru4DWaXoZ/fkyx62R7UdK2kYLJIdDcTfaU5e2vsG48j7iZMU3mgoXxRDazRWGLHKv4ZqZTaQS0GPeUEHsJLlnascTIDb4Wcxu1p/kVyvDJfIq9Mafq0Vk9IeyngcYkV3kPPDjh2cgn7wQWFEJ69PgINQrrogaKbPxWL5NAf9meLAMfI0bv5y+o1wYBZpr9hktEf3i/qOQyX4kXyNZPPBM/9fKtfTgNFNjgxJQzuN4SuOb0L1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZS2iG8QR5736fCEjJ6mIxdZVSoi1sVkw3/CClekQVQ=;
 b=gkvS1sV46X79HDmpEyj1AhiB0Fs07Xb1mnlXDktx9r9WTGuudUlmRkipETpg7bRudvasBRmfWW7ue2dYfWBp9TKePjVtKUkVYb2FAj8Su1GxOfVa6moqsBCJfeMGsCooB8Sn0ryuiu8ghKeRnc7l0f+mPVyiRJtpZg9X2l5DUsnT5WpqfDOk0G4rDleCej2OPV28tQ3Mb+R481OXVpcjSgTgLS2RQNxvH5wf/bp5Xd2AmYe8PIRxTdr1QaCH0RH0ZVSLIuPnBLK5KHBFXIMShYaryoaA8cC0qwgIaqaZpmaKlbkdEPc1eTrOEarGK3cmJHvzHrSRBznRAq5HyA0Oxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SI2PR06MB5316.apcprd06.prod.outlook.com (2603:1096:4:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:03:59 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:03:59 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] spi: mxs: fix "transfered"->"transferred"
Date: Wed,  3 Sep 2025 10:03:47 +0800
Message-Id: <20250903020347.563003-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0292.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::17) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|SI2PR06MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e496dd-3a31-4d38-e1ef-08ddea8e251d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6japhopb2FdV8bZKaZyEGX87g33CxYmIB8DY3eekjIuoiOUGG5HOyDGGog9u?=
 =?us-ascii?Q?ilcemgNozJnTsqLxxv6M4IsAvwHrmSkOLUKQkv2/VB5ihAiezTT7Ep2E74rz?=
 =?us-ascii?Q?oeB5FV2H9CsJ9mvqBoWxxyUa6NQExNLURIl2gVBsJz1f7VY45h9itb8Vpk3J?=
 =?us-ascii?Q?g4Cy+SeARBmUo/l/CSzpiItgb/KX7LFYCiVaMdUZSNxMGSmCW4Gwj8mATvqm?=
 =?us-ascii?Q?ncZO9DnmYEr4UPIg7qE9Km+xTMxgps5yD3p4uz8ea+rspm/NZXWoy2cykxWe?=
 =?us-ascii?Q?VF6LASqR+LtNGhwP5o35DKK7VxDHOKeEgOwiq1r+wNoOF33TISbyEvKncqwo?=
 =?us-ascii?Q?yzJp+3mf+t2lSzHZEcVLNuM5ERtgY29/HWZ0pa+6m/HPdnzhxUNmw6qgwIn3?=
 =?us-ascii?Q?jm3RKcq/Xd6KXd+tJhyHLk6N7R+9UIlEr+blkZfy4reQ0PZZr9ohGUQy81E4?=
 =?us-ascii?Q?OlZ8fA/V7gk0h1QPPIQcs83JK7j68BrBI3WHK+g0+O+HWvyAHtFQUuKMMRJH?=
 =?us-ascii?Q?Meb0p71uF/otWJQntTpCKPNoK3A2Smswod/VWkOc0uJDLe7bUojkQIydiCap?=
 =?us-ascii?Q?D92enEjsALD+gj049XJmw6TwtUcoINv2rl8jOu+R01VxJt2y3E8360rewq+6?=
 =?us-ascii?Q?YyaREbrkBt49N77UQ+WDCD306bwfhPlvhLLHB+34KktNmbZAkrwoi1PBJUQ0?=
 =?us-ascii?Q?d/sl6UQy5pGGmN78+yJgRn0Un3IWTDbXnMo50CzQbXWPhjdpuaLxHIyM0XeG?=
 =?us-ascii?Q?kvcBlI359opL3OAWUQEcfza/whJLM1ubhnGd8KfG45+8WWyZ3j6mDbZRdieC?=
 =?us-ascii?Q?8tei9gaGSXzyWag7Rsa+bavnC1YKNeIlFfuSez3gXa5x6detRFMciDt6ddnf?=
 =?us-ascii?Q?j8Fwofg9DTl4Bq04UyCllH+uU67Iq/mnPWZUbe1MT1OfGgXQwhtCZgOHebsD?=
 =?us-ascii?Q?n6k4OlEx7x8vEW4JYOy7ytXN5LOVp898gPjTqwY6Pju6lrF65jhm0tuk3PrY?=
 =?us-ascii?Q?ipWDdX3cnzu54TuLYpQWmdxu6A6RY+r5qolxhqOH40KxHOq12JoHRikjqq0R?=
 =?us-ascii?Q?ZXRku7iffxextwqpWlQfnp+uWq0qFs/WTGphneasx4OJj7y8+9obe4j+JcUY?=
 =?us-ascii?Q?7cNKLKVlsWI0XCaolvgV4D1Ar8pshmWkejrRjVk8yIga7JUCWC+yMM5SzrY5?=
 =?us-ascii?Q?Lu1uyS2yueHCqne+xv3RzTleEMQJep/jZaAz1oQW44c4cMzR7gP2ZEEp0izk?=
 =?us-ascii?Q?CWWMahVo48nKGnvyn4H3OAiC6l/NJnrmSYSFX4qsDPowad5Yuv5/NyYCHEDh?=
 =?us-ascii?Q?iKZbmw+35WhOdJVOCH5OGI4EIGrxWRnoqWd/jjS6WwqPkeVBrtk+ZUAY5Kf2?=
 =?us-ascii?Q?0kFZYuu5x1DOj6cy8/BsSkfEeDPZD+XmlS8cTIAGhww0etE9JhuMstjvi3PQ?=
 =?us-ascii?Q?1vseOashSejtJ22dDSaOGfsiBISJhJvl+BqR0j78FhVyF0OKemWvhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHpIS42rQg3caD7ehPGdivugCkuL25biWW7qyI0qxzdYvrn/VlIKxlQcO2mN?=
 =?us-ascii?Q?ueQiBw2wa8IqIzLe18mPx66woTqXRJuDyvNPqApO2TzqhxwyQcXqiyTYrfoS?=
 =?us-ascii?Q?9E8sXJaTnPlaN5+UstKpDRYuUpOXPvb5YrdGhjwjClBEwlQzHvQKJPuAucP0?=
 =?us-ascii?Q?U7BvAvRE68SmJEMtJ6MnpzombmOm1yODMlvwqkwZDvwWOdtW/kRIOs0TlTiU?=
 =?us-ascii?Q?Z25fkUo+HxX3o+KwMYEr8rKhyESMFP/4hgBIZSiwIVQu5sRCdz6/+WgEtmOJ?=
 =?us-ascii?Q?7SfNjlQhaUHue+IVnJl0oyS7rt2BJ2kmGsB/aPrn6xesIKAVZs5rYcUapv2e?=
 =?us-ascii?Q?Vo0mFztix+VHk0UB9DtUA3a8Lb0y0gbt++U7NWe/gOUbe6cvVB79EdugYmPa?=
 =?us-ascii?Q?IOZWY3RHlmEQOcB2LJWX7QegUxTDE5xB8VYOSBNjnfxHpJD/SlXaTqxlHZKs?=
 =?us-ascii?Q?Df7iSnUUxcgSkpwTd/q+0RN8KlFa90kGq1U9k2uGdI6fE34JDwYmgqUo1aTO?=
 =?us-ascii?Q?s+cpkzAp2FOekWnuBL1cvHCi0B3VxbFUAWosAxN65QixwLy57wa8X52BmRdb?=
 =?us-ascii?Q?i+IVSscobIuN9aNYbcegzXBQh6N+Py4Qfs6qF0woxkHiLPFjVSHET207ZXL5?=
 =?us-ascii?Q?SOXwWeqwl5wQgqMywatmqG4a+ki9rAV86DpzqGVYGxqxfmcwtQ6qL3eu0jBY?=
 =?us-ascii?Q?lTxRvojLCb/ygBAACyZwKoDzY9TxJ0zDU9t8NcxvsbdBnyROuVwHY24k5aCb?=
 =?us-ascii?Q?Gm+FlaJado0YD1MIPBwjyWJDRNvn5TIP07bHvRQNsCOUDz9xCu76sMJsKjh6?=
 =?us-ascii?Q?H8j+qQ7ITWrYcEb/GRFwiBXQ++MrGriOrMu1tk4rI+HwoxkeGchJd0fPXfkz?=
 =?us-ascii?Q?Cn4iLVCK/evDp8vb0qwxKONLjb+BMBZvdwWIQ1/6te0h3VFheHCfUee51Prq?=
 =?us-ascii?Q?Y8IRUqNP7OSpDtEndJ3GnDbfETS34weQ8RHeX7gBrxO/VXneKacLge5hOwxt?=
 =?us-ascii?Q?BIcvCCanzP9lmYdjGYeHXoVPvDQY1MkQn7Bxz7jDjkfJkpNbNcIwBsq5m39M?=
 =?us-ascii?Q?a7mhP7yNoNkw+gYYMdsKK7gntF81RowB8yKCXRXWuWxn8zI2MsbvTDaVfNID?=
 =?us-ascii?Q?FBUE5CFQi5qtKLZrfDRgqwRKrKXW3xsbU+kpIxsX+pNjnryX1xSkbR9wwLd9?=
 =?us-ascii?Q?D//ypGQmCsoMkEYUeIz1Ho08lQMRPkIr5A3PKrkLvIvcXOTRxzvXgLH6lvbo?=
 =?us-ascii?Q?vTsfAkAwc/XlACzfjbtQ8UlMxfAF9wdhrESLYk/bnKEOKzKPvqqWMSFSJ/Bg?=
 =?us-ascii?Q?xCZw00EpPjh5NpIs0758feUPAsMGZMwnzUYraYZsjuyV8XfZwmBDlgLfKDgD?=
 =?us-ascii?Q?/jB+Bw0HD6jkeXwQ4c5bSph/N7eH8wDjg0UYSlALI5YWN/28KLylfV62m9mz?=
 =?us-ascii?Q?gj2+myH6zMh4QAZUFBn3Rr+MSRDabCBLLIqOllUVf8YGeTbeMe9Kw9B6FpHB?=
 =?us-ascii?Q?C0e4G1KBtX3M20xS5NqRG3TlfFZqclNgGQPcV0SxHxf/SiHhHZfeBpOV4IMA?=
 =?us-ascii?Q?zRgKcSYvI6VMY/O2mHuBjSJNafNAbLgHVFDUhviq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e496dd-3a31-4d38-e1ef-08ddea8e251d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:03:58.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZIztdumqpnOM68TueCCw4o4MVIylYgb7vRw6tLyr2Wdh1e/bBp8yqsTL6DIeZqZnDpVmaaRO71QNheKSAKgeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5316

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/spi/spi-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 43455305fdf4..0ebcbdb1b1f7 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -388,7 +388,7 @@ static int mxs_spi_transfer_one(struct spi_controller *host,
 		       TXRX_DEASSERT_CS : 0;
 
 		/*
-		 * Small blocks can be transfered via PIO.
+		 * Small blocks can be transferred via PIO.
 		 * Measured by empiric means:
 		 *
 		 * dd if=/dev/mtdblock0 of=/dev/null bs=1024k count=1
-- 
2.34.1


