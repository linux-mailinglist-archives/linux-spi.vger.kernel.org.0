Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10257A8E15
	for <lists+linux-spi@lfdr.de>; Wed, 20 Sep 2023 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjITVAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Sep 2023 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjITVAS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Sep 2023 17:00:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF491
        for <linux-spi@vger.kernel.org>; Wed, 20 Sep 2023 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695243612; x=1726779612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RvIOsZcns0su/Jshi1Tsj8Zw2U0ZHFryQ9zXZYz0/ZU=;
  b=SJ7jJsDn0UJ6paeUB6b3XUdISE820voF76znXbt1n3nkofZsOp18JCDw
   yaQe/5aTBCpAl+O6VNClzBp3pfJtj/gZ21CpVtuSD1UXXOr8shJSzU85A
   lCjGoq/r+evhq69ymp4d6oS+lUr5jJ91go3ewXte+zCuAl3cwtSIkZXwd
   iw9eRbqBX+IXuySntJvVLCT5Ve7/spGB1PTL86WUfHPHFR1b1RkhJ8op5
   MkYY4E8ZZte/s+HjdhrDxePKvB6I74NT9nglfaZZwkzZC5UQ5Lb8RqBym
   neHoD7Jg+mCFW8E6XtONDg/DLODqopjW8tBswkq9wI+R7Lq9j0hTilTrm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360589413"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360589413"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 14:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077618460"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077618460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 14:00:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 14:00:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 14:00:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 14:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUSZsHV2PiXTmIGj67is4oKR/R6/NxBvPtBK15R2ysbFvIBodmAL8aVjee/V78ZTFRsXj9CsJxBOco5BwB/g3BW00/qeFW8hRhlXR7lbqeQlgFR+oUhC5OBXT5uMQ2O2hQmczuaBMApfeAOybQt1HkIyl88wJcTqOHcT6PW38semHwQigavxvbFsQpTFzMUgExuS1TXSmCsH4qiM4SkU5Pd7MRu0UjnG0/UbhWLlA556E6/Y1HZZs7hlU/lGpcx1Fuh/V+M8jjArihl00ZQ+Wg2o2vpz0bWcvs44VKSfb8B5YeHDXn44OXrSxQlj8frb+fKisnpLQnA0hePDBntY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPnV6V+sIiygt3/+N+X9EMErVJmIdqVhy0FVM6mTaDg=;
 b=THEb6NHA/pr1RSqZbvAzhRpmL9zU27o8130KwHL3v7ydBwMXauWsmaFPp9jMd90u3vWJ51JF995DamlTEQAhzDgEmpCnFAyvCgJx1yc4QrrubAePJPCn1ZUh53MrfbBZz+2PiT8Yur3C4tGiFqh05DIkmVmhi49y8dsMBW8mH1PyLdHTk/yoHemQJJlmftS+ZKF637QnvCX2+7hIH8Q+PoHuE/wksqU5M5l9HFY4D/Y137QRbqE0zv53eKd9F9G1PR4s0QxRdViHlmSRGlq+Km7noyq2YfDb9hR0orfjPjjCv8z3CtNr0uKOkq+Kj7JvKMkMoVx4H40lxMuKDXuCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 21:00:09 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::60bc:138f:c2e4:f7e3]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::60bc:138f:c2e4:f7e3%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 21:00:08 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Mark Brown <broonie@kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Topic: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigCAAc3FgIAAEJ0AgAAB+wCAAARvAIAMk8IggAAlTwCAABcL0A==
Date:   Wed, 20 Sep 2023 21:00:08 +0000
Message-ID: <MN2PR11MB40938110726F81D8CE305FB8E5F9A@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
 <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
 <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
