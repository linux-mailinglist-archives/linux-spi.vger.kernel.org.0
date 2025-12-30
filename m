Return-Path: <linux-spi+bounces-12168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0972CE96C2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Dec 2025 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75BAD3002848
	for <lists+linux-spi@lfdr.de>; Tue, 30 Dec 2025 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33A1A267;
	Tue, 30 Dec 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="FpB06Gc3"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AC1E1C02;
	Tue, 30 Dec 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091023; cv=fail; b=FMeP9JESKDlHQZOlUK/0NYwVWcPHuL4FhqDGyOCQLezcmEHJFpWmYNus1xs3cg/q0e3NCHeEjcHCsUBPn9YPJi+S5L4fdlg3rBE/scwTcY9n73WrYLTX9E4POKh8IFJdAzeRAs/zpU4KYChM4qkzMdJev2qaTEzZKLvT681LNlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091023; c=relaxed/simple;
	bh=yOaSYoepqlDRONbQ14bYvTyrSvaf7SX5Nx/XCD37sm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNVatgPBUkWnwgG+EwxfbfnKSZRzdnjxFGAvPcdZLp1cd1iCY5HNPf4/TRx5MPvZPghvvZdbCFdlWsLbLtnVghNGeNQzyLcmheOIqHc6jPdV3Nfiek1oe2vooBu2qir4Tu7t/eWRpsQDA+I6+QWO2FAvsN0z99JBmgnPGaaA7D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=FpB06Gc3; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOtDG1MAT4vFSzEREkXotaZzq7sC/LuWEflCQDLEEA7Km/FLLkIrM7NLOlx1D4uFhfSGqTXEbUJjv+ixuuB72pY6purOd+wJmWHuxbx+cLg0RKHVlDrJherlyKjMMbrcSN5cGRuXs0C4hmcdiG5LXAJ8LsQ+e5RKPTnmRTb0VfKIAoBYGEOYnNnHTN7LCvosOks8WYC/2Sk2mQnxBPv5Dkqn8FHiSmgJan08XEO5zWjsn7N6ZBL11V+DF1lfZ4YlHWd2znRW0Jg2drtdPvz2yiNAE+kOu9/+4j67uSq2BrnWfnky49HdgI3uo5bP9CnVyISoC6OMqGJ5h6HUy+PhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h/l83wYyQQJr2xmF+HXjY0s+mX4KwaQNwNC34o5YnM=;
 b=AgCA0caN6lc8SFnPnsD8QgDJMUDtC9RmJ7VCcDCuE1H9W0By7eoem1Fb1yo9a+SDNsMMHVojeMxKwF6YsYcsGG0JCk+tyFuZqx3P1qWNcBIuyY4qxB/TDQNujr8B26jXpqA8qzQB0rdfzNijXhQgY5VakWtgkBK5PQfm4EbIp42G92a+8vnNQvc1QrQ5sNejlR04Unop4QoaMgzM5WPaWr9VDLgRkLCc7wyj7IsYT5L2CZ7lGDAGF2KggeJjw7szz3WZbqfywzPOgrH3v0gQJdu5nELqcUpCwB0SxftiADQfxxYvpAYmvE6UNZEv42eKQlFByROgxcnpVRI9MW+6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h/l83wYyQQJr2xmF+HXjY0s+mX4KwaQNwNC34o5YnM=;
 b=FpB06Gc3FGGXDvuRLsxrwJLvXHcmlvH5F5f+kEtQI2vDS+/hKKjxWsRf+YdHGjY5JhjeQ84BHU0NVrFicO9VjD5dshrRNyqVcdQ5AR3x0IrLiYXNw9pHxflw+3Hnt4wD0+nFPcK2BLPDPABPNmIgGxPcGt2P9s3sTAhTFPGjIwCuZQ5WqC+tTl297JoxiZK8pU/laUfpnTUo0KmjKz8Ehk8MLlZXpFKtnuszgutlbmKY03km5f3qr6qvURlnkGs8DF/51kuiiOVf1UFsa9NuCAQ+tNoy2xxHICcOjqhl1UgOhayDrOGbLDfpXoHuyr7m/wDV5/p+6Ju7e+XWuyygrA==
