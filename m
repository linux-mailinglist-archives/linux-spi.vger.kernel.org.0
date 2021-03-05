Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0932E71B
	for <lists+linux-spi@lfdr.de>; Fri,  5 Mar 2021 12:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCELQg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Mar 2021 06:16:36 -0500
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:14048
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhCELQO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Mar 2021 06:16:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo1zZvAmEBzfcQcM7QTGUZ4jhHeONeaoUYpKMWUKf91k7cYEadF2aQCyYzDlFQ5UUC3pzkSNKd/RjB6+u1L8b4wXwLxbCOI1jCTZqzD+tpP+v2wbDcifcIsdO5B6OFX9NJLrLBgaQSOJZB+ck/xV8zRTwwdKAhqdIKrg3QYKr8dyyszXv9aruSZyEogSdPK1J6mYEQA1/E8cifrR3D9jaHmWcRi4L2ztTBbMhesuUWpQAEoypuSx8gATHkOHdNZ/C1Ne+ArIBsV9JvDU9vHKdOtL5pjjEhmJlE4Ta2SOlk+6TL4Iuxwr6SPxRiCU9KSGKen/MR40kuVZOUqvJp1NdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVXX0y5077z6NBjQprvvEHc6U/cgViImSZvKCDNF6Uw=;
 b=DTlw8AVjdPR3hgKVWGWrzProZYsXB+kLgl4A2Ty1jzPDG0+ijywtWieSnoyahDeWPMcJdEYyJ2XLbpFOlZWJzjm4DwZsNcQBEZneBj6o0pd9T0TR/jvN+GnlyjTLVZPdt5AmubTc4KDZt/ZXbzH+vZ2ja31UyJCy1fdJUkXnhioTKxDlDcWahxlUoBlwqgRdehaDnW0SY+e5MVuO/sXOS0W2Je8DAvd3eg7qWNLTloa7XslYLgsZgONZCCg+ahcNjh9TJyaIQO5DXT7oYwgV7Thw0jpXU70oN39cBJtMBU29/RWmRj17GhkzO3zlac7aXyfwt5u/Mtj39z7UidB3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVXX0y5077z6NBjQprvvEHc6U/cgViImSZvKCDNF6Uw=;
 b=hEQF9qc4LzcRswq8dPt/cWZxHXBQC0enRHt7Hky96fPc6LyARqet5WMCC6lhrfx4g0wCA/3vgtgFrP1fqinl5bEzACz5/wDqH8D4XWMrnLL0QT3hdd9B844rs9LVRUE8caCw9Lt8/pNfv8EMEG/UOogZNCj6slzfPiiL/WMbVoo=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 11:16:09 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 11:16:09 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Index: AQHXDqlhgRlOifwiAE+hoQ8fjRA8lap1Q7lA
Date:   Fri, 5 Mar 2021 11:16:08 +0000
Message-ID: <DB6PR0402MB27589AE0E8D140292351DCCFE0969@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com>
 <1614609861.083844.37863.nullmailer@robh.at.kernel.org>
