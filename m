Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42D3E8A1F
	for <lists+linux-spi@lfdr.de>; Wed, 11 Aug 2021 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhHKGQG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Aug 2021 02:16:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:11215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234729AbhHKGQG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Aug 2021 02:16:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214796032"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="214796032"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 23:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="675910898"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2021 23:15:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 23:15:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 23:15:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 23:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr7Q3vsLkAyl8rZ4e1BKxvcxNIQwoHX2syirO+Q8J6VCpd5RLIwFtMiONUzOHdJg+HJpuReXnj0/lrrTyD307UbjRe/tDBRJKyy87xK7S9vbaIPdMZOsKkQCfG5NIMxEKfV8JgPqnZI4ZE66HjjcUIqgoeYaJVBA8WH5WZSMal1DH9LnkbqK4yNQ0WyPwTQL6p2ZOw1zgpeFXxt90uSW1VAGx56wRzKGWU8zoyCx0a5Yrt9QOors7yhzJzJ9lS5uO98dCdCUC9wzLtR0yoY1vo3ugAK/rlsSCXZ+L3PmcQvHG6QwFheloULt1JJbalIERn0b1q/ee4cdm31upvs3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP71qiVE2YbmLfvrct0pxQaDzIlf1uUIoO8pCqy7jbU=;
 b=TP4vVJ6UOrNMbXjelmBrb2jPTbrbFETjhXQNx7OeiDQlopNihwONicANN8d7g8N5CkabU5vVQguMeIurF2fF1+nrOflkJS0y/KUeoDoWZKa8KxFGK8C1DrnrqPQFZ20nj4802VPEgJgRukSpsOnXYR2/xrAILQWcz89FR1O66RUFKJW5Jw5K+yBB3SUHo8jJSrJGkYdNVU/A6r8qRW7pPErhimv3KlEm77cYRZHvPV0CVw2K+UWgUEn5Hgana3P6q+TJUBAgREKLjyLmTQB0JT+eigPXd6oFtrhensPDOcfgB9JnvzSZzLF79DpAYTXC7tPGtriv72+7u7pegFeaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP71qiVE2YbmLfvrct0pxQaDzIlf1uUIoO8pCqy7jbU=;
 b=MPaU9RyizGCV8HuNl4rRxP0TqSs/SuFHyzhTh3fOZXRii2SgvlsAHHNxGkWPfgxLkXufhTI1AcGAylTFbFwQbEEJbUmd2/BDxbhvotVpVS6bBnFlsPKmpqvZINqi8l2lOri36ZgZOBCtgJRFQ3csK7R4KO7u7u7m5kCB/yp8m1M=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN6PR1101MB2099.namprd11.prod.outlook.com (2603:10b6:405:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 06:15:33 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::60d6:b84a:611a:8c49]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::60d6:b84a:611a:8c49%3]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 06:15:33 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
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
        "A, Rashmi" <rashmi.a@intel.com>
Subject: =?Windows-1252?Q?RE:_[=93PATCH=94_2/2]_spi:_dw:_Add_support_for_Intel_Thu?=
 =?Windows-1252?Q?nder_Bay_SPI?=
Thread-Topic: =?Windows-1252?Q?[=93PATCH=94_2/2]_spi:_dw:_Add_support_for_Intel_Thunder?=
 =?Windows-1252?Q?_Bay_SPI?=
Thread-Index: AQHXfrtL0kPrBk+pdkC+t3HvpmcbEqtPOdSAgABbPICAAEOtgIAeEENg
Date:   Wed, 11 Aug 2021 06:15:33 +0000
Message-ID: <BN0PR11MB57279C001349305911E529DE85F89@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
 <20210722053358.29682-3-nandhini.srikandan@intel.com>
 <20210722170435.y6fla7ixfgzwkje2@mobilestation>
 <CAHp75VeQ0Q174gUww0oqw9MmmE76AGMxcNLj4UkgjLZzhGy6Mw@mail.gmail.com>
 <20210723023321.h63awes3kyigu7mx@mobilestation>
