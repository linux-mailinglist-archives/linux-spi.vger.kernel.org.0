Return-Path: <linux-spi+bounces-7578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F701A8914B
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E72C16B3E5
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148C78F2D;
	Tue, 15 Apr 2025 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YJuY3bgU"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5FF9DA;
	Tue, 15 Apr 2025 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680811; cv=fail; b=Ct/mVDvvAI/dOuct/8kzumY26DZBNCxzYPILoS8bgE11Kt0Z0bppv2IhQCjhsIH6mrR9l4hSl4tSm65hQjY/qoWOAuKis//uC0AB4FGoLdIVONWvwjzZssbspeQJTgEYFpPqoezDwbnm+ZiQp6ip0X8qkfj1JH9j7tzKWq/3hKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680811; c=relaxed/simple;
	bh=by1mKWs2I2PK1LMkF3/yEZ7518234hyTf3BYc8/ueNI=;
	h=Message-ID:From:Subject:To:Cc:Content-Type:Date:MIME-Version; b=ET0AFArl056NhYpK+U6h/w4fPBBhncWLNXc2oaSMyegWNfmtOJWsVcHRUFQmbS+YRFvWLYPfXMyNt8PCHufsvbgqsDqet+3/1qaFOIY3Kmznap/fvMtiwHmJ/6a6tuE2KKfezCdb9bD51YSCSXFep6SNUkHvRh8vqHk/3Jy/wVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YJuY3bgU; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTRINTQZq6A2DQk35IsBGbXbOXW/mWQpvU70PZxOhx0JFa0C3gzPbpUhi6pfY6MtoYEn6OtdhxGceu0Nhf8wjj8tMRSX7Qr3b2DkhRzOxxG0MrTYhKERxf+19CIK39f8qnRR1xaFuP7HryFkLXLxd8fAmp+rKRKX3McKkVtm6bJrQjv/0cYE/Bipsz3rnO/rxoD6jV2scd8/serb7Nhtj40yBDrd8iAxmWVWsUhqiLE0kwhGAN4+MJCPW1FpJ1dRSzfwTowpvk3PIWlaxXwhbR6vEJDYFTX+im1BHMEhnQjgivN5Tw1DwhI0XV8jiwhX6ms5BKpIL00WYdlK6LBlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5xsC8iTiQ1OVouFDk4kusESfUMU5cSf9eY0/6dEltU=;
 b=wr+0A6SDPvHxTO1zro3BN+V2e57NTojEx5b3WedEGcA70whMiGR4G3BzAM9uA2MFu+xe9dewAmJQuMpjh/nnDKaE/zZpIdl7YWQtD1Woki6Sn9CxMem8AYJat8fuuRxNsWNlzVAIME9UyRbN7R2TC2hL4t6V6Ae6ZOknY/ifAAs2Sd8s8kp/THyq6JQnO62QOv3GQQCx3EWgcapYpgfxono2x0VkExJ2aWliGxss0UWqnSGZ7B0QKFYHwNtg17PrJyzzvDYO5r8tewvnep/6m5qorc5CtLfFKwaoCaLjZJl48chSaJjmmH4+PdTsuqS78qDnQ5ttEcwUKRHjTZeHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5xsC8iTiQ1OVouFDk4kusESfUMU5cSf9eY0/6dEltU=;
 b=YJuY3bgUsb6/sWVAWTblamdcbgZ0Zv2QFC/c9VBvQPefOwg6HkfysTz9yUgOIwmeO7MBhB4pczziw813vdfoo7zmC5RWQ30lJdEc69QUzFCFDNvk87N8tyKaCqnsICh5YS7FAQdWBiTpA5Rm6XuqNsKPHeUwqqpFAgKvllrmrcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:33:22 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:33:22 +0000
