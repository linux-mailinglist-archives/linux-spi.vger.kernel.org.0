Return-Path: <linux-spi+bounces-12377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F1D20483
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D7D301C08B
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386E3A4F49;
	Wed, 14 Jan 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwzXTt7a"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A733A4F55;
	Wed, 14 Jan 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409035; cv=fail; b=NtyTZC134n9fd2ou6IUAlwPnUnmwmNLVfmW0Inp4EGF68BH8fseK0G1/Axle9MqAsf2jILjN0B6Q+O5K2YGoGCsZXuUm/R3iM0MbcGQu7682Z0npYV3YpA/3AjOvmuDArEen4bc6k7LK4eLKVbiO1H5bwgIOS/gGWRkn3rYJLAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409035; c=relaxed/simple;
	bh=VLLBrA1C/CTTJ86u98h2Gp+VcxY0Yjhq+xssz/VQ9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Twhr9SLRT8ffmVfW89fPyz+din2DabiiH8owshDQUMik5naCvfQBNN/Df7V4Hp2vBhi1Z92zNmG5/FGg+HvluAFd8XAfpB8uT4OC+oDglfoex+SGns56zdYBPOzANqZnIkZn8FfIkSyR01Gu4z5LAH5FIBo3oKn+trI9TNY8tb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NwzXTt7a; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU0QiCopdRq1oZNJT7o7ckTg2r3aXYRgAgpVwDKPF1zwWSYpVjpHPjYKJD3AAMcsNiviFPt1ZSNP1EfIeEreaduH+uzjv0h+ACHHpJzVy6qhSOuJPx0C7F+hAVIS7DuKH1m6M1rbBCZxgHw3hhdpkiRjWOcjLFlqq4K3+8FQxFVEQLFzVIlYujYqhh/wbouRfew5ChLEDx/EnvCk9wfxMl+3o0IZUeUuqZjjia1TAXbEBb7kX1k5gvTTQoi/ZTay+6vvyQATsapu3JWkR8iMTl86CEzzROlhHWmuy8Dz4ZkPjS/k0hP3upJFXFZDWJX3MH0bmThi33eiai0uxMhzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB2Dka2h9dV4OQhA4vL9qhRvXvwE7dh5oqaT4ryNkf4=;
 b=wQaeatEOiUjGN6YEmw9T8M0fak00JiEKzybNt+AeLMyhqSrqvXydvdcon9zV+tUSjTbZfqudndX8y141nUagWPIeTKoSCNuBJOuQu86YowabyTkmbBqmmNHTEXVKhzZwy7qtksBERUlMgabHpjkNPaFoeldz/43rTNBLCF9YQmdOQbKmYeiJkVWdIlcrJCBD6OOJCsBnC2jsuozSiePD2nctbiT4FL1gpDK1vUBXjBxi96BdZrkcw7U9DfcM5+InPwOrjhTMzo1pBM1a5VT87gExBw1NY7YqKO5rYAhunsV63+ciXUWW8VpPeg/ShfeXeCDwjw6t7A2ZZuo8oH/S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB2Dka2h9dV4OQhA4vL9qhRvXvwE7dh5oqaT4ryNkf4=;
 b=NwzXTt7aus7uZak+wDFz96liGSn9SdNTIoXNLlNwpsJfv2YIzb9L/UnCgqUcqsaeCkBMAftkh84A8uoGXwpq1jllsatD8T5jvG/yTx9Wg+0+LhWisrVbQqOmu7aG9bKQOBX7hTziG3p5VPGI2svTyaoq4TuQ/LZdR96vdXzWAlWwC9jXrPMB3kAVxNBozYg4IvoouV8+aYRPUAJ5f2nLB3O5DTuESVaxZU1R+54zRc66p8c8jHUq8DuGWQU7M6+WgMyJt7n+7rUopaPYWg9bVn/tOfV16/5GUB7UFWGgvLJAVRggmBa8ANtYIuFCFM2oW6rR0OdqyVvdXoaLpZMLQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB12079.eurprd04.prod.outlook.com (2603:10a6:800:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:43:50 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%3]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 16:43:49 +0000
