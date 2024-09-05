Return-Path: <linux-spi+bounces-4651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0696CCF1
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 05:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EA128599F
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899F42AA2;
	Thu,  5 Sep 2024 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fU7aOI55"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520A25634;
	Thu,  5 Sep 2024 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505637; cv=fail; b=PvocEHIZfe52+7qJ/oDn5nKHRjUPaaTzfk+g3MJhXxtFojzSxtNFemOPhR56N8MZXQe6+CReogkQdpR1Dafd3/r9/2i97GkiY3H7KJEn5LdH0pdeCS9nTHmiu+wqovIkeYaHquJ2C6BsU0GNADrwx3IXwaxBzaZnJCdIM9j4hkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505637; c=relaxed/simple;
	bh=mM5Tpfe/lZbMjfnUZfK6CUXb/D4J1aXxZQZbk7uMRuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BK1vvm3gSLtzRnyske0qhDyS4yFODltu5UHJnWjD9mVGqfsFWiDh37kA1S/fUsL/5prA6aaOGm7Xh6keSAMq+JISKPPej+Q3NHuaRDGxv4Ea9gEyCaAaq6bVIcZF49GSMjCoCgKt4a8Z+50n+Hb+tLtIiZYj7CPX+u5To+N+82s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fU7aOI55; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q29SQSXX1NGDMFjLArOwplArekQPUUQpLrq2ey3oY26rgubQz6XW99CdYh4ZrzInHx5xPh4H7OOc4sj/yfhMuoc9p+BEQlwasceZDg4faBpJ0SWx+WAsBcqGc8VvZIO/aHtiOLr/dHtDkxc9SbTtei1amtJKqoVDJiOBRayMROkGvMBsAAs9TuIdGepYmL9FXaygBzETPANw51NRz/rVugIPVcdh4Gdg5RvNMf8ZRCtYFT0A90/RpP3guCV4BLNpAiBbdTDZ8pguFxDTlhQK32AQkG9u7UDkVyDGq/caD/6yiXCXALm7FRq+mUEqTHHnexeQkg0H85AHYZWl7KrCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGFfEPlUoKU4Hpuf/WsuwC7IOAi74QqRzouj0LkChJU=;
 b=YVvQnujY1lG+lziCR4WjQIPZg9+TMxW1Mhn6YpmtyX6mUD5NuMKkuHUDTbcz6alj7WFx2bkKAL4cPK4nfxii0vb5d/U1h5VsoQC+bLBhab77q4d3ruTmasXD0EojIASeCUJ/pcMNP4xtnbEWWeNYSlcjro63aHpnwuKA87mJSDMhtEpKXH3GJ1bwlekUE4Qtvs4DkacTLokbmIR7RQXoMYUYVqTTWXl8xsCtfrteqC7V5qQ0BdiIEh1rDPct2MaPmw1Zqt4e6xW99IDwH5lg/U38jqULxNT7P7GA6GR9L3Iifz5GWQEnMYd4IM/KpDHdrN6eRZv+YOqO8C7ZGByrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGFfEPlUoKU4Hpuf/WsuwC7IOAi74QqRzouj0LkChJU=;
 b=fU7aOI556HV3dUgqiEzNPb+QillAuYt72QvdOexoUrac4ntfrgvd/myhyr75/Y9+AYSCoy8/Y+lpuMA7aKZXamTFuJPGb2DbROEh7woAiEbrrdLRjwGSY9qt14G74/jpKlkqlG5GQo2Srkh6i2xY8w+3frcCQb/TbZUpTpLXfV8ScQzAn9JolAp/RYcyjWEVdnFjhyBLldnpkul4obPctKq+RvKgC6K3gPE7GLS5WBeLdF3z+nekQOeU6DqKHwY/lC6v7WKQ0LZKNC3QZ68c5wlDhuySEhyUQcUnMeqCwQlYf4poqYHnjC1tbIaCN9BWCholeRgOXt04KifMEKAHaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 03:07:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:07:11 +0000
