Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9E40276A
	for <lists+linux-spi@lfdr.de>; Tue,  7 Sep 2021 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbhIGKzU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Sep 2021 06:55:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:48466 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343493AbhIGKzU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Sep 2021 06:55:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="207391451"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207391451"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 03:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="537919752"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2021 03:54:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 03:54:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 03:54:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 7 Sep 2021 03:54:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 7 Sep 2021 03:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPlr0EPTx+KANMVFbqZl+tNnIRtlVHWe6Ju2AfrXHjhp726vMRxean1lFyr3dHQUmELuVcbUUGK5fmXA8qfw5/8qwTzMXuit5T09gjTZ3VjqWNN9GaleIX54XdZaPKzP5JdyRriKln2LpyWeyJA2bNH5qBTVyTE9B3F6qMR+PiISMpoh8p+W/q9XLp6h3pYHv7R54N4ErrEdkPpNva/51LMCV78fHvl34yUHTqk/e9lGrZVzmuu/TrmamKcOmWfycJ7hYCfR1zew+cPzkkPN+GNwm950wVqzVOUCBDsle2wSVqH+IWmhCXDnTjuIq1x+xzNN5WzLxy2ZGXyl0zGUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tvlGC0+wU9E26tAgVEeOkqCmsljMF//DsUmNlZ3GLKI=;
 b=gR8JWEpPOpcVxRBQ7u/u/eHj9rD1nG/ihSTyFSW+/40CcTZGBwjtZ/wCldceNjSCqaoc+EKq4IEkve96rKcqVfYExlv+2yxk7BmLCSyx0QhzcwFyFmKtHTeBOKMhYhTliOVLHHv+fGGWRU1VJjiPxOHDJYGf4LOZPHMaPBgTbIrXZMvcGA+IaOCQyq33Uwbwn7FG6WspQIQwrT0aI48WOvFv8OOncAm1XByxoTkFTUvZwnIeyKS75fk2iqazuLOjgMPsdJSbmMTXICGpqYrquA6i816YWYFqTBAXJQUgbfzTSwfXxAyNRtUcS/VfKJTqeEy49CneMwuZvcZTPIsloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvlGC0+wU9E26tAgVEeOkqCmsljMF//DsUmNlZ3GLKI=;
 b=vtNs8P0ziGk2GaXz2/YWrif7JvV2sUGEXqYUrGROtuF8FRtprxAY57z4nSmOgdGlvxjis+k4ET5gbirXkVFXjX3g66xJSTBVrlLGOhtS6yGPFHC4E1ofA+Ed8ShEHT/ID3zNLbLkRYKM9stY+OMWgUVGEhOzSh9WaXgLXGUvCDo=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN7PR11MB2626.namprd11.prod.outlook.com (2603:10b6:406:b1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 10:54:11 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::4510:ed69:988c:a1ee]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::4510:ed69:988c:a1ee%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 10:54:11 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: RE: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Thread-Topic: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Thread-Index: AQHXmMZ/7kfVt44fxUqxTArbVjy05auVlJAAgALhwKA=
Date:   Tue, 7 Sep 2021 10:54:10 +0000
Message-ID: <BN0PR11MB572717A9D159F96E276712B385D39@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-3-nandhini.srikandan@intel.com>
 <20210905143356.z2xomprpgsknz3fb@mobilestation>
