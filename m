Return-Path: <linux-spi+bounces-8644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB67ADF040
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82BA3B97B7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7042EE617;
	Wed, 18 Jun 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UHj0Pdng"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9D2EE605;
	Wed, 18 Jun 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258447; cv=fail; b=dKzQOH/fagAasu3vrM/WE7FQv/B8iGu9eMcfPn1w2h7E9N55x7YOqiz/TfrKWwXQKx8qwpScqYmTY64vKUayQSRK3x1COp8ocFHqU3rIbZ08C2hVNgAOU9t1WB4pxwvrHxHGSsrgSTauiwDfdq5lVoro6zMl8zjXl21n5iONuh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258447; c=relaxed/simple;
	bh=nirVoHDHBevZF71WkVKoXAmh8fHsuVUaczUfP386U48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOOloszzygqrBcAG25EYNKFhTlUUYuLMoKuPeLgCcNLblaf4FMmTZrhDjxh6FsvskXWNXIGmL3KS8ofckaHrDyohkYDs0L4i+AqdsBbmCC5HQWLshD7PlAMsGOc9r2WCPt0CMVXP9MTjA7lxN1TxjLFg40muCr1Zvj5MBtW3PQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UHj0Pdng; arc=fail smtp.client-ip=52.103.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igjulGbnFaT95d0v04+GFgS5c2mI6JNqSHz9gV3tszJk6f5Li/0GzYDYxjWn3MOTfA6e+qoWQlNN6SLaS6ECsCdLsJ2ncDBGfZ0l18qTmItwW4H4irNmMcm8jEFiGr4UnNBN5AP5OAZGbKuOlPy6JJi6e9tscsSEZArpmsWL1BvzrLBthBrmrtTMwbxWfOkK3lwHEGPDcf4y9vVnY6xzo+hXmx7zsxqWEeYdQ4LqWwWjhF0zjuS284nhTGHfkbBSf71UD0j8kRfdNYwzbqCWdJdUUNkBGQdSpCJrHiRuYQDxnEhmwIFZ0jqTsPN9hepM818KlamEb89FhoZGi6EVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm7I8ZlZjw0P2Ul5A0Mw80OldDtWWnSf5gRYKy+RzUQ=;
 b=MeYmy4B77Wt8isPHw8B7yX5wKMLQ0mY3TPOQw46V3dW+YJ0xKB4A1BOwi0ytMXn9/73Pse4OGVsietpVWWu0VxRr+MFH/39IOF94tDnV34V/Gw6VEX+ZidlDlCMyJixyQ5uF5djvnpFwf9b+pBwAEXzWb9RhPThVYac8MjBw5nhIm5WhjQvf0Anfa2/CRGL4Q8E4Bm01SAJGgI7lFUnrzpBWItEUKQGyzzbd1v+QuBgeFnl9KInpuleWbfMmX/gZTl3oYXQbmljrR5fTyt3ctxw3qn/b20KoqPKYCD/Y4ME7/u5QJ6bOMrgPkI9RVqyhi0ZJzmbsoRx0n1FcSsSk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm7I8ZlZjw0P2Ul5A0Mw80OldDtWWnSf5gRYKy+RzUQ=;
 b=UHj0PdngI6uepeKhx+CPUAJ/8uj7al6CPNQPwFTEwogPbIqOgI09suD0+SUW8nhHDdGEKgdbqhY23s9uOVgemJ1rdaBj7Cs79wxlMy40+F3rxbDm1M4ToIGtLpM+3/QQXVUrg/vv+Qg+ZJWNY6drtZaBU/ScwGwmE0Sn0LpMlAmiLyUkc2R45+FwBjswJPwPDhxT8W2rR/pI4wEK/iMuZIMqV0MkSpZy2jVP46S2Kvyio6qZuXAFliQ70QBPvoIiP/XbeeBvgPmS9FHelKPeYD1+IvMs33GZ4eKivSDaqAXi235oaae5G3aXvOQH2hLGL8q4X8OtwzamITlrkSb05w==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:01 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:01 +0000
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
Subject: [PATCH 01/16] MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
Date: Wed, 18 Jun 2025 22:53:14 +0800
Message-ID:
 <OSBPR01MB167036C58BEE8C1FFA94F69BBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-2-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9515dd57-e36e-4741-3d7a-08ddae77f5fe
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXd2DcaTc9GHT1SddFV+jchKF+/Ml/tDSpRlRqPJSKteUvGsY0S4gIqOWlJeBiKgFjPu72sKkhwvlblZLq2ML3AoMO8Xp5dhDh9Ywdnrf665UUL+AW7p5fJRoEyvHWNYLbmbetRIUjWmWOmpwMjASYSqfcj2BX4jsjgOZsea5zsg86FpwCWIVgC0H2PhAheiaS0HdKBNJyto4AeK/u7fQ4CfMHss+fUZSGNUh6Ye4lnr461IDnVwR7DWc05F1qL5tvmdHq6xf3ww+IfcXmkauyuWRtmts61HIs1pX+GWF/Vd+EAvAefdY61tmK4jZfeUPo8FUvDP5TJbX6L29eV7JcYpPpZNtRk3s9BRNV6OkEC+RzPoK3CgZvJm2lSQojPaYWVqMo0QeWTBH8zoLhylxY5+rAUIEVnQY/UaK3J9S+XGsYxetFEAip7gilxYD3GrY77jnvgBg8ab/5PPweI7DifIdTcJoFuM4zr6PkqKIhIgka8efWZQvKBFDqDbvXjfdjqmlXcRxFuGhWgLKEnBpVIwzsdzmJwqkjiH4Mvj12w3mQpdyNvPGZdPsdU2vKuvi8OYv93X7KQXAhw4rsW7daJyb3x/SKVsG34Zx+5Nl9ytMdzCk/lffQWyeBNxX9YxNGgCd82ySsrU5csjC1oACJg8DKYXRDXRWhM+Fm8zmfpd9C8VHEW3nmg3hvLtH920CAzxi1bfQ3jaTJ5Xh6TNPww0YmuywzE1v+1x33RydlEuCo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wxYpU9j5eChHPghJNlSz6F4oXVI3PMsB8kJ0ND/KyPahxUb2qKRBZjN8e3nT?=
 =?us-ascii?Q?goNpShvLh8wOMmDZnqjjbubQZWNWc3P3SSx4TCJ2HlxsxpZcOE+Kb0uNrSF+?=
 =?us-ascii?Q?UTY3dEd68omgBM3CvHqS0RlVMjxZo3ZY492WNAEPjqwdNT9zLjMNYvT1Tdl3?=
 =?us-ascii?Q?dPf8I/3u8xmWGXG118lkZhbW1KItntS216lSg8qlH8FR8QhPfLiukqCWHDGk?=
 =?us-ascii?Q?UZlTDEkTVqp5GO31Sq0XrDRAYlYhyocwjPnIR4N24S6Y8vznir8gnfPt/KyM?=
 =?us-ascii?Q?tpzwoU+LDsxL4655x+TRKLAV8j0VGuuUaZQJCT7hfij3dsRnSDjkOBkfVRma?=
 =?us-ascii?Q?hnh4Zt1jiJkFWGl++nvzYXKULN+WZgK15LFzV0fMveIT+tVK4n9yCptXpSFj?=
 =?us-ascii?Q?zZEmizaaJEwafgRO8WveVCSVtIIQQZsnCv81ZUUn0hCVCeS6DNyJxC39WXz+?=
 =?us-ascii?Q?zWnqsrBt8NTDc+Q/DlfVXQsPi5FSJOA+AuaKLbFxAEVkt3cmLmCA1ZlRcFNz?=
 =?us-ascii?Q?JO+5+CEF9VX2WdjKyBjOaxa+PVqQnfrXiZ/fwdgYW8agOLItDmdqJ+zkSTtq?=
 =?us-ascii?Q?HwJxA+GAYqGnYKBqy55RoRmXWTxPPXgnpdHX9jwqODCtqneLxIQkmbIhhxgC?=
 =?us-ascii?Q?JbTHNT5Ucmn9O5ER78tiykSoZY1zlUt6LCgXm4EwGKHM9RjjXDkftco8vexv?=
 =?us-ascii?Q?geYtkJpnmjnOdsQEJLoP4F1BAsyvRIuudu+gCRTFb/Wc2RyANgUOssiRirob?=
 =?us-ascii?Q?dP1JO59QBgv5Wur+RPwennp8381uht3eVPcbHMXm1+E4Ri+sYnlWty8rn71I?=
 =?us-ascii?Q?f3ZVsxfSB6fHrivYFy2t8mYV88OnUFJLj3RiXuaGVA8BTZdWw3JpRPuhWgHb?=
 =?us-ascii?Q?3hucHNX43qYYmN3R2KpQPM3yMmhykzigDpka0xgZ3QRj12NTrgOCbafWpOXw?=
 =?us-ascii?Q?DwN/G/5xc+awtCZgeccGJhYLHHqdKE3gaktFzsI7AHbQ939zpA29E9jMmJUj?=
 =?us-ascii?Q?4rhrhSy/o6whPsiTBAz3442NuFH83HVzihW5U+exQiW8LKmmNUcRWOtGUAPb?=
 =?us-ascii?Q?eFoofhn2Gnxd/E9fThV9A60ZRzU1gF3xwM5vngINTW5NGb0yBohpSEvKrhij?=
 =?us-ascii?Q?GAvwDVlLkJKPAI0MwJlfP+YV8EUcRSYFE8o7J/L/ImSXJt2FPX7k7HiNGJ06?=
 =?us-ascii?Q?mK3gMgT8FcyVXMF0xiRo2pwe+z0Eibor/fS2686GcwumE9uvFHFFiPRsqMY?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOSraQud2HGEpRBfTyDuka5y/H7rqgVSAx9wlsHlDg6XWdWtIh9aw+jcpgSP?=
 =?us-ascii?Q?J7WMb5Gcaz24axaocfm/3jMvBsvnr3dZ/vpXUDYZaR0c9Kz+P0cVAe5lkh+Y?=
 =?us-ascii?Q?PctRkTACxITokNXtCuDox3YiDg2ACQ0200uJdBBiZplvbdp7fdxKzI7tvl/O?=
 =?us-ascii?Q?HraOkk/wiEtjaVSzBee00fZTY9Oo564HBeZdlHVZoEuDiZwaLjPECgXvwn6Z?=
 =?us-ascii?Q?RATJz6cu46uzAIyhrkximZPAqSKeSfQuYiOQbS6mEggXvHHt8HZ1j8qbZ6ov?=
 =?us-ascii?Q?40FFeZT4ZQQbvEsrhcI6VnxuP8Z2Fx+GmGQ4BUSiPxgdVePP80o+IAxXvUx7?=
 =?us-ascii?Q?ZihJwz/hwJzsEPIaTRS3BPhVjmLuPpt3hphhOrHvzIYJFkkwi56x+mHkKQdy?=
 =?us-ascii?Q?1hdzwpRfpe00RTZGWTHf449Y9W3M1eSdk8uwOXUGwdqtggzzeV3H/f/VO61p?=
 =?us-ascii?Q?o6MRZuPYUu3b4tMEK6oIt7Niq4CTSrKBsP5WfIyqWKyw3CwtumnYL5cvs3ls?=
 =?us-ascii?Q?On4ASYo170usbOI0B62KKNDS39CqgMp6UFCQXPcZuhJQUkKoe/7GHzquwt2B?=
 =?us-ascii?Q?/SRpWhQrWoYXkzQjRK8BOBABOvQIzb9Hp6NE7nsByS3DT1dz4h6u+45Q6NOW?=
 =?us-ascii?Q?GlYtgzzwyWWNU6IiCrmE8AOmZujygC8hmr0Jmq9abbsMcWywohKLK5wWHDM3?=
 =?us-ascii?Q?yGD6/k/v0F/yCaixOFJ1D1H+PGVp8DfkEarkEYcbmnSDzSmHdDdz8npYJMKj?=
 =?us-ascii?Q?2SDaig8DaWkrfFCMyagDbvLEjPrmb6uwPoJxanvyyX/d6lmKf0RSbOORSli4?=
 =?us-ascii?Q?dTA1VEmd/Qvxi/p+38scLCqkLSXEEYs3TV2tqGwrq1ZuKQPLUzcsC3r2oqMR?=
 =?us-ascii?Q?qrRlJdKgnWuLe9xRq6QHphyaQFVjpBNEIb6sDxLdzodGx2I4dCzLRNCCpcRm?=
 =?us-ascii?Q?TcTR1nj5p0cq7sg27PZK0m+cPipk5aqDs0BPO+gN6J9bWXFpnq5OIWR7KOhz?=
 =?us-ascii?Q?ULQj3JTSZjNhTU+o7yruDP+IWVAePZPxwkH9cfDli1C+6HsKVlYiZq1CTDlj?=
 =?us-ascii?Q?dbfv0ky/foGSwwi+YV21uCLToaBD1cM0c2+VA/4HCLePDcqO/+PV/cgVshV9?=
 =?us-ascii?Q?Rv92ifjyTzG1HJp36QKU1Wo1EXmmPRhzSIBDUBYQ/ADJTqcXC447ak5ia4bP?=
 =?us-ascii?Q?mJvr7mWgvDXYDrLVNMAem/OJG6oZZoVYKEpK+ruX1//P+kMjq22ILNdOlp7b?=
 =?us-ascii?Q?X/S4Bd3eUPnSUvuQU/Ol?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515dd57-e36e-4741-3d7a-08ddae77f5fe
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:01.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes warning:

arch/mips/lantiq/xway/clk.c:77:15: error: no previous prototype for 'ltq_ar9_sys_hz' [-Werror=missing-prototypes]
   77 | unsigned long ltq_ar9_sys_hz(void)
      |               ^~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/xway/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 47ad21430..39fb3ecdd 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -74,7 +74,7 @@ unsigned long ltq_danube_pp32_hz(void)
 	return clk;
 }
 
-unsigned long ltq_ar9_sys_hz(void)
+static unsigned long ltq_ar9_sys_hz(void)
 {
 	if (((ltq_cgu_r32(CGU_SYS) >> 3) & 0x3) == 0x2)
 		return CLOCK_393M;
-- 
2.50.0


