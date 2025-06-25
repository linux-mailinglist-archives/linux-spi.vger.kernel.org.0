Return-Path: <linux-spi+bounces-8758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27076AE79E7
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FF0189B372
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DD20E31C;
	Wed, 25 Jun 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nYw2PnUe"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD01FCFF8;
	Wed, 25 Jun 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839682; cv=fail; b=XWwNX8E5ksmaRf7aWu0V5x0DGRwgWmG1amAopo/RV3BLAc8AqIaSyqvcauvthQVg9qeoIx+Sz3qPx+vRYPt5tMKUkPowpZxBL8OCK+yLSApYhjcdC0SzZijjs783g6yLjy74QnfhKqJFdHReDHkGmFipLSfxVW9161O+ioFU/8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839682; c=relaxed/simple;
	bh=v0ciy9RVLKl/o0yLYvL4yijs2aUtIGh6ThZSkrrTzhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W0emQ902vCFlWpEpOU89/XE7Jxp5GTZhkXSf5v3M8tLJPMbsHGbqoIFM4ZVAOjAiiU63SMewwfqZ3oragJfX9oUO7u0OxFknTBEuZYJeq1ae29xADgqUOIOCZV0YL3nShtzi25BhKRm9Ss9oSAs1Jv3iELHPb3iGVdMCuc3piUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nYw2PnUe; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIXegIzwc++7wg5uNpVNX5BgNW+GJqyZgIq8OOETIec461BjEEfthZvpQnCNrFk7OgzdRJmKfWXh71adGhXAQfQj0xbEoI+924pHN2IR47ApCRHtCNte4RuWNB0lefsV3LPv/EYIg4rht8hJ76I3kGg5UNm7YcwphOrGcUv7ChCjnVKF/U+ZByYRRWEnz1rsCsogtG33uZM/tJttnN0IMSCFimPzE923HzOXMCN8kXHnX8rxzb8CHkH3yqdCwV/So97/oEU8SIa9e1XuXIYTBWAYFCoHpMgiSwAy2qb/7BNbYMOw88mYDJTwbyKcqz6lYjLIsZBJDxaFV+cPR51C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp6PU5jZEUwWlanZUwoDYV0cFCxZpBEyU1ZEm5seabk=;
 b=QZchoe5v3S4b0H3xTWKERs5o+0kk2BPdUX44elRFBelgsesb6QiR6aToYilNrgJFrRf8t60wfm34dGXwl66jblei2WkiuXksNQnfQybZoVrbvqsr59ZvDOHhaIiU1632kF/PwKlP3Gzv7cP9jpgFwhZ1U06twRuadJK5cHnc7Bs7cfHQFhrNKHZCa6Napp2K2rwq4vUA9hAu2rpvz7s27B43yO6UHsU4ocfAD+GjKy1DrDPmTanoKPatz1ok05VIoqIwkfm85vQHhKsVDwyXFZEWA3A5paSbQXvB5UuJN5DFi7MAJp/cdtnywYF/MlsUnqtLGiAvPVpiz7BeEy+ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp6PU5jZEUwWlanZUwoDYV0cFCxZpBEyU1ZEm5seabk=;
 b=nYw2PnUepwx65UjC1i612f6oGBzT3cMsb5NT1oAGgeywRs+XkUTO334ASHTvpXLoB1wlqzZT/IuSlX9G87cb7ycEONjgFfRZuWp9pyCcm3ME1wQIZRO3bJMhOShfazK628nuFQwJxCZirL096JygWoy+iF/fVlwperPMwhRF10I=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSZPR01MB8735.jpnprd01.prod.outlook.com (2603:1096:604:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Wed, 25 Jun
 2025 08:21:12 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 08:21:12 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann
	<arnd@arndb.de>, Nishanth Menon <nm@ti.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
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
Thread-Index: AQHb5T1xscIuIrIiBE2ZRy7rZHxWQrQTg8oAgAAFYhA=
Date: Wed, 25 Jun 2025 08:21:12 +0000
Message-ID:
 <TYCPR01MB12093CC4F24CC79DC86873816C27BA@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <TYYPR01MB15132652B441DEBC571798CFCB77BA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYYPR01MB15132652B441DEBC571798CFCB77BA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSZPR01MB8735:EE_
x-ms-office365-filtering-correlation-id: 752d3640-2d21-449f-cb9a-08ddb3c13f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?S9QFOQnM5D8B3s0AcWBIZ3rRWbEYj7X7Ky0l9Biaba2o0ls70QTgqEL0Sd?=
 =?iso-8859-1?Q?37zZXTXn+Eol0ysN7yTY25GqBbUt23y5/LtsN7AkQmwz7g5fy3i01P2PiG?=
 =?iso-8859-1?Q?QnngTqYWaF+P0+eKFkveXROOPcV/ynb76tzZdPid+6eNIRbGpkoMkmvv03?=
 =?iso-8859-1?Q?HM5OWKYVP69wuMQlOTi3atNL7mlqSzqnS0rAf1iQVNApBgXVkzDauwrbQo?=
 =?iso-8859-1?Q?XZLIcx5M75js7P1FMKDk/AXJelQJVPPmV20PEBEsbb9Ep5eULGU5qICJic?=
 =?iso-8859-1?Q?e+3rkGVf05/NhREmQ7TWI4M9JQq+z/I2DaEDU0uJI6myCBkLukx8gRhk5Q?=
 =?iso-8859-1?Q?a3AHW2H6rB+OOV4IrwuDShE9zckcHr90ILQqoZM7zuxZka1u3jFazFUXNQ?=
 =?iso-8859-1?Q?KTowQxmCtCV7yJ3Q/1FpiuB1js1jmdyD+YRkKwZeOUdsAdgN4sjP8sHoFN?=
 =?iso-8859-1?Q?uzG2od5oGFHTWAA22PB+OI9Dc3ZJUY3y+xbgGGXHZK3hKeWUXyFKsTj5ck?=
 =?iso-8859-1?Q?LzOPnWXkOHZwtZP1dcpfT4E/SjzR01Mc4KZ77kvP3KTi+81+BOdwoyfh8H?=
 =?iso-8859-1?Q?7BkTBJX8Owirz6h3Xg1dJAI0xGejA+Rrhq0kqCLCbuVRyM4qHgwwvXXYh2?=
 =?iso-8859-1?Q?AagEqrx4js9OmXYkM8fzDUzx98C2wi4w/hCnOtgpJ/q1YbVdji7TGE/W7d?=
 =?iso-8859-1?Q?Cun9dw2qRcXYcYNafbeQBXHo0BKMNYoosMnt1EZQjEcGdkDxIUeZiSKZYH?=
 =?iso-8859-1?Q?m652uVBaaA2eQJl795LJLm5SDFODWyd5xNPIK6u4ZsIxrl8NLNLzX0EPe9?=
 =?iso-8859-1?Q?A3pMDuJlZWnRa0dPL/O/TNJSMAOUg4PtKQ/ZVGqu8Mnk0ytJCOHUa9QWbQ?=
 =?iso-8859-1?Q?XX4ccjEf9OxJRnxwPIU2K8SyVkRVxd85ljmzadIXxYHq3zw3qULxSn6lmz?=
 =?iso-8859-1?Q?nd+FYLL4IjomhTDLiiVZJoRhrEEWkQkoc+Tw4C40t5ojVf07cCoahmvTSA?=
 =?iso-8859-1?Q?osqrAravWKd8ObzgxRu8bOBKp1oeZGeV0UBqd9MnCwN5fAalNMj1atp+2G?=
 =?iso-8859-1?Q?5xxvUEUWUEQJu6Kb0My5gwVMPNVGgiaoKGT7TO68ekcd2lBQYYyfWxdFz7?=
 =?iso-8859-1?Q?mAhfKWeXQ8SsqkgUOiG3H3bJAKA6fCCA5E4TgccHsAXjqNHCUJhAi4hGjV?=
 =?iso-8859-1?Q?frtnfMBG7nFLrWKN0dpqcrB7d8vBF+n9MIGrC13bMPNTMRZff/o9XRfgFP?=
 =?iso-8859-1?Q?mxBIEyTdH9XIZP9aGcrx1XmLSyPuIFif2D/y0J8nmFd0DnpPwzPFUerOfn?=
 =?iso-8859-1?Q?zQTI+TElt+cx/SzDv1TAYLpJmrvl5zGZ6zv87DH4oR7B3bZuYF8PsdZ9c/?=
 =?iso-8859-1?Q?6/aJW5NvNjbGhDaIW0N5fGFqzBOLuAV2DglfqLhQnLnMB6hAvoZMg5IyD9?=
 =?iso-8859-1?Q?MVPr5JcGXkzOgCdCbX7Bcg0R9hc5ID14uPMF5yFm61EXL3hrzy6rO3nLea?=
 =?iso-8859-1?Q?8Kp1CXIdaLMOZpzXa91AGMbosaaahL2t0eeTrOisqF9v6r62SdQXopt9Vn?=
 =?iso-8859-1?Q?V5UO3Fc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Eg8ANr8+RH0eljFoXt9C1kcTJiBE3ni2wSw739iNUz+fJ166BJ4am67ZOz?=
 =?iso-8859-1?Q?JSltUi4ZIeEcyeuEIRrFMls6tHo/IWcUxJ7OrS0cCaRnsoVCQDoV+pjJgD?=
 =?iso-8859-1?Q?UBDdYEF7EYTGMecty+06k3v0tW9QJvt8JmAaGdoRPJZN7c+bPtaoyWMW2W?=
 =?iso-8859-1?Q?HVspdZrpfd0HlGbo71k36jtLP8oYflL3meRCIdPitxGQokGdlKU25LJtHI?=
 =?iso-8859-1?Q?9g8CIxW+3wl2AqlBXnemoKCLf1XyiSNysPhcIJEe9F7KQ/TOxkuNNkEkXg?=
 =?iso-8859-1?Q?OGXRIA3xRYwPMpu5KJoui6JSBjCuHFLpzthy4wDoEy1xOG2pEatlZrItvi?=
 =?iso-8859-1?Q?we553rbSBgBekq9Mqbdp/VsIh9H1dfMOM+4dpKagDSp3lhw244KIA0SDtr?=
 =?iso-8859-1?Q?1Tt2/XRaTJExmNHGN03UJJGH3lEpoaAgqyBvR3gTN0ZByNfx8ZGVmlqhR1?=
 =?iso-8859-1?Q?CFsAj8HmzPzDkcTzYV3TG4SEP4sJSTXp1fckYQJhNgGApjphz3XFNZQNFa?=
 =?iso-8859-1?Q?Nmi58f7KUziTZHu/teKk1gx6fDfAqhg5QstX/xi/iU0aFKWONk9q6xZ28a?=
 =?iso-8859-1?Q?95ZJxvCicd5LU8C6g6RMkw1d3wmhCCcRgz9paaLDjSInQzhGZdcbCwGNB7?=
 =?iso-8859-1?Q?cOocHMdkVYn3yJqKJcnihhjyI3dxbWxEdUnIzYCP3+7JiAGGcKU5C4Y+Xd?=
 =?iso-8859-1?Q?+QwoNMT23c8fzACXpi1yTqc+2Bxs7K42q7Dbx37cbadl/9TE8BK7gey++g?=
 =?iso-8859-1?Q?AcRIje13y93L+KySZaOqwr+m7mA6F03lTwZP5BVpVvyMVIlvzXkg6Ks54K?=
 =?iso-8859-1?Q?fyRCp33Zz5Sh3sLH//tRuuV0IKtUR9VIhd5IVjyRl5LoVuZJPnWbS+Ju/l?=
 =?iso-8859-1?Q?clE7MJrYQczWI/f5hOxG7U3a8ew+xad8LQyNpjBbn3Plnx+g308OIPp3wN?=
 =?iso-8859-1?Q?Lp7fck/sHlK7dybTqm3Q932tTxwWGljdfaNyCRcqs2hJ1489fZ8FaHcK9o?=
 =?iso-8859-1?Q?v1wcoiar1PAZ6y9yoZEnk49bd5fCxERjlbGNiQeLXN6Q4oxr4cps4N95/v?=
 =?iso-8859-1?Q?QNNyLe6p0A+x527GsgpJ/pzQq6aQtvZJaWVamxxnuXAJ4O8ER+wLr7c5c6?=
 =?iso-8859-1?Q?+LCSJzWSYjEfaNR8ZSg28oiVO+D7c0IWEGg+uqCaOYtELSyoeOC9y5BKOL?=
 =?iso-8859-1?Q?er2TJdYkDHdSVYVBF2Mpsq/YY1E3qDD8W+sdsulcPqhOOi7e9jj9xb7FsZ?=
 =?iso-8859-1?Q?AaVg8HHPP0ifbMZe+mr1/yJOe2PZZ0f46dfTnMv1Di/BRgf5Zw+M9Cztjc?=
 =?iso-8859-1?Q?t+arnxWtSQoWxbGtJaeX8pkoeBJuKLSHObzXiO5vpur4tMI/iHhzj08imp?=
 =?iso-8859-1?Q?mJ279G6pTabvpalj3uOqibUT/8xlMmprf2HpFIhOrXZe+8foL8d6TgL/oQ?=
 =?iso-8859-1?Q?Q0FRWNat1KC3XXr1L45KvfZzhSnk5b4Lxi10bw7j2OgvDdGI+jEnc7lxDe?=
 =?iso-8859-1?Q?fWgy5VEuNxnHo97TcZq4wh5M5TFo4pgyTJs7r/b1FOTPJfQniAE840sXR6?=
 =?iso-8859-1?Q?sfLsrB8WQ/H430Q4n5F/yCzurlFHwO5TZNNzal+yFm4KdzuPHqEcP2MUcH?=
 =?iso-8859-1?Q?wVhNgmZELo51zm+4erPhsbifX0pOEYn52BlfKqYPO8fUsDoP0FsFnHDA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 752d3640-2d21-449f-cb9a-08ddb3c13f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 08:21:12.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2bev1RhJRlm489iqudBAL5ZmQnTjZUvJRHl95fuy4PvTaUJwT72FQw6WvBnw6hMlrakO6ntC2kBNc9Ed2NzVQWbdOXot9OOnLhp+DHByic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8735

Hi Chris,

> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 25 June 2025 09:00
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Fabrizio Castro=20
> Subject: RE: [PATCH 0/6] Add RSPI support for RZ/V2H
>=20
> Hi Fabrizio,
>=20
> > From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Sent: 24 June 2025 20:23
> >
> > From: SPL2 Bot <spl2-bot-eu@lm.renesas.com>

Doh!

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> Script fail?

Indeed, thankfully it's just the cover letter.

Thanks for highlighting this.

Cheers,
Fab

> The patches in the series look okay.
>=20
> Kind regards, Chris
>=20
> >
> > Dear All,
> >
> > This series adds support for the Renesas RZ/V2H RSPI IP.
> >
> > Cheers,
> > Fab
> >
> > Fabrizio Castro (6):
> >   clk: renesas: r9a09g057: Add entries for the RSPIs
> >   spi: dt-bindings: Document the RZ/V2H(P) RSPI
> >   spi: Add driver for the RZ/V2H(P) RSPI IP
> >   MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
> >   arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
> >   arm64: dts: renesas: r9a09g057: Add RSPI nodes
> >
> >  .../bindings/spi/renesas,rzv2h-rspi.yaml      |  96 ++++
> >  MAINTAINERS                                   |   8 +
> >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  63 +++
> >  arch/arm64/configs/defconfig                  |   1 +
> >  drivers/clk/renesas/r9a09g057-cpg.c           |  24 +
> >  drivers/spi/Kconfig                           |   8 +
> >  drivers/spi/Makefile                          |   1 +
> >  drivers/spi/spi-rzv2h-rspi.c                  | 469 ++++++++++++++++++
> >  8 files changed, 670 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h=
-
> > rspi.yaml
> >  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
> >
> > --
> > 2.34.1
> >


