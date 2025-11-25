Return-Path: <linux-spi+bounces-11495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ACBC8315D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 03:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6434B24C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760A1B0439;
	Tue, 25 Nov 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hQn2cZHZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6719CCF5;
	Tue, 25 Nov 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037469; cv=fail; b=rd5dl9o52pmBKj/oC4QKS5Dt1tDXev2lGUcXeT17tO1Cfb2N9dcgMPDIiO1bxDI5XmmL6Iz5jaxv6hEO5yrHuhfZfFtarMYIlsKE8Okcq/ZXgcQopbDbFQvy/A1zC49gTjSpoCZhm5oQG0j362LJhlw9C3RuhddeJvIqCY9aTtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037469; c=relaxed/simple;
	bh=mcRIYlcRzlYfSJObyK5zMWOi73xg+EzC8Vd7+6zubXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MqghKQueSiCB6MqZSbbeD5wVm0UYfN9hX5SJktbe8XskMs7CaznD45vfcOBtTbRYLN8oGmVEBeVPtU3USPIAimVMXWTJGcr39y80HL8koLw+6pPDkPBQeZsO2bbmieVv3HVLVY+deGYMHJHGSQEH6Cfibbmdv45DKdu5b6bYfx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hQn2cZHZ; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEMXrHFBCx4zHK55EPlHM6AuYogoUBPviOEdzc2r+hJsVlqhbIS6hYrEh/kGZNLtZ2NrDZOqBJwCzRNUONdVbCrjafkXzyWrDmHBP2iowR+L5QydcK9IYFGuwfN4pn2lkav/o0XTLGKn9/NtCSgZ1x/smk4cbw9Bza670KTZLpI1n/WAkv23F5zVqkKnOdYmbaEfK7iFs9o6rF7b0MgjViaeq2FjQboF1OodaMqXwFBY79x4mt4BvzYpT2J1OuXycatSNue22GYQ9T3K9xh17i7G4cylH94I3eRbspbRGOVroRIrz6DzEAXndI6cjWMAmSt50Tj4YSxm018G1Gfkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3f3nXLDIzcdvwKeTYCSstBZ4dqo0GsnKlXaGQsrrR8=;
 b=xhm0Mwem2Aclm9fUVlPfc0sQ7TL+nKKekwdyi05Nii1s1QH5yqlEpS4/f2HmWpD8UVZ0mkfclbXcdH1OXzB/ICuM9lrm3q2GMQIjGncZnZQXqhDi7oerT7DWuVRS/lEh6b4TQ1hRGVxHYO7KMtwSVds+OWJDWyerqhMMNQzWLRleEygnz0jIZjkecmMjtwSd3sgqVd1pypv3YPrcMbweVFTK16XiBQ4AVhYFukvi70QyEvuVAdD47lnIqM5prORpVNezV2DkWidmVeMLcoO+yOfGKWgA31uB/XCODtueV7bUamAwOk4ATnNE4DdNZbQVWkXNHjzsxc6eqgMJpPAWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3f3nXLDIzcdvwKeTYCSstBZ4dqo0GsnKlXaGQsrrR8=;
 b=hQn2cZHZp97527jmgII0OSIeRaKz59YPDE7DFozos9s9NaCuP4GQIIcLMRrGLJnMB3VM375a3QOYRhbChosTV1XEh+atOkEj3PnRVlDn49RAO9Ikl5KEl4rMg5UmIZSLUbMWIrfrXK1PaAiiV9EgJGWiU1d6BZwUyioPUER0wwrwVsAEVPgqJEQNXFypX6O7SMf+qzMXdrY0yyfhjB7y/H35xnYfp6jPT0VUPeoeiY3hz5lHyF2g+iFKEQ/ronarTwQ6G7qnfxBJ7n78xPLH8MvMOt3UAdVFw+ubrtLMSXQJ9wBeiPoZd3+S4CQDmAw1kPNSL8DP9D2csPak1PyBdA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 02:24:23 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:24:23 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 2/2] spi: add driver for NXP XSPI controller
Thread-Topic: [PATCH v5 2/2] spi: add driver for NXP XSPI controller
Thread-Index: AQHcXSQyemrLaYsQdkihJDyose79m7UCCoWAgACf4VA=
Date: Tue, 25 Nov 2025 02:24:23 +0000
Message-ID:
 <DU0PR04MB9496647CDAB3D15A5245693390D1A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251124-xspi-v5-0-6fd03a6cb766@nxp.com>
 <20251124-xspi-v5-2-6fd03a6cb766@nxp.com>
 <aSSMxU6iNdAGheSc@lizhi-Precision-Tower-5810>
