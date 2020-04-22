Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1C1B36E8
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 07:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDVFmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 01:42:40 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:26386
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgDVFmj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 01:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N993X9NeleTTuglH6VvmQETbkBiayGVjGuCZ8UTQqfkjie4xcDZBZU297r3TDmlF7Tlqv/MLG189VW73JG6Y7jJMiRjporHhz2MDYcrFlZjK7pfp0RKemThL41dU59kH2zWVpO+eHZDOpn3hz9WhJx60itH6cimrZNVQhtZ8lxNlbQiot12smG3o0jQdyejLFAzOsbTl191YklucHDmyzkZPDUdxjR1IJNT0JhWqGMMlHMX0He/b2YRdRsZPhN1Ky9MyJ9Uh2qcUc0XxT2OLU5KOsNpox9qkqtIkdwwTx34YRfHRNs1YAdFfc5FheyKPjGVuqPEvJGgqde3CwZv6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e/H/K/okVgBMG8qTVGepR28N8IeAfoVO1TEWkLEVDg=;
 b=e7hFWx7p0yecbcYqa12W8F/HKRzTxbU3HjDVCOt3abEivOzypOEaTo4QZP6ruWKsg74uojzkXfQQcIKunL7n/3DHs1T2oBesP2unzgE3lmm7j935Afj+vnLiO3TXeVtlfpgc6XXhoB1Xr/m2CbTafatXc5ycUFNg70AcrRIaNOIkMj7oO/7ACnglL1pkHYeLzDSX7QVbmFTvbBNWqDGwCtQj038Ep3Y6YLhwMX/kPb3Vl+GgFAiNvTKwM4gIGNo+fqxDBc9XVFU50Uvb4bsH7xnNzqOQUJqT6+JJjit7ukN19TQ5w+QXxwMWVY6AHSgWo3voK3v7HfEVff1/G9bpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e/H/K/okVgBMG8qTVGepR28N8IeAfoVO1TEWkLEVDg=;
 b=cHeOTao1wCf3PvQcioZCksVPjCtzNooTKdjT53+1AIryn68XkyQD3QjMC4LOeO/RxQShkqZ7TwUQL927qIDBw3413dnqSwbzGzksNEfGT2okzJEF/d3O4rCWkCOci89S6Tik8bjFN3MS2cn33IwdkqhD0gCmzfArJCjmo9gVtX0=
Received: from AM6PR0402MB3701.eurprd04.prod.outlook.com
 (2603:10a6:209:1a::16) by AM6PR0402MB3877.eurprd04.prod.outlook.com
 (2603:10a6:209:1d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 05:42:35 +0000
Received: from AM6PR0402MB3701.eurprd04.prod.outlook.com
 ([fe80::d8e6:42db:b8be:1e1c]) by AM6PR0402MB3701.eurprd04.prod.outlook.com
 ([fe80::d8e6:42db:b8be:1e1c%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 05:42:35 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next v2] spi: spi-fsl-qspi: Fix return value check of
 devm_ioremap() in probe
Thread-Topic: [PATCH -next v2] spi: spi-fsl-qspi: Fix return value check of
 devm_ioremap() in probe
Thread-Index: AQHWGEeMvsnTe1Ix2EWObznN46qi9qiEoPKA
Date:   Wed, 22 Apr 2020 05:42:35 +0000
Message-ID: <AM6PR0402MB37012FFCC4DC632FC3536BD597D20@AM6PR0402MB3701.eurprd04.prod.outlook.com>
References: <20200421093908.48213-1-weiyongjun1@huawei.com>
 <20200422014543.111070-1-weiyongjun1@huawei.com>
In-Reply-To: <20200422014543.111070-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [70.112.23.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 504c1683-d8f2-4e17-72ff-08d7e67ff5bd
x-ms-traffictypediagnostic: AM6PR0402MB3877:|AM6PR0402MB3877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB38775C2DB7CA9BE75A72B33F97D20@AM6PR0402MB3877.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3701.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(6636002)(110136005)(66556008)(66946007)(86362001)(81156014)(54906003)(66446008)(26005)(5660300002)(76116006)(71200400001)(8676002)(6506007)(2906002)(8936002)(478600001)(33656002)(53546011)(186003)(52536014)(66476007)(4326008)(9686003)(7696005)(316002)(55016002)(44832011)(64756008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ib+IsmBcQUk4g8xghRQdF+93nkJDcrEskwtlwe+ezcjqaFsoN+szAA92I8WbtHzFDbNaS162KhlcHCyUf0fyAR0z8QE5U0r/aEPikPWzMnSyf9CDR22BbPEaCwECprt0Y4vL1CfJqY7NAOxcqjD17nBvdRw7/44kKMYt2UV6qMr29isHCmmZekx2kMvEQgNrvrPNaN14aLl15AFlzifzYslny0f+nVCrQpK7TxVvEBgGD+vbpewkPm9gtIQYHbYhIpx+Ra3khxWohlbdp4SNauFRJbnpHKoNqWK3nhdnk/emcdiOagBqdJRraz2JTtVtG2UT0NLOHYj0QfwP6BSTvRFGbHz1o+omHAwEHMI/75g19i3zon7AYXlEGi1R4kcdOiPZ8EGnGgY9h4wW3W0061qdG6aoUP/u5qGkCLPfue9D6MkxV+D2jrHKhMQTVHto
x-ms-exchange-antispam-messagedata: 2fF9YqRJKLnkRo7aP61E3U9B6LxxX9lqLl+D7nriWQe++xKEZ7K2EfPNLeTFChyjgbaq/nPXIGmm8lL4+jmwfbX+W82Szyi1FbpaG6YIe5z3FwTyWqef1NBLZa+fNYT3Db860jpIdofOiv9bbkRBmQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504c1683-d8f2-4e17-72ff-08d7e67ff5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 05:42:35.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed6yEIlpNsdltogqyAow/04cCGAsM4NU6O4VH0CRorMiPlDTMmlra50twWfwezWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3877
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Wei Yongjun <weiyongjun1@huawei.com>
> Sent: Tuesday, April 21, 2020 8:46 PM
> To: Han Xu <han.xu@nxp.com>; Mark Brown <broonie@kernel.org>; Ashish
> Kumar <ashish.kumar@nxp.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-spi@vger.kernel.org; kern=
el-
> janitors@vger.kernel.org
> Subject: [PATCH -next v2] spi: spi-fsl-qspi: Fix return value check of
> devm_ioremap() in probe
>=20
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be replaced=
 with
> NULL test.
>=20
> Fixes: 858e26a515c2 ("spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 ti=
mes AHB
> buffer size")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Ashish Kumar <Ashish.Kumar@nxp.com>

Acked-by: Han Xu <han.xu@nxp.com>

> ---
> v1 -> v2: fix the subject as Ashish's suggest
> ---
>  drivers/spi/spi-fsl-qspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c inde=
x
> 83eb8a484faf..6766262d7e75 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -880,8 +880,8 @@ static int fsl_qspi_probe(struct platform_device *pde=
v)
>  	/* Since there are 4 cs, map size required is 4 times ahb_buf_size */
>  	q->ahb_addr =3D devm_ioremap(dev, q->memmap_phy,
>  				   (q->devtype_data->ahb_buf_size * 4));
> -	if (IS_ERR(q->ahb_addr)) {
> -		ret =3D PTR_ERR(q->ahb_addr);
> +	if (!q->ahb_addr) {
> +		ret =3D -ENOMEM;
>  		goto err_put_ctrl;
>  	}
>=20
>=20