Message-ID: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 00/10] ASoC: add Renesas MSIOF sound driver
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:33:21 +0000
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3289bfe9-0141-4d5c-6fbb-08dd7bbd821a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/GlP31ZpMv6BIRrZC+i7ATzDKrssEhrO00B9K5V3ISFM+ou6PADBqgsYRCNe?=
 =?us-ascii?Q?52JDaFELVEJeBiBTsLmD4v5rkzZ/Tj3eBQRoimNqgf6iEbU6UYs14tpEuK2T?=
 =?us-ascii?Q?bNGT1rwYYx/9L95x/vHkHAooCxOogtrDj3rwfAwWKTwpabDqD+oR93fH+435?=
 =?us-ascii?Q?ABZlgkgBZK9zj5+mOeBpkmpOvjAbFmNf8QE5HvvotpYfvev2FHehu+ufn2E6?=
 =?us-ascii?Q?3R4UXZDvJlBzO9oKxxAgD2bxX7783AF5Cewsw1tccTcEHzDpd/Zca5jUOOsc?=
 =?us-ascii?Q?5eN4NRU5Vt+PJYKgb4LgaqNLpnnlbQaHm09mXUPGSfw0OqZuLYdEAr/Le2ZW?=
 =?us-ascii?Q?9GYE6nD5da9diCP8BW/U6SB5t5Sw0Gfqi+oIPOn5Kj/jxNV1cnl4MifANdjB?=
 =?us-ascii?Q?YqetezYz9ymBZ2yeAZhibhERuCFTDuDAncmhidrUdBM181N6cNcZvT5XNW7Q?=
 =?us-ascii?Q?yvMv1LXGf2JXFD5MiyhQYQSzvh80EXWq1eoWITjCpYP/okfJIRt9Wr7OHTSn?=
 =?us-ascii?Q?Arn16Wr5OKlFIEuA4Xy3a5t+uVz6HMbaXyCt/2SWjd6uoEHy0FGKAPG5nhuF?=
 =?us-ascii?Q?ccf+aeSmIfmkZ6kHJ9A7RztlU53TsaQ15QX4n1umydUsRVicKtjEozNu87kB?=
 =?us-ascii?Q?0alvA50uyd1Qv1iBk2B2259AAWeNO4Wx4SRJRm/hvyvQudQv60HXh/TGOmsS?=
 =?us-ascii?Q?5uAdR6WFmXZNVmGavopQRWSvKNqnmt9bEVizPVTHzZPUnp4eDpK6Fux+Fm/w?=
 =?us-ascii?Q?7m6okIDD4OcXDVb3/LCRmS2y0s36Z112CBXv7Lxp55zzbgIB1Goy4oZP5AZ5?=
 =?us-ascii?Q?9Y7u12j2ZsdbvG2/SWUbbAqSRIe68JAVNQ8WNYoOBqvb8P8SFeiQ3ijMPZ0I?=
 =?us-ascii?Q?Z72gRwRtM8G9kssHtmN4cFzUpshRtP/amvOhT7rYv30AR/O/0VG6LoL6ZLYK?=
 =?us-ascii?Q?hlvVcCnfIhIp9cIrgRYijYTlQXcX4KWL0Bpethy8e9qlC1PgGuscQRVAU7FP?=
 =?us-ascii?Q?taE2BAUFkFaFVVvcYaox1oRvppj3zmBo+kbLI09K8B6Yoan1/sag5KnJjUVR?=
 =?us-ascii?Q?7kyc5/R3gpYa1Beubz/QI/6KMPduUtYea4MQdzO6M1TPDZG7fRm7saYagd6g?=
 =?us-ascii?Q?AWr51zblE/Ywc13hUP5TTjb21M0i33eITHg+mHiG10mYRSQQ5d6K3u0Y1c0m?=
 =?us-ascii?Q?ZMfzfIpnFrVev/kZQJWEWZ/NxBetobtHym6R4hFhwKD2UI+N3FzdACYUNM7l?=
 =?us-ascii?Q?rXnVPwdgcRb2X1Ibo8WqJIibeVKZrkNfx+B1e5ChKEiBBFssrkogChGjfsuV?=
 =?us-ascii?Q?J017nVyXrtCYtBhYo63TWqjLBmQc3PV4JOPyKfB2xdP7Uq8JMdi7I+dtta+s?=
 =?us-ascii?Q?a6YB0iyhk3GkYOpXkub3pJ+vwVLqhNByLMy552qEfUugbZ88W2RWHLr9DPNJ?=
 =?us-ascii?Q?62irOe+ZFzDv6/rKr6LbFSbrhajOA9EZ5lxgefQk6+V1n5BVDgiteKWN5GgA?=
 =?us-ascii?Q?9hL8GyD4bKGQoTJHw8TMyZpaUvvNHLgB1N/G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYf3kkmch3UIF9ohXIoJN6/vyIM/hewPoqDwvRzq2pQ/0j4mrA2+fpHcfYLd?=
 =?us-ascii?Q?JzOosnnP04HoZklflHRTvtRD7+Kb1Qmtp5/tAP9U+nREN2JEHrsxeyepDJ/W?=
 =?us-ascii?Q?wGO6JanUKDGRTTQokV/XJmndDME1QVyYlAvpDJvNBH2gZ4bk6LDQ0inXH46R?=
 =?us-ascii?Q?tAizq+oBXU/RfZVUFuu5L66PT1X1GWDOP8fPcxB/rJtLqalLSfLXE6pOjpNw?=
 =?us-ascii?Q?ozxjOWIDcjdlXHMOwQWe9jpEEj6f8GBY99L2hQM5Cr8fH0Q2rRERRe1fenRV?=
 =?us-ascii?Q?N0G25OqCF4YDBOiR7Z1ujSBfidbNFqNB5ooebNp8m1s3kfUvYU/1sqPd+q1p?=
 =?us-ascii?Q?DcVwIJPF4ueCX+EV3ndzU2G3dksU+gM4Hq9I6YoAKuGycl02J6iIocw2uNfz?=
 =?us-ascii?Q?/6Cx0sE4jesmRMvNdPvVL5GoFvQgY81Fx00OHhka8CZoScjENaV96k950IRW?=
 =?us-ascii?Q?BoLoqKW9ScjrleZuZNiFxkaq/g59+QSw4Ru7bqukahx1hH5Mlocnx6LLvlH9?=
 =?us-ascii?Q?RIlpNAzlvyQsAhzvKROvZRqr9xfrjk4m90rh2+lcOyPY22Q/4BPh05IomIqY?=
 =?us-ascii?Q?NljsWsWdwIxmpPJTIYP75xcnBVlgHBqlFwDYiDgULaBir3tm+GfXLdFDtDTb?=
 =?us-ascii?Q?G8/0zAfMQ9fCLngjLUljoG/RljyF5UigKiiasWD3zomqUyVNa9nQtw/W+qUy?=
 =?us-ascii?Q?0da5U65aThCxcz1oj3ByBCX2whtWJpTwsP1VtiQX3GRL2dDrXA8wwvVfZfPM?=
 =?us-ascii?Q?lGfh01KeLRKYYYP3ar94kk1q5LMWzFSoM2c0Niwvu4unnoKVrfZOw2YcaaCb?=
 =?us-ascii?Q?wL87owPGadyEtwT93Y1sGQ4nQv04DrFxVBbuVsKP+5d/yUhUtq9RVcEhmOR+?=
 =?us-ascii?Q?OomItwGUghLPVwYnCTzgp0t3/pixbdvoqRNwIYtDsR5vqHG4HU/vA+kITUc3?=
 =?us-ascii?Q?rpOsZoTK5GWSWQHSDvWkooxC9Jnh+QorxuqHzCGrNY0/NxkMefODTcO8UrVV?=
 =?us-ascii?Q?nbAkKYIVhQoQRcO0ZPZl/ZI2Rn49BtHLBzK9Qo2g0xp7oXGbLaH/wXKwk9Vp?=
 =?us-ascii?Q?jBEqJs0FmsnGgmJJfbVEU2fr5jfZeW+wWv61Wa4MZhvYmPz8tA2h9rHVPzQ6?=
 =?us-ascii?Q?3N9nOVxAfwTWrIZKkO1lM0+yfUCNjj4Ye+qE/c0HdPIYwvW/8SccsB19IKzS?=
 =?us-ascii?Q?k4X1LtEhqYJrewlHOorMT/Mh0YUsZ0cvtEARDMy5B0shX5bomwn25IySH0b7?=
 =?us-ascii?Q?zbs8VK+HlItxlM4ppb9kLYGZ/GGE0LI+KUGrNJ3mXJOoQqL+hGnVLuaqcu5E?=
 =?us-ascii?Q?pwO+BrUxgKEmB7qQPJ2ZMed+Iv5AfnrR6nfYl5JI3zHESreEBHdFK63QtShI?=
 =?us-ascii?Q?PqqA7PWHOfLiIWe94vHttGYkBHZt3nGoDxwAFI+KGoiUaMZu2uuxxh2VRILN?=
 =?us-ascii?Q?wFHXR2Ij5cMYSFZuErjt/CGu5Eh3QovUholzYa1Rg7BlQdv7YCX74XOo2odb?=
 =?us-ascii?Q?B1Nu8PC12k1FiryiDsNEdyKcD0otvRGiSlcyuDWbUPDvXHzYZ7d+7l+2tsP2?=
 =?us-ascii?Q?vW/EDy/cwg9mLFyCCUImjK9D6b+blRR5WIBuTemo8siSlnIgaG5DWIC01vVR?=
 =?us-ascii?Q?UY6uJV7iuFVjyrAiPk7aXbs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3289bfe9-0141-4d5c-6fbb-08dd7bbd821a
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:33:21.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83CXPv+bMCm0mQj+/VsUNqWVCeuCwDWfIc9/QV+/OXLTgFBWJLB7G+QT0HBkNq8og01RRFYeSqxmjBwax5q3wSSVoFBB2nMEBPMO+NwBml/gQyPTqHfg7P7+/rCcLDmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536


