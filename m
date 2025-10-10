Return-Path: <linux-spi+bounces-10511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD6BCB8A6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19F584FA104
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558527F01D;
	Fri, 10 Oct 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="QD0FHKLZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F527A462;
	Fri, 10 Oct 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067133; cv=fail; b=Cg5bZBBfAcfJFaIurtrLAyMtCSOgZ0vjnyodTxlpsRAq4UcPfE2r6R4ytm4saDqGmZvuhF416+WhqGCaxxFytiUKNC/yusNqwWoDM7jPQmL3mQOAUzc8OwqcZCCet0bQX8rYJkkmZ9IIjkN3HKo81vOrXLoPknSxby8zpU+STR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067133; c=relaxed/simple;
	bh=RiKbo/qwhlU6jP31RsuFL9gEwPwjUa/P/53eg/G8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hcr2OOuZwT6FxoJFzWwagbUmHZ92S1InGdKkQx18x5mGW7DeyQ6pEqlRyebDbuwoUaN3j29gjedyet3rGo2bx2trM44xhnGZH+kc49g2AqYAWvMoRL0yGQTBsXzNr3qNv3TphOj88bwlN9MoqMjorFlIhCxMsXNrC3KVvbCdkX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=QD0FHKLZ; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8N/g2UAvAUn2gvdZEtjBhHrO/N52KGLKhUOmHzy0JGvWTr2RUU4VWyAThE8FN14w0j2hYAuT4I6RZ0D9nwfiEwes3tiIzCvvyUpdP5xAjDousr4NymgjOe5ZRxyfaKZub0lTajDB3+q1t2E4wzni1nc53QuNK2KTR1qfyvWKuy8Y3RVOSoMWxsgGEl/IYRPaEm5JEH3a/dz2chpjeTWGwj/D2uRalt+J1mg3RsEWoS0uSgB2DCfGJooxWmnmrL9M8HX93/EQftkZAx+NCNjifrdrFiZKtSlBZdTm1JLnq0cIv/ubLirEUKOmgyDvNjHtAUjzlYRN/4r5mSihC4Onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=gtFrCCpb1S2Z8Fs2pZDV5vZR3fshEVuU/G0SOthMdp82dSdhyLbbL//ikO4/31vabeMYekYix+knNV8nQfiz/MMko9+lL6idRAeRn2Xgc4G/2IfY/racM2OqNxWPUdNfD2Fj83oLcHHWKuhGjNARgZMI+7lpEMIodyN5Df7oF4uTM6tF6Q3LwRk9YAibMJU1+iPkzIRgz8tddgTOicpSJwedK/iLMXUziPPeLeX7TTtLSUd1+bIjEEzJCkTXQbrWoSIPwPnnc6IzupauVFpT+CaGulODp4ZTJfJuswl4n6FUhrxVmVu8TOZQoFJJkcDhUMVsOxDuD9tVyqZszI/png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=QD0FHKLZzi3e1I7SUh0jBoBc6pco0Xkzvu3L2kjZPMY0vAO+fQWmgSubdK48MAf83BYTYFHgENKTkrALFvMVZw+dJbjCOOjZtCBi/tT6BB5E95LPvo73B+XhwyhYmqQkAYTLKkBRuVqaYwhBtLgv8wWsCSYGFs59jdSoSjCf/GsIbJabsXqaT4XIXUQwU9TGtnNYwzZJlYKiyPBdl+dcILadXHqDsbzUwzMuv1fet6GILyhrQHRjPGSp8NMdjWe7OtILvSE5M3WzS13Ixz53Yu8krB8rS7Z5A8XdXWiWJC5+d/L/m19C5I9HGmMNiKqHKBSgBnbxOiGWOnPTrSX1mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 11/17] spi: airoha: set custom sector size equal to flash page size