In-Reply-To: <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|CO1PR11MB5201:EE_
x-ms-office365-filtering-correlation-id: e999a106-ec79-4a49-55ba-08dbba1c92dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEOFeZhZoeaY/qQq9o70JleCX2a/tQ+4jTc0ufPWLFmIF0+7aDt8jJQcMl8jKo9W/wsp8R+bTuAc8N8H7k3K/NhhjbmjxgpP5jvBpdLn+l8nR3BFybGnw6II3Mfa1isro/LXC58dozXBr95cLGVoqjLq0WI00D7C7Cpp7qzNW3KRgktFkR/ew7TAp++EXYpZ0H2NhIk6/STevYfRwUcuJrHeBYAohfrtGOnswAUPzsP/5Y5qRKMii3g+2XVWt8rdU1YZx39OEe9XfUSx3t1H+myQlY35j10C4mUZidAaMVFwvU4M5qv8exE6Ultyeu/TV+Z7hD2AT6UlotIkKVZmYn8NhdQ/dE1DglAauVFp+4Bm6AJayLPeGeZh7tjNs0Fe8GiXyGpt8wFC0CbVCL3RqemPrLRbfTBEaaxCckvc8UkZ6/JRo93/8G6Sn6VBk4BwFmjtdzoN2PYLaThFhI5UQ8ZYRCqhXTkivj8ux8/kmSFXkNv94+fMjiDMHhu1eaAkXkIKMNYqxuKV+ztEQwAqpeD5ZIH3bdvPwvtuwLg/RUmpe2Tg9ok/+hpC99Izfxgnk3LUxNwMz0Usqwpx6o/Cz54kKKtRjGmSFfImwD6LybTPLIBUr3ANXii17GD3SK9L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199024)(186009)(1800799009)(4744005)(7416002)(2906002)(52536014)(5660300002)(4326008)(8676002)(8936002)(41300700001)(316002)(6636002)(66946007)(54906003)(76116006)(66446008)(26005)(66476007)(66556008)(110136005)(64756008)(9686003)(478600001)(71200400001)(7696005)(55016003)(6506007)(122000001)(82960400001)(83380400001)(38100700002)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2CRxuwK9nWjmpJNVZes+1YxnRPoSqR/qY2lcyMAtZ4nej8IM/NOwjVuxJpbt?=
 =?us-ascii?Q?vUAC4E4jZaw+swG2PhnaZbB/suBRt2jxe60dfhgR23DuOMSS1enKUwUWpVAe?=
 =?us-ascii?Q?OpGUacK5W4AvSiggZKONKTvNpI1+S35P0qd4QnSPyN5TDtrQ8YjPgE2EQQmA?=
 =?us-ascii?Q?jyNsO7jZlkaQ0ZiOVqKJGlllsYhN8Bxd03cihkiOq0o+9JVErn8Ld8BOxWGI?=
 =?us-ascii?Q?lt94EZIu9VA3FczcxouQAk+C0GcgDcFYyMTvJGtqCOEF9vN0l44YOxXw52l9?=
 =?us-ascii?Q?o5j3LxfguxXaM/KOGYZf2XFZgXofPHogJS1P+xru90d+Bl+EiXr/s+X5X/Ez?=
 =?us-ascii?Q?zjaUGaD5VeBYMtd8ODevq6nE2sfQgDYZiDhae8N83lZPfTKKKDm4PgUARp7d?=
 =?us-ascii?Q?KkLbU+tN4dPtHDYerFEYJl+CgBkGzPLXYYkcsstHgq53zg3zZdIV8uxBFIax?=
 =?us-ascii?Q?olTGVmMi1TiASsXBpZKajBD+knm41U85+IMAJuCudkMtEZTzxH/BINmQFc+f?=
 =?us-ascii?Q?yWA6cZD4MW5S2fBPUqYzH7PfRYYlewltGGj1hIzxRGufbqlpk9MQxbwaVPAn?=
 =?us-ascii?Q?49hyGchGeAsq2kzZEwoHY2qcPE3FvJodDQO76gqr0Uljzl0yOEJt3lDvsGfz?=
 =?us-ascii?Q?tLrpTBefc1U69+lEmzida+hY7M9obWjozpiueRHJClYt2/bqKwQL5Go5XiXC?=
 =?us-ascii?Q?9awGL9lXpQMr74oHwQ2eCdEBJ6O9/YEy6MP4g6qtN7SOA4YwMnssmjADTI1a?=
 =?us-ascii?Q?tP/zOD4wCwnOXbSaQIEO6fzbc87lU1QKyQNIQd86qvc1w1Y/eNf9FvHjm/67?=
 =?us-ascii?Q?P/s3ZGWQNDYt/ZZg30dZmg88SsYwApiLSQwWPufq6CWlbdtOsLYk7dTxsD1J?=
 =?us-ascii?Q?gFxW7y+an7prJtNGAm9USkGUQe+C522QT0ZFTghUqRso5RZfL9kcypRdd8w9?=
 =?us-ascii?Q?vfWiCpTmbyfJ8rQdm8gmHcRxdh6ZKlKDgTetQhYzitQ5I8wAB+SusvUSFk5T?=
 =?us-ascii?Q?dNFQGxx8/JyfAz6GKWtG03DMD751mAFK7M400EsR4MR1ZhQv8XkqzWZbQNJa?=
 =?us-ascii?Q?OlbFnyJYJ5JNIMCTmLfwjSluvLAepEtd/cGFmusLWr6F5y4ahDlBvgY7bAK4?=
 =?us-ascii?Q?P2jJ3fN0/uf5yKJinGtSWp/GGHN3HqmggfDujidMzg1GwotEPZ5tjCuMUHUD?=
 =?us-ascii?Q?6ZTgI2anlv3mAoN2Hcn2fJx6Vj9MfC21SVQZSBOWsAl0h/pccgI3qiVObWCX?=
 =?us-ascii?Q?shJVStsc2YASehvINBJEAZwfeuZ/5dzMXpJa/tBj3N68fa7oG4jnskKYYoz4?=
 =?us-ascii?Q?e8LUIDQrUx6oL9l18b4UmWu++nqyUnZtJsheWaz2OocmBarOmGS35LVfDo/8?=
 =?us-ascii?Q?PhhEw2ljR90jv+d7Q5bgRLB2NHzb7SNG4tgV+MfO1c/okH4xfoOpFnOV8dG4?=
 =?us-ascii?Q?b3eVtrTJH4+c7vrCvXYU5mw4A+GQOP1adZihfwrHOmBZukPZMnDQt++ffrjJ?=
 =?us-ascii?Q?dj3iFoD3stzHklNcLAzYZmjKWZqgopYlcotaT/7FHhrQSfsoObgOzaWqdOLP?=
 =?us-ascii?Q?P2991Ar5mDRUM2AbcEyOd1nijO0edY+qa+UwjtM1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e999a106-ec79-4a49-55ba-08dbba1c92dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 21:00:08.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH60r3LNYLRDNZGNtc1XMGqyLiVHK6B+Pg+1kI71rtcoRrJgyRyGB4Nu5lun5Lin6iOtsOPXLXxo+5zsJ9VJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


>=20
> On Wed, Sep 20, 2023 at 01:52:07PM +0000, Usyskin, Alexander wrote:
>=20
> > I've tried to register spi controller with a spi-mem ops, but I can't f=
ind a way
> to connect to mtd subsystem.
> > I took spi-intel as example, which connects to spi-nor but it relies on=
 JDEC ID
> of flash to configure itself.
>=20
> You should use the normal SPI device registration interfaces to register
> whatever devices are connected to the SPI controller.  What in concrete t=
erms
> have you tried to do here and in what way did it not work?

>=20
> > We have predefined set of operations unrelated to flash behind the
> controller.
>=20
> This sounds like there's some sort of MFD rather than or as well as a fla=
sh
> chip, or possibly multiple SPI devices?

Yes, the driver doesn't talk to SPI controller directly it goes via another=
 layer, so all SPI standard HW is not accessible, but we wish to expose the=
 MTD interface.

Thanks
Tomas

