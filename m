Return-Path: <linux-spi+bounces-9439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDFB26EDB
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F671CC24F1
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347178F2B;
	Thu, 14 Aug 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgpYp889"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663320D517;
	Thu, 14 Aug 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196113; cv=fail; b=IAqCLOfvqdHoEkgMss23Vw8iQ3wHXbAOOGmWK87GZsm4fthX779VsEv7I/jkTXmwsG9XTZrWaV+N9bFbCMZ78+e8u7wqKPyr7G+MtD+5aGIdkIEoTwelxzii6N0775uDeVPwqLCcEEHaZNsqg2Cklu7ht1P+hBznD60jgn5GBt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196113; c=relaxed/simple;
	bh=KCeYk7sHF/sFKh8SurrN6IacLUwpCW7SKJ3ZSVu5YXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRveQnAaIGKlrOTWouyCJ8CpESW2f0R2ZCR4UQ+5SDc13RP9C7uWK8paOPvCjuMXEZ8U8nPTPPxGLhsnl0DL0DVnUM2sn1kQTp+Ce774LbT6cyVNeEzGBE/cplah6BGAXpMRMccIpNFq+LwlbHpChKAl0GGexwEpfgqm8uQIFTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PgpYp889; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXnk9REPQEoqx1h/uN/VuVlMKk4Q1GEgD6f9HFg06+i/ean7BZvF8yzn9uVzrs9V42cAnaL/SF6GF2S7DA/Vlh1vZBgOi/s9pNnGS6Ofv/6K1kunxNuuqJiAbmX9Tq8CUyZzxPS7Bqf5XH+ZGKX+CCBHi8laCfN4lpsRZ/q/BhNIgxe+9c8Ru+uREwGK9llok1ioIgGooWyDFO8qL9hAC2XcggES6nrjpAIO6uOk4PqDRzO588bljGXtCRnU7Es9WsdqrZ2Ts3W7mu7tDSNdSllttLEYkHZFut6OqhfyCarOwMQZX8KHepp/rFm1GHwyjm/uSy4B8IBZnShdTnUH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xsnaarR8P0cvt6ygonWRXillQFQXurMQERytBpgbTM=;
 b=PCeHtwzDXU43FNWlwKSSDcJafzON4L1B2ndEjzIMHFcj0LyzCLAQywzJsZl2T4JuJKyWbaDqQBoK/GAgiyKYIDZSQL5fY0w8NbV4tnC+CA+ktPWIj41GOpRu0aDWhAltWQfUue94Plq3MMei2TzsEGttTr4LTNOD4pEMjIDMLWFh+mfV1aE7dv0RAzEcGQ403rZjAraPSUeSTci1OyqGmaL5kWRZRue2TMEc3Sw6+4shTjgl0soz6SJPwl3nAgnDFXcNphbqAXU+155UUTFnR+MdS2Y6XQdCp1rUhO1vrckFZeQLuo2PCzARC8KnXSDjgh8I5KR3AMcKr1KVuCjz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xsnaarR8P0cvt6ygonWRXillQFQXurMQERytBpgbTM=;
 b=PgpYp889p44X3KgMCswf33qBfa+XCA8S5YTbawELgH3pkLZd1P0Rw23aa7kDu14kKVH31IsX9SWpkedwEO4zuiRNQLbnP+FikLXfYd/hrVTfq9y4alpAwFkuuIKpnsZvg6jk7fsbkjr+X9FRlNBaqXd3fwawu6UO1w79N+NUs9YZKMvHKvvnn1JxtNlFOctLWuyQnDCLXOuJ1tMwE4QkdSmxrJ/e0R4Byd31Bdbroyp+7ou3bPAb4ilf7U0Q9tD/hRIkr2sY7iULPOeINflOqZkUfK3PH+jLmSx+yaa+2SWgwLXFJhQrZtCHX82uvZsItXsBvBpJANUOkZMAewFs+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by FRWPR04MB11222.eurprd04.prod.outlook.com (2603:10a6:d10:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 18:28:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:28:27 +0000
Date: Thu, 14 Aug 2025 14:28:19 -0400
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
Subject: Re: [PATCH 11/13] dt-bindings: lpspi: Update maximum num-cs value
Message-ID: <aJ4qw5eF10oJMIIA@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>
X-ClientProxiedBy: PH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:510:5::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|FRWPR04MB11222:EE_
X-MS-Office365-Filtering-Correlation-Id: b556d67f-0c4e-4f71-8529-08dddb605c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMhTlFYxYRVGvTBatdbaC4qlQ0T2zJZndmiqBvY4qn9MPOOr1uwo53nhpJID?=
 =?us-ascii?Q?EGhNS7qpTRqe64qhFb8/BLKsLm67NSatVaoEflNqPx+lbCCtEQd7UE08PLAl?=
 =?us-ascii?Q?wsHgmJYNDm7KWPxSK9MjkZHjUbB5yQ69MZqnz67Sg8eiB6w7s4zMt2vEHC15?=
 =?us-ascii?Q?aEJrQOIkwxpkCZdTLeXxc0cbd95WpkN0JfNKAMazBukba/EFxu463wjk5ffn?=
 =?us-ascii?Q?EGE0PVCdn4tB0mBNwZP93ssmf4MrcoUC8kASydodMDKnZ/MnF9UqN75w/Jsz?=
 =?us-ascii?Q?qk5pTtVC/N4fapbhye83TUxIA9P5HIOTGmts9XuL1TzxjmPqpYGL4XqY6Ija?=
 =?us-ascii?Q?9/03uHwX2+WrA6csuhyGw6Nf4arzBrBanpcDMk1BQseaSeAaE6vnQboIyEjR?=
 =?us-ascii?Q?J9xnwqq0pqtMQY+32TFUpRaEJP9mjw07Yzj7OX01vZmSaxyJxA4OALY5Ii7R?=
 =?us-ascii?Q?f1lHGrXu/4heMlKEpXgHwsMXAGYFCsqjV7SsGeh5NpFWoN43xSeLDaDfbSs6?=
 =?us-ascii?Q?dwYuyNjJyev+YeGGmKDgLhXZP8XWVKcg86hh+8LXjzxnhDlcahV621R3IcG1?=
 =?us-ascii?Q?/otaeUAfClrHs9WvxrE/QJM7WX69ht1T+LgXXEBxhXghgzrQ0HWgnAI6bcm4?=
 =?us-ascii?Q?Fow5FQS48Vvc4bOB+QdBFF6uf/xpFAtpSn4rCRc/iuWnFWFTx71oowGZsbxL?=
 =?us-ascii?Q?zGaAukyKumxSebxLzo32TNGt8xGAAfCq4zuRKC/pUrIDOYJp7LV6Q18zwKIX?=
 =?us-ascii?Q?24i4BWKcMC28BS1FTuciqFG1Ip3v567jtqdU0ULZKTjR/bWxVXaffifZ0n5v?=
 =?us-ascii?Q?X/9Bmiw/huXHwEBZncQ9YHPXQWNBNzLNQknpDDFEWiW263mC5qtsVjKLk/wn?=
 =?us-ascii?Q?4HvrUrx++OxmK4pxcAfZKaHkVFmJ/IGpUCwQZSXOFsbK8sto2kiWsqCnghyv?=
 =?us-ascii?Q?M+V41sMPw4jbXhJLHzVFKHeqdqgZ6re0uxNG2GGy29uS9IPNgUUYRAyGD27E?=
 =?us-ascii?Q?KfaEZcKeVwpuePjKgAQYlxluDAnTHtSico7VReEXCau/xEa4mtgX0lLuG0E/?=
 =?us-ascii?Q?S55RN+PlyFPDCiT5QtCIY0JQnxQHUGoU7YQalhTp+rW5OJDsI7cPm5Ya3ur7?=
 =?us-ascii?Q?WuUeZjNbYoqvDReCYpZZK3iw3z4WQY5vdjB8X8+SW1n3Bhx5dJUbVXnKmCn2?=
 =?us-ascii?Q?uqDReD7qFeJHHfLXYh1zxQISb8E+n97RTOgM0Cww3x+otZuMZdeWQkfR5jeC?=
 =?us-ascii?Q?7Z/LTes6Sx9jOw+kah70FaC5EQffGWU0vgMzFaFjRCmWZ7taecE4q5zzvoT/?=
 =?us-ascii?Q?xrSyLjtoao6yXuKLfjIX/yyVsj0YC8/Q/qiQz+xj6mGWxI8yqseRkGilrqXq?=
 =?us-ascii?Q?6A3ZNTzGCIBzEB8UbM0I9DO4CrkLZuvp8IErElIseGGD/rAiGOzEmos4sMN/?=
 =?us-ascii?Q?A9tIEMxqD3ddHQ8odZcxu+0N2n8pMQ7rn5Uc0klfLtyVZZgEzKgYZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XM9q6vRtN3Wuypnnik0WtX/FTeVYRXoBTzHTu/AsJ1mmoL0C7CoyDn+1BjTq?=
 =?us-ascii?Q?jKlVaG6jiChPVMsLbbkjo8t8hS1NJIk3iG4EAW9TbNSc6gbUM25Xtior+ZVw?=
 =?us-ascii?Q?3XmpFElR+C4juywJ4ImFYsV/0sWmtgJhDceiEybasxGLQPa6/0ojGEWaW1Vc?=
 =?us-ascii?Q?XAi3DuaZTAkOFLpEWoIVh7pCnUWsGjCIIpBSo8iXkNEf4JBmBzho6fPOdK4r?=
 =?us-ascii?Q?5qsx6NhM8c+myHuzQCXS1/bF+mrEetox0eewkDCikRWud0z1wxTc2DXLhYMs?=
 =?us-ascii?Q?1PFMd1zu6yc8WOm+pnBo8qD7JRfCrfOoo+4IOGuIgGIfXaZKOfaTZdphrsHE?=
 =?us-ascii?Q?5MbhB4ctGftgWLUXv2D5vFUqfjGASF6nVKaBimkgHzwiIxvclqZcy5k+J8jk?=
 =?us-ascii?Q?ehtI8U5AnfUygcUs2rv9OHLqWZwD0AWN/gF4ioV+4o1cfHtdrbupw7jHPf+T?=
 =?us-ascii?Q?0vOZFlScXrBF0Py7L/BD7RrAQS+sCenqg3apWZGGG9cu+5UK7dM5bbuDQuk/?=
 =?us-ascii?Q?6HXXJPxcbIzr1wxhBd9axtkKwUrvl5bOAZbMnkJo48+7NPaoWgHFjM2Q9sUX?=
 =?us-ascii?Q?mCJ4C+qdfPRLE9AHmPx/pj1cDyUk6YenYZp6mCjl46V5aXETacT712aUt2/Y?=
 =?us-ascii?Q?NUDAyM1G8m/huyCzfcFuGA7AtPYIKXDk5UqpDZnAzEc+Cl0dAL6oWJ3hXMj9?=
 =?us-ascii?Q?R+dE2Cv7rvCT0T2U2hRfvnUcx/JodhaBLGeFhauR91K8DdKGCSRtBbAxkUTN?=
 =?us-ascii?Q?WvNRd41hjtDQo28aBd5qyzYCVi64Q4PvVIVnA1Kd6B5HMH32JbWu6NrjqNfx?=
 =?us-ascii?Q?p/ln82Y60i2dk2RnohoGO6Tc7NRId2TSxsGIb4EgzXPTaQ79XHR9tpziyXKJ?=
 =?us-ascii?Q?/Hi6uqM6pj0GF86oEwIw/hTWnYZopbpG6Yhw5sLDSVomQ9xOopEuAfkwgJuf?=
 =?us-ascii?Q?UEsyWLEKH9vdzZrHGd5K4IpERmlMfjpfBCD3WMs7RCWI+GipCpOwJi2p73xc?=
 =?us-ascii?Q?+rQpNfTwjYWDi5x10qpNIM4QVpUfIclTh3MZtP1DKmsdqpdvXgmPRrKEzA/h?=
 =?us-ascii?Q?gMo76eiWvUdtwy8mPH63PSP+BwQFeR10owM11U5ophg/tbV9miPHasCqQQED?=
 =?us-ascii?Q?m9QZGMAPeN/71OCeI37gPB9qfMX9QkdIzGgjk6/SS+rgRL2IMl44DhRV522m?=
 =?us-ascii?Q?HGJkR1sdjbr5lDSU+t52ETfhDhbT1YiV2e9miZTntaYcTB+s3tGomINYf4cw?=
 =?us-ascii?Q?gQ+kcndcNCnEx5KY5709M32oii7Z9tlQMPpm/8wFj8sM5RK7lX3p80kvYIU5?=
 =?us-ascii?Q?VgtlpivSdxv75OiUQgyUhSVoVuHb3mNGjgKVCyz1x659irpQbDVx/1wrLgWX?=
 =?us-ascii?Q?Hp6ErTEqgpZ43Y9AzvFTkZPQtp7tUCJYc+GNAV0C8c/uqVR45L4RXP6bDd9U?=
 =?us-ascii?Q?d1zzkAOWjzjMbIwiBb2ZjPe1S6pEqjdhRmWTsAXM+ZHRB24UdN6Hqq0UyUcS?=
 =?us-ascii?Q?Zo/J/USozpDwDydqK6WZjH0BU6AnJOPsmOpzHB5g9wZQzqaGZkwLWp4Nhotr?=
 =?us-ascii?Q?T/4MUDkbrONOgv8MdXDYhRioM3owSKE3gc6WmfMn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b556d67f-0c4e-4f71-8529-08dddb605c7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:28:27.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j0eEV81K5wC2Ezg2MTlj/GsSp9zaP6Egqo07LwmwavzKNZb0qUUBjvIfFVFpl8/TzS7T51LCPdAymwfB/4evQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11222

On Thu, Aug 14, 2025 at 05:06:51PM +0100, James Clark wrote:
> As mentioned in commit f46b06e62c86 ("spi: spi-fsl-lpspi: Read
> chip-select amount from hardware for i.MX93"), some devices support up
> to 3 chip selects so update the max value.
>
> This isn't a fix or functional change because the devices with 3 chip
> selects support reading the number of chip selects from hardware, so the
> value wouldn't have needed to be set here. However the commit states
> that the DT could be used to overwrite any HW value, so the full range
> should be supported. This also avoids confusion for any readers about
> how many chip selects there are.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index a65a42ccaafe..ce7bd44ee17e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -64,7 +64,7 @@ properties:
>      description:
>        number of chip selects.
>      minimum: 1
> -    maximum: 2
> +    maximum: 3

You need keep the same restriction for other compatible string, or need
reason for other platform which also support up to 3.

Frank

>      default: 1
>
>    power-domains:
>
> --
> 2.34.1
>

