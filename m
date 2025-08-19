Return-Path: <linux-spi+bounces-9523-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5AB2BD35
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F685A0E28
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D231A05B;
	Tue, 19 Aug 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ae/6QRoq"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292B31A054;
	Tue, 19 Aug 2025 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595265; cv=fail; b=HLfo8TC8EhpiAPPcmnKbs5wYnNeiiwkgFQqLiYxVkZlaBe/plMMCuE8ZenZM2TFedWqazyC2p2G2gDxZEoSyjqW4aRDi2KaK+6WvQZc0IqN9ppkvU/sZMEJQuOJRboJSVjJTEpeuigpJgLo6/Q3yzDHAEv4Uj1V1k8y4nWQkTIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595265; c=relaxed/simple;
	bh=DFxX8MmkrjUbQ23OgeELIpBSgfH8szm/n534w33nSg8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l7xzp6X5IRmZLAj5tw6mcm4OQEyHqC6/Cd6Fs1g4LUSKIO3fQEysQguXJOXN47Q6vTpy4oedXMjjQhMhSAUblDDMTtkit1UHRzLmhH8Fug51g5DzIQiXUDBqQZPhCL1OWcyFTSr9ltxOyVMjrwlxRGL4XEcRNeQJ8B2z+pjKAZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ae/6QRoq; arc=fail smtp.client-ip=52.101.127.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFtxkh4sMUspzFYQfkc5h+Rs70Dp4+er4Hnst2LfvSrN4fiUvtH+1rdBN5w+zbUFS9hBmEFJWc2BVdKyrMPv5sw23yD9BfPsMsT10TNcASrYDPwhUonpYmyxqkiYvGLIhus+YjUUdzINusjftwjzyBRAMWEL8maIXH+cdBcoF4FHPPlEhdCAKRKLkASmqDXwMSZSbexcIGfSkRXuJfIMib6bi0IgdDk2jbcuNcdXdatw6bUUCp5QFV5rGskfGyLvARlxX/S6f0b5VyoXLtn5pYjwt6hxgT2EYyrYAA1AYPL2i1sgRQ6H94fyw0M9m+n0cQP3F442zmG5EtAOMlgu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H78CLIdj2y0Ls3t7E7E3SHhlbgDz/8aTkcLo2mKr9DI=;
 b=t0igeQt4cyxQKB93Er+01Uaf3OoqlnPvLGjMJuUQDyK6UNb5XfadAc6cYwWHDY7lcIEczE2eUt3m2ZOoqRjcW8O8/LID1yub6B997xfIeS27uho8xqG/DuyPFws1IMsjquPF1hSjTMex0bb6oDMK0I5Lw8edzCyp1dKgP9NVx9qrwT7YwlAmjxkuratsJ/QWzdVuJnSKSEmwlxwZUEGLuJSP6n7Z6xMKEvJU2yOu5hd1b7M67j4OWMGHbgF7c4gNYV6vd2eFY5wMx2293Crs+xyeuu+r0UPCg663WtfRw0wFN0ncmSf8E8rnF7HW6/ULEETud2Shtmg559LH4lP6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H78CLIdj2y0Ls3t7E7E3SHhlbgDz/8aTkcLo2mKr9DI=;
 b=Ae/6QRoqkuN9lvCd0JVhBQbjpL/BHxSehifuc90P1UeHwUJLIIxHj7gLJk5PyR1tWlUXH5j2Pnv2eTgqRYZC+nzqTzbBh1MOOrhanGQ2N66ogaffZ9q94HxFk4UYXW5pNzl67vPWF3XwOILcsdjcqNUuP46BaeE+MiJpjKdMgWUDS9At1dE3Obz7+NXV6vS3CZaDtTdKES8coqvEQYxfosXaHg+WPA+vG26zUwlPy3j1AoB9N3eoTQuZs11yEVbkq5C5DVgjnEyfIQvQsJosM7umA4vd9ddhuAREB/8jMWRYD5QblcMarpRuE3jkX3b2fLySDXO/lAp/XKH1UVb2TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5054.apcprd06.prod.outlook.com (2603:1096:400:1bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:21:00 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:21:00 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org (open list:AMD SPI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-amlogic@lists.infradead.org (open list:AMLOGIC SPISG DRIVER),
	linux-riscv@lists.infradead.org (open list:RISC-V MICROCHIP FPGA SUPPORT),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SPI DRIVERS)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v1 0/6] spi: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:20:37 +0800
