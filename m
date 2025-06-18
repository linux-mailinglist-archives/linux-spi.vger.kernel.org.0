Return-Path: <linux-spi+bounces-8658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D029ADF086
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840253B5018
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A42F1996;
	Wed, 18 Jun 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nrt2oQ/o"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284B2F1987;
	Wed, 18 Jun 2025 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258496; cv=fail; b=hYMpVwD/FWdIdl2fH7/FWZ0T1JjZIp515dTICsDsS+EJ1eWSeTXVq/TZKt86TxSO5znasLCXByJSSDbkxg9d/Dj4yTObP3gbo2YXjJhe7nKBJdYBTmfjbRs66T2cjCKapHG24hrwOvOogFBDNKLS7FNwasgKKj8gL7td88Cu54k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258496; c=relaxed/simple;
	bh=Z11Q/SbErfSRnp4btUVQavDce7NWRlFjFJwDPgKCs9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tM8eNbaHCAOVwmbxSIpeMbiYcoz42PRY+jafyM4TFR4UaNhDrpYnoUa/mgyp0XhZ66aKsz4fnkZWrnQWcGBpLVy7GVoy0UV9jw+IoceDc1YF3BXzIcu5T112Stpnbi+9j4cgpxzk+OOFGEca3Qo6lCqjikkE2xkFz44zBRB8WC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nrt2oQ/o; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfcOT7qYADsNM5uJqzpVbOzVyTTbB+E620j5fS8d4opb+QO1I0vpSA70qGOzdYi5pPD3XgUebVJnF/gM0c1LlfhKRfupKTgWUDleqbKwgkWhOv/3BMNBth0bZxD7mDXEkKHgBGNaA+S6ZtLvXuRGu3mp1Gizc9NDcsHc4JnBp46lOZJiktLPZGdh/axUPfgzIUin0drSjOVaszBwg0d83N67LF4vZRHhg75K8SELJbtwWFuqSW9oPzsj+/4PxMikQ2b/SbQUSvr2sK3NrhVnSKIg3QLAvisl8C3/ligX4ZbRUuvB6C4e7XJH49VkFm3fe9O0ub88/d1ZVAKxjAkT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSAP+vBtmwIy/Ylezxv8jdm7Qq02VJe87gZWYwuO+xw=;
 b=Z5/LVBzynQKC9pRFAp3YUR0kW2eHlWuD4h+K1s6oXIDvpI5dAZ5vKq9MvJimDSPhh1KR3DHVWCsWwLkJSr0zEeLK1ZfjHmvOFdKiF5ZqWfjO1GseFyfzxlex4Emt2YLRwUBHX3qvRO1obFkARIJTt6pNAeD2tRDXciMtgVvgJMzeI6aagHsEoWKWSnEYDwYgWb2Fp55jwknNvxko1gXAUFyOozRLqQ3XbE6/aK9rw/hummOckSuiO+wK5YtDyyLsbLXTjwYaparDEnkBGUF/3153Vsnx1Qp8RqFY4gd/fX5q6frlhnfPyoEKokOFUf8OBNCewyATy+FC2pltkEInyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSAP+vBtmwIy/Ylezxv8jdm7Qq02VJe87gZWYwuO+xw=;
 b=nrt2oQ/oWXebaItMHOmFg6Dzka24KE2osNRUdOgpP2W4w9i89HktVEBhxu8f5dEiSin1k39HV+2HnG8XJvdwPExGXsGH4xqhyS6VVhO+DNi+EY7/rKV+DdEf9aWAotPGAPxjEZJ+0OxgvAj0vDFPLYTxUCsU1sL1qw+HsN45L9L7PXZcnnBnMnFfyYlxFSdn2m0KFjl2RBLCZbQIVUICds3hb12M3QfBIik85scl+htJORrV5OqRhDmY/QJ+TZBv5lTE8TC7rbvlKlBFTjK3kzob0GjFkDtu7dxuagRjOVroC+FdJRQi5EzxLvh+9jvr9DZrx5SWwril9ZZnKLhAUQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:50 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:50 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 15/16] pinctrl: falcon: mark pinctrl_falcon_init() as static
