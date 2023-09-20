Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580EC7A83ED
	for <lists+linux-spi@lfdr.de>; Wed, 20 Sep 2023 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbjITNwT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Sep 2023 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjITNwR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Sep 2023 09:52:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121EC6
        for <linux-spi@vger.kernel.org>; Wed, 20 Sep 2023 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695217932; x=1726753932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1jpn9/+etpklPwN90vaet4mHKPDt9YytDNKCILWXMRg=;
  b=MlB8/bFqXDdCJs/YXv/Fhn2FMciZpurKa6dLF3oDcA47elaZ8mO9Gsik
   fRVYUvGS/p99FrEkY+rGxdtqIY0UykQKarQDJUtZOoIr1XSFzA07RJvhM
   Fc/d8ydcbnBB9QjFpjiQPzFAoRxtupMTBhmexsQ6EVXeu6IuSnLcKgJ/N
   VUo/k+uJyU+H70fOfDFtgLEIGzfPmt66G8rfTb/oJwUs7p6ftl1NKl1Ce
   TF+YJh+eDxKwwp66IKySRhkYGllFuLus5d9jA0C0FGfake/JcR1J+DeJ/
   EfkLSQM4kI0QX1xO8C4lNzCgfyY5A65zP15AFkIV2JALQrQCT34lXJEQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444317834"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="444317834"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870388089"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870388089"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:52:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:52:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:52:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmaKMkOX/gw+MH6ls7vn2OXzF4fiTclvlF7TPsMbgfM9I9fhSnK/RG2TixFoFjpfp73mBOPd4nbXPjpKk5Wk0JE8Dpeee4PnZCcf8oRtZ9OjNreCvmQ3T1dPvqulE+pX57IoKYoKrhXoj5oZ5ZCpgRsD5h2AdXmcohMG4TygQLDSvJ8swmhwpmt7WYLGbqLcNlI49NcQXV1JoJCJ8uxVM3XfmP4RZLCyAbaOMMpzqeH7rMwNvLa6hDdGtKgripescWZSXnWNksrFAE11QQYZjEb427O8ooNW/8QB9wfDHbc4GczSeEl93ikDJi60cgsAADRr8MM12RNzIl8QQPgHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jpn9/+etpklPwN90vaet4mHKPDt9YytDNKCILWXMRg=;
 b=X5DT9oVzBkqvSBngYl2iXS/MVklu5j2zl+FVe+oYCBN4aayhNFA000eOtYmgGO5dwNEWjIwReSmd6GMSJWfgj5VKPeSW3llxSfzkKyMp62BDB0YDiwv7rV0MFrebnzoxyYJmyY0MFNWULhgQgCzg9/MhFrX+zb09V+WnASaR1U6D44tM6yFs+lGj0Lvq/C/MwzYlQWa1/SaGRnHbf8d82RjbicEsWVBH0lJkE9T6jDi3OujZNSYSitHBpy5hs691SN9CHtOKAR66QEruym+Fj0tZGyRyPS37l7STj6j7W5EXIeWGcpZ0/d5nJGM6vzra3WkXgC9/2p3PtRrFhSaTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 13:52:08 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:52:07 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
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
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Topic: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigCAAc3FgIAAEJ0AgAAB+wCAAARvAIAMk8Ig
Date:   Wed, 20 Sep 2023 13:52:07 +0000
Message-ID: <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
 <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
