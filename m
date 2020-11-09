Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8AF2AC7E4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKIWAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 17:00:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32194 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWAU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 17:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604959220; x=1636495220;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gVySOS8fakcetGUqOdCBGLQ26TJ//OJHVTj6n4lh59Q=;
  b=MN+tmqxl07x0zgAH7Y2tXTaXVAKKEZCLEPIIGXinWazTdFkHm5iL0Bx+
   7Ibly/tdyLAXZh71V4ezGvNgdOoS5/VrAUAtWiA/07rU8Oz3g6QqJuu52
   SttDN5+gu3IfQW+qVEQTHGN4ngXDczSlYNKfPWdGxT9Mpun3oCHiPi+wb
   VOHqTjQ4KekPzA/66vjaM4mH8Dg8VobqYoKkBLwibBrfuaHS4cbAMD/45
   Pg4Wv8CbPvdcS50EzO0VbgmMMjiXUBcb8pSuFRxRaIKws+qraYSI5FKbV
   D9RTN7tAeEpOcLS4W8Iqrrjdtq94ccKA1eZizGKFiGkeCPvPPzWiFUj1H
   Q==;
IronPort-SDR: HjeNOS5eWYU971jpT51mCkotNkWxva6AsmGdV/0qz+wr1ASirqAYUwpa724QnLrmUAXWVPAWwe
 EgU5vwknh23aUlp9lcog4GRbYXRnMkTO7B8dfcipywM+zmr7wKzMn7JOSERgIr48glbmXMegsO
 LBBwtNWhXi5Tc3tvMywb8OLrjHzK2WRT6qSTiAnDloexYkZJY2opcWmHTT1LtAtVcORDBrXI66
 byMAwXOICITd7ujbyCXvzNjvE7NokulxE02iJBjO26q1wpTv8DyqRlCsdt1zTpxc86YeaBALt9
 9e4=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; 
   d="scan'208";a="152323691"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 06:00:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1X9iJtlNIAKKMu6RZ46zsr2hZcGKRNid8M+jTcfZPIpGn2jarUtdFVDHWZvtVAskPfA2O40kr/rC2rgU5BDDFLakfA1U+f/BLP41wOL2bKf5JPDvc+4XngK8gM90m2DOX3rO3VpLtjnJhxKmojqwyee6xPfB3MrmrHz/7UogaQwiQ4qPJflbs1Mdeum4DIPd7+503b12up/Jmt9Wo1gIyK1cRmnhzQAlhlrA/is01GD+UBMIKRb+G6FPeG8q8TSglfQgKzDeoHVIFG1XBZamf71kVGLW47u4RtJQeEjXTUXy3g9F1KHpLXEoIBdJC1nZte6uvIUXTj8vpEQymop8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2YZbNjrkhWlRgvz9mvDvLD7atOxugYZ74Ac2hsG35s=;
 b=SCe7qIXrgRgpINhjeggDqNc+xjtySAPcADarSkf/aNk6J0MMj/gvRlKbOZUpm4mwGtCl2fCqtmWaer8ae+tPTNfsCNTQfyUo3bEnhCZWY1xZWKf9/L38ioLvCEe5FZb95JhAel5Fs4r6oa+Jc6jfi9vPgRu3RNFiB+EzU5nh+t6w3DB64Jyj61A/6OE1MfXWQpvzFuI6jabbTkLLlFWVZE2IC/uNGybz35KtiHDj5E/vbQPlevS9bUzwQ9w4+f8GgoCgu45oWBfHerCHDImBVJBqjP0bD5PojZ/3MfCWSiXgUwC35G29bfRtJYYrWQTUgTobEvUFDt0URg3FSuHVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2YZbNjrkhWlRgvz9mvDvLD7atOxugYZ74Ac2hsG35s=;
 b=k2nAGGMCch7kcIddlR9/tSklIOBQu09utlQXxebkVHKaE6cg7NZlWY6DDDQ4mxPHt3zOlVPmsHTBK5eeEU/ah2WG1q1gUFy7gnhIzbxNgqTEzix7a+S7qEBosCLwvoOtZgp/X3ghUXxvSZ/Co3keOeOtzITXngpVQyjRY551utw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6477.namprd04.prod.outlook.com (2603:10b6:208:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 22:00:17 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 22:00:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
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
Date:   Mon, 9 Nov 2020 22:00:17 +0000
Message-ID: <BL0PR04MB6514C9D94E2098EEA0A8462FE7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <20201109212158.y34otj3uy2hev75c@mobilestation>
 <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201109215524.GA1819368@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 491be48c-fc5a-401f-16d9-08d884fad80c
x-ms-traffictypediagnostic: MN2PR04MB6477:
x-microsoft-antispam-prvs: <MN2PR04MB6477031AE3749A055E8DA06AE7EA0@MN2PR04MB6477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuPBSRrVofK5SHBOP17VwvN9ZTlJvftEU/dm1EV4DpfEVqsfQqDYzduAvCZ1XzOv9Ky8OiFmuCIQvLJHsf2j/xrfK8co43xsn+jhNPrwmJyW3Hle804GbtEHDTOLgH6MHAEZRmZqvp6a01Z1S+DL+9Lyh70HcBchf4TkwWksAXq1x2/sm4Q2CjMkwCTqMZP+fcynkp0BZEGxJe14Zl3VjwoWgYg3Ft6kU4aR8a96SrocAwQRn3wXDcVyUpAu+OwhhljM1OXC/Lns0Jx9YuXVPKwnkkJVY09No28CN5sJ3a1QsEJt6wBDlxGHarJCfI8S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(55016002)(52536014)(71200400001)(9686003)(66446008)(76116006)(7416002)(8936002)(66556008)(64756008)(66946007)(53546011)(66476007)(5660300002)(91956017)(6506007)(6916009)(8676002)(7696005)(86362001)(54906003)(186003)(2906002)(33656002)(316002)(478600001)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /vcRxQKs96NL/VyHKAwSosYX0BReL2GPCTr5Isv+ywzmupOBkKBmU0zYwgwJHOuadYts944mZAF+0oeVsS0+E2HqsVeoeeYc+zPiKdTRZZYKi/ZbYuCUZGNBQlKNRDQnVyqSZGT+INsFu3QNByutpKl442ZqWYn3lcuQoD0gS9IgtWqTONuanvVai+5k0nD0txrWleiBJOqMdSu7cWn3DZjMHiFOY4V2422j+VZwoIAzINQmna+2P7ILSCLp1OfZnTp7iufpE5u+co9+EsYNJpmkouFmEQ4mWnjHBAnq2b8PltnZK/3tjiBqmRWV6IQhQxCRa/ketQu6v42kiocXvRJx+D83cafEYnghNuz2Np92QJVoOuA++3rr96SmAlQwSqaM4ffFZ2LUGALFUwV6CsGSn91jArdM6Sswytcq2NBAmH6EfUwdJvhYRLcrqmcmg30gm+QXTho9ftnIjFtffkG4RoO19VRqIiyCt5MpGkokKsT4yFzsT3H5Y5/E47OtFpxHmcAX79LWSEJ3Ki0KvL24pDKOnn+bULUUaVsVeKvDmYTXJX6GVT7odUA32+lN4kPaM2+k/0ZrhqLe/jS/kXEnsIJscLDaZfuLvv3ptRN0VcJLcdsrfxYdB2bgA49LISUaPFzZ/tAR9DLvkYV+iHqQDrhDw3t2bSRQgdzLtUlUYPkcQHGl8+aw5QIzIGvZc8gLE04AdquGgwBKpLlsxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491be48c-fc5a-401f-16d9-08d884fad80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 22:00:17.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s34iSV/Z1Lg1ZjaKwohbr6S+SpbadShkAXWPshRC4WujcSnmbukfEiwLlNgWmFsNqyWMVdF72+axGB4Zi1DsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6477
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/10 6:55, Rob Herring wrote:=0A=
> On Mon, Nov 09, 2020 at 09:39:19PM +0000, Damien Le Moal wrote:=0A=
>> On 2020/11/10 6:22, Serge Semin wrote:=0A=
>>> On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:=0A=
>>>> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits=0A=
>>>> ctrlr0 register format. This SoC is also quite slow and gets significa=
nt=0A=
>>>> SD card performance improvements from using no-delay polled transfers.=
=0A=
>>>> Add the dw_spi_k210_init() function tied to the=0A=
>>>> "canaan,kendryte-k210-spi" compatible string to set the=0A=
>>>> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields=
=0A=
>>>> for this SoC.=0A=
>>>>=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>> ---=0A=
>>>>  drivers/spi/spi-dw-mmio.c | 9 +++++++++=0A=
>>>>  1 file changed, 9 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c=0A=
>>>> index 3f1bc384cb45..a00def6c5b39 100644=0A=
>>>> --- a/drivers/spi/spi-dw-mmio.c=0A=
>>>> +++ b/drivers/spi/spi-dw-mmio.c=0A=
>>>> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_de=
vice *pdev,=0A=
>>>>  	return 0;=0A=
>>>>  }=0A=
>>>>  =0A=
>>>> +static int dw_spi_k210_init(struct platform_device *pdev,=0A=
>>>> +			    struct dw_spi_mmio *dwsmmio)=0A=
>>>> +{=0A=
>>>> +	dwsmmio->dws.caps =3D DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;=
=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>>  static int dw_spi_mmio_probe(struct platform_device *pdev)=0A=
>>>>  {=0A=
>>>>  	int (*init_func)(struct platform_device *pdev,=0A=
>>>> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_ma=
tch[] =3D {=0A=
>>>>  	{ .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_ssi_ini=
t},=0A=
>>>>  	{ .compatible =3D "intel,keembay-ssi", .data =3D dw_spi_keembay_init=
},=0A=
>>>>  	{ .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},=
=0A=
>>>=0A=
>>>> +	{ .compatible =3D "canaan,kendryte-k210-spi", .data =3D dw_spi_k210_=
init},=0A=
>>>=0A=
>>> Other than the comments from Sean and Mark regarding the DFS_32=0A=
>>> feature runtime detectability, I couldn't find a patch with adding the=
=0A=
>>> new new compatible string into the DW APB SSI DT schema. Have I missed=
=0A=
>>> it? If I haven't could you add one to the next version of the series?=
=0A=
>>=0A=
>> Yes, I will. I forgot to change the DW DT binding doc for this. I did ad=
d a=0A=
>> patch for the "polling" property but forgot the compatible string.=0A=
>>=0A=
>> In any case, I think that this new compatible string change can be dropp=
ed by=0A=
>> switching to automatically detecting the DFS32 and using a different sol=
ution=0A=
>> than the polling property change I sent for the RX fifo overflow problem=
.=0A=
> =0A=
> No, new SoC needs new compatible string. Especially if a new vendor. =0A=
=0A=
My apologies for the bad wording: I meant to say the change to the list of=
=0A=
compatible strings that the DW SPI support would not be needed. So from the=
 DW=0A=
SPI point of view, there would be no new compatible string to add/document.=
=0A=
=0A=
> =0A=
>>=0A=
>> I am still going through all the emails trying to understand what to try=
 next to=0A=
>> avoid the polling "hack".=0A=
> =0A=
> Use compatible.=0A=
=0A=
Yes, that is what this patch used. Again, I think there is a chance this ch=
ange=0A=
can be dropped.=0A=
=0A=
> =0A=
> Rob=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
