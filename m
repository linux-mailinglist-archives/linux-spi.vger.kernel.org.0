Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB147B0648
	for <lists+linux-spi@lfdr.de>; Wed, 27 Sep 2023 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjI0OLx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Sep 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjI0OLw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Sep 2023 10:11:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CF191
        for <linux-spi@vger.kernel.org>; Wed, 27 Sep 2023 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695823911; x=1727359911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vkF3R1bJ1jbSeuzSAq1TPdHhu2Kj5vZ42mxkiW6KYT4=;
  b=WzbfUlPKndUGebwlARF4gOKAzjHPbktF8PdEtJ787b/OeGQuXnifXfzx
   0Gd3/6sko+zTAFt2Wgat2kKcOQ5r/1NRjM1c7CMOeaEIfWlGKTi2hi94E
   4O3SLCbms43nwdXcL1RsRFiuQQSsDs83P+skkUb7ormF34eOGVBzcVVAp
   KDzIiqX+bBYVE6sUAVUk1hpqwu2K7zgedrAvYSAps6w4SZDbjyleiunmq
   hKhQGpsPIf2Auv5aQr5hmMS68VoLJldFdrGz7060T5Oxqh8aU5JBgZCm/
   fXTBMPU/7UXbaBvswt47Zc/Rn1RECWKbrszmvBpnZjdHq3eWTb3kkYDub
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380713871"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380713871"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819433033"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="819433033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 07:11:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 07:11:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 07:11:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 07:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReecqEiKOpKcEn5VT+z6IfeHRiwRB/kxm00NSunvIRoJLlFmhsgubgDbQekqRCcgdWIndKOYo/LRk0suiQFQR9O+EI5HTAPkc1nrToP/2nni3AE+2vBBXmVCQflIAM7mFoNBuj85kxMFamN1+r/rv5ftnwcgr1cyk52jMgtJpvuYVwslDWzschM41h5KtDFUy1FMjrDMZoAbT9P0LZWtU1WQHVLaj2pX/39jfehScdZVbd78r3KOrgJCxFtUP/3+OugozYDTTciz9JzLJixh3DVxw/kOZlnApmDDPLfwcFBmDkA13ztRxETOMl3aiTijaymRRLB7TBZE+/yA89WVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnUHrd0Y0dzkCa13k7qLqupvJ10M7SP9ab4ESib58kc=;
 b=DeogGTnSRZXj1BPWanqaAQ03Kh3o+D93bQq/mmhLSwsMGZTlyPdyGGhztNxvc38Rr+w19Pl+enslm6ZwCO03oMH/bvcODip+2IwT1K+mI76RsQo7IESX++DiURbExnwjf94408Bv5UUXe1uPRJLeb26cwhEcGnTD2buf/A4puCSWhJLoEUcsGZT5WwRS7ykhOR59hgzb8M0gAuQ6jSobuolLvudcVx6FOdT6hEy6f0E0e3y5G3/D1FBl0oCnNCYpKVJuA1xVG4Ig+j/xd5fmnRAV2V3PlRM0+21q74wjCILU6RBdMJi4ZsZJcbwXxIdw/k/1vOTJyRJ3d9AVfG39fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 14:11:47 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 14:11:47 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Mark Brown <broonie@kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
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
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigCAAc3FgIAAEJ0AgAAB+wCAAARvAIAMk8IggAAlTwCAABcL0IABMV0AgAk58QA=
Date:   Wed, 27 Sep 2023 14:11:47 +0000
Message-ID: <CY5PR11MB63661B36FFAE9455504DACD6EDC2A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
 <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
 <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
 <MN2PR11MB40938110726F81D8CE305FB8E5F9A@MN2PR11MB4093.namprd11.prod.outlook.com>
 <0682443d-5219-4aa2-a932-ee3e04c0760e@sirena.org.uk>
