Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6D1CF353
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELLaL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 07:30:11 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27299 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELLaL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 07:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589283011; x=1620819011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dxXmUhUPpxBKko4J3joFmmQRuvEUizeiEmBAqHTdng0=;
  b=J7dZQtzjxx2Ee0GsASYdMnYYC0AUxwUpcL1Uq2NyRnywyqf9E0kaUEAj
   w7/zZ1nOk/Dk5xou6VkeHRixH7XGSKZRdVAaUQiUTDIdfINmpDgjcNZud
   KII6fOHfFwjgJbg1m0xx4vwPxCEorfkCI0J8Ihn4peo0+pOMVnR9aowa7
   mXciXLyBUPCNedQowfRU8ummZj/soz4CnsA8c74/cT4X+Ur14YM+u4JxH
   GsTf0sD/P2bTwc1B7Qp3ZCYWRvEfBJ62VxataLbQ4lRIIvXADadzVi2Mb
   Qy/1G39ucyJ5DNNzEY12crBMej329ZxMhLArOWsoDMOeVow3ZhbC1OmsF
   w==;
IronPort-SDR: 5M8CTnBYortKXeUXnXoaWD43z8iq4uXFSiMmFNKQUa0HYmvyHUtNioYCYEmd8JhlWEvtNftJH4
 SrqbDPwYCgVgK60V47+5j9n0Eq674akHwdDbaMaSbkuMyx9l8JaLa7i0QVxtVbPOwK1AgJ3Xtj
 siQWsTSoESVTtRmFtqoDDHj4iwX9VfW1JgQ3MdG/mh2d/98k40YIzi/fFgIaTtkO9cTa/uaTCe
 g1ZUOOi5mVJSit2nkdck789HegZFbz1Gqcy9XlFyYyh4CmVKqONE6d7m9ah+BtP6WvNhX/ViSv
 n84=
