Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8794DB232
	for <lists+linux-spi@lfdr.de>; Wed, 16 Mar 2022 15:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbiCPOMl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Mar 2022 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbiCPOMk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Mar 2022 10:12:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F943C48A
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647439884; x=1678975884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AX80wIVy8REBdeHM5FxJhc0Lhik3VxE9+ifa5WW9rqc=;
  b=Yq4wTifunOBmAjJ1KvGj+ixfer4a/KSsvd53f+RUNlgY/5WrfsjUD/yn
   7tNs4Tt5RatbGHwod6Uf0MqFPx9bWWqXhMAW7YeCYLFCvl41bBwm21crc
   G4ZB1lMXLsUblWXqfktEKrXjog3loj8AJbdKewgZj+gVnkIWGd7DwaFDN
   3uV2VaYEBnh3YfYTbbyqykogQGfwu3TnHQlpYggS9kL19w1oXmbV0YsbU
   WQnYFakmmhSklxH2Vx1LLlsfpWVuVCYAR3f/gHSG2WjHHmenBNTTAO1vh
   qpeATtFJiJPSizTISVpeFxjWHX+2/L7BKskUvgr/JK85/U2/DUO2q4MXP
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="200354528"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 22:11:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+TSPbwL6I4XhL4NJvS/WIy/X9M4o+YWzXltUSH7o78MjaPXil54qRVqQhKI0976wtNpVvWTP4iW4s4DIodHG0DrH8q5PEohtgDYvJDti+40qtLhkaZ4NUWMd69Z5tw8z9vLhrLTmfiQYhq9asV0W5DGux0hCHB+UxZQjkU1MG+YAHCI/2lcKbsPr49I5rP/6QEOD+uLKvHKtBajQNDJqILdMRrfj0RM6H1Gvk8dUeYnIRhsr6roDaPU/nCmHSNr05MmYneX+Zvg143NoKQTh6NmVIb9ikZpc7x69Oicmjq2lLj5SezpGkx/vHVWvoBfpafcnCzz/cgWWfLI+EEgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuPhMyg0quxvGDoyv+6C9oyYlEVVUt43UrlwX9Th5gE=;
 b=nULvtYpW6zzyj15eRuiebFIJG+s27/U0YKZ+sO8DcMr9kOfZxCUjFr4a1E1Z0M01rwpYmYafNaZ2rRSAzF56NQb3AVSNacAZFvjV4jJO556EiLHJ5DWGwScwLv1p11hZGSQIoyswCf2gYuISG0p9cWpdlhFw18rq7BlzACJPSUn24R2ZDzUqz7MEb4rWh8TKhPAm6mfaQmdXqkk6IaW2faup4UMjD5B28AgpdI3jBssUyDRlBr3GE9ZpqCJMhYpCRyuTK8BZBl6f5YNtjEW5ZLRHQHc/gZhxJ7b1AvbLsSYrlO6cG8GOSXNq5I2zIfKc42N7bzcS2mNkIKJ2zco9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuPhMyg0quxvGDoyv+6C9oyYlEVVUt43UrlwX9Th5gE=;
 b=XD7zPwIJ62DYpyQ0oIEokRGwDyTIBpBeiOnf3HS7cRDuvF/Vx5e0zcGniDddOOqn7tPiTrSBQXNbTnqvzBRy5G3IVswfoSQYvWTrgvTeClkEsKdDqBM4nDkmnsZAKZvqrZQllQwGrIDcveDSscAhGImnAvqGslYqfcJz1BIUj2o=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by DM6PR04MB3787.namprd04.prod.outlook.com (2603:10b6:5:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 16 Mar
 2022 14:11:23 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed%2]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:11:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Topic: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Index: AQHYLV3rnbk35M1FUEuh/urYvKkCb6y6TRQAgAAX5gCAABTXAIAHqt+A
Date:   Wed, 16 Mar 2022 14:11:23 +0000
Message-ID: <YjHwCcRW0kXMhiLk@x1-carbon>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
 <20220311142550.haw5jnrjycavr43m@mobilestation> <Yitv+tKTH2RpTV2K@x1-carbon>
 <20220311170558.5bj4vwbalufpmc3f@mobilestation>