In-Reply-To: <0682443d-5219-4aa2-a932-ee3e04c0760e@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ0PR11MB5790:EE_
x-ms-office365-filtering-correlation-id: 6071ca6a-1e2c-4889-c784-08dbbf63afdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOy2WE/iZSh2M1RqZPKpGb4ke5w0ZHCcxzl/90HCE7eOcQxhRvNPDfkjldNffXRHbFjtY4smrX1AAEvV9PvA9Ac/BgvwQUth6gXQ0G04c+RDqzRp+uq6oM7+wxSIH5PeREvRJuvYN2jTpQpRZulrt9Qkmxge7yB/IfLvwv1pGACdQT4kEChPXuhQqiMG/v/ivCDCyXIay+Gte6ZCZgG3QF8RWEdaDBpv8H03MuswBuy/TuLCKdrTsk9s3Js2SOriq4asvtl9cfNknGoesjW5nRJ3Ht81l5ekJ62vXRiPGjUJgQPDmch4Fy5MlvRaRyRiuUlLLC/wIHit1ZRiTH/SO007PiG/MZR0mSZ0/GF00e+nZcrXM8uz+ubslPvs1oc6RiZQ+7vtmyuQHY2/XHv4AezBfHNGJJcvT1WLURKaHOCMYJZAGNE6xXBpCtXETOn+SmirQDWpYG8ivIzRu5oAzjGARacPdaXP9XJR87XoUMhVAyEPbgQT/IqVBG25agLLFZIoTjDfHY/wD0LUwr/9iDQTg6xR8fpQ2FIx4C6FC4VEXqTYENSvBJa/LLHvmfaFHkwZ82hiSW/3EvQCbqafMhMHhWV3NqDQJUJzKPOwZZdZPUD0oyvrxBvkTIcR2I00
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(5660300002)(38070700005)(38100700002)(66946007)(83380400001)(76116006)(110136005)(66476007)(66556008)(122000001)(6506007)(6636002)(71200400001)(66446008)(82960400001)(26005)(64756008)(478600001)(316002)(9686003)(7696005)(41300700001)(8676002)(2906002)(86362001)(52536014)(33656002)(8936002)(7416002)(55016003)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yzbpEcUhvSNOLFskGKfwJ8P+5Z/grXQqbJ5D1tHTKf1jpaBhxcUPBiPfYZDd?=
 =?us-ascii?Q?rfZoqyU8gQCQ/XlS5RcB0411u86uYAMz7K6Yj8BKwwK5yEdmdEgBMBkuOBVw?=
 =?us-ascii?Q?7WQVt5xj0hyHqwWytG+CAjSFYHSho0Yoq0+HB99gJGCR0M23CSWWqupjFkMu?=
 =?us-ascii?Q?2sllajWPZ6GPh+UITOkw9D6Pgi+y+BsEm78lWx/bsz57+/6u/CBPBY/qmTEv?=
 =?us-ascii?Q?bcpCj8nf029c6pmgBqk8+HUuH/layG0QX+U/qXjWqIS7nM/Xx4tBT5zeCHk6?=
 =?us-ascii?Q?RHimjqqRUcWOO97kJu5k5Hi+r3npoWt5W5aEmz7WMvG5rpmnMXHJK8ZfFBhV?=
 =?us-ascii?Q?GYkRnP30EomALKN3gTIFLiDEC3LwqWTUdJtpP26CCeNk+VxbIQNjVWNT/AQY?=
 =?us-ascii?Q?54w6KH4lLW5Bofy9tFJ8C4elP5DF86OSY9l6X6ZyuU80UCrF8+MV1PsC4Nt+?=
 =?us-ascii?Q?MQv0JyS5S7+UqdpkKvdkqmY2q9naQ6JKNM59ONndnNqd24Hm3Ur1RHibIR4H?=
 =?us-ascii?Q?zMlyfk7aroWzozTZ2yN04r7bQa3gFLujC6UBV33iJ6FFcBc4EETuSHX2l+pN?=
 =?us-ascii?Q?vPSOZADxfz26ZwFoUznsyADRP2wC93tOPKcSAtOAUA2OtaP0kRzFpADnvLj7?=
 =?us-ascii?Q?1wxosnoJgMX0ENTNjwElGm+LDrAtaHQvNg6yHiX8borWyFt/ZYB4BLmW5r+M?=
 =?us-ascii?Q?IbTsD+xmc7E5fJTdgbW6KaTjRqnaZwfGExcbVlbIdk32UFuq9BSki8mxVhqN?=
 =?us-ascii?Q?jOa4NgZFAlpESV9SNsN6MWslP0Xs5ZseQytF+2ROd21pYctjzfaf8jsj0z8y?=
 =?us-ascii?Q?ZJhurS4a+y7SHNGzopsdpIiwvZy8ZDe3rUNdEh9KVPgntCXrT6BdwW+wYh96?=
 =?us-ascii?Q?pRkJnooNlGg5r3d2OxtHC0MgaUCJqA27vb9pSRF6QgYhGpeg4uc+aRt9ZLlf?=
 =?us-ascii?Q?vh8kbhlPEkIGW+q5PYPeKf5+mmxM01EG0hF8YtWVfcXA8dpFIxPsP0ZrklXq?=
 =?us-ascii?Q?9GW0Ed7l3uIIt7d7nKVEjZlzeXw0ISbMS2WVDTt0EfDb44wDRgQoqh+7vHoY?=
 =?us-ascii?Q?nwllzUcsUvM84wlpU7GpoL4u0hnFvgbsMxUv77rb8Gxi1Xm5SmP69118hXni?=
 =?us-ascii?Q?yiM+6D7npooFnIM7hZQwlMvGcWfrxubmUU7Dy6K9mxkL5AmQxd47aqolECQx?=
 =?us-ascii?Q?TDYPHY4wikm5xV82g/CBYXIVstvwEppgEsWywAYkAo+Kqaogy18RG+ZU/0EO?=
 =?us-ascii?Q?bo5duXb3MgP8oZuCmdtH+qdR9OExpZqxl9uCW1PTZ1OuMcjgAvE699WGNU1D?=
 =?us-ascii?Q?sxSjPNvb1VJbvLTLD3XBXf5aJy8a5mW0h4myzOtJ0RSU7rZXUE72SCB7czjm?=
 =?us-ascii?Q?MNlPBIK2aQ2Kl6fQgGzwrYdPmpFhOWpm4v8w/nXE8xm70lLMilAJC88RZxJV?=
 =?us-ascii?Q?3V6f1g/OjMYnKur9GjYmzKZpGiJpSCqERwxXQPltywdCNdft0NHa1QaszZ7C?=
 =?us-ascii?Q?HvIJctoQxo5xdJYgGul6F6JEoa745p1lUnGCtvrWAhP+8coWTkz8wTnsZI/F?=
 =?us-ascii?Q?SlVrjBTlwW9YFj128C29Bpv+5BUwGvUecSu8MD0X5c9XAC3N/KtrVXY1edca?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6071ca6a-1e2c-4889-c784-08dbbf63afdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 14:11:47.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tErCitLOnW8WessZn6QFcqStDqYDMchjl20dzV9NPdeuCU8nfMhHHXdedQKZ4htsjNB8CG6ruGLdYFyOIDvueHAYpOMNoRJcau31+ET6Zzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>=20
