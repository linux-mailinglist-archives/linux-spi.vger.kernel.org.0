Return-Path: <linux-spi+bounces-9440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CDB26EF3
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F0A5A8272
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F532248BE;
	Thu, 14 Aug 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKM6E2IO"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697E31984B;
	Thu, 14 Aug 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196326; cv=fail; b=SlsyasEiopYw0TyvyWEFi8dQx76UvTMwJ7Hmmkb4MiLGxzyQ75EK1KyXlt5n/VGJjyaOQZ+YXX9jc3+2MWgchgf1o7IR7/cGNtIYS8Enjtr8JNSehS8XDC66Yk63lrGE0+lVxkQj6XwgTWVXjHSJYLJrQHTjD2PyRAE9gDOgdyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196326; c=relaxed/simple;
	bh=qxfSATh5HJ9D8lGZZH7zNUQH+Gu0CC0iA0CcRkzo+s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkimzRKsrpxRA0mEWW4/LswAIpyfEeOVqRkHZS3iccZ72AuBgTb4ZwG9h387roIHcevuY4TF/XtdRQmJ4kPNxKH1XvKeiuH4e9zwHjGvWWuJN8WEF6lN8T4WZ30LPTRMWIkIAl8pfOzGytHPKXhZUIFmgqzy6Yngthm5PFhvgXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FKM6E2IO; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex3+rk/BuKSBuvo7qvOtTF69xMYT/tRon9oghXkstmpr4Rh8a5QDlPZXnLwjDwB/qdPp88zITuBLwLTSYmtQ4OiBCnRx7ghg/XlLnL7dBqwIaGJanxbMf2vyM8TbIvbQuJ6iaMMyAVq/x8OIp+JVUSQ3PiZ3tvUMirCKOrq17M0nE0GH8DUyYlCnRSZS7M3Bj8OeEnd+EqbkScjaAvmWGlFi143WBc3Bz+OtyU/ixyLmyXhxMIEQ3FL9FK+qWf981jy4xUeHhpylfaYaRn77TtrNlyVSZMryqvulI0p33K+8L/PtHMB2f4lISO5eGDoQn8ZqvIcWJlo1sC6FfUQmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C4a1EthRb6W/JmlE2JwgN+rdHRZfTkElOCeRfMLeY0=;
 b=SZy3gSs2UYSWJm+7xUVU+iJJ/Q0BCcMp0scEVq5OlWZ2UKWgDlKVIoMtodJMvD8EXhwtJd4zq8SJYcHffRzAm7xkr4WQu+RRcg6l0pue7d0qIDxNQNhlyeK6nnIAdjdOYjcflm5hVDyE5mevSJ3lgMOOK8e8vUfernHYBLa8bzK0vcTDGdQGjrQeWaswQHm3EqrZWBW0rcyA5h3n5UAh+YPATbs21PfvrDYuRdmO7AFZBgRdaTYmzcpT6vFyw5/4C/aA3Z2S2M7K/fOY5wZVAzytI+VHyTTgAtYtsxxYOGEB+BE6yT5+z1xUlyRMFDL+av6QPFg+Gl/hwxOJewBf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C4a1EthRb6W/JmlE2JwgN+rdHRZfTkElOCeRfMLeY0=;
 b=FKM6E2IOySgWZrHgVKXoJ34TOtHCWFKoEsl8rR+ZmHtxzPQIf5UB704YkLnXrkAS3yl2s2Uy2zHlGR0GhZB+u1nwhfarpbzjlAdazVvIAzPUe8njKqZRG7tZDiW0is13WOEhhWT2Y9BvNau/hn26it6qhRRq5iqCRue5sgxrRlbo3N48R4TGZSTWWsr2s9PXMeyCs9ZFFS0OSwRkVuN/PMrL8f+CA6qLRrUA1iThKjaiqrExFtNVv+y7lT9Hy2uGe2XAfYqK6U8pAzTvgC+ZLLMK7ZvfNl9EZ8MFkN2Rxc46UP4ORdHFjTkYGiBTt+iDCeVEVunoVJrPt9rFDPap+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10160.eurprd04.prod.outlook.com (2603:10a6:102:407::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 18:32:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:32:01 +0000
Date: Thu, 14 Aug 2025 14:31:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
Message-ID: <aJ4rmLgTm+A2hDA0@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH0PR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:510:4::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5a4cca-006c-4e63-c407-08dddb60dbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYRdNvwopP6S8Yxt66jWuh0r50k6HzIDZvNKmhgwuMAO8BYVtuZ3AejUcJ/x?=
 =?us-ascii?Q?bUeZYb31c7m1f5d9QqkyqoFg7YXATjKkV0AZPXQ+FLSYgg+Dt1n+9kA0FWI8?=
 =?us-ascii?Q?YBJQ+Q4rVzKVRzT2QRt8axRiSMEmQGjSq80n1Q+LG0FPH804FNcGFIHnbF/8?=
 =?us-ascii?Q?oc+jKtH9T03vJwWtHdCPbKqcZZqcNl2DdshHybh46jHGR3dTo1gLtrMBCEsH?=
 =?us-ascii?Q?zgPpcDJzkEUkje5cH95q2ho6zgD7qiJ4XiWQDuJgEiANpBZRtH9D5O75y8uo?=
 =?us-ascii?Q?XT9dhPV2u/MK+sDWlGaR09eN7/RKbIxmhJZ2Ok+3ILVDvk08InEzuT8ncjoF?=
 =?us-ascii?Q?qIzCAwexG1DvosxPyqfSIwHCS7t4NI2843bWP+tV38o6g4P9wHMLRIT7xfFm?=
 =?us-ascii?Q?nYcK9Wig9ZKBeFEYd6wgCMTqrQl32JfIPvkwkaj2xEIuiry4kmGCcnObDUOX?=
 =?us-ascii?Q?nG2mFK/ZMv4M9QOvg5yFv22siPX3I/oUxEfsf2LwnYKDPPWj+w6NEWTSsSNl?=
 =?us-ascii?Q?fJGmOzisyidqb1GpKHImdktuOjG+xcn/kVstddmd/QXwZ72DwQfg8UifvjPf?=
 =?us-ascii?Q?5g3xPJq5bei3D+XpKIzOcThJ1YJRVO1ffWt9NG4ILDNk1vPR3rmAuDKeIAwB?=
 =?us-ascii?Q?SMmXMeUUBFhjWDRgksbNhUl68e5yerYtSDxc2D35pYQ/5ajrGTa6JC/GWlt7?=
 =?us-ascii?Q?vd4GBYihTIZRl6IX2PnfPKQ7r4zRbuske3UAZAOTIYedrtgrRsnCWlMMRUw/?=
 =?us-ascii?Q?5mHBuA/PSbkfhMYJTqU2O70X5L6DGwXJ46HfWxbKqpfIVIxLzRgiDnTeOO/C?=
 =?us-ascii?Q?H0BiRb47T/3E9ExIAR3obHI4L7qCyTX5iXh7KJnns77AthnK8CQcu3H58EYi?=
 =?us-ascii?Q?Jn3MBZmUVvfo1bbCbWAup3/nlDwyrPQbO/YAoCjtYJz7ddjWtDozz35PLRBQ?=
 =?us-ascii?Q?TpmaAz6is/PDs0wkcsloY0L5NzkRYth9B+Ig/WKvJL03nF4FfbofXPMD8KcP?=
 =?us-ascii?Q?UGNBdWj9LL5YeqcXBkMoFGjWYxCSC4rjiQ3QWNSMtLNr+EcMsxthcnwzOewI?=
 =?us-ascii?Q?9coABglkMO4R/kplZNZPkhcd0W7z3BZ7JqKaXLsUYFHoCIUFFvA8mt1/QqIA?=
 =?us-ascii?Q?lnpcw6ACrMevTxF3705UlHvh78pqrN909+aFLYEvXPDxZobVAxobqOlhQB+Z?=
 =?us-ascii?Q?sN1gdADja81tEEJoQq9eqB3RQ7c61hgIPxPbwJEFV3zkRFLFIp0xI3lWjBGZ?=
 =?us-ascii?Q?qwzxHiYImMaV/fkbJ4kznGU79W5TCLVB5CS/EjHbEAjN7KBXyPsCMsmIaAYE?=
 =?us-ascii?Q?KmDTzrig0fNgD2z6yQxMDIcBTYzXbw0ng9EXiuYIJzpecxJRiy2yHOJFrMwY?=
 =?us-ascii?Q?IO8/QZL5ynhLQBtBuqsM4LcxgGWTZdlFgZ2c38XPsQeW8vK0Z6T7m0IHX0Dp?=
 =?us-ascii?Q?o2SqbMCtSyMFOWSNMBou8dBJRZCXtZ2zzpW+VCMVlYd1epLSkkAqCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2nASKOPPYfJUZ4sqOV3WUB8c/zoEF4uJ5dcyvt8+aBHnE6IzAAETGrj/aoh?=
 =?us-ascii?Q?2JMFlpb1K5kt4jXQroa7Ii4OS0PrHebUtgXcxXzSUdBh1Imop4zcK8ThLzxX?=
 =?us-ascii?Q?LuRM7vw5nTWBnWePu7ur71IGjLPkDVUYS3mqCu6x3TiEBlengxb6zlhH23xn?=
 =?us-ascii?Q?h1mCM7QivwGbvqTdshPcM0j6fKQ9LO8vlnrcnx6emikTiKPMBbf9zLPam95M?=
 =?us-ascii?Q?Ixo9IYQZEROfZHun3WFqhOt4yL09Jp0gorl7c3mU5ue/EHPbkzNFLWhztNSB?=
 =?us-ascii?Q?M+Fl04BZ5VuK/8BNLlVt4YwNTwgEXsSaFFubGbvshDUesYd6HLc57t23gzff?=
 =?us-ascii?Q?8+teVasIbWgoqDu6yOtwlVfvi8Rh/nwAfTAcXROgy5CEixs7HPpBhLNC8ir3?=
 =?us-ascii?Q?NfJdDJyUsiaIyRxAeZEf1PwoIKZDfr77gb1AjwE02zbP3LPk/1RBOCovKuYJ?=
 =?us-ascii?Q?/29Mt0G1218kCSx/Dsc+muKVmdOCUEly/upJwhFTrNdYLhVSkLDopFO/U8Nq?=
 =?us-ascii?Q?umuBFzzJheVzCnwY8phRV2lChSEEdtbT19pp2wUWW+klHMClInZKi6ZOdyLq?=
 =?us-ascii?Q?jx9rtjQjiJQtr6wxk/9f0AC2m9x+P5mIA+j69EMQQpr+oj8vjCdqOhC6RWwm?=
 =?us-ascii?Q?xS1ZKuqVX/p7d8L2FhTJi9Mxtt5zwI7JovF/nD/2jz0BKjkd9hQGwnuQHj7k?=
 =?us-ascii?Q?h8whox1eXh8xKz/8JsS+OIInPlVJIqSg7uOmbOHNV9iCSo3dkde4bce/u54L?=
 =?us-ascii?Q?TwnNhjATubWwVX3X/Y4eST+WoLkiBQF5a/usWwMyWnQrbcVEUfPtXHnfyffx?=
 =?us-ascii?Q?2XR9irDAlCGeM3yYwyBwgAgEiiqLEEHf5FERjFDZUHX/znj2D/+Ix3mbpTKm?=
 =?us-ascii?Q?OTGCZc7ToiRX3n1UGPK2aLQfBv1X1qMOzDCGujbR2fCZkUlMHMJX6EHaPZkX?=
 =?us-ascii?Q?DieCURLtpdPxVOolCd9MErKPHzNjacl3Utr+pU8Tt0vu/asECnYlj8fg4hUM?=
 =?us-ascii?Q?XS25s1gfesCq+iLlmGCbEe7BsjPNgl1ZgfDStgg6ixnguIKu0a/BzpT8hh9Z?=
 =?us-ascii?Q?IbL+H7Pm7LmvbAtV1x1VV1I4XBtxPyM1SzieBY2mfSPNV9kUORbh34ip86el?=
 =?us-ascii?Q?EOXxpvKHCq2LUAb8gQXbO4iLIcllEdDC0Yei1UpD5yvCuVkPfmE0YhliAQdj?=
 =?us-ascii?Q?LI68iIH/kv3ojegVc8XdN35WzvYl1EVOGKqlqdWEu1KAnSDc9unOAva+Y4o4?=
 =?us-ascii?Q?v2zvDBiQMsf+Ef1/H40zk4ekt/9Xq8rtHyQQay0I6IYmfoKr/yXkdJgPhMyp?=
 =?us-ascii?Q?VzNDNSPPRiv0plFWWP2GpaCxBbbYeARLnfDH2mQyl3ncWCtxoLG3aWPQBTzd?=
 =?us-ascii?Q?h9KsyEx9JrnbHgsFMNUnckvhDRPvEpYuvyPOnYvN2CzEkm6L5b64VtnpcZsJ?=
 =?us-ascii?Q?PVyrOHWpY7Hs38rnAsZMj6Q5OTe5VIG9Rg+8Z/ftUWTAm3ylRL5RCwme3YyG?=
 =?us-ascii?Q?mFM5A7jFbuY1b+ZIdPK7Aa4znEWebd2F46sBtfGThk2SceaUH2CcGTamo3n/?=
 =?us-ascii?Q?Qe+SqpefXg42CgS3GHc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5a4cca-006c-4e63-c407-08dddb60dbd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:32:01.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAMEsrKKKLKT707hKnCW+NfXZKVSnmALVM1el5MvgfBFnHzuv65xID/9ag0kGESOFlgCDkzj53gHFcH8l4j5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10160

On Thu, Aug 14, 2025 at 05:06:49PM +0100, James Clark wrote:
> To avoid adding more string matching here for every new device, move
> this property into devtype data.

Add query_hw_for_num_cs in devtype to avoid directly check compatible
"fsl,imx93-spi".

No functionaltiy change.

Frank
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 1013d5c994e9..6d0138b27785 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -97,6 +97,7 @@ static const char * const pincfgs[] = {
>
>  struct fsl_lpspi_devtype_data {
>  	bool prescale_err : 1;
> +	bool query_hw_for_num_cs : 1;
>  };
>
>  struct lpspi_config {
> @@ -150,10 +151,12 @@ struct fsl_lpspi_data {
>   */
>  static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>  	.prescale_err = true,
> +	.query_hw_for_num_cs = true,
>  };
>
>  static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>  	.prescale_err = false,
> +	.query_hw_for_num_cs = false,
>  };
>
>  static const struct of_device_id fsl_lpspi_dt_ids[] = {
> @@ -960,7 +963,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>  	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
>  	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
>  				 &num_cs)) {
> -		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
> +		if (devtype_data->query_hw_for_num_cs)
>  			num_cs = ((temp >> 16) & 0xf);
>  		else
>  			num_cs = 1;
>
> --
> 2.34.1
>

