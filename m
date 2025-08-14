Return-Path: <linux-spi+bounces-9408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97AB25C5D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4271C872B8
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820426CE0E;
	Thu, 14 Aug 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="tKBcRbha"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155626B973;
	Thu, 14 Aug 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154489; cv=fail; b=hVBKN3uti0k7Quxe5SuB5IOHfZDxq4UHSF12ucYfyc9cpsbaH8pwGAyxPbimvvBOApAI+BkFc2FMJAljOSr3M7B9nGVc3pxX7MPtAlmLrrulDrFPOSN7feb3g872kNRiGHaXF21B3vHNmxYyaXEQzze31L5/Fmu+q0Eg5CgKBm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154489; c=relaxed/simple;
	bh=YaY8Mq8Ik6RPzxaHeEN7V208vjYUm9Eoqlxrc3Dq62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLrqek6VZsUe6hNc4BAX/s42QlCiPpgrnpWj+9wDSB1t1A5rlVsV+DwtaXedSBCWaP4iL+624bLbpohZmIGMG+h8kJ2L5rAvO6gnhJ5mQB4OFqbmL9yKjceDGthetLvCGWVW+AsJX20y3b303enTMbZKm/jDwqbDzu5XpQNijjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=tKBcRbha; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXZrT8GuYdmsdrLyg3myOMRpyUyxtS901fqcUXAWOOlseajYDMDb7gAAWseNjg9GX6rP2GbCD+ca2PcO9X3L5G4z2sptCx7yRMk0qNoC1Db9LCD40uhRBVZ6+dJNHMsg48ejjV0LYRqO91mW4J+h72+QE/ZOnFYFnp0AgqYg3xd4VyqsHdqiRYGoEOSDH8SgZAxg9RiwLDBIUE4PmsSOC0C0sXgBXcK8hF+o5KPYjLwPOgKsROK4nSWwEzg4QB3q0njT+phQkWfqvQ1IhBd0VooWupcSnIu5iAbo4h/uUtWaQ7mZx4jayhTGilOFWST3aW0iTPIeBU72m5fj3r4sTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4KDm/adpJa/CKniexOr3XhUbTqwuDQSUMnj7/NeChM=;
 b=tGp5qKbUYSWuyQ310nHb2T4zLgmGouCTt/2E4jRf1s51vijFHgl//vqYa7FK9BWnaX1OLSyKYTjzMeFM0lak8MN7YsewYNBIT5DuHEjIqP41gvBv8ff0algkltKn1zW3GK11R4YSm/K6WwsDQcPG9MZyfZt9wr+F9m7eQqk/0Y53y6DZ3zmP7CDkLvHA4g82av+h0upF04x/RRVmbAQ/fOr0SWzzzYO0xozRJUbG9RmAPQS/WY6qOgonnMOKnbUerOCMzr9mRilIP7w4MuKRjyOezgqAfn19OSu5OKDg3oIgBrqbnPQ/5J5buLMM9lydAAjOpp+YHYSKQUCWBsiiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4KDm/adpJa/CKniexOr3XhUbTqwuDQSUMnj7/NeChM=;
 b=tKBcRbhafO3jvAcsPd25OfYVAvRSPo8Ktey+zJw8lNtv5P8lJl2EZQ6loqUwa+7wlNRZcam6TfdTZincN+1jLgcBZ9JNEhrLCBVtPM/pZ6PLl+m2KKY3tWlFDTZYud2hvMZg4bW9nh9saEvDlhPs5JhOTSHOync5HSmkv1vtWf4EHaBlQdpjN92K4pgHtaFWGE6sKApnQgYLqHNbCRGnevZiq2TxMr03LSijKrTJA/grrdu+IQwnkY8nursYlOVVCcP/nMqFSLVRklus7nONKjlLZf6I6q8sAoe7aUIEPBUgH/PDHJQovg/wF2KTYSOXyCldwDCtWLqhAMF6/D/noQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9013.eurprd08.prod.outlook.com (2603:10a6:102:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 06:54:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 06:54:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases
Date: Thu, 14 Aug 2025 09:54:23 +0300
Message-ID: <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:7:28::36) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: b57b136b-7566-4c48-835c-08dddaff7008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23qt8uabS6PwN+grhf202pzfjtfO9+KVhhi05oJd8BAWDtRlZzZjKpUeV/qs?=
 =?us-ascii?Q?qhlL3o+wkQke7Zxg0Ze2L4woGe7n1WAYLlRNIl6nTctJNUSLesIN79eWK06p?=
 =?us-ascii?Q?0ciRgA+1AdMMhlRTTP3LCz4fEdJ0cCcKsTAWUO46rassNmeZhYidMVRmAqO8?=
 =?us-ascii?Q?YUIeOfiH8sKmRA45+ywftAgexTtjCzqca5aYi89LzHTVINemR6nXN2/JAKoT?=
 =?us-ascii?Q?6UmZ/wlI/GwtRVbgd3t2EXuN6FpGItDImi07p39L8eYV/cqbu6lZZXe4nGfK?=
 =?us-ascii?Q?sgWkCcFZc0L9FqN0O7laKcdJR0LWWuH+8Hnls3VSVOfyNtZ2MlTsHWz03aeF?=
 =?us-ascii?Q?4ojUos/u4IvqktiY/r+tOwKCkJucKu2Ntnx5HpJbuqP55pm9PTt9fIswxEps?=
 =?us-ascii?Q?yi8TpgYtt78gG1ilI3nIjSkr8gfKkjFkBXVQwPShug4Cl11PP2X3ax3+M05G?=
 =?us-ascii?Q?2HsXN5cktycocm7eaCU8klXe/5kp0s638wUfg71oQWOzbXQOR43KjHjbllRq?=
 =?us-ascii?Q?gjjEpNX0bwHuU4AFV6hUD0QbNM4Q3HKc0gIwAtaQSrOfhupqaj6kF6uwGTFy?=
 =?us-ascii?Q?IPPFq2nMpgHwXxQIgXZsAO6hwQ2wKKSbAGUabWsF9oQYicgnidHWkV4ddcy6?=
 =?us-ascii?Q?B25dH778SS264k416CNUsKPi9AdbhZVcNy0CmP7sLmkpxo3EepOwrRXrqPH6?=
 =?us-ascii?Q?DSQ7FtuTDLeW8c/NC4nshcXPyM7kueAPuyZtkEeepzPVyOai/puccXKqedBs?=
 =?us-ascii?Q?4Jp9xNp+osxfZyyqfi6/j6YI/YwjNmYKgjd6aNIgNw84lzLejtWM4f6BTsCA?=
 =?us-ascii?Q?OJ/Z+k/nkLSIvFVL/GO8/4KBlVcUw08bNjjFYOFPmx8ZMv53zA2RxjiJMGHP?=
 =?us-ascii?Q?8LR39WdC0iWYo3PABmA1fbymbrJjyGFqsX/sF1lapVX3YsVS3DOcEKmlFERg?=
 =?us-ascii?Q?3d1rA+1Cq/NntNLwbWz9XZuk9ML2P2TCpDCmdPmAOJ2BdAkzqxlS9MvQZTCe?=
 =?us-ascii?Q?qF5vwZKlwfUPca2fJFs42q5d1umXt5zK72Qy6NvVbvkz3AvJmo3u3ps2Eo6W?=
 =?us-ascii?Q?lSW18SDMF1hsw4BLF5TFAUQOxYfNxaF1Ixk4rRIyzIICp3faxGs1JMRpexDy?=
 =?us-ascii?Q?vk02wY03WWvgVm23oKowAgSEgQ6TBBvIo/7G5pN2aU7/GOmjTiRnSlMFiyHk?=
 =?us-ascii?Q?IPDYau1uXU7nRwi00OrTJYY7HDCW6bwXqejc7ik3R0XQLunznR71GoqX+yry?=
 =?us-ascii?Q?PVo61py0k7IZ8KggzmU2kZBFxQzfQDxPuK85+QKGypCPVyOpgLBgLGj4A6Dz?=
 =?us-ascii?Q?LkVpK6OpajmOapC1gLUtEonuzMrQXJU0VsMpI/Dba551ABBALTqsuevVnBib?=
 =?us-ascii?Q?Oacltu4Ho6MBo4tDRQ2WFJmAFJPdb8TrHYi+6O/87c0nSkyqbALrui1fNd80?=
 =?us-ascii?Q?xQ+go+fu7klN+SwnAg88fjPoRwsjRwEHfe2zsgGJlLaFouYIxXHWLm6I/McT?=
 =?us-ascii?Q?v+GraU/j/Go24jI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zq4tXcaMbdRk87bN+/rMqu5CqZtra1+QQDzxBSZ2vZdgi3fQ3G1FBU87RHZQ?=
 =?us-ascii?Q?Slo/P3qiTkNTjDFkGCJLVc39H5Myxs2dnr6QbKOHXbyjvuTPcTJ4dv43CWNE?=
 =?us-ascii?Q?EBGySfi3+mcdHTFRo36FhL/zvZ3VdZCB9nOqCrbMovdbDHyfiU+apPMLORs2?=
 =?us-ascii?Q?1H1GfledkfgjhkDGL0LGBPF1K8WturIeOY6mlzX7pfFJCJuOpVE5lDc012ls?=
 =?us-ascii?Q?EHKJrSd+LBXBjKCrHnPPcjMYdxzB+IilAG//su1Vd3C3qNDE7py8evTQF8af?=
 =?us-ascii?Q?i4v5ZzcfA2+sVJ51SmznZp7wfMGln8qXqHHxgoPuA7FOA2OFh8dHLhUAMyX8?=
 =?us-ascii?Q?1ahU2UL7JJozbyPxeJXV7NyBzT5br+8Ft5xUeTeOK0JnzExH3eTF3fW3NAxR?=
 =?us-ascii?Q?rEiTPzZtqH7JJaO5GdPVZACWsZ8JeQEFvu3T7Xbekn+FHR2TCq2odQv+4WWO?=
 =?us-ascii?Q?CQNU+0/atFr/Mrzf5LmIrHgXjZAXJeNJrS18SnAOOxKGsQ+S58ChYeY/sI1W?=
 =?us-ascii?Q?8vGcgsey1ic0txaXTD+BnVxSRJaIfnH4ER/21za+4W4Mh3p0j7GXhFRcbaXF?=
 =?us-ascii?Q?kxQtxDoXNMAvWETHHa38bjJTe3hlA2j4+9eIG+f2W9Yv65XSA3nSxz+yJGAR?=
 =?us-ascii?Q?zAnrfQGlyXPgMdFTxAjlyuESEIXOkowo4ViW5lg7O5dsXOhN3EcS2afA3P0B?=
 =?us-ascii?Q?dhMPH+by017UaUTPekx1TR6VxxNRrr7MO56tRV44rDYJPv03x3AbvqqK4lL7?=
 =?us-ascii?Q?rtSo6LD8w0qPm10xT46WQ0WMEVEs8IKT4Kfo3UxnBqx6x+xfqo4VSIkLN5IJ?=
 =?us-ascii?Q?T7KMtZPXNmg4N1h/2jOlmaBJdwdrTLo48cOn2IoMm+5OqU5Oul8vCNE2WAWc?=
 =?us-ascii?Q?iPAImM5ugnsAZiWcxnfswcHEm9R0kpdZqZghAlDRb0hUsVDv9njGZ4W8WTNv?=
 =?us-ascii?Q?TzT9FkWKU1dp44Y4fGJEgaCjRUSHaFfh1mw0kYMXGJ9dHmvVB0Gh11P38rti?=
 =?us-ascii?Q?JkIZOkghqXNQyrHVneFh8Vd1glZMX7gu4yhsH+GIphHXXkq3szr8XgC3DXkr?=
 =?us-ascii?Q?M/nynRiSd/e/LwEuQKXK/F00p7iJOWPrZbsxS9JUWmzIp+o+4mfnqVrq8fR9?=
 =?us-ascii?Q?fXpYVGPFLoV2i8ZMLHpV9+693+jDRskVYhOASQrm+C5Gv2+W72v6uJwVeIcG?=
 =?us-ascii?Q?LRRrN8KWXoksltr1E9K3ud2z0EGoKTAYookhCW5px+pntDr7MhL3bleiUGpI?=
 =?us-ascii?Q?k0+UQlsJDZ3iRKy+BLuK+EAItq5DqbMtw/DC7WDkhLiaAP3A8djf1x85MnEE?=
 =?us-ascii?Q?s5VneKS1YTNwWfLycY7GpZr7LC61nXZCEA2WSj3BiRS/EtNApwaaA4wtnE9B?=
 =?us-ascii?Q?7awr55+bUoS5tZAZJsLSs5B9GzcQ84OO2eLenAMZ1XFHM7bgyg/FcaToljcf?=
 =?us-ascii?Q?/WmQusryc7BiMaceedX99E6N9F6dS3i6/kOqnhC0aFfJme3L1uuH+JYDPwPd?=
 =?us-ascii?Q?ngOLB2V91VaTiqeozuYqHGAQ3Rgo1wwpZpZZCWd0F4CVAe0Eue+E/bP/LxBS?=
 =?us-ascii?Q?99fNYQmY0JZqoN396QbVFgAjAnMsPiE83hOjquxOIXKkNvryNxJ4gsn2of6V?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b57b136b-7566-4c48-835c-08dddaff7008
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:54:38.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eOOi6eYFRwaeSfduRcEzrSlqdtXF7vm7D9c+4/xTdn2A2V3xcUHZE+1X9j4mRJPoSoAschzt8hXx8jI3WoKz/RRgRj1+IIE47jeq30t0yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9013

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.50.1