X-IronPort-AV: E=Sophos;i="5.73,383,1583218800"; 
   d="scan'208";a="75610674"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2020 04:29:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 May 2020 04:29:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 May 2020 04:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC5x1LyfSHAa+XdkBuQ7lJZutuTazpgDZ8vCaUpJBR4f7d+HMrTyF93gc582X1vciVjuLxsvrD2bvaA9R4Tij01e0IIrkjdCWJo0lAbgr/QEOKw48dQoCbxPsuBjg3B3gEwmNdQFCkJkGn3+u0JkVPMX87Pf9vxth/apcOFLet+gQGmhq65YTtIVmuzkE/9mNe4TgbtoLGJSsmt5A2dVk73/xq1yJoZOfxHj18fpTRt3xW3xCkS5JZjZ/JA5kz6c8xFMQGIYXK7rszAIEBIzWHPfBhRQggU+nKxMCeDPbf00djokbgtdC3xcIXZL4GTUFuY27xDPl445vIaToBsztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxXmUhUPpxBKko4J3joFmmQRuvEUizeiEmBAqHTdng0=;
 b=CVy574zK5msFvTX0B+Tf9fnwpX/0THhSlnlMAaAZfFETAi2MkCqsQNVYKZkN4b0UEn9LNjR+1khilZRcxafy1CCrvD6xauSMs2ny+FJmyMNAMVUWKyoNPi3HjDsfMM4J4IIRocPr+o52xBEVN9NBSrugOZnJKEG+b8DnLOvXSUMEfArzfq7XiO4RAgd0JptiybVwdaf+tw+qW5gSS2Dhv8HhGytlRhZmajUhiSrNMc1XV/dhlXdrlghqiDBTezTLIFodzavb1Pcqjh+qIb0/bos3E9cuP3nfnpT+LBwzWe8Ji4Eq+d1gBGcR0cXsGdubKaNFm+5ol3haPnVSwM49ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxXmUhUPpxBKko4J3joFmmQRuvEUizeiEmBAqHTdng0=;
 b=o8ubR84TsqTKlrbeH5Qboe10KvxqaqEfwJBXK+bJSfLwdjqAU8OgMstkKZBW1flx1sRPY7Jx2elm6YrnerAS7DM25jnS0ny3UJ4tF3eCqDyupwLz9QUbtvauFfeZlNgcrtrRAVZdJWDOJi9sPBUGIie8H2SRpm0HzChxV3AHRQw=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4273.namprd11.prod.outlook.com (2603:10b6:a03:1c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 12 May
 2020 11:29:52 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 11:29:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <alexandre.belloni@bootlin.com>, <richard@nod.at>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <miquel.raynal@bootlin.com>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWJ3Khn/aolf/mv0usqjltSIxTLg==
Date:   Tue, 12 May 2020 11:29:51 +0000
Message-ID: <2352513.UHBGRE98Z5@192.168.0.120>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <144878625.o7txgtY6sz@192.168.0.120>
 <49abc8f3-5bb5-bc6d-b2ec-f14b115c58dc@ti.com>
In-Reply-To: <49abc8f3-5bb5-bc6d-b2ec-f14b115c58dc@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a709c7c3-0de1-4d26-de04-08d7f667c97e
x-ms-traffictypediagnostic: BY5PR11MB4273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4273E99AF8E2073EAD9CE1DCF0BE0@BY5PR11MB4273.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Gv0WOjS+9tYsBLjdISMnxZsyY9Jv77VM6xy06AZZ2r/iQweAreCiYPj1OD0Y1KVSgxXez0ct8CfAwH4VGxWsy/Y6ywKy4lle/0BoGtmwE2n89iOdB432vGOQqUOi7LKvFFRujIhfPxnnNg/mH1UUa+W58+xPayZGnJZ5+6GrS5ov4GEVL5wYCqyj9XYI8GTBw0iOycX5tadsrSs4LQ6bpH2TmkUmG93hFs7v9TbnCNYPCkaJW5ss/dRs4XRb8JGVZI1tfxFoyL83TjAu4W4XaRaywtvIZwraDNgTDUd/837dHa2iVTvi66Sgn20jWz3gbsjLcq3dE5nku3aSAKD93Ze9F/rDpHZt38j4JzreiKi1/t23jatdq240cicqNIZjhALrwbcPi/jQ1+MUClLJ+/P2SKq5KQ5Sqovgew0FUy+gmR5R+8D0URZHZk1MWN/U/1a/9ExNazNJrgd/u+tgrCB0UZCXxq1Iqze/a0kKKklwMpip8sfQvsVKV8kzRnTdfiDcrqdD3g10OaBfqD3Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(33430700001)(6512007)(9686003)(6506007)(8676002)(53546011)(54906003)(6486002)(316002)(26005)(186003)(2906002)(14286002)(5660300002)(33656002)(86362001)(71200400001)(478600001)(4326008)(8936002)(7416002)(6916009)(33440700001)(66946007)(64756008)(66556008)(66446008)(66476007)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0z/9iDby6r1RomoUT3gx21JWxqrI3EYVWQLLFJi8jVtrhXxxYhJos+kiyjBaBuEbINB7Yut+1BS7RYLATStFiQVB9Hin/yGEDQyngsglkEtxCWTVWVi4YKOGQuoGnb8vuUit3LGMWu+PqKJDElC6o+7yDUXIlDZpl+VhBVhekW5ZKRH+BQ49coEQQAwSekBerkdd2FHBG53rPS7ajcOoTPhYgQOnJ8dQHomtZWqg66ncY370sDG7HP/7JksGO+tF0k9iu4FUY7ouza4eHorXs1HPwyH/2AyYa7HWSAogyeskJYgVLBC5ve4+MgY0s6xh+Bt22Q+8vqguJOTtvs/4VMAP1F8bzIB02UuUT6uaOfSCMnH6fqXBVH9gDW5BocI20gY5pNGobcCosEpocvCPajZR/Vy8jes95mJN+xFTgJPxQLAM+jC5Iyh4UOxEbfPpuxYSptFI4+zPWMpaxHRwvlEA68SdrYIYg0eG40A1Wa4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44CDA89EFFB0AE4D9EC0B1C246CED218@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a709c7c3-0de1-4d26-de04-08d7f667c97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 11:29:51.6335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z468bkByZ2ePhuJQZSoQnWSjgQw18GCKblKph7YUtgNcrIkd4qfNYzyvlkusdQlQo+RfuO6hymhUdA/Yok6xr7p3AkyyGTNx11Oj901DsjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4273
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Vignesh,

On Tuesday, May 12, 2020 12:49:07 PM EEST Vignesh Raghavendra wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> On 12/05/20 11:46 am, Tudor.Ambarus@microchip.com wrote:
> > Hi, Boris, Pratyush,
> >=20
> > I stripped case 2/, we'll not treat it for now.
> >=20
> > On Monday, May 11, 2020 12:27:12 PM EEST Boris Brezillon wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>=20
> >> On Mon, 11 May 2020 09:00:35 +0000
> >>=20
> >> <Tudor.Ambarus@microchip.com> wrote:
> >>> Hi, Pratyush, Boris,
> >>>=20
> >>> On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
> >>>> This series adds support for octal DTR flashes in the spi-nor
> >>>> framework,
> >>>=20
> >>> I'm still learning about this, but I can give you my 2 cents as of no=
w,
> >>> to
> >>> open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is danger=
ous
> >>> because the flash may not recover from unexpected resets. Entering on=
e
> >>> of
> >>> these modes can be:
> >>> 1/ volatile selectable, the device return to the 1-1-1 protocol after
> >>> the
> >>> next power-on. I guess this is conditioned by the optional RESET pin,
> >>> but
> >>> I'll have to check. Also the flash can return to the 1-1-1 mode using
> >>> the
> >>> software reset or through writing to its Configuration Register, with=
out
> >>> power-on or power- off.
> >>=20
> >> My understanding is that there's no standard software reset procedure
> >> that guarantees no conflict with existing 1S commands, so even the
> >> software reset approach doesn't work here.
> >=20
> > The software reset procedure can't protect you from unexpected resets, =
but
> > the hardware with its optional reset pin can. Pratyush to confirm.
> >=20
> > cut
> >=20
> >>> Not recovering from unexpected resets is unacceptable. One should alw=
ays
> >>> prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8
> >>> with
> >>> the presence of the optional RESET pin.
> >>=20
> >> Totally agree with you on that one, but we know what happens in
> >> practice...
> >=20
> > What I proposed is to condition the entering in the state-full modes wi=
th
> > the presence of the optional RESET pin. We would introduce an optional
> > device tree property for the RESET pin. If hardware doesn't implement t=
he
> > optional RESET# signal, then we will not enter in the state-full modes.
>=20
> Are you asking for dedicated SW controllable reset line or just an
> indication from DT that OSPI reset line is connected to board level
> soft/hard reset lines?

I don't see a need for the reset line to be SW controllable, a simple=20
indication from the device tree should be enough.

>=20
> Mandating SW controllable RESET line is bit of a stretch IMO... Board
> design may not allow wasting dedicated pin due to lack of GPIOs perhaps..
>=20
> For eg.: TI EVM has OSPI reset line connected to board level reset out.
> This ensures any soft/warm/hard CPU reset will trigger OSPI Flash reset,
> but there is no SW control that allows OSPI flash alone to be reset.
> Isn't such a reset mechanism sufficient?
>=20

I think it is, yes.

Cheers,
ta