> > > This sounds like there's some sort of MFD rather than or as well as a=
 flash
> > > chip, or possibly multiple SPI devices?
>=20
> > Yes, the driver doesn't talk to SPI controller directly it goes via
> > another layer, so all SPI standard HW is not accessible, but we wish
> > to expose the MTD interface.
>=20
> Perhaps if you described clearly and directly the actual system you are
> trying to model then it would be easier to tell how it fits into the
> kernel?  What is the actual interface here - how does the host interact
> with the flash?
>=20
> Also to repeat: please fix your mail client to word wrap within
> paragraphs at something substantially less than 80 columns.  Doing this
> makes your messages much easier to read and reply to.

Sorry for that, I'm fairly new in SPI and MTD subsystems.
Will try to describe as best as I could.

There is a Discreet Graphic device with embedded SPI (controller & flash).
The embedded SPI is not visible to OS.
There is another HW in the chip that gates access to the controller and
exposes registers for:
region select; read and write (4 and 8 bytes); erase (4K); error register;=
=20

There are two main usages - user-space manufacturing and repair
application that requires unrestricted read/write/erase over flash chip
and kernel module that requires read access to one of flash regions
for configuration.

--
Alexander (Sasha) Usyskin

CSE FW Dev - Host SW
Intel Israel (74) Limited


