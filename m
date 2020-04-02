Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D219BB9D
	for <lists+linux-spi@lfdr.de>; Thu,  2 Apr 2020 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgDBGV5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Apr 2020 02:21:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:49848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgDBGV5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Apr 2020 02:21:57 -0400
IronPort-SDR: aTnC9U5QdKQjg2/k3moLqjP0qckSTcTd//e71PiMNV1VSfKzzFOJgfMIVF4v14bz3n9eaZyXgb
 XdwHfVVabrUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 23:21:53 -0700
IronPort-SDR: 8qg+dT3qSFVaR6bQkEz578O+8S6Gx78RWuaCIJfiWn+ZtqXKaMrlqnfqWeDrZ1DUyFBwxBe+Rl
 +HpXfQSm0U/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,334,1580803200"; 
   d="scan'208";a="242962054"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2020 23:21:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 23:21:52 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 23:21:51 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 23:21:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Apr 2020 23:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msghxVxYm6aEmOeqmoRvQT/NtZ0Zkre4bagQXyF71b4xoFov1hsVHuAoJ0tCQ6nawGQ+AUyzs+pigE1to/qAaifTk07oRnAR8tHvtpU4Ig1bHfSuI9GbOOJac9NFqhQxD2l0Mo4UoHMTS71Y6WqAxf7zwKUjDxAQfYTe1upHSGdnbtDDk0Y/75tDUwkRylbYcjnM+5R/iBGtPDvfqWT9SN+wlNajfOq1bmecN+kmQmanAS6vv01r4ugDPS1hOSdA+rYWKWTSj3a4xvfulqJEDxfBXcx9/cZI/KbagewJwOF2CdHdwic9Xie5KWV0XKWdV6XQUDxXyKbcuZsbwCi3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1emqBmgtfFG+bZL1hCYnc0/cTbxiUKdvMw+MQO8J3o=;
 b=HrigZ+iAkc5Qo3Y7rjiX3bmDX0hcMEwh8riymKSWJr7rwlFJFvrOOnlMFQPuv/mEgcXejSbwqH4om7P6T+PfdEfWWbe8HfLGvSgHHOyOGBGfive40hQ9CgmlXVXNvnWgA+PtXHAeGN49mEKuUMMwSg6eBBC3nrUoGXyed9JrnAgJul/vqLCNTno2vYwHqlQ/FeluA/Rzy/jqP+y9T8DygyvTI+X/zDr1juU2CvvUNwTjiKm6TobKEjdzGzR+AwRbD+F5PodRUKkNBUQNFTjN3yl0yRnuD3DRs4GNz0ikE2MxleuB+/f0+gjR+hVm2/S8Gj94YFYk5VzFguq6ZYuNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1emqBmgtfFG+bZL1hCYnc0/cTbxiUKdvMw+MQO8J3o=;
 b=Y1v5hPOBmE9RN8sRLIsQ6eB78D4BEccCWyCRsEUFRNQ/MakTHVk9esSfvdaIlVMgIWSpnd5XPXCJ5VMtTgxeH4hyrasAnN8EholWaQGzh3sn2Iw8dsjupKW9u23OvckW+s/SinxzYrFVIvaZLSx5oklb0nOmj1TTL3YnSNz7OgY=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB2684.namprd11.prod.outlook.com (2603:10b6:5:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 2 Apr
 2020 06:21:48 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 06:21:48 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Thread-Topic: [PATCH 3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Thread-Index: AQHV+GHhc1HUzdnYHkC3/fl0Ve4yOKhhdwmAgAP+49A=
Date:   Thu, 2 Apr 2020 06:21:46 +0000
Message-ID: <DM6PR11MB372161B8DBE8E53C41DA5245DDC60@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200312113129.8198-4-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200330165439.GA15130@bogus>
In-Reply-To: <20200330165439.GA15130@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wan.ahmad.zainie.wan.mohamad@intel.com; 
x-originating-ip: [192.198.147.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a589df1d-5465-4c73-5ce4-08d7d6ce1ff1
x-ms-traffictypediagnostic: DM6PR11MB2684:
x-microsoft-antispam-prvs: <DM6PR11MB26848E8D6ECAC9A3D0352D77DDC60@DM6PR11MB2684.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(186003)(76116006)(86362001)(8936002)(71200400001)(66446008)(66476007)(33656002)(26005)(66946007)(2906002)(316002)(5660300002)(4326008)(9686003)(52536014)(7696005)(6506007)(8676002)(53546011)(55016002)(66556008)(64756008)(54906003)(81166006)(6916009)(81156014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtBV2vAKGtpT5Otp5AnjQmz8VjdNSuId43L3XaG54+BNbguJWtgx/12IVUATBPklKwq+/ZRNQ2fsrKR4ePeUbEKJ/CAA+08ZRKHR7xc4MmFhJlsue3q2nX7XzN/Va0wNHmEP47qPYlhvIhHIu+b+V1NmxixNjJSpiU03ZSSXuL1z3obH4eBU9l3FdMaeYCVdg7+63w07bYIq8DNykhr4JxbO+uWIyn096WIAD/7s9XtrRgQFKroYaKdpZIUquj0m82r2MMf7y7ViSvUeA0hb3xrWgKHm3YC9OcFWW8hiflN/sw/9HgqXK8ccuE4HQuiy0AlIytm1DVmkDRXV503cQXw4gTt7EcYuo184uEi2wOfYTHpseqC/Vq+pVT6rYoG0ZEz39EUpsLBdwO0antNb2Qh+JZT6uf6t50DHC0ZpAHL8DaFFyOOt0djKVERcclPLbfeU1fYzuJlazRRJKwA6I7ZUdvNbrWxSPWqwIOqb5DClwCtXRdrTd71FMhb/ZxUDUeVAPDhrMiopmyiBHVW6/Q==
x-ms-exchange-antispam-messagedata: SUz5K5AEPORbsBG5eeZAd9q51XgIyqg0fs3Gv6X1+B7zruK2e8CVd8GH/btHVOS8eSjcK+srzQPo2LCcVuI7dhtCX+++39uo1NIBWOwiegQyaIwfIlRnlX1IFlU5vQu+HGAmu9Sqc8t9Cf8PiTKj8g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a589df1d-5465-4c73-5ce4-08d7d6ce1ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 06:21:48.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyT59PHHWj6GSLnavDuww2KdiyaGSyPXcixOPVe2Wg/kDs6r6+nMBcX3AaXWNKIsT2XhbI4VXhMWSH23BfUan9y2V2yGalfnSv9s1sHdjbmUSK2MV1CGfcQpJMpGx5IX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2684
X-OriginatorOrg: intel.com
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, March 31, 2020 12:55 AM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: broonie@kernel.org; mark.rutland@arm.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings t=
o
> json-schema
>=20
> On Thu, Mar 12, 2020 at 07:31:25PM +0800, Wan Ahmad Zainie wrote:
> > Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
> > using json-schema.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > ---
> >  .../bindings/spi/snps,dw-apb-ssi.txt          |  41 -------
> >  .../bindings/spi/snps,dw-apb-ssi.yaml         | 102 ++++++++++++++++++
> >  2 files changed, 102 insertions(+), 41 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > deleted file mode 100644
> > index 3ed08ee9feba..000000000000
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
> > -
> > -Required properties:
> > -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is
> > "ocelot" or
> > -  "jaguar2", or "amazon,alpine-dw-apb-ssi"
> > -- reg : The register base for the controller. For "mscc,<soc>-spi", a
> > second
> > -  register set is required (named ICPU_CFG:SPI_MST)
> > -- interrupts : One interrupt, used by the controller.
> > -- #address-cells : <1>, as required by generic SPI binding.
> > -- #size-cells : <0>, also as required by generic SPI binding.
> > -- clocks : phandles for the clocks, see the description of clock-names
> below.
> > -   The phandle for the "ssi_clk" is required. The phandle for the "pcl=
k" clock
> > -   is optional. If a single clock is specified but no clock-name, it i=
s the
> > -   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be f=
irst.
> > -
> > -Optional properties:
> > -- clock-names : Contains the names of the clocks:
> > -    "ssi_clk", for the core clock used to generate the external SPI cl=
ock.
> > -    "pclk", the interface clock, required for register access. If a cl=
ock domain
> > -     used to enable this clock then it should be named "pclk_clkdomain=
".
> > -- cs-gpios : Specifies the gpio pins to be used for chipselects.
> > -- num-cs : The number of chipselects. If omitted, this will default to=
 4.
> > -- reg-io-width : The I/O register width (in bytes) implemented by
> > this
> > -  device.  Supported values are 2 or 4 (the default).
> > -
> > -Child nodes as per the generic SPI binding.
> > -
> > -Example:
> > -
> > -	spi@fff00000 {
> > -		compatible =3D "snps,dw-apb-ssi";
> > -		reg =3D <0xfff00000 0x1000>;
> > -		interrupts =3D <0 154 4>;
> > -		#address-cells =3D <1>;
> > -		#size-cells =3D <0>;
> > -		clocks =3D <&spi_m_clk>;
> > -		num-cs =3D <2>;
> > -		cs-gpios =3D <&gpio0 13 0>,
> > -			   <&gpio0 14 0>;
> > -	};
> > -
> > diff --git
> > a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > new file mode 100644
> > index 000000000000..57a789f5d9f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: GPL-2.0-only %YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
> > +
> > +maintainers:
> > +  - Mark Brown <broonie@kernel.org>
>=20
> Should be owner for this h/w, not who takes patches.

I will ask internally, who is the current owner.

>=20
> > +
> > +allOf:
> > +  - $ref: spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mscc,ocelot-spi
> > +              - mscc,jaguar2-spi
> > +      - items:
> > +          - const: amazon,alpine-dw-apb-ssi
> > +      - items:
> > +          - const: snps,dw-apb-ssi
>=20
> This can all be a single 'enum'. You only need 'oneOf' if there are a dif=
ferent
> number of compatible entries.
>=20
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +    oneOf:
> > +      - items:
> > +          - description: The register base for the controller.
> > +      - items:
> > +          - description: The register base for the controller.
> > +          - description: For "mscc,<soc>-spi", a second register set i=
s
> > +                         required (named ICPU_CFG:SPI_MST)
>=20
> No need for the oneOf. The 2nd case is a superset of the 1st.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: One interrupt, used by the controller.
>=20
> Can drop description. Not specific to this h/w.
>=20
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
>=20
> Drop these 2. Covered by spi-controller.yaml.
>=20
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      phandles for the clocks, see the description of clock-names belo=
w.
> > +      The phandle for the "ssi_clk" is required. The phandle for the "=
pclk"
> > +      clock is optional. If a single clock is specified but no clock-n=
ame,
> > +      it is the "ssi_clk" clock. If both clocks are listed, the "ssi_c=
lk"
> > +      must be first.
>=20
> Rework like:
>=20
> items:
>   - description: ...
>   - description: ...
>=20
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ssi_clk
> > +      - const: pclk
> > +    description: |
> > +      Contains the names of the clocks.
> > +      "ssi_clk", for the core clock used to generate the external SPI =
clock.
> > +      "pclk", the interface clock, required for register access.
>=20
> No need to repeat what's in clocks.
>=20
> > +      If a clock domain used to enable this clock then it should be
> > +      named "pclk_clkdomain".
>=20
> Should be a constraint:
>=20
> enum: [pclk, pclk_clkdomain]
>=20
> But really, it probably should be dropped. I don't understand what the
> sentence is supposed to mean.

I checked against source code, and no code in drivers/spi/ is using pclk_cl=
kdomain,
so it is safe to remove.=20

>=20
> > +
> > +  cs-gpios:
> > +    description: Specifies the gpio pins to be used for chipselects.
>=20
> Can drop, covered by spi-controller.yaml.
>=20
> > +
> > +  num-cs:
> > +    default: 4
> > +    description: The number of chipselects. If omitted, this will defa=
ult to 4.
>=20
> Constraints?

I believe this is not a constraint.
Native chip select for this hardware is usually 4. We can have additional c=
hip select
using GPIOs.

>=20
> > +
> > +  reg-io-width:
> > +    default: 4
> > +    description: |
> > +      The I/O register width (in bytes) implemented by this device.
> > +      Supported values are 2 or 4 (the default).
>=20
> 2 or 4?, sounds like constraints.

Yes, it is either 2 or 4 only.

I will fix this and all your comments that I haven't reply above.
Thanks for the review and comment.

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - clocks
> > +
> > +examples:
> > +  - |
> > +    spi@fff00000 {
> > +          compatible =3D "snps,dw-apb-ssi";
> > +          reg =3D <0xfff00000 0x1000>;
> > +          interrupts =3D <0 154 4>;
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +          clocks =3D <&spi_m_clk>;
> > +          num-cs =3D <2>;
> > +          cs-gpios =3D <&gpio0 13 0>,
> > +                     <&gpio0 14 0>;
> > +    };
> > --
> > 2.17.1
> >
