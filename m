Return-Path: <linux-spi+bounces-9753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE3EB3A9AE
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311553B5DE5
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236C26CE2E;
	Thu, 28 Aug 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nj0dRaP4"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5A26C384;
	Thu, 28 Aug 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404845; cv=fail; b=KgURnDXAr6Vm0Z0OfrnoAO4J6GzMK1oBIL9R8kcRDNzVbZiCrq4yrOfrLSy3p5UIzXiZVO9jWODsqUr5e10mGll8/ymDVrHT4R3SS6jlVg81qvcCowtH3xMDSCd9BvQKq7KFrDqm73HoSthm18lmbwGmKRqOpS609r0bWMRI6Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404845; c=relaxed/simple;
	bh=k5X+R2kzFGLqHF8FlrmcsAwZ5tTTxUd1OPAfgXvZeNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1jcCcayhvIj2Tt/brR5juHcnZUw/O6BzOkUkJDC6JZvF3/eFF/PLh11AmOJA1wvSoONiAd/BzpgpFevTp9CSDD/37IjL4DhSO7OSuJNSwVN4CuDBtrHrv+pU2LitEmX3X0DUoz6orWT1rQvi2ZhNuzoafyxh3+pHOdNJosyEvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nj0dRaP4; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY7QW94EaOnI5ZhQo7WgNnImAlb5Xj4QhiEojpZHp4GneQZ3X9VrqO21r7hpUv52aMuAm7iMgiCgtz+b1VFNCoQq3f3bqPwn8YGpHAhFxhexN8cUq2edEtLZYnGts8V/jLPV93LM4KZ62gOFnGCJm88HihBLn6PtK9GlWzInY4WpbwK8YPL9O+drVvxTv7ebfXu6slsFqad/ppesvBToFL5kkzaV0SO8N6vN07pUH7MZsr2Jg5RUlAKCc3hdEhYHc587osVAPIZ54dc08M78wNtFkUDyiHgjwKF76dGzG8XCI4rRS6YC/jgMxzOupIeiNVWe7tja+mxjdcyWS+KvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZqs7TTCCya4YB3OxUbbQkuhFNnEr4MwBKOR2Yak5cY=;
 b=LuN4swd9Nr/9+sDSSpDUghKZuN7HCX7PsRqCcRB2WRpjVUfTA4jNITWWtbyNaL8iEBBAVnoOTLZQKEe7ruWdAvhcFSAAA6q8O5chLjTCXv3fb8B+Zjx3OM1izSd9e4trBhXR27KxsdKo7dEb20ZdDsgaVR883cOZFLWcPBOjGr1hnrXgvRwcmAUEHhpa001tDg0jyZ/4Dnpwx7Y9DjXJXduDmzrsK9UyddeFnlRG+KEvIIPWq8sIYO5RIIT7OY9Ae/mmmOoPy+aUDxRHhaEY8NAKoOU6faxQ4YhKp4RjoxCBcIb36H0qtu8WNrrXKcHjTjFI6YcM7AKbRCOKNkAuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZqs7TTCCya4YB3OxUbbQkuhFNnEr4MwBKOR2Yak5cY=;
 b=nj0dRaP4JkaCQn5s8BOO9ql3KzVVj+JZG5OpKDCX8ThvYlnQ9csHxsiuG4AeEGN5p9IoWmpW2fc+mKgwXFDlRbB4rW5i9hnZkcDV4LfvUwRcGLEz/7Osydkj4y8sx1sIEtvV4dcKSE+HNvsLORHZ6TtsYDetPwFB1mqVBHuHb2WflL39c6e63+pajKK4xy+etJeNmO1DsoeJ6JXeW9WYChIR5f6TUS1RKleD8Yz04D69OgtpgsdeaHZE/ox7cvfyxIYT6l8tC3AQF2peS5OBLFCfNEtY9Dq6g+ZGeAVRI9RIJGirCqyVRoJ4rJ0IDC8PYHB7sJQPxjCZNIVZ9Qmk4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:14:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:14:00 +0000
