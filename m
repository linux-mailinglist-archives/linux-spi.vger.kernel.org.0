Return-Path: <linux-spi+bounces-9644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A9B32A52
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C99189AD12
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4992EF65A;
	Sat, 23 Aug 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="M1XcZS4Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023118.outbound.protection.outlook.com [40.107.162.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CA2EDD70;
	Sat, 23 Aug 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964902; cv=fail; b=hQHwMIxGs7okS7kYQAte96t5nOtzSgg+O30l3Utd9JJkdrxVKSOwddPrAeHEx2y9M4v8Lm+jxCG0Nc49mhdAAS9YaJIjozySvMS6LyJe09PVpkZalpEZ4QNkdg6QRdDOhytTJU2+BjUAEFbVz7FIEO79uwg0EnNox8PiidKj4Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964902; c=relaxed/simple;
	bh=3yi139oLRY1Y3EG1xIBQk5vhNt4FMhANTVe3kDQorHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inSwiK5rWz/0SuBUAts8FJRUCk2Yo4tGdYBH5X5pqaHs6+IWC1/T0YkJewVtMbfIGTWQBbWvn1SASLS4qdimUH0u/qUQfqVjoU9crgxksM+FBn0+y01Z9uG/vyUMHKLeJpg+jqqfjzQKREmd+I2tJqdZwX1jcVViBQU2eQvbouU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=M1XcZS4Z; arc=fail smtp.client-ip=40.107.162.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4Ox+RhqYUDcK74iAOObe6ISwqe4l4ZRCzJ9d45PZm3ErZYZdToJpBnVDDqw0ZF27GELkh5Fa8xep0weDLh/Hot30GwMgfM+1JwIYzo+6dUZbJ0kSblmXa0s6crDFQK4rSTZfIF/5WBG/VfvsnM5WhcOgrOzxeSt1s044HJ7XwvEY8C3oW8JDw8N2zd+puMrpBaYjLqqSOW3Sonu52MZ3OeBt5dZ6V9ObDXiCW2bPVCzRUeCQUE/BfvF1rCLg7NhmrtTtmGWvCkP6wQGqt6OX9xuDgBNMTAiNOJC4NyJTL8WkoLzWuVu1KSs0wFaaeugL/ZSS5o7El8jFAG/qkICTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dZDfOfVf0uWv4J7U5NMPJtXwJGCo2z0OCtymhOeYbc=;
 b=HHiFKmkORnYXjQgH1z/h5TH3kZwgqnStXUZgTQUBzVhElQzobcsBnJ2iduJq1kNlfxyHJn2cKPn6AUqJbqwHZu98xT68BW28J/IGhq1k/b98lzWxkgRZczar6p6lR1PVPHIpDQFnTxntRNv4e1BQkR7adC/GZWLcmEX+/p8ndV33qZCo8A7ciEySFwh3I2Atm8FkdvINTGEHA0nQyF3r9D+Pur/E/KJkuz9MYF/e1ydOP8qZL0ZCfYaiT1aPLgruzGJSksADurEUSfPqXsoQRB2gxQrleD6eckuExVe/RHGsV7uYLIeMG8ooK9vd/TibetHrfqVLbmhNGk+RoCgLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dZDfOfVf0uWv4J7U5NMPJtXwJGCo2z0OCtymhOeYbc=;
 b=M1XcZS4ZyXy1WD8erA50tIV/xjF/REwKiNGPlSXdAudnOgeJvQm6Yrfj9Gadd1BU1yaFOd03yPTNY6+JYRogcg8SBpZ6PZrKYJe20UFKuzRK/uly37LnRWqCeKsilPOISU5CCnZsDDcGzQaK6NEWpqEboTZ+VHkClppo3THc4TOfgeg5tt4mIfdtQjNIqRmcwuzy35Rrx9Xl+QRhl0kMya8LaYUxyhkHo9P5Na7uyeEv81SIxwJKmHJ/7UJKh+dB1SRDfoxMPJX9wx28Envmn+8r6BeZXOZdYA9KL+yZVbfWNjGuP+5ljhICt5P28o/X0f48dR26ZAGk0stOEE6cSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Sat, 23 Aug 2025 19:01:12 +0300
