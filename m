Return-Path: <linux-spi+bounces-10546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A97EBCE5EA
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F6C19A728B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB8303A17;
	Fri, 10 Oct 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ABkGGwBP"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021121.outbound.protection.outlook.com [52.101.70.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40783302CDF;
	Fri, 10 Oct 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124079; cv=fail; b=DpIYFWvRdko2gnBxZw0xCrVy34agwSpGDhO+HkEZO40AY1ItuV9f/h+h+h6GXO16He1kuoPZLqisbaVd9AZxOKs7HNRDnu7m2TtQIPSGv4WcOqe6vsdvn4BnkAw4kCyvxmEKtjUZa8tNfn8GV5qRE0eX5SX8IDOATHmOhNExGjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124079; c=relaxed/simple;
	bh=KT5udailUHW2w2UDOUDfCnQxIsOgAP77HBVt40zMTmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=um6w/Z0vDwuPu+DVL+AwHBHVgUXpova49qsER309TrAaTh8bP6IJOMDhmIH9QdvoCGUPARtadSf3PJ/gPbdvLaAwAsLiGDYtqR/DLTJ4eyLNrGqkQp+kkIhiM5noOZH3Oe3g5BLroONkdlpsk+uFEzHYpsH7vY7coOLRAao+FBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ABkGGwBP; arc=fail smtp.client-ip=52.101.70.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzeB3H/oZXOJRVijYPoNBoS41hCDD6ST3ps3Q9+wCxiayId640E2h3XQYHsPJjrn8x5VUpW/Ukx7ea2NeBW0/D6JvzUs4pmfCSTKBIDXaWdLEnMYANJbdJyrZLwJ1A3yCzQfsV7AF/L/1KCNqC0/WukWEe/HD+U2usRNOW69wPNMLSBA/b/tMYB2sXdOvvy+DcJRxjOjF2+WblhlljdJ0Hly6JcucqvwHenMwjFCmgwq8PcWbU2aSC+l/tjyzNyEdHs2igkuo3dtEqawWUpOtuLootoe8pMAhKHPHg4EgmIigQScgLeK/LNxwR+9VztglyhvhC2CKsca+ExfMW8ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ36ANYsV+3/RELMf9tXZH+F27z/ACyzhr8QYtfvPes=;
 b=hie+9l7qgTdYG+rvevDZoRDAhCVRh1kd0NcjiBEQVbrZ7MSPC/eary6ZYBUeYAHoNrKzEF1mYPFwy7bdsDBAHivsO/0hdmOJqOUrjHrTTZIv/w3f92k58jHwlix+an96X0LraChMJH0JaAT8LV7IlRFLP7YT2AFCPARQzbKkjXst612tBbO505/A6+/emfkycIy1D57eaUk0aw7YrJQIhkhiSAC19qNvr2kIpVG5U1aaAyLNWw4TSZcGeD83dLe+2Wzn/yIP1DJTIaXBImo3MHOHHJJVFn9Y463f6obJh0cX+/A/fOr974x64ye669K7PwcdydR7Jd/jCX1cj1ykrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ36ANYsV+3/RELMf9tXZH+F27z/ACyzhr8QYtfvPes=;
 b=ABkGGwBP49Vub/PgnCpAFUtficH3dOfwaYQBdOr1bj33gTCG233FdUmd1mXJfnBj0z7Rk6QifXwTkDOuhvrv6VqYgINCYV6s8KV541BLw1l8qeEAMqOz3NAjP4PZyad7PFAu29MoMy9YE+7ARaYa+r7h+W+42RtTeSO7BtdfWXOh3c8B83Hhtr2l/gtO/ddlWmla2858QYyTaHNvZeoxSZQJ2sBsju2+BfpSU8CqTqylTZoSQM/appwHZG+i7WszqvBFyZrMllYLN/yEve6loargN/P8oyrLVFDvD/+xoPpqVXp10DpubLuUIN5/gp3gdYJfYXcdHpRxFEPqBRVBvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 14/15] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Fri, 10 Oct 2025 22:20:37 +0300
