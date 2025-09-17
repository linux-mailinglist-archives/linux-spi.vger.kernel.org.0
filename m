Return-Path: <linux-spi+bounces-10083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE6B8213A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414A43ABB7B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C830DED4;
	Wed, 17 Sep 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="hxR2joRu"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D83112C8;
	Wed, 17 Sep 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146361; cv=fail; b=VfqBJSxTh6lLTUiuwx9AxXa7HD/h9nV++JbgvEGXiHE7kytkb6fZkvJ67+lrMfMZq38NtPh6sWZuPYJez5ufAAQQImaaikKsmB9qIYUpewLEtq4RVuNCBQtYTEelQ13uXNX/Mxb6x1U3Wz0+G84L7d2koDMo4EUTKhWa3+vusvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146361; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUqtSavf5N5nKgzTw2ODFd343060c0pgAEUr3Vn1Y0KDrzBIalsPJtgMJLr4UHJ4+G2Whft3wEn8jyVo/jrRf9/wVvwwpK9SUsB3ryMDlcFPxto8ddy1S+Yb2cpU8sg2solLG26mejcwnjZcznI3yubzZB3Pd5HbmAlbtMQw4BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=hxR2joRu; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u74yciIFOKxbM2sYEuHTe3fS5vj0/GLVvUt2QrKw8l99NWIiKoysPj+e53gB+4lQtF8/5wQNq/0dcjBcT6qw5LE3b9U44zSEbmGqTYJmEIwMGcdzCl8GJLv0Ox6PjgF8zHwfpPVhY/nTkYDDxKtlpsRzjJEvg4xHcHlJ5c1viMXUZrlknPBJwpxINFxA0PDIT8BI3lieeTMnsrBfOjog0K6Vs5HVIe1jPhVBb/F+al7jeaHx8mw/0rRWLHi2vZc5s//VlOjpihYEvcFqylPrnASY7s0nx790IGRLq7d1DBt3zWekS20abfRTBlB3p1ki7gjltG5Ccn672iHpHxGuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=yYt0jHDtcp2AsyrcJfLN5MVU5ugJc3/wfKJAMSn9OobrrN57+2VejZkZkcGtN0Ov9Xw0qIUJts8EFczhNk7ZQCJXzPbS6rtPHELHywjgE52NS3rAWamVh2KHw8BsZnJARDQhdtrq801nZEWRAVjKSwhxvY0QvooqySugyH5znGjK5KmTCFi8sr/6tUTlXPkI7pmC2rAcwxpmlhHxl4T5ajbWw/yTPFG112gHP945/TvmHa7536d0XWE/bZckgHM3dGnGygJhGAuruwY3dgTPqTEemaZpjj02aqIfH4d8vY+4U3iakgxTtzNhRgr11yNVWU9GVyoxjzmW18AnB4g1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=hxR2joRuJ/vmuZOvpYeuN3edLnSdyg/o3KVGgeynBz3Phv6sSYXxr2wqTQvezFJylNH9gRmeCniw4xm3yfRqBPb7TLg+mH4VQ/MbxDvbCpD0YJbosnnLUkCR3AzP8WcILiea8mmr3ys8B+aLQNhFMypjRUZcA8lF5mfnSl3oLm4kkNpaMkRxRp4HS+EpwI2RhNaly+UR/uxlqfiCh+LVsb3gowxH0iKBhGLczEY8a+IT5vyTsNLfA4eE6674lWZt3jAZyXYHdiAMlmwadp5IWxEyU3GhylTwtD8tar8YDVc9A/E6dUV1V87R0JYz/+ORk/JvNN9Y0aL1TO5Q7I4+iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Thu, 18 Sep 2025 00:58:45 +0300
