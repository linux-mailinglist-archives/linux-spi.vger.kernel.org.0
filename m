Return-Path: <linux-spi+bounces-10558-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAEBCE868
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69BFD4EEBDD
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9874303A1C;
	Fri, 10 Oct 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="tJOOtgz0"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B2302772;
	Fri, 10 Oct 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129130; cv=fail; b=N66yWl4VrVuHOx/5HFdXmGbJZSaT9qQVDDB2pJC3d8YrhXasbAhfS6Rb65zU5igz5dhU5lFT+Pa0AFGfMnZBNTm0gXXFPQ9bgKg9q8I0++bck1WlAQ4zkcd7F3khccG8lPCHpReBEkkPbjQSEcmjv3rrs8z0vKeU71l4Ooj/6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129130; c=relaxed/simple;
	bh=yls5E1AQJW8UjaQIdkFn4PFMkKchlzz5HVhY0hyRl2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNT5W/i877kbqt6839rmG13gLw49+frUIZYnZmVZjKWDEr7q/Xfu7c55IElLxe0plDzyVmzK+YtvPN2FYSMEbi0PKdClLAKlZslIiEVC+nncBE3Fkut2ub2N3WEw7ocEWiFwPjvGaiGf/1NvdzDR0h3RHtPY6suFeHhpUI5sqMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=tJOOtgz0; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZKz2vVee2p5JiKgCDr91uo1Dgtx00zDJNQoxnX272aWmpXJM4Esjg7AA0aa74l7vsgG/ZBIzTjZkvcrQwYuPVhKE0Md8jYD1EXtgFI6z6xzIlErg2iBW7gHSja8IDuMLogf9YUlyGLH/w6Plo/KMRubmZko/x9qOnKvqPuWV7PIOcGmsub77YGOA9OmNWoZ4D5dy+CMc53Q276f1vYSO+rECMbs8B13S7K3saTFMsDqZ5k3C2qPMy7mRFm58uNdNuFiyvQ0TAVfGVhETjRHsRNF7I6BuWzEtaBbQx72ZsxtcC1sGQqrbFNDxWYRnp8WDtX1cT0g4GfE9/Jt06OXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=ywTlGoov+P+GMUZQFFOjK0rmzPnuSlF2CYPJQFIpEORVFQFrJe2sbcaSOmOLB0B1QPiuvEN0KJd5gu8wrxYYbHcQ34uW2ym3pH1v0kaJJuFg/QT4jBQvZpmCB6MT4e09agVdNVoabaxfsajyV3Y/0vF9KzpXb25YMYTkChgDbdCG78N3IzC3PimWil+DY7cHRwpDL40x3tzi+PepJwUJ0LRQ4yy+93Z2VtlMq4qYne2Ro/O7Q6kdtNGCM0+/sM4X5Cfpr6Fcma6/ShBMCAnnl5LgY9CDIknLA2KoHmD9saQ8TB+0vKViBPdlr8z/qDM9+d7wkh6822SfjvrkJ2KByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=tJOOtgz0KaZ9hiVNDkqlW1uO0y/V1N2yrsf6g75Y0NNDvbKJAYkVDWkCw87QXBlBnRhUgFeLW9nYAoRbMw51wz6Cz0AH+UKcWGljhtrG0KBYeVnVitwMVzfq5uDEWtenB7wSRd47s/AvGbu10telnb7l3uO4z20fLd7CEjRKHbrJOai8F13YG3aiXtKc4sQmk16cyxYkkDLWFsS+cafcyWVhXwT2A6uJtuex8B0l2sg5Qy6ctPGCGh767HG/mKrQ39ZhIjf9EabTZ5fYrl26ZKBB64FGHHHaO1vBTTCHoSZygfqMpl7VO+q6s/XDRQkOT0WhZcGlwQhLX99IzftJkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:20 +0000
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
Subject: [PATCH v9 08/15] spi: airoha: support of dualio/quadio flash reading commands
Date: Fri, 10 Oct 2025 23:44:53 +0300
Message-ID: <20251010204500.1625215-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1608db-98de-44b3-372c-08de083ded78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbLXPNSpesW+rlB0KcEkpA/qDhhw174wDtXjOsoXJxkTnONRTCtfjwhUaxbw?=
 =?us-ascii?Q?QUdBgQJhkQuSssFk4NiQQIkilzKeT2ctTLa1bhmOD4/QWWipOYLB8cLoE+G3?=
 =?us-ascii?Q?bcBq0V1pi4XExeS+9XBZkStRZ9IKKTC7epUjX1TTH9avLwqD+bZ5KLCyWggi?=
 =?us-ascii?Q?4XRCTvkg3+9GrfAji6WVYlUZ7MbEO41jTEgqvI7v+tUuPQXXaGoddQsKW4Rh?=
 =?us-ascii?Q?n9qCGfVYfiIsjYcaQkHYD0tLKGSAUGvDFum7RbDVIDmU6NVjmiwUszZK4t6C?=
 =?us-ascii?Q?u0kJvmj+w6g2A3uqZt3gk9GaqU9wdESVr8a3QV2sXByGHeT0n+PwuUO/8ZRe?=
 =?us-ascii?Q?UmYjG1T8gfvtRRWpbJbdq9jI47H7xLNTlmsNK0m1FaLPL9yzGgBccjtcUVuY?=
 =?us-ascii?Q?AHe6Em9paZ9QlZZQBYGjTSqNRit58ONgdl6IJxJCukjbg1H94e7Ewmr225t+?=
 =?us-ascii?Q?sxGwS8y/gGTuLU/BASGlyX0OCx1V2NYywerL6WviR2Ni1KPVxoLB0aB8rEM2?=
 =?us-ascii?Q?c/b9L22aiOPzc32murhGcaAwRGG9gF8VSkMnJ4TNNLqCDJ0EAWSzM4+449xH?=
 =?us-ascii?Q?jx2gQIYr0nuo/BLMgl9FtJy5nnaZHMsycEvh8Ho7pvfhbQChT3n0qL7JFA2G?=
 =?us-ascii?Q?w8SjS9gnj1piNG2ccoSv24orrDgq69ilzHA6SN+S09CTfzUUBc+rk2syPVzX?=
 =?us-ascii?Q?+XGeAVTuHLy1KvmsH1GQ8n6/iC/Rg2a2RELLnH2OPN5cpm97eq0rFO6UxuqQ?=
 =?us-ascii?Q?GxDKx2kJgdxvsSNlaGIrnnJKAO6hMSilBP6iSrMU89O6XYEMvlRbiPlZ6o3N?=
 =?us-ascii?Q?CtEDjBISpy2M4IQ1tSfhIV1GgwvBbt2wYaDSmX0FcFPfhCz2YI0gtkEx/k3H?=
 =?us-ascii?Q?94SwuzTEjR3rJuzXtiN4MYeyqyQYJTLFFYCOAN9IREG9qqAYPwzSB4Jg3sbx?=
 =?us-ascii?Q?LCtZxWRJy5RbmsQupGMA2gYDf+rPBUQc9ONExk7LDQ0SjOMyj2UiYiOvxRMW?=
 =?us-ascii?Q?k48Yyx01n8HzDnWA2GZD6KU7rr8h3p3AFgQZxwZ1WZU/+6bAXg4djzHJEgzr?=
 =?us-ascii?Q?ZAt89lSuZ4qVQV0Z1ylGWV1t7G01kJo0HfsaQjlcgyDaY3s/YpaXuFWTta5J?=
 =?us-ascii?Q?vD+9BHyW89eSlZitVmY3tXk3fLabAW6QhfdgP2qtQcMsS5P1DrRlqONiQii6?=
 =?us-ascii?Q?neTIKRd82l9/TRZt2sU/f4PBsUjO6W6rMk5QJ6eT76L0nBUStA/5BuWrtpKg?=
 =?us-ascii?Q?ZoFjSXY/n68wWdVodngDM4baPANSfPOSRgX0u23PS2sjaPt4yp2FHv7Grqs/?=
 =?us-ascii?Q?4Qo6DYm/b6ebxYOv79M0jTMD2MJl4nvrjKNxl5bhhoyGR5g5H07iosGJRAmW?=
 =?us-ascii?Q?Ic2ZukqQjHimJSvshXmGkMDRTjoHTT1mfEZigestavPInTMtVsUMY7Ugslat?=
 =?us-ascii?Q?Ny3B6Xb5UWQDFHYS/+Tjuj5qbNQuiDCwR247lwbjX6PSTexpr/fztaFKr1QN?=
 =?us-ascii?Q?+d85GjwnRhDKHxXC7LpIPp3otGiaR2vqCoxvggRpQOJyS6Qc4HBoh+H0Dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5ZcFPHvSgiGf71gBfVMN+0l94OsYpsEXirfufp9yRcYxFOGevYC9Y+t0qt8?=
 =?us-ascii?Q?OdrlSsaiDOzQZzzMb07bw3fW6hhGJzOe/HpKikmpSRmM30DkhY/qLro5T6z6?=
 =?us-ascii?Q?oz/7NdJ4YlIfQRTq49OkY4MIpn0kKJWHewSNU6aFnMI7pac8vWdzV+C6Auh6?=
 =?us-ascii?Q?V2Zuggp5oKVoMc2fDlNFjePBAtX8X5Pk3WG/m7c6vZWZKpfJrcP3ebXGJ3pL?=
 =?us-ascii?Q?UpsoQyQ6x4IyLWyOLvZkdBfySFOg8+mPMmilicSxv9oo7rZt5Dj+6W2d0sbt?=
 =?us-ascii?Q?i/USx2TRzd9teu+dlX7M23unV83UXzwzOh8cYn5CogjibVg8vXX0SCt/FZTi?=
 =?us-ascii?Q?Uu83Xfh2K2Mti7NP2ogYA+qO0hV+KBCL556S6ARg72ZltK682hXOP9rFJEOG?=
 =?us-ascii?Q?uIPGC8Y7NPCpaKybkQs8jykCLwKCN9lX5Z5eppS+KmHk9m0CY5EZJ07Fntlf?=
 =?us-ascii?Q?M2YcZuqEqFdtEDQwOaN8CPRj6eQZ2kAjES05q+DO+bixWT3ATgNjApPj1AmE?=
 =?us-ascii?Q?304FqOFGT0JZTMhkIgILBzUFO1RQCLpEBjTumP96suMakQEKXk30ZvYW7fDQ?=
 =?us-ascii?Q?CU4JitkTEZ7kTzYPSRLK0YQB2KkpBN+jkYc/5vQv2DzWPG12iDY8mrzEUJJq?=
 =?us-ascii?Q?ohNUPV90ICYFKJKu42yoTUXLQEnTH9a/id1gZv4uqrcQOuJEU8z0ve54D7qY?=
 =?us-ascii?Q?/AYklRK/ssQQhV7W3M5mrkX7dukYdIMVZk8Fg01nKIH1ijZj3U2Sqyhgi+YI?=
 =?us-ascii?Q?hsvQlJYecjPpHGRuW15ItpdXq6epS1lJFAmF48UdIW80kxDscHSs9g1CZLHN?=
 =?us-ascii?Q?ZD1cInIfP/sLN8n7HY0fWbcf5fP6DjUzUF1h8UIAiJyqwteBzJWVcs+HADlh?=
 =?us-ascii?Q?gOjCMesHwHG8dJe+kovqfQEaY/8LFsR8KTf6+kVFjPGSqQwTGQiriCkwav+q?=
 =?us-ascii?Q?afl4ysnXtoNvribCJK9xzBdCfdBy8Q/B3jhGr2VHfkVf5vQTAHlOlt/3ax85?=
 =?us-ascii?Q?cvzFw8G8wHKVP1eleS7TIBQCYfs4G+W8tnWaxXjijO9zeaOOJtWiNH5Oe5SX?=
 =?us-ascii?Q?WsH85tsQ08Sou88Hnlw0x9A9IWrf2CUXJjlJoSEln8cGA0yZNl8nyWiO6+CT?=
 =?us-ascii?Q?wAdRIUfBWc8Qm8ftLEMQnrbdZdCSNBtVrq4ZvPCzkyHf79dXm858ZsynK6x3?=
 =?us-ascii?Q?F8VrMZGHPUIWjyX8m5aXqQ398kPM6dgQSrVGuz8C9tJAcGa1Y4+vdJcC8epK?=
 =?us-ascii?Q?A8BI1ESbSJ0/a1enqq7hgDesiTrHl5fIlvBGVsTMQO6lrJXwRtpWBYJDBjh7?=
 =?us-ascii?Q?7OASyB1V0An8LZXi9PEwhYTpVwqFhMM1xKx1qM19+eP1JxC6N6hHyJ5K3Bwc?=
 =?us-ascii?Q?nrA5cJvX1THTZzHOCenQcpMC+bzJUrfoyADWwq7/mN02uKHZoyQzWEMifQhh?=
 =?us-ascii?Q?ifAyo2r5ixINeOXuTVrgI5kRT3cUKjI8vijb5G3QQDeJV1SwriVcH4kH6Zt0?=
 =?us-ascii?Q?rJI1TOu6UwZ+uBkaHL6NMKYkonPbdrBUO7WEb8Cimz3nzz4lJO2bcgNhWV++?=
 =?us-ascii?Q?TKKRloU9cWu0WF/GZ4k6At4+fdKXXwKTQzecAutPzocOnUF/KsMVzvj68nCP?=
 =?us-ascii?Q?Vc/WF2dAJtRShOMuz4ah7fo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1608db-98de-44b3-372c-08de083ded78
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:20.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1HBxjMX+NI7jw40m82QU58qNAYnEUOPwaiZ/+qAgyQ/kVmJlNvLZorF1fSt0o4ei1Jr3oXFmrG86Gi17v4ME8RNunet12doIuIsFruBq4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e90fab69d81e..744eeb2b24ef 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


