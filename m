Return-Path: <linux-spi+bounces-5144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A49942F4
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE821B257FB
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1917C992;
	Tue,  8 Oct 2024 08:43:57 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2116.outbound.protection.outlook.com [40.107.222.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5017C215;
	Tue,  8 Oct 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377037; cv=fail; b=RbsHSM4xDTUlsjoAfgJJAAa7U3KDdhoutsnUVLksJRRbQj+DwLuULr+MOCvmoCr2WsWW+bSVF4fwSw0Ul/JFqQvqGKGBCk6cqytw6hpxguR5KA+Dt0n94hp69r4CzZAqyi6EyyEbFCmS2rH6dygWdbvITcBuZKDrDnjfdfqCWjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377037; c=relaxed/simple;
	bh=x5dK7lx1jvXGOVwr5e7gczTJEfbq0hDBCCfOLGQVMrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyeyuOJMNZYRaSppt8jSD3f5+boE3aUnDBdfVmKZ6BEcoTliGrZdndA4bBnl6g1a9glKkSHryMT02S8iimZMUR+SAhR+50bIb74SdD5euuDl/ZAxxNnoZtHOPHxOOak0FvuhmjL0bchpBNm4g9gr09uBhuW5j0SxtEoeDFBThKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG1yWu+c39yTf8RPbdfznarmZTKv/s1xDkzCFXcttcOp/o/Ld7M50NSBXslckNgQuSmSlByje442dwqOz3qrVPSI1b2jpZt5pcQS+FQ4qzN2+c9bIJSR82gSS4AWdxc8UMCMKjETTS50GvOhTU69xzsFYSMUMSSXL3jxerAdZd3DCmPnqdz7gjdNpLevpjlFCJxQTEPB6uQTLnHu2qT6Lm1PAxm1DagQQxVQtnRt4w+5DH9gvQTkJSwHLW0IC3NUmgwYTJnCGdFBNtug2OKNlUY7gAYBZz5ynUSFtoRKURe9hCDZ5y5fRlSCBC8lsiCiIaPkR1cwSWLkvqEGs7V2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5dK7lx1jvXGOVwr5e7gczTJEfbq0hDBCCfOLGQVMrk=;
 b=e2txr7/5moGodVoMRki+NQ6Xw0UwoauHk4epb65mQd//XnPdstG8YaVbrclXXDmso4m3WJLuwJJJfPHLPC9WBK4iXj5SlHayPLgq+wSboOkJPhr1yRfmSr/IBttY+tzyeNmggfC62WAjGQuPnB/fTeW6KX6mEYISvzuAqjh2In0HLsUlLLdObEyEtQ/gCJSSPNKZ+3/1u3vRq+MNCoTSespd3q5+vwcr5b+gkfKDv4Q/YUhI7PK5nnB4kbt9KWkfDHD6BUvfKYCxS2mPoAnXQqEdIKCyqmkFovwtHT0TR1FPm1pw8xBQH93kaLDg0yoQTSsl61CGVC7uHR2otBtZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB2133.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 08:43:51 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:43:51 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "frank.li@nxp.com" <frank.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: Fix Sparse warnings
Thread-Topic: Fix Sparse warnings
Thread-Index: AQHbGUbs7xqnEpD5EUOFWr2jkK33zrJ8Y0oAgAAjQCE=
Date: Tue, 8 Oct 2024 08:43:51 +0000
Message-ID:
 <PN0P287MB2843E06597DD5D64BE93A8A7FF7E2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
 <20241008-impossible-mysterious-salmon-e1b8bd-mkl@pengutronix.de>
In-Reply-To: <20241008-impossible-mysterious-salmon-e1b8bd-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|MA0P287MB2133:EE_
x-ms-office365-filtering-correlation-id: 787638f0-4dd9-4607-4968-08dce77555bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?58fLlxmj53pxGoLTnUYhfOvvsLaObH9MmWftGsCTId2mDe4UEjkaftQ1?=
 =?Windows-1252?Q?mJWUHAB0i/YVxmWPdd6kGbHMAFNsqCfOgP1k8iB1fqIU7tmRCBUw/iCf?=
 =?Windows-1252?Q?7nKZzLobAslB4xykPUYztwWIsvR5eV4yqIjyPUoqmIgH4rrqLFd3N4X2?=
 =?Windows-1252?Q?qkZSuYGop6GHfbE/rMw+/4ReRN8xsoVoXrSl/3Wkk0FpfYt4LejbRopN?=
 =?Windows-1252?Q?jqg+4QCi8VetWNusnChmYFxx+TRHmc2VRYjMcWIdu0lPd2cx1vdwFb1V?=
 =?Windows-1252?Q?10GVCyqXYAN96QhUm05homU8i3rxGsrCf/KZ46wvrcQ717w3xLasEWqm?=
 =?Windows-1252?Q?C7kPKf5J2pBYtjg7VMBqiNmwBbVosw9HnY6f58MJURVi4TZ+wF8Upc+f?=
 =?Windows-1252?Q?dLEzv+TpWp4dZtyckyy/FeaGXHJphDcCWkCxqTsqey/jaygOr7NX/sBK?=
 =?Windows-1252?Q?WIQkffnmZUy+NdQtbMuxKxPujuAdTcP19cGW/Ynhlxw9CV1mZ5q0Qj67?=
 =?Windows-1252?Q?Gu2OWE9BFZHuavw9X9qJGQLY8xOtlWtdSovwk6S7CHkQCTfNztmrTHvN?=
 =?Windows-1252?Q?+goyc104b93qXd/Q7Xzj00bd7L81Hqb7J/oQFgn5JG6NsOd1/B9K84xI?=
 =?Windows-1252?Q?Gin+GLs/xV9sStEX7jXLkzbno9GpnADbMN5qMr9B160APykI+tri2MHv?=
 =?Windows-1252?Q?kZwZSZiZccMXuvcK0lUNXubpGDx5I8D8R/SzDMcWVLuehI+0H01vkjQC?=
 =?Windows-1252?Q?JRkGHDqJZ4Y6sxpGtv9hZg+r2n4eCuOvgQd5CNn+kh8OlNG6SlNvyGnP?=
 =?Windows-1252?Q?nCLnwVZ8Dzss0L7NKd1NKgStSk9okr0bZgWZ/elWk8GtYwu+0gVsqgg8?=
 =?Windows-1252?Q?QP2RACJt85f5DFoxNfax+69JCZPIr6SFea549dylXOXBcR9VOM9e6+DY?=
 =?Windows-1252?Q?guYFPgkowda6jBx61fdRfVVbCip3wFe7dWKMMyVqAGPdkOxYa2BsZ6gr?=
 =?Windows-1252?Q?B0D9WitCmeD7LliLpKLF/f3oC+CCgn76Jl6W7YLAkUcacAL2/x6EiHvw?=
 =?Windows-1252?Q?KxpkOtN3Ukreekpdtq23atkbjYgGpyi/t4PVbwVgXqQYP8Qzi4Ls6pc1?=
 =?Windows-1252?Q?tW5kv0V+W55Hhxuyhm8r4THBhwzfI/IqaUypFIc2T5jMkSgtLg9wpBVT?=
 =?Windows-1252?Q?ytirnBLVz5owvAKC7ugcBgc/pgLzuWtBB9k5VcsMfoQhs9zvEApZQhXD?=
 =?Windows-1252?Q?8mnvEIIb64dSwA5H4qfp4j2VlNGQyKDipo91lU+1u1jWQXUaKoI47vK/?=
 =?Windows-1252?Q?9RcsXzeXcmmymB2I0uf9xkPDf8vZWVMs8ghtxM/kYMq9sQUOJTNdRpgU?=
 =?Windows-1252?Q?/4kaZaWgbgMMCw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?hkWPdE+LrQNK0V+RR+dAVpoENlkaP4hOZQLrzN9sscR00AfhNh9YnjO7?=
 =?Windows-1252?Q?COYqajfGGOQsLlNnk7+omtQiHpXmb4E9xIKw2qfwyLzuz0/HKtt05zyk?=
 =?Windows-1252?Q?MlplipxQdLXO89wk83YpPYWsEKQVF6twdlWjY0SqEdgOL//cnkx55gcG?=
 =?Windows-1252?Q?OYTI2LmmU2D3cFhOI+FhGx6nmQUmEMLsNJI0TCG53UtZnt4fYcZ6JCuY?=
 =?Windows-1252?Q?Q2bjSEJEkhAvnMobzbizBGwQIHlSAMnwqer5cZPP61QB80T6XUHi1mOW?=
 =?Windows-1252?Q?lG5BZL4SeHc5kBJarV4x9IAFpvKCBkQXIrnY6epSBsky8eSFX8O4lQfV?=
 =?Windows-1252?Q?BWhWhMzTEerGpyLYQurmz25lWHtfsbdHawJSffvUmDTaJKO0dxS11b91?=
 =?Windows-1252?Q?/xv0qTWwxCEAJzmTJ9JdanAnRbQ9Nbefc+DAaif4YQ35wPwRgSKixDP3?=
 =?Windows-1252?Q?1hCHI1f/cRJBiN6/7SFMVwXPBI4qLk5KrVVSfkmpqlpq8WbxI5vYomCo?=
 =?Windows-1252?Q?j3xcjAw8PVZ+u2CCiP4U2hpBcFVitJyZohmV3qCzlTt/f874rv1ptzYD?=
 =?Windows-1252?Q?Jd2pnPCc6cCx98BUmJFKulPRTe6uFgUIdj0G+Aki2aOOJE4W6bHd4MvA?=
 =?Windows-1252?Q?0mb7hTFC2keVFoMef84PSNnP5tRCqLPGhqQjLQume5itJCt7wq8A1JOc?=
 =?Windows-1252?Q?WImqaEtNF/713QhnNty5mZoVlDYs0OspbPn4CbKPjciKldJ4/VAQZ5gv?=
 =?Windows-1252?Q?yqZfbSNvWatdfOIUPsu6gHphdNteg6s2M7LCl5MSkEAYZaisHsHXYXpD?=
 =?Windows-1252?Q?396JyBOGyrVMgU6/LLdZfcr31QXA3brp0b1kQiP8DlsHrW/CIfiMZvuP?=
 =?Windows-1252?Q?5CiYcLrngrTXKYhePg3BJDm5GswoFiyjjuo51DR4JAftDa1SzrD4HV3Z?=
 =?Windows-1252?Q?0BJfqfm9HJDCehEWp4ZZ9QehV21eN8ZNs1nrnLosGLVuaxI90N5QEqPB?=
 =?Windows-1252?Q?UIwbtM+HjGYjMpeXDuuugW29GyMu4u6rCS6UHHmjdQgvNzmu+d0rifr8?=
 =?Windows-1252?Q?nNs8ods+92tNoFbf5ICDrWSWEz7tbBkvSh05KCL/7DHPxcQ41moq9yci?=
 =?Windows-1252?Q?FjXQYbuN1s4jxnO+Hlqdynq9AH98Nog2yydJZpzyDoqDVnujytbEKSqR?=
 =?Windows-1252?Q?9o2DB5a9SNiMHPbNopCToHZ941IUOiLvoWK0N2/ze/GL0hfLXDvmkUo4?=
 =?Windows-1252?Q?KEvuQhZAGcIIxnxxeR3Xbzhu000ItBGRJBFtHHShI5iyXac+UpS8T0Io?=
 =?Windows-1252?Q?OxfDDkwOcJqyA0Q+tZ/ThVUcrogLEMsyCm6nifCSPj+U5HdwtReMcfWL?=
 =?Windows-1252?Q?LYBJ+6peEMucvkxDGJmdSN8DfY+LK+Rid1C7V+YYV/0taZyN8+mcgHFt?=
 =?Windows-1252?Q?fGZo1qGkrQ9oxxXlCndFF+n/D1rUB6tTEmE+LMWIlvxe+V8fCboa2ZkE?=
 =?Windows-1252?Q?CturHG0gKO7eYjX4AWuPQUZyLakSxrNeARRHIB3LeCB9POnX4Fk7/7dv?=
 =?Windows-1252?Q?igwe8oPZ+S67081BKjVbj4zarHR3PLIGRPIVZe/cjY9xpt4uHvHPW/lo?=
 =?Windows-1252?Q?3bmMK2DGbyGl5NPTVuqtKuyBbmNMX8A6GVwNSdV6/OTFnYEHsGiWLT2I?=
 =?Windows-1252?Q?cj73uFbz49KymB4AvKPn+d/0d/i6ILpYa81kOH6dmvaOLOn8QeLZ7fsO?=
 =?Windows-1252?Q?jzqAoIxkoBh2bM9kA7Y=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 787638f0-4dd9-4607-4968-08dce77555bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 08:43:51.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FMFDg9JRp0I+cs9/vQA7dNjWKe3m4TUj06SjNu1Arq0DnZ2I7YiqXhvPwhOX3qeLHpTwH8J2jlRb7nBL7pJWnIlc51orQtPlsya59OM48Hp+UebnWNEDIPfwpPZ2Gpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2133

Hi=A0Marc,=0A=
=0A=
>> in patch 2/2:=0A=
>> =A0 =A0 =A0 =A0- Use ioread32be instead of readl=0A=
>> =A0 =A0 =A0 =A0- Use iowrite32be instead of writel=0A=
>>=0A=
>> Note: Drop 2 patches(patch 2/4 & 4/4) from the last version=0A=
>> link to v1: https://lore.kernel.org/linux-spi/20240927132944.19285-1-har=
devsinh.palaniya@siliconsignals.io/T/#t=0A=
>=0A=
>Have you checked the code on real hardware or compared the generated=0A=
>code on the asm level?=0A=
=0A=
it's just resolve casting warnings so....=0A=
=0A=
No, I haven=92t tested the code on real hardware.=0A=
=0A=
Are there alternative methods to verify it without using hardware?=0A=
=0A=
Best Regards,=0A=
Hardev=0A=

