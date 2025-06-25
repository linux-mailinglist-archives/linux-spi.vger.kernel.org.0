Return-Path: <linux-spi+bounces-8757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6FAE794A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C71177299
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791820C037;
	Wed, 25 Jun 2025 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Rl9BgI+o"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010026.outbound.protection.outlook.com [52.101.229.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638C72619;
	Wed, 25 Jun 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838400; cv=fail; b=o/qkREasnCpVmKulN8wkCq+uJwbuXzIxXrtMBrw8pF6ZjG95j9pZeIrLS48hOjuvt26kFhDrNay026SOvz4nZll4MQY+jDkbfhoH78hFZieyasjKrqieAqzudNnZxAjIZi0z4bGVFeu31eiumNiZ3B8/zcdm6pHHCE1C/xd1CiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838400; c=relaxed/simple;
	bh=vbPLBJ6Ms5Mon6KNAUyTWTPVRzqmh73THKNrHUFjKa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfWheT3cmbMAHxg3FebOIdnJCjqeZJWfuOWT0rFxo/f3kNxxlBgQ+KV/7QdYGlIcNoQFhI1m8yJ+MBla89BJgTt3PMRcsn0rkMZixEKTBZMafMJqNWZggYLP0l7BRRPFlAbTuTUgjSNxBbnc/61uyZnFxg0T+CPtutwHkIzi9H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Rl9BgI+o; arc=fail smtp.client-ip=52.101.229.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO/8yTm1hN/G76X7Scm6fgOdqjEdUakJz/LhdxUz+8sh+UtIe1bDCUfoRVgifW8Vs28ivhL3llU71tnYz0m/G5GxdZfyNWXdWBAddBxkZRG4YjtIOX6B1wr/hEFx5h8YOnF0Z4Sl3D2SCIOl12cQfFseHs6EeQ9GIb0EPfLuhbpPUtLrIbHOP/DPhkr3z2a15UNJ2SXtRESLjwg4BNSHTo3ZmPXOSt1c6Q7+rIbwmoMTmZWCbJ/eFiyQPpdZbafHhd9mP8MgO4KqJlvMK3ExnC3eIb04jOlTvz/yRKpMioBQhEiaQuUVbwVjaRp1vMDXE7yeoyP+RaCFwX342UHEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFt/h3y08mHSkfpfZJ4kG76h7WNbkilOnR3CbFJs324=;
 b=SutUlcRy4es5foMjYRbsd579A/1BG73zrWr5/d1ZUZdhlUHdaHqN7QryJlF2R2I6fISExcCfJMolAm7grbYwf3gxRCo4S/ZgXKvm1B1hVqSu5NxdM8TN4V/ESu/bWPoO234SrUUVAXPteESr4JSULVB2+fdLQXclHGO2XglNC+L88mvx9Oh4lOUbbshEB2MfVbGvTvn75rAiQKzS6Gn+PPi4aiPEi2YPwobLzmFITuC7mMVNMPAqXwM9YCP3YghMEcqwrZwtVLUhhdwRsBQg/jJeUuXEOPsyuANEfN4gM+80p1M79pIZDr0dvb2aWXubvg6pAATTsVjDDB7U5YbUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFt/h3y08mHSkfpfZJ4kG76h7WNbkilOnR3CbFJs324=;
 b=Rl9BgI+oA07DpN8R3sD/vgEe1XGFuaKFUxvLEr4tG16QQpSMYn/RA0m6CZpiAomTEi/wI7AGKehW3VTOshCpnH1Rm1dqTxrdydPuuypeBolPwV69Wja2N4zxGVvJeNp+8wUZp131xurlCiFvLyS2PY4BaKDqjF0RG1PCQz6IKaM=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TY4PR01MB15709.jpnprd01.prod.outlook.com
 (2603:1096:405:2d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 07:59:54 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:59:54 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann
	<arnd@arndb.de>, Nishanth Menon <nm@ti.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?Windows-1252?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>, Eric Biggers <ebiggers@google.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 0/6] Add RSPI support for RZ/V2H
