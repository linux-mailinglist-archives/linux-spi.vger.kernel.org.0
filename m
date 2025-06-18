Return-Path: <linux-spi+bounces-8648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F1ADF053
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1D4A07E4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902912EF67A;
	Wed, 18 Jun 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TPcM9FZY"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE42EF662;
	Wed, 18 Jun 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258460; cv=fail; b=YYUY1RPEkJPqkRDGIEzaUD1+xWCz29/WL34ZJ36W/2iHavKVfUKuj+/rx48IoyIaQdcctAmJb2CQDjEQapgSfFGWFnqqD1P+vNWH3J8IHjMelAWxOcWkx38SpcmEa65cGtmEUzARRYUBR2BjAzc8Skur4p57yV5lmgykr2Ro0No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258460; c=relaxed/simple;
	bh=p/M/6yXSc/i0drsX22qPWJgOHj4uM+9nf82qoY1Aj7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIJobVv+XvMraDEhqvxrLcAOgdJbKYl0xoKeUG7GM1Brs9fgavH4O+1yBu2kiBI5g+Zb3fbt1m8Qd0ZbclEXCifl/7+5F8mNpA7ZFmvN07/zPqO7i8qaJ5Wr+BNWih4J4x8T2YSTuDvymF9LVR7t9U0jyAQf10G8UZZMtw4Iik8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TPcM9FZY; arc=fail smtp.client-ip=52.103.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxwCRr1tRXQ2DXtpsUi52vmZiJ+h9ekmjZlOOwkTb3lczuxOcEO6nFOKyPPcZveTR+ub/JQKbHMz8cRuOFOC5pUz9Zf92yQt9qFUJJ83iS8UPmZk3SMCT1HTLKQzNdwzpwOChj5MvG6u7eemqCPB5d9O4+f6/VbJqTDg8pQ/LiNveCtxgZsRtNMB/T/ABazlYh4ARH1MCacbHPuHx0XeTh3VYMDoO9VMswvcsZbQ/NbR6vEyU0VSdCgVOYlZi0U2LJwAQwZbHdBhEYsgQpA4V0sgig+1xOkOGjYKF8iwjYlazZDZgja7j8L6ps+lQd8K75DD/mD8p4RFIJER4zI1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcydEYy5bWf6jUMRENs3xJ5Qz54abOneaE8xy/i3wG8=;
 b=taEtVWnwHwfm6ACd1PPkVTKSEWj/FZa/Eca2dCfe//zXFm+P4GHf+PLqDrstvAXE5amA0+h3Mfm2fzBzvDoD9hVvNNYwv5qhb9zCu4qeJjWzrupqylHqFJZk5TiHgZ6zjlgakob0n9LN1DZIhgaY+prMt7KyYMK/YarIE56TZUOfPdPwydpIxABnay7ID8z84XkTk75A+G8OFrAZBtQ3HqadFmqEc5ACFLOcRF1Hlg6pHNcUa7aF5uKvdcIbIR4JSyqF2gaw5/Jqz8ANcQS9RRCqyiAwZUsDmtOGXVeAjKRH7Mp7979REEdnuY6RPCp+PRrdodY4dJzRQCYy47sE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcydEYy5bWf6jUMRENs3xJ5Qz54abOneaE8xy/i3wG8=;
 b=TPcM9FZYFkfMhaUYr2WmRoCW43Fju3hfeyK7A9x3aMYjM7faniLcwPz0gSemg2utXQTkVPg6aUHWbCMMtm1CjTzPw1fRG1jjK8iMV5+AFlEGo3kYhuKo9SpTOoPdYhj2YRJm9ZOdU6Fe6hyHsPYmElv1BWpLVrWCc+1XzmGdoNIqpl62cPb5Gw4hjFWO7u2e3KOy5EwHAxhIJS4hFaZYKNK1Uv8ugbHwoK2T7zQ1quI/f1tarMIoMnQ++rJI+AGAOXkQglg3Hb705AVz0G6XIF+D/f7S0gySesL3FyOX7irv7EmsDeyiMC995CzixbxnC8qguL8yRSwxDx3Ch/Vcrg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:15 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:15 +0000
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
Subject: [PATCH 05/16] MIPS: lantiq: xway: add prototype for ltq_get_cp1_base()
Date: Wed, 18 Jun 2025 22:53:18 +0800
Message-ID:
 <OSBPR01MB1670AC1C064C0DBD2C38CB86BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-6-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: bea82b4d-0454-4999-f178-08ddae77fe9b
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdqcfDGWz3xsq5csUheyqIofuMNNbMVRLGiocuB+yvyZyKtP+1gucSXnxMljtEUgfnrRDkeLT9mR/dqcNKBaE8GWRx88B2C5alHe81rDaG0wY31XJx3JoFqRlPxUv4mKh5QjuNrArDSldKIMjBCEc5QHUfwFasLl+/NcO5kaJ5vI/E4RXIYp4T0c/crFrbgCT0Cufx0kgYpG1CiODNxOuqjWvhnCodye7oazkAiInsXKiQtJiDwaP8EyDdVLpVcrgrNieLEaYxeYgWBiGHvLSEIZgaalUBWBUiHo7VpmMgEfzFUHMuOAH4e0phB/VIx9uL6MORNFnLH1my7o4NGUrlhITFW8SyiB4MkKgRjfFM8nvNW9PFDz1Ao7n7K5sggUcxz8YdlELDa1Mf1xXHRs77FekDSq02Q65BStXIbt63gQMHNgU6dHndw724FirHv2MxP5QBTOQ4lgB9vJNnis3NqWNm5DMXQqNckXkVfbh+P3TeH8UD0KLpCgOy6b/81cfLNCdu8jpciFsr9wcJhATsowl4aSXoAtkSVqADyuMSAY0uOClu1jv+0Q7Spw0mOU9Xaug6dlNTjYxVfYLRuFLJj70ExAo4z6ap+ylI3y0M24EoPvQiAux1H+5NafhjZrrv7+x1ToDRahAGRaY+VcKQeh1tPi9crP2/DawKr6gOruMkd0WWcuhzrdUP0birfnGN22yuucJWjmGUS03fdf0WaqOnWyBH98ZUR24WAYGB/YQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlvtarU2qYavylVtZOyU1ximoizw0VYOUJNG1IDgpO/wRXIoTJI0KScDTSl+?=
 =?us-ascii?Q?Ui1KK5Nym7nFMShU+Sa70Im3zkdCwiTjkxTXvhHjh/0rVRrmBs5IA9R35GtA?=
 =?us-ascii?Q?/206PEEbukyxVGDoz4xPyb00hDxsvaVWklN6wx1ON78C8vewhAsgGPp4Rfk2?=
 =?us-ascii?Q?IFU3f173Bfo+f3SuhQrNQ/NoLCzfzjQzSTTAsXdL1PlKyHHVQknDi8EzBqLg?=
 =?us-ascii?Q?LyfKwrdzqDEk2ROrksibSsBFVAiKHPecwzM8LCYCJpiZiVgxyuK11Lv8wsU3?=
 =?us-ascii?Q?a5zmcx8if7U/D8JWKR8dYR1Xn/8Nb6tuCv8puKYSiF+wtT7AayVfwmE7gDv5?=
 =?us-ascii?Q?muhSXh17Ux0vNqbmT5Cbdhxvl7Uru1qmOjE/vufdH5to78FeNt5FHcTEO2G1?=
 =?us-ascii?Q?gdx+ctOjDtkVhgA/3FnniF8ZZ4KOTHBnCQa1+YfBvomrwYbPHIOMhY0FWrjW?=
 =?us-ascii?Q?JmnmX25MJCjA/gAMj4B2y9BFHlQbMElmxN5kK3mnu8C44OXbhEhD6iTiB0TR?=
 =?us-ascii?Q?dB4WBH+Tm80S9sa8D6NocU7BSm97gqkzHTg9fSsftVnyKqy3IgH2DjyZJEkx?=
 =?us-ascii?Q?evC1m8/E0FlRnzUenq2yvNF2FoL6k+QMblxxIOKejjsVDRDLiY/yAdh1Imlc?=
 =?us-ascii?Q?NCIRYqRmlC51bF2GYqLCit/B+BaQ8mS3H0LHHd4dxizRlLpuC23U8K5hYCrX?=
 =?us-ascii?Q?fQ1pscg9pbEDOZQ3NEQQUiXSGYZNKwFaOQAouSZYsEeyuXTcB5QO4gerRoKC?=
 =?us-ascii?Q?IS0jPYQMBPykHhRSNixMTLSHSI953jkZ9YRqb8p8UL3DpzwKl6zQY3RKJZFR?=
 =?us-ascii?Q?F7+naPgsiCrwcwOfeR38WkjrMjH/3u7A9v2HzZVeBbggHqUxgnq4X929gJM2?=
 =?us-ascii?Q?xYCL6SR+3ng+G2A1yau0z8UEPZZVJ9OAXlmXC/p97LQemj48bYXMIgcZBjnC?=
 =?us-ascii?Q?Q7byuMHl25OIL7LN5L5ci3UPDGNSNZ6WjsOQOn9R7bLbP6+Z4BmFN7TNcGJL?=
 =?us-ascii?Q?KwNGQcoH3IN7mgzXWYT32byLC+chDOQ5f834Ahj0wrBDEN2FRhhwogv2c8Ow?=
 =?us-ascii?Q?fZK8gfnKxCCb+zV5SS1k7rnS5EcITkMFnKMrlWbRN22JoscdSS8Wh5+PBvtN?=
 =?us-ascii?Q?LaJsfNivu+IP+Dk+yLYnCIhuaVa+6cuNVaHn4NW5Y6tS0fZD2MX4xZfPXGgV?=
 =?us-ascii?Q?mRApXy9z2n2WscPgS4IV3j7xbY/7nic7dp+2Xw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kdpn+5EA4O+29Sj4+9NJ769ys7TZjJS4Fel7TvfKilMwj3nCSp9M2itakSFU?=
 =?us-ascii?Q?rkIK9P672GXUPvhQTf85vt5n9dvMTT6coDaxy67xkdr6l1LEbkuHEiL1IDuT?=
 =?us-ascii?Q?SvbFWKpB4adJP+mTyHV1ju6sa+H5X9FKx14K+exNvIrNpRBvyor/BUouwGQr?=
 =?us-ascii?Q?2UrWqMRtNazOpS3g9jriV6fOLD1bwJus+Wo/x67FdqWMeZgT+JNLzTg8LegY?=
 =?us-ascii?Q?dWwAb7AKkHXa67TXJPFqO/fjKtyCv6B8CdWciQLDCPNyCP7ctHC8/1HBuqRH?=
 =?us-ascii?Q?nycbaTI08ZiwnPxNi4t1uhQIAN6o2lUAf3ecAKwmmPLJuGQMHLcKoDaeRIES?=
 =?us-ascii?Q?MZBgDme3+i5UhyjpN365bhasYvdMnTM8zEa/iG66SEdojaFVQlV1dkdX3WtE?=
 =?us-ascii?Q?Zs1hjHwKJSrilBP8kxbGsEpkwiOcLvQApbkhJsVzZUzuFOrsvZrhn6s5X3/z?=
 =?us-ascii?Q?mbuV/4pwr6KuzD+zQ0Zwmis5SYQMHf3Ot//cSZdyK4Q/B3Y3OqSnBytM9YtI?=
 =?us-ascii?Q?2GgYUrnaKOI7XHnrok2DLH6LEIXG2+B7Z5Q50fyT/MeHE7o0AJVDcDH9uyY+?=
 =?us-ascii?Q?DwpXXuXid1zXegfMV/b1VeqIJTsUKTWIOGMtzyyptyDgmFeKysmTULdCGjQB?=
 =?us-ascii?Q?ybyaZIGSZfWzHhUocxHK1hI3RA5Re2MIhEFqnlL0UGVAEAHqMNXvyE4iWkPf?=
 =?us-ascii?Q?/DOzXC0oyb4jdITOu2uVyu0byFFp1y2GYBh2wE9mMEFqxpDrqXxgCp+zSJqB?=
 =?us-ascii?Q?ChUPZj0muTOmlYdqzBp86zfU0wEgPDtl8mYQDsVyBbyvhZYn+FaoJ3O0ohv0?=
 =?us-ascii?Q?AuNuR/NOxZ3LHUfi/PSPSVKyAo3wbxN1WMEjr2f6ghhS7+fVk3E6JFk9uTZm?=
 =?us-ascii?Q?fA9VZsUnPRKT2u8EZc32CIzsfGU4+gmMAtiSx+ZpRM/Dj7oemFDZ2r7HkoyG?=
 =?us-ascii?Q?NCD6MDR3QDRHFJ0BEW9OiuYEb0Xbo2t2IKWlfWELfh01bZlE/f7QZ8T9VZHU?=
 =?us-ascii?Q?WYZ+MmZy9kXm/fsjrZut5tE7E5sjjnqb996vChCcvCb9itGzyZ/mP6ztChtt?=
 =?us-ascii?Q?uAYG08kabFDBc21rrrBLKfugcA1uFCxbSmz+/Ry7VFQnwNGwaYAkBPayi6eK?=
 =?us-ascii?Q?6tOoIo27d4G2LqsEHeH8i+X/ctpji9mls2NOEA/agNYvZxzGttBAxobOdF0W?=
 =?us-ascii?Q?UmalEFnqulcBb4S2tVLPq5IvWNsyZ0Y9pyXWEUDHMC1BzDNUpA7Wu+O7XIQf?=
 =?us-ascii?Q?Z3aeo5bEpYRxBEHamPzK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea82b4d-0454-4999-f178-08ddae77fe9b
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:15.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

ltq_get_cp1_base() is an exported function, we must define
its prototype on header file. Fix warning:

arch/mips/lantiq/xway/vmmc.c:22:15: error: no previous prototype for 'ltq_get_cp1_base' [-Werror=missing-prototypes]
   22 | unsigned int *ltq_get_cp1_base(void)
      |               ^~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index c2e0acb75..dd9f621d0 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -99,5 +99,8 @@ extern __iomem void *ltq_cgu_membase;
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 
+/* VMMC */
+extern unsigned int *ltq_get_cp1_base(void);
+
 #endif /* CONFIG_SOC_TYPE_XWAY */
 #endif /* _LTQ_XWAY_H__ */
-- 
2.50.0


