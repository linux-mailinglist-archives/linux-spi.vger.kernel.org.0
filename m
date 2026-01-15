Return-Path: <linux-spi+bounces-12418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E68D2538C
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6628130313C9
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F73A4F5E;
	Thu, 15 Jan 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GZnUybOV"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143D3ACEFB;
	Thu, 15 Jan 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490163; cv=fail; b=MbZ6mLo/lMnrOzasGSnGXQruhrDOUKXFiWfkE4Tl3sAo+/qFZs8XsP74q0CUK3ZUFcHVDFOFzPTzzqvYEs10Nx0AGzG0xFnDdUXoBl99nxM2+7FKPL4ZG8n9m5Iawj4NVeVaAg3K6Idst4qXgaN+z8GY7yODTZqimmvWKsRyXio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490163; c=relaxed/simple;
	bh=1mSJDo5H9YFAoBEQukO+2caLSeHPsOfw8LwSZ46hFJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HssmlNUJ+kcKCRs20RwT0yzuqzgFIOvyPwSDy0yBJAcSnpxWrZYKNeJ7NfB6QcQ2Z39MkeDYYyhxTO54bkbONZJXAXDTHuXQ3sOkfLqH81OHXBvbsF8TQQ3uuB2DJcRgg8WBkSFiALFTyrfJGBU3OLc06iV/7Y09eXl3/pHbc2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GZnUybOV; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTi97ZFFIMDZ+/m9qZ/DAMhGNHTqDEdLZeYtt4Do7iAFdQb99tst64t8yjmZs3JBwmUL5qfluhN0bP4Je1M0D5wWry0tIulaa3Rn1euIQI+znbtz0wppWErTiQRwLepT6g5+f/jwJ3YXuVoSuvhe96SlIFL87icOMHM2iKWaYzp4khbkNmUxzkYkY6DXaBgrwnWhh18JwV40XoIzpF+9kWKmHjpLuD7clnAZvtBXac+db2+4IBAyBeXifsHgtkzFXRIvGi0Y0KsxPv1SElM9FDO1tNgmkgZNp+jMKEVGoDZ7Hs1a+uCxD1+twHRZSBK75Y6kN5XkyvJrD7LKWWZlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0153pnsyC2CEq+4DAGDjmzIj7oGxVtJUdMEQvbPlxg=;
 b=tIabpzoL81XOhYQZakC/9GXTMAweJLFLDdTLO7L9x0kWJKyZ/DjTXgqkp9uHACKqF2d1nNH/nSbHqCeK0P0RAEsdjxr6G6JudABIlrirUwxnP4j7if/IWoT5ah16Bl9Qc6bH3UdvTB1KsMPndsC8c7E7rFTOScPbGX1sqGty4W6exY/FPOD7R4MrPD09kPmJRFHUSH7SfHf2DX5IHBwUsUcmYVPSQtpc3/HKwugD8ogX4F8F6kVr3NjrMsfWYIjDsmMi0UVCfSv3QStyJF0pt6Zw8zZJTKe4MMT3mNT9Irpwp+oIC+qLP5uxzUdJcaAx+lHPANr0L5P0LO0X9W05jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0153pnsyC2CEq+4DAGDjmzIj7oGxVtJUdMEQvbPlxg=;
 b=GZnUybOVnEEv0c2zmhjAoaesLfABaPV2kKfpAExdju5Kef/J3G8wMCH7qTEU5kTa0j1JYyKQyLMaRgL6ENU3aFoFJrg1RTT0+pixxywa68Xur1cH0vbJHSeofkTvG55J12G8ez8bG/GD3+64ZwIposcGAY8X2syf8iBviSIcxpPmjkw+Y9w1fFvYntjIyw9MLkLft80eZkFepPPUofG0w3Edg36Myh34JfmIILP4xLMN6+r5MDVXCwe749FGOnmGSM1IoDZChVTHf5Nu5Qt3X0IT4w3MuL12Y/+7GoWfF2t70AxmhrCPY8X0FAf/xtFgCTBpOV8dldRnbuAriyRFNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by PA3PR04MB11226.eurprd04.prod.outlook.com (2603:10a6:102:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 15:15:50 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 15:15:50 +0000
Date: Thu, 15 Jan 2026 10:15:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
Message-ID: <aWkEnEJRj01JSZj5@lizhi-Precision-Tower-5810>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>
 <20260115-imaginary-banana-beaver-7b45ea@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-imaginary-banana-beaver-7b45ea@quoll>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|PA3PR04MB11226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc3fbe5-f906-4ff8-72bd-08de5448f76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AMvCIR7JbrusFm1wYucrjrLMKK5Rxa5QCr7DLpBolYNhF3YWDSVqIHoZqtBe?=
 =?us-ascii?Q?B/AP/S9DnE+taXrrizKy2rfzxrB/cmzR3oBRMyLg7W/kCV47EymL/oPMCoa5?=
 =?us-ascii?Q?uGfZ+MDgjLS9b5i/d+KmFW8YihfmrSwC7pzhQU9IhYrKBtcVw3xFTB6biWbh?=
 =?us-ascii?Q?uBg5W5tdsbMiQuYefI+IvjB8jHQL2zSakGfRNDG0NTA+3AJF10q/AFVTII+f?=
 =?us-ascii?Q?SHBw0yFPOjVTqjspgfwthxglkgzJVoglL0Q4WrAwA1z+KD2bf4nacYPXklQ+?=
 =?us-ascii?Q?WYg61PsyqOxm2IBC0qBI9oLrqqhjNsamNirZqM5nv+R+3Z6Ckyv4Jnjsm0oE?=
 =?us-ascii?Q?tpGOIXVEd3lwQvEYIuj3J27F89/8XkD7fN2tdCb7iIodS0A/RRvYw06vIk47?=
 =?us-ascii?Q?i/745pa84tDSfovXiC7oDA9tU3nwDUQK8o3/jX2/KQcSue0Fqyh7hvHjVIIk?=
 =?us-ascii?Q?KJqKQO3MUMjIufLAa2xHVMc4FlerCMP0PO08/dp4r2n/AVe/GiFyMjMnQt/V?=
 =?us-ascii?Q?F17SUPL3vLr8S5ztrJ2ltJ6t/EnaDNySSqPAhhPFASGtCZOICeG83HHQjcdR?=
 =?us-ascii?Q?ZoxDGCOKe/7nQ5w78iL1Wnrrv4lnUiymwbApLPL64nsQ+q9nrEOqqzpnWRXV?=
 =?us-ascii?Q?XP16oo6WtB7c6r4R7bmaO1+y4i+LfJGHe9cGyb4bBYS52Z4uCYMaXNOtjDdH?=
 =?us-ascii?Q?cW5DD2Q7nvfttbvCs0rOjA1cLm+FwEl4ijfvZJosLYyz0JX6GuSVTFPMwX7h?=
 =?us-ascii?Q?gc7JQFysCNWTCBVpMZrTFPaieGfrtaq+q5Nnwsyx1504Ymmcq5OdUSe2M274?=
 =?us-ascii?Q?qSNGgUlBQb45RbO4sTY40kGcYlenguGJq/MHh5aRmfPfVi5YReaxtIlazTc4?=
 =?us-ascii?Q?Wh6Jr+8+9PHeBOGiGVk4+MgBJrLeVlErTgtFGJ8puoON2DXtq3XF1RYeeM0X?=
 =?us-ascii?Q?g2cb0CJHtBJyIlTsvrJOnJ6wZJolZyes5VwXJ+DUDJH+X0oqX14ropZGOFa3?=
 =?us-ascii?Q?8CB3480FuctsM2fB22tD92BPawgeSqOZaBg0YbjEtv7dZJS4zty7gimAg5KV?=
 =?us-ascii?Q?J5vw/OdnRstG4+WPSvmSwsVTyy/gfDNfjOd1UJbmcKG/d5FJCGAsX6QxxpyR?=
 =?us-ascii?Q?OHAzFw8KUP1qnwFV9qnNxoc07+XWH+kZ7QJiW5xge3SEqlKT5Fk3z5sBktcO?=
 =?us-ascii?Q?p0nnELH/mfMT7LTZou+rSMB2jfplUy5TDfaRnY4eGk5m2RbxhMU1SHN4SWhm?=
 =?us-ascii?Q?pSDWCo+cFVKQq/SL7RxgLH2KvMjcQSJcaLT84OhVJVRp7ygnJgFHMqkaH48G?=
 =?us-ascii?Q?3hinTrsEMWtpI3ZpRGhv/UcDwm46VLGxtJcg0pX/khZ36PH90Kspq3WtjTPP?=
 =?us-ascii?Q?BOvZsYQVm/XQEHWjjebwnfAskkb0ykaVnsS+cSvi4uGgRKE/WoMZH40fW48D?=
 =?us-ascii?Q?UzI73P4O05MpJnOKtqi9m6/cYdhZruALSCpeQwM4cWBerAASb/FvxkuSxugd?=
 =?us-ascii?Q?Rkh8RERZ97ESR45ZMTp3ShIXV6XAHXVJDb30MMrNEE5wApeBlrr3UsMim7Gb?=
 =?us-ascii?Q?D98UUOUFKLxHOp8ZvQT4RwRzoyR1riMG7lRRHyVHwLo0/8EEtKr55WR7xUjj?=
 =?us-ascii?Q?vX5DbFtWWgbP8cmuoD79mXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m87WSy+UPFX6dpyxQx+y12c2cHHrxPTpsqMx11tp50V4wJRcBAWympZMdIxi?=
 =?us-ascii?Q?i+NlQEMsS+cxeZIIVy3zSSoz6fbpbvAPnYhGko0Lj3I7MR/zknu6iAB7CK55?=
 =?us-ascii?Q?5dWEHNY6vDr3Dlu9m0HfdOTAnmLqKOU7u7OrLs+MOViaDvYDiPYAJ2taYs64?=
 =?us-ascii?Q?9G2zazRsgXz5mPeYh1oHVePHY1Wf/QwFxXzpfUudhj+vvTpqNLVhvpVupHi3?=
 =?us-ascii?Q?fYpJ/yOpifzlnwWgNIEkm5K/shmqjvRALaRQNZO2qzVInXhDQp45rQ9/Bpd5?=
 =?us-ascii?Q?uIYu9imv3eAyh2TLcF/65EfwMDh/uXC6GOsDC/RAd4VRm3tPKC84me9RW25u?=
 =?us-ascii?Q?u1b8q0ofK2AQZdNz9/5+wCbd3HtFUdwGJn8yyD59kOL1O1EQ+v2ex9Y9T75C?=
 =?us-ascii?Q?dknuaUkbptwOmqrBai277gTvfgS0cOzxrNY9O+IwrlEy+xD/yb0t0rXSUa6g?=
 =?us-ascii?Q?y/IucNigc/JCKNdb5LfidnrJawkaP4A1O2M90odgWFeZ8PNyWLTEFnXb1lX8?=
 =?us-ascii?Q?P/MfLAGp1UCo19a8qUkGos7B3YC6EqNdhdbv8Ao2AF1pKREBT3sl5oP7n+Gj?=
 =?us-ascii?Q?c9XnDBf9oaKWJwVzUKqBGL3hTQt14p+NPRVoVFFS3wCW1A1db5tQ1LLtB+ZJ?=
 =?us-ascii?Q?QWCD1ATlk81s0SM8C0vmd/yMMCfukpnF/31LldbcIwBOWe6s+arFXDBgXHtG?=
 =?us-ascii?Q?x9gdxNnFmSD8EHeSz2x7YLRPLeVAspXAh/Oag4Vh3ST4geWdInqcX3o3w1jV?=
 =?us-ascii?Q?TQqiOE96Ka8nC9YGlQ7R+OgfGzZU1uw8AeD5LqdU7vC1DnOMHq5Vwmv/ikh7?=
 =?us-ascii?Q?ZhU/MOmIgMeNZ6bpk12fI0Fh+Tf8//CKpbF3GiEGx/7qnZ/Zzwoay0HGq39O?=
 =?us-ascii?Q?yy1s7tN5iRvFB/YUkV+q171DrGQcn63zFaotlFVamcUIuLMEaKxAfvaD+jTp?=
 =?us-ascii?Q?kESTL5tPbXWcwB6npP70yGbg1PnIiOJrZO0e7JnphIYRwQi+4OwhZSzDDVdy?=
 =?us-ascii?Q?2j2rAwvE6z19sN13hUKl9d1okaCqNkL5WVNhRiCQCfJUE9kVvy982k8bVSVu?=
 =?us-ascii?Q?n4sNoVeBMk2kNUtm3QKQLZeLDJrFJ4EvOjBjMZahi9Agwx6uK+pYAKpYRuN1?=
 =?us-ascii?Q?7wKtfrVYvTfc/n9IyY2T+RJRzxgx8IPMKybXfCAOqKUT5oOGMAFrvOIX0wVg?=
 =?us-ascii?Q?Ae0uP3GCuCNlbhQYqsxjm6obmKSJzdwMr4gwh6JOzSmS3MXNcGOBVitaM6Mj?=
 =?us-ascii?Q?hX0l38zTpqqKYjE4DV7Uw8W5PJlQBAu3z8Xg9KwD/rcFxj6iGiqw7vWNz8nu?=
 =?us-ascii?Q?4BMTkFdwnkY3tevaheTmlCARLUH7xzn9sTh9768nw1STy0aXfzePGRvmxkTR?=
 =?us-ascii?Q?lG1VgZ4STNy3ckcFIAC5CAqd9GtNj454UuOW+EFxGaQfWCHfcJsrrPCsqcRQ?=
 =?us-ascii?Q?5hdrfVxontDvmvhyvQ4vC38yH+Y7T+FIHOin7KKgfrcB45O2YGMe98R+A5fF?=
 =?us-ascii?Q?GBWcrpPUxU1hdESEKX4MoPOoDR1ep/97zd32fmyd5ZxLrwnUa6ixMcCN9NsZ?=
 =?us-ascii?Q?K+ZVaP6OGpQPWUS972ny52fQBxM4zJV4A9Q3aLC5uHvMQ5xLaQYJjXlFGlm7?=
 =?us-ascii?Q?7nFUFfrAZmn0yY17W5INT+IkpfmS1UJrwye/4aujLeUGbtoky6gMwOmVHt48?=
 =?us-ascii?Q?Se6zB6cvQA7R0hzrBnvWAmQfWE4Jg4qZxZ1UXcZ3FWrZoJw2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc3fbe5-f906-4ff8-72bd-08de5448f76b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:15:49.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90v44tS/MtqDMP91wq1hNCz7ptpgqXzlJoiQ5eO234AeEiEHNMtKJfd43DDERTyQ93lzTSb52p00xdBljxG3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11226

On Thu, Jan 15, 2026 at 10:39:20AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 02:49:45PM +0800, Haibo Chen wrote:
> > Document i.MX952 XSPI compatible, which is derived from
> > i.MX94 XSPI.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> > index a0f4b162c85855c55d06c6ea1a2417af5121fab2..16a0598c6d033554ce5a42a13a3265315a16992e 100644
> > --- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> > @@ -15,6 +15,10 @@ properties:
> >      oneOf:
> >        - enum:
> >            - nxp,imx94-xspi
> > +      - items:
> > +          - enum:
> > +              - nxp,imx952-xspi
> > +          - const: nxp,imx94-xspi
>
> You never checked your DTS and broke all existing users. And existing
> tools would clearly tell you that if you tried.

Krzysztof:

	what's wrong?

	I have not find any warnings under arch/arm64/boot/dts/freescale by

	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 CHECK_DTBS=y dtbs

Frank
>
> Use tools instead of reviewers. Reviewers time is more important, so if
> you just disregard it I find it quite disrespectful.
>
> Best regards,
> Krzysztof
>

