Return-Path: <linux-spi+bounces-10512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AFBCB8A9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA4422EBC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7927F00F;
	Fri, 10 Oct 2025 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="3wlzytRY"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E226F297;
	Fri, 10 Oct 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067135; cv=fail; b=ECIpTQVtv/s+qerfOv877wIbhqRmGXw0U6pbN+RH+G1JoTX8J7W9JiBOzxBapbq75+iJLw/tO/z+96+VrNFfIx6e1o2uQALec75HG1ngFkA9vkg3lrsDs9JOdWUVYMEQIcqjcx43HmqmpmQ3JFX6+iNpcBGjfB8H3NT7B7y7ImI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067135; c=relaxed/simple;
	bh=zXs1zjwe73k8NBFsZyuBC+GPa3XlTDJdYKLifu+UCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNadH/SZpFcUO16c3EDouRK4Xq1TMPKwmZfpSQQjo+e/4CT3kwCDxMOgBFXUYJPCi65FRQkbUTkvvkg5qEqi4j7sBrNdDqSmoyMlESAkvtxNg6ew3RSoDKkFHaxdpY/bqKvDfwS6FPupE1YAdW8GIc7PxRvL608OUohKXtOqvQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=3wlzytRY; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW0/KziX3d0MpI66eBPqTwu96HRGg98JioVt8STgL9YoYei6MnD+f5cpKfze4Lz0XYSVOm3aDJrwrcTSmdugRp7XXVT6dpwRGokh+Nsgwj7qQpJGBf3llRyn+vpnHyqRBSzAW2paBB+tZDQghZQHXEumY18bht61oLJNDao+OkcWfE9vd0+gwWjQk2I/RxVAocGSDbH/5sgo4+9oLntuXkmhEiUhEzo8PetZKSb5wcTJvwIR4Jq3+gs4eH+iEZLrnRYIZjUuQRUFgleUmH8xfRIRRYxuWkM/zW/YiYiAIwaGXW4bN7uFhr9cb5+s8GiQttULUEQiFEKkbcsLPXavsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=mvQG6NAfZH2XTPKEOvzJhnBcfF2/O5HBnSul4Od4baiCEXY4F19+j9XgoVtI4bA6XrPZdBOwj69qcc2gNQF5gD5U2wZuTeLSY2BgxRDZxlnO3nVslPYBotzYjIPsQhem1hzdC7j6VseS7MBH/WCk8mW+nB0PQ+5R7oXmSaKiSjfOpUD90z0FpNYeNtHOVDw9qET868fWRfdiTSYHNwLj01P+LyPgh0IoGJjnusi6k/rBm+vOBfemBz9gncqmQt0E2+cULikW466b97p2nVXnzkgItOlPA8mj3+PlZyBV19Jd5oiWJqbqfUAOOO/yUHxXvk89somh025LOkgGfDkzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YfP1CniJwGInA2vQ6HDM3aMcUELcqgKMynfNA1KCUs=;
 b=3wlzytRY54JUm/Im2O5IEUZAjWQZSJHD5QmWqjrPhHU+LLRN+mIBX3jMOPuNYK3BDlm0wLUVbPM1cilzufxbh0UPS3NGNcRbbeehQLkYSUdew/K1BhRJyzh1skA1TgxQdD+ah0zM9q64nfJ49H4aEvJ1LAx5Xl7vIM+yl6soS6qBNCbGW+9Hr+rB+PO09skT7+inwwTy7Fj0vhrvG0B4K7gg8IGGqX+RjQfyTd84urjDsq+d3HurJikJjHzhbZRHi3dcOZM4rQDQeHJ3Xlw/mYOvbGWBhEi2z3J7uzz7sxyl/WDaESuWtX+2bJCXYSQe6ANLcj7DWcWqIbaJfQIrVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:05 +0000
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
Subject: [PATCH v7 13/17] spi: airoha: buffer must be 0xff-ed before writing
Date: Fri, 10 Oct 2025 06:31:32 +0300
Message-ID: <20251010033136.1475673-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 75d57038-1eae-4dd3-53f2-08de07ad95b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Lahv7OdJLLiKGx3/sPjwaYc84x8q1VeWWBXsmZyEs0VkTWUFCYl1xU7Lfot?=
 =?us-ascii?Q?OKGrN+fGaMzgEe5lRYDL3qf7jzlyv51Pwk7Ov2K4BO5J0e/6Q7qb7pKWakGd?=
 =?us-ascii?Q?Ok978DQhAX86h70DLpawL2D82hZaJlYgxKH7sUnRFFHO/EvhehnC21cG5/hn?=
 =?us-ascii?Q?f/oib0je/cMShiWK8iboEUF38qLbdEJKopxD7xbawnE0QGTaAHX0wH/rHWpk?=
 =?us-ascii?Q?zldhnsAT7zSyOtglvgfYG/IW+CILr+DXTJnQs47ibRqaHtH69ObkNNP5rOnt?=
 =?us-ascii?Q?qCgQtF/ALWuQLyeaPFK5VUVjdiYBAl/g9op0SHqjzq0v5AU2/UGr3o6yQcUh?=
 =?us-ascii?Q?L6EeUG5E2mRoDMg6Gm4s994WzvYUyXmCfvQ1HT19Aegf6Xs+ONEkAQJIpm7f?=
 =?us-ascii?Q?OWYrP5OlQC+LA+nkgBg7lgIlpZC8MDSEU8ZEA74mJLrUD0cXeJZWl/rofrRf?=
 =?us-ascii?Q?DWIcdAmjXuwefznwQBcYZccoefcEaIRYjb8br0i/HcOijYO0OVGeRIzuaGJH?=
 =?us-ascii?Q?ZOLR7/YSets2gdJa3BOdDJ6WwlbkPhV7gLTGKh/m1Gbcx3bZEUTb8UPzwy+X?=
 =?us-ascii?Q?QhBn1RflhlzKd/kVuxjjfcDS14xE++5SvFqvSem43PJ6shYPoht2EnygZA4B?=
 =?us-ascii?Q?NLnnGcdFeL97cIWMIAsC4+/ToKGfi+EiV7Q5dhWS8gAYcwTgmCj+wMLL4YkA?=
 =?us-ascii?Q?U3h94OUhQ5Xzt2XelF04z6UpHK5rP0pX3W+y0o74j/u3wyzS5vaYnQXVx3Gu?=
 =?us-ascii?Q?PHnCt/ckf+wFFbsil52opwQFdJmIEyxAs49yh5pmxDvfLsr94721pVO+bAPF?=
 =?us-ascii?Q?EVIAVxDgbrAE+J45mA4iq+a8Ci6+e9D0toPnKocn0WcRqgPnW1jQh4/Im+vs?=
 =?us-ascii?Q?NKwz3EQy9WDwwTtoc0h6YgNDk0e21K5pWJ/WdHu5W8wMTMmXDd0hBh1VEcRF?=
 =?us-ascii?Q?aYR/FBWpJ3+JwGkUuXtybBxWs8XYFl/g9AKXJAxei/sq2/hQ0ymE34FfQuKn?=
 =?us-ascii?Q?KX44jlsp71jr/4kGJKTnQoB+S6ThMv4cFyL8OgHzb/OYEyM/xL+4b5/iZhmE?=
 =?us-ascii?Q?t0W4WOO26E8ynzXHDXd0sUbSKuKMP/irgkuOebVcdbX6DlqUyvyUshQc/2w3?=
 =?us-ascii?Q?L4C42jk6vV+AatF7HZch0R7eKaFTjNBXnx46/JQNOboyTJWYdC09/51mctZ+?=
 =?us-ascii?Q?po7nudUB4oGB9g5BaKfxxtBO5PTvriK0ncbhC9O6EkNBBSRH3p439XMBMhGO?=
 =?us-ascii?Q?K1o1cK1LZA53IM77m7iuZVErGD+/sVn231KZqDqZrTwVnYSiED3u8s+LjUTE?=
 =?us-ascii?Q?PbCTriNnH18Yq49JsSlUeXQ+qHT9qtNLWkhpYZh8VTgMiJt9P+fK9jLy/Gys?=
 =?us-ascii?Q?lYJpxW/gEy3S4TASZ/Edtei1QHm4w2Y8rhHPw0OBoh8awa5xStMbXSkBccXE?=
 =?us-ascii?Q?MxXP/HahI8B+gHClXpvxe5rJupEBIiEs3XVV/h2t4lqmkJFW2ooOsXWV9riD?=
 =?us-ascii?Q?3yeA/CRwjwBUUrX43/l5hpGkN2PxH2CX3FNUGkv9LG1WVpfaLIwvk3qVTw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4Wq6aOyvZuQO7fKBjNAvNBwqiqSU84wNu+AqSWOLsYE8ZWb7IrKwZAm6vjC?=
 =?us-ascii?Q?S6DXxB8FrToSErdQEjOKJ/N7l3C69HrmsIUJY/w4xa/wCOIER7um86gmNsZv?=
 =?us-ascii?Q?btsyQmCdiibWLzAzVAvh7eylAM+fcTjxPBwFdhluPdwitmMN+BvB0JpeS5OZ?=
 =?us-ascii?Q?8WCyBk3BmJ2EUiJpIhpxWFH1K9aS1yKh/7uShX4hi2eB4HkPehIY3N8mYWIR?=
 =?us-ascii?Q?W12qzpSWND3HQCP9ThVcj7Xev/gt5jHmmd/BPZtxrdJt4YhAu+N5s4qKvovK?=
 =?us-ascii?Q?SKwhiVR/AgYxTw2eikvrPUOqV8qZYV9NHYhGTJ/nt/YGSRiOUOedWZL3WaGi?=
 =?us-ascii?Q?hraR2PAiECsOPduoa1a2kYMpmiBxxA3cAmzlwexWZK9J2zspINuqAdYHz3Qz?=
 =?us-ascii?Q?4W87lYd8q7yVBeVvCpAlbiG9u3BiMNLTW8b7gJus57Po4VulA2bhlO9nToAd?=
 =?us-ascii?Q?gtTUnJSmA/2hCmRfbFCy4L6oS8Xwj4WsXzyWh2iPrFVFqYeN/mtJWQhtKXVf?=
 =?us-ascii?Q?7v+SVyiym60ZfU3GRQwCQXAoJbMMEV7AeDTm1d6vFIXmpgnHGwy1PsOo5S+f?=
 =?us-ascii?Q?NYmOvqQc4D8Ea18m3N82br0eFfLUnqUP5oPj9ATLHUb2gVU4ON80B6JfL6bV?=
 =?us-ascii?Q?jhtD02BnBdnZgnEYXTnYuLJpR1lCSK6t2bvR7DvQrQxe2Cmkwu2qiBj0Gxpw?=
 =?us-ascii?Q?cOr//KPU2J519s+1QbOUfSy3ZL7eAoQcptEIxOSre4AYjgqKyLg191COCR0J?=
 =?us-ascii?Q?HJ8XE4VkDX8/FnUu2C/lyot2X+KYqWTTGF33aowdFx1/9Gqh3W389I3zFAWr?=
 =?us-ascii?Q?vnKA5HlcZyFCS7Tx80Yz+fYuwSuWuvlt8KpruSfJq4sqIKH86GfYhcuDnXVS?=
 =?us-ascii?Q?D2nyzdGg0CrnslUJAdzzta9KV11oKQKv/8GVI484yQxeho1wNUuXzF0ATULe?=
 =?us-ascii?Q?+kKWdKLkJ6QokfntNmWV2pUj6cEtf96+fW88OkOTdpYwpgqUzj/QAkLzA3sF?=
 =?us-ascii?Q?DP2AoQiuQugY2mF5PJDoaX/MvZ+llZDZJdpwkzBDzM9Wkohq321EaLOoLCZN?=
 =?us-ascii?Q?Npe/G+yosHsShsldkvOSX9HzhKEyXByvTaT83jA0niB2yvWb4oc5hVtq3ko9?=
 =?us-ascii?Q?JXfkNL3bl2q0QU5v0k5x0sW0UVWqZk5wB7dIJqGvu6o7T7BpzsI7GSrihYmb?=
 =?us-ascii?Q?OhQ62auhF37sd7EMScFXfvBmpSW7frsN8QeHYPrAA/PSDPbYhrp+T8EFsw45?=
 =?us-ascii?Q?IT7q8TRy3nszJO5rFYoeEQzVUoJwEnwZ+fpweRoo9+0oyEAH7RfjgMX3dC5c?=
 =?us-ascii?Q?QWt+H2LmPR9jzJoCLtv2FwbGSo7ccVNdL7fohS0Ra9ujCP2RLHIDzKWxJ/OY?=
 =?us-ascii?Q?uiYf3E9fi6+yPRJ2TiTOtqJF0BLWRSDjSayBQk07w8FY1rgmtbsFKfGnsQDx?=
 =?us-ascii?Q?CZgSpYY7QZE0bqaVD6W+Ml7up6bSJWDQA/juxni2RrIJENvlRfBtQmpzIahi?=
 =?us-ascii?Q?spz38YoIyakxBhhojWep8HZlWeqKiauSjkP2bETLioK5N+RUTHRe2a669z2a?=
 =?us-ascii?Q?WrTvUomh69PnjZgKj3lYV5qS7QBduVXI65esckiTep92Jx0u/9tem2oH2/SC?=
 =?us-ascii?Q?u0sj3alO0JelDfrEEU9Xlng=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d57038-1eae-4dd3-53f2-08de07ad95b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:05.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDNriHMxc4T8bsq9uCvBKweyiWpSUsIh5/ZWdBpUNBYSbABDBLQ+QFcuWPsyBq5e0Y/QkzPbpx+U6HykWBKZA3zgrR5p3WJO58YWRZYKhTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..8408aee9c06e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,7 +776,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0


