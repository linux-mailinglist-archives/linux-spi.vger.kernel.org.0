Return-Path: <linux-spi+bounces-10867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93292C13D43
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 10:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D34207D1
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820835B124;
	Tue, 28 Oct 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ekoy10I9"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB70145B16;
	Tue, 28 Oct 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643749; cv=fail; b=mS+eSddYiPqYknsaGivW/Apvbr5sk4GCFrkJdIrbbhQABrdILPg2ZGfWF7AX0zfVfBxl3giRor0qMvu/Ik72OBAExBiPlNPPr6BhXrH0kOwZEhU+9xVxfu58aBEO5GvPD6W5+THhYZwEV30Iu1Pe3pHpfMShcW29h1TmwXCsTXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643749; c=relaxed/simple;
	bh=3lYHu/uM+kXO5nKTnqfz88M//dmEeYpbMSPvN2TwTdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YahQikSEuHaknKn0rTmdmOIblDImqbNX/hPh7HJocHjD7zHzoi3elfXKCxJ4csUesUO6hE5EMaI3xT5gnmxhmJGggU09L65NP7DWkdmiCf598+a9RZx6yM+lM9/3bH/dFM6oKEhGR2olCg+L26wpMv77GVeb8MZF2IJZhm/Fzvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ekoy10I9; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRXMVWGZTUHSGYdBUBEIKCv7hxoeGjkZKNO1arw3L/TiNVtRevnhOl2MOaesU9ziQXIk2WonO6/X67Ywlfo9Ypt2VjEZO80pv7gELUySbj8EPd5730nC5lh7fsEfHS8eGk5wcORkJXAi05mob5NdngaKLOZGlXnXq0mh8zWqOeXy0uNWE4gNak8lk0qCqhZuUyc/r9UE2Vg0OatKA4LF68gQAEAzkgKjAft9ffGLlp32S1ujQTv2Itd+TxOPKWZEApF7esHg7PgleytSJj7UgGUCGUqslk30g+B9lDtZaAzZ08jFKEl6b955JPhLRKSTBSndvYMxL/eYu8N5avBiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFW3cUgafNEFvdYzmDiDIjXyhlp1ejlEMqSb1hEr/yw=;
 b=o5qXHR9ZTDnOCUhgNO270MlrlhwXjWpALRYdSBsM17Dfv3Rcpd9+SZGm2RJll9U0cY3kggUxu2tn3dea7fS/AcDC5sbU1U6UsVFT/i8YP0/GHQsX3f27Q1jbHvBDu1ClaEeRmWtm3Gwl81xdmXaVttogBvk/QxvvQKqIe1aPN4xtFnzmnaEoUuveSmIaoyEo9IWJRnkYcRL0Mtj0aMJdA/ZeH4m+X6B6Iwc+3vwsAQaqUAIcos/uUXk70H5y0qSekcCIo3VkH78SY64gGscE+MTfZgvv6nfQqsAMN5jFOaKytCHEF+luLOWujKuysAfA/4D3PzRfzGjCGBNdQBw9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFW3cUgafNEFvdYzmDiDIjXyhlp1ejlEMqSb1hEr/yw=;
 b=Ekoy10I9XLDue3CAyLeQ7kjPd0UrUqsps0bp9wTtPiDtvbBUYVP/2X1C1N9pC9eSNIBJsmpiOvEXDSf1R4aI/tG9zG37eYqdRtLJ6DG/mfdoFal146ZnoRJJvNwvWvUEth7So9zZ+hlAMtKSYBFdFY6qJCwx6Dx9gxQQcWxvAVbiyFexPN6sb8XQtafHb2n3LJBR/vM+4VgkO8SP5/tjA2dGjpJa+e7l5QEktUx5t/anxPODOhaz96vWqSKC3+wpZrsPhf4TFP86zvjCDfDs7L+85vhQ1n72Ym1o9JW2jKmSt8JYZCq0dJporETftyYrRdAL4gbcuAMfcfdhR7wKeg==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA1PR04MB10603.eurprd04.prod.outlook.com
 (2603:10a6:102:484::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:29:02 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:29:02 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "mkl@pengutronix.de" <mkl@pengutronix.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Thread-Topic: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Thread-Index: AQHcRNm/zRpEV+zYiU25ok3CqsF1ObTRSXUAgAP4xlCAARklAIAAxsaw
Date: Tue, 28 Oct 2025 09:29:02 +0000
Message-ID:
 <VI2PR04MB1114746F42268876E27C1B93FE8FDA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251024113107.513604-1-carlos.song@nxp.com>
 <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
 <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <aP++6ghId1LvQ1NF@lizhi-Precision-Tower-5810>
In-Reply-To: <aP++6ghId1LvQ1NF@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PA1PR04MB10603:EE_
x-ms-office365-filtering-correlation-id: ec1bbcd2-d939-4e32-1c5d-08de16046e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WD6pVaHl8/xpx9Bq//QO46GIIszTssfRByV1v30wAyTTCDW8E5s+Lp8bjuYM?=
 =?us-ascii?Q?DPY+tqDzx9bzFWZUVfRUWFXXNiGXaLCa5qqN+NiOshPITTPZwnDL0WStuStS?=
 =?us-ascii?Q?XftaqQzYAO4xVAiBg1HO8aAZqXZhs/MIWLshDAbpjZZnEUAguQfxB/aJKoz+?=
 =?us-ascii?Q?Qzg4TMlqkfRc2UQC3DAC5v2CiCdSBXfsm5MhtKbVXxXPFP2Chwhi8+BQgBxT?=
 =?us-ascii?Q?avXGBCIgqNkxWtysxSLk1bl5m/Ua5v6VVIYQkk//FQ7I+6NOmt5/mo0ARh4Y?=
 =?us-ascii?Q?8kpwj9bCsoaaX1km48pQ2ZKN1uakwVQWsvCHzg+qTJufP8vntFcDBbn3aYRA?=
 =?us-ascii?Q?3GNbwY6PvVfZUqP69nx097ZXhrdRpLd7iV4UlWUWOmRV9kYe8zpefyVMno0b?=
 =?us-ascii?Q?OfERx8E6992sPiNUoKSpd2CdILQqTMWDSFVaFOO6r2jKUfDciJdgZC0Wf38O?=
 =?us-ascii?Q?ED29u9dKFNXYUEywRZCdoHkwNhdoWlAMrFs4nSicI2Q2rbYEAFjPVgMRdsOL?=
 =?us-ascii?Q?NeJRgLo7MaAVCek0N42NkbfioZVcmtEQsp1HOxzCPnWoEA+NISqoCL0Z8GKa?=
 =?us-ascii?Q?yjM9ebMXMuNd9p3jQMof9bEfglJS4DwDS7ti5bAODaCsX0+rQ+QmA2TolGHi?=
 =?us-ascii?Q?3+aD0aRorQcakLiNaiRNVNPrUKrHHoXquKgb5+r+8EprrSf/pja5b2yle1jR?=
 =?us-ascii?Q?B9co1S/r2PmSoAZ2mF63mK4xYgSQahdTf2v0GvoqJ00V0dtDx2K8VejkJppp?=
 =?us-ascii?Q?PcpDOkPvruTnMYImLjcF1mgtcQyeiEu2CevZaozcXgAd1d3VmHibIbJCfM8D?=
 =?us-ascii?Q?L1gsAu1bLOa+daI+I9aQ229AifTJRDJv43wf7Vc8c3R0Q32Kdj0nRnxsP6rZ?=
 =?us-ascii?Q?d50gQ0VUwUJjf/+Yi8qOpoGv1ATi6BGeKDykRP7qzC1yU4fhkTkfVGIRQ9ni?=
 =?us-ascii?Q?maDS4aXHq7oFCkN1iR171udYc9SZ6rJ2ROzmxQzFeHjSjjMVjcxkPxp96Sqv?=
 =?us-ascii?Q?Qfa8Lztlj6Gu/HyCKdVhIstXeP2B6QWXSYw8JI1qLbRVfubxLSCt4QKXWKxi?=
 =?us-ascii?Q?mo+6w47GWR0cZ8qP2UBbPaZ7e60SXOxNFfCfYJw9+6dTnr+A/w1OVWMH+MlE?=
 =?us-ascii?Q?/HVF4p/S4RXmXICl7gvoiOucpQTJBdxHQL+ZVgoCc+PMOMkQMub2BtFEVRKF?=
 =?us-ascii?Q?EwrX0/qFp1OTf7Lmyro+fPOCpb6cDiHvy74q+aUhfI433DCNH62iPh9Z2gsm?=
 =?us-ascii?Q?CAfgzxoQ+aueHkkCdlMb8yxvDrBM4jeMVBut+mJKGUG6saGLZj1zXvBnmP9i?=
 =?us-ascii?Q?h/O64T+UJfpKefLHWJPBZWLJ0ZaFQv1FxOsnIlHQ4gUp9b9pANXCDvABNiXd?=
 =?us-ascii?Q?Pl9spyJNppHel5s3zVnVYnxAmGzqig7vlADXlPE812XanWlkle+0hLaouqiJ?=
 =?us-ascii?Q?W2cDvULQrhX3jrwKbaV01hJvvdzZGWnSf0coQaIyGDB4OPrzyqgIqLjRhekj?=
 =?us-ascii?Q?lAsWDiwM66mhtLXdQqkYBPMQE73xbWxAxksi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7OjTTyQnFWp2uEHy/c+U4bWCkfsjl0gGTlW+jSRQhgJcgEt3SuRLyljugzcF?=
 =?us-ascii?Q?FLSI+9cFIqw50bT50g+e32VkmwZ37V3JdQx+A2dDd8wUAk/kLdblbIZUwc+8?=
 =?us-ascii?Q?bgLqYF57+RHw7KODLwoYqFYZ7BP0iybeGMJAbqGMZve7bBHOcuxt4eBhnif3?=
 =?us-ascii?Q?KZoCRrvcNGscYyFkjacmwBPXjklNoNaNPvFzgH5ouQuTcWF5ryDmvDKLl0Ai?=
 =?us-ascii?Q?pO0LJ7/+sMNTUNklhKQwBnhxc9A2U7GKeFIzuanxjQzcxEgG5A+7w8U02+Xw?=
 =?us-ascii?Q?c9yKoPNE0jv1EyxXXFfNuE5nRG6XajVStgTOiVAdtGbIgaBriDxyXJ961NE6?=
 =?us-ascii?Q?5iKsV6UKlhi/LlkwZhNM7u5ctXQOKNjM38dhdkdmnMY15Sa9iGG+O8j+qquN?=
 =?us-ascii?Q?4xZmKfC3/e7Y575TKXmmX6wkHN6t/qVBU0bdMk4DmqecHG3XKEIfBLulfNlJ?=
 =?us-ascii?Q?s0wfzeOASDWgfQaZJtT6K6MPF85wClgo1IPZN91QqN54X0rzYYrrDOr2vOQ/?=
 =?us-ascii?Q?2Hv8hUAshtm0wqkfq/bnFSzcm5tODV0fR1ePFlTdmqa9DL6EQMHRBOxoYWV+?=
 =?us-ascii?Q?bcDVClqoXH6qUWer1dMK3TqnekNT7RBZReatDiRJ9Q+kjq7r2dssdAeu1uXF?=
 =?us-ascii?Q?i0EyKRl5AOMI8kUmN3fV9zyxNtiI+qwy1QaFABoojvkdC0hLfDMjPqgB7mZn?=
 =?us-ascii?Q?QeIELhAlyIIkdDn6NPWn19BlJpHbJH4RPR1MOMgeSCHop54HPzxka0ZfRzl+?=
 =?us-ascii?Q?C3AO6pNUwDxTmDbTaTClsUQUXMN5WtDyDguyycC7v8pe0eIAg9FitY3Uojeg?=
 =?us-ascii?Q?5+dIVkJ6zkrzJAiKx8PYCXHmAdIvkPDkg/JCyctdzqKhXOb041U6hCGJ3aQ8?=
 =?us-ascii?Q?1Brei0D597Dw9oSab3ceYwqqLXYDEqrFokuN+Bc65X9iM7a+ytUPkDnqUzl6?=
 =?us-ascii?Q?Q7Dy13LhbmcsRwzp4nB2qJjTl/NLe49fwPJcRA2GSC8eOAoJKXn33PEVRj+u?=
 =?us-ascii?Q?cnzfsvx84Y63FC+RtYa/TnnBeaQA+cqZbM7aGEhcG9hGc3pKQVbuSGp0cAdt?=
 =?us-ascii?Q?k6xJ76UoOixE+ICP09mCRsuKzXWAPV9drYmr8IxQVSgf0rfvCoUH66HlMIDF?=
 =?us-ascii?Q?b4YmUKHzbRfUue48yehPflHpFw/557mBAyD97KphG4UGfBra5FxJUOUomUC9?=
 =?us-ascii?Q?hhx+bDp4w9+MpBbGin3bX3yWXgOdU6DYqJP8yQ4BHe6CJmUGAPQOuOCCiet8?=
 =?us-ascii?Q?a4M31DQWSlgjG2GDG3JJBxvfGlUd3e1E2tj+32p/K0US1IFvnUBXba+btwli?=
 =?us-ascii?Q?x8fUFur6AccrGHW03XE4dB5k5qwm97VgOs3uV8eGFrWyyLRxJkV23+k3/zMI?=
 =?us-ascii?Q?Q98JV7CAiYTlfQ1z7Vhk2kSoqvbpjHa0/3eAP5vHUzagu7U+ECPbqFPfMDPz?=
 =?us-ascii?Q?jeWpguPNiN8cyfKrgfLwmOOSa4891dABETStqaPZ1U6mmkHvD1tdV8zzZA0O?=
 =?us-ascii?Q?vx6tM0wx0nY2Tz4dGd6G3N8LhCLvX1uJQn1FD4DecanbJrMri0lCdNcyctsE?=
 =?us-ascii?Q?20rtmbrCJ3PzMnQk/mCVC3cVmf2BvhH2XhC+Mt1Z?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1bbcd2-d939-4e32-1c5d-08de16046e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:29:02.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUgc2gSetQUuvDkGXRCCuIwc4EEhNQag4gAnkZx6t6nIG6x5Dvb1HKPnTCMGOFVwxcnQfMdCiYl5e4kEj7MWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Tuesday, October 28, 2025 2:50 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-spi@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for tar=
get
> mode
>=20
> On Mon, Oct 27, 2025 at 03:39:36AM +0000, Carlos Song wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Friday, October 24, 2025 9:25 PM
> > > To: Carlos Song <carlos.song@nxp.com>
> > > Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > linux-spi@vger.kernel.org; imx@lists.linux.dev;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support
> > > for target mode
> > >
> > > On Fri, Oct 24, 2025 at 07:31:07PM +0800, carlos.song@nxp.com wrote:
> > > > From: Carlos Song <carlos.song@nxp.com>
> > > >
> > > > Now for ECSPI only support 8 bits per word in target mode.
> > > > Enable 16/32 bits per word support for spi-imx target mode.
> > > >
> > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > > ---
> > > >  drivers/spi/spi-imx.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > > 155ddeb8fcd4..017f83f5dfdf 100644
> > > > --- a/drivers/spi/spi-imx.c
> > > > +++ b/drivers/spi/spi-imx.c
> > > > @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct
> > > > spi_imx_data *spi_imx)
> > > >
> > > >  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)  {
> > > > -	u32 val =3D ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> > > > +	u32 val =3D readl(spi_imx->base + MXC_CSPIRXDATA);
> > > >
> > > > +	if (spi_imx->bits_per_word <=3D 8)
> > > > +		swab32s(&val);
> > > > +	else if (spi_imx->bits_per_word <=3D 16)
> > > > +		swahw32s(&val);
> > >
> > > Needn't swap when bits_per_word > 24, like 32? or our hardware max
> > > support to 16?
> > >
> > > Frank
> >
> > I think we don't need. We are reading/writing FIFO by 32-bits word. In
> > this case, we just need keep the default byte order.
> >
> > Is it more reasonable only support bits per word=3D8/16/32 for target m=
ode?
> > -b 8/16/32 can cover most use case.
>=20
> yes, I only can't understand why needn't swap at 32bits workds, but other
> needs.
>=20
> FIFO 31..24  23..16  15..8  7..0
>       B0      B1     B2      B3
>=20
> next you
>=20
> in memory val is
>=20
> 0x0: B3
> 0x1: B2
> 0x2: B1
> 0x3: B0
>=20
> swab32s() to  bits_per_work 8
>=20
> 0x0: B0
> 0x1: B1
> 0x2: B2
> 0x3: B3
>=20
> if bits per_word 16
>=20
> val
>=20
> 0x0: X
> 0x1: X
> 0x2: B1
> 0x3: B0
>=20
> after swahw32s change to
>=20
> 0x0: B1
> 0x1: B0
> 0x2: x
> 0x3: x
>=20
> B0 and B1 still be swapped.
>=20
> Does SPI defined term word fixed big-endian?
>=20
> Frank
>=20

No, SPI doesn't define this. This swap is caused by the SPI-IMX FIFO design=
.
SPI-IMX FIFO is fixed little-endian.

One example to easy understand:

If buf is:

0XB0B1B2B3

So data in TXFIFO is:
FIFO 31..24  23..16  15..8  7..0
  B0        B1		B2   B3

So we can always see data on SPI bus:
0xB3B2B1B0

For this patch:
bits per word=3D 8: it means one byte is one word, so it should not effect =
by big endian or little endian, so every bytes should keep the same order b=
etween memory and SPI bus.
We write FIFO by 32 bits word, So we should swap every bytes in this word f=
rom 0XB0B1B2B3 to 0XB3B2B1B0

Data in TXFIFO is
FIFO 31..24  23..16  15..8  7..0
  B3        B2		B1  B0
Then we can see data on SPI bus is
0XB0B1B2B3

For bits per word =3D 16, it means two bytes in one word, so every 2 bytes =
is one word, the word should be a little endian word,

so we should swap half word from
0XB0B1B2B3 to 0XB2B3B0B1

Then data in TXFIFO is:
FIFO 31..24  23..16  15..8  7..0
  B2        B3		B0  B1
Then we can see data on SPI bus is
0XB1B0B3B2

For bis per word =3D32, it means for bytes in one word, so every 4 bytes is=
 one word. The whole word is a little endian.
So we keep the default order.
0XB0B1B2B3

FIFO 31..24  23..16  15..8  7..0
  B0        B1		B2  B3

So we can see the data on bus is:
0xB3B2B1B0

The RX handle is the same with TX. From bus to FIFO is a little word, so sw=
ap in memory.

Carlos

> > Carlos
> > > >  	if (spi_imx->rx_buf) {
> > > >  		int n_bytes =3D spi_imx->target_burst % sizeof(val);
> > > >
> > > > @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct
> > > spi_imx_data *spi_imx)
> > > >  	if (spi_imx->tx_buf) {
> > > >  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
> > > >  		       spi_imx->tx_buf, n_bytes);
> > > > +		if (spi_imx->bits_per_word <=3D 8)
> > > > +			swab32s(&val);
> > > > +		else if (spi_imx->bits_per_word <=3D 16)
> > > > +			swahw32s(&val);
> > > >  		spi_imx->tx_buf +=3D n_bytes;
> > > >  	}
> > > >
> > > >  	spi_imx->count -=3D n_bytes;
> > > >
> > > > -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> > > > +	writel(val, spi_imx->base + MXC_CSPITXDATA);
> > > >  }
> > > >
> > > >  /* MX51 eCSPI */
> > > > --
> > > > 2.34.1
> > > >

