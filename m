Return-Path: <linux-spi+bounces-9896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CAB43E98
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91051C8683F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6163054D6;
	Thu,  4 Sep 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Gd0MBDJs"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F012303C9E;
	Thu,  4 Sep 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995837; cv=fail; b=Lo3ZqY0yRErxVE/Z8mqObOYUjsgDV5yOlZckWCu8qMgm2qzzONgKKWUHGKeaB12mzzvLsSsbVmTieyFX84IWO/ciCNY6Bcs0fmM6KdigznaTJl7WL7Ve1YC0kGn2sCbR3vmHV8wtN/hzBvA4xIdY8lJ5jRE3uP8B42OwkZ9XX0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995837; c=relaxed/simple;
	bh=yfVgRyVAlRoU3SzK1GEy9nQvaGLglKASwFFrlb9QsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2cg3QQKw7wXfMv9NygOvSUZKI5jrIxgstFUCnT2SQfkEoW7IFewqynmHyEBb9d078iCj+9lhvlu2XHVxn+IJb1ABIYAlgogm7XXK1dWduoTRz+vu3uFn/fwdx5N0rOHACRFwt7d5pmfyVsPtBucX1Vr0iIa1veUc/R44oLqWWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Gd0MBDJs; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEmn2inRj1Jr42fgjmnWhGI4smPAiIQd8+noHYUctQt9PzFnhqW9LHEhEXjTocgq9Uq+La83wJqucaD88CuEQm8T0n9OzDpDPd0E71lVolhD2VxCzaRyNjKhQ/HyUZE5iUljbeEVSepSWdvoHLKZznf4uI03LCkHHJWRnQHV4fXq3gfgyEHQCxplsdHv20nXitraLMp0n0r9xhs1j7cz2PxEiaU4DD5wu23FeRr90rsDzcRQJTfCeuzaT2FniUJNrWPkhDExwwQReJ9LPlkH8UQoZR4edzXooxDrPw/XkJoJbh63ZRjSI9qqaRzP7TNQIMUUkAjFMPAK6N+lpxN3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=A0JcImtRkgEVP7ohn5MZibg8JbroejXSQmIN++DrAyMqXsK5f8b0QIQR0IBW1OUXjZMNu0GcHC6b8SRRIu5/ssoWl3RjzDLU7icUEBxUXleIo972H3/wv8gOYRZuSPCwPhwJa0d03Es6FQt0NlLh+ZMt9K/mRPR8de+7XG1cBnbScBzvgYE7kvWWkEUr0E5Fj7nX4IxkoyR2zwf7qcmsUQ0zDIUfhWZHhM9P9qLVYBQt0vshEd9BSi1r9q+QrnON1a4aicnxa7d3ibCrk9QS2hvEamcSXgJkennrnZZhEBrWl4xoaQtqPZ8G6QCr/Og1UdGkwbaIqW2MVly70xaJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=Gd0MBDJsqD7NItJa8d1KxZm+zsfr6YkTkOVRCqWKvUaard+ucyQ/BLT+yFxiO87JskIVFAXK2EOLwNiDB2810YQKgGLXxlBTLvI5nPl6vt/pvi77oqJcVlF0VAsASHtew5XDRvJiVK1/8LbfCu14gPJjnqtX8KGEvyWdXvzw9oa5DM/JXO3JqTWSJvEJJKpxitlvOwEFfEBdWMWr3IG6pO+XCl+EUrGcztB1/WruUz8mq8XQ7tsqBNlJYDPaEGRDJV9wlziCrPeDUv4IR+5M6vFrYsK2A6oauXRupn+sUHDXQbcG+5NFFjxl4XHNzZ6WZQK5wkAjNc74LGyGVwxCwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH RESEND v5 01/13] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Thu,  4 Sep 2025 17:23:27 +0300