Message-Id: <20250819092044.549464-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 971c334b-dd05-4c4c-3d88-08dddf01b611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymCvrDiVyhzg+tZ0N5k+ezlJ8fLHQj53cbcBBUzUbWjOSw+DGYK+aPFXSjEO?=
 =?us-ascii?Q?JWoNRzLFMjjqI//y2TuJrpG2b0gbSf0KVBylkwQ14Z3bZeqsQi1vMbsFx+b9?=
 =?us-ascii?Q?S11wyysrCI8zl0jzc6NlYoJaMTzngTTkOZXu33khFZbzLihWQKN7SiCQpaY2?=
 =?us-ascii?Q?eV1Q4FTM9GjK/KSeN4hbjTfzgGhtdndDgJwoiBbAyBlJ2JXJfRzUlwkaknhp?=
 =?us-ascii?Q?AmBirb0dRy2w4YpinUYq2avOSVJF8BgCldoOCH4sNRKTMqwq2YHVE3Crp5bb?=
 =?us-ascii?Q?vtHtr+CBQZL13ieZL6oBolgFHmZM2NYQRmv6ov0GN8fK+Fqp31Ji2UqotGVd?=
 =?us-ascii?Q?ddfTvV7OgmgRFygyA6yCzFO3RBPkm05nVdDC4TusR/6NgpnRQd/EnIho4JI6?=
 =?us-ascii?Q?/bxLF1KieqD+d/l1T7KA7zB8vjISvBeQr0FiHtasNXuwGW+002qMMQsGWKXX?=
 =?us-ascii?Q?KGLdegvF+AQIZXe8g+OxQLsUi02to8tCAugInRoymqRHLbTfvyQ/hRoXotaV?=
 =?us-ascii?Q?cUjOvuC5+X1TdSLyWFu8g5CM3RFLClORK2NLVCAEBAR8qjhJOGkIGQ53ex/p?=
 =?us-ascii?Q?LHzX/CCxWW2GaJ5noUToszUaPEHvu45YDWngqJ2mtYZwZRLIhnCzHGdFhN1d?=
 =?us-ascii?Q?Rhc3vI+whfvmOc0SgePFIJ9EOaFJkkjKvkCVUQYyc/PU50m0JD5q93gipc2p?=
 =?us-ascii?Q?ZYj6dr3UaTrAGbI4tSswRV+lfQOB70Fi88HVj1HzztiyjzW32nSQAD/ACQF5?=
 =?us-ascii?Q?0/WZ736iVdFb7JjAT8VuYm137jIP3YxqIzX6UPwwmcB4AgXSEjyG7W2xVOpt?=
 =?us-ascii?Q?qghvej2VTyk1Z0hlpdKyp4wc1zls4JPnhMVcqzEXZXK5wkEc2o/okFNCfuUa?=
 =?us-ascii?Q?luhCgNMU74fgp3jIdoupBUG8uRq0JM8GF2/JNhv7dj/zgFtMQZCKZG3HcMNH?=
 =?us-ascii?Q?BjCS+gEcna7dgk8lYeYbJv6wJONNBh/G9NRvThTf3Xd1EmTbWDBkN9wT0Twb?=
 =?us-ascii?Q?0S6bvim+dM3fb8/WNbX0ntLi/FiVTsyD3kkTNOXtHg8LRZIOvf+Ph9UEW0Cj?=
 =?us-ascii?Q?MxddI01nKvt2XjqEDqqjeXTbWdNzlNb9ZN7afOQcTvDoMWaAaLHSJ8xtdjcd?=
 =?us-ascii?Q?CjhBEy7MmQ31B0Wl2DAb9L0IkALVYxQWhbHDLdxnmmaWCvzCviH9XLTN1qXW?=
 =?us-ascii?Q?Y3XE6Jg+l1JcisFtZXQbCXcA9UhsRNE5uqTxjf0aeMcbTEbQvKpqKZk42eS6?=
 =?us-ascii?Q?ygA/JQM0jFBpF6hKn9ezJasfw484rs8XrLjhBXpmf19aiBrdmHKNCU8IWkcd?=
 =?us-ascii?Q?cWYsYlIcp+tRXuzY3FvjrGIWMv5tHd5oAYXR1ncsVmZOi7gAvQ5clIbwgyHn?=
 =?us-ascii?Q?dZF/jFHjeIrlXzc28KhdgdnO5coq8XAcIn3FllhlxpJpT3z1yV+CUb+Ayzy4?=
 =?us-ascii?Q?Me5q4Y+PxJwdF7DZTcYYE0h2TPKW/FUITKr+vU1Xf920cDfvyNlJokXouDOW?=
 =?us-ascii?Q?6XOkzYRA+SWTfnLO4Bq2NI8Moznq/+gEJH+FJUUS54S5sdPrFGGg16v4mw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y0l26Rz8YWGqj7bzqkWuQhjSyuz466EdBFsvYk+dCxLiw9hA5SjmPKvk9s0o?=
 =?us-ascii?Q?vCh7zPypPM/zwoUzo7409qi+iiX5t6Ap0kfhjP4on35Z1fljciPvj5eA4k2x?=
 =?us-ascii?Q?giOPvHnvysljUUOspF+OnykEqZ+0SL2lSov8h7q3oT6VTsgk+8L61IdJcgsD?=
 =?us-ascii?Q?yvu5dr51JFK0pnS9WP9TlqUITtiVY3glWh5b/UwwFo616bUSzyIMRGwyZtOf?=
 =?us-ascii?Q?NnDSzJoC1BgrBMvYCmZhFd07rEYzCbiKMMFIGtZj00GEDjdmvKDQ7otEQYIG?=
 =?us-ascii?Q?MYCHJ+myTPGgm9sqEiaNJGTZXpIJbc/yEFckWosIusGu2kX1e6a68eLpex5k?=
 =?us-ascii?Q?X4Yh51tDg3cXj2BA7aTdg86DhOohA3AD17PqJNoy3bz8b8AkAhrKkpyzsHm3?=
 =?us-ascii?Q?49u9Xr53sPrZytc5bAUyaqWjTKhE3Od84Cgcs9kXAtX/gZdH/zxwb09C2dl5?=
 =?us-ascii?Q?Y6xcQ1dJJ2sHhgZmaw60lF8jj4SBNloqD80JUtnPLHFxgjGhOKiOlNbHebu8?=
 =?us-ascii?Q?72FWfbuonGlVAoHOPGf5FEB4yGib0QTEL6lafRIA6WXzDZZhIGqe7+mAaik5?=
 =?us-ascii?Q?ZzcMw+jS2u0zKjmvVPN5DcTffnyULvcL2r8t7lTytNbW+QKt6tp+xVd3O6TJ?=
 =?us-ascii?Q?Jd3UQIiPbbJOtjB74jU9Bcs1FYh7e+xM+q6TCP9a+sxXyXFCl7PRx359hYyC?=
 =?us-ascii?Q?f61WYGMougNh7m9DyLi7qt5GvGrULyHOmgS/T7aYKq8JA9M56EwCHGPEYgwD?=
 =?us-ascii?Q?dRI43yvZYLac2UFqm8ORPrbSEmWUYswna1F+gqPzw8LximYXoSAL1pvxwfn5?=
 =?us-ascii?Q?C74OtwhLD/vdHKLM/atjHeZdqRYgwt4DkWNAHaf14xwf7NZeO4YyPb/9K9N4?=
 =?us-ascii?Q?DGpN/VVxDtI59nj8vQyTfZ2QOK5ZIjBfp3RbNUZ09ywWkps9B9UFyu2PVpm9?=
 =?us-ascii?Q?efb12X9wqotya2RSQnSI4sPwjN3YZsT3GAczcquSze5SvqJdzccnnL5D58mF?=
 =?us-ascii?Q?SxL+2AJ176fh7oFc6Xk4ID3cTkocvMD8cfdlhUGDS5BK9i4l7YVdwj1q2GDW?=
 =?us-ascii?Q?4ZkFI550zYzYsoCboBdEg7MujKUHIc/zU9qGrchUua1jpKq0+Gbyn7PKr2X7?=
 =?us-ascii?Q?Z+Vxf6qTURdwRULGUDTU46/i38bguNamD6MCmT+qEKg4+HZv93O433kA9jut?=
 =?us-ascii?Q?VXV2zv1BMDuBAhkvGwlc4kNiACJKGNIHpxighxCYZEcnRaqKwV8JEzEI0M0R?=
 =?us-ascii?Q?qA42DkE8//U26TF3cKiILQhwJUIdyhFCPMLhRtMsFlctWXKphXR1rVo9F5Ck?=
 =?us-ascii?Q?zwBamQn32Zz1IJcMyCDAQLLRBhuJ2jxKFTJwxe+p2klKACF4bLw87ZBM/sAy?=
 =?us-ascii?Q?hCt/fJ7EH7RfBmjDnauAaF0MgJ5qQ7v5PucFmsrebwYzwv/dCYyWAb5rZV6Q?=
 =?us-ascii?Q?PHa+ZCVt9Ocn5RblJA+opgWCXU4c/7fScU0r3ukp48weNgU9Su7Z/nsN/4ZN?=
 =?us-ascii?Q?LiTdW5BhMsI4yKBzXcgKh0OB0tyQBvPyva1few6lWbrdPRgHsiZBJbWV0ehP?=
 =?us-ascii?Q?N6ivZXJlh5cY76zV9UO/4WQZLGup85bXyEjzomjP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971c334b-dd05-4c4c-3d88-08dddf01b611
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:21:00.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48WEncUZDNb0IakT4eADvOCAnbXb5llrEJYmcjpdeMPzLy9hT2Z/Lv/RLmbVf6cgiklg+A4XaIG4yiFJoVYDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5054

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Xichao Zhao (6):
  spi: spi_amd: Remove the use of dev_err_probe()
  spi: SPISG: Remove the use of dev_err_probe()
  spi: Remove the use of dev_err_probe()
  spi: mt65xx: Remove the use of dev_err_probe()
  spi: pxa2xx: Remove the use of dev_err_probe()
  spi: s3c64xx: Remove the use of dev_err_probe()

 drivers/spi/spi-amd-pci.c             | 5 ++---
 drivers/spi/spi-amd.c                 | 2 +-
 drivers/spi/spi-amlogic-spisg.c       | 2 +-
 drivers/spi/spi-microchip-core-qspi.c | 3 +--
 drivers/spi/spi-microchip-core.c      | 3 +--
 drivers/spi/spi-mt65xx.c              | 2 +-
 drivers/spi/spi-pxa2xx.c              | 2 +-
 drivers/spi/spi-s3c64xx.c             | 3 +--
 8 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


