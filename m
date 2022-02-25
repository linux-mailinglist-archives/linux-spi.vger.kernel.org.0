Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC84C3ACD
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiBYBVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiBYBVk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:21:40 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609F20D52C;
        Thu, 24 Feb 2022 17:21:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgBulmk6MTGsrRjPe7zvFnnlkemGddgBPxN1pq8vSkHOlQi4w69rVO9JNkz7DPVF1wQLDNIJRPGjJNEirqiCK52CSxwrlVh4GjWTYFfTvfs2N1YrTy9aqkdHlhu0wzmzrnW/Pb+bwdSn2WsCzDje59qljlba2JXyToO0+EIUR2533phT0el0mJpeLBY/mz2yxqiB29W0fih6tK55EGPr+KjBHmWOB46VVxW0VyTvER1yV+PoCx2lq6UpoJkDHcKhUfvUuCASy6Yx/J/DDzSrMLq3H5j5nC8m2mNYBDDfFLlRk/eulLXN5UTy09meTt0YkjoA5veR0UZdA4+RBqvnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3LYaacVYr6i4WlY4yoFwM4WhCDgCd1ZLdRWT1Afs4U=;
 b=a3fMK3CIhhPGxNmoo3tVKAJu/+cdITHJKTzADQRQ0HOfZk2xZclLwgKD0gHQVz/TO64y7mFchBx/SAQ+x7myuRwCUvZQpCmvKCjMOz/5CPtePP/3/DpmvkKjDiAFqP9cb3EURKY88Tv6rzyfnRo1IkIYY+z+xzB+/mHtkMYNxHExBGcL+yj0Tug8wxNtERMivc7/+49IF8Qtb8fSOJElhNkqdL93R0rMQEdwdiRO15W6VAhmy4m1oCAQqcIgvuirzI5fTDosC0F4hDQUaXMmOzYNMFLLdvP9gUbvlIygDMYjMd7Cs9MEDh/hOQd3YBamHxiXxCr/S9vO97Au6E6g+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3LYaacVYr6i4WlY4yoFwM4WhCDgCd1ZLdRWT1Afs4U=;
 b=QHnDSluQfrMbLwPi8MaCwox494ukl5tzj9xlgkhHygZEhsps+FTIGidR1fORAPSQgxGHMDynlkqaqmGGGyThi8CSRqZ8yNyHOwVwVWomTjU/ZbNO8FfVEufMj4ycS0c1QgKYpO9ERvSFJ4tv8avhIyUbHy5e2bbiz/7u0qVRYMY=
Received: from LV2PR21MB3181.namprd21.prod.outlook.com (2603:10b6:408:175::9)
 by DM6PR21MB1388.namprd21.prod.outlook.com (2603:10b6:5:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 01:20:57 +0000
Received: from LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::bca6:7ca2:7138:f083]) by LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::bca6:7ca2:7138:f083%6]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 01:20:57 +0000
From:   Dmitry Antipov <dmanti@microsoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dmitry Antipov <daantipov@gmail.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 5/5] HID: add spi-hid, transport driver
 for HID over SPI bus
Thread-Topic: [EXTERNAL] Re: [PATCH v3 5/5] HID: add spi-hid, transport driver
 for HID over SPI bus
Thread-Index: AQHYCckHTs+InSP/zk+uTQtR6XaGZqyjs18w
Date:   Fri, 25 Feb 2022 01:20:57 +0000
Message-ID: <LV2PR21MB31817549780382A0DECF6613DA3E9@LV2PR21MB3181.namprd21.prod.outlook.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
 <20220115023135.234667-6-dmanti@microsoft.com> <YeJOd/1+vCKN/VXU@google.com>
In-Reply-To: <YeJOd/1+vCKN/VXU@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47011c21-78df-4047-8cbc-57482c610614;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-25T01:03:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a19f053-cee2-4392-69f1-08d9f7fd136a
x-ms-traffictypediagnostic: DM6PR21MB1388:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB13884B40511B2EC762D1CF03DA3E9@DM6PR21MB1388.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxLhJJNmGbonEnlx6JpS7zesZil2D5EqNhSuFtC7j4h7L8S8yo6Up5HcdSXSwEYB6kSjMtSHKD7C1z7uKcs8OHVvbEJgbri1sqtAKVf+GodtxvA/6lhwzrMrND1nyt+afzv72Mb2POfFqjH9M9wF6G397xgXxpUIykcOpwEWASV66lNo6Tp05djlYvpvr+Kdyvf1adoKYCGxQarN/lQ9tFqHEVdbbLFpVJocIVGjxkitX2veIVEyjssCmvoPC13SE1we5o8L0BL02RLjlefI364/wfbNcam7bgkACOUSKtP17rhrdSXLO1h7Y7CKvt6erKfK6T9n9mQIwJxDe29tKrUGwIj3ZDDMi3zlNgbU0hhS4gBYw/AEDzBEcqXm7e6AFaucaJurAyOdtbZP2CNRpdjx3VMvE4m9qhox6tkGbkHRK4aWkVzYccoXeIm9PRRBhGh/5SPtdWlU5lEuxH3S3TOz9Za4R865A+s/H7T5zrvDJnSWoW+YOoOrauuliRa32t28kSQANgmlsZa46g0aHh9q1r4dRLD5WFcTGZRw5rP4Iu4NnIe+MG97w7DP8kV3F9wlYhoDaZ2rwe9xZMMh5Q2sMjJNcyFpcDgwncj++DzH9aPAzis+mdgOlS+Vz//eVDkhLCbimPtlhtRo79gXYAYPrqcIdO4/TkSHt5nLGqJhVG/zaqA3/3U/2cApaUVmeAa0EiUmlmH621L/7qdKmqEVyDt1MeSL82QFyWgc48h+C34RyMRGVQeLraqN/NHN3qo+yMuwjpQAe0ivGmADbKD4ljyykCSMC/0cXp1TA1S3SeOSZ+ZYc+qSqBNcGzRzrU+4VAQrZfCIK87j8byPIqVkBbXYv43uOsRzP+utUgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(30864003)(2906002)(186003)(52536014)(9686003)(8990500004)(66556008)(64756008)(66476007)(8936002)(53546011)(6506007)(55016003)(86362001)(71200400001)(508600001)(7696005)(122000001)(33656002)(316002)(110136005)(10290500003)(38070700005)(38100700002)(4326008)(82960400001)(82950400001)(83380400001)(8676002)(5660300002)(54906003)(7416002)(966005)(66946007)(76116006)(66446008)(2004002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4DnFBxm2EdqE2TmL0tuWjezo0muIsjZMNCyF2Mb/ap6oMOpZTKJn46JL4TJ?=
 =?us-ascii?Q?DltG9323I/pGj4oJ+sSsLTBcqYUejBF/5L9QwzcvfiaA4BnaAkodgA9QkFLj?=
 =?us-ascii?Q?hJcK+W/OOiE9D25t/X6+wzyG7H+XpdyO0lwDUL/LOZjM6WOu0I/23Ynlp8F0?=
 =?us-ascii?Q?n0UN/fL0dN0atE/4OtYXP6hGMOM9E8W7xNLetHk2k1991OdTsnbFECSLn/Od?=
 =?us-ascii?Q?R5/TUWaxEPla+G8DYXxLbjcVuEcFTPrvSmLM5J+aTosAAD0rITQiqictYehk?=
 =?us-ascii?Q?hDcm2EWuPDSppJqet7l9jCpyrVlD9X1BUy9LCoOtJE3r4I8+wfFL78iHSyq6?=
 =?us-ascii?Q?KxwUpuSsssKgdLQsskZipdtmeBfhqBsKdPfbG0L9jTVlkjfqgsTI4RjLOy6j?=
 =?us-ascii?Q?NlPv9137f58l3nnATysXAlTZbRwSjTRut/PDueyp4/UaCW0GbYLvsIgALAVn?=
 =?us-ascii?Q?RBgQWPj1F67DGgwANGGtalT/u939x7YJtCbw5WowcN4z2AU3X+9Rr8Lri61T?=
 =?us-ascii?Q?dnlJSXICNpFQHIqZ3JMcT0tyVfeIxKsGM7Cds53ZkMbDco4NzeQkfFmSIuAi?=
 =?us-ascii?Q?1Gtdb+bYgeEJ5xo2HFEb77b6QP8q3uhqezuWuyMAP8Zeescvs6Fkwmyv7Kp6?=
 =?us-ascii?Q?sUNVWwuybEEeq7PYJ8pDFiXnJvRmi1jm/tWTCAyz2CKATqJIghK7/2NRqFK9?=
 =?us-ascii?Q?Jdi3kMdQDBkbpzPcj8sy0yEH/GzbHSxCvMH1am4NRgKu0wjEWIBSzPS/kTly?=
 =?us-ascii?Q?gY9VsN7Uzp+z31B34wAsIPtJT4RerzD/fU/OybB9dvwU6BW/BSu2n97Y4MoY?=
 =?us-ascii?Q?3zctiKWIgm0/ftOkBDpiHJi5ixmAmI2uZW0cLTvVzeNjW0mLuarpe8GSLVCX?=
 =?us-ascii?Q?anL3sOUiOVFXdeYUKsMXc93wXbxpoUyKNvut5gxVXzPr6grGLq6O4ArH/0Ol?=
 =?us-ascii?Q?Sct9wDuDr8/Z9scWCwUTwYV5+6KtB5Hh+MlunIDH3WlMLK5U2ccnM3SZZC8x?=
 =?us-ascii?Q?EjjA0QUMbZtLriNEZqNzhC7QaZSZvi8IFH//lA4PnOzTjaN+Kv1CuART5z7z?=
 =?us-ascii?Q?fqW8H/Yt+OBiXKCO+Qsqcb6SyRoyevwAPWfDRcLtwdJ1vo4rXtViIMB3obIX?=
 =?us-ascii?Q?uUKlQ0zZm42aChuUUFmJZQMd48CRbH+QNsjgsh+mIQtzRHkPvAPBmZqNsONk?=
 =?us-ascii?Q?lxTuw0KpYj14ixQDgin+zfoEEH5dKQIEV0Qw3aZIKtFpPjfb6bffd+AVUNQJ?=
 =?us-ascii?Q?BgGJJ/Z/M0LjOH/a8VhE/65EWsv5VKGdpcKL1h9MLb6HqbfXl+eufZGKf96y?=
 =?us-ascii?Q?X/e7H5eG1HMDUJAa3IPIzTKayf1CBFAcczYGEUJ6qA+5LatZC1pi1m09LouM?=
 =?us-ascii?Q?+serMVVSab8wzO2WkCR8UOHBanaWcaZrzJWcHF9Zx+SfjSQ8CliEJpQMsaVV?=
 =?us-ascii?Q?uMk9reXivQ5P7Qy+1WVAxY/Z0zhAbu16/CO48AF+CGIR1zRPbG8H9t0nFGqs?=
 =?us-ascii?Q?/5faRupGHJLgEbOTo89a7uGwvj8RbhTMt7uvIe3r38ePuCE6N9rLSsSLW1+/?=
 =?us-ascii?Q?JbceYi6u29grW8TWYS/2mNd64iF/GWngr1j9Z/RWzHci4xHwMA/s6/UwXYfN?=
 =?us-ascii?Q?Zdp88m2YLfnUHiPvs3Wvg+g2huQ91jqDn4WdiCY/DHXUc3IOTZ/W1/EgtHyk?=
 =?us-ascii?Q?btBy3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a19f053-cee2-4392-69f1-08d9f7fd136a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:20:57.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8cGBA4Rayz/a5AfSRHO7ERhJMjEuTaO0kxsCJttIA/BIle/qOlVs4KXx1ZxHKXADKobgc+FLbx8RnmYr2QOcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Dmitry,

