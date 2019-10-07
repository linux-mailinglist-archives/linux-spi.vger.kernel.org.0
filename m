Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2FCE62A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJGO4r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Oct 2019 10:56:47 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:20290
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727589AbfJGO4r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Oct 2019 10:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPwzI3RWsioIePWUReE/tdaCQl02M71+fbnDEiQ0QOs3lfbcdwlHDVpDkYxfW0MtKP65igKajWJ6rOCp7+mQg6I0BeSXkf5qbgnNsrdzl2fLddlp70aY1ZaNcosWa8Sjs5y3iK2Q38Dd0FxvCvNbef95pB8yf0qH47I/2RS8lAJt9iQw2RsiQawYes3TZiH6nnfeeQ7PnM6GPa8VBw0f3D3LaIK7jr8ogcvs+8rlWG03MIWGduTcMcf4VOrLqYEuHZhJ7rJKZRyYeL60akEzSOK2UkgGWwegu8D8lWOL6yRhSgIJB1ZyEsEyxadS7a0opOtIDl70AqBvP12Pp/S3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lcN8IG23IEUYY/8C0d76+GjBIGrxG/KlTzCGDhznCI=;
 b=Tt+XkFBzx6sVp9f1NJV+EuUCgZM6hEc7V3+1GWi7GquT6TodFVBMNQV+ZOtlupVZEo5R31d6RqBWzl34hh25pY5VzrJ6mO14LkowVNCRqcODoci8nGoFf15FXkg5MuaI88rBbbBQoThVMF+8g+eeWM0BhJfNTw4yyw4U+pFEaLefoRRfeYlnuVjuRf9Gl1DjqUCaRAF/MQVpsnN/tLuL4YcV9L3Eg+ZsoNd1rjxEJ3y6G2AYw0GFccIx32hKAMbVjFAPpqgUNOkzf3xepxrvq4qOW816xfCFh6dke5HtEENFTXApBu+aKK0+a93NzrfHpC0it43nQka9sctcFnzs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lcN8IG23IEUYY/8C0d76+GjBIGrxG/KlTzCGDhznCI=;
 b=Z5CyBf0CnjLXgK1qBArnzOoCZ4v2rNYsbT1r5VoOXBwJnO+zfl6FyvcywEFjzGg3+No29P3/pR8I8OXhDyVA0VkvYQVAAQ+SP+XJGaGvXjkhq7mivTLUZR1JnEAPmOOuIQdhrE+6D626FYWlDwigidrfvrBB6WD/zajPJW6C8fs=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.34.75) by
 AM6PR04MB6695.eurprd04.prod.outlook.com (20.179.247.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 14:56:39 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::550b:474a:d86a:1967]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::550b:474a:d86a:1967%7]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 14:56:39 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different
 invalid master Id
Thread-Topic: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different
 invalid master Id