In-Reply-To: <20210723023321.h63awes3kyigu7mx@mobilestation>
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
x-ms-office365-filtering-correlation-id: 8cf5e9c8-b22f-43c1-62c6-08d95c8f6d95
x-ms-traffictypediagnostic: BN6PR1101MB2099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB20996ECA62AAF0BBC3CB8AA885F89@BN6PR1101MB2099.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5g/oJgT4I86GelvC45bwgIUOtJMZNPoG5etpqU6q/UhqKfsqiv941VJiqgbIbNNd0SLeV7iK6pGFz9NvW9KvzBHYgz9DUChA4v97YWogQu9TGDqydT4tYsM2QmeugAqRx0hl0mfmHMduAE8mfbbtkJJuBLeo5SCVdWetH6xRFqx/VvzIXfi479A9H6Yxp9bjsJd/Gf3I4KoG7jzOAJsXs4Ve7nb9Xa3lH7cpn0RD560jvtSxUSBF7OBFUT4W7PRLipUUexCuwtpPoXp1I0Ko5H19GC5zZrPqfNQx7I/awknbztJV2VscXb/Ds2XnMgKNrjWnCIZQw/Iq4zL40HrzIf3p+K9F8iD/LFcXJdjUOkyosZEkpQeKMahpH7P/gWSx4dGLjZIoWLRyc6xIpG6XqscH8ee5ZykRMu/427+MulEbpK6X8wrZ71JwGSJrAC8gEgOVuuF9DUSuT1KDNvZ+EiLOgWmfJjgYZhZwadsk0+U+KaMHJwQQ9+Y8b4evi4zqOs28Vxgh93U+tfIn4Fncfta9vsD6u4SR7eIbPMZX5U5eyxrkqD1m+Vtf36RmqQ0cqY1zX0IgevSiIoYG1S8nMUmavcdaE+qOZNY/wAaT4AO+vs1PgUzxJeUDe2YeBTVSXC2UnhCnYKjMzo3zX/IH9VC015OQsr3/0k0bXVpplKqaBr6ECsFH9UmwycMq6zIXq/zI1ljfE+tXDfr7RUZng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(6506007)(478600001)(30864003)(52536014)(2906002)(53546011)(4326008)(55236004)(38100700002)(86362001)(33656002)(122000001)(5660300002)(8936002)(71200400001)(26005)(316002)(64756008)(83380400001)(186003)(66446008)(66476007)(110136005)(55016002)(66556008)(7696005)(54906003)(38070700005)(66946007)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?YuVD4fbJbM+SYp3hS4b7Niw3q24oCv66NYdciHzuae0W0PHOMa4ZvbZs?=
 =?Windows-1252?Q?JBO+XYwrfZjhr3HWouQjgDwGilfu0taLdRTCsKs7tgFnZBAFfR90nXYJ?=
 =?Windows-1252?Q?NupOImELUAjiiTZ6qC5YmM64qsB5+Jy+pmS0tLrV7skP76iVRHvpv7eS?=
 =?Windows-1252?Q?3jsi95TXRbgmASCiHmH//9k2ygLRfQdZGnIVpq2WdctO5lHHlOfJkSAM?=
 =?Windows-1252?Q?zwZqFdJPH4IvQTpNCs6thDqUPipoyFwCe3qv7GrgVOaH4vfxwAd8KaZP?=
 =?Windows-1252?Q?oee4S8TnDWUzUdClSjkrNZYL4YhIzLDptFvmj5tGxhdJYpw5CZR7+JFd?=
 =?Windows-1252?Q?8sliRgBoujvJIhs2VcedQC1Fat/XHAtoWhhO5aLvbkoA/+lQpgIRCKiy?=
 =?Windows-1252?Q?TVq9XJM83uGHEhfDMGb4BsnaLILKZ1OrFmi0ZWULxsDrAHLlaKTap0o9?=
 =?Windows-1252?Q?PwFLGBbpLO4PXQUc2/L7r8afqgMdOwNx3L0hGWCb6IuwRwTdwMWpdAfb?=
 =?Windows-1252?Q?Dpt/9hZCuP4oyB63hMRe4jdXu0HokbYr4JINaXY7RL9jnrGUPf8vMKIN?=
 =?Windows-1252?Q?sxjAre2vYhDKezYCd/dlmLZPBmvtYjTtmNEiGh6sSYyj/iK3TlCS4FLJ?=
 =?Windows-1252?Q?mtYyN3mwk2ejUl8Ox7MYfGNS4D644r+IB52QR+I6tuJTgO8qYpiYQcaj?=
 =?Windows-1252?Q?6puikY3eo+uFjFhta8hR/pF6jwBPoU6xA7b+2stspOxSPQxCyt6jy+Jy?=
 =?Windows-1252?Q?rXZB8HqTmd7dLpgA7xHE3G8Yq1ImOH7/cYn7WiS1oW5INL9RwbEhiaX9?=
 =?Windows-1252?Q?sCECvyhMTV4hqSVxZ2k3uTJ4PwlAPQK0OjRGt7P/VVQALOOZFoeDsoYm?=
 =?Windows-1252?Q?2RObzsLMZR7jwiT3kCUfcEfAVjubVYaOKAiTMVe9sbzozXnhQL2nlD/I?=
 =?Windows-1252?Q?Qr3/q8gFauqIMZUeMTGqjLx3PzGCVbYcjuZMHSyeuvqzBExoZHdxRDCD?=
 =?Windows-1252?Q?yJPx4MXm60MPhGTVT+TNKwnq7EeZMw6gnttvr0Ivx/uv96nPWRbCKDvg?=
 =?Windows-1252?Q?yyBC24Rn/el7lH5uHz8OO6C/GG3LrvgcGuqbOXbqG2xsV/8/TMIMSqRO?=
 =?Windows-1252?Q?jvWXCPZg0JQXZFr+1MO3uxyRRrc7+tW8NitrPGXR3KPHv7e8/1ZkLOxO?=
 =?Windows-1252?Q?qZFFLoXd5EKzPYaoksFfjMqJjXsBkWMe63kLglNxQPK8IGV1Tk4Qbgyc?=
 =?Windows-1252?Q?zZPMcv0deThBspDOvhJcyGRGo4UPE9Bru/gn0M971geLLhnoyHnoRbR1?=
 =?Windows-1252?Q?cNnCD/zfEqq46eAhjHyFQq/jIJWApsqyLCrnbSnVBvWGbLAqElISvfRv?=
 =?Windows-1252?Q?RaJYwDHvjmGKnLNu8NdxyPBTrKfFl97lqbsy25UDoQsbFzlQ6J9FojOw?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5e9c8-b22f-43c1-62c6-08d95c8f6d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 06:15:33.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RB3Sxa3/u4rrX0zoHVYb4JSSJsMWScMvhP0AMFWbSnqLT+eUBCTpsQMl2kEht5IYsto+7J5jZkQcwZkPid+o8TDa1q9MOareJV8a4pDW2MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2099
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Friday, July 23, 2021 8:03 AM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Srikandan, Nandhini <nandhini.srikandan@intel.com>;
> broonie@kernel.org; robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [=93PATCH=94 2/2] spi: dw: Add support for Intel Thunder Bay=
 SPI