Received: from DB7PR07MB5324.eurprd07.prod.outlook.com (2603:10a6:10:64::25)
 by DB9PR07MB9989.eurprd07.prod.outlook.com (2603:10a6:10:4c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 10:36:59 +0000
Received: from DB7PR07MB5324.eurprd07.prod.outlook.com
 ([fe80::8f63:a64a:4211:298c]) by DB7PR07MB5324.eurprd07.prod.outlook.com
 ([fe80::8f63:a64a:4211:298c%4]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 10:36:59 +0000
From: "Mateusz Litwin (Nokia)" <mateusz.litwin@nokia.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] spi: cadence-quadspi: Prevent indirect read
 timeouts
Thread-Topic: [PATCH v2 0/2] spi: cadence-quadspi: Prevent indirect read
 timeouts
Thread-Index: AQHccGYy9Mf++45C2EWr//V+BLLuJLUvfGKAgAqMpj0=
Date: Tue, 30 Dec 2025 10:36:59 +0000
Message-ID:
 <DB7PR07MB53244FFE1916FFFA205D249199BCA@DB7PR07MB5324.eurprd07.prod.outlook.com>
References: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
 <176650963782.445653.10248419661863551247.b4-ty@kernel.org>
In-Reply-To: <176650963782.445653.10248419661863551247.b4-ty@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR07MB5324:EE_|DB9PR07MB9989:EE_
x-ms-office365-filtering-correlation-id: ab5f3d3a-1387-4494-0226-08de478f5ca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?tFqpJ2rZRbpE0HGepiot2dR5cXJxJ8Y8YuKEm4YIYJPLhSv/8yAUKWqmKt?=
 =?iso-8859-2?Q?RH3erVhCMbOoYBCEtrOMP/GOW0jMxRy9YseXUFFFHVPdy5hgkuAwPcZNU7?=
 =?iso-8859-2?Q?HzbGnumYq9PycVUT2BhTgF4ofAn6yxJ9p0UAzOh4Ldg6UAOkSUZbmiAOaz?=
 =?iso-8859-2?Q?bQqAML/OQhYhmczykOXSLwDiNPQi/wEG+nZEPxqkPcqH2nlmLiT/ivdmQR?=
 =?iso-8859-2?Q?0CT3danamNdo+JMtWUlHXHsjf+RsNwB8nlmt7xoytYuz5ZgVbMWYbGsjv2?=
 =?iso-8859-2?Q?uJOtJqYf4zyLoJf+SUtowCELV7VyePmrKpw0cBwuF22sTqV9ib1qHg6Bx1?=
 =?iso-8859-2?Q?uSyJl7ul+u77gZgLuCBts1M+ixiJTexAhFRK4GZ2OL5Y3zgUMXrpgh4So3?=
 =?iso-8859-2?Q?68XMOejgw82C0uhTKcudHsa9lZX2lGjfSB+u/Ymt2Z3CjlVB7l+8R+Agfw?=
 =?iso-8859-2?Q?kReF0bSeuYFuvRxfiic5WTU6e0pe3c9P09yeMOowlBDksJaER7wkL0+3Q5?=
 =?iso-8859-2?Q?E7/Eg1S5xaVgyya52qqOI/dPVGiHqv4Z2a2o2syf1P0gIcXDSfOMitph0+?=
 =?iso-8859-2?Q?ywE4K1pS9HW1vKuxa4xl83HYLbF+5esmiuAhJMnlZ6zua5sN7BnOZkP+S1?=
 =?iso-8859-2?Q?05tMFuh03Vz0mzATVYgyWsCx/5E9RWvJwYcgc4p/08L0CaxhhISuiQgreW?=
 =?iso-8859-2?Q?gnSu7qaKvzVQqziLj10tMJ/5RGcVjujVNx4mUTxjfQLCW+skaJX3FQ0ggU?=
 =?iso-8859-2?Q?SrkEDE0W/Fboxm/uBtrk7kI0wR07cTzB5W6Jz4vVSvn0+uTniYS3HnDaUx?=
 =?iso-8859-2?Q?5UzNnTeF28x1hAptkeP2RiM0c/8PVlRc57xd9AX/g/Wm32st9oGGT4Enap?=
 =?iso-8859-2?Q?4/xo4QP/I1ycJL9APRcpETuCS8610TZ8dUVPo7RIbDOwNxv8/LCmXZzc5B?=
 =?iso-8859-2?Q?0bvyqvxiSIu9Gr83cs7TYM0QvHUWs50y2QI+l8uUZ+xL2K2cyrOBBmMN8h?=
 =?iso-8859-2?Q?Sunja+JHCToKGfFfiE6dmJZJZOdtVgQrAmeihz0iFr54Dvh2BEK6PYcrJK?=
 =?iso-8859-2?Q?Eg/U6eZkfu9UlaDatuLKDYDKTbinQBlEuhD0/79lxd/PSOn+Pqr9Lp4Z4v?=
 =?iso-8859-2?Q?p4qZoIs6bsLutk/ZNptahaXTN249vJvvfVBeoyQBXlsHZhcJ2WcUUE3Xcu?=
 =?iso-8859-2?Q?B3jD0JiZigl14/zaleDaVRVpSOSDUUSdWQl/x+d7W6k0XQlmgmoYV75eQU?=
 =?iso-8859-2?Q?rnHB0InSiBO8Fd2PLdsJuqjtyxAdmG53uRrfeEprimEC+ZUcjwN9if2aDb?=
 =?iso-8859-2?Q?crr+V9R99VliYDphvtDWPnfgAI78DWu2v9exoByRPrn2fmF/xIpJHSVvC/?=
 =?iso-8859-2?Q?4TUpdj8iLzHd9C/dDR53AE5zbxkX/ILA3FpCY17HCkEcuUoUc+yM+/wvXW?=
 =?iso-8859-2?Q?AkaDUYHDDskuyM8crhVvfxHmH8TzzDZv2wdcvDeEPh4PCyyGnNT9C38ZX3?=
 =?iso-8859-2?Q?3kQRIc3Vx4yzwsjFC634BsvBOUr0bKXp+1XVKINCOYBWxcepVdIw8RYV0G?=
 =?iso-8859-2?Q?symt4QTTgk+d/HakhCmHkcFOL4Mr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR07MB5324.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?F1nioPs7tCH17AuuRygyh3dCjK6g5AwLQadEaa81/BulI0tDgwmoTdfwYT?=
 =?iso-8859-2?Q?ZGezsP80DSkQ4pGTegicRh2OkJVTJbYVP8EJ+tOUi/juM52Ujg3LzA/I3z?=
 =?iso-8859-2?Q?0ISCNNXkOKBcOtGK0GyprAtyGjSFnIXGMpw/0WGwr5ZraCdiJnwP6xtv4c?=
 =?iso-8859-2?Q?YrLOJn/BuDa1N/mtRP81bi8LVlH/5BzH0i7/CZMncmlmCKk9/eZWcOjpr6?=
 =?iso-8859-2?Q?mGdHBEZczZCqhbS9zI9GALli6gj/gXVYebMQtceP7wSeqFvR9paAoEGy0f?=
 =?iso-8859-2?Q?EbF6NSQnTDhcSmWzg5957QUvNWtoKAMPGAh30Gb40FbCB+MUrqtN9MJnEI?=
 =?iso-8859-2?Q?AKctDA82y9kwYlrU/Kize4GpPcQizYy49tzRYilIDh2piJF/pB6K15Jou5?=
 =?iso-8859-2?Q?DE0ZQvYnb7bGSo34x293T75P2mRlZrcGM0xSkuA0t51k95makIw4NFfzuW?=
 =?iso-8859-2?Q?GDQTXAyF+VXa9s83WP1OYt+n1RWcbw3w9Cj+Zd3fVuaL09JQJs4iyEG5oo?=
 =?iso-8859-2?Q?mTyfnk+OPY0rVRpzYI14Z9dGx927WOcZPppJ4GdJmur1NkSOFRDXSReKhP?=
 =?iso-8859-2?Q?Q1i/+0ijJi52/Sj5cU55IkZa8ulce3HqUWB4AWCYYVbgETJf/uytVhS5XJ?=
 =?iso-8859-2?Q?4QDKYBLzlveGrUmAtHf47EG+QNWwPm8KmsmJS2K46AzXiVmoW4/FxFAn4G?=
 =?iso-8859-2?Q?SLeqznkcdnfD0Md4Wpx+doijbE5k/VFlQJBXjDon3ePQhF8Bb15Wy2HpCd?=
 =?iso-8859-2?Q?y6ylhi37lSb3sCpKTA9B4dLlYwzL3n6jNFoXmXjuzcVPkC0vbXgk0BjDLn?=
 =?iso-8859-2?Q?z5ZE5+uBtHOzm56bgolClHks4ZCAWMnbkBO/T3PVDbM/01RMA5J2SOYbGP?=
 =?iso-8859-2?Q?PGItVmOLI69fzCWEQNOHQ1ltKHwqJyBqOnk1AUz2eKBDrvE+2tW2NeCpnD?=
 =?iso-8859-2?Q?ukneVeER/8uRUuOC2+gBkKca2r0zAvIgw/b5TX/y473X8a4gjh2QNGCS4N?=
 =?iso-8859-2?Q?R00M5eyiAMyXNnaVMiRYRX9s2CBOIGaqUl4whmyvaa+LxZOcCr6lYaChFe?=
 =?iso-8859-2?Q?m4WVnOVugd7nmh7qzzcYfXTCBDnBCBRQNC3Vhbo+v/lB0zOoLFn0kebaMM?=
 =?iso-8859-2?Q?ET7Tvp9t59HKhoR5MAvnRXEWc2BVdkLPD+Z3bESh+VBQv9hSMSlz2Beagg?=
 =?iso-8859-2?Q?zngvgpJOC8BviAot9xJUFcjdnNCXUOzsbnpt9mzKQTBSt5f6QNACwJMbHV?=
 =?iso-8859-2?Q?E2z1z7BMA/gt1kLGYK3bBMjhjthHMvhOEivGYvDYHMxUE/UURxGoEDyejG?=
 =?iso-8859-2?Q?jKBZef3FEj47e6s6SOIK9EGFTZM/pJ45uDaqQ85dPACkP+ZORBj+LCoOUf?=
 =?iso-8859-2?Q?B9HXVv03Km8weSo9OPJSMIoNLFaztfBihcFf0fKIePY/FDSGyotEx8lhcB?=
 =?iso-8859-2?Q?c2N24cIkZaT3TKRwWgM+tIvXJ1m8YJlRdHH63vvARfk9TyPzRAHBkulLHR?=
 =?iso-8859-2?Q?VxJUGmoKqWoflXTZIPw3B1K1sATYCkN2V3rYa/kDH71l12pnsEi4C2ALSl?=
 =?iso-8859-2?Q?TZRpx3TUEMrJjJhTJwDCxhzFkVYD+god160Ef/V/L7gtLuQDMj/GfV/OMH?=
 =?iso-8859-2?Q?goSuwJW2/b1m2rvS9BNtomzS4l7vvo2d8fJ+RuXW1LupQB1tV+MkxwoehZ?=
 =?iso-8859-2?Q?O4tvzeMUhwadky7if3twQsWwszSjTokMc9KoOKY66WIg0dDwSLKN+zFRs+?=
 =?iso-8859-2?Q?wE139881oQH/E4DaLFmxtl2QM25XNFOco6JYgOsvPWJ77I+vfJl5Y9Xnc2?=
 =?iso-8859-2?Q?v9g7LUHtIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR07MB5324.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f3d3a-1387-4494-0226-08de478f5ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 10:36:59.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOFwz0d+NWC1I5UdbC1vZ9mkEuNj/JAbqAo/tywUJDw+e7EEKp7RrB7/oZtwpYJ0IUe3lP1MM7COvfGPpBY23l6XOzqyTwvjimiUjSMWk7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9989

Hello,


> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!
>
> [1/2] spi: cadence-quadspi: Prevent lost complete() call during indirect =
read
>       commit: d67396c9d697041b385d70ff2fd59cb07ae167e8
> [2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is slo=
w
>       commit: 5bfbbf0a49ee4b5dcf46a3bfd4cd860d72cc887d
>
> [...]

Thanks for merging this patch!

Apologies if the formatting appears suboptimal; this is due to limitations
of my company's email server.

Please let me know if any issues arise or if further fixes are needed.
I'm ready to address them.


Best Regards,
Mateusz Litwin

