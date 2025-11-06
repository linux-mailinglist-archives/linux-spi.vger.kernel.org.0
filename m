Return-Path: <linux-spi+bounces-11099-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6FC3D056
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 19:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A01056009B
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A51324B10;
	Thu,  6 Nov 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Gla/VtRy"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEE204F8B;
	Thu,  6 Nov 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452130; cv=fail; b=nnQf+CSQzjHk+lY7EQJJFxbU2ONHW0D6huwxoVrBb/gL8SZJiwXLQYjQHhBibAolMlTtF3KaBImHWq9cT9Pt46UhzBAxdCkrJPcYnzL3LJVc4Ex8g8F7h2GhotNB4XC/QarAdotdS874n8Xrnq5sUpVxizpNTbEF9hUJVZaE5W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452130; c=relaxed/simple;
	bh=VEZ6yoASyuYmWaJuXJjPQPdgQGs2MoEUlY4qe1SUBLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KuGXxnby7YD2FZddhPHQ8rxLeX6wUyHuOHDEIPznAYyDkbQkROYnTnBgTVyxq6m6kuqhqcp5Awe0gNIov1Et+9u7StPFfyUy9w69tzg/b/KF0ip7HODcKff+UL3GVF3FunIHSkEQZ3BlMNt1JOLy6rD3p+zdbQndz3PRaGaKdhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Gla/VtRy; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdOxVhs79gPzwnqYHpKy8o0hNkF4jalTlVx2OffQRo3bpFA8mHlH7frRzOyXp7Yf1QuOwUDA5hq4UdQ2DOQj6YnqnoEEYFdKPihpl6ZoV9pOeE3aSH+oq08SQUteM5K0fzsJH56s7IXsTA9MZjlWegRgDfR5fn7azeNg8EB3F+BSaJDyw203cQRAhKHzfheSf1b1IIx9Ebv1xqUQWTjo5oAjvnCIYgqPhU5XTRNgNQG6sf7/dhOB5bfVKkIVzuOvrJf46+1o0ve6MfEF21Y0GCY2lgpoEMUHWdtPblISGf+QysBSsWmZjcm8U0WMK1GcgNtTaeyP+4QuC6+qT2LpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEZ6yoASyuYmWaJuXJjPQPdgQGs2MoEUlY4qe1SUBLs=;
 b=YGmQFMtAE+TeGT5NLe2punYKQqc2YveQl7OoxeUyjtNqMtRp9Sf4c/z0gJwwKrdN90V0fByCRcbCK5L4SlO53zO01NtrFuCO4yWbvMOfhDjQ0+wX9zQlH2rOuqcDDcu2FIVPotkQpie+eAC9zlSv5u/+5OQJkOGnR224RVHTu3GzZ8lu/FaxVy245KINeKAgrJ3vSfwjmuiOl6cbVUKx+gRt7PL8PCAPHBK+tku/kqYNW9+JKlWwbvAzrEa194Hwtl1hlm1PbN+Jrr+y+WGUtVKLnrqfcgAECqnd9MTMLKRLT7iEZMAIYRd5mT2WHq1cbS5YCsz2XK7eC4reHt6Vrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEZ6yoASyuYmWaJuXJjPQPdgQGs2MoEUlY4qe1SUBLs=;
 b=Gla/VtRyC5R22CyXig0XcMx1/SOX5DbTElVXNPiuegrwIWrUVw7A2m1lad2PO6Uno83cK9WXP0XXdV6yyyiInM9jl/Lr/K7skWjOz9w+1KUsw62IpTKJWXfMFsyVbfVmkCWmEHHkBd/WhG0zQ90yVTa1Lz1/KvOPlTn/bXU1gHk=
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 (2603:1096:400:2f6::13) by OSCPR01MB14532.jpnprd01.prod.outlook.com
 (2603:1096:604:3a5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 18:02:02 +0000
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686]) by TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 18:02:01 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
Thread-Topic: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
Thread-Index: AQHcTjTIdWNta6y5E0GwjMRvj5rlDrTl8VWAgAAARFA=
Date: Thu, 6 Nov 2025 18:02:01 +0000
Message-ID:
 <TYYPR01MB10512F74C2D89BFE757AC7E0C85C2A@TYYPR01MB10512.jpnprd01.prod.outlook.com>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251105091401.1462985-12-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251106-anchovy-font-33e9a3b4efe8@spud>