In-Reply-To: <aSSMxU6iNdAGheSc@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8449:EE_
x-ms-office365-filtering-correlation-id: b17be3b5-86c6-4646-553c-08de2bc9bf85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iY1VCHSt6k7nl8VU8yucSSxYh34gmwWyzgGK0Sj4b+UTcUD73B05fRYVuLsA?=
 =?us-ascii?Q?4o6R1S0cBYyvVzYr/T+7EtUmW0vUUT0mf9DCONxHWzvgST4MO6TafeBPUEhc?=
 =?us-ascii?Q?uY4M+s0ijvSmxASfaGbir0p7RzpDQXU82eg2+Rt4IHqUW1KLhsqINDzgNnZb?=
 =?us-ascii?Q?GKkdE57gbkwYP1IG70CZlefgp8CB58GqLp1ovyjU66ogoh+CXls/BUOrHHU9?=
 =?us-ascii?Q?+R7x8g37Frzs90HD7K7rSMNg7OIOcZICh2GkO27xD04RKWO+STQQrXDdM5eU?=
 =?us-ascii?Q?zwKs13+2pjJZ9DUso42ybspQfF6ZCgsEUorPUqntZGCX/rRV1b4Jv7Wm8eZ5?=
 =?us-ascii?Q?LzT/Nf4Od9xWngFWlE7nMO4hVv+nHcyOELxMTPoQUDZiXGMcupCOQu/anCiY?=
 =?us-ascii?Q?NqLnEHNgkkDKUNOVEnYxWtpg23LonuO+NMKnmUuddGXJJdqXM3CLv+3h4UMp?=
 =?us-ascii?Q?6g1D6Kykq5Di/YMXTtP7DvsFbmjRNW2PivP7j5gAU7WhkeBThDCsKczGqPDJ?=
 =?us-ascii?Q?3jncR9KI6BeCrELocsUgSF6k6MmRRI6vZ4YMCTly6fiHjuGx/IZkunZhjKVX?=
 =?us-ascii?Q?+uMqQwelMz7P+DrYF6k5Un7LBPZg6Wo/5hGm9xV9Xl1SqeyBxoCebqUmz3+s?=
 =?us-ascii?Q?6K2Y5uAJ91YrP0zq9FfsbxLdgHe4gLRHNqp4aHv/p7t97rHKuOhB3P/SKcSB?=
 =?us-ascii?Q?3N8hWB9CUp063YQQ/6MihMUgdJy0/dvxQ61FR150vtwGKYm/Z3QiMYsB7jX7?=
 =?us-ascii?Q?/+I7AOybfve/hvsTpZ5K6skmIaFM7/sYLnr9X6NVHAGWyJi5QRch3pDFZr7+?=
 =?us-ascii?Q?+ZI7AOtLorm387EWPrpjKFvbs0qJybwOpHpKyxLoO8ekXKf1PD0nC9ykFWLY?=
 =?us-ascii?Q?r6ALvm4O9NLCkFMKdvOYekZHnGRjiOdndb06rH6Ip2PrQZ5QcRKjIvWyFcJY?=
 =?us-ascii?Q?NuNaPnUmQCOt0cvKBA5Qowwv/m37ToVzBS/WBdfJGMO0g7nY2g7BODKoW6x7?=
 =?us-ascii?Q?z2vwhWU1FN70rQbUtf+0z6nQ4I1j9RtEIGmTlR7q6hYMYIr/IA4NTAJDLe0F?=
 =?us-ascii?Q?8NRGziw0lK2WSvUzK/4oAGt0MP/2a8SjpzcWVVwNArI3jfENQykVp94tqd7/?=
 =?us-ascii?Q?PFo4h/1BM1Ty91/1G2OD3EOeCeMrswT7vI5fW0HiGyuf7bjE+AETT7F479Aj?=
 =?us-ascii?Q?OIyvw229Uo4Ff99fnSZ+xQRUJaA/92tc5LGGsFEacvkSHuXxK8fsOHheN0Cp?=
 =?us-ascii?Q?LrAMJ3puoCziwCHZr1njUAj0tf0JjdRIDGSy7D45iUGsY0e+fAB9LyX9KFQu?=
 =?us-ascii?Q?iP3RVV+HtMoMexibR2i8N45aKHSFOUesc8+BhIWQBxkOMSKgumNyhLaY/RK8?=
 =?us-ascii?Q?+TneygooDjMlL+ELI/iS25q2k+qjQzFUAAqzOwEVj6yRET31jplLAv3+KGEo?=
 =?us-ascii?Q?20FCjdtDhvUq6OiOSDdIwyQuIL3Lp860/rC6j2jxvCZBabemvfCrmV1zU7Or?=
 =?us-ascii?Q?QB7f12gOsagkfLpP5kKUYN+wXnyyWiUHBNsb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wUtT5b5KbNeqaffHVojLBc7EFg2z4K+0CDXfzgsjWjb8aAK6PMJPFx+u1zOo?=
 =?us-ascii?Q?zswRlacyt/QxH/54cevef2O/KLRHH1NSMe4FrbYAmdcmzaJC3Q8oFUnyKcWn?=
 =?us-ascii?Q?N5VTC9fb/Q5P7CafZRmiSKhhzIJDnMAqSaeXkHmnYI++RoR8aI5T2ywEW9QL?=
 =?us-ascii?Q?9eXdkpFT9ni8v/Q6GPBOFzQTcrLTB/EIfoS6vWQlNQ8lNqDhiZnCIuy3HsWs?=
 =?us-ascii?Q?VbRQZ8vrI5ZSZ4SpJd9czI63ISZ1bSopaJT0Xw+dW8AWIEjmh1AJBH6t9fOF?=
 =?us-ascii?Q?Iv0beuWZIMLldrC/w3gOCG57JrjVvRyFaRZAFI7EcJXngTuIwnndutgwme0x?=
 =?us-ascii?Q?kfySs9zS7Z2Lwvm0WGWAJpDZ5KepfWrf2Gl0NGm1iqWr2vw5ZcS7KDEDYqNb?=
 =?us-ascii?Q?XuyOwb4aI0cxAO7G4DMIIxdX6L2zNBhdCVKQETE5kfFx5kWHrs9bLJreX/e9?=
 =?us-ascii?Q?wA52Z5dLcsLkpOXdwfz+6+ED5kl/uIdeY6m4qz97rOUWcK3VFXxdJW+fgekE?=
 =?us-ascii?Q?99mw+YbumG6WVkgVBcQyyur6N0adOb4b5IZk5oFoVwpJ/dtO4ixRJI79/X83?=
 =?us-ascii?Q?nbIhsf0abEeZ81N2HL2N20z8s4ZQ0DXWa+SBpoqOxb/l/e86TKGmHJ+SOz9M?=
 =?us-ascii?Q?r9y9XgRtDw2av0OtOf3rfYIQahYK46ce8fDcDl3yh26lzI3aVOIwDptnPS/v?=
 =?us-ascii?Q?nnullPpqBMGe3eu8PglKjvV5mSc/psRS5o2yJBf+sPJye25gENRipeE8bZGN?=
 =?us-ascii?Q?P8hD+u34l7Rfiymduj8Ub2ERO4QflWi0aYe8kkkKf3n8WLQHUtYNdLt6/tBM?=
 =?us-ascii?Q?SV9O/mV30EA8VEPLkIlFIH04pS8qXWlla+cBJb1/g1yvGb3nNi1JinGagrSa?=
 =?us-ascii?Q?ahiCplOANcNC3VaYANqwZoty/imZRQsnN6xLzfBpA1jU2r1FoZjK5jN3+1cq?=
 =?us-ascii?Q?WFSpgt18teemsLSpzeS4jsjiJANo3MxFftud697GXGCYYpd0IVrb+IjVxNDK?=
 =?us-ascii?Q?DlmvW7ovBaTECDPAgW6WPfev0968MG2gD5lEURSykYk/EWrzh3Pq7QoYUKJL?=
 =?us-ascii?Q?iIun8NTy9Lwb6D5/L2U5nGC7PAZ/sb6z/HtuMEXUMbFNrH7beYa5tY3nrfvd?=
 =?us-ascii?Q?akQM0iT1nTdJ+t5FN7e1x2UNANMb/mZpAXtTkOE8h8UGPi63aPcEHgGm3257?=
 =?us-ascii?Q?a0BbU2n2brb4aaDeDtnDqjAgJpybfIBtfTHA9itzC1gfWqq4v0aYUlwVKF1f?=
 =?us-ascii?Q?rRnVlQYsOI6+4rUVrDuktEPs3PKECo6dpcylpOf5O3NFvNXMa80qbL4lZMRx?=
 =?us-ascii?Q?BZDTFIkcrQkgZvWc4GYxwsbcpsViAXnJVtUA08yqPPKJ4o8X+wr90T4dyUdR?=
 =?us-ascii?Q?iNFsW7gPe0LI0fS2pbaJj3AgUtR0uXkfLAaaAL+qgS5q+0we9ZKMsmoRiF0s?=
 =?us-ascii?Q?N8tU2exwA4k9ByVAsuWHo/oSiqcnL1U9DiAruFvnxYApA4FPg0x5cFFNC2Cl?=
 =?us-ascii?Q?qwtuPAV/R2MxhIGqJtM2E/nYwJX2hnIjQ3UIBSAjJHD6X56wDU5Oy79Gwho5?=
 =?us-ascii?Q?R+kJZipLQDHNfMeILcM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17be3b5-86c6-4646-553c-08de2bc9bf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 02:24:23.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQca7nkOW3L1iLH46pbGuVvsEz+oEDoPdvgpQnkGZRS1QdFq5l4nDTUVoeB4ugPhYRl8F+kg8GXpFD2rO8J+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