Date: Thu, 28 Aug 2025 14:13:52 -0400
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
Subject: Re: [PATCH v2 7/9] spi: spi-fsl-lpspi: Treat prescale_max == 0 as no
 erratum
Message-ID: <aLCcYMBqCF5XaaaN@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-7-6262b9aa9be4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-7-6262b9aa9be4@linaro.org>
X-ClientProxiedBy: PH8PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:510:23c::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f54e67-2271-405a-e914-08dde65ea95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzDe7ao7/w5CLoQGWZV4ntZMNxnC7komXy90nuaxWrlVCi2aIeJ8KhOMBkzP?=
 =?us-ascii?Q?y/KjypBzeJX9xQ4/VUrCSjdjMWZ43d3oEswA6TioQOpHASmoDiH08UIWgl6C?=
 =?us-ascii?Q?HVJzxHWwmJBvFL2cuxtf96DkYrpoYzoi97FicFO1XKw0bovNZKwI5avgDhOB?=
 =?us-ascii?Q?bDO9POZpU7P7zKxjK7KSpPq9tH0gq6y+G2sUKRxfXVim9qWy+R4ixTVMn4dd?=
 =?us-ascii?Q?4bpy9B3BxE53diENvgi8zk3rcnhfd5wMqZkzcRDP4tBhVJ6Bp+FpYksBlARi?=
 =?us-ascii?Q?r0LSBrRhH1QjoTn4rht1pLqVRdZScqmosnB0iqfTQESXzYLWx2niMp603kpr?=
 =?us-ascii?Q?Ztlk6Z5dyH1Zsyt6mvrUPa4G3UeJfMLhwbxL/w36sF6yivOsXpXrGF7chyc/?=
 =?us-ascii?Q?RO5/HRiQl7aX78WLPxAsoLcIhRxj+3359OotrXSPNQ2WMVa99g/LHlqwoEZ9?=
 =?us-ascii?Q?63Z12YDow1Z322jSuu/K+tkHoEajb9dySaEseoDSKRpaXMQVwXQUQbuXiX3U?=
 =?us-ascii?Q?qT/+aquPtjV+tERe7E6D9jBoVzPc9SVG9qW6PROr5bE4CewlOdrul+DYVq5R?=
 =?us-ascii?Q?7gamz+PTv8b5789GsloMpPtlR3FEjpIrZvyOW65SAOHkkyuxzyzhuu2ti0J4?=
 =?us-ascii?Q?9/80MZ7DUbyzTxHvEnsQgJM5imiyJwDWBxssyKpKoRoodq8cV5+30P1V/qiS?=
 =?us-ascii?Q?sRizHaYvlZVnUrZtTuWv/x+BjqmYASBEflct2bLZr6rAJy0aA6wXuGU/nwKm?=
 =?us-ascii?Q?cGdmln5P//yXymHUDRTr2TB3EcvKPZ9EN/v4NvGC65IOOc2gADNOUYnvMQjP?=
 =?us-ascii?Q?aZLOlsaCESxsZVGi+14lM0UsKZZjJcUBV9EvEAFPPc4r7o20db1PY6awW+yB?=
 =?us-ascii?Q?LiC9XJKjtZTzLkm2QWPRgjOq0xKzIbARoD1EPzXSMSujjE8HE+zmBCC3y1tZ?=
 =?us-ascii?Q?erl9iwkkbRjhQ3OuOh5xctglK4pQNVjJ0jVXU6GcYFCMfhharariQ3cMDe7I?=
 =?us-ascii?Q?oTNClLuc/4VJIoZ816aCEsBsR2U2j7IPqazeKxZH7EHC/4zWZBmEZBf9NRur?=
 =?us-ascii?Q?5++jmXghUvQNpPcbcv/a+g2H4G4tPm1Ieyiopp+Dj4mx2PALUjfuj6Bi4t0+?=
 =?us-ascii?Q?i/mWaXefmlAKutHZMJCT3zdC2jaIttMLToJbAGlu5hNcl6UBjPGR1vVsokXX?=
 =?us-ascii?Q?B+JgtdgojSbP8pZze4cAcQ5KO8MU+63gDBVlfWc/k0bYJuX+jivd2oO1Iui5?=
 =?us-ascii?Q?IOJolA0cpBe/flg4ngK1kn1Fa90Ob9jEHqoc97QaxeT5+OUNYTGuw29stbmi?=
 =?us-ascii?Q?ZmVY4H+6LSueUS/e++++wrVW1hyViOav8vRAb6uVvU/I19fYW1c9R44+LIXe?=
 =?us-ascii?Q?Anw99dWsW4LpmpnyH84i3ftUgD6+foR/NWGWkwXzZO6T5cY1hj7wjTaCYIKA?=
 =?us-ascii?Q?2wCldYd5EdeKFSpYMZ/uSwxxYjx0kCNzFBE2zMY2N1rTPFnOO6hxOUNWnw4R?=
 =?us-ascii?Q?vWfiKV5RzH6YEys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pl/CNRAEpRR5v8aaefzz5lDSmCwzz/m7tO7yPmG5kHFOKQZDvSRmH+u0ucce?=
 =?us-ascii?Q?vJmjs6isxe/78o+a268ww1veiOqOLTybA3EOAThSoqgaFOOOeOwbU3M167+h?=
 =?us-ascii?Q?hpDHsqcNuCKS5TVwzWEDR/wAWVPmUCWZBLI5ZE7NSFMX2VJYyiOAIhhYaDPD?=
 =?us-ascii?Q?OV05Ku22jkpTgcKV/uzQUKb+CIRxpyVGgBQU82H/y2syls9bDAJZ+ucd+VfP?=
 =?us-ascii?Q?TCRFJsfNkJm6flbfxvqcCajFbztFj2tQEyDCrW6P1oQWJkB1CJY2vVnPz1kz?=
 =?us-ascii?Q?chCGfus3i9noU6GFdb9LiJ2pcW/vUv4QhgmAZ8JTavDcLiuoxFqD4RQPC16D?=
 =?us-ascii?Q?RUOINdQPxCdkwFjSqwp/qcC9BdqDozVRuh5AXD5mFzfozc7NlzrKXjBK5iun?=
 =?us-ascii?Q?n/eMgRNFvYr30EJ5PoNn6j5cRPXjIKYPYkT5ZMzPidko6ce9z9B1TcmHiJnR?=
 =?us-ascii?Q?2mBg2kbtF4NWtbi4CDvemoBM5+b6WtZiqdt7Xj7v9wfVCjDnPI5mGGmMu/EE?=
 =?us-ascii?Q?G7+tnkW4g0W61Cn87/n1Gt9KC905N/17heTeJVlpaDoVpY3+QLhyd4Y+lwda?=
 =?us-ascii?Q?S55G2fnCrQQxLBDUECVQPkSs16uz/sc6Zkd3634dgliedsBqXwNOltXBK5bW?=
 =?us-ascii?Q?7cWVw5TiOd739JsG1SCeChrJFftLxmY1/RpT85Q5SX5P25TNA3NZQPMY3+Ic?=
 =?us-ascii?Q?tvtB1GuA49BS3PYxVK3CreB1Io/AVd4xkuVzjjk772WOIXI7tJDaxjxcPZFp?=
 =?us-ascii?Q?Ja9laMwin7kiLxyM1GaEZUNzoTaEHfdfnltlO7gnEClKScpQmHS4PKbSxPtO?=
 =?us-ascii?Q?GUa7cuRtmYZZGEhA8EaybQblo7rDpZ+zaG0/vwsIB1iQ//E4sXxv9IjkMQ3Z?=
 =?us-ascii?Q?EgrVtMzW+3JNUXrgjuJI38rJQWKzbKR0JTxxWpBT8LSzcxCikXXqw9lkmDDT?=
 =?us-ascii?Q?8HV4fs+8SZd0XSJJwMe0hdygORsmDITe9ggWlS9NGbGCs2A5efXM18GcsRRy?=
 =?us-ascii?Q?GrD5qVZH3n7KZIBCmbxR82OxFnx6ZaJK/5vwpUhNVmd09gr1W4DZyb2jYCn6?=
 =?us-ascii?Q?8K5FLCUGTua7MIH15WySBrB8p7G6L7QpBtOBOXd4aDEqd7V2YAe/NCM29SNm?=
 =?us-ascii?Q?AVzjFTa/5mU/IacAWr121J1aYQ3a+UvY6JS4BqvIPUtpX2YVPVE/jAiUWJjc?=
 =?us-ascii?Q?oFM8NtYl3ixTuaeF/5Ar0/U8bIs/UF0FjJScSvtrco05l6ISy6F8nDMP6/z0?=
 =?us-ascii?Q?5mvBAR36cr906JbgwtlIBZEBDVddbSNDQ4dsb5mOVKKmnLaR+sGdKFLXaxlY?=
 =?us-ascii?Q?UVRUHgZAx6eUSFx5apTmiC8oY0FUH8F5bmcWGWNTvyV+KyOr4aZmazGhQRaH?=
 =?us-ascii?Q?gDihsfrJAAH3ClstXSLcz3GyFhKV5LKxUAiHh7TjYM7dYR3l9aRVeBRF3IAG?=
 =?us-ascii?Q?3uPa35iU3y9p0Own2WHOQZpJ0ir/IfqEbmN2HjSpKarWUypesfqw3MDojw8Q?=
 =?us-ascii?Q?Hj8LNPUh05Tz8AA2thP7UynuE/iE1AjoGYzua94vWM6i4CvLfXJdHjX+3DAd?=
 =?us-ascii?Q?npBh8sximKpOoDYVJQM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f54e67-2271-405a-e914-08dde65ea95e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:14:00.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1F3Rz1SoJHw3r9X9eBBK6LYVvhK/I26cQuOkhqcNSSjI4DKdRw+XN6P1wpbO+ak3mWyrFDEbzdzMUPXHH3aSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:14:46AM +0100, James Clark wrote:
