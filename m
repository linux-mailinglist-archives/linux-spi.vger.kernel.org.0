Return-Path: <linux-spi+bounces-10413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC76BB1F92
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F619C4F81
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74682312806;
	Wed,  1 Oct 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="NilqiBIz"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50915311C38;
	Wed,  1 Oct 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357451; cv=fail; b=MujkXt7Xe854g01zo7ZjJvXmX/P6RnVI9UeAsO4qTaWcQUfyLTAx+w3fWepYGgOd4BT8YbPZE01XGCitnrEdP8tYoywk8pgTbWyt1oD/9T0nPST94D0VkvnGDFALhrsShcZ5PPC5t3ExkXTM+B7JZmdk1zQzJgDFBq+dtIRUOqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357451; c=relaxed/simple;
	bh=FMrVF5Vv1XqxxA6IzimgjaqpoFwdt1ebmex3NhH4hkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUJIXRujAws3hs+PoJP+A0N3u/dGmrQEjZXYvHV9YMSqFwnJRpVGuBf1RzM8sQM8ja6a57B7Y/X8m4Ekqubs1KEAZJNyf6N7ICVxFDKJZu2zNfF1bh0bM9c1ZPzzTV/KNj4mAcuCQK3FTSeB+zB0z1WhCIyDJBVOAOTR/F37XQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=NilqiBIz; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW5s4sAsaBuw5w1o3mx9Lgp0UlogEGdpmXE8JoeqDdO2YvA+P7iZ/Ok1WNiudlYqmtacehVuqYSBTe+wjRn3X4dEq4C9xRPrnQsFwdvoC9Zv/LT5h9626uWg/ewbrnoE5lxsfD+VI/0n5aE11bItmSCgplU/w755B1cBc7qh+Ae6aTNUy+6UiX5sWBtquMQNrvCTFtQN1khYjwsR6DAHNTgrtTjMCFZFO9QQbuF/4qL/UmmAx9nSAumqWaa6lZOBXlME1Vk13EmHein9lYC265D3k4SPR8Gj/gaNUlfaPqtGvEfFmaVpAI8Uw1mOt63ofCG7CIG/4JDfzoGwAIBwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvX94nIt6Ushebm+TMBumijXPGW+xCDBR3BCYJgUfgw=;
 b=pidknm4lu1YhsteLRdafDRxvjmKibOsRDiSrroihUy/MHGJpGsfiuk7dDidgHZdgYgmz7I29LYHnKIfwcUo/VpJkunZT+Rypbgth3fbSmjIF6kb2fXlbYpsO1Ejo8wvmvIZt7ETrzA8tBqwrYyKiHzWCfzDCUacZRBPYlZGgXlZ84E+IYE0b3Y5GHVrSTqFOVviHYfpepaTMmGGrG+1yzmGdXDeRWg9qdpp5hnKuAEd1DMF8OTsiVq30I9SF0upUpacG47eKvAmg8WisAoLaOxs3VrNxMnT8kxekRPHsVsZjdjRlpjOZGbROZn+8fMeXhC23MHyFEVQHBpdvXd/MWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvX94nIt6Ushebm+TMBumijXPGW+xCDBR3BCYJgUfgw=;
 b=NilqiBIzpmFniYrkLjz89uWtqDM/bvAoasTm40Iq+kaCgBhEBz7cp2FwJ0zhDoAQwnTK3P27wN9M/TAK96sK+FcaxGUEFtQQKC7af3MNzZOq3SWdf5rT8HyAxq2/Zycwdstv4cZaxY2cZWZCTnz7JE40g2X0ZUzfyZKLHCT6JsfMVGrfNBpN8gUMRXTo6J7w+PQh9cSG7o/ZFZmLkncM5FcejUMCv634ccGAjEgOLiZ/BFXaIchtawSFYBMGLQTUHotj2jDcav/j11l53S3DOSONkbIQbIPNHP1uCsYVLmOgeu7ary/kYpjeru/We/A77rDXbefIThDBYqXUZdo95w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:00 +0000
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
Subject: [PATCH v6 06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Thu,  2 Oct 2025 01:23:39 +0300
Message-ID: <20251001222347.3386506-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c27138da-c26d-45f3-0ed9-08de01393883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lAer/KtXAY/KY3HW0Ru2qlOEq42efhnk4xXpif8VvEdaY1ABQBqpqKkXoDV?=
 =?us-ascii?Q?pZjRq8bgYc2uPHFtJApphAQZgiaoHyylEQ3E9iZECq78V4C9lnClFUWR/QoN?=
 =?us-ascii?Q?oRZLDgkhbfuBscrEPLxajZJHjoXb47duweNxklDsLV2oJK8lMPt8DzePDYs1?=
 =?us-ascii?Q?zHzxWUPI+OWKK0X25AHGOIH3CoTS1rz+rsFkfBn5F+YNN96DlxL5To2DzpvO?=
 =?us-ascii?Q?NmDyWriRVZSgwSHITsqb7EUKIq23sp5982j4Hq3/ngL9P6QsZ/aiQU7jOs//?=
 =?us-ascii?Q?LReUtQN/h/JE/4OzLLm7GKjAgUegRkasExmuKX3Yae4FFdOB0ohbvDgWzERU?=
 =?us-ascii?Q?61oJ1cX6YIKfLB8v74ckF6OdTbmM/qbskNsamRtda+wr2Z5ZC3hwCv+9rYH3?=
 =?us-ascii?Q?DSaEKF/5SoYm8GAYrk9Jdk6AOaX+he/02bm76396qK98DXgxI4pfHWbhGqWJ?=
 =?us-ascii?Q?YC0u17QUQdK9Xpk/r5XXy9I6CONbcYL5oNqOVmgvSKnui8lQ7OIx3FTHrrNV?=
 =?us-ascii?Q?xFJf8UqpAVdh27fyNxI0CZ9Vjc5wSPXsqKw0A5oHp1QFprbGuhzozE90K9/A?=
 =?us-ascii?Q?K9+gw9UK+o3tXxqRomL7X3JYwijw30XmXkLzpqBaEa82otB5iHQFzLcxoQK/?=
 =?us-ascii?Q?Qgg+C0TFqNQwCJYPgO+AjrNGDkRIcwrcI2BC2Bs4ZF+bW2jeCwaYyAS+tZa8?=
 =?us-ascii?Q?1D4ir6YRZhu6FdUOFauFNJVR+oToP7j1D6U0uFZgUHcl0eF0OJ2vG9e77R0O?=
 =?us-ascii?Q?iNKUjseeA9TOTOz93e+2/TrNE6I59hohGv5M8TZ2PDK82mlx9y9N8pCqP29T?=
 =?us-ascii?Q?qZtIojn5z3NwBeFPgM78JRvlEN4AnRSoT0NHoH9o1rAid1Xad7R9MRXN4CLM?=
 =?us-ascii?Q?1wj+E+Re0bON2yDVXRHZMQGAV/vXomWl9IFoz2AsBHWcScxjwrA0uM8bQEtb?=
 =?us-ascii?Q?cpntTVc2e+CnUZ2EXpH4vngIRaLKUV6u9qgzqvYcYNUDwoJSaa0EjmqcYht7?=
 =?us-ascii?Q?gQr8SPQn/FjuVaPefJKCif/w6ahlznjaW82hN8rj/ToJnJgbffvISwAgiCBO?=
 =?us-ascii?Q?pl6gmoGnnI4RBk+XDdsFo7EII+ns9WZglugkJJgnMPkuSEG6KZf+HPv4B9CC?=
 =?us-ascii?Q?x7P58+lOMMskBR06FJMieUsO2YmD3tC8mVz1CLCq/udeJ78uPEuEymGCaVXq?=
 =?us-ascii?Q?wMqD7LTTM0DokUtJN4eJiQ+jB4yl7Q6l1iFNrjKkcU4F6a4GtSaA171CMfIM?=
 =?us-ascii?Q?kyAiGBojwm2xxbJkQBDakUC6M1AYBg5/A1cz/TZlGUG3tjMXvBoDiaRsNq7n?=
 =?us-ascii?Q?P6hD0VLcp3qpgKfeUv3bEIeOWkla8CHVa9a5e13CzsFZFWIJGJKRucZVxPCS?=
 =?us-ascii?Q?5vTVYfXlpaG4eVRKU4A789fTbAXHed62k+7t1MgrhBORRe+du7b5yoo/RxfF?=
 =?us-ascii?Q?z6BeMoIhHNgT7Lgdbqa0XyLRk7GoGT/7YHnHRzp+UKTzg8oXRh2M5AEOVb6F?=
 =?us-ascii?Q?7EmQj+YrPcRWJgQrNOW6ETMS2SW7XDHoKI/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4Xav3J74Vmwbs6ep26qhjsu6naYEYbOC4eirnpOsvQCjAUg4XELaU0z5WCb?=
 =?us-ascii?Q?c7xSfxJ9e84SVanO14qxM7FdrAq4OaVO6AO9xWn6tRB/L5btu5e6xL65YG7t?=
 =?us-ascii?Q?sMcc3+zOVTVcUKBHLdjgIrYwv/XhMB0YlGHT+3RNokYRk1sRLPdBlb4zfvIZ?=
 =?us-ascii?Q?lAk7qY7z9Rh8NR98X+UMotW/7rdTTJUn57D1357Xe3DE5tupAVnZxbFQohqh?=
 =?us-ascii?Q?0Mb+kfE8X/qDzdU1GVkdoENc2oRCwe0uB95aGrpVzyQAO9LM+3EW9N64+VUu?=
 =?us-ascii?Q?2uOwtwF72rj0ZnrKV8E23XPrxJjaAdTL7VOqhj83Hxq/rNI4E/eVjSuBf/Ji?=
 =?us-ascii?Q?hIjD2KvZ3YbSEvaLSCmW0DdhhlpcJuFaL/lLUDyZDbe9NoYOwUk08q0NrWZ1?=
 =?us-ascii?Q?wKSLxe/9PysxbwzwfFJ6dpKZcczbSK/axvz0zhrrRp81pdgJEzY2u+XOu9y0?=
 =?us-ascii?Q?8MuwalOzkrBxxveupkJdJ30SNRzIYsyrZVzZcvlefD7pb5GRMOM8vLhYiVT/?=
 =?us-ascii?Q?KKG1Z8zRMrTngR8Jh58VM33F8k82gM5DMBxuREd52WgU4vWoAqN7P1JHuPzJ?=
 =?us-ascii?Q?IV/HCjI01Aj1lY5tgav1vClFz5ltdujHLdMHpNFYfVMOtstd8Zb5CA04/E6U?=
 =?us-ascii?Q?p7PapfGsqOMemr0gNR+x30zejHDVIwswJ3QXyprVbH5UZdt80J8zDMU9g/iN?=
 =?us-ascii?Q?VAFMOe8JGXb3a5pnN/CMx+EZMCqQZEddg4iLED+OOeotf2iR7wlQVAKvDMa9?=
 =?us-ascii?Q?9y/m+euTFF0kxnXTJYLPbdasX/2NXkpE00CX/PETAq7JFGKU8YW+gWV9v1cI?=
 =?us-ascii?Q?+NUbEM6OPR++tQRfgsUJnxarGnZL8BUHwZ78Sq+GBb20pC7tgRIkNVbxuN+a?=
 =?us-ascii?Q?AjpfXiILKZPBUft+/bTOOND/4mRRedYuJrhfpvicpNEJGvsFRd5o8yiHYRdB?=
 =?us-ascii?Q?+/5mcDvvlvJFQCc+Fdell+3/nNwp+G42WaxnCDILzD65y6/JNtyYfXBPoBGa?=
 =?us-ascii?Q?SRO4rFuqQPmXa0P1mG9dwCcR7ZXboL4kVlCQa6herveyCCKD1LfgqLe/kFMo?=
 =?us-ascii?Q?60bacFvyZXWjCVKUsvVQKlupA0puZnqkSVhS7s0/NRCoubNneKTw17+DSuOs?=
 =?us-ascii?Q?67ZlrF3iwBlm8uB9Y2qPb07lCDbgA9v1kxoqMja5qmSSEa42lA7fMgaM2Im1?=
 =?us-ascii?Q?VcKhvbQ5WwzEmhHQ4x6yGhxHJG1w5W4//0DslsiKa4GhwoUWd052uzIh2uwE?=
 =?us-ascii?Q?G829LQ7X9soC2yJ9oEsMu+xhGxaNjbM5s+NSTLQ0DdJlVI/H5/xOpWhX28FX?=
 =?us-ascii?Q?i4+v1Km9IgJUc4CGqa67t2zz5xrKoFv5RykkSJCeCj1zlGEbkFLkGjIo3dPo?=
 =?us-ascii?Q?/O9Xq5liEexhW/uF/Gxd2KhTtZ48DXGK/K4MaKg+XjqP9hhz6uZYENYkZ92m?=
 =?us-ascii?Q?wzw+zk4hdSArK8TpotRmHX13yvcm4suEliICsyTsdMQx7drBY7i9Kb1TnT2f?=
 =?us-ascii?Q?Af3Noor2n4ZvdJLf1k88TUgB+hMj4fNAMuTy6FXSYW8lv8e+GhIyJAxEYfiy?=
 =?us-ascii?Q?JhPUWknnU/eKKldBmIeMg5GgA9GVlVrPD6+clPBPKgahjktExiq7oLFHCmmZ?=
 =?us-ascii?Q?eg/Nd+9fzzx/AU7aEa8QBX4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c27138da-c26d-45f3-0ed9-08de01393883
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:00.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYoj9UsFuvZezWCSkeKgF2WrnIW7Ga2axbyqS8NoB5grktgPKE6hgRjVw/JllmnsSEbyLPkb9aE2FliHfzvNMxp1SGDz1vmqEnsf79kmbeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

Attaching UBI on the flash with more than one plane per lun will lead to
the following error:

[    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001350] Creating 2 MTD partitions on "spi0.0":
[    3.006159] 0x000000000000-0x000000020000 : "bl2"
[    3.011663] 0x000000020000-0x000010000000 : "ubi"
...
[    6.391748] ubi0: attaching mtd1
[    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
[    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
[    6.434249] Volume identifier header dump:
[    6.438349]     magic     55424923
[    6.441482]     version   1
[    6.444007]     vol_type  0
[    6.446539]     copy_flag 0
[    6.449068]     compat    0
[    6.451594]     vol_id    0
[    6.454120]     lnum      1
[    6.456651]     data_size 4096
[    6.459442]     used_ebs  1061644134
[    6.462748]     data_pad  0
[    6.465274]     sqnum     0
[    6.467805]     hdr_crc   61169820
[    6.470943] Volume identifier header hexdump:
[    6.475308] hexdump of PEB 0 offset 4096, length 126976
[    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
[    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
[    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[    6.529294] UBI error: cannot attach mtd1

Non dirmap reading works good. Looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus the address
passed to the flash should take in the account the value of
desc->info.offset.

This patch fix dirmap reading/writing of flashes with more than one
plane per lun.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a39c3ab4af5c..5ad3180ac6da 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -726,8 +726,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -860,7 +861,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


