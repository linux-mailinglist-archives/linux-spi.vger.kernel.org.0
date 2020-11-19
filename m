Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F72B90DB
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 12:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKSLWc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 06:22:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29318 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKSLWa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 06:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605784949; x=1637320949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ge/pHFZW6CmfDvVtpZh+cDiAkaVqXt3bMUJWG4eusys=;
  b=mj2rO86EYmYlM7PJ9YMULrFjq/xWLekXiVVjdE1fT9Dytr+RkwGVdpUI
   oVBsb3oEUKg2jvSVRxvJVHE7J2BkgLKoWtMYKRwsS6KYx/ZMsUMxTDq/v
   HXJkYwbAF6jOAKc99rTxLYhYdGWJWYl2G72JwGMU2pwiZcRmCc3PLmPMg
   s42WtVEwYh1ZehNgIPRUUqND+jOX5iirRZ9DJ9MmVD4LMLYZSl55mrtME
   F9YAVKgd3QFvjhv2IsW7XFO8cyvu2ZWICZyeNn7aUfF1+yr5oWFdbW7Ci
   rfuJk3vtFxKWfVZ+TwtUEZOPDQdbynyRPLv/aqVoxlEF9A70/Rq7JWOQX
   A==;
IronPort-SDR: bckLJJlFupBQR7v/b3SA8Y5+uc437CmYLqChIx+dNpD1NzTEICTgPvhEaHxbO/UDxRuC+BJSYA
 Sz9O2I7LYVcCECTcAawEJktIj6Xk8/yVsPBlRJjrcsLWvwMHhLBk1bniXaKoQMxHQg8GkpnIdp
 R2hXtAEgXneFmeGR812j2H5bB07/IvTRAR+gh6hMZrP7S9EzTVTVqShEEyu3G73Yp0NcFjfZ7l
 JtEIVIbk0Rs9ZE5uyjURURyU9RkzVLOceGtw5Z1GyS7rahwGaNk/BX6IIBPVow7R9/hI5ztnna
 /EQ=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="153062735"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 19:22:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ3Z+5YpPeGRtQxH8zdKTJaLgFMZqFRY44fwgL5cO3cMG7O/qG6xsev5gSuAHSMKGKvQKmVprLbprwMp+KaD2e5uxjRLXb9SWTsEJ2VopVEL1GUawq+rK/KPwvSrdCx7G29QlWQUP1xsJM3YCjg//e8co/wx71EktP9y6QSvoYEAdH7Md5XnkqyPgqjgz+wo3AKBQcRVghgFFq5J0B0zNrHdwD4VLmNcNPkhFkz3E/GxemYYKbAH0WtqF9AFys7XsW6rYD4vX4G7kFJ9KSa9YcvsDcCIbYmM1bXXN7+dl0c4VI/sbDVOMhVZla1w1A8Ni40rA1bMktMjDlgTT0q2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6SgIfPUJbXPreM+cABcdMc43jWJnuJZ0/aVS+wIlAM=;
 b=bOeEpFfkwc9VNcorFIFqHwTUu9JTFuemzbfr+IV6Ai4YrJVKQYT+DhRxL9zBdF7JF9wc7/hFeIonhyPh7RRkiykJpsVD+NG8solo21d0UqWAzI/+rqQ9UdDpSLlfyFUBELj+gzhslhkoREIs0NYpDTJLLTrPe104nIiMJdUZBNogvGr18TwPakGJrEyB3Ayh1yU/0rLErFwy6EkS6TgFCvLzj4XoBv+7juZDIS6eLkFXPx0IN2vzUqF9vFhqzgp6Oxra3V/x+luv+Qd4d+/AOPXut+kKJIkE96zY5H3a0rvInf3oOFFNjps403Zn+31PIMANjBHVK2h6fioZgMY7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6SgIfPUJbXPreM+cABcdMc43jWJnuJZ0/aVS+wIlAM=;
 b=EZO8seH7wnbs2qidBAe3ju6e33iPkZnBmlW3jWw8hPF+LcV//MrHobpBeDTrQoOOJvruQA4YrzeBMu8xcOqLA3rzDuNPOTew21DLAYIRaL/minzICZAFL0Omh5zoM5KDpSpDofQZkWQWtszEBP12rb8oH9nqN4I6CeOaFDdnecU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4532.namprd04.prod.outlook.com (2603:10b6:208:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 19 Nov
 2020 11:22:25 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.034; Thu, 19 Nov 2020
 11:22:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sean Anderson <seanga2@gmail.com>
CC:     Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
Thread-Topic: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
Thread-Index: AQHWtN4pogxbCuVPg0qTFpKg863FNg==
Date:   Thu, 19 Nov 2020 11:22:24 +0000
Message-ID: <BL0PR04MB65143886DECE34E61DAEE9BBE7E00@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-25-damien.lemoal@wdc.com>
 <20201109153625.GB1330401@bogus>
 <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
 <CAMuHMdV0GL-GoY5=cgsW5QEWPB=ySK-8EyVeKLwt=6oODV4z3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:752d:4d55:43bb:285f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00869975-0540-4f71-f18f-08d88c7d641c
