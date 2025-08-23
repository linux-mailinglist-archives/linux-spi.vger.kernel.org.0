Return-Path: <linux-spi+bounces-9613-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB038B3259B
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2C588941
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACE22BD11;
	Sat, 23 Aug 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1cFAmF9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023102.outbound.protection.outlook.com [52.101.72.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0556111AD;
	Sat, 23 Aug 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908204; cv=fail; b=lRQJhHD65aTTNmXGukEk2a3cNBaAw17MRNYpw/Oz8HTJxqPu+N1HJ+RBFFU1Xn9kf/e8N8Fr5f/MRyk+d97uXSJOsVms7GJgXNLWV7DT2J2wdGxLVBeQxWFvRXoJ5JdMAuqKyO6LYwX/DFNWXxhaYC2w6VvsTtFKZ8xHgh2bwDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908204; c=relaxed/simple;
	bh=6wRPZ3JsQPvCRfH1SlYXJi0fdIPN3xQwBEBeQgxM1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jz/LswZAjR5H4quP8K+u5v8xX5sPEseHiaDmltRaz722mZeThL6+iW7nVKiKkHGBKDqo7W+7zD/gVGaiRG6ypLlteJukeeeX6t/GZAvUtsZYS9bUokT2tu7wdYddA/Tt2kV1Vp8RI3uSpjYBYzOeXTy2sH+KdpN3F4Xjb83umkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1cFAmF9m; arc=fail smtp.client-ip=52.101.72.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOXP6RskyYjLXs4NLXBs59Bs6H7sRy5xIZBM/jn7RpaZbqnXfWLFjVJOvjwiaP5iDC0M88XWrn8gwsLan57uh3sJ1lOpL/2YR83wd34Yi4meNGw6EmaFci2W0kN0+Az5HP1FGsBDq3mpOQ39ZZEebdFl5Q9dirJPWAi7MaUTD6bUx4wZa0i3lAyeeo4b2HFFM/lioMKOSwgXsl7ksGzxCusoYG883VkKpFW6NtRv6VP+Ks4tHnk+9yP9yLdKIfMkMYC/fGOm8q9kMzo+Ov1typK9UfoZPnl7ul85s3pvqnqNNsKSeFMTTA1QwOKzR2gcEDlftIMdApfy+W82UmjbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dARcHoCM4HyMpVSyowxjeXYn0ojHi6T9vKH/YSmCFB4=;
 b=XipTjQFU5lZJH/CMdB3+FvEY0eaOFeR9KBnDAN8fyNKhjgKyyPCNwkGEIH2iSwn5SbLJ9F/78GeSHm6542GUVFNWw/Y/IsbOZlL5aMWzBeiQwGBBcHZusYb8oMAtcAEC7jQfqM8AMxpxZm8BP0c/nSbQzlMfe4mjqx4nMxFNP6GNjIworCl1yw7E5NiOuxrvcTdZ5hLN5Twc756rnJYYgFgMHE+/opmiZqXhnHE6vZUqkcVj9Ttg9nEJyM3EzubNVWE0QCIvJqMSrhNxop1SZBB8dWrNVTuxvieEwvu7F2iyZrur/Lk95Eq8uDvV3xuTOITSjxE4X0/9Am3ljw2Vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dARcHoCM4HyMpVSyowxjeXYn0ojHi6T9vKH/YSmCFB4=;
 b=1cFAmF9m8YXFWzjtHdRQLnN2iYnXdNIWI+QCi0WU6HKKuiJe9Wma5YqlhT6sC89d1ITABwOClzNcuO9WsgSElhJe1zbLN4LTP6c+kigg34S0Bu1JN2ribAzzNWqZWwCmcLGRv+9R90mwvkDtu6OwQnfsGulcdGRkDAU6ewyCE1GezRqME2PLGoBjfunT+unKWi1SCT7yD7NMYT0eOrrY26lRIzyAyUOa/ngVqY7VCn0wG0X6TBUThS9bKYUPI68HIOlx2TqvIU45dGK5V3wbObBaylKWHVqaCENMms0p/y7izlkuwkK/ZJLzvfyrXYr/W5rjEcR8Qk8oEyctyz0Prg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5618.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 00:16:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 02/13] spi: airoha: remove unnecessary restriction length
