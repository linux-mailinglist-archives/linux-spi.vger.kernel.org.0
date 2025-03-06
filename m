Return-Path: <linux-spi+bounces-7068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C8A5529B
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C8B175710
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB525A352;
	Thu,  6 Mar 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gjvA5mlv"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC125A33B;
	Thu,  6 Mar 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281100; cv=fail; b=hoPcvnxVVv9qgCjkbE9JhfmLIlo7yLA0n6mo1d6QvPv85WD/xYKmdX92iWgoJDu5+B9zuj1/7vqTVxhiIPot+KHrgTJeLmUskMVILDbCO0MQYvy1YVAw25Apw6WNGs3NfIEUldAlqrTOJbI1cx0G/ayQXj6/JvUxt/1Asy9ll10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281100; c=relaxed/simple;
	bh=x5b5JpMhw/Za3IabgYgHJAEXmS+HJelZX0ZA2grjxrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUXl/Yif1R7nc/mti35IZ4Ujdtkfzc+O0CB9+3kAjEMPCa94WaVkpP3DydwBSgN2MC3tMy4+JIPEYObHsUk4CAqTue7klmbGIRCuFxQnpa8fpgz+Sisuae9p91CwjAa1HAhkMLSVowPxWvAs8G0tngzqi/Y3XjyyhMrOdCi3aYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gjvA5mlv; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC/piZydliFIe4Bgw3NFs3w9ZZeYwiXe/7rtStggSaBb2x7FBCb/YCRLNvQwfVD4ams8+oPDrQmnZD/0cDzJkHGtl9K7wQAOYU5m2iyXVU0aRoaYafPREe1JRDqUmzRuTEWkYV+AfJpsdHQ0SCYNHd5gNhzH4hfW5BtjU+wMejoxzGIYBbaqjc27GUTM+mEY4boAdHfVhnaPZAsAqza6kZjtGzLxS7PAVxbyJ84oEtdCVPfP6HpHOPnIkVNfgcBwY/LJUYdQ2yntvt9nCoPCQkQcwP4+RaeTZNiQy4tjuy++372lZFb//JSQI37HJrYhcx1M0Qhjw5l6JpYn2WsfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdVbFxrFIAB4/dyDenCZf2f+GL9rPd/yVDkAzxDIvQI=;
 b=QuEV9Rd3H2xLEBJ4U3SJsnb3cBpHoFcYTCxWVDPaIx8p4s0r29GbKzphaKGYg8/mGDTisol83I64PP2SzPGErgJE0FVPI8FYjeFuJpta+fGYk4vnLoz96LCyJCVJKXykcdMrzqIbXJLi/DRm54ftiUD/DtkE/olZ4QqoldKuJBz/HHTDXi6r0iZxNXw3zkShQelCKS1mTR4Sel+mPq8fbC8PrWM7UIs9gqOBoxLj/e7d36b3IezOEkGRkfAsHqprxU41w6SxnxdePH/JHeyf/hmB44Z2N6A+49wMst3ojQYAQzaF9NsccNdCu4GPbtOeMTab9vEBXevgYvN2Sg0g6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdVbFxrFIAB4/dyDenCZf2f+GL9rPd/yVDkAzxDIvQI=;
 b=gjvA5mlv6AtCD+/ZBBU/Fuo+5D5LT1zh6yAcp2k1LyKO40IMHKdIxPZ+DzeRYnWotjfDDpubEs53b5ENgepXoO5QBm9yAJ5npTIpzZAmPDSb/0KFalArd09YJaKOopROMU7/BXZfLRpRaYspW6WP22QC+ryxVz6LfUsGUclGiHQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB5694.jpnprd01.prod.outlook.com (2603:1096:400:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:11:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:11:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v2 0/8] Add RZ/G3E xSPI support
Thread-Topic: [PATCH v2 0/8] Add RZ/G3E xSPI support
Thread-Index: AQHbjrnxOUA4uaf5RUG4lFktD3wm4rNmV6Dg
Date: Thu, 6 Mar 2025 17:11:32 +0000
Message-ID:
 <TY3PR01MB1134671B7220B31A785C2972686CA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306170512.241128-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306170512.241128-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB5694:EE_
