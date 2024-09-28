Return-Path: <linux-spi+bounces-5020-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F2988DF5
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 08:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1253B1C20AAB
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DB4A08;
	Sat, 28 Sep 2024 06:12:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2118.outbound.protection.outlook.com [40.107.239.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E01534E9;
	Sat, 28 Sep 2024 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727503920; cv=fail; b=L+R7JWqbPzskuOUgkIF6WT+S1PQs8isp8QP7hnEMN/yY2lPfsj4wP3CCsdUgX3mX245j+B/+f2qzCVmSgdEV8dBS+fDTMxpjpRrX5DMT+rj8MzNCarM/BZiv/fMYNKdiYIeV3ZzEOu8GAm4xE5UII3vTenyzW3CsN1LX9C/63IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727503920; c=relaxed/simple;
	bh=q8g9arr9VrnCiHCXWVdRGwGR8grGlOLHmdqLk+dUMAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZAbRswMaeo9LT1c15grZJBiYr6OSvJD5xzXSQvUfubzEjOFEs+LCn2IDR3/2HnlKnA0/DXYOPenmJoUL/1mi27QRIx6YrXt9hnCEgsrDIxw3BcL3M9fgbhNiOmpvkQbOyR7DTxHdgOKdHkoe26R3eAEXVU5jw5v/0yNAV7N4mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIm6fU0rHmyafPpR5V9DCioJHkwc0gefYQwFHSyxHASsHH+VBrgcTLRnYHI2wSNDl9qv6tyyb9nCQMO0rsnijgcI76htNmK7Ga1gqNTYpvR960oNtpytHA1jGxQCxedm/On/k6fiswksj2ktCOjIZ2A5XoLdVuu28zy4vyRGZTlm/P7/xPLIDMvWDDEc0h6jPIJEJ7MxQOl2ZL/pQ1NFCEh79bW/SAK8aC3g77BDeZSWedLOudZbFhdi37ahMpzlfDUjSWqD40ZZp0BKeNyqn8HHuMZepiM/fEekgrbZe06QVzRKyADQagbjZedFRR7bsu0zkCXK6h7M0NB5LgElQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8g9arr9VrnCiHCXWVdRGwGR8grGlOLHmdqLk+dUMAU=;
 b=NYyYVrfWiZX01Zm4AShsLmwSLb/kOz21mTkCf6qpA1t1/aIAxl5M9DsWK8G9XcPRiW9cjCmAJmEcNz4dknCHczJEzzOFKKR86TKHnM3GGtUMsWiU8B10HPSxMFBRmFrYefSJb3AVBwJdHpFeOeaud14Iwh7cfiXQXWCLSOA/NvGZVgzYw5RjRUNkv8SoQOh/4lct8c893z1RPMnEWwO893wUEIQB/WipcScQZ1B7RC+fYzGF5r6XHfJu45xkV2WNnrYsLEOoGl0+SUzgbHhyocJoS3dTuGpcm85j4vKvKDAr3/e3uNtLxmFeJYN5UBoHb3TTG/63Kh6ES4MJgFH9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0906.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 06:11:54 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 06:11:54 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Frank Li <Frank.li@nxp.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, Han Xu <han.xu@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Thread-Topic: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Thread-Index: AQHbEOFn+QUYD6WjJUmrnOptnijwM7JrxWkAgADwQOU=
Date: Sat, 28 Sep 2024 06:11:54 +0000
Message-ID:
 <PN0P287MB28432411CBC8CAE2C443E74CFF742@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-2-hardevsinh.palaniya@siliconsignals.io>
 <ZvbR8OaXeg4SQc1i@lizhi-Precision-Tower-5810>
In-Reply-To: <ZvbR8OaXeg4SQc1i@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN2P287MB0906:EE_
x-ms-office365-filtering-correlation-id: db69af3c-c0d5-4a1b-8c01-08dcdf847362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?wt+LZGTs8b62wLNmXyF3ZKHumMXN83lYxjVFLyyF64Hg5ymMYucj+K/G?=
 =?Windows-1252?Q?bek4Ku5ZFGPjm/xVGva7XCA/z8t5/hwt19LZRyBUFCqpqNOCmoEUBAZK?=
 =?Windows-1252?Q?/tWC4TXl4pz2du/UuoH+6YqSS20HuFnv5mcDa0CdkI3lOoXNGkegykon?=
 =?Windows-1252?Q?19F1p7WYfXnEdFyqijSgrbWavFvMzQhOBNJF3PCSF72dhk6fPvNaaTXX?=
 =?Windows-1252?Q?ss97No98Km6CTKyGiu0szCUWDfy7gGUnd2+Yd1HkAgFOhIRS3zxbltgF?=
 =?Windows-1252?Q?phUNiJFS8/5ryM2qYgGvAVnvnG4H3j287vkGEHDk9c1SwzmzOkVKB6ov?=
 =?Windows-1252?Q?5/2UHJOBNzTInqOh40KNasQrZEHDe+aUGTki3kkw/M46mk2bDPfIgJhu?=
 =?Windows-1252?Q?33oozqTJFG3+tp/veu9DZa1MU3dDSMio+BQiF0xJ8nGDJIDOTJHtnRwK?=
 =?Windows-1252?Q?Qvj00d46QkLitqaqPi5J+ov+IOkQsoMTE/UfemnUZmUQxfcrzgK3a0WU?=
 =?Windows-1252?Q?goCuwyzjqr7dPv11JxW2tEoH6QGYNDg/tUh9D31hEUl8Z3inAzb0o18x?=
 =?Windows-1252?Q?98vk4eJdNDR67f+TjIQmNbRFFqqGnaPGbIfU1XczVjxm0osu1PIE4S8z?=
 =?Windows-1252?Q?PSHX2c03iN2ozQJKQNWLhsb7A4H5ET8Oh7L6tGxLvCZ3XoXkNj324KXk?=
 =?Windows-1252?Q?49oC4Kl8MIqHQ3Mil9YUgMMlVUCu3LL/y9WfUh5EcDbLTiAcyA0luwiW?=
 =?Windows-1252?Q?ac8MudgOJh/9/jd5YZwhPeyuNDPUu7JWrr5Mit3+mNvzNPGj9cFRiQjV?=
 =?Windows-1252?Q?WNuTF5HUlNjZoJPolp67jin61TufOasQfslxPMsOUzZb4jfi7nwRCjAB?=
 =?Windows-1252?Q?EJFuf+C9jq/mb5ZdH4Er30c6yq/xCFs18ZoVAb4MiFNIcfqhSVrggf+k?=
 =?Windows-1252?Q?oCHF/AwKeqYi5HZ3ldcFejdkyWlBvBn6l0WsN/Ks6kP1YfyXDwwPfRM7?=
 =?Windows-1252?Q?T/VIALdVTEJ9mWpabe6oqFbCqPESQa/s+VdfTkzBYZFXxOuHYzIE30wf?=
 =?Windows-1252?Q?Bjapu5HXNNL0161Az2k687ORKuVC0CkmTLN5UC5f+xpyFq9PFXBgZvgz?=
 =?Windows-1252?Q?AllHl5HLBVZv0kLY/dsvhgYxUfcHB5IyR0Rl+cgrYU2dkTQIJnupTMGd?=
 =?Windows-1252?Q?tU8CZwOZYHDj2WE0LzxO+IJqxdwk22GET1L5wCH8vDW9DACXMpVVQrZt?=
 =?Windows-1252?Q?N5tCN57gh5/V99olbs5M1xpkdTRKZVGLC6c+KYsoNynj3PjbCqpopMFq?=
 =?Windows-1252?Q?g58SONQP0FEEVPZ9FJ1+b19lIQPqOEPAxbTmdiParqCsYLQYRM6KL0/J?=
 =?Windows-1252?Q?hheWoMMuOTsny98qmz9EBxqqGQgy64ov6L/bSKYh4LRDS0mCF7YrjZuu?=
 =?Windows-1252?Q?FWzWmigUw+2Ezb8L3rNbMA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?//FUtbLB0S7JMGHiMs0bgnEBVE08llG4xNVYLCflTwQ1D0vmwD+Vlt4+?=
 =?Windows-1252?Q?kbbDRdVaK0jYLLUmgw5CRmK+C1OPoV/u26SQtfkxKLJjRXoiZ91ayHoA?=
 =?Windows-1252?Q?4m3Lbv8ywTwfTY/vV4T/p+4ibFoGLk+rOwZiY6/rY+c5X8VQc4w+bJ9L?=
 =?Windows-1252?Q?MZYx72FGleToGFXBSz1gQjMG7EnwUEFDjBz53+q0KqR+w5J4vG7uXCeR?=
 =?Windows-1252?Q?SlXmA5NUhog+rs8+dyFgOKJXv730yARjKwjOOjh8QgTY6zx9DqMZbUcN?=
 =?Windows-1252?Q?RuFUUdW3sUDSzIapFK1UFrwea0WqdwRgc0RTRvr+2FHQVEb39rM1MdFR?=
 =?Windows-1252?Q?pALFpP7G50E8xZralbqFO8s/chDZTOoX5c+SJwLG/VmylXC7HEK8hixD?=
 =?Windows-1252?Q?Wq+UFZpbKOtmcMZmhM1tGrRbpPO/MnkoJYH8X1WcTcAAq3Wag1+67Cem?=
 =?Windows-1252?Q?g60LdR/eJ8yvnCXm5Dad7e9Ye0Erc1cvpLEKaEQdryf4vWGJFqdOx60a?=
 =?Windows-1252?Q?I1B++chheFgUx2ChIRmgjDjIulAa0NPGnjSvIXmN59k2VzXfqoxHIVzc?=
 =?Windows-1252?Q?o8w9kxqmnUu1spSLMf79/JwfMQGuXEcbr+jjaMp4C6yRw7P1TxhdVKRt?=
 =?Windows-1252?Q?ey/BeEkJnnoQjNMx5FiCTsktv8XpC0rR01Ngd4XLXISkdzO5Lm2cCSx3?=
 =?Windows-1252?Q?R56r/lb1HGrUF/4vYNcx4jzDASke8rdx3nBeQawPd0+z1j3NTy+mRyhW?=
 =?Windows-1252?Q?Hz7HOmlll8kOZf8zw1g1S81YUZfqpHhhi295szm4kx8Vv2sju6RGg2EI?=
 =?Windows-1252?Q?U22xKa8j93uQuF5A5X9kH4LTfJAdl95K6FM4yK6n9Yq48+q8HlS58UY1?=
 =?Windows-1252?Q?29hnWlmB0365YAkJWcdlXtRp2tvn09NDEH9j0zSmadi00G7+z8srXwu7?=
 =?Windows-1252?Q?I8tvrpC3ii6O5G0Us9tCELnw3WgA/yR43QWWx/EqBkEjBn6ivIkPFSke?=
 =?Windows-1252?Q?PQ4UK5nEbrmF/nL6RCJSTHER/ig0JTqNtrABDHGgpvSVxUU+ICzN91Ub?=
 =?Windows-1252?Q?IlE/FlmfPb1clD7dNXQkruuRD6e136KJSxa8hKJL4QVE51Dknz99DTUp?=
 =?Windows-1252?Q?mn4FY5bwRynJrw/Zvx97rbNJoNd2MT+bOXcX/lcgxy/FFIgHs2WN79/E?=
 =?Windows-1252?Q?099x3U65bubSGXdBo3RdP5pcswAplcLWqlTxDErD/5r/P4weBxne1qNg?=
 =?Windows-1252?Q?xSYxzWGL6LNsXYjViQVGxFsL5mkwlArPEyi4fikEgugq20C61m6EFDAr?=
 =?Windows-1252?Q?qNPkOcxm4O6AxB2RpYjUNw8YZ+I1P6jHJOc7lpAkI98kp/PkhJk2zMre?=
 =?Windows-1252?Q?2F/PU89n9PMz1E4dEbu2U+JFmLPpJvaFioFTcWmZH0AG/3rrUBkSwir1?=
 =?Windows-1252?Q?k8v7mDbu/4gcQiWOflwM1q1SF0YGksN0wfAXdc+8emQrKUm+Uq9wLP52?=
 =?Windows-1252?Q?3ubPxy0mR0SkI+qR7LkpJ94iIjNjGtzY2tn3unaKDaUGbm/4ohtR6ZhU?=
 =?Windows-1252?Q?jbTyeKoUlMo2gxkXSfJYQfv30kC1V5jKW88VBI7lq8wHhMruFNsWpwrD?=
 =?Windows-1252?Q?pY/ogmZcHuNywmfsHo7i3U4H/sDiRZsNjRj8ArCdkD3emJ6dTD7Wjmnl?=
 =?Windows-1252?Q?ZkcXAnY5JTryuI7/RGWN6aFLym5uqwWnYKkyBr2kG87X+iL/htyG7UGB?=
 =?Windows-1252?Q?Sslc5d9F8nyuxZgqRe0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db69af3c-c0d5-4a1b-8c01-08dcdf847362
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 06:11:54.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMywYyCuIcS+DU++LL90GHKeEc9uU322PNJVyEpzi1KGRqfdc+WOHKDcV4MfmQh4ftri8+76P0OCxm/WxIt9xXajKHVkKFQU1Xu37X0FusTDH9EovF0eIGu3UowMvTyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0906

Hi Frank,=0A=
=0A=
Thanks for the suggestions=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0 if (!q->devtype_data->little_endian)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D (u32)cpu_to_be32(mask);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D(__force u32)cpu_to_be32(m=
ask);=0A=
>=0A=
>Most this kind warning report the real problem. I don't suggest fix as it=
=0A=
=0A=
I=92m curious about the types of real problems that might arise=0A=
=0A=
>the 'if branch' should be removed.=0A=
>=0A=
>and simple=0A=
>=0A=
>return read_poll_timeout(qspi_readl, reg, !(reg & mask), delay_us, timeout=
_us,=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q, base);=0A=
>=0A=
>qspi_readl() already handle endian problem.=0A=
=0A=
I agree , it is a good approach since qspi_readl()=A0already handles the en=
dian issue=A0=0A=
=0A=
I will change it to your approach.=0A=
=0A=
>=0A=
>Frank=0A=
=0A=
Best Regards,=0A=
Hardev=0A=
=0A=
________________________________________=0A=
From:=A0Frank Li <Frank.li@nxp.com>=0A=
Sent:=A0Friday, September 27, 2024 9:10 PM=0A=
To:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
Cc:=A0linux-spi@vger.kernel.org <linux-spi@vger.kernel.org>; olteanv@gmail.=
com <olteanv@gmail.com>; broonie@kernel.org <broonie@kernel.org>; Han Xu <h=
an.xu@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@peng=
utronix.de>; Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam=
 <festevam@gmail.com>; Haibo Chen <haibo.chen@nxp.com>; Yogesh Gaur <yogesh=
gaur.83@gmail.com>; imx@lists.linux.dev <imx@lists.linux.dev>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.inf=
radead.org <linux-arm-kernel@lists.infradead.org>=0A=
Subject:=A0Re: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
On Fri, Sep 27, 2024 at 06:58:33PM +0530, Hardevsinh Palaniya wrote:=0A=
> Sparse warnings:=0A=
>=0A=
> drivers/spi/spi-fsl-qspi.c:635:25: warning: cast from restricted __be32=
=0A=
>=0A=
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>=0A=
> ---=0A=
>=A0 drivers/spi/spi-fsl-qspi.c | 2 +-=0A=
>=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c=0A=
> index 79bac30e79af..e4a2a6049e33 100644=0A=
> --- a/drivers/spi/spi-fsl-qspi.c=0A=
> +++ b/drivers/spi/spi-fsl-qspi.c=0A=
> @@ -632,7 +632,7 @@ static int fsl_qspi_readl_poll_tout(struct fsl_qspi *=
q, void __iomem *base,=0A=
>=A0=A0=A0=A0=A0=A0 u32 reg;=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 if (!q->devtype_data->little_endian)=0A=
> -=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0 mask =3D (u32)cpu_to_be32(mask);=0A=
> +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 mask =3D(__force u32)cpu_to_be32(mask=
);=0A=
=0A=
Most this kind warning report the real problem. I don't suggest fix as it=
=0A=
=0A=
the 'if branch' should be removed.=0A=
=0A=
and simple=0A=
=0A=
return read_poll_timeout(qspi_readl, reg, !(reg & mask), delay_us, timeout_=
us,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 q, b=
ase);=0A=
=0A=
qspi_readl() already handle endian problem.=0A=
=0A=
Frank=0A=
=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 return readl_poll_timeout(base, reg, !(reg & mask), del=
ay_us,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 timeout_us);=0A=
> --=0A=
> 2.43.0=0A=
>=

