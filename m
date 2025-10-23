Return-Path: <linux-spi+bounces-10798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C328C03D65
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FF194E7050
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1F2E1722;
	Thu, 23 Oct 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MYKAjAII"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC71990D9;
	Thu, 23 Oct 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262343; cv=fail; b=ScsoYnLMVBpbow/4rBpCUcLK4bfwJhXzqStC3jMNqUcPLzu3Mt4jBC5LA029VQndZC8p+J3eAbbc+shexzuSXWjhSKjwezfLxk6ltJ7EZw/lpJ4LtTn6GxuP76w58ivE5/PYYmedSq9uUPQYAB/QL/vhL4al2S2KWVLq2pNo5oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262343; c=relaxed/simple;
	bh=lQvAEDGMENyxVBc4RyH1S4EagUSZ88QuW0xTpOhQevM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GN0Bj1Psx+BrgzsbCS5sRcXlHgVGwU3M2w7xxocCN4NYxjHl0Yuqqkhxu0DZGTKcqujCSTEyFTepTtvsrGvTBHBBoNPGw487hlcqQjZKMMjndYSm7nXtyJpdNtZl3/61lSkJpZNHLp5rkoGelloJquJkfo2PErGzsGNbvodDgmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MYKAjAII; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWyGedhWxEJao9DXOZa9NuKw52w0Kf7MO6muCQtSl1WMZ+30BEJpwmyEGVK0iIa0zicKovABr9XBThM9lMHeZkSgulqgyXpeRmg5BZr+dmfLWmA+f/MyWL//yECHSbdrbYyO3xHKdSJJJdeXPgblIybmCThOqFSYN2T6jtPZmlf9Zeh1i6YB1nQET74F6HXmr+IKv4uuAhY18EB0i6ZPUt14UBY27WHWbOP41disKyocA/aR2NdBQ+xauO2MTRsszMTJ9QyEkIFM6VWUzaTDWmZ8WNs9wBQh21lGarqhw2Alp7tecA87TQZgM/Fm/rrjW8KMs5uvIMtqOhFqb55IJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzSx8lbAbG7ayvwiRWojuFSS65qwanoBTpkt2qx/Z4s=;
 b=w5DslH5JTsH7PasK+baOn0I+MMtaKr0QKTLzUPnrBr2fnvsAGwn3raVbMTl/sllDKjN6BgaUqvCfMvp/bV7oc4tvx/Nz/pDEK23apal/3ABDKs6kFOR9fHfFb1Ss3lZOoMaR+DV9xHkxhKxRIMwGU9TkaD2DLgU7B0rjSXoaq5+3CQV5Mh5u3Ti+QiKgb0LFWKwdw+Aemjml5+NsTVj2dNIS3AsK4PvEOveLd9bwiOaeMCZuWe6KMSe0PLuw/eZTLAwqbRuNLKrTHz5VkRCjV33IeQgkfWoxdSoIrapgcuYVSeQeZb5s0+597DXrHZjldgpyRNDI0ZKFkhmIgYbccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzSx8lbAbG7ayvwiRWojuFSS65qwanoBTpkt2qx/Z4s=;
 b=MYKAjAIIsmk+RjIRx6Z3t0zgf6Ui92DP3Dfvvo4QGAwuyuRwfnOWP2oh3JMSNQmlbZTsjYwabEaECIbTwwUuA9R1fVdIJAj3reC6I0O+6mtLeM4iTSIdJMoM8s8lyAYuZw9tzRzh3cClGWLIZEmOczDh8JoPKHK7oRnjCBXasHDyA6Dd5GzZmQl+j7ESno3itUcZbn4O5vwsoP4GaK13Cq3PdlxeBE1vYemyCv+BaTuPh/D5OtfG03r896tD4bdY/e9f1kgbRghUrgj3nUsTIV8yENRG7gxFIN9pGGrPCveGJ20AznQOtwWqTvA4UGAeD0bue+yRNoJRWSF84tQ0iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 23:32:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:32:19 +0000
