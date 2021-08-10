Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114863E56BE
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhHJJYe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 05:24:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:18169 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238915AbhHJJYe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 05:24:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="202048608"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="202048608"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 02:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515732198"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2021 02:24:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 02:24:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 02:24:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 02:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajhp0GmvobZzndxzCIHryK0b3XygziBE6EOGcAyYNabu8YoeSNHJm0Rt4urm3vhQtXYQxBw8UhVgYIL7eEA+ITnfj4UnA/MAuFGH6vCfcJMjBGqEtLEa2VQELh92Vl4eKiHyV4bOcYarMRzyIVnedn1554oFr4DsfgSU08M4SNVhENF9tp3EONpii9gzHTWQDGr2ack9wdClKtLpKcXBMuiJvdsPLUd02FTHjxtnRu1we5GZzCNxNQoe1A+x61szug8MLi12UY0EskRH+hBM0Fw63nLedW4Gz1jbBQzsonrHjS3Y/H8dzrHdbeQVh8TLo6Jq1CkRlu60Hd0R+WNdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JAUHRCuhRI96xpjcUIKxUcgFudJsO4e9i7LDZ6WNGw=;
 b=CtQ0ncVmhYq3LBMKBSkf1/Q0gF8XXGyoCYwbXgF5xoiJhapiEYQKqrZXO29htMVndsUul11FVb9rnEBOGiZO2cREsj5I1ijazhF4U+7XUgNb1L4rWpc2ZtlTnzooIUrX6WxcfBoNmoqayOjcLcO8jRg2LBjzL+GTcpQC20WRRo6oUAaU7nAKjHbugRRzZKT5wk30Vlnz8DiOxrc13vZr07j84yTkFxO8AVU8uK5HXDV4gn6WWPw3elDL1LlTbpwfSVEK1ow5B/jTWRJoiPYk1SiHRHuQ5PYxK3wj/Hhoj7igsY8+MKSrYRqyP9fGFuT+eXrKqZ70dxLg4C5Xd+siiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JAUHRCuhRI96xpjcUIKxUcgFudJsO4e9i7LDZ6WNGw=;
 b=yQf2pE7UWbQNRALsApGXZhNEilGmcUZxFQT56ajTWujVXJW+qxM7CxHYQtmSlGnJMKmFV96NDA14vxPRO+j3K+0oDod4fjQxoEodIpo5ayDZCN6DHS2fafpEjqGxsBEgL6dirA6KRCQduzPnSGE4h5eSJ4IUbd8Klw/wKjRNkIA=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN6PR11MB1281.namprd11.prod.outlook.com (2603:10b6:404:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 09:24:08 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::60d6:b84a:611a:8c49]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::60d6:b84a:611a:8c49%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 09:24:08 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Subject: =?Windows-1252?Q?RE:_[=93PATCH=94_0/2]_Add_support_for_Intel_Thunder_Bay_?=
 =?Windows-1252?Q?SPI?=
Thread-Topic: =?Windows-1252?Q?[=93PATCH=94_0/2]_Add_support_for_Intel_Thunder_Bay_SPI?=
Thread-Index: AQHXfrtHGOh1QvZTHUCrj94RnMIVmKtPKmOAgB1qEUA=
Date:   Tue, 10 Aug 2021 09:24:08 +0000
Message-ID: <BN0PR11MB5727CB650247519314CCC92785F79@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
 <20210722160919.ccjfodb7pbvu7ul5@mobilestation>
