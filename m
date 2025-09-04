Return-Path: <linux-spi+bounces-9899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE142B43E9D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590AC1C867F1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745A3090F9;
	Thu,  4 Sep 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="FThljsSf"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020124.outbound.protection.outlook.com [52.101.84.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD1308F0F;
	Thu,  4 Sep 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995842; cv=fail; b=ZiUu6NCua305Znu1XKPMRRhdkRxhJlxGMxVWHDIgtMiDPl6W4MQS6tdMEDbu0HdeEZ2nM+Nonra2Mvg6Gke4VQCoWjK9oROttDK6/jMsT0ALTeREBG5zo9Fxl5Nmj1Z3GPbEfIXETEx9pWh3tRBcET1Pp6l4OD4stC2gZQwzkZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995842; c=relaxed/simple;
	bh=4dfx/SFoGDV6AFfwoXXXNtAuAzdZgI5WfpnEnH4J7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ageNnY/AllyFCs9ksRVSH9n3yhvzUZwdPQmIQ+lqXRhABaxroMcSkZtXzri7M16UaneQ6FE6vpiD1EApOgEopO2jFHNPkJ4A4Rh7mBV2GuwWGvwW/MoXEceoavyp2+ev97BsmfdgAdJxpcMrXa+MOccE15ze7QG9BeT4El/u7uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=FThljsSf; arc=fail smtp.client-ip=52.101.84.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diD+2IVZp+R5Kk6+lwPMbhXpeHGFnhpd/fFkTXokAE19I8LTUedrVAAfWCWonPRtMWvOgXxLZ1TL32E4Ov1bKWn78Sx01MhZkamu8C3Nebj0s3HfJ73w9fhiG3xJRJyXE3JXBwZGHlopVl7wWpGjR/I0k/xvvn3PGLl9G0gHTNEbBQ/TjtoirU5Oo33IP/NtZxMjPuHJwL4E1kxxHR2jmggJJbbnJmXlgiClBqqws4jCz3+LBr3IikZCOeHigw6XNvI5dPJvFhuAGPJMNaKLPw9JM97eaVa8wFi/HiHEnREh3tM/c06fKSX5HPyn1qm0JzFR70Uca5U5PMUhdbh1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHmDOPbnpVlBZN85+1DnJ5UG5L/VqNy2oOxWyq5NUIY=;
 b=y0qRt3Pvz4J7WOWJA3UNMgwp38rwm9EiAnGD8rhB0QVMk/UYPI1LNYvIpKJvWH7q+XL7NkIPXYbnrB/bUoc6IRLA/sAqLSAS9cX+sbt1+/psHm2KzZ/6MWQX0dmtbBftHUbWRZHh/28Hki5QaUAa5w/WVJR8/mtdtgBb3Tu5C0xNUz3jojkmPTNbSSC3GeVSv6OoekA6Bswf7rzT/x82zynStoKTi2d3C3wzXL2NkTBZVijjyZtemCaSc8hSwENpP8v6IQjgxvMVlqLe5A8dVxvwRSfkJ+XbpfF+58wdqw8gIjJT/kzkO+7inFt8dbv5Sp4QPyFusnxrrYPwLNph9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHmDOPbnpVlBZN85+1DnJ5UG5L/VqNy2oOxWyq5NUIY=;
 b=FThljsSfPVRzjBHcJyBp8d41C/qFvlQIqFTl91jeKjBjN8Go+dXkKDbG/ZB2s60PVBVxptrk4sTkYlqxQ3EPoUfenoizGpA2TV3Sn7n11vvW054388yyMm8QPcJmU65zsMMmFlxhwu1f2ZHTmhTRlWZMnCYatZatKHS4SrGdUvYicgQ++s6p90Xrp3S8pM+qKzpihVtk1LiyboixZohO9Xv8BdhLRbKPvuhhMmwFTGVklfnx+bjAlUnMRhvs3kI7QO7dAAGSyxm81hHqbjIeCIw3EOyUNCzHO32VxegOO/LLfSdZuc4qxn6P3JK0gM5cDSUP6298XYFnbXfH51aIFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:51 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Thu,  4 Sep 2025 17:23:29 +0300
Message-ID: <20250904142339.656346-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: cb9a49e2-7fd9-45d9-6570-08ddebbeab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JE5LzVLUHe+27TQn3hEPIERm6ck2BgzwwwLVW9Jok/jlHsttKmRsI+mm/Sr+?=
 =?us-ascii?Q?HU+T9pZ8GM25MFrETBbg1SiG4xDzSD357SlZmR7YccgpV7aUPza2EHDjUc+T?=
 =?us-ascii?Q?2mCk3mH8ohUEAE/kQsY6nV1GrpeZuZz+l0+tG5TQrCbllAzg4pHvc7FHu3O4?=
 =?us-ascii?Q?wiEHOMmcUC5qlPIfn3CqVZPxX9PA6mtDcjbSLwwi5kZapD8WYq/dRzrwhOU3?=
 =?us-ascii?Q?u30g2Me80ZiJsnJHeuBbuzWI4iIP7Afnft1JBAdRN1vO1BaUcTMZdKr1R7ch?=
 =?us-ascii?Q?JkF/VnaG5gltoURaYn/LyTM8VR0TsyB8mH3u9n8CGZsxkgn8yLaurDDniPAG?=
 =?us-ascii?Q?bfejWVbN3HEitBz7wZ7GUO9fuo16TVcOZEG6l7iwZjWX2ExrD1p5ls834+PJ?=
 =?us-ascii?Q?HUGsVsTdAZdCwbkc7d3ljdLzZM+Mh+tzi3vG72AKHBsgEJcnFl+s9XasUoEp?=
 =?us-ascii?Q?EFEDIPXTscmnAZpw8IQAyKIKBVYjfNrWhpeSd7xHcKGD4JhW33pnA+l1PcRJ?=
 =?us-ascii?Q?CZkq0awhDSuuMIhB0NWbB1pQR4upSaTQyF0fpBODS+NDFTJtcC/RoZZ+zgQ+?=
 =?us-ascii?Q?14I2/htKoQ97Oxf4LUCS3btdGLMqzpV2EeYpfwBIZXZOeeWa606HI1u1wdkt?=
 =?us-ascii?Q?smWGVuYV42BCGa3GEZ8W7lAnYNTK6fPeCNpzC3w7Pce9URm6Kx8tPAzLRrTC?=
 =?us-ascii?Q?F+h1AkjIzamaXTLxPpFEYTQtw17Mm1AF3eZ9atgfnMHe4KlyMxS4ykUUmA+j?=
 =?us-ascii?Q?qg1DWEMsK0VmKrduEz70rdyQnRzEG5uhkYEDzwm7erL1LdH9mEMbm9PQuRo3?=
 =?us-ascii?Q?X8l+1MO0x3+EOhzpAaCGVs36VxKis2yPvBsAcHthJrzZS11Yw/Kukh0e3+Tw?=
 =?us-ascii?Q?zApYwNdW50PaG5GFizI0s09k3L5Uqr0kBi+dsRCvEL8IgBF4B7xjLPsuPK0n?=
 =?us-ascii?Q?9tSShKrgtZGso4RG2GJOk9/+W0gvUyZ4Vg2a8rK2XhWjxUG8IsUKoNrvYLRn?=
 =?us-ascii?Q?UMdxQEpk7bDKO7eHrIcwJV7MF/RsTrWAUrGMO2n538H200x2LkorDBdINw+k?=
 =?us-ascii?Q?6VN+YkN0hu7L0NdSyVEBvy9uglA5VQptYwVUZbNZNqwaYlwJBzYbqOqqEeOH?=
 =?us-ascii?Q?ElwO8ftyhAlAJ7lekERUpVdVA21r6RExq9LU661Wq6oWMRbNGXD3pCADaRf5?=
 =?us-ascii?Q?1caJETBj74eZpuqz8ZJD6gn+m9QJ1Hsr+iCYEkYdu81MZdqe0rlBKDpuOLUb?=
 =?us-ascii?Q?n22vm6/GPvcGlMwlVqegjSmPNpqVFLGvMAokI0TSccjZiuh8Pr3aT8BMijwI?=
 =?us-ascii?Q?zp5h3qNccDxCZGcJdsZPe/HoCFrba+RQcuVyXrDcWZeUu5lDVpxgWQQiPfcq?=
 =?us-ascii?Q?BuzAosejpuk9Ufxj8mm6Af8XRWqNrKzt13JC6SdS1d9J5/lqnWxd5d/KMkP5?=
 =?us-ascii?Q?HmkMMkHXvTX7Q6de98ROBtatUuZ8LifHVSNuOaAU2HZR9dZZ29EbGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBNXvvzUuM/LDHCCDMd1lHZuV9NSaFZKhu9WfMGQaIWVV+D1nOXdP8HCkezI?=
 =?us-ascii?Q?QKAz/EsysObm5ldVQFBpvuwPDnbM0kpdbGhOdT6meLUjrWNKCIrOauTk1SJS?=
 =?us-ascii?Q?JulrWsTGjyLm2bDiTlhB+C/d20eG4SgST+YGkANy5TtjJJSBiEAu2/eB5eCm?=
 =?us-ascii?Q?Foe1wijwA8+xKUAj79yA2JtSi5/7KyqRJtX0S4oebcz3WGL0LgcWQ15ZSCPT?=
 =?us-ascii?Q?dONzjFe46HV1xE9yVcsqNkdEIP3GrFrdlTz3EALy+ZKaHmYL3/qcyLvEd1Bv?=
 =?us-ascii?Q?/lk4PphncVy8Iy8svOlYko70ZUKjMcpXEGoHvDJXs2nzdqVztCX4MuDlnbgA?=
 =?us-ascii?Q?vFccGEFBZ+rnVoY7LONbk8ScyjhLFeBNtt023ZKEDiy9Dsixmv/EKNg1sOtu?=
 =?us-ascii?Q?K6mQkJctXyLswjXXeZAstj16EyEfQY1X6j9qdKI19I8+n89gtO7oxUXmKQIK?=
 =?us-ascii?Q?EhZ3IBDUN3zz0401sQopWQFZLl43WqGEsW6nNTlbiqPcZyRUTNhcq/ShQ8v6?=
 =?us-ascii?Q?d32QkPmadJxuOB/o+pzrC5PZt/ehzKW77/toSChpdKLQGsgNEPQux1xOaw+X?=
 =?us-ascii?Q?UFJoN/KLTB9IBgR0tkSUS5RdIS4a9cRmnwlkIG0oqqcng2Ifr20UNgiQIrGv?=
 =?us-ascii?Q?/QPtAiMU+Aa+dmBf4lhf6YpkPfsHg6yQ1on1W2QXx01pFKF27/hIKnzJFVf3?=
 =?us-ascii?Q?2Z5/o/TXMNiGJTK7y5JM+niZy2Nr7WYDaKWl9gVZe6Gz3cY7fFaLowl5Cc9H?=
 =?us-ascii?Q?bAX35ImLjh09RW3lH/7BAFA0m+JUa8oHiF9uVskNfqtN7amQqF26+IRgvGFg?=
 =?us-ascii?Q?Y6fC/f8Jl60ANFoi/8cRfHPUYDioi+1KU8/VNjtOZey3+l/LRl5WnDVMJ3R9?=
 =?us-ascii?Q?jEFGoo1yjrVuDHfe/V8bRFKb3XY1m3gQzLDmwmsIcMaxBuxK1G/GeI3el4B5?=
 =?us-ascii?Q?eX0tLovSRi4OWLexihsK7fzJIRQ57XcUhF03MgzjNTC42OciG8ddAjFx4UNN?=
 =?us-ascii?Q?p3OR67ld1hmYIIluG142IfXDCxrKQSQ35OLusd4yofWNaFXePGFnWdBP8gy5?=
 =?us-ascii?Q?mtqveYsjCFXsuY306DXuaVVRkGdghUT2brHEFRNWkaDcM5IsRrYvY8yLN4im?=
 =?us-ascii?Q?MJ9Tq1RM1oZ0VcYtOaccZdVAcHdhPHGldHw6+QqQSx/l1A1n+obX2opiDBhu?=
 =?us-ascii?Q?7K+nfkaH7glmjO0D3h6UonhZJZ0dWlAXLhc+gazfjovRl+GghVS75956WEFL?=
 =?us-ascii?Q?o+cZxYaDDYAdmfIYtjMfTDAYus2ccxpc3vWHxbCaahrHkHYjw+YK0qdr6mDZ?=
 =?us-ascii?Q?ReaSi/F1mdgJfVGp/GQYsXCU7TT1YIO2Do/2Iy1XIhloSD+ylYSn6H7f6IvX?=
 =?us-ascii?Q?oLzkTz+iVR6wmE4vWACC3/QKIhQv64b90mSmuGqT/Ux713FwxZABZzTB485F?=
 =?us-ascii?Q?kaZGK5G9GtXxVjqFUvNi4hvavRYxEetHRZF/uOBJjgSUOzloxegXAWl6UobH?=
 =?us-ascii?Q?+ryoeqwo9DUDFTwhX6PW6wOPJwgf/G5kqC1U8B7TOqcmteWCQhDFqu6qIiLm?=
 =?us-ascii?Q?gY5PY8Pr2FRjYb1yAzRWGP361d+3gwE3O15CFqYGAR7yk8OZ7sXiKTYhGrJA?=
 =?us-ascii?Q?KOOpMQdVfKyfOAnys0jFtn8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9a49e2-7fd9-45d9-6570-08ddebbeab7e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:51.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO3icMkokooWx02sHpF0nXX6TY1znUi5AlGBIJriYwVDJEjxaCmGrNp8WctQWmlDEhcSTwHd4ZmSrGoZYd/tdhkc3t1xTjA3r6wUUBEopcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

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
2.50.1


