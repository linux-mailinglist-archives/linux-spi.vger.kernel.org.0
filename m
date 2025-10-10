Return-Path: <linux-spi+bounces-10543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B190BCE5E2
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5495446C6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B67302CC0;
	Fri, 10 Oct 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="WRqbcDtV"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88224302773;
	Fri, 10 Oct 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124074; cv=fail; b=j46yOsUTsJv7fFWkCAiO1M/XPLFfe8S+fFnmcOdfI/Dw8GI9UObMn4BH3xHkBSeUojGdq2ZactlNU7L01yH4LXUJ4yU2M/yowQyOmWBzOREEHPLyMuTT0G4cGPk2VU9cHsKUHRtQ6JoxsHGjunOLaEfWlIdiGVbdWQZZJaUbyLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124074; c=relaxed/simple;
	bh=cBHsnFZtmlxn0wHvSPe8hsUcctWdvufB77xOkfG7jHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBAF6y7KEKdx38VJ+BMe+xJyzha5guqgtsBh0DD6O6aPm7bCoArdKXo/yCNVMX5a22T1xfLySxTnQbneTd3v1GorKK1BvW3jrQ9+jBaPDLFg0yInqYJeoiXBbJJUUBAGybl177cZI1HcuqyNVFbkPVMN0nvzk7lI2HEbmfprtDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=WRqbcDtV; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3par0pcuY4ixP6vnhztVAv15wEWugS0hrpko89g5aZ7d3TfB7TUJN4ZnI9uww3iejdzOSKpJy0m5Oou4PGpC5grxP2SBHEyEbg9K7dsdzIOoRRFIvEYV+7dq7Mpcg3t4aQRfH04zTvEJvWU/O28Di8wHnOHf4XleM9S3bCy/DpzL3h62KVvWeZmzYoALv39/28BHvp71n7PP8PB8VeFZOasxaZMrBwhEvVR/hmmdh4AiE7iGDwVXu5ue9f4ZHqnDX5O4v1eQTN4pNreUu0YX3p43doY8N4dpW/qYA/0vx4muGwmGyeQ+xZp6jhyTe4zJ9/jhmWpEhYwYVx3MAaPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=DBEewZWdjldQnUXypq3rntOe6DFM+2nTp8twlModI4mzrRyv9IX1c9x/emBsO+ru0diIi+PGfAXHIEC8uT3mr2yVwBleWKehMDtz+LOFnFtWO+iyLQ07ti77LnS/PmF+V2IaSdWEeMZ2yVX+2Xd3mrSy7ODTq5QtIdfhVGIT6vrxbQYqfY51ObCKL/4J7uA57wvPW6PRExg2A1KSNMBUUxPriXh7y2Amu1u79QRKaOek8/hsqTD1rJyp5t8pnV5ONCpYOG7BDsgbzqTEPdaHzwof67ma3aEJeqQr4YVex+apzBtjAONIhyYVE25ykhC83DhNZPm0FBj97mPYHjd2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=WRqbcDtVrPu3JOjcXLiVkBMMjr2sj5Zsy4wSMXiEewlTyKZbaQXhD/FQLG2mfUv6ybYjJwSMVlWqhrkEiaKIt2MxqklWV+u/CoyssWNnlz1uYlcfgGn6gmf024pHYpjJdYy7q+W7E4hPI2tQDx/THS3699DcaHvi0YCA42vHMXfs1SPCzQVPSWB2nc5avBuA2KBgzbtZW0/EdfJ7e6Z2G0YZGs0gIA+KysBsdRBWgnUVRk/9LmvQMTaqhsFC8DCFQNPcO2ml63HN3BqyL0MLvLGUbOkRS94jyFOpCx/s07d8l8he3rSPNF+hqQ96fVUwMJRfuUCyKTO0adhCRWcHsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:00 +0000
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
Subject: [PATCH v8 10/15] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 10 Oct 2025 22:20:33 +0300
Message-ID: <20251010192038.1592889-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ab3f3852-8e60-49ba-1aab-08de083225a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fd3o0j2jbODMudxeSpMo1WZJZWuwFyGRSaVTaT7etaRCfo3YJLuNU4jLb5Ky?=
 =?us-ascii?Q?Kvn4j6fIcu4QwAHa8/8gnbbAl7fSblcPQiAlKST1C0fd/KO51PcJxt66sif8?=
 =?us-ascii?Q?s3Kc1kJphp7t60eg/7h/IKbqGCDbKrFT0bREWJU+0loE0WjbahdeEEN3/ZDN?=
 =?us-ascii?Q?tQigOj+gZR6/A3XIPZc1BA5G/oaqwO31PUwGWuB4DYM3RhAUoiriwy5VqI8h?=
 =?us-ascii?Q?iBdEE7j+yDTbtuVt/LGYfZdl4CZYCxYcyTmr9hEZaWgMxIuBI1OCnK1D0tbR?=
 =?us-ascii?Q?oNhwamkDz7pIKxpXCn5K1y7poDWZ5+2Zh9I4rNoBJcZYJZgdwHMPNvma5ZFc?=
 =?us-ascii?Q?n8+Q0qpMzQC6fO9TiGf+rI3UeYIaLcSwDR5x4gC11v39kOCblGniCLWa3Qp5?=
 =?us-ascii?Q?zddlMVXQgeqEf9bAlsD7PTuyvO+oWi2V3bdzDyI3J6FDjuTy7DwZRgL+EqFM?=
 =?us-ascii?Q?p4SjEKf/WUzbDlLaLWDRWhmGUFwS7sSuG9g9Okx5VU4oOg5+bTXJIeHmzp/p?=
 =?us-ascii?Q?h+PzEtMaAVw8GKXSZBKXksKGd96A1JluAJaCjyi780HGOIk6odgwubnFezQO?=
 =?us-ascii?Q?4C5eVCTiuuVsC9SWHtUNzGXGUYypxWcPXItsR4WKzPyUyIslg1IIF4H9B1tn?=
 =?us-ascii?Q?8AzDWcYtQ7yGDtho+GEc6U0+7Pm/Ck6J1Wk7mBbMNNmCKeKibv0/bUxwgqPG?=
 =?us-ascii?Q?bLY6glI2JFO3IGznQZfXxrdOeGqtve8v3L1+wng8sMDzT0FHX8KA8YaAwEoy?=
 =?us-ascii?Q?G171EuwCLTTvFvJ0mJ6rGZ4XKISZm/Gxe5ahT29cf70v2fLjKef/CJGaawPM?=
 =?us-ascii?Q?52yz5YsaYUVU21Lsa2pJhgb4goVe1zpG6PzJKvWz7LgBumL36/LzOADZleRF?=
 =?us-ascii?Q?8H3IXCgSYtgVnNy0A7K+si3CTNlqDgrMmTjMRkjzZd7OqMz4zXYSlXzNtOsu?=
 =?us-ascii?Q?ew3YsZdIiuuqhSnq6Tpu06yQ4xyEsTWxcuh0dyb9Q9hl/laUMcCOCzUUrlF3?=
 =?us-ascii?Q?PZM5eHSr8N9yFqpRgODhycA8LK18C2R0+HCNxNEL3yTX0PC7qohFUuaRYitL?=
 =?us-ascii?Q?2XhAuqDXxPFVylbdmv/AEvkBlVhyQ9hBj8Ci1pA/ctcuvvhJRfWi2Jv420b7?=
 =?us-ascii?Q?7QxBSVZzzKYF5QSktByXw7UuunnOrd72xxiI4vGLHqqubIG+gMPEAtuLfi4Y?=
 =?us-ascii?Q?x/9yzucdlGR70viGWaF24lNJfipsuFt9JvGQ/9sDEwvoLBN7tLETMKMLBXPi?=
 =?us-ascii?Q?tAnQa7ZpVR+iqcdbRMzeE2uRV7HT0GPNc2CPec3xzf96rvedOiXAzhu9C8KB?=
 =?us-ascii?Q?1dcKvifoPFluAeb71Efs0Pv8ewcY74m4kwgZ0r5+apS7GRQFR8cRsFWMHdjz?=
 =?us-ascii?Q?6t8N0y3FMsrAisSefqAF93aOIiGbdqCijWc0JOge8zR3eUnY2UdJa2ksim62?=
 =?us-ascii?Q?xYp2XTrg+3mDEcmejTjLtPxhzTuM4EEYgTmXOFSP2qhohqCiK6aLq5Q89S2g?=
 =?us-ascii?Q?3Jp9Po8d9m8GZbHd8Vn32oCrEWEdoNndN8bTIpxVlpoaDkez82PrDf9dJA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LbRQ3hiEkIJ9J74m4UCElutyFT48FWcLnAhY3Czq8dc5kHmH1R6Lbtw3PN5?=
 =?us-ascii?Q?jQeFBDaI3SFfgg3w/VIHKFjdllt4XzzATn5i/PN5Jp3WwcfVEKLGHI7TDQ+8?=
 =?us-ascii?Q?k4IOpgXlt3NRHt6BZp2GgYOBoDxI6JL2kqF6zYgClNNCqM3dGn/tkf1JmXbR?=
 =?us-ascii?Q?6jFLGO3/drCNhZXBngFDMRMb3sPkykaxD6H4mwZCmShfyOKqhTQnCZOp0JLo?=
 =?us-ascii?Q?gPxax0bJBw+Ic2Dz5Kal76lR78hDibbES3B3BtDUU0XF/M8P4a8aIhxonEua?=
 =?us-ascii?Q?fFx8WAmhthhL5H6oKFSIAIEhthaW+hQpre01+pb/B+OQ7mWF7gnyCw04/hzz?=
 =?us-ascii?Q?N5aD9ZBLR7dMn5nYs88xqzngJqK14Tp6iEjRzGQhBAzFELqHptpYexKZB8jW?=
 =?us-ascii?Q?9pFkWCtOr7NF+k1J2sMHY0ECyNVuQ9+cFfXrhCL4d1/FGdBw7LJsT2wmCs7U?=
 =?us-ascii?Q?fz0qp+iwif+ULG3DLanxhbl91y0zA991fKfxdTtNKRJ9zbqbWvxTG5xO8Fdk?=
 =?us-ascii?Q?R77pmz07jI19CTix6mUtbbK0Welng54k6C0H6XuUY2FO3H4iRebU08fgAXN+?=
 =?us-ascii?Q?57q7NAlG0zN9DoSwPxxZqgJBojW1FOoK2IsUyuOVN8xJBwJ0HlqGLPNSpPKI?=
 =?us-ascii?Q?ALxuQPVm7yEal+Bgqf1NDq5MAYnWOLEd6LSokWdXjTU3I60RP5oCgDFyXds+?=
 =?us-ascii?Q?NYUZ3yxl/nf7xovrqlmn4vLJhlKfu3u7oQqzxXy2n516SkFvpCu+L3lTypDo?=
 =?us-ascii?Q?lgONHwDo0ONATXojmzWXcjftfddYHNuKZaO3DZzm3kYdiyJIpKMRho1OiUHw?=
 =?us-ascii?Q?MsyYpmbeTj4qDSHPUFxCU1ScN4CAtRbaZzcdhLTYtH5/yIg0IPahU0vAiMHj?=
 =?us-ascii?Q?FhdT7AA7ttzLw4lamAfW0MT5Hxk/lmGt3zqNCh913zOtkSLwtriVMOZaSUSQ?=
 =?us-ascii?Q?7329ZkG1wghVJ0xqv2kfdjjsaQd9QHWlFmLARtzTgSdpdPOt3vXfc0bh6S8h?=
 =?us-ascii?Q?/vR2umO4ZUu1+mCOByC8pzHO/LMTnAFmmJ39uS6774mQlVn09Aj7+kkcKShx?=
 =?us-ascii?Q?mO/I7mzpR4uZI8NF0JKPBWhax03ggHfoxozXHQUmgJcDhelyGYC828zooU7t?=
 =?us-ascii?Q?wRynt3GBAD6uGTDLoVLbrybrByA9i66/Mvjyaqgmi1EqX7TzRXigRh5qdE4r?=
 =?us-ascii?Q?IErEmPeYcccqZs0w2inic2G9S5ZoU8plEK4xwdzLv/8gOhaupMrqUd0RL3cQ?=
 =?us-ascii?Q?xZRExwISqR6+HloqDdqrXNizq0SAKvcPzYOfAH1DQ54wOllQprjkpE1o6ynF?=
 =?us-ascii?Q?h3pV0h5iIdQ70GXolwXsAdgPk4mhTmaJ8gs5oCgnQFwbIdlICqOm4MagAwJI?=
 =?us-ascii?Q?zD4P8VQBD1CISPK1a8Q9omrEYDafQ8pbX+tJO2YRXh16FuZ8hJaQDq+q/T6a?=
 =?us-ascii?Q?yOh+SUkfW2zA1wuhs4NBhVvF8ShrKWirUiL/rTT/v3PCL0T4TjOVEe2zl+VM?=
 =?us-ascii?Q?8rxAQFyHlSbDRRqx8zlin5fe0Mm24fepIxQYQvwAG/cEPB5lWfzBpQ6TQao6?=
 =?us-ascii?Q?mgCDcOvba+88fx3CYGES7p+6jHvbJ0UH/ERgINH9y2Ywup64ilmYY2xhjgfh?=
 =?us-ascii?Q?8VE4iX6eSCM8W92e9tHUiuc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3f3852-8e60-49ba-1aab-08de083225a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:00.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vth4JtJbIzLjXXSmCbvz7AX25/QaAJ8mINugO/+Xo2suC9vprSV9riCmaoYMwdr+vZUGlUnWRP43DYOi4tjZnY7fQjvTzTsNQTvjReusxAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 719b424d4cce..3fb76e2dd5e3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -684,7 +725,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
@@ -711,18 +759,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -815,7 +851,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -831,8 +908,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -857,22 +942,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.51.0


