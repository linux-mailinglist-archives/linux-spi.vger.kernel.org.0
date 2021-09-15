Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F640C3C0
	for <lists+linux-spi@lfdr.de>; Wed, 15 Sep 2021 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhIOKpT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Sep 2021 06:45:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:23800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhIOKpS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Sep 2021 06:45:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="201786461"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="201786461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 03:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="434079393"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2021 03:43:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 15 Sep 2021 03:43:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 15 Sep 2021 03:43:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 15 Sep 2021 03:43:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 15 Sep 2021 03:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpDidV1gWKIx2EyabGGmFOe4iBlAp627oLHUTFk3/atP6Jm+6HsgOPCmiubC6vmKkrtH1T46BgD5iBnM3tfZAckR3AhYF0wAYHYOmOszGyyZj6UZ2hsmPhTUnEVVpLFfMNNe7vU3VxUHo6YFveOBXQIbk0CRTt2M0EySq4QiZDyaEUaiCVyEcrKYdcRhjqZF/CDnDAm83nRMkD4QG8gKJ6OMsb/I1xsA0Zae6podbNy3Zo/eEFkS9czOf9hZDQct5tk74Xva39UaadFH4CxvHPMcu9jGykEywmSuP7HEFOUYsVSOtYfwYDFjTy29IiqYO5fzgOJPJqgJoIyU2HFrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dBRI+X4nU/3z1iACDq1E0v25JPKrdrlXIpzW3Td1px8=;
 b=YnJqfKuxRhjr70tDt0PQYWOmNRdZ7PjkQfpJR3Zq9lLsMbB7AzD1x3f6Ky3Avzyn30CO/LvWNt7dS9o5Vxb7NlQfr2adVFi0pgXjIvHsA7B+dHhn7mdyWrqerxss82C0M5pCwaVU5zf9Bdqb7AE9NDL0216UXVP4KLZSpm1+9idj+YjE7mp6kVw9SliUOctEBjW3j1VDM1mCk5KpzstNbkd3V1d16if5xz5xbd5H6vG5zWPKG1LnwP3wtw3JitGh7YDVb3aFi36Sy/CManKx/lJKDvjv7Q0sg0ZLdQcvDLsm3LCgltSD6qKjeM45hWRAlAs5l3cboJ95DXNQeGdIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBRI+X4nU/3z1iACDq1E0v25JPKrdrlXIpzW3Td1px8=;
 b=YMOO/CEY9Gb/5zQ1ieFvH7fC9H8NAuCGXe8nRAxLbbuKFIuYqDJ3yT+zwPcxmgzOOIY8OvbWwwjv5YV1xGfiF8PL6zPCm6XKYUOZnPAZ1sguDenWm314Jk/IdviaXbBqjJKixpSf/JK1FvEt+0yOFrJIehc4C5Fre4I3jlwDxaI=
Received: from DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) by
 DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.17; Wed, 15 Sep 2021 10:43:29 +0000