Thank you for your comments. Most of your feedback was incorporated into
the v4 patch that I just submitted. I appreciate your help and apologize
for delay in my response.

On Fri, Jan 14, 2022 at 8:33 PM, Dmitry Torokhov wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Hi Dmitry,
>=20
> On Fri, Jan 14, 2022 at 06:31:35PM -0800, Dmitry Antipov wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
> >
> > This driver follows HID Over SPI Protocol Specification 1.0 available a=
t
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.m
> icrosoft.com%2Fen-
> us%2Fdownload%2Fdetails.aspx%3Fid%3D103325&amp;data=3D04%7C01%7Cd
> manti%40microsoft.com%7C33c7f0f39c9349ef7d1d08d9d7e01d17%7C72f988
> bf86f141af91ab2d7cd011db47%7C1%7C0%7C637778180034947738%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3D4bdVX7cTKLt7dDBxxsrs3EG1j8k
> BE6h6dBWncpwH7EI%3D&amp;reserved=3D0. The
> > initial version of the driver does not support: 1) multi-fragment input
> > reports, 2) sending GET_INPUT and COMMAND output report types and
> > processing their respective acknowledge input reports, and 3) device
> > sleep power state.
>=20
> The driver does not use threaded interrupts and instead uses a lot of
> work structs, which makes it very complex. Please consider switching
> over to threaded interrupt handler and see if some of the work can be
> done in-place, I believe it will simplify the driver significantly.

The v4 patch that I just submitted uses a threaded interrupt handler
and spi_sync instead of spi_async and is a bit simpler. The four worker
threads are still needed and their work can't be done in place. Three of
them (reset_response, create, and refresh) send sync_request() which
requires an interrupt with a response to be handled. The error_work one
toggles power and would be racy if done in-place.
>=20
> More random comments below.
>=20
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > ---
> >  arch/arm64/configs/defconfig        |    1 +
> >  drivers/hid/Kconfig                 |    2 +
> >  drivers/hid/Makefile                |    1 +
> >  drivers/hid/spi-hid/Kconfig         |   25 +
> >  drivers/hid/spi-hid/Makefile        |   12 +
> >  drivers/hid/spi-hid/spi-hid-core.c  | 1328 +++++++++++++++++++++++++++
> >  drivers/hid/spi-hid/spi-hid-core.h  |  188 ++++
> >  drivers/hid/spi-hid/spi-hid-of.c    |  148 +++
> >  drivers/hid/spi-hid/spi-hid-of.h    |   34 +
> >  drivers/hid/spi-hid/spi-hid_trace.h |  198 ++++
> >  drivers/hid/spi-hid/trace.c         |   11 +
> >  11 files changed, 1948 insertions(+)
> >  create mode 100644 drivers/hid/spi-hid/Kconfig
> >  create mode 100644 drivers/hid/spi-hid/Makefile
> >  create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
> >  create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
> >  create mode 100755 drivers/hid/spi-hid/spi-hid-of.c
> >  create mode 100755 drivers/hid/spi-hid/spi-hid-of.h
> >  create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
> >  create mode 100644 drivers/hid/spi-hid/trace.c
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index f2e2b9bdd702..25249a4b0c8a 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -805,6 +805,7 @@ CONFIG_SND_AUDIO_GRAPH_CARD=3Dm
> >  CONFIG_HID_MULTITOUCH=3Dm
> >  CONFIG_I2C_HID_ACPI=3Dm
> >  CONFIG_I2C_HID_OF=3Dm
> > +CONFIG_SPI_HID=3Dm
> >  CONFIG_USB_CONN_GPIO=3Dm
> >  CONFIG_USB=3Dy
> >  CONFIG_USB_OTG=3Dy
>=20
> This chunk does not belong to this patch.

Moved to a separate patch in v4.

>=20
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index a7c78ac96270..cd2c10703fcf 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1262,6 +1262,8 @@ source "drivers/hid/usbhid/Kconfig"
> >
> >  source "drivers/hid/i2c-hid/Kconfig"
> >
> > +source "drivers/hid/spi-hid/Kconfig"
> > +
> >  source "drivers/hid/intel-ish-hid/Kconfig"
> >
> >  source "drivers/hid/amd-sfh-hid/Kconfig"
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 55a6fa3eca5a..caf418dda343 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -144,6 +144,7 @@ obj-$(CONFIG_USB_MOUSE)		+=3D usbhid/
> >  obj-$(CONFIG_USB_KBD)		+=3D usbhid/
> >
> >  obj-$(CONFIG_I2C_HID_CORE)	+=3D i2c-hid/
> > +obj-$(CONFIG_SPI_HID)		+=3D spi-hid/
> >
> >  obj-$(CONFIG_INTEL_ISH_HID)	+=3D intel-ish-hid/
> >  obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+=3D intel-ish-hid/
> > diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
> > new file mode 100644
> > index 000000000000..37302d658162
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/Kconfig
> > @@ -0,0 +1,25 @@
> > +#
> > +# Copyright (c) 2021 Microsoft Corporation
> > +#
> > +# This program is free software; you can redistribute it and/or modify=
 it
> > +# under the terms of the GNU General Public License version 2 as publi=
shed
> by
> > +# the Free Software Foundation.
> > +#
> > +menu "SPI HID support"
> > +	depends on SPI
> > +
> > +config SPI_HID
> > +	tristate "HID over SPI transport layer"
> > +	default n
> > +	depends on SPI && INPUT && OF
> > +	select HID
> > +	help
> > +	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
> > +	  other HID based devices which is connected to your computer via SPI=
.
> > +
> > +	  If unsure, say N.
> > +
> > +	  This support is also available as a module.  If so, the module
> > +	  will be called spi-hid.
> > +
> > +endmenu
> > diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefil=
e
> > new file mode 100644
> > index 000000000000..0d34a04b5dc7
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/Makefile
> > @@ -0,0 +1,12 @@
> > +#
> > +# Copyright (c) 2021 Microsoft Corporation
> > +#
> > +# This program is free software; you can redistribute it and/or modify=
 it
> > +# under the terms of the GNU General Public License version 2 as publi=
shed
> by
> > +# the Free Software Foundation.
> > +#
> > +# Makefile for the SPI input drivers
> > +#
> > +CFLAGS_trace.o =3D -I$(src)
> > +obj-$(CONFIG_SPI_HID)	+=3D spi-hid.o
> > +spi-hid-objs :=3D spi-hid-core.o spi-hid-of.o trace.o
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-
> core.c
> > new file mode 100644
> > index 000000000000..4d5a24613beb
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> > @@ -0,0 +1,1328 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * HID over SPI protocol implementation
> > + * spi-hid-core.c
>=20
> I recommend not to put file names in comments as they tend to get stale.

Addressed in v4.

>=20
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + *
> > + * This code is partly based on "HID over I2C protocol implementation:
> > + *
> > + *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.co=
m>
> > + *  Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
> > + *  Copyright (c) 2012 Red Hat, Inc
> > + *
> > + *  which in turn is partly based on "USB HID support for Linux":
> > + *
> > + *  Copyright (c) 1999 Andreas Gal
> > + *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
> > + *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for
> Concept2, Inc
> > + *  Copyright (c) 2007-2008 Oliver Neukum
> > + *  Copyright (c) 2006-2010 Jiri Kosina
> > + */
> > +
> > +#include <linux/crc32.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/hid.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/string.h>
> > +#include <linux/wait.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include "spi-hid-core.h"
> > +#include "spi-hid_trace.h"
> > +#include "spi-hid-of.h"
> > +#include "../hid-ids.h"
> > +
> > +#define SPI_HID_MAX_RESET_ATTEMPTS 3
> > +
> > +static struct hid_ll_driver spi_hid_ll_driver;
> > +
> > +static void spi_hid_populate_read_approvals(struct spi_hid_of_config *=
conf,
> > +	__u8 *header_buf, __u8 *body_buf)
>=20
> I think this is largely matter of preference, but usually in kernel we
> use u8, u16, etc, and variants with underscores are used in headers
> exported to userspace.

Addressed in v4.

