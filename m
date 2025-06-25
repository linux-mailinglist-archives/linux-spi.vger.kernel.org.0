Return-Path: <linux-spi+bounces-8767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51136AE7EF6
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358551712A2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63494270557;
	Wed, 25 Jun 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bh4EmMAi"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010045.outbound.protection.outlook.com [52.101.228.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79671DE2DE;
	Wed, 25 Jun 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846794; cv=fail; b=HPnp6H6UytDmt2XBNwd8xqPm3pR0lWLKPj4Qo79vUJYHAs+/wDmt8DyL51/hZGwUxtBb/wvlgHKh+bXAZMUVw/vzwxeLKWn9hZPmfKrFdZiu3Ub7IZEVk7+Y9q6XRwF2+Gd9hfHwc0rD3CC1yV/g/Z2giqNyfpQcvy8ZEF9NNZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846794; c=relaxed/simple;
	bh=3N8TObgYjt5ZWDwdCDdCgW5bg7c9Zr3j+aLuj58zKXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QT0iJl6I0wWc09jRydL4FNyJdi0AkFimhnDGWgfDuH5miuBZU2iq1Na2gyNLC22OTT3ao5dBm8oJqZzpDbnYsWg6IEzL5cOwztK2miuYeLCQi7OcDOCrhfW8wHBwp1AW2P5sFPhokmJQ2wQAnEWp3wa3G7ublFS32qFhWhZo35o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bh4EmMAi; arc=fail smtp.client-ip=52.101.228.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUVVPzZ3GgyTc89bY2v0kXldwuX/XDLsxpH9qCaYfVOumeBk+KPMAb0fPuEzucC+ouV8XsOZjaMKLIcMyWo/vxjthbSA9kRPyCeAVambLYjKEUxNjx6ZUNliIPD1OuoeDHYvHotW1Bq0qCCM7HCJawf+7WkZU84tMEF4l6H9qbkJOBiL0pErj7KjqFwbfgcJWZeu6VhygWTUD4gAZk3NfDpSwpQpOuDSJQE491xiueP3cuwUtMFgQeInszdUnsFadomDhpS8TSiicE3tlS+O4CP10CM7oug79j+/AMJoiuB7VJ3gpha321TePqb0EA+HJJ5U5c6a7tvg6afe2mtyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XNhwfFfcbnzhohtpqLddhDL3oduKetG4KY/62JI+vE=;
 b=aPIp8y0dwuVkQ8W5C9sqJGBf39W2bjZBW9fmVgHgYud1Dq53OPDylu8QiMVy7yuqKlayth7chrhD2IFpCCAH8qDh8vVtrK6H1F3dKfrvn6y/7Nnm16W/qFDvmAo5rcH2NbRMYuS2T7qk7foA3EPmFvVa1sp0Agol2sxIBlly22LFSLJM8ir6t/zNDwnLegR69E/W/s0tqWXe3sgZLYxhkLectRXChKDgpE51hkE8hsDJjM0M69IGRrI8JcLcosBW24f/i5dFnJh0z1fJ8eG7A9ISzgyWRfUFtxZjzf+kceeyEiaWt2sVq3FlH+KQyw8UNT4rPcoULlXlWDHA80ckOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XNhwfFfcbnzhohtpqLddhDL3oduKetG4KY/62JI+vE=;
 b=bh4EmMAioisWvjRSDAZ+ChnGiQ7lRoNpxgJDB9r+3LN/rMFEkGZFK60j8rgHXwKrxBaSZnF2cYuZ9oSHIRCBxAmBY6lOWw2v6KUjqmPW4BjxOKVO01uxhOyej8GiCBgiDMhrUJZgftmta+v2OTruenKWkE0mroP+VFZqbWDkfQ8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7161.jpnprd01.prod.outlook.com (2603:1096:400:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 25 Jun
 2025 10:19:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:19:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown
	<broonie@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Topic: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Index: AQHb5T14bgEeyAQojUioIEvtS1AgK7QTpXcQ
Date: Wed, 25 Jun 2025 10:19:44 +0000
Message-ID:
 <TY3PR01MB11346270DF3A4B90C5A73B450867BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7161:EE_
x-ms-office365-filtering-correlation-id: 6e29fc5e-dfa9-4726-965e-08ddb3d1ce35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v8dUUZapQKwZKJ0+psJxNXa/JV7wk6aXryV/AkmKlBRMMDf14+6diNq6zTfJ?=
 =?us-ascii?Q?cm9jqksmjC9PrD3J2AT91x7NhZMUP/8G/DlpxJzNNQHD0HBhcv67z6d9pVEh?=
 =?us-ascii?Q?chIqjty8HS6f1+l9u5sUMX4JpreTbwhZRhrLuy5n8t2j7pvH1xu6avRIPhMo?=
 =?us-ascii?Q?sE9QunDh9NAl6lp/p8ohUA5nD5XD+XY37madodgx1xJBRuUep1vJT/3y57FU?=
 =?us-ascii?Q?wBvLl4Bouexq2UIGUnfmYO3Rp34+EorX+X5NzyhpzXezaD+CpIM2HIMeNdrK?=
 =?us-ascii?Q?Sae66OoQau3QDmFJgiTKzfPZtxzYJmt8BDYd9D7Pd8XaJT70ToyLF0vD7z3A?=
 =?us-ascii?Q?As5AgJo8txfAED/cPuPaMFvUBc6HL2jxYDgByNNeg6M33taArZYvvYWpaOUI?=
 =?us-ascii?Q?roWCzz2bH4e/MGJxgEkCaxtVs/mRcSo0eeeA/4St8bmiWem/udZKaPEs66aM?=
 =?us-ascii?Q?+2NPxIorjvXPRe4wrL/mAoLoDl1zFuP23mkpOQAEFHDGbfVcj3/gUf3QmicW?=
 =?us-ascii?Q?JRrboFkGKqXyCktvRAKj4znsVyMlEdGQcvY2dqAT76iliaEZI12brEe8eKbS?=
 =?us-ascii?Q?zq+sM93Rtg/kqK1KwXIipEi3V0FQdQgbALIa3uD6xW/7RMbWWPYa3NPQgqPh?=
 =?us-ascii?Q?TndAyKr/nhQYiD6oPli4RMwjzF6T0Yxftt9OeAzjQNaa0JYitK2X55QlYUyH?=
 =?us-ascii?Q?ZsugusCdCsSYOt85bJWcWPOMVHlA2MWLroZeZb07C99sEKP7rq0mMbIeG2Iv?=
 =?us-ascii?Q?vYIDgT0gT+/iIS6jFOdgzUBL2mXQFfxBFmRPiesvx/8tzAfDmmcZjX6BGbdj?=
 =?us-ascii?Q?PJKIroQt2xhphQdlH4Arily3eGC0lDBCf2WB/a5ycK+xQHHYi2O/maK85jyZ?=
 =?us-ascii?Q?SU0Dh6wjGmvOvZnBxYQr/QfnSCvRXKmEhUKFXKfShLDgmslReGn4B6bN8F4N?=
 =?us-ascii?Q?JygC/5nb5URXk1puvQdNRvC7Lqdur3GSrnTUWHBrHimikpgP2GkauFSvZxyC?=
 =?us-ascii?Q?s5oTI7GgUC58AO8TmCjTnKVJJNd1EgsxejuXF6iNJcUvow5VaeHCC5d7mreV?=
 =?us-ascii?Q?7akZ6CPceNeh+PVWqmofLvnqYEZSL9QLX+xX/997yrjLO0ZA3VfmQwx7OdDh?=
 =?us-ascii?Q?jcTQOiDQnqudqkdNmoEZugWqhvWaTX/eUbnvbhKtN+aCv8ZsQwGyWXiD/gwi?=
 =?us-ascii?Q?1mDTpxS4p5r2m26mY1ig9bAnRZCxScYRqW6JWuNAESU6oGgKmjm2gbgVVVNv?=
 =?us-ascii?Q?ANFp+pf4FW6q1HfZN0+iZHzs2jEH8GnbqCD4Lza2qcizSdYV7ZYOs+G8SXrL?=
 =?us-ascii?Q?uFw2NEKenkIcsNXPsra9Bwn9Td7RXoL5sVZHcC6ygT6cVUmIja+NSL6nMrQe?=
 =?us-ascii?Q?TFXhHP4cgS7I+3UUSdbWwe46Wl4Wd3eklw1a6yQVh4/OhO/e2FbmTFHqb47d?=
 =?us-ascii?Q?F9y261WQZYFYkZzH09TIToubH1HcXrvkpwp8dNfTl2yfoe1O+VmPnF4GTjSo?=
 =?us-ascii?Q?5n9VNs+GP7c0TMk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OpbVzWGKo6TOv2t8XMLP+jvfBdTu60mp9nBu0Rq9w8qo8BpCBcNCJJ5bsb5i?=
 =?us-ascii?Q?y4eC9k1qaG9XiQfqRBqxqwOeJgynrSzqCakr9MThDbFEPSakxQf85T+fdtSW?=
 =?us-ascii?Q?dWUCR+VkdkCvMyzDwMiYweqwqcEazJfMpnukmR6td8oTumqSfDKQN07NBDop?=
 =?us-ascii?Q?6mUxwzuYzW0vM4vmoqt8KCLiQbDr+8tn8I2T09uFjBXsmJTmYHKW9S6M048M?=
 =?us-ascii?Q?+Weq2bToohbK72r9c/Lc5V/WG++6FEY0H8JAmE/LYgrXezCsxCEgJmfZB9Wa?=
 =?us-ascii?Q?Gv2TQe1und7tyx4JxrKZ/ouezsSAGEqbtESZEUgKR8OEQlHPJviKsI8wHF52?=
 =?us-ascii?Q?RM2SZ9oxg/uMj0+EYUjVIWYc8wEbzJ82Ezi990E8ScueXPGm9nHtETGEbKGt?=
 =?us-ascii?Q?jugTVNDMOMWGJVROANSJ7YiMFzvpTABvqvB3sgygGrX1VEl6xG0t0L1m21fF?=
 =?us-ascii?Q?xQdrOeMBPVv0+yDG7x24TxdPDWAyLpcEbzEu7VJzDB7oejry9jGPameBnOPo?=
 =?us-ascii?Q?eNdcSlzxyGXTM42Cx/hv+EqqmbuKAwnag2bet9atBU1y7GU+t/p+gGvmzG94?=
 =?us-ascii?Q?fBHKulNBQpuFP92zsZX3yOl/gG3aJdxxSCfkgTZ7hke6UTA6edMKxE7uxmSd?=
 =?us-ascii?Q?O6/nYM31fN7AcrS5cr8DltB5Ds3EotQKGEhVgKP6cJFo0Syohc3ykWrhQzQv?=
 =?us-ascii?Q?vYLT8u/5+BIB/0atFiGyQm/9IAB3saLELdZdsxTfAuHqNmDS2UUJD1Su6pZb?=
 =?us-ascii?Q?lAf4rr17xWZsi8TCcU1dPNZ0jEvAnPjWQVOoJzD/SufOMGntdWvk25/zfoCL?=
 =?us-ascii?Q?YR92uFZoDU+QYYC+SU4lZyyoRRW1FGBT9MCaP8Ndddp+cMv9vwldxFtYr+VM?=
 =?us-ascii?Q?LO7AweMklcDlahpop3s1LIDKvQ0/NsIfPFPq+b9e+CSu8xI81pvVjU2WG++L?=
 =?us-ascii?Q?a8bD7bHzJspOs4sYikcMCyXwzSo6IiqntNlFepW3jfUraiPrornsuCBhP0wT?=
 =?us-ascii?Q?sS5PBH+982CSetAuSWQRskBPwNCo4jCosn2kR65gzsxLJYV7THaZElNQY7/f?=
 =?us-ascii?Q?iTUuF6PTtWbOlRxxkvhKtlGH0RPe+8ICCWFk0DASOCpZOp6ELyVulMp4gBat?=
 =?us-ascii?Q?525TFKX4xrxnJs58el9eUE+uG9NB1HmU5p1D8TwVl7j5F/poVLvKjJnwAgUY?=
 =?us-ascii?Q?xa6vXiyUiK1Cszm2LG6KC56Ok/DJuFV6wcjn95y2KyfdJepMxvfUgeg3Uz25?=
 =?us-ascii?Q?/8B+u4NTji3NujtvfE6+x5AWAXx6McWqmyifBdAvjQAYlKIVT7Y1zQD1tLJO?=
 =?us-ascii?Q?XWDqUq2gEBPNkO7PN8eykwUecDHh0QtZJoNJ9Un0BrfdwcI9D5I7tT2q0v2q?=
 =?us-ascii?Q?9WN0MevVR/Dx5wy7yY1kdz/AXLDJu9G14Btn6qvvun5kooh7Q+7uLqtfpmtH?=
 =?us-ascii?Q?ZqQsMHMnCMPK0VFTmHY52BySYTDanEoq+QPxu0Kg+rkccw7L9fAzbgFidSxr?=
 =?us-ascii?Q?M06kLGQuHr8h6dXShwCmG5w8Uijc2B5edHicsHm2tPPrHlEj0PNXmAf272PZ?=
 =?us-ascii?Q?Kw9F86Xu6y5FpXHXX0em+VDX+iYAAZD/eToeWcfX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e29fc5e-dfa9-4726-965e-08ddb3d1ce35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:19:44.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpVZCCAWL8FNpgJfIBhNGgHCNX4rgdbkmjGJlUxuFUPa7z9Te5GQRY6qjYqYXUenWn9nBaYO6m7tcDSJ37T8pCcTm59iSDMT0t1WuV9BnyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7161

Hi Fabrizio,

Thanks for the patch.

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 24 June 2025 20:23
> Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahade=
v-lad.rj@bp.renesas.com>
> Subject: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
>=20
> The Renesas RZ/V2H(P) RSPI IP supports 4-wire and 3-wire serial communica=
tions in both host role and
> target role.
> It can use a DMA, but the I/O can also be driven by the processor.
>=20
> RX-only, TX-only, and RX-TX operations are available in DMA mode, while i=
n processor I/O mode it only
> RX-TX operations are supported.
>=20
> Add a driver to support 4-wire serial communications as host role in proc=
essor I/O mode.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>=20
> I have noticed a problem when unbinding the driver that is solved by:
> https://lore.kernel.org/all/20250616135357.3929441-1-claudiu.beznea.uj@bp=
.renesas.com/
>=20
> Once the above series gets accepted I'll send a patch to add runtime pm s=
upport, and I'll also switch
> to using devm_spi_register_controller.
>=20
>  drivers/spi/Kconfig          |   8 +
>  drivers/spi/Makefile         |   1 +
>  drivers/spi/spi-rzv2h-rspi.c | 469 +++++++++++++++++++++++++++++++++++
>  3 files changed, 478 insertions(+)
>  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index f2d2295a5501=
..fcc6987945fa 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -923,6 +923,14 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>=20
> +config SPI_RZV2H_RSPI
> +	tristate "Renesas RZ/V2H RSPI controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  RSPI driver for the Renesas RZ/V2H Serial Peripheral Interface (RSPI)=
.
> +	  RSPI supports both SPI host and SPI target roles. This option only
> +	  enables the SPI host role.
> +
>  config SPI_RZV2M_CSI
>  	tristate "Renesas RZ/V2M CSI controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST diff --git a/drivers/spi/Makefi=
le b/drivers/spi/Makefile
> index 4ea89f6fc531..c19d02653b8a 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -126,6 +126,7 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D spi-realtek-rtl.=
o
>  obj-$(CONFIG_SPI_REALTEK_SNAND)		+=3D spi-realtek-rtl-snand.o
>  obj-$(CONFIG_SPI_RPCIF)			+=3D spi-rpc-if.o
>  obj-$(CONFIG_SPI_RSPI)			+=3D spi-rspi.o
> +obj-$(CONFIG_SPI_RZV2H_RSPI)		+=3D spi-rzv2h-rspi.o
>  obj-$(CONFIG_SPI_RZV2M_CSI)		+=3D spi-rzv2m-csi.o
>  obj-$(CONFIG_SPI_S3C64XX)		+=3D spi-s3c64xx.o
>  obj-$(CONFIG_SPI_SC18IS602)		+=3D spi-sc18is602.o
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c =
new file mode 100644 index
> 000000000000..9541f2c2ab2b
> --- /dev/null
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Renesas RZ/V2H Renesas Serial Peripheral Interface (RSPI)
> + *
> + * Copyright (C) 2025 Renesas Electronics Corporation  */
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +
> +/* Registers */
> +#define RSPI_SPDR		0x00
> +#define RSPI_SPCR		0x08
> +#define RSPI_SSLP		0x10
> +#define RSPI_SPBR		0x11
> +#define RSPI_SPSCR		0x13
> +#define RSPI_SPCMD		0x14
> +#define RSPI_SPDCR2		0x44
> +#define RSPI_SPSR		0x52
> +#define RSPI_SPSRC		0x6a
> +#define RSPI_SPFCR		0x6c
> +
> +/* Register SPCR */
> +#define RSPI_SPCR_MSTR		BIT(30)
> +#define RSPI_SPCR_SPRIE		BIT(17)
> +#define RSPI_SPCR_SCKASE	BIT(12)
> +#define RSPI_SPCR_SPE		BIT(0)
> +
> +/* Register SPBR */
> +#define RSPI_SPBR_SPR_MIN	0
> +#define RSPI_SPBR_SPR_MAX	255
> +
> +/* Register SPCMD */
> +#define RSPI_SPCMD_SSLA		GENMASK(25, 24)
> +#define RSPI_SPCMD_SPB		GENMASK(20, 16)
> +#define RSPI_SPCMD_LSBF		BIT(12)
> +#define RSPI_SPCMD_SSLKP	BIT(7)
> +#define RSPI_SPCMD_BRDV		GENMASK(3, 2)
> +#define RSPI_SPCMD_CPOL		BIT(1)
> +#define RSPI_SPCMD_CPHA		BIT(0)
> +
> +#define RSPI_SPCMD_BRDV_MIN	0
> +#define RSPI_SPCMD_BRDV_MAX	3
> +
> +/* Register SPDCR2 */
> +#define RSPI_SPDCR2_TTRG	GENMASK(11, 8)
> +#define RSPI_SPDCR2_RTRG	GENMASK(3, 0)
> +#define RSPI_FIFO_SIZE		16
> +
> +/* Register SPSR */
> +#define RSPI_SPSR_SPRF		BIT(15)
> +
> +/* Register RSPI_SPSRC */
> +#define RSPI_SPSRC_CLEAR	0xfd80
> +
> +#define RSPI_RESET_NUM		2
> +
> +enum rspi_clocks {
> +	RSPI_CLK_PCLK,
> +	RSPI_CLK_PCLK_SFR,
> +	RSPI_CLK_TCLK,
> +	RSPI_CLK_NUM
> +};

Do we need this enum?

> +
> +struct rzv2h_rspi_priv {
> +	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
> +	struct clk_bulk_data clks[RSPI_CLK_NUM];


It is used only in probe/remove. By using devm_clk_bulk_get_all_enabled()
this can be local??

> +	struct spi_controller *controller;
> +	void __iomem *base;
> +	wait_queue_head_t wait;
> +	unsigned int bytes_per_word;
> +	u32 freq;
> +	u16 status;
> +};
> +
> +#define RZV2H_RSPI_TX(func, type)					\
> +static inline void rzv2h_rspi_tx_##type(struct rzv2h_rspi_priv *rspi,	\
> +					const void *txbuf,		\
> +					unsigned int index) {		\
> +	type buf =3D 0;							\
> +									\
> +	if (txbuf)							\
> +		buf =3D ((type *)txbuf)[index];				\
> +									\
> +	func(buf, rspi->base + RSPI_SPDR);				\
> +}
> +
> +#define RZV2H_RSPI_RX(func, type)					\
> +static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	\
> +					void *rxbuf,			\
> +					unsigned int index) {		\
> +	type buf =3D func(rspi->base + RSPI_SPDR);			\
> +									\
> +	if (rxbuf)							\
> +		((type *)rxbuf)[index] =3D buf;				\
> +}
> +
> +RZV2H_RSPI_TX(writel, u32)
> +RZV2H_RSPI_TX(writew, u16)
> +RZV2H_RSPI_TX(writeb, u8)
> +RZV2H_RSPI_RX(readl, u32)
> +RZV2H_RSPI_RX(readw, u16)
> +RZV2H_RSPI_RX(readl, u8)
> +
> +static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,
> +				int reg_offs, u32 bit_mask, u32 value) {
> +	u32 tmp;
> +
> +	value <<=3D __ffs(bit_mask);
> +	tmp =3D (readl(rspi->base + reg_offs) & ~bit_mask) | value;
> +	writel(tmp, rspi->base + reg_offs);
> +}
> +
> +static inline void rzv2h_rspi_spe_disable(const struct rzv2h_rspi_priv
> +*rspi) {
> +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCR, RSPI_SPCR_SPE, 0); }
> +
> +static inline void rzv2h_rspi_spe_enable(const struct rzv2h_rspi_priv
> +*rspi) {
> +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCR, RSPI_SPCR_SPE, 1); }
> +
> +static inline void rzv2h_rspi_clear_fifos(const struct rzv2h_rspi_priv
> +*rspi) {
> +	writeb(1, rspi->base + RSPI_SPFCR);
> +}
> +
> +static inline void rzv2h_rspi_clear_all_irqs(struct rzv2h_rspi_priv
> +*rspi) {
> +	writew(RSPI_SPSRC_CLEAR, rspi->base + RSPI_SPSRC);
> +	rspi->status =3D 0;
> +}
> +
> +static irqreturn_t rzv2h_rx_irq_handler(int irq, void *data) {
> +	struct rzv2h_rspi_priv *rspi =3D data;
> +
> +	rspi->status =3D readw(rspi->base + RSPI_SPSR);
> +	wake_up(&rspi->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline int rzv2h_rspi_wait_for_interrupt(struct rzv2h_rspi_priv *=
rspi,
> +						u32 wait_mask)
> +{
> +	return wait_event_timeout(rspi->wait, (rspi->status & wait_mask),
> +				  HZ) =3D=3D 0 ? -ETIMEDOUT : 0;
> +}
> +
> +static void rzv2h_rspi_send(struct rzv2h_rspi_priv *rspi, const void *tx=
buf,
> +			    unsigned int index)
> +{
> +	switch (rspi->bytes_per_word) {
> +	case 4:
> +		rzv2h_rspi_tx_u32(rspi, txbuf, index);
> +		break;
> +	case 2:
> +		rzv2h_rspi_tx_u16(rspi, txbuf, index);
> +		break;
> +	default:
> +		rzv2h_rspi_tx_u8(rspi, txbuf, index);
> +	}
> +}
> +
> +static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbuf,
> +			      unsigned int index)
> +{
> +	int ret;
> +
> +	ret =3D rzv2h_rspi_wait_for_interrupt(rspi, RSPI_SPSR_SPRF);
> +	if (ret)
> +		return ret;
> +
> +	switch (rspi->bytes_per_word) {
> +	case 4:
> +		rzv2h_rspi_rx_u32(rspi, rxbuf, index);
> +		break;
> +	case 2:
> +		rzv2h_rspi_rx_u16(rspi, rxbuf, index);
> +		break;
> +	default:
> +		rzv2h_rspi_rx_u8(rspi, rxbuf, index);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
> +				  struct spi_device *spi,
> +				  struct spi_transfer *transfer)
> +{
> +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controller)=
;
> +	unsigned int words_to_transfer, i;
> +	int ret =3D 0;
> +
> +	transfer->effective_speed_hz =3D rspi->freq;
> +	words_to_transfer =3D transfer->len / rspi->bytes_per_word;
> +
> +	for (i =3D 0; i < words_to_transfer; i++) {
> +		rzv2h_rspi_clear_all_irqs(rspi);
> +
> +		rzv2h_rspi_send(rspi, transfer->tx_buf, i);
> +
> +		ret =3D rzv2h_rspi_receive(rspi, transfer->rx_buf, i);
> +		if (ret)
> +			break;
> +	}
> +
> +	rzv2h_rspi_clear_all_irqs(rspi);
> +
> +	if (ret)
> +		transfer->error =3D SPI_TRANS_FAIL_IO;
> +
> +	spi_finalize_current_transfer(controller);
> +
> +	return ret;
> +}
> +
> +static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 sp=
r,
> +					  u8 brdv)
> +{
> +	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv))); }
> +
> +static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
> +{
> +	unsigned long tclk_rate;
> +	int spr;
> +	u8 brdv;
> +
> +	/*
> +	 * From the manual:
> +	 * Bit rate =3D f(RSPI_n_TCLK)/(2*(n+1)*2^(N))
> +	 *
> +	 * Where:
> +	 * * RSPI_n_TCLK is fixed to 200MHz on V2H
> +	 * * n =3D SPR - is RSPI_SPBR.SPR (from 0 to 255)
> +	 * * N =3D BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
> +	 */
> +	tclk_rate =3D clk_get_rate(rspi->clks[RSPI_CLK_TCLK].clk);
> +	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv+=
+) {
> +		spr =3D DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
> +		spr--;
> +		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
> +			goto clock_found;
> +	}
> +
> +	return 0;
> +
> +clock_found:
> +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
> +	writeb(spr, rspi->base + RSPI_SPBR);
> +
> +	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv); }
> +
> +static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
> +				      struct spi_message *message)
> +{
> +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
> +	const struct spi_device *spi =3D message->spi;
> +	struct spi_transfer *xfer;
> +	u32 speed_hz =3D U32_MAX;
> +	u8 bits_per_word;
> +	u32 conf32;
> +	u16 conf16;
> +
> +	/* Make sure SPCR.SPE is 0 before amending the configuration */
> +	rzv2h_rspi_spe_disable(rspi);
> +
> +	/* Configure the device to work in "host" mode */
> +	conf32 =3D RSPI_SPCR_MSTR;
> +
> +	/* Auto-stop function */
> +	conf32 |=3D RSPI_SPCR_SCKASE;
> +
> +	/* SPI receive buffer full interrupt enable */
> +	conf32 |=3D RSPI_SPCR_SPRIE;
> +
> +	writel(conf32, rspi->base + RSPI_SPCR);
> +
> +	/* Use SPCMD0 only */
> +	writeb(0x0, rspi->base + RSPI_SPSCR);
> +
> +	/* Setup mode */
> +	conf32 =3D FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
> +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
> +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST));
> +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
> +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
> +	writel(conf32, rspi->base + RSPI_SPCMD);
> +	if (spi->mode & SPI_CS_HIGH)
> +		writeb(BIT(spi_get_chipselect(spi, 0)), rspi->base + RSPI_SSLP);
> +	else
> +		writeb(0, rspi->base + RSPI_SSLP);
> +
> +	/* Setup FIFO thresholds */
> +	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
> +	conf16 |=3D FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
> +	writew(conf16, rspi->base + RSPI_SPDCR2);
> +
> +	rzv2h_rspi_clear_fifos(rspi);
> +
> +	list_for_each_entry(xfer, &message->transfers, transfer_list) {
> +		if (!xfer->speed_hz)
> +			continue;
> +
> +		speed_hz =3D min(xfer->speed_hz, speed_hz);
> +		bits_per_word =3D xfer->bits_per_word;
> +	}
> +
> +	if (speed_hz =3D=3D U32_MAX)
> +		return -EINVAL;
> +
> +	rspi->bytes_per_word =3D roundup_pow_of_two(BITS_TO_BYTES(bits_per_word=
));
> +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word -
> +1);
> +
> +	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
> +	if (!rspi->freq)
> +		return -EINVAL;
> +
> +	rzv2h_rspi_spe_enable(rspi);
> +
> +	return 0;
> +}
> +
> +static int rzv2h_rspi_unprepare_message(struct spi_controller *ctlr,
> +					struct spi_message *message)
> +{
> +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
> +
> +	rzv2h_rspi_spe_disable(rspi);
> +	rzv2h_rspi_clear_fifos(rspi);
> +
> +	return 0;
> +}
> +
> +static int rzv2h_rspi_probe(struct platform_device *pdev) {
> +	struct spi_controller *controller;
> +	struct device *dev =3D &pdev->dev;
> +	struct rzv2h_rspi_priv *rspi;
> +	unsigned long tclk_rate;
> +	int irq_rx, ret;
> +
> +	controller =3D devm_spi_alloc_host(dev, sizeof(*rspi));
> +	if (!controller)
> +		return -ENOMEM;
> +
> +	rspi =3D spi_controller_get_devdata(controller);
> +	platform_set_drvdata(pdev, rspi);
> +
> +	rspi->controller =3D controller;
> +
> +	rspi->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rspi->base))
> +		return PTR_ERR(rspi->base);
> +
> +	rspi->clks[RSPI_CLK_PCLK].id =3D "pclk";
> +	rspi->clks[RSPI_CLK_PCLK_SFR].id =3D "pclk_sfr";
> +	rspi->clks[RSPI_CLK_TCLK].id =3D "tclk";
> +	ret =3D devm_clk_bulk_get(dev, RSPI_CLK_NUM, rspi->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot get clocks\n");
> +
> +	rspi->resets[0].id =3D "presetn";
> +	rspi->resets[1].id =3D "tresetn";
> +	ret =3D devm_reset_control_bulk_get_exclusive(dev, RSPI_RESET_NUM,
> +						    rspi->resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot get resets\n");
> +
> +	irq_rx =3D platform_get_irq_byname(pdev, "rx");
> +	if (irq_rx < 0)
> +		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
> +
> +	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
> +			       dev_name(dev), rspi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot request `rx` IRQ\n");
> +
> +	ret =3D clk_bulk_prepare_enable(RSPI_CLK_NUM, rspi->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");

Can't we use devm_clk_bulk_get_all_enabled() instead that will fill struct =
clk_bulk_data??

> +
> +	ret =3D reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert resets\n");
> +		goto quit_clocks;
> +	}
> +
> +	init_waitqueue_head(&rspi->wait);
> +
> +	tclk_rate =3D clk_get_rate(rspi->clks[RSPI_CLK_TCLK].clk);

Is it not possible to get this clk from struct clk_bulk_data by using the i=
d "tclk"??

Cheers,
Biju


