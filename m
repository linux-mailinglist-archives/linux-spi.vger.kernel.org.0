Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCD1E9325
	for <lists+linux-spi@lfdr.de>; Sat, 30 May 2020 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3Smc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 30 May 2020 14:42:32 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18179 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Smb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 30 May 2020 14:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590864151; x=1622400151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3X0HkmmwdYlt3B8YQ7a5lZOsqG1PbFwvQ0cBVECn3kg=;
  b=OyHD6vd8513/nDSmx+z8yeCtRPvoX7MaQKod79SwsCbDkN/ci4sVasv2
   99dXRdrPNhp6g+0hUTMADM/KCXV/oQf20XsQtWTsfs9ymIHdmBqwXoh+X
   e3Hc/S+B9vgiTRqvEs44Pk5VqdH85IxVvWC8lMLr5QD4u3Eu/zJ80Kph4
   hvikmmuQFC4u6pNNa60HUCGeozkAzhRlgU5khfPv0K+0EoFon0sSv/Wnw
   bFltcyxrm6VvmQF2/sZAYFEphuwf3h11iY98/Yp1CBrFSnrwgBmqtwLY0
   meKaLvSRbM0hRh6p2t8/+FpkzDCoQiphWuCzIivuSjqD2o64YFNWnbOX9
   w==;
IronPort-SDR: lIu9cni9mwU1E0ORGOylyPMw1OQ4+cy/7ubHowjGyplj5HIPAIC0hBgZmiRXLZLO5f286ICepz
 MvJ2Vay8lOsKvS3KbI3yPEMk3LrmCXlVJjjg262VgqgNOvClKoLRGNyUZgRttUtQbw/4SMVK80
 lYa7YNlCaooW+Rh23zRul4zNXFYVQ5hU6gKSwBnBS87pyKgM+wLcTK4u7viMa0LwoZumLghCgd
 /3CWwH7KPUvRng6c/ehthXZfuaT0ljCT1m/QFiVPfkH4C0Mts2Z6Rf/WVF/Cw1ZTK9H5t9CK1E
 K38=
X-IronPort-AV: E=Sophos;i="5.73,452,1583218800"; 
   d="scan'208";a="78368972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2020 11:42:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 30 May 2020 11:42:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 30 May 2020 11:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwlZ9lSnhf4OuTV0y+VmBMR+yAqlrZ1ULQwi/ZqHJdQ00cbnvVEP+TLr2+gN9bxYobJf+wN5X9HPghrxRC00Vt+DD5cWqLSj8no2ZM5jgQGt1tsbj3r9lowFX/tqerlpyA74ZINt6s8zf+nxGR9kvBPRaFeWXEcF1AKy+2XdpACW0S79ItG/VJl8Khds6dr6HI3cRH1fEGTa81zrY2KkzCq8J5KlqUMF0DA9nAW9fbrSHkdYpwHOEzbWd3lhOYx0ZsKSCRMzSmhwLfquBBzs455sU5Nn1h0a5gPoDnOx9BykgemQdeEnmsvrHfhZ5JMITir0A/BYjfWHdoV5+o1FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sTQKSvperSBJ1cOluezahYZ9bKqYVueX8+oKlr8zGg=;
 b=lOkjK7Bzb8J0HFZiXcUu5Q1zjmgjnptbSV1v7W5VorGfPvPbZ9wU6PEVk1hsxGT9zhByhX+0angCkuUJ1ktftlyFmQUezQ9hGXP2mtZnsQzEnAzuJsEHPPdtTwg2R//VSHDWNWNxvu5AFBYN4RFMbfW+ePVeUR8LuAlduHTj2fVdFzk4KgWvmnYKRBLAwacUVhSFWdIZ4ok+qontTW9vdsoLtPFZ2HDbR019d8I8bzLG5YQPHfs4XoRe/oEfJCiCPBMRBBj3zfu6CIl2I+DkN4e5tpGBBzIWh6y65Di9E9JnEROLUB4hor+2YgbSgZyrnbPSLU9/5vrJ1H0+R+U0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sTQKSvperSBJ1cOluezahYZ9bKqYVueX8+oKlr8zGg=;
 b=Glmjl7cCMLqK9QTP3xWNx+wg0L6NIEZIJIw4AdDZjEuxOG6UBjOBGfp/OGDhm9lXBc6lHDclfoxcftQhv2wfdCygxD4Vo1WDx7DlxRkJwcKjDQJ11fhFyBq64eTjIJuyZBqDkXHb5K7EH/T7PG0Pk9pWOW/IqzuAK4py3XvBJMI=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sat, 30 May
 2020 18:42:26 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Sat, 30 May 2020
 18:42:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <nsekhar@ti.com>,
        <boris.brezillon@collabora.com>, <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v9 13/19] mtd: spi-nor: sfdp: do not make invalid quad
 enable fatal
Thread-Topic: [PATCH v9 13/19] mtd: spi-nor: sfdp: do not make invalid quad
 enable fatal