Date: Fri, 10 Oct 2025 06:31:30 +0300
Message-ID: <20251010033136.1475673-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d14e1a-a75b-48a2-7617-08de07ad93e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLeYhqwPJ5nlyFwB0zkMvtuktMAY+wQoIdvvi1OSJyhUDxko9KdAwHquVo4s?=
 =?us-ascii?Q?yGfBv4LSTRqpV1zNOptR9THsT3relwCwZuocUu+liE8lBJhAPDxZTtpOT8Dg?=
 =?us-ascii?Q?FN1bELuiFnuM6QDj91o2rZLLOlhQXU6iByz3v3zqW0QSSmzw1Dz7OIFfOnNA?=
 =?us-ascii?Q?amBrKPl2nTJIqJVWbHrTOmvL8voc30zTqYmU3Pm/oFM13kAcafth2qdBEB7e?=
 =?us-ascii?Q?PYExaaQy8+6/gOgny6oSTbpOscCrIKiz5ZEQLbcZDRqqKxpmAbRuPm9WJ/4F?=
 =?us-ascii?Q?l93vCJLgSRWRduDMNWIrewCtnEh6dd47YgEBuolpO3wiBusFCEVTtbBrUgnw?=
 =?us-ascii?Q?Oq8LhUNAFRhBVaFpDax4YvHHS5UbLdt+0eH1eopaCw+8Qi6gLRDGhNyOPTpA?=
 =?us-ascii?Q?zAiUY+X4h3DUK3L/OiycsNp+Y1wQsP1t1B4lA538N3ec1BDq1Zu4Hm2deJYT?=
 =?us-ascii?Q?hW0l4x4Y0c8s5Pe9+3wyIAPXQgR2d1KeXqUT9qPHY1UGZOBNXFyma+qkouif?=
 =?us-ascii?Q?vErBLm/pvstJhiVZ4cEb1D2/QczHzUJggtEur2fZWKrFjVQR7dvy8mGsInpb?=
 =?us-ascii?Q?usO49fxsdmD+/c4DxJGMQObz4ZIFsaSx8RgxAFGXoivMzxXxOp8/e/ZmyDnP?=
 =?us-ascii?Q?0jNXCrP6N2cHebs16WExMX+pdghr+fisHq1LRMqFcEjBo1P6MlNko79WIQvi?=
 =?us-ascii?Q?ae2wlV+f3UT6tHqkz580Bp5rEg+MpgzPgcMJGHTcvhLyIz5nkYbB6g4fuiW7?=
 =?us-ascii?Q?iNIEdZC1iBdcLzMXNV0U+/m3ImEm38hP/XcMTWI74U3kqTXJTV13rk0noV3N?=
 =?us-ascii?Q?gPEmTBSiiRJL0+FjT0xQYoOMDDX+SUF3P2wO3lSs8eZiMTt9T/LN+0zf70gJ?=
 =?us-ascii?Q?+Sx0MRY0VjlWDTXzHY/bgcwR9iKEVMQoWValD89jGcBtPfeUbkpcFlQwpB7H?=
 =?us-ascii?Q?1608s/NOjAZcXY++kh9Wlcqw7Ep9rSaf/tWdM7OVg5Ehs/Fr+btu3Ok8AM0N?=
 =?us-ascii?Q?gPUcOmdlxIjwiY4/uSxPWqqIcBUCTDhjrMTZVd/5m8j0j3J6YYzfAZYnnxNM?=
 =?us-ascii?Q?V3+KLmNTAWCHSmoysymDqyRlNE5dSt8ERXTTS/nqLMqQLUsZNO4V7Rn1JfIw?=
 =?us-ascii?Q?ulwnmivHhj+nzRxTWNtIhLllCTvajaKQeDcXFp/zxpzqrt7gW4ZosziZSXSL?=
 =?us-ascii?Q?oRA1pRoBCMQ+EJKJcoRuXuhwK/HAeruOOOGeSfCOfLUJFvbm0osdfVBmtJmr?=
 =?us-ascii?Q?U/0WC+LpetHYWILclxjjTL8nU7oh6hhPP2Xgi/XOvLd5QqzEAG+Gx03QUqxb?=
 =?us-ascii?Q?VCNMOLJLvUTr6X8uB42Cp4mlCmoR0BJcpDoY6IU+c7/z4PYw3EkCSeEuiJMX?=
 =?us-ascii?Q?XT2QENRgAJJFtW6XNoUG7WAsOzjwf5z9YSHdrC52wVHUMs2G73kDZvsd3mKV?=
 =?us-ascii?Q?FRE8ymv23pd4LiFLzhz9EBqyDaoB7DVyzj/d8aGoj8fhY1z+hvvOWgoGKKRP?=
 =?us-ascii?Q?H98YHdvU/gapV5o50Uag9LuDogkbAa+eidmhVVGcei5MR51LKeGIURyhHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ATgidCHg5PmS2BG9KzuGLrVaMYWKft6Nttej2X2CX2tESbtzdUZTWMtSupt?=
 =?us-ascii?Q?kq7+4Mn4vXkaXc51Kv+UulVMcXQ4md4rRNtiq+zlDUdkTAZ/NV4XNYIg4BWe?=
 =?us-ascii?Q?nNhXaIOIs+laG80WR46ItSdBjhi0AT6V3o6tuMp09v+oYLmVGdkQsUlx2TuY?=
 =?us-ascii?Q?gF6WvPOWMnaDsgqigHScqt3Hmv2kIElHSQCy8NT/0qhTs45zsrmRZQIyozc7?=
 =?us-ascii?Q?Buy7JXPR0C9r5+gTBoitcFheJmcERbwFSXtDA6vj1SkTc8bxEWs2Eu/6ZY57?=
 =?us-ascii?Q?ls22iM3VqGHex+IuD/eMSlWMfK0Cjj3o19znzLLTmBfGUnGLZTGK9j0Ns18w?=
 =?us-ascii?Q?1ruQIl+cccny+tNnCU+b7H8HQs71En/LiwXbHG4tSudIFZ98qpqOJyzyYJOJ?=
 =?us-ascii?Q?h3Zdd6BaH1qYV56eECJBaTQNHfFDf/l9JqmfMHVVFpUThinXULd9CBTaIh7q?=
 =?us-ascii?Q?LTHhNJIeuKf3hZJ8zZX+Oc5RekvJW7pjD9Irs7v+D6GKwc8tnfDc6t9cU+ka?=
 =?us-ascii?Q?gPecRurSCTg8iQv2wvsl1NtTwTocv5pq+f+OEIqp+E2G3rODgBQduznyukC4?=
 =?us-ascii?Q?unxNPq60TFyFJBMQEjlEkTzgzLYb6ROGczX6tgTKrCpTz/z2Sa7Efmusewg6?=
 =?us-ascii?Q?DcdqM38bDB91UhP32WBXoxJDaLC6SC2GmtxhHa4hGwfPTHjHDegYslxgPIPK?=
 =?us-ascii?Q?XrEt6zS9MUTfA4GFuwc8NS1iBSNAdfFqHV8FIPVhycb6cF9dN1rF1toXAzG5?=
 =?us-ascii?Q?BUa7wXyGQySoflTiIQ9pPxTqohYucjd1qfPFeg9QypWdoakqG5xu6zdkRmD5?=
 =?us-ascii?Q?DVjSW1c3ofddHoUrOWl6iOeQ6ZHNzL8FM5LFyGZaMd3k5bySbp3SPqNLM3uF?=
 =?us-ascii?Q?x5uHQ6ORrk9lYZiT7KPsAIXZpnhvk4ao9xLukU5B6I2gkbb6H3Dxru/1koVN?=
 =?us-ascii?Q?YdtJuk+ahuLgykDBa9mx6w1raen78JvJzkJRBG/LXC5s0MYrK6n5Cs567rGh?=
 =?us-ascii?Q?3mHoe1nXC0DHDWCjKblVdZWVdgsMzR+SaYQIdNLOIdTJFzDU4znb3XdKr6/l?=
 =?us-ascii?Q?g5xb6Tj2SrdfDglWxaLB0OpOAalCrDlepECU5Smo2FLTAHOBcUpfDQjjvqZ9?=
 =?us-ascii?Q?4an1MF8oeUBt1+jJqxllHIfRES8w7dsrK2517lC/hq5zjJ0BW0ZVP4AGCIGQ?=
 =?us-ascii?Q?kIKktIWv0BTzEhUPuuan1bgN6Q0QAZSfDWQ9l3exS4iRbqDkZINYnrD6590y?=
 =?us-ascii?Q?FvcopchSxbGuMh7VFZeABsKq5QyR5gwQ5SvouWmZDXd3ViOG+6ZR2pFb0Tni?=
 =?us-ascii?Q?Amqmv3rGALLuudZPQ3XA2l6Q/ug/DKFGJQk1he5x6DJ9UceashjAtQHLb66R?=
 =?us-ascii?Q?SgqdzPN4g9Cmjpi8QI5vTWYu5cW7nm27Nh3RHgmjSJRh6OzIxoI22szGIjsk?=
 =?us-ascii?Q?HgbpXjg/58HehR4TNlsnlMDGvo5wQbC5uG3I9DdgeDAlWejr68j8QaQOL3K0?=
 =?us-ascii?Q?EaFJmxe0w9CSUopClyKEHLuggz+mdGSKgRhRZJ5jezCcp2u1o+VtIclPqljw?=
 =?us-ascii?Q?jiW52x0el18sPssuCIsKDd542FL+ScNjW59vNO5RtKDrIV6XFSzxiTIhub2B?=
 =?us-ascii?Q?q6UGcDCMorvQ3ND4S+Tgu+E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d14e1a-a75b-48a2-7617-08de07ad93e7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:02.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Thpu87wekALZqW8KI/xuZ4aw05eb8MMAHM2DSoSPnSk3/cFDaozm0jwSMuYyq1VfHeiSI1AyK6aThyJ2uiHtrKhDXsKtVw0P7lmEKWtPqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

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


