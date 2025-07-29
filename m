Return-Path: <linux-spi+bounces-9212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D5B14F71
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C804B18A28D1
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A61E51EC;
	Tue, 29 Jul 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WskA6No7"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011056.outbound.protection.outlook.com [52.101.125.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDE1E491B;
	Tue, 29 Jul 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800159; cv=fail; b=WuSCalbi4aDJsFa4Idl1AcZFno9DDz3HI8WoDbssYeYA4+VnbJavA/Pos7saXAk9hxQQUYxxQ/x3lUsqH9UHRvj9tdTuBtReGWUriyeycnqSS8j7WkLA2GXlqpgD/H3v7pWkRAyXyDoagw2M8fJzKYSxFvcUSHtzvor2A0CuoG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800159; c=relaxed/simple;
	bh=21dk71OfeuXa/5STJsvgY0CogR7ev/a4EnsRlGh/dZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m41QqaVaQBq1VLRpcS7EHy7JUjQ/gQNU1h+pnp3Chv2t6I8fzCQeH88ak3XKdrckGAOWUYG7IAylK88AZs8Sqwaukf7dfdu94h91pPrcfoV3vbN6242HwYQrgBnbIMFgdaKrWzujgwmTnunOHMvqst9s03L9LxIgHhyVBAt5K58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WskA6No7; arc=fail smtp.client-ip=52.101.125.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph3y4YsalMVgmutK2vvYgT+0ahd99hRR19jTkzdkjaVOJcEnQ7Y8zGI5H6iu0FsPHrHBxij2jmfAc4KgY5A4TL9EoiERrDIfyiF4FrvSDx/TXlyBJXCm+rkfQ+ZSCU6aYolkQtKNEqNj2paEPpjGGr2+gdb6pIv/QlpMJKlb+s/ifXijHFUO8nPet5I9ocHrB0nXr1CZubC+GQuG+Yt2gaC2Etkg91f/tslGiHuHrG/fbpwWcbOV5w/Q/89QrfGQlozsC1tOJ739X6gzLM4TREHG2Uct+kkXWaJk7XD1kvGRXTlAeWJtooIhrNw/9aFWKXGcVjLP4Q3f2PGa49up8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21dk71OfeuXa/5STJsvgY0CogR7ev/a4EnsRlGh/dZA=;
 b=XygGwq0LRamJuncVJ3uZ5MLPZNVGU99MJ1k3s6CfOulklHwc/I3twmj+TjG6O3d0JnOI7ZCKwZOqVAF3r6+2yTdvUlUq+v9hKgL71rMItcdWoj/GesIwvNELB/FAO6iQEcx4ExWiksHL7ooKOghEeXJvzdznu3BsiShPj7nn3qEmzObVcZymiv4ngf8unAhSZ0xeSE0p2V+i4XGrqD7xEcHMuzTZUbiB1T9T5yIPqwvxmQlPgC6cPl1oAX2HXcsLNriEHAjJ7082bDIT5SdzCSWm75wqQKBYnVEs7NEdJFsfGffSKU6lsrX4AbtRjSChNdgvkbrK/8qBeLZwnBQKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21dk71OfeuXa/5STJsvgY0CogR7ev/a4EnsRlGh/dZA=;
 b=WskA6No7RIbDvrxzdpKObTYOfLfHgcEGykLNNkwnlkEGWA/YlzV6xq/5KgtLY5EQSqt6uSJXRjA5mS64FY4XjyiOofWFvzYu5hIu36GHuSyFg48ainKipbjlcsmDIeeXgryArIAKqJLyuRPDfq1iIulKmDYLLKBY2HvPvThS00E=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSCPR01MB13471.jpnprd01.prod.outlook.com (2603:1096:604:331::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 14:42:27 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 14:42:27 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Thread-Topic: [PATCH v2 3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Thread-Index: AQHb7P+hjh53F9mNvUWIlax6A4HhZbRBW5+AgAf4EqA=
Date: Tue, 29 Jul 2025 14:42:27 +0000
Message-ID:
 <TYCPR01MB12093F6A1672538A203E9C3DFC225A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
 <20250704162036.468765-4-fabrizio.castro.jz@renesas.com>
 <0b58e72a-ef96-4f04-94dd-66a6f3f4d0f6@sirena.org.uk>
In-Reply-To: <0b58e72a-ef96-4f04-94dd-66a6f3f4d0f6@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSCPR01MB13471:EE_
x-ms-office365-filtering-correlation-id: ac40347e-5537-42e0-6eb8-08ddceae23ad
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PcuYXzIwlZ/Zp3j0JHi3G6vJxorP57DQBvkoikEjmnruRrjqM3y/69drOzU1?=
 =?us-ascii?Q?FafBIyLAX8SvVhARd+HijEgx0M8ouBIrA03rqw/Y4DqMtnGqvA8MpTUu7uTk?=
 =?us-ascii?Q?w689FcfUIK1EV3+/77QR06mB6f9v3eX1EbJg0MEqCPhh7MoCCZANB2GAih1w?=
 =?us-ascii?Q?VwDyQcBkrnZkiPVpkksshzNzsOuquLty942ooaPF+FEqoVoJo5+W70MajZbf?=
 =?us-ascii?Q?4HSb/QzGXM0NkaAc1CLIaft43HUybe/pPq4l7txYDJFn1I8mkZjFcSMmHCD5?=
 =?us-ascii?Q?akzU6jLKjZnOAvtzym+9qZ0KIv2wOVRxkQym8oECn+lsO6O4nSut7uQf8gMG?=
 =?us-ascii?Q?brvsVZCJgm7KXCZZncetCU5P73kbTWZk1LX2Ey6DRBCAJov8EnLLekgHn5+v?=
 =?us-ascii?Q?Mw92/Ok8GUmWDQPRl7Tundks0er9ujsejWhLrCfV17y08XD7uZ6tGKdPuAii?=
 =?us-ascii?Q?ymV7ul+XTuTWWJjNunXSHc8k0o3inFvpHh9YHGYmVsFA+i/xdFWeBQBEqLcy?=
 =?us-ascii?Q?hikjhRlpfNrf/TqTWQDfonkibOM6JCDq/qMwp1YNbcWWxEoL9mNdWL2N3rTE?=
 =?us-ascii?Q?lKcx4ghJ8i78OgiywsBPRjLNlaXowh8xq44PqD5DUF/l/riSXw/jjugso9ZZ?=
 =?us-ascii?Q?K0kOGsYmcl9ZYo5+i5wDsZOAO8WFe4R9BmB5fmPQ2/9IuYYoZUpXG5CIKjK4?=
 =?us-ascii?Q?F1Zc6a7gGsItqEqHB4V3RC9EnLHf8CoE46mgBtGHNwQSy/+pcTe1kFtzd1QE?=
 =?us-ascii?Q?tVstQSypjczWRTCLkamYXuqKO4dbHInZnM/SWVD7Md9lrZ4qi+PpwsmJiyfy?=
 =?us-ascii?Q?CWKd20eIoFBPAPUqiCwB+E7ab8iWAjlc/MGo4gY1EUYP9mniCw5ot7iWpQtm?=
 =?us-ascii?Q?EEeGiwffNlhD1nJu2OKh0rY2eLTWZ2Sku04VQhgq46+CbwlKhRCX5qGtB6Q+?=
 =?us-ascii?Q?FqeDS7szqC4sugffnpdrdKCWvlJ70m24URR6F70ICzpOj6QuO7W0KqxLJOx2?=
 =?us-ascii?Q?4AH1dkuWiK2MDZ3B353wK6t5PXg77QR+hzDjsXrDEUG3UjAeytrK6kX1cMsP?=
 =?us-ascii?Q?alVlo64tD49kIeKs413i1jutwPG8OdHQ0RF7liTUbVgcXDGtS49or1HpCCI8?=
 =?us-ascii?Q?cM7dyP4DHJO6DwyrCh5lXW8W7ZQMbrMCNSYxTpn3wXR/oLSURonfFRj+3t3p?=
 =?us-ascii?Q?0p3upyMMskIk/VAhgHNlZj6LutNPFjiGmEmouniIQqoyo/ZBk4F39HleOwI3?=
 =?us-ascii?Q?bckfO8ZIGCwSGIvS/wSDm8hZ8U3QcIAaezYquwCCp2fhqe5/ooa0R9/ELwug?=
 =?us-ascii?Q?koXhJDttvJuVcHCErxSKkqL5qfXCPJIU+aljpDNLhHxYJya8OXvKgM6/wuJ/?=
 =?us-ascii?Q?Tlb8bEe51hc5Jp7mqoeoM2Ebjs2bTwspQ5E2ZFdktP1Aj1bjPdgtgg12wfnK?=
 =?us-ascii?Q?aP0svfdnktGGWEG9qrxYaURDTN8qqhpimfXR8xGvVnKn+EudgfULJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGos7MTSRC12zdk3R42hEb+8gSZHH8++ThMOP8uO1//cksecuPJh/M/vCs1h?=
 =?us-ascii?Q?mLjntANTcvVyLDPZ3QXbZ/vP5DwwH7Qq9cl+HKesPkdoNW+Hqgr4Qh1eK8Xi?=
 =?us-ascii?Q?2qKvXWz3nv51AV/quVyR3mSeYoQGW+yCt3uKiRHMyfbgvwQs8u2+Ohud+QgK?=
 =?us-ascii?Q?yR5FNyzTFTxyQarfzq9dycyV+EtbmWPEOAjWuBw+0LRfL9GCz395xe+/Au1g?=
 =?us-ascii?Q?0QqWfNeFTLn6Ekk793Ix64PVKmoWLBj/B9FfCszavEhTWnaoWoNNaIHKzZs5?=
 =?us-ascii?Q?ss33jEoFvsuUfYhqZVCFS3E15E9sftAprcmgHOBPvktrd791X0uHMz7B/n+u?=
 =?us-ascii?Q?GuVwlrkNK/e7QEo4sajb0dZifBjOAPC1QMr/tEj27ikLhVCsjDDNDcafbJQL?=
 =?us-ascii?Q?tyKcCZ1inlBqXYmx4u4gcjxk5i9Pp2Ozlc+OBVEkitChjox+7CeQ+pJRTLJi?=
 =?us-ascii?Q?UAAlAsB32vWn/7wzC2Cv0m/rR9s/Kilwlk28dk4f+Dj8tkv+H3ErRqYdG5nY?=
 =?us-ascii?Q?AEWU/5OKKm0aZZzKH6Z5lYYDzqu7ej7hZwXlS2M/t7U6QrCvkPXshGpfeXDa?=
 =?us-ascii?Q?yE52+R7mzr3thgzFxQSiw4UY8s91SH8Id3yZHhPLnEmRBt/1fZ7PLesjrn4J?=
 =?us-ascii?Q?X9TD8ti8KsgxT2AfcEm3+I3EQ24t2j18Mv5rZLRpIgvlTwKKPBpfWYQ6dTyN?=
 =?us-ascii?Q?OB1Q9ueORyyFhidxDu9nrl80uKq1at//0hGdRcZA+EzhBGKiYU2Pyu/x9B05?=
 =?us-ascii?Q?y/+FlpiPiK7pCik7ANLH8np21u3M2G/nzEqmXoI07OJI3yVYhZk0DVOoS/a/?=
 =?us-ascii?Q?hcqG7rYUbD3nrOLHcr5n+ZAQxtQ+2uT/ioiMJRFezrEfyfSC7DOI0xGHmu1O?=
 =?us-ascii?Q?ELoU8I9gsae8Y52O7Ujr2+x1IB9e2LALKvmPpdKr1RZjdP+pLoXmo2Q01h93?=
 =?us-ascii?Q?ImQ+bs++/PWHSQM69jpFarUL/fGhWZqpMcQduYyxbLzixXMOZOcSuKORYFE8?=
 =?us-ascii?Q?zPeeyGrxXV30qkRpF0nOv15AY+WJiCR0kYpiSpszHgA6O6PPPniZ8h4PsnL1?=
 =?us-ascii?Q?1k4VM4t0TF6r6XDxqXWKwH1lglK2zpYRmnGpqb7MAPLvaXMNDQeuqgTJIumF?=
 =?us-ascii?Q?mapclTvJF3G9bpSvW0jVceHmfqmv2KUWceJyAmbpFjqJcEZWTjn/pcgAMvb9?=
 =?us-ascii?Q?ILFJbQd90hlH9mLLEbKbDC/hj6l5MYn/MbeDXb96x5deitHG4/5jmeFTWz3X?=
 =?us-ascii?Q?qoy5izIwDuPZhsRKCtfteB4xbKbdBtunWJnvAX26Ve7JN7rHDfp0HRx+CkDO?=
 =?us-ascii?Q?h3Kk1p4AmWucaQGjNVTHFsva5jmf4c0n92CbI1BCDxBpFP3GoSdqqB3RqlNl?=
 =?us-ascii?Q?njN71xAFYTq3UQC6X7tDfXbssIPKezu5KeHAepXSvmxA8ytMimwTvVwBMppY?=
 =?us-ascii?Q?9ow3bWHWG4eDDNvwEEmuuA2e2Chtkp5vTnfu2Hbk2Cxzky4W+tgRcmNGxJsL?=
 =?us-ascii?Q?TO9pPheT/Jiz6jLqm3sn/oNA6CqU7XLp7LGs3yheI/bqJ/VU6PcCos2uzKZQ?=
 =?us-ascii?Q?050Qyt+R65GukcDVYoyNRogQa4fUp0xv22ULSF5GPTZc/hpaa8b4kw0YtxcM?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac40347e-5537-42e0-6eb8-08ddceae23ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 14:42:27.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aamcYLklFrPSY33MdHXGZD63knRDxOmBCXSsaTX/EFFaD5ed9fOYG391p/eMYSj/HyveuZtN++2vMWoWkQAV/6Us1j9N8MqeZBXKoQiJJec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13471

Hi Mark,

Thanks for your feedback.

> From: Mark Brown <broonie@kernel.org>
> Sent: 24 July 2025 14:00
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.or=
g>; Conor Dooley
> <conor+dt@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>; Geert Uytt=
erhoeven
> <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.com>; linux-spi=
@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vge=
r.kernel.org; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-la=
d.rj@bp.renesas.com>
> Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RS=
PI
>=20
> On Fri, Jul 04, 2025 at 05:20:36PM +0100, Fabrizio Castro wrote:
> > Add the MAINTAINERS entries for the Renesas RZ/V2H(P) RSPI
> > driver.
>=20
> This doesn't apply against current code, please check and resend.

I'll rebase on top of your `for-next` branch and I'll resend shortly.

Cheers,
Fab

