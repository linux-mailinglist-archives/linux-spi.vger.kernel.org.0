Return-Path: <linux-spi+bounces-4782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F7975C48
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2024 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD01C21DC9
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FB144D18;
	Wed, 11 Sep 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VaflUZGE"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970F143C5A;
	Wed, 11 Sep 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089173; cv=fail; b=rOo2lvvBAz7Ei77b2vdylc2HFa/P8xGGf06XNR5mF/VPaxMpF557S6aEZoWWtl9C8u+y/BhKBDEUjkk1Wt7kD4hsoa9s3Ls9DqLZnPYH83JOg+KspMP+qZ0rFAz9wPAdj1ZjIEbcjieuvfhbP4sDLj75hZWREyU7zZ3MJ+foMV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089173; c=relaxed/simple;
	bh=2RNsDEUuFpbFQ5xlfdzDRWj7RbTO7IY6IZdgfd32Kgo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ugvOAUiTvNprOm7nk5AwvFwwxfSyH7gAySIeHYDTG/uIhhMCZKym4k5mTCIxpPijcgVCRdmJvmZahzRdVHigZ0dfD/A0qGVIyVqDlcpraAWQVmne/ep6a0ZnKIAfmF3PNZHbGCZjNs83hBNzN0b/VFAdMpVcRhKuvTMEH6QJ6ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VaflUZGE; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU+RHkQpyfaU55JIs43vHQHb3Zs/TIqFY4eFKei1l6BHkn+TotRVJ1Qyh41I54QGSyLLLnAUMOXm3XdjZYLbDn2AQbY976IKGMfvmRtHHVKviK73ywigEBelZUCqtLhu5tbD6H4uSb7gRP2HgDRHJVlM8B7aeOJ0LlY5GlAcHXcuMhPJWECIhuOrc7DzORjZA0BgQ5jS3TyI4CmlEYODinX5OQiFCtkk7GUYktF8861fg3N7Gb0M8iUh2b+RVmcKsK8VCeOj+53Y3mx9tydmhjmDSlcOddjy3HdG8idkIZ1nDBMYdSu1KEpBUgrqe9kYpu7Qcepz1vS1xlvCZJ6CRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNG4Gqn3LWSw6tN7q69azjGhbIMCL32AuhYSl0W01oI=;
 b=hbrcpXnNwtbxcYWBc5LbF1XyC6nHVNZhlbg/M7e1tFyhwQWbH5LoDid4c6c1hQn3AKSGMV6f2VENLGBjYNBj4BMSpu74cxg/P2/TaVvLWYnhq5uoQoOUYbZv8umShhLQdExSGOa+H4pslNdE05cdBGXvcgM4qkprTGEyFptbp9ILVe7yXC6SU1L97lOimhKHOO+Ab/a+0oqJPVmwW1STsO+BxDgsnuvfC6RFa2oubc864224kCa0BcNwMr1OqSd4ipgnlffqm/RCChlPEBz2j1ZXKMQ89vnP9hp4P+kAVyPqJe953vATrZvyQmKNi2PP0Yy1be7abTi5l/4v8OvvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNG4Gqn3LWSw6tN7q69azjGhbIMCL32AuhYSl0W01oI=;
 b=VaflUZGEQAqUsT8yp5DnmfBSxkl3Yr47dmj//D+0O9apKUz6u5N8kaQoZAgxGDuFkW+U0oGfWJfpk7DJGJroHykO50m02aQ3mBsc9ocmaoHPoRTwX5i9QXIrZwYE/vuIwVe3lr4SLXKj+8rX8Dzcj03LTCdK+kbks6AILZHiYUMDKPkzL1jCNJWl7NgrXjJcy0jeLDII/MYvphc5EgAY6M617CWqfA/d9Y4t+cT/hDA3+z6P1bbaoTCeIfTCceHsadGZqDQYK6VBbIr9FGYaJHWkygYbtgsEmjfrdUHJyLtcCXSi/jKQclsfl6CSRoVuCgDDPKqwaJMz3RAWv6/Gag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 21:12:48 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 21:12:45 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: stable@kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: nxp-fspi: fix the KASAN report out-of-bounds bug
