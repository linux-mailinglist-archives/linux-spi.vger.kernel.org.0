Return-Path: <linux-spi+bounces-10411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D63BB1F86
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A4919C4D68
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9C311C2F;
	Wed,  1 Oct 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="bKyvCc+W"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1430F53C;
	Wed,  1 Oct 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357449; cv=fail; b=WrmL9MkuL+tnn2RdOKXvhb7EvnVEr+IgWdN8i71DzQYWqRY/k48466HEhLN5YiI7ac8LAmFY9k+42gbUsRY/SIFpNguLTpd+YHKXH67n5yZzh929r1/GNUTKOlb1EdnPKWTlY272dCyFgEs4LKM/0WY0u/ZygqU9oq18lFxUGEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357449; c=relaxed/simple;
	bh=4vEupTlFblAxVYLWw8wNiQeHRVE4Pd1f1C8AoyYUpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/ENeWff6PBh4FoZviLMnODOyAe7PjaArH+XytwxbKiNGjR61aLVmFwgyoBZQIH2GgJc4Hltq9buSvWWcCx3qRLaP4548/zBlPZQqMOcU8Enfg2crHF82t7lIyVQvc2PCRvN0H9bYjHOv3nnPYvCsXo7HHyfQbkNuToSaUDFq1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=bKyvCc+W; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrQtDkLKk8TNsd/RKxSl9bRiIRqui2dId4KFdWZq1uPHHVVKLKdgaasssIcx5bYMfsRl3WSU9Vs3RSTUXJvMCq5gpuw9rkt6RWjr9yMXGdjaHSs3kyiPetdinihX8GijpRPEKB3OvJfZ2CgTO3Dh/PCYWg+6cEwCBUtWrXK+S1cIo2lG0Vk3QeWJg00HT5jceZ7y1zlRwAM1If5MyTw7XyXHr8WWQW3CTZY/e11K+hE5BIUA0XnJgmtK036q8Q0T4YsSQctqIP+EUxhPTczx9bcc01HV54xdoDlU0RuPDQ9T+od2Mw+2151xjvb6cT9TLfkwxbRRAQ9nHYhufh8FeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=fRxyO0GmfWLmqdGD0JM5TCvrJrHMooPstX4ZK3kbAPDTgOdjyIDFY9GI4H5LPGT+6wZfZYXEncpqruVcPZ8VMiU75NYlS07erzA6eIQb0ESUY15hSynuy11SrkMQYXGev8EqsCcg3wNmBI0QDbQ2sI3xUI675pm8cYlXlIQ395zXLcj7VdLCa5euCC8Hmq25xnzX3eEUWINIakkBk7jwMZoQby1VWdU0BZckeQKhJBM6y5aSaH5hNt0SnUSqpW7rs8LZsQt3jX2Ui+YvGeWuM4oz6CVy/eSA1qRfVXY20li/JYkTf+VX4YoXgUmuACzNTyChbMZqHP8Q/znLkEGWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=bKyvCc+W5OrKQW6/Y/zD3cZxppJEkUmxf2oiB0CXLpAf2+XcnyfQTcvDdlV7rGUlDvNKHLox4hez/6dywCAHYHKPs9QUxidXt8SQfympAL6JyNxtLg2BW1unN9qQlP0FW8hKcGIJGZSRFBNLhurJ5IgiwlxJC57+maVMPe6kUEU1oOZlfZ7DtYAIQi4q0tgsRD2cdriwvjaCgRLWB4n+rp8hcuJ/7ZdMX/adJgLSgItWepmsClcnXP8xojphrREwS/RKdEMcDhveuI47iM0CcJkMU+JhMgDwUJ1A8QkJPIPGthDYAerTEYPBhIXRBn7Oi+qqRj0UuDR2XRZvQWCRwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:23:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:23:58 +0000
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
Subject: [PATCH v6 03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Thu,  2 Oct 2025 01:23:36 +0300
Message-ID: <20251001222347.3386506-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 63033376-9479-4f2a-c76b-08de013936cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOqq+wgpkAjZshEVcvDFxXsezWfzIISgRBWf/rDPbwUxRR62J3/RdoEhT7rx?=
 =?us-ascii?Q?9BVI3lfzVk3ZrPHePQZfswHxJHblQxieGnGZXwiDnbt4mCFRT6mF8qlXsZkl?=
 =?us-ascii?Q?62hnJv/L5L+6CUN5f+rKtP5a2tdAK++7BGge+PWW+TVT7iE/qfGGovmOLtT5?=
 =?us-ascii?Q?na8iOSmmjlOT82e3uba1WgcwOzOhnNAkA0e7wyL2kKeBd32Nv1BYZ/NIflt5?=
 =?us-ascii?Q?yC1mSg9Sn1Nhqk/GxEkoEPzUF3fiw/3LxavcMeU0eV0DwyB8cThvOL6sQ0k0?=
 =?us-ascii?Q?Za+uAzfPc6N/oDj6e3zwIcwwws3bu///cCBZkKoqAJG9BpgWOgy+HCTxPRWD?=
 =?us-ascii?Q?UdrLhBlSi1cHzMMpW2lWD9uVVNz5a0tP6K8DP0XNJ79/i3BhegwTs+UG5UeI?=
 =?us-ascii?Q?9nV59hRWNfr3PYL+sSIGHUQCjSoKAalIGpp0pFrtRv3eeeU+ABabx1m5fWt5?=
 =?us-ascii?Q?4/YaOzmJfM16mFR5xg/ttbwLlsGmaj5RTF4DG2YwWBXHj1LytpZB07qmOpLt?=
 =?us-ascii?Q?cL5+vbgmh5U9DOe9tn2ogE9Vx96+fIiTfaa+oH0SbZsaw+SfoaVanrlfA4dS?=
 =?us-ascii?Q?HHBwKdOuQVdDDGSnqwNCBr9KRDfDsgh2wUFoqgrIbQJCuB2S7A0AzCrXeb/l?=
 =?us-ascii?Q?c3Hrkm7D/l1n4FfhGVbrQaTly5uPCaITjqdypNieQAjkwljMcdtE6USgGvdA?=
 =?us-ascii?Q?Nzk5b1ju1qe0dOtkLkCt0cvbdvFbHNrSEUvC3xGR0kSJFsXAMpbKO7gHXWXY?=
 =?us-ascii?Q?akDzvKrFGyz+zFuGSctglLv1aH9FrH4CHO04jz7KAPofWqV/HBGM0PElvvzl?=
 =?us-ascii?Q?VbrGs+bRWPb5PnisX1U9upvR2tDNKYC75d70ryPCDOBrxTNfsWb7DBY4LAFy?=
 =?us-ascii?Q?hzC62+O5sljojdYQn3ZGkgtwEZpxIQ1hnVKYgH+ChDYMXQvl19n5MenoKWvF?=
 =?us-ascii?Q?pUo1QGxhOpgd2U5A5kFx/MPzuIHVwWJfVuOSjykPEfMucl4UoeoB5OdtokdH?=
 =?us-ascii?Q?CXd0G3jEaxEXuWqhRPZHiDMJ3/8d+U7xz23dImoRxaDKMk+NZaYRVL9e9eBl?=
 =?us-ascii?Q?wdTYeXgvAVlWrO4cVe143uZvk5rY+DOHcbn09GZVRZLHNGmJZf1hicvG/NAR?=
 =?us-ascii?Q?BFYE8wqDf5stHqPT3dsnrq28uur6ot3K7ICNoVnnVhmc0CBcih2zva60AC9o?=
 =?us-ascii?Q?VqvkS/AEW5UkkXGgzkUTCpiHdmuIki0BzvCw72ZpYwzrsxiH5zLMmzhHVi2F?=
 =?us-ascii?Q?I5VtzrnSha46G9Co6ImLMbiwENZw2DdpqWPL6LtWP5c4rjR/5I00om7J9kKA?=
 =?us-ascii?Q?/F0Awag5YKEpfpPqdy6jchdGwuBoTSgNJ5kpXJ6Rh4y5xlnpbPux70YVcL/d?=
 =?us-ascii?Q?mIkl6WYsTfYx3/pQr1xQQ0eCw63yJ/hG2QHO0QVSeWiVHgEp7CPwaT/HyEbE?=
 =?us-ascii?Q?yL6+N1vEeBPLqk/yIPplvVJJX32YSic85cGY7Ow3M4mwicWa6BOHlABpvMhA?=
 =?us-ascii?Q?L9WIQmJDXAXS0vzLG3pF7AzDYSYGB87xtPll?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyZ/rKCMJZnNsdSrmprVMRAEFwgWgSDZg6FHC4czZO/up1VKQ7sI1m2QB4SN?=
 =?us-ascii?Q?rJWyKv3ffriDltgkgbO2xgGoagnagWczmPgwzkXuhHj74ypuLKB0Zy/9X3UT?=
 =?us-ascii?Q?n2LdETGzZLwgyQdyD/9VLuamMvRA+M7MjVDcdULFUsdEaEqcuBoCva6N6gfD?=
 =?us-ascii?Q?jyDwR4F0KhVxX/n1+SzWb88zNK7Q62RfuH+WSTNDNc9pFEllICPru/UQXuLb?=
 =?us-ascii?Q?dnjid7POQErhIrXfKUdVzXuzBamo/DQBKc9EHcvlhP2mAuydYuv6do2lgi22?=
 =?us-ascii?Q?8U+sqPPxHJ6CW7pf6KJWRPz4YyKmHFubQ3Jh30gtBRkiSPPwS8CrrotbnRxz?=
 =?us-ascii?Q?tDQ/JSz8IUKx061uEcz/x0CTgZyictu1e1/cVJogWy/YdTb4CqpqZC/LohLt?=
 =?us-ascii?Q?Ewnkb9blw/E08jSflarod3dg3AGCFKAmHcvRNUX9NuH0MXrySB2GOfkAdak6?=
 =?us-ascii?Q?ZrOb8/Gak8elOWml11AxD3s1oI1UU36yzca+qG1WQANUyLIP8KEhkeq6T1z6?=
 =?us-ascii?Q?+XiVicawkp+DTxT+KgboUsU8Y9NV3Lpzr4Hmw3dStSLj+E+cox3Du80C8REU?=
 =?us-ascii?Q?/nazezfJtZEl7CKrNI6/WVrkb4h1uD25EPdOxe+5Qi0QL4HHglsLCJtHQ0Zm?=
 =?us-ascii?Q?AuXHZtPCfxEUmFMPk/vj7AnNFpbCqcL4KxNP8CX4XjnE2epAOFaQhXIIQh+c?=
 =?us-ascii?Q?O/QX0pQcU5iPNNjd2C49OjDOLgASSXD9T9xujWrFbGuEmi0++oQ2FQN4BRCt?=
 =?us-ascii?Q?9ongOolY7Ud+Yg15SsoPvV8B0M/KyufPhM6o0NUoZruNYSRl09UKq3LmDymy?=
 =?us-ascii?Q?UsZ624FquNPRDD35x6l76eP2a3rfGVVtNJgBpolJm88+Ym+Vy7K/IplUajEy?=
 =?us-ascii?Q?UR0qtblIGtpkG7BneIwz8K57qUTuqbLSJfjAjSk9v87UuNU1YVcJWDYj7NIQ?=
 =?us-ascii?Q?NwkFtnk4gU445S3Id8YPKd+7zHSYUi9k23bQhgQ5Jz+mOtk2d7Ga0ZD6lW5Z?=
 =?us-ascii?Q?ydgw5gfilKWbvHZOiKt2TaUxBrDh+REt+xzvtHOdWbBocSx9x1FoGZtiXrLm?=
 =?us-ascii?Q?dGo8V5PpN+g4nzQHcfdmKr8A62ELTlitxwBWnuYnIeiqTEqFdEZY4AfDpLEX?=
 =?us-ascii?Q?p0FPMC1YMJiv2tnoI0lm8ZNqKmELPAFc05WvwpnovFC7vVh6cQYHN3YgNiAA?=
 =?us-ascii?Q?bxFFWDQza14wXlRQAGIymqdVOck9oWKznWwFN5MRxbyKZnEPGcv3MuxgZvc6?=
 =?us-ascii?Q?A9m+80wdG2ZW9eTrCUWSYovU5YPVzy1EXMxV9w49tGuKNUcOWYstnyHlzgSQ?=
 =?us-ascii?Q?p/9cytJy9XpCaOv/5BTlVILfddi9aLoRm5zzz4Xb7v6NTFSyBMZnGj+C21C+?=
 =?us-ascii?Q?ScCR+LWlkc/eftNlORfaJm4CMXfLe/G8Kvq85I/3zy6gufLNS7ArI/4fIyUS?=
 =?us-ascii?Q?lzg9o4FPmb+y1aDRGdja7bBSVBngOuYd3G1WrURKiZ+W7hTCuL8qXSRXznn2?=
 =?us-ascii?Q?cL5ICeCZYRIbIxJtGW/k4aUbKajabOSYUESwzIvx92yHntS/b6B+7GBv1yPX?=
 =?us-ascii?Q?jL177pI6SFxXbG7FwZgkCYmdzYxFGgqxidvMRGq+sKgjSDXmNmr+4KsUFNzS?=
 =?us-ascii?Q?QY7d8KAKHZf/HCHZ5zQmIQU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63033376-9479-4f2a-c76b-08de013936cb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:23:57.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky6rkYKiXOjijbts/2LaI9iBILsP8wPI4Qw11efU2F5hZy9YzLyeJ2xuLxHeFU5tudGn9vTBZQOs16tf/k7uZnjd4dk+3P/HvmAJolslR80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

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


