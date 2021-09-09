Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC140480C
	for <lists+linux-spi@lfdr.de>; Thu,  9 Sep 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhIIJw3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Sep 2021 05:52:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:12862 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhIIJw2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Sep 2021 05:52:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220772797"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="220772797"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 02:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="525311782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2021 02:51:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 9 Sep 2021 02:51:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 9 Sep 2021 02:51:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 9 Sep 2021 02:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/Bkx3ZHUAPMExE2GcU2XFods5lGY6IbeV/vmF38NZUwq0AML4qDmT+tuAhpD9Saapwfm0R2B1XHuIN8p5xwockhO4/npRXkCqZsybn52HoIiATBXUUbZbuyCOjTXy0+Gr6lFF1StHRBsm92HnA8LRwOIDNG1hofXIMYkxpZxAyN7JfPk/P7FCsYaPyi8xxk2hpz6KmL5VcIcQrBvOB9Gvj9j1O5L2Rz5qJI1UwQpBn2oysGPsrKBOQrcO0iMtwEZT5Xx2tYBvGxuYMNPH86FoSFF40AtbmFewyZ021ndiY9LJlNskR56+qXGpzvZGBYWAA0247D1HgGIQTDodohdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IjRpDJd8JuaPB4PsHcnAstt7eBPA7YYQg1jYojixEnM=;
 b=iUp8U8XxTRJ6Y0Q7fcqfZLBqvAJPOfLW5BGOaY6NOVT3aKL+vmMPjCFOLnRAtaRVP/k0pQo/UcMbRGbKRAZbOLwU0clroeQIjddsRjvrvQ4KyK0ntjSBFSQ8cR20WNoK972KmryFqoIRaih0SDAvtbZdgYJEPTGsOt4div69ViAzzL9/qkIybfsmmH7b3uTaoJwY6HaVwk+2qqE0TO+X/+V0UVg7fT1ZeO4mtu9xO7iGZmAs9D+fkbPuFuZfSrwOIqLqd+FZSiQ2c3TTIOdmcIlzAqQJYuFSG/MpLC0cfT3mDrVKs1QTdkbQWc9YGvEoQsxagDse4827bmAzDH1iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjRpDJd8JuaPB4PsHcnAstt7eBPA7YYQg1jYojixEnM=;
 b=DLcX1ASGhWcdb5QocF4kZSkCx1Wrb4CTQYzNic8znkLF+yP2V2QdmeU+dTrrcecfW8d4m2fzZkum48NcN9FmUmvT+AjvYJNLdeMPWX+6KtI9QC3SQjXP3hgkLWHcTc33THw0AhWSTFnRPiN7+KqBrTc7PaT4n4w67UlJqKnfQlA=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 09:51:10 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::4510:ed69:988c:a1ee]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::4510:ed69:988c:a1ee%9]) with mapi id 15.20.4500.015; Thu, 9 Sep 2021
 09:51:10 +0000
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
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Thread-Topic: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Thread-Index: AQHXmMZ/7kfVt44fxUqxTArbVjy05auVlJAAgALhwKCAAX/ygIABmCog
Date:   Thu, 9 Sep 2021 09:51:10 +0000
Message-ID: <BN0PR11MB5727C739A6A9F28A129941A185D59@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-3-nandhini.srikandan@intel.com>
 <20210905143356.z2xomprpgsknz3fb@mobilestation>
 <BN0PR11MB572717A9D159F96E276712B385D39@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210908092839.4n4wgx4nf7m2wji2@mobilestation>
