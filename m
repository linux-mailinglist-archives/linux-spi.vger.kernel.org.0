Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DB4D653F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiCKPyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Mar 2022 10:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350232AbiCKPxs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Mar 2022 10:53:48 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61AC1CBA9B
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 07:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647013901; x=1678549901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+8Oekrfcjd4sqUvRKuHX1tVXkCMa2MljBGZTsh5NsL0=;
  b=Iik6ciX+OVuzzthR1LuJrvI26tP9yzY7G6FMOj3BQf5d5JCQsO+ijzEN
   NPDWqbLgK/O+D0uKHtf8/H8fuzLpzXpFL6KU7cr4fmn3R5cBHGCMV6gIh
   tzZidkn9IPljlsawvT847T+LKTZsM1ySi7Af+l+BWdA4o67yCc/DXPcfJ
   tbsOCMMfLvbq09GV6GDKjGylW6Z7WVXA3Z/0Lt8eTlOha2y8M42QBiyJT
   f3JscW4YqrhuzEgLsRvsS2GwovghHe8XQ44/+4mu/BZXsxt4L04r7DN1q
   GzAR2rpBK81seUWQ+ecaeSRXYr5kXKssykW8/kKAb3dSTTkEhdAIxP99R
   w==;
X-IronPort-AV: E=Sophos;i="5.90,174,1643644800"; 
   d="scan'208";a="196068828"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 23:51:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZMjjrUQoxVUTQWddBUqaAgOgnH0s6XKrtM4Xuh96BTvwAMTg/afORFDeDgPZ2tq3rnJ56WWGwyTW/O9WVhup3ksAUGIUGtek82lcRKg2oNVWzLrv9bAM2qR4I51ljpOrZBFTSvTXnO7hjvDJxwOuygv1ukgczDt9R/ff2tS9FF9Ap81XC2jpZaGrSKv68QeWKXlYCOIB/aegSUH4dzehVkitQDEq9X0kyA1h+p+19a8xucjyL1aKFLjpD4ttzAOoM2xvyfla+Lf+bo8fIUZP7btw4d8gPvCOYESsOEOlikqCbewFngceDQ5zkQmW93jjK4irKZnbRBfLQIosfx8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b82EqmoW3tkhd4DQOWcxfnF9BmObT3Y9wdlA4C6UXI8=;
 b=axaNqseIFyNnidQqJwmz5a2aIs/O2d3q1XeFTg0nVL9OYB2H1vywqshYX9vaKlb2QITJUNf4y6rsifAPbCPPQGr0w8m4v7G7IMlN9iYWyL/gX2fn4jnkP3LVocpjRZ+vNzP452Lz9nMre5xcUZSqR1QeWoAUULWaFbZL7DLL3Ut05aU+5odkxu1Pk8E4LZc4bS4KHK/QT2Sso7ub+n1zE7jY90g6HyjrhxIv9yG+SHd1YCJeYzrS1AuyaELqlSqO6F8M/53lKispIFANJQutr9Pj71g5aZEvW2bJLHQwSY6jjzCnA8zXOTZsszUKB5vAA7bIQX9nuHJl/Rm0spc9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b82EqmoW3tkhd4DQOWcxfnF9BmObT3Y9wdlA4C6UXI8=;
 b=sCLa8Y8u2ThrERH0CWG+ge9LwrlTZom0d5KbZD6w7ZRtWR3pZyVL/tid6fvIglmrSsYxKBzFbrPJIVWzpW1K8pQ8eV+yv4stTTQaPtDanJWTS+0QmEBg2UYDOJHtELIZRqzDOn29wDzxGAX5jmUcU6HDKiaa8ajnYJg+RxeCvlQ=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by CY4PR04MB1047.namprd04.prod.outlook.com (2603:10b6:910:51::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 15:51:23 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed%2]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 15:51:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Topic: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Index: AQHYLV3rnbk35M1FUEuh/urYvKkCb6y6TRQAgAAX5gA=
Date:   Fri, 11 Mar 2022 15:51:23 +0000
Message-ID: <Yitv+tKTH2RpTV2K@x1-carbon>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
 <20220311142550.haw5jnrjycavr43m@mobilestation>
