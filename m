Return-Path: <linux-spi+bounces-10415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FEBB1F9E
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA817567D
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D03128B6;
	Wed,  1 Oct 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="5fnne4w0"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB9312811;
	Wed,  1 Oct 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357453; cv=fail; b=NGzZi7YCdS/BriV90S9xgo7+LL50KfA/3wcQyPTMUB5WQ5tj9tnx/lPym6X1/ROp0xEfaO8a8dH1fjpIo0l+afWKk+d8pCbDNgkf4fQXdnS/g4O/NfsaiB+0LW5M5DIA7Bznw8OK5PHwkYzRBNhIDYDQwNpcYf2+yxWj33YBc8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357453; c=relaxed/simple;
	bh=yls5E1AQJW8UjaQIdkFn4PFMkKchlzz5HVhY0hyRl2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulEJPvj/ag6NgkVMggROMQqQ3M4sUcLKF0ibDagKx0PXqII96wArX3mjlRVFx+QbV27rZd2ZBHkF75etj/fbfxdvs4SDR0rs9JDzMEKrKaqPcT6UhBnkrqmu0An59qgU/RdhnCIhisCeiFMN2I9xrNuPvhWUXPX3WrBfuBlGTg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=5fnne4w0; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeJnsRAn0UiHx4uwMnZvV0ybqqgEMZ19aTcGU8q/sUYeqO4eVRjjLUbqVer7HJjFRZ5BCGprvRemBb7YfmayB+Og1Qgxk+hhoBS4RBytFWzG8cGvcw+VhLu/OX5KnYSnjioYmlvxoz9mklHv0ehAWnvc4XPFrAGUgCH/PFfiSbshrn/wttnpFgt94kSML3/6KzFnE5CbSMdIlcLsyOJq647HpVCPJOHXBvYXjMcs3f/ZTY3JPbKn0Lpb7NA0/3lFT3nZdfEmqrCbaAsT3iQZJ8JUYG00tSJEfmucC+TerSqmAJGVM9FsExk1tYGANKs+xrTH+0QrM4qVF5r59gReTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=B/dtpj+Y0Sq2vgQamPqmXMj7KJTaTtM7+4EG/3+eFfwdIS/fNfrV7IIlhGylPkgldCXVAEsL28RLfQMIbhzQOi8XkFqIq9bBVJvUroonJU3bl3onrcQvPvppjRhua/ttCPTmaBiWYBA70RYZut+DwjB3lA0b2YGUr2Ipxp7yz5GJlw9Ri1WJoTr7cckULfTbKA/ol7jITwp8FKegAi5aoLujF9hOd1UXn22w8bkXAMI57eI8LgkrE2ncuZSc1uB3SnT6o3lJyzkmnUCTrkamJrSGWpmMo5drL91a0swr7wq4k2PEmD8S+3LJTbhDHmD8/MhiaFqJl9ZYLH5hGmoMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=5fnne4w0DimtYna3X0nevwTRrZcInz6+nhMHjvyCYeKKydIFnyJkl+SRnJBvUVQNYk2Zzuh7JuQJ9RYSBMi751iIsNHrzqdpQEpquZekmfILLoKw6zsCxR5dpe7Lr6l01uranCSMArZ2W9Z/Huz8vLkTQYEts1BPIJdsbkg4wx9XMA8BHt6pl5H3wk3+czeWp+hEuz/+85ymNWWITB1biB+5dHv3thwNHX2sHPd7KiL8rixQT0hE1cfhZAeODe5k8FirJfZ0E/bBGMRWbvfP3B1G0SQAAhR9RuCz1ClcKqezmDzpqqEU0HDacRY9eqCOAj172AeBvKFQJsL6OT2U5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Thu,  2 Oct 2025 01:23:41 +0300
