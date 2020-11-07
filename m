Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC82AA585
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKGNmv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:42:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39175 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNmu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604756569; x=1636292569;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EyfDn3dO+o9gop8SiRYLxECvpV04e7ByOl3C1JNEBLU=;
  b=SfBf+u6Nie/dc6/c+3P/ExfqiogQzthcVGRFryeAXxqQCFkho7UXfAko
   tso6u5U+QeRdMflrlDmgUUsxAWlXFl9CCp+jk7Mq5Abd3FgrQa4B2gEFc
   Q1DHh30SqH/ovRcT9xXgacuc10T7ya5HSHa01dTQA2jmk4MFwserihGMw
   hU1lz6bGvkO1wVRSHQW9qh1JnOBf+mIIuXZkuW3NhyU1g+Rk09tq6P9ZV
   kaCrdeRQstP27LLFqCJAnVADdx8roSDml09vUoHD+ZSzopn9gdOKSHGOP
   7Mjh6uMKJixY0aXLLCLEGeZV1b3aZ67Jm56uRa65/JCT0lYNFEToML4mR
   Q==;
IronPort-SDR: A4aSZLLGl5EZdIWY+N3M5ViKR9/FkWKOrbpw737WhmXKais1PiW/YKilou8cKT2Pboc4sx4iYB
 ScHK1Ra7OdDmugGfpOwKpnoIqwYKzWOpWq6uLCyOLTBSM34O0RmrIDNKyE7BSgW5njw+1nYD6K
 Xseh8244sCRThdkjd9AH9Hpc1++oY8x1UUveVLFTT0h7tfnsXetzN+3Nzf8JdLXyJHL6L/zX7U
 EWo9cF3Y5kDlMtqWdxYENkf3WUZaTXaBEgFMZe+cFPtWfJbs8lDVlvvTxAR8NPQsr1OBOZuOxt
 Co0=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="152196681"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 21:42:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgrMqyu3BXfLLeVII3s15cDpi/VeryTVfYBsHKbG0zkr3s2374ba++HMdhn8JfNvUpjAhTY04RKZRlaepRETOUvlpbfj70e4yvxnLSiU+z3z22gh2DBqWru6IZW2Py/Y650NL3KyeE2+soVXiSv6r1cZXqCixgAY0jvcOjHrnt6zW7bx8/0iqGQGBaOaJVOTZcr190lmkTFlvMs9oo38Qadvs5t9vkDzv151WjobWW4HRakETAtFR8PjLVR/aM3jmXfwtTYGvuJ4UjFP5fpLY7TOkmSrro5cMeAZOSdAMOHhaKP96Ys0eDQ6XUFvS3DbSyHkpLb3x7L8wHWycyTjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoj03cmZVHA5K9Oe2WO9gJdqZWY0+mU+e1gQBlpTDtk=;
 b=eHzXg7hYsnEX4PMz7PoA7GHxUttW1V3dNiwIPC3FAC76Sz4OhZIgCUnrTWw7Z3tYyPYRi6+l8ZjyUZCTKIBD2jwJO+xatGDWHJFFvz6dfDmKb3lvozF0BsJbzaDLoi4eV1ohtRfk6Sr2jmS0jRXV5xWVbhXeoa2gQ85JdttXa0seADm5oyHdxMPcX9Glp5JIvh7Gz2uGejQWXZpWACNsqOnBP7x76yKHijb6/WD8VaEUtlg+qEp9+nOAXeiJuscV8eer15bx8b9Is4Y4pknah2UJajTCnw/XjvWwWN0HARxjJ5r7g6bae3zViIqu8C1qjEW5X3R5TA+o5B8tzbRMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoj03cmZVHA5K9Oe2WO9gJdqZWY0+mU+e1gQBlpTDtk=;
 b=ga/zI5ldKZZSKOnh57LivrK4A++HNjocv5vQxn5F11qGKy45jT1yfKhF403mDchxfUqZdSe92S+isIcE+h4lW1CtcT1NGk7L6VPgSj8Yf49iHloPOzJInjpGFL3Mw4pXFH32wLlzKnj3ZAud6ShTajnVM7CDSDWaQ0jwa8rmQ2M=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4980.namprd04.prod.outlook.com (2603:10b6:208:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 7 Nov
 2020 13:42:46 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Sat, 7 Nov 2020
 13:42:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sean Anderson <seanga2@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Thread-Topic: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Thread-Index: AQHWtN4N0wumwRzXdUGPL6nbxUOPpw==
Date:   Sat, 7 Nov 2020 13:42:45 +0000
Message-ID: <BL0PR04MB65145CB4FC66106B62E179CEE7EC0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <53859725-ca0b-5f57-9147-10346707b3cb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca959040-81cd-49a0-2926-08d883230271
x-ms-traffictypediagnostic: BL0PR04MB4980:
x-microsoft-antispam-prvs: <BL0PR04MB498007F07A1BF1A2B9CEBBCCE7EC0@BL0PR04MB4980.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L85EEZvlO8jJ10iCG8ML4IcBic53nTUiRuSNr4hTI1+4xXytMFNgDK0vUMrxsL58Mm2sYd6WJeQZf4mgAYq8DiqJFsYRpJFHINXZoHojnczZg/t7mHoxnX1XrrDIZCrI2Uf0YyY1W0wGmqIFE9tH9t0sjgFhZx8QppRHWY7wcs2epM3cI9+KPTfqpKPHVzUCm3Yd93mUPiV3NUSg9GLcMGaNFX+SkNqhJFXJzLjFBQXEV3SWI+n4GAU0YMu0ODXui6TazGFpKWimAyy75NU5zU9b6Obnwls4B4h+R+QMIonjq/n9DgViaY/jjI44XT1GeMvir4mHHcqW2vFpDyr0FlYmjr2OD1o13xy/0CdVfkdfls2jwMtlw6j4hbVQ9STN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(316002)(66556008)(8676002)(66476007)(110136005)(83380400001)(76116006)(64756008)(2906002)(478600001)(53546011)(6506007)(66946007)(86362001)(71200400001)(186003)(91956017)(8936002)(33656002)(5660300002)(66446008)(52536014)(7696005)(9686003)(7416002)(55016002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SKTT4yQ3lnNEUyl96rxsgHx23YoMxEbP7jv/QTF5GYSR1thvZZvU2/TWqkybvgHworDAO6h43nFcU2/Q2tAm2+Hdd83hwieCZorQ7rIDjAE2XP5pWchzFV+/J3qHGpKJ9j8ekL68uldwW+NHvI5WRwUyeNsekIglpXz2t+xhUB1RBtboOPJZkfZAYlNqV/SIE247IPEwY7UgPOGcECd0bZSt+SLGZsjydRjJ6KmDSNQVVYfdVn2Zz1UYMQhMDBab7H4hjElAx/nOpifhsQDWwxoeoj1cdxvGi8deJZ2JxbYDe3pWVU16Ka8h/1g9u/ihbyAu8bE0A0yHa0AbJY9ySgNApoENLyfwzMXwsemVHjqRMDx906DPeRg5ejndKjQxwl+0KBd7fEcZ6sFIxnAK/pUgQuwQGhmLoJdpoTKGIxFgp4vBfy7wbdJlBgSMlzRYy2D2p1JHh3Va2S+HTlHUYtJW/h+0m/cjLoHMmmk3a5Aq2bqZGB0NdtRF+9Q/83KiX5D4m6SMTW+VsoPwrGkOq8J30+H23DS9VMXEt7zwaLoTGihPrUkH2ByhoAq0BWCLjtLxkg3+gH+/iCwuUP8ExR/voqR9b/nMDElBxqQZniLw7bMG6mBMG+OBrGvo0/MqKzdKEZdk/HWM351T4nFcyd5jNNreVPgkaOXOpjn6jJ60IGehBCHyPEuCCUhBaKAQe60bvNcsxfpdU39h/RAz6Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca959040-81cd-49a0-2926-08d883230271
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2020 13:42:45.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxyyQcW7rDF6cW5ejfAL2+MEoVXacszDH0foUjf/1UNIlQKAc+ioJy8VJcIIFVffuJ4chrLSEB0Cba6EmNz4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4980
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/07 22:31, Sean Anderson wrote:=0A=
> On 11/7/20 3:13 AM, Damien Le Moal wrote:=0A=
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
> =0A=
> Can't you do runtime detection of DFS_32 in probe?=0A=
=0A=
I think it is possible, but it was much easier this way given that it seems=
 that=0A=
only the K210 uses the DFS_32.=0A=
=0A=
> =0A=
> --Sean=0A=
> =0A=
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
>> +	{ .compatible =3D "canaan,kendryte-k210-spi", .data =3D dw_spi_k210_in=
it},=0A=
>>  	{ /* end of table */}=0A=
>>  };=0A=
>>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