Message-ID: <20250917215849.19720-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfbbbcb-3300-416c-facb-08ddf63570af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BuWFPJ2PU8hb+fACuFXKtegALR9B45xqLszXC2KySdpOuHK9/G9DhZblh+6?=
 =?us-ascii?Q?QnECVNq6JJC+1jNqLdFrysfCXJ140tCSnrGBg+4SvAFS60iYo5X7XumXU29K?=
 =?us-ascii?Q?cVcn83cComSz00JXMLe9dPMnOmlYxShY6eVOFr2P6wWPtGUXz8sdZ82/Gjly?=
 =?us-ascii?Q?74U4X3/4PHfrX6/NU8r/3gdyUtStzq1mIqZlxlwqDNfpvBR7/pR0btE1M+HL?=
 =?us-ascii?Q?Agg+LG9F8AhlujkCVL9EB6glUY0fAnjbqUbSN1E7woyOdkradDnfy3mRcRs6?=
 =?us-ascii?Q?a7u+eY4M1m9Ll2mTJe2N5hWkmGKASfapaxChEcTl/FGbHQZ7+Fefu9Yder5q?=
 =?us-ascii?Q?KXSam636UqOHrE7DaS9bdinxT3Jv8yiBAfE7SikpTjcXuKjW9pPbv0w1yUfc?=
 =?us-ascii?Q?4feXCKiBmwqjz+xl582QuCKDdtnhzPXXTF1d1Tslk4vG18K4tqtPCeL5QrEX?=
 =?us-ascii?Q?JlDAlE9PeDRpOCqjHg5LvjhzwWywfxGAWq7gQFvxo8zxsiYT7NqjWmUu9qnO?=
 =?us-ascii?Q?5mrGi3sEL09viZjE3EvaNvVknGQQ80VtYMg3HLRErVVTeBtjjYedFyROHIVW?=
 =?us-ascii?Q?+BmD+siBr/yNRpXsL8ghkqSzDX7kvuk1GknkJ3BNzjyTtz45JJBlscevIJIz?=
 =?us-ascii?Q?H9G+B/LIbOIXJyJ7vsUZAt5C7fXh9Dm6Vc7OEFWPoGcRB0kZJjCM2Wlu7UZc?=
 =?us-ascii?Q?2HCIJrIX7raVzE5qACp2VL0lPvysFPd5qpDNxHio7wVTAq4Y3w9HIPXha8pS?=
 =?us-ascii?Q?xF7twKo/S4NFbvFlqJrWvrLMkViZvx5NZUj9nnPpYjCLz12uOd7G0L3gDLDE?=
 =?us-ascii?Q?oyQ33rY92I8seR/mPPsajuCBmvqJHq+myQ8ZddI7HN1jWbpyeEDsPI0T9sUg?=
 =?us-ascii?Q?9sbJ8ufoozoU1BuhCB8hsUtOwAEjZc0E1TSjUDFCIxA8qopDk0l+AjYTnNdc?=
 =?us-ascii?Q?2X2bm1G3T7lfNlkZzmkPUXhu4perRK0MQX1/eXApAsJ9M/ZANqpMPqHCurMf?=
 =?us-ascii?Q?+Jzk5r4IansB2CaYrHsqL5RzwyYpObL4/Ilit0GDLNc/ysfHN6aGA7mOFYuy?=
 =?us-ascii?Q?ERC4L/RQCE8R6MWHYxDoyc9kQuSmq0oZk6KymhkVtiFF6ifSpx8zTrKU3Uig?=
 =?us-ascii?Q?P5ywsCZuYULwL2yDIWbs97cmO9HK5bKZnSAchSJLMGPeJQTsKN87Dcff4up0?=
 =?us-ascii?Q?vxSaUmIabg/hLb45oepQ2MEtdJ70HKtih5zYZr6pyzCh4e9Fngosvj2+V9Q5?=
 =?us-ascii?Q?8jX5G0L6l6ydV8Nj+E0AMb0ksmwaxKdifQ6fX1oSV8ygcQ8SI105PxmweoGC?=
 =?us-ascii?Q?EL6uWNJAhj/IdJaLrzWQY0m8hv4h+Ji2lNXsqCotfJZMhSgFEFjWdSSAvd72?=
 =?us-ascii?Q?hN96DyZOuFf6SFQr4wMJZgwgHQd6UNnJzZx+9sx3qyp2OBdj7O2uBITZGJXw?=
 =?us-ascii?Q?vZEmpmVP8dcQUEnnQj48ZHVEQFTJ54Fl0DNBzojjLfig0nOLn3dzyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFafItAnZY5wOi7Jq4G9a5ACRY4OkZWyVbuEdTM4kLZQvUyKdzMcrSTcinpK?=
 =?us-ascii?Q?SKy0CYbckk0tC713o+YpE0H+bT+0Oe1t6kWcuukoacNMtVo8swL6owBPjt56?=
 =?us-ascii?Q?Gdc6f7IyHaAW4XP2KEGF7ZmAvvSaiOtOqHV9rbbwYnHR9oW3rDyH/mk6M1I2?=
 =?us-ascii?Q?05vcqCZcxjoOJz/+rsGPdqb/g+jiSehuljGhOeubtQPfC+tc7fkS0mB4C7El?=
 =?us-ascii?Q?RScSRs1K01D9HDtHzA5jPI64yZRTC8kcV2Sx6cV39aDzCm08kY1SHsizdNU2?=
 =?us-ascii?Q?Oq6ruNHMTb04g1MhnqdlWcgTQife6ahSyu/qg6KjiVl81fjv05QcnLuIAqoe?=
 =?us-ascii?Q?X+QAZQ/EmbJUzoH2gRCohk6c3zmz3KAF7FKXZXJajUyU7NpBB2Ca/1wC+JSx?=
 =?us-ascii?Q?7PORJfURH+KQvFyO6/7XOdQg+0QBwr7OSC02MWt5nqks5T3fImT3JdzLUeoO?=
 =?us-ascii?Q?E5zXVM5HfLnA1K6tFl9RoOgbE4tj3pZctX5sUCVRuvJINV9LWOEpejJ1fCIl?=
 =?us-ascii?Q?4INoy0B8eXFAuLi+SGSn5VMk70u/oMEdqPXKeC7m6EOmhYnNISMZ1YHf9gbb?=
 =?us-ascii?Q?HSzkkzevNDhHZ3YxCrQSb86QW5F/EDNTWg35izLniZA69pF1tH3bMqfl/7Gs?=
 =?us-ascii?Q?QZMWBKq69DWyup4X1Me3InFZ/7YcmZ6CLepm+cMzfFsJ2+urLdyTElnry9mB?=
 =?us-ascii?Q?m9R1t1gCQo5VDPe44QLGX4sc0LzkYK3I0EfqACPorgVoA0Eq/w6et6sOneI4?=
 =?us-ascii?Q?hcs4yjGyzEX6v2LZrIRqngVdW6FclalLtLpw872s/M4jrC8tfJzNryQy29Op?=
 =?us-ascii?Q?oIK7YJvBMJtcFtox+eM7LDnYYUxKcyRgy6A09vQ4dvxNEkdPtvima0L2vaqd?=
 =?us-ascii?Q?aF4GwnJrdU6hZCqZxhiFYfspBxvUCG96Yw00JfdVN/VFFa+AJ/nZ0rZEYT8C?=
 =?us-ascii?Q?q72FwdgYM0aWZqgIwvUq+24SUK8eym6jQkyQ3QZp/wd8JT+qO+20vhBHWj/+?=
 =?us-ascii?Q?NKtXFBthY1yI/BmJqQT7MNU/HoiAXdVotX+65T5yjAwhzytPaA3+Cs1YNefl?=
 =?us-ascii?Q?1oS4OF2fqF/osiAdFHF4rcTCR1JCMHCcwG2PU8MQdnflchELl6ZKLaslLzRf?=
 =?us-ascii?Q?WQPXa3DElnH++rkgbdIhK+PMx+QVUp1S9bUIAHHYNcaFf5xwoSZ3fsx/UY5z?=
 =?us-ascii?Q?3XvUgbuzf/F28y76lV2vmZetKfXNs4PrnsUKKe1WPETVWGn7J4SvM6WkV5my?=
 =?us-ascii?Q?karwlGMyCrgOPam61RGrFs5VKLtlJtxFzg4x5JyubDH9Sk1tYbT0gAvYBCo9?=
 =?us-ascii?Q?+8a3HpPC6V1wZ6t5uFT1YcGtE5taZC+bNY3SZQHtfd5ecgxOplNslYCNq9Pe?=
 =?us-ascii?Q?hjuEN7mqabgP/EUfki3c110DOMeCTqxhYcZlg49s2G03e+uMs9+yRdbpIOOb?=
 =?us-ascii?Q?26FFLGhGgRtZfi1gHu/bCRMSHrVOHN/kwHjp5awNTJruRUGr+jFc+easAoAi?=
 =?us-ascii?Q?hR2VxwbgjJcqZKFgtnVxNGlozMODsJwbvGd/WlHJRLLJ4oDdLt7LNH+dJDi8?=
 =?us-ascii?Q?sipnVWawPemTOp1WMBi5u8a4ra7cUaM0K0hxWMbOtGb/4v4NIdClFh7fieXF?=
 =?us-ascii?Q?l496t/Nm/nBRm4TCgdvTVAM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfbbbcb-3300-416c-facb-08ddf63570af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:14.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uac2Y2hc6JLxTCv1m5VSryOvTIO5z02yEQUlUSBXvz4JxDe1A3EISKYKuDuk2Lpo4Y73Oy5W0g82KiZ+Z+jgIL9hyi+6tsw/0iVC8089NLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

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
2.51.0