In-Reply-To: <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: 11d9ed4b-f848-4f01-03c6-08dbb9e0c7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9YSf2kRNf/60+Cg31yjh6Qetd4/Hx+qRODNPffslNNXRl6EDEnXkBF0RMaWRGSI+C6Um6PhUfYprB+eZPh9JxkWCFSoafr9zfMig6fDcDibEd3A5XTCOAYcwAUv872E/slM3Re4rnOfK3AqUibDE/2vjsQoGvivsGVXGHufiDhWzXLC0OmLxizHkEaJjdsbm8shY6sI2QiAY+KIcNNPNxYQ8LbcmYsOJ06qGD+A4Pa4DCypFOBdTj+bHtR+UealUoEA75Fk1QaPIhnuYtKhDwKcy3u2b03hUi1DuSQcdH6REfzWoW+QR5XWuOLz7F4yOEq6cjKNo6CKWEloBKgDyd5pZ1XrGb0nCTqTjC933eIwAlkArdSh20SW/5KHttBmjrcsyKSLej6udFL7s764Nz9h7ZGMa7E6fX5xmJUwgrouAGh8zAJrfxjygwIWmbiIzjkQLJzES1LgvAcL7QtoCjKxHZcyMauyfBW7oxCJfsW8a78gP5bek+EIikJ+RKIjLvn3APKoP38ZleMNEAoxD8nPrz4Z4oN7qjr5zzIJzrYn34IZ0JhB5PotrJaexVJE27d+8JN/qXmLQB36l3b7fhpZ4YRhqXkGO4uFCpUlOUrG7lYHhXTKZaBsbcGKUacB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(186009)(451199024)(1800799009)(55016003)(64756008)(110136005)(54906003)(66446008)(66556008)(66476007)(316002)(66946007)(478600001)(122000001)(38070700005)(38100700002)(2906002)(76116006)(8936002)(41300700001)(8676002)(86362001)(4326008)(52536014)(83380400001)(5660300002)(7416002)(9686003)(82960400001)(7696005)(6506007)(71200400001)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQner26q1iGVzPTm+gFGYoHOzns5RZu3qlHlZ6gAtTk5DJt/SQZvVLvFwDoB?=
 =?us-ascii?Q?L3qGFJ2sahbep2IyRtvBTpb3gIXp/SHAJLPJw4GV/tBXUSHBQQ2E82qIJ/Bl?=
 =?us-ascii?Q?epcrYzGllC9+zRUv/wAfTQW0le3L2HTm+xjQcUqm1ItNZ8d1YYb0aAlDTzGn?=
 =?us-ascii?Q?hHO/G59HPlb8iH3t8pAw16Qgr+KzK343pdPwiCW9eujn2S7xkNXUUlkcn6sB?=
 =?us-ascii?Q?0K+3LkR80EfNJdUfTpzzgr3bn9+FM1MHwCdYAhEVeNhgzGzwKuVXQsBNoexC?=
 =?us-ascii?Q?GLU8FuoNEwOYyJw8xVdmBl7nA2aWCytDle2Lsrsh1ObIB1IY1ZhCsJ6tEkNF?=
 =?us-ascii?Q?3edKb42OmokCpYO3YZOGqNIIrFwppBqnH0NHadfday3f+hP2G/e5rmt4MCc/?=
 =?us-ascii?Q?AoyruTNu5wsyRGv+IeTZF5BiVxvD1LQm45aCJ/Y//EKxx/5x/d/3wfBlf6Vq?=
 =?us-ascii?Q?8SWR/0h/yRNn0LeD4N01p1HiipiKy9TKWTgUY+dBiG4I9jxuSFzIZGDinmv3?=
 =?us-ascii?Q?UK2CNWw002vPtcxr9Plve8lnE9P4alIsGNf4F9XkCAuLSIeMA0zgtUG2aRTU?=
 =?us-ascii?Q?wGFKVig18qEuhr5U6669OzdBD/+SRIyMCE7Lb4ndjJh0zhXuR/QNS+7RoT58?=
 =?us-ascii?Q?vmZiGJyBAhDDno8QH5wyKjKSUVBiBTT0XcWibaE5BAHrOCnk6rSOSS8nvehb?=
 =?us-ascii?Q?H2eIbnFZ8vbze+qz85X4cYm+ren11azn5p9XFuD+i6XwnZ9clmTOcchlFP33?=
 =?us-ascii?Q?93OQH+VcP23Pti0LoSjZnbYZiym3gtgxfCdJNK1lwbwLrQFBNkUzeBZe0T4K?=
 =?us-ascii?Q?yyHe1MFEMz69sVkabv5CRvhkwGSM2RxVCpObnnshvHGSJVFI+aZeEXPD6A4M?=
 =?us-ascii?Q?qGvM4FlBQk60NGjw0xrMRwbURx9xDQvg0rurbC8IbMj/OmYED+ugv0b1qlqP?=
 =?us-ascii?Q?At8AXaoNvnjk7ghdN6tsV8dIW2KLQktVFqUZ0AHBtwKzPS7EHv4BRCxCRUmz?=
 =?us-ascii?Q?T5H9TYcXma/49wp9nZRYVe/2Gvr1MJqcn0R/LA0HYijGoYiYh7S09QzrJ/+c?=
 =?us-ascii?Q?VoBh71ruJ0gCIsx6XPlxoehNAYYafQqLvWZQ1xJidsaERsKutUXZ2Ye+tm9A?=
 =?us-ascii?Q?/2xizL/bjv0KBXee60+Q5ibGqxtyIfXjehwZWRLfj4uI5RORzJ4rb/jy/ufs?=
 =?us-ascii?Q?6u3E/Vv/8cbVZdNRKmCgOCeWGUiWxVSr1HDPkEN4eBHyiBtMhxzIle2gVMqS?=
 =?us-ascii?Q?MPU9QQfJtv4BQdj5sH/vCUwgMUSjcw9cs/W/a0248N/6/M9sMshGLibW/kbB?=
 =?us-ascii?Q?OLP2aBV3cMHvfkUxfpNwIPuC0O4DpOZ+2MjvgtrtjjSoGXqvhSuxNL6ptNZb?=
 =?us-ascii?Q?66HV+v/tIuIGpRLIcPtF86GVOf4+yxKTzAzbbmlC9xg/ze/iVEWyA8SeMDRT?=
 =?us-ascii?Q?SdH3xCcQmPsLf1vwsCvZNJdXhaPDqp5KbnmaBzA32WdG0jX/AKSbnRMXMtzh?=
 =?us-ascii?Q?yRS+muAPD1nUp313OfI9SivXaLJ9dmeS4DeIULLoxM4tkef1sOH9Ba0Ha/tX?=
 =?us-ascii?Q?719dgdfBH2Cc0UDhp9lxeAus7HsVhXlqh2upC3AMt5wHNMcZHeYb2MAx93P3?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d9ed4b-f848-4f01-03c6-08dbb9e0c7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:52:07.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0E0ViY4yvbn6ocBEhx+vyEptH4Q2n0/koq1KMwuRWbUtiTJFdLYWUG2jVDIPkrvMNpsUHevYHpOStloWU55fnF8kR88JV+Bw0B4uWNfxoJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
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

> > > > No SPI controllers are directly visible to userspace, some SPI devi=
ces
> > > > are selectively exposed but that needs to be explicitly requested a=
nd is
> > > > generally discouraged.
>=20
> > > What are the options here? Explicitly request exception is the one.
> > > Any other way to add access to flash memory connected in such way?
>=20
> > Register a spi controller with at least spi-mem ops, as suggested
> > previously, is the standard way I guess. If you're not willing to do
> > so, it must be justified, I guess?
>=20
> Right, we already have a way of describing flash chips so that should be
> used to describe any flash chips.

Hi

I've tried to register spi controller with a spi-mem ops, but I can't find =
a way to connect to mtd subsystem.
I took spi-intel as example, which connects to spi-nor but it relies on JDE=
C ID of flash to configure itself.
We have predefined set of operations unrelated to flash behind the controll=
er.
What is the right way to simulate the general operations?
Should I add dummy flash device? Or there is another option to connect spi-=
mem-only controller to mtd?
Or this is too much and warrant the exception to have direct MTD device?

--=20
Thanks,
Sasha



