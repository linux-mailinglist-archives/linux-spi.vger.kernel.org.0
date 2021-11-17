Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C28454617
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhKQMIT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 07:08:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:4998 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhKQMIS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 07:08:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="213966318"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="213966318"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="586571906"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2021 04:05:19 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 04:05:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 04:05:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 04:05:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfAcN8HYO3trOsqnL0FdGH09BBvWi2ga371w7p9mbmDFkHpqm2N+pWInNGI+aMcmJEN6/y1wazqcyxI7pMj/jWDYETGXYndHghcpzXnRXiamFtOwJEb4rHy7XFMPZUVwX4NC+rSI0M2ZZanmMZx/tqXNmy/vlwBVGoSnDs/JAoHEWxW7Gm7a6nwbi5x/Vdx6Vg4hzlvQ6w7ZxM0bjDIV2byjMZ0AboChoWrHMGBBLAlRG8q1ZkUmqY6v83ALky2HLhQC94w0F2NrZMXjW1YfWxAukHZcnGDfeQL8lXYCx1BTEbI1c9KXO3QwvjYZJHlQPLfISBhBr10UAdc41EhwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EefrpTqkd3UZAIxCHucgLxUWFFJCRb87sSg+ym0Nm0=;
 b=jTRLLPteBQW3awmpDZLjdYO5NEzCq936hzw7BhZIrAHyNMmckyBqcss64RuDFBEbEQg1fQT5oP2MZ+kYfzHZJWeBmdPLfYjyEdjin+teNxi27mCdYYyxzihIPcJa+NF9XErkqN+lSXgfqUrKBTlLC+mLYm3ElRwBis8bSC/8nbttBCk4tFr6MaKzmkG98e6D2ZFCwf7ZLcSg3eHh4ndWSkQDW0PAGTXcxq9ydFXOqhMCob1quDlPmQRoYNmwOzK+A946Pjxu1kxZUZwo/6zBbw1qiBpSqx6ZZN63wc6MDiBBmKAOGI1/cFTIj+nSFntlm3BMd34iScre4q5tAnLSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EefrpTqkd3UZAIxCHucgLxUWFFJCRb87sSg+ym0Nm0=;
 b=UlbtLjQFxJ1XxBxoXGColm5Qd1w1r9AMizAFKyc0wMGjACgYSbfiuyu0/5iZjgpSQ0Hq4hehyd09G+FDwlD71iyuPwFqkU8jjuTB/jrZ1EVuZ+0QGbSZimi11cANdxPN5Wy2xrcgy+hf1G19dXnMeQen5hAzevNr2av6hYUBGCg=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN6PR11MB4083.namprd11.prod.outlook.com (2603:10b6:405:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 17 Nov
 2021 12:05:18 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::a50c:f54a:8955:a443]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::a50c:f54a:8955:a443%3]) with mapi id 15.20.4690.016; Wed, 17 Nov 2021
 12:05:18 +0000
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
Subject: RE: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Thread-Topic: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Thread-Index: AQHX1sj9BYV8Rb34sE6mEcfI2eSuS6v+Y/YAgAAIZgCAAAGNgIAJOtqg
Date:   Wed, 17 Nov 2021 12:05:17 +0000
Message-ID: <BN0PR11MB572705BAE8AA3E8CB77CE9C3859A9@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-2-nandhini.srikandan@intel.com>
 <20211111143108.pxovseqvm2ywmoc2@mobilestation>
 <YY0wOBoT7X//GfQ8@sirena.org.uk>
 <20211111150645.f6qmnzy6hcoiatun@mobilestation>