>=20
> On Fri, Jul 23, 2021 at 01:31:07AM +0300, Andy Shevchenko wrote:
> > On Thursday, July 22, 2021, Serge Semin <fancer.lancer@gmail.com>
> wrote:
> >
> > > On Thu, Jul 22, 2021 at 01:33:58PM +0800,
> > > nandhini.srikandan@intel.com
> > > wrote:
> > > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > >
> > > > Add support for Intel Thunder Bay SPI controller, which uses
> > > > DesignWare DWC_ssi core.
> > > > Bit 31 of CTRLR0 register is added for Thunder Bay, to configure
> > > > the device as a master or as a slave serial peripheral.
> > >
> > > > Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
> > >
> > > Could you elaborate what this bit mean?
SSTE (Slave Select Toggle Enable)
When SSTE bit is set to 1, the slave select line will toggle between consec=
utive data frames, with the serial clock being held to its default value wh=
ile slave select line is high.
When SSTE bit is set to 0, slave select line will stay low and clock will r=
un continuously for the duration of the transfer.=20

This bit is needed for SPI-slave devices like TPM used in Thunder Bay, whic=
h needs SSTE bit to be set in order to work.=20
Hence SSTE is enabled only for Thunder Bay.

- Nandhini
> > >
> > > > Added reset of SPI controller required for Thunder Bay.
> > >
> > > If it's really required (is it?) then you were supposed to reflect
> > > that in the code by returning a negative error if the driver fails
> > > to retrieve the reset control handler. In accordance with that the
> > > bindings should have been also updated so the dtbs_check procedure
> > > would make sure the Thunder Bay SPI DT-node comply to the
> > > requirements in that matter.
> > >
The existing reset code in spi-dw-mmio.c file will be reused to de-assert t=
he SPI core by passing reset-names =3D "spi" in DTB. So the reset code adde=
d here will be removed.

