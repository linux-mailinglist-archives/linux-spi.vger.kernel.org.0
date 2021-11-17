Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0045460D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhKQMCc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 07:02:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:46763 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhKQMCb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 07:02:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="257700171"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="257700171"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 03:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="505004873"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2021 03:59:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 03:59:32 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 03:59:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 03:59:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 03:59:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOnKc/jfMkvkdBrCt+B0Gx7yrSjilGceeQ/9Z0yBLQymoWI7vxzb3XgnWAXagCfYVKPuVQge+ypcsAucVe1r33ANwGNJkdTMKmHToUY4IVQs0C6wq4FcPzgA3Fv3tQIf6BJM+Wj7bNZfPPUehhYVLM67JiqoXBi+gRW95R4NLPyZuFuqd4aUmFT9azrfRVeK7TmzHbUOxM6KWD8jWdJPLycSDnNtq8p5kjmpku1YAY4sDOcl0teOMyVzKezI8yEpkRT5z5o864PgGHoKs46fOQ1YFBk6aGQVok7G+lGZLSIPGhVsJ/Q2jNQqbXZFEpyuVGm/Wo8+ThKNk+szepGRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NswVn7/g7gh21IORJk0ZDEsH6/P32BeiSP2aoohpw=;
 b=ihhYWvU8nr9dLq80MPUyW7TXkbNMcvg5nRoeua95L9BcQWsUTyoEqZg849k3spznKLI/UaKpB+/H5l6K0j7Ck6NzlhepTVxIwAJz9iUKGAAF03FfsrpXAu0wO5xhynKI/9vt0xkDFkpnjtOTkqdyIJf1DNA3MVYyhDPH/eGPICMXFcLsy0zQN5oO/tVqL03zXnKxBFvLjefrVU1VHtQKSK59Uzn6FVIWVS2DbRcCqzlSGHhadBiSC7d+0AXzMJyotU5whdu6SA77nyHxJix4SPhwodrSvxwe0AVLKr0VpnNpjZpQhN3vAJZ/mfBgXyDOfoxBTts4HumrqQvso2viMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96NswVn7/g7gh21IORJk0ZDEsH6/P32BeiSP2aoohpw=;
 b=RMlH0EiZY8QcZZVLcQ2HvU4RAm1+vP2roGc6XjjZPm2Wy/0PIdG4+09qiu4vqkgKDyPoGrUFjgoe2j2whAwpECS2hhOY0IXZFTd1oA1bTqqsNNz4nzHC8Q7n+P8XE+KAWaQ06FgqqEs3ziQhXfW48OhfalAVjDYkw5f6D2b9Qa0=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN7PR11MB2771.namprd11.prod.outlook.com (2603:10b6:406:a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 11:59:30 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::a50c:f54a:8955:a443]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::a50c:f54a:8955:a443%3]) with mapi id 15.20.4690.016; Wed, 17 Nov 2021
 11:59:30 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Subject: RE: [PATCH v3 3/5] spi: dw: Add support for master mode selection for
 DWC SSI controller
Thread-Topic: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Thread-Index: AQHX1skAjajAYr0c7EewenRpP9BbBav+X8GAgAAKQACAAAYOAIAADoiAgAAFMQCACAtYAIABF3/A
Date:   Wed, 17 Nov 2021 11:59:29 +0000
Message-ID: <BN0PR11MB5727E5AF778F8B504F009554859A9@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
 <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
 <YY1D3tM4fg8h6mmj@sirena.org.uk>
 <20211116191542.vc42cxvflzn66ien@mobilestation>