In-Reply-To: <20210905143356.z2xomprpgsknz3fb@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d657a2e-77c1-4fbf-73d8-08d971edd308
x-ms-traffictypediagnostic: BN7PR11MB2626:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2626022B349D44B96B1DC49685D39@BN7PR11MB2626.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sk2OguVm9OxexO+LXXHLdQhOq9hmprHcibVSdCFjL5cyA3lm6SVEzbtmh3WnpIzcnFVhMU0pAGDlWin2u6ItT+xRzz6X8ylhfPkLyVsajFpIc3Mwz7Y29iCz46uW71dVT0TOqtswivBFu/tAijPpIIE4jT/+tZt8BCi4Eq9xdKtaqKaYYsi2fWYvDceDNf7m2rdzMZfuFSfrAvQoRivpySxcv5hOLa8LYMvO2iBIzpSy/7+BtpaUEmzfn16RB2iQTrMh7qcGsjh9nh6V+gHLABgq/eHY1tmOwyZMpAlOPN6BkoCIv/3erBetT5/gU8okWi0PR+VJ8oCQESOQQVD12gTlQpEffhf2lFIaB6uWhHbtddyph+X3KHdOSCM1rwsB1HT5sPEeXJJ/OgOHhl/h/pnTKSxfh2WfxSv8lI0oBEIvzHN7II+b0gsVj9UNeoMjfFlCr56SVOjKtJ+79G+O2gSkVW8/F90ukkBnp9suJ4UKJQa2MLY+XNy44rWoLHKy9+Ecr65Md1wRRoSsIx/nyv1O4JO8g7CrB/X8hNXe/iiBmAjWubf5l7zhxXQAM20omxQANCJARJVNDwb9o81t5fXa3sRghctLeA6Wr1WKbYQEzpOZ9GKy+om6O7hGNQIvmgk6c+a7GwBXgeUNLUFdhp0jqLK/aU3Bdp5qjldumSzPiaGgJsBzIytsDESJYb8MrFYw3OgoliKCYq301HBvfELkCK40yapeUCaCvRXViB74z7Oqv3/H2k8gj1CQVA4Kr98B7uHZIHem0ryZ/lG7K5snATNskD8PpuGgYhBg/XA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(66476007)(478600001)(66946007)(53546011)(6506007)(9686003)(7696005)(966005)(66446008)(64756008)(66556008)(76116006)(4326008)(6916009)(55016002)(2906002)(8676002)(55236004)(38070700005)(186003)(26005)(54906003)(30864003)(86362001)(52536014)(71200400001)(316002)(5660300002)(122000001)(38100700002)(83380400001)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i8pGYquW2aA5pku+0I7yy/W2CqEAO4g7OYHPF0GGLY/tLjXTmx6rsfaoLzke?=
 =?us-ascii?Q?um/moVFzsJ9l3N6jWZa+jQTYkothQwe4rjynhq0fdkaLj6yO64fSurIhkFRl?=
 =?us-ascii?Q?bGE71g7ENr8aAjsMH1nh/5StoqHPlV/uDDM8e0DQl81qgkr74Qcueu3g5iKo?=
 =?us-ascii?Q?8wTmxqA22mGWV4AEduAR+/a8H4ANtG7W6B7q7VEyYycA6IWvt7Olh1CIrTqj?=
 =?us-ascii?Q?2GqURZHMC8kxJclbfgQ4cMHx8kPqg0rKeSVwKTpMJ7kUcEUMEQ8mDop3GS65?=
 =?us-ascii?Q?UFn+UYUvw3517jzj7wqXGq1AMpQtyT7eXc8n4SUxk1tW/1RWsSOnCA4rfXcn?=
 =?us-ascii?Q?hQo+oLsHX5V1Yd+tfg3Ol7IqiIbVHurH0zdIpU4bVcfdAyaF1Hiljvf6WmeD?=
 =?us-ascii?Q?dVW/tOPpFwnpmzEFv6mvHYpz97maaXycgy8gKv5DkSJRD6SXDfUU6wgehHcn?=
 =?us-ascii?Q?mEU2cjtLpdU9i5BDrVv0Ki+XhlCVMAR5Y9pbkE5dmBHz/7LEMb50PzHKT3Av?=
 =?us-ascii?Q?4104GdVUL3wHREauHoIp0jAvzQeH6E+596b+U6MbIB5cSkx/EV/N4J0+VD0G?=
 =?us-ascii?Q?3xX3QjZvZx0jy1KU1r7qZVEac59swij8fFQGh5W5P/XpI4LxNWNan1Gqm/Fv?=
 =?us-ascii?Q?gEbceEOXsBNkYjwLcHn14VPB29LqvZHDnwiYX0vV2r0njVxREZSulOC5bQ2N?=
 =?us-ascii?Q?k7WcqlLdwEWblztTR/p2ZkKImfocE2FUrANXvJBb0363D/5GL9WaLYFMkZp0?=
 =?us-ascii?Q?2l8ZSNqMF2kTmUkaGQ8BTzGNlhjb2yk+3rJppHqRD6pEX/3Rpq29a7dfB2Fw?=
 =?us-ascii?Q?KoRZOH2CUWVswQy8XiPWaUBLoGt/awFT7Pa9FDlJK7CDgnZPq1O2Nb5lEBpH?=
 =?us-ascii?Q?HkA5ztLCmzd8h5U6hKtzqIqCovBvtChx8u4cs85+yue2zkegXidC7h7XPJYa?=
 =?us-ascii?Q?8de7LyhWYdlzW79oE1O7dv3/KrfS1lRtBiHBK8d9TXZzu8iVcpm0yNtQ86/3?=
 =?us-ascii?Q?8x7iTmMEv6NRud6PRWTwcuAxzJ0pxiRQEfi4To7Cg//ZqeEEY4kTeLC+Nnlh?=
 =?us-ascii?Q?sT/UQ2yg8ytFXiJS1kzYrQDtUJkR8cVYR2pyO+ZbtR+79KkvZMuyKQkJEhBN?=
 =?us-ascii?Q?hCC858TIXqVUhQgezHPgN5qgYE0k1GnpI06g0XmGye2u6MDuM6gLlkP/f7QZ?=
 =?us-ascii?Q?zGcM/nPH4kl5UbsYbtudv87Ixlk4Zz9C2ybCxJehgtAGNDkv8S/BkRIfaPxR?=
 =?us-ascii?Q?fK5Q485cceW+xRq/Vl+7a5QrwBo9JHY1v+tf/NQKluzIq3Nsbivt5L35SoBG?=
 =?us-ascii?Q?URfIf4u0QehdT1OWqH1cxb8V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d657a2e-77c1-4fbf-73d8-08d971edd308
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 10:54:11.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptmuhdVxg6nd20hB/Qq+gEwakybn7D+LymzG6PLcy7zbr/0w+xCsdWxZCD5nb/yaaq3BEpnXSUvMEk371Y7ZbBpWyTaPvdYIQc6MGxc8f/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2626
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Sunday, September 5, 2021 8:04 PM
> To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SP=
I
>=20
> Hi Nandhini
>=20
> On Tue, Aug 24, 2021 at 04:58:56PM +0800, nandhini.srikandan@intel.com
> wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> >
> > Add support for Intel Thunder Bay SPI controller, which uses
> > DesignWare DWC_ssi core.
> > Bit 31 of CTRLR0 register is set for Thunder Bay, to configure the
> > device as a master or as a slave serial peripheral.
> > Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
>=20
> After reading your response to my v1 comments, I've got a better notion o=
f
> the features you are trying to implement here. Please see my comments
> below.
>=20
> >
> > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > ---
>=20
> Just to note for your future patchwork. Instead of having a single genera=
l
> changelog text in the cover letter it is much more convenient for reviewe=
rs to
> see both the summary changelog and a changelog of individual patches here
> under '---' delimiter.
Sure, I will add changelog for individual patches also.