In-Reply-To: <1614609861.083844.37863.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.176.14.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fed62b3-d35a-49e5-6d83-08d8dfc813e2
x-ms-traffictypediagnostic: DB6PR0402MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2758946BEC40CA3FBE4372D4E0969@DB6PR0402MB2758.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Tlex5H6YS5+ueKZRwzgXnJTuh/qwWCJItDWCWbi4kzINRfp7rbHUxerhtInycPU+ilUKph9n9yNX1H0oFgtbwcjxaluv07u0+21bhVDI2gqc4ioZGYhozzkjdssOY3CjW9ZN5yatXCDm6bqLIVqvfTqmzAAeR5a0219znF+xZo7S3Jta/KbdAn6Nr210v2LHaDjAi9e7HiNnTHh5RuRT41zDf3jnpWRi8MJDffnzsDBe65B08tOOzvppOu0HiC8DG0hxJBEapHtpRPWel2WFYRK/G1nUVkRn2nKsS0YP21fvJKtP8Zx70MkxEORL9nNPsNnHKRdtksAJAHa5xPruwvsWDiPdtQ9wFrWsoHyjDJz2cWuj4V2nm+a42bXkicj0fXI1P0wZxS80TtVgoUMQfQ7Kqm+xbeCiBaOJ8WgQeMd9vRFLwmERDuGF+waZNr+EXp74teGGTVs28j1qeHcYx/bo/dl9MvEB6FY/1PLLn9gcz0Y2aMw/3+KleWxlZ1AMjwMgs6ehqt9fyv7qm74/2ZXULZDFE0ZPlq4aDlIcrAxILCKwladWv0uOllaCYlPa1aAZ9w/lFWb8uCRfvxNFmgcZTI9C72PuOsyQz9NQ98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(9686003)(53546011)(316002)(33656002)(55236004)(6506007)(44832011)(54906003)(55016002)(478600001)(4326008)(110136005)(966005)(83380400001)(45080400002)(7696005)(71200400001)(186003)(66946007)(66476007)(52536014)(86362001)(76116006)(8936002)(8676002)(5660300002)(64756008)(66556008)(2906002)(66446008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8kgHjKPSgGCOQVbePFjLCpzFEEcEPOQzlUqZ4FekGcDu0qAPxkyeuliXVlds?=
 =?us-ascii?Q?IJIJ5iCJVHqvdRjm5FR/MUGFZ7NUgIY8X8WkqGp0LO5JrYaVJMp0UdW5jau1?=
 =?us-ascii?Q?LDaEu/7zvKKYxlPRe3aJXySHCDGJBZPckPvxJfwZuU40LtuhuJUdwRNHkKLi?=
 =?us-ascii?Q?2sWx+IJefUq3LnxP3JT8JRePYir16n5rYQp8b8h5rfR90Wgep5PYaxAQMC8y?=
 =?us-ascii?Q?FrBWPqPN0lvMYFR2P0CcgVWc4yXTnaw9Mx4kl9DHp3UUHJF+l9qRO0chsvxz?=
 =?us-ascii?Q?JI/xrOH+CG9OuLzQUbqu+qgbe1RCzaRwcePZSNrfNK29OYw0m+/eHG9X+xFV?=
 =?us-ascii?Q?KT0ThAvH227vPDo5iNgdWIG8bzN45IgQMNFsVXRSU62MNrYg+nkefWht4Z3r?=
 =?us-ascii?Q?EJC5u/1aisKTjPGUNUmWqW5eHX8qdRs73A1MqSABLRFIL4h0tpefs/mk6nwk?=
 =?us-ascii?Q?bF/q3EC4VFSLqPcQpebiRusJOVGnyaQ4WWOVRFt/n24+Lplw+8Qu5o4+z2X/?=
 =?us-ascii?Q?zVx1SsFHelnnPpHyI4XPcJBKsJzpUFiir/Gows7mvTyw/WVDhH8P8B/wK0IV?=
 =?us-ascii?Q?whJ9E4Fc9wHbYPM0JuYm5w46ZdNxhHKumCzJXHVKUwykX1Qi1r2kJqlLEu8I?=
 =?us-ascii?Q?t8f5KKrXrMSEEOs73fWnAGEdd9QIwdIWgkgx4pteaErmrbg5UP3E0XS9zaNW?=
 =?us-ascii?Q?kWaEjlVow9jk2uv+By8JHremCo7avUAMX3EYMDB5lK2Rnk/8JcnEzCm0MFIB?=
 =?us-ascii?Q?wTRXoL01Frn761uUdmKKNke6pZOG6fHx0EDtiBVA0u5To0dKclVOVHbbEdxJ?=
 =?us-ascii?Q?3TqLtl2PHZldCFSu0e/cibxC5PwtE2yaPjcF0NObd1NEdeGcB6X69or1BJTz?=
 =?us-ascii?Q?+trx5QCuEUhRCBqkmp+zQjAbFEPEnXd9MGnWgg2FoPn3wUFITUkz40MWvlsL?=
 =?us-ascii?Q?scwLZieslmbr0xIbX4xjHngKS2BHP1d9fHsV3zOpImqTYtHWlRw1y9nXPf1B?=
 =?us-ascii?Q?rSdht+krTBoZ4ylWsGLNvB0JA9tfPsfcIWM0cg9YJy5ovXfHyQlb4GkAoWsK?=
 =?us-ascii?Q?/rYWGbHxIkksenTNL/vTtG86FAxOBYVUFW7ULM3axRHikAsQw1cpHiEsLulD?=
 =?us-ascii?Q?xofacMxRIuCg5wJ7uI9xtiy4CEndamy2ja8SqynOU18N9kAWOXyxocIibQCm?=
 =?us-ascii?Q?Zd8Yefca9+moslzjXiTpQ9teTB6BowHpjnUAbKRqvun8Bgdxs4LOmPvZs9iE?=
 =?us-ascii?Q?b+Xxw4jrapq9zpP9UQuN1kAM0cnekL4KhzzKZDa9ertesJJn/+nudF3QCikj?=
 =?us-ascii?Q?ByI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fed62b3-d35a-49e5-6d83-08d8dfc813e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 11:16:09.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7CMbIM71adBNnqx3dLgN0xWw66Oqtn7OJ23EEACozUgSxlOBiKNSS3+eNTtiIf8JgEaSDMDds6l88xfUyZxqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2758
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, March 1, 2021 8:14 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Mark Br=
own
> <broonie@kernel.org>; Ashish Kumar <ashish.kumar@nxp.com>; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org
> Subject: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json =
schema
>=20
> Caution: EXT Email
>=20
> On Mon, 01 Mar 2021 15:34:06 +0530, Kuldeep Singh wrote:
> > Convert the NXP FlexSPI binding to DT schema format using json-schema.
> > Also, update MAINTAINERS to reflect the change.
> >
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
> >  .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 101 ++++++++++++++++++
> >  .../devicetree/bindings/spi/spi-nxp-fspi.txt  |  42 --------
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 102 insertions(+), 43 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml:
> properties:clocks:maxItems: False schema does not allow 2
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml: ignor=
ing,
> error in schema: properties: clocks: maxItems
> warning: no schema found in
> file: ./Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
> Error: Documentation/devicetree/bindings/spi/nxp,spi-nxp-
> fspi.example.dts:26.31-32 syntax error FATAL ERROR: Unable to parse input=
 tree
> make[1]: *** [scripts/Makefile.lib:349:
> Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.example.dt.yaml] E=
rror
> 1
> make: *** [Makefile:1380: dt_binding_check] Error 2
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work
> .ozlabs.org%2Fpatch%2F1445509&amp;data=3D04%7C01%7Ckuldeep.singh%40nxp.
> com%7Cb964d840a95e45dbf3cc08d8dcc08376%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637502066681922692%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3DGa5fpQ7oBEz8sQaA%2BtBZh75gPELe%2FDg6R5qJ2tZ2pB4%3D&
> amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries is
> generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s), then
> make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Thanks Rob for mentioning. I will make sure to run 'make dt_binding_check' =
before submitting next version.

Regards
Kuldeep