Date: Wed, 14 Jan 2026 10:43:44 -0600
From: Han Xu <han.xu@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: imx952-evk: add MT35XU01G spi nor flash
Message-ID: <20260114164344.whdnpnyob6xuxhms@cozumel>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-3-acc60a5a2a9d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-xspi-imx952-v1-3-acc60a5a2a9d@nxp.com>
X-ClientProxiedBy: PH7P220CA0054.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::11) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB12079:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e17eed5-4764-440e-ea57-08de538c17cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNLCGs8MZIkMImfmBzWQcjrFrzohyhJHiuPjQEeHHWn0QK+9f1bqtwXnW16R?=
 =?us-ascii?Q?5uGVLZ+BvfkPDpA+9Bo191BcDLNWWdN5sFycS/gFFliVOW1wRb53p3JsBHtR?=
 =?us-ascii?Q?1QC5HM273x7WowbWD2quariBx3kpIR+eGD2FwfiWd1K2Jli7bditqBGK4T7f?=
 =?us-ascii?Q?ouHpzAiXHP5QdsAOfrrgLDnpeLv27w3ngwDBJb37V6hStLzckPTTjSKPhe63?=
 =?us-ascii?Q?CbKetztATidEGU98sAgkwjWkSSkkQNKGpufBMd9m4GuwXiVrfo7OYczhGr3A?=
 =?us-ascii?Q?5FTERy2vgczFOpeQ7JR8toyb2j7oF0xInb3hpnhZkUr+kJwXu6OBhZk+iWo6?=
 =?us-ascii?Q?VY+5iXzljTpFsSa/nIVBCs4Te15pPoh002txJWUr2crDHULemm5Rlt+PGPPs?=
 =?us-ascii?Q?WraThmplZJAskWtPIJXqdO0D1Zxaad0VWk4Kz0RD7QhsSkW5LBVTL7zY4fMP?=
 =?us-ascii?Q?zVVUxhdk3/Q935m8sqKRClQJef0JuKZOloEHWRYKSRRuRTk2le4P6CtDz5Wb?=
 =?us-ascii?Q?eFisnWu65An0ru87YrMFpoc5vqcSidsZZFy01qaUdG+KzWyT9QxLusliwRVW?=
 =?us-ascii?Q?D5lUkUUrCkFh4N4RBQI/I4y5EkAQbyJdZzqyxaW6H+puOm75SFTjLFWCzimY?=
 =?us-ascii?Q?QZCOsMVs93BVr6Pj0mZQn819IGUXz53lk3Ltt/7J4gfa0QN30JIPSkIXrffT?=
 =?us-ascii?Q?C8hCV8SWXWS9DkUTYPmEWY3hwsOrcKE/zObRjcDT0d37MGUmskWHoJGxtrjx?=
 =?us-ascii?Q?CbNs8lYNXEGgvtyINUyr5cmykaeatmn8E3tSnq80TOtvCZB9W5NoL2HGTZHm?=
 =?us-ascii?Q?JnTC3BsyFyeg5LH7pobmxDF6UcK4BIN6vZ4U29QhNuZfsqXuwtTzxSNiTcwe?=
 =?us-ascii?Q?+PkbU8G+F7E1R26KQM281PyRlXBF0XU1KeCYhUJcz6tNd8D2ZDeVxuOv1e/V?=
 =?us-ascii?Q?QaYC2GrxBxGC/ld/v1NiDx5fvzEGAVx7XRseTHKfgxHSSWcEjIbffrGdqwFP?=
 =?us-ascii?Q?2PYWwnPOpbnYigPZwPy6aTt1HsGw+kANE/A9V5MmHONKCWT5r3lTzh+R5nE7?=
 =?us-ascii?Q?J5S7OkiixkJbaABykz8pLC7iUQRTzRvv+QxYRuW6qmJ2LNd4lB4nAFN6HT1g?=
 =?us-ascii?Q?9UXRPbR6KUlTMKqg1yx9sf0sbHQzxmqhhsQa4xFWvtRw5B86XhfG6tfOV7Vt?=
 =?us-ascii?Q?k3uXsNuwMn/GOM1vzX56D7/tbxU7gcH0fsY1fXAuT+uXAkLoUKusv8gsuYw/?=
 =?us-ascii?Q?TZy6XLZYwTyTn6VzcrlR1Ego5bfB9xiamBCEpuDogu5HoJgO1jHDFdGnajKS?=
 =?us-ascii?Q?CjP2bJ6x9hgzHWu+ax40k+oznMaDiuEkCtozd4ydRixKW8ei2vMaAXl4AUVs?=
 =?us-ascii?Q?ciKGxikPi53NXGjnVO/WcWj69arTyBhZ0JhpsnODlTz8atQzasUFZhFWdbU6?=
 =?us-ascii?Q?FTZ+4wLDOoQ2yi8VPFCIaXzK6iUgeF2hstgZxFAX3R/QiobO14aUNd2+j5og?=
 =?us-ascii?Q?bNovX+a9oO8W+aA09lCqUCqitrsAdxSxSMiuGZ4exNK3BkAMbL6D5oiQ3Dgx?=
 =?us-ascii?Q?tqJ6wi+uLMZzbwxbruUxu0rgW53OYaUV9Y5k1O3o3NbQ+dn4WJuo1sQEGka1?=
 =?us-ascii?Q?v8E2vZX/w9ZrjnkK98dHVVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(19092799006)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6B59heZsqEnW5vHP5Jh+fdpa695la4yuuY638k7cJQsimWlaM90xbtmbPY0d?=
 =?us-ascii?Q?9LFUe7YskC20hG8gyx9IfVop5G6+5sQjWSaA5fptX2bRam57VEkcwqm5mUX0?=
 =?us-ascii?Q?8El43h8paUH7WmnejGNo50aaM47B6uj1NXuDu4MW4e6/3+NHYmx87SGQso1W?=
 =?us-ascii?Q?27je5f72z6x98D/HM9ulECydAmna+/WhYLQ5QFxLvevy4IsFWeZNZzPCRs0b?=
 =?us-ascii?Q?/yDtRESL8ViM4/85Q2SgfKOvPEHKefdm9u+bYEfMzhsZRF6H497VhqI1f5KC?=
 =?us-ascii?Q?HcgAbZQcXWsfbTTSKEVK/PR+C0HIC9GvMnyqLSZK0tsiBJ1GcATvGbQ2LR5b?=
 =?us-ascii?Q?5ysSEdM6ul4JRAb3DJnF+CuR+PQtB1QeZrw3zl4ARBKj0ydhG69j7amFeo1Y?=
 =?us-ascii?Q?pmzNgAjLNAZh8zHqPz0CI0wH9W4WtzR9p5n3efcJ8mGZtfP0WL2hoWp4y1mJ?=
 =?us-ascii?Q?A4vn3Ia62WG9EyyECC6RKYWakilndMHETI9RHlYCQyBhheI/Cuwoy1sdItOz?=
 =?us-ascii?Q?vYd9ALFratuM91tQcxwHpIkQLDzpm180wGuQk6eNeYrJcgK7FAd/faOZZf5S?=
 =?us-ascii?Q?dnytTGyXlSdc4Xo3uBmUcDdlcjINfHC7qFpgTaXkIDt8wCEWg5h0h7+P7Q/y?=
 =?us-ascii?Q?p2LyE30S6iPVojjgBvmYy507Ai2OgX9IJhlFy0wuGj5B7VS0DFImuLA69v8n?=
 =?us-ascii?Q?od2fA7H6iBxthbm2IuT/63GNtykDHhUZzlWmbLAirDvMq5lfixHJ2zDloRv/?=
 =?us-ascii?Q?+IA7iqrxZMI7COJCVN1wzphynITprnLMjY/7OOCtgnEpjTieYfCSqJo0IDNT?=
 =?us-ascii?Q?nogOXcCTh5kvhb5yGdAIlp9FVJ1VmuZfMdDuLVeru8qkpEK+vYZ5eQOshiqb?=
 =?us-ascii?Q?/MhW+oG6lZSld7TB6jFcOSpWDIlBcY9epXMWRoi8mk+BF0K1SkyxuvL4fn/S?=
 =?us-ascii?Q?7zjSspfWmoSOExEikTB+gGChQ/MSVfJcZ4fP4XzrYplCIAR1HMh+gelTaAJ6?=
 =?us-ascii?Q?+JDiVIoHIHxZ52LcqKDVJdB6BzXa5/WSDOGWvnxUhdT2oK+jZ038eZKAoiu5?=
 =?us-ascii?Q?iy/90KD9YXSsN+E87UVfkUIpmPyXozzIls84BCXSb7fOqrrFdkvTsxb1wMHR?=
 =?us-ascii?Q?VnUC5dctktGyt8SYBZGquHNPqm7ex85jbJcLUXo/pESoCFXG86d1VMEEyKxr?=
 =?us-ascii?Q?3pgQMUEWhoz7P9ukUezrG1hNviKFiEm7j5Nrj06j9M8SgCSvzNvmXArEju0M?=
 =?us-ascii?Q?BFIpBB3VW3FYLiv9pp01eEtQ5Bp+KtSzvigB76nLRcgR/5OzYHrB/rsHpl0o?=
 =?us-ascii?Q?rIjtcfRNT/FYvo2lMRxh5tHcSqPt8OtZBne1j9Vn3Pqrb2KqSjew0Ks0XDGK?=
 =?us-ascii?Q?oUtbSyHijosYWcWFfXILFQOeWSedPJFEi284mgGDZEKZj8NZSiAstNMvhqk7?=
 =?us-ascii?Q?JlsxyCmopQyU+hID240qwM6OLfOpN3Tl/uKg2FRx0Ds0UbqUTju8UHAGkPOQ?=
 =?us-ascii?Q?Knzpq/5VzInD21/YvJhOJMB7djxzTqKN5YJC/+nIeOcMuCKgbQKeaY5CDSGU?=
 =?us-ascii?Q?Pi/cQzlRhQg+rPRr+MxnN8r0vYrSDWqmei19b0v3U16/HVX4PDgIDenI0o42?=
 =?us-ascii?Q?FeNJ+OumrQC9GOHrt6NaHMytXuC1MlCPK7tPwKc2wNDzzyb5EyqxD1SiEIfT?=
 =?us-ascii?Q?58ug+3wyEYIP78yKuRLqbflG0Uki7D4oY2s87iWNqC02obJB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17eed5-4764-440e-ea57-08de538c17cf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:43:49.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD6cLWzhm7f65Y6Nx/dV6VEC1uMlkvwT2LNExp3TUYbDrL5bejPsEmR1Ai8X2tU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12079

