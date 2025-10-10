Return-Path: <linux-spi+bounces-10509-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC15BCB88E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C084422796
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8C279DAD;
	Fri, 10 Oct 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="fdQCZVpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79D275B15;
	Fri, 10 Oct 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067130; cv=fail; b=C7oSaicL+RccWZkOLTKIt3Hkwgso7kqOMSwpEaMs9RRRXzRi9qc9LuItTgQc29Ai2YnIaU8gOMW1Wp1nGTVn5haUZIed6XlF337YKX+I/N6xs81edoqnJDtWqwbeQDrXXQ1zcT3b/LHEcVtq1+7DyISPA1AXQjOQiftIAa3h3SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067130; c=relaxed/simple;
	bh=yls5E1AQJW8UjaQIdkFn4PFMkKchlzz5HVhY0hyRl2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHzbGUcqSTv8KvDOU7fVdc+AyXdQ/J5fV4UhbbSWxdLqMLLaG7U8Fknh4Zt3CfGDTTs4QH4gZGbH1Vc/wW4cH9r0kueNG8XZVacEQEMTtPbySZ5C00c1kvAvAmYen9kqDdl7BMf9pdqfZP4sjOAaMzDpUHC9KjA29Cmc2QFbX/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=fdQCZVpH; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcxPz0mosOluHasLeNSTdZ/9WPLgRsXEWmV/ApVmZ6Su18yHEbLAlKj/ilA5FeOFUjSstpEzYhcxoOol/cT1RFBAoc4fo1UfANndZgEcAnsnGPSLIRCE5FFWKSPm3Yatakl07WoK262ejbTrVQHORMmv1B/URyHeR8TQooA9foTPaP/ICL781oM2SjY2NgSJxvrkJPnTGCMmgH0bNcJkUhRYVtB1GHnSIeudM2p1i5mpDiDvR7mwe9WOVA2o6j05PeRypxkc2O0Tefw/TJMBNQrgkppU35SKVxHk7Oxof9HjHzdkc20Heo0MLtAfaylMhLReiQjKvB+3fgTBCHIXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=hdy8pwzxeomiznWMgMIIZZSvaXDQu4T3COF+7RAsOk2af5Z1RxyU6Lr5y8so/xt2GnyHrZC0YMfDBlpUnljukJvmAucwC8RLGMHC4RjtzNTVzGiQsIZ8rQ1M9bWJdApmzFrnuo0qH5kyjgmEJ9AwMI5uCOkTHzI6SIl1Q2CmEXucKIKpclLlCoJx7pkArZK/V4KqFDD5VlO6wNnrGQ0lWOqYPusw47WlUHTz1ruCB5sBmaHYLxueQzm3waefQ5OHF+uPSxQ1xaYkK2gniPHFkUOS+FnYRg5qJhrJPBMOEuPG5yvBj5mj7bGdm47Fc/izYSgpS01cKm8spVrKqeBoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=fdQCZVpHSo+6/rfUWatHHei9NLtTvK/ngdCnKwtX68ov44XhYE7o6AdyZxTr5HqLDP/z86WyJp2VK7ATxbcZDB3aNQigDIQ5wz+t33xLCXhKt3bQOpKPyR3V0h7Wt5PMsFZwge8qQR1KuQDiw/wHEGQUkgN/ZTPLWkgcP8ERbdQxA8wJhfju1U+E5HDidQqGUFyeW0AYcCgFIfZaik/l8P9pcPIv28UGsGJg51bv02GY1zw81uml1vH8gNWinGtRrw905OTgtI6weAdKrY0PojoVuz90qKgOgdz2KFp2WJR5bgXor8VjWuH1hT1FZIdCYwR+Yfm9kajX70FAoQ0GMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:58 +0000
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
Subject: [PATCH v7 08/17] spi: airoha: support of dualio/quadio flash reading commands
Date: Fri, 10 Oct 2025 06:31:27 +0300
Message-ID: <20251010033136.1475673-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 18a0e718-c7c2-4587-dd82-08de07ad911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJ+PBhSoJ106wOUHjv6M3EoqxE7tVUuTCiO/wnORLwwCtUO2v1JpdpCEWP81?=
 =?us-ascii?Q?4/XD4Vhc2J4R5Vx5DRrO7pwu+lOPBp+fFA/iULRr8C370KAlvyoeXh2ColBc?=
 =?us-ascii?Q?0DnERglXL/HuxziBl37vmVNCtYry0mXT3zSww/gYl1+SjpEh/d5aP/YwgWGd?=
 =?us-ascii?Q?iFpK4LMx2zfke+u+xS3UM1MEbuYApw5bMJr1OXaFr2s44d60HuBdsBicAZ1S?=
 =?us-ascii?Q?b+Z/So81httTsFIamoZFoVhJmWGmg9UVZl3rRZOHk0qZ3CFUVOjBCfq+GOzt?=
 =?us-ascii?Q?dXwrNprFmURIBV3EByNYlcC/mFuaKvNVOVB1xy59pYPUWQXr3oAwtk4KAkDD?=
 =?us-ascii?Q?zysRP5TzuZvcv8ErLWZ02g17+1N2zBjx0M9V36lgOvsJHO3LlI6MM0QtPcDu?=
 =?us-ascii?Q?MbV69M6TvGM5bSGnCgfjwbeXIXVrERPEciEIffXR4yEsUS6ayK2+p+HujWUk?=
 =?us-ascii?Q?z2SvyvbWRM4dxhDHEZcg7ybhJ6ykJ06Atf0Jbvye87DB63GjzMWxfid3+4J+?=
 =?us-ascii?Q?9T3BxH4vKqVBWpE7W2xVyR1/6DF0K0eBa5szMK5d0pC/yvvZeYb8nnTYHGhh?=
 =?us-ascii?Q?S17Ifi7M1X9Eh+0Aon0OyWFXq/i2qsdtn/Tqyat6c9LnyMaQWEzAET1k+DpS?=
 =?us-ascii?Q?8EFk8uUh9sMkGcTDRDMqulLV4zFB3dwgjqL2yKG/AueAitxVju7XaWVrewDE?=
 =?us-ascii?Q?cv6VxvceqObZvhOrQfNWPWwOh+TWqngeQ2SITjd6z6YmFLyJNKPEf23n95N9?=
 =?us-ascii?Q?5iqfJaWbAITG4dlYbfevOXp57iDPIXBAi7EcS6cg3ziNHpR9sjlWwrusmpPl?=
 =?us-ascii?Q?K6S8dcTICfiQeiIjn6G3dwzbg1zMmlSx9R5xHKXa6YLAsQxjV22nQte4y+YL?=
 =?us-ascii?Q?cZeJJAeiTibxRNB2tyaTOq52PJd3jNWeRffr2tgxp6TdMO5w+GpFjHRp8NE4?=
 =?us-ascii?Q?8WSZ8A+GxKZPXpU1ZZoW7EZZxJb8Ju6+s0+xhnLuijz4ZuzIy/dTtakig1YN?=
 =?us-ascii?Q?41J/1wNifN3GIDxEYSFYSfZwhH59hjRTZ5cXcvvUeNp3GRDF42x8K4TG4hbo?=
 =?us-ascii?Q?TyzfvtbN3mNTOqnDg4RstmESqt7nkPoDhVR+0z2/oxdPsOsynTRh5QG8fDPq?=
 =?us-ascii?Q?Ro9Tc/fXfWojPLJZWoUlCniKaq3YFh6rT6y0wugP9Ext2zpfcXUgQ/J0C7wt?=
 =?us-ascii?Q?CHcxlxyO/0g+hPuTGZ41zHhJ1jFNGsPPj3Kue5qW9jRBhrgMG+qQzBpq3+Yv?=
 =?us-ascii?Q?NeTPoduKOyETihqkuajI8Cghu9xoPgX8WGNWOh2i+C4s0PJUaBjn10tGntu+?=
 =?us-ascii?Q?vo3mO+4Beszn7Q++/5nrjZdt5X+tgMj97kCYjqEHK33ZxwWuaNt5QZgbO+Jn?=
 =?us-ascii?Q?LKb9gz3+zbogeooOqP1HCkejIRLMm3zC+G0Ib84PcZiTZgNCepUvYXq6OknV?=
 =?us-ascii?Q?pN9UkB6K7z9xfiB3XB4zHKw/lI7yyWcExJaVq2P5oUT++NjSSdLK3Q1b/A1j?=
 =?us-ascii?Q?K6VcyLjLJu2jPMLOvvAXDSansKJeC4mZoDGCJxfjrgk3BSUETchCD1N4KQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWyrQWWS6OcbQygU0WqgoUsXiA8GbTSj7+dMszFLD9gqvyl0tJ0NSsKaGEzc?=
 =?us-ascii?Q?OwlzxhpiZiMq9UFGH15KiH3itUVUjl71lGdhAoR7gkpBJysSR46hMZ+xUzJ6?=
 =?us-ascii?Q?6VGNzuWUMw5k8By9GyBycL+yRbK5xmjLCUKXSV2YaZwMVze/0T2/W74/qUor?=
 =?us-ascii?Q?pZLN3PzDwhrYryU6htKOyRUizlfo/Q2v+VKQ0TsLuIHEV4hpQ7MdgGPbdOVa?=
 =?us-ascii?Q?5a6lw+gyYNsSBgfkZ3Mwm5Ex55ZvbUMErgJyFC85uyPqO7WRGeMXy5ixStco?=
 =?us-ascii?Q?GCpwG3ZJgXSZ3r/4VlWBpRDAq9EFY4Pb+VY4QmK11Fuke3qf8+RkXV4JwBh5?=
 =?us-ascii?Q?nf6buZhTFiMWKbmj5UmrUClQvUH6s6xn9XHlrGK6LWa8VgFIki8B1rYObTw5?=
 =?us-ascii?Q?wKb2dXQbqj8Z1r/ruaahvJoGGJKZbSmoBsRlohJzJtwOcTW1cWrLa8bapETW?=
 =?us-ascii?Q?de6gV5SXxTNpEIbX2BZuixmGog6kYsW9z7s6BwMN7WogccUrGUjOWnsx0lND?=
 =?us-ascii?Q?/L3ZGYNaVqf6popJIp62kTa+YhK8YB7CjNiiuKZRWl+ytBub4MouaOYBX6sA?=
 =?us-ascii?Q?2d29R+m8BHBiApUeuJ86OC042yWYBNczfKd/kGGpI7bbnZgFsbum07XMnBGk?=
 =?us-ascii?Q?ifhzQoHeuV0p3+M7GIRlRBbRNncZDB+lpPgvELv3g5yMRagngw0sG8bvILAp?=
 =?us-ascii?Q?BuwMXo7VMuc/tjgwaO3aNFNOWFtNqH5do5ipTdd6X36DrB8YTIFY25VxSlfg?=
 =?us-ascii?Q?kqLUPD1zwvGFs1vRz0UMUzydqYTalzubiKKBzo8B/P/KCt/bHGgshflb7Uz1?=
 =?us-ascii?Q?uUfbR8YUs+5jIAyWQFf6aBv8t3mD+WiIilx6+1r0XtQkS8EYnlBhKVlqZEyw?=
 =?us-ascii?Q?aJ3TMptN30kuPs9X3SpHveHF5gIueBvNVBjsqxlTWSnu+FLgO7z7Jrh/I0X/?=
 =?us-ascii?Q?nw2dzhyid1WI0HanVgwqvjMiF4scEu08qSAbc/mb+OkYB68tvkigsquPc4bl?=
 =?us-ascii?Q?PaAV6aZAnORxOlXkkwJ8VrwQDjZ9GgoZrYtjVseYcXIrW46nSgWzjOxnaess?=
 =?us-ascii?Q?9bEhy9h70Y2Jv8rneiqBpLiQyWVtOnrL8Y93W1uAFG4a5TbvDyyqIFjwmLjY?=
 =?us-ascii?Q?PVPD2nfbs2qPz+pp5waYZy0dXU2ux3OSSsHRq33QhlPXkIq5AvAAuWWVAl8O?=
 =?us-ascii?Q?vFFstCXoVsPn4VupLqRpMYG4mELXSsvnhAJlmaGf1PRuzz1ie3SZehb1LXy6?=
 =?us-ascii?Q?TF1If1BpfRDJqJBm5nqPWCi1yR3CjI2v9DlYxV3NIe82Hn1hnSq3rJaA7+oA?=
 =?us-ascii?Q?IX/6aYbuTMp9G/JOMj/LOZLfaF7RJ2fQmdJK8NHVQJ5X6LsqhMJPiXb3Iivk?=
 =?us-ascii?Q?yRaaftqD1HrLV7bEaA9gJxZfOEBl57tlaoh3cb7w4u+4De7owwfGaBPNASO4?=
 =?us-ascii?Q?8fNAQoA31qZwXWbcZQ/GbcEuYsM8i6KSgau/Dd1Yjbo+1dLGKyC2bknQGGPx?=
 =?us-ascii?Q?oWkaDNUi/UdQPjau6TJywmf9DcxuNOa8vr00/qjQwdxvFRNJLYFfqlRVEsN7?=
 =?us-ascii?Q?Whh0SCJhBQM8zt+1lzKRNbv1I+5RqhDwsEFALxhs2ps7YLYgI9eFZu4PBhK7?=
 =?us-ascii?Q?IwYuYnc+KhJ69BVytFQ3Tvw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a0e718-c7c2-4587-dd82-08de07ad911b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:58.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kou0XwGP8nHJNrPlxCbABeadFr0zGJyol0LLEf6OCIEtdFmfWos15tIfY/hBh1pm2RJUtecTgCIWnxIuUIK1dbwmCKO7w45v4Wq5GBL/Z9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

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