In-Reply-To: <20220311170558.5bj4vwbalufpmc3f@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1651c28-c2eb-4e5a-eff2-08da0756da1f
x-ms-traffictypediagnostic: DM6PR04MB3787:EE_
x-microsoft-antispam-prvs: <DM6PR04MB37879DA6D64D56C3C082D0F3F2119@DM6PR04MB3787.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MffvqL98egJBvhsMRIoxjSXrhr8SOcdmjQx4XbmzAYFVe+Wx0ERhUi05Gv0QwgFJf7UMEupsb6L6QGB+RWvxttxM0eQjotCt7w3uiU0mmLi1+6Pg+H7tIJKvz7136DZ6ePHyDkFiabIqqxTxkjzanxVFcuKbJi91CKOCovTnD0zu41LTtIyAbrSxqhne2jmkrw4NJdTv6UqK8AaV/Xl38sH8OHux/NNkOkOG0zlNZIR6DDm3LEYzdI/vvHUQ5fbB4WhNNugznZN52/7iJj6i0oxSFJl1oRr3iqnfUw1g+mqXSFdxGOU16D4wi0S6UeZFfM+BvoAptxYfsp4o9IeHbvCaWLkmCkrgR3kRGIhzXxDuVPAWqbAh2JYLjx58dUKfk14ROcqjM0/YqlXrvXXfISsMw9cUHdQO7YsCDLiQqOMKD9+ptybcSQDGmQ3OL/wWUVYmGHPsMLczvKeuvucSIeSCwB8z0e73OJuH/L6d64BsSInxvFj/UFtOyJw+D/BF8EgLSpCnXtb1zKMUXjsZdoN/XL4EdtNmei90tcGCeU13l5LTXGl0Wp0snQUl/23K/aYXOajpj6P8mgJ6wRcPoQAcRP7Atccf87WV1roEQmpdTWoi07OWS6RYyPSHJrkij7mbgjRRgX8Sbtv31kIv8jLXZU+/1NAnhtXrECAIPc1IH2L3STm3nPQFAz3st1sYijz4Um2B/t9BG9K/8diNUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(26005)(83380400001)(38070700005)(8676002)(71200400001)(4326008)(508600001)(66556008)(6916009)(54906003)(66446008)(66946007)(66476007)(316002)(64756008)(91956017)(76116006)(6486002)(38100700002)(9686003)(5660300002)(8936002)(6506007)(2906002)(122000001)(82960400001)(86362001)(33716001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JsxuB3D9C0MyJm+ethIJetU9vfdYc4S41rNl4oH+yZ8goBJAbIdbF11ZmDXM?=
 =?us-ascii?Q?PzDl+kEyRkmmrn5AlC1ISlf1P7eZtGAdBv5jj4lQnSdUhb7QjKS4D4NaSVG9?=
 =?us-ascii?Q?8JZwIVEvBMFVIy7gX0KaMtaCbx4AhbgCNG9JRdbHg90nuwcIqmI6U5eSvdFr?=
 =?us-ascii?Q?iyK5K33P2neOxufLqr6xdJjGdfFfj3bDrOPfdlG0ra3mniFdROnN6kcsOJ34?=
 =?us-ascii?Q?esgw6vJLcu6vY7oTwYUFcVXkWFAYwg6acHQ6nWwP+f4hl2oT+SmMgKdwCNs8?=
 =?us-ascii?Q?TVN2V6NMm0dsAO61qDmuP8H2GLXddaVbZN3DJwJioTcY+oipsXf+1AkInPN7?=
 =?us-ascii?Q?FkKb+CDDKluccpyNJHsbRTjTDsaumwPyzlVu0VXrCXZ7TUTIDtl2IUgh5sgA?=
 =?us-ascii?Q?xx1Z7LyazLSNEbSZJ3AjS1c+U6aniEgdWW1J89ECZJU3cpIQ+bNLlgQmHLuS?=
 =?us-ascii?Q?gR20hJndnKUdWr+x0D91dTEFYThINjZpR7bHJqWiip3olpPmMy9cq+C4qmuR?=
 =?us-ascii?Q?WvDqE44WkxhvW7okJ0vrIa9fzgXVOFIGPnl2eUpwB+kT6PKFL5bMDgZerU1x?=
 =?us-ascii?Q?KTWMpdvRrtnjBbS4y/LbWVE9M5hIgoHOeu7/0a5u2Dj6QTx6oTxjysAd8QDU?=
 =?us-ascii?Q?ZvIiDjXb051BqRl5D8QMQXWqeT34Q8hc2FhOiRYKIw1eZIgzpi5SzkLbJ02F?=
 =?us-ascii?Q?aRWvNwk12ahrhQB4mlFcBlK8Bnlb8kPw1xsEblvt6l/qsdGHft5KyXEhn95T?=
 =?us-ascii?Q?58X8XSXZToivlWXVcJnZIMgjWFMmc9ZCgnc/jHqbuj16WVwtcrm7dKGeSMn6?=
 =?us-ascii?Q?DfhhOP16tCR9FbI2UOGKBv+IZTAbnNvBjjXAZnblUKm7JzkoGlimf8b4VJNP?=
 =?us-ascii?Q?M9oKV3ntzgV9Ypz6iv+aCJMrOYJNVY5oFDwXBP945rgUHxsp4qhe98KhkZV3?=
 =?us-ascii?Q?vffjD0j1HkZJfwPzIRaduhOrFFHsD/XJegsbyfQBQiXvH20HlHyz+z/kEh/3?=
 =?us-ascii?Q?/VSX5Q5YsfdkrkooJWKq3WL6nzSz9e1GNrHix1c/St/KxoMXyqlmTS0Uem52?=
 =?us-ascii?Q?rU1ZhirelhOTIkNj3+t30koe6boe4YGsKTHtpewjNhAWSF6s4pb3fYdxazhR?=
 =?us-ascii?Q?rJlevtE7wg81PJI4MrRZ1YsenFNnSTajboHBs6MDrGfMVscAA3zif6znEiXu?=
 =?us-ascii?Q?a1TNtltFGyyRG8hA1CXxW5aJMV8+ci4EV7gZBRB1S9uhBPBegZg3RAIWl4bh?=
 =?us-ascii?Q?C0RyHc0ZJpIs4GDeR49/UxUPQuSJTpx3CqXmUgiBSzbvnSSuImI2WUFTmR4T?=
 =?us-ascii?Q?TMISdYcTzxARTuf7HxMhyN/mlxjH6Me+2m1bg+MzJaSAwzqTGfYbvf7lG9AB?=
 =?us-ascii?Q?RZeGAhHuGZPJq0upNOMYyCL/YFInbpHUK1V9HA2zaTnNLr4KC1tqTOGhS9AE?=
 =?us-ascii?Q?kJRb5N8wDesXBpgwTrTM4oFWf0QD968czxN7JHrj2S1209LLAJ6ZmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29EC11E2F20E2B478E05B08B2952FB9E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1651c28-c2eb-4e5a-eff2-08da0756da1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:11:23.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xkBQ5sRcWFPPFbHCr9NsWoHB0skFVqCIiSxZalvr04E7PQdB7iAitV2P4QkAEWNWB3/rtc63ON7hMCwSjCnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3787
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 11, 2022 at 08:05:58PM +0300, Serge Semin wrote:
> On Fri, Mar 11, 2022 at 03:51:23PM +0000, Niklas Cassel wrote:
> > On Fri, Mar 11, 2022 at 05:25:50PM +0300, Serge Semin wrote:
> > > Hello Niklas
> >=20
> > Hello Serge,
> >=20
> > >=20
> > > On Tue, Mar 01, 2022 at 11:17:20AM +0000, Niklas Cassel wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > >=20
> > > > Simply deasserting reset just ensures that the hardware is taken ou=
t of
> > > > reset, if it was booted with the hardware reset asserted.
> > > >=20
> > > > In order actually reset the SPI controller, we need to assert reset=
 before
> > > > deasserting.
> > > >=20
> > > > By doing this, we ensure that the hardware is not in some bad state=
, and we
> > > > ensure that the hardware registers get set to their reset default, =
clearing
> > > > any setting set by e.g. a bootloader.
> > > >=20
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > ---
> > > >  drivers/spi/spi-dw-mmio.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > > index 5101c4c6017b..eb1dacb45ca2 100644
> > > > --- a/drivers/spi/spi-dw-mmio.c
> > > > +++ b/drivers/spi/spi-dw-mmio.c
> > > > @@ -289,6 +289,8 @@ static int dw_spi_mmio_probe(struct platform_de=
vice *pdev)
> > > >  		ret =3D PTR_ERR(dwsmmio->rstc);
> > > >  		goto out_clk;
> > > >  	}
> > >=20
> > > > +	reset_control_assert(dwsmmio->rstc);
> > > > +	udelay(2);
> > >=20
> > > Do we really need this? dw_spi_add_host() is doing a sort of soft res=
et
> > > anyway by calling the dw_spi_hw_init() method. Do you have a real
> > > platform, which requires to do a full hard-reset?
> >=20
> > Does this solve a real problem that I've seen with the SPI controller?
> > No.
> >=20
>=20
> > Which register write in dw_spi_hw_init() is doing a soft reset?
> > I assume that you mean one of the writes in dw_spi_reset_chip(),
> > probably DW_SPI_SSIENR.
> > I don't think us toggling this register will reset all registers
> > to their reset default values.
>=20
> Well, you are right it isn't a true soft reset, that's why I added
> "sort of".) Anyway after calling that method the main DW SSI registers
> are supposed to be in a known state. Of course it doesn't reset the
> controller RTL logic, and some of the CSRs will still be left randomly
> initialized in case of bootloader doings.
>=20
> >=20
> > I think it is a good to start off with all registers in their
> > default reset values.
> >=20
> > Arguably, I think it looks wrong to see a reset_control_deassert()
> > without any previous reset_control_assert().
> >=20
> > Do a simple:
> > git grep -C 10 reset_control_deassert drivers/spi/
> >=20
> > And you see that most SPI drivers (and most other device drivers for
> > that matter), usually assert reset before deasserting it, in order
> > to ensure that a reset pulse is actually sent to the hardware.
> >=20
> > Simply deasserting reset, will have the hardware in a "fresh" state
> > if it was a cold boot (where reset is usually asserted until deasserted=
),
> > but will not have the hardware in a "fresh" state if booted via a boot
> > loader. This is an inconsistency, and could potentially lead to issues
> > that are only noticed if booting via a bootloader.
> >=20
>=20
> No objection then seeing Mark is also inclined to have a full
> hard-reset cycle here too.
>=20
> > >=20
> > > What about the self-reset based controllers?
> >=20
> > Not sure what specific feature in the SPI controller you are
> > referring to.
>=20
> I am speaking about the reset-controller lines. They can be of two
> types: manually asserted/de-asserted and self-deasserted. It's
> platform-specific and mainly depends on the reset-controller
> implementation.
>=20
> Seeing you are adding a full-reset cycle anyway, I suggest to add a
> support for the both types of reset. Like this:
>=20
> #include <linux/delay.h>
> ...
>=20
> ret =3D reset_control_assert(dwsmmio->rstc);
> if (ret =3D=3D -ENOTSUPP) {
> 	ret =3D reset_control_reset(dwsmmio->rstc);
> } else if (!ret) {
> 	udelay(2);
> 	ret =3D reset_control_deassert(dwsmmio->rstc);
> }
> if (ret)
> 	goto out;
>=20
> * Please don't forget to add the include line.

Wow, that is ugly, and I only see one other driver doing it this way.
(All drivers in drivers/spi simply do assert() + udelay() + deassert()).

If this is the way to handle both reset control types, there should
probably be a common helper function in drivers/reset/core.c.

Right now, I'd rather drop this patch than being guilty of copy pasting
this pattern futher. (Considering that this patch does not solve any
known issue.)

Philipp Zabel, reset controller maintainer is already on CC, would be
nice to hear his point of view.


Kind regards,
Niklas=
