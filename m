Return-Path: <linux-spi+bounces-11019-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E22C3504F
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B6C3B156A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19429BDA3;
	Wed,  5 Nov 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SIv3DQNR"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010048.outbound.protection.outlook.com [52.101.229.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B7A932;
	Wed,  5 Nov 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336915; cv=fail; b=hQgnEVizp3h7wyntVfwR/ao/ahxYQw2sQyr/LGZ05P+DQRCu7SNMiFGwZ/6YOktQlP1BEhC4FbVeYTF9AEHs8fyisYuuf9TK0AYXqVZoE/fIKhWzfjAojcd2xWdeBUfUI20IraRT/TmZFCr1UtPPRTjmUas0RPqf5JAsq8pjaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336915; c=relaxed/simple;
	bh=Nu5ZfoTrU+Q9W8E+vZpr0Mf4e2CUB+mneRIVZxryRrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MppopW1r4bLrkdKQLJqAeq1KadPLA82uQx7oQiOwgYV42nWymaIpRVyMfDkPPWPrFj97BhBUeUkOGhg6ylO5jGOjUL3q8nvY9uJx4abFWzueDZnBnnQ/eAtqlMBvnlJjL4ZmETdThm/9tm36SxwmeYoI+d3k/pvytRyGV9AjqeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SIv3DQNR; arc=fail smtp.client-ip=52.101.229.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuLHCzU0UAiSgajikCgiQTZoG/rIGWwYVef1fK9LYqucyOTYUhcmIMIwVwoiAGREAtFkWp60+TixP6BvxBC6y+CZC0l+kFGmHw0N+FOomrCZvCIfjiQuWqDrrOpkIGygaoG+VrPYdluf73HdZKnqfjaoyVEYbYIvmY8CV1hh6ZNrLrps/XIrEzYbj9ES/5yeeHlgclV/mystieBF485FxyIj7zddI/mbcuVA7CH5GKe+JrxKZDAJWAjqdE1n37eqfyeHREN5liT8ROEAct8yDi1UuJAdjVbQP9HXwIiORq28bYsM1oDkkOw+9N1YiXt1rUpalGdd9htV7kHw0mijaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbRCelCDp3AtMzj0JSemsX3KX8N3H2s144zCqBOxbT4=;
 b=Df9Do5MzlTgvCbIx5ZqtUfj3OJLE7a9EWuc7YmDbC/kUBSDrDMX0hky5xe39EvugG9QeDFSozD3clFjWloLf14qrc/k2KjB2kAmjvOiOt2F5ef9+yyi3HzvjoXh9S0J5LcCpf8GXrsyU7rdG/g4EwcXBi8P8ZnLONPahr+bdwLe3sHKCRYNYYcXIgCPUMnc511+43A8/i+oeLdFV192QoHzXvqTTmsFD/Sgt+5/5ZMpCNFJYcNnG+2bGh5OLEL9GtaA5ww/3ISD2iOZDDbTWhGcqxYa2A+FvoKAZpeh9+F2xLiebqyrG0tXolg6G0WJhTa7scDWVWvGXE5y3w0N1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbRCelCDp3AtMzj0JSemsX3KX8N3H2s144zCqBOxbT4=;
 b=SIv3DQNRq1sXIkJxJZkF75U2RJiSmScFaOhMvP9M4ftx9IjXYBlQvvs1BGHU8cUu9b87ZFMTaLSnLjF5qmWP7YG4CwuvIHjXfikGFvLZwt5bZuw/ooZ7qy+IsUnmXcdBC7skfbbvCqhZ7ZX0De4nhwUigqpTngCyK6L5NCpLAwM=
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 (2603:1096:400:2f6::13) by TY4PR01MB15485.jpnprd01.prod.outlook.com
 (2603:1096:405:273::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 10:01:48 +0000
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686]) by TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 10:01:43 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
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
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 00/14] Add RSPI support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH 00/14] Add RSPI support for RZ/T2H and RZ/N2H
Thread-Index: AQHcTjShWQc/cJmaS0uiOD+gMX23jbTj2OmQ
Date: Wed, 5 Nov 2025 10:01:43 +0000
Message-ID:
 <TYYPR01MB10512CC2881708C2F574A631585C5A@TYYPR01MB10512.jpnprd01.prod.outlook.com>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10512:EE_|TY4PR01MB15485:EE_
