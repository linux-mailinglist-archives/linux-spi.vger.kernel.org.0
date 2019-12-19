Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E44126722
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2019 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfLSQct (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 11:32:49 -0500
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:37204
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfLSQct (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Dec 2019 11:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUOeryutKHXDDSpiW0KzlKxiR1SBY58ws+y5gfXucbORuuMdJgbYCl5bI6luO0ZIhHGj9Vabyye4aCgS49yZjxDpoBXGix/vOYl0l5bJ72utXtmCdp3oHTi4OzLCBWftvm//zkvHdl2QdX/FEYGXAnKFn47rYJj8O5DikEs7y6DDH+ju0JLdlc+n9S5VcPcy3Ak7gZ959iZftniEbZEq54piMAw4HfjpjLED8T51tymLxWVE9PQWXvih/SggC08XGAREwNC0NM30/SlGjwqqRBKW5tBjGy80rD+olXAIla/a5pfrufb+goBTb/zMlEhtl9lfTd7+j2MhxOKUJRsFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsDsGDCxFAcxH7fBRpH8TDjVByJIH9m0oOhlBMBddzs=;
 b=fRu5lpYuHOww82L05ec3/H9vT+qM2himmkCfgeJ3ZynlbVnsI89ePrDT2KSIW6PNfdOECFipDmu0OvsArHc14bvLGQkIbgjgpX6XiRGb7Km/uhO8XF1+y18nxhbnzhAvrW0W4p78CvyYA4n+Bh+3R6n6ElLKuzhLy+WaAgFZQBYR/v4AJXDSCQ7UOHkCZ3H6UOI2WQG85ZatPqB2XjlYexAbOUFYpHC9FAR8kV6ntL0Yl+PbxpHO7Dc3KnSmTzcPFRHeHPPsmYsIQD95X/ltEeTvzlEaMlquzuiSRRPnsb+HmW77KD0lLO9/8z/BS1rOcljif/FXYOVnOMgDdB6pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsDsGDCxFAcxH7fBRpH8TDjVByJIH9m0oOhlBMBddzs=;
 b=QqABxJRAaVJ08OMrBZ5fzW0RHoeY/A4audzX+p0nb6x5sH8xlc5PLvmzZGJQ7sNTIZ95ib5vmdyUgN3ZbLjAAj9WjVRdMjB1nr3zc3T0ua2Wt4O2HRJvsyPDoYMe/Bu+6rCjNnVm8A0hSkhP3++SYIrWAXQcttQZS0WEdFs2ebs=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1563.jpnprd01.prod.outlook.com (52.133.160.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Thu, 19 Dec 2019 16:32:45 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 16:32:45 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAa4UICAAYUHAIAA0FQAgAIeaDA=
Date:   Thu, 19 Dec 2019 16:32:45 +0000
Message-ID: <TY1PR01MB1562B2779EAB8CEA09F7B18E8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
        <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
        <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
        <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
        <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
        <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
        <90164352-6b74-ff78-261c-374f51f83330@cogentembedded.com>
 <20191218090952.4c9f02a1@collabora.com>
In-Reply-To: <20191218090952.4c9f02a1@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmRlODEyMGQtMjI3ZC0xMWVhLWFhNTgtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDJkZTgxMjBmLTIyN2QtMTFlYS1hYTU4LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMzMzIiB0PSIxMzIyMTI0Njc2MzQ5MjExNzgiIGg9IkVSOGp0aEtra1NNSjM1SWJMMi9YYWR3WVVJWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe6fd247-4598-4209-d7ab-08d784a113ef
x-ms-traffictypediagnostic: TY1PR01MB1563:
x-microsoft-antispam-prvs: <TY1PR01MB1563DA4B1C3622F72E7A1BDC8A520@TY1PR01MB1563.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39850400004)(346002)(376002)(366004)(136003)(189003)(199004)(7696005)(81166006)(81156014)(71200400001)(26005)(2906002)(86362001)(186003)(6506007)(9686003)(52536014)(64756008)(558084003)(5660300002)(33656002)(66556008)(7416002)(66476007)(54906003)(110136005)(66946007)(76116006)(316002)(8936002)(66446008)(478600001)(4326008)(55016002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1563;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHSq5ZrLGL/E1U9YEnWMzinUO2v3AcyP3U6Xn/vRfc9mye4Bx6lvPhxyjikJDrQkDBcTI3tkkPMG8Q0dBs4xTi6/KryMaqUybrAQc9KAfw9d4NiRRvA/ZCsWVMVdPCCMFdZQmbhjoT1zX6QFro2pMRaurE+SIpawCV/EjS/Y2GulE5U1nYcBJ1ctAEzB4h6G6SCYUm3Cym8pXK+bqhO8DCtMKCYpckKeWRuJv4ig/JmUv9mLJslLAklLsGxq6g8mT5z/kf4pnAFrSxeJCn7X3dq48oDeVxQ7ca3tWxR1U9GSlMCOhkswf2eNEhNYgSE7gL9HxeOdX5JyjUfi3SBqrL3sytsCjk5bQAVIBDKaZD+R2wD4WSYCckmN6pIsTiSrPILXg8Z9BOVnX2gw1/V2XyBkOVDUb2PpyfFKbzt8ptgEnvR3FtJ5Hydk/kyp4EEM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6fd247-4598-4209-d7ab-08d784a113ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 16:32:45.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VS3Uvj6pysGM3xLuBPM/04wCv4Im9CHGr7vvQPryOeefF/kQeIMOl2rf/ANwfvSjqKLGvhyJ4jCSyaX0UgUUUlvSAVlW1lZhzhJS5g2i0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1563
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 18, 2019, Boris Brezillon wrote:
> The dirmap API has not been designed with XIP in mind (though we could
> theoretically extend it to support XIP). The main reason we added this
[snip]

Boris,

Thank you for explaining.

Chris
