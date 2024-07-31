Return-Path: <linux-spi+bounces-4106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DB942813
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DE1284224
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F8C1A7F60;
	Wed, 31 Jul 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PxT5F9qW"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011066.outbound.protection.outlook.com [52.101.125.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F791A76C3;
	Wed, 31 Jul 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411269; cv=fail; b=Zga2+ArSJUDAEX0dusdpLNsGxEu9PL9tvAdhfRxA1IHg4N6lcrerm0YR2LUZN/1Ll89GnJ484zNHj+HQ/YVdDCLiwAxkOc0MTawnQ2JhLc3oYjexRZOyaeSNvc/u9qcdhtrb/CpcuhpDsDl2qry6PEKVai8VKlRMI4K/0aW/Ob0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411269; c=relaxed/simple;
	bh=cKNqKqXmugIqmTvkvYb0GhLUEcAdsJcgNUg21yK2Cxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=koh3TxcAf+icDaz0JwKRQ58k8jhOtvkbq8Kzdn1GV/RcRe1VQUBE+hJPXSkQk6v/w0JMaSK21SUUkGjYRHwZfa7JfBo88LYRFPQPruM4MUbB5aRIXOXUvsRlJBlIhP+20fgV908gTig3YTmrw6bWurgtSvAiOOHXlNJfzg7zHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PxT5F9qW; arc=fail smtp.client-ip=52.101.125.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4wM6R3PBtAHPiXCu6I4FAiAY+B7i1cYVbnUtXwjNQSjdyJt5YIchD8JyaMxrR8UYisfRhMgA0WxdokzGX493I1lsoEm7/GJBzqtrT/dMk9PRaJz4zhDQZiDm3w0wKyEZ1LL+p7obvWDcWEHRq250h87Nc1nKDbkU4DW9dgs6nGNQdgwrbyGhC2odG1o7fihIt89tXk+47y1h5KfmkOdFuJzmymA7rFsENNrlF8B+F69Onpm51CeP3+XXxSkOu/T+H+YrJsNuKkeb8RR77pP0JTfFC4tJRGY/PBlVzDWPdNyZZrQszktyVPpqx69Sfbj0lL3NyTrElZ/93kMppbNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiUqZ8/97jQYSzHyoq6/f0XH2ixXhIjDmqoDLlc/OX8=;
 b=TY/xDCrV/y1FdJomBbhH8HEZn/r9kQ7y82ciPT2zguvgUq7ibu3ze0NUxR2BKwOaMNnDt8tUKFbPb4HtY4UCk6d9b9kTUgZjmw6arMZecWRE4OpAEY0VwN5QxkVWk9Bl2wm0KhOT73oMUCqV+ShUp/2D5s/mdTFqaN4C7eWE7XNW1AhZZ11I06VMtAlhHO/GXaYX03gwYLH2bptV9cobjgXdbr93lLC7Dc6lsiqIks41Httshxxmhi9L5hQCJuRalOwv9MbtC6DhxePNjSJyHnbxjq5CgmciOOMkIELIr8AgLQGp/86VvbbG7ZQ0ntY5ucNJc/kJ/0dHThJk6tfGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiUqZ8/97jQYSzHyoq6/f0XH2ixXhIjDmqoDLlc/OX8=;
 b=PxT5F9qWAPbIs/rR6fcrYXne1k2OcFIlAoxJB7iMFMx36wg/sxbV7U/2oU2Dooy4EK13l6ISuTkUmox3ZWC8gsupfvnuuiTfGkCOr7XI70GP6N00iPd128rl3QZVJcQpBF1GR7xgifTvVPl8zdkywNTmvBkCRqGWfF4ufnsjo14=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12583.jpnprd01.prod.outlook.com (2603:1096:405:158::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 07:34:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:34:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Mark Brown <broonie@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Thread-Topic: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Thread-Index: AQHa4xt0EnK9lxDjQUmMbVqbEYz1TbIQcOJA
Date: Wed, 31 Jul 2024 07:34:21 +0000
Message-ID:
 <TY3PR01MB1134657183F57710D8F6643A186B12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12583:EE_
x-ms-office365-filtering-correlation-id: 26ee5667-713e-4cc9-cab1-08dcb13331ab
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DGExUyCYuQSuFiJFPuo+oXn51QXw9gXClXpzeKt8JOuvRrml4jjWNQkZCEiz?=
 =?us-ascii?Q?QDt20SXUqOPZ2fg7G+jku0n01R8kPnlHw7JW/uk/OeqLqEYH81+nmX7cYi37?=
 =?us-ascii?Q?5kjTLqPu9/jHZoPQtcd6z4c4DWVAsqRLZ5Td+/rSktOrMIfZNtDZY+b9Jryd?=
 =?us-ascii?Q?wvsFUjFbiaOe6bFQybyDK/z0Md5MIuHv3YWrO/NkDLDdQo/FRqNZNKh3rzIJ?=
 =?us-ascii?Q?hm8co6d1VZSU2UI0DLe5Y5y+LQ/MK807kVMq675QqdGoIU6t/2qZETLEIQ3d?=
 =?us-ascii?Q?nLMciBNJmdauZVAawSvpfOOoudnR78YqnIiO+iF/TKfHfqFtVf2VwJfs+EY0?=
 =?us-ascii?Q?qZagvQ6xfAgsRDr19Tr/I6CNVgufZKLDZBujlVrTHR/EcPDNTErKimY61bXy?=
 =?us-ascii?Q?s+ow0zq4PNctcebTn0L2UyB9b7c/9nzaQDuX4IQnTrZmMfwdJP832boF7dZ6?=
 =?us-ascii?Q?vCQFfpv5gu/DPBvmVIo4EmhZGROBa5qOlveyPQezFzbnvbKqoZofv2MfsuTX?=
 =?us-ascii?Q?BbZa0AT6NHc5jLogkpHmaHh7JsS0B/0EoD3VhDJ+ucFtL0TKjeIXVTWqC8av?=
 =?us-ascii?Q?3btO5i2n5Z1HCMqGTtArZoYQo4lqpi+aN7nkZ7YfVVNIGpUUxzSMHrn4OVih?=
 =?us-ascii?Q?sC2pDG1rNYAtJxXE4LAQ/dNlWutpYwN+aAtZxoUu+NRCjloU9dzWDkb4jzGd?=
 =?us-ascii?Q?5yfOVDf+ZsVcrJgkR+gYfvS2/CWOinNTx8g8m+Qx57+Fh2GCQcGPjWIG7apH?=
 =?us-ascii?Q?y2pVmtO2K/Awj9b35NON9TQacaObsD+OvxIhhTYYnesCOIeNcE9riouXvdxO?=
 =?us-ascii?Q?AdfNPPJOX+8NoX9Dnyt/erOuxvkEBmFD0Ycanxox0aUxTpCNh6IiG63wK4Yp?=
 =?us-ascii?Q?ln32/APqMeFWSuLH92LYTEvfv1yux/65+BQm41588aKN4qAyQeyCiNryw9Pk?=
 =?us-ascii?Q?79/JZLTZI0fPnliHfbmfLibNECj8v6u9HTNPbW5OIpnRmb6/uA4L8//SgIWX?=
 =?us-ascii?Q?knv8gSepzPrqWv5txLIP5iGS3ea33nHNDmSZPnFtJhZI5mrtoQSTPLixMshb?=
 =?us-ascii?Q?uOEmJJhhwZTpwjghEV0+B2rAfDPqEixbTJ95lMcPq9RELueyUQwqicvXD3b3?=
 =?us-ascii?Q?B0735s8KEzvheMD4WVahl6jKstwLC1oleUoMLoC0GGOB3xTAhEdCvXF2dHQr?=
 =?us-ascii?Q?lpsT4TQQifPpkxM8569swzWH01bF+Vl2ujQPsdG2yMXcvPv7FYzpryGVhV19?=
 =?us-ascii?Q?Yv3lDszmTVvFpvPJ0BZWp90UXA83xmeMow2DV24CYeLR2uJDjIaSHznzWe3A?=
 =?us-ascii?Q?veaRkEivJCv4hxeGlRoCtNUjukcQjW/V7apOW8Dbb00qAaeN/7cMB43bDqcM?=
 =?us-ascii?Q?4qC9C22x7fhh26IsbbVJTB2LXf/Q8gkmTBAwS47HbsGfnsea1Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cIY11kHhlm4MeFTuT43bqj3akCIx2au7871mvOp7tL7BQmzEJJt3RptGjd9K?=
 =?us-ascii?Q?+UlzoUq7SBkcQujluLQBJ+Y6Rb4K61j4IoSIXXU4b5rT5FtWtHBbaLPGmIDz?=
 =?us-ascii?Q?fkF93tjsonLJ9JVCc+IjMTvb2ZiG/Tu+dxlzaC3+mOfkV1zfm8Wf/KEDGvJ9?=
 =?us-ascii?Q?QTbdAT6BVGUZzGQpEtpzN6beI6YC7aZ5i7i0hmN9rqgNIGWvEa1Cd6nBJB0E?=
 =?us-ascii?Q?EUZNK4gO4v04Yvb5S/kJeY5culbu5onBrBQpzR29qZDoPSrazOB+x8wby2Y8?=
 =?us-ascii?Q?3O6qIqLUAKzzJZKbNclbjcoHtXRDhMpJok5rbYYQl5trYOkxEKKM7vbG7vWy?=
 =?us-ascii?Q?EAFoInJxIIwSV7I+tvAsbypbxmusyxkmX+GZkjCg/eAXSTQjDSZI/kqOJqae?=
 =?us-ascii?Q?ZaBfrW0DYyJoxRN+G9kSILZjeDtQpm5gZDYeAx/4fbyaY1wfYammUTRkFsJk?=
 =?us-ascii?Q?HG+UFHoWEfrATDqAO5C2PEmYXaIyE6n+ajeb/jLK23yqZByQ/0iktJN5rhj6?=
 =?us-ascii?Q?VYnAx+vyVG+xf/gK8QlPaa9sxHZbrkaU+mR8VccgrxMhz7P50s4eH/y+y31o?=
 =?us-ascii?Q?/N01B4+3a0wLmTWHxaZP0jhsd3hWqgUtXLIY1rnxY0+focAnR9ah7NlcHsh6?=
 =?us-ascii?Q?okplZmqTcr79rbLNd7usZWTofmmk8rYxUTJS4/OGz1oDtOyK1Kw3IuAPYMNd?=
 =?us-ascii?Q?IsxpazM0WjzzIFhUEnR2vHe5gbPOHVgo3zeYrVKPqRb0AKid2SOwty/RW1iG?=
 =?us-ascii?Q?g+8gW/XEMvcr6mvZ+v6+8m7ErrXE/H8qd5tBTlKRQRqrO+7YQscduXAdOrRP?=
 =?us-ascii?Q?v+8qiErT7nef7Q06mQ3JibZWQ9L9c94Jxa85EmiZq9/mwoopq8MTcHzfYFQ8?=
 =?us-ascii?Q?4Xl3zgefz0PwwQThbx15MytSBgUEGWzbBWL7Pcu83//sQRjq37hxzwIUdjq7?=
 =?us-ascii?Q?n8v70mhaYYCKZ1ONHy2Tr1kgUelkvwbj+hSDMMF1S4tCNLPEVHw4uCIuDI66?=
 =?us-ascii?Q?5gCaG1xZUhDsqEnqIHIfmvOWXpJ0gDwg6DOVUbP9Wv9g9lEh26R6+dvZp20d?=
 =?us-ascii?Q?sjkcpRTUfvDoU3+jweSfX4knBO8AR4ZoA2VCTrr2AWpDSOrEV8bZVGEDrC+9?=
 =?us-ascii?Q?LX4j3dDbzbvon9KNK2x1FHh9qIiDkAaV3k+7+X2ghGGzxJvo8k3gvsix+gnf?=
 =?us-ascii?Q?hZZsXUUZfwE6+96rxkiJdG1xFFzFHdaMhjUx1n/7Ksn81OprdXshBKEhJARp?=
 =?us-ascii?Q?fxxf7itlyhYV67Rr5UFLWqHnLfb7HczYDNONHJA0rd86IUbdaqPvhcj3PpCA?=
 =?us-ascii?Q?j30s6BsGw76Y+82AtgM+7stGpF1qFWwOEAi85omHa8qEsxVxD/v0IuOb/WjK?=
 =?us-ascii?Q?3n4zagHKQGIpsNbIjYIo9KuY9n1ZL53YmEKxa7JJfqMzjQv/ZYlVOg6nc1H2?=
 =?us-ascii?Q?/erOaovw5A0Y5kk6argvx82VaFTz+71T93HmSyTatLS/KWDAjbqtGmP5WRUa?=
 =?us-ascii?Q?ZkBTOCUZseZc9dN24pBj3gPFF96341hoIsaUPkxwZjMJaZnH5glSjF7jWTGa?=
 =?us-ascii?Q?E/h1D6KFDL2demHX0nQYC5jTw5y4E2zpNAtFgFiv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ee5667-713e-4cc9-cab1-08dcb13331ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:34:21.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0cL3XLx5ACwWw0QpjSbmDKfjA8bZ7F3aFUiBOAi4B6jTz9nbA14huw5AUfOUSTal2QNDD6WvypzSjICp6TMVlOvuJu2blxs2GW+q/svNSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12583

+ Updated address for Sergey as the "sergei.shtylyov@cogentembedded.com"
bounced.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, July 31, 2024 8:30 AM
> Subject: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
>=20
> Add missing MODULE_DEVICE_TABLE definition for automatic loading of the d=
river when it is built as a
> module.
>=20
> Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> On RZ/G2L:
> Before we need to manually install spi-rpc-if module for getting partitio=
n table info
>=20
> After this fix, partition table can be seen during boot
>  2 fixed-partitions partitions found on MTD device spi1.0  Creating 2 MTD=
 partitions on "spi1.0":
>  0x000000000000-0x000002000000 : "boot"
>  0x000002000000-0x000004000000 : "user"
> ---
>  drivers/spi/spi-rpc-if.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c index d3=
f07fd719bd..b468a95972bf
> 100644
> --- a/drivers/spi/spi-rpc-if.c
> +++ b/drivers/spi/spi-rpc-if.c
> @@ -198,9 +198,16 @@ static int __maybe_unused rpcif_spi_resume(struct de=
vice *dev)
>=20
>  static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_=
resume);
>=20
> +static const struct platform_device_id rpc_if_spi_id_table[] =3D {
> +	{ .name =3D "rpc-if-spi" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
> +
>  static struct platform_driver rpcif_spi_driver =3D {
>  	.probe	=3D rpcif_spi_probe,
>  	.remove_new =3D rpcif_spi_remove,
> +	.id_table =3D rpc_if_spi_id_table,
>  	.driver =3D {
>  		.name	=3D "rpc-if-spi",
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.43.0


