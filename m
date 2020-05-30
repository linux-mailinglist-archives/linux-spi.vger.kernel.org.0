Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386B21E91E6
	for <lists+linux-spi@lfdr.de>; Sat, 30 May 2020 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3ODh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 30 May 2020 10:03:37 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61653 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3ODg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 30 May 2020 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590847416; x=1622383416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VG5uN6J561ZKiYZwCThBO61QXUqjf5b3Ws8+A5ojabc=;
  b=eCtbHuy6b9eShXBvb9n9z2tZRqRqdXkqVKzhdpy17zjCMDAD7OK5dckj
   a7ShosVI9ytnf3Z/daqKm9E+oH1Ct+POQqkrnTvrM6rYWizxhZ7Rrs54j
   SGrk5nwDUZ3Mu3El+Fj5xYk+JOcZRkeG2BFbaJU0MrpAI3B6nnGef9WDN
   S+enuR5m2A9QIO81vpu6gUuda7ffwOvZ762qXj2q7HAnNLSpBdzSVLBaZ
   0rcGjIm2RTkUkphLvkV07r4G9LYiew/gZbY/m/WdgJBtVxAMiFlktESPP
   EGkmIWgG1/v0V1De6y1hh8Kw+EHTPOVunFmPB5qPg/2xSKkEmtZ7fryun
   Q==;
IronPort-SDR: yBsgqNVf7eGdfIWzQs0IVcaEa7dfqHMDkgMFmI6iGMONa4p1gqzy1X4nCT0BHao3g0obD+W0NS
 kbZbFedolo5LJZ0FmmE4Jt7VD2fdh88nwIb/pl7V6gzt5sL/KfZ/jrD8esagnsTWcPUVhpiYnR
 +zboP6Ib4VnAGZQiKWgimJtOX1Q/ol6Xs1RUPqK9VfmuOuDt5+0x5gX1RJYlv3/dq1Sj9VStpk
 zt/kYpxwVKnlS2Czh3/qFsyl2GjUGW0tPQ/mjkW872u92JKNP4Lw7J1qWg1h5jJVtLYCGnYIlz
 Gps=
X-IronPort-AV: E=Sophos;i="5.73,452,1583218800"; 
   d="scan'208";a="14043703"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2020 07:03:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 30 May 2020 07:03:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 30 May 2020 07:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuM/FnuCY9M7cS/Nv7vymXKX5th4/cs7/8bjikn+leGvBdW8SIMVy+atJRSz2Iht2SvtxOAjtgda1LRt5V3/kRd8/gj7+PHS7XSt1pGe+uj4D8FEvnsmDvqOzpD2sUvUMaXfRizec3h/8vxv3nd7ehtNO22NufhOcriYOBeqRGI18YFLPHOTB51EOogDXqa2+kq7MFJD85wejslHkDokBJPfaUhjQxdx3JEw4sXFzV49QIJbSd/0lvoXxMtvWddGP3O7YMbDRxKMeOp+TwrJK1jiE/PqXhSFylc3EoIcg75rJ8lAHmO8d4l8cFjlO3TiBpNdAkdbjWGISm7hwwI3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raEiasbuFtnxfFGFVPtdn+Hj/et9KNzzOdkA2J++NpQ=;
 b=NIlKQKAkCk8wye+gXhifPleEEkrB6BGuz5l17eUMTf/T6fhaO1CeNU23XgPGA/F9AfCA1PdUThFK0y6JxwJuPvNJ4r5nNoslgBVEKttmCidMzsqwotAOAwXyxBL/KExdqW/qBW5IBGjgvKKB4tUBhUYSo3BuvV1L4QYgAOHDd/ktAGVYXyybs+g2a96/qTBFGwCsr+LaTmjyGKkkShjKomF9OrwImSU9nieXXm49W9dy/djZt2OwmMI33eX17hh5EIW1YPHi83HP3ec8QGVUQGdZPYp/yHVQzTNoQUqGkJMvxUi7vcBWdn0jKvlC1IlY7CDyz5Y8yfUvuM/dgKhZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raEiasbuFtnxfFGFVPtdn+Hj/et9KNzzOdkA2J++NpQ=;
 b=F+YEM45pA1z+eBO7o1c6MWANzhE8bsSOIQobqXSmpubpzRiHlWN8PPV9fa387Tnc8y3n5NrouLyq3xK4AI+V1Nb4hwIHtscihiRXIhcsdu7ufCig1Wet7dezERaVvwIlJWw2ZUMm1dpdJPbP3Bg3AKWlOoXQ+hw6Ij+q1h9VeXc=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4120.namprd11.prod.outlook.com (2603:10b6:a03:18f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 14:03:17 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Sat, 30 May 2020
 14:03:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 6/6] spi: Move cadence-quadspi driver to drivers/spi/