Received: from DM8PR11MB5608.namprd11.prod.outlook.com
 ([fe80::c18e:5b8e:dcab:80e6]) by DM8PR11MB5608.namprd11.prod.outlook.com
 ([fe80::c18e:5b8e:dcab:80e6%2]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 10:43:29 +0000
From:   "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
Subject: RE: [PATCH v1] spi: dw: Enable Autosuspend delay for SPI DesignWare
Thread-Topic: [PATCH v1] spi: dw: Enable Autosuspend delay for SPI DesignWare
Thread-Index: AQHXomlz6yDi9jjb/E6tpLs64kgOG6uk6liw
Date:   Wed, 15 Sep 2021 10:43:29 +0000
Message-ID: <DM8PR11MB5608946D508564E1BEA1F07FA5DB9@DM8PR11MB5608.namprd11.prod.outlook.com>
References: <20210903212758.22038-1-mahesh.r.vaidya@intel.com>
 <20210905151919.znaftqnzsuqd4n5f@mobilestation>
In-Reply-To: <20210905151919.znaftqnzsuqd4n5f@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 724c99f9-46cd-4fed-36db-08d97835a7e1
x-ms-traffictypediagnostic: DM8PR11MB5574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5574088AD89224BB12F7B873A5DB9@DM8PR11MB5574.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Le6FLy2ZNof4D99Fv3RLJzs7XdtMLZw0ZKMHTIF6EfhJH/x1hI76z4X2OHkgg9fGBjCYWxliH+epyouWlGCMfbNVsKKQNcs7iSk24iwTyiQtZ2muZoPmkBnC7+nxL9iITbGgx8rKTdBAVqaAWS6GC+OeWkeE3/qFHTfcnIGkoskkCpJ2DeVordKq4PHL2JNzp4MfJv0h6oeWcaiVVa404/S7C40x5pRzRX5pUnSw7YiELCv4gcg/qgQnY1/E4Fc20SVymSNYCXIZ5kDcAHzeFqGRj5asmsAdFBKz2aUzJStylNM31os+yKzsfpSM8Uh05ht0yvcI/r3kgD3FiyRHJVlUkExXUoojTYwLzZWxgO1yWw7daOFESH6bH4Cf3BXodUo9BcEpMWPrN8faoIyhOtUAETc5RTfLcAXBoOWXQzQR2zB5lX6MzZ3hE/gGuvp1ZfczoJqGvMqqEHKkLVky/2bV4NetXce0JYDmMAdzWB3iHSxTdkZ4kuHztPYLWf47gokhab64Zx4WLe3euGQH4hhkDdM2hsRMrRh6toB7LZi9etlOLw3lXbfY5+JiC7XH6GrOWnmBPanYfygav35Kn8xKKQ0PEyAC5SWWlQ7uFcWINraVPbHhLOVu8v4sNbaBMNZTFpAPrOalq7HTjbKuEo9OWmAhgrwH0nFd3PuWuOO6kP43etGncTtkHOpnbaMRxPPF+wm8lGkbx/S5zp2o3Fe1zO8uaPuFng/KFf9F0MGVPpEion91o1Y2mqLo88wCXliCvLECUd0+OvwEj9ZqQcgOhj3PIPnhZPsocyTAu4t7SB/qDTiz99Kvxcb6QBm9X2kHEwFgo1fqUwoV6e0CcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(26005)(52536014)(83380400001)(478600001)(8936002)(53546011)(38100700002)(122000001)(186003)(71200400001)(6916009)(7696005)(33656002)(55016002)(6506007)(8676002)(5660300002)(66446008)(38070700005)(54906003)(4326008)(2906002)(86362001)(9686003)(66946007)(64756008)(55236004)(66556008)(66476007)(76116006)(316002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kAt5iGFr7fOilb7DGFj8uJ6R+D0O3iAOsbT/qIGn9RaoZXhpa2IvWGlDC2QC?=
 =?us-ascii?Q?eoYGsFHWwppoM6/+adc0LaN4eUO9NTDUcB28LUux6XAYmoVWlmDTJc7PlvKM?=
 =?us-ascii?Q?inSYTWlKc0VD8b/5Gf3eEk4RpOrPqcv6lhwCp5DZxWYrbaQniq6Jc5cDx8wG?=
 =?us-ascii?Q?wgzLfOzoZdPx9eZ475TzFDFYbIWIA1EwiJ3KUHj+FsQW7w7SU4KGMO0JTgR1?=
 =?us-ascii?Q?xvsZZsptRzemeOR18ng3u9bJKcWJm7fY2PCW+c0LUdNRGbh6CgPcZJ6Ndqsc?=
 =?us-ascii?Q?3WtzmFlXZF1nS1fHNDK1jnjAOMReA7YBwxTFJxJHcj8HvP4vEkGUaGLRzD/4?=
 =?us-ascii?Q?FotqyQhVmpVjNMwZ4hjcMY7tWe6Ge+OWQtUHuD12KdxSrnrz9WRxgXR3gcKa?=
 =?us-ascii?Q?rYl96f833Mm7ICPEzgA5KArwyIDdh01xHkfY7K5u2vbNOY8v3y2RcFOi0VSn?=
 =?us-ascii?Q?tfEtY7Gb3qjE9kVVW3PbwiDMC9qtyT9pZwaMi7WpQxZmrxyDyK55/KlvGWWs?=
 =?us-ascii?Q?JSA3tlG3vNTiXh14jNoPhuXzj0DKLUXKqaD2gWhUOCGWrHHQwT6i3RDlh+4F?=
 =?us-ascii?Q?BLydFTuix/Nnd0GdVcNhbjAf6tOlR+evx9oNWkAvrNKrlN/rTalEVrJJmLwB?=
 =?us-ascii?Q?NbRyt1Uel2CutInCOYtjHVXIcVifHzqsZ86PFhFuRTT8LsOedPKmn5i8iSr1?=
 =?us-ascii?Q?LRutU4uoHGGwk28j5vk0J2fxsLtm50PPxtJ9Uao5z0ireI96+eJbtSZBZLWM?=
 =?us-ascii?Q?2eYbCHs0PcJZ2JWTPEWkp7C3EiciAE/GorAJAPFjHqfVRZUNqPGbTz9w76Wn?=
 =?us-ascii?Q?2ayMT/h1EkKRVflceaUL2/f8oHp/blzqJTUL8BdhsDrBUiHen7SZNaZUupxP?=
 =?us-ascii?Q?G0f2ec8TWRRSo0L2nzixNzyE1fCYvHgqxVxubrPH45m0vv3h25iIQY6wCq/u?=
 =?us-ascii?Q?TQXPDz5wJ5ItTGtZPEGvoYZ07DMaSLOzgFEXGaFLqYvn3+fTaMmMXjfdPsBX?=
 =?us-ascii?Q?5ZJF/ply8N65IHGnpCLlOMC3cjgCbA5Ay+ezg2P+uK+DdMvGjize0ZfOEuek?=
 =?us-ascii?Q?RX1ePExmXQC7inv94rxHXJP3hSVrY47zMvHenZy/l4/cFUxMi4scKdky4ua/?=
 =?us-ascii?Q?OlD5nan5pOkX4Uc9E2lI4Diu37pvcskTsft7tpn1d+gtYXtyAYArRExAQ9u9?=
 =?us-ascii?Q?S1/zSoUTDq+dQPt86ey8qf0yfSRsn9hnRKtF2G/8NfF5jfOqh6HcZuXVWl7X?=
 =?us-ascii?Q?6X8Gm3vD5qfmb6qH2gTMU8ABHOa2iEqmp51GPrktZ/RSW2g8WiRNXiGcyEH5?=
 =?us-ascii?Q?gx6j/wsh7k5B3E2s1Rn+Gfdx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c99f9-46cd-4fed-36db-08d97835a7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 10:43:29.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcPvRFzUsDFRppVH0IQKcAp7TlnGvNrMtp8wOLTAAycMu2yUXxhnYL2Fp0OCUs7wm5WHxb4YGXWMov2Fi+HzikoAq+UYoHiCF44X8BCyUhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Sunday, September 5, 2021 8:49 PM
> To: Vaidya, Mahesh R <mahesh.r.vaidya@intel.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v1] spi: dw: Enable Autosuspend delay for SPI
> DesignWare
>=20
> On Sat, Sep 04, 2021 at 05:27:58AM +0800, mahesh.r.vaidya@intel.com
> wrote:
> > From: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> >
> > Enable and set Autosuspend delay for SPI DesignWare driver.
> > The number 1000 ms for the autosuspend delay was picked a bit
> > arbitrarily, so if someone has measurements showing a better value we
> > could easily change this.
> >
> > Signed-off-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> > ---
> >  drivers/spi/spi-dw-mmio.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 3379720cfcb8..8b588ce9c16b 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -33,6 +33,8 @@ struct dw_spi_mmio {
> >  	struct reset_control *rstc;
> >  };
> >
> > +#define SPI_DW_DEFAULT_AUTOSUSP_VAL		1000
> > +
> >  #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
> >  #define OCELOT_IF_SI_OWNER_OFFSET		4
> >  #define JAGUAR2_IF_SI_OWNER_OFFSET		6
> > @@ -309,6 +311,10 @@ static int dw_spi_mmio_probe(struct
> platform_device *pdev)
> >  			goto out;
> >  	}
> >
>=20
> > +	/* Set initial autosuspend default delay value and enable */
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> SPI_DW_DEFAULT_AUTOSUSP_VAL);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
>=20
> Seems reasonable, but doesn't it need to be reverted in the remove callba=
ck?
> Like it's done in the spi-imx.c driver for instance by calling the
> pm_runtime_dont_use_autosuspend() method.
>=20

