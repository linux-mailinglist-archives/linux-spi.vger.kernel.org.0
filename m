Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274CAEC67
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2019 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfD2WCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Apr 2019 18:02:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16894 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfD2WCz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Apr 2019 18:02:55 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc774960000>; Tue, 30 Apr 2019 06:03:02 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 15:02:50 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 29 Apr 2019 15:02:50 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 22:02:49 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 29 Apr 2019 22:02:49 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3542.namprd12.prod.outlook.com (20.179.94.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 22:02:46 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c%5]) with mapi id 15.20.1835.016; Mon, 29 Apr 2019
 22:02:46 +0000
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
Thread-Index: AQHU89KFcGFem7n2hUyXzOJxTF1ajaZDnpyAgBAjKRA=
Date:   Mon, 29 Apr 2019 22:02:46 +0000
Message-ID: <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
In-Reply-To: <20190419151823.GS2803@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49f9f5d5-042f-4d19-89c2-08d6ccee69c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3542;
x-ms-traffictypediagnostic: BYAPR12MB3542:
x-microsoft-antispam-prvs: <BYAPR12MB3542901594B6E9E3B1BD0604C2390@BYAPR12MB3542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(8676002)(81156014)(256004)(8936002)(81166006)(446003)(486006)(476003)(97736004)(33656002)(11346002)(478600001)(14454004)(71190400001)(5660300002)(71200400001)(66066001)(52536014)(4326008)(99286004)(316002)(68736007)(305945005)(102836004)(74316002)(7736002)(86362001)(186003)(6916009)(25786009)(54906003)(3846002)(64756008)(73956011)(6116002)(55016002)(2906002)(53936002)(6436002)(66446008)(6506007)(76176011)(6246003)(7696005)(229853002)(26005)(76116006)(66476007)(66946007)(66556008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3542;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rcZ/uG7uSEaY2FGCqvhZ7GlepjAa+wi+9N5qAVcarydMdjVMv3gZGG0BnKqGK1TEzvVcH9/F4jfzRPBRXpNZZmYkT6p6X9uAVAdEJmYNjKBuD1nm9wZi7g95QWhpfHIj6g37Em5L0Vc+FLQWkrXngA6Pt2VPoOhDDdv8krRNh++EgZjc1OqxvbzaroXIu/++ZFUze4zsb1SMgHcx5YyxZNY+ur7sVjaYW9jyfoiMkJAUnjllEif1K/f40PO5ynOuD3nsabpk2zBZA18e+y7Bb+v9c4jYcRnPkGlX1JpEi/vlsiFWFtrMW9jCqq0LNW6jGjer1HfXSRwNfIxtVtpld3yuOKdnZTng5J9Y+WykoB0mV2IPOaLE9OHBgp3mcfeqX+9sKlTdoB20/DVJZWthXv/niBnsAJr6jPFUY31KAbQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f9f5d5-042f-4d19-89c2-08d6ccee69c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 22:02:46.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556575382; bh=5yKZKf0errhNL3mQy5FDPk9vvc7PMqpXX3TIYiMpOPE=;
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
        b=Vt7gPh05mJ9yLbOAxTMaNWD6IehPsu83L6qYDntcQNJwoyLxVzP23G0FgqWvN0mj4
         b0zDhT0KYjaPq40ytVYaEhkKRPsKVZ1fmhIH2U41GzFtd/ymAgghZ07xs+Fp1/2LMf
         f0J0t3nch7QGeZ+fXXK2ayWFU/+KEuEf9kfe1oGphloQP4BZOh1GgFGI84fuP+JH/8
         2NoIOauYiQ2c1nWGgETN63pqX4R5Ylqe8uu4WdpDLAiyv36WcYKAGb+5RLaMmrE26/
         L2KxeoeHgUfCxgNK/rVcR0eYtoTizDnXaJqeDtl+iXrGcWAWK77Xt334BypNmEQxfr
         D4HwaCRNbApnQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > This patch exports spi_set_cs of the spi core to allow SPI masters to=20
> > use when gpio based chip select is needed.
>
> This isn't really what I meant when I said it'd be good to use the core G=
PIO code - this function doesn't do a huge amount really and the usage of i=
t in your subsequent patch for the > driver isn't exactly joined up with th=
e little it does (which is mainly swapping in the GPIO chip select instead =
of the hardware chip select) isn't used in your driver usage of this as far=
 as I can see.  The bulk of the chip select handling code in the core is ac=
tually in transfer_one_message() which your driver doesn't use as it's got =
it's own implementation of that; I've not looked in enough detail to figure=
 out if it could use it.
>
>
>
In SPI Tegra driver, we wanted to have GPIO based CS control when cs-gpios =
is specified in parallel to HW/SW CS. Having parallel GPIO based CS is to m=
imic some of the timing stuff that's needed for some spi devices by not act=
ually using HW CS on platform but only for SPI HW design logic inside the c=
hip.

Tegra spi driver don't use set_cs callback so looking into spi_set_cs from =
spi core implementation when cs-gpios property is used it exactly the same =
that is needed for GPIO control CS. So used this in V3.=20

Can you please provide more details on what you are suggesting?
Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs and i=
nstead implement in tegra SPI driver using GPIO descriptors ?

Thanks
Sowjanya