Thread-Topic: [PATCH v2 6/6] spi: Move cadence-quadspi driver to drivers/spi/
Thread-Index: AQHWM0FdEOiVAVvaCEy6tJOJa4r5MajAr52A
Date:   Sat, 30 May 2020 14:03:16 +0000
Message-ID: <3126407.cFKMuZumrP@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-7-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-7-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf300e9-4de1-473a-fe7e-08d804a2339e
x-ms-traffictypediagnostic: BY5PR11MB4120:
x-microsoft-antispam-prvs: <BY5PR11MB41202B9F983572378631C947F08C0@BY5PR11MB4120.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3I7//G4GuTz3ByrXNi4mbPevh5Z2tPhPmDFLv3i8VU7T/63giDclGlm59JeF/2+szIC826hue5LU+JaLYZEL5iqOURxoaTzLC7rYtHdyKIRlP72eqRaZBdoKitZBCsiqyh9EBePBLm4wnhwmml7McqPgPXxWfM4PeHjsqPL7bfhYxCkboghggb95tHimRQQzq3enxuBu7ajW6gIC4xFP/e/YeZgF5eJJMmyNkh4VchqFCqTmr4EYJGlTsQT/5PB5CXAY9HZLfoPNaFs/elqHAb9LyHm6km0e3DGZNjqd46RNI/3WXT26m4lXQbEESmIZgBLniyZTdMMWZbIk6yEc0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(26005)(8676002)(4326008)(6506007)(14286002)(66556008)(66946007)(66476007)(66446008)(76116006)(64756008)(6486002)(91956017)(7416002)(8936002)(5660300002)(316002)(71200400001)(54906003)(86362001)(9686003)(6916009)(53546011)(478600001)(6512007)(4744005)(83380400001)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q2t2SDyVy9LGXvyANiW6JUPrWylXo8qqorcZtEDRISX3+H1Di169Pgzj+79rb12rsDe0OfE3ArJkgOhhokDTo1xM1spDs50TQgmbsqZyQOpdp1ZTZseFykcEHS86t6Rde/y+CgT0CIUWtGPyohhWjcdgRKlRoTUhZWIoluyK+TzoHcYZWZ+JyEGzQH+vXdTfy6PKRqzVVurW+mERzUx4kgDwDWxAp8DmktLlsKbjFY5uWidIu2LbNAZoGyFutU5hdz+OklLnfm94uUJH9TXu6OsAQcxBquiR9W8FOxNmIvOSwGPyrXaEVlKKDjyluO54NHWCqw4XZIkNwJEOk/jaSdC6cgV4Cw4l9XcT7dN4W0pXQHG5eNW2H9b8/Xpv4urvM0UU+3v45Jim6MHgPH5AecOEQ8W2XBMZXtgw3nQopFj9e/rjVAOgDlZSLrP9gzIB5MS0gPd3p8o0d8LTqzu42D00+7a9PTuEIj6geXbKoVs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D790C2BA81B0094B8C1E8B975CC4F029@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf300e9-4de1-473a-fe7e-08d804a2339e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 14:03:16.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRb9wLAPKtmnHrXKVCnjG2WwoDDua+9rotRx5vzn5kWj7I4IRiUn5vAVGEA7MBK6VNHACI4Ygqyj/eN1w4WHb/QjcWVCfrCqJ4ie7pKhsuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4120
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tuesday, May 26, 2020 12:36:04 PM EEST Vignesh Raghavendra wrote:
> From: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com>
>=20
> Now that cadence-quadspi has been converted to use spi-mem framework,
> move it under drivers/spi/
>=20
> Update license header to match SPI subsystem style
>=20
> Signed-off-by: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com> Signed-off-by: Vignesh
> Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/controllers/Kconfig            | 11 -----------
>  drivers/mtd/spi-nor/controllers/Makefile           |  1 -
>  drivers/spi/Kconfig                                | 11 +++++++++++
>  drivers/spi/Makefile                               |  1 +
>  .../spi-cadence-quadspi.c}                         | 14 +++++++-------
>  5 files changed, 19 insertions(+), 19 deletions(-)
>  rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c =3D>
> spi/spi-cadence-quadspi.c} (99%)

I get a conflict when applying this on top of spi-nor/next.

