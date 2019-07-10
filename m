Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92ADF64856
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfGJO2B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 10:28:01 -0400
Received: from mail-eopbgr1410105.outbound.protection.outlook.com ([40.107.141.105]:43712
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727556AbfGJO2B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jul 2019 10:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILBZReeuGM+PkdIif3M9ShMvOeP/tFICrKlzSp0I5aXY9TQ1N2AJsZE8aFhsgTvElcEiLLpc7cV61r7igBDKh8jXW00QAAFAMo+zJ8N690nfqkhFthUdzb0Z5yBPn7Pe061AA6jNclg0d97+yOLWyOkeOhmAT60jsOpuZj7u1ngOQ/7evbia4L0L5o2ifpVzNDqRIeun3ITbG0kgNNPxi1R6mve7DeNx65o5jRGWPQ6erwmB++yYbK1o/hvmRJZUqVatMp6f5d6uPAdAg/eyOSdzcJ7BqIjHcEBWVn5FQ+Q4RGGTkskgkRWUBXymg9/4UlR1LwDSfUD0AcLLQRxuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJECFwTXqISO1hB63wMFhmHcA91eQ6YE9dkXBikXTEY=;
 b=A0bZbyOrJFHf3feQI7ook4xRGy38CiBfJgMg8+Shv0obvmAf0jQlj1sNCryOkb3YOF4jEhshS7c/C/FUiN/AhQU4iNBHiVGKySwtp2UW60OuVcxx74RR44qANSBtacq8RBkLFx4L7Am2Gk0ow6Zuk4Pu0L+gxGOLao6RyrpmG7w2MyFUMDA06BR7kJcOZyvBTji7NcWL8my55Pch3pqEwkX9Nh3Tf7A/G2MnnRmcXHQKxrdrdjMEPEF3WB/BnOjT8clnUe7r965v+mpjDtbTOjEHWej2PGQfXZmbCmYKmYmUNqSX9NqwXpGZItjGvtEzxNNqtRMUycYpdNX4Rn7I1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJECFwTXqISO1hB63wMFhmHcA91eQ6YE9dkXBikXTEY=;
 b=Xu9lgehlo+5JQNvKsRCt3Wi6ZaRbV4CkEi2O+sjpFwts+SkJmJ8obBaF8gUfTqN8jhZwetltkRy4ckAjuvDI8n/SehzZB4TykRtv6mrXicr1YJLM8Q+ac8OFLQbay7oWmx5zIZbx4+HI5cb+TbKdBsgHkpdLX3PHoQJ5e1qO1Sk=
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com (20.178.139.140) by
 TYAPR01MB5005.jpnprd01.prod.outlook.com (20.179.186.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 14:27:56 +0000
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::8545:d750:c6eb:4665]) by TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::8545:d750:c6eb:4665%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 14:27:56 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v1] spi: dw-mmio: Clock should be shut when error occurs
Thread-Topic: [PATCH v1] spi: dw-mmio: Clock should be shut when error occurs
Thread-Index: AQHVNxSbKvkrG3DXckSFYjl6nOwze6bD4lZg
Date:   Wed, 10 Jul 2019 14:27:56 +0000
Message-ID: <TYAPR01MB4015F09D9F384A2E168270A8DFF00@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <20190710114243.30101-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190710114243.30101-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3d7c9a-12b9-42ff-d3b9-08d70542cd4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB5005;
x-ms-traffictypediagnostic: TYAPR01MB5005:
x-microsoft-antispam-prvs: <TYAPR01MB5005B075509D222797083B87DFF00@TYAPR01MB5005.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(51914003)(3846002)(86362001)(446003)(68736007)(33656002)(6116002)(8676002)(53936002)(81156014)(81166006)(25786009)(6246003)(55016002)(486006)(66446008)(66476007)(64756008)(66556008)(76116006)(14454004)(66946007)(11346002)(71190400001)(476003)(71200400001)(14444005)(66066001)(74316002)(229853002)(6506007)(52536014)(7696005)(7736002)(4326008)(76176011)(478600001)(99286004)(5660300002)(2906002)(53546011)(8936002)(6436002)(316002)(9686003)(102836004)(305945005)(110136005)(2501003)(26005)(186003)(107886003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB5005;H:TYAPR01MB4015.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fQbMOEgGM9uc6UzMglH/0Z/Ak45HgL13fb4HYJrgG7wFRr4PNOyr9fJ8hfq51NRX9Uefkchr/owdQN7ZYB/NILQzgCvwGlDyyKsmfN9LKuxEOIMBrtmNpMXUq1oBv5Cp0yYGnaHUNTFcX7fZGfO1Y2k8gslMdTiCF7d/SSYUtgLV64A8/UBDCbr1AtxyuRG6VTwmZ41sboRDFcTX1YtPFXXwMGszJDQVDd+8qYeZLJUTfoWyec5ZpeFVFpjUzplxg7LVk+l/otCiYb5sx8X2zxk9pFMumA8S8mzQycWZr5ppy3BPmqLTTz4tIjDdIj6a2AcVxp08WI5/XMS9ai8xoa04svYz5Ov8SM/T5thpvU0maH5riK349ZpAR0FuHZ62CF/EW6iPmel83v6v68jChnWwx4ZE1029fJl5H36KVYc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3d7c9a-12b9-42ff-d3b9-08d70542cd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 14:27:56.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gareth.williams.jx@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5005
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

Thanks for the patch.

On Wed, Jul 10, 2019 at 12:43 PM Andy Shevchenko <andriy.shevchenko@linux.i=
ntel.com> wrote:
> When optional clock requesting fails, the main clock is still up and runn=
ing, we
> should shut it down in such caee.
s/caee/case for the typo.
>=20
> Fixes: 560ee7e91009 ("spi: dw: Add support for an optional interface cloc=
k")
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c index
> 1c1cac92a9de..4fa7e7a52ebd 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -170,8 +170,10 @@ static int dw_spi_mmio_probe(struct
> platform_device *pdev)
>=20
>  	/* Optional clock needed to access the registers */
>  	dwsmmio->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
> -	if (IS_ERR(dwsmmio->pclk))
> -		return PTR_ERR(dwsmmio->pclk);
> +	if (IS_ERR(dwsmmio->pclk)) {
> +		ret =3D PTR_ERR(dwsmmio->pclk);
> +		goto out_clk;
> +	}
>  	ret =3D clk_prepare_enable(dwsmmio->pclk);
>  	if (ret)
>  		goto out_clk;
> --
> 2.20.1

With the above corrected:
Reviewed-by: Gareth Williams <gareth.williams.jx@renesas.com>

Kind Regards,

Gareth Williams