In-Reply-To: <20211116191542.vc42cxvflzn66ien@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2a5fab-2466-4188-23cb-08d9a9c1b661
x-ms-traffictypediagnostic: BN7PR11MB2771:
x-microsoft-antispam-prvs: <BN7PR11MB2771A3B5B565881FDD3574B9859A9@BN7PR11MB2771.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GHpZXIWPUqYw+PR/Ov8a0uqWFlpRoLWKZb8u31Occr1cCkx55lCQ4amtD+wCJngd3aMrhQUpOdVyG39rTGgkEttFBqnMNmWpaMAR7nnsiPqA1mE+90swpj/P8ANLx6FdAWXR4sa26Q7vJBSTsBJ5t+79O3OBsvrZdk/Fz2EqlMD50uCKBQFc3I8QFVtS5uI9pZocyjjZaq6hVCjeP5NofzODr/skyGf0SED19GUWm+q/JIXUvgM9agmSMoqbZJFISo2CjyhZwkUCyrAp34HOE8vkOtBYpNZi3zeNKPVQswgUTWPafcLAj03Jkzctj4PRBdRUU04rWCVPORzvIwyJ1sPsBc3aotOLwVaMklclQ7cg2Timtxqu16qsM/bEKVBtfQXRnOdSnuSO060cuqiJQaweMEhxJlKHETjWNAM1r0fe5cnUAAaEDIstkc567XTYLzeCrUsqXJViGb0e4p5RlOl7S+PCoOjz0ytcWaKOP8nwxCYa/JINh5cSScweko3UnwHvMxydXvDdkTAKjQ5v4RA9JrQk+lKmKLr6CEnDj37K5So9t9w4AWOAn1LVBB59uXqemQ4cYas0HNuGBdducQAusgL7FYahI3qqShCmVxIwQAsIrpuXIQVcRHvRcc86Gj3XG6ypugKAZpGj5lESah7euxFoyNDH0uITpsgIlOF3GhRcnVCS4Qh0fscAI8zgelZCIfQKVz7yBJXnGBXmY6HjtcTJKveyX5TZGpwARhi4aekr3XA8pBkQykbqWJrIfOtGCoZGpTCudRUMaEHZnAvZPBZrABNoiUikPywCuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(38100700002)(64756008)(5660300002)(4326008)(83380400001)(122000001)(26005)(508600001)(33656002)(86362001)(8676002)(966005)(55016002)(6506007)(54906003)(82960400001)(52536014)(2906002)(66476007)(316002)(66446008)(38070700005)(186003)(66556008)(110136005)(9686003)(76116006)(66946007)(8936002)(71200400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8NIZVkCxFHOm3P+PlQbPwGe0gQTesV4PhVdLpcEXwMXGQGkJRsVph/3TI/aG?=
 =?us-ascii?Q?JV/fUoyE1DoAFs+xRz3RjWvgxIOrqG+Di2VfARHyKsHExbTQ3YYYExD8tJYV?=
 =?us-ascii?Q?MiSfeVMnIMSFfuj8PyXcRb4c1vJuRykjCGCopBOhjeyW2bjkesnOIPqqKNn/?=
 =?us-ascii?Q?tFqyybOmxMq+fQyEjsM7MzyKMU+2znGfU1f9AguBtzT73HKE10ggVylqo+Gh?=
 =?us-ascii?Q?479LAEnnUO8HrZNrlEdXoym3tN0DKqD1j6bXgaqVyoEDYY2b4sPBJHGyS5f3?=
 =?us-ascii?Q?Rk3fX1vrDXfQSeBcdcKwAq4dAlmajBtvYZYgrrmc++wxp0q2TPJ31vqTP5ES?=
 =?us-ascii?Q?FD3kX3QekNWwpUZxy7mRdvROwbTsCuORwvJdAU5AaMQ9dodE5zl72jn0NzO2?=
 =?us-ascii?Q?cvYlmnAAeKT12RNOQ/eE1OVFDU2s+Pwwgw/sIPRX2xPqPdkZ3la/Bk306xq2?=
 =?us-ascii?Q?OODgN3C8gEBSH6N8CCII7kmfaNjf9CI50NQTOT3dvDJg/8DQ6ypuUGeC/P96?=
 =?us-ascii?Q?6NoPfkmq+KEEkB0hE39/RUjUhlHliqsjfFyPVriblM1FNik4BE1NmQjg/NOz?=
 =?us-ascii?Q?GoOGeRk5DMn8t91z4UgjiuEvENv9ONfcPrYzyx/GA68m/JwQeK/8sKivbvtL?=
 =?us-ascii?Q?jkK00KjyCGjRPPDS5iIg4oB6qRqfANh2Np4MJgzWoKYNvzHxURo8cI3qQ9dr?=
 =?us-ascii?Q?/3OHNMdxtFMpetcfoVO6LncwOguc8nGs8g4IfDJTpjoRV1m7UY8rLIJ0lQQk?=
 =?us-ascii?Q?ix91rTmw8PKrG15j44x342JFS+RKq0ZBgxSjwZpHUQok6SmF2xJp6DNQ/3Md?=
 =?us-ascii?Q?gEAZF2cPuyTdjrx7DhWqELZIOuib/WtCZ+sF6rrwd5EwCWNOAQqNqG0UgzHr?=
 =?us-ascii?Q?k7lxS2eJAa1G5ciOeHRy70tUoKWRmezYlH1nMvVhGWeg9++yLYnHD7sw55N/?=
 =?us-ascii?Q?gAXOeoFihETS6hH84xFkML5j/2MqsdMPfJJ4LQeXzJtySaFD25wkDmTj0G7L?=
 =?us-ascii?Q?E4LW/aa8U3XQOn+GUzZtIawaB+oUcKZmqrfoshb0jNPNOTs8Xx/zd/ut+qKW?=
 =?us-ascii?Q?SrZTN6Ozi/LIqWE2fgL5iiww0XuBKhGpR0Bj+lMyfAG/iyazJa5CbwPSkb4W?=
 =?us-ascii?Q?iQl/StHC2LYA2xQUguOSTLRBtQPF77xsR7sJopg8WOmN3NLlU5u7IhmFT5xg?=
 =?us-ascii?Q?EXh2xpr87zmo/hs5Lbj6GpSCbytoUp0oc/gwSuzyaDjBCoVXEON0Am0JMTI/?=
 =?us-ascii?Q?7NttP9WvHlO2CJcGixXRATQIqzRwmh1Z8/XztKQE5Buq0/hti/MEzK7/3D0I?=
 =?us-ascii?Q?HEWuUcZPc4emUlLqjgSRNwFadUGc0U5IU4lYnS8o61V8oQ5Uqq+/c7fwIE5t?=
 =?us-ascii?Q?aqLT0q50Tyz6UwX0+kBoF85YnymMlf3IjGvmE4+3SdHuKrkXQnaKbHNpztL6?=
 =?us-ascii?Q?uo2YfPDJvUxhTC4piI2lPyOchYHXOO+fm5clkwvwb71Pvc9JsO63ytthRq4q?=
 =?us-ascii?Q?7YE7BuSp1ELQcgdxL9lnOlDBoglQa0LjhMRSCOfq4TdE8u6AXdh0UEGOcvmA?=
 =?us-ascii?Q?X84ccjH8NCPM2Iycsy+0H3mW2zKhQydHjpKvyOgHrnHdWAPv6UePZih2jtjB?=
 =?us-ascii?Q?crRhxe9hW4olKOKcbPHQDzry8MIw+KnEkH0nwo+gxc8hSkLyw1nTshfzEfs0?=
 =?us-ascii?Q?GOu80Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a5fab-2466-4188-23cb-08d9a9c1b661
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 11:59:30.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL7GQIhWdRbwAXXcpSS9b6sF/igu+Q59O/mAZfHuzGuk4ppOZHOjCiJ9zuqm4I6DTKArdq87p8CyfNxB/Y6Zpiz/HtC1teFXhTUSGIaCQjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2771
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Wednesday, November 17, 2021 12:46 AM
> To: Mark Brown <broonie@kernel.org>; Srikandan, Nandhini
> <nandhini.srikandan@intel.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; robh+dt@kernel.org;
> linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> <kris.pan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selectio=
n
> for DWC SSI controller
>=20
> On Thu, Nov 11, 2021 at 04:25:02PM +0000, Mark Brown wrote:
> > On Thu, Nov 11, 2021 at 07:06:27PM +0300, Serge Semin wrote:
> > > On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:
> >
> > > > Given that people seem to frequently customise these IPs when
> > > > integrating them I wouldn't trust people not to have added some
> > > > other control into that reserved bit doing some magic stuff that's
> > > > useful in their system.
> >
> > > In that case the corresponding platform code would have needed to
> > > have that peculiarity properly handled and not to use a generic
> > > compatibles like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which
> > > are supposed to be utilized for the default IP-core configs only.
> > > For the sake of the code simplification I'd stick to setting that
> > > flag for each generic DWC SSI-compatible device. That will be also
> > > helpful for DWC SSIs which for some reason have the slave-mode
> enabled by default.
> >
>=20
> > That's easier right up until the point where it explodes - I'd prefer
> > to be more conservative here.  Fixing things up after the fact gets
> > painful when people end up only finding the bug in released kernels,
> > especially if it's distro end users or similar rather than developers.
>=20
> Since IP-core and components versions is now supported that will easy to
> implement. Thanks for merging the corresponding series in BTW.
>=20
> >
> > > Alternatively the driver could read the IP-core version from the
> > > DW_SPI_VERSION register, parse it (since it's in ASCII) and then use
> > > it in the conditional Master mode activation here. But that could
> > > have been a better solution in case if the older IP-cores would have
> > > used that bit for something special, while Nandhini claims it was
> reserved.
> > > So in this case I would stick with a simpler approach until we get
> > > to face any problem in this matter, especially seeing we already
> > > pocking the reserved bits of the CTRL0 register in this driver in
> > > the
> > > spi_hw_init() method when it comes to the DFS field width detection.
> >
> > If the device has a version register checking that seems ideal - the
> > infrastructure will most likely be useful in future anyway.  A bit of
> > a shame that it's an ASCII string though.
>=20
> That's what the patchset has been implemented for in the first place
> https://lore.kernel.org/linux-spi/20211115181917.7521-1-
> Sergey.Semin@baikalelectronics.ru/
>=20
> Nandhini, Mark has just merged in the series that adds the IP-core versio=
ns
> infrastructure support to the DW SSI driver.  So now you can easily conve=
rt
> this patch to be using that new interface like this:
> -               if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> -                       cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
> +               /* CTRLR0[31] MST */
> +		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> +       	        cr0 |=3D DWC_HSSI_CTRLR0_MST;
>=20
> Please don't forget to convert the DWC_SSI_CTRLR0_KEEMBAY_MST name to
> something like DWC_HSSI_CTRLR0_MST and place it at the top of the DWC
> HSSI CTRLR0 register macros list.
>=20
> -Sergey
Sure, I will test this patch set on our hardware and then use the IP-core v=
ersion infrastructure support=20
and make the changes as mentioned for MST bit.

- Nandhini