- Nandhini

> > > Anyway I've got a few comments regarding this part of your patch.
> > > Please see them below.
> > >
> > > >
> > > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > > ---
> > > >  drivers/spi/spi-dw-core.c |  6 ++++++  drivers/spi/spi-dw-mmio.c
> > > > | 20 ++++++++++++++++++++
> > > >  drivers/spi/spi-dw.h      | 15 +++++++++++++++
> > > >  3 files changed, 41 insertions(+)
> > > >
> > > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > > index a305074c482e..eecf8dcd0677 100644
> > > > --- a/drivers/spi/spi-dw-core.c
> > > > +++ b/drivers/spi/spi-dw-core.c
> > > > @@ -302,6 +302,12 @@ static u32 dw_spi_prepare_cr0(struct dw_spi
> > > > *dws,
> > > struct spi_device *spi)
> > > >
> > > >               if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > >                       cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
> > > > +
> > >
> > > > +             if (dws->caps & DW_SPI_CAP_THUNDERBAY_MST)
> > > > +                     cr0 |=3D DWC_SSI_CTRLR0_THUNDERBAY_MST;
> > >
> > > I guess that KeemBay and ThunderBay SPI controllers have been
> > > synthesized based on the same IP-core with a few differences. Is
> > > that true? Could you tell us what is the difference between them?
> > >
> > > Anyway regarding this the Master/Slave part. Is the ThunderBay
> > > implementation of the Master/Slave capability the same as it was
> > > embedded in the KeemBay controller? If so then what do you think
> > > about just renaming DW_SPI_CAP_KEEMBAY_MST to something like
> > > DW_SPI_CAP_INTEL_MST and using it then for both Keembay and
> > > ThunderBay versions of the SPI-controllers? (The similar renaming
> > > needs to be provided for the DWC_SSI_CTRLR0_KEEMBAY_MST macro
> then.)
> > > You can implement it as a preparation patch posted before this one
> > > in the series.
> >
> >
>=20
Yes, they are synthesized based on Designware SPI IP core.=20
The master/slave capability is same for both Keem Bay and Thunder Bay.=20
Hence I will rename the macros and make the code generic and it will be par=
t of upcoming patch.

- Nandhini

