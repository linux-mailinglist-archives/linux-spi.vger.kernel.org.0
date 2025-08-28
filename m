Return-Path: <linux-spi+bounces-9752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3EB3A9AB
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A1C1C22D5E
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D526C38D;
	Thu, 28 Aug 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqKfUx/M"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C823D7EC;
	Thu, 28 Aug 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404701; cv=fail; b=L6S9UliK1XWBTdRLZK8Yqjcp+0EGKmG+LW5LKQLQIsAk2kJsC4wg7LNszppmMv3tPfcwAF+eR1zhhiD4jTos4DcpDwOIO39xEU/p8q+AsRadVl1OCZrUBtY4cr/nd4BnfU31Czihv7QNvvNcxU1SXYK5gXf+YQdVNh8HQEI1Yh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404701; c=relaxed/simple;
	bh=/0UXGY6np4h7N5sMpCO6ffJVdNypdzARu6tS9BF3jVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PpMKN4jSlAmg4TkYYipe8lXw5bop6cq6nGdh79Lt10hYUKUaYGfhnj7sHP1WN5H7npWLA0soIC9orMj/0jOAd6KXgCGxx8w2u9YsMYzPSpSP406AR/7s1BlaOczkJUUQrVrgbHyyGqvYDKrs4he1XM4+HQlF26boqmdkgEvyxmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PqKfUx/M; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbgzqByO+TPRhxR6tZsnOxpaoZq3rwE1owXsAvXs1A2qUf1vONfc5ZjE8cqyiR5cOnDsscceIAgKyywVcpXy/bJZ6/zM64rzrPljiO6cjhcMc4BnjCA71Tg6dwhjU7OL8tZ7pfrZwyiAbDKd6wuLzJDNdUa6mvkZEshIL0jU+m1GeRpcQzwJx6yJKf+u9UJr8nakR19F5c4XUHUx2Z/2cGoHk+6wZVnOVXKzrl28ZzJ+QfV+lD6kbQGy+p0eVpizms9DD7iReGGOscTYG8J9YCGlPcRw7N1Mgy76FaN6Dhbxvp05maDsFAzbBP2o5QnYdk0ZJg9Dv7d6M/u4Q5j3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4EuR1m1GVsy3tvwciimd+0qyZtcCHQEoLGb9983Ar4=;
 b=tu9yrZwlMOKBOFem9fzqtto3Qt5PHoROpdMpOeS24G9GY5NKJdEwOV33m70vF5RqV3sRRPFYo1+VXpXruqmhbr342BwehGS8UPJlMo+Bq6koZyVB5kgOUqbJXBTr7H7Km+Lo02kK3e/RQvb01FmIPjoVj7oGSzmUtTxZv+An8QnCPvh4AF3oxrkn49ubqb7eIpIcosvo/tmZdHjQi1SLhh47K8K+2/GMKCsH90wmYyiYvlvHCpiGqIYVw0Di5E7PTcsbzzG1va/Iz3Zr8D50WYH6qgK+dUrhxUVpW97W3ZwYWgrwh847n3I8zrzOgJPUitA3NCHzaOHY19b9i7jh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4EuR1m1GVsy3tvwciimd+0qyZtcCHQEoLGb9983Ar4=;
 b=PqKfUx/MQbLWG4nIlu9ANqmj067m7lECZUbqVejKrGk+a0FntuSXPQOb13pvxHunBjx+ay9MbA8PXDqwoYDQBwUn+GI9isldDK0Jd0h99wbL4dbvkvd7F51ZmlTKLpeceSdn9yWgSmHE2O4Z+nFRzHEuxRX/Y1Bop1B9K9nisW1ETuRWJ6U+huiHseZIfxmFc3rvwikumUxEE/8cN2+XK9NmDnXiJWOo87myxI2y9b3p5qMBnpTZz89HbBFJJwn2EBamzeq7Q/jlnPlpfUgJ+QCL6jqOwj0xF/GgW7hC1LJ9soIqo6cSEbZAq6ohPNbS/L3Dij9O7xZaqpUuNR1Vdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:11:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:11:36 +0000