In-Reply-To: <20220311142550.haw5jnrjycavr43m@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45265ec8-e5fc-4eaf-41cb-08da0376fe7d
x-ms-traffictypediagnostic: CY4PR04MB1047:EE_
x-microsoft-antispam-prvs: <CY4PR04MB10470C5CCF18697DC5CD5902F20C9@CY4PR04MB1047.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4wj35UwII9ISuBxvgibZKKZalhvVd+SZJDnqNWE+Xu4Y4J6LmOom/6O31ZxVqeCXROMLNYcRDzIfP2njrCwm7QKH214XiCu+yklL9nzj7dlTAcbHV5vPSizFCCf0owjPytX2PyjEH/oRU8CS6S5mJxE07D6wXV2x3gS+Q2JYJ7eBHInFAZXrpmOBGAMzYTYkRXKKpQpmmo+8d8B2cCzTmn3sKWnSn5TNBkrZGkzK3wfvZEEF9Cwrxy9JDUyAj8PKNJFEncNWqnc//Lei3vlJiF/kRLW0kOU6q1x2ozy5LZdBdLNrYBs6xEpF4IChPo26hA+ohbwv14QMSIw5jLcDHv1k6bd0/xRgJyCmzoXajxTdH4Glwfkt1lDuc7z3RNZ686zy0qIgW3tAv0z20RMoGR1QSZ6kPuRQp8O6kWpnhUZK4DucBZ/SSP4QoIET06cMAFl2uGKHTWQiFUPw64XlVpIEF7f403gsBwuK9EoNeJZq2R4AKOqJ7gRzpP4GWbNjmCuhuIlXJTZNiOU1r0Eko8OtXYv5GA0zWSBc3UNlQDEDHhfWu/4AdeImt1HhIeTeDOC4lkbpuZmtaWbS500y0Y4yXpROguulASOYInXexKInHQAxkKTIA29chvKMjTmAboN8bLL+q2X4ZLe8TGv9Qycf7e1ZnRDYA+OfUr8NU2jK5aSjjPgPBEObBhdY/KTP2p25xf8vZnkCXgnnHyFekgkeKN37jXQJZcOr0Ky+/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66446008)(8676002)(4326008)(86362001)(66556008)(186003)(66476007)(76116006)(64756008)(66946007)(316002)(6512007)(91956017)(9686003)(6916009)(38100700002)(8936002)(6486002)(2906002)(122000001)(82960400001)(83380400001)(38070700005)(26005)(5660300002)(508600001)(6506007)(33716001)(71200400001)(54906003)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I3QWmwwy89wzukwNOfTYwHbH1+iKv2PdO/20rlkyuuVHe4ZL8ceDDh2esG8F?=
 =?us-ascii?Q?ylL5LCcwrmDMAMvvQerRF4xsk8ms8W8Z/HhXtbTI0O243MDGOqjieC81UBpK?=
 =?us-ascii?Q?SX0t89eOSrw85RRQRnOJzDL9tIkl0Qk6LJgyFAnh/t54RxESgG/pahvZYdO2?=
 =?us-ascii?Q?A87H0MvUyG3zZuq8XdBJdP+wscnBLNWCst3XPE431I9z+O5zSk8JxrAgoKmR?=
 =?us-ascii?Q?zZC8BfF5RY05CuvV8kngshIOd8tiKCvsAdMg38fUORj6o8skEPrExkOxOtov?=
 =?us-ascii?Q?QEcw97fKptc6M3iOUFmXJG5uUsH28bwxd7WDuapjeY7m3nkHSAHSpxcRpCtI?=
 =?us-ascii?Q?GJ8vw0XiSJUeBBxaCVMNvN9JCgYPwUdjdfTmmWqusqjvNOumC2YwOFBAxfk1?=
 =?us-ascii?Q?ykcV7MtW+agTCZW7XKOxAkmXKYzFwgMyKqoG6ZHbGU85by7vWcy8BJ5QHnb9?=
 =?us-ascii?Q?dLCFBkV9qn3hOHWroqc1mfMlf60Bk1p4kU1RWddMe8h6IIg+mhxlWjDgxxJ6?=
 =?us-ascii?Q?ADZTHZQ+GFVT/SD1Gp13gEktClZumyOGwap+bg8j+lTRlu3CIyXxGunUteer?=
 =?us-ascii?Q?MsOi3V4imqYyON+IGpRayE3guZiyiS6z7jD27hPexE/EmneTJwtWWmrHolEe?=
 =?us-ascii?Q?0gBLassRAG2LUSO2PVioLBtNmhAAYMKfLLMtEnnS5CRQjJfO8saUaFg4d/39?=
 =?us-ascii?Q?ZiNnxptVpWhJKwOCgYWYK1uookmDVioAp8dMdb7SaprrlZLhbJ8Qt03GCp/c?=
 =?us-ascii?Q?eOLkrZkKPW1Lm5frpYY1JZlIXhPJans0dmrm63pHbysj4Xfz5DyWBcefZYbw?=
 =?us-ascii?Q?dFpeAUOb2LFynt+rgll1qEk/GkRT8FvSIgXM4VfnDAiSrY2XC6/CarByDiBP?=
 =?us-ascii?Q?7uxI3DU7AOanB0Qd5hwH0sWOYJ9Ss0LlvI+sJ5+UmNhul6JUXn2JIcTsb4Gy?=
 =?us-ascii?Q?W6t3lrIxDg6ciV+MMONY9Id/f/wMP/79uJeGXnWbG57EZvEx+AGgTedqshZi?=
 =?us-ascii?Q?Ypdbk98cWV9V1Ysfy4MoUYCfJUsfr5yPPcob8LGPVyal5h48pMLcg107fCvz?=
 =?us-ascii?Q?0KVwGh0phClnlFxUJavxXJeDu9DDTiUzBheIUeVTmD8bvArTn8fLT8zT+s/+?=
 =?us-ascii?Q?GXkAKEm6bEn/qTCbdE7LYaGv9yHSbowkUYcWEP7LwnZjifDRtsLR7HZR6xKR?=
 =?us-ascii?Q?NXZ687qOBNdGMHu/lOggqzNhdQQPFfSmblrL/TCloaZmd/3tFiZ0hkaMgqZL?=
 =?us-ascii?Q?cP/bxLnG+Y8/l6G2RKwuuqZuiNMW+AmVQbzfJx3vHCirAGsJJrtadFcp4CZ1?=
 =?us-ascii?Q?RmIRvgpGVCRthx1JRifPe//iQ1TZZGpe7B1QgKEDV3QYdHAYveS1xGu+e+Xj?=
 =?us-ascii?Q?r5oHn11VNpVAR+tReH2G+8EpyJHBjP9pJu3UNdSbOEfo0vE2qv++LCEYMksP?=
 =?us-ascii?Q?CD4syTdRCLJ4nVvBOoumc/RxLIhMxFTmrdEyks5zUXHU0I6YiTvRg3F4dJUB?=
 =?us-ascii?Q?+lLhPBsS8E66kKF4yGjd7LE8bI9NuDu5tOC+F88w9nkyBggXf9WIFUsm7++A?=
 =?us-ascii?Q?fStMlVM8HOGUtYKoTMmZcmEqcj6I0PezXvdOyM/5vZRgh6/6jI/tM0Pgnl9a?=
 =?us-ascii?Q?9k7i909rGokAvxnM/oTPm8U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABB092803FAA42418A321375316F0364@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45265ec8-e5fc-4eaf-41cb-08da0376fe7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 15:51:23.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGqsJDll8o+Eh9NsIyHFpex/VXybvwr9DjCHPqYCxwbCDfiCazCRbx3e1YTsGbLrbSg1+CYglYyPXoLET5dFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1047
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 11, 2022 at 05:25:50PM +0300, Serge Semin wrote:
> Hello Niklas

