Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C087A2AC7FC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgKIWEk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 17:04:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6636 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbgKIWEg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 17:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604959475; x=1636495475;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VD/3TgT92z0Mvdo0ohstObVh1V+uxd8S0unKwOwngf4=;
  b=YUNJD1v9ByY/4VFc1oV3CAJ4iQT8pyie1Km77XZYkvLKj6PlMuLHY1ur
   VSHOephS6JFK3Q0YHfy+lInyuhHLk01Dht+96vkPh1zf+L9C/mNYVpPjh
   F7+MMWL1UXF+4gMkwa6YQXxCmN82K8JNtIOV43P+aRlmuMZ03aHueatlA
   VOhXqMcwttE11l7WNpOM1LXmjF3XUnp5G9bYtQ6TlRol4eLY2XyLDF5QS
   gvTYn8rVFG+4FM/MZQXzNhrAjslocy6C8Dej02kCDvJPGD/ISU5X9lmNO
   hPBC9Qqkk7bNPxsoLNlBfPj4sYNvkcVJcNsDtpa5Lu8MViX+CD8k39bDY
   w==;
IronPort-SDR: dJdJ66HiJZ24XfwUTFTY0MtpyWncoCQUX6os58dRroDpTA3+/mPu8N/VHGbGBnhCTeq3pZXm2y
 +gYdZ4spwl4eiD4RNuAYzb5PB/5wN/2+9vUYlQPIlcGh9OYv26sF8pkLsLP5iQ4YPC5YgcVMcp
 fSOQKl3EHlnrFbxhjk7f3WTs/9XqcBBFivkIR77NbIdrko2AI1eujPdl0SxHwcGfkr5W0Bp82/
 lw5QaarXWt3+hqAUjtBn4Nwe6PawGfbRI5xiv1lvQtDbFRpn0r89yhZDM3/Ppmnb0wyzFbmqmc
 jpc=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; 
   d="scan'208";a="156702746"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 06:04:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7QJTV/LdhLAkKKFmn3WEhWtz5IeQQtRRK/r2ZCNHwaukTkt3Q+cN4C/sIS3Pn0Oia2trV2c9px5dq4Prd36vhg9SNA7sBE9hpXNzA1qNnbQQ+YJf7W1ukdtNuyjbKmkOhAKgkWxCPamDQVEB3hRyw1107cOkPqlpioX2dPtsDGgCADRQEOb+dneVKgNGefWvJb69A/7wrp4oak45vYy5cxxQC/4+DSlX9psv/v2/YNq7B34jQyLLkzZTBB17bmNgC2unbpUph/pWjikxx9r2sTtaGjA4h5o2GkatF3hE9vh2G+JlnHeTGv5FB+kuiP9dtc4MmygSCSyW7E5BSFK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxzEQ8DxEaDw9PIEtTYQYlKYoyp6eCRaBuMdgiDIEQc=;
 b=YUR4vfJLioYEVh0xiG/66aCufZCklbTAZjbpKKS8rzaLsIgAkOuUzyfBAeCJ7OrtbkPcpXr1sHOwMxK6ma5M+5Y2eEEJRxCjR/wYhGyX3C0Cu+IXt4+NZJT4MSctgIexHFPS4AlgfWgpfVsJc9R+3B6fk2qOyUHoXkkeKqAENoguGdqgk+EbCzrTWtwCdtl3ztPEytHLKumsUZ3k5zLdVzueyOTL7JSKBjEyKxeeuecWk2WpuLCtEV0hGWfhBvHvicD0oi6ZH6CPcFl4L6VqVVwhnmqpcnn0ecL59wgYXbFuIH+Et72kbH+ifSKNinFk6sKuQakOkY9I6orK0TLlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxzEQ8DxEaDw9PIEtTYQYlKYoyp6eCRaBuMdgiDIEQc=;
 b=khPdQbFNMHRGskrDkOn0tv8uNpub1tSPLmHI4AmAqTNHnvaQuadJwBoGxg0dD6j1XLwtW/LBG2YRKUCiL13n8IiWb8vyrOv4pgDX8ETqJeibO+NbH4lCDQe72Q8z5jyj2lXPiJ51r26Ng6+y+5WIk75a0W6C8//PEdQUQNAAiUI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 22:04:31 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 22:04:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Thread-Topic: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Thread-Index: AQHWtN4mKRuAhov4sUaXWKhVt6lq6g==
