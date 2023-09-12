Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB879D1E0
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjILNQL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjILNQL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 09:16:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B910CA
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524567; x=1726060567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QHfpny+JBUusWPf4ND/ZvymZ/GrDJ1Rtj+TZY2RQ2kk=;
  b=gM5Ya/IoEvY/w2AgHfRVZEs9OjnP9APeVNvwMc+3mQc+J+HL/rykunvv
   atM/9J2++dKzD7VYTWvuioTE7O6wGytBUr2egFmCuFotQeg7riGlt24R/
   OP26eXpPMaQZZgTLpHMOASGNtY/FFLn/f9UV1FTfONpGTr/4h1vXK8WfU
   aipJsEkPef+LsjWaI2YKQh/CbMDmvJORn+3a2peD576xDvpgpDfL62EZ/
   mLOhbIREArw1O+JI00QNsyaoyVdiLFyaM2xcXapX0yMj1wFaw75MH/0CB
   nj1o/355+4hBaVSoQrzeoPoKx7mTBc/YzcJ+rTk/lYOO6vj4N7kiMmciL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368628124"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="368628124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917433008"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917433008"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 06:16:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 06:16:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 06:16:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 06:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ42SYwBhQp6SqtbbaBjUEhJClClD8tjIwcWZRBtWuLVDf4pLjqDN02z/xSOSVJKzwJAD0BfsOdjxXPbpPp+nns5yimAeTo68z+1DS7jJdA0UbRTujqKswzHXRgqInccEFaUoea+fuwBuhrjqvCqORYyn6vR5mRfgKJJadRCK1RoE8yPq5hTWWMK4z4wrBRYXCJoYkURYCkgtUu2L7qLaMFCB/TF7ALOC/F3rXFD0hL3XDrcFotkqMe7W4zz90WVcxy/aDwRQuobgjaoflllav7UYmUkCg42x/+U2DTIMNGtB204yEgyGQJVJWD9k6jdNsCeOTFw+pRT0BJad3EAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHfpny+JBUusWPf4ND/ZvymZ/GrDJ1Rtj+TZY2RQ2kk=;
 b=ZfhX0VSCmPZh82hZJVjFFgJ31kydg9fUSF6+ht/i065X2iZrLQKr0k+eot52PaiQVD3hXRvc8cleDt6uaK7zfm0ITPMaiFs4AhMroiR60RutvOmbv7lv+s6MpE6WCWUS/09W8frG5hLkTqwIwLr/sNGEoxb0ID4gTV6t6OnP4KtW8ml9awoTQkzhmW4z3XlCCWmdIufknOA3VUjEwcjL9gNI0EWe9am9RDjTPp7YatKDxIHrIOG1y2yo7oARSpYq99DbSasPtcb/lkvo7DA8ePKNyfRosXtU5Wyslgt80wGR9/sMSGzQ5GLPgo/qySp4sWSzwEKzzhshCTpn7liAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 13:15:58 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:15:58 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Mark Brown <broonie@kernel.org>
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
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigCAAc3FgIAAEJ0A
Date:   Tue, 12 Sep 2023 13:15:58 +0000
Message-ID: <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
In-Reply-To: <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH8PR11MB7118:EE_
x-ms-office365-filtering-correlation-id: 88839ded-b8d0-4780-9ca6-08dbb3926770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWEEqc6MtOwO/dcaD5OLcJNWmL1UFn1gHQHUqw0peqPNMsUHThaRvM8UMaVpzY5kcwHOJSUIp/9Jt0SQKrZpkl8TtGocJoMTAazqXsQr2clNl7x9Ka/Sm6wnxrmZ0EnWtNdQwyqJD5GwZL4iKuMecKmOxDH8xm+v3wgY75W/hPSx21FighCL72chjv8KkvsvSabCdZ0w4Pqya7cVMtVBBn/rwI3MBcGAXNcYuCDWhw59rN9gI0XTkRFsmSGx5TYpwGbFPMQZXW3Vv4/rfmgHHON9C+QWWBHd92w25aUYgDf1UVvYGGHuJT4KV3a23pLzf2vTp2HmrlE3tg6/DFhz3s3YetPpBMpnsOGNHuGap4/cRoj71quiNK/X0LAn3YrVd4fC9xabqY14kHOkX7UHh0jarVBGjovVmtgtkeLMu78AVPXtD8X0IvodZY3l9VJPRglPBYNg6BOgUGZehHadq8IkQRfe+vmZhWpcNxR5/U4OGOlA/P+XHxCswrbKF+StFRQD6DSiaMHH58zQRPBRFbvBrWHVSQgo7IyzLGjmB2YD6sne1A9dlk/Fq3LrEcg0XPiqHsjdXU6VAVbF42If56aHL9AAN2Fv7o5WoaV5uYKkPP96xNicQpTfkFz2TNUh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(1800799009)(451199024)(186009)(55016003)(66476007)(66556008)(71200400001)(6506007)(7696005)(478600001)(9686003)(122000001)(26005)(66446008)(64756008)(66946007)(54906003)(6916009)(316002)(76116006)(41300700001)(38070700005)(38100700002)(82960400001)(83380400001)(86362001)(33656002)(5660300002)(4326008)(8936002)(7416002)(4744005)(8676002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/OJbrod5DbwRjUwVqRLF9cNvoD6lFQyhTpSr85iv9uDlXFHtXOR1a02oZAtr?=
 =?us-ascii?Q?6huoHPbkaXBm3rN5w9+LqmtMTYEFkavNcoT4Vw5F/iKQYu8DwYWudeIomLYx?=
 =?us-ascii?Q?cEMX3Zna5+/H8eKhqSaHpUcMmo4/laThS24Z6/qs6ezFTMQn9D7q+s+26L25?=
 =?us-ascii?Q?2B87wIfuC6P2m9hg5SGgV/dhV1p5JZm1SEwhjpmIufaiuJUFRu0NbdRvrnsf?=
 =?us-ascii?Q?ZDQgpj73Me7k5kDjq6mArYkUsYOlAtxI93GDKUJPyy9On50fZYz+xExL2br4?=
 =?us-ascii?Q?rMBm3cRojt+uDI5+qAsBzZKe9kGQ+wcrPo6GXCL6fl8xWz4ZXNfBzIEyOjXp?=
 =?us-ascii?Q?u6D6T8XiBW4HVoeDD1wBYlgcYNuYBhCBZBLpzW3kQeutferQoaL3cjKZFjci?=
 =?us-ascii?Q?P20zxz7ydgFCxFL/PsLIE5yQqsaajIJ/ZtvXwvplPOGDi+Cz/NeiEJPKJ3vS?=
 =?us-ascii?Q?3H+5VKV5y3G/VzcXx8miYxb5EoyUwt/u8RPHyq6u32M8atffcECz7iHIxh4N?=
 =?us-ascii?Q?buaIvrCDmx44iCefqo4RmlcBtu9dfZ90NWDcx+bzVR/O2XiXbV9x4TBI6L/5?=
 =?us-ascii?Q?4QGZAEAQjC9521GXDxmau8/bwAaiU9HMCxwpepSubwpFBboxeBopq8npJBoB?=
 =?us-ascii?Q?hg/KQIR+L1qDetKtcProdK9LHCPGBaIa0O4Qmr7LyVVIl0D9ufLvGHhvdgSd?=
 =?us-ascii?Q?K0unroT0HoEW4lNdPrkpiSolXMG0MTz40reGL0OSx5RdIxU40l/c3YAqg4nf?=
 =?us-ascii?Q?TR4S2yTBDwuPpGMVXJ1+gEmICMUz0ROfOKW53ofROnFoLBP5P2VT5Q8yzqSS?=
 =?us-ascii?Q?HUp9b9pz9Fq3yrny3W8zaG8M1ngqUk1YUSgC8KZfBPBOaobwtA5RGX+79OGf?=
 =?us-ascii?Q?sDeTlhg3GVRqfvEbas0ibaKNGHq5IpzrYmBlIVjQU7l+7mLWRIFzcvxiSGO9?=
 =?us-ascii?Q?e3f9jxPKyjcT2ts1m3S16pSQZ/eSC/9sx+cdcYY5mavUlWXTAPZ8YqgdErQ3?=
 =?us-ascii?Q?E4ujILVt+HyEghAjZTrvie9Z0aVKBS5k+/q/K9ibhObHwsr/wSUkTJsIi7mt?=
 =?us-ascii?Q?g1b7TxpwacyR8WG3Hz6h1/C6Epzk0MY8lEHqI7mOD0Yf2cVxqzL4pFLTNQN9?=
 =?us-ascii?Q?Sd8AQZGiAbN0rKrgYboh4hXfIoUNSbyBzDcJmZMxLzg6QhMso7lHJv7xU/NS?=
 =?us-ascii?Q?19T3S2a7i4WMKkSMk13ffT6npSmg4od+8OIMYpDuMGb5xh8SOSe7gWqKA7ui?=
 =?us-ascii?Q?FgrOQkngnIAweSpGcXBQONJOgHT9BtwLvcyBNrPYfRgzgK2Bh/ZNjTLE1KV0?=
 =?us-ascii?Q?NCqEzoylhtJr08OT/x8X2a2U7f1wvUOAjiphlvoZpb1zk9gwnMQA4Su8hCOy?=
 =?us-ascii?Q?nMtzLMcpKj7/L6fSos+uVIHRqHBWK16y75kRxPgZbzhQ5yG1s+d6laqp0gOn?=
 =?us-ascii?Q?NqMBzwEIv1oVpMuvWjzfqnSUVMGUTx5ar0Lu8IU0P3PSXLtMFlhlglqVsZCk?=
 =?us-ascii?Q?iGH42niv/1ev2UcThNHbwXUTORxiH+FLkJJYUonM/gQFkkg2jL/oaHeNVThJ?=
 =?us-ascii?Q?1yG+WoPocQ/P+KsSjgh+GYcziMUrFrRO9GXtxvBgVaEhRdd2GWz0lH99xA5h?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88839ded-b8d0-4780-9ca6-08dbb3926770
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:15:58.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rVT9ZB/sBlSZFXlV5nKpxH5yCFfEhnt+RjGXFaOKyBpC0uXZ6/3fpgoY1wMjDfiCyDWAtrGukPYFWJaihm5ds2/OiTBRsIfUwrp/7G7DNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>=20
> > The spi controller on discreet graphics card is not visible to user-spa=
ce.
> > Spi access flows are supported by another hardware module and relevant
> registers are
> > available on graphics device memory bar.
>=20
> No SPI controllers are directly visible to userspace, some SPI devices
> are selectively exposed but that needs to be explicitly requested and is
> generally discouraged.

What are the options here? Explicitly request exception is the one.
Any other way to add access to flash memory connected in such way?

--=20
Thanks,
Sasha


