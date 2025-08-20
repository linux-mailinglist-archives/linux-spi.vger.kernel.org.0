Return-Path: <linux-spi+bounces-9554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48133B2DC9B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E565E09F9
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0831B129;
	Wed, 20 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q7h7ReIX"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0131A064;
	Wed, 20 Aug 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693217; cv=fail; b=ApEZVwz9TCAzPa6bzD72vIoTGL0QxyYxV4nk6hnwHceatC2Hg5dnrAJq7MslItPt68AGlj4Ozt80cAL1qHCynwqAYHENCP/xavTpxplpvLXsPEk8+KeMuNwQHEHo2WKeGS4tJ2jmYLUToo0ErAq/2TFS6YiznORgV+2yybYShfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693217; c=relaxed/simple;
	bh=bswb54Ci7TjUUf5sDcCikDKpsKAnCrL/5XuH2C4W7Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCvDSi6GMwtAkjjYm3I1qQu4S22bbq/OYCjWRRT84ppQITBXddHm+dvl8rGJ8oqr+1Pr5ilJQbPqghmNsmAoLXzTq4zFEjmYbYjjSJDAFXZoDtDhQEoRC0rT2k1HUD1vEmPGovn6MOLfdK/DPNhrMH9S5Kk8dlaVBtR6osmHW9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Q7h7ReIX; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sixIxYmEB/0lEPnzCLOP9HdQ1RivAVEDvOci13N8/r/ZQ7CF8vwIa85gqnA6MT2fGspQMGgFwqSlUBJIon+144AWFuno7XWfiwB0KTwyaPio+gq+OOcENt+c2HRaIdOQIvFgGx9WpvdCo5PJXC8fFBsQzYVzZvOK6Fb6CW3qAKJDom2OB5gFsGn5SRwSNJtYUgGw+Vj1oLiUT/S331Uq5Sovs1re4/h1XtEl25T6v5/l5/2Oks0ca/wnQhVq5ZS7kL5OgaEfve/CzC6d1A2E+IUWvVi612bqIfLfj2Qt8awz5VG2Uvj4TmQ6MwKo9RjbahrjqI0lqzBfWHQXYfxBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FlPP13HNVDKeJqRNHZ9Eriu2kBJ9szbA6aAncjtVCA=;
 b=ILOzAip0qO0JidHgwSg98UOXxKL1oUlTAMb7TFemHS8ZXGw+zR9y5bvomqVVgaGyz9cqM9B4DvzquoxQkE5qtyRSMWavjDnTZ+oUo7QvfzraQaroSuLHxJJkNPneulwjjYisotvZ2Kw3dqcaFJjxIaHaGyGe8TjMe+sRgdKcppIou6M7+b5gkd7f67KZphXNAM2UPbf1k9fJlGRqOMOPYpfl2JR7c8qRcwECZoaTABQ3G0RfDhwxXTsRclrEjHEpi4wrY0PBNhS5ufjkmLA9zwDEX35XetkBzrk7nB/GLOxGdFVET1NyB+L94/P6e7HFkOysFopU9lmiFiPfm3uiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FlPP13HNVDKeJqRNHZ9Eriu2kBJ9szbA6aAncjtVCA=;
 b=Q7h7ReIX4DA2ATKcKzNv2+M1xXZFwKyNpAuAge13oLNLL49Qk6mvNvDAEHr+iGrjAxu/bVXyb+Ioz7PabPMOvTLf9gnRM/W+nDutXAhCuF/eEjYKVGSr+hC1S3hXbVzjKqEtmkrfQEm1/nNxMufOXeQG/MEvQ0PKskS8gMM86hVPv7n5twVF1JgbgbVRKwdI8ngUIpx/NtF+xOs4a9lZNyrUibFKhTjmdpkzWe3jjHVBH3dKE+Yzd3R6PwtwFH+COsaozUKBe1Hx2Qzhlg6RhPSrnaArN5Jtx38FtfCMUhJJwxMLX6pZMo8Y8jyHjtYrKyQ20FciNzKYheKArOanwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 04/14] spi: airoha: remove unnecessary switch to non-dma mode
