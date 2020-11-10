Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF82AC9B8
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJAfs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 19:35:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60387 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAfr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 19:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604968546; x=1636504546;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sVSvCHAUWLM+sWxTzHLGpEBqs4okxf/NrsrNdnDpFMM=;
  b=e/kaKj7Epdlj7g8csi4TDQP4gwG1vTxe2gMzoZXz9igC1ZGXP1u+Oof4
   tC9MX7uS23UnrcUria67aZFZcODhls0riAt1pY9IhM6CX6miRp4tdkcPM
   n8R0h+/sE3g6BEBmTCv7LOO5qln4OV4aGnyg72kVv9qf9l/XltJIrkBH0
   BzO0juoKHJHmbocqielPM+AaF8VyeQeAzwIRl/nmTU8g+vfr0OLqJZrrY
   K7JNbxlccB4+jDQX3HZ9YSxbfu+dsEo1cBpL/c4PslTSBwP/exAmMlqLy
   PrTfuyIT+dBJJATpm8wtSgDl0CfbX9CBRV0M6nFCCJIOG2HOHELmMcezZ
   Q==;
IronPort-SDR: w1oIWVub0oQrkk7u5lxQj5Mv5DeKfSn/HFvVigYF3tKpNMPzjJJt0/lhunWxBW8PhFFT/zsnN0
 fcv12wuKQ3EuI9gumw4hWXJ3qvOPBMBXQXa961+5EPHHoMKBKfvrq+EWKrKGDlo5Mch9ThFSAF
 qXeBPRHs6biMx1fcjAuR5bJJRgT9SMSX5gaj8GcGYoVqd0xWoeefYnbuj0NoKNr8q+Dn6L6Dwq
 ShTbGlBqR/zzZzNFWpDkP85v/ByeIEh+xJm3PIjFm3Ij8mynuecq95tpVAc9P4jztLMG+nKCv0
 CII=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; 
   d="scan'208";a="152332490"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:35:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnVUFSBKjGI2lD2niHi45GUQMlEze+A9QE8M5K11EJPL3KtoXSr1LsccbzZfYaYLuRBgL4YXc6hI2sO36nVhxap7ZpJaG98vIc2iWpFQS3t8FWWW09NiQspeem1Et9PGzohfq7fohaSAiePK7qThAM5hO2wdZ4uStXv469LW4FXnn15cGq+Dg2+ldS8gntSRXcggXqtG3d9gFSW06cFXvXSHUFdody50rg2HskvDVpE34P/LCNHssXcW6S8UUT/p4RJyBOfBdRWyVVbHXfbtqDQfYsRtxst2H+9GhjvOtoguCyg3iTHppbeBUNIqW8iAo2AJSAuPJPj+/gr/NG6XiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrZfZ0uR7cluVSeayvbuUJ7mlVIMOLZWi388M386z4w=;
 b=P+Rq4D/Q4vNyY0cHLg+Z/deWsWNkznKKBUnf3j2cVeAHkpW8e+VVCCZ/SrEpmuarQNk0xITtKtSLVGHJ7ah7LRZKCK2MZceXKGL140OmjbXRyn6yrG0sL10Ei9W3Y0xeGk6ToT7fd+wPA62YO1kpnGv8oxVkVyPhCk7PjMTOfKelCXno8IK/qK2dKkv1IUTXcQqbje+JpMkZ3WAdrmUjKJnNGFRwZi97GsHAIhbvN4dij2NkoexXkFcmUIa+JcEcPW1HVOAagWkPZBTdTKvDu9RmNL3OAYYs4jx6RhOUUIn9oUkmLN9JsS3C21GYs8TCRBQ75AGwdBHnFkMqYkM0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrZfZ0uR7cluVSeayvbuUJ7mlVIMOLZWi388M386z4w=;
 b=CJBcHuNjagkOjWRFG7SwMZB2JZWiqwohn98sKxaTmnP9sxGVFSmG1Gi0v7dxQIs/eGw+gfEeDAG5VRMQIlR5Z6IL3vBUaZBo10fTu+DPzWeLccJbL5hsqBrstTc3X2QxM7T/kiBlCAQALkkYnxnSQDTN2bgIk+ki73YSguRDfCw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 00:35:42 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 00:35:42 +0000
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
Date:   Tue, 10 Nov 2020 00:35:42 +0000
Message-ID: <BL0PR04MB65149233915E4D313115C840E7E90@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <20201109212158.y34otj3uy2hev75c@mobilestation>
 <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201109215524.GA1819368@bogus>
 <BL0PR04MB6514C9D94E2098EEA0A8462FE7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAL_JsqL6GuY01Fye6U8QsGMzz+TuMiVJF9r0cGXCsNPPJzWXEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59ef60a4-83be-4171-4781-08d885108e56
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-microsoft-antispam-prvs: <MN2PR04MB70717999F7E791634C858913E7E90@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RymfBwaBdpbr8hJgd72CY4YCDNw+zLmIRy3U64qm6Kgr0lUHcVQOwBahABcVenYnNz4+hLE4vLXkRH02xL63A4ljHSoWNSW691tjki2PbPbTkng6womj6Ptk4FPv/b6HrZ9PPU7pnEsuH4EMqgRYVjuP9IKw32hHgV0YdjMRejnyK4d0k9hE+V5rATrnkVLh08XyRtfdL3+tVBrxuhRMbGpewASwnCzgZb/QJ3BWJ+RfZH++inCX754UzIXImOBRKpxUxGZReJ0qsRzLBgAT6MYDm1o6ZELr83QyOml+5EuRvRdgQI94e0/WWy1mKUdIjYnSqmTTPjDgHQEYYl/yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(6916009)(7416002)(8676002)(91956017)(6506007)(8936002)(66446008)(4326008)(186003)(26005)(7696005)(53546011)(66556008)(76116006)(66946007)(86362001)(478600001)(33656002)(64756008)(71200400001)(54906003)(316002)(66476007)(9686003)(55016002)(83380400001)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NKpjHj2fehOVan/eK8DNZmWlXKzmalFITVEZ3a3tfZWMokR6vavbAcGAt12QduJoMy8vPnF/u3EedqX8iFsvC7M+DCw4s9/DHgkEcfcC4TOdXyEQQIT5Z1YoVdUAo9mPD5vwKlkTnqJuUOT+e9e/rXV3tyNimYpGqFZe6+yNiNO5qYzdNs5cAQIwL4sYR9/4Hxysh4Jq1YQuE453fX3tSceLpPF/Rh2cPCfCe/GfCbniBRODCP1Enj4ceU99P0h0RcNl7HX00MRSC4NAFXQZqruI/ouynkxQZDi6o0JZq1MheiH6z9tjbUAmV2UYZo+Auqe61gUYj1WyNRYx5uhvS0B0sjEpex836kQ3zDK8x7o3Jw4tuQzA7J1rlcqnVu0mgzkNQWCgB7Npl5S9S0cDZEhWR2OlzbCMXSxO00DezaJBlWPsNXEeG8IN5RsVUCCFDK12qODi4A/8IbMl3VVTVdlu4F/oPHfqUafZib3KDospg2Y7TPhZLNxSHQ+jQDD5xQr7rttDazyIrLk03wkPQfobycPSqgb9Jhdwrfejp7qeWTXaCiX/t+gp/sgxzpFMY79/8yLV7Qike/PvdJ95I/2AWc++Mi+XqMkQtbq4xkyZMfGH/YZzB8m3hW+Jx+leaJOnRuTQ5Sni0ajhgPSSAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ef60a4-83be-4171-4781-08d885108e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 00:35:42.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdE6xqNWfnpkBVEPglyiMFvim+ITTWIo+BXkmq5wC/IqOA8d+KSCDbNlAfr9B1+xJ8mv3STlt/HS8awIgcJGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/10 8:08, Rob Herring wrote:=0A=
> On Mon, Nov 9, 2020 at 4:00 PM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
>>=0A=
>> On 2020/11/10 6:55, Rob Herring wrote:=0A=
>>> On Mon, Nov 09, 2020 at 09:39:19PM +0000, Damien Le Moal wrote:=0A=
>>>> On 2020/11/10 6:22, Serge Semin wrote:=0A=
>>>>> On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:=0A=
>>>>>> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits=
=0A=
>>>>>> ctrlr0 register format. This SoC is also quite slow and gets signifi=
cant=0A=
>>>>>> SD card performance improvements from using no-delay polled transfer=
s.=0A=
>>>>>> Add the dw_spi_k210_init() function tied to the=0A=
>>>>>> "canaan,kendryte-k210-spi" compatible string to set the=0A=
>>>>>> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fiel=
ds=0A=
>>>>>> for this SoC.=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>>>> ---=0A=
>>>>>>  drivers/spi/spi-dw-mmio.c | 9 +++++++++=0A=
>>>>>>  1 file changed, 9 insertions(+)=0A=
>>>>>>=0A=
>>>>>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c=
=0A=
>>>>>> index 3f1bc384cb45..a00def6c5b39 100644=0A=
>>>>>> --- a/drivers/spi/spi-dw-mmio.c=0A=
>>>>>> +++ b/drivers/spi/spi-dw-mmio.c=0A=
>>>>>> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_=
device *pdev,=0A=
>>>>>>    return 0;=0A=
>>>>>>  }=0A=
>>>>>>=0A=
>>>>>> +static int dw_spi_k210_init(struct platform_device *pdev,=0A=
>>>>>> +                      struct dw_spi_mmio *dwsmmio)=0A=
>>>>>> +{=0A=
>>>>>> +  dwsmmio->dws.caps =3D DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY=
;=0A=
>>>>>> +=0A=
>>>>>> +  return 0;=0A=
>>>>>> +}=0A=
>>>>>> +=0A=
>>>>>>  static int dw_spi_mmio_probe(struct platform_device *pdev)=0A=
>>>>>>  {=0A=
>>>>>>    int (*init_func)(struct platform_device *pdev,=0A=
>>>>>> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_=
match[] =3D {=0A=
>>>>>>    { .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_ssi_=
init},=0A=
>>>>>>    { .compatible =3D "intel,keembay-ssi", .data =3D dw_spi_keembay_i=
nit},=0A=
>>>>>>    { .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init=
},=0A=
>>>>>=0A=
>>>>>> +  { .compatible =3D "canaan,kendryte-k210-spi", .data =3D dw_spi_k2=
10_init},=0A=
>>>>>=0A=
>>>>> Other than the comments from Sean and Mark regarding the DFS_32=0A=
>>>>> feature runtime detectability, I couldn't find a patch with adding th=
e=0A=
>>>>> new new compatible string into the DW APB SSI DT schema. Have I misse=
d=0A=
>>>>> it? If I haven't could you add one to the next version of the series?=
=0A=
>>>>=0A=
>>>> Yes, I will. I forgot to change the DW DT binding doc for this. I did =
add a=0A=
>>>> patch for the "polling" property but forgot the compatible string.=0A=
>>>>=0A=
>>>> In any case, I think that this new compatible string change can be dro=
pped by=0A=
>>>> switching to automatically detecting the DFS32 and using a different s=
olution=0A=
>>>> than the polling property change I sent for the RX fifo overflow probl=
em.=0A=
>>>=0A=
>>> No, new SoC needs new compatible string. Especially if a new vendor.=0A=
>>=0A=
>> My apologies for the bad wording: I meant to say the change to the list =
of=0A=
>> compatible strings that the DW SPI support would not be needed. So from =
the DW=0A=
>> SPI point of view, there would be no new compatible string to add/docume=
nt.=0A=
> =0A=
> No, there is a need for a new compatible string to add/document. You=0A=
> might not need it in the driver if you have a fallback.=0A=
> =0A=
> Compatible strings should be SoC specific so you can handle quirks=0A=
> without a DT change. Otherwise, it's a never ending stream of new=0A=
> properties and DT updates.=0A=
=0A=
Ah. OK. I get it now. Thanks for clarifying. So I will keep the new compati=
ble=0A=
string (renamed with proper vendor name instead of brand) and document it.=
=0A=
=0A=
> =0A=
>>>> I am still going through all the emails trying to understand what to t=
ry next to=0A=
>>>> avoid the polling "hack".=0A=
>>>=0A=
>>> Use compatible.=0A=
>>=0A=
>> Yes, that is what this patch used. Again, I think there is a chance this=
 change=0A=
>> can be dropped.=0A=
> =0A=
> Looks to me like it used a 'polling' property...=0A=
=0A=
I hope to be able to get rid of this change if a proper solution can be fou=
nd to=0A=
the transfer speed problem I am seeing.=0A=
=0A=
> =0A=
> Rob=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
