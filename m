Return-Path: <linux-spi+bounces-9751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C8B3A9A8
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739D558099C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCA264609;
	Thu, 28 Aug 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3ajVvUj"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CB625;
	Thu, 28 Aug 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404666; cv=fail; b=a+O2Uphcsacunn2ObbJG3UnsZZihG8iJ4RikQlGeoWVJEXejFjl56JqeRS2d7rKrIqzYWFUa6fNZQbsTWwth8YRaejwBas3uTuhjvcjoH5expbJooHrOn+27u+/Y4K8Pl2okw8DBeI9webVRf5OV67IFXnJkMR0PvOaQ/NICJqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404666; c=relaxed/simple;
	bh=950+p0Jz9/BK/k9ILjje5/BeOzUVa8TFLIv/vtBHp58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufOi7leLfkwjnDuxoKY+rn4TjnFTViX0dxkBUuRyB9NvnoXVreYLvfDWoh/XVNIF2cAkIiTidHHYGZvj8a/adpYagPW/lCVYTCCLKZwjwHH7UcX0898mFfjpZpuVhTdV33X5QuKhsILc9Tx8GYiwLQ/U4Jp++ORz0bbmpMZV83o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3ajVvUj; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH//tZtd6p77ixGsC9ogaHl0CV750BJz2YA6f0OS5v6T15FWxCkL6eDsk8LlSJ/ZwWfPK4P7IZLBa/EwRxVYR/83oXotyRXRVHuIo5dW5h+oNQ9jpjl6N8OwrQty1ORqRqEaHC3scQwd4hu64e72ShNHai8uCDd5VLbS8Wr9ud+3gOGiDjyriBAcFe0tR6Yq+Rxm6QHj6sV/z6uYMUotfoPZTuTOQ7Q0ua4u7dpEIRty3ryAhhum9y23CmYFxthD83/pW7+rGHy+dNI7zsMc3OTndPDA9K1sZpEGYOauwnyBaW5CUokkYlNZhmT1NBkqznpEmYA25le6Mt8ToP2q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgLgow6Bv3tk2vChT1L0diWtixX35A+0kjImZo2YyyE=;
 b=ox9FYZ7GTspTljmdT/NyNpTuFxk6EN33D6S82fktJEppr4BBxIPYT8Vw9tPD3vWwg1Kia7bWsqAHhKSWbPV44xhIsJghK8kKla8JplpuJivXTjY2Gb+h80uvpo+Q/rnxf56Hn688k8HLcbW1sS3bjDXKkLmRdmnU4dNHzpGH7PGF+UegYRVWb3FUZ+bRLavM83eGXvYIlZ1jIPfSCuRxi3CO6iSaV1f5l2i+XowyjSErtQvkXoqteJl/MvZS+RYw64kr7ti01VVckbtdcxDSBOaKaCP/OSIuX00Bss9Etx45sq7/hjugjJ5ofVWqDObrPTlaXJSfPzDg14xHJ7/cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgLgow6Bv3tk2vChT1L0diWtixX35A+0kjImZo2YyyE=;
 b=c3ajVvUjVBnpWH00qzKwTMm2vZELJnqxWc3iW3JZgJROB5+6kEcQ6tXEWSazEfUbt0OBem5NTzJly+JdSb6Hf5PE9zxRwsq4PvfvILB0F4j7aL4W6sapyEFKs03Xvd/YguDQyqe8mWsl/fGwBXKfuKSr5NGjppxU8lmv+Ygq/UjyRBOtDsMtVEf2mNnMjpFLtnloYwjGO34EU/XQ7lbvcJdQWZ7l1eGMZS6aQP229QtQN4N15ipw4pKE0WKxVKLc3AJJfGYW2vSejJfFYqnu+AxPKKJBUtegNQijZhXoTqANGEQOY/5l2IGxMZyMuBXe4TQVdMl5SfjAF7l90l3JCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:11:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:11:00 +0000
