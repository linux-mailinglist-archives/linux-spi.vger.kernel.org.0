Return-Path: <linux-spi+bounces-11555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE9C87CA1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 03:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDAA3B545B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C8308F0A;
	Wed, 26 Nov 2025 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRcdMAIm"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F54305E2F;
	Wed, 26 Nov 2025 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123079; cv=fail; b=P0G2qAnRSIihGmxOLFcuwqPtVAwiogC3shxPOKgPxvwSM6FAZ7wJqz+NVNlPd5HnW6wytdyBlCOVcjk6J6hn1G1tB0v3nWGxZ2PMdAB+nHZ9nMQU/MJAis0MEMwuPX8ca9gKo46xCU2CytZwpq7b7MDDo/PUlI6SE7ThsBZXOsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123079; c=relaxed/simple;
	bh=kKBAQdFNZXoHshbmmFtMcNXfI1ltQSBYmzhV9Frq/5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sO2HHUUtZSayQWEfnHpOEhZ4nPQuRPru4iWPtKTzhz7A1kN2CuNleLg3yRhI4Wv3NcTVns+niGCRC6BR2LU+1UUTISzfs9w4srK/9w5Y0YHvJ3U3Eqsc0J35MMXowKtFCdE5fgrMTGTFeoDhHeKpPRw3TDCc5Ruf339nm1PzUvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRcdMAIm; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goJfUauYl4AyJl9M0DETMT0nNAGU77LJETX9iPp3kijB1uvDLiZHFB4/F07N6OJs/nD0N2/QRq85OzlxVDgjmzBWFYgM4ZOQrJBGK+Z2LebYHAkh0IIiruODIJMv8OUvHOK0H0BibCSK2aBBTM5Z4QpVeiNeZGEnJG9/PDjN47JPK0jYJu9Da9jD4hIwxVJH8eof9Llppqlv2H25xUKsfMup3jqHvSIcvSZ0B3DS3qJytp9Vp/Ox/S+CW61Mv7F1+1pX3pXLqlyKkNZ7LgNYr3oFp6Api35Boa/rZgGdAEkk0afLfdxNGR2XGWwFyY/KYCzDcml69wP5nnh+X9uIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJka8YDPUVdVAIHHHIAtRD/XCcr4rJkdWdO1ylU53bk=;
 b=beVo6IZFqLysoodE87B/6C/WOPwxP32fMJ2n5MUPzvsfkSVSGeaXyet81QGDvu+NjlY8GJd/N4VAl3FKsLUTKqc83u8b24jwmvfZjsShKNgarT3sJI6QP5VuaJZOWX5YVFF+rftukcNX18QaMnpENkvW46JpSJSR7V9i/ntD5Tb4FMNhfuz0eeDpG7pcNPNMUzRxqVhimtE29xIBdk5YZMpVnN++v6cxxOkwRaSWij48Eb4lUfD4XZBGOhgazxLPF8ifFXM0IfHmM4lNCfqi+ZkgBecFdee6OdU67JQsmGT01RFdN5EnkafQnsFoTy18FhPOYdJ121exyaiipIqHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJka8YDPUVdVAIHHHIAtRD/XCcr4rJkdWdO1ylU53bk=;
 b=jRcdMAImuxaqAQcK55OG7or5Q3+9FyleEyGl2nTYWHyh1w9RMt+DiNHhPouA2Or+T6ElhYdpY8VwsWPzU0Jr9TKwMvlxxUKv/RTCKuv6j2Li4DVNuVDyc1zor6Z0DFcfhb1nSkH5+/8hbniefjc52fbEjWBlVjHxY+JstbTDXDyAjtZWIzQPMuyghm4l2Qz91lmvgtnbjugDYZ2uE21MZ4+xBneXLPSKRpq9H/t0Sx46qdOQr3mHgdHSNUeJ0F3G2JbqUlms20U9AzbQkGbhR3YJqlWViIGpt+zuxdpouCWLUE3ssMVjnT/aaMsUZwbBnv53nOdH9qynexwNckBqRw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB10620.eurprd04.prod.outlook.com
 (2603:10a6:800:26f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 02:11:14 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 02:11:14 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "hawnguo@kernel.org"
	<hawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Thread-Topic: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Thread-Index: AQHcXfNYgnkhVybOTEWLiW6Jy5/IP7UDjt8AgACo8nA=
Date: Wed, 26 Nov 2025 02:11:14 +0000
Message-ID:
 <VI2PR04MB111475132F3380BF3B5ED635AE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-7-carlos.song@nxp.com>
 <aSXT5tzhfHYVUrGy@lizhi-Precision-Tower-5810>
In-Reply-To: <aSXT5tzhfHYVUrGy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|VI2PR04MB10620:EE_
x-ms-office365-filtering-correlation-id: 45e91cae-254e-4bc7-416d-08de2c9113ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EjtabvfLreSxlIV3JA1UphvuE4dkfAEP7c4mXTd6AIJ3bDV653o2z3OuChKU?=
 =?us-ascii?Q?RVUHQaGO9gTmLoiq8fRtYoA5LmMJWUDAuEaG1QuKagRbDsps9JSkA5cLUEt/?=
 =?us-ascii?Q?6NpChX1e0IpL6fSZA+wkB9G6+MGiD2OBZVeZNl77dFw+NL6rWo9fAtO3AwLx?=
 =?us-ascii?Q?/RTPQa/G4Dm1TNZpsD+vJc8hWSA1o6R4BmoRn0armwJR41TYw9gVlvwxPpF2?=
 =?us-ascii?Q?Rao8HQvEFTnIEteI2MR+WhQ0fLreGTdN8Y8FmGTYJKA73BPrXaH/eZi/1mc3?=
 =?us-ascii?Q?gW5HE4mZt3texzC2m4WajDvR7RGvGO1sUCAVoyjybo/1GqTiWqob1e0clmw1?=
 =?us-ascii?Q?rx8v2tQ4h9/NSaqSDipPyKQH/4cJw6uQnBNe/Uk7IrDZd4+10r9DMqozdNUJ?=
 =?us-ascii?Q?iLvKpeq5o5UnUselujEgT48VA19fCa3q8sW9qFs9248VO1BGHyKT0G67cEnG?=
 =?us-ascii?Q?i9CAldCavp/NS5anTUUrqqQ73qf0sgQByr6a1Nv8b51D8/+PoIvq2E7coA0o?=
 =?us-ascii?Q?c5WCfIKSXVA/D8kcru1mJnY634BQcukmuoie087IcMkMH9jBuyVRIbSmOTAF?=
 =?us-ascii?Q?obPqKS6f+JNb10LI/5iumExJA8bjAy0L1CMbkq5mtoZ7YNUoK6LtIfgtJ6gm?=
 =?us-ascii?Q?QbGZuQ8hpHwRR/f7WDvB5dnJqW9tVl0VYsPI7cvWCqWtSdr5eYkavOaHZD3l?=
 =?us-ascii?Q?K5TuqVjpWfU1MaR4f48TXUvFg4X2fPQAMPiWv4S0lHwn2BSJXH0ETd956tT9?=
 =?us-ascii?Q?7dKofUjrZkVivReXtdEbKvWKhJv9C6KVJZ3N0XY2d3DvDCAmLvnQfmLqPZG5?=
 =?us-ascii?Q?eoMFcXgx+wzW+QjbRUy99eaVa+cjBSwim1pReIYRi4Zc6DelpPqIRyXVh5tS?=
 =?us-ascii?Q?dUom2IaylXe9VCUOVWA6DVSW45Jvt1UtahQZ+KO0n7xKRb3Qdy26iY7LkmP5?=
 =?us-ascii?Q?cnlH1QmiW8UWiu9N4DvAH1OlaZXS2wIbq1iS/0GZ2TAwt5oFJHFc4LnCQuA4?=
 =?us-ascii?Q?xhfOcWfrEkptopmqymxkFoSxszSLAfpJ+ftu33is2+2f+Lq1FdHsdUIdkd+v?=
 =?us-ascii?Q?b0fpivUFAmC+7zoxLYMLKgwdxBwSurtuVafaPhG129Y1LxIaslbHUXuF8CkE?=
 =?us-ascii?Q?C65p81yNc6OTKzpkUZIAy5NBSKsbkX0pvx8iMscM7ak7kVhEHnCbu7HgcBZn?=
 =?us-ascii?Q?4IyArne1eWSRWCE2dBX3m4JQ9sSqYVU7GHFkzcT+U3l+9gDSytvLdSQv9ASK?=
 =?us-ascii?Q?pqQ7mhnPB0qyffU2ZrQlLXj5EjL/LECqcO0/4MIpPF9F8YjcyrsxXC21OPH6?=
 =?us-ascii?Q?5qFW5L8ETsbchNav0IvE3PD+NWFmg+AhNCE78K/jhkTiIMt/PG4glW1GGxRw?=
 =?us-ascii?Q?An+egnq8KEcSavrUYWmq11zuseDiXPrhZc5hgwSo1icCdE7eLdxpQ54u5gju?=
 =?us-ascii?Q?OQ5gVeKXFDtTQjRegvnWhyq+4hX3nMuB0yI9OjBSZtY5EPa0aLaZnW823Sx/?=
 =?us-ascii?Q?c9SIWVaLueZx1ulJr9sfab/EciuttDDQTsun?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5hxX8tBzPbpfmxu+wwSMoGY8ekPLFjepTJNI9Ah07Av6rmIpeFFMnlbqLHbp?=
 =?us-ascii?Q?w0JVOtxPmBHyiNrnWEiCJFsY8JAwMM765lB4+23QFh1ZvFz5QUYQB3TOzd2F?=
 =?us-ascii?Q?U3k8fQFltPfT+gFRzSBt8VmL/wuC8QB9z3YJaEtikCGVEwMiZib8Q9Lox+f+?=
 =?us-ascii?Q?vGaKlhJCxFEleTDtsfU9mxgqVFdV7hlDswy2WkPDV3R5MM2pA2UHzljWEtYa?=
 =?us-ascii?Q?I7Z3hMF6W5gWpRE3kV3gwyht+HIoR5mZCoRoSetv5uYA7be5UhoNFnFcNA/u?=
 =?us-ascii?Q?n9MBb0ndXr+n+Oo8nEyQVDnAcMyAY6YciEg+WSHQ1hBQ8FxwRnR473zTo7mR?=
 =?us-ascii?Q?9VZiItE3hD0HLrCxMhxc974/X3DZbvUcsl9vsGbrHZzsr1cbXIqlYDxZlBIb?=
 =?us-ascii?Q?kFVM2epDZabA91EJhoAUJpmKzhRwtTazKSXPsB/SYxz1PkFfGVJKyz06x8vr?=
 =?us-ascii?Q?rKd3PlBknMtyraEALo6R0A/F3MFqs1gC/ldiVpqOukZTSZWjgjaUlvx2lXaI?=
 =?us-ascii?Q?SChNgM8St4WcAPav3QjBvBlXUECpE0d+v8lBmZLbWGVazCxx6ynwDoBCLSKP?=
 =?us-ascii?Q?HPHEM0piRUBHzHYzL8NYBirWw2TQPmxIBy0/ms1BT6OY0H3De8vd97ceGias?=
 =?us-ascii?Q?wdUWfFBNsyIuSIcdQM6jH+T/sRmQqbg9H7+BZZ8njFppZBi0eUwKiaacNkll?=
 =?us-ascii?Q?SA/mF30EMYT7/O7YQi8uZ1Qty/dsRRCkGqoxFd49FPPsVafjlitdQOhZ48w9?=
 =?us-ascii?Q?1AaJ2T6Yvc/t1s3mIfVAybLPNeOIVL3u47YdJifJiAMqbg+f8IB5SB6vRF8t?=
 =?us-ascii?Q?QHJ+aN01iyIO82WiAXllIhKWmZRRe+4oDXJMHDAJfOrpASADhoaW9NeWY9QG?=
 =?us-ascii?Q?bkXLOefRh662fQv7eAk8Ea/27mufXa/X52HrOIAsmphpxpyf1ct/r3VMs/ne?=
 =?us-ascii?Q?TWdr4rsGYx9xcX+znwJqiC8yZHC/2L45PZy9I4YvrWeD1AfuwvBzOZhcYBDZ?=
 =?us-ascii?Q?o0EkZSU+aeqUvtzYlQveKLYKd5glrlupJoGx5alwU3M/Xvw/Kja6mHbqTGHP?=
 =?us-ascii?Q?jGNipXQFxNI8YBMB8zHZNNLwXHckP8SuN8EoEU4gkMvgAa6VsAYImtraEL2L?=
 =?us-ascii?Q?BV2EeJJj6DFztNuB+uk2oQJnU1h6VqT98ARz0ZpEcBZ0zTw5Ny0DN8iPOK5f?=
 =?us-ascii?Q?HUywREfDWZBfTSpAzGOXD4mgb6sgBvp3dqroEvusdLGPPntSqbi0NLyhx1Ce?=
 =?us-ascii?Q?Sg/vmBlj8xKHc3Bzr9hJXnlawBVOGz284Krh6qty7OJtdCShrfq4hBlaVGAy?=
 =?us-ascii?Q?gENDPkZ1kV+QFkzPzdJTHeU8+NfijMf4h0I6FE4GtjWHPSK0t89hClau2pS2?=
 =?us-ascii?Q?A7AzDOpp1AtQ9tbPbNKNd8SPFzEQQufR+iI3r+WVWrHsKN4TaryJ+HgH6VCg?=
 =?us-ascii?Q?5yzTLk7OLnccX1yn2q9Ohs46ncAhdO+ohRiSK6ItHmoMXCa6AJtKZqZB/J2G?=
 =?us-ascii?Q?wvjAksrZaZwFcEnPfIArxQrsME/8+VNF7lyS4O2xWS3zFG90C4nJKPDyH0g+?=
 =?us-ascii?Q?s7lsvaU/B6DdIj+DnIABtRlhRwMs86eotNy6+sAZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e91cae-254e-4bc7-416d-08de2c9113ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 02:11:14.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 160L3Hn4MagZqwR28Y+8HQTZqXhNkps6S3jl2KAQ6et6U3AwDo/3PIMPpGtnu2y/DcmtbBjH4GU7McPVvMWIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10620



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, November 26, 2025 12:06 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: broonie@kernel.org; hawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-spi@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 6/6] spi: imx: enable DMA mode for target operation
>=20
> On Tue, Nov 25, 2025 at 06:06:18PM +0800, Carlos Song wrote:
> > Enable DMA mode for SPI IMX in target mode.
> > Disable the word delay feature for target mode, because target mode
> > should always keep high performance to make sure it can follow the
> > master. Target mode continues to operate in dynamic burst mode.
>=20
> If two paragraph, need extra empty line. If one parapraph, move to previo=
us
> line.
>=20
Will do this in V2.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > ---
> >  drivers/spi/spi-imx.c | 78
> > +++++++++++++++++++++++++++++++------------
> >  1 file changed, 56 insertions(+), 22 deletions(-)
> >
> ...
> >
> > @@ -1756,23 +1753,51 @@ static int spi_imx_dma_submit(struct
> > spi_imx_data *spi_imx,
> >
> >  	transfer_timeout =3D spi_imx_calculate_timeout(spi_imx,
> > transfer->len);
> >
> > -	/* Wait SDMA to finish the data transfer.*/
> > -	time_left =3D wait_for_completion_timeout(&spi_imx->dma_tx_completion=
,
> > -						transfer_timeout);
> > -	if (!time_left) {
> > -		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> > -		dmaengine_terminate_all(controller->dma_tx);
> > -		dmaengine_terminate_all(controller->dma_rx);
> > -		return -ETIMEDOUT;
> > -	}
> > +	if (!spi_imx->target_mode) {
> > +		/* Wait SDMA to finish the data transfer.*/
> > +		time_left =3D
> wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> > +							transfer_timeout);
> > +		if (!time_left) {
> > +			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> > +			dmaengine_terminate_all(controller->dma_tx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -ETIMEDOUT;
> > +		}
> >
> > -	time_left =3D wait_for_completion_timeout(&spi_imx->dma_rx_completion=
,
> > -						transfer_timeout);
> > -	if (!time_left) {
> > -		dev_err(&controller->dev, "I/O Error in DMA RX\n");
> > -		spi_imx->devtype_data->reset(spi_imx);
> > -		dmaengine_terminate_all(controller->dma_rx);
> > -		return -ETIMEDOUT;
> > +		time_left =3D
> wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> > +							transfer_timeout);
> > +		if (!time_left) {
> > +			dev_err(&controller->dev, "I/O Error in DMA RX\n");
> > +			spi_imx->devtype_data->reset(spi_imx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -ETIMEDOUT;
> > +		}
> > +	} else {
> > +		spi_imx->target_aborted =3D false;
> > +
> > +		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion)
> ||
> > +		    spi_imx->target_aborted) {
>=20
> Suppose somewhere set target_aborted to true. I think here should use
> READ_ONCE() to make sure read from memory.
>=20
> Not sure why here use wait_for_completion_interruptible() but at master m=
ode
> use wait_for_completion_timeout().
>=20
> > +			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
> > +			dmaengine_terminate_all(controller->dma_tx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -EINTR;
> > +		}
> > +
> > +		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion)
> ||
> > +		    spi_imx->target_aborted) {
> > +			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -EINTR;
> > +		}
> > +
> > +		/*
> > +		 * ECSPI has a HW issue when works in Target mode, after 64 words
> > +		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA
> keeps
> > +		 * shift out the last word data, so we have to disable ECSPI when in
> > +		 * target mode after the transfer completes.
> > +		 */
> > +		if (spi_imx->devtype_data->disable)
> > +			spi_imx->devtype_data->disable(spi_imx);
> >  	}
> >
> >  	return 0;
> > @@ -1895,10 +1920,16 @@ static int spi_imx_dma_package_transfer(struct
> > spi_imx_data *spi_imx,  static int spi_imx_dma_transfer(struct spi_imx_=
data
> *spi_imx,
> >  				struct spi_transfer *transfer)
> >  {
> > -	bool word_delay =3D transfer->word_delay.value !=3D 0;
> > +	bool word_delay =3D transfer->word_delay.value !=3D 0 &&
> > +!spi_imx->target_mode;
> >  	int ret;
> >  	int i;
> >
> > +	if (transfer->len > MX53_MAX_TRANSFER_BYTES &&
> spi_imx->target_mode)
> > +{
>=20
> why only target have len limiation?
>=20
> Frank
> > +		dev_err(spi_imx->dev, "Transaction too big, max size is %d bytes\n",
> > +			MX53_MAX_TRANSFER_BYTES);
> > +		return -EMSGSIZE;
> > +	}
> > +
> >  	ret =3D spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> >  	if (ret < 0) {
> >  		transfer->error |=3D SPI_TRANS_FAIL_NO_START; @@ -2104,7 +2135,7
> @@
> > static int spi_imx_transfer_one(struct spi_controller *controller,
> >  	while (spi_imx->devtype_data->rx_available(spi_imx))
> >  		readl(spi_imx->base + MXC_CSPIRXDATA);
> >
> > -	if (spi_imx->target_mode)
> > +	if (spi_imx->target_mode && !spi_imx->usedma)
> >  		return spi_imx_pio_transfer_target(spi, transfer);
> >
> >  	/*
> > @@ -2116,7 +2147,10 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
> >  		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
> >  		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> >  			spi_imx->usedma =3D false;
> > -			return spi_imx_pio_transfer(spi, transfer);
> > +			if (spi_imx->target_mode)
> > +				return spi_imx_pio_transfer_target(spi, transfer);
> > +			else
> > +				return spi_imx_pio_transfer(spi, transfer);
> >  		}
> >  		return ret;
> >  	}
> > --
> > 2.34.1
> >

