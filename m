Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227FA17F131
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 08:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgCJHla (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 03:41:30 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:32244 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJHla (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 03:41:30 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: iJdTnug9arpDX1SJTikIZyVhXjV07sIbkUMwnSzNSLgFI40HYO+kqs2zjL7pnvQVZfEtq+oDVq
 Af6qwpvcofdz1ZRuyoYWgPc6F/79jbtHdMgl0FPAwDQ7iQci2dFCQ6ZNnEEi4+fGvObpU+/UdM
 3orQ99frzHMqCNLX/qm7Gjh/VsuRK6eY4lw7Esw6OZHufr5uMDNbJwnAYgnaVSC/YKYEOex/O1
 owuYUl+PcytMVwIwH5jM+LEw5e6f7fcVo+6KR5ZodUClRwUMMhYHwXhf1CKKM5b4rCr2E82+Ue
 ea8=
X-IronPort-AV: E=Sophos;i="5.70,535,1574146800"; 
   d="scan'208";a="69454650"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2020 00:41:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Mar 2020 00:41:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Mar 2020 00:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxjJ4OXVc6+4bHYjIaIhl4P8UgI0hw5U+ZLXWhfwTpaOVEaiQYxFhdBq5gyA2v32RWY49h2/e6/OxLMt2UxzMIF9NgtXnUC/TpJNgdpol22XBZW31qCdBvr9Gf0DCkQrKLmYsQtW1My5adhh4EhCYssRFMy8WRVIp+Jj2Dh7mjuaZMiqFA7kzGJ9FI/BKWDX9HUJ1d3sNlKW7sCocLZN9ctw733yEk5vYtPEy3FqJLoe8+kNHN6/yGbFHuAakzcdX5+3FozKqAVYZCXl72SRyGET3RI/j/ibiqc8sQBRWQAHTAIjmrGY6q7GiQBgnWe4cryzr93LZiL5Yqy3FJPK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE0CawRCXUSo0LXtr9OwRhxSC/uSBNYRJ5RCKOpapV4=;
 b=IJ2tltq0KhO5qlNtUijDqwbbZFWKxQ9Hk1qhsOmyMo/1XP9Qgi3EQz4c+jYm4+BeuNiG6BqwAFIZNa4OWAsuOEURrIBFIb2iT6nHifs0Kd6zplIFp14JvztXJxdHd6C1oSvEUs1xQB+lC7tcvydijrGiTJSggAk0HnZOQACVzhKB0d9/Ve+MZ3nH+P36vwI/ILoff74bF7yjeC047EVWUfKH4Mmii13xqr2z9gyWXNenCajbiFk77B8YcxjRYk7LctE1XrV3Vlo/gdqjWJ9ld+KJI3duYXBAvo4sZYP3qDJFQbnrkF1F2wt2wQnS+q8fKeIY1f1SHvZet4q8fE9Obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE0CawRCXUSo0LXtr9OwRhxSC/uSBNYRJ5RCKOpapV4=;
 b=h+Y7E99sNPo9nrob7MvUeL72ElHFeY5osRqZ7yp5N0NBYJtBBu83GvOmyJpMTLve3gfBPwP5hHD2zAubrp6JI152Nk9fnxyASqrSu1hVduOT9iR3FnQZRL2SaxGpev6aenwTCk4qMK58+T1yp0Ojqr+RgP7Gg72J384MKJX8KbI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 07:41:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 07:41:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <gch981213@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Thread-Topic: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Thread-Index: AQHV9q9NZuWbRCDn2EGRyTtBWaWZXw==
Date:   Tue, 10 Mar 2020 07:41:26 +0000
Message-ID: <2471214.x7VzW1FXlQ@localhost.localdomain>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200306085052.28258-5-gch981213@gmail.com>
 <20200309121020.GD4101@sirena.org.uk>
In-Reply-To: <20200309121020.GD4101@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72185611-e006-4c82-26d6-08d7c4c67056
x-ms-traffictypediagnostic: MN2PR11MB4600:
x-microsoft-antispam-prvs: <MN2PR11MB46004C074BECF2B36D91842CF0FF0@MN2PR11MB4600.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(6916009)(5660300002)(9686003)(26005)(91956017)(86362001)(186003)(6486002)(7416002)(76116006)(66556008)(64756008)(66946007)(6512007)(66446008)(4326008)(66476007)(4744005)(966005)(54906003)(2906002)(478600001)(316002)(81156014)(8676002)(6506007)(53546011)(81166006)(8936002)(71200400001)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4600;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aa6ia4kd0da6uwxZWkBMIoYXLbU5H439Kv57STuKKh4wgKhfdg13nswxOEq2J0ovCOViYHfGukb4j9iwD3n/4VNacTpa/0YcyirkCU8+Dom47foJFHzfIeBbAh/27Z+laM98J/debjVwg3jixmwQIBI5j7fFQERGA+jVS6uIz5bVtPS3LFF3hY4xqyEh2w2wbXbZSlNVRn7Igw8XR4HL/zRHX8wRBn47rrm9K8NWDagIQajtvat2M9GmKp6e/cBUWIDIxEPYHwzfSlvozNxGFvmCydBVUdQQ7CqI0lj902wFfm5EIdVECOej0+9CF68zu8qWFTM0C5OG6kimom0QHS8dSyeH5XQqx1eksYcQcCUIFpM5s/YgQt9mWHOg+kch3oEwqQnunN/bKYqpfGJw3ZJIN54Pxq5GqC/z1WzrDQOJrGpDfQ4juxd9DEBBiiLoRDmUPeuWnnjGYQQo+0I7HaEG1hDJq5+b4o2vGDQiyLx0w4dJ/xV3ZGxFgb9Bj00V
x-ms-exchange-antispam-messagedata: jQT4xqvvYYmPFVoKATacNduTqlP4otenqyCb0WNHAh2kFotkbqTCEIChE2xIVGV5Pqs001P68CQRYL5dvlggcPB4JjH2AqSRAiWrwtNuXfkB7layFN6jKnXalJWH6Czxx2lu71F3ZUVrb8xmfquJsw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A321634F4832945827FEDE57CD2E761@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72185611-e006-4c82-26d6-08d7c4c67056
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 07:41:26.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiMLjwuB7SkVmsP7b/xLrJl9RM0hqkFUbD8ltI+60eMDUlKLbbDhu7nsCEHfAXnA8D3YStDba3WWWeskVyaz3lvsPvNgNoJoGJjBvsdzyKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Mark,

On Monday, March 9, 2020 2:10:20 PM EET Mark Brown wrote:
> > This driver is superseded by the new spi-mtk-nor driver.
> >=20
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>=20
> Is this move OK from a MTD point of view - should I apply this when the
> rest goes in?  The patch was in prior versions too and is obviously
> straightforward.

If you find the rest of the patches ok, this can go through the spi tree, f=
eel=20
free to add my
Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>

There will be a conflict with the following patch https://
patchwork.ozlabs.org/patch/1247791/, but nothing that we can't handle.
I'll try to allocate time for reviewing the remaining patches in this set i=
n=20
the following days.

Cheers,
ta