x-ms-office365-filtering-correlation-id: a9dba2ac-e72b-487c-d565-08dd5cd1f12e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7wlM2qk+zuDKHjg96qI2cUu3fgQyRbMyhw4yIrSlW3koO8mKZnQ1zce+oOPg?=
 =?us-ascii?Q?UhGmDqItmdA5czMsvxzLUsnS6doe2pGCkM2j+qPXg9GS0UUEzbCiTa2kUczm?=
 =?us-ascii?Q?TPe0J1omLiIgKcGlM+LdIvl2r0yWtMOixt8OpyzAB9uMHDnkn4teb040RFSh?=
 =?us-ascii?Q?pBmEq2aDOAwL2yU/j+XEsnd7RyKEiug8b+AupJ1uQhb12DFaGEmcdi1cOuXR?=
 =?us-ascii?Q?2W95Hg8yHuXvnomQkTPNG4eweWNmx/S3vpbG0VRj+QDLDUgLz4FWAihshKO9?=
 =?us-ascii?Q?J42vFkLH+nqdY2n5xH5S3c8Hn7jzk+ljs2zs1ad9ijBsk6/h4yRwZtuevZ25?=
 =?us-ascii?Q?T2hKAyajWfWYTmzM85vLTmiiG2JKEg+/O7WKWZz61s2Orgtjt7s3ZbpTAdn8?=
 =?us-ascii?Q?PKGaMVaiHJwMatcFbrImFwYrsdPQw6/bLm+AJJjD2hO8adHDt+CodRt1xlRM?=
 =?us-ascii?Q?YXxRN1dZgWH93rKc6jQSTZ3naKIFfbq/FXCYTyydEfkgUG0KuGj+QVBOYQdp?=
 =?us-ascii?Q?MMw54aasxtFgbzt/kCgH9FrJsfLK7cKtWITjzO1Z6ikFfkiMVFuCy5SIpEZf?=
 =?us-ascii?Q?3JohgCW7zuzj+6ZyR1JAsbqwM7huoQKURJFyhrjUHgPoN8lpe2OGQxaBPJnx?=
 =?us-ascii?Q?d1jBd2D1DaZT22VRrlTHcERiZek/uVeLRe2SlCdpl0MIENc050jaqlaRDXm1?=
 =?us-ascii?Q?9xPe+uRKmBlPN2oFCRqzbhc9PmEJI4GNkpdw1s19vOg2zDZFNdr9ROP8Luaw?=
 =?us-ascii?Q?tQGKY5j98M3Pr9CcuMbQXhIWPiFODyloN6YWsZt05j4Keo/ly2AAQuAeGaoI?=
 =?us-ascii?Q?zZQRZYILrLY+sJfbA6fMDxciRB6fiUExQPhjT6zazkGKpst7fFuQV81O1s0e?=
 =?us-ascii?Q?iS2v7qbsBm4zbVXS2nfJcasuAba8lJsTihZW0Hs3uU/Z9ciu6Myv1Zjx6mT6?=
 =?us-ascii?Q?+T2DMRm46O9hHFCuwSYqbnUbz+fOCmeq8Vi83APmL0b7+cSbkvhVm6jizqLa?=
 =?us-ascii?Q?aHLFHNbpMY8EOD0ncKEG8itOuhJEs7ji13C3eIEWHLEZZzLUI03JagDmbAyn?=
 =?us-ascii?Q?KxAUs8DdSApmXrSQdO5VD3iXkSeelkAYzQDFFPff0TvZTIdkkyO7pBP92qLN?=
 =?us-ascii?Q?oeRc2Tj2dGlAocjrLkx/55DDsdz5qsoTZwfqC4vKvti3HD3Xw21oG10DiFST?=
 =?us-ascii?Q?F5Q2Prov3c3QQc4wnw6DtzZWJxBuaHrK+BuiFlvwsUfG1zWsbXbouIBN7CrY?=
 =?us-ascii?Q?qSvaK3KIlxnAaIZPBjauZORh8Lluot94TWN3uIsqH5PNQZdUDOUGqxutsmA/?=
 =?us-ascii?Q?f3asuh3PJjIZ6fRDLERur9aDUZjcFd3ybIZahHQHVjR+zF8mJwlyMtRVrQLA?=
 =?us-ascii?Q?PgR22cAawN0Hqn4CKchac20IGJAjThWC7qjiCZgR36v+ra/Hjraxm5FoIVDb?=
 =?us-ascii?Q?/+MDv2u09HARIW7jEsWvCdm0tNzYB1Mf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sc0SiINBJ4k+zpwZ8Bxe/j0fCl2xuni7aebNZ1jp9ltVMqzp14jeMm9tbJkC?=
 =?us-ascii?Q?Yius5+KGOkRZJYd7c000v+hnxstKREUtOGEdj6GA4TFOEakpXMwu4TKMCYoH?=
 =?us-ascii?Q?MZplNufY/wWg2fFSAyEam/+x4FbjnX/5Yk4SRDuQ4+33H1uOkbkZ/IFHhVfl?=
 =?us-ascii?Q?I/RqwTClU9v6kCUBrOY9+IKCha8s7QAFK6QGAVjWCxKKYq4H/7rlokiK4Epe?=
 =?us-ascii?Q?DFPzpZCwzCCFnQ+fwiXpeTdXc9MHAHH6BnFGNwqLSLefREZnTuy65KEtckgr?=
 =?us-ascii?Q?Bu2CNYv164ol3G5ERYxcOYXGlBOPYOzOu5J2zEVjVA1bbU9yapsSBCb9KeMN?=
 =?us-ascii?Q?r5GMJfZ+ORwcpSUtba44mBNoFtIUCosf3fitc85hEELf/qKfway2m+Y1Ilgq?=
 =?us-ascii?Q?4U/aBxl+sh41C9NItvJQWDwnzm5J9ncuFOC0gJALx4NcmjOXkBpFW+omv6kc?=
 =?us-ascii?Q?HDizAnaveN8vs+R3QvrWXOzsRHAXqAdVAxJHLXFXOLADqEGvhpE8LNojbJvF?=
 =?us-ascii?Q?vSr/FrTRJ7W6bG2oi4HGby0Jzsxwnm7lX9garE+Yu5SoaXEl2oxAlkGvqdyk?=
 =?us-ascii?Q?eXyYyEVgjX9Z99RGyB7+1gfx1QOSIBFFTth1mYJAkF0sSYaEmPPVLvhORNky?=
 =?us-ascii?Q?Av1Ew/8nwCfiAXOmDnHaWWjqSv7YZdhG7xi/JQY2knKkpFTdOrQ/ZcNj21G+?=
 =?us-ascii?Q?wNsPQiEQFsknme0C/Jpqr1WLTeD39ZIUCsK5l1DGf1K0Pk51oUk9On9Pm3eI?=
 =?us-ascii?Q?k2ywhlT9n83SOgjpX9xqECHD/Dm7vOurTYjZkDc0bFLbPAskF2EMc7a98drT?=
 =?us-ascii?Q?M4fhKc0622OX9D3DgORVeI83Fzfjn3UIptE/piDB0s8lhBd3VuRA67sxjtH8?=
 =?us-ascii?Q?HpqTmYNaRgDitXLc/EXI23bCb+tA+iRtgztP+1nP56mf+ATjIqBzVAgyojbs?=
 =?us-ascii?Q?2PY5Yj9bYFUKBF7fIWuqqQi1vflAWxWQyarcme2sHfHHhkRu4/loRRM3RUUD?=
 =?us-ascii?Q?xTzOjHEKNcbBzws6Vu2fURd01YJyPq9aHs1SfF32tfNbiKx7InzSC5+3/qNc?=
 =?us-ascii?Q?SwgqP3VL9Ec9/gkTBZDlYHjstM1pQf/pHhVqz8r1bsJixSGChcg6tpK3xr47?=
 =?us-ascii?Q?jOoa6C0/N6145Hqr/lVHV9jPupVcs+jm3hem58NuJA0K54SLMd7NGZWYdpLD?=
 =?us-ascii?Q?GM+1bJbanaju50oQDamnsW9BhO9WsEtQBgnuY474MnRb4vP3tN887L2Cn3wC?=
 =?us-ascii?Q?G6tuXRHTMPH5knpncBTbNs1tPhqdP/hSnEa+j94mx/5vSBjnQ6GFikMccGFC?=
 =?us-ascii?Q?xFZf4RfOT7XohIfPdfvJYGhX/szBUm/1bWJZsHH7a1io2nkyOjZennDjBzUO?=
 =?us-ascii?Q?pa2zqyOX2gHCsBdv9ISP99Fe8PfWyvfy8fF+q0bCD80A/zA4IA4uDdgxXcGM?=
 =?us-ascii?Q?Q+wBGNLOtBQ66u5CHdf3DoJ6VI3Wld8IA1KVKM70AcLQX4iugb6/BKDRSHEr?=
 =?us-ascii?Q?T0ceyz76YVR2lq1ell8X6ryDie2Excw5bLMMoLcmMZgM//66ASB7oZVt5XWs?=
 =?us-ascii?Q?3Qp6JA65vhmJ5eEF4tukqPODvitska0uCmLRCGCTPjbpnWMI7CYnzLjPa1Al?=
 =?us-ascii?Q?Jw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dba2ac-e72b-487c-d565-08dd5cd1f12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 17:11:32.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1gx5m/i+TJ1g9I8JIBXelXCD9Uv/1gKAGHjXzmVq5+iJgOor2hMrWmqrliYtMVIcrl1ucRoSgxKyKv6ne+cDDyQLTRpH9qXwgxX60ydSSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5694

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 06 March 2025 17:05
> Subject: [PATCH v2 0/8] Add RZ/G3E xSPI support
>=20
> The xSPI IP found on RZ/G3E SoC similar to RPC-IF interface, but it can s=
upport writes on memory-
> mapped area. Even though the registers are different, the rpcif driver co=
de can be reused for xSPI by
> adding wrapper function to it.
>=20
> This patch series tested on RZ/G2L and RZ/G3E by overwriting boot partiti=
ons.