> >
> > Please, if you go this way add some more specific definition, b/c this
> > IP is being used on other intel SoCs which have nothing to do with thes=
e
> two.
> >
>=20
> Does it have the same Master/Slave capability? If it does then we can sti=
ck
> with suggested name like DW_SPI_CAP_INTEL_MST, which could be
> perceived as "Intel-specific MST capability implemented for DW SPI".
> If it doesn't then does it have another type of the Master/Slave capabili=
ty? If
> it does, then indeed we need to think on a better naming here. What name
> would you suggest in that case?
>=20
> -Sergey
>=20
Since both Keem Bay and Thunder Bay has same Master/Slave capability, I wil=
l keep the macro names generic.

- Nandhini=20

> >
> > >
> > > > +
> > > > +             if (dws->caps & DW_SPI_CAP_THUNDERBAY_SSTE)
> > > > +                     cr0 |=3D DWC_SSI_CTRLR0_THUNDERBAY_SSTE;
> > >
> > > Similar question regarding the SSTE bit. Is it something ThunderBay
> > > specific only? Was the corresponding functionality embedded into the
> > > KeemBay or any other Intel version of the DW SPI controller?
> > >
SSTE bit is needed only for slave devices like TPM which are connected on T=
hunder Bay.=20
There is no such slaves with this SSTE requirement on Keem Bay.

- Nandhini

