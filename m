Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1534E1CECE2
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELGQ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 02:16:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42860 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgELGQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 02:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589264216; x=1620800216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wqYxkizf978rl96HjeZnrTvJJgv4ZrvXi374oL1WGHA=;
  b=dMKhjgng2EBfxHBd3KTZ0zCUMFvkKaMYNjJA43b2LXBAqpAfwM1Qj+G4
   NBfF4VS+/VH2MoRDm+ob2VJNcuViUHd2AthDGc/nVZSX2Qv8lhQEqCM3C
   cZKNHQHNC1TCjdqNq1T5n9VO2GSbcLGUrblhwkX973AS5ZCmbL3A9Q7O1
   UeDZ7a5tTDx9sngnDIZMiuPiAzG+C7tliv3DrVfCjTwwGE2L4u9iV+BwZ
   2q88pHLEwhCWiXP1as/w4xTUb4xynI+C/Hai8gZBd9zOnQyIZZxIga5jm
   /FeFebZ3soLxUJij/CGzNX6RQQkC3vuRlYTr5x+DDC7g9uLCOBMuQ63aq
   Q==;
IronPort-SDR: EArsk8vci0zaHCMJ4YfSsDBBafyLIhKA9+k/VCZL0A8lIN7+OJV5nPKwm5I+RFYLVzy6vg2QZH
 gwitZb5TxstPJVFsfDCP5dcy8sdJGGRIQkRCsiwQvqDWvP31x9vSCFF+hzedVyQkGS1rMBdAnu
 s9nvCmHrhsnmP3eHR0bjomucHK6X+mZai+BDAgpd+5TPwSojnb4+yYVeqazQF1IspFvzMLv284
 BXx5jC3+hlQSuhnffkkwyyGTSZCmeyh/jwjm9xUKFxX7T42apa9LA+uOEdjHS3FuhyXcxuAjp0
 v5g=