In-Reply-To: <20251106-anchovy-font-33e9a3b4efe8@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10512:EE_|OSCPR01MB14532:EE_
x-ms-office365-filtering-correlation-id: 69078e78-0ee8-4a8a-bdea-08de1d5e962a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DTm/QELTZNJidnNEJ+eqYqSDK1+liFVJ5R6if57lnDNrknk1Xa/07A2idPq/?=
 =?us-ascii?Q?eHO2flf0SU1NWHGlabQWKrvjEypSds6qGfegMDCp/nDKHg/HYWFItoPQ8qz+?=
 =?us-ascii?Q?fkb3MrYTrj8DivLb3zlOf8UMG8kX3AlG4sojV1VRE7s6cHc2marCFn1Tzs9P?=
 =?us-ascii?Q?zcGVWuxVG/CWV9FEOkebzgJq5dpIRJ+Xo2YMUtAylSazaLV19CqHvXJ43IJ2?=
 =?us-ascii?Q?0tPMlLXMI2eWkFONxlLINoYA8EPBgz5FiLuLejuf8rHqLwjUgP1mTL+Nd4b0?=
 =?us-ascii?Q?BpeoM8naST+zRi7oTjmR7vL2pluJs5G+trP9irhb7IobVHBZR50v2tkCs2ny?=
 =?us-ascii?Q?4usfr/JgOdkcwS+SWfWnfvrfuqZ5b9gK2JZwGsb1RTC0JmIlkm+grn+UnAma?=
 =?us-ascii?Q?tamzGL67oy/hZb9zHvGom7C38/f/lujdiGQTA96nu2/X3YJLbrVfAc/NDoZT?=
 =?us-ascii?Q?M1kvcp03iUyf1k2WSK9MT3Nlsm7UXRAj9mzFPKSZ46pURjW/+QdjkKWwt8wR?=
 =?us-ascii?Q?4Sy5bQoSn7ZYLsRJQ2yq+0ohOXAqOX70C4kFjungeBcxqC1NQ12UOoxqDvTW?=
 =?us-ascii?Q?RolW/FPfJthJaEQgocWoCqqpOwEIzJBykguGGOtTKM5KA72ZCzhmi4axUEed?=
 =?us-ascii?Q?xhHXQrCgU6N2bb7D9/R2o/gHDWW3/fiMG1uLjcyRiAFy/RwDDITzInKEShAI?=
 =?us-ascii?Q?1zUOxcent08hfUbbMTS7HOPs8XzgwsS6Y6v9vs2BqyvFlKDiti+0gxkU+B9T?=
 =?us-ascii?Q?iiA5HDIJMYdnQuzD7rQozjYmS6gsYpwmi71SLitUIk9sqpzEmOqIoSzp4yMc?=
 =?us-ascii?Q?je0KFX9aFewhbE2he5FrZSGv1uvP+ttEDI2c2ATzKaDLWNqmH962iPZ5GOZr?=
 =?us-ascii?Q?QZcKb4BvYJrNvMWrIYRp3ue0EXtv5+ETz5bYkV7tpwPTq6qx3O6sPv/mwTbe?=
 =?us-ascii?Q?n7IXhdxs0jt7nid8OZtfMWhtLoZnwfliX5DTVn48LfNmz9S4vm6h+/yf8eO5?=
 =?us-ascii?Q?pOkSimih7+VfV7+9k/t5mt5grPRuWbvV5g/IhH6pLOPpJevKVr+/MGVV00Yv?=
 =?us-ascii?Q?jf2HnAbfYywaHXzUxEsQMHA5zEqXYQuVTRkNud79f8Zv2mDGmQzPyNK3riA9?=
 =?us-ascii?Q?1qPmLoZUmYLCdwnasGRxkybBpKERl55NeZSrbGirgjOYSzP1R+lgZEJkmO1G?=
 =?us-ascii?Q?LaB3jbWnPXvE1cQLuhYnFumd80B+wucwht9D2gHI5SqSTBGXMJRvfINIxQQZ?=
 =?us-ascii?Q?bnFcYnV7OfHatTwUoyDE5P/hZxh6uRNNRN9wwEcPCtWDYwMzTD3W/uRkzw/i?=
 =?us-ascii?Q?l7soLwsI0d0CNbyRgIsH61aBgsPOrHz8S8MPSmPXrvfmCmCr7mu5MTOs/57b?=
 =?us-ascii?Q?Dl+9mMa9GzFwy+WpBSHvJo87is3fCNVyRWydQJE6BRu1K1/Uiv60EIdCw+2r?=
 =?us-ascii?Q?nnw5moACKeqIAVpEG/DS7KKc1crb1Rk9ejpE9dJou5XoRtfXYw3I21LdAmRE?=
 =?us-ascii?Q?+t1DuW0pEOSKeqpF+tuem8J1vhYb9lyQ6ZRN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10512.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WDRNxZdMQVpbciHFAcLyWIR6fU9/HNUQCC5sySuJogFQwHacC6OqviprO+wi?=
 =?us-ascii?Q?pB7kQ7c7nHIPAOaDochPO2YYDrGzXfQmLAgO1HwWaez/J+Q12nejgvwCQhiz?=
 =?us-ascii?Q?i/0VK2ylFdGqm6B5a88HOyS6Nw0w8EoS9Kq2iGoVajRonS5+oAFrJqs6ZPe/?=
 =?us-ascii?Q?kr1fTapLeQiG7ukzn9oxNp8xdDufpxI6bFe7Y6Fyqg0EC0t7gMsTnWgwNIHb?=
 =?us-ascii?Q?rvajzo7EKhp/LiSeSwuXh6e9/kOOcvEuyeRvOh/6INiIHZJ3lp3HKpZoPcLw?=
 =?us-ascii?Q?4ZWcD4Hddwl0bgw6Q1A27HOXQ3dLPKOq7BRvKRa/ijY+530JDEkd6X3oV8aY?=
 =?us-ascii?Q?qWlLwDecIT3wv0km5CQl9t7ab7J5CbBBDa8ulMQOZZTZXaUlz6ku7Goisu4G?=
 =?us-ascii?Q?AQweTf+Tb7POOMFk6dhJi9kwx0UimLFg+178h2Pphc9iWCn7vlYuaZZuSNOZ?=
 =?us-ascii?Q?Daw3i7XC13H9VblErJL3o09lXj40cpqvzPxUV0IJt/hOWDlZP0hEW1JVxyhu?=
 =?us-ascii?Q?LhJLkhU4X11kiqrQS+lSX9YoZRAINqj4Pz6KkbfRKhYUC2Uk28QwqqwwJMEN?=
 =?us-ascii?Q?bVgSGni2aCL+MI0y8c+Lou3Zot9q1qJy12nVstCfukiw9nlb/HZOfPVwwiqt?=
 =?us-ascii?Q?DShFpHouGyAT2GiTSoPwCyBz14Z5v9ZqSgPQ4lr29lSqSsPiNWcLi9bB1S5n?=
 =?us-ascii?Q?qOvOMK6qiuivXLIxo9XCfS1EO4/5LzVikZMWtydixDqBnXDtxvmvREm48x5Y?=
 =?us-ascii?Q?C52JCkICYdbCtjzxB8wtBfl6cY4kTfF4yrygiVLKHDhs+9lWf2bx0Pr97vW5?=
 =?us-ascii?Q?B0WHbNCjH4b2/2v8Giowmzmy2rkb8AOWN7TP3l7tjkvEvyMdsqvJAF0gUGN6?=
 =?us-ascii?Q?jFAjYhTGJDwmjTohn+n/vgyytnfBLwNJ0LWhnro6hh5PQa39criNBjM+37+h?=
 =?us-ascii?Q?d2MxR8NJRdHIti+LWgF1XZRMBYxHXc/hLwVu8iCbQgCLb1510IyPsmAZDzUY?=
 =?us-ascii?Q?/kINQdaXgNgphjb0HpvvorFl7+2DOMF+k4Sah3JkWTK9SRQWTz5YzyY0csqN?=
 =?us-ascii?Q?ovtp1/Rpe8UrL9JK1KS4F3DyFU0JbZubCECZMUZqvhZbN17CpvthSE6Sqgk/?=
 =?us-ascii?Q?kmooijyP7sLn8dcjjAvK8pLClT9kdx20T4mCxCMYXBlmRzdpxOteSSiaVsgg?=
 =?us-ascii?Q?4V8mLMkM+vzHARcO1cMCzuHRNxfrvz9KR8udSjd28dJCE5ZigHYmNaKmznWB?=
 =?us-ascii?Q?IryGu29lCQ3qcqqkgOEwZYlouA61Aa2F2KLJ1aIQmWJk2ZVsXCrnQc+kGvJw?=
 =?us-ascii?Q?pSx7vIqCqgybZwIphMdwKEgWLET2M6Mtbq14oeQBQVVvYlVT1aZtfknP44op?=
 =?us-ascii?Q?a8422/7KyddrQOiHkxL+ARpBH/GBR0B3OAXtoYXT9OSXCj4ZF9OL6jeNa0Y+?=
 =?us-ascii?Q?IzIe3vn3nJsEQaF1NBFFpzchKEdT5/oCxbM8CEUQ0AkOB6mkQsT3T5lXy3U8?=
 =?us-ascii?Q?BQBkGNi3NCJTJRLuo9kY9tfFialBqXlsDaPDMCYH3lC1Pdu416CQvdEpfPkY?=
 =?us-ascii?Q?Fthi/vOp4A4xIV2QTnHpbDMNZYPJSo1/mrfTvNe+E/+8VELHR/Pr8Y9OYFZ4?=
 =?us-ascii?Q?BKJ0fMTkxqc4jTtUHmYgKNM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10512.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69078e78-0ee8-4a8a-bdea-08de1d5e962a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 18:02:01.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFPoZEgHkQOlpu46qOJcblNexrOwCSvb8NB21v0nqIQWQsKDQBVvIpsEf54pKNeYFsxP+YXyDg5EnQE7odhSs/EgPZTKiMGfcvKd3vIf6oEwbrcM8UoBpR5ulwlECcvD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14532



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, November 6, 2025 7:58 PM
> To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Mark Brown <broonie=
@kernel.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=
 <conor+dt@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.co=
m>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp Zabel=
 <p.zabel@pengutronix.de>;
> linux-spi@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicetree@=
vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; Conor Dooley <conor.do=
oley@microchip.com>
> Subject: Re: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document=
 RZ/T2H and RZ/N2H
>=20
> On Wed, Nov 05, 2025 at 11:13:55AM +0200, Cosmin Tanislav wrote:
> > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SP=
I
> > peripherals.
> >
> > Compared to the previously supported RZ/V2H, these SoCs have a smaller
> > FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> > being the clock from which the SPI transfer clock is generated, is the
> > equivalent of the TCLK from V2H.
> >
> > Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> > entirely compatible.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Why is this a v1 with my ack?

I forgot to bump the version to V2. I've sent V3 afterwards to amend it.
I applied resets: false & reset-names: false as you've asked and you said
I can apply your Ack afterwards.