Date: Wed, 20 Aug 2025 15:33:07 +0300
Message-ID: <20250820123317.728148-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec6bb68-fe64-4dd9-511c-08dddfe5c384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xbd3YxcVHwcQ0pylDxRxcBll3hqXp/6CbEcn6GuDJ6K6VqDdhIWSObnzu5Bp?=
 =?us-ascii?Q?vgHbzyREt0geFy+XV1QFoGzfekf4mksLiJPnUkDtry8hHT29Ww86fwjLEY38?=
 =?us-ascii?Q?eE0NdnYUGtdYBBELy5u0EoQ6QXV1yLfEKDzwOpC3PfmCEG229XhCipdpOS1H?=
 =?us-ascii?Q?nkRgLAZFGBN7vq/BMb0O/WblNtk1nt1pTnMCFJHYiaHmGI5P3U7qM05LUkQl?=
 =?us-ascii?Q?VRm4f3oxG85wRpl2MfZhSYiKNjajSA0cZez2AJDOWuh75I8APQHwsJQ+c62p?=
 =?us-ascii?Q?8/brPLyoOU3ecKIMFz243D/syk0sbIzK1btsRi/8B9unMJVnvD+4Ko8z2qzh?=
 =?us-ascii?Q?3W68g/eQ+IAs7V+LtAgQM7vCi3yJB+o7FTWX2KzqajphUI1W5eC7iDhbF5bz?=
 =?us-ascii?Q?NKvUz+65cQicXup7hhK6uGwvUkiyF6FWW+0QH1OpM990jOayiyqPvE72ZB5X?=
 =?us-ascii?Q?szLI2Bu76TTjaI//8OKihX+cMWOpC9vhyRgvJW7tvXb+FIRVyRy5R0MO0yvm?=
 =?us-ascii?Q?h+HjP9leoJhcAd2bjqUDxUauQjgwcyAQlUTnCrqfWHm2+po746UTndAzUGyW?=
 =?us-ascii?Q?U7SnXGgnlePIeBlwxLUL9mOg+UZStUBiVLeGo92L70UUXmnPMq45qHDG68Ui?=
 =?us-ascii?Q?sSRjABZVFhOtWAZ9Z0YdFasA67ouN7TwRTrBvpbwnRJX4Rqz+dmp3P+wP02W?=
 =?us-ascii?Q?tREy1idIOj02e6yUBU3szzJqTQvVXI/iITndlJW4MxV7C16KuH3EW/x+nMH+?=
 =?us-ascii?Q?b+DmSaYK4M5L/2dtELUeQpIBJhC6NNM4dXY1Wdqho6pvVhod574yaFwvGOYA?=
 =?us-ascii?Q?DbuF8nOZXbfneE2fxZ0nrNyezJVfggpNcjfvQQ85ACta/DQd6pw82Zcblexi?=
 =?us-ascii?Q?4ZlEUw17GkAFvdzS9t7i4sEZbXWT9Ow+3h4gvjEsNActiD/GgHQ+dYJP4Fmb?=
 =?us-ascii?Q?MtK0lpDMR+3p+Q7X3P5mVf7NX5vix841921gZS0sX2pQXZGabXWFfo3hRggi?=
 =?us-ascii?Q?Spei2I/2AdjeFQYcNiWKW1p/RpqE4N6YDZhjxsnYY4AUyYT12YZQzrogIx6L?=
 =?us-ascii?Q?Hdn42tTOSzQUBbjZJNzfHnxisFMhCbxNnfKGxQeEptLB4P5vPPacQjYoJkUk?=
 =?us-ascii?Q?JR1r/vpqvjDy29YowBD64NSidZ+/PSw6J4ltn0SKti3ZdV5MVc9L+wHE1H78?=
 =?us-ascii?Q?BcAGYwNX9O+IEO8fAna2pLfkCX4qZwLGUPWvSiIlIx9AF+Y1LDYHAM5pYoMu?=
 =?us-ascii?Q?SwpBu1gQO480SZ86Pak6tI2NBor+s5MSZR3GkEv2+jawLHp7EzkIBy0r4MbJ?=
 =?us-ascii?Q?Jdczc+c6IUekPHn0KxMkMHDvaytqPHoe0ALmhz9o/jbCXzv0G34iKxtYWwB1?=
 =?us-ascii?Q?75DYDBpaXDSCbXAKk3ry5qthfMlAySLcC1rdEZfiFAVXDaMnwxeGhUHXAdDr?=
 =?us-ascii?Q?C+41B/23YSnNgrr5nfzWONooU3QmDTaEV2038niT8Z5OHPdhrBeH7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ok6AJv7ZaI69pE2rIn23QF0kXZiE4RBnOBZx+z/H5Au2/w5KfZO1lNPdyn8H?=
 =?us-ascii?Q?UFQRPpH5rw5ZdVLnXFJnMl914ZA+gKcPrrx3uAKequP4GhC5SLNBxV/mhuvR?=
 =?us-ascii?Q?IX4TXj2d3FGEDvEZwwbvw2xLIpmJABhRrkiR8aLy/8AuYyBz4VtEXD7gqBEv?=
 =?us-ascii?Q?CfqPanocLds5JPt1Hyg7Bsrrx8G9P+g8Eh+3dmBc8lAIn2M1KphQrayPXnbG?=
 =?us-ascii?Q?8YaaPKCbrr1PYe+PuvZvOfjslcbg/uuz89jcsxQvxLlHku6cjnZXqtttz0v/?=
 =?us-ascii?Q?vjk3wdwU5YLVVQjbJQtGDX5N1y4XE0x8TWU8NcPLhpqk3SS+xLQd07K6IpOV?=
 =?us-ascii?Q?DH8gRALTdagqQ0gamCaXr3iPZSQb3B4ChUh9oEw5uRcyggyH9vCT6pas34Bm?=
 =?us-ascii?Q?TWiJotdo2NeZaDa8zbnO6VTpqFDSFPjSPWeJJ7rifSKXQLLYYy6hfGkDcIML?=
 =?us-ascii?Q?46M42GmYiIS3T4bhkkp7J/c1YegG2c1Fpo5h41lTngkRXY2el4UbIUWrVsA5?=
 =?us-ascii?Q?pY8AnvToKgtqxh0suSPi9FZJdTIGTfxYXdpTyZUvMwf4eekBI7qIdkdOVeT8?=
 =?us-ascii?Q?7DtNKHsUXxTsx2BcJkkXJOndm7YMLJFQ5u8WRA9kh88tKasKVHs1+qgV6Uf2?=
 =?us-ascii?Q?1RDjpFhQgtIjG8jMI9wf+MtAsC5MqTTAf58tiB3roppSRccjOPqH1O7HfxI9?=
 =?us-ascii?Q?cZjdeHKTqsKrp1JzSriXLn2bPJURyvvTPZ+uoE20WlL2qIcyP7VleZ7YuBX7?=
 =?us-ascii?Q?EKWAg+eXfK/hOZcjHrr2ocoUUT+KZfDPa+IBX2kfaw/h5M9NnGAngFx9d/YL?=
 =?us-ascii?Q?GRalHT3BuN1feI/Q8ym6rM3ichAQ8EQyUJwfHOqWzd3GaD1MxH5+hByLF7rP?=
 =?us-ascii?Q?0A2kcqyQm7Zi27sgHX/4kUhF7f7PGFu/I8Sf3pxgzkY4y1drUV+kreInM+ig?=
 =?us-ascii?Q?2YrIxDE0/pJDyNxtKSyRxCCmeDm2BbeKff2VaQmrfj1gDOjXEDGxYBQ4MHTC?=
 =?us-ascii?Q?Tx/cSWvAduk1iXD2+1z+UMiQb0+BT2qW0HcgJvLzJZL4zkM9Vcs1WessuqFj?=
 =?us-ascii?Q?nAcAjAUPVn3WGLiwJFLOs9d4MCc0J3pdpRqRI7nfPpiyUYAyY7vY6fzP7Fxp?=
 =?us-ascii?Q?xaamF9B7vsJtjnNr6x08ujMqCXqXcIjBmDv41xUJaue8PDoPqve71Rt+5Q9q?=
 =?us-ascii?Q?9nTG+g0hGDCQ7YgB5FADKe+G7JkpeBIoauWEpKigZU19keoObzj5hQJl7W9V?=
 =?us-ascii?Q?rPxE+svD0j6B/Ti0sdnQImTtP0Kx1HgHvjMPotPbcUfyRoYshgOwX+okD5GT?=
 =?us-ascii?Q?SqTalF+huFtlBoQ4Z0CIUVH582U2eboXgaspfiPgfRrNIsIETYeFT6llHvel?=
 =?us-ascii?Q?K1Mf0B7AcVwtu+yfmeW+9EHod8KDE0NVtAUymBWGCkvJfgdu5lBGdSKmCP/+?=
 =?us-ascii?Q?H5SO9kTRqFXeV6Y7QCui0kW4Edcl784eb/uc4GYqy112fjUBmbZFcgU4bMT7?=
 =?us-ascii?Q?V3WWsp/X34mWqrhHwA/Gi3FVyUEfPcJyuZLIq1LRfR4hFUg5N0WyHgbVi+WI?=
 =?us-ascii?Q?PFKBCRUCarYiS4mSX8BRAcUjKMHoo9L1rmBeWb3tNE8GWZoKLuyASRBD+Msy?=
 =?us-ascii?Q?B2wXIZ8ucuyf6aQzQrCmtnU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec6bb68-fe64-4dd9-511c-08dddfe5c384
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:27.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSSYOLHImswO6hXcCaVZXGNhJLVlTwCOtcCH656whC+wOykAfRa+ADLgIZAiUiVi5Cp6+jbjBJ1GHIWgwmCQM7jrzYHLGvZXNa3BrbNIphg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6355

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 7aab3506834a..7f33131fb6ee 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -810,9 +810,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.50.1