In-Reply-To: <20210722160919.ccjfodb7pbvu7ul5@mobilestation>
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
x-ms-office365-filtering-correlation-id: 6704a6bd-fc55-43e9-e32e-08d95be09b6f
x-ms-traffictypediagnostic: BN6PR11MB1281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB128108B6F3B81ADB7AE63CB285F79@BN6PR11MB1281.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaSez1VXsj+V3suSKfNBkPNKoyqlUdV9ulGzZYg/o1/ECETBJYUrY9jjwqOYn+4Bpy7DujTkIIqcdHJN5JDrBzaLTwhl31OwNtjMEjA++5MylQ+yl6G2HYYrvumUgUpFx1LADCINJCZpUl0ND+wcx/kmHvu+hWaIXy4a+2kOBphPLGW4XACWbQRm8ufM5t9lTUHAhhNU7ezlgsVKjvzoFiRMzX9QGuJX1QcFQAwa4n6QsI9bx9SuW2C5Wye6a22iKi7dwJGOqKqJ7L/vqBjJ5coJ8Itxxrmo5+88KnQSn8kQxreH1h+k8ASU4x3FTszMnAu6du+X1UrMHQBf0uVCz8ybCZBa3794v95/OhSzmAkDa3I2gO0aC4WfFW8nXuN5akAg5DYsi1e7Paa18qyHR3lZcWucJIbvLE9c9d488k7KxRfZdQgkYpNelZlhSiWOYSAQNGEMXqfVz0Bg4wpvcgk0ZvV9EBLFqM+HTcXdXhOSWgGOHMJrOn9r6zYjx45n7R931QBaBtrSVRVgFDWOu6Vo0LFDOHWtrIjQOcKOSawuXdDUSyDW0IJMGvb9mM5FrBo6oa/a3ZC9GXW+FbuLTvb7/uQf9ibVsfv4xwet0RaqlTMmjquqAlBjnyqzTHrv03nTM47uJoUMXXClv0q1IhNrRzpVc5Lxb1Qk/NK/RI51RyKyoeh/1nG9Y5pNLUeXwuHqnEd58qskYPOjLYpnrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(26005)(5660300002)(71200400001)(86362001)(52536014)(8936002)(186003)(4326008)(122000001)(38070700005)(316002)(38100700002)(55016002)(66446008)(55236004)(508600001)(53546011)(7696005)(33656002)(6506007)(66476007)(83380400001)(66946007)(9686003)(6916009)(66556008)(54906003)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?rhqyoE5FhTq0LNB8rsx4KjFr/UyuF1z0VMZYvme1PqrlH/WlNjU6KnBi?=
 =?Windows-1252?Q?PYVsLYLxT4W3Jf63BsQ2v5RP8uw5SRtTpxyFOSZDT5F8I5+dlBu6V7En?=
 =?Windows-1252?Q?S0SwzpDIUuxDmCrnpnBIJuSY7AhRBwVmMtsojvJ0uKhsWHcN3VIqc5Ru?=
 =?Windows-1252?Q?83ljV6TILyCvFSCVXmU/jEiNJrO6umEJSSwBXn5KACSdXhCxhLcGQcVs?=
 =?Windows-1252?Q?nfkzVOoir01GyX5vRCZcIg/7U9jMr/QVc20emZb43hBLE7jSoWdkpEYC?=
 =?Windows-1252?Q?7JpWd8SA0ojYyU2xu5Ax3mIcprPK8KK7Gwr7Jur6WauCjWefqUPsLleb?=
 =?Windows-1252?Q?r+npD27KXCZHJVb6NutZxhbWpFcozjCNQSbNk4CBiauRGPkGyyw/CvXx?=
 =?Windows-1252?Q?iHOWF5hSa54FfEs+7VqppnY6ln3bTCSXn6XL4hGtNiW0uPbuesn1SEqa?=
 =?Windows-1252?Q?O1fn9KnSrf/LQzGB8fxZwlq2yIq43XPDwIRVuAx8LaAZZK5E/m6p4YFz?=
 =?Windows-1252?Q?AAmidKqkQPdTV4bU2I9Fuou16kV+uJTxSCtdtpR/fLgbTCQQLSJ63UbY?=
 =?Windows-1252?Q?3+kEDKE9wcnJ97q4SCTOc0fMV4vaOnLcL8JEIx15JyFffd2KaCbx2YX2?=
 =?Windows-1252?Q?vYwEiLv/HqFRdo597jznnxFkyazUYy/xDRwdfKzc/UrdO0I1CgtrmVfK?=
 =?Windows-1252?Q?RQNxGDpMQNhlcOL42kInXSTUgqEKzhIZRq7zuO6ghFSxnaljObNjLU2j?=
 =?Windows-1252?Q?1vSpeRtwkeo+N1OL+101uYFuUT/S6JfgbdrgGEREl7AlIgwzpmtac3+y?=
 =?Windows-1252?Q?USYv2tXC20/nc1UN0OgS51Xw9x37CkPb0y5zPs6jiSjiP8CNUYc0zMH8?=
 =?Windows-1252?Q?fNKCh2qLT/uTaW7dFc+umQU2RTw+6gte37CLGsPKgkcx4+M8mYenis3l?=
 =?Windows-1252?Q?hAYBwa8LrLM24B64bmUBiTjJy52M6OXKsSK1+OB+rvvdd5KZJBMqCi7O?=
 =?Windows-1252?Q?LrCc9JLG6Bnq2Xrzjm0cfRO2i2InNHsFE5IXIyd4R08HbCyhfa9urMBs?=
 =?Windows-1252?Q?QOUTmAktE1yN4ARBuKbBgIQrpkkC69ADGo1K4ICqttja8AzPtJY3JxB+?=
 =?Windows-1252?Q?cXxfuNTHcLd4uVnGYNAqa2uBJHQ0PeiiHzciDHDX9906bdfXE9JFotnC?=
 =?Windows-1252?Q?2qX1hGC/Gnk4j0nT6++V/xlO/wjdVypAc8PYTNx7F367X2qolcu87x2q?=
 =?Windows-1252?Q?QjtjW7qAHyRrY2OgyxHonbqc5Zndqu3O5BXUTExKrz3br41/mMmcsjdK?=
 =?Windows-1252?Q?E3746AY4IpO5OWfrTxYn/1dx5w87Y84eXrMY4ZNLSgg4ZuWHJuH2TpBr?=
 =?Windows-1252?Q?y6Qo/3gLd1hw//zSjHcchjtMvnosiAvNfDOd6RXvKtTPCvqG5BNVoikn?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6704a6bd-fc55-43e9-e32e-08d95be09b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 09:24:08.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ptdOhinunddRYrRVSbVGhuHT3ASPeg907TqRXSKQzyoxV2BmGFl4L/F5Yx9tUifLYqrFX/DDudF9NyDiSVW3G1tW0jkedYMVjN7vnoW3uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1281
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Thursday, July 22, 2021 9:39 PM
> To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Cc: broonie@kernel.org; robh+dt@kernel.org; linux-spi@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [=93PATCH=94 0/2] Add support for Intel Thunder Bay SPI
>=20
> Hello Nandhini
>=20
> On Thu, Jul 22, 2021 at 01:33:56PM +0800, nandhini.srikandan@intel.com
> wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> >
> > Hi,
> >
> > This patch set enables the support for Designware SPI on the Intel Thun=
der
> Bay SoC.
> >
> > Patch 1: SPI DT bindings for Intel Thunder Bay SoC Patch 2: Adds
> > support for Designware SPI on Intel Thunderbay SoC
> >
> > Please help to review this patch set.
>=20
> Thanks for the patchset. I'll send you my comments to the corresponding
> patches soon.
>=20
Thank you for your review comments. I am working on it and I will share ano=
ther patchset shortly.=20

Regards,
Nandhini

> >
> > Thanks & Regards,
> > Nandhini
> >
> > Nandhini Srikandan (2):
> >   dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
> >   spi: dw: Add support for Intel Thunder Bay SPI
> >
> >  .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
> >  drivers/spi/spi-dw-core.c                     |  6 ++++++
> >  drivers/spi/spi-dw-mmio.c                     | 20 +++++++++++++++++++
> >  drivers/spi/spi-dw.h                          | 15 ++++++++++++++
> >  4 files changed, 43 insertions(+)
> >
> > --
> > 2.17.1
> >