> This erratum only ever results in a max value of 1, otherwise the full 3
> bits are available. To avoid repeating the same default prescale value
> for every new device's devdata, treat 0 as no limit (7) and only set a
> value when the erratum is present.
>
> Change the field to be 3 bits to catch out of range definitions.
>
> No functionality change.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/spi/spi-fsl-lpspi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index f16449cf42bb..ea25e8dab0a4 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -86,7 +86,7 @@
>  #define SR_CLEAR_MASK	GENMASK(13, 8)
>
>  struct fsl_lpspi_devtype_data {
> -	u8 prescale_max;
> +	u8 prescale_max : 3; /* 0 == no limit */
>  };
>
>  struct lpspi_config {
> @@ -132,15 +132,15 @@ struct fsl_lpspi_data {
>  };
>
>  /*
> - * ERR051608 fixed or not:
> - * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
> + * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise there is
> + * no prescale limit: https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>   */
>  static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>  	.prescale_max = 1,
>  };
>
>  static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> -	.prescale_max = 7,
> +	/* All defaults */
>  };
>
>  static const struct of_device_id fsl_lpspi_dt_ids[] = {
> @@ -324,7 +324,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>  	int scldiv;
>
>  	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
> -	prescale_max = fsl_lpspi->devtype_data->prescale_max;
> +	prescale_max = fsl_lpspi->devtype_data->prescale_max ?: 7;
>
>  	if (!config.speed_hz) {
>  		dev_err(fsl_lpspi->dev,
>
> --
> 2.34.1
>