Date: Wed, 11 Sep 2024 16:11:45 -0500
Message-Id: <20240911211146.3337068-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB10163:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d580abf-f1b7-44c8-fd3f-08dcd2a67b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UMkmehfXYrizNwC/mjZ1lhSeRYlum7imPDqX0kgbYzzkW9Pv27eY2dB9sDk3?=
 =?us-ascii?Q?NeQxolUmN8dD2yhsKR7qTeb0rpoTQqUAmPgSkkMJ+MFYftUByalJX+8TnBU9?=
 =?us-ascii?Q?S+1Y7TC4Y+G1ZalXYY6bmBOpx5SO7VOUmOWEm6D44fr5fwKyPinDCabeD/R7?=
 =?us-ascii?Q?eSEpcV4KbxaOciVMaV9DItRMvNDZYtSJbuTT8g88pwRewcLFOOO+qk1iBpXE?=
 =?us-ascii?Q?T9ZYBZUg2XaChJhGv75WFnncW72cO6PUnJyvEyNQ/f7SxfZMeqBx53k8T1OR?=
 =?us-ascii?Q?lrBpJgb+JuDZwS65kHNQguQH9DHUscZOBncYNh1PiOx0C//ZjiX5L+FvOsVV?=
 =?us-ascii?Q?o0wfbSQYHIMP6qoRE5jmTiPlPiKFA3c8pu2x+TU+B/P44Ebfv5KpBEJZT9+K?=
 =?us-ascii?Q?jGbm9aF0znf7iatbVT3xNRXQPcr9Pms3q54g9T6nPmSf2BC/NQkAOwleu9u4?=
 =?us-ascii?Q?34J8XrbDYngKxpHQ2hj0YEqjIVOz1Tx4rjSEIWR/4kHq4kzwF6qEwfA7slFK?=
 =?us-ascii?Q?KZNM5tMOOrQFnFBsztbnejqOlMIaGR7Xh7OIDLkJfMgqbPfgOcxAvVnKv8Np?=
 =?us-ascii?Q?a8/uz8Q+zNHs65Lzr0y3CuBR0HtC4xuOp4o9okDTuRo3SHZrgvpyOBnoOcdW?=
 =?us-ascii?Q?n6G6fLT9c9LNCuc3WGL3C+PKwDEDUWscK1eiVctTU2PkHEI59ycf7R+bZ195?=
 =?us-ascii?Q?KTDTbaPkdF2BRutwHlLzxc0AyXZiyPpQcUqqb8cZ7Xto3xz5ETegYDrT3nEF?=
 =?us-ascii?Q?URTlIgkLTTAKxK5wDkFoKog816oLkRYoQTCUbdvtWkG3mr0PXiujNonzRE9D?=
 =?us-ascii?Q?lmURQzcIOZvdwzwF1guY+J4nk9YcCRZwyOZ4zNMGmUAkGBDU20a755R+1KYp?=
 =?us-ascii?Q?7+VlYEUfQCavs8Iz+1+LSDD4lbWcrJmZjCrVlwgm/FcO+TYovZo/2u9beQJi?=
 =?us-ascii?Q?4NuRhoYxzRinXtHlRInYuuHtPTbrw23m+uuLVLfpfuxtQWYipdRcz0sAdz4W?=
 =?us-ascii?Q?aiHoJJeAI7knsiAaLx/qBKTBKzIipzl6HGoOSBH8RC08vERTSzh4ZY0HU6x9?=
 =?us-ascii?Q?QiA0NbZxg6KPJEbv5K32SJBBrTZWuxyr2n/eaiIrzLGjQvy4hQq+VOYKT81Y?=
 =?us-ascii?Q?qP1EHvDmIN/HxBqrhYoU4YGHsJv96ys4bXU1w3NOQeHPEs9898iaTRuEqVYb?=
 =?us-ascii?Q?ySgNYiO4rm1ADPvAxUF6Zc3NPvyNvKavr35PIQxfT8j1bGMrVb7iFhGVEFt1?=
 =?us-ascii?Q?9Rh5naelOycPh+MwzMWgRVrPXpRZ3XVueKlqWLai7oUxQ2VCyJ1bC73qoatp?=
 =?us-ascii?Q?NERDh/6jLG95V08UhvgvgaFcD/vhj0VserZ9b66emTMTbH1T90nriQdTfqEn?=
 =?us-ascii?Q?UOJ/ygDR1rRVZ1P6fUvAyjhQ4yf5HNOcQtL/OiAMPj56DYsqCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oxt+A3vmaUpg8OWti5O50ycNJIv39CHffoBHlELrO6iHmXvXp6W0Y//+/Avq?=
 =?us-ascii?Q?oIID2bvV25KyDbXIOHSAs3pvmAfbwsz+4Q9Ih4Lc/4JfoAUg+Oh/vVUT6R9Y?=
 =?us-ascii?Q?eNFsfHiA/39m6oHhNDI7zBRPkm1POLAygNudqy132Zjfofg32MhLtHxzyNFj?=
 =?us-ascii?Q?Fvtmox+MnKIkHYvVnlCwjnnO/efKS4uNGhUy9PGlKx9L/GIuSxsWTdN4x3M/?=
 =?us-ascii?Q?BbnCSnTg6loOeHkAhtpiN7xO/qTxAmyhRKPhXJxsDFvrmlBH2ezG92RbFhE6?=
 =?us-ascii?Q?iSVY4t2DT8kdCc9U+dWTsygHXEUgJGeY/ewchxj66NFmUUV/h8NSEvuKprYm?=
 =?us-ascii?Q?yVx3F3vJVlxMY2fOvaiTzt4+MuGHvXnvMBhY6U638VBvS70stUFiTgzohFUH?=
 =?us-ascii?Q?Dy87kzGUa2rGI3hMY17zcwz9c+KFFfFNBgq/CwAkgMgB0JbbcWzD/rbO22tA?=
 =?us-ascii?Q?e4Bz2EbccmaCkHgNnwKxY63/I0SjSw9LOJL2yaBkOexBWjsTd5fjwUDa43IU?=
 =?us-ascii?Q?DKE+OYyxk5ZTWRgFYrmTG9GscS3JhO01lTyJPZNWEvXPOhrYM57+HhYMS3/q?=
 =?us-ascii?Q?hvLaB8Dqj1TeaKSPyyw/FNFLK4GmYI3KqnMvfnyQhAaFW3dJxFZBIMwd5aWb?=
 =?us-ascii?Q?NrxhAPOFPrUCYPVmc1ykuS2EuvzV7TizQqyY7Xcdm2yXELpqwAZ9v6r1w6Sb?=
 =?us-ascii?Q?9zzR3BsEQOemmgsFwCAbDCuytZ2BauLMjfllyNu0g2I3sCbwGw48c0Hey92S?=
 =?us-ascii?Q?DeGc0nNBAj1Zp3lSToK0Oz0UmAGy1hWTMWClfT1hPf3dvqtAhOOwILpa3ZxP?=
 =?us-ascii?Q?T3vAjOTPl5LSW6jhGcjHGxW2J/m1V/P4WCNl4w6LBxixwuCkKfOixdK/4p5J?=
 =?us-ascii?Q?dF8PMagoPZdA3BonL2CI9+RX/YuPeI8HVDZ35ntcMAaAu7tWy0+gln4WF9ed?=
 =?us-ascii?Q?GwySTWUok0F6udLlcR6iJ4PbF3fNtjUZNDPOOK4ck+MtfMNC1mVudOcm+tns?=
 =?us-ascii?Q?nMwUPYOhuglUf1G16HEq+jT/fZAprsG5RucBltqhzCZinyAYySfFl8Jr7PyJ?=
 =?us-ascii?Q?eHjt34m0u4TYhGj6z3gcgfC4Q0ZKtSpZLYaBkwBWqs+mnHUS66Axn21q6bqj?=
 =?us-ascii?Q?AuHWKHmOeGnLtKCK9GK4T88+QQlhP2G/nMX+XnsNedoxrVPTQRP3PMTmt+aA?=
 =?us-ascii?Q?wGoEEt0F/wXNdThetw4B7PKSLIgfbYfyfIwcULfRXE6bM4kl5VRpKchqcr9/?=
 =?us-ascii?Q?02NX5wATR0zzmXJa93VmPLc4FM46VbePM0vM4TxPSmA2znhs7nASG/P+/Pa2?=
 =?us-ascii?Q?4GL+uyi3xaoNepCdPb6zxDRkowybwXfrjnEGEozmrX2HbRPChAgBkyHOodVW?=
 =?us-ascii?Q?HpE0AAok9iw/vD1JvhPAM271Ao5KYhhs7BTAtegNrVE9C+ykhoR4j1713L8R?=
 =?us-ascii?Q?9AdpWZALQZ1C+lGfKvSba/8WiXgLpl0D4gsaJZw5/oPHG1kUMLkNUC8TTfEO?=
 =?us-ascii?Q?TLz1ZV5PyaQK5YUJwsqdzyXbVayS3NhBXsBRum+ODSv3To6Xdf8Zdwc4QtO6?=
 =?us-ascii?Q?ci2o8VouLZZh2nVaf8Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d580abf-f1b7-44c8-fd3f-08dcd2a67b63
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 21:12:45.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+821qPSTCWbKgchrCsntdbFdsHQn5/0xAwNhfjn+MoIFXL+LgDCGK+sPa1O0JEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163

