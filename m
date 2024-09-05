Return-Path: <linux-spi+bounces-4679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851A96DEA5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC971F24764
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F53194AC7;
	Thu,  5 Sep 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNMkFFUN"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F91CFBC
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551007; cv=fail; b=QXfhL0RXkmo5naFQGAb3p2ECYGQS1SuO3V0qPgv/OJDTME4NTO6yd0f7K4qTktUPgn3dggtxX6FOmX30rMyT6Qi4yKETO5qyW6Jwi/eq/uxueMW0rcpYqwQRsmjhsvJzpg2ka/dWspIM7nByFECmEKH53+KNWmLft5Bfi6kVL4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551007; c=relaxed/simple;
	bh=4Amx8H2rQnBHmbPIUFWximrSVdZwhV8kWfU179IjFWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBTm9UcEp/paDVI/w+l/YhOhtLRWCxzgfDB3n++y9ZauRsb4YvjNYwT/GqEZEvKQgKzrVU8ISxJR10FwLU9QmLU0L5HKWBn7n/WNenZoESRVc+WqBJ5i+9tYKBfaRTqCiaGzh7d9juIN+dfGfD1eU4aDGZBa/gzO9DGbJkQPif8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iNMkFFUN; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFLVFprXMmAunOwJO22jGZDJy2qlv1Hj36w0Xws4l1wSc7Z+CATxVr+Rv171BRcDFt+dP1fiK09r/VSYpU+R81ikLIcqXqVo1rYRPrWs20EtPEvwu9ZJLUQnMFYA4mc7YNY1eVxEv5DxQ4oFfcJMddqsDp5D/qDuUvKrx1SpNCVUFiapiYGDFRmgzYW5jdl729YFHUfp+BaLwd2swo9M+9xW6AikV7/PRGTbLn5dmVXCxMBy4EmAed1Xy7NF94txYI54Cd2qTvxKbP8vYKMy1hauPFzZCAcTrRfZk5PMrbQAedDrZ+9l49/KP3D51RSb+uZ5WQtBLpc0uGCisBK4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Amx8H2rQnBHmbPIUFWximrSVdZwhV8kWfU179IjFWk=;
 b=dpRTOMmCs3gh6/CTeGUep89sUf7ECTxqpQ/FqG7K/1jF7mNeady8m0CxLGVvOtCa5at6BRxcU4vw0IvNGQz8whx1Hz03A9A4TPjJ+H6+cYO1ihnNSAS69e2/7PWY4AQj0sVnJqW8kWXDmdYaLxK7I9h36TvhE4oxoFiJTzs0zLP0H0Bpl02NqwmgEj1d/jF1j6NFY8tMYq1vjOMqacCPGI8WyBSMHFe5RBG76O0p3HHcTHoiUn34Z3r5Yn8P73nJK5IjAg/Z/4mFFFgbMcXkb/QdL31sS/4yGGmOZQ6Fvauep6U/olplfUUnHvbqgvboif7g1XTI/9JVCSxi92Et6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Amx8H2rQnBHmbPIUFWximrSVdZwhV8kWfU179IjFWk=;
 b=iNMkFFUNLNc6Yb6zhQVP5qR0rcEvOYBdDOhEAUgkcaisdC218MXn6auQxMnJzq+wlMR1ZtF3iJ2rp5+QjlKmpkskmWE+kCX1Nu3mT5mk9Y8pvpqXtDl4fe1IqFVdONmfT1OfYcWti/fv+dot5XDlWGrmASkhe61MSCJkndxhvKJo/qEX/JFUk9VF9h1ltKWdm5pJu6tCat32MN6xWvibu4WqeRmRdoRbtLViVGh1IdNCBV8UfrSCn0F57UuqUr8EjYY8bSkf76Im3SK0pR9KhvNv4AIvlum+c1nbFTR3aJfLFzOhhyUkPbsLG35ymCqjrjeDhPo0v/sdyTrDZXFeGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8521.eurprd04.prod.outlook.com (2603:10a6:20b:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:43:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:43:22 +0000
Date: Thu, 5 Sep 2024 11:43:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Carlos Song <carlos.song@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: Maintainer for spi-fsl-lpspi
Message-ID: <ZtnRkmlzq85HCDGK@lizhi-Precision-Tower-5810>
References: <1112988f-7c53-42df-94d1-7c479ea276fa@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112988f-7c53-42df-94d1-7c479ea276fa@gmx.net>
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: d37cd69a-80e4-420c-b632-08dccdc178ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TdeCsVPP5doUH8VkhqzYpsPFVW3Ma+YvVimHWvRRhudvOTo1IqmnTzj05Q0p?=
 =?us-ascii?Q?kJTIsILvl2JBRGfoPcYnS62UiA7rQXFooDdwH5vAb0J/gk8rU0UCdSCjIUvt?=
 =?us-ascii?Q?grsqbJgo9mcJebzEon2hqKRl0yz+zmnqvDsmWmBop1sqDmcfj9yKm0drF5GS?=
 =?us-ascii?Q?KU85ahmdoCh0dN91OBomtdEKawhlA75OW04gyeTun7lQwg9WL+MAoCb9FL+d?=
 =?us-ascii?Q?/QTD+4aWe1Q+GHRxN6etY4DXLNq4TSZVTReVqq+O4StWAjO6tEXLCt2LYZOv?=
 =?us-ascii?Q?BPiHHnxjiuWn5X53r2BaG26dXsGItQ8aKkbi2OOC/KhtzpHjcJF1epi8Dv/2?=
 =?us-ascii?Q?piMFw/T/SPDIs7YwBPkEsS0a7hZ7LxQjsLuZWe3Mi8u5Bz14bJ76xbW402jT?=
 =?us-ascii?Q?pCDHte/zEkCKpNkR984xFN70oUend2zKQU2MiQsH88eWKt1ZSTuix9XGEY8H?=
 =?us-ascii?Q?oqX8j+yEmerH8K6AEQ1vnV0h79Uxc1YuILxOk8XZiD+oCeILgHBPhDNS7Hqv?=
 =?us-ascii?Q?fMG4YPDuoFHbG9JCv4Kylq17JJaEHWB/JJv/D+Gk+/9LjVuMpEV2ggQjXasS?=
 =?us-ascii?Q?d1BIlFBpY2vso/tVSfx8KKrpJxL7cBvRFbNrD0aRiy+nfMxS6L+9PhdPJQoA?=
 =?us-ascii?Q?0au5gwiVVae4eyXXP7SVeBHFQoD0vJ9Q82X0VC6iS8frxk7hYRFkVGc3IsVN?=
 =?us-ascii?Q?Mx8TAuNcW4ttlUVVnWBKGMGY8NNxkFaNzGNMkbP8E1uRiX8x9+Qdj1Xy4TIS?=
 =?us-ascii?Q?bial3qI1qPNpBti6fxTFAY1ozZIopCbCY50THXRCZXlnzPMwyAgkecdHP6Vx?=
 =?us-ascii?Q?8xDxf8kTXx0BvdxrmBD47G572324FZZdK0qXz/pyTsNJJjUZvED8pNyPMyqu?=
 =?us-ascii?Q?QETnvfTMVNiGRAb3UMzxLkTmQ4ypm0iSDLLfYEFlTVwRBpnNOQNoJUWspYo4?=
 =?us-ascii?Q?MMO4JjJ+TIflnxetlqQUOvFwAlveWFn8p2FIWBUay8WgPBYNAjOGY18x4BBM?=
 =?us-ascii?Q?f4RdQIfzGve4/whcmhkHB7q/SWSny/s30c5IhH0OdYJUFlF8sGGSjvo6mQOq?=
 =?us-ascii?Q?FhOZRwbgchLOpQoq8rAb8bPnKel/jdYfLzYk8JodSReiAgsHtp3+YvKzF4c1?=
 =?us-ascii?Q?a1DLmvAr5NVopuM6ODeKgrbhLMffHRp+36PDez6hgpMqXZGC+oJK6ptGddxk?=
 =?us-ascii?Q?xrr7efhQ2vpCgl6ir6kIcGbc/JQQVMMOCKG4Fywyu2fbAZpAJTz/c915O9FE?=
 =?us-ascii?Q?rYk+4Fo5rjih5etLLJC6mFfkxMCN1MBYKRtZLTMNbnrf0xLbNyq4kr09RFDk?=
 =?us-ascii?Q?AVpqc2klPxdk1lWcImrJS0IzIaXAiZZ4xLTv0wpRo6iYrRgjmDmDYD6jvt8G?=
 =?us-ascii?Q?BpJtH2YrgxzRTWpI0akxzRKk3B88TaFnHA87Y+BjtHbLeGdpKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxRwR0Twvf4VNKcK1F4pBuiuuX2numpekNBl4F1TUyHWOzmeDdR9Zbwo02jy?=
 =?us-ascii?Q?+S3sp0naUMLPEx7AbKSQzepMTLYewIHRViMU6HAxFkODsAUVCNAVNCS2qOww?=
 =?us-ascii?Q?rVUDTWxiMTAyJ77fb8Ev8TmFD8szJPpID/dnC6Ac+SjbVVnpGBt5n7XLsIz7?=
 =?us-ascii?Q?6dM/eyfkgIqxujSgZ1JdEh0ElURLoDHdg9HPXyJJN0cN2Z45ILuHhtVNVTAQ?=
 =?us-ascii?Q?uka1wTc0nVlou45/q35HhiPFeQezUMaTDMnXDEfn8oLg5Iz6DJ09j6coQLE0?=
 =?us-ascii?Q?nKXRaiPCRJX8Ow47q5jv1Y4sjX3zORik3VoQLCNsC9dc71OPeLBzVK6o4Jsu?=
 =?us-ascii?Q?DeEENoh4/luUVzP8I+zk9E6kMWEczxMO/rh7iLXSf/Fg8ahsrEFevkf4hGHa?=
 =?us-ascii?Q?jc1a9gbQsqnwKMTws360OB+8ctDcuCZ9fpXm3QP/R4sX0dPO9fm6iRr62j+e?=
 =?us-ascii?Q?uNtQvXEodSIVRlqNkK61adFnsmJBLMoe4InLGDnVWb0nKeTjlkZgqFkOPVv1?=
 =?us-ascii?Q?6zlVBEwejLZVvozrnWjXnLwsuAspGXXfrONt7IzHaG+TEUYO/8DbmUwN4ZMf?=
 =?us-ascii?Q?21T0sIN/miqY4HtQx7j8JfsUv997PAS1CNEwEVAURR2KDQTNUjvaklfxDtGO?=
 =?us-ascii?Q?am/YfMNi01v87LVuOwGxgQLbfhHmCqIg78CWqaDbRzWDKMEAxp7vflT9jkNo?=
 =?us-ascii?Q?j86O5aEdMIR8yJHBiVtx2WUfZMbP/cuVx5GY+M3K8pBH+PiWTIjgrwBviCvj?=
 =?us-ascii?Q?tDWbbxFq1OQc4Zb1/khF2cUr3G4R7zPOL+HxpLWaQy5EwgWfVxph2IbPzZWb?=
 =?us-ascii?Q?tLCwB3jhNcQB3h4x6P28akG/1ieTurTsTOwHApmVcEQ0TNs8eMLFysOHt7u0?=
 =?us-ascii?Q?VbKkU7YKpruDWRY69Yi4Szmtv8gfKjPilU4rwXODl/rZki7EUU40+/P9QEzP?=
 =?us-ascii?Q?RpHlnYsASZCsnh7zPV+ybo9z/gz2gXh8O1DQWjmBG8cRdtiMICx6LtZJ46LV?=
 =?us-ascii?Q?WA6/gq5Nc+eDGY/6GdFsx8Y3H2Es3mo5AoEva197tMgdlVMFoGhHLmEYA8u7?=
 =?us-ascii?Q?/DAr+4e2+MpsDjvhv3k11nV1Tpj+P2T4I2snb7Z91kugQmtSbXGhitXVzViN?=
 =?us-ascii?Q?ahmgnotaUSBwS03hW9hfwPl4SQQJZ2Ub4qT+6h/QHs420XdfAsv2bSfXPnB4?=
 =?us-ascii?Q?yVrh2nhTFS6ejYO9ubJDi85fJr709JezKgH02HnNPvyCJgpULypS7h2rIJoV?=
 =?us-ascii?Q?h3AA9SanRxJtL+DOoJkUNPzZyfI6OO0yxeDTwae2+TmWZjNTdPtvAgGbJEXz?=
 =?us-ascii?Q?sMpuSc8eFj2qwlLp9B4PxK0Y9IP4OlNKM0eKrAp7Qm/6Na/TfMd05iq3Najl?=
 =?us-ascii?Q?NZxYQRE37MpeeD7Z7vckoP4zs1YDomMssoCDTLkuyGb2C7f2p/jx1pDfc7F2?=
 =?us-ascii?Q?6/XuPRjmqekf7BxAlRI82NU0TwBo36bBV7end5QbZmwnrwfrrzY2G4vEDlm0?=
 =?us-ascii?Q?ZgXrbPaEOxUEvupILo2hAGyAU83r5EoJc9Uk4xEcUSsQq7z8OSB/G9e1DZiB?=
 =?us-ascii?Q?VWFMiGt9NxQ5e9uZUH3hdpOc/ytNY9q3Bvfoel0M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37cd69a-80e4-420c-b632-08dccdc178ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:43:22.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNrpTfwcmas9jmNtQ6R3ihBbFkHHPKvhf5SNzx2MdsmyKtI/rMXCBi2M1nr8d4+BEkuaRBSloWHPNPE0BcDNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8521

On Thu, Sep 05, 2024 at 08:34:42AM +0200, Stefan Wahren wrote:
> Hi,
>
> i noticed that scripts/get_maintainer.pl for changes on spi-fsl-lpspi
> just provide addresses for the SPI subsystem. But my expectation would
> also be linux-arm-kernel@lists.infradead.org / imx@lists.linux.dev in
> order to give the platform people a chance for review.
>
> Is there a plan from the NXP people to step up as maintainer or should
> it be added to the IMX architecture?

Thank you point out this. see patch
https://lore.kernel.org/imx/20240905154124.1901311-1-Frank.Li@nxp.com/T/#u

Frank

>
> Best regards