Hello Serge,

>=20
> On Tue, Mar 01, 2022 at 11:17:20AM +0000, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Simply deasserting reset just ensures that the hardware is taken out of
> > reset, if it was booted with the hardware reset asserted.
> >=20
> > In order actually reset the SPI controller, we need to assert reset bef=
ore
> > deasserting.
> >=20
> > By doing this, we ensure that the hardware is not in some bad state, an=
d we
> > ensure that the hardware registers get set to their reset default, clea=
ring
> > any setting set by e.g. a bootloader.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  drivers/spi/spi-dw-mmio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 5101c4c6017b..eb1dacb45ca2 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -289,6 +289,8 @@ static int dw_spi_mmio_probe(struct platform_device=
 *pdev)
> >  		ret =3D PTR_ERR(dwsmmio->rstc);
> >  		goto out_clk;
> >  	}
>=20
> > +	reset_control_assert(dwsmmio->rstc);
> > +	udelay(2);
>=20
> Do we really need this? dw_spi_add_host() is doing a sort of soft reset
> anyway by calling the dw_spi_hw_init() method. Do you have a real
> platform, which requires to do a full hard-reset?

Does this solve a real problem that I've seen with the SPI controller?
No.

Which register write in dw_spi_hw_init() is doing a soft reset?
I assume that you mean one of the writes in dw_spi_reset_chip(),
probably DW_SPI_SSIENR.
I don't think us toggling this register will reset all registers
to their reset default values.

I think it is a good to start off with all registers in their
default reset values.

Arguably, I think it looks wrong to see a reset_control_deassert()
without any previous reset_control_assert().

Do a simple:
git grep -C 10 reset_control_deassert drivers/spi/

And you see that most SPI drivers (and most other device drivers for
that matter), usually assert reset before deasserting it, in order
to ensure that a reset pulse is actually sent to the hardware.

Simply deasserting reset, will have the hardware in a "fresh" state
if it was a cold boot (where reset is usually asserted until deasserted),
but will not have the hardware in a "fresh" state if booted via a boot
loader. This is an inconsistency, and could potentially lead to issues
that are only noticed if booting via a bootloader.

>=20
> What about the self-reset based controllers?

Not sure what specific feature in the SPI controller you are
referring to.


Kind regards,
Niklas=