x-ms-traffictypediagnostic: BL0PR04MB4532:
x-microsoft-antispam-prvs: <BL0PR04MB45323F90958417F013493B16E7E00@BL0PR04MB4532.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rq+ve6LCXF4g9af8TPbLbNO7PReaCXOfSATaoYMUwySmsjzpj+wE1jMZ49rQLGpw35YiT+e8mNL/Eq4MlMC9lEa46+np1Zu4tCEkuTLMkyT4GvShUSrS4Xhj1lizvO/SnqK1MhiHIXbGjm1GExJ0pS71MnVgavRYV17ovfutmc+Gym+DCM+xAJGHhduv+4SSadiB5x7GnNBnlc1KC4zxQXmpbK4FCGF9WsP/5xO8yx1VODrFTNwX22ULgOrhgVOtTFqmVN/bNCb/aGp0ptHzRaz/OVdDzEETLfoCr8ROeuQKTS+pI/f1zCnGRTXmuOZLDnu1IhK/8F9jepveiSBYUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(478600001)(110136005)(86362001)(7696005)(316002)(6506007)(53546011)(186003)(7416002)(4326008)(9686003)(55016002)(8676002)(71200400001)(8936002)(54906003)(66556008)(2906002)(52536014)(33656002)(5660300002)(64756008)(91956017)(76116006)(66946007)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FmKh0QTqnaX2zOf9cWNv2UPiJzB6nv8H6upvyzdyvNCzDo7TNzbJ+oN36msQqf51kqkyakY0rOzdJ5o7RSJwWcaEfKtY0W7EncTNSJog237k6rDPG9lemZ+LCYaej+93yZRDUuA5mQKH3Xn80lZ3uKfQBaQJZPuWM6qdYbLSE5f2PnZt6PV6iTt5P3F5+3fFfsdGdGwiJTzLLWBha1NV/whlOQDoZY1T5I+MgxKgze9o9Tavs+xvbNWYdxXNm9XPdIt+zQwT4ekzClwOs5uWrnPlzW8GSk85z6FfNoqmrHQYWXCIBKqHymfpD4DEqeoLe/cTUdFlij4WAemrq6Bit7W6dW9asUCSVsVXwYfGH5mvLnBS0fPPyY1isT/oTh3WvsLy71n9gSCpUwQ5MwoWzUVT5sB1ORVLmET1HzjRUwP0je1cJiRDnvThWcYESIfO1Jrj7LR866lO0w4f836AOm9LPYVeTWC2BIG8AEaIBOeoZaFItWottB1dYqZyq8aDkGgq6kV/yLAyr0tdnkPQ8hKqhmsTD2kJUS0KA+qMuTd5WgeWA2EMHyq3zGHaqLohIcwMI/6mtQkhO166I8kuq8TB21QW4efwED0QzQcyMVT0ZPAKdE72Gcv+6Hmk4tnXovtWnah939L6b5196uZ3IFsTk6G3aB9z+3cdFWyxYdBfo/76TBKZNjd7uUXUT49hmxNf5o4ZeH8F4l2TUVmg8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00869975-0540-4f71-f18f-08d88c7d641c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 11:22:25.0010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2ChgSClezmhD6HYH7GBdpdRYPPYywegTC9STL1RQ4GdSMZEc/kbAFzqG0fSu47V6dBMotmbW4/pMj4EoEpSQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4532
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/19 19:58, Geert Uytterhoeven wrote:=0A=
> Hi Damien, Sean,=0A=
> =0A=
> On Mon, Nov 9, 2020 at 4:46 PM Sean Anderson <seanga2@gmail.com> wrote:=
=0A=
>> On 11/9/20 10:36 AM, Rob Herring wrote:=0A=
>>> On Sat, Nov 07, 2020 at 05:14:12PM +0900, Damien Le Moal wrote:=0A=
>>>> Document the device tree bindings for the Kendryte K210 SoC Fully=0A=
>>>> Programmable IO Array (FPIOA) pinctrl driver in=0A=
>>>> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml=0A=
>>>>=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> =0A=
>>>> --- /dev/null=0A=
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.ya=
ml=0A=
> =0A=
>>>> +  kendryte,power-offset:=0A=
>>>> +    minItems: 1=0A=
>>>> +    maxItems: 1=0A=
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>>>> +    description: |=0A=
>>>> +      Offset of the power domain control register of the system contr=
oller.=0A=
>>>=0A=
>>> Sounds like you should be using power-domains binding.=0A=
>>=0A=
>> This is for pin power domains. E.g. pins 0-5 can be set to 1V8 or 3V3 lo=
gic levels.=0A=
> =0A=
> Which brings to my attention the power-source property is not=0A=
> documented below...=0A=
> =0A=
>>>> +      The value should be the macro K210_SYSCTL_POWER_SEL defined in=
=0A=
>>>> +      dt-bindings/mfd/k210-sysctl.h.=0A=
>>>> +=0A=
>>>> +patternProperties:=0A=
>>>> +  '^.*$':=0A=
>>>> +    if:=0A=
>>>> +      type: object=0A=
>>>> +    then:=0A=
> =0A=
> As the driver supports e.g. bias and drive-strength, these should be=0A=
> documented here, too.=0A=
=0A=
Thanks for the review. I fixed everything today and ran everything through =
"make=0A=
dt_binding_check". Will send a V2 series tomorrow after some more fixes and=
 tests.=0A=
=0A=
> =0A=
> Gr{oetje,eeting}s,=0A=
> =0A=
>                         Geert=0A=
> =0A=
> --=0A=
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org=0A=
> =0A=
> In personal conversations with technical people, I call myself a hacker. =
But=0A=
> when I'm talking to journalists I just say "programmer" or something like=
 that.=0A=
>                                 -- Linus Torvalds=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