> > > >       }
> > > >
> > > >       return cr0;
> > > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > > index 3379720cfcb8..ca9aad078752 100644
> > > > --- a/drivers/spi/spi-dw-mmio.c
> > > > +++ b/drivers/spi/spi-dw-mmio.c
> > > > @@ -222,6 +222,15 @@ static int dw_spi_keembay_init(struct
> > > platform_device *pdev,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> > > > +                               struct dw_spi_mmio *dwsmmio) {
> > >
> > > > +     dwsmmio->dws.caps =3D DW_SPI_CAP_THUNDERBAY_MST |
> > > DW_SPI_CAP_THUNDERBAY_RST |
> > > > +                         DW_SPI_CAP_THUNDERBAY_SSTE |
> > > DW_SPI_CAP_DWC_SSI;
> > > > +
> > >
> > > Originally the DW_SPI_CAP-functionality was provided to modify the
> > > DW SPI core driver behavior when it was required. For instance it
> > > was mostly connected with the platform-specific CR0-register
> > > configurations. So as I see it the reset part can be successfully
> > > handled fully in the framework of the MMIO-platform glue-driver.
> > > Instead of defining a new capability you could have just added the
> > > next code in the ThunderBay init-method:
> > >
> > > +       if (!dwsmmio->rstc) {
> > > +               dev_err(&pdev->dev, "Reset control is missing\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       reset_control_assert(dwsmmio->rstc);
> > > +       udelay(2);
> > > +       reset_control_deassert(dwsmmio->rstc);
> > > +
> > >
> > > Thus you'd reuse the already implemented reset-controller handler
> > > defined in the dw_spi_mmio structure with no need of implementing a
> > > new capability.
> > >
The existing reset code in spi-dw-mmio.c will be reused.=20
So, this portion of the code will be removed in upcoming patch.

-Nandhini

> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> > > >                                  struct dw_spi_mmio *dwsmmio)  {
> > > > @@ -243,6 +252,7 @@ static int dw_spi_mmio_probe(struct
> > > > platform_device
> > > *pdev)
> > > >                        struct dw_spi_mmio *dwsmmio);
> > > >       struct dw_spi_mmio *dwsmmio;
> > > >       struct resource *mem;
> > > > +     struct reset_control *rst;
> > > >       struct dw_spi *dws;
> > > >       int ret;
> > > >       int num_cs;
> > > > @@ -309,6 +319,15 @@ static int dw_spi_mmio_probe(struct
> > > > platform_device
> > > *pdev)
> > > >                       goto out;
> > > >       }
> > > >
> > >
> > > > +     if (dws->caps & DW_SPI_CAP_THUNDERBAY_RST) {
> > > > +             rst =3D devm_reset_control_get_exclusive(&pdev->dev, =
NULL);
> > > > +             if (!IS_ERR(rst)) {
> > > > +                     reset_control_assert(rst);
> > > > +                     udelay(2);
> > > > +                     reset_control_deassert(rst);
> > > > +             }
> > > > +     }
> > > > +
> > >
> > > Please see my comment above. We don't need to have this code here if
> > > you get to implement what I suggest there.
> > >

Since, existing reset code will be reused, this reset code will be removed =
as mentioned earlier.

- Nandhini

> > > >       pm_runtime_enable(&pdev->dev);
> > > >
> > > >       ret =3D dw_spi_add_host(&pdev->dev, dws); @@ -349,6 +368,7 @@
> > > > static const struct of_device_id
> > > dw_spi_mmio_of_match[] =3D {
> > > >       { .compatible =3D "renesas,rzn1-spi", .data =3D dw_spi_dw_apb=
_init},
> > > >       { .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_=
ssi_init},
> > > >       { .compatible =3D "intel,keembay-ssi", .data =3D
> > > > dw_spi_keembay_init},
> > > > +     { .compatible =3D "intel,thunderbay-ssi", .data =3D
> > > dw_spi_thunderbay_init},
> > > >       { .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_=
init},
> > > >       { .compatible =3D "canaan,k210-spi", dw_spi_canaan_k210_init}=
,
> > > >       { /* end of table */}
> > > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > > b665e040862c..bfe1d5edc25a 100644
> > > > --- a/drivers/spi/spi-dw.h
> > > > +++ b/drivers/spi/spi-dw.h
> > > > @@ -82,6 +82,18 @@
> > > >   */
> > > >  #define DWC_SSI_CTRLR0_KEEMBAY_MST   BIT(31)
> > > >
> > >
> > > > +/*
> > > > + * For Thunder Bay, CTRLR0[14] should be set to 1.
> > > > + */
> > >
> > > Could you provide a bit more details what this bit has been
> > > implemented for?
> > >
> > > > +#define DWC_SSI_CTRLR0_THUNDERBAY_SSTE       BIT(14)
> > > > +
> > >
> > > > +/*
SSTE (Slave Select Toggle Enable)
When SSTE bit is set to 1, the slave select line will toggle between consec=
utive data frames, with the serial clock being held to its default value wh=
ile slave select line is high.
When SSTE bit is set to 0, slave select line will stay low and clock will r=
un continuously for the duration of the transfer.

> > > > + * For Thunder Bay, CTRLR0[31] is used to select controller mode.
> > > > + * 0: SSI is slave
> > > > + * 1: SSI is master
> > > > + */
> > > > +#define DWC_SSI_CTRLR0_THUNDERBAY_MST        BIT(31)
> > >
> > > Please see my suggestion regarding the Master/Slave capability in
> > > one of the comments above.
> > >
Sure, this will be renamed in a generic way.

- Nandhini

> > > Regards
> > > -Serge
> > >
> > > > +
> > > >  /* Bit fields in CTRLR1 */
> > > >  #define SPI_NDF_MASK                 GENMASK(15, 0)
> > > >
> > > > @@ -125,6 +137,9 @@ enum dw_ssi_type {
> > > >  #define DW_SPI_CAP_KEEMBAY_MST               BIT(1)
> > > >  #define DW_SPI_CAP_DWC_SSI           BIT(2)
> > > >  #define DW_SPI_CAP_DFS32             BIT(3)
> > > > +#define DW_SPI_CAP_THUNDERBAY_MST    BIT(4)
> > > > +#define DW_SPI_CAP_THUNDERBAY_RST    BIT(5)
> > > > +#define DW_SPI_CAP_THUNDERBAY_SSTE   BIT(6)
> > > >
> > > >  /* Slave spi_transfer/spi_mem_op related */  struct dw_spi_cfg {
> > > > --
> > > > 2.17.1
> > > >
> > >
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko

Regards,
Nandhini=20