Date: Sat, 23 Aug 2025 03:16:14 +0300
Message-ID: <20250823001626.3641935-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f62c15-24ba-4afb-b272-08dde1da5270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85LrBaImflUMS0Xk2+Y4XApmtB/BQRALuQHFX3QkZObsETlNHbYXPprJCS+8?=
 =?us-ascii?Q?dHiTJXi6wjFlZtFEZdik7VW6UL9IRSSCQmmVmyDPSTbOYL75OArcSjcYwok8?=
 =?us-ascii?Q?EFizaMyRgM40aoUUpPFDvMCEhVVJXL5p8QHfBgtFG1IpLXxuO59ufJUgkGyn?=
 =?us-ascii?Q?4sGMppbWUGQkljCFm11rss+xRdbbrF5FQHGSJYJaG7+3jEFtVIAHXjOquEf1?=
 =?us-ascii?Q?QWd5bOLEozVytfSBE/m3UzY0LasRzQBX3siBP6rHoS4wew158BW+G08HpCqZ?=
 =?us-ascii?Q?ef/2XNKyzYHoeS1SvTBrz0HEn8i0c1v6CwspvTjdmLFRJjwsS5f9SR/1j+Y7?=
 =?us-ascii?Q?Y63s+ckx5+NZMwJhy51KqG4T3fBrPTWufcqSen6T0qTPB1Qw/9dFT9GBgwuD?=
 =?us-ascii?Q?60TVb53P6USZeYS2anRqD3Wmg5oV5h94H8d5BZY22BtFHY1Czsss6FUH1xVY?=
 =?us-ascii?Q?yKazlBNQHiNkH4Ew7Jdr8wowRiTH9BuDoI4gg/5vKJIMoiLINdFVVO/gA8dC?=
 =?us-ascii?Q?hiFimlbo6pciP7mXEciPXbmVnwNOcGC+JvJ+1vgFAy/XWBAWjJGYn4nDH1J6?=
 =?us-ascii?Q?t3udniRKsckv+ndD2uhsb5S5peVXOcWQldMOeGm8unItEmvBD3v/cmgfm9RQ?=
 =?us-ascii?Q?c/Zig2Rcjcmzm7KBMtngu59LIf8/CZuSxiZ+OjvvC3eCzshaF09SKfQoGOYM?=
 =?us-ascii?Q?Qx5Lhy4RYHUCV6ivaFCpnmSNyGgIM0NRa5R7oqOA3xI7YBdbgRS8NjnQIflM?=
 =?us-ascii?Q?2U/87OfpWkq5c7684LFmM16esaIMgLfYUByd2fCvvPrtilJA+MEsomi2yvMA?=
 =?us-ascii?Q?flLc9ICt2st59rDtc+C++A2iaffWnrq0grElP5AoYWDrRv2KhpS792VW5TXI?=
 =?us-ascii?Q?RCgX164vYBaZvZu65or7P227x+PFBRQy8akAUEEn/PVQoyfy6M8Ett47b8xl?=
 =?us-ascii?Q?gJj0oipB5mhGh5rfjh0tcxT7JKtO/J3g8Lvqi0cbV/ltxHRMC2sILOnYuLyQ?=
 =?us-ascii?Q?ZOzr8YrXMds5iUz6yKWK7zV3jLtSZBShT5ahGuwHCH6alinDNe+c7G5ID3SX?=
 =?us-ascii?Q?LFo7SbGewAC9pE8XFesPaUHtEXehkcSRv0AJEGrV6RfIoMhczh3AeogWCT/g?=
 =?us-ascii?Q?OFGFYqiLHmiUMcdeg+A8Pq73YcMrUHYerFqfR18/vnNXdLlq7jqJyK1HI9Az?=
 =?us-ascii?Q?w3u160hhNv1+FJ/gFIIHlljLHyg5k7+7cQzT8Odo1FxxonlS7ENveazDLmhF?=
 =?us-ascii?Q?FGIJvovBo6McEbP/raYxBgOZeSAUmZ3nqBx/xHciiMQmSRFjzrX2O4h1IkeA?=
 =?us-ascii?Q?j7smyT8ZgL3WA1r3/W26MIUOzpkhr/fizdgu7Ex6dwx5pdaSMQhe68X+MobW?=
 =?us-ascii?Q?Jx6TQNjE6fx1JUvSmkDhWVxFexLhmNyzpRcm/riVsLAe4UG4raQDXSZRohcM?=
 =?us-ascii?Q?VLjB1F95wQ42IBWVBwPwOiSiV7kFrhTv6lffSOLrvXXhH9pJN52lYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXP+/mGbCp+OnJyquxekEUx/+0uroc89q5kxWAm1BkiLEOj0WkQghR1LHgOA?=
 =?us-ascii?Q?aTBN7wPFRRRVCOcZumKNYBR3lnGt1dMfB0lniyKyO/CezNRvu6uUUr2BvUf8?=
 =?us-ascii?Q?CN913u9nqxE44kjXkQAhzRdp04/NNOruaTs/cm/TU/Zv+VTvhLfXDRso46pt?=
 =?us-ascii?Q?qbdleygutmH6widUHlMIIirNdf3+fAhnJcIY0cznax7nrwBLBWm/7jqfaJ2s?=
 =?us-ascii?Q?YpO76UdIw/xl+6bZu+Z4TdQyZqB6bDZvSiY6OSJHv3CJaJUrciHe6RGoqEOV?=
 =?us-ascii?Q?hIK+b4EOZgcffGuDQXVh8V/2Ew7W5hl9YhhTBiQBSgjzcNCUT6OFlIM4kbBs?=
 =?us-ascii?Q?TgcADnDfxRB504xklV5UQr3/i4HW24VZDCXBNrX6coo0TuN/flWmdp3M9KFO?=
 =?us-ascii?Q?q5C3QpS+kepwJ7RYMBUlbc4ZWTM6PJjwXBfQoMxmh72J6t4wWTz6VKcZCV+n?=
 =?us-ascii?Q?i5LBm6Bnuh5dSrSo6v0iltkpInCHM8bITcytYew2aH5/Wj5MIEeZTRQkdWA6?=
 =?us-ascii?Q?zo5Bg8vseISLE1WXzYSRgN961WjTFXYc0anKm5HWJqkuGfPHbIkF7M7Qd0tf?=
 =?us-ascii?Q?3eYfnHxj7WLJgHOf7NniHkv0gZFJIrmTjF48zWkQzv6TYnxYrP6UxXQhcc6v?=
 =?us-ascii?Q?Lq7OQt7pCHlMuycD+TtMObxBdScm8hjqWbcZlPr3EwoFkF2MHioPXt5DD5an?=
 =?us-ascii?Q?uBru0xWs/RV67Cc1odO9aOXUzcAaK70OiKJoI5I+2qgmixQO+XPgcFHFTGWq?=
 =?us-ascii?Q?JR6f/eQbBO0V77p2yZMELZBUtGSasJicbR/wMg3SFHO/JizAE7sw54WmseOt?=
 =?us-ascii?Q?IpH9xFXu29yFLm3yBul1do5hfV0Gg5Hl8W4mLb2P59nKs+QxL6NG14/Hgf9c?=
 =?us-ascii?Q?r4DNYOSwslG3y2R9iwH0FFHDz17qNjCVSoNiMsQkY6QZ/CyohN3NxTgzuGTI?=
 =?us-ascii?Q?xifqfwwiQTGa5j6L//oHs7gilN9oGyivMJppNZLqOQ77eIOL5JxwB3jSA4OW?=
 =?us-ascii?Q?E3IKpXPlFrHhpIKjk2s9v2bDqjzDjsWUn4K8E8F77fv5IA3y12/hcL9aFPLB?=
 =?us-ascii?Q?2OCPtFK1SgRrmIGXyxygqX24fhBQ1XBhjAUTrEykBkY7hvGw58d+ypXQ4QpN?=
 =?us-ascii?Q?CNGl8xSd2GAIU8g6qczBw4qdWGAp5dqpDAJM87fbjst8aBuMsQzpGnavcFGg?=
 =?us-ascii?Q?MDtyPIapsuOwmiLA676naMRqvtSnAWGvl7G+WaGJTtYnzo+bZRAj1GVPlCtK?=
 =?us-ascii?Q?bMmp6PnQ05ZbtnTUlPqelaKur3+tZLrVRxhbeMCwBj1C+jLPEeHYfpc9pb41?=
 =?us-ascii?Q?4NCasOUHw3nrab1k/yDcQwFMrXg8mH09j8wuEr1ws5L0NbBCHamfRXxO2A44?=
 =?us-ascii?Q?O/e9IMBRjJfjnCBv4+8pizQlRjA2pEXFnk7t4ZcQ5hxvb5GZFVvxotupRMp/?=
 =?us-ascii?Q?yYRlzixA3hcxMOqr36ILZgyhK4WeA3JFRldc1EIIJaIkktN+H+unrqTXp3Kr?=
 =?us-ascii?Q?LAd3Et4Rd/ir/bNouvjA0xnwfcX3ya7NcBGSfwIRqtIE2rSb+u6qy2+ltdaj?=
 =?us-ascii?Q?PWOsOlDey56V2Q6hSX2KKWVXTeApL9b/7aQT2Cey4nHsAJBODxNa50xbSck1?=
 =?us-ascii?Q?2uBraIo6xNROuqmKRPu3peQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f62c15-24ba-4afb-b272-08dde1da5270
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:36.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AsaZHHSf8QVzjBKk2YeW4LV2neDDnRwiY9emZh560+y2ykrGVTQSEEqIXk7rAnlzkPpvOgrVK6vA+3ekAmDFmRZPmXEK1U/ej7CUF63OI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5618

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.50.1


