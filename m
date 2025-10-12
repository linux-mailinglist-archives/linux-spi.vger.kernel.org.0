Return-Path: <linux-spi+bounces-10578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9BDBD01D9
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFFB3B418E
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3927511F;
	Sun, 12 Oct 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="IAtmvP7R"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98866274B58;
	Sun, 12 Oct 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271450; cv=fail; b=rMYJtdru+FjDGxGhPxJUWJ4khSxCJX7ziCVZ69E2nQHy+WS2qNQ6YfSZRck8Dv148xiZZukI70u161RK3pLCn0IobrXHjtofEBhuxdJE6hBon0ethAEEYzMxpES/ceA6Qoo658oeK64+294CuvFhGpJ6UW9+y8LjQ4YGSWkmV4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271450; c=relaxed/simple;
	bh=4vEupTlFblAxVYLWw8wNiQeHRVE4Pd1f1C8AoyYUpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7yNG8tEucT5RUn3RHSCU6E5UVSmSVuCACxXXjvt46zVZ14tM7RBFi5VksGF9Co0uk38WcqirslOByhSAUVqLZntOgH7DVFSkq7AisdYOU6Ao/pFXXzYzqTmJ8SJrDIiIyd+fdUFgYKsNicLZe8Z9X9Gns4s+F+Stk6GNmDOanc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=IAtmvP7R; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbzDYmqUTtK6BWIFJ7Qm6rZYqtZu7RujKdkNUqPULUwuN1U2gICRzDS+2S8OnBfBqxk0g1qzvLnAkHSEOgNnitIU/guaFDd/ecRibPSZU+rkBG57PtioMteLj5bfHzyCE73QfqPUEqqq4bE1lQCzzMVkApsKeYdOIIXzUom3UV3GY/DmpY8pJqIkzWN7A63TOryKIDGjUVdegt48MtgNNC/Getn5SWprngJ/J7NOcEayWCopP9q22TTLWkd28LPMWMppKeOM3I9/ghbu0QCbNdlIONo23KRe6e6suKumurTRUvcxA9tB/LPfa0OrzH0iTVblfQxitr/CvpqXrKswPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=K/9rUxpSRKjcNCiqjJkaIaVv3u/bScF7qRz+I93ORz34iJDSOZtT95e9nFNy2Yf1cRvrAja1QoUeXLAQwBkss2AXtvD2TzUgiwf3SdFnCVAyMX6DJyfBDkRwqTzNe6OqQCvKiyX+/x80/KH3NJRsqGzsfyT2gkaneV7GWXzy712AAPv2Y2duKrjKJpfRCJw2lj+nYJ13y74urUD6NXUOEirKqjur+me6uzq3GKAFeEK02wJaUuOtw6Kw6IrBKBXGwL40uGqjAxwjLmiI2TtC/mYNdjxdAgpQJ+LF30YZ50iM09yw0WmmL+bMgxAq3/OCcZfJIN9eoLpWStics0DT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=IAtmvP7RNyPHRTg1r0SPQb0jxLAGfnFjodKoHI/KiS8fZ8828Vhhp3MBOl/ke+V/h3A21g+lKuttYZIUHLzmI3N+wN2xnmYK8WXEDeaetR8yIFBtYHnTVHljT/zbIP6V68JLw+fXHceYCzXngToKbMl+A5t2GVnpgDJV9Sd86ps9vKlt3FGm9vCtxBjkXzqTwZymIU8VbKl4+fQrVSZRsMaQIePgPDCkP6wVcuwZuhKnvcJrYjIfDXCwak95iSOx5FonEmEUzDB4TFHZgw3Bh5vAV/j5uE8RuZmlRax1c9IPEMicsvw3oZuGuRIEuok5BDjn8LHA/GaBRBE5J8HsKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:22 +0000
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
Subject: [PATCH v10 03/16] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Sun, 12 Oct 2025 15:16:54 +0300
Message-ID: <20251012121707.2296160-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db36259-18e1-4e15-ec69-08de09894bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sVGp/WlIPJmMmz23iU1jxMl1V9VplF8Hdudose0l3tJfT7NqrFJL7QAqslp?=
 =?us-ascii?Q?+jE/ORv3Oo2UEEj/71thhP7Q9yVI9X8HxE/st9yEH395FNc77j0N6mf/RZLd?=
 =?us-ascii?Q?gTnWvvB7THGKJMTwXhENYRDi8Y2ENztNO6n7xQUkv709eVaxw2bGPmVAdh+u?=
 =?us-ascii?Q?rsF4EszE2o6vgm6oWuRY+F0FrZKSoZ8Hzqn+FeJYU+VhZDT4HExxes7j5awz?=
 =?us-ascii?Q?Sg+//m5qXI2/HZHFf7TXkHZG7+cBn551HGE52WEXC1jfWaX7UAh81lYhFxce?=
 =?us-ascii?Q?R+NA8cW3YE1LM0/pyFwcdv33GmAFS6oe/ANr7TtUoiDkNmQPL82869JP/i53?=
 =?us-ascii?Q?/Xb2148wFnbPXsQzElRMHegGDmWKBrwoL1H0/js0Rtg+yQmxOW41wyA8RnCT?=
 =?us-ascii?Q?4MCyy2Gy+7k+OKRA52/CfStyESUqj66p85IO2AsfkcI0FfC7JhiMwv2TjRe7?=
 =?us-ascii?Q?oeaw+CNjXITGuDichFdKk5t5UHCtmCGJNzZoeHlzCvRuS+8E6rnAyxh4MGIU?=
 =?us-ascii?Q?3elGHXuh4AFE4A9Y77jmNg2sc+dnKwFwhOb6hZjXc7oZyDXFeKXaFwChTWPP?=
 =?us-ascii?Q?9ZRmGg5R+FQHGWVq5eXR2vSgDlAhffeYUPgaj8NtjC+vMFHzFLKmJlecoXOo?=
 =?us-ascii?Q?/yprciUhMO8lLtSpF5o6SRaUe9ZGGTdpjtppqmeC7lBEf5AVuJnF9njT+tgH?=
 =?us-ascii?Q?aKxTUel5PiR/Y4MTpi/dIANuyqr8oMkTrevjdL5R9mczROzxNcOQ5egc7Lln?=
 =?us-ascii?Q?VgsfU2KLBTx+YGbZ70UV/w1CK+0CfJH/pwXdqrApi95of+mCtcKGY97f7iHC?=
 =?us-ascii?Q?1v7l+3c5owqRvU0oFaSg2PQlitQI5uYp78KJ3KMvbd+v7Qu0W6LNkQaD5W0N?=
 =?us-ascii?Q?G00e/+1m9v33q3WJwrTBhLb1nsJ/4y5zWzUkoSM+yHbTlCS9pT1wyEMRsub2?=
 =?us-ascii?Q?G3MLWPBRkrxziCmexVyUL22D2q54vMRAzbmMMhBWX/YqXXV5zi2pvsmyLA3m?=
 =?us-ascii?Q?5zwhg8old+foa91zm0YwfcOSuIx70s+hO0siXdaX2YOLAoBVa596adm3w42O?=
 =?us-ascii?Q?9BjqLl5jCTuLxhv7qUvx0FbDC8AbT8DZIaEsWYIhqXXRH+0nIaFMUiN7ugSv?=
 =?us-ascii?Q?hbr4v2kVUx2i48LGwIAlSlnS6TliT9iNYtOpPnkLc01Hs1n6BP0wcaROrF2U?=
 =?us-ascii?Q?tUI1Nel75pipsHeESRBk8si7oFQY3vNIojUI08V6fHyZEAE6HUIDySLFjg+y?=
 =?us-ascii?Q?cq4VdW29wAfKnrP5AVoRV5Y5zDB3qfXbEfuRG1az5ATe+1RAskJVL2jjV6Sx?=
 =?us-ascii?Q?eWR6x0zPceikdm6MTs2ZUYa+libgA1qWFIZT+nO3kan3lu/oR7NLPgTJPWGw?=
 =?us-ascii?Q?YI6jD6qhIgKVaftD8HU0JhOTPdSr3uPlnJKU037J5fr9VZSH1gce8cIWzfRe?=
 =?us-ascii?Q?RoY0Xctkzc02V4Ee5g3WW5CXvSk/0lfQmZSIdo1+0IhL1hTr/4TSK9Xa+vye?=
 =?us-ascii?Q?Cg/eOOEeWSJSZ8rHYQOHf/U/WVVG6PiuwJsu/jqN1WSxk+/uvIjpLN0m3g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBuAbe1jYGLRGpych8kLPddBs+2U0M+GK4EW+VfXp5RqedbKBADyFHtTbB9I?=
 =?us-ascii?Q?oCdfSzt9fwIH9fCxmtd4Y1LWEoQ1u8vsfnJzlUlI/Hf9phyQ/qEjrHg6u4M6?=
 =?us-ascii?Q?c9cz9O4CaMfuE0635ICSxHfpH72GQL9NJugKAB/mu75rzKOVH2E7NcFdjpsS?=
 =?us-ascii?Q?Bt8f1Ly4BQwYKAX3SoNNvQKrClUeUSAu44Ysk0o3vAwuVfm+ijccyGPv49ua?=
 =?us-ascii?Q?KT0ROJt3QxOL6ABQ3mYQOIp6zaqlnS8zdO3Dgpj5GrMFy9Ivs9BWMNEy/SPN?=
 =?us-ascii?Q?oVmu4MFULAC4ow50T/XSArYPJMhoJDxK75RPsKvI26Qqyq8wKqO3MqAg7sGs?=
 =?us-ascii?Q?X476t0lqGv9CFu6tS3im0phIJ4ne+Q7bD1R0E3L4+I1r1OgUdITIr6DW2+X4?=
 =?us-ascii?Q?Rzy+W71oNWQBuAWCFluN0KTx4DwUzpj5Y67SVfjLEqKS5fRkgZpCBSOET2Ar?=
 =?us-ascii?Q?J/1JVRrl8XiUxA8FO04YvTl9vMe7zdUA8FVv7KFSJGvUsEPMO38mG8YZ2dy1?=
 =?us-ascii?Q?ug1AtSz1G5E6qEKBDwsnsrVjfc7tj4mnLJvfkQ++9C7Bi1hc8U01+pB/gJFp?=
 =?us-ascii?Q?O6jyPcFSD9no6lL2WIitNcR1spcMs6lRJI9xYXytz2wJKyq/JnnlJfIzB2yD?=
 =?us-ascii?Q?x1Xb3+c514YiDejGQ8umVU1OXob32h+8kUjgIVuv6L6Li+BgXV0oblGhTrGR?=
 =?us-ascii?Q?Cn92u+/XInnQb9J514b3cUM8mDbTAPMiEAVCjLct32yx76y1+aLsi62ptTrZ?=
 =?us-ascii?Q?8g4eELgzdxwdYMbRXAXs2MZFB/LiaYHSg4ZyoURts6faHhZHh+s6rWFStTeI?=
 =?us-ascii?Q?Do16MukvACgagWrOWfWRnJZ6i5wDI3zc54qIJjH52GPeq9eVY9YoXBeqCka1?=
 =?us-ascii?Q?JVH6uy1Vau/TrPUPuEX+mAKcOzBWKs4/VKcxaRne2bBLPt+xjtdHoI78ghxQ?=
 =?us-ascii?Q?kBaHxJkN2hNj99QjIEGGcYpi2OZlR6oK4LAJvPFdf23rXEOd0MQGhZ9BIbqI?=
 =?us-ascii?Q?BtN2o6R8hkWBr+4Z0QVUE5cTPAzAoAnrol2dhRWsHNSmYNGZAI6PUpPjSrww?=
 =?us-ascii?Q?oAmmgiH34ZEQb/WZGh7bH4oZB3RUBNDoNdSUgTU4iqGCexJkIVZ1VITlpqj7?=
 =?us-ascii?Q?LvdIWY8Ov3PiPT4bSHq94N5qkKgnYD+mq5AtLgRgu7cTsa3EykTq4mz7fhd5?=
 =?us-ascii?Q?v77Ehm5bAgd60rDA6utqeazmABFp5cLbdt0GUFR43EklQDjLTMsUu1mStKDA?=
 =?us-ascii?Q?n/nGoXRQOgoklE2SFsUB4PatzdVqBeVsa93GmlDFhgdkjZhKsrLEgHZfMnkq?=
 =?us-ascii?Q?a8Adolh9IOlM4E7ebKytv7oFElLpn4DlibzyIzhap0vdbjRfkaziosVNMMfV?=
 =?us-ascii?Q?PYAYJyRTRA+Emir2YfYgny2Tt7zew9F3i5d47s+v5rPa4QRC3NK2BETrAlo0?=
 =?us-ascii?Q?uPBHgZttr4vA8W2zW9QD2sXfg66AtEPQFwlt4DiU8qq37tYp6YxQ0otSZstW?=
 =?us-ascii?Q?0O3rXwxAD8wWhrDB+bzS3HTFnMFvJGLwOPdM5llfUw/AwoOcSUfmlGB3bxjY?=
 =?us-ascii?Q?GDlLzxnDqjFp48RC32H64IGpCxZDdJzNRGezLZS3UzGpBiQ5PPKxoQNHFCMj?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db36259-18e1-4e15-ec69-08de09894bdc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:22.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGLOqhwPBpB9QyhHnmvXGlzP0giYfZbjt4O6N73RE4x4ctc1KwKH2g7Ft5NPuH2OAqUjC5psuEXFfuYNPTzwk4vjBAnCKYyKf3IEP0rN3jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 108 ++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..fffed26ff990 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -895,12 +935,28 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -911,40 +967,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0