In-Reply-To: <20211111150645.f6qmnzy6hcoiatun@mobilestation>
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
x-ms-office365-filtering-correlation-id: 79eec672-01d9-4eab-9ee6-08d9a9c285ba
x-ms-traffictypediagnostic: BN6PR11MB4083:
x-microsoft-antispam-prvs: <BN6PR11MB4083E07BDCE06E6AC71B50C7859A9@BN6PR11MB4083.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbJ8Aht4RTgtI2RIHQXzmA8LJtqzo8lgpyEBEEojz7kUSU7H6gqb73TaTSUGcG/w5PEyqyZ0fiLmD0wnmWfI0nayanYZ8Ldsfcr5Pce+3uOptcrbMXNS6yR6Qk2ivGOlQzRNaEXNXKIacfV6lIGbuwhwUy/a/XLPkxs/q96Gwxj6RPp0b7GSg6IdQ6c6gY+OfgeKpL7iKpRahn4Yvguiikzmr85eU75zBp+8nu8LxhrXioLEI9yQ+K9OrWv58AjYDttBUafH3XmzdvCalx608EdcS883Gav/m2lQGu2kqYIPEQZ2y5bB38WtfhPczBONoud3McnTrV4nlb7O4ro2rymvgQa+hki8H+j8yLNlo3MwY9sxkNjMdnsnGmLZEuTOjhGZo9S5xGLo7nKyRXUBQdhlgxY7BaKMu+aGJoHP4bh+9XWtbN2X6u4FqVeourhQXmHih7L2Hg7JwKyrMmlZMv+FRut5ooeaEB0g1bV2LBfIpQDJ2s5YPOUEpUQx4b6u/lphnK2FUHs2vxYTOgNw4VKVNE0xTwrVuZrPewcQ0kHg21wUQI5eTMw/n3STHVV4/XVlUWi5Zyz/Y6E3FaqWQkbbGiAemGpBEoNUnjeg19FJ9dRo6082u45LxRPl6YB6aoOGFW5kXbJcBhvw+QqaJhtCdXIWDr9Nw0rcWbwyr2SUwhflwgfjU6rRpWSfT3ov4+csr5Ylz1TpiSZR46N6VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(52536014)(8936002)(33656002)(186003)(8676002)(38070700005)(66476007)(66946007)(83380400001)(26005)(86362001)(316002)(66446008)(66556008)(64756008)(5660300002)(82960400001)(54906003)(9686003)(55016002)(110136005)(2906002)(4326008)(71200400001)(38100700002)(508600001)(7696005)(6506007)(122000001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nzhabavVFied2z7z+o5maN/nCWUC2Yyx9Qufxt19IJy3bO2XbyM7qWxe3VmK?=
 =?us-ascii?Q?g/NeF6RkIlA2+zmuBrzqj7pQXYaDe5vtooFKKT2dVF+KFGFLR0VHoInyfk9C?=
 =?us-ascii?Q?m3+4SU9py+zx/pA0N411lcaxFNC2PEq0EAdamIcjyKtElCb97wsvd3YVxebD?=
 =?us-ascii?Q?p5pubnwGl/cwG+S/gjK732nRdIWAVO/TNpOD2ExUYMppT4g50ojFmwTjgfpg?=
 =?us-ascii?Q?E37hP7bPUkjSMAFnA1ZsSkq8VkZb8AByJa6Oj7ve/1nGBjrpfIZhwfoSpiNw?=
 =?us-ascii?Q?Hvg28EHzchhP4cpz/0fdJcY1BuijhDb/7Ud0MVd1fTGV6KWOSz0uJDBAvNcx?=
 =?us-ascii?Q?AbSgPgcqbt/lARdSa7L3kr5wUquAb5POK0xAnkISq4v6B/cluvVQxALYQdFE?=
 =?us-ascii?Q?9Ore6ef0bZGWbZxuXjb8CB0ajgUj6Y3ivGTjspJoco6uWV1mnbHjw/lg3FsO?=
 =?us-ascii?Q?Js1fK6gIUMrLpRssjJkXBH8WgSoVs2zL7hbs+Ma4e4Ce7uQVPAYtuf69syOR?=
 =?us-ascii?Q?yvrHvwPn+xwiPaUHDjtRG4EijRMPK2oPLBJKY0Gk1bkZigXQbtFoZNQuDObV?=
 =?us-ascii?Q?/zT9gs18U85vYEJeBtmZix9uCTaGTkvMZHv69J9FP6rRI092SdreWDAha3cj?=
 =?us-ascii?Q?tPdE99uKr8s2oI5qpHRr7gIxOID2456gZv6MTA6QNC9n8nsSKUlSO/A42HlQ?=
 =?us-ascii?Q?5aPNJRBJ3ci5q55HJ9EpsrSXJmEEYjKe++0O6FBwd5kC7DqP2fa/FQh/FBrq?=
 =?us-ascii?Q?zOEjT6HyK0IjKVqsR8MprEa6KW25wZI7/TQrmKRcn+7/WKPgdgQIyu4cMHfI?=
 =?us-ascii?Q?SCvB+oLKLEFq0R/feAM+dwIpJHxxJXi+TSgwdB544EwXTQiwQd9RxdIpqMfX?=
 =?us-ascii?Q?c9cbr8Uf85+9sSqQuZeC+DsY5X+1MbZ/8p1Zx1rLIsAQIY+pHqGnPwH0zJzw?=
 =?us-ascii?Q?KpYw16QdpO+BrznsDjNw5q32CVw2lbMJey5p6qcnKuHU9kWVAYqgjDL2vogf?=
 =?us-ascii?Q?tdqiAvqEWLI8e263TYPoJAGJ2D3RP2a9Lp9RuScXhFoJylCeUaCIvTYZkl9e?=
 =?us-ascii?Q?0CifFSKz/GUFuFXhUbj7yXVo+WZ+LeepU9NofAoPC2/QA0WgdpFvKrOoLJoP?=
 =?us-ascii?Q?Hjl/XP52ga+4J8vmoRrJ6tvTlxg2BrDGArP2mujl9ptLJI9iiu7b7L3yoWQo?=
 =?us-ascii?Q?sBwTwWYmPMDgtyB7STgUwNiXadJLywBNFF5atQg6p1I328kCkmE/8dNZov8p?=
 =?us-ascii?Q?SUsbDzJf2f5oh+1NZk8kn+Y0PTA3ht5dOUNgC0xHUSVM3/x6huAi8rLat9xm?=
 =?us-ascii?Q?MYtS//r8J0L3hndnyXl8Benxcga/GwxcZdB39Ht85ivjp0PQvSBH7vYOIv6m?=
 =?us-ascii?Q?r2QbOCEG9veG/MmfyE62WJzz2NWoQk0VBw4ubUP/8KHJW3ZCS/9SBFbwDTse?=
 =?us-ascii?Q?YYYPQIC+zS85T81LB4M1quEf30ySpuHibf8uq1nLH//dPSUdDpz/TJBqYNpf?=
 =?us-ascii?Q?aGuBpt7W1ko27j/AuDW4hP83sZIYIKrxYbj8wNQ33Hc5rYSp6iS1Maux1z2D?=
 =?us-ascii?Q?TT0IutklKY8K73OheKmujgVjhGRI3WaJdBq3Awk39lYENQosv76YOVM7yPAF?=
 =?us-ascii?Q?xGNE5TvREkPWlGxQNWwrqE6PwGqz7WrEX9Zlujfe6UKOds8Rnz4KNL3WiqnO?=
 =?us-ascii?Q?rhhQvA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eec672-01d9-4eab-9ee6-08d9a9c285ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 12:05:17.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/JR/ddwIt8RvwRMr7ZZ5+S/rhANABGUIPD0JCrjp58ugKSf4maJvoGjdqa1EPEALV++8zNAFdviSW3FW0a+fcgEm+ocbz/qQ1JRNrTxgI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4083
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Thursday, November 11, 2021 8:37 PM
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
> Subject: Re: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SS=
I
> controller
>=20
> On Thu, Nov 11, 2021 at 03:01:12PM +0000, Mark Brown wrote:
> > On Thu, Nov 11, 2021 at 05:31:08PM +0300, Serge Semin wrote:
> >
> > > BTW Mark, why not to have a generic DT-property which would set that
> > > flag automatically by the SPI-core subsystem seeing it's indeed a
> > > client device-property? For instance there can be some property like
> > > "spi-cs-toggle" DT-property which when specified for the particular
> > > SPI-client DT-node will make the SPI-core subsystem to set the
> >
> > Anything like this is fundamentally part of the wire protocol for the
> > device, there's no need for an extra property on top of the compatible
> > for the device and the driver really, really needs to know what's
> > going on to avoid data corruption.  You could also use this feature
> > together with varying the word size as an optimisation at runtime (eg,
> > do long sequences of register writes in a single hardware operation by
> > setting an appropriate word length to cause the controller to bounce
> > chip select between writes).
> >
> > > SPI_CS_WORD flag of the device mode? Like it has already been done
> > > for "spi-cs-high"/"spi-lsb-first"/etc.
> >
> > I don't think either of those properties was a good idea, there's a
> > bunch of stuff in the older SPI bindings that don't make much sense.
>=20
> Ok. Thanks for clarification. No new DT-property then.
>=20
> Nandhini, could you please drop this patch in v4? One more time I'm sorry
> for misleading you on v2.

Sure, I will make use of SPI_CS_WORD flag and drop this patch in next versi=
on.=20

>=20
> -Sergey

