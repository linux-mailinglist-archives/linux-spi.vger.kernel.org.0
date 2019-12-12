Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39F611D2CC
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 17:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfLLQxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 11:53:30 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:62658
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729961AbfLLQx3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 11:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqQcOKoBlQ978WfXRWVOUoT79e+jLKyUZcEriyzCPOPUb8Zxy9tpZHWxZI5A1xQe3hd/3DKFsy8HTckow5fg8hX+p5RYsZO2dWLXbAPv1BgwRj2PJKOWlkaz4pLUtq2/n9LC8K9GS7OLnlIsEsx4UsoqHWUzDAJgZNUITXlyc7gmRsN6Mf6dKZVpdnIsDDIIMlD0s7EAOn0kaf1TR42cqwOr2XVyYmjAbQu1yJHi7E+4T02MdeAhMc6GJIjbCga52j+r3Megxt3WWuJpIOcy0Y0V+dZtfppzy/bg8kZbo3Rs27jCClETQdBpVha+9tnzWlfWZZxlZnqGON/vHJKlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJLsEKd/1IkcNiBgjzgXJv35XqbqMMWweyk01Xb4h40=;
 b=exz19m400myr3bIJu9nYh9uMbEIM/4sCmQyCtn6j2UEFcIek7DdSHVCvVhkSTuZiNsV7lFTrb+LYvO5eyD83BN5JNaz5y5UlFPNOLt66/I8Add5APsijXv1A705gl8UC/LyaCBZIjtxNLp9g+wSSL7QY5GpLoA3MSwmzj2hn+0SwC5d+yHw4sAH+B7DEUmHs6yI3ouSxJek3mZms4WdefPDRwD3QLG6O8kd0aS3oL2Jarf+zFaES5kEc9cv5wo1KICUXJu8h+DfeNyOT6VvUGKBdwe1jXp39nIi6+remGu1cSprIcTbJO3VrPHF7SsceV1As3iwhvCEHpPc9pOfbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJLsEKd/1IkcNiBgjzgXJv35XqbqMMWweyk01Xb4h40=;
 b=K0QjDQVkDZRnhvEro69DzoBai7LM/7DQc0yjtevNJWBB+LFYrKJFdzUC38FLuLswInluqDQIv8gZk5xQ6dlIWWI5y8NkvwyY1gaRdYnG+9zldzgsbDKF6TlND76lA36GGCWXQzGnVCQ94iYkT1XZOimH9FuZv2/2eQXn3Whkzl0=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1820.jpnprd01.prod.outlook.com (52.133.164.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Thu, 12 Dec 2019 16:53:26 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 16:53:26 +0000
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
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAAaWYCAABMxUA==
Date:   Thu, 12 Dec 2019 16:53:26 +0000
Message-ID: <TY1PR01MB15627D5522BE325B7BE74E328A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212152855.GD4310@sirena.org.uk>
In-Reply-To: <20191212152855.GD4310@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTg2Mzg1ZTktMWNmZi0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGU4NjM4NWVhLTFjZmYtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTI3NCIgdD0iMTMyMjA2NDMyMDQwNDgzMjU4IiBoPSJkemQvQUh3b1lrd0xZYnBaWGsxSTRXc1JRN289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48d0998f-5b86-471d-cd4a-08d77f23cebd
x-ms-traffictypediagnostic: TY1PR01MB1820:
x-microsoft-antispam-prvs: <TY1PR01MB18200327521769E2E60CE4B58A550@TY1PR01MB1820.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(71200400001)(6506007)(4326008)(6916009)(26005)(8676002)(186003)(7416002)(81156014)(81166006)(2906002)(478600001)(66446008)(76116006)(66946007)(33656002)(54906003)(316002)(66556008)(64756008)(8936002)(5660300002)(55016002)(66476007)(9686003)(7696005)(52536014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1820;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: orRGZ2pk1Bljw+33wI14MAejRql9dzJinOaqUxSezhg+8LR7JMFTanccxnZPZfD4cVm7ZCW+s2BiWPX8HmS/Su/pU4hb6Ck4yct1Bc3oAQxBFtYKdhUcdjHGwGlQ0lcO0N5h57Q3qlWqfI0lBrPlTwK++VehCg+jYRzhuQDchP+zlL6s5VYXpusnAaLGzbo3ixGZURTF84raiR+ex89BisY7yR93vxtz8T0sKAa4L1ipE0wvSnt+vADIdNVdn+YUgQVQpFPRrvjD9/3Rb8QGRvv+wXQGYpDeFXeXsWRmT8qg08fNW36Y9jENCq+25p19Q+Wf4AvjFp5qav0twTajSSTUnfwmxDDuWC9b5Y2ZGn6COwNsF8rsaYg5/oQA8Z6TSBmiYaoSidQOUwOR7PFsee4wuXTkzl4YLmY8rOXnslVUjKC5ES0YI4WaTE/fPbN2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d0998f-5b86-471d-cd4a-08d77f23cebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 16:53:26.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmK+ASEFvGBVhpkz+QUZvk7H8i76+JwY2A0HIqF4D3/HfcH11YOLiYHFPABIgtFQ9v3jQPjycntQrWJcxo7wbDsBXhvg5kssvQp1IW65rxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1820
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 12, 2019 1, Mark Brown wrote:
> > Is that why this "RPC" patch series is taking so long?
> > It's a fairly simple piece of hardware.
>=20
> The submitter appeared to be having difficulty with feedback from the
> reviewers with knowledge of the hardware, then it looks like the last
> version of the patch set didn't get any comments from any of those
> reviewers.

I went and looked at the driver and it was more complicated than what I=20
did so I wasn't sure if there was some more advanced functionality or
something that was trying to be achieved.

I admit, V1 of this hardware (in the RZ/A1) was easier than V2 (RZ/A2 & R-C=
ar),
so I had to re-write our BSP driver when it came time to support RZ/A2.
Basically, when they added HyperFlash support...it 'changed' how SPI
support was working.=20

I agree with Sergei that it is always better to have a common driver for
common HW across different SoCs. However, it's not clear yet why there
needs to be increased complexity.

There were some good suggestions from the V2 series that I think complete
this driver. But I have not sent out a V3 until I can better understand
this 'competing' solution.

Chris