Date: Thu, 23 Oct 2025 19:32:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Message-ID: <aPq6+4RwGeru9Txw@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-3-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-3-elder@riscstar.com>
X-ClientProxiedBy: PH3PEPF000040A2.namprd05.prod.outlook.com
 (2603:10b6:518:1::56) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb18936-8b96-42d6-245b-08de128c68a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZzTybp0IBhVEhLWgkH/1AagZ9MYcp+NfDnd/XauBW4N0sOczq7i+jYwzp1N?=
 =?us-ascii?Q?2r3eo5hOGU+Dmk4GPXrOtUhusc6XUItygzdRtXcDk6YHsegTZ0GobgKddh52?=
 =?us-ascii?Q?tLb5l68Ntibf5ZrAblviaP/woVo3aG/uQAqwOtGze6AwpwnMGCE62R9yUVnT?=
 =?us-ascii?Q?SAhWNRBttadFymfMEqyVFDEJnFwZGZ2UbepTbhhiGV+UQ+TOERwJxE1WKADa?=
 =?us-ascii?Q?E6xq/WaZ/8/b+L4A2YVGo1X/KkoUS107nSKAlX0tBgmyNd6x+YS8CI4LcmpY?=
 =?us-ascii?Q?IF3qgO6k5b+EOeYdvj9IHmzfEztGp1wjvP8l5BO+1samDlUt8vA5HdGDq4RS?=
 =?us-ascii?Q?BNbrrFt+7MxWJ38qN1yprtVelpCG9lxlrVcmlduz/oPoACgjehAW9+OBxwju?=
 =?us-ascii?Q?yp83cg94OyJlXxZovNAGWsmC1Vfk+lKlRc5v4EN+54wd4MmPPPhrCiHcPGAE?=
 =?us-ascii?Q?tPBV3LrfDL+I8n4aQ5BO8suljII/0rFEFqJcaqzpGe/d8gpJU5LG8+2A7iJz?=
 =?us-ascii?Q?ks6ligueBqNE1bfefhFYEMzuk298VHYJOX3ihwHCB14z4Z8Sf/1MPHW4TjO9?=
 =?us-ascii?Q?4r61/kRypm8EsMk8ZgAxW+9Y3Bb/613BxCsMDCY4HyS8mNXduovjLUNZ/Tuv?=
 =?us-ascii?Q?BegaDrw74gMsCV8rrDuWaf2ryF2CIsLP4PDukobwXbzxldxjwnGBGEnGgQZv?=
 =?us-ascii?Q?7YFDHadA4FnD2MI1tk+u/UmguTYrDhKLGCi6LK0+wTr2HVUlC55w+oOj6aGh?=
 =?us-ascii?Q?OdUFiGEwtuNN5FCC1uctme+AcvAosXtlJrf8NKayl3RxwlJrOMOq0DANQTtd?=
 =?us-ascii?Q?dNiG8r6PrNNjGD97uaGyDvtPhhH/ZI23QtAwTCrQgHNpk2gKJiaER0tgrDAX?=
 =?us-ascii?Q?S3T241pP28P1zp59puIg6LVKsFky4+WVZc8JrsyQPJdM/dBj7uGNJCvwvkhT?=
 =?us-ascii?Q?MHa+ZfZ+KC1LE13SLkSDx3XGsZG0sMWh04/A5D1xonvb/tL2HyvxTfZmnLP2?=
 =?us-ascii?Q?U06tKtsNXp/wqXT84uwtLQINd2hXjQulJdl5a+HeEpVr2ix6gLfATGti+M8I?=
 =?us-ascii?Q?pEwggcCwvIKklJFWoch/I7bOULwn7gz6xi7FeEVPnWxmgeRBzk8pyxCOt2sq?=
 =?us-ascii?Q?ah9D+xe2sStECHb0QWZWPsQ2z4Evzl83Id675MGzmvRjoo6JxVIFFKIE1+ZA?=
 =?us-ascii?Q?3y5ZmaSuvP2/U72flefDDeSeEcXUpxC6z/wwPqUUxnkf2UNSVwluOxjULU1k?=
 =?us-ascii?Q?k9fI/9IudjsO4HU/s+Yvzywq+APT7SdP/C8w/7ZkBbf7HKeWQeGRwykWGZYQ?=
 =?us-ascii?Q?2DOvAaGjg4ymRV48Ef+cGo3facCnqT0yXeWC/rdXRhuV63UcqcU8h/mb6P4p?=
 =?us-ascii?Q?LkAU9GG5A4G6gj/FqxCF/zs6USNQ1XvOmA/WbUX83iW5Hd13GCXEkVbL8r0B?=
 =?us-ascii?Q?xbFswHkwgeXvdYdTYH4PkPJ0UpyIyqrozV3aBjJJeqwZy4hAGEHxuk38ZZNR?=
 =?us-ascii?Q?nELxb0QRRls1WbQTXpdaxMSDrFcPdYKh7E6H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?td44IZxPTMs/xGq8DeIYDZKKQR6ArUQMkDo6D1HpJQ1ytVvSM/t3JugWtzNE?=
 =?us-ascii?Q?9UjwQjOuEcgwpq8yDf+TVbS+E3JZ4kLAVyX2EhKwOkLmlt7v6L4uabFtvbmR?=
 =?us-ascii?Q?iR7yIRWkSevQ6TXAvF1GZcsdcQTqGvwrRANfX4Iuw7j1YRporju6uvrHQFfH?=
 =?us-ascii?Q?9onihkmFjUN9x/8FppTPaLjtgN+AeVCBn+VDDXRfTR9ct+GzcGUZzePA/NJL?=
 =?us-ascii?Q?t9pAYUYmHXgoUTahqNiBw8uVyGne+EpInzQ4iwfi9JK8YkMS4KpEXu4gMrXn?=
 =?us-ascii?Q?rNnVfZngef/DHhGlAYEHtEURX1KitdQ8Vi9ZEtvIB/enjnmNIOtzwiMOT5aI?=
 =?us-ascii?Q?v//vC7Ex+WJqvisuGKEo3SiXI6q0L/KU8FzMckpP6QceIG6qR4LvuXkrSGY/?=
 =?us-ascii?Q?thlW8FZb6FZ2ruR/jwCVkRWB/IjXSDDmBKyGC6+o3mfpaxqRRuvksR44VhFQ?=
 =?us-ascii?Q?pmIT3uZ3HQj1H9x4xmwJdJxaBJ8wykvaGtZ1HXJkBbPfTZciBwOGu6hDg3FN?=
 =?us-ascii?Q?dponqnselnRXtTrzPLlV37z0yqU4xtIG2RBr8BcxhlVwU0Tc2RhtxA2czGQV?=
 =?us-ascii?Q?PfQBY0cWLuAxouULSPW123QGMCbZgdknTSOtl8jIN6GDdE9U4vofH3+y4M+5?=
 =?us-ascii?Q?CQAHSAQUYTXHYu+MvspKITvLFyVwUh6IZWNxxtl+0RVCJXcRdrJyws/5GWWV?=
 =?us-ascii?Q?PtTU00oRM+lROH5Qm4VF3tGgotVdY1VZIts4syWqcRjMe9mVVjEI7gMtS9Zo?=
 =?us-ascii?Q?8WMa6z1ZXescdqoX9fzpdJuvfzawJS0wqdQIWTUZasNTxO7G1yfASkYO+Pmb?=
 =?us-ascii?Q?r3RR/icCb+Ix7ra74qUj+aL83pGSrHanuXQpNfJv+71cNQEja6sEgps+0uKL?=
 =?us-ascii?Q?r8k2FJSzgYbSXGl+zP9yJ+jv9DxT+ipZapxQ2iM1pGkmKhD7wVLnEnziPb5X?=
 =?us-ascii?Q?f2aXYakTvHZqKIBb94JISi4M8vJ5kjgZTZvBWQRu/wiVV5dqtv8+JOWyssxT?=
 =?us-ascii?Q?qAu5PeYP/HKM1lX6MivMrjnAs5EOGshNCzYwUMYyWGjoKqMxqn1lVA2ag5wG?=
 =?us-ascii?Q?FLjzZx+JIOWKdvTvnVjCuWglVJ1I6lM9v3ITIkhz/pvraagPYkB0NPmUxNw3?=
 =?us-ascii?Q?a7HAzQVZyp2gZwPjeN3hYXeRxh/04RGjK1CRfSy5SlwZ+FUJfAVq2n9BMV94?=
 =?us-ascii?Q?Gc1GTg11A8oLxAaVlg0zWtofOoQ5YtH/TKQOviFxUrdw78I9e7jxScWvnKv9?=
 =?us-ascii?Q?y/A9AE7RS8/eQz5q8JXlGrRomBVda8h8TiT3TMzRANxb6Efrw1wrMi9k+V6+?=
 =?us-ascii?Q?p95ooq6FXVr//R2IpiczsmmUps4b2MbgUySTcwNt/JYqU5OWpw1EeHbQbBHb?=
 =?us-ascii?Q?04Pz14k23eIYF3/FivZT9J8d89fqsCIz1W59XATqJdi/RIw2oYmwj0mLg8v+?=
 =?us-ascii?Q?Ko0jFu0wESiUXIQyVtpHC+XH0ezidD5oUBWMmBC/7+HbaEDMftJUv+4V7nf8?=
 =?us-ascii?Q?nW1xojhyjh+DDG4hawrqgWah+0IMVG6dXYCb8RsizJ+fPkuUowFZVd9IT43C?=
 =?us-ascii?Q?WPT9kAnzbe4dEKN6BlCX/K2YvmhlZavUtjY8QVsm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb18936-8b96-42d6-245b-08de128c68a7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:32:19.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kun+40S4VFu8/siRbAWCBIpVcQYZB9GkPIGmF9gK0tCeSEhSxvRmP+cd5/JH4qY5lL+RlsBWZuk1HqDB3R9oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Thu, Oct 23, 2025 at 12:59:14PM -0500, Alex Elder wrote:
> Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - The "reset" property now only applies to spacemit,k1-qspi compatible
>
>  .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index 5e6aff1bc2ed3..edd3158a6f2e8 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -55,6 +55,21 @@ properties:
>        - const: qspi_en
>        - const: qspi
>
> +  resets:
> +    items:
> +      - description: SoC QSPI reset
> +      - description: SoC QSPI bus reset
> +
> +if:
> +  properties:
> +    compatible:
> +      not:
> +        contains:
> +          const: spacemit,k1-qspi
> +then:
> +  properties:
> +    resets: false
> +

strange, if-then should be under allOf, I have not seen you add allOf. And
original file have not allOf.

Frank

>  required:
>    - compatible
>    - reg
> --
> 2.43.0
>