Message-ID: <20251010192038.1592889-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ab5fba-8d16-48f0-7d28-08de08322910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDPZRMbSAQKrKZVyYfYcv53CkcQ2t1f9Xm/UblLVwWdAzrfyGiDlzQtQ/trM?=
 =?us-ascii?Q?kSF5kxDAfkiulQoUAcg64gANOBHmHVQrzOYzTllvBuNRgwzTs2Lgem6vIF7+?=
 =?us-ascii?Q?4Wg6a/70xlrJEfTVuqtNY6Y7x0Ikpnoad2uPMGkaPU0DSQUBucB2kKoKumMk?=
 =?us-ascii?Q?n0gaTy8AkTOQK7BknEu85BvpwK2wazqs6xyD1YR5MUZCVWTzGPbO3X14G7G+?=
 =?us-ascii?Q?usoYJjO9TLrOptFXUmagKcyeh3AlrGLxfEtOV32H+BRy8kJEoH9EQvRAOT8C?=
 =?us-ascii?Q?2NfB3jzi2y4sB58i2UnaAksJ1/N1zkzlXTMl4n361Z+yJrGoOITYvLcOMTyv?=
 =?us-ascii?Q?la9W/vUjcwFGVHobOshGJJFWUgjnTQflNxZP3A9Mr2xNIKX2MhYoXl0YcXV/?=
 =?us-ascii?Q?iT9cNSmMRB1Px1eSSF+sieFddbQsIKSVCAgRVzzjkg35xBVYHgmy/1IlNx9o?=
 =?us-ascii?Q?HyG7LgUonpNQT1a4W6//F09ucHkcsCpe7yTJsONrBKcKISQUR8kXeuZbL4mV?=
 =?us-ascii?Q?vCdOtQI0jZztK+yaP1X6Ezfn+2uIo4CJapLALF7puYf27MbYUdavZ1ck5Uke?=
 =?us-ascii?Q?vt4Ex5hQ0IB3u7v/d/RpQW7wCIBSLLKvMRzT39K6yLLXNONY0T5Dkw/uvF5C?=
 =?us-ascii?Q?q/CoTn4CTzd3JAkpTqcBIkvDQ0p0IJWSur/wVsYIxQSDFDDtCfs4ZnY7Bjsv?=
 =?us-ascii?Q?cBRboaaBhAlkcIKN63eZbO73jutWMKAi/hFB/8E+O9KM9pgx6wFIBU7feF3G?=
 =?us-ascii?Q?PCACKPJK5p1savjJK1UhaUkSJjhLC/7cUuN78/zGrO+/NlH5k43MQCzc/4+u?=
 =?us-ascii?Q?FPZRjZE8BxMqwGJSJwIASjVPZAn8Stu/oFR+Bt0TfdchkTIscVwEqIZnc+kr?=
 =?us-ascii?Q?qQ1jTZkyBPee7KGsx4JbJ8EguP8584ROENt/P4iNkUrhjGkgokgs596iLGPA?=
 =?us-ascii?Q?T/qA0Xi7VJnX1rlqQafHaFh8V943s7RZ4wSthXTE0/9vdhycRBJ1M1hN3YIJ?=
 =?us-ascii?Q?GugUcI18/6TkdJ7EbaM7UrW5ub6jVI7yMkpByOx8wPIRx9tOv7zrjy8l1R4y?=
 =?us-ascii?Q?8wi+u3f3IK/USFwNhKxxMm0H1Km7hR1WqE+DzLMi/qLMzglPPxBGJGv9mSwb?=
 =?us-ascii?Q?OrPcYmayojFGI7xV31LX56aou4IEVR1J/+asmadcajQLz3besLJvUdXwlmgd?=
 =?us-ascii?Q?LpfRmSe/hBj8OuSxuPWLn6gnGBHiD5zvKugCEZPd83Tdv2CvPVPilochbRL0?=
 =?us-ascii?Q?XV55F0BQg62VCUxw+V4O/foRZu72Q1wHofqt2evtpTQidYGBfhXbROUtFj3u?=
 =?us-ascii?Q?1ag9lEeCgv5Ua7Ai0IIBAtT+44NDPozhxJoMCIsuWeq1sHPUY9TthVsu4qdx?=
 =?us-ascii?Q?WydczR45vmaK6KXQjm8fXdjAfNyKaFmK9RU71PZ/bbojSOvZPw3JPhhAYaz6?=
 =?us-ascii?Q?Bz+YQWN/31uTYeGuZhKxM5DyM4K9yPEUUd4DvsyDRvGqSjHKWNdlSdBBMyxS?=
 =?us-ascii?Q?84s0pI/FDv0UWL02n004k8E9IODRSeBVoOu6EYUysNEJ4VGV5RvO43Whdw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWsy69BsJT/oz3n1QryprfY2Na9n2snnkcvdpF4Cu+nmeZoLigxZfl7goH9L?=
 =?us-ascii?Q?RBV8NxGgYjcZvf+G6R8nh/3bVGgT9/VB7822x2RUBSETERwujP7IlHXG7DGV?=
 =?us-ascii?Q?qOKFH9+9LjW0eVbiQimGJIEFs+dbvEk1TRfP6BWoHvawxjoHcd6DMtpnc5h5?=
 =?us-ascii?Q?M6DA/2EbksKo8u2qNe34FEtvLVgeslNGH3T/h/TUOjKeUR3OAa0iVE63rJUu?=
 =?us-ascii?Q?xs1sy2JbI05l9t7pHLcd0fo9Tp1KhyDqTEbnjbiV8orJ2cQyoMkxp1NUQsF7?=
 =?us-ascii?Q?vsQtkcTobQinFXVGsvfq2odU2RDunmfYMuG4yGlEzBbkBl7hVGIxtCEIMCOi?=
 =?us-ascii?Q?1lnZC07atUFTQYJwyxsKSnV27walVe6AyxwnlTDS/rjVZCJiFsOGjsx4FBfU?=
 =?us-ascii?Q?lOrMKO5aZVWMbg/816yG2XxLbRhEJIgWBetr8JzBy3cV2tsCllfL3l7GRn3t?=
 =?us-ascii?Q?P6nCyd8syQ5PXGuPyfwcZ7suDBVEtt62R2tQnKZWpq1YiVkcOkc9PJwHgEY1?=
 =?us-ascii?Q?dfIg+frBoyZWyzMKtNn9Y9l4PD4xjKB7sAkX6Ik7mxB38l8JogBayLqyndzT?=
 =?us-ascii?Q?ZD/u4bNpsWfom/lsuyVmjyiX3tg/TSrOTZw9pgf9+NdiM+auVxM/ecdjfXmL?=
 =?us-ascii?Q?mcC4WNs02FHnGQuo3LaCK7onkkZieYsj1L/44LWB2bTU4WuNuC7x/5FyJlQH?=
 =?us-ascii?Q?zzUpBlp0yvYlPEf03rfW7CGN0gbCwha5xPKBPjQc4ZQZkJR1TNo0/boenNXR?=
 =?us-ascii?Q?CN3YcTk95am7/CIkWV1FoOfl0FMXfgLgymB7MUmT0lH7COojMtAURtsJmgXp?=
 =?us-ascii?Q?aHTMQCfT5/PhPGZ3M8mtGjRIlv6tzN7PA19fl/EWK6XD1S/PElHe/hWGk1Gh?=
 =?us-ascii?Q?gxC2MhrtHbrM0xvLbedXqfs2uH0012PSGPLPBLihsffb1R/IVf5MpGCXHjIv?=
 =?us-ascii?Q?qIBWStIQtelkAP/qYyI/2TIwL3ZsLySobxuMwQP1Vl+39plXkQM4Mte8thoA?=
 =?us-ascii?Q?zMk48ldmVudjIeBvc+ITos2FtSsLbPnN9pTb2uLY54IkYU8uXLFZjmdwEAWN?=
 =?us-ascii?Q?YbOZP9bfbDnUDqIskZIeCp3g5cU24E5x5YDzX9ICRv3R7KA42UbkAQchTZAt?=
 =?us-ascii?Q?VpNBlGeKystxD/ojDXC81LjgE4lCB4FvMFcUjLt5M7oeXG0QCH9tO+Eohq4S?=
 =?us-ascii?Q?sYBu+gENV7CVpCmLITPGDdk8XH+6YVal4ljK3gxCJOUdM/2VO553eM6Gx5eO?=
 =?us-ascii?Q?sZBQj/KVLC1hD62W+A8m4tivUpaG+Uq2+s8bB2GZ3OXOcu40cJQ4VX3LmSiH?=
 =?us-ascii?Q?gSlf/beMaCvL3Axx6WWB/MPsAwAoYy+QZjaCEsmX3qJN4k3MIQNuArHdQ1Uh?=
 =?us-ascii?Q?E1wg9BjWb2jXD5Viz+hIQl+dv8ZLCjD3mFT/htrZsdv1j7FSbb1VkaZVQR29?=
 =?us-ascii?Q?OzQ8AbPFAjsf04Q84TTWvJTiR5IgeoUPRZuOhjXXydfcS0BZiY/6yHNS5Jov?=
 =?us-ascii?Q?Q8nW8zwiGOpvH/G1pvXjaxXiwSpnBFKBnEs5gS7IFqbycvryejvEOxSQWnyt?=
 =?us-ascii?Q?5DQ0O8DqwkyTjWi4ahrD30wP1mTaeF1HJxhW1oqB/M8GPfZfCkwfCkHvG41E?=
 =?us-ascii?Q?XkEUPA0NhLds3sJi3IzvbSs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ab5fba-8d16-48f0-7d28-08de08322910
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:06.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVJU4VewELkCx38vKAinOBzcIgg4t8xz+JSs0ueF4bw7XlFTsV1m/jsRHWZxxbmHNL/a5lHcD+PDlkPzTY2bmCrohNeqxTIjyjbpkncVt08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 ++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..945f31a81876 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1058,7 +1063,10 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	void __iomem *base;
-	int err;
+	int err, dma_enabled;
+#if defined(CONFIG_ARM)
+	u32 sfc_strap;
+#endif
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
 	if (!ctrl)
@@ -1092,12 +1100,36 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
-	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+	dma_enabled = 1;
+#if defined(CONFIG_ARM)
+	err = regmap_read(as_ctrl->regmap_ctrl,
+			  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
 	if (err)
 		return err;
 
+	if (!(sfc_strap & 0x04)) {
+		dma_enabled = 0;
+		printk(KERN_WARNING "\n"
+			"=== WARNING ======================================================\n"
+			"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+			"This mode is known for incorrect DMA reading of some flashes.\n"
+			"Usage of DMA for flash operations will be disabled to prevent data\n"
+			"damage. Unplug your serial console and power cycle the board\n"
+			"to boot with full performance.\n"
+			"==================================================================\n\n");
+	}
+#endif
+
+	if (dma_enabled) {
+		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
+
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enabled ?
+				&airoha_snand_mem_ops :
+				&airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