Date:   Mon, 9 Nov 2020 22:04:31 +0000
Message-ID: <BL0PR04MB65141C58E049C324FF0BB27CE7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-22-damien.lemoal@wdc.com>
 <20201109220105.GA1830760@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75e85513-bcd8-49e9-e27f-08d884fb6f4d
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-microsoft-antispam-prvs: <MN2PR04MB707179A3222B5CE28C07E34FE7EA0@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuJh8fn1HbQ1A1M98y7CJPYMu+Z5HfCzYvc6Tk6EZh/otTzXoVOJ+hUyXjOkmze0P+0D3ROHSRCc2x+2JVLWJ+49/kMY5YQwlyklA5Ft6gUeQ3ZrNQTikASJIMV6eSNcf8rKnAhG9ey4QiHzNam7JrgkAxlJudVTASlzkmEMKqRYvfFXgBmkrDYmyGsdiQ2189U1zZXzTtBq2wy2XEY5AHlRaCVz73ezmkZHVi2p6Lx5JqX1iewO4yfTBkecEhAQwnnwmsLPhT97TgLcT/v+nlwEfMdmzd8z4ijJve0W8BRFZkmADkTaEO8CY7i2Wfxpc1RinFilFe++s+opUkL6xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(8676002)(91956017)(6506007)(8936002)(66446008)(4326008)(7696005)(186003)(53546011)(66556008)(66946007)(76116006)(86362001)(478600001)(64756008)(33656002)(71200400001)(54906003)(316002)(66476007)(7416002)(9686003)(55016002)(83380400001)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dgU7Y/o610oW6asaB45MjbUvomEFFSLobxf3GMdTjLNdncv4e5k+NWBE+rHI89saf5+coUkDKbd2hGXrJG4cZLU0hpj1YC7cVr0S/PmqhaDIVSLIjtl/gWt+EZ+vRuA95834nDazXeuCAL/lBc05aj77nKmn1RIH9uizXZA3XcYI3lQGMtlYmMsDywqGZyRaHEHI/ed/QzbrUuzPJvBqdcS5UdidZdTTmOIZ+tURu2CB4Bdr6Oz9qxD9rzKW+b2lIK6lVVWNRirasFWUVkRkRyqjaGbpIxl8ZyWJWCkLe+aLReb9ueydALT44BCitrhgMCWTq3yk76PujT8gSUCfDvdmCmW+qzvqKRBGSd0r2luQlWZImvD8FGR9QiqHn1zqdl0TLkYehX2LG9rMYfvqhFlobCeqI145Xwr3zUpgmGM+9wG2d63wBMn1vV16hng7CPdLJwwVzDTjvW7wYvbH+nGHiPqD0Uew2UaeNVV+7mtpjkfyu7jkE7LQelPULyOzZMc9Zo07zt0mTHbAYaFJJUc4803U+Y2g4oJeQ5JAxuGIsvDI7tPXv5UrRwexBuAgDQ0Pv9SWTQrP85mP8O3izfmSJCqxgNTv+O0uIO4WGaxb3dH5KweOIt4NuZ5jq0d4/dsgz9WIvFGyVbT9j3BbcL1KatiaB9xlAkKYAVm3X8x81tW8Di7vgdpPGb5ASdcLJULQIrZ4BG6RwqjBzyK+pQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e85513-bcd8-49e9-e27f-08d884fb6f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 22:04:31.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/sno/pW07BMfhstrdbgAK7m3rfxmgYwYQusavzILMPUCUHHbGYoy6dzMgKTrtxGfN60aJemd05r8zgtzTpkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/10 7:01, Rob Herring wrote:=0A=
> On Sat, Nov 07, 2020 at 05:14:09PM +0900, Damien Le Moal wrote:=0A=
>> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include=
=0A=
>> "Kendryte" and "canaan" as a vendor prefix for "Canaan Inc."=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++=0A=
>>  1 file changed, 4 insertions(+)=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Do=
cumentation/devicetree/bindings/vendor-prefixes.yaml=0A=
>> index 2735be1a8470..f53d4d8e7f2a 100644=0A=
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
>> @@ -179,6 +179,8 @@ patternProperties:=0A=
>>      description: CALAO Systems SAS=0A=
>>    "^calxeda,.*":=0A=
>>      description: Calxeda=0A=
>> +  "^canaan,.*":=0A=
>> +    description: Canaan, Inc.=0A=
>>    "^caninos,.*":=0A=
>>      description: Caninos Loucos Program=0A=
>>    "^capella,.*":=0A=
>> @@ -537,6 +539,8 @@ patternProperties:=0A=
>>      description: Ka-Ro electronics GmbH=0A=
>>    "^keithkoep,.*":=0A=
>>      description: Keith & Koep GmbH=0A=
>> +  "^kendryte,.*":=0A=
> =0A=
> AFAICT, this is a marketing name for a series of SoCs? That's not a =0A=
> vendor.=0A=
=0A=
Correct. Sean pointed this out to me already. The vendor is "Canaan".=0A=
I will change in V2 all compatible strings to have the proper format starti=
ng=0A=
with the vendor, e.g. "canaan,kendryte-k210-..." or may be more simply "can=
aan,=0A=
k210-...".=0A=
=0A=
> =0A=
>> +    description: Canaan, Inc.=0A=
>>    "^keymile,.*":=0A=
>>      description: Keymile GmbH=0A=
>>    "^khadas,.*":=0A=
>> -- =0A=
>> 2.28.0=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