Date: Thu, 28 Aug 2025 14:11:28 -0400
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
Subject: Re: [PATCH v2 6/9] spi: spi-fsl-lpspi: Constify devtype datas
Message-ID: <aLCb0JI0dlQYoEpl@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-6-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-6-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: PH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:5::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: e310b2ca-8d06-4da2-a854-08dde65e53f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cil7ep33xzTKGOqqC2YhVJ2um982oKW6l7jJ26Fc6g3xeIHSV8FplHXSucNS?=
 =?us-ascii?Q?GqX0LnFNR9/2++qzr+/M+52N+K/6W9dDjK3QxAa4PcqY9Pj/UkXBFeOlleg5?=
 =?us-ascii?Q?q2pDYiBMFYV9izc/Mu33tOYw/IXnIejwkasy7ftP4ypePcEFQsp13Glmo1mU?=
 =?us-ascii?Q?F9SLiDmwJXNNfMwwoXq0RvDPtu7qE7r7yULgAygLuM+K9YJxNs3LY1Tnz78W?=
 =?us-ascii?Q?xyRw2glmDDQgX3X2NDeZtg8E56OpA54qfesgEX5aoRk1cjlGerkb6V+5+3CD?=
 =?us-ascii?Q?n8koA7iBn/pi1ZQy2/VZ/y140M0RwOfLEFH4HJ9NbVEQmuogQLV69FNyvuYL?=
 =?us-ascii?Q?A3yKtibpjNdxhTgYFSot+Sqjo+5VJLHRar8z/VkX6ZXT1fwrmeG686hlrB5O?=
 =?us-ascii?Q?Ngdh3jgijg/I+P4fYbYYikagoy+iEYz8hvKKvykMZhVy+okKkI+BWXNXZflj?=
 =?us-ascii?Q?Gl/IVhWuB2ZU+uIfUAR8vvdrzV8g7qVRLrNmaXzJYBrX1MIqsGhPVJgHxS9v?=
 =?us-ascii?Q?5uhZBOfPD2iPAjcJnGwXx6lOaHx6AtJpoi7src+ctMBC8DM1N2CdeK27tXOR?=
 =?us-ascii?Q?rOE3a7Fo81uo3fCUNElg8BlNVVAB+Tj44hepHht589130D3YuVDSh9wPBHxQ?=
 =?us-ascii?Q?Ii4GMmNoEMr7BLYSaXsVBp/3UUGpmeqJeYrxZGLwKBzFZyt5atYyUrkgPlTZ?=
 =?us-ascii?Q?HDktGIuZ8QbreOCmw8kSKM/lytvOdNBnysu6D2IQSNzjy0INb1yws32CvMor?=
 =?us-ascii?Q?fMVmWoI5BEDMxvZqtjxEa/bOsEgxml3i4LE6neQNlPj2KJ3Pfeo63fu6Le11?=
 =?us-ascii?Q?XzKDBIXms6K78egERUwwCOnKZIIagPBJlBdd4WfYkF+ksBMPA/3a//hFz2sJ?=
 =?us-ascii?Q?aGQh6mvrL8q141Gc1Fj10Jb4rfF1Uwu9RgEi3gtbEKBC/L2zILzxFsvS3ROf?=
 =?us-ascii?Q?zEFxisfjqvcIn03nUuzqSzN/B12auUzt6UmqfZUdZVRM6qIGBraxBINhoR5j?=
 =?us-ascii?Q?sVcoaygQLOGokt4JfkZ2ELymiL1mEEilckW1fyUuxsoywmDPlj3TD6yBYGAv?=
 =?us-ascii?Q?hjWKALe8MP0/qdZ2GlxM16dDHQnb6o8+AOolIPoIWvCxCtZJTrYwlegWViS+?=
 =?us-ascii?Q?fP7Ky0Mm/7n/yKnbspBwPPaDzaiiIKkmA6fuXMtu81T4+s49FPTK84oCsgEh?=
 =?us-ascii?Q?964uyIzwaHF1LpDfW2XrLrtLG0rU+fjhYopsb+Ul+OWqi3xc0dcVCpFNrQp8?=
 =?us-ascii?Q?LBE/jT6hOt4uRYb2kJLEe7PfB/wPV6oVUaTHPoBH4NzMZci+n/UqWeVQ+tPF?=
 =?us-ascii?Q?n4FhL09NTkGSr4hhVnvfGzq0FcgnJ7xxxnH+CgWurcmlPDxrA7bDKFaZOd2n?=
 =?us-ascii?Q?zCslnkqvAZ0blkcnegPx7Ts4qrxZJf7pXrsktO5KGVx17n5MjRuiF96LQXys?=
 =?us-ascii?Q?4Nxo1nqTSAQfXeuFg5DbXmowYi/+C5fPjvYrMHI8DB0XdNt7B7Dy9T6zAj+O?=
 =?us-ascii?Q?AQzqMkKPt6krneA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syhrmtOvxmd5TiqYI5Z8boiX/iRAg4oh4EFqHE7NbPGsPP6E/7QA2KXH+a96?=
 =?us-ascii?Q?7vDwmfZeWuEz5CuKjccxHMfji5+FutUrTZXVXmrWfjL1cKnNBr1dRzChr21k?=
 =?us-ascii?Q?0u6oabG/rCy/5IkhWxgBAd5ZU6bgISwkXyKbEy8TeFcakRpyQcpu+7zgSsK3?=
 =?us-ascii?Q?/3K7MF7GXiYKMuyD4qNUr9ntcDuKU+9OcWgjdNQNSSBrztOXxn8XcRvkgzxK?=
 =?us-ascii?Q?bHvaEg2LBqB5AoFLkkraM1lpWJRORIgq3J/n7gyxfD4nFIzdotYRcdLN+gLf?=
 =?us-ascii?Q?ghcpAbO4Cjmo7vEHoPfDM7lzwuhngvoi50vMR9X99Jdl8fr7s+sL9NynWJxJ?=
 =?us-ascii?Q?oPKVvDKRzU87x1zpNyLYwLwHifFm0Mq7XRd9y2IJK+3uLRUURRoN8AvvCFg6?=
 =?us-ascii?Q?6UQsHlEmoM9XDFR32VtB27Pze3bbMuKirdYabKCywYnk1h/NoUXY3zMEKZcU?=
 =?us-ascii?Q?oudxNQ5lSaJ71n4j94ce9PKJVAngSxEYvm196T7PNQ8/UVYfuYEZ2fcFC+rS?=
 =?us-ascii?Q?ieHIUU4TVbncDvvSmdh77ej7MUcb4Uf/Aux8sMXJKwbnNnrAaNHfUb6ax9Oy?=
 =?us-ascii?Q?QnKTO7G7TQxtyEOU/Z2yZWs6N4Wb6m3Z5MKD84C5669CK+LUQ4Muxfsx7P5n?=
 =?us-ascii?Q?qkKLhIDes+gLaf5yBoahA6WVnjAlDMD7QAyh0zk3W9KBXWxxSxpN6Frqj5ZO?=
 =?us-ascii?Q?QkT6uIoRCpOVGnWfb6K/turVzUgvxIZOI9TJQ0cCR2N8uxph6xD3G1IjHJxq?=
 =?us-ascii?Q?oRmqnFM2F8p5Pzgq5f60jdbNhC2fanZ7XPraKhqPXLEhn/3zIwi0vXyDKt43?=
 =?us-ascii?Q?G25ElyWZ6W0YtcAGRXJ9N8YN0MxF85M1M4Wko7tLIysrx5WZc3YxS/y52wbQ?=
 =?us-ascii?Q?rxj3py5BeCrcDoC8AapSebEJ6eoTa4aBgkBb/ZA4FUaN22AiC7BwtE03j04N?=
 =?us-ascii?Q?ZVY5JZRCUbuWOXURCa0fq1a31v5Ne63JoNZIM2rCD2XvDWEw2ZETH7CSGx+W?=
 =?us-ascii?Q?RnShL8bfnrxLdEsX51O7D5y6N34kFKaZlvHfSrOTgo/RTuHBNctLu91GeONf?=
 =?us-ascii?Q?B7qo9hhj7VyJqh9bpwe04roh41R0X8JShSAjgPzPFWoVgAtiyVc2ca/Wz5mw?=
 =?us-ascii?Q?VyLbru7nXNz2mM5O5I0YpT7/Sh+VD4SUl3E93YvFfBTduIUt3fcE//Gydegw?=
 =?us-ascii?Q?DZUDzIx/iMAQutYz22uTIs5xot5aBJ8Q1jlM+SpIrOGmIuSF0gvokCr21+2U?=
 =?us-ascii?Q?8iVLy+6qvFwWX3aeBhKckca+4CKOht1K9CKQxr7rc4JolKupRmW0uBwJLRC0?=
 =?us-ascii?Q?JNCDKsjKY3/NU/qsHCeYA3RXdamW4kxVv0NzIlv0frYBlQp+A27YKYBQLZaZ?=
 =?us-ascii?Q?y99+h3NfAHZyqqql7/qJK+9cJg/UKgPr6DtXBhMZ0j1MeRvocmir09Nm9zxv?=
 =?us-ascii?Q?BRAzJp5ebFvOJC9oGuVHIBQz8Tyvo50UamY1eRekdNN4QlnC5KiIpnUJVdQd?=
 =?us-ascii?Q?OHJ71kCLK/Ydz60JHqswX6rTK1MnT8GX7pBHXbhUhxkWZ9C0eX+IKE46SYc+?=
 =?us-ascii?Q?i6Ix+TIi1hfV4x02cH9VxVXAUWwSeqzIHz6FxyK0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e310b2ca-8d06-4da2-a854-08dde65e53f3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:11:36.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGdWMhtfY0yXeRywLakcRXTCsLziI8J8J8Y+4NPUIsmPRlvdZ04tuMFp4eoFCwkjmWqMJOfFgHjrZTv6URL9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:45AM +0100, James Clark wrote:
> Add const for all devtype_data.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index fc4d49f0717e..f16449cf42bb 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -135,11 +135,11 @@ struct fsl_lpspi_data {
>   * ERR051608 fixed or not:
>   * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>   */
> -static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
> +static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>  	.prescale_max = 1,
>  };
>
> -static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> +static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>  	.prescale_max = 7,
>  };
>
>
> --
> 2.34.1
>

