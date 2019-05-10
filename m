Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B314C1A328
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfEJSxf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 14:53:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:53846 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfEJSxe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 May 2019 14:53:34 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd5c8bb0000>; Sat, 11 May 2019 02:53:47 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 May 2019 11:53:29 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 10 May 2019 11:53:29 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 18:53:28 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.51) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 May 2019 18:53:28 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3637.namprd12.prod.outlook.com (20.178.54.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 18:53:25 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8%5]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 18:53:25 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Thread-Topic: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Thread-Index: AQHU89KFcGFem7n2hUyXzOJxTF1ajaZDnpyAgBAjKRCACeNYgIAHM2Xw
Date:   Fri, 10 May 2019 18:53:25 +0000
Message-ID: <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190506044425.GN14916@sirena.org.uk>
In-Reply-To: <20190506044425.GN14916@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d1d444c-3290-4c2b-f8dc-08d6d578c8a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3637;
x-ms-traffictypediagnostic: BYAPR12MB3637:
x-microsoft-antispam-prvs: <BYAPR12MB3637B861F915C1A2BCC7708FC20C0@BYAPR12MB3637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(476003)(76176011)(25786009)(68736007)(81166006)(6916009)(7696005)(55016002)(486006)(81156014)(86362001)(9686003)(8676002)(11346002)(6436002)(74316002)(4326008)(7736002)(6246003)(8936002)(33656002)(102836004)(6506007)(53936002)(316002)(14454004)(478600001)(256004)(73956011)(305945005)(186003)(76116006)(2906002)(229853002)(54906003)(446003)(66946007)(26005)(71200400001)(64756008)(66556008)(66476007)(66446008)(71190400001)(5660300002)(99286004)(6116002)(52536014)(3846002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3637;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hmm1Pl6d4T5zF38Oimj/UHvsDdfYT5m7dbU9l+7VJj6c/w9l1C4fI3Ui68Af6HiZ7GrO2Mca4rIXjifuwWW49ymNo6xlG+vQb9iVXKh14OsB8nHDohdfUbTdk3ivb9iZuf2853SCl7JkvZ8hJ4TzLXoPZFk5Fbaf8vZz/3gM8aMOWroqnLE7qK8V6se0h1CGpt7LNtdGIzIVzmLJJoznPJuTdx2UO/oOnWAh7OaBNhzlsnhRENWZcK8+mG+ukiqfd36kQyKZ49QNUdLdfPLEend+lo9lDucAs103CEY+iTUDf6ch+m2yTlS38JcnHq7oBzDJQcNjNZGR2yHdpFwiXyH4K8r/ihl+d940la2u1xLEGn3mK3hi+hV736Z9zQMIiJoLI4J5MQbKs6gDfb+idmWJcKSK9ifCmj9WIYYpLqg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d444c-3290-4c2b-f8dc-08d6d578c8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 18:53:25.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557514427; bh=VT8bt+syJmx854wEZloec1bmVexlWZhId+Yw+YOfMPY=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=cFo31SneKSwPX/nIxOFVh3+HocEQxWmSoeob7zEw5wQs3/llIXXvBWa18PkAueJEc
         tmJEhDXLtPzOi4uCBLKaIoEkA1KgACt6aih3QIIXKelzf45r/ogvMDdimkMDTyEKKu
         JaVHb0CD15356nkqi8u96RN+yRJKBPS+TVhHsB9BobQl4FF7ZWaTRhT7gRReM3Gm/g
         sIu+XgC/q9L62ahN1KnADyt+prmxuKjgJ08GKleHe6pNzAESGK8rZK7W5gjj0SbYOu
         zdii7Y8xsW4NhCCB6ep2C1xLZyWbGaO7m65NBo01MjrjYR9gGQLnGh50ye6qaY33qU
         zz+w8Sp+8j/Ng==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:
>=20
> Please fix your mail client to word wrap within paragraphs at something s=
ubstantially less than 80 columns.  Doing this makes your messages much eas=
ier to read and reply to.
>=20
> > > On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > > > This patch exports spi_set_cs of the spi core to allow SPI masters=
=20
> > > > to use when gpio based chip select is needed.
>
> > > This isn't really what I meant when I said it'd be good to use the=20
> > > core GPIO code - this function doesn't do a huge amount really and=20
> > > the usage of it in your subsequent patch for the > driver isn't=20
> > > exactly joined up with the little it does (which is mainly swapping=20
> > > in the GPIO chip select instead of the hardware chip select) isn't=20
> > > used in your driver usage of this as far as I can see.  The bulk of=20
> > > the chip select handling code in the core is actually in
> > > transfer_one_message() which your driver doesn't use as it's got=20
> > > it's own implementation of that; I've not looked in enough detail to=
=20
> > > figure out if it could use it.
>
> > In SPI Tegra driver, we wanted to have GPIO based CS control when=20
> > cs-gpios is specified in parallel to HW/SW CS. Having parallel GPIO=20
> > based CS is to mimic some of the timing stuff that's needed for some=20
> > spi devices by not actually using HW CS on platform but only for SPI=20
> > HW design logic inside the chip.
>
> > Tegra spi driver don't use set_cs callback so looking into spi_set_cs=20
> > from spi core implementation when cs-gpios property is used it exactly=
=20
> > the same that is needed for GPIO control CS. So used this in V3.
>
> > Can you please provide more details on what you are suggesting?
> > Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs=20
> > and instead implement in tegra SPI driver using GPIO descriptors ?
>
> You're probably best open coding in the driver if there's value in using =
the hardware chip select.

Sorry, Just to be clear on my understanding of your suggestion,

3 ways of CS control implementation is needed for Tegra SPI
- SW CS thru SPI Controller
- HW CS thru SPI Controller
- Direct GPIO based CS control=20

Patch Series includes both HW CS and also direct GPIO based CS.

Regarding direct GPIO based CS, I understood you prefer to use GPIO descrip=
tors.
I see SPI core set_cs API also uses GPIO descriptor for direct GPIO control=
 of CS.=20

Tegra SPI driver need parallel implementation of direct gpio based cs to hw=
/sw based
CS control thru SPI controller.
Since SPI core set_cs already has implementation using gpio descriptors, in=
 V3 I am using
the same API.

Any concerns for using set_cs API from SPI core as it already does direct g=
pio based cs using
Descriptors?

Thanks
Sowjanya


=20