>=20
> > +{
> > +	header_buf[0] =3D conf->read_opcode;
> > +	header_buf[1] =3D (conf->input_report_header_address >> 16) & 0xff;
> > +	header_buf[2] =3D	(conf->input_report_header_address >> 8) & 0xff;
> > +	header_buf[3] =3D	(conf->input_report_header_address >> 0) & 0xff;
> > +	header_buf[4] =3D SPI_HID_READ_APPROVAL_CONSTANT;
> > +
> > +	body_buf[0] =3D conf->read_opcode;
> > +	body_buf[1] =3D (conf->input_report_body_address >> 16) & 0xff;
> > +	body_buf[2] =3D (conf->input_report_body_address >> 8) & 0xff;
> > +	body_buf[3] =3D (conf->input_report_body_address >> 0) & 0xff;
> > +	body_buf[4] =3D SPI_HID_READ_APPROVAL_CONSTANT;
> > +}
> > +
> > +static void spi_hid_parse_dev_desc(struct spi_hid_device_desc_raw *raw=
,
> > +					struct spi_hid_device_descriptor
> *desc)
> > +{
> > +	desc->hid_version =3D le16_to_cpu(raw->bcdVersion);
> > +	desc->report_descriptor_length =3D le16_to_cpu(raw-
> >wReportDescLength);
> > +	desc->max_input_length =3D le16_to_cpu(raw->wMaxInputLength);
> > +	desc->max_output_length =3D le16_to_cpu(raw->wMaxOutputLength);
> > +
> > +	/* FIXME: multi-fragment not supported, field below not used */
> > +	desc->max_fragment_length =3D le16_to_cpu(raw-
> >wMaxFragmentLength);
> > +
> > +	desc->vendor_id =3D le16_to_cpu(raw->wVendorID);
> > +	desc->product_id =3D le16_to_cpu(raw->wProductID);
> > +	desc->version_id =3D le16_to_cpu(raw->wVersionID);
> > +	desc->no_output_report_ack =3D le16_to_cpu(raw->wFlags) & BIT(0);
> > +}
> > +
> > +static void spi_hid_populate_input_header(__u8 *buf,
> > +		struct spi_hid_input_header *header)
> > +{
> > +	header->version            =3D buf[0] & 0xf;
> > +	header->report_length      =3D (buf[1] | ((buf[2] & 0x3f) << 8)) * 4;
> > +	header->last_fragment_flag =3D (buf[2] & 0x40) >> 6;
> > +	header->sync_const         =3D buf[3];
> > +}
> > +
> > +static void spi_hid_populate_input_body(__u8 *buf,
> > +		struct spi_hid_input_body *body)
> > +{
> > +	body->report_type =3D buf[0];
> > +	body->content_length =3D buf[1] | (buf[2] << 8);
>=20
> Where possible we should use
> get_unaligned_le16/put_unaligned_le16/cpu_to_le16/le16_to_cpu/etc.
> It documents data structures better and may result in slightly better
> performance.

Addressed in v4.

>=20
> > +	body->content_id =3D buf[3];
> > +}
> > +
> > +static void spi_hid_input_report_prepare(struct spi_hid_input_buf *buf=
,
> > +		struct spi_hid_input_report *report)
> > +{
> > +	struct spi_hid_input_header header;
> > +	struct spi_hid_input_body body;
> > +
> > +	spi_hid_populate_input_header(buf->header, &header);
> > +	spi_hid_populate_input_body(buf->body, &body);
> > +	report->report_type =3D body.report_type;
> > +	report->content_length =3D body.content_length;
> > +	report->content_id =3D body.content_id;
> > +	report->content =3D buf->content;
> > +}
> > +
> > +static void spi_hid_populate_output_header(__u8 *buf,
> > +		struct spi_hid_of_config *conf,
> > +		struct spi_hid_output_report *report)
> > +{
> > +	buf[0] =3D conf->write_opcode;
> > +	buf[1] =3D (conf->output_report_address >> 16) & 0xff;
> > +	buf[2] =3D (conf->output_report_address >> 8) & 0xff;
> > +	buf[3] =3D (conf->output_report_address >> 0) & 0xff;
> > +	buf[4] =3D report->report_type;
> > +	buf[5] =3D report->content_length & 0xff;
> > +	buf[6] =3D (report->content_length >> 8) & 0xff;
>=20
> le16...

Not sure I follow, these are all 8-bit assignments.

>=20
> > +	buf[7] =3D report->content_id;
> > +}
> > +
> > +static int spi_hid_input_async(struct spi_hid *shid, void *buf, u16 le=
ngth,
> > +		void (*complete)(void *), bool is_header)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &shid->spi->dev;
> > +
> > +	shid->input_transfer[0].tx_buf =3D is_header ? shid-
> >read_approval_header :
> > +						shid->read_approval_body;
> > +	shid->input_transfer[0].len =3D SPI_HID_READ_APPROVAL_LEN;
> > +
> > +	shid->input_transfer[1].rx_buf =3D buf;
> > +	shid->input_transfer[1].len =3D length;
> > +
> > +	spi_message_init_with_transfers(&shid->input_message,
> > +			shid->input_transfer, 2);
> > +
> > +	shid->input_message.complete =3D complete;
> > +	shid->input_message.context =3D shid;
> > +
> > +	trace_spi_hid_input_async(shid,
> > +			shid->input_transfer[0].tx_buf,
> > +			shid->input_transfer[0].len,
> > +			shid->input_transfer[1].rx_buf,
> > +			shid->input_transfer[1].len, 0);
> > +
> > +	ret =3D spi_async(shid->spi, &shid->input_message);
> > +	if (ret) {
> > +		dev_err(dev, "Error starting async transfer: %d, resetting\n",
> > +									ret);
> > +		shid->bus_error_count++;
> > +		shid->bus_last_error =3D ret;
> > +		schedule_work(&shid->error_work);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_output(struct spi_hid *shid, void *buf, u16 length)
> > +{
> > +	struct spi_transfer transfer;
> > +	struct spi_message message;
> > +	int ret;
> > +
> > +	memset(&transfer, 0, sizeof(transfer));
> > +
> > +	transfer.tx_buf =3D buf;
> > +	transfer.len =3D length;
> > +
> > +	spi_message_init_with_transfers(&message, &transfer, 1);
> > +
> > +	/*
> > +	 * REVISIT: Should output be asynchronous?
> > +	 *
> > +	 * According to Documentation/hid/hid-transport.rst, ->output_report(=
)
> > +	 * must be implemented as an asynchronous operation.
> > +	 */
>=20
> I am not quite sure what that doc means. Do they simply mean that the
> driver should not wait for response from the device?
>=20
> I think that transfer (send) can still happen synchronously.

This revisit comment was based on incorrect documentation and has been
removed in v4.

>=20
> > +	trace_spi_hid_output_begin(shid, transfer.tx_buf,
> > +			transfer.len, NULL, 0, 0);
> > +
> > +	ret =3D spi_sync(shid->spi, &message);
> > +
> > +	trace_spi_hid_output_end(shid, transfer.tx_buf,
> > +			transfer.len, NULL, 0, ret);
> > +
> > +	if (ret) {
> > +		shid->bus_error_count++;
> > +		shid->bus_last_error =3D ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const char *const spi_hid_power_mode_string(u8 power_state)
> > +{
> > +	switch (power_state) {
> > +	case SPI_HID_POWER_MODE_ON:
> > +		return "d0";
> > +	case SPI_HID_POWER_MODE_SLEEP:
> > +		return "d2";
> > +	case SPI_HID_POWER_MODE_OFF:
> > +		return "d3";
> > +	case SPI_HID_POWER_MODE_WAKING_SLEEP:
> > +		return "d3*";
> > +	default:
> > +		return "unknown";
> > +	}
> > +}
> > +
> > +static void spi_hid_suspend(struct spi_hid *shid)
> > +{
> > +	struct device *dev =3D &shid->spi->dev;
> > +
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_OFF)
> > +		return;
> > +
> > +	disable_irq(shid->spi->irq);
> > +	shid->ready =3D false;
> > +	sysfs_notify(&dev->kobj, NULL, "ready");
> > +
> > +	spi_hid_of_assert_reset(&shid->conf);
>=20
> Are you sure you want to have reset asserted while the device is
> sleeping?  Is it really a reset pin, or is it actually a GPIO-controlled
> regulator?

We do want to keep reset asserted during suspend. In v4 I also added
code to power down on suspend and power up on resume.

>=20
> > +
> > +	shid->power_state =3D SPI_HID_POWER_MODE_OFF;
> > +}
> > +
> > +static void spi_hid_resume(struct spi_hid *shid)
> > +{
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_ON)
> > +		return;
> > +
> > +	shid->power_state =3D SPI_HID_POWER_MODE_ON;
> > +	enable_irq(shid->spi->irq);
> > +	shid->input_transfer_pending =3D 0;
> > +
> > +	spi_hid_of_deassert_reset(&shid->conf);
> > +}
> > +
> > +static struct hid_device *spi_hid_disconnect_hid(struct spi_hid *shid)
> > +{
> > +	struct hid_device *hid =3D shid->hid;
> > +
> > +	shid->hid =3D NULL;
>=20
> Umm, why the wrapper?

We use shid->hid to check if a HID device has been installed.

>=20
> > +
> > +	return hid;
> > +}
> > +
> > +static void spi_hid_stop_hid(struct spi_hid *shid)
> > +{
> > +	struct hid_device *hid;
> > +
> > +	hid =3D spi_hid_disconnect_hid(shid);
> > +	if (hid) {
> > +		cancel_work_sync(&shid->create_device_work);
> > +		cancel_work_sync(&shid->refresh_device_work);
> > +		hid_destroy_device(hid);
> > +	}
> > +}
> > +
> > +static void spi_hid_error_handler(struct spi_hid *shid)
> > +{
> > +	struct device *dev =3D &shid->spi->dev;
> > +	int ret;
> > +
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_OFF)
> > +		return;
> > +
> > +	if (shid->attempts++ >=3D SPI_HID_MAX_RESET_ATTEMPTS) {
> > +		dev_err(dev, "unresponsive device, aborting.\n");
> > +		spi_hid_stop_hid(shid);
> > +		spi_hid_of_assert_reset(&shid->conf);
> > +		ret =3D spi_hid_of_power_down(&shid->conf);
> > +		if (ret) {
> > +			dev_err(dev, "failed to disable regulator\n");
> > +			shid->regulator_error_count++;
> > +			shid->regulator_last_error =3D ret;
> > +		}
> > +		return;
> > +	}
> > +
> > +	trace_spi_hid_error_handler(shid);
> > +
> > +	shid->ready =3D false;
> > +	sysfs_notify(&dev->kobj, NULL, "ready");
> > +
> > +	spi_hid_of_assert_reset(&shid->conf);
> > +
> > +	shid->power_state =3D SPI_HID_POWER_MODE_OFF;
> > +	shid->input_transfer_pending =3D 0;
> > +	cancel_work_sync(&shid->reset_work);
> > +
> > +	spi_hid_of_sleep_minimal_reset_delay(&shid->conf);
> > +
> > +	shid->power_state =3D SPI_HID_POWER_MODE_ON;
> > +
> > +	spi_hid_of_deassert_reset(&shid->conf);
> > +}
> > +
> > +static void spi_hid_error_work(struct work_struct *work)
> > +{
> > +	struct spi_hid *shid =3D container_of(work, struct spi_hid, error_wor=
k);
> > +
> > +	spi_hid_error_handler(shid);
> > +}
> > +
> > +static int spi_hid_send_output_report(struct spi_hid *shid,
> > +		struct spi_hid_output_report *report)
> > +{
> > +	struct spi_hid_output_buf *buf =3D &shid->output;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	u16 report_length;
> > +	u16 padded_length;
> > +	u8 padding;
> > +	int ret;
> > +
> > +	if (report->content_length > shid->desc.max_output_length) {
> > +		dev_err(dev, "Output report too big, content_length 0x%x\n",
> > +						report->content_length);
> > +		ret =3D -E2BIG;
> > +		goto out;
> > +	}
> > +
> > +	spi_hid_populate_output_header(buf->header, &shid->conf, report);
> > +
> > +	if (report->content_length)
> > +		memcpy(&buf->content, report->content, report-
> >content_length);
> > +
> > +	report_length =3D sizeof(buf->header) + report->content_length;
> > +	padded_length =3D round_up(report_length,	4);
> > +	padding =3D padded_length - report_length;
> > +	memset(&buf->content[report->content_length], 0, padding);
> > +
> > +	ret =3D spi_hid_output(shid, buf, padded_length);
> > +	if (ret) {
> > +		dev_err(dev, "Failed output transfer\n");
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_sync_request(struct spi_hid *shid,
> > +		struct spi_hid_output_report *report)
> > +{
> > +	struct device *dev =3D &shid->spi->dev;
> > +	int ret =3D 0;
> > +
> > +	ret =3D spi_hid_send_output_report(shid, report);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to transfer output report\n");
> > +		return ret;
> > +	}
> > +
> > +	mutex_unlock(&shid->lock);
> > +	ret =3D wait_for_completion_interruptible_timeout(&shid->output_done,
> > +			msecs_to_jiffies(1000));
> > +	mutex_lock(&shid->lock);
>=20
> Where is the completion reinitialized?

Fixed in v4.

>=20
> > +	if (ret =3D=3D 0) {
> > +		dev_err(dev, "Response timed out\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * Handle the reset response from the FW by sending a request for the
> device
> > + * descriptor.
> > + */
> > +static void spi_hid_reset_work(struct work_struct *work)
> > +{
> > +	struct spi_hid *shid =3D
> > +		container_of(work, struct spi_hid, reset_work);
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_output_report report =3D {
> > +		.report_type =3D
> SPI_HID_OUTPUT_REPORT_TYPE_DEVICE_DESC_REQUEST,
> > +		.content_length =3D 0x0,
> > +		.content_id =3D
> SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
> > +		.content =3D NULL,
> > +	};
> > +	int ret;
> > +
> > +	trace_spi_hid_reset_work(shid);
> > +
> > +	if (shid->ready) {
> > +		dev_err(dev, "Spontaneous FW reset!");
> > +		shid->ready =3D false;
> > +		sysfs_notify(&dev->kobj, NULL, "ready");
> > +		shid->dir_count++;
> > +	}
> > +
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_OFF)
> > +		return;
> > +
> > +	if (flush_work(&shid->create_device_work))
> > +		dev_err(dev, "Reset handler waited for create_device_work");
> > +
> > +	if (flush_work(&shid->refresh_device_work))
> > +		dev_err(dev, "Reset handler waited for refresh_device_work");
> > +
> > +	mutex_lock(&shid->lock);
> > +	ret =3D spi_hid_sync_request(shid, &report);
> > +	mutex_unlock(&shid->lock);
> > +	if (ret) {
> > +		dev_WARN_ONCE(dev, true,
> > +				"Failed to send device descriptor request\n");
> > +		spi_hid_error_handler(shid);
> > +	}
> > +}
> > +
> > +static int spi_hid_input_report_handler(struct spi_hid *shid,
> > +		struct spi_hid_input_buf *buf)
> > +{
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_input_report r;
> > +	int ret;
> > +
> > +	trace_spi_hid_input_report_handler(shid);
> > +
> > +	if (!shid->ready || shid->refresh_in_progress || !shid->hid)
> > +		return 0;
> > +
> > +	spi_hid_input_report_prepare(buf, &r);
> > +
> > +	ret =3D hid_input_report(shid->hid, HID_INPUT_REPORT,
> > +			r.content - 1,
> > +			r.content_length + 1, 1);
> > +
> > +	if (ret =3D=3D -ENODEV || ret =3D=3D -EBUSY) {
> > +		dev_err(dev, "ignoring report --> %d\n", ret);
> > +		return 0;
> > +	} else if (ret) {
> > +		dev_err(dev, "Bad input report, error %d\n", ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void spi_hid_response_handler(struct spi_hid *shid,
> > +		struct spi_hid_input_buf *buf)
> > +{
> > +	trace_spi_hid_response_handler(shid);
> > +
> > +	/* completion_done returns 0 if there are waiters, otherwise 1 */
> > +	if (completion_done(&shid->output_done)) {
> > +		dev_err(&shid->spi->dev, "Unexpected response report\n");
> > +	} else {
> > +		if (shid->input.body[0] =3D=3D
> > +				SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC
> ||
> > +			shid->input.body[0] =3D=3D
> > +
> 	SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP) {
> > +			size_t response_length =3D (shid->input.body[1] |
> > +					(shid->input.body[2] << 8)) +
> > +					sizeof(shid->input.body);
> > +			memcpy(shid->response.body, shid->input.body,
> > +							response_length);
> > +		}
> > +		complete(&shid->output_done);
> > +	}
> > +}
> > +
> > +/*
> > + * This function returns the length of the report descriptor, or a neg=
ative
> > + * error code if something went wrong.
> > + */
> > +static int spi_hid_report_descriptor_request(struct spi_hid *shid)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_output_report report =3D {
> > +		.report_type =3D
> SPI_HID_OUTPUT_REPORT_TYPE_REPORT_DESC_REQUEST,
> > +		.content_length =3D 0,
> > +		.content_id =3D
> SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
> > +		.content =3D NULL,
> > +	};
> > +
> > +	ret =3D  spi_hid_sync_request(shid, &report);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"Expected report descriptor not received! Error %d\n",
> > +			ret);
> > +		spi_hid_error_handler(shid);
> > +		goto out;
> > +	}
> > +
> > +	ret =3D (shid->response.body[1] | (shid->response.body[2] << 8));
>=20
> le16...
>=20
>=20
> > +	if (ret !=3D shid->desc.report_descriptor_length) {
> > +		dev_err(dev,
> > +			"Received report descriptor length doesn't match
> device descriptor field, using min of the two\n");
> > +		ret =3D min_t(unsigned int, ret,
> > +			shid->desc.report_descriptor_length);
> > +	}
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void spi_hid_process_input_report(struct spi_hid *shid,
> > +		struct spi_hid_input_buf *buf)
> > +{
> > +	struct spi_hid_input_header header;
> > +	struct spi_hid_input_body body;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_device_desc_raw *raw;
> > +	int ret;
> > +
> > +	trace_spi_hid_process_input_report(shid);
> > +
> > +	spi_hid_populate_input_header(buf->header, &header);
> > +	spi_hid_populate_input_body(buf->body, &body);
> > +
> > +	if (body.content_length > header.report_length) {
> > +		dev_err(dev, "Bad body length %d > %d\n",
> body.content_length,
> > +
> 	header.report_length);
> > +		schedule_work(&shid->error_work);
> > +		return;
> > +	}
> > +
> > +	switch (body.report_type) {
> > +	case SPI_HID_INPUT_REPORT_TYPE_DATA:
> > +		ret =3D spi_hid_input_report_handler(shid, buf);
> > +		if (ret)
> > +			schedule_work(&shid->error_work);
> > +		break;
> > +	case SPI_HID_INPUT_REPORT_TYPE_RESET_RESP:
> > +		schedule_work(&shid->reset_work);
> > +		break;
> > +	case SPI_HID_INPUT_REPORT_TYPE_DEVICE_DESC:
> > +		/* Mark the completion done to avoid timeout */
> > +		spi_hid_response_handler(shid, buf);
> > +
> > +		/* Reset attempts at every device descriptor fetch */
> > +		shid->attempts =3D 0;
> > +
> > +		raw =3D (struct spi_hid_device_desc_raw *)buf->content;
> > +
> > +		/* Validate device descriptor length before parsing */
> > +		if (body.content_length !=3D
> SPI_HID_DEVICE_DESCRIPTOR_LENGTH) {
> > +			dev_err(dev,
> > +				"Invalid content length %d, expected %d\n",
> > +				body.content_length,
> > +				SPI_HID_DEVICE_DESCRIPTOR_LENGTH);
> > +			schedule_work(&shid->error_work);
> > +			break;
> > +		}
> > +
> > +		if (le16_to_cpu(raw->wDeviceDescLength) !=3D
> > +
> 	SPI_HID_DEVICE_DESCRIPTOR_LENGTH) {
> > +			dev_err(dev,
> > +				"Invalid wDeviceDescLength %d, expected
> %d\n",
> > +				raw->wDeviceDescLength,
> > +				SPI_HID_DEVICE_DESCRIPTOR_LENGTH);
> > +			schedule_work(&shid->error_work);
> > +			break;
> > +		}
> > +
> > +		spi_hid_parse_dev_desc(raw, &shid->desc);
> > +
> > +		if (shid->desc.hid_version !=3D SPI_HID_SUPPORTED_VERSION) {
> > +			dev_err(dev,
> > +				"Unsupported device descriptor version
> %4x\n",
> > +				shid->desc.hid_version);
> > +			schedule_work(&shid->error_work);
> > +			break;
> > +		}
> > +
> > +		if (!shid->hid)
> > +			schedule_work(&shid->create_device_work);
> > +		else
> > +			schedule_work(&shid->refresh_device_work);
> > +
> > +		break;
> > +	case SPI_HID_INPUT_REPORT_TYPE_SET_OUTPUT_REPORT_RESP:
> > +		if (shid->desc.no_output_report_ack) {
> > +			dev_err(dev, "Unexpected output report response\n");
> > +			break;
> > +		}
> > +		fallthrough;
> > +	case SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP:
> > +	case SPI_HID_INPUT_REPORT_TYPE_SET_FEATURE_RESP:
> > +		if (!shid->ready) {
> > +			dev_err(dev,
> > +				"Unexpected response report while not ready:
> 0x%x\n",
> > +				body.report_type);
> > +			break;
> > +		}
> > +		fallthrough;
> > +	case SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC:
> > +		spi_hid_response_handler(shid, buf);
> > +		break;
> > +	/*
> > +	 * FIXME: sending GET_INPUT and COMMAND reports not supported,
> thus
> > +	 * throw away responses to those, they should never come.
> > +	 */
> > +	case SPI_HID_INPUT_REPORT_TYPE_GET_INPUT_REPORT_RESP:
> > +	case SPI_HID_INPUT_REPORT_TYPE_COMMAND_RESP:
> > +		dev_err(dev, "Not a supported report type: 0x%x\n",
> > +							body.report_type);
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unknown input report: 0x%x\n",
> > +							body.report_type);
> > +		schedule_work(&shid->error_work);
> > +		break;
> > +	}
> > +}
> > +
> > +static int spi_hid_bus_validate_header(struct spi_hid *shid,
> > +					struct spi_hid_input_header *header)
> > +{
> > +	struct device *dev =3D &shid->spi->dev;
> > +
> > +	if (header->version !=3D SPI_HID_INPUT_HEADER_VERSION) {
> > +		dev_err(dev, "Unknown input report version (v 0x%x)\n",
> > +				header->version);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (shid->desc.max_input_length !=3D 0 &&
> > +			header->report_length > shid->desc.max_input_length)
> {
> > +		dev_err(dev, "Input report body size %u > max expected of
> %u\n",
> > +				header->report_length,
> > +				shid->desc.max_input_length);
> > +		return -EMSGSIZE;
> > +	}
> > +
> > +	if (header->last_fragment_flag !=3D 1) {
> > +		dev_err(dev, "Multi-fragment reports not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (header->sync_const !=3D SPI_HID_INPUT_HEADER_SYNC_BYTE) {
> > +		dev_err(dev, "Invalid input report sync constant (0x%x)\n",
> > +				header->sync_const);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int spi_hid_create_device(struct spi_hid *shid)
> > +{
> > +	struct hid_device *hid;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	int ret;
> > +
> > +	hid =3D hid_allocate_device();
> > +
> > +	if (IS_ERR(hid)) {
> > +		dev_err(dev, "Failed to allocate hid device: %ld\n",
> > +				PTR_ERR(hid));
> > +		ret =3D PTR_ERR(hid);
> > +		return ret;
> > +	}
> > +
> > +	hid->driver_data =3D shid->spi;
> > +	hid->ll_driver =3D &spi_hid_ll_driver;
> > +	hid->dev.parent =3D &shid->spi->dev;
> > +	hid->bus =3D BUS_SPI;
> > +	hid->version =3D shid->desc.hid_version;
> > +	hid->vendor =3D shid->desc.vendor_id;
> > +	hid->product =3D shid->desc.product_id;
> > +
> > +	snprintf(hid->name, sizeof(hid->name), "spi %04hX:%04hX",
> > +			hid->vendor, hid->product);
> > +	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
> > +
> > +	shid->hid =3D hid;
> > +
> > +	ret =3D hid_add_device(hid);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add hid device: %d\n", ret);
> > +		/*
> > +		 * We likely got here because report descriptor request timed
> > +		 * out. Let's disconnect and destroy the hid_device structure.
> > +		 */
> > +		hid =3D spi_hid_disconnect_hid(shid);
> > +		if (hid)
> > +			hid_destroy_device(hid);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void spi_hid_create_device_work(struct work_struct *work)
> > +{
> > +	struct spi_hid *shid =3D
> > +		container_of(work, struct spi_hid, create_device_work);
> > +	struct device *dev =3D &shid->spi->dev;
> > +	u8 prev_state =3D shid->power_state;
> > +	int ret;
> > +
> > +	trace_spi_hid_create_device_work(shid);
> > +
> > +	ret =3D spi_hid_create_device(shid);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to create hid device\n");
> > +		return;
> > +	}
> > +
> > +	spi_hid_suspend(shid);
> > +
> > +	shid->attempts =3D 0;
> > +
> > +	dev_dbg(dev, "%s: %s -> %s\n", __func__,
> > +			spi_hid_power_mode_string(prev_state),
> > +			spi_hid_power_mode_string(shid->power_state));
> > +}
> > +
> > +static void spi_hid_refresh_device_work(struct work_struct *work)
> > +{
> > +	struct spi_hid *shid =3D
> > +		container_of(work, struct spi_hid, refresh_device_work);
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct hid_device *hid;
> > +	int ret;
> > +	u32 new_crc32;
> > +
> > +	trace_spi_hid_refresh_device_work(shid);
> > +
> > +	mutex_lock(&shid->lock);
> > +	ret =3D spi_hid_report_descriptor_request(shid);
> > +	mutex_unlock(&shid->lock);
> > +	if (ret < 0) {
> > +		dev_err(dev,
> > +			"Refresh: failed report descriptor request, error %d",
> > +			ret);
> > +		return;
> > +	}
> > +
> > +	new_crc32 =3D crc32_le(0, (unsigned char const *)shid-
> >response.content,
> > +								(size_t)ret);
> > +	if (new_crc32 =3D=3D shid->report_descriptor_crc32) {
> > +		shid->ready =3D true;
> > +		sysfs_notify(&dev->kobj, NULL, "ready");
> > +		return;
> > +	}
> > +
> > +	shid->report_descriptor_crc32 =3D new_crc32;
> > +	shid->refresh_in_progress =3D true;
> > +
> > +	hid =3D spi_hid_disconnect_hid(shid);
> > +	if (hid)
> > +		hid_destroy_device(hid);
> > +
> > +	ret =3D spi_hid_create_device(shid);
> > +	if (ret)
> > +		dev_err(dev, "Failed to create hid device\n");
> > +
> > +	shid->refresh_in_progress =3D false;
> > +	shid->ready =3D true;
> > +	sysfs_notify(&dev->kobj, NULL, "ready");
> > +}
> > +
> > +static void spi_hid_input_header_complete(void *_shid);
> > +
> > +static void spi_hid_input_body_complete(void *_shid)
> > +{
> > +	struct spi_hid *shid =3D _shid;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&shid->input_lock, flags);
> > +
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_OFF) {
> > +		dev_warn(dev,
> > +			"input body complete called while device is off\n");
> > +		goto out;
> > +	}
> > +
> > +	trace_spi_hid_input_body_complete(shid,
> > +			shid->input_transfer[0].tx_buf,
> > +			shid->input_transfer[0].len,
> > +			shid->input_transfer[1].rx_buf,
> > +			shid->input_transfer[1].len,
> > +			shid->input_message.status);
> > +
> > +	if (shid->input_message.status < 0) {
> > +		dev_warn(dev, "error reading body, resetting %d\n",
> > +				shid->input_message.status);
> > +		shid->bus_error_count++;
> > +		shid->bus_last_error =3D shid->input_message.status;
> > +		schedule_work(&shid->error_work);
> > +		goto out;
> > +	}
> > +
> > +	spi_hid_process_input_report(shid, &shid->input);
> > +
> > +	if (--shid->input_transfer_pending) {
> > +		struct spi_hid_input_buf *buf =3D &shid->input;
> > +
> > +		trace_spi_hid_header_transfer(shid);
> > +		ret =3D spi_hid_input_async(shid, buf->header,
> > +				sizeof(buf->header),
> > +				spi_hid_input_header_complete, true);
> > +		if (ret)
> > +			dev_err(dev, "failed to start header transfer %d\n",
> > +									ret);
> > +	}
> > +
> > +out:
> > +	spin_unlock_irqrestore(&shid->input_lock, flags);
> > +}
> > +
> > +static void spi_hid_input_header_complete(void *_shid)
> > +{
> > +	struct spi_hid *shid =3D _shid;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_input_header header;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	spin_lock_irqsave(&shid->input_lock, flags);
> > +
> > +	if (shid->power_state =3D=3D SPI_HID_POWER_MODE_OFF) {
> > +		dev_warn(dev,
> > +			"input header complete called while device is off\n");
> > +		goto out;
> > +	}
> > +
> > +	trace_spi_hid_input_header_complete(shid,
> > +			shid->input_transfer[0].tx_buf,
> > +			shid->input_transfer[0].len,
> > +			shid->input_transfer[1].rx_buf,
> > +			shid->input_transfer[1].len,
> > +			shid->input_message.status);
> > +
> > +	if (shid->input_message.status < 0) {
> > +		dev_warn(dev, "error reading header, resetting, error %d\n",
> > +				shid->input_message.status);
> > +		shid->bus_error_count++;
> > +		shid->bus_last_error =3D shid->input_message.status;
> > +		schedule_work(&shid->error_work);
> > +		goto out;
> > +	}
> > +	spi_hid_populate_input_header(shid->input.header, &header);
> > +
> > +	ret =3D spi_hid_bus_validate_header(shid, &header);
> > +	if (ret) {
> > +		dev_err(dev, "failed to validate header: %d\n", ret);
> > +		print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
> > +						DUMP_PREFIX_NONE, 16, 1,
> > +						shid->input.header,
> > +						sizeof(shid->input.header),
> > +						false);
> > +		shid->bus_error_count++;
> > +		shid->bus_last_error =3D ret;
> > +		goto out;
> > +	}
> > +
> > +	ret =3D spi_hid_input_async(shid, shid->input.body, header.report_len=
gth,
> > +			spi_hid_input_body_complete, false);
> > +	if (ret)
> > +		dev_err(dev, "failed body async transfer: %d\n", ret);
> > +
> > +out:
> > +	if (ret)
> > +		shid->input_transfer_pending =3D 0;
> > +
> > +	spin_unlock_irqrestore(&shid->input_lock, flags);
> > +}
> > +
> > +static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	struct spi_hid_output_report report =3D {
> > +		.report_type =3D
> SPI_HID_OUTPUT_REPORT_TYPE_HID_GET_FEATURE,
> > +		.content_length =3D 0,
> > +		.content_id =3D content_id,
> > +		.content =3D NULL,
> > +	};
> > +
> > +	ret =3D spi_hid_sync_request(shid, &report);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"Expected get request response not received! Error
> %d\n",
> > +			ret);
> > +		schedule_work(&shid->error_work);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_set_request(struct spi_hid *shid,
> > +		u8 *arg_buf, u16 arg_len, u8 content_id)
> > +{
> > +	struct spi_hid_output_report report =3D {
> > +		.report_type =3D
> SPI_HID_OUTPUT_REPORT_TYPE_HID_SET_FEATURE,
> > +		.content_length =3D arg_len,
> > +		.content_id =3D content_id,
> > +		.content =3D arg_buf,
> > +	};
> > +
> > +	return spi_hid_sync_request(shid, &report);
> > +}
> > +
> > +static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
> > +{
> > +	struct spi_hid *shid =3D _shid;
> > +	struct device *dev =3D &shid->spi->dev;
> > +	int ret =3D 0;
> > +
> > +	spin_lock(&shid->input_lock);
> > +	trace_spi_hid_dev_irq(shid, irq);
> > +
> > +	if (shid->input_transfer_pending++)
> > +		goto out;
> > +
> > +	trace_spi_hid_header_transfer(shid);
> > +	ret =3D spi_hid_input_async(shid, shid->input.header,
> > +			sizeof(shid->input.header),
> > +			spi_hid_input_header_complete, true);
> > +	if (ret)
> > +		dev_err(dev, "Failed to start header transfer: %d\n", ret);
> > +
> > +out:
> > +	spin_unlock(&shid->input_lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/* hid_ll_driver interface functions */
> > +
> > +static int spi_hid_ll_start(struct hid_device *hid)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +
> > +	if (shid->desc.max_input_length < HID_MIN_BUFFER_SIZE) {
> > +		dev_err(&shid->spi->dev,
> > +			"HID_MIN_BUFFER_SIZE > max_input_length (%d)\n",
> > +			shid->desc.max_input_length);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void spi_hid_ll_stop(struct hid_device *hid)
> > +{
> > +	hid->claimed =3D 0;
> > +}
> > +
> > +static int spi_hid_ll_open(struct hid_device *hid)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	u8 prev_state =3D shid->power_state;
> > +
> > +	if (shid->refresh_in_progress)
> > +		return 0;
> > +
> > +	spi_hid_resume(shid);
> > +
> > +	dev_dbg(dev, "%s: %s -> %s\n", __func__,
> > +			spi_hid_power_mode_string(prev_state),
> > +			spi_hid_power_mode_string(shid->power_state));
> > +
> > +	return 0;
> > +}
> > +
> > +static void spi_hid_ll_close(struct hid_device *hid)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	u8 prev_state =3D shid->power_state;
> > +
> > +	if (shid->refresh_in_progress)
> > +		return;
> > +
> > +	spi_hid_suspend(shid);
> > +
> > +	shid->attempts =3D 0;
> > +
> > +	dev_dbg(dev, "%s: %s -> %s\n", __func__,
> > +			spi_hid_power_mode_string(prev_state),
> > +			spi_hid_power_mode_string(shid->power_state));
> > +}
> > +
> > +static int spi_hid_ll_power(struct hid_device *hid, int level)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&shid->lock);
> > +	if (!shid->hid)
> > +		ret =3D -ENODEV;
> > +	mutex_unlock(&shid->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_ll_parse(struct hid_device *hid)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	int ret, len;
> > +
> > +	mutex_lock(&shid->lock);
> > +
> > +	len =3D spi_hid_report_descriptor_request(shid);
> > +	if (len < 0) {
> > +		dev_err(dev, "Report descriptor request failed, %d\n", len);
> > +		ret =3D len;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * FIXME: below call returning 0 doesn't mean that the report
> descriptor
> > +	 * is good. We might be caching a crc32 of a corrupted r. d. or who
> > +	 * knows what the FW sent. Need to have a feedback loop about r. d.
> > +	 * being ok and only then cache it.
> > +	 */
> > +	ret =3D hid_parse_report(hid, (__u8 *)shid->response.content, len);
> > +	if (ret)
> > +		dev_err(dev, "failed parsing report: %d\n", ret);
> > +	else
> > +		shid->report_descriptor_crc32 =3D crc32_le(0,
> > +				(unsigned char const *)shid->response.content,
> > +				len);
> > +
> > +out:
> > +	mutex_unlock(&shid->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_ll_raw_request(struct hid_device *hid,
> > +		unsigned char reportnum, __u8 *buf, size_t len,
> > +		unsigned char rtype, int reqtype)
> > +{
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	int ret;
> > +
> > +	if (!shid->ready) {
> > +		dev_err(&shid->spi->dev, "%s called in unready state\n",
> > +								__func__);
> > +		return -ENODEV;
>=20
> This will confuse users for no good reason. Do not let them call into
> the driver until it is ready.

This is the biggest change in the v4 - we now wait_for_completion() in
ll_open() until the device is ready.

>=20
> > +	}
> > +
> > +	mutex_lock(&shid->lock);
> > +
> > +	switch (reqtype) {
> > +	case HID_REQ_SET_REPORT:
> > +		if (buf[0] !=3D reportnum) {
> > +			dev_err(dev, "report id mismatch\n");
> > +			ret =3D -EINVAL;
> > +			break;
> > +		}
> > +
> > +		ret =3D spi_hid_set_request(shid, &buf[1], len - 1,
> > +				reportnum);
> > +		if (ret) {
> > +			dev_err(dev, "failed to set report\n");
> > +			break;
> > +		}
> > +
> > +		ret =3D len;
> > +		break;
> > +	case HID_REQ_GET_REPORT:
> > +		ret =3D spi_hid_get_request(shid, reportnum);
> > +		if (ret) {
> > +			dev_err(dev, "failed to get report\n");
> > +			break;
> > +		}
> > +
> > +		ret =3D min_t(size_t, len,
> > +			shid->response.body[1] | (shid->response.body[2] <<
> 8));
> > +		memcpy(buf, &shid->response.content, ret);
> > +		break;
> > +	default:
> > +		dev_err(dev, "invalid request type\n");
> > +		ret =3D -EIO;
> > +	}
> > +
> > +	mutex_unlock(&shid->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_ll_output_report(struct hid_device *hid,
> > +		__u8 *buf, size_t len)
> > +{
> > +	int ret;
> > +	struct spi_device *spi =3D hid->driver_data;
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	struct spi_hid_output_report report =3D {
> > +		.report_type =3D
> SPI_HID_OUTPUT_REPORT_TYPE_HID_OUTPUT_REPORT,
> > +		.content_length =3D len - 1,
> > +		.content_id =3D buf[0],
> > +		.content =3D &buf[1],
> > +	};
> > +
> > +	mutex_lock(&shid->lock);
> > +	if (!shid->ready) {
> > +		dev_err(dev, "%s called in unready state\n", __func__);
> > +		ret =3D -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	if (shid->desc.no_output_report_ack)
> > +		ret =3D spi_hid_send_output_report(shid, &report);
> > +	else
> > +		ret =3D spi_hid_sync_request(shid, &report);
> > +
> > +	if (ret)
> > +		dev_err(dev, "failed to send output report\n");
> > +
> > +out:
> > +	mutex_unlock(&shid->lock);
> > +
> > +	if (ret > 0)
> > +		return -ret;
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +
> > +static struct hid_ll_driver spi_hid_ll_driver =3D {
> > +	.start =3D spi_hid_ll_start,
> > +	.stop =3D spi_hid_ll_stop,
> > +	.open =3D spi_hid_ll_open,
> > +	.close =3D spi_hid_ll_close,
> > +	.power =3D spi_hid_ll_power,
> > +	.parse =3D spi_hid_ll_parse,
> > +	.output_report =3D spi_hid_ll_output_report,
> > +	.raw_request =3D spi_hid_ll_raw_request,
> > +};
> > +
> > +static ssize_t ready_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%s\n",
> > +			shid->ready ? "ready" : "not ready");
>=20
> Why is this needed? Why can't we simply delay registering HID device
> until after we are ready to handle it? Or delay in open?

Delay in open is what was chosen as a better solution and is implemented
in v4.

>=20
> > +}
> > +static DEVICE_ATTR_RO(ready);
> > +
> > +static ssize_t bus_error_count_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%d (%d)\n",
> > +			shid->bus_error_count, shid->bus_last_error);
>=20
> This and below I think better suited for debugfs.

These are used for telemetry on our device and customer builds don't
have debugfs enabled, thus we need to use sysfs.

>=20
> > +}
> > +static DEVICE_ATTR_RO(bus_error_count);
> > +
> > +static ssize_t regulator_error_count_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%d (%d)\n",
> > +			shid->regulator_error_count,
> > +			shid->regulator_last_error);
> > +}
> > +static DEVICE_ATTR_RO(regulator_error_count);
> > +
> > +static ssize_t device_initiated_reset_count_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%d\n", shid->dir_count);
> > +}
> > +static DEVICE_ATTR_RO(device_initiated_reset_count);
> > +
> > +static const struct attribute *const spi_hid_attributes[] =3D {
> > +	&dev_attr_ready.attr,
> > +	&dev_attr_bus_error_count.attr,
> > +	&dev_attr_regulator_error_count.attr,
> > +	&dev_attr_device_initiated_reset_count.attr,
> > +	NULL	/* Terminator */
> > +};
> > +
> > +static int spi_hid_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev =3D &spi->dev;
> > +	struct spi_hid *shid;
> > +	unsigned long irqflags;
> > +	int ret;
> > +
> > +	if (spi->irq <=3D 0) {
> > +		dev_err(dev, "Missing IRQ\n");
> > +		ret =3D spi->irq ?: -EINVAL;
> > +		goto err0;
> > +	}
> > +
> > +	shid =3D devm_kzalloc(dev, sizeof(struct spi_hid), GFP_KERNEL);
> > +	if (!shid) {
> > +		ret =3D -ENOMEM;
> > +		goto err0;
> > +	}
> > +
> > +	shid->spi =3D spi;
> > +	shid->power_state =3D SPI_HID_POWER_MODE_ON;
> > +	spi_set_drvdata(spi, shid);
> > +
> > +	ret =3D sysfs_create_files(&dev->kobj, spi_hid_attributes);
>=20
> I'd recommend using devm* for all resources used by this driver.
>=20
> > +	if (ret) {
> > +		dev_err(dev, "Unable to create sysfs attributes\n");
> > +		goto err0;
> > +	}
> > +
> > +	ret =3D spi_hid_of_populate_config(&shid->conf, dev);
>=20
> Error handling?

Added in v4.

>=20
> > +
> > +	/* Using now populated conf let's pre-calculate the read approvals */
> > +	spi_hid_populate_read_approvals(&shid->conf, shid-
> >read_approval_header,
> > +						shid->read_approval_body);
> > +
> > +	mutex_init(&shid->lock);
> > +	init_completion(&shid->output_done);
> > +
> > +	spin_lock_init(&shid->input_lock);
> > +	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
> > +	INIT_WORK(&shid->create_device_work, spi_hid_create_device_work);
> > +	INIT_WORK(&shid->refresh_device_work,
> spi_hid_refresh_device_work);
> > +	INIT_WORK(&shid->error_work, spi_hid_error_work);
> > +
> > +	/*
> > +	 * At the end of probe we initialize the device:
> > +	 *   0) Default pinctrl in DT: assert reset, bias the interrupt line
> > +	 *   1) sleep minimal reset delay
> > +	 *   2) request IRQ
> > +	 *   3) power up the device
> > +	 *   4) sleep 5ms
> > +	 *   5) deassert reset (high)
> > +	 *   6) sleep 5ms
> > +	 */
> > +
> > +	spi_hid_of_sleep_minimal_reset_delay(&shid->conf);
> > +
> > +	irqflags =3D irq_get_trigger_type(spi->irq) | IRQF_ONESHOT;
>=20
> Specifying ONESHOT mode for non-threaded IRQ does not make much sense.
> Why don't you use threaded IRQ and get rid of your async/work hanlding?

Switched to threaded IRQ and spi_sync in v4.

>=20
> > +	ret =3D request_irq(spi->irq, spi_hid_dev_irq, irqflags,
> > +			dev_name(&spi->dev), shid);
> > +	if (ret)
> > +		goto err1;
> > +
> > +	ret =3D spi_hid_of_power_up(&shid->conf);
> > +	if (ret) {
> > +		dev_err(dev, "%s: could not power up\n", __func__);
> > +		shid->regulator_error_count++;
> > +		shid->regulator_last_error =3D ret;
> > +		goto err1;
> > +	}
> > +
> > +	spi_hid_of_deassert_reset(&shid->conf);
> > +
> > +	dev_err(dev, "%s: d3 -> %s\n", __func__,
> > +			spi_hid_power_mode_string(shid->power_state));
> > +
> > +	return 0;
> > +
> > +err1:
> > +	sysfs_remove_files(&dev->kobj, spi_hid_attributes);
> > +
> > +err0:
> > +	return ret;
> > +}
> > +
> > +static int spi_hid_remove(struct spi_device *spi)
> > +{
> > +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	int ret;
> > +
> > +	spi_hid_of_assert_reset(&shid->conf);
> > +	ret =3D spi_hid_of_power_down(&shid->conf);
> > +	if (ret) {
> > +		dev_err(dev, "failed to disable regulator\n");
> > +		shid->regulator_error_count++;
> > +		shid->regulator_last_error =3D ret;
> > +	}
> > +	free_irq(spi->irq, shid);
> > +	sysfs_remove_files(&dev->kobj, spi_hid_attributes);
> > +	spi_hid_stop_hid(shid);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct spi_device_id spi_hid_id_table[] =3D {
> > +	{ "hid", 0 },
> > +	{ "hid-over-spi", 0 },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(spi, spi_hid_id_table);
> > +
> > +static struct spi_driver spi_hid_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "spi_hid",
> > +		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D of_match_ptr(spi_hid_of_match),
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +	.probe		=3D spi_hid_probe,
> > +	.remove		=3D spi_hid_remove,
> > +	.id_table	=3D spi_hid_id_table,
> > +};
> > +
> > +module_spi_driver(spi_hid_driver);
> > +
> > +MODULE_DESCRIPTION("HID over SPI transport driver");
> > +MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/s=
pi-hid-
> core.h
> > new file mode 100644
> > index 000000000000..95e667ad53ec
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-core.h
> > @@ -0,0 +1,188 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * spi-hid-core.h
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + */
> > +
> > +#ifndef SPI_HID_CORE_H
> > +#define SPI_HID_CORE_H
> > +
> > +#include <linux/completion.h>
> > +#include <linux/kernel.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#include "spi-hid-of.h"
> > +
> > +/* Protocol constants */
> > +#define SPI_HID_READ_APPROVAL_CONSTANT		0xff
> > +#define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
> > +#define SPI_HID_INPUT_HEADER_VERSION		0x03
> > +#define SPI_HID_SUPPORTED_VERSION		0x0300
> > +
> > +/* Protocol message size constants */
> > +#define SPI_HID_READ_APPROVAL_LEN		5
> > +#define SPI_HID_INPUT_HEADER_LEN		4
> > +#define SPI_HID_INPUT_BODY_LEN			4
> > +#define SPI_HID_OUTPUT_HEADER_LEN		8
> > +#define SPI_HID_DEVICE_DESCRIPTOR_LENGTH	24
> > +
> > +/* Protocol message type constants */
> > +#define SPI_HID_INPUT_REPORT_TYPE_DATA				0x01
> > +#define SPI_HID_INPUT_REPORT_TYPE_RESET_RESP			0x03
> > +#define SPI_HID_INPUT_REPORT_TYPE_COMMAND_RESP
> 	0x04
> > +#define SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP		0x05
> > +#define SPI_HID_INPUT_REPORT_TYPE_DEVICE_DESC			0x07
> > +#define SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC
> 	0x08
> > +#define SPI_HID_INPUT_REPORT_TYPE_SET_FEATURE_RESP		0x09
> > +#define SPI_HID_INPUT_REPORT_TYPE_SET_OUTPUT_REPORT_RESP	0x0a
> > +#define SPI_HID_INPUT_REPORT_TYPE_GET_INPUT_REPORT_RESP
> 	0x0b
> > +
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_DEVICE_DESC_REQUEST	0x01
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_REPORT_DESC_REQUEST	0x02
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_HID_SET_FEATURE	0x03
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_HID_GET_FEATURE	0x04
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_HID_OUTPUT_REPORT	0x05
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_INPUT_REPORT_REQUEST	0x06
> > +#define SPI_HID_OUTPUT_REPORT_TYPE_COMMAND		0x07
> > +
> > +#define SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST	0x00
> > +
> > +/* Power mode constants */
> > +#define SPI_HID_POWER_MODE_ON			0x01
> > +#define SPI_HID_POWER_MODE_SLEEP		0x02
> > +#define SPI_HID_POWER_MODE_OFF			0x03
> > +#define SPI_HID_POWER_MODE_WAKING_SLEEP		0x04
> > +
> > +/* Raw input buffer with data from the bus */
> > +struct spi_hid_input_buf {
> > +	__u8 header[SPI_HID_INPUT_HEADER_LEN];
> > +	__u8 body[SPI_HID_INPUT_BODY_LEN];
> > +	u8 content[SZ_8K];
> > +};
> > +
> > +/* Processed data from  input report header */
> > +struct spi_hid_input_header {
> > +	u8 version;
> > +	u16 report_length;
> > +	u8 last_fragment_flag;
> > +	u8 sync_const;
> > +};
> > +
> > +/* Processed data from input report body, excluding the content */
> > +struct spi_hid_input_body {
> > +	u8 report_type;
> > +	u16 content_length;
> > +	u8 content_id;
> > +};
> > +
> > +/* Processed data from an input report */
> > +struct spi_hid_input_report {
> > +	u8 report_type;
> > +	u16 content_length;
> > +	u8 content_id;
> > +	u8 *content;
> > +};
> > +
> > +/* Raw output report buffer to be put on the bus */
> > +struct spi_hid_output_buf {
> > +	__u8 header[SPI_HID_OUTPUT_HEADER_LEN];
> > +	u8 content[SZ_8K];
> > +};
> > +
> > +/* Data necessary to send an output report */
> > +struct spi_hid_output_report {
> > +	u8 report_type;
> > +	u16 content_length;
> > +	u8 content_id;
> > +	u8 *content;
> > +};
> > +
> > +/* Raw content in device descriptor */
> > +struct spi_hid_device_desc_raw {
> > +	__le16 wDeviceDescLength;
> > +	__le16 bcdVersion;
> > +	__le16 wReportDescLength;
> > +	__le16 wMaxInputLength;
> > +	__le16 wMaxOutputLength;
> > +	__le16 wMaxFragmentLength;
> > +	__le16 wVendorID;
> > +	__le16 wProductID;
> > +	__le16 wVersionID;
> > +	__le16 wFlags;
> > +	__u8 reserved[4];
> > +} __packed;
> > +
> > +/* Processed data from a device descriptor */
> > +struct spi_hid_device_descriptor {
> > +	u16 hid_version;
> > +	u16 report_descriptor_length;
> > +	u16 max_input_length;
> > +	u16 max_output_length;
> > +	u16 max_fragment_length;
> > +	u16 vendor_id;
> > +	u16 product_id;
> > +	u16 version_id;
> > +	u8 no_output_report_ack;
>=20
> bool?
>=20
> > +};
> > +
> > +/* Driver context */
> > +struct spi_hid {
> > +	struct spi_device	*spi;
> > +	struct hid_device	*hid;
> > +
> > +	struct spi_transfer	input_transfer[2];
> > +	struct spi_transfer	output_transfer;
> > +	struct spi_message	input_message;
> > +	struct spi_message	output_message;
> > +
> > +	struct spi_hid_of_config conf;
> > +	struct spi_hid_device_descriptor desc;
> > +	struct spi_hid_output_buf output;
> > +	struct spi_hid_input_buf input;
> > +	struct spi_hid_input_buf response;
> > +
> > +	spinlock_t		input_lock;
> > +
> > +	u32 input_transfer_pending;
> > +
> > +	u8 power_state;
> > +
> > +	u8 attempts;
> > +
> > +	/*
> > +	 * ready flag indicates that the FW is ready to accept commands and
> > +	 * requests. The FW becomes ready after sending the report descriptor=
.
> > +	 */
> > +	bool ready;
> > +	/*
> > +	 * refresh_in_progress is set to true while the refresh_device worker
> > +	 * thread is destroying and recreating the hidraw device. When this f=
lag
> > +	 * is set to true, the ll_close and ll_open functions will not cause
> > +	 * power state changes.
> > +	 */
> > +	bool refresh_in_progress;
> > +
> > +	struct work_struct reset_work;
> > +	struct work_struct create_device_work;
> > +	struct work_struct refresh_device_work;
> > +	struct work_struct error_work;
> > +
> > +	struct mutex lock;
> > +	struct completion output_done;
> > +
> > +	__u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
> > +	__u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
> > +
> > +	u32 report_descriptor_crc32;
> > +
> > +	u32 regulator_error_count;
> > +	int regulator_last_error;
> > +	u32 bus_error_count;
> > +	int bus_last_error;
> > +	u32 dir_count;
> > +};
> > +
> > +#endif
> > diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi=
-hid-of.c
> > new file mode 100755
> > index 000000000000..4896a90c2e8e
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-of.c
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * HID over SPI protocol, Open Firmware related code
> > + * spi-hid-of.c
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + *
> > + * This code was forked out of the HID over SPI core code, which is pa=
rtially
> > + * based on "HID over I2C protocol implementation:
> > + *
> > + * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com=
>
> > + * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
> > + * Copyright (c) 2012 Red Hat, Inc
> > + *
> > + * which in turn is partially based on "USB HID support for Linux":
> > + *
> > + * Copyright (c) 1999 Andreas Gal
> > + * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
> > + * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for
> Concept2, Inc
> > + * Copyright (c) 2007-2008 Oliver Neukum
> > + * Copyright (c) 2006-2010 Jiri Kosina
> > + */
> > +#include <linux/of.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/delay.h>
> > +
> > +#include "spi-hid-core.h"
> > +
> > +const struct of_device_id spi_hid_of_match[] =3D {
> > +	{ .compatible =3D "hid-over-spi" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, spi_hid_of_match);
> > +
> > +int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
> > +				struct device *dev)
> > +{
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret =3D device_property_read_u32(dev, "input-report-header-address",
> > +									&val);
> > +	if (ret) {
> > +		dev_err(dev, "Input report header address not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->input_report_header_address =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "input-report-body-address",
> &val);
> > +	if (ret) {
> > +		dev_err(dev, "Input report body address not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->input_report_body_address =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "output-report-address", &val);
> > +	if (ret) {
> > +		dev_err(dev, "Output report address not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->output_report_address =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "read-opcode", &val);
> > +	if (ret) {
> > +		dev_err(dev, "Read opcode not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->read_opcode =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "write-opcode", &val);
> > +	if (ret) {
> > +		dev_err(dev, "Write opcode not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->write_opcode =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "post-power-on-delay-ms", &val)=
;
> > +	if (ret) {
> > +		dev_err(dev, "Post-power-on delay not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->post_power_on_delay_ms =3D val;
> > +
> > +	ret =3D device_property_read_u32(dev, "minimal-reset-delay-ms", &val)=
;
> > +	if (ret) {
> > +		dev_err(dev, "Minimal reset time not provided\n");
> > +		return -ENODEV;
> > +	}
> > +	conf->minimal_reset_delay_ms =3D val;
> > +
> > +	/* FIXME: not reading flags from DT, multi-SPI modes not supported */
> > +
> > +	conf->supply =3D devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(conf->supply)) {
> > +		if (PTR_ERR(conf->supply) !=3D -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get regulator: %ld\n",
> > +					PTR_ERR(conf->supply));
> > +		return PTR_ERR(conf->supply);
> > +	}
> > +
> > +	conf->reset_gpio =3D devm_gpiod_get(dev, "reset-gpio",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(conf->reset_gpio)) {
> > +		dev_err(dev, "%s: error getting GPIO\n", __func__);
> > +		return PTR_ERR(conf->reset_gpio);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int spi_hid_of_power_down(struct spi_hid_of_config *conf)
> > +{
> > +	if (regulator_is_enabled(conf->supply) =3D=3D 0)
> > +		return 0;
> > +
> > +	return regulator_disable(conf->supply);
> > +}
> > +
> > +int spi_hid_of_power_up(struct spi_hid_of_config *conf)
> > +{
> > +	int ret;
> > +
> > +	if (regulator_is_enabled(conf->supply) > 0)
> > +		return 0;
> > +
> > +	ret =3D regulator_enable(conf->supply);
> > +
> > +	usleep_range(1000 * conf->post_power_on_delay_ms,
> > +			1000 * (conf->post_power_on_delay_ms + 1));
> > +
> > +	return ret;
> > +}
> > +
> > +void spi_hid_of_assert_reset(struct spi_hid_of_config *conf)
> > +{
> > +	gpiod_set_value(conf->reset_gpio, 1);
> > +}
> > +
> > +void spi_hid_of_deassert_reset(struct spi_hid_of_config *conf)
> > +{
> > +	gpiod_set_value(conf->reset_gpio, 0);
>=20
> Why do we need these wrappers?
>=20
> > +}
> > +
> > +void spi_hid_of_sleep_minimal_reset_delay(struct spi_hid_of_config *co=
nf)
> > +{
> > +	usleep_range(1000 * conf->minimal_reset_delay_ms,
> > +			1000 * (conf->minimal_reset_delay_ms + 1));
> > +}
> > \ No newline at end of file
> > diff --git a/drivers/hid/spi-hid/spi-hid-of.h b/drivers/hid/spi-hid/spi=
-hid-of.h
> > new file mode 100755
> > index 000000000000..5991011d8921
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-of.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * spi-hid-of.h
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + */
> > +
> > +#ifndef SPI_HID_OF_H
> > +#define SPI_HID_OF_H
> > +
> > +extern const struct of_device_id spi_hid_of_match[];
> > +
> > +/* Config structure is filled with data from Device Tree */
> > +struct spi_hid_of_config {
> > +	u32 input_report_header_address;
> > +	u32 input_report_body_address;
> > +	u32 output_report_address;
> > +	u8 read_opcode;
> > +	u8 write_opcode;
> > +	u32 post_power_on_delay_ms;
> > +	u32 minimal_reset_delay_ms;
> > +	struct gpio_desc *reset_gpio;
> > +	struct regulator *supply;
> > +};
> > +
> > +int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
> > +				struct device *dev);
> > +int spi_hid_of_power_down(struct spi_hid_of_config *conf);
> > +int spi_hid_of_power_up(struct spi_hid_of_config *conf);
> > +void spi_hid_of_assert_reset(struct spi_hid_of_config *conf);
> > +void spi_hid_of_deassert_reset(struct spi_hid_of_config *conf);
> > +void spi_hid_of_sleep_minimal_reset_delay(struct spi_hid_of_config *co=
nf);
> > +
> > +#endif
> > diff --git a/drivers/hid/spi-hid/spi-hid_trace.h b/drivers/hid/spi-hid/=
spi-
> hid_trace.h
> > new file mode 100644
> > index 000000000000..905de02d85aa
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid_trace.h
> > @@ -0,0 +1,198 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * spi-hid_trace.h
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM spi_hid
> > +
> > +#if !defined(_SPI_HID_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _SPI_HID_TRACE_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/tracepoint.h>
> > +#include "spi-hid-core.h"
> > +
> > +DECLARE_EVENT_CLASS(spi_hid_transfer,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, bus_num)
> > +		__field(int, chip_select)
> > +		__field(int, len)
> > +		__field(int, ret)
> > +		__dynamic_array(u8, rx_buf, rx_len)
> > +		__dynamic_array(u8, tx_buf, tx_len)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->bus_num =3D shid->spi->controller->bus_num;
> > +		__entry->chip_select =3D shid->spi->chip_select;
> > +		__entry->len =3D rx_len + tx_len;
> > +		__entry->ret =3D ret;
> > +
> > +		memcpy(__get_dynamic_array(tx_buf), tx_buf, tx_len);
> > +		memcpy(__get_dynamic_array(rx_buf), rx_buf, rx_len);
> > +	),
> > +
> > +	TP_printk("spi%d.%d: len=3D%d tx=3D[%*phD] rx=3D[%*phD] --> %d",
> > +		__entry->bus_num, __entry->chip_select, __entry->len,
> > +		__get_dynamic_array_len(tx_buf),
> __get_dynamic_array(tx_buf),
> > +		__get_dynamic_array_len(rx_buf),
> __get_dynamic_array(rx_buf),
> > +		__entry->ret)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_transfer, spi_hid_input_async,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_transfer, spi_hid_input_header_complete,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_transfer, spi_hid_input_body_complete,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_transfer, spi_hid_output_begin,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_transfer, spi_hid_output_end,
> > +	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
> > +			const void *rx_buf, u16 rx_len, int ret),
> > +	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
> > +);
> > +
> > +DECLARE_EVENT_CLASS(spi_hid_irq,
> > +	TP_PROTO(struct spi_hid *shid, int irq),
> > +
> > +	TP_ARGS(shid, irq),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, bus_num)
> > +		__field(int, chip_select)
> > +		__field(int, irq)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->bus_num =3D shid->spi->controller->bus_num;
> > +		__entry->chip_select =3D shid->spi->chip_select;
> > +		__entry->irq =3D irq;
> > +	),
> > +
> > +	TP_printk("spi%d.%d: IRQ %d",
> > +		__entry->bus_num, __entry->chip_select, __entry->irq)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid_irq, spi_hid_dev_irq,
> > +	TP_PROTO(struct spi_hid *shid, int irq),
> > +	TP_ARGS(shid, irq)
> > +);
> > +
> > +DECLARE_EVENT_CLASS(spi_hid,
> > +	TP_PROTO(struct spi_hid *shid),
> > +
> > +	TP_ARGS(shid),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, bus_num)
> > +		__field(int, chip_select)
> > +		__field(int, power_state)
> > +		__field(u32, input_transfer_pending)
> > +		__field(bool, ready)
> > +
> > +		__field(int, vendor_id)
> > +		__field(int, product_id)
> > +		__field(int, max_input_length)
> > +		__field(int, max_output_length)
> > +		__field(u16, hid_version)
> > +		__field(u16, report_descriptor_length)
> > +		__field(u16, version_id)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->bus_num =3D shid->spi->controller->bus_num;
> > +		__entry->chip_select =3D shid->spi->chip_select;
> > +		__entry->power_state =3D shid->power_state;
> > +		__entry->input_transfer_pending =3D shid-
> >input_transfer_pending;
> > +		__entry->ready =3D shid->ready;
> > +
> > +		__entry->vendor_id =3D shid->desc.vendor_id;
> > +		__entry->product_id =3D shid->desc.product_id;
> > +		__entry->max_input_length =3D shid->desc.max_input_length;
> > +		__entry->max_output_length =3D shid->desc.max_output_length;
> > +		__entry->hid_version =3D shid->desc.hid_version;
> > +		__entry->report_descriptor_length =3D
> > +					shid->desc.report_descriptor_length;
> > +		__entry->version_id =3D shid->desc.version_id;
> > +	),
> > +
> > +	TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d
> len i:%d o:%d r:%d flags %c:%d",
> > +		__entry->bus_num, __entry->chip_select, __entry->vendor_id,
> > +		__entry->product_id, __entry->version_id,
> > +		__entry->hid_version >> 8, __entry->hid_version & 0xff,
> > +		__entry->power_state,	__entry->max_input_length,
> > +		__entry->max_output_length, __entry-
> >report_descriptor_length,
> > +		__entry->ready ? 'R' : 'r', __entry->input_transfer_pending)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_header_transfer,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_process_input_report,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_input_report_handler,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_reset_work,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_create_device_work,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_refresh_device_work,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_response_handler,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +DEFINE_EVENT(spi_hid, spi_hid_error_handler,
> > +	TP_PROTO(struct spi_hid *shid),
> > +	TP_ARGS(shid)
> > +);
> > +
> > +#endif /* _SPI_HID_TRACE_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#define TRACE_INCLUDE_PATH .
> > +#define TRACE_INCLUDE_FILE spi-hid_trace
> > +#include <trace/define_trace.h>
> > diff --git a/drivers/hid/spi-hid/trace.c b/drivers/hid/spi-hid/trace.c
> > new file mode 100644
> > index 000000000000..aaa2da0c9642
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/trace.c
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * trace.c - SPI HID Trace Support
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + *
> > + * Author: Felipe Balbi <felipe.balbi@microsoft.com>
> > + */
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include "spi-hid_trace.h"
> > --
> > 2.25.1
> >
>=20
> Thanks.
>=20
> --
> Dmitry
