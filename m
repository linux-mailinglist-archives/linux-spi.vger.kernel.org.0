Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700581E9EB2
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgFAHBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 03:01:32 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:2963 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAHBb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 03:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590994890; x=1622530890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0+8FUMEi9BKsHiSzup5nhdSrUqN3fXVb5O3Z7TcXTis=;
  b=DFZ7oNwvclvhxMdFUImNejSmSN5tEO1hriSSXwrrC30+KLbDY2fhRTQg
   6wD1AhAPgcOz4iIqUnUsO/v7QUR6x6sx792G/h4LkbanEM1rdMylImoF6
   nUFm/GgUc5Mo/jgjNYpMSPqXQZw8cl6HLqlr9QCMBIXS6OauiGyHwjocs
   krVe4SXnK0ZtVTvvnTaO12CV3EzAn8gN/e0ZJOUYf4tLJGcjnC3yE/Tx8
   NvJCTjJGKEF3heBvnuJXIKgxeoMCUcs4o/de8uEh3j79jwj/QnrzxD7pl
   C5EGYnKg/Y1DeP/CMgY49mteGRfZrYW1CRrq2Xxn325tzuztQJ3xKBw0d
   Q==;
IronPort-SDR: qPVaH21Q75YRwodv2ScwzwoXjla2AmfBMHJWB9SL1Qb0afIHBO758CpJuNO6oVjIjNwajBFySa
 n77CdbPhwnNEa5xm+MJo8RPDS3zc6Slxn7Gl6PFq49isH49oBGHcmLLYswPacX3Xikf26X6LPd
 5N49zifKKGbBZN24it/b6VDiz27e7mJI29SkmVcmoRd3EoouLuAkoXlL4MAcOR0lRHH6ppNAHe
 K/AzQU8Z6uvkAZhef2GbDK16303vSCMfX4UBv1egBklI7gmCgVNAPCKvDdPVsEgVkA1Q0njfjr
 AdI=
X-IronPort-AV: E=Sophos;i="5.73,459,1583218800"; 
   d="scan'208";a="75061190"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jun 2020 00:00:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jun 2020 00:00:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 1 Jun 2020 00:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx6PXI+/2AmN3UioC/AmTxMLG0/dbDWbuXpslmBVYeMkMzB4fKBPdY0x+nv9HhsEpdB7kjB9Ml0E0dswrRFDnm1DYsYyysth0Zj1E/ThLab/uE9onHuphkykRdupE7leJF5Rxdda3Bi8nqml8VAviGS+wCIlYDa9jBmB5f2kHHsu1i3tuzfTeDyGAUN1/aXYyxTNOjBcHosJNKkfVHtb9D+uTmHbj2Uy/e3i8MhFMc4/HdEydxiVm4NJ2C1m3aQmCOPQMjsEz0FGqpGG3r8ARbgWRIHPkvLELJd/NWAEVob3Tpuw4iw8eL6Egn8noKYe+3h8MOFvoXBY873if4bKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRqymHqnXLNNfYboxhQ9KzTlcCKG7jnFiZHI2jbJDlA=;
 b=BRM4Wc/kdlJ5eZxK+xEYHroDuu9EJMO352B3xDa3NwYIROIy9i7If/5rSfPRLAlsAAYRdtQv383kCEc6EQIL+o/7YDn1hP80/iFg1c4RcGJP+8wCvxKiJds0AhLaSb8VvYEDu5oOCgMPfz4gIWbYB7Bq4sxCDLO6oQ1KBD6hUYcAL7oAPRkGeGpYfzx6zKdR6fvYBFSOhOhhtM1ipZt8xCTE7cvQm6vaF1WU8TfiLnRWwgqm415MQZGmwFUWlZx0uTUKp/qrCsngJPPMIwx5ipLl4tQ6KZa/spBaPKAL8K+P+W1ZgnHAK73jr3UTkPuEme8Lr1rNZ9lR2DBeHIxtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRqymHqnXLNNfYboxhQ9KzTlcCKG7jnFiZHI2jbJDlA=;
 b=UwXrLoleYFXq3JY/AugJ0sorHYOLtMeqSIYhacaYNN8X8L8Of4rxQFO8UIOeq6iBLQ5k3ZNRHlnjltWuy0jpYl+Bb/2HbY5C5f2rUjBbc/Q0InkTZnqqVuTYXO6XeCmy6j+H2otNo0/owrp4wXtN6ad3YZNVtfAvF87K4Ni1h1A=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4168.namprd11.prod.outlook.com (2603:10b6:a03:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 07:00:34 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:00:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <broonie@kernel.org>
CC:     <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v3 8/8] spi: Move cadence-quadspi driver to drivers/spi/
Thread-Topic: [PATCH v3 8/8] spi: Move cadence-quadspi driver to drivers/spi/
Thread-Index: AQHWN+JYwTPU7GcYXEOZEVBVNroLHg==
Date:   Mon, 1 Jun 2020 07:00:34 +0000
Message-ID: <2051214.IORyQiarUF@192.168.0.120>
References: <20200601054725.2060-1-vigneshr@ti.com>
 <20200601054725.2060-9-vigneshr@ti.com>