Change the memcpy length to fix the out-of-bounds issue when writing the
data that is not 4 byte aligned to TX FIFO.

To reproduce the issue, write 3 bytes data to NOR chip.

dd if=3b of=/dev/mtd0
[   36.926103] ==================================================================
[   36.933409] BUG: KASAN: slab-out-of-bounds in nxp_fspi_exec_op+0x26ec/0x2838
[   36.940514] Read of size 4 at addr ffff00081037c2a0 by task dd/455
[   36.946721]
[   36.948235] CPU: 3 UID: 0 PID: 455 Comm: dd Not tainted 6.11.0-rc5-gc7b0e37c8434 #1070
[   36.956185] Hardware name: Freescale i.MX8QM MEK (DT)
[   36.961260] Call trace:
[   36.963723]  dump_backtrace+0x90/0xe8
[   36.967414]  show_stack+0x18/0x24
[   36.970749]  dump_stack_lvl+0x78/0x90
[   36.974451]  print_report+0x114/0x5cc
[   36.978151]  kasan_report+0xa4/0xf0
[   36.981670]  __asan_report_load_n_noabort+0x1c/0x28
[   36.986587]  nxp_fspi_exec_op+0x26ec/0x2838
[   36.990800]  spi_mem_exec_op+0x8ec/0xd30
[   36.994762]  spi_mem_no_dirmap_read+0x190/0x1e0
[   36.999323]  spi_mem_dirmap_write+0x238/0x32c
[   37.003710]  spi_nor_write_data+0x220/0x374
[   37.007932]  spi_nor_write+0x110/0x2e8
[   37.011711]  mtd_write_oob_std+0x154/0x1f0
[   37.015838]  mtd_write_oob+0x104/0x1d0
[   37.019617]  mtd_write+0xb8/0x12c
[   37.022953]  mtdchar_write+0x224/0x47c
[   37.026732]  vfs_write+0x1e4/0x8c8
[   37.030163]  ksys_write+0xec/0x1d0
[   37.033586]  __arm64_sys_write+0x6c/0x9c
[   37.037539]  invoke_syscall+0x6c/0x258
[   37.041327]  el0_svc_common.constprop.0+0x160/0x22c
[   37.046244]  do_el0_svc+0x44/0x5c
[   37.049589]  el0_svc+0x38/0x78
[   37.052681]  el0t_64_sync_handler+0x13c/0x158
[   37.057077]  el0t_64_sync+0x190/0x194
[   37.060775]
[   37.062274] Allocated by task 455:
[   37.065701]  kasan_save_stack+0x2c/0x54
[   37.069570]  kasan_save_track+0x20/0x3c
[   37.073438]  kasan_save_alloc_info+0x40/0x54
[   37.077736]  __kasan_kmalloc+0xa0/0xb8
[   37.081515]  __kmalloc_noprof+0x158/0x2f8
[   37.085563]  mtd_kmalloc_up_to+0x120/0x154
[   37.089690]  mtdchar_write+0x130/0x47c
[   37.093469]  vfs_write+0x1e4/0x8c8
[   37.096901]  ksys_write+0xec/0x1d0
[   37.100332]  __arm64_sys_write+0x6c/0x9c
[   37.104287]  invoke_syscall+0x6c/0x258
[   37.108064]  el0_svc_common.constprop.0+0x160/0x22c
[   37.112972]  do_el0_svc+0x44/0x5c
[   37.116319]  el0_svc+0x38/0x78
[   37.119401]  el0t_64_sync_handler+0x13c/0x158
[   37.123788]  el0t_64_sync+0x190/0x194
[   37.127474]
[   37.128977] The buggy address belongs to the object at ffff00081037c2a0
[   37.128977]  which belongs to the cache kmalloc-8 of size 8
[   37.141177] The buggy address is located 0 bytes inside of
[   37.141177]  allocated 3-byte region [ffff00081037c2a0, ffff00081037c2a3)
[   37.153465]
[   37.154971] The buggy address belongs to the physical page:
[   37.160559] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x89037c
[   37.168596] flags: 0xbfffe0000000000(node=0|zone=2|lastcpupid=0x1ffff)
[   37.175149] page_type: 0xfdffffff(slab)
[   37.179021] raw: 0bfffe0000000000 ffff000800002500 dead000000000122 0000000000000000
[   37.186788] raw: 0000000000000000 0000000080800080 00000001fdffffff 0000000000000000
[   37.194553] page dumped because: kasan: bad access detected
[   37.200144]
[   37.201647] Memory state around the buggy address:
[   37.206460]  ffff00081037c180: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
[   37.213701]  ffff00081037c200: fa fc fc fc 05 fc fc fc 03 fc fc fc 02 fc fc fc
[   37.220946] >ffff00081037c280: 06 fc fc fc 03 fc fc fc fc fc fc fc fc fc fc fc
[   37.228186]                                ^
[   37.232473]  ffff00081037c300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   37.239718]  ffff00081037c380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   37.246962] ==================================================================
[   37.254394] Disabling lock debugging due to kernel taint
0+1 records in
0+1 records out
3 bytes copied, 0.335911 s, 0.0 kB/s

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Cc: stable@kernel.org
Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 69e427b1903b..5a1e55a01c52 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -812,14 +812,15 @@ static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
 	if (i < op->data.nbytes) {
 		u32 data = 0;
 		int j;
+		int remaining = op->data.nbytes - i;
 		/* Wait for TXFIFO empty */
 		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
 					   FSPI_INTR_IPTXWE, 0,
 					   POLL_TOUT, true);
 		WARN_ON(ret);
 
-		for (j = 0; j < ALIGN(op->data.nbytes - i, 4); j += 4) {
-			memcpy(&data, buf + i + j, 4);
+		for (j = 0; j < ALIGN(remaining, 4); j += 4) {
+			memcpy(&data, buf + i + j, min_t(int, 4, remaining - j));
 			fspi_writel(f, data, base + FSPI_TFDR + j);
 		}
 		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
-- 
2.34.1