>=20
> >  drivers/spi/spi-dw-core.c |  7 +++++--  drivers/spi/spi-dw-mmio.c |
> > 20 +++++++++++++++++++-
> >  drivers/spi/spi-dw.h      | 12 +++++++++---
> >  3 files changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index a305074c482e..f7d45318db8a 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -300,8 +300,11 @@ static u32 dw_spi_prepare_cr0(struct dw_spi
> *dws, struct spi_device *spi)
> >  		/* CTRLR0[13] Shift Register Loop */
> >  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> > DWC_SSI_CTRLR0_SRL_OFFSET;
> >
> > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > -			cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
>=20
> > +		if (dws->caps & DW_SPI_CAP_DWC_MST)
> > +			cr0 |=3D DWC_SSI_CTRLR0_MST;
>=20
> Since you've used a generic suffix here, are you sure the MST/SLV feature
> toggled by the BIT(31) bit is generic for all DWC SSI controllers?
> I am asking because I don't have DWC SSI IP manual, but there is a
> CTRL0 register layout posted by your colleague Wan Ahmad Zainie a year
> ago: https://patches.linaro.org/patch/214693/ . It doesn't have that bit
> defined.
>=20
> If you are and it's specific to all DWC SSI controllers of v1.01a and new=
er,
> then why not to implement that flag setting up in the framework of the
> "DW_SPI_CAP_DWC_SSI" capability? Thus we'd have all "snps,dwc-ssi-
> 1.01a"-compatible devices and devices with the DW_SPI_CAP_DWC_SSI flag
> set working well if for some reason they have got slave-mode enabled by
> default.