> On Mon, Nov 24, 2025 at 05:25:22PM +0800, Haibo Chen wrote:
> > Add driver support for NXP XSPI controller.
> >
> > XSPI is a flexible SPI host controller which supports up to
> > 2 external devices (2 CS). It support Single/Dual/Quad/Octal mode data
> > transfer.
> >
> > The difference between XSPI and Flexspi:
> > 1.the register layout is total different.
> > 2.XSPI support multiple independent execution environments
> > (EENVs) for HW virtualization with some limitations. Each EENV has its
> > own interrupt and its own set of programming registers that exists in
> > a specific offset range in the XSPI memory map.
> > The main environment (EENV0) address space contains all of the
> > registers for controlling EENV0 plus all of the general XSPI control
> > and programming registers. The register mnemonics for the user
> > environments (EENV1 to EENV4) have "_SUB_n" appended to the mnemonic
> > for the corresponding main-environment register.
>=20
> Nit: please wrap at 75 char if need respin patch.

Okay.

>=20
> >
> > Current driver based on EENV0, which means system already give
> > EENV0 right to linux.
> >
> ...
> > +	/* Wait for the CLR_RXF clear */
> > +	ret =3D readl_poll_timeout(base + XSPI_MCR, reg,
> > +			      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
> > +	WARN_ON(ret);
> > +}
> > +
> > +static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct
> > +spi_mem_op *op) {
> > +	void __iomem *base =3D xspi->iobase;
> > +	int watermark, err =3D 0;
> > +	u32 reg, len;
> > +
> > +	len =3D op->data.nbytes;
> > +	if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
> > +		/* Clear the TX FIFO. */
> > +		reg =3D readl(base + XSPI_MCR);
> > +		reg |=3D XSPI_MCR_CLR_TXF;
> > +		writel(reg, base + XSPI_MCR);
> > +		/* Wait for the CLR_TXF clear */
> > +		err =3D readl_poll_timeout(base + XSPI_MCR, reg,
> > +				      !(reg & XSPI_MCR_CLR_TXF), 1, POLL_TOUT_US);
> > +		WARN_ON(err);
>=20
> Is it enough by just print a warning? If timeout happen, is it to continu=
e below
> operation? and other void helper function (such as above WARN_ON(ret);)
>=20
> If clean FIFO fail, suppose garbage data still is in FIFO. It think it sh=
ould return err
> to user space to indicate op failure.

Return err seems safer, let me check whether other places also.

>=20
> Or are you sure our hardware can tolerant this error.
>=20
> > +		/* Cover the no 4bytes alignment data length */
> > +		watermark =3D (xspi->devtype_data->txfifo - ALIGN(op->data.nbytes, 4=
))
> / 4 + 1;
> > +		reg =3D FIELD_PREP(XSPI_TBCT_WMRK_MASK, watermark);
> > +		writel(reg, base + XSPI_TBCT);
> > +		/*
> > +		 * According to the RM, for TBDR register, a write transaction on th=
e
> > +		 * flash memory with data size of less than 32 bits leads to the
> removal
> > +		 * of one data entry from the TX buffer. The valid bits are used and
> the
> > +		 * rest of the bits are discarded.
> > +		 * But for data size large than 32 bits, according to test, for no 4=
bytes
> > +		 * alignment data, the last 1~3 bytes will lost, because TX buffer u=
se
> > +		 * 4 bytes entries.
> > +		 * So here adjust the transfer data length to make it 4bytes
> alignment.
> > +		 * then will meet the upper watermark setting, trigger the 4bytes
> entries
> > +		 * pop out.
> > +		 * Will use extra 0xff to append, refer to nxp_xspi_fill_txfifo().
> > +		 */
> > +		if (len > 4)
> > +			len =3D ALIGN(op->data.nbytes, 4);
> > +
> > +	} else if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> > +		/* Invalid RXFIFO first */
> > +		reg =3D readl(base + XSPI_MCR);
> > +		reg |=3D XSPI_MCR_CLR_RXF;
> > +		writel(reg, base + XSPI_MCR);
> > +		/* Wait for the CLR_RXF clear */
> > +		err =3D readl_poll_timeout(base + XSPI_MCR, reg,
> > +				      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
> > +		WARN_ON(err);
> > +		reg =3D FIELD_PREP(XSPI_RBCT_WMRK_MASK, 31);
> > +		writel(reg, base + XSPI_RBCT);
> > +	}
> > +
> > +	init_completion(&xspi->c);
> > +
> > +	/* Config the data address */
> > +	writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
> > +
> > +	/* Config the data size and lut id, trigger the transfer */
> > +	reg =3D FIELD_PREP(XSPI_SFP_TG_IPCR_SEQID_MASK, XSPI_SEQID_LUT) |
> > +	      FIELD_PREP(XSPI_SFP_TG_IPCR_IDATSZ_MASK, len);
> > +	writel(reg, base + XSPI_SFP_TG_IPCR);
> > +
> > +	if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_OUT)
> > +		nxp_xspi_fill_txfifo(xspi, op);
> > +
> > +	/* Wait for the interrupt. */
> > +	if (!wait_for_completion_timeout(&xspi->c, msecs_to_jiffies(1000)))
> > +		err =3D -ETIMEDOUT;
> > +
> > +	/* Invoke IP data read, if request is of data read. */
> > +	if (!err && op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
> > +		nxp_xspi_read_rxfifo(xspi, op);
> > +
> > +	return err;
> > +}
> ...
> > +static int nxp_xspi_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct spi_controller *ctlr;
> > +	struct nxp_xspi *xspi;
> > +	struct resource *res;
> > +	int ret, irq;
> > +
> > +	ctlr =3D devm_spi_alloc_host(dev, sizeof(*xspi));
> > +	if (!ctlr)
> > +		return -ENOMEM;
> > +
> > +	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> > +			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
> > +
> > +	xspi =3D spi_controller_get_devdata(ctlr);
> > +	xspi->dev =3D dev;
> > +	xspi->devtype_data =3D device_get_match_data(dev);
> > +	if (!xspi->devtype_data)
> > +		return -ENODEV;
> > +
> > +	platform_set_drvdata(pdev, xspi);
> > +
> > +	/* Find the resources - configuration register address space */
> > +	xspi->iobase =3D devm_platform_ioremap_resource_byname(pdev, "base");
> > +	if (IS_ERR(xspi->iobase))
> > +		return PTR_ERR(xspi->iobase);
> > +
> > +	/* Find the resources - controller memory mapped space */
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
> > +	if (!res)
> > +		return -ENODEV;
> > +
> > +	/* Assign memory mapped starting address and mapped size. */
> > +	xspi->memmap_phy =3D res->start;
> > +	xspi->memmap_phy_size =3D resource_size(res);
> > +
> > +	/* Find the clocks */
> > +	xspi->clk =3D devm_clk_get(dev, "per");
> > +	if (IS_ERR(xspi->clk))
> > +		return PTR_ERR(xspi->clk);
> > +
> > +	/* Find the irq */
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq,  "Failed to get irq source");
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > +	devm_pm_runtime_enable(dev);
>=20
> need check return value here.

Okay.

Regards
Haibo Chen
>=20
> Frank
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable clock");
> > +
> > +	/* Clear potential interrupt by write xspi errstat */
> > +	writel(0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
> > +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> > +
> > +	nxp_xspi_default_setup(xspi);
> > +
> > +	ret =3D devm_request_irq(dev, irq,
> > +			nxp_xspi_irq_handler, 0, pdev->name, xspi);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to request irq");
> > +
> > +	ret =3D devm_mutex_init(dev, &xspi->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ctlr->bus_num =3D -1;
> > +	ctlr->num_chipselect =3D NXP_XSPI_MAX_CHIPSELECT;
> > +	ctlr->mem_ops =3D &nxp_xspi_mem_ops;
> > +	ctlr->mem_caps =3D &nxp_xspi_mem_caps;
> > +	ctlr->dev.of_node =3D dev->of_node;
> > +
> > +	return devm_spi_register_controller(dev, ctlr); }
> > +
> ...
> > +MODULE_DESCRIPTION("NXP xSPI Controller Driver");
> MODULE_AUTHOR("NXP
> > +Semiconductor"); MODULE_AUTHOR("Haibo Chen
> <haibo.chen@nxp.com>");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.34.1
> >