Date: Wed, 4 Sep 2024 23:07:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: nxp-fspi: add imx8ulp support
Message-ID: <ZtkgVR3GfPWnOD6n@lizhi-Precision-Tower-5810>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905012617.1864997-2-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 688e06e6-8169-4670-1f3b-08dccd57d5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IyPSuT4UR9B3LUv1CqhDIG5FD8gJiccSuaRFjI6/4lch1cFwZoMs42aRF6rV?=
 =?us-ascii?Q?j30t+4VeMixjRv0th5WqxIHV9oZbbNnF0+rQqVBBKifgr5wk5Bb3zYo7djXX?=
 =?us-ascii?Q?xqSiYoJYqkXoZu5FDJeoFCk/jV1Sc1gmS1VnW+hf75T6JgmDCmfwod2LLLsW?=
 =?us-ascii?Q?hW9usQWquxZfrnhkf4GZ8vFdVPuGjtFTOqpDW8vVJlh+wYsV9o/1Xd4RD5qk?=
 =?us-ascii?Q?K2oOnPP4lbprgWyNdi0BYBeRDdl+Zf0UK5eU0mAtvYc26ZH55Jh/vxEHUFRl?=
 =?us-ascii?Q?xdPi3PZX5f9dkO3eFQ+Y9t71F8Wmmq3MIV2yE1SBYyuZaHyzlZj1ezvajhRk?=
 =?us-ascii?Q?kflnCYD03qKN9Pps7Sn4zC6RW/8ohF2n3Hgc+5rWaiH13/CMxDVRqYkj/bTP?=
 =?us-ascii?Q?WNNPe1Z/xPM84jy3wAZACieTGKPxMBjp1zcIIaKCE3JpLAUcac8XlAiGB1tg?=
 =?us-ascii?Q?QJiGT/ruG6xZWykwNaXICv1IuqEPFwTwy0t7BCYz1S97ObJQYDMlzd2SYSbb?=
 =?us-ascii?Q?8fYSnOOPBVmUho0mkea+z9asBffA1voX7wkMdQMeHCeR5UZfIqJuuQl5TSaT?=
 =?us-ascii?Q?yehkuEjdiSHDiqfhamlRw3qdyziMeekGYvB4delQ0Ojv8WV1Fzq2U3/+LhD9?=
 =?us-ascii?Q?2EhI0zssZErWal2PPNvQxCEe1WxLAEcmS50krsxHkxjeLsdlbtJAQ0nMWFrs?=
 =?us-ascii?Q?mesKyJbibaw+vHi1/GOvbgQmmVfZN/BY5KgtGbafD+TruHxetryxIdtE6DtQ?=
 =?us-ascii?Q?2KlFll/Z06mJ3GKKqfbTLHS7+UY4MVjibdtnPTtSrrUPNrMdW6BPf+UKxrb0?=
 =?us-ascii?Q?Z9JlWDW8TUFoB9ci4jKmLUavdZjl/n69dQky2CBN4D2yS6HYQjVif5uTQ39j?=
 =?us-ascii?Q?LM1R0CrRXXWWEDnSeZogVRxS573rfl9VECBvAVOtLr/MTWsciEOBrQ8wiwOX?=
 =?us-ascii?Q?mNFcyM+O17AjlcIgkLmVjU+hA6YOYn/oDr0NY1F06JKa9TbjLU/Q0voy8OqJ?=
 =?us-ascii?Q?FyQcXy/sfuFKqJk8LydI+CAMIwpbc5cRNlJASRBXI3LEfX/VrrSxVQIbKoML?=
 =?us-ascii?Q?aNgeIDUJtatlhnlhcSIBRWv+qqEmur5/Q2iKm5lEWRjAWNrhq2JkgC6QLPOe?=
 =?us-ascii?Q?Xetfh7Izxorag42QFfbs+KPzBIS7Sju1lcjg1g2sGL21Nf0e09Ex4wEIKRDn?=
 =?us-ascii?Q?Xpxt3cYqp00K0PW25Bi0B3JOvxTrpBvTis0RhGUlnUc5rQO9P6LZRDX8PQuV?=
 =?us-ascii?Q?gcLXQXflZmSk6y8BcoZi6NotBW/eivpRqbXAfs9LmF7zGsiYPrDiJIsLYPhc?=
 =?us-ascii?Q?UD1ICy3L/KVTJXVdX5hYMSRL/4EwrcOS6uvQDlTQPRCSUBjgm8NrIulNKE2+?=
 =?us-ascii?Q?Q0DmP006z/wOTkd2qKdcwn2lImN2dZQtz1BvvgR0zTdPKOhUnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iB++XYl4igRnjRzd13Icjeaa79unrhNtQnDL6axUBSuI//vMFIyKBpPZ2HtZ?=
 =?us-ascii?Q?sO9TmHkGVLdoaegAe/+H/3Z+f06dqmhnRnDzh+z7i6GCwP9OYbb7zAPSO//4?=
 =?us-ascii?Q?/d5MSMCN4R4QMqpIeEOeYGqZOPAw0rdT25XbccxoN8/wmQ0TlzxqFtZi74cK?=
 =?us-ascii?Q?Jn4YMdi0WRgKqPT9REJ2FdDxDcoRtXEv+5E9KWLWiDT2IgS837TgEVdiuryS?=
 =?us-ascii?Q?kxknDc8mc+xRB2AbO5z0p+XGJwtFF0J6ThEUfUGNeIdiLxnNWt+UgpW1zGn7?=
 =?us-ascii?Q?S1Eq3Az2ZOcDlpcgBaL8XokEVZy7ueGDD1w0ZXnHqf5S4vi+kYL/orkovZ6i?=
 =?us-ascii?Q?0jxNu32UdP1y5p74aHfGFi2anlW7X91tRwhiQh7srOGxutk/pbCEJGJrZJRg?=
 =?us-ascii?Q?+OSIinl3QpSivJXeIT7lk4LlQZjrAEucfMaiSuN6gXhikpAKKDpgcmylsOEK?=
 =?us-ascii?Q?bq2udisKXRT/a/eP7OIyzxvevvuM5LXvqxZesYOWp13bSTnhonWlnkYLfIGz?=
 =?us-ascii?Q?/W1LWGPrw1YUqqJqdi01ongOMhwshsc+FsbsmzSYVonD/VvCJhNq2Bx4mWph?=
 =?us-ascii?Q?fWEixngqzFHeGXm/WmgiH7k+feCrIY5AoPIXxj+NPMH43En1gTu5CvqCPGXl?=
 =?us-ascii?Q?dpBc6yueJ7eHc5+V6UCd2b+n3lTsYKWMhK/I7lvMGwbsjDxlvP5+6e7biEMq?=
 =?us-ascii?Q?i7P7Aj8gh+FNXVzZ3j9Al6VPmHrl3FjmNaZADsVrH856v4o+D0ctbHRRFkp9?=
 =?us-ascii?Q?Jo4hF5LhGvKeeS185B07nyrKS2oJ6OFxn9sUh+tmnmtr4DmYBIZdvF1ZxT67?=
 =?us-ascii?Q?I1L8jPMJeap7hgfWuKTf6aSHc/FrCfAROYyX+GBfyUwArOdVelf5ZlBYugDO?=
 =?us-ascii?Q?WEmJQsEjXqHATwI3fyAuYXpZvS01qaAfxPxh6p9nr8NJ4YlHt2JYzAMQpmC1?=
 =?us-ascii?Q?GlRhKSGGeb+C26uCROy9zrSkyw9P6o0oPK61c/M0w0dD4dhqV+uyQVCUcg7A?=
 =?us-ascii?Q?9rEuoJom+wz6ps6d/CdcUiJtkNQ2DE+s/Lw6JoCuBNijzSw5STt69cLe1gN3?=
 =?us-ascii?Q?rpCNUg05Ncj6Hdeb1eIznrCYJDAn+UNxWOBN/U0yp4qE2ICZBa4FUeK+JUX4?=
 =?us-ascii?Q?MUQ2MlhyAR1Xu4sl5wxxumRyvLJWjvUaFQI8rs75iAfQ1LwWtuCv449NF8sb?=
 =?us-ascii?Q?nHZnSy2Ag/RCzDmneD3Dvc/7wNp9bmkdQI/b0fK4l33QjFDnxnCjc/jdG0fX?=
 =?us-ascii?Q?oApiiIUY96Cye4quNX4WKfV25aot3GnFc2HkyOoahIMz2PU1SPa0ErI+Qmi0?=
 =?us-ascii?Q?eQRABpdD65WfrRjGrNb+PXZplOpAla4vmG6Q+KtJL6mF/niCbfGqgWjch3+5?=
 =?us-ascii?Q?ZsaLdAgL7NCuE+UKG5HFoV6BFqJ8GH4mdH5FzYTF/aFHdm9EeusjedZ3cyRD?=
 =?us-ascii?Q?6D8csYND7idonlXM40uJVsehz2qFvUhvsoKjZq7/LZxEgTxDseE5hMokxlgP?=
 =?us-ascii?Q?lGiJgnTzySyZBYeYoN4ITiv/rb/J1aYNR/EEZk32PZHuzRIJ2Ia4BsH6JREs?=
 =?us-ascii?Q?RDgK6vMGgW+nMW20epN1y/mEqRuU16ZVJQ818F5w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688e06e6-8169-4670-1f3b-08dccd57d5af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:07:11.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkGiFIo61Vh1kUGongRGvF0iEVnYTSfrrUwIDEz/RrA5b+z5mLHeSbaqjtPQNzdPsWKMuo/BMQE+hxauGYOcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

On Thu, Sep 05, 2024 at 09:26:15AM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The flexspi on imx8ulp only has 16 number of LUTs, it is different
> with flexspi on other imx SoC which has 32 number of LUTs.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index 4a5f41bde00f..902db92da832 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -21,6 +21,7 @@ properties:
>            - nxp,imx8mm-fspi
>            - nxp,imx8mp-fspi
>            - nxp,imx8qxp-fspi
> +          - nxp,imx8ulp-fspi
>            - nxp,lx2160a-fspi
>        - items:
>            - enum:
> --
> 2.34.1
>

