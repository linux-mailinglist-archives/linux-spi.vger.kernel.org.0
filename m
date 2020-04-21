Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439281B244D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgDUKs2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 06:48:28 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:1415
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUKs1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 06:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDX88B4naxcIWixpSeeKcvRVdvLGzbCRuzcOQZ441/PFUMByIriH6rxxTUGxrT+zsyp4vC2cDWx7ZoNJGxuJ0RiMvUWUSHsgL6gPaFXNr992JBRQj4eLX2pNybbOTfqp6oDUDd4/s8E1dztUyYF1G3JE8GV4b0QJRggupXItCykBGoxdN7nQZHKyrLlp2RLw+b5/LebERX0Tqstsv2CKS7aRjCQzJmiKUEzhFik/BO6MLJFl4Ga3R7Oe9kN0JqmeFX2557AAISguhWUBuVNt62Bj9le4u5TH4j19IRBbplXe0Qbv6CJLzYDBXWGyCA2qj7X6ji9Ogkhi6PAntR4mgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTz/MIlGmhodBFfu85r5AQGrN3PIaHBj6vKYbzVMhxE=;
 b=TRS+2mHUL/ZSxh5Bj6C5+l8Fq0vhYjAQEPlmuNlRiskUirtXkpUoWl5richoklu9qfRWqTNgeqVn+BVC7yTyr+cnGvR40fXYHy58di4IaLK9YDL8fWW/yc9YRnPaiLbmXy/anPOX6SUyCE7ROE7Ea/xjxdrqhigzAk6l1eErFlEpIskQOvjyLbkDHtJU8Jo9ZLjLNo2g1QyYwThGZ6UtPIA6hU0IFWeLE9OxnodOjo9tr+qgMS+R+T8tHHEHnQN+t5wdamNjLaA3zT9xqT03cWGHQqsbRj50nDbeWkPyH3GC/0jk9MRQOn7YWRproBkau7m0V+cn2kdhwuqfSfuZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTz/MIlGmhodBFfu85r5AQGrN3PIaHBj6vKYbzVMhxE=;
 b=IpFttvAnVeS+8eLMrtgkdcAMlDgZhEdnHaBZVJzaobgBN9uSs8D37jLJ7ej2x/OWPoouyKteXUDgY9v6RpGfJ+/cpejrckK0tiBNAEgUAwzfYCUKf1UsollTdN+bdz6ZumrhrB4nbKliPu6shCi5sgJg8U1Xd4YCwp6PpZRN00c=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR04MB3193.eurprd04.prod.outlook.com (2603:10a6:7:22::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 10:48:23 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::c84a:5e6a:b6e3:4a1f]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::c84a:5e6a:b6e3:4a1f%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 10:48:23 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>, Han Xu <han.xu@nxp.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] spi: spi-fsl-qspi: Fix return value check in
 fsl_qspi_probe()
Thread-Topic: [PATCH -next] spi: spi-fsl-qspi: Fix return value check in
 fsl_qspi_probe()
Thread-Index: AQHWF8CB4WhsoBnUE02CXSTlcmNhpaiDYV9A
Date:   Tue, 21 Apr 2020 10:48:22 +0000
Message-ID: <HE1PR04MB31965ACB33866E9A673472AF95D50@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20200421093908.48213-1-weiyongjun1@huawei.com>
In-Reply-To: <20200421093908.48213-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [106.215.98.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3a82d1c-fc4e-4983-e0bc-08d7e5e18378
x-ms-traffictypediagnostic: HE1PR04MB3193:|HE1PR04MB3193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB319309CA29916498FD085BE795D50@HE1PR04MB3193.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(316002)(44832011)(26005)(186003)(71200400001)(64756008)(66476007)(6506007)(53546011)(66556008)(66446008)(52536014)(478600001)(76116006)(66946007)(55016002)(9686003)(86362001)(5660300002)(4326008)(110136005)(54906003)(7696005)(33656002)(8676002)(81156014)(8936002)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAt+JJyF/95ystx1DavRcRf1ym05t8iowZRyXvfTVL+uEfw69kw4eTVk7wNupEbsQOD4R99+fbAhyRXGhIM0sg5Juvi7W1o+MIx3WVjcvrPVlxx47fN+Wv60pvK3H/Sh9+mumRpkCJbxII7uTxfqfNJ7hhpOXJWvZ0oJv3/c2WUTLL9IlSjVDI9bsH4NQHIekZo3aU9lMFQ5tPCFQSTZs7BMkRQSPqdZpxGY9rDcp2d/+PbkDBuL997Q6Brnblkc8v9468BTYyQWp/tnXfIGMEBQwwUswPh51+QAxbJDYvLF/ZDNKHIwRbE3+LGsVpP/CofLVQlbiMAU8eRoKudvNgjO08b9lr011Qpb8doXVmC7aBCiyV6/OCH4q2a80IMqncPkUkv5DDLScYy1raBcMeawMVCm+DVbltMf6LlcloIeOw0mz/jeAGMKyx5Uhj4O
x-ms-exchange-antispam-messagedata: RYWnvithbtkWacHwWAdzcULuFmhJUDuUcMLNXZ+orDkXOl25J3G3RUgh/ueIg0chOE9nbzPeMwCRGHQmUUNX5Gh88EwaNvbxwiEKTW1kj+feJJMpyzs63Zj7SfSvBwL7621s2+IOeA3TootXHy+EGA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a82d1c-fc4e-4983-e0bc-08d7e5e18378
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 10:48:23.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZp1CZVtxNUaUNfDFJRNE7eqYqVleuQSLb2p9lnAZ4OHNv8VeoGwKyv5pTieER6zdxxzzUsWyOY2tryvNqEmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3193
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wei Yongjun,

> -----Original Message-----
> From: Wei Yongjun <weiyongjun1@huawei.com>
> Sent: Tuesday, April 21, 2020 3:09 PM
> To: Han Xu <han.xu@nxp.com>; Mark Brown <broonie@kernel.org>; Ashish
> Kumar <ashish.kumar@nxp.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-spi@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH -next] spi: spi-fsl-qspi: Fix return value check in
> fsl_qspi_probe()

It sound like all return value in probe() is fixed.
Please reword this commit message like this:
spi: spi-fsl-qspi: Fix return value check of devm_ioremap() in probe()

>=20
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be replaced
> with NULL test.
>=20
> Fixes: 858e26a515c2 ("spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 ti=
mes
> AHB buffer size")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c inde=
x
> 83eb8a484faf..6766262d7e75 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -880,8 +880,8 @@ static int fsl_qspi_probe(struct platform_device
> *pdev)
>  	/* Since there are 4 cs, map size required is 4 times ahb_buf_size */
>  	q->ahb_addr =3D devm_ioremap(dev, q->memmap_phy,
>  				   (q->devtype_data->ahb_buf_size * 4));
> -	if (IS_ERR(q->ahb_addr)) {
> -		ret =3D PTR_ERR(q->ahb_addr);
> +	if (!q->ahb_addr) {
> +		ret =3D -ENOMEM;
 Reviewed-by: Ashish Kumar <Ashish.Kumar@nxp.com>

Thanks & Regards
Ashish=20
>  		goto err_put_ctrl;
>  	}
>=20
>=20

