Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779C1CD457
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEKJAk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 05:00:40 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:63347 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgEKJAk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 05:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589187640; x=1620723640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ps9HwEIgGRmWlYbSzXCQ2wypQT0gHrWrHPwwkkx9emk=;
  b=ypirCHRsyOL3hVKZPJ+uIwNVoFMzuCcJJMXuutIJ+qBrSIdUMuhbejq+
   WtLHuWmkvEoGBMuM6nTo6C4zwYND3SPU4I1Q+qCW7f3r2y0Yyh9LCNssS
   R24vDpQAlQtU928iB9vP4q7WyKQVyv0ExA0jG6fkUvaFhRNXulM8i0NqT
   6bIXdBGUNuRvmTGf0my0cUVUJKiLQOFeOYCJVSkyskIrM3dhSc39Edpn+
   nupAt8MEIWXBDfGJhuS9mT5Q8zmOr1eQWHwdLtsJOjE3A9O7fKIlxoD/M
   wkuQaQcMi+6R48jutrJv+gJZnjnfTEXYdaPpwAc5VmBWZpdHbRglJ+mDG
   Q==;
IronPort-SDR: W7v7F3fePcC79mASEJuRUi2aeRbMisK56hJ5pb8/Z0MEMXddV04zkxIM/DS0KkHCB8cwJbfKtZ
 sOV1zFJ489f6rwxwBzRwXeU5BEf0c1MWhHj0M9HlXlZEbMgYq4KWEftTSfe7VvHAb9ZocR7E5A
 vQK/iHjprASF+UGEF62XEegOINB0ZlYuJK5FXWActVloXTDt9vD8WVD6RbqSnRjOR2UPZ+wfYq
 0ohMZzy9hrKO+rWdOvx2zVfvj+6QA9kyAhupxS7/mCAz3p1ZGbQ8rDID9o3F6TF63jdg07D4lv
 vM8=
X-IronPort-AV: E=Sophos;i="5.73,379,1583218800"; 
   d="scan'208";a="75456419"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2020 02:00:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 May 2020 02:00:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 11 May 2020 02:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA0pEtvfQ1VBJDX983Fg3TU3zWHhrVJIjdAW+aBeU4LdZcU3LhWA5VCY8F0apAB7ekGJc8tNnQorDwGeXJx2hIBoGHH4uujvDbku6hMp7mG9ECz6w+Tgo7x0/vT/97lv7XQvMmiBGHb2RUb0vlYsN1+Td457R/unU8/YcNj1n/mYzGfG9DWxYAVweWITqxtF36vrqh0OB5ALG1ibvpXu98Qc/LYWIampkwSSew/Me4JpNkYKcOHo2SSz/l8Wa0aZ5HPpnaNbvVyt0zB7ddTNg6D03pbIZVcvVgNdmjehhAuVIwgEh2KOw7os0dFmQnPn9mqzrEHzXqLmt6LweftRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps9HwEIgGRmWlYbSzXCQ2wypQT0gHrWrHPwwkkx9emk=;
 b=SyuPPHvXklve8pqkEjYn6X/RL81mnQw08rVA6Ug+lomm/NnSqzrVosQi8WTXptN8UKyjFpPS387eF4mNPJDJOHmduDtAIgpgjpaDJUtu3iGtf1kDklG227ehk75E7TY4bhDlzf6fcMAikfFaA26QkTzZ7kVc0jG9BMvrWVYntU6+rxyfK2zz+NYx6RC19NfjxqO6LiTkb2QQXUtns3LX13vV/Bid7+NYkH3UtbG7zZein8XeAQ652Mz+BCEqPpeWPdhRl/ctVJeavPvqeGD4Z2aMmz75pobZpkE7KSQlGx63MyRXm494cxrTohp+oKku6mcEJ3wB5DlqH5OHJ7QAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps9HwEIgGRmWlYbSzXCQ2wypQT0gHrWrHPwwkkx9emk=;
 b=iali1JoD7uZ/E722LD6/UB2g1aV8If9sAwbPbjidTw8ou2tI70eXhzmjcXKg4rbeNkX1BBik6Xee11Ret2v4DvKwgQ/BFRKVRt6b9IpsWUflPsPJ1wi1fXPZNUOlmMirQZz6rXfduQ1L/SSK+cm4aFGZK4tcRFgCsB2AhaiguRM=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Mon, 11 May
 2020 09:00:35 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:00:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWJ3Khn/aolf/mv0usqjltSIxTLg==