I initially referred to the below two commits which enable the autosuspend =
feature for spi-rockchip and spi-sun6i, hence had followed the same.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D940f3bbf3dacd6e31e482a10e64c96e69b00dded
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dae0f18bef30d0e76dd62be46c59b24c75f175092
But, yes, I Agree with you, right way would be to handle the reverted calls=
 in the remove part of the code. I will modify the change accordingly in th=
e next patch.

> >  	pm_runtime_enable(&pdev->dev);
> >
> >  	ret =3D dw_spi_add_host(&pdev->dev, dws); @@ -319,6 +325,7 @@
> static
> > int dw_spi_mmio_probe(struct platform_device *pdev)
> >  	return 0;
> >
> >  out:
>=20
> > +	pm_runtime_put_noidle(&pdev->dev);
>=20
> This doesn't seem like related to the subject, thus needs to be submitted=
 as a
> separate patch with fixes tag if it fixes some another problem. Additiona=
lly it
> isn't balanced with the pm_runtime_get*() method invocation. Am I missing
> something?
>=20
> -Sergey
>=20

I checked this further and pm_runtime_put_noidle() seems to be redundant in=
 my use case. Hence, I will remove this in the next patch.

Regards,
Mahesh

> >  	pm_runtime_disable(&pdev->dev);
> >  	clk_disable_unprepare(dwsmmio->pclk);
> >  out_clk:
> > --
> > 2.17.1
> >