Message-ID: <20250823160116.3762730-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c529c0d-b013-4c75-8712-08dde25e54de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jq5EVA+UmCaHA7/NfkxLEsjmxOMsFDOPGEUmWiMXmPT3lM/+nOO9mxdsBjvD?=
 =?us-ascii?Q?a7hAdcw1YFpEjzjEE9KRjr32YGQpeGunCeotXByYdsUuBI9uklQIrUqsJMW+?=
 =?us-ascii?Q?l1dqC4N/vu5Z89u05TeJrMc/LxK6sVvGHpNC5bfHcSZ437sdJ7mf+ZqXQfJR?=
 =?us-ascii?Q?sZ7iWSuNPwq1JHcLaIUEK0wh9rf1ZoAQPAYjvliM9GJZu6jR5/YxEcIG3Xm6?=
 =?us-ascii?Q?P+b6t6QRbojG7k2Rf56aT0ex5FR7rkNFjFif+Qz3R2umkxPu3L9pqLTcngWb?=
 =?us-ascii?Q?B3mZBgcFBkfnBbTNjblYD9fxqsjbzyMBVGapFtB3BQUdDwYlc5G9cwMZ8lME?=
 =?us-ascii?Q?QiwYzQx6q81G/eGVZdJvFkynLYn4GNI4VTDMwHTXMkdMUOkFYATaIFIwe/l5?=
 =?us-ascii?Q?shWXCXAPXZPNjLO9qsmMQ7lbpvDg2dL15ixn9ZlInMgQk/CTJYyXGUC/le2b?=
 =?us-ascii?Q?+/W/YmGDsN7Z922OQrcP2y6AdaAZ0yVhcb8090c5KiEOt7CCpYrb5VDQ2rS5?=
 =?us-ascii?Q?wN/YWP6SFx7ltEYOePH4BgUgeY+R6MsGPraFJdn4i0ePTDBDB+i/VJWPPcWP?=
 =?us-ascii?Q?ST42T9mUjgWkQj/44T9hBTfOevOGkCu8R4uNwGAcxsTguq/WxyOxTuHzoj5I?=
 =?us-ascii?Q?m2omv6u1TlQlIt7EviUzYGWX/ajSDM5isvTdtPb5vj80OuAMae7PTKE/ZEMc?=
 =?us-ascii?Q?wWl1Br394JVksulRjqnZb0JOzq5+MNziQImRoZIULlOBGjesQb7PHmSDMVjc?=
 =?us-ascii?Q?FnPsRQV41h5fmufXdBNSU7kgo9fF3VVToLHaPFk8ppc8Oz4HOIdwE+M3w9zS?=
 =?us-ascii?Q?PpVHw2B1mSGqHmoT6vyI7aM25pOVZusfQhPhnCCwqGVYXbxm2f7aInqG6Qvw?=
 =?us-ascii?Q?xxLNwc/p/VJD6aT5aH0emR4WN90PADguoPiMUXi7tOqGvakgjJfGAQE+dfQH?=
 =?us-ascii?Q?3qLcjNNviAO3wN4peQOvuaTcMhsaze1Dh1eYvKMlfupqZB7aLl8qzpeMz0Cc?=
 =?us-ascii?Q?uKYpnozfJqqVgbNU6+Az9OASWf9xpuZ/V4mVq2EHc+L25x8Fm9YhUDId4pzD?=
 =?us-ascii?Q?y0jzCustYZmapWjX9YRWoc3/LalZITgKZFo5NvLv/uAsyWyIoBlY1GdJfPl2?=
 =?us-ascii?Q?y6161zUD2oi4X5h1RYVXHuJuXwTDSKpZSGfXIPvdG7vXg7cu3SE1uu9uAoKJ?=
 =?us-ascii?Q?KJggoUQGlqcJbWo3J5kdtR1kJ+4qLiWQ/qAF5BMIkpF+ZNX/8ynUdSlCKRnr?=
 =?us-ascii?Q?7ShSrrOvIG/wI1wizjmBnF+SDdnn1x4J4Bmjf1kQNlb72+YONm/E61LMxwkC?=
 =?us-ascii?Q?88etDfYpNouIH4owMxnH/Iu6GVrIO5sQm5FSLut/a7va4l7v+s55Xcx3mFXi?=
 =?us-ascii?Q?Dk9QvRojFyxWg/bPEYUQY2nA/hRZNbSHtrqUviFvDkY9CzPjqNDCELz/1MCb?=
 =?us-ascii?Q?nF7KAMYppZrcj3d1meMvRu5j58H80vCTWhj5qDo9MUk9Hhq8zzJFPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDKv7PV7z0mVcmUZlSUX1f1RwhK2elm4CzUCZ4UnVSgmF1IZVV7XgPN2BXMW?=
 =?us-ascii?Q?RB+NHLi5XkEE/X8rB7J2+CAOEGUBczXIEV+Prn1WgrzS/Xe6U8TL0YHKD99v?=
 =?us-ascii?Q?kLRLDJg/2ci5OH/2yXOzmtxyN1Qi7iCqJaTHlX4yJbc8u/+YP8M1S5OGY3kB?=
 =?us-ascii?Q?VffCzUyCdTa5h56mJn3JDtaIkmjmL8JwF+gZb0yuXBC466PGYY4JZ/cE6FZg?=
 =?us-ascii?Q?TcT/9cgGb3vXAO9bQhjdU6upGzR4SFaP6G5Jg4aXq5NtgOMj1ext2DM1jX0T?=
 =?us-ascii?Q?GZKywtqGrrOEWd2GTxEazjMfy13dt9GmCQ5kU8tUOwocgJ8shCxmzgF3oqv/?=
 =?us-ascii?Q?EUgQL4cHaRWuM1TyEjcvsIbYLeoJkbpFhJa33fAJrmZfKYe9OAfW7ExehS3j?=
 =?us-ascii?Q?B4UloYjPmGlk4VI2GTZ+8E6lrnPUjxdeHOUJdh2famhJjFXPmcrrqYEDOVNT?=
 =?us-ascii?Q?bGbMgkIr3zYkweY48RkQjlb4jIQU+6PHgf64MWbhiEP2l60wJTb/6B6cZaBz?=
 =?us-ascii?Q?IOUpFXYnSmNFYacgvm1t86Pqwj8ZIq5Q74hYSuEQWhQC3lP8tfAtB02+gce7?=
 =?us-ascii?Q?+/EuYrn8k437w583dnnqT35G5r0fUJSj2m+CqPxrp0mpiIDqScmnv7MfcU4n?=
 =?us-ascii?Q?3j515AWngtMzw7IYRLcmk6a/AEZKOp9F8QrO7EeTeTRYH2ee4upX4e8/grBH?=
 =?us-ascii?Q?K8bh6fX7dWh7uNh/R3zIuo5EDJDPrrL5YfDHRq00Wsb6EhBXjeuhNm0PEn6A?=
 =?us-ascii?Q?opt6cKRbp43234DY+nHpClrV+gSLSTsp4FSRAcvlGzYk7+Qb9SRsj4RFGUdJ?=
 =?us-ascii?Q?BwMRKnrU/UBiyEjE6El1jKY7DqjvAupl4G7wUVrjDMjOaqzPe5QWxXn71xZ1?=
 =?us-ascii?Q?VFQmP1IrGnwfQTbGdd/0p08RnQ21LnbBxklsyYOaBM411KxdoTZO4FMgWYYe?=
 =?us-ascii?Q?DJNShif+lhzcIHv8qsRXvuV2dWNvvvIi8eAmO+bvE0FrbrHzCe2E/jsaVUNN?=
 =?us-ascii?Q?fja7NkdN2xcocNBIUWKQFpKnpNr/NKfryfG0YekcdwdnNyT06T1UNtxZ2DTV?=
 =?us-ascii?Q?K+nIcCtu/XdLacLiMlskGoJTpEpRgY4vVa52XgyJEq776YRvZiIFs/K/GD2r?=
 =?us-ascii?Q?O+142ZIElXvsj2j6uMMNFVX3aCoY+3313BQgAjlZ3vGPxBRmojoEdrrdsfAJ?=
 =?us-ascii?Q?pNRCQPicWUqpzM+FUV1rJFyY4GcTInc6dJgBSmAUtR5kgm/Q+zphNcvFd37x?=
 =?us-ascii?Q?nrcxNoDjzQ3iepBN++akptn+92KOaY+CIccX5dAxkNULfzWC8D0gbSRZNzIx?=
 =?us-ascii?Q?OJnEDHF4K7TyWPu+Fxrk/RBWeFTjkG+bxPwCwoeCDtbQSFt0VLqP3OiGwlqP?=
 =?us-ascii?Q?SXzh+s/k/hNFz1mD49BEJxgOLEyRBsndbxVVXMMlW3MWf/wUZFhrV+6vE5j6?=
 =?us-ascii?Q?trleOjAceTag7UrepxSKFxhUbPEp5xTTz+hpDxWu/BwNim3Q394QilJfcfvh?=
 =?us-ascii?Q?Zja5hxMFwoR43H59dkX29z1PTm9DItSbWcv9EVdYhWzmZa4gAfFViVQNmjVj?=
 =?us-ascii?Q?5EALQD6bm70LAWfqh9lgnFh4QciE6ogi060LB7Mr5fhqG43prTQNo5KesZEI?=
 =?us-ascii?Q?qK+2ITc9bVDuelCg2LjYFzc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c529c0d-b013-4c75-8712-08dde25e54de
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:33.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4++aHcKLIxtzOPimIGzep2GbCgj0FDvYd0bjuE/sLfNxzszLwOecLdfO6Bqkj0tJe7ywf3AQ1WVJs7a6N+53hTe5bvTZ7X/4iBOYiVRNhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.50.1


