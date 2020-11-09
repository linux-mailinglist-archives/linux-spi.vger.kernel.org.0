Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C874F2AC770
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgKIVjY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:39:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28547 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIVjX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604957962; x=1636493962;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MUU59PgXzNdolf9yqQBKX2r1v8wNb7v5kWdKTrVfz6U=;
  b=N2JIhEuJtHtI6C/bzodkJSVrOIpavuB/vXqY/l4F30Fh7mAA3S+7AmrR
   aNaoNpfb1qVCuE/vwex1m31jjz9Y+xZ2Xq6tuCnaG6ZzBhJyCEO4oymL6
   7NOZxVioq/P6utjr/seWYRsYNbB+2SKMSW8LN2rnhLKliE3AvLGHsfruO
   HV/FuXb8oXXXSv/Z113RJL8fHRABqrY1/n+JJQBiMXUhggtXvxUSYf/2K
   dHV+uE4lO6QepfWN9PjmWBBR17QHbZ1OMnSfxqWDx1WxEZWrVGRNEt9dq
   HT7rqTsGSGsKHjmgME+9ihXM3btx/Jf0VR4rfSdDWBTcX2nbNk5Zpm7bQ
   A==;
IronPort-SDR: 4RXB3Pra7QmoFcG0BcEfPS+4DEwfdZbsbE/LORWvacHmZcb9mJCPVt5J1BLf2xl8CbHYT+1X7H
 lNojHoZ+2O5WfWyIG2U8nD1YYXUrOGDUvhHQJpp7Vw30UZ7AX82JDGOO73jGW2i45jA6ehIlZ9
 WJHVlL7YPxnSpJx4ht98cugkaY9/XqaPMg43DrKIz9r+aJcZpYSj/Ub4rUpprlAWvyDfe1HduM
 yxIk0XCtE50iqN0Vb2k+YcoWzB+BKuMFaNaWYelkbetgoJpe0I0dYo5IQCJALBdiuPW2MvbFgA
 fsQ=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; 
   d="scan'208";a="262225475"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 05:39:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmeqwHws1DVU1JH1vavGlLx/u/g6UE/pI1L8fMTFc3XAoZUMzGXqfAhyhF7XVcGCTJZ3qiUDagpx/JFqZhGsNhcueRzu+G3ZqGx9hT7LukLi65VNTZCZFyWXuxl1EhANShXD4BugVN8XBI3BuohbUlKEVSq9V1/6WrIXDDSguLup7eINBF4LPZy1PKE8ECg5ZgR+6J7i2twVetZJRvZISZeozCVi1s6T6wu3Sdt2l/KpIIovfd6i/TxijFyHXZKv0mfltsAx2zqD+9R8oaafCfPmDCiz9oryceFvGjPuGqRBLEkfywJEmQ02ZFul+n1zdH1vgllC/3YsyUPxn+5/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyI8kQ+p/OY8FQkWgRR7wqCWgbte95uHuqGPpC1yD+s=;
 b=K89i7qbzqYsEPtNEKJfDVAWfB10hY6QfoasxG9TQDYSxbkJjTdGm2BDUsHqyb76x7XC1pDYn5pqNxfmyuuQa8w0gatM1ml2A/M/l6iZ5OEPLPSZTS8JLrAJ+/WktfoM0C6J3oiFMz49LkIslML4J1FGODA9eVJgBoPOdB1839yznAOqgqW/yjOZ1KHdUsYG89qS3WgDKkQrugoOCQzr+vJSvEWoNbnif4nDzBFhdPpNYsCyfmEttwdz1hRfMTnxvE+9hr4KOoLDdfCzF01pU2yKtOWK3LLzySkUA943zcjyImYLejrsj1ys3KkMrReN3gTLViq7w9YIo/LPxdAgERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyI8kQ+p/OY8FQkWgRR7wqCWgbte95uHuqGPpC1yD+s=;
 b=jGbNLUNB6rtDqNZUlTdSHJcpMKXbtGf7iSUQ5exPwCi7O5wAFsbdaW25crxV6UvNK+0+B8qEiZfdC/oPuPRjcpmMdCrZbZO/gN1QCylDYgr8Y6B+ecBVJ6UkNBV1S+Rmf89LMmh5Hi+gmcZ1qUICLfs4/4HcXUJEO3Bdy+J0QWA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6531.namprd04.prod.outlook.com (2603:10b6:208:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 21:39:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 21:39:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Thread-Topic: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Thread-Index: AQHWtN4N0wumwRzXdUGPL6nbxUOPpw==
Date:   Mon, 9 Nov 2020 21:39:19 +0000
Message-ID: <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <20201109212158.y34otj3uy2hev75c@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b6e3fc7-a35a-4c75-5fa1-08d884f7ea56
x-ms-traffictypediagnostic: BL0PR04MB6531:
x-microsoft-antispam-prvs: <BL0PR04MB6531BFED5F85EEC7EA71C17CE7EA0@BL0PR04MB6531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEYqwIkd7GN09dco3rVtYSNmEp9xwdoXI3VpsjDpLenAX5owHnkGU6lv9NYsRnJBQKrSBKeErsNpfFmHO2CJEL/0sN/X9vAw8/BAcisCjKp1G90OElUwCUxfIaveGuCLZmsf//CTqHJYZrWWuObTYMTqJuBblOifbNn64U9DIr+MOZ64+30P6PTFdUoDBBNpGzmusX3UDuY6lxMGr/lPFhbXNnkL5gIQw8mU2yXGdS7JbKSyh6Y2dLooZioIU/cI8VQ/XKnzJa6W+OZBtuZsbZNUPcWeD5lnp6zBFoVGw6JwJ2UWF8QePbqStrwDF93/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(91956017)(186003)(54906003)(64756008)(6506007)(53546011)(66556008)(316002)(66446008)(86362001)(55016002)(4326008)(9686003)(33656002)(7696005)(66476007)(71200400001)(76116006)(66946007)(52536014)(83380400001)(478600001)(2906002)(6916009)(7416002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kTRzw6HpYRE3uL3GyI+6okkp8gx+O2UPmxMEprkx2sF8EJcD917ELP6zP1QABKrEgYhHXjtZB+pF/QD8TRQu5gufKvVvEC2yByMm0gpCvJCXkLl4id/ahX9KE/z4oPDQme1xzHmEFclAV8niA1HN8XJ6j4lPtIdAJbTfHqO6SKWwOl2JK/WL9m6ATi19AaI6s1X/K4granf6g6kY0cy2V3ztFww4rs5UU0jUog1dzzLuyZzrPtsJ3yZfBvKtJ16rv+jrWBWL8OeNGdKd+UKrFCnJcedSOE1j/2KwhjOm84lq8BCCFEdnskDfnU1lFFpCgUEoP5h5GIDthCZad8JhN/vaCWGySY7Crhg+zCsvg6JjGs0+jAeoFqntWJZRobUCMzpoEu7i8h6IjlZsLDpRmKw/WsRGM4RT55TUpqVi3E+SDVkFr+th0AoVf2/kR1wZ1KBR/MmgMtT0uD+/9dAa3HmvFurgHWsjTwxvm5MtclxH6MIGaKRlxnA4/UpZNvWnnjZ6b3shK9zRVUHCuWRoMDKF115r9CAcKAaMUZpsjoV1/A53UZFZAAUDD9HjOGBppICi8ux1D+rLMiGrRZZ5RQ/AJInEmvFntdGsoWOQDUfBFcjBiFchrEddiAit4ulLqilmbXnhpiSD4i5ya9YwyDhcYq5KtVH0UirxICiDx3bMSjaFXS0RXfkk6oEB+Lf8355wK4/mQ/JU5gtT/+bVeQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6e3fc7-a35a-4c75-5fa1-08d884f7ea56
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 21:39:19.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff7lm4rwVhCoMdU9XnJOpTkQma273qddUkCOb3WrtZQApCwOKQu8Y9FqJoGc/IGp3xnMqkbm7ygmGAdaEHPSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6531
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/10 6:22, Serge Semin wrote:=0A=
> On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:=0A=
>> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits=0A=
>> ctrlr0 register format. This SoC is also quite slow and gets significant=
=0A=
>> SD card performance improvements from using no-delay polled transfers.=
=0A=
>> Add the dw_spi_k210_init() function tied to the=0A=
>> "canaan,kendryte-k210-spi" compatible string to set the=0A=
>> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields=
=0A=
>> for this SoC.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  drivers/spi/spi-dw-mmio.c | 9 +++++++++=0A=
>>  1 file changed, 9 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c=0A=
>> index 3f1bc384cb45..a00def6c5b39 100644=0A=
>> --- a/drivers/spi/spi-dw-mmio.c=0A=
>> +++ b/drivers/spi/spi-dw-mmio.c=0A=
>> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_devi=
ce *pdev,=0A=
>>  	return 0;=0A=
>>  }=0A=
>>  =0A=
>> +static int dw_spi_k210_init(struct platform_device *pdev,=0A=
>> +			    struct dw_spi_mmio *dwsmmio)=0A=
>> +{=0A=
>> +	dwsmmio->dws.caps =3D DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>>  static int dw_spi_mmio_probe(struct platform_device *pdev)=0A=
>>  {=0A=
>>  	int (*init_func)(struct platform_device *pdev,=0A=
>> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_matc=
h[] =3D {=0A=
>>  	{ .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_ssi_init}=
,=0A=
>>  	{ .compatible =3D "intel,keembay-ssi", .data =3D dw_spi_keembay_init},=
=0A=
>>  	{ .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},=0A=
> =0A=
>> +	{ .compatible =3D "canaan,kendryte-k210-spi", .data =3D dw_spi_k210_in=
it},=0A=
> =0A=
> Other than the comments from Sean and Mark regarding the DFS_32=0A=
> feature runtime detectability, I couldn't find a patch with adding the=0A=
> new new compatible string into the DW APB SSI DT schema. Have I missed=0A=
> it? If I haven't could you add one to the next version of the series?=0A=
=0A=
Yes, I will. I forgot to change the DW DT binding doc for this. I did add a=
=0A=
patch for the "polling" property but forgot the compatible string.=0A=
=0A=
In any case, I think that this new compatible string change can be dropped =
by=0A=
switching to automatically detecting the DFS32 and using a different soluti=
on=0A=
than the polling property change I sent for the RX fifo overflow problem.=
=0A=
=0A=
I am still going through all the emails trying to understand what to try ne=
xt to=0A=
avoid the polling "hack".=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> -Sergey=0A=
> =0A=
>>  	{ /* end of table */}=0A=
>>  };=0A=
>>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);=0A=
>> -- =0A=
>> 2.28.0=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
