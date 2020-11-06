Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA42A9226
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 10:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgKFJLQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Nov 2020 04:11:16 -0500
Received: from mail-eopbgr1320120.outbound.protection.outlook.com ([40.107.132.120]:6171
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgKFJLP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 04:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo38IPOF2JvEzl/+TnPSc0xGVIFaioBwMr4vWRUQn2pQKkxWkKHsEoPx98WpzP/atIAI0cy2rEd2JTT1P2738gN7GHBxhzXaon6nEPPVKjK7ynke4W+IX1G2nHx5A2Hz2sSEr1p+nX2yYD1MCAZyDTWqaIWFUsSn1VDcbUOE4HQg9LvSnJ/6lPPo0tn5y99zrYTX6uSJz2HQ5Slvd+6PSrPd9hRJUqep4zIlczSlAKXHhXHVpuB+gBtc+X9c3lA+XL4WWwoIcSDeDUQPG0Jc7g9DSknfP1rnR0vHFXljt9FuYC1cvLhfSKqQg5eLXUI2dDunXX7JaTlNIOWnPKoFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RexWBf2NWF5YtYV8/ZJicK2aifBS64TMTsgVHj8KKI=;
 b=N/bCyPcFvt5ncps5MHEodYsqDif9pNVZahLO+wJsr3Rb+y2ntoD21kC+UzQuOOm+NarTmJXcJU14OgFME1TWbWFkwi/UnCxskSYDAbtr9aCan6Za7zFk/J3TLlaodlO8HOW85H8Pp1ICP4Y+x0m775aTH914+opyoTE17hrUL2/MOmGUb3DxMjlPtWuLTZFKFXuWxgOtUE4AvrMIoC42sswRrraeDPhztFuirsrCnpOsfgAivl83Hsx6ufSCFPeeGUZsDMJSxcGHMsyN1YZIRa0ocd34LJPnOM/bR/rS973u4VOr/7XifDJ0wWvpbD15Y4FbEsY8ZciwUFHKTqtwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK0PR06MB2625.apcprd06.prod.outlook.com (2603:1096:203:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 09:11:08 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.033; Fri, 6 Nov 2020
 09:11:08 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>, "clg@kaod.org" <clg@kaod.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Thread-Topic: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Thread-Index: AQHWs2uzsnQifgX5cECT3PhrZld01qm6IkuAgACvSdA=
Date:   Fri, 6 Nov 2020 09:11:08 +0000
Message-ID: <HK0PR06MB2786B92D4FC88E8179888D9AB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
 <20201105223949.GA1927504@bogus>
In-Reply-To: <20201105223949.GA1927504@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 497269e3-6b89-46b7-ec9e-08d88233e5d2
x-ms-traffictypediagnostic: HK0PR06MB2625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2625BA62FA8FFC661FBEE388B2ED0@HK0PR06MB2625.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iYxjyWIYU9o53NZTzzUUGwRzHPuITFA+A2nTSwnPbkDhl071JhvifSoG9itod8yNZC7k9RGuOTfa/wG6k5cQ7BqSUhGcgJaVL+UH3pTNNu0LqyfQcO+Fzpd1akcn1T8VfZdmKDQxzRvZ4HwoANVIWqWzjikzsq6GHzdVPURNKcJU4dZHmwA3DvEtgT4bIDLVjHG2JmZHfDR9bmdu0RJdoflpy/R84SDdnD5yE+HOR+M3I3zz8jFaJD+9fQDSR+RycVN0s08fIYnyufUuxjev/91CHaumx1VbtbIFriVmE8+REWIxOuKPtr8Sa1R5UWG4j7y+qHyNiNu7rjmmEFnQFIxB+N0yf7EOEkYr9YvAMwuEFXWC2MuRgsIFv4KPzQjOQPAIjwOmeA2rFNvJMQYkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39840400004)(55236004)(64756008)(66446008)(5660300002)(52536014)(8936002)(53546011)(6506007)(66946007)(66476007)(76116006)(66556008)(478600001)(6916009)(7696005)(4326008)(55016002)(83380400001)(71200400001)(9686003)(26005)(316002)(8676002)(966005)(54906003)(186003)(33656002)(86362001)(7416002)(107886003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zC/xGavuZukPKfeh1a0XOS1Pu3Lr8pUVNJgS+AI4PpLTts/NVDk3eGOcepkC21m9ulcz8FZlOzA5Pd3KqVEdU5dEsFzWGC33FizXdHt2lDI3Y33MzaqOoAmPCXRMLilxkA3qs+y9mdBbQ3xoogphDQpZbEIXDSQvMfoJq0Pg1AEE2G6iCojv6l4Rc0B2P3tS5YKF9IcBXhi0PNmo+w697kSCWbxibi5mwHteKnquAcozQ7xNCus0j9hG6GWn3YEV3Jb/EmY84hqrXMHJShZCBhWsGBSLNLhHJSWF5d8rk1mqxqvij/l3geHxCaf9DS+dRcxgwqFyB0mZeKYmac4NBgVriwwZ6Hg40H7JERoPiFm/hdf9MNDWB2A+odpN6/oyVfH6UGioHfZT8imcBfp0uKQDfeLP4y5VRm4/U5WNBQ/9xf3HAp3ydZ5LsyPYM2yA9Nzz+U4XdMVvCNASgPFm1szDOiWWt2UiKh8DRCWUtQagNPYzJvCafcwQ5U2byh65lCjD/n9R5ze6f/gL1J9ObBIAvUr4uNEx2WaHAKzUjv0gqMsRX0ZTOzS33OeV+XujTWAUNPPbjbPXBdEeTgAVFHRZnaow6cfal7dHSXn40JWzYxVrZ8HSyNSydTJTxSPx5mZcgzm01LXb/rdWCoGgpg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497269e3-6b89-46b7-ec9e-08d88233e5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 09:11:08.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIJqvEhr0SZtRAy0bf6NOGd11vdUYy5+XrMYAz8jBB61fDTbA1oPk4hqwHS62KKGMlTy3hOzSsv4xxxCwp4+pjlp2Bt7n9SY+CRK7QlqHG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2625
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, November 6, 2020 6:40 AM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Cc: broonie@kernel.org; joel@jms.id.au; andrew@aj.id.au; clg@kaod.org;
> bbrezillon@kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-aspeed@lists.ozlabs.org;
> linux-spi@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
> memory controller
> 
> On Thu, Nov 05, 2020 at 08:03:28PM +0800, Chin-Ting Kuo wrote:
> > Create binding file with YAML syntax for ASPEED FMC/SPI memory
> controller.
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > ---
> >  .../bindings/spi/aspeed,spi-aspeed.yaml       | 66
> +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> > b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> > new file mode 100644
> > index 000000000000..41b9692c7226
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/aspeed,spi-aspeed.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI memory controller for ASPEED SoCs
> > +
> > +maintainers:
> > +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > +
> > +description: |
> > +  There are three SPI memory controllers embedded in a ASPEED SoC.
> > +  They are usually connected to SPI NOR flashes. Each of them has
> > +  more than a chip select. They also support SPI single, dual and
> > +  quad IO modes for SPI NOR flash.
> > +
> > +allOf:
> > +  - $ref: /spi/spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> 
> You can drop oneOf (there's only 1) and items.

Okay, it will be removed on the next patch version.

> > +          - enum:
> > +              - aspeed,ast2600-fmc
> > +              - aspeed,ast2600-spi
> > +
> > +  reg:
> > +    items:
> > +      - description: the control register location and length
> > +      - description: the flash memory mapping address and length
> > +
> > +  clocks:
> > +    description: AHB bus clock which will be converted to SPI bus
> > + clock
> 
> maxItems: 1

it will be added on the next patch version.

> 
> Constraints on num-cs values? Or up to 2^32 is good?
>

The maximum is 3.
The "maximum" item will be added on the next patch version

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - num-cs
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/ast2600-clock.h>
> > +    spi1: spi@1e630000 {
> > +      compatible = "aspeed,ast2600-spi";
> > +      reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
> > +      reg-names = "spi_ctrl_reg", "spi_mmap";
> > +      clocks = <&syscon ASPEED_CLK_AHB>;
> > +      num-cs = <2>;
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      flash@0 {
> > +        compatible = "jedec,spi-nor";
> > +        reg = <0>;
> > +        spi-max-frequency = <50000000>;
> > +      };
> > +      flash@1 {
> > +        compatible = "jedec,spi-nor";
> > +        reg = <1>;
> > +        spi-max-frequency = <50000000>;
> > +      };
> > +    };
> > --
> > 2.17.1
> >

Best Wishes,
Chin-Ting