On 26/01/14 02:49PM, Haibo Chen wrote:
> Add spi nor flash MT35XU01G support, it support OCT DTR mode
> at 200MHz.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Han Xu <han.xu@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx952-evk.dts | 41 ++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx952-evk.dts b/arch/arm64/boot/dts/freescale/imx952-evk.dts
> index 2c753fcbae3c5d545f5d835bd70492667061d626..534c93e527d0f3fb14ff3f21114993aae1d88a88 100644
> --- a/arch/arm64/boot/dts/freescale/imx952-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx952-evk.dts
> @@ -111,6 +111,25 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +&xspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_xspi1>;
> +	status = "okay";
> +
> +	mt35xu01gbba: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_xspi1_reset>;
> +		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <200000000>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +	};
> +};
> +
>  &scmi_iomuxc {
>  	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>  		fsl,pins = <
> @@ -214,4 +233,26 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
>  		>;
>  	};
> +
> +	pinctrl_xspi1: xspi1grp {
> +		fsl,pins = <
> +			IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_XSPI1_A_DATA_0		0x39e
> +			IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_XSPI1_A_DATA_1		0x39e
> +			IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_XSPI1_A_DATA_2		0x39e
> +			IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_XSPI1_A_DATA_3		0x39e
> +			IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_XSPI1_A_DATA_4		0x39e
> +			IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_XSPI1_A_DATA_5		0x39e
> +			IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_XSPI1_A_DATA_6		0x39e
> +			IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_XSPI1_A_DATA_7		0x39e
> +			IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_XSPI1_A_DQS			0x39e
> +			IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_XSPI1_A_SCLK		0x39e
> +			IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_XSPI1_A_SS0_B		0x39e
> +		>;
> +	};
> +
> +	pinctrl_xspi1_reset: xspi1-reset-grp {
> +		fsl,pins = <
> +			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x39e
> +		>;
> +	};
>  };
> 
> -- 
> 2.34.1
> 