Date:   Mon, 11 May 2020 09:00:35 +0000
Message-ID: <3649933.zuh8VGJVCz@192.168.0.120>
References: <20200424184410.8578-1-p.yadav@ti.com>
In-Reply-To: <20200424184410.8578-1-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a278c0-aece-4143-0505-08d7f589c47d
x-ms-traffictypediagnostic: BY5PR11MB3975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB397506D5434693BD7B9B9E4FF0A10@BY5PR11MB3975.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUszZyRx7LcE2BjzcR/GjCjj/eYzbWgHZuuwW7HPlMLgV93zX9ntVFj1+k+rCSx6FzwPZGMSMMgcCArZmixOrwE0kPrIVf6wF+xrCgeO2C7aLnob6P0IHJ77bfk2G4xq9/Lqs2ju9V0p6PRyoxKit5auds9ABbIzLESL/0etR+9W6MY2ZwZE5sVMvnE+sVbuCBZYMGI1MoczUIlwj6ruO4loWmSkfsYW+g89AxWvVmmd6+cm8sGc5sX0WItZQJ3q6SkhOyVvs/x7MvYrpa/IeysVRX0GU8+HnfwdVKe6rvi0MzI6yD69zCv+iTgsOKgRnxQMkBLytVLaGQrs9gHja6fKweEKh4aDRnpxboVr1JQNoD31lIem2TBGsNm19SxNjmLkdl3hxFOm4TfU2kqS1aNZkN2Pwj+GoTZZi9Kr+VKPiscBr41RTOZ1HlTgjFCe7tEsATA3e/R/7J7PxJkBojrrYoHqvMk9ZAc58dgv/8DnhAcpnwedYamzX3fnDFE1jBfo+Ow22H0sxbtnuTOIFqp/RoyoDgSucMq7d3VJdjc7M3wU4IclaYHBf7YgA2v2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39860400002)(376002)(136003)(346002)(33430700001)(71200400001)(33440700001)(2906002)(86362001)(14286002)(6486002)(7416002)(64756008)(66556008)(66476007)(66446008)(9686003)(6512007)(8676002)(8936002)(54906003)(5660300002)(316002)(91956017)(76116006)(66946007)(6506007)(53546011)(4326008)(478600001)(26005)(110136005)(186003)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oAUyy0pW1NzoftWqj90QzDowXKm6CDEK02CRVS12jeO6mRV8ZRlSaK9nfWq3aMyADRV14oithkK6woSW4GFIJ+ZJza85l9T9wwCb1ZLNv7jUGF2rm/AwA2ImrAWy0DmPFQqBRxWSHzFZY7a4SrnsPON0x5WC/RauFd9Wh2TgAkywn+UPA5Yv23HIEXtYq/Au6p4JU0kFNNjOelhtlXRZ7zjRmOAO6YTe3hgBQiiNowfnpPSgS5npGuHKLz1ELBZntvMEYub1iDXTKz4DnuYpbl9Q3zvteZa2CyN0GDyPfiyoQHLgWFJH3PGX9pTUMlKD7Ku13mPtcjkqzcL1z2brHu/4/g5R2a4TYG0Lj433u0PUMrqtjptNTRR9E9R/xzXtzc9jokhG9DwFQLnc0NcJoM730ttzKnM4AbFBstVT0pKw9keADyN4j1p0gt3sOF7Pu2ikYoPjmn1MnF6exVbkSzpIFoIW0kYsbj7KMU8A0U0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC1D03ED70AB18478EDAF0B070DEC3BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a278c0-aece-4143-0505-08d7f589c47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 09:00:35.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPFMgUsS60Ng6GTw35EFXYBzZNSRfKeHnUj6l6W59l0y1Yc9YdPYG0V0t3vH6gWN6QgSz44LRUraa1s0LYN3xvqpqDOfFBuMCrWJlKLW15Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Pratyush, Boris,

On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
> This series adds support for octal DTR flashes in the spi-nor framework,

I'm still learning about this, but I can give you my 2 cents as of now, to=
=20
open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerous=20
because the flash may not recover from unexpected resets. Entering one of=20
these modes can be:
1/ volatile selectable, the device return to the 1-1-1 protocol after the n=
ext=20
power-on. I guess this is conditioned by the optional RESET pin, but I'll h=
ave=20
to check. Also the flash can return to the 1-1-1 mode using the software re=
set=20
or through writing to its Configuration Register, without power-on or power=
-
off.
2/ non-volatile selectable in which RESET# and software reset are useless, =
the=20
flash defaults to the mode selected in the non volatile Configuration Regis=
ter=20
bits. The only way to get back to 1-1-1 is to write to the Configuration=20
Register.

Not recovering from unexpected resets is unacceptable. One should always=20
prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 with =
the=20
presence of the optional RESET pin.

For the unfortunate flashes that support just option 2/, we should not ente=
r=20
these modes on our own, just by discovering the capabilities from the SFDP=
=20
tables or by the flags in the flash_info struct. The best we can do for the=
m=20
is to move the responsibility to the user. Maybe to add a Kconfig option th=
at=20
is disabled by default with which we condition the entering in 2-2-2, 4-4-4=
 or=20
8-8-8 modes. Once entered in one of these modes, if an unexpected reset com=
es,=20
you most likely are doomed, because early stage bootloaders may not work in=
=20
these modes and you'll not be able to boot the board. Assuming that one use=
s=20
other environment to boot the board, we should at least make sure that the=
=20
flash works in linux after an unexpected reset. We should try to determine =
in=20
which mode we are at init, so maybe an extension of the default_init hook i=
s=20
needed. But all this looks like a BIG compromise, I'm not yet sure if we=20
should adress 2/. Thoughts?

I'm still looking into this.

Cheers,
ta

