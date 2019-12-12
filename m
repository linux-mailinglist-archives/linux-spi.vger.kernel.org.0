Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED1A11D3C2
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfLLRZr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 12:25:47 -0500
Received: from mail-eopbgr1410104.outbound.protection.outlook.com ([40.107.141.104]:3753
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730088AbfLLRZr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 12:25:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBep7AVB6qZ1274g/J1aghWMX+gwpUqBLuHs9fQ6T5AGcqaZC6o66kXcpJ/NokBcTU7/PaCPdAbi6Y+YZH8w+5tAVWZXbn5I/ZRetaPPNDGqlxyvxOkBuyJuTYY7kO23c2KOi1TJiS8uoKTsNlux56JAp4Sq0zfugkzPTCaNKc2SoAcYSX4Uj5S+ZAQhqefLOuRJT7LhDw/meqXmxIPA7Xpd6HPqRfPVLB0Mc9c8hG3mj5tIcKBfzt2DqQ/+FUGKFBdpvFoRgfpRfzxhPBh5o/C0zS7mUg6kU3fB5S+CK/3pGZFQh6rz4GY2BI5cGpJmwjV/1NjKzWqvqiOLE8jL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2vekd0pRa1kDGoNBho71SVuTKV5H5oyrjgv7If3Eoc=;
 b=Tc1mxbnISGfz9xS2QQalfwNyeKdpo7mZJMBfMUOnBoIqPNm825EDeonlJ5qhY0hJFDrzkQr6RZLMISEO53ryHSqZFiN4mI/1R1lNIb/kjtXV0KAUJa4tPFKWlrDTPAf9GNF+cpNE/Cx6JpfiUchTXyIilr3356TLLJujTgBxj3TWhcYasaAMjMP+MmffqP5CUNPKPInQBj4TnxOTp9eoU6CQS2z30I2Pq6S+mxApP2QZboijwwfIM22bYkt5no4+5duuKSjezYoXSWz1mhrgGLXHnFReAJn8PstA3PhZmBXATeDJObOgkVT2H8+zbQjYLnzzgnJ4H9m+ZNHtxhIDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2vekd0pRa1kDGoNBho71SVuTKV5H5oyrjgv7If3Eoc=;
 b=n7/WjVlhKqkF9aPR1ZK/VpuySjPzS893n7KD54BuRuUeuPUEVvum8dRopHT27bw9QvNC+HFasCCQS4+qE370EL59kzfC9/P5IePaG7QyDfy/cUSZgSI/Fg87aTvIb/+qcp1mcakyj9WTAm6omrtZLtXhGoVjOei56dI133JVwdE=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1866.jpnprd01.prod.outlook.com (52.133.162.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 17:25:43 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 17:25:43 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAAaWYCAABMxUIAACeyAgAAAr9A=
Date:   Thu, 12 Dec 2019 17:25:43 +0000
Message-ID: <TY1PR01MB156256ED8A09D4CD02AC26AC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212152855.GD4310@sirena.org.uk>
 <TY1PR01MB15627D5522BE325B7BE74E328A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212171307.GL4310@sirena.org.uk>
In-Reply-To: <20191212171307.GL4310@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmE1ZDEzMDQtMWQwNC0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDZhNWQxMzA1LTFkMDQtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTAzMiIgdD0iMTMyMjA2NDUxNDAwOTQ0NDg0IiBoPSJ1MldOdUNvbm1IZm1kcGZaWU1kTWlJcUNKOVU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74c6fd99-1a80-47cc-b8f8-08d77f28511d
x-ms-traffictypediagnostic: TY1PR01MB1866:
x-microsoft-antispam-prvs: <TY1PR01MB186625A60C14B1B22939E34B8A550@TY1PR01MB1866.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(5660300002)(66946007)(6506007)(186003)(86362001)(71200400001)(66476007)(76116006)(66556008)(54906003)(52536014)(4326008)(64756008)(2906002)(66446008)(26005)(8676002)(55016002)(33656002)(7696005)(9686003)(81166006)(81156014)(8936002)(316002)(6916009)(7416002)(478600001)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1866;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuSoZW3blgNES/72JV9jeJ4s/9BXemxA05LnI74Moh7WeJEZnrjwR1mDbC/hX+lAvBuXJu2NssUAB2nV3gAdkK2pjCHGrCGiem5kNoZUNStsiC4T9/MboxK2iKvvUR1w3YfiAhRYHyxluONrddYJ7xvM1PFofe9pwhitdijrADwg4zFeWsxhgfJOmyWDaXz8TNGSwFacPON048F1Vl812vZEvqQ+VhxRiXv3VJku8VJRwUEeEh4RMmoDrEg+g5CGiGY6jBt9Rm3P9Iw3qctp/0x10CLh7DyfpWC0IjQmxS/orsrhgEjFmzY1ldMIb7Rjb2yrD/VEBWBOFJwlz5WfHR81yQeCzY6LKZPBiVoDmrcAXEgM0N65h3QAElW52xc6i1zgAcK88e1sFvt9mM+kSS0hrdr9haHg+dT8nb4zmJoCpufiB6O5Q0FnQVR9bY9i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6fd99-1a80-47cc-b8f8-08d77f28511d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 17:25:43.1566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0brWz6f9SDtp6x2scpUkItr0UskvJjcTSQoEAh0YFWk4WXd463NZ7kkC4BGkkH6jeJYqWuMNKloL52hL7GLH5AN4JJu6eHgxnVQYwgBDIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1866
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 12, 2019, Mark Brown wrote:
> Oh, this is a new driver for the same hardware as the RPC driver :(

Correct. More or less.
Of the 3 devices (RZ/A1, RZ/A2, R-Car), RZ/A1 only supported SPI.
RZ/A2 and R-Car now support SPI and HyperFlash.

But in my laziness, I never upstreamed the RZ/A1 driver 2 year ago...so her=
e we are :)

> I don't really know enough about the device and there was *huge* amounts
> of discussion which I'd have to try to page in so it'd be really good if
> there were some agreement among those of you working with this device as
> to what the best way forwards is.  I'm not sure any of the issues were
> at the framework level so that's probably more sensible anyway.

I'm trying to figure out if the differences are 'technical' or
'ideological' (ie, R-Car use cases vs RZ use cases).
Of course we can do anything we want in our vendor BSPs, but I'd like
to see a common upstream path.

Chris