Thread-Index: AQHWMnVIZMEYjFqkx0Olg5PzC+IdA6jA/zMA
Date:   Sat, 30 May 2020 18:42:25 +0000
Message-ID: <2267830.vuSd8QnXzO@192.168.0.120>
References: <20200525091544.17270-1-p.yadav@ti.com>
 <20200525091544.17270-14-p.yadav@ti.com>
In-Reply-To: <20200525091544.17270-14-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced1d5d5-284d-4cda-5fda-08d804c932c1
x-ms-traffictypediagnostic: BY5PR11MB4241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4241E672821EC385C242CFB9F08C0@BY5PR11MB4241.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZwxSVRrO35JyKderyiQQdXs4lq7ih00xDcQrgznTOk5LwTAQxqWpPpqc43eeIxO1NlpwnL9TiImSgPhhMcH1xtdA+nq6wvszc5Vn/JLtlZETRC5yx43PfoTJ3uCIjleFA9n5IMnekFz+xin7nQcmBErFftO/2fwOtSFZFEazy4FuB39Y8cZK0OFDRH7vWj0uTilkjnDGSD+h8D21vzGoP/z6NEaFZovWhgyiNFZAVQ+chsOcWL6DUYZaTkb/daM0ih9eC01P+S04gsrRdC6y1atrJBjIQmgv3BzDQ7JxA6waxdCS+XWLIZ0u4ezDtlTzcYTC1o2CLAOAiKFdpfXmY4hUslFooM0ubNjyPeMCGuhckyQiFCT5hdW4jFklQNL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(396003)(39850400004)(76116006)(6916009)(91956017)(8936002)(478600001)(66476007)(66946007)(64756008)(66556008)(66446008)(7416002)(54906003)(26005)(71200400001)(2906002)(83380400001)(186003)(8676002)(6486002)(316002)(5660300002)(6512007)(9686003)(86362001)(14286002)(53546011)(4326008)(6506007)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wbLTqMlkieEw4dS9HrNYsU6xXWfX6FfumzTQ+gdi+SGxKvHMXcAE6mklM7HO6cbbnQUvUzaRCK5jtY7C0yXVGxMmKwnNCJ/jQ79+U6LHFgZpWagcqBoJRJGDJuVitcEOi51bc0dg2upvYE/8f+IQfjhjRdxfdtwE/i8ckm6GPuFUJDnYhRmUw5Mq8BQ8qMDtnZy82DwgB3jMVd//Q/w3IQGKHKdI/xxTME6ZtDWmDI9YpWskIWi+kDhg7d0eek+BzPGzzwx+ugJmIkZDNCxvW7LHhex9X1Zy+ZzhGiEKVIZmpnCCLtEIFGekVXrzDtFNUWJgGKjolprhMwGcZSN9Zd19hDWBnPuzxFeDf0BgNXUgyF478sTn3+m1av5Yxuk/P+bugM9gn00Ix2Uh3l3UHq+AgSH3ZsRMAbRfSqJI7F8VbZcBlxRekjQc1pMID11PI7EeVvbGBAE7L7jvEdL9aNoMG2BsBv5IsFdGhf5vpFo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9626737D8CDCAE47BA3681563B01A1D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ced1d5d5-284d-4cda-5fda-08d804c932c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 18:42:25.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKE+ZMPzkmlQjpVc+sfcl3IIL9Kd9OomJq0OW9NEjk23cNvTDWMr/nSRbLp9gebBwZyslr9TJFdaXf+qKSh9NRzM096Vbl0B4r4ICow8O1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4241
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Monday, May 25, 2020 12:15:38 PM EEST Pratyush Yadav wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The Micron MT35XU512ABA flash does not support the quad enable bit. But
> instead of programming the Quad Enable Require field to 000b ("Device
> does not have a QE bit"), it is programmed to 111b ("Reserved").
>=20
> While this is technically incorrect, it is not reason enough to abort
> BFPT parsing. Instead, continue BFPT parsing assuming there is no quad
> enable bit present.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 052cabb52df9..9fd3d8d9a127 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -576,10 +576,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>=20
>         /* Quad Enable Requirements. */
>         switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
> -       case BFPT_DWORD15_QER_NONE:
> -               params->quad_enable =3D NULL;
> -               break;
> -
>         case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
>                 /*
>                  * Writing only one byte to the Status Register has the
> @@ -616,8 +612,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>                 params->quad_enable =3D spi_nor_sr2_bit1_quad_enable;
>                 break;
>=20
> +       case BFPT_DWORD15_QER_NONE:
>         default:
> -               return -EINVAL;
> +               params->quad_enable =3D NULL;
> +               break;

I would just add a dev_dbg message and break the switch.
	dev_dbg(nor->dev, "BFPT QER reserved value used.\n");
	break;

You will then have to set params->quad_enable =3D NULL; in a post_bfpt hook=
.

Cheers,
ta