Thread-Topic: [PATCH 0/6] Add RSPI support for RZ/V2H
Thread-Index: AQHb5T2C40dZMNzzc0WKyn0WofRHq7QTgzvQ
Date: Wed, 25 Jun 2025 07:59:54 +0000
Message-ID:
 <TYYPR01MB15132652B441DEBC571798CFCB77BA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TY4PR01MB15709:EE_
x-ms-office365-filtering-correlation-id: f5e55c7c-7de9-4cfa-ae29-08ddb3be451d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?x32EVYqSStk7FWPT3ihci9+GiC/McABEfHkXreLWoN7cce1d8XVrv2K6?=
 =?Windows-1252?Q?jZ3lS5VbtsADFROCSuiPEegd+DlwCtagqYns33wxCgGQoXylNE7/i++4?=
 =?Windows-1252?Q?NMDD8mdmwZpM9JBAkoklHC9P6excoHcqS5OvzvCar75WGVsUrswdKgoS?=
 =?Windows-1252?Q?wtLwvA6PtX92WaePR7SAe6rZ8y2Taz7VgNMdW6CprG6bvnqeAHskIEq3?=
 =?Windows-1252?Q?t6l/gD9eKD8YSbOPsBROa/gaepIXbfsXjNYP+JlGAf86oOU6MKIO9Mmx?=
 =?Windows-1252?Q?ltwFwAZoNPdd9qx56UMmWRKUTTJknfaFq0cCi9rmVS0gMXvGxOOrJox1?=
 =?Windows-1252?Q?BXFYJISN0rCb/Rf8v2oVCrKoHKSo0e2kBFCJ8iPi9YmfuON+R+YNYNuq?=
 =?Windows-1252?Q?xO27DKxW2NL8Y15wXyjIy1NL4VQzOyKZ55ruwcRujgH+Ke6YY8VCvLon?=
 =?Windows-1252?Q?cecgq/3RsMAGlt07AyfxfqyxOnZcpB3JkXmOJNOMNznnxuurtIl+KCl7?=
 =?Windows-1252?Q?nOW8kVcAS6SpbVRQAntQScYZUhlQyMs1B+hU1zlLOmKxPjgVt5iJ3LCa?=
 =?Windows-1252?Q?EghEs4w9mU6/aSG/htISx6MUjnJZpEBXN6cJnImlk/b8oMaYAZlZnoLH?=
 =?Windows-1252?Q?Xl37bq4qktAftMS5JsD4XL0edSZv6GIQnoPdrBSg/d6sa4ho/W/6sHm5?=
 =?Windows-1252?Q?umdlSYydO1XxR6Z29Q5nEV221IQLckhFUnrSP001bQtJjlW82yTDR8fp?=
 =?Windows-1252?Q?t07EKNU2LSBS0XKilUInU3jAj2dOEylFwMNCnL0O8M4izWhIWIozgMf1?=
 =?Windows-1252?Q?y11WCNMi3wZf9PszKNBouL8c38WSRZhG+T1Rf2Bao0FURhS5ZW8Ng1nV?=
 =?Windows-1252?Q?C+2jA5L8v2uWIZ/d6zL82D1pMQ98M/RLwJsE+pEBrv8dnlD33H4S8+cR?=
 =?Windows-1252?Q?9izqLkpbAAcTaZZxo8aT5aJvZ5Yl7quMf/ZLAA0PE6+S/vJBmgPNg7Sr?=
 =?Windows-1252?Q?pCk1BJru0GrpVYD1T4e/WyoXjAc1RJiuVhdP0MiPAXDk9qnmjKpoqobU?=
 =?Windows-1252?Q?IJnqNUGstdam6csGuDLUKqgHnXb8oz1tzCxNJyLkpkzLju00MmamO44v?=
 =?Windows-1252?Q?nsygR8xjHAXWZMyndN5lvcIPqP7XabDaEolzighFGnOvypBHjBZni58R?=
 =?Windows-1252?Q?9QhOGsB2qBAgjUXvtSqNS86v3KjcPRsEn5cKqHbnLSIom7lyigECK8ho?=
 =?Windows-1252?Q?g/4Yvwxhm5gtEJUig4wwcelAXvu6eQvmWx/aEoqLxd4d/XyiLu76DtjP?=
 =?Windows-1252?Q?j5pAFy8djY0XDQ6K5qDfcUKJuUNT7lRiV0ENoeukV1cQBVBFp0MfN9NO?=
 =?Windows-1252?Q?Y/Rar2HPeJtLWmeq5MzaCU2sqVCXWkoKr7yGliw1pFwDuE1+sBUfhVX2?=
 =?Windows-1252?Q?YZwC15txJ8FD6s7a8gOlTlvUX1KXtfDdABKXJdXMn5KhWgEUw10TJGYt?=
 =?Windows-1252?Q?r85JGACOHH6NYM3vFnscGRYGE0wIG2EYjPw+IIe+XtDqGfFcPI4lsBx/?=
 =?Windows-1252?Q?JHFYUCA3G0VMgoSimjwJ3gwM8+0vSVeOUnqPMTsYJSp+qJc1/fUThdT9?=
 =?Windows-1252?Q?tsM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Xm1OAUrM2f4nHIt42hRigtQxJm1vR61YethlKlSY24DawSMYPQG18ipl?=
 =?Windows-1252?Q?GWpSmRWnK+CYg+Xbr+K1RzFvMp46e6JThhPvyZdCf8a6+zyXZ77xcKb+?=
 =?Windows-1252?Q?Cc2wBlh+2yNFTeQZQtVUhEuHc5lnClzLO4J5TgaRlD76bjr7KsMR0DUw?=
 =?Windows-1252?Q?OAA44OCUioRD5Kx7i2J6YdlommHtCPlLGZGnI+b5aKnYP2mPnG/ZJIst?=
 =?Windows-1252?Q?wpqUGc8rCvDlL1jMpWNF14WcF3xkc+KWYRvtbM0bGL/FlyJo5TpcYVqy?=
 =?Windows-1252?Q?VQkYfB2QWXtOhGsMDad8bObtRfDZyVJU7witQlHhNtYAVPxOgbDe9J/a?=
 =?Windows-1252?Q?gCEvgRJ+eS8LNe3WcrqZQLRmrWSZ+o+pM4EpAbsx/W//D3P/Q98Su4Te?=
 =?Windows-1252?Q?QokwfaNvFknPBJwbX2nyyKLNB2RuqBI3mM2ZfZ+fOgrdYIPzVtYGc6km?=
 =?Windows-1252?Q?/8Fqg1dVLoPkFFd6ka6vYYOdCWbfDJrQ2mc8eXU6GE1s3f16dgjPiSO7?=
 =?Windows-1252?Q?Ib35bG20RKM6iZIy7eIF3uyX5IVYSrxZxybmTF4X2HLx6qQIljsjmpPw?=
 =?Windows-1252?Q?lpe2KvfQxzlT8Hl1QevQiDXCSOOJWSgt+rv2zD+YPAg9vgYf0CwhF22O?=
 =?Windows-1252?Q?7f4sJ9EUZ69vGeo8wSO+Gnp/kE2NxKUp7D32Twz/roW4K2LKnNRno5NT?=
 =?Windows-1252?Q?J33WAGbnycf8cmCNfZuMFQMS7qDEcFpdbVQV//cyTQj7fouYEKtYHfJV?=
 =?Windows-1252?Q?QialUEwwFnfpH0/VzYjwA/k/8GVVnCuvwNV4kh7IJqFveGbVcYCZZP6h?=
 =?Windows-1252?Q?Z7pMLr0WzKmCRD92NZdvRtwFhIpiGNbVg5QkEgDvw33heoZ4x3LASC0S?=
 =?Windows-1252?Q?yeEkFcSNUdMKsaR6vmQQLPQyP2BAQeT4zHcQoNWmCZdtrCVTHCW4k11F?=
 =?Windows-1252?Q?dHciSsTDZ77jKVw0twlm00UXB9tZ7fJcLNUAT+fVIhp4PPfiLOuCgiQp?=
 =?Windows-1252?Q?YJg8mqdLwapMs4iTIRjIU9/uzpCDPBrE2D+x7LEhOl82DH+opLWiE3N0?=
 =?Windows-1252?Q?6zLocDoz5Bc017zesPdfunRdtEnf0JLouWYNFP4rWmC6QgqcEeDpvZQ1?=
 =?Windows-1252?Q?0H1pTXBP8Wczo86xDSJ+pyLHtgkBuI5DAlYKFXu5EuoOZSkR2HzvatcV?=
 =?Windows-1252?Q?1qyxFPesfgsr5S0VHOwLM9E30RdFsPMN7n2szc4OPcAkyxgCplSv/+oc?=
 =?Windows-1252?Q?0TL3Gs8JHaFy+0EnG8vj1zodpiPOUj14KckC9rbBo64oUYXf4nOO4/4G?=
 =?Windows-1252?Q?h5lCo7+i/xEPDZrzcp9dtlDXqrkJ7kbkprZbDuboUwKreJq1S2nBrF2J?=
 =?Windows-1252?Q?uqCLbAlNLkiGc2VzLWVR/RTtqDNnFP+smwtv6KKZGQ9m67GBbk28JTW+?=
 =?Windows-1252?Q?VUapoQUN20ln2obBuAsMW3CSnfRDnTO89oSEN6pvabXihBi/R/lSeRFF?=
 =?Windows-1252?Q?dF17zlws/5XiDtAheSrJ3ha4+GYFBZftRvbgUoX969Gy+iXwJz/Kilce?=
 =?Windows-1252?Q?digD7XlEBHxSOy2ZyLfsNHIVPVzWSro3q2L6rEFe2E7R4wINq8epf6uK?=
 =?Windows-1252?Q?GYkaSpdubhqYzLB1mNNHQ2aTf0hQZm6ovLDup2zfkkIZ5hbhWrU+kyiE?=
 =?Windows-1252?Q?ZJ0FSKxAIQ3kEWt2RHsoUvQGgaSAvySLpWrcKKcc+7kTo27V+q85xw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e55c7c-7de9-4cfa-ae29-08ddb3be451d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 07:59:54.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngCCBG55OwMQAQ0D6XHE4j1rZ2OudLJVLc78/cUL/a1q1EVM1/5PcDK8wqAS13uY0OSECVr6hj2v06AXUDNtznaW87+1v3RF47aLUOGi5j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15709

Hi Fabrizio,

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 24 June 2025 20:23
>=20
> From: SPL2 Bot <spl2-bot-eu@lm.renesas.com>
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Script fail?
The patches in the series look okay.

Kind regards, Chris

>=20
> Dear All,
>=20
> This series adds support for the Renesas RZ/V2H RSPI IP.
>=20
> Cheers,
> Fab
>=20
> Fabrizio Castro (6):
>   clk: renesas: r9a09g057: Add entries for the RSPIs
>   spi: dt-bindings: Document the RZ/V2H(P) RSPI
>   spi: Add driver for the RZ/V2H(P) RSPI IP
>   MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
>   arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
>   arm64: dts: renesas: r9a09g057: Add RSPI nodes
>=20
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      |  96 ++++
>  MAINTAINERS                                   |   8 +
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  63 +++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g057-cpg.c           |  24 +
>  drivers/spi/Kconfig                           |   8 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-rzv2h-rspi.c                  | 469 ++++++++++++++++++
>  8 files changed, 670 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-
> rspi.yaml
>  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
>=20
> --
> 2.34.1
>=20