Date: Thu, 28 Aug 2025 14:10:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 5/9] dt-bindings: lpspi: Document support for S32G
Message-ID: <aLCbqyJ1E9iqAHCP@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: 49610ab5-e9aa-4d6e-eb11-08dde65e3e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQinrW7SC0ojBEh5Oyn3D5wuNWi6YBq4ue5eXKvbB68BxCS8DXRBM5EI5VfE?=
 =?us-ascii?Q?zSKLPgULMYdIdniMAa+nEH6FNoAt+AtlGPpUVnGGQvIMaMgzASg2ouhlTPWr?=
 =?us-ascii?Q?0hmgpz7FCNpX3tn+DPKz9WMtLzQuomKV+Uq2WdkRHyKuQJ0qKeDuxvbz9Oza?=
 =?us-ascii?Q?Hnn1GHK4IyoGk1Qe6+w37gmI0rJq9313JqwmZnvrgJqVedbdgaGVWRVejO3l?=
 =?us-ascii?Q?8AGcL1V6m1Ar/KQLYMEWIRjGYU55OJY6LXrbuRIcvwyYammQiZxoW8Vfz/B6?=
 =?us-ascii?Q?4kV/ALFo8CFyi4TA11FlJFfD1lBe1RnjX2tFcxmO9KSt7T15envj/R30fp6E?=
 =?us-ascii?Q?dvYxOhKqsLFK0VInLteMA5m9BwEfQmDVp29q1AmEaC+Y+HZvdAZ8+1gPVQ/2?=
 =?us-ascii?Q?IgbbtpJaLrfPT4/bj+MH459rF8pSxlncIVc+rlmxnzfs6tTc/0QehOHdsdac?=
 =?us-ascii?Q?7oKT5jkHlYObHrS5wOOsTMidXe6uLN/nUaW1gnYwFj6B01bohGMjXFziLMDd?=
 =?us-ascii?Q?Y2MfXooI1ETWbWKY3xlDXLO6TST8c+rgmHW1bVVCaEDoO2UIxbBqxyjtuuaf?=
 =?us-ascii?Q?PUA7vnRW7o0gkm/APym595MVu/ORidaFHn1sL6gh2xUnM8OCs/VTs4WK9gvO?=
 =?us-ascii?Q?OmwvVibKEjZkKM6oVC+jtB02BYuUbzKRpOiqJJzGpb7Zg6QBMOpXvZTDN3oz?=
 =?us-ascii?Q?t+TDu8b0IQ/D3Oyr2nUOv5FtcwQmp1QISRRCDZ+UcVWj00yJYgj2vShPVEsK?=
 =?us-ascii?Q?r/E7vDtLeqweBUnz3v08JPPLZ1o10WqrfeND/BLSvSGcp79/OPhLcgNKC8We?=
 =?us-ascii?Q?urUzlxaNDTjWA56cxoYBoAsMgkTxTAK/Q0xN+t0tenEmplBIuw1UybkLzt65?=
 =?us-ascii?Q?T5xVNHEOZKRydMr5GzIa66/kJhm7Div5c/qy4hu19PI/hlfQmvxWmYiQBue+?=
 =?us-ascii?Q?6qbcDhtSXgJ2ikqeFQoYNRT9ctLnmiDQmMl6s4YgM0+sRB11RfXXLAhetzYJ?=
 =?us-ascii?Q?dcdAU+VVo0plmryQP2iMP7NO4MjE9rfIePHETolB15Bbq1KY2ZR+l0jFf+FY?=
 =?us-ascii?Q?bapPzQPLJU5a1AnGFKVHJsn/nbWuIWrujFyaOTJw/ldIPoRCa2XDDuMW3D1O?=
 =?us-ascii?Q?CWLrxQ3MsS0b+2MVUISJHd2I7Y+lJStd0pP67HA0QLRt05URYHj8NQteBVd5?=
 =?us-ascii?Q?Iz1Bef2u1QAtfskFMcyrdJfKgyKMksYHEOMSP2QA3iGETrrS/VeSK+fXW47v?=
 =?us-ascii?Q?mkORBTsm4+iDM4ythDGPgVsrq4gqt36hbVMO2zvAKlWBkf40sfQDiWHyemss?=
 =?us-ascii?Q?rbpNBafBwZGsbRumG3Y1wNMKXZk4I1RznI8CaKzTXF1czdujQQ56JoaDuK79?=
 =?us-ascii?Q?TGYPgqjWQ/m32bZuTXmv2kjDsj0m8z+QfEgMET3bY1hJc+N2VojJztdfLUcO?=
 =?us-ascii?Q?lmQQMRyesLPiANbaO9rbE8ZP2QIOMadDeVsLafZrU1ADKa9iMZ1+qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NThQ8pH4uwd0f1rMC1Ui7bspxhuW3bATiADYWH0RO/SKziyJEXiF3skWV+px?=
 =?us-ascii?Q?CyqrXPart/w+NsrelQ5lI4JtH8RdWzU8jJWHsGUEM0R7CKVJNHnNN4zlRBJK?=
 =?us-ascii?Q?Dx2PLsKu5qnBQtkdwAfD/E+j7dwH4hCyOuMIDRMKwBYuy9umceA4dyIwZrEN?=
 =?us-ascii?Q?qLBnTYIDZ671egsQJyA8kTh+PRm7a6PRyuey/NmZo9BAtkDfcA4goVfFgm/1?=
 =?us-ascii?Q?oH6tRRX4KYsYEm4lU/zZt9eX+rqggNwd6ftJS9D9Fuz33f5Bt5bAe68BCeNw?=
 =?us-ascii?Q?zWYyk68Aj9wrkLYUJhtHGf3/xMGcYuly8vhS8tqVBI/NzRf5rwtSK+glUZdq?=
 =?us-ascii?Q?6BWsEw/zBiqubHttaEI2U3YHz24XFUb388jCrvvTsoc8/lIXXRFp+XvN4cKx?=
 =?us-ascii?Q?nySrrGaFoDI5ZhSdAeg1+7XisCH1ECs+Q4nwY34lZluwPQZUawGOTYuafApO?=
 =?us-ascii?Q?OljuD4s5jikoGQT4uCi79jbUd85yRQIFKwKPzUOHZNhJdtCiJvb9YoYr16mM?=
 =?us-ascii?Q?l7I1wjEZ3IMWojXA1uXDeUEmk0C3IrQXRx/gvTyU99KuraeZyOQ+gOr+s7GB?=
 =?us-ascii?Q?eCVowNzryaZhjcQ610bk06TZkySP2w7nmERxu4h+erYK7JO0/Aq8UeZB4dyC?=
 =?us-ascii?Q?YZUWg2hcINKFY2R/VhNnjQZJ7o5u/iWqjqz1qANq2LdSN+vULAdFfzABwsQv?=
 =?us-ascii?Q?os+93psuw7e51SvcE3OmrvglwHWey+/R87NSOp12/lmTTVb0/+KfAAkvW1X0?=
 =?us-ascii?Q?OGGMfSgTCaXzVUi8o5zs8z7/lWIOS8Yk7MkEKX4yZFcvkNuIR7TTMHc/C2Pg?=
 =?us-ascii?Q?vv+HmLwDlu6B1E+3Hb9V1tZeW9a4+Z+O056EBNX9LEJOE40o+tAlFoSEsttt?=
 =?us-ascii?Q?uOC5+mLKeM6VsRRuVq1+6je0k66F2o/v1V/ChXiooQVI6ngyYHDFiUT/Pl1q?=
 =?us-ascii?Q?GjlDSfRr8n8ONVdKlUgBUsosuhSGLgA/p9MFW6SPnBv7t0mwew8fDNzgEDkm?=
 =?us-ascii?Q?V6zvYgzfu3aG1+XV08zRqlMN9+C6Ar37tTg7PJPgO/9+6AWB8Fj6MVQXerwF?=
 =?us-ascii?Q?vAHwP0Ap8HB0w8yAMtT1dgPQIYX+qs/gTGOcoIwsPuH6lDYPO380wdSmsfzX?=
 =?us-ascii?Q?cMjcbcuExc+Sh1Klbbswmvl3cNfQxIWqzjZtb8rt23fEm3d2n+KkVCQYkjDR?=
 =?us-ascii?Q?f3OrAJf5nGKlslTIPGIc3lHgc7YLuq5igof5uJ9pmnJHD+OhzRnzmWAygrBd?=
 =?us-ascii?Q?6G/75Ngvow0cr9859HRq3P/ZnnCFkQ9ucCOIULiA7xmCIXwelqRAvZiQzd0Z?=
 =?us-ascii?Q?I/m/ntk6RBui71Y+jCRyhU4dq74U2TBKitTvOKQH4qPGP4U6bvV01o8fTrpu?=
 =?us-ascii?Q?u3CNl9SRBWX6QroVWz+F/Ey6jeGaWv2nI6zO4ghd9A1pjsuI8JWIYxlGm9MG?=
 =?us-ascii?Q?1ShpN8UNP13N/Fiw6qep547AcjK+Rp58FsompElnUsUgRwTiH+AIarL7pNw2?=
 =?us-ascii?Q?F2/UzlsygG263pS5lmTqf8phz8XuoSJ9bRFec+S+NKEfJi7EmBIpPZuIrvlB?=
 =?us-ascii?Q?sIk6+xaomDQZMt+tk5M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49610ab5-e9aa-4d6e-eb11-08dde65e3e48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:11:00.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnH2ao2Fke6iFJmAQeI/872CT1hG3sdugDmXzZPrUthFw5U9rW84laWRVBAW6MMv4+K9WGxO1OLYEGYrLCP7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:44AM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> Add compatible strings 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
> and S32G3. Require nxp,s32g3-lpspi to fallback to nxp,s32g2-lpspi since
> they are currently compatible.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index a65a42ccaafe..a82360bed188 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -20,6 +20,7 @@ properties:
>        - enum:
>            - fsl,imx7ulp-spi
>            - fsl,imx8qxp-spi
> +          - nxp,s32g2-lpspi
>        - items:
>            - enum:
>                - fsl,imx8ulp-spi
> @@ -27,6 +28,10 @@ properties:
>                - fsl,imx94-spi
>                - fsl,imx95-spi
>            - const: fsl,imx7ulp-spi
> +      - items:
> +          - const: nxp,s32g3-lpspi
> +          - const: nxp,s32g2-lpspi
> +
>    reg:
>      maxItems: 1
>
>
> --
> 2.34.1
>