In-Reply-To: <20210908092839.4n4wgx4nf7m2wji2@mobilestation>
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
x-ms-office365-filtering-correlation-id: 3e0e3a0d-be46-47ae-d124-08d973775a8f
x-ms-traffictypediagnostic: BN6PR11MB4049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4049DCBA3BDF1BC8366C567385D59@BN6PR11MB4049.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5P/X6NNgHFVHPg5FR2AJUmqkKnk59o4iUkJL+gDPvuLjqonqz4m5P1TQ24vnes68y8tisUM1hW15K0AwmbCy6KP/MFETk2+gKwaj3WD4Q85C6XBatIwMVQHegevf3h7zWOr7W1s0QNpiyXKVNQPIJZa5a9eCPOhYL9tG4urD3/1ZirXByY9U6Vk22cgxmsv6ib2vCanKaDM891rWC4oKIcGLEevqy0iNbbb80fopWusihEzBsQ+z06Xl01mvx9CtbPRHhdZ6eldpfwQXh0rGvgFhxXTsf7bdQ6N/B1+ktJXEZJnVHytzOaDM6c9n8wTE3mq45566Tx6x2SexR+EjCNln7ciGerdTQURMqVMJPgvzN1cgmcJiquGdw/xCk7yMWqx4yZKb7mqajtPpMhubaw7YYEG0wkaXsFj5QR/GUw4MDACTYhKFPuzLsDf6oLl9p/FTtpy22fy6+fz+bk6AlsM8BMklkOag7uI39uj1ApkhbVvcAWT5UmCPWkUIDNCnnlZyjZmJ8/743B3CQXmfXhdjwShp1z+8xGEjWtGNvODJ73XDSdvBZNuaYQXcgekl0I5y83+IUGsk+UznZ9sW0zbx40YjnhPnHehWGaZoN6VIB7smHalIHYXrf9/fbFjc46SK3RVsDKUcPLkpVaomV7Be/5Z5d0AkCmi5h3s1HXXN9+S9xCVRrC/7GmIepIFxi1Bg4bZF14pmJFti6/8zq1jb349n51BNXDohW2Rp2qDljE/wvyTUBGhKCiWxEOUY+Ih3LGX5JmQzduCJoibpLg0u+S624TTDTlua3v24zI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(8936002)(52536014)(38070700005)(55236004)(53546011)(122000001)(6506007)(966005)(76116006)(55016002)(478600001)(71200400001)(7696005)(66556008)(66476007)(8676002)(66446008)(64756008)(2906002)(66946007)(38100700002)(6916009)(26005)(86362001)(30864003)(5660300002)(186003)(83380400001)(54906003)(316002)(33656002)(4326008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oroFzt/r1AeFmneu9Sn2PPusrQzxOEt1GwmOvc8kq8Jwq8h56aUo4adAuVcG?=
 =?us-ascii?Q?5vptKaMRramYmF5vDlhnwtp7FXwAP3iderOdRumZQdTbRKvKi4h4VoJVlHqT?=
 =?us-ascii?Q?i2mz0M4/Y0MOSqRWi+UqcP9x6FHrK4bUWguqTM+ovMg7tFVxoo0HALb7nfTk?=
 =?us-ascii?Q?SdwRU2GAtAwj1ya3F42n0YLmuqCpeH3lXUAU1SnJ494qJR1263FmRKst4Hnb?=
 =?us-ascii?Q?ymVbnWZH3ZfrQia0QEWhfH80OZL6s8ASKbgfI6f81RUxB1XaY1sQTNIlh8A2?=
 =?us-ascii?Q?8feV5rP08c4AtfrAz1Jx2ERCJoyqsCXxDnqMBxTM2KyqfcqxsXDFRXL7ILO2?=
 =?us-ascii?Q?okAy64joeMKrnRjeQMrxBt6PuvuEiNktCMT9544fsDu9FQ6UtC9YiSKGeTab?=
 =?us-ascii?Q?Fljm/oFEsyliJJKW8NOJtagQobr8yEHlox5pG8ru+GahpdEKylkq7dci96VH?=
 =?us-ascii?Q?x1LOA/r6Bd2AKFALo1AYHWyZWFVB/A3z0av9jvplaQfdrg6J7ic2n2TnD3rZ?=
 =?us-ascii?Q?U7bPctjB8fJEmlAd/OZfJ3C0Ehq4oaKHhZjWWJYmsGgr1SNO7PVvqf/s4nl9?=
 =?us-ascii?Q?2OEiM1R4a2PFGJtarmx5Ojg2kgjiB9qy5ky2HZnCtn/nm9ou8WPOYqWGey0h?=
 =?us-ascii?Q?m4hggnD7EFS3/DPsnqDRQTReMfEXnbALvh3/k4BAtxWCL6rUuLt+afY8Vmon?=
 =?us-ascii?Q?ZS1Co3wsvu6xXFzfTKLWWtIuYuIZCq7USkyBDDOBFQePadFIvR3cC/CkjB5P?=
 =?us-ascii?Q?67MlMlPXVY33r603sLcFNo9RjNNz7Ifgq/hG8qWfg8nR0Z9pit22XS0WXFhZ?=
 =?us-ascii?Q?phGA/dPEWjQr3Zdkj703aZp/PNvyzXd5/VSGHhQeJRP8iz1wBTQy3xN4/7vJ?=
 =?us-ascii?Q?kK4gg11zWXs3qO6taYm5O6kX7y8js1lRal3qKD8nLjeRJwCrw1eFOyK1PxVW?=
 =?us-ascii?Q?yWsTqzK+sLiGTWMNuRw52WaFdhbD17Z6XT5WwJ7upL+aikp22HWGnE4tauTT?=
 =?us-ascii?Q?CbbTO67UXk/6ey9INw97KJl0k8YRVkbbzia+17JLt4T3lXa+AApLH0eKnSpY?=
 =?us-ascii?Q?tirpkXA9AHhrhTsz+EObV8PAgF1xpWbkJuAU1/uBrgyEE8Y9CuTno6r8xDOz?=
 =?us-ascii?Q?ry5aB5mBxOMLf7e93d/S1bgjg4XN2vCUS/gqwbVfU/YVpIzD4y5TIuk/5xrl?=
 =?us-ascii?Q?VaKls9QTCxkArH9I2KVdU5X28F0cIcN1AcB3zciDGoiUPqCkA9oxNpojLBz+?=
 =?us-ascii?Q?OrV3c1m4l32Py9jnSVNXXffUgnaYq7QChRp4tulzLeUv0pglDNFH6cUe4a3D?=
 =?us-ascii?Q?buRlkP3Ajt4z1kR/aHQqrmTF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0e3a0d-be46-47ae-d124-08d973775a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 09:51:10.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1zrBbEMklL3dg2xozg+rLvb3WPwrzDt30cs96kisSWVjBiHLzGoOqczvoNCFNH55YeA+DByKdNUreZJnV6G1FR2qajA3+uM1KR/6T4WtVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4049
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Wednesday, September 8, 2021 2:59 PM
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
> On Tue, Sep 07, 2021 at 10:54:10AM +0000, Srikandan, Nandhini wrote:
> >
> >
> > > -----Original Message-----
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > Sent: Sunday, September 5, 2021 8:04 PM
> > > To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>;
> > > broonie@kernel.org;
> > > robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>;
> > > Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>;
> Zhou,
> > > Furong <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > > Subject: Re: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder
> > > Bay SPI
> > >
> > > Hi Nandhini
> > >
> > > On Tue, Aug 24, 2021 at 04:58:56PM +0800,
> > > nandhini.srikandan@intel.com
> > > wrote:
> > > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > >
> > > > Add support for Intel Thunder Bay SPI controller, which uses
> > > > DesignWare DWC_ssi core.
> > > > Bit 31 of CTRLR0 register is set for Thunder Bay, to configure the
> > > > device as a master or as a slave serial peripheral.
> > > > Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
> > >
> > > After reading your response to my v1 comments, I've got a better
> > > notion of the features you are trying to implement here. Please see
> > > my comments below.
> > >
> > > >
> > > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > > ---
> > >
> > > Just to note for your future patchwork. Instead of having a single
> > > general changelog text in the cover letter it is much more
> > > convenient for reviewers to see both the summary changelog and a
> > > changelog of individual patches here under '---' delimiter.
> > Sure, I will add changelog for individual patches also.
> >
> > >
> > > >  drivers/spi/spi-dw-core.c |  7 +++++--  drivers/spi/spi-dw-mmio.c
> > > > |
> > > > 20 +++++++++++++++++++-
> > > >  drivers/spi/spi-dw.h      | 12 +++++++++---
> > > >  3 files changed, 33 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > > index a305074c482e..f7d45318db8a 100644
> > > > --- a/drivers/spi/spi-dw-core.c
> > > > +++ b/drivers/spi/spi-dw-core.c
> > > > @@ -300,8 +300,11 @@ static u32 dw_spi_prepare_cr0(struct dw_spi
> > > *dws, struct spi_device *spi)
> > > >  		/* CTRLR0[13] Shift Register Loop */
> > > >  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> > > > DWC_SSI_CTRLR0_SRL_OFFSET;
> > > >
> > > > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > > -			cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
> > >
> > > > +		if (dws->caps & DW_SPI_CAP_DWC_MST)
> > > > +			cr0 |=3D DWC_SSI_CTRLR0_MST;
> > >
> > > Since you've used a generic suffix here, are you sure the MST/SLV
> > > feature toggled by the BIT(31) bit is generic for all DWC SSI control=
lers?
> > > I am asking because I don't have DWC SSI IP manual, but there is a
> > > CTRL0 register layout posted by your colleague Wan Ahmad Zainie a
> > > year
> > > ago: https://patches.linaro.org/patch/214693/ . It doesn't have that
> > > bit defined.
> > >
> > > If you are and it's specific to all DWC SSI controllers of v1.01a
> > > and newer, then why not to implement that flag setting up in the
> > > framework of the "DW_SPI_CAP_DWC_SSI" capability? Thus we'd have all
> > > "snps,dwc-ssi- 1.01a"-compatible devices and devices with the
> > > DW_SPI_CAP_DWC_SSI flag set working well if for some reason they
> > > have got slave-mode enabled by default.
> >
>=20
> > Intel Keem Bay and Thunder Bay uses v1.02a version of DWC SSI controlle=
r.
> According to v1.02a, BIT31 of CTRLR0 is used for selecting Master or slav=
e
> mode. In earlier versions, it was reserved. Both Keem Bay and Thunder Bay
> has to work in master mode, so this bit is set. The dwc_ssi controller ca=
n
> either function in master or slave (default) mode as per the spec. The bi=
t31
> requirement is only for Keem Bay and Thunder bay and other controllers ca=
n
> have a requirement to function in slave mode as well. Hence the bit is se=
t
> only for Keem Bay/Thunder Bay. Please let me know if it should be set
> default to master mode.
> > Wan Ahmed Zainie has posted that patch based on earlier version of the
> controller and later up streamed the DW_SPI_CAP_KEEMBAY_MST capability
> flag. This will become generic now.
>=20
> I see. Thanks for clarification. IIUC BIT(31) is indeed specific to all D=
WC SSI
> (not only Keem/Thunder Bay SPI IPs) and indeed determines the
> Master/Slave mode of the controller. Then I don't really understand why
> Wan Ahmed didn't make it set generically in CR0 for all DWC SSI v1.01a
> instead of marking it as "intel,keembay-ssi"-specific seeing he provided =
a
> generic "snps,dwc-ssi-1.01a" compatible code in that same patchset.
>=20
> That decision might have been caused by having different default states o=
f
> CTRLR0.31 bit in generic DWC SSI and Keem/Thunder Bay SSI...
> Anyway I believe it won't hurt to set that bit for each DWC SSI especiall=
y
> seeing the DW APB SSI driver doesn't support the SPI slave mode at the
> moment. So please do that in a dedicated patch by converting the
> DWC_SSI_CTRLR0_KEEMBAY_MST macro to a generic DWC_SSI_CTRLR0_MST
> and applying it for CTRLR0.31 for each DW_SPI_CAP_DWC_SSI controller.
>=20
Sure, I will make the macro to a generic one and include it in the upcoming=
 patchset.

> > >
> > > > +
> > > > +		if (dws->caps & DW_SPI_CAP_DWC_SSTE)
> > > > +			cr0 |=3D DWC_SSI_CTRLR0_SSTE;
> > >
> > > Regarding SSTE flag and feature implemented behind it. First of all
> > > AFAICS from the Wan Ahmad Zainie post sited above it is indeed
> > > generic for both DWC SSI and DW APB SSI IP-cores of the controllers.
> > > Thus we don't need an additional DWC SSI capability flag defined for
> > > it, but need to have it generically implemented in the DW SPI core dr=
iver.
> > > Secondly as you said it two weeks ago it defines a slave-specific
> > > protocol, the way the SSI and CLK signals are driven between
> > > consecutive
> > > frames:
> > > >> SSTE (Slave Select Toggle Enable) When SSTE bit is set to 1, the
> > > >> slave select line will toggle between consecutive data frames,
> > > >> with the serial clock being held to its default  value while
> > > >> slave select line is high.
> > > >> When SSTE bit is set to 0, slave select line will stay low and
> > > >> clock will  run continuously for the duration of the transfer.
> > > In general DWC SSI/DW APB SSI controller can be connected to slave
> > > devices with SSTE and normal communication protocol requirements at
> > > the same time by using different CS-lanes. Therefore the SSTE
> > > feature turns to be Slave/Peripheral-device specific rather than
> > > controller-specific and needs to be enabled/disabled when it's requir=
ed
> by a slave device.
> > >
> > > Thus here is what I'd suggest to implement the SSTE feature generical=
ly:
> > > 1) Add a new SPI-slave Synopsys-specific DT-property into the
> > > bindings file like this:
> > > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > @@ -143,6 +143,12 @@ patternProperties:
> > >            is an optional feature of the designware controller, and t=
he
> > >            upper limit is also subject to controller configuration.
> > >
> > > +      snps,sste:
> > > +        description: Slave select line will toggle between consecuti=
ve
> > > +          data frames, with the serial clock being held to its defau=
lt
> > > +          value while slave select line is high.
> > > +        type: boolean
> > > +
> > >  unevaluatedProperties: false
> > >
> > >  required:
> > >
> > > Please do that in a separate preparation patch submitted before the
> > > "dt-bindings: spi: Add bindings for Intel Thunder Bay SoC" patch in
> > > this series.
> > Sure, will modify SSTE as DT-property and do the necessary changes in b=
oth
> code and in DT.
> > >
> > > 2) Add that property support into the driver like this:
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index
> > > a305074c482e..5caa74b9aa74 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -27,6 +27,7 @@
> > >  struct chip_data {
> > >  	u32 cr0;
> > >  	u32 rx_sample_dly;	/* RX sample delay */
> > > +	bool sste;		/* Slave Select Toggle flag */
> > >  };
> > >
> > >  #ifdef CONFIG_DEBUG_FS
> > > @@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void
> > > *dev_id)
> > >
> > >  static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device
> > > *spi)  {
> > > +	struct chip_data *chip =3D spi_get_ctldata(spi);
> > >  	u32 cr0 =3D 0;
> > >
> > >  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) { @@ -285,6 +287,9 @@
> > > static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device
> > > *spi)
> > >
> > >  		/* CTRLR0[11] Shift Register Loop */
> > >  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
> > > +
> > > +		/* CTRLR0[24] Slave Select Toggle Enable */
> > > +		cr0 |=3D chip->sste << SPI_SSTE_OFFSET;
> > >  	} else {
> > >  		/* CTRLR0[ 7: 6] Frame Format */
> > >  		cr0 |=3D SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET; @@
> > > -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws,
> > > struct spi_device *spi)
> > >  		/* CTRLR0[13] Shift Register Loop */
> > >  		cr0 |=3D ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> > > DWC_SSI_CTRLR0_SRL_OFFSET;
> > >
> > > +		/* CTRLR0[14] Slave Select Toggle Enable */
> > > +		cr0 |=3D chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
> > > +
> > >  		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > >  			cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
> > >  	}
> > > @@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
> > >  		chip->rx_sample_dly =3D
> > > DIV_ROUND_CLOSEST(rx_sample_dly_ns,
> > >  							NSEC_PER_SEC /
> > >  							dws->max_freq);
> > > +
> > > +		/* Get slave select toggling feature requirement */
> > > +		chip->sste =3D device_property_read_bool(&spi->dev,
> > > "snps,sste");
> > >  	}
> > >
> > >  	/*
> > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > b665e040862c..2ee3f839de39 100644
> > > --- a/drivers/spi/spi-dw.h
> > > +++ b/drivers/spi/spi-dw.h
> > > @@ -65,8 +65,10 @@
> > >  #define SPI_SLVOE_OFFSET		10
> > >  #define SPI_SRL_OFFSET			11
> > >  #define SPI_CFS_OFFSET			12
> > > +#define SPI_SSTE_OFFSET			24
> > >
> > >  /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
> > > +#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
> > >  #define DWC_SSI_CTRLR0_SRL_OFFSET	13
> > >  #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
> > >  #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
> > >
> > > Please also do that in a separate preparation patch.
> > >
> > > 3) If MST BIT(31) feature is generic, then please discard the
> > > DW_SPI_CAP_KEEMBAY_MST capability flag and set the MST bit for each
> > > DWC SSI device with DW_SPI_CAP_DWC_SSI capability set. If it's
> > > Intel- specific, then convert the DW_SPI_CAP_KEEMBAY_MST capability
> > > macro name to DW_SPI_CAP_INTEL_MST.
> > >
> > > Please also do that in a separate preparation patch.
>=20
> > The feature is for the controller version v1.02a and above. The control=
ler
> can function on master or slave mode, default being slave mode. So, it is
> modified to master only in Keem bay and Thunder bay.
> > The difference between v1.01a and v1.02a w.r.t CTRLR0 is BIT31 selectio=
n
> of master/slave mode. Though the feature is generic but BIT31 is needed t=
o
> be set only for bay, I will rename the macros to a generic name.
>=20
> Please, see my comment above. Let's set that bit for each DWC SSI control=
ler,
> so to have the driver protected from having the inverted default state on=
 any
> other vendor-specific controller.
>=20
Sure, I will set the bit for each DWC SSI controller.

Regard,
Nandhini=20
> >
> > >
> > > 4) After all of that you can add the "Thunder Bay SPI" controller
> > > support into the DW SPI MMIO driver by placing the
> > > "intel,thunderbay-ssi" compatibility string into the OF-device table.
> > > Since both Thunder and Keembay SPIs are based on the same IP-core
> > > then you can just reuse the dw_spi_keembay_init() for both of them
> > > after renaming it to something like dw_spi_intel_init().
> > >
>=20
> > Sure, will do the same.
>=20
> Thanks.
>=20
> Regards,
> -Sergey
>=20
> >
> > Regards,
> > Nandhini
> > >
> > > >  	}
> > > >
> > > >  	return cr0;
> > > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > > index 3379720cfcb8..2bd1dedd90b0 100644
> > > > --- a/drivers/spi/spi-dw-mmio.c
> > > > +++ b/drivers/spi/spi-dw-mmio.c
> > > > @@ -217,7 +217,24 @@ static int dw_spi_dwc_ssi_init(struct
> > > > platform_device *pdev,  static int dw_spi_keembay_init(struct
> > > platform_device *pdev,
> > > >  			       struct dw_spi_mmio *dwsmmio)  {
> > > > -	dwsmmio->dws.caps =3D DW_SPI_CAP_KEEMBAY_MST |
> > > DW_SPI_CAP_DWC_SSI;
> > > > +	/*
> > > > +	 * Set MST to make keem bay SPI as master.
> > > > +	 */
> > > > +	dwsmmio->dws.caps =3D DW_SPI_CAP_DWC_MST |
> > > DW_SPI_CAP_DWC_SSI;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> > > > +				  struct dw_spi_mmio *dwsmmio) {
> > > > +	/*
> > > > +	 * Set MST to make thunder bay SPI as master.
> > > > +	 * Set SSTE to enable slave select toggle bit which is required
> > > > +	 * for the slave devices connected to the thunder bay SPI control=
ler.
> > > > +	 */
> > > > +	dwsmmio->dws.caps =3D DW_SPI_CAP_DWC_MST |
> > > DW_SPI_CAP_DWC_SSTE |
> > > > +			    DW_SPI_CAP_DWC_SSI;
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -349,6 +366,7 @@ static const struct of_device_id
> > > dw_spi_mmio_of_match[] =3D {
> > > >  	{ .compatible =3D "renesas,rzn1-spi", .data =3D dw_spi_dw_apb_ini=
t},
> > > >  	{ .compatible =3D "snps,dwc-ssi-1.01a", .data =3D dw_spi_dwc_ssi_=
init},
> > > >  	{ .compatible =3D "intel,keembay-ssi", .data =3D
> > > > dw_spi_keembay_init},
> > > > +	{ .compatible =3D "intel,thunderbay-ssi", .data =3D
> > > > +dw_spi_thunderbay_init},
> > > >  	{ .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init=
},
> > > >  	{ .compatible =3D "canaan,k210-spi", dw_spi_canaan_k210_init},
> > > >  	{ /* end of table */}
> > > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > > b665e040862c..9fffe0a02f3a 100644
> > > > --- a/drivers/spi/spi-dw.h
> > > > +++ b/drivers/spi/spi-dw.h
> > > > @@ -76,11 +76,16 @@
> > > >  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
> > > >
> > > >  /*
> > > > - * For Keem Bay, CTRLR0[31] is used to select controller mode.
> > > > + * CTRLR0[31] is used to select controller mode.
> > > >   * 0: SSI is slave
> > > >   * 1: SSI is master
> > > >   */
> > > > -#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
> > > > +#define DWC_SSI_CTRLR0_MST		BIT(31)
> > > > +
> > > > +/*
> > > > + * CTRLR0[14] is used to enable/disable Slave Select Toggle bit  *=
/
> > > > +#define DWC_SSI_CTRLR0_SSTE		BIT(14)
> > > >
> > > >  /* Bit fields in CTRLR1 */
> > > >  #define SPI_NDF_MASK			GENMASK(15, 0)
> > > > @@ -122,9 +127,10 @@ enum dw_ssi_type {
> > > >
> > > >  /* DW SPI capabilities */
> > > >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > > > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > > > +#define DW_SPI_CAP_DWC_MST		BIT(1)
> > > >  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> > > >  #define DW_SPI_CAP_DFS32		BIT(3)
> > > > +#define DW_SPI_CAP_DWC_SSTE		BIT(4)
> > > >
> > > >  /* Slave spi_transfer/spi_mem_op related */  struct dw_spi_cfg {
> > > > --
> > > > 2.17.1
> > > >