Thread-Index: AQHVeDaNx9WIVsU7Tk6OBiwESeYpGKdPTi6w
Date:   Mon, 7 Oct 2019 14:56:39 +0000
Message-ID: <AM6PR04MB4967B073EEA50BFEE2F69C6D979B0@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
In-Reply-To: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50458cfd-9866-438e-ed0a-08d74b368f33
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR04MB6695:|AM6PR04MB6695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66958A287911E0A154DBB7DD979B0@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(13464003)(71200400001)(229853002)(2501003)(14444005)(256004)(33656002)(110136005)(3846002)(44832011)(305945005)(316002)(2906002)(4326008)(6246003)(6116002)(7736002)(6436002)(71190400001)(9686003)(55016002)(74316002)(25786009)(7696005)(6506007)(53546011)(66446008)(76176011)(99286004)(81156014)(8676002)(81166006)(5660300002)(8936002)(478600001)(102836004)(11346002)(66556008)(52536014)(86362001)(2201001)(14454004)(446003)(64756008)(26005)(66946007)(486006)(186003)(76116006)(66476007)(476003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6695;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zcgfr/SXRObkneZcYuEl5cp6v/3FW3QusNll4QTWuXeCsaA/NMzPYjkepGMvLJZdqMWP6xuz/lmrCOCnKHitYMm6TfQ0hiz9B5vwOixXPi8YCbXixhjJIOoK+qWQSgoYsLPoBxeU40EOl4hB7hsFomh44PC6rAZzCHwhB0en2QhZV3Ztgpfj8mXgcfkWqD7NsSIU57iTnRgol0JmELJgexZWMRq9h5Gjk32unbfsERYkwtFszF66cbRFI1oSvM27URezcppM+W1GuuLnqnLMbqJjReu9n+eareaLk+gP4d5Bor9yo3zDo5cUKBdKD9bXOBxchnpWdzN0ui6KbhYoCrjgre0DyUJzN323P9TFpo1MRDGyxB5ENvEG22UAG3wyWshe/0Vcd9PEdAah+E3Uw20SAGjPS9MW5mpXBNvEoxI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50458cfd-9866-438e-ed0a-08d74b368f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 14:56:39.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmMb5vN84uCpM8+zJPWM9tHT9v1uEBzxDsYNGhB3gP9cs0fKRNe9U7WgEsbl0OLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6695
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
> Sent: Tuesday, October 1, 2019 3:59 AM
> To: Han Xu <han.xu@nxp.com>; broonie@kernel.org; linux-spi@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>; Suresh Gupta
> <suresh.gupta@nxp.com>
> Subject: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different i=
nvalid master Id
>=20
> Different platforms have different Master with different SourceID on AHB =
bus. The
> 0X0E Master ID is used by cluster 3 in case of LS2088A.
> So, patch introduce an invalid master id variable to fix invalid mastered=
 on different
> platforms.
>=20
> Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c inde=
x
> c02e24c..51385b0 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -63,6 +63,11 @@
>  #define QUADSPI_IPCR			0x08
>  #define QUADSPI_IPCR_SEQID(x)		((x) << 24)
>=20
> +#define QUADSPI_BUF0CR                  0x10
> +#define QUADSPI_BUF1CR                  0x14
> +#define QUADSPI_BUF2CR                  0x18
> +#define QUADSPI_BUFXCR_INVALID_MSTRID   0xe
> +
>  #define QUADSPI_BUF3CR			0x1c
>  #define QUADSPI_BUF3CR_ALLMST_MASK	BIT(31)
>  #define QUADSPI_BUF3CR_ADATSZ(x)	((x) << 8)
> @@ -184,6 +189,7 @@
>  struct fsl_qspi_devtype_data {
>  	unsigned int rxfifo;
>  	unsigned int txfifo;
> +	int invalid_mstrid;
>  	unsigned int ahb_buf_size;
>  	unsigned int quirks;
>  	bool little_endian;
> @@ -192,6 +198,7 @@ struct fsl_qspi_devtype_data {  static const struct
> fsl_qspi_devtype_data vybrid_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_SWAP_ENDIAN,
>  	.little_endian =3D true,
> @@ -200,6 +207,7 @@ static const struct fsl_qspi_devtype_data vybrid_data=
 =3D
> {  static const struct fsl_qspi_devtype_data imx6sx_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_4X_INT_CLK | QUADSPI_QUIRK_TKT245618,
>  	.little_endian =3D true,
> @@ -208,6 +216,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data=
 =3D
> {  static const struct fsl_qspi_devtype_data imx7d_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
>  	.little_endian =3D true,
> @@ -216,6 +225,7 @@ static const struct fsl_qspi_devtype_data imx7d_data =
=3D
> {  static const struct fsl_qspi_devtype_data imx6ul_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
>  	.little_endian =3D true,
> @@ -224,6 +234,7 @@ static const struct fsl_qspi_devtype_data imx6ul_data=
 =3D
> {  static const struct fsl_qspi_devtype_data ls1021a_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D 0,
>  	.little_endian =3D false,
> @@ -233,6 +244,7 @@ static const struct fsl_qspi_devtype_data ls2080a_dat=
a =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
>  	.ahb_buf_size =3D SZ_1K,
> +	.invalid_mstrid =3D 0x0,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_BASE_INTERNAL,
>  	.little_endian =3D true,
>  };
> @@ -615,6 +627,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, cons=
t
> struct spi_mem_op *op)
>  	void __iomem *base =3D q->iobase;
>  	u32 addr_offset =3D 0;
>  	int err =3D 0;
> +	int invalid_mstrid =3D q->devtype_data->invalid_mstrid;
>=20
>  	mutex_lock(&q->lock);
>=20
> @@ -638,6 +651,10 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, con=
st
> struct spi_mem_op *op)
>  	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
>  		    base + QUADSPI_SPTRCLR);
>=20
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF0CR);
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF1CR);
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF2CR);
> +
>  	fsl_qspi_prepare_lut(q, op);
>=20
>  	/*

Acked-by: Han Xu <han.xu@nxp.com>

> --
> 2.7.4

