Return-Path: <linux-spi+bounces-9050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44319AF953B
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF1A1C420B1
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6241957FC;
	Fri,  4 Jul 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="cie48xhf"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010022.outbound.protection.outlook.com [52.101.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACE130E58;
	Fri,  4 Jul 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638648; cv=fail; b=ZARH+TSIt7BSOR2e87VLp0nrrScOnOLoKIWmOyaI+ULkSWfSuaJ8CUE3yjBADgDlZjZVudXFIrYEv92mbv3Q60Sc5U/zOmi/vJ5ZhH/82M+EjoGPUbnD6CTDYJP/16Qg/ABYPoTHpycChwbLc6fq3ihcddU9UjCaGVCKVKIaFLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638648; c=relaxed/simple;
	bh=gLoOC/yy4D+IKaJko3HcCYoPPZ20JrvVNXfWcUPK92s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJJ9GEZenB2fnHHddXpnpp3ZZkR98sqHc3sW2HWKjojUl7w+Khh2DpQJSe49w5Q1nsfYSlX1y9L0HvVT7OG7rqcbqxs1HulGEhqMOvFOf1PO8ZzELnVwpZA9BPklmENTI8/bEvcZQ4Dn/YSfr1nL5ptBLc+kqwAqmGyP0UGSPBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=cie48xhf; arc=fail smtp.client-ip=52.101.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIqFBlHAh/Vlfjs0u43wh530eJZ7gafUQhv5S0Aq9AM1eqSKyRCwlhOoodNbbFqL8niwssYNnQFP056J3KDtP696x1DRn5q6fTy08ArV8s4xE7ryuDQQ1P0JJ5bCuG3yc6W6swQV6M0oVXAfB2m1SeHE0Tkp/LBv2d24VRaXKTweV07EzS4Cl7+u4JK9qD8f0qgRuBX3GTTOSKNjSvop18waxIsd+j0io2q38n1vtuo1M54ehY/Nu/aThj7NEdPRTEf5cOUxcrfhTSyk2K+eo6a19WzXZYBvMR9Z80J268p+g7zNt/SO3q71c8hihAB/Gk+feHYNF+wae3ArS9m7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQk/tSY+HFMsFRpD+hWYh4CuJduD2DTDScQS6ZiDmM8=;
 b=KbNCUxh6a/alFHecM70fBnNaVcQl+UabHJxua7NTD2pHf2iKU9zjN8MRNAL2ekLjLYLkLRQZQWgJfSnvf4WIodlt27RkyX1lJn0TPmwKMWt7Q0y/D79oD9ZK+5hGNrrzpliO/mp2RpnmWCiVJYwoxXhi7UEwIUTMEi3TIZtLJWiU5HUkMEzacVQFqpEVYt/faCuqcthQvE8OXmnR//Bcl3SF2WUgI3DVsUlQWXXd5RpwTdUQTSPjFc19KLz1WPLFdD7EwU3hHYM6BO3jvR2XMOwOHZvjpGT4R8J9emM2D6UMnmm0x5j1nTrblRdliBtYWPdaMVjgEnK2A9jbr7+2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQk/tSY+HFMsFRpD+hWYh4CuJduD2DTDScQS6ZiDmM8=;
 b=cie48xhfYSOSlwVbm47Uj0ddI83X6wRj9DdWqH/npcL3zricsf4ks3dx9fxuKJB15KyvLBS37xe3eua/7J976pjp5VYVGEEuzccVPyNxS0tvEyKLIKx9+DSUQ8UB6mM2JiP9wpqj2TEHy+Btb3H5s0U3SrDlH8uSo2dOUJsnaIc=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSCPR01MB13298.jpnprd01.prod.outlook.com (2603:1096:604:350::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:17:23 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 14:17:23 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Biju
 Das <biju.das.jz@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Topic: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Index: AQHb5T14qAnsKZMNTUuJ9m/tpR5+9rQUPs2AgA3SkCA=
Date: Fri, 4 Jul 2025 14:17:23 +0000
Message-ID:
 <TYCPR01MB1209371D193D48360CD5D09A7C242A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
 <b4649385-ee50-499b-a965-e08f04fe0d3b@sirena.org.uk>
In-Reply-To: <b4649385-ee50-499b-a965-e08f04fe0d3b@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSCPR01MB13298:EE_
x-ms-office365-filtering-correlation-id: 1eac3acd-70e6-4b85-2cf5-08ddbb057f22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nqXifogdLjcRk0hYWJGicweI8gGF4faG88HvyEem4CK/GKStRNtnIKP6Wa6B?=
 =?us-ascii?Q?cH/WBa0dDXfpb2iDTDHo4F0MPGe++xr4jdgsnlNfL4u6lMLQ9z945aaa3wQd?=
 =?us-ascii?Q?JzfoJZUr+wKAqpOiHO2zWVkShUQXph2mEBVb09kQw13qVmftgkuhZ9sOJR3g?=
 =?us-ascii?Q?HPXUwD3BwzwmKBWYhM/yH2XQJPKVxLmtPS90ky589kYFLpAGWYLeFTinUhaQ?=
 =?us-ascii?Q?yzoPKuaYY6Emub9jKd4G6KuUk7PCjyo/OEV7nEkVU4qqR4OH9Lh17D9tWOdU?=
 =?us-ascii?Q?nsAi/hUqM3mOqrA46sYyu86l4hFOZjg+KQOgHhyp8XweRm2pyb/s3Anc2Z5p?=
 =?us-ascii?Q?VoF3qh7DqHUW6Kurqfg5EJvHRw276Y5cwGcOzwnZq4ZlBAvM7PzxH7E/3kgu?=
 =?us-ascii?Q?LnrW3aGEzI3uxkPNaUjW93iw3gZs4LU+50UVklx2t7V9jGMh5WJRTzHNRYbW?=
 =?us-ascii?Q?x8ELcvxRse9IlP+6p5O8DfUFJRyl6WhVWnUtYQLZ7eS67xuRT9eUk+Io+jX+?=
 =?us-ascii?Q?vUvd/FIk2F1oU2sIKdG7XXAaywqN8NZltFlYwqZGRTvTBMRFmQGGWDLH3pmp?=
 =?us-ascii?Q?RHSO0P5SB4a5nuMeBXNYDVHs7h1Uz4kUCJq9DZe4T7i6Vp8Lco2M9x9sWccP?=
 =?us-ascii?Q?SOOntxTOcpR5EvNgkWkrqCGv1s1xoCCT+2Y84bjWEt+LNnS2+vPZFTmFVEb2?=
 =?us-ascii?Q?+WtV5vkrxv9/OnX7h6+KfkZNq6V0nWMyWtyvkG9YP4WA414VJ4GEOHILNLAv?=
 =?us-ascii?Q?3SIUKVjj+kVw1OQjIPeHhbX7EHSBAKybS2oWH1qXMoFVNp2wx72AJxIsjLZe?=
 =?us-ascii?Q?EfLxPPrRma15Db1FezgfdN1RoV3VP/qmeAtrKkEGWJsesoVthU2eA9X2rLog?=
 =?us-ascii?Q?6Q0Ha8y33/bJ8KDU4fBZik0AV/dtwFAif/mIUOY3EWpOHIFNeZTK057gBPid?=
 =?us-ascii?Q?eL1HcIqnqsR63eewxsLV3jBerQrPxenRUCqrKtx47u3LDKllUc4+goyLZvzp?=
 =?us-ascii?Q?zpqq0St5cT3yt/SAupgwS8bOrZrs6o0wDIcjZSC2mEFs4G+/cdVedHc4wZBM?=
 =?us-ascii?Q?eUuAAC83BuajiwYP4H5sAsFCU9Z1hpnsFNsQc6ADoQNioC0VGBcea0BbZBDm?=
 =?us-ascii?Q?FbxqZbIs+aUyclbo7tvIMk6njZApksaQH2kL+k76ZC7W4npcYyRkfQ9WSsWM?=
 =?us-ascii?Q?oozodbqqjwWj/jEV8K9Eg+3muhwGiFmL5K/DVGHMt8RjbQd81n4WfSDw1+hV?=
 =?us-ascii?Q?nY8qYy3bc67AH1wfMnXRoxsDN/2vnx/DOnHwFqEwwWxz6cG7QDcxu0GYjFg9?=
 =?us-ascii?Q?qLOTdcd2qTL70XPHVM7tnX6NHsCqmXQNswCrdCShEprEtmK9uTAtKTxUNZPR?=
 =?us-ascii?Q?l2biKpjHUX6/VqqxOludzKaXR9q2L5qVpe2uIiEde4mphFUhay9Kch2DS1ds?=
 =?us-ascii?Q?nQeYBqk92QmFgnSXbFy6UQhBo+gviz3wwn9WOkr5EfAu/3imGwqHvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YP2T8FlVcy3BSqhc9cf1DtZpTRkoPvnMqgdRTvnJt4TuuIRGBCUDXC5SvrCk?=
 =?us-ascii?Q?3rcmY1UZ9sFCqQQTBkVnBi8waDuzYP0iKcq02+VKTy7Dt7K+HGe8421dDFyw?=
 =?us-ascii?Q?9O2wUG0NB2RYFlMqthkRCjHbij1bQF782qD50ZmvQ2b0uAn+BoNHQZZNKEQN?=
 =?us-ascii?Q?BPGT8IMg7SSvuEKEbrUwu//KEf2DA9Ghl3dwxKXy6BwP1uWstPO9SkA7K2V7?=
 =?us-ascii?Q?QaNB6Ia0O71XYwMN/Ueff4L+U7juh+wTA21eZIJnBo8soQVn6a85HuaVguC1?=
 =?us-ascii?Q?OwQSCpb8SE2UEoVsAGxeyqQNw05E1ayWoLDqpjgvtluetnjUzrmJ2qcocTu3?=
 =?us-ascii?Q?aOdn6jQZ2TdNfk1FDqT7FyZ/zf8F8r74LfCWsSIJazKu9x05WgRA/VGgsuR2?=
 =?us-ascii?Q?7GGsAXlC2WeWaF6sgXY0JMiBj19rwx1bAkyYQu6C6h6l7/Di44YuCcMPxSs8?=
 =?us-ascii?Q?LOQdyabF+/KDC7kBkqtsJMRu1/3dnD3gEZNXrXGVE5sVeb1tmGdTDrZZvvkq?=
 =?us-ascii?Q?04FIKPVkLvQj6pAdD9H+MgRopxuTAL6WUtC8HSwk8lumkYJHP6XciZ2ekQKy?=
 =?us-ascii?Q?cc2oIhj7zU+nBKQ/QaG9jAqx3P2DCNW34gyXU3Z0ysKXePrDjks6CShkveOl?=
 =?us-ascii?Q?LW5y/ViZo681OzC/31SBnsMnZ1CHGIT+/Up0Zu5dZKnrdyY3E0MuKI/9F98r?=
 =?us-ascii?Q?z5OeX8ue2OjnKY+VqAJ+zYeIx+ulcXuazWCVZG8U/Ymt+AQRxRc+b1TZc4NH?=
 =?us-ascii?Q?BLbuNs4PkYTspDcUsiJ9mikNI+JRU6U2TX+t8tzck4dTZ2NXZvMvlx+3imF5?=
 =?us-ascii?Q?up8zDxeBSs+MKlPmE85lR6zVXVVAFl1C0OdU6Hk0TvKQSVz5mor7tn4+azjA?=
 =?us-ascii?Q?7duHx6ie60wJCTXD8plhQ9N8Z/IqGDLoHhY2EtbmK6yVAdBwq+ptSGtzb+G9?=
 =?us-ascii?Q?0g3PVAmWd7tCPMFbv7tk7WVEQ/kWMLUPARLWJ71Y4PiICuuDJsbueUUWp850?=
 =?us-ascii?Q?DWDvNkLKM7vtnFiD3xwT+wLQKkZwyPCw1Z4s3yHJ9skY3f2Eu7ZVcLShF9YE?=
 =?us-ascii?Q?rP9OEAWNTEJmwH3AWbMliM1uAt6ABa2+Q5OL8dwlcUow1TLsy4FTmWKeSUKS?=
 =?us-ascii?Q?U83R6dDPgN9h73k5e3nExceFycT2FGeCULha7ybkwtBKf7GLgHtAhVVcBxQE?=
 =?us-ascii?Q?RFCrp2TywFIjX7hZLtj86MjDlthvrhKYozAJvKDGEY1Ed2Fvb0rf++k4aPji?=
 =?us-ascii?Q?WeUYOEFun48cI/5ea2P+RQgaa9qxtvfIF9LJ22/FURhRPD+dY5Q5LrRvGPy8?=
 =?us-ascii?Q?1xnUN3JLypE3IwD6BjRuFEgXtSyj1qPIniv0q8MLBv0TLKvx38r/ybtDylms?=
 =?us-ascii?Q?eVJmcvimcZgK1tUe5yP/Fnio0OvzwSL2L0lo4bS5pe0vIyNo67O/6oQymQxU?=
 =?us-ascii?Q?0d7gtJO1ynro7NKB45m6jO3/hQWi6gbSfbXfWLS7D1pn7D/Uba8woTz5z6UB?=
 =?us-ascii?Q?siEBOftF8MSla1RKbaox/XcwVHpdJ9+NSGuG36XCWgxfi4HoesA5rJ5DMQnM?=
 =?us-ascii?Q?Wj6y4Amfs426mTRsXoim8f0JAY/68x1sWerW+gmvHzBUBFb3z77IdE6GLS9g?=
 =?us-ascii?Q?MQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eac3acd-70e6-4b85-2cf5-08ddbb057f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 14:17:23.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fI045w87mzyI3PWXU9kH8MMXuQUh/E98K3uNCPPn7YNov4PyZx5EOgSl1MnjFYiN7tRVFOu2Lz+1gDccrzC+T6w2Ey5k13xRPhHQ94EsYxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13298

Hi Mark,

Thanks for your feedback.

> From: Mark Brown <broonie@kernel.org>
> Sent: 25 June 2025 20:09
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>; Geert Uytterhoeven <geert+ren=
esas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>; linux-kernel@vger.kernel.org; linux-spi@vger.ker=
nel.org; linux-renesas-
> soc@vger.kernel.org; Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mah=
adev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
>=20
> On Tue, Jun 24, 2025 at 08:23:01PM +0100, Fabrizio Castro wrote:
>=20
> > +static int rzv2h_rspi_unprepare_message(struct spi_controller *ctlr,
> > +					struct spi_message *message)
> > +{
> > +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
> > +
> > +	rzv2h_rspi_spe_disable(rspi);
> > +	rzv2h_rspi_clear_fifos(rspi);
>=20
> A bit interesting that we need to clear the FIFOs, but it's just one
> register write so probably not worth worrying about.

I can surely take out rzv2h_rspi_clear_fifos() from
rzv2h_rspi_unprepare_message(), as rzv2h_rspi_prepare_message()
makes sure they are clear before we start transferring.

>=20
> > +	ret =3D devm_clk_bulk_get(dev, RSPI_CLK_NUM, rspi->clks);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot get clocks\n");
>=20
> > +	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
> > +			       dev_name(dev), rspi);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot request `rx` IRQ\n");
> > +
> > +	ret =3D clk_bulk_prepare_enable(RSPI_CLK_NUM, rspi->clks);
>=20
> Are you sure that the interrupt handler is safe with the IP in reset and
> clocks disabled...
>=20
> > +	init_waitqueue_head(&rspi->wait);
>=20
> ...and the wakequeue head it wakes up not yet initialised?  This is also
> a concern during unregistration where devm things will be unwound after
> the remove() function has run.


Good points, I'll move devm_request_irq() to after the clocks are ON,
the resets are deasserted, and the waitqueue has been initialized.

Thanks,
Fab