Intel Keem Bay and Thunder Bay uses v1.02a version of DWC SSI controller. A=
ccording to v1.02a, BIT31 of CTRLR0 is used for selecting Master or slave m=
ode. In earlier versions, it was reserved. Both Keem Bay and Thunder Bay ha=
s to work in master mode, so this bit is set. The dwc_ssi controller can ei=
ther function in master or slave (default) mode as per the spec. The bit31 =
requirement is only for Keem Bay and Thunder bay and other controllers can =
have a requirement to function in slave mode as well. Hence the bit is set =
only for Keem Bay/Thunder Bay. Please let me know if it should be set defau=
lt to master mode.
Wan Ahmed Zainie has posted that patch based on earlier version of the cont=
roller and later up streamed the DW_SPI_CAP_KEEMBAY_MST capability flag. Th=
is will become generic now.
>=20
> > +
> > +		if (dws->caps & DW_SPI_CAP_DWC_SSTE)
> > +			cr0 |=3D DWC_SSI_CTRLR0_SSTE;
>=20
> Regarding SSTE flag and feature implemented behind it. First of all AFAIC=
S
> from the Wan Ahmad Zainie post sited above it is indeed generic for both
> DWC SSI and DW APB SSI IP-cores of the controllers. Thus we don't need an
> additional DWC SSI capability flag defined for it, but need to have it
> generically implemented in the DW SPI core driver.
> Secondly as you said it two weeks ago it defines a slave-specific protoco=
l, the
> way the SSI and CLK signals are driven between consecutive
> frames:
> >> SSTE (Slave Select Toggle Enable)
> >> When SSTE bit is set to 1, the slave select line will toggle between
> >> consecutive data frames, with the serial clock being held to its
> >> default  value while slave select line is high.
> >> When SSTE bit is set to 0, slave select line will stay low and clock
> >> will  run continuously for the duration of the transfer.
> In general DWC SSI/DW APB SSI controller can be connected to slave device=
s
> with SSTE and normal communication protocol requirements at the same
> time by using different CS-lanes. Therefore the SSTE feature turns to be
> Slave/Peripheral-device specific rather than controller-specific and need=
s to
> be enabled/disabled when it's required by a slave device.
>=20
> Thus here is what I'd suggest to implement the SSTE feature generically:
> 1) Add a new SPI-slave Synopsys-specific DT-property into the bindings fi=
le
> like this:
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -143,6 +143,12 @@ patternProperties:
>            is an optional feature of the designware controller, and the
>            upper limit is also subject to controller configuration.
>=20
> +      snps,sste:
> +        description: Slave select line will toggle between consecutive
> +          data frames, with the serial clock being held to its default
> +          value while slave select line is high.
> +        type: boolean
> +
>  unevaluatedProperties: false
>=20
>  required:
>=20
> Please do that in a separate preparation patch submitted before the
> "dt-bindings: spi: Add bindings for Intel Thunder Bay SoC" patch in this
> series.
Sure, will modify SSTE as DT-property and do the necessary changes in both =
code and in DT.
>=20
> 2) Add that property support into the driver like this:
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c index
> a305074c482e..5caa74b9aa74 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -27,6 +27,7 @@
>  struct chip_data {
>  	u32 cr0;
>  	u32 rx_sample_dly;	/* RX sample delay */
> +	bool sste;		/* Slave Select Toggle flag */
>  };
>=20
>  #ifdef CONFIG_DEBUG_FS
> @@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>=20
>  static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi=
)  {
> +	struct chip_data *chip =3D spi_get_ctldata(spi);
>  	u32 cr0 =3D 0;
>=20
>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) { @@ -285,6 +287,9 @@
> static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>=20
>  		/* CTRLR0[11] Shift Register Loop */
>  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
> +
> +		/* CTRLR0[24] Slave Select Toggle Enable */
> +		cr0 |=3D chip->sste << SPI_SSTE_OFFSET;
>  	} else {
>  		/* CTRLR0[ 7: 6] Frame Format */
>  		cr0 |=3D SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET; @@
> -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct
> spi_device *spi)
>  		/* CTRLR0[13] Shift Register Loop */
>  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> DWC_SSI_CTRLR0_SRL_OFFSET;
>=20
> +		/* CTRLR0[14] Slave Select Toggle Enable */
> +		cr0 |=3D chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
> +
>  		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
>  			cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
>  	}
> @@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
>  		chip->rx_sample_dly =3D
> DIV_ROUND_CLOSEST(rx_sample_dly_ns,
>  							NSEC_PER_SEC /
>  							dws->max_freq);
> +
> +		/* Get slave select toggling feature requirement */
> +		chip->sste =3D device_property_read_bool(&spi->dev,
> "snps,sste");
>  	}
>=20
>  	/*
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> b665e040862c..2ee3f839de39 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -65,8 +65,10 @@
>  #define SPI_SLVOE_OFFSET		10
>  #define SPI_SRL_OFFSET			11
>  #define SPI_CFS_OFFSET			12
> +#define SPI_SSTE_OFFSET			24
>=20
>  /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
> +#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
>  #define DWC_SSI_CTRLR0_SRL_OFFSET	13
>  #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
>  #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
>=20
> Please also do that in a separate preparation patch.
>=20
> 3) If MST BIT(31) feature is generic, then please discard the
> DW_SPI_CAP_KEEMBAY_MST capability flag and set the MST bit for each
> DWC SSI device with DW_SPI_CAP_DWC_SSI capability set. If it's Intel-
> specific, then convert the DW_SPI_CAP_KEEMBAY_MST capability macro
> name to DW_SPI_CAP_INTEL_MST.
>=20
> Please also do that in a separate preparation patch.
The feature is for the controller version v1.02a and above. The controller =
can function on master or slave mode, default being slave mode. So, it is m=
odified to master only in Keem bay and Thunder bay.=20
The difference between v1.01a and v1.02a w.r.t CTRLR0 is BIT31 selection of=
 master/slave mode. Though the feature is generic but BIT31 is needed to be=
 set only for bay, I will rename the macros to a generic name.=20

>=20
> 4) After all of that you can add the "Thunder Bay SPI" controller support=
 into
> the DW SPI MMIO driver by placing the "intel,thunderbay-ssi" compatibilit=
y
> string into the OF-device table.
> Since both Thunder and Keembay SPIs are based on the same IP-core then
> you can just reuse the dw_spi_keembay_init() for both of them after
> renaming it to something like dw_spi_intel_init().
>=20
Sure, will do the same.

Regards,
Nandhini
>=20
> >  	}
> >
> >  	return cr0;
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 3379720cfcb8..2bd1dedd90b0 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -217,7 +217,24 @@ static int dw_spi_dwc_ssi_init(struct
> > platform_device *pdev,  static int dw_spi_keembay_init(struct
> platform_device *pdev,
> >  			       struct dw_spi_mmio *dwsmmio)  {
> > -	dwsmmio->dws.caps =3D DW_SPI_CAP_KEEMBAY_MST |
> DW_SPI_CAP_DWC_SSI;
> > +	/*
> > +	 * Set MST to make keem bay SPI as master.
> > +	 */
> > +	dwsmmio->dws.caps =3D DW_SPI_CAP_DWC_MST |
> DW_SPI_CAP_DWC_SSI;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> > +				  struct dw_spi_mmio *dwsmmio)
> > +{
> > +	/*
> > +	 * Set MST to make thunder bay SPI as master.
> > +	 * Set SSTE to enable slave select toggle bit which is required
> > +	 * for the slave devices connected to the thunder bay SPI controller.
> > +	 */
> > +	dwsmmio->dws.caps =3D DW_SPI_CAP_DWC_MST |
> DW_SPI_CAP_DWC_SSTE |
> > +			    DW_SPI_CAP_DWC_SSI;
> >
> >  	return 0;
> >  }
> > @@ -349,6 +366,7 @@ static const struct of_device_id
> dw_spi_mmio_of_match[] =3D {
> >  	{ .compatible =3D "renesas,rzn1-spi", .data =3D dw_spi_dw_apb_init},
> >  	{ .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_ssi_init=
},
> >  	{ .compatible =3D "intel,keembay-ssi", .data =3D dw_spi_keembay_init}=
,
> > +	{ .compatible =3D "intel,thunderbay-ssi", .data =3D
> > +dw_spi_thunderbay_init},
> >  	{ .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> >  	{ .compatible =3D "canaan,k210-spi", dw_spi_canaan_k210_init},
> >  	{ /* end of table */}
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > b665e040862c..9fffe0a02f3a 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -76,11 +76,16 @@
> >  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
> >
> >  /*
> > - * For Keem Bay, CTRLR0[31] is used to select controller mode.
> > + * CTRLR0[31] is used to select controller mode.
> >   * 0: SSI is slave
> >   * 1: SSI is master
> >   */
> > -#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
> > +#define DWC_SSI_CTRLR0_MST		BIT(31)
> > +
> > +/*
> > + * CTRLR0[14] is used to enable/disable Slave Select Toggle bit  */
> > +#define DWC_SSI_CTRLR0_SSTE		BIT(14)
> >
> >  /* Bit fields in CTRLR1 */
> >  #define SPI_NDF_MASK			GENMASK(15, 0)
> > @@ -122,9 +127,10 @@ enum dw_ssi_type {
> >
> >  /* DW SPI capabilities */
> >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > +#define DW_SPI_CAP_DWC_MST		BIT(1)
> >  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> >  #define DW_SPI_CAP_DFS32		BIT(3)
> > +#define DW_SPI_CAP_DWC_SSTE		BIT(4)
> >
> >  /* Slave spi_transfer/spi_mem_op related */  struct dw_spi_cfg {
> > --
> > 2.17.1
> >