Date: Wed, 18 Jun 2025 22:53:28 +0800
Message-ID:
 <OSBPR01MB167014AF54EF9818CB98C83BBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-16-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 44032d45-c69d-45e6-a20d-08ddae781337
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicBBERLAmk5UFwj7bM5Q2MTg+EwrQmopVa9e6ldGZl8rXFxmZNwkMlcRD4sKMdFulUtFWHwdSDOsfNYVeXyR8Aob1gs0ygpM6CPQ6VU0UUCe9oc/op/Ubfbl4GShemg6SlH3EIWda4cFRdTOAQm1QCFdjOG6zs4l+zKq9Aofkvrn+25SAg89zHRO68k0I3HvXwQI0CinAOuepJ2mIx7pWdkc8yfmrK/Gw7tHoIwK9kw2fVOoXO6zxXp7+uCCZNxFQc879EEC/VikTE7qX2rBC97wj25KUzpNdMDkBwDv61v2HFwww+Sk/iE8H1iWsJMm8uPxo6UQ+CoiCMiWEK7911r8REuBRw7rZXvoU0nwTpVPpWJ0gPB9iopnBMi5K4w818yaeJIDtBlcDCJ1PFSGTK4CELNzsf4eTeXaCMl8MyqoHQk2MKBFtA+DfnaCYLmcxwZvygcs7sSPpc+cwykUgxGi+m1shzEYQOdxKp9GH5d9Gfg/peOVK3HMerVR/rNUPgU3g2PwH7my4Rycz9IZUBcPFBuAajo8u38ODQ4CtNjBaioW1/FX9tzrMuUcfSXTv1ZrFpV0Py53GKOVcoWZg3CcqeLYrDZ09JK+OgJKG2OL7hHuMFPT8C6PcJaoNq0tWUr1v9hM9dJ16p5X9aKuCTBhD6z6yQbjjMGfGsUlayYObirAuV17qZKlv1TzmkKczmVgqjgrBA0PfzrN3nmEvs2uczFahPuEr07PFD6Ydd7hng==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQnPxBcjpvKVQJmDLJwh4kn2SrYF5cwrBMFnKwLBKIcC3WaAuWvgmLNlslaj?=
 =?us-ascii?Q?l5Lh30/GbEmXTKr/Reu8yckMrblfZW5D6dQbEm+Gsa9aDdpXHq7+gsRjB6vS?=
 =?us-ascii?Q?/5jGek58kS94T6q+CyGWlWmys6Z0e/nWIuTga9Q/fgD5T8nEP3MtBCDTJEft?=
 =?us-ascii?Q?N6eDEpTG3yzvDTlUmfT8WxSupIrhGS1o2h5ny8vZ8Qd23ftgxSm408MJlPBE?=
 =?us-ascii?Q?vxcmJeBPZDcHcKUOMRBiJN/hpfgLPKyq/IywJOCqOCs1OjsO0/aNbKSZ6wve?=
 =?us-ascii?Q?kZltCz8YJtfgdNk+0t1DmzM0rGMd7Mp9maL2cfGwJeRvtRtyp7G0KceJ6E+q?=
 =?us-ascii?Q?TcVBwFZQVv2Qz88brAHBVvoq2lJNvAp6NK9AdqujqNm0MBoiMoecK7tvZohF?=
 =?us-ascii?Q?E1/IkT0uPYI5Ku8pYepTz7A9RX3vVhsc6mcH65qIuxd4BVRtMHogzy7+p03l?=
 =?us-ascii?Q?bB0XXQ9rGGiRhQaQ3fFGDbhPTAep4T6OyLoRtKu6jmm94wP63qlMrsT7eYXq?=
 =?us-ascii?Q?NRv3WBKike9I6m3JYk+UV2YR4IQ1YjjPQ4PT41CHZs91OgynjOmeCyrN6u4e?=
 =?us-ascii?Q?sooIXhFg3WB+FN/MUQ1337eSFl6j4UNQsH4lpDEIpqBOiEYpVoRaNJS0Tbzv?=
 =?us-ascii?Q?BoKm1j54xBIBSLNtGjxeB1WADiLrQ6c49Q88LcKuwq/o080tNhCoSb4WedZd?=
 =?us-ascii?Q?s2o+bdlzc7LKJm03YM08FiWa5C0LGgq9RtPlseo4d2S0ttYTEg8Tz6aQr8z5?=
 =?us-ascii?Q?dAIOjJd/4Y+gBPh1xiciaEA82elGQQi+cid56/A/MYfx3oW/6IAmF0o6ExEl?=
 =?us-ascii?Q?PmQrFZe1yTX+GEAwKYSHx9Ubb6WICEmCzbuE9eDOqjkfkGh3sZhRlegC2+gx?=
 =?us-ascii?Q?p3ERUaxOmAj8mj82xSmqQKD+xZD3mPFcDKoBh790fbxU95KBR77gLJ85GK0p?=
 =?us-ascii?Q?N2cZJ02Y9EvMwe7gr2yhwdtUUwvC3bcX3L9G26pz/ATwC6s6sxGzyGST56nV?=
 =?us-ascii?Q?u5NwosnZKJMjaCAYoHZNM8xSPiq2g5h5P0xawIHhAyebOXJVqmPqsd0L3frx?=
 =?us-ascii?Q?nBCyWWch1lQhGxJ97HZELTvtufmHgfwyLnRJggJoryEjTSpcjfikNeLHAAO7?=
 =?us-ascii?Q?PZi20zO/4dfYkBPKxaUYbNUxYqyJrLj7Uba+OeRqVjdqxQX8YSIRX8bYQ+Fd?=
 =?us-ascii?Q?R+wUxbv0+ke63sx2GrQrmQdjUx4pnraHhs7kBo/34oLApVHfywOOmP6A+zU?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujzUFfWh0MjadAD7z3c2xWMT92RQ/9CI2nkic33mLO9lO/7Q75DCybSIVBZ9?=
 =?us-ascii?Q?3a4piPeyF+emD2QbG4LuD6FG4LfVQwIBksSLAaeBsMv3CEeZz9E14DrrARIN?=
 =?us-ascii?Q?wMjUoLLR3Ix9RtV2KS5/SZb4llD0R4cH2bXTypyoey8kE4xFc9DBWXbuOCFh?=
 =?us-ascii?Q?mhbwtHNBbfOeHQx8ZHEFlaRGDqfIU6LQ33nHqemYuiRl+peS67ac8T1yklIw?=
 =?us-ascii?Q?vUjAsMEtUOvBacqKELRwG/+eFMksw5JC6SAHUt4LTzAZzGg0pJiBq4tWfXKo?=
 =?us-ascii?Q?GxNqfeDRlu1vn8tFVUFQWAbeEi0B1xSOiWQQqTYCb2wbJqjbJmhwNskdXjIf?=
 =?us-ascii?Q?LCkYLnxUcg6ZvidwiTiBppzyD01WmzoicVvbc3F7VkRr012EfjbwfDG/DuXL?=
 =?us-ascii?Q?fATYzSCHwr+mdzVTKnSZYAUrtxPKhJM6eDOynToDzUVL8jjx4yaR/f2pFhSx?=
 =?us-ascii?Q?ojM5wUmvsn6K5AZcnALDxWypUDhoLxoSQ6fANEyDM0Tp9dqaeCdcNphNnZ40?=
 =?us-ascii?Q?j7o5DuzjPHy9+h4NtcOMeuD+gnngcWnvYIzQHd55E902qLefJrSwNI8CllnX?=
 =?us-ascii?Q?zSgbe4YZgIP1x0BKLAanzbOaDr7N3DVSqsR/lQhTt5OoSbTqW4qLpAfwZMYG?=
 =?us-ascii?Q?nEyjdWJF5SysnslyWB+EzeXrn6VcfSN74a3sr1vXpLWJ4bCyt6sAqu/hf5eV?=
 =?us-ascii?Q?piDJObSkClsWi+/M9yumB6IenCm2w5If/TEHM2C/4gbAaHVHX2lREbDhyKtX?=
 =?us-ascii?Q?IbS3maILgQzVvu3PDYQQDn3KcodOT/lobkPvEovgp29vE2XIfqGPWTTEqM3s?=
 =?us-ascii?Q?CNg//nQCwsHx47kwzKydjuquRIVXgQSqm7ZeHKOljx5QBsdDdpmoBDj82c3Y?=
 =?us-ascii?Q?DAvtxl2cURxKUQ6eJYhUbWQLp8PhkFTEj8EMbQGRWvP/+Vc8EjWFcIw1bIZ+?=
 =?us-ascii?Q?Us/p4uDM7MDhbZD0anmHR8QS7EP72HjexQ4Ku5ag6TIqzwnK3lt9VFnPawv5?=
 =?us-ascii?Q?gdZLVq2XFVioxkE5COZUxVizDK2mZ1CPPrVsz7/xK/nJpwfg+MACXkrV/54E?=
 =?us-ascii?Q?g2y3k4iqbCGyV9gaCmGMMlMRriBRIDU9+1vjJjwTaqlb0kQQpjxdgjOxW83C?=
 =?us-ascii?Q?qH+eIWUSqtJuN7m3Pln15AZXyh9uX6DJ9tX0zxivzc4kIrbbKM1lprO9r6z8?=
 =?us-ascii?Q?Cl8uOCZOuNO75N5WOU1SxzYhnTvHmyoQrY4++wu/94Qq7fWjTO0vw7/0KlTk?=
 =?us-ascii?Q?J+ZpaymnSMiL/cSQsuAC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44032d45-c69d-45e6-a20d-08ddae781337
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:50.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

drivers/pinctrl/pinctrl-falcon.c:508:12: error: no previous prototype for 'pinctrl_falcon_init' [-Werror=missing-prototypes]
  508 | int __init pinctrl_falcon_init(void)
      |            ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/pinctrl/pinctrl-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-falcon.c b/drivers/pinctrl/pinctrl-falcon.c
index 0bf9ffbcc..100eed175 100644
--- a/drivers/pinctrl/pinctrl-falcon.c
+++ b/drivers/pinctrl/pinctrl-falcon.c
@@ -505,7 +505,7 @@ static struct platform_driver pinctrl_falcon_driver = {
 	},
 };
 
-int __init pinctrl_falcon_init(void)
+static int __init pinctrl_falcon_init(void)
 {
 	return platform_driver_register(&pinctrl_falcon_driver);
 }
-- 
2.50.0