Message-ID: <20251001222347.3386506-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d042c6-6f45-43f7-2d09-08de013939a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?InjO2RE8LWVMa8bme8tPLauF3qVv5UBBeXFZ1YBrZtbobJ1UAAY3ZtRQs7D8?=
 =?us-ascii?Q?OU7KRf71ybtTT+aafwXpqosm+p/3+piAGE/w1uFEF2HGXSK8orvRlI9vvq+A?=
 =?us-ascii?Q?LISTHN5D5zVKwYra97u5tYxbBqZxlQdriu7VpxgORuPCU5smICQLxYKA0I/J?=
 =?us-ascii?Q?wHrY3DM9SOtnjHEaEED11iycDNPW/kz01vqmahNHrJx7XZ3Us9HQjLOaERMp?=
 =?us-ascii?Q?8EIA6XJEFAcK4TxbblMiRmAj+jI2QkxKP9Sps4lzLMuJU7nNBkKBF31MHPhx?=
 =?us-ascii?Q?juD0ZCDWIq9DkQpQ79bVH9vgLgr9QicRJ/9V6QuFhYPJYoxGaOkd/hstAZw1?=
 =?us-ascii?Q?K7YCQj923f7CwXJTiARkFeFyMV3j19i/95mD5e5NvSWCDRZzz+C0acZ18Fqx?=
 =?us-ascii?Q?VC4PTfSkZcE40mqsF/Xw6TSPSLOfJ6XT2Mh1jqP7scUhtfxIVY6zpOstkcZa?=
 =?us-ascii?Q?hDetYxVRJ7M29m7nh01CBND6Vdk39mAjyrXDU2sVJyR7UnZUE1qFRAjXzWaD?=
 =?us-ascii?Q?KRNyFSPyh3cnNc3vOGk/vH/fMf5JOIxH+xQ7JHecoECtJWCgAxTo1zOY4ihj?=
 =?us-ascii?Q?yRQdd0CakSVcMmFoJtrFjh6h/G8Heeb/HP85RZJhBBVgCX/6o52AVnyIubTm?=
 =?us-ascii?Q?sJgaXFde7Wt3KXRXvV6T1NAG/rbZxqduumw1m6z05xx+X+H0eW2CDhbJwZVm?=
 =?us-ascii?Q?QW93nOR1VsR9T99Exdpax00c+j4etNTrViAt98+TcwaaTl3EJdBJinsedZfx?=
 =?us-ascii?Q?nQaeFAf8Wm+vuF3wn4O35o44W9FxObT3HVW04DuWJcS6sH26Z29mNnmjPbYE?=
 =?us-ascii?Q?IJbKzGnNfEmHT9kAzh1a++VXR88rX/REKGRh/nx28osfS6MCW1z/XZN/4eWC?=
 =?us-ascii?Q?CQGrutAFOPjvapfMv+CcvSfHRwh/mC5KyiPymgpp3tLG2N7dlAjg3Eg9VAEW?=
 =?us-ascii?Q?EwJLUzpuVNhBZTIYf0WjayRqkWHF8HO8fNS4RSQ/2nMDp8Evx90nexUlQlyQ?=
 =?us-ascii?Q?kkh2EfuVPFRrjfGYjVBxIiK8Fp07MiwB6a5fDvN3uw8iZ9ct0fAGE1tDslx+?=
 =?us-ascii?Q?6l7/zs1aVR1N46TU4C06OlJEw2xdVsfDRW08KPfvAl+IiNUhYppn8/bapH3D?=
 =?us-ascii?Q?VZLM4q5dr3QIpc9/bo8RAmqd9HrSEWbFKgXHRETo3zRWdtL4HyXp6WFbAtBs?=
 =?us-ascii?Q?IBlNBZHJVqICcUEhpq46XxBnitBQPxzErsGaQgmFcVb0OYDHHyPWKgH8WlZ+?=
 =?us-ascii?Q?FcroQik/FbCKKrPG0kvG1vck75jGjjF03LwIGW5a6jcn+chhx2vFz4rEx8L2?=
 =?us-ascii?Q?o/O5BBt/8+HP4PPb3n46KT0yYbdQ6Dh8y28UdHpYtl9FGU/IVWW0OcDBgCy3?=
 =?us-ascii?Q?v6FhhhFJmJwBLHzU0w9kGN8YbVDYmNhyAgE/JZI8+lBjCeUE2MweiXu+p5q6?=
 =?us-ascii?Q?KdVoJVjbd8tickyQ17OelKKygwzewPeh69J+DSKe1OiwaIjzmPGfl0LP/Kpr?=
 =?us-ascii?Q?tPx42IQxQMIVrTUmwuCgRbROQckFt9BHMtLz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YOXicNCnAsFRcjsQofzgyeVC52+yg568P4jcFw6maxsUVqts2XZedNuRw56?=
 =?us-ascii?Q?2OTBkemV1sslfM+a0IGnyy+gQ0k176+qCY2mfzJMKRfXyo4GHmcvzABT0Bs4?=
 =?us-ascii?Q?7CwVrhgJrA96ZT3gPaVJ+EHYXWhHiWVo+V/Zqujtb7EW9kNeSS56N2yMXFLs?=
 =?us-ascii?Q?sI1B0kWUBdPJxLnC0nJ6jsJO8VcUOB9qKSris5z7ZoPmd3yLecFCtcZQwfE0?=
 =?us-ascii?Q?ps62Nj1GKRZ9c0c8gKPLA3GWKXVABLte3EJPQFB86duFJi6RXvX82Si/0pbU?=
 =?us-ascii?Q?mTIylXdxkyXquub2HT+NMogHzLxCS3Kue+N6JzqbzCcMz2TeXOblo92dqwUH?=
 =?us-ascii?Q?DK1jNUZ98j+wgmjXmwC6tZm/ZrVXE/mXSxnuqZPoUEO/nqM3B2zn31ncIa19?=
 =?us-ascii?Q?i/VSAonZW7ALtOhS6oHb5z5bBYHJen0i4N3HiK6+SIE3pGgo0dzrqKu6r5yL?=
 =?us-ascii?Q?0wcs3qQvkUO6vyh2+sbAX3O0VXnK7QVebdnff2dCg0MNmO6VQeiQ+r7tglRu?=
 =?us-ascii?Q?l0Fk8UAU0sHq4Fq7M18hrSPaCh/fqGSPxI1pnqrRGnX7mD56g4+G6OyXlQys?=
 =?us-ascii?Q?fTDEpzPwx6uYt10g1vICGWsDISAq67vyMYLH9QAoTB3mh/wMMtEyKZec2V4F?=
 =?us-ascii?Q?9wEP7XcXLph1QF71+jY3f76IfZ2PAQQJYCb+Qjw3325o2Pb6rH43zsCbgeqR?=
 =?us-ascii?Q?9LOk+umteY7spXYHCTM9sePHw5bwik0B/QjZ3/IM/mVUluEfcHlyZXt52nZ9?=
 =?us-ascii?Q?fPOzffJy+Oixp0l5flF3067e0aRf4KZP0w+3R7yXUkg2WuQ69Vp0+2wOyx9V?=
 =?us-ascii?Q?qG1pji3QPcI+Aj6mBoJI/qirvG+kQY+xlPdvgaDbv3K8ijhhiftlVsy+5BCE?=
 =?us-ascii?Q?Pxlvykrd7BSY6WGpI8xA1HO5UOq+QOo9IRIX7yLvlG2/2uVF9Q71xlUZUCIc?=
 =?us-ascii?Q?HWBVj20jEphXT9o7+XG0iuxHCMxfwiTf1ESidgarIGVfCztRBAFc/5pdK7jy?=
 =?us-ascii?Q?eNxrle8q2y51Z3gUim60VU7CkCllAbNyBmP9s246e32W03JKNNmYTDyuTy/N?=
 =?us-ascii?Q?xfVIJQLgnumabintDel/0J0I/34yqhtruNXsXOa8rE8D/9Mmbt1mnfDNM/1f?=
 =?us-ascii?Q?8XW3ApCl3Ylin8/meBDu2zxrzAjdXHGezcPZSRGkK31dyHUteVY+AJwLCKKi?=
 =?us-ascii?Q?1teFohKm0mcdqu3PdNG2WSzQzcOEz2ZhLd+EfapKivk/6C/1Z+rebw7RP09U?=
 =?us-ascii?Q?VakK0eTDEGs00If54+lYrjeZoixdY+2EgbVoA0HewTEqAMTTMA2YsQcyLzeI?=
 =?us-ascii?Q?Tqm4hAEWIWDxhN/DPA27vRz1sIGvkQJCb3qZEfN5qyy7nJGlQIp11AxrJi0c?=
 =?us-ascii?Q?XV5DM3iyfBz5mBYrZ2YNQZfb+qTWsmsxTk6wkfF5J2QgODgCcMutbmCMQ96m?=
 =?us-ascii?Q?tHExs307xp3UyZSzPCed8PW1B17tPZpLyU39rb0bKwTsVZwqpH5ZvBw/AcEA?=
 =?us-ascii?Q?l6c9ANLzCQPEZ2z1tUF8QoyPiY0y6XhM2xwKAv4WeMhCGKsDn5zD2paVZvut?=
 =?us-ascii?Q?0qdZeJXyAM1Ai77qTzl9h9oLJon3owNgYW7cgqMuGW8CugCx+LeNLQmPknLb?=
 =?us-ascii?Q?QHwd14B5Hb4LWtjI7e1VVrs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d042c6-6f45-43f7-2d09-08de013939a6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:02.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk4M0aQJNYThzPdrlI26M9pfGETcz5gRB9+03aWAA32k+FiJuAEfM9owbWo/N5CR2tCoUKCB3NzQHxMh9IPItkp9QS5RZ2XRAoT9CKbOWwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

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