x-ms-office365-filtering-correlation-id: 581fb030-0ee0-4111-f812-08de1c52528a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XE6915wbdNFlSPV64W8mp8kIb8hiD2Ex8yy7/w7RXkFbniuZRBNHa5Q6YWGP?=
 =?us-ascii?Q?gHknVR6rFREqppEH3toyU7bnFfVtM+RVFh7/y/Ep3dmGqf3qUnSCyiiPDF1N?=
 =?us-ascii?Q?Ecmzuixt/X7+v5KsGnXamWrAIjTrIjFl21+ToIRYUZd56IG2NGjT6SXEkiiN?=
 =?us-ascii?Q?QSFv3+PhbRBBBPE63iQffpZ4UhrMjCsz2YsNRTOUckqOKTC+c03XUSl48JWS?=
 =?us-ascii?Q?cKJ+B/3gTD//7aKPdC8j1uiDKmCG4li+YM6fqfoBi+ncdUU5l9eqo9jVYYvm?=
 =?us-ascii?Q?MiI2U3T9bqGjpru+Xn61YbfhYGTfSCiNptNr5Amhfnx7q+KnGu9UF2ShYcEV?=
 =?us-ascii?Q?p7bTguO0TgxurDxAc48pVI6dBDtXWT0LE2It+/qp7ck4EheVVIfIbJ7Pny0A?=
 =?us-ascii?Q?NTpIQqco9D9Ky+Pw6IeW0OOqZvMQXmP6asjw8OgITQOJFjhBi47cGbi7Oof1?=
 =?us-ascii?Q?iFyN2o1v7tC6OzmfLuLJuP6uSMNJ5UvG5sGY/qd3QgJl4fXzDrc0bGdrDnzj?=
 =?us-ascii?Q?yOn8xKOc2TYYM6Vwjq2DayRsMeAnVWxG8fBr+gQZkBr5E5S7g1Mrl2eUYtVm?=
 =?us-ascii?Q?okrHAOyn/EgqD/3uv6YrgUNfXrmVtkpTTJLDt84xHW/FLZxjQdSbwkHZIizL?=
 =?us-ascii?Q?TZ8zwvxN+8MX/oftLTy3PV0DO/a1W0ulpzhGRd+kEPWxErvjCHx+/mKRVJOI?=
 =?us-ascii?Q?FNj5PADfCDzMruzDJxVC2xoe3XjNtNp/Gz47TdBJHwXF0O91AkLPD4oBbVIm?=
 =?us-ascii?Q?fGsDsjvFrNklRpG0U6AeIsYSqbzrcYmNsHj0b00NiKc1V797mkhi3szpmaOc?=
 =?us-ascii?Q?Jym9Cn4UiUwmQUlJQJ/9UH9C4R+Cszaew+/Pg7PXqzeGf/BNUB5BgtDaS2M+?=
 =?us-ascii?Q?RrYLccWYMrO4mAUgKbL0BKoFUnpBVerRKoCEVrRg2/jZ6sNZCdR1jYNuIavZ?=
 =?us-ascii?Q?QBISRcK3InYzuhxmNSRIZU7tRb58llgvXmT/A6FvSNueVBD81EforUpzd2Fn?=
 =?us-ascii?Q?H5iVaRAQLcnYDfd1MX/3RPZP90ZdlhveyagtGi8erInmt7nxpM8LrhbLUYlF?=
 =?us-ascii?Q?VBMjCNvxxcYmvc9z1tkGEHjiIM5KhDzmTdFk96f1ICtCnvQqc2IQX1QJE/m0?=
 =?us-ascii?Q?04kp2XHndMXMI6xqThXJ4ZhoQAWFLTfJdKpVkEz+HziPQ6nSow9QTgS3FO7v?=
 =?us-ascii?Q?JPLWZQG8QTzY0oKR1qYznKFbQT1XXwMBBVnZAQYww0AJKzEoHKmzCFuhHSWB?=
 =?us-ascii?Q?aknU7OrEzWD9xhtTwptdxS0623lcIy7ivqq0SKDK4Q7FJI10EBJIlQg4KgdF?=
 =?us-ascii?Q?fzHSxukW1qpirKX5+HXM6oJrN4rBQk/AoB5zePVpUw6+m7gOdpR41hk0I3YN?=
 =?us-ascii?Q?UBz6pf6sJRUmQTXP+jOFKeEq9h4yMXoTi4+ivYtnMmzKgxsQmdDYe6VOTpOi?=
 =?us-ascii?Q?+/Xg+No/aCNJUJ88bxeOqGbzAwsM2BLmltXdML94CQdp2sY7TuOiGJ39kUHi?=
 =?us-ascii?Q?HjTetTz7bK/ATt7WVDy+tc53FpA/hdvwxhST?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10512.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q20TUf/u58lpcohG578nAONXEyUi5wRLsooKBsehtSn75w0CFqroHdon4qup?=
 =?us-ascii?Q?+eEHLfn9w4cEoa9UlXmRX+zHrUQUVBo9WuyA/Z/ovGTsHJLENA4iruyua5Zf?=
 =?us-ascii?Q?dg/c+f+wOd8pZ4Zh+zwffSfRoH812BjUf/vRbnZ0hUTFRP4yr25DB4g/D+Wy?=
 =?us-ascii?Q?Jc7GFOA5B7vSGmqe02sxUjleEhCYxulMeRfStx5jIXPBlty9XIcYbTZmqrKa?=
 =?us-ascii?Q?VqHtYNs/0JBPoOoGyBX/iQDvzDi70hi4NIvH+vck/jJpZnFIAizokx2Ooqhs?=
 =?us-ascii?Q?6G3GzW0vAnq0L86JM1SWhxBR/h3pe3vLY6B6SQSpz3CKMVmQh88GUNPrz4al?=
 =?us-ascii?Q?wcNbd6Av6B7sFa8pjLuSdM/V7trA1mEDITWabAXWpLsYgxogvMbGz9ZKGBAH?=
 =?us-ascii?Q?GVJnjgf/kg8oYtpuMRckjBDrE8QmXUPgMyIMuvit+guCg7xvMbJpHn9AfpMZ?=
 =?us-ascii?Q?6ZMJnflls/YmYByu/b7frCmS/xEafPYBn1qaVqPWRkLCpjYJaH0d4l/YcElz?=
 =?us-ascii?Q?zOIVvEzi26h8nKD8tHSKDT1NQzRAIXc1rThp1rjgmbxh1afoUvPk6GtalicL?=
 =?us-ascii?Q?te6j2Z/qyIThPPyCIysZfs6fnKn5uOXNx5JDsVbnJz+LGaCRtmBBucIPG3JS?=
 =?us-ascii?Q?5PKRO/7bDJ9HCZPmV9JQ+ktpnXfHTusItw+bBar/nrxk5YcFvMTxxmZoA8ju?=
 =?us-ascii?Q?MN33JTpMn0IoMhg6F2NDcSZeBLs56WHP7U81cDuyZYmKpUiHYZ98rK197Bix?=
 =?us-ascii?Q?0SRpWd2O3Lv4iwQGfGIcMNNKumHVbRJ20TmUqxTJkKvEUjkdVBj3ohGCuZGQ?=
 =?us-ascii?Q?LbmM7T+gI9s6Us13imrZBfhYwyFtlD1S2z8VomakBomBUR10MjrZ3v8NDf74?=
 =?us-ascii?Q?gOpP9narOuLC5NOHbt9OkRp+wUsQ0xHPQF/bdpteTQjzwDQj+gwVVztu/C0z?=
 =?us-ascii?Q?SP53JuVNma9etVo9UieO0qTpjac1DWLCiyLODf37+Zb1z3zda4NOYyMwmtDI?=
 =?us-ascii?Q?uZ6bDDZ3o05IDQhQNBnnAw1U8Vlz9GyBVanDAYFK0OpBelx5tZjksqMqg3af?=
 =?us-ascii?Q?tWlq7jlHTCz24Ua0SBh6gGcL0CZwM51eMbFpf7L++no9MKuNtMzRvSy9YfwJ?=
 =?us-ascii?Q?niphTMuo3MqboUpN31toDraO2P7/Sa9ncyaPRGksl8WrVnX70r/c/qj6kiBG?=
 =?us-ascii?Q?cZaZ42aFmsd3z9SFFSJOtq8zZ1YRIuYxEsw1x7v4Ru6OwdMl7Cd4YzITydgd?=
 =?us-ascii?Q?Kz4nPh8ft9yp0UzTgOFyzN11niqfHaDX2LgVIQZhfyypMoX3SnGA1ztduer7?=
 =?us-ascii?Q?8N4ke55VIRdopULK/uP9AgJ1w+n1o9EU2Sd2e/omnJskR/0kL5PIOPDY059b?=
 =?us-ascii?Q?uHBNTlBbbDa7Hav/egujCLfgO0TtJTQmAY68B3fLq6qw+EmPzHXEHO2thLM2?=
 =?us-ascii?Q?yy37GomDWHSIcW7ESpurT6X6mgm+eeLtInhDOqEBwhr6NosKbvVu93J4KBxG?=
 =?us-ascii?Q?FMM9zGg/nckO7KGg7HwjH7njzh3foCsTQtrbGQXTSa0Sz3e3MdVDiKyzX+fV?=
 =?us-ascii?Q?ZwKzRNaYmVNzf/a38hsn6o+4J09CTLgQmAZPwmd9F6EKCdvy7i8LW8p0rY8h?=
 =?us-ascii?Q?RHPVgWnhbE+FZJOcx+2a3kU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fb030-0ee0-4111-f812-08de1c52528a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 10:01:43.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYXwMzPAm90Ft1S2Bjf4BIbwjb/vVF6geqnqWShn60ka2FetL0n4NXlJiEwxsUuVSW40V1IjLm1+gl09a+70EgPtrRZ0JfrWrxBvHmKC8YyXknUua+D+Tux/Vkhe74OC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15485

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 5, 2025 11:14 AM
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
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; Cosmin-Gabriel Tanisla=
v <cosmin-
> gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH 00/14] Add RSPI support for RZ/T2H and RZ/N2H
>=20
> Compared to the previously supported RZ/V2H, the Renesas RZ/T2H
> (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a smaller FIFO, no resets,
> and only two clocks: PCLKSPIn and PCLK. PCLKSPIn, being the clock from
> which the SPI transfer clock is generated, is the equivalent of the TCLK
> from V2H. They also support generating the SPI transfer clock from PCLK.
>=20
> V2:
>  * fix missing unwind goto quit_resets
>  * add resets: false and reset-names: false
>=20

I missed bumping the patch version... I'll resend.

> Cosmin Tanislav (14):
>   clk: renesas: r9a09g077: add SPI module clocks
>   spi: rzv2h-rspi: make resets optional
>   spi: rzv2h-rspi: make FIFO size chip-specific
>   spi: rzv2h-rspi: make clocks chip-specific
>   spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
>   spi: rzv2h-rspi: avoid recomputing transfer frequency
>   spi: rzv2h-rspi: make transfer clock rate finding chip-specific
>   spi: rzv2h-rspi: add support for using PCLK for transfer clock
>   spi: rzv2h-rspi: add support for variable transfer clock
>   spi: rzv2h-rspi: add support for loopback mode
>   dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
>   spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
>   arm64: dts: renesas: r9a09g077: Add SPIs support
>   arm64: dts: renesas: r9a09g087: Add SPIs support
>=20
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      |  65 +++-
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++++
>  drivers/clk/renesas/r9a09g077-cpg.c           |  22 ++
>  drivers/spi/spi-rzv2h-rspi.c                  | 339 +++++++++++++++---
>  5 files changed, 501 insertions(+), 69 deletions(-)
>=20
> --
> 2.51.2