I am resending the series as somehow, I missed adding addresses to patch#7
and it is not part of the series.

Sorry for this.

Cheers,
Biju

>=20
> v1->v2:
>  * As rz-xspi is too generic, replaced file name rz-xspi->rzg3e-xspi
>    and dropped generic compatible rz-xspi.
>  * Dropped prefix spi from interrupt names.
>  * Updated the example with above changes.
>  * Retained Rb tag from Rob as these changes are trivial.
>  * Fixed the build error reported by bot by dropping
>    EXPORT_SYMBOL(xspi_dirmap_read) and restoring
>    EXPORT_SYMBOL(rpcif_dirmap_read).
>  * Replaced enum XSPI_RZ->XSPI_RZ_G3E.
>  * Replaced compatible rz-xspi->r9a09g047-xspi and device data
>    xspi_info_rz->xspi_info_r9a09g047.
>=20
> Biju Das (8):
>   dt-bindings: memory: Document RZ/G3E support
>   memory: renesas-rpc-if: Move rpc-if reg definitions
>   memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
>   memory: renesas-rpc-if: Move rpcif_info definitions near to the user
>   memory: renesas-rpc-if: Add regmap to struct rpcif_info
>   memory: renesas-rpc-if: Add wrapper functions
>   memory: renesas-rpc-if: Add RZ/G3E xSPI support
>   spi: rpc-if: Add write support for memory-mapped area
>=20
>  .../renesas,rzg3e-xspi.yaml                   | 135 ++++
>  drivers/memory/renesas-rpc-if-regs.h          | 147 ++++
>  drivers/memory/renesas-rpc-if.c               | 665 +++++++++++++-----
>  drivers/memory/renesas-xspi-if-regs.h         | 105 +++
>  drivers/spi/spi-rpc-if.c                      |  16 +-
>  include/memory/renesas-rpc-if.h               |   4 +
>  6 files changed, 881 insertions(+), 191 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.y=
aml
>  create mode 100644 drivers/memory/renesas-rpc-if-regs.h
>  create mode 100644 drivers/memory/renesas-xspi-if-regs.h
>=20
> --
> 2.43.0


