Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259312A920B
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 10:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKFJDi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Nov 2020 04:03:38 -0500
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:21728
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgKFJDL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 04:03:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFYr/uxAY0dedN3uQzb6MKqkk1JpYB/YCb5jGU1wtojQAXWa53LsGZtP9GkV0uqBN2mM8DPgCH+ZzoMmsaCtcNelmFURa7diTvgggk7hbVDuBVWJVc9tIDwvGqtgtebFU9d6PqwBtESlX/dU6Fk+qhrQfzt74/jMX35la1x3qndKSEPDOkTTK6fDYXyz3U0dhS1ilLsF07ajLkzmrru64UWpL+kq3pbskvwwbkYMCvNWd54pbyVkS+wzxfYEFguQpmTU7LnO6DAQP/jwKkpKIonBSSWHD2MsRklNtz3KpBJ96vJEvFwJM9TU/bcvNZAXCjGdx917q0jh0304lSGVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh+Svn6smS/SqtKYQBLY53tsEIphYI6eXh74imGVTsE=;
 b=YA0jQUDf8QWDtg+Ed2YcDWUAqfC8Ly8xdLXRml4OPftheMxEQvTo9PWues4HQSXQtXgsKRCoUAFt+3pcCvf14QaTfJhAnU2xiyyQb48/5v246TnLHeXboTMgvZ3qRMCDVIbVppzPHMR6f3WUC//o9JFf3Ad2uZW2AZ96r4eUYULQp7mR33kBrWTSMPWY/eyDINQCuZ/NSYFcyXJDgcHJkiwXXE1RMQb5sTwO19TZd4/z1BY4poqe5O7jVXN6OAiKjyDz8MOku2k+SOIeOgFxX1B6QGEPpN88eGBqV6OoEeyMMdDVFZ4VUQEeod2IaEjYXEJnQCT5F5hOBaQvP70Oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK0PR06MB2356.apcprd06.prod.outlook.com (2603:1096:203:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 09:03:07 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.033; Fri, 6 Nov 2020
 09:03:06 +0000
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
Subject: RE: [v2 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Thread-Topic: [v2 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
Thread-Index: AQHWs6MqVFfaQvK8UkmffmksveHUb6m6z8Fg
Date:   Fri, 6 Nov 2020 09:03:06 +0000
Message-ID: <HK0PR06MB27861E37623DDADE1FE5A472B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <20201103072202.24705-2-chin-ting_kuo@aspeedtech.com>
 <20201105184036.GA1607865@bogus>
In-Reply-To: <20201105184036.GA1607865@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c6df00f-158d-4d99-2c62-08d88232c6db
x-ms-traffictypediagnostic: HK0PR06MB2356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB23569D812FBFF30F2606B5E0B2ED0@HK0PR06MB2356.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4nDnbJ2r0iI9AbR0Q0nQelzXG1vlfStCGPzmme0PE28JVrS+LpWWfrW0BpgStOPfOCS9fCdALmT0cRbQ4d6BGYqmk/kHJwVYEp+UuImlHmIT1gkBIeUBjOWmZl4RMrE47enupxvOb5G5a32P6kzUzwFxvFLxdy91wRQloDuJt8pXFU07o3QsGRb7NrfkpDyoFnitJcktav2GVvdBTFvC6kOX+lvhwfMm8D7Z87s/gpwDBjcbhPdAOsuoqrWTGd0dg5Rv7saP8KYY+FZrIIT3X+9u3i5lh2sONWpSDOsQXtcySUGtTJJ2dOWyaii/mX+nt7/kaBgvHVfd0+hm9buQ+3DexLxSjU/e4aJr7FWGrhnVzjmPVe/PH6xP2TSq10yNqMMmjrkWstLyFBXTFm9Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39840400004)(366004)(71200400001)(7416002)(6916009)(4326008)(83380400001)(966005)(9686003)(107886003)(64756008)(55016002)(186003)(66446008)(76116006)(66946007)(8936002)(33656002)(316002)(26005)(6506007)(7696005)(54906003)(66556008)(5660300002)(66476007)(8676002)(52536014)(55236004)(53546011)(2906002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QKfQ156ydVaXc+0j+YnIzTte32miiUi3xC3ob9tucoqblhfXloOF/kC6erR4uxalgAJM/rEyqQyzkn0L3ts/0ya0GmcmzeVavhSdvVKWG4oTGSI/AlupUpJVYVF4jhpcAfn4DC8gfK1nUWu/2DIRRI4Xg6oHdWmk3UE3F0wwS/B5On6XME2au5l8HaT9eKZNXgyIzx2LHad7Sb2mRHDlB9vgUMsdpVxPfA1sNW9q1dhRmaPWTUP7J0vSK5XOHWIAecs9GIGN9aep2SGRWwP96S1VbqXFgq+XCYYnSXOo9iOyiiy3hHDmnMpfnGQRDGrMwdAfxCar1gGRUOl4LQC6BkQZQql3BxgwfdHIJV7h/2igFIWDd87eC0twl3qIeanJjaW0nkZZeRssUuhjUZBDSSNE7AriWknDpcWgmmWDbeJ49BNAsPrxU/0HCkjEbKDMZALDGvRkVUCL4ibtZzNjgwBAv2m2FR+CGZEQPrpEJUcKvU4mhD8VLVaV36H6NzekAgmzYM6bX9ZFZFbZ7T2Bn6d2xeAEQ04L+hvIERAJfCsiCq0lbdpz4kSVBUtqZnmVeJ1VH77fPAz7fZmg3JlP57Kp34NGmwInv8+dFg1z2SbEioPoshKL4gIy4lBjMrAQ+mr5FCSYXd676bJwmEO2Dg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6df00f-158d-4d99-2c62-08d88232c6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 09:03:06.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWQDt9pXkh41x576wkQRCSlHOXtApjoEcVgfud+447TApOsw8S+Bu7Epi8YZJri9AsOa/2o2nOb8xisvOM0byq19pLeNis6qBzh/FICDmWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2356
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, November 6, 2020 2:41 AM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Cc: broonie@kernel.org; joel@jms.id.au; andrew@aj.id.au; clg@kaod.org;
> bbrezillon@kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-aspeed@lists.ozlabs.org;
> linux-spi@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [v2 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
> memory controller
> 
> On Tue, Nov 03, 2020 at 03:21:59PM +0800, Chin-Ting Kuo wrote:
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
> Need to define how many clocks (maxItems: 1).

Okay, it will be added on the next patch version.

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