X-IronPort-AV: E=Sophos;i="5.73,382,1583218800"; 
   d="scan'208";a="75576543"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2020 23:16:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 May 2020 23:16:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 May 2020 23:16:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8nv2E0geFSZ2rmaE+P4lkkeM+7mJCBXhvd+9KPkRLeDKDXEUztRxI1ayzYT6ZI3421vB4QF+Kvoe6bY2gQBtfYP9iwzxO4bzVGppNh+hRLFgfJKJyXIJj4zEFrFKPLsB9oN8lCtmw/t7ZDHxGenI7RnjsaJH5i6iHgyxnMbmtnFhDXoJiaXvSGHXkV5NqiUYJNnzaEc+sXeBHhMrlgCos8Fp5jm/jYbblX0TXbi4YsyctcSCdMJ0yBaqWOjMUP2BR6KgvtI4H6UgD+XeGVKIcEKfRdDBqJAVrD9d0PCwl3mV84bmuS2V37JGchAET8KqCjKOumLrZuvJnD0RTFCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqYxkizf978rl96HjeZnrTvJJgv4ZrvXi374oL1WGHA=;
 b=GXiwnM4Wgf+bIn4J4VICNHAkdtDtHkQiN1d1Z36IEdOYyvR/xy8r8xNyIAGa0NKxYIcbFzT1pWEZCdjUUEVtc+eSx6dGxseWqyZr6fOPu/oqY5m51tUAx1nqWUBwMP8DmrWJmSx6zone73nCydOTHHgQaZOIvQXwltuCz6xVV58X63iQI9wWTie0sew5VZJEJ0V9LQtYqO8+aat7EheyU8A3anTe56kKjRY7R4620V3VGfaeiFl4fcgcBs1BQQyRKKTk1/oa2ZkF99cAyVSGBzfiT4oxgDwSz9wKL6khQTTYydOCDsc6bkS+pQijA1DFoqbZbk3Gy03lLn5T48ecAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqYxkizf978rl96HjeZnrTvJJgv4ZrvXi374oL1WGHA=;
 b=Xt3p03JjXtJK4iapUJrxtHK0Tc/gXCAGBx0P7KyDzRPSA1Q84pQf5OEkKRBcdoMEeorEu4b9WdhYLQF19bJDg0x1OasY4PtOfk+woDOuC1Xs/3JsLnQn2EBHh9nRdVnpv38+/f33Rvb+ecShM6RVoHu7hhRw6x6FOQSOvGpvL/E=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4291.namprd11.prod.outlook.com (2603:10b6:a03:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 06:16:52 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 06:16:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <p.yadav@ti.com>, <alexandre.belloni@bootlin.com>,
        <vigneshr@ti.com>, <richard@nod.at>, <nsekhar@ti.com>,
        <Nicolas.Ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWJ3Khn/aolf/mv0usqjltSIxTLg==
Date:   Tue, 12 May 2020 06:16:52 +0000
Message-ID: <144878625.o7txgtY6sz@192.168.0.120>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <3649933.zuh8VGJVCz@192.168.0.120> <20200511112712.466f7246@collabora.com>
In-Reply-To: <20200511112712.466f7246@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ad52947-c446-41ae-9f59-08d7f63c101d
x-ms-traffictypediagnostic: BY5PR11MB4291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4291740DA943AD341293788CF0BE0@BY5PR11MB4291.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBfrnNDmYmW9+rZLNCXbkSl2VUqvCyg2aJY2wGoouF9jTNMY1lbvqJhYwuUwfjWNJX0/DkdRElqgmKTCFJAYjf+sqxcyKcSmdYpj+YET95dlRSWJ6ga+ynfNvPnSBLhmnlZdB6w9ClwTx4RpBCW/iGz1r2P6jAWcb6vCL3C2zqukygRXi5dKAyzL1izT5k/HfkNvoUB+8tciawyKWOhxumYw95df0TsbC9K9jBrrNq4Tffp5u4zFzkM63dfGDqhOvPAcP5Crpiv/NlQeggAGpBSejd+zZe01Wm+sR9IIYlFuft269lNcrVvU2UNNHDp7UT/NrXP6gjo28oJJ8QNo9HmgEJ+Ol2jC8e7XPPybMS8h9AKsj/h0RdQ7fw8Ww2OgoVEGRVwLGwJvWMIh66Wc88/wJ0zwWt7U8miQzv+hOITRlYJ8WX54H/bwyc5aEOaglypDAqk4VzWT0aGMjMEtOSJYXZ5Z6/ZFbJyP8YVsS8R4AYePl3e/AG9rBRuXSS667atfBZvI73l705p+2DFqu1oAch3k5OXExOEOQec6A3mW65fqQjnBCDU0iD8/P0or
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(33430700001)(6916009)(316002)(53546011)(478600001)(8936002)(14286002)(9686003)(8676002)(5660300002)(66556008)(2906002)(6512007)(4326008)(7416002)(6506007)(64756008)(54906003)(26005)(86362001)(91956017)(6486002)(66476007)(33440700001)(186003)(76116006)(71200400001)(66446008)(66946007)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: R5tfa+RpuQpEm58VMFhiQMKQbgiotAsSdHswScLv5iB4blm1q0x7jrSmqiJiOwuLue7GJczCouA5X2h7eyHRZFrOpqYLS2VZj7QDOVG/Ki/l8fBhSjVxjEVQtcIFE3LV0eVxxprDK883xZck+FHV42AzEx5n0ehBUtMvCE1k+kBjr9GtGdo2eiAvZmjy4GIVWXK6m3MUwGqpRV0bRFRKFM7IACotpWuNF/1typc0fgwtVFJRFzj7Ikt2XKmhei83kfFN96VgJL0gLf//vt1ivFTcwVPtfHe2wyVBxdWaWkQEiwrxgfBU2zTw9t6c0e5UweLimnUV8F8cr4uM5cJhNuV+jSiZhKExs8MBxBwNe+wUZ6VhC7brWc5B7qtHngGHBWDvXotP9AW6eN8d42I9xp3jNL+OGHtctyLfMxHHV4a5mJCthoPd/6jp3mUOg/2ebOkdp3xTePtwDebgXXjWPqD3mpq/DcpJDEL3BDDqoNw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D67A0AB6DDE6549B9366E73092AA3CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad52947-c446-41ae-9f59-08d7f63c101d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 06:16:52.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GPt2Yiz5THlRm+joYY2rNA1gmxGkanf+hah/HKpYQa95w6f84nR4Sddg4dmP7F1oOOHLMPUMqyFTppuDjRC59Ot5NI/VDJiKmfrcbV7QF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4291
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Boris, Pratyush,

I stripped case 2/, we'll not treat it for now.

On Monday, May 11, 2020 12:27:12 PM EEST Boris Brezillon wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, 11 May 2020 09:00:35 +0000
>=20
> <Tudor.Ambarus@microchip.com> wrote:
> > Hi, Pratyush, Boris,
> >=20
> > On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
> > > This series adds support for octal DTR flashes in the spi-nor framewo=
rk,
> >=20
> > I'm still learning about this, but I can give you my 2 cents as of now,=
 to
> > open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerou=
s
> > because the flash may not recover from unexpected resets. Entering one =
of
> > these modes can be:
> > 1/ volatile selectable, the device return to the 1-1-1 protocol after t=
he
> > next power-on. I guess this is conditioned by the optional RESET pin, b=
ut
> > I'll have to check. Also the flash can return to the 1-1-1 mode using t=
he
> > software reset or through writing to its Configuration Register, withou=
t
> > power-on or power- off.
>=20
> My understanding is that there's no standard software reset procedure
> that guarantees no conflict with existing 1S commands, so even the
> software reset approach doesn't work here.
>=20

The software reset procedure can't protect you from unexpected resets, but =
the=20
hardware with its optional reset pin can. Pratyush to confirm.

cut

>=20
> > Not recovering from unexpected resets is unacceptable. One should alway=
s
> > prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 w=
ith
> > the presence of the optional RESET pin.
>=20
> Totally agree with you on that one, but we know what happens in
> practice...

What I proposed is to condition the entering in the state-full modes with t=
he=20
presence of the optional RESET pin. We would introduce an optional device t=
ree=20
property for the RESET pin. If hardware doesn't implement the optional RESE=
T#=20
signal, then we will not enter in the state-full modes.

Cheers,
ta