In-Reply-To: <20200601054725.2060-9-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa2c79d9-69e7-42ff-1cce-08d805f97b2e
x-ms-traffictypediagnostic: BY5PR11MB4168:
x-microsoft-antispam-prvs: <BY5PR11MB4168848F8DD36D0336AD6A58F08A0@BY5PR11MB4168.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEvPcbc3EUMX4heYQH+dKBSQET416vgTrXS845XA3DUmp3HAdMYGYs1QUO20AT4nDi9ntAGicxJdudcKyQaQIU7oOj6EgNeEfim7On3Di0DLxL+MoY1ITq1zmVvXV2qCmBwH097GJWny4BNs4QFfmH/eQgK7WNu47Y9GgzhFBs15jk+Rpko8VTHEVmO4aelcp4aIBBw074dbPiBRsInWV+8hQqqitV3/LS5c1bG5SCkdyHBM2pkEtcCuoavR/93/0uD8e6plzlexwAzAhAvD7Nhilvyr8iHRVDVqguN8KFmL68D9YnbzRmgR2SfMEuW20iYyibNxo1mFBaP5ACg1hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(316002)(5660300002)(83380400001)(26005)(14286002)(4326008)(7416002)(91956017)(86362001)(66446008)(66476007)(76116006)(64756008)(66556008)(186003)(71200400001)(54906003)(110136005)(66946007)(53546011)(6486002)(9686003)(6512007)(478600001)(2906002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X/p395m+m514Rtw1pgw9/XG4mDtrpVJFBVJSZywZh+DQVx9owpRh94hO/Ag18GnKj4WjGBpGSun5DnLEX66uMk8kC7LWY/oUybJNsiHNrGi3HlHXPGXFShU2mlqyIgcFLVOIxxX0IVPU30i/AFRqQHvXxBbrE6gZ31VXQnC99tU0jZm4n43AuPoOOpL1Q5eLxwE6Ih2cET+tu6Ru+SMaACrzkDVwZx7C5AcP5Xnn7RPC4ogakaAYKxG4YzLHG4MJAgJf8/3zEjvvmc9fzPdC18WYB70EYOHm+QbR8H47yeVGnhKa0ZviMnXrlHwe1QIo3oDsr6qZ9KJtnYG1mQ1tEe2ZDZbf5Fb7YdXYBN2VMnFlDurWmw70CF/1p490PctFedTsSWhFXYt2oPDhhTwi8bkjXED4ATn5Pk9HnpuHzZNkajSyXhrMuItAx7mNv7zJ3acjrrcx5NQXf3SJWUw9iw9VzXimDwz/39abEOi+vu8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <969BD4A2FE8FEA43B671AF2D528936C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c79d9-69e7-42ff-1cce-08d805f97b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 07:00:34.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI5FwlPOX7RtQ63H7J0ilDxjFB1SR2VxwrA0SKfgPu4HctwU4sXuougSfwNVvNm2LkPAFFJnG5nBsZhx8d5+VUq9ULZxGicNzACjxw/X3aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4168
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Mark,

On Monday, June 1, 2020 8:47:25 AM EEST Vignesh Raghavendra wrote:
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

If this patch set looks good to you, would you take it through the SPI tree=
?=20
If so, I would need an immutable tag, so I can merge back in spi-nor/next i=
n=20
order to fix a small conflict that will appear in drivers/mtd/spi-nor/
controllers/Kconfig. Vignesh would have to respin this patch on top of v5.7=
-
rc1. With this addressed:

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