Hi Mark, Rob, Krzysztof
Cc Geert

Renesas MSIOF can work as both SPI and I2S.
Current Linux supports MSIOF-SPI. This patch-set adds new MSIOF-I2S.

Because it is using same HW-IP, we want to share same compatible for both
MSIOF-SPI/I2S case. MSIOF-I2S (Sound) will use Audio-Graph-Card/Card2 which
uses Of-Graph, but  MSIOF-SPI is not use Of-Graph.
So, this patch-set assumes it was used as MSIOF-I2S if DT is using Of-Graph,
otherwise, it is MSIOF-SPI (This assumption will works if SPI *never*
use Of-Graph in the future).

Link: https://lore.kernel.org/r/87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com
Link: https://lore.kernel.org/r/875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com

v2 -> v3
	- Tidyup MSIOF dt-bindings schema ([1/10])
	- Add SPI tidyup patch ([02/10])
	- Tidyup git-log comment ([04/10)
	- Tidyup ADG handling ([05/10])
	- Tidyup typo ([07/10])
	- Add Reviewed-by ([10/10])

v1 -> v2
	- Merge I2S DT bindings into SPI DT
	- add "dt-bindings: " in Subject ([1/9])
	- use dev instead of pdev->dev ([2/9])
	- use __free() ([3/9])
	- Add Geert's Reviewed-by ([3/9])
	- Tidyup top NOTE ([6/9])
	- Remove unused defines ([6/9])
	- remove "probed" ([6/9])
	- remove MODULE_ALIAS([6/9])
	- rename "spi" to "serial-engine" ([7/9])
	- add MSIOF on defconfig ([9/9])


Kuninori Morimoto (10):
  dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
  spi: sh-msiof: use dev in sh_msiof_spi_probe()
  spi: sh-msiof: ignore driver probing if it was MSIOF Sound
  ASoC: renesas: rsnd: allow to use ADG as standalone
  ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
  ASoC: renesas: rsnd: enable to use "adg" clock
  ASoC: renesas: add MSIOF sound support
  arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
  arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
  arm64: defconfig: add Renesas MSIOF sound support

 .../bindings/spi/renesas,sh-msiof.yaml        |  43 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  12 +-
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     |  98 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/spi/spi-sh-msiof.c                    |  42 +-
 sound/soc/renesas/Kconfig                     |   7 +
 sound/soc/renesas/rcar/Makefile               |   3 +
 sound/soc/renesas/rcar/adg.c                  |  32 +-
 sound/soc/renesas/rcar/core.c                 |   7 +-
 sound/soc/renesas/rcar/msiof.c                | 566 ++++++++++++++++++
 10 files changed, 766 insertions(+), 45 deletions(-)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

-- 
2.43.0


