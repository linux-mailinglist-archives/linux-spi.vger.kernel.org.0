Return-Path: <linux-spi+bounces-8646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A60ADF04D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C956B3BDC30
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A62EF2AB;
	Wed, 18 Jun 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bTRd6TKF"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D72EF28D;
	Wed, 18 Jun 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258453; cv=fail; b=XdiAwCABh4e3Mllu5wNGd48zyzueENVZx41RY3kopPhV0N+ZYK3xbutJD9E04RySIjHcJagiSqr1frmsa06sSu+j7O/R9wAlrjM9wohn5y9/WPx/TPuk7UDYnULCiDxgyIL7gkLCCUdi3h6NeQxkMjhwJUzH+7bZ0biJK5EonKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258453; c=relaxed/simple;
	bh=wcBREP+E1emeSaWIix19k7xMERCvV7o0AUj7EtoLd4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iv0tVacoheLjEyiG8cBXvILsIq/Rm43lmJ2xYv8iQFh+zo8VmfUjCwoS/D3/fg6fIDdqLlSJvHh9PVCL2zuwbnpZtvebtgot9DZ8kMkoqFjgj2o/bzaEVZN/WbNb676n9cFHNLdcEbXEfbCDUXvGOTzy+P6Y9DjAWlPc/DTc9Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bTRd6TKF; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ufwn27039/fDS3b0NCJ1GHtSO62DoJngH/ydXPfpY2XQEEzaAzDRs1DuYlZsmSb2nlX+sn4tvTpg4UuhGIb3keW2CeWVMyInJsrWVeT6AIvIJcHy6tqnFprVm/hYg3RDpv/Bk7wuhXffW50OYiBusWUIw6AJfGTl3ajU4T71ZlHPQvgwraWNSYvVxYr2II5hAzc8cRMnVWhi26tqK4WFlAh3vXspaR7shEHtjESScJ92E0t/YHLi2S12GK9jCw3XQ0q6g4YfyGP2ChxkQaGHD/UFp0nKOi9HJnQxMr4O2fGUPLUrlQ4GrvRJLsBxBVM3yGI9sU6x+gWvpL4aHqZoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILICOyMAPCRL1lBYUyGEL+42KBjPnnRBvULtAO0qRzc=;
 b=e2ETNs6v6bkOu40L+wj+XiTEOg8/TWYUZB/zvttJaUXAzcPzULm6qBWE2Ade4rsrDR/fK7hNzDnRUP68oWijtUx02lfUG9JM6v40zmAL+VFrRH2TNRTsw8FeR0MJEC34TVmg4w0EB2s16aaFSGrcQxJXV1lsAWiVI5luvqaJlOPbj4qrg2mGdYwZJHpmPwkKoZfnk3dizX5JRAuWFo5/pwXVbP9lJjY1W0jhR04BUZ/DY3MPUoXRAvOzkoPdzq3VUR8DjNWf6h013eP1ESTCATz+a00rS2s5R5zRN5K5h3o8X2nmf8SUJMYdnXeEb9sasQ2WWJLE2iui3R/B+mccfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILICOyMAPCRL1lBYUyGEL+42KBjPnnRBvULtAO0qRzc=;
 b=bTRd6TKFhlbO977KoQJ5gX7cYgSfIBRmXXja+wQJOqjYG8+RW0LmxzpG68DyMAhfu/T/UlgTIf9dgLQT9OlUMahB/rFf1LOHzPeEBlzXa+/vwbno1EwTMl74TSTDZzMROZWMmT6lgqKfZmo2iQ0UVTxMecsU27p4zWSBCqb3TLPejLmNpJSdUPh1TGVRizDylWqMOzbecebRlNwv0Gk1KM1x2zOGYZ+jqUiNiGZkg7Pl2D9ha2iVvY30NOYz+1Q4VByCm9jrv3dYuTabviJFQEVvGlfsGkrsvhsbDQ4eBLb0qxfCMeqlV2KuiNXCVJ91xUaJw31KsXP9dO8+04lkYw==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:08 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:08 +0000
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
Subject: [PATCH 03/16] MIPS: lantiq: xway: mark dcdc_init() as static
Date: Wed, 18 Jun 2025 22:53:16 +0800
Message-ID:
 <OSBPR01MB1670EC05A5E26AE7109E74FBBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-4-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 767508ce-755a-4ad5-f01a-08ddae77fa22
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXddCYXUi1i6D2szTHGIEFTmVEPqSpvQtU0YbxH4t3s5iPB/y2KHhtqN13NBWCoDduclqXwP903ko/GdtM3+SbCTQ5tGU46vnAoiuJlZSzAzddOUSAOHtsUrJUalRGxW9He0B3wgTS9ztCa+haRshy0K8OOC2iOx06Kt6Z+5oADUbQaWYAgZ468xze5g3qQaFhtEaC/0PAc6GHQVqqC2zrifRFH3sUu+fpfhRtLtbQ8UIB+u7sr+wvifcvMdQY/kKIeZ9JkhZBaFGqHXKHyYi7SZSNygz1rzMLJr1B/VDmL3X+6osJpZ7/83M39ZQspTI2i9VQo/6gw5n+P7ZKQXytG0zR1Fzkgbqcw9+MdXD+DFx7A5O66fMg1p1NmYHVbFcErMz2DGbuNZzyNiwf2pVldeiRdvRd1qbLclAnLsmfP6Kv90je906JLvb/oN2IORji9P8SU5AAD/DLKOjKocDJ8x9U4809zQ0rkEJ2E5MAVsf6JLsqcTYLaiVCQh3Uc9cRct9DpwbCgT4KIj0XbiEpd6LUC3Up0Xl/GSlz625zitgC1llcPiXruN0XXBZrpPj49n8kcw7n3zyrocbs4Uc1nH3x091fEb93+9mxfZCymZ28Axka8dw53Q2Ev4W62e2FUGDX4Lt7MTb3ChZP3VTOJOlJvsg2aI1DETf4VtwlfrgIRcTI+5sBoY/dZQcph3VWx/qgHWFVaVp0VweaU3l/TeTyJDthePsI/21t8pUpbonQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K6/zqCsSS4WtZ6UNaUUlWkW6onCxIYEjje/e19Q5y1nGvuhqcP2VTZPSMhAK?=
 =?us-ascii?Q?CW7gB9OZ10yrHNFhVKvrQ7BLJx8DXnNsKln5h5ZjhraBKA1B0iHKey2sWCLq?=
 =?us-ascii?Q?LsDNlInBP3l8yRaG90F1PdPwQDkZaoZDjmEfU/DvcZKdiCpwULoPmcNMta7T?=
 =?us-ascii?Q?53ADQrFyGG9IjVn/62fqNmdKfjuUoXFPsZBGq48Y7DbJ2pKdENhgTQDVPRZ/?=
 =?us-ascii?Q?YKxrJdERklQ63lpJmTw05kHAVgpxnbvAmAK110RXXz9mF0Mxh5bn/WjzrSO7?=
 =?us-ascii?Q?7cGjor8nuDfPEs9Mk/visLq4SIj1DMH5LiMbaYCSoUgDwsF7MFDLCBagOEc1?=
 =?us-ascii?Q?tku3QiSZ+6OQwS5rVRu2Ua87ZsECviyuBBpd/xYMhmKnlMcaAXMPk3900F2m?=
 =?us-ascii?Q?ilH0B9fL75ZXXoKq6f0nJymG1Y7MMknUtbEYRNm/DYoAo6YmNdc+D2fCoU4J?=
 =?us-ascii?Q?2Hg0p9miQFPlK1tuanXq4BJHQQG5J3d2Gpwbdc7O5qRWe2zUf+CXTGtJXs5B?=
 =?us-ascii?Q?ehO/J0DPUgkAvkAEWEI0IMiQDGFSLldZvakKNVMNmq4sgm8sB8RtLOuUMCJ6?=
 =?us-ascii?Q?juUAtWlDZI1HpDlpbKrljIpd5M/RT9mvLPOXeho8RsjHKC24jK5Vdhtgkjy6?=
 =?us-ascii?Q?n+8lCqynEYQKdho+a5uwKhUpq1GIMFBDXcCNWrnxRJeWNHSEimrcg3YobHK4?=
 =?us-ascii?Q?rlQwN/Mt+e/i4FeRICserzW8xAcsl29IQJIjiX78TjOkiMW3VNujYufXENWI?=
 =?us-ascii?Q?q5qLE3qjDwQHbn9HrlSwk2DW5CwQskpqXXHGPkWAkmacVpgNPVJVaT9EXwSO?=
 =?us-ascii?Q?jjr/LbyRkqQqWSDtYgZ/eOQF+wnsM8KoaAJno0DmN1LGEURlxXofX2HFwRmL?=
 =?us-ascii?Q?2QWHWjnyy7TRvlRwcjARg7/3PaLP1/EVYHxdCvOIbNAOMa8CJgGHULCgTVZE?=
 =?us-ascii?Q?vJhGxxyTe5TUG4EupmT7PaXw5ufPUB6NqRt4ZzR7bRdCfY2c7L2RXftb1iO0?=
 =?us-ascii?Q?fuJfDHaV5BIgPiWTb9xSGkDVoyFzTMhOhGlmzfIwCxkGWXsse7SopCl7ixZc?=
 =?us-ascii?Q?kS/Vj3T+b/AlwH5xbvmUJ8gLlWG99FRrNueFXHALVSOs5nwJQcVe4z/9Zwz2?=
 =?us-ascii?Q?zPXTuNXg+d7ucVe7WBKrmrKyKWP00Fpj7ohemNet1svt/OCceY6OVyOXR/mB?=
 =?us-ascii?Q?dK4r8ypP3nXEgA3cJt3FIFlxmaXexTQNqr32vQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgQom3e+oY0K+TpEaoAlPCk3j30x/6VXaSLbwdfpG7MPM98LaK/og5+41NMU?=
 =?us-ascii?Q?8f90q0tLcwMXelbtMtQLtbqv65jLwTaLBImo9Bgmg1D88+koI6JmQQIpt80M?=
 =?us-ascii?Q?Ca48t2s4D3KuylIq8sj2xOJpojph0zAs+3jRblZgO17W1qi8Rbz2SUlpVL09?=
 =?us-ascii?Q?Pk9KBUz9ehqLWVTmV6gEdmmhgbPjycGuS7bOg1DIbashAz7f/cwNLLNfmfVJ?=
 =?us-ascii?Q?mmsjZmjYksmtPpebfa6XDDMlp//h/52+jVmTP1l7s+AX0Hf/i1ZRAym69x3B?=
 =?us-ascii?Q?i7RNxcx3HpvVCCrpVnTj8YKWhIzK+XSj66f/ZOaLzOvKCgQ4N41FLhpVo0RF?=
 =?us-ascii?Q?esuVENbqHm8qNZDZ9sRMS8fK+dlT+A5SpYX8Oigx2AqN6lcypm7eETi0Y2ki?=
 =?us-ascii?Q?BRdy5zIRZzV6UggTH5Gnr6UOySLEocGhFSaDfupGiE/6DtJMX/xUDQhehKHQ?=
 =?us-ascii?Q?h0GAMtsaLCbSMb8Cu0wWLeZ+rdrMi/efXRT3U859IDqIBUw3MsrgFgRixmX/?=
 =?us-ascii?Q?3LGl0wpfwNx8uQRmEHe/L2Ahf2YZ0T2u2uxNpIHg7aj6We0KVfvtXZrfG4GN?=
 =?us-ascii?Q?OsteEA24mPUjT/22lW0R3HNYKWjimORIQEXH5a9olj4jEwdJk8DGHHVSwP16?=
 =?us-ascii?Q?PrbMf2ClamHAoyC++kUPvH/nmXhpkTRuhyugqY8TXbc9fD74RLsscdKPoCDZ?=
 =?us-ascii?Q?m0U9V0cJtKN28Ro3FAzuQ6Kn4dwBSd69zBWB+y9q5d7dfbJt/1XHEfTLIXvG?=
 =?us-ascii?Q?rzjvAUdK1fj0mDl31lcsFWLr53Xi4oiXoJiQvZiGlAqG9BtMK/7iq5m7haLK?=
 =?us-ascii?Q?Nbj/3W3I0FJr/Y2AYknh7PcddYB0Lmtuk62CRZcRWU1yXhoYm0osvqdnlEvm?=
 =?us-ascii?Q?shJ3+Pz0bco625LO5IG2dZNLMvFRnnu3FH1QiUfNKoqDtUZl1gLHmtVrqylc?=
 =?us-ascii?Q?LVHJUgFeuXPc1NDNKD3MLwfTYCwh8yuJNU6PKktINzQ8+jWBF0z5M/LsOmhd?=
 =?us-ascii?Q?gnYJRkAiAiDgVazvLj6M40p0U+Jgo603TzXqw3MHI6vYlyBvRqDo2BD2tQlK?=
 =?us-ascii?Q?Rudphv4YeWxOvTgNv5x61jktt3HJSgQ1Qx9NVyYsO2WCCG7o+xp+/ZodAjsH?=
 =?us-ascii?Q?J/O0xiCvcxFvir/0AqotdIc3bB10TTozdxNXlKlrgsWyAATs8fk+c1/s6rhX?=
 =?us-ascii?Q?0ZOBeLuDeH7Nm/vgYxY/DQmgImkYBwixKcBsLgcRidELUTp+q70yD3PolTSS?=
 =?us-ascii?Q?ZKoySoj0pGVSGNDwSPJD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767508ce-755a-4ad5-f01a-08ddae77fa22
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:08.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

arch/mips/lantiq/xway/dcdc.c:49:12: error: no previous prototype for 'dcdc_init' [-Werror=missing-prototypes]
   49 | int __init dcdc_init(void)
      |            ^~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/xway/dcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
index 4a808f8c5..b79c462fd 100644
--- a/arch/mips/lantiq/xway/dcdc.c
+++ b/arch/mips/lantiq/xway/dcdc.c
@@ -46,7 +46,7 @@ static struct platform_driver dcdc_driver = {
 	},
 };
 
-int __init dcdc_init(void)
+static int __init dcdc_init(void)
 {
 	int ret = platform_driver_register(&dcdc_driver);
 
-- 
2.50.0