Message-ID: <20250904142339.656346-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 83309be3-3f94-449e-0c40-08ddebbea9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/A83ICP3CisQ+0iLY5pXDTm7Tz0tCioZOaSq6U7qnEnTVxnsxM1qbOowFmIA?=
 =?us-ascii?Q?Cm+/oh0Fcb9cxq2qQdkesIQbkkyr0JFG8iwrznoMzCzhdVEQKjszr38f7Pdn?=
 =?us-ascii?Q?a+D2lYq9gXoTkLd67Vy39gk7Zgi34tMLHv8Qmx/XDOCco/eKxXXEojq8Q4F+?=
 =?us-ascii?Q?sFQivwYQq5FHUHptMxmKgiy2DuVQ+KBXQYftcFp38IE2nRPaX6NvAK04pHCK?=
 =?us-ascii?Q?QJNMwtfC0KoB1U+B/lMovC8pOJJywfO6o5BYGosaBWOPzSxpcbZc9UNGcGww?=
 =?us-ascii?Q?EO83KmqOoU8ZMYeJzBkG6VFsj7d8HT0lXZgOYzpMsE1I9gu4+gXqShJhkket?=
 =?us-ascii?Q?jnozFBy81i4fr13dyx54t11uGtYscQdymeIO0z2NCV/ZjOVWDFAs6dOMcBuG?=
 =?us-ascii?Q?8kL255xo4fKZeX1za1i7FA0PWEqQ+guvXacZ4t+oOhHDQACSHqLK68fkuEsp?=
 =?us-ascii?Q?vbGNCcU8di/nVsXXvB7cEtWp2aVpU8RLtdp9lA7doyCG1uJyhU/yFnpL26sS?=
 =?us-ascii?Q?dRecgBRPVeYCNioozqWWocJrMjBt3ZouHGCNoiJ6NOI3uJVV8VZYeYrGR+Wa?=
 =?us-ascii?Q?iRODc4K1Ym1UsdUBC9eUcwjXkD/T5/YBfpe4mj8RNg5L/O8cvMqjxMoBQh5N?=
 =?us-ascii?Q?8EYb9sBH+QU72HcKm4Df7XzklCcH692UzM8KeR1u6c+Mu3GeHpvWGaKr0cpy?=
 =?us-ascii?Q?M1VNgS9QlNEwxQTdS29VpRJZ1w3hoGa8oZgXH1hk5Z0Cokt4tOqW8k8faSr0?=
 =?us-ascii?Q?K4zOvftfdE394EOuGiiHQyP96+ksxtTL7JHVtsP9ywdZAwbYcrkMgRIYKy0x?=
 =?us-ascii?Q?nBQaaGymMKVbGHWoVcTOQoUlh5TayyJrYb4wyAYSDYl4RXvYJT+tYMRICPO0?=
 =?us-ascii?Q?qGUbFLBfmpEzbKH1BLOrChO824GeCNGg4luwiEKODYkeYG9604CQV/RR9kAv?=
 =?us-ascii?Q?AvyTmyzuTg0XLlrnxnHgdYOp6OEPMu7b2/XnFLB6kdfHmfYX5TmnO8SHPb2l?=
 =?us-ascii?Q?FJC3vLggA2QlgPS7KQrhrW9f/ZGLf1q+sgOwAgl8oPPR0bRE6xoGuAiHi8vb?=
 =?us-ascii?Q?bzQ1V3iO2ul+P5w5PZJ5WCcDjZfVVh1IZ0AqrqtTTBBF0lzyKaFeNrX7Diyp?=
 =?us-ascii?Q?cZtiXnOoEKVZ29toZ3JVXYOuEw9w3TwUTPWizukb6jf1f5iJFlp6tkBf6uya?=
 =?us-ascii?Q?7tQ4BScVqOHJuRWux5ljkvmTXXEQvtqmkrmrsGdK5EZX0XRTL8nyn2G3NiOM?=
 =?us-ascii?Q?JFwB40QRUn0+DPqdttVksjpOZUhpCK6ZfU4HAWWviLLhovX87fzRmDK8esZP?=
 =?us-ascii?Q?flhe2VlcIjbwtqWRGEh8iK/k7mCrTThWMYz83r+RQ8MQIvQFMC/BKx08eG2W?=
 =?us-ascii?Q?wIUtEegrse1gZLjIftyoWyxR1EnGujhPtLIJxnpK1i+WfZgRkpfxXnCYhs1W?=
 =?us-ascii?Q?/9WRo56Dn2WscU8PFkbmOvnQwCaoBVZsBw+QrnBeTdKASlrIitUE3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzpATKaqMSP5ffWSvIMRce1eP9oNcXYO4rV5GZ8agjJcyFNxXCKnnC8m1xGq?=
 =?us-ascii?Q?z7IcAORTkkH5TL4zxZ+9zmeUEVBeEYmTshiV4QO+ZMdgxUooTxVQ8fUP+gyb?=
 =?us-ascii?Q?iHEwpYe/wSKenA8bRkmcRO6duQaI7MeZss6hAQ916Riw89r8EzpDyVfG3s9b?=
 =?us-ascii?Q?iiZyYpnNP5BDgft8yp+5syCJACDUqM1LHpnhP2QYZ+p3KHK/s2ujxeD8JPmt?=
 =?us-ascii?Q?koZYOV66MIQdrSFoDEh4JkX5PKN0p3N/7hdA7aNO2oh2YzO4NZCPGZWsNwjk?=
 =?us-ascii?Q?oB68ywd8uKN0sZ4Unqu/w3GbTsYIfILgV0MMhNnEEPkjLz5BdNupEDZDxM3q?=
 =?us-ascii?Q?FiLY7eKZ/XbfkbtThx9nt4xfi09x68O8rFYCxTnvwwdviMUeLWALEJpWEoPW?=
 =?us-ascii?Q?x9ThsIoYn9ysjA3NqRMPoqYzvcPy4w1AEpA63lnJbKZBtPmk27xDAWwTqC3C?=
 =?us-ascii?Q?xErN9qzKgWXjAJAhy9Um09y1vNYUgQQW+BIF200yuOSU9+P22vAYepwdIKdi?=
 =?us-ascii?Q?xiApvTYeLumGxcHGU8bMcc/6knQQzhsMAF8Hp6eJg8f8arJQBeLIvN95OUjr?=
 =?us-ascii?Q?a3sUHUFQZi2s8TIg9WWuyBjzLEPstuYh0Ef5N6jvZ2zxe3ixB2MUdfu5UBGg?=
 =?us-ascii?Q?QrRKHH3EWWAWSwWnQsorqpLDz31lAaAJo2HLL+cmLLj9wnme73w6dRJhGLzQ?=
 =?us-ascii?Q?EAAmFelmop328a7jcdrUIvF5xb8XbeHCPYxGmv/+dW5oc1jJ6KohnmBvOKAs?=
 =?us-ascii?Q?iO+IYh4jX9WNgVtEAxxsDKAR+NMBYte3xd+/ap6bFn4rhfe96D3fcX94F49w?=
 =?us-ascii?Q?zdOI8tOcAjl/a+hHkxXaZuFO6OSu4oC2iSKbrzXlckYfglqXHvCoM0sFmEpp?=
 =?us-ascii?Q?dj6Dizo3I+50Lhy1onwCroy4gj60oqK6WoA4tJPF/qVQn22fc5X4wp372D4S?=
 =?us-ascii?Q?ILdydH8tebCbfelV+7VG4sdWUVIT138HXg06plEDwaj3WbGt0njbrax0s9oE?=
 =?us-ascii?Q?ktGF2gV74roGfYEz0dSgeYFiDuTIDSuEZIlqDAoafclf/QVHWddIhFuc16+1?=
 =?us-ascii?Q?Hft6Ym4FueFWZrx8R+lqXfj/dkc39Q6RbrivYMX4CkE2ufR958xt7ej8DewM?=
 =?us-ascii?Q?fUXZWdXRn+utwgZxL6SjBgs6kvrKzH2tvezyFKs5igIqoL+SEWrfbjtsOTR/?=
 =?us-ascii?Q?WDQUhm8ytFkND+eOMUqJEcFCMj4E+V1L3VmTfeQoS6QDBKj1mKXiZLh82UKQ?=
 =?us-ascii?Q?u1fhB9NhOl6c3q5XU0tLoyoYFqZozS8eUHMJXfW8dtJkHOYNDfS6j7rmS19s?=
 =?us-ascii?Q?VZ2wa9LepzJBVMbdSgbL8mcc9IFLVWl9LEbHR+FvxIzKJBUn0RcYtSR2tmGA?=
 =?us-ascii?Q?zOsutmFLM0WPBRI+FBTJwxDI8F2MkpWDritsjZmpZn/sUZ08CB14BOkfVXn9?=
 =?us-ascii?Q?dXi34271oTFHyLMyhQ8EYb5FVqHtDwDbci8EJb8LogHadNV0ANHaE4DqNoAo?=
 =?us-ascii?Q?jYFTOT9TFbheJlKH7COsEqg+2g3yJEXrExEapCEOhX3SDSkqQvW7tzvrI0jz?=
 =?us-ascii?Q?dNWm9/VWYuenV9ARf3awHa0JJEQLG2jKl2g3fYj1poJzlOezETyvdFciG5GM?=
 =?us-ascii?Q?CYBXgLkpaNdh3qCMeUvYwV4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 83309be3-3f94-449e-0c40-08ddebbea9f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:48.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1URQw4aoRhMuvhGa4TA/3h10pqB1lwNd4KSDV74t9yE8Q42hgBz7D43wYIL+vP7lUscGnIIj05rlEfdPkrAArFHsrhunT5HoP3iiAvg9Sbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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


