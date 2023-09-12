Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72179CED7
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjILKud (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjILKuc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 06:50:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF2B3
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694515827; x=1726051827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WbmE8YVKM95Eg+mn6XusQ1mz4yjbN8MqufZlI5uCfFI=;
  b=cY0LvmCAFVfl63d/IjSk7xRKP+MhBYFZDS2sMdEH9tg+L6YstajxooxQ
   xG9JMIytdtl6ZaEnz+ZWFsJHU4iCc3KBweTxCg9jSyKU1fSOzX5TV6F+F
   7IsydeRggxkVvkGXj2ajAXYDHNsEOf67KwIxG+mRBQVjoC8tdu+P9h27w
   7W+gwxk/MINMqn7J9Fq3OuTM11XYTkIGlNsOJhYXH8qFAzd8RNKoGe8Ej
   5yEgiRSVkRQp/d+r6tU0ALpLikSSzi4+krNBhB8+IkO2vaKwJ4lMfVFN/
   4i+jqArzH1m+Us0eijM+07xfR0lMiQZhnb89zgvMmZFwPyZjBFv1geGgS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378249791"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378249791"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="737087944"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737087944"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 03:50:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 03:50:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 03:50:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 03:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFp66rlzM6Tzri5MTGxI1Uconh0zTzlQqv3ZU+/2I3DdOvmPWHqiNBqSbLEVnYqzh52FXRAQ628vUxoC6EdsErqhbEKhdWfCYf4fWwJwW/jHKa/A9tCxKP+Y5PoAfWf6zmnkk60jKbv6lwPfTyDG+N0mf4RyEoQYXjkZSJaQzh45Qah8ia8igEth6AtcgMabRjuoHMgL2r9tKfNEqdoGjqqhf2aI8p/2PyLKmsIoCOYNWtqcG0m9uDHAxu7xHscVMbPsFthelIjOEyDSOyUGu9EBGaj/S0fmeeOlAKDVZgdlPv/ixth3Ea8ZRhXb6N0YG15VrWeJVbMyG8ILSwlHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbmE8YVKM95Eg+mn6XusQ1mz4yjbN8MqufZlI5uCfFI=;
 b=l53q2cnwsoo5eR3RYRSIJj4dY/XM8a5UX5QVZZ0DV178UxNecytQOmf30k1VC/mg0iQ4FlnDSwunMuzHr4xHCTwXtnc4h067Yjl8EjmIG07seQwElYac/2CsRYl3li2jBqSS1B4woVpRshyWGyE2JmsrKZE9PySwpZu6q6RZOf6lrkbf/pQM0GX4PTb5NtZEhy2tVp2nz8lBYqO0460M+IXqgoVsYcXH5b3HpSotlyUvMkCwFEMjvKDa11qibi8ekACGUXyyP1/dR1SvshStP6OqPNcq/XPtWC8dHp03NHJsS1bzH7bRl38mkzOeCiDkGGwiFOjdxhrmmp9vXEIPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:50:22 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:50:22 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Topic: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigA=
Date:   Tue, 12 Sep 2023 10:50:22 +0000
Message-ID: <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
In-Reply-To: <20230911094233.326fd936@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB8479:EE_
x-ms-office365-filtering-correlation-id: 40c40db0-79af-44c5-4e63-08dbb37e1063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5550iqul5EWZrkLg3iFP1tIQvas6Q9KXbL7zpcdvb7uJK0b3YbpHEAycgDG34jyWDOFIISWaR6LPcpPxsneFONqeEgUmoY38t8WRkd1coZkGOxO7zkgxr5AiiITxjwvePJsISAJCN9PLRN+1Bh/75ox1PS5dQ0ntPKnesi6E4n4l8ux1lrY9m9aNZm0uc0Jjx8ICBBPHtR0Zy4/dJcAe5KRGLzLsYSQII06vP2O+SWXdx3hekX0ZHBGJlgRKiHqbQzcEkarsmy8u+uLKHOZLv6d6NjO/X6sxP9xDCBDYv5ADdedLB901neimRs/yrA42KRNLMq8TsR6vNqDPDojcABLPvDt+Gme12LG02SdyEjc2OuydEE2wC4LTOX3QZK3pzMGaxua8GfRyv9xCgj7OFke7W/xPTUWAGa+5OLBQKD7+Lnz36cfXp29DKhYevPWDk15MPqy7z+QWhGeYblT5A4ZzWq4Ejdu8JcebpGrfk0+K4RHv0rdTUeejqeHvDhzr9Epv3evP08DC7TdgYB+dOhwQi3W6MiVmbUeB9HWzuXcHKlZlw2+XFaFzD4fNhzBGjo/Q+B8Dkd4Hu3lOSSwPuGTrf9I7RkktoqZHO6iC7RIVtnUNWuBDajFcc+9emHJ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(7416002)(66574015)(2906002)(38070700005)(38100700002)(33656002)(86362001)(82960400001)(122000001)(55016003)(41300700001)(6916009)(316002)(9686003)(7696005)(6506007)(66446008)(66556008)(54906003)(66946007)(76116006)(66476007)(8676002)(4326008)(52536014)(478600001)(64756008)(8936002)(71200400001)(5660300002)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhtR0ZBcHN4OXNxOW10dGZWMjNTa2kwZG1WaTdFWm5nZ1pqeXY5K1lPT2Qw?=
 =?utf-8?B?WCsyTy9pb3F2dDRWU1Yra1VONXZGcFBGVXpLcjROOFVhSEQrdjhWRmZUQUlw?=
 =?utf-8?B?RGtnalNXSVRrRDFSNTdmS0VYNWE2S3hIWkVVVUprSk1BcTFqNHV2V3BGQjlD?=
 =?utf-8?B?TGdpKzhjZjdHK3dNdTByT2tlMUVUZmlUcGc1Ykd2Q0Z1K2RiTTZHSk9BSFRN?=
 =?utf-8?B?YWFEbkJpZHU0dnFpVEJMMWY1Y3llNHZRYTM0U2V4cGZiRFg5Z0pjT1JKeS9H?=
 =?utf-8?B?OVRtbzdYMm1yM3EwZGF2TUtBOGkrbjVabkxmaVpoUzlNdTJHYitVTWw0dlFY?=
 =?utf-8?B?WW1jblVaM09pdGFrVFA3Tkwzbnkyd1IzRXM5UFJva3VDOFBhRG00R01lekRD?=
 =?utf-8?B?NVc0R0s0Y0E4WFhWTStQWncvdFl1NmErV0JRYXpSaVVMNnFJaVlJRmgzbHc5?=
 =?utf-8?B?UzJJOVN3aXNsMW9xKzNJVitkR3dBZ2J1bkN1VWh4QU14TjNvK0MvemJTV1kv?=
 =?utf-8?B?aVhPQlpDN3hLR1RGRDMvem9adSt3VERBYzI5NjQrcDNVNVVCTDdPTkU3TGE1?=
 =?utf-8?B?QUVFaVVrSHR0bXJ2L0kwVi9jeWg2cCtVMU9jMXp4bzBzSk9TMzRqVVlNNG12?=
 =?utf-8?B?Rk40TGt3RzVKelhuTUVrTS9ReG16S2dNZTRVMGpUbXc5Sjd6bzBxT1NKNExB?=
 =?utf-8?B?TEVCc3crSzJkUGxFcWFkZWJIdkFyYjdCOTM4MGFjQzBsQWR0VjhWejhYN1pR?=
 =?utf-8?B?cGs5a1Y5eXQ1UGFCWVVJUHZlQVREeHFRNElmRld2cldiT2hBakFKUGVVOURF?=
 =?utf-8?B?WGZDb0tzcTMwb0hjNWg3ME5pWW5HWmk0dmIyeUZ2WXh3RlZITEh6VWZEZm1o?=
 =?utf-8?B?UDU2bEt5Q01ZV0JDU0hVdkdQTWJ4b28vQVdSVytWQ2duY3FJZDZkMFN6bnd6?=
 =?utf-8?B?bXpCMmpkaC9VRXl4U3pJY21Ddk5VR3hIWEZaWitFK05zSGNBNDJKRENsZ1hZ?=
 =?utf-8?B?dlQ3bUtEa2tNSWlZcTV6U0wzY2dTMWtrYzM2NElMcmVKUjdQdXRvaVhzTlVW?=
 =?utf-8?B?RjV3OGxZK0E2VE5udk50ZmVPWTNPZHI3a2tCU21oWncrVHRkNHdkU0JpdnZY?=
 =?utf-8?B?SXE1UU9aemFnM2hGTWJreUtuUHB5K0NLZG5kK2JENEl1UlY5Rk1ENDZIaFE2?=
 =?utf-8?B?cTREOEZ1UWx0cXJjV0xsdVlZMmZBbXBLZzh3UkUrT0xIMGlOUExNc2xVaHQ2?=
 =?utf-8?B?UGF4UnRDRmllZGo1Z3FUSStRU3VCM0lJSEpiUUZNcEN1b1o4a0p1bEJ1Mzhx?=
 =?utf-8?B?V1NWNjhBS25wM2t6cXh3U2JwTXNjL1MvWGliZFlpNExDNUxqUGs0M0lSZ1Z0?=
 =?utf-8?B?NmdHRjRYRWVySEM5T1ovWmZjR0E4YWJhanErYVFaenJWaFFuY3RkN3VJWEd5?=
 =?utf-8?B?YW9qZ29TaEVhM0F4SlU0TWJoL2tkK0dSRUlzZGNtaDArNlhzbUxNYm1sbHo3?=
 =?utf-8?B?UmVmZ3ZodE5PTFBsdTA3bmpuZllXNGFtb1FxNkNtOGtYWG5YcUV6V29QcFZH?=
 =?utf-8?B?bmZsd2JadmJpV0U5akJPcUNQMjdCTStqRmphQ0ZoQVRjWDQ2TEZ0bUZjV0FC?=
 =?utf-8?B?RVNNQnpacW5jcVlWaVFxcUxJSVJsNUZTcno1THo4RTBCNWRSOUh3c2QzRGlh?=
 =?utf-8?B?SmxJVkxyNjhhdTlyR0FSUjI4VVcvYkVLa3hSdWo0N0M2Qmp5WFN5U1FsNE81?=
 =?utf-8?B?cGNBV2lkZ1NzUUlRM0RRSzZYYmQyUWhkRzkvMmphT1EyVnAxYml0d05CTDMx?=
 =?utf-8?B?UXRSL2ltS1V1aW5CSDZadm5wTkF4Yjd2QTF4aHpZS0wyd1ltck0zaU5nVWpL?=
 =?utf-8?B?SHVUY2NvTlh0VUpac1VHdTVIazlaSWQ3YWtvbEpOcW4weUhGQmowQjdpR2VJ?=
 =?utf-8?B?aG11Q1dJdUoyRCtXOHc5SHczT3Y2Y3RKRUFqYll2ZDdiQVBoZzdQejVJaXpz?=
 =?utf-8?B?NzEyVGRKYUVFcEV2OXllWnR0bEU4cW1TTmhMc05wV2xGMXBQaEE3MU0rZ1c3?=
 =?utf-8?B?WkZTQWhFREhHOXBCSVRqV1JoWGhYbWVubWNEQnJ1Wjl4TmR0NUFKMzlKWWlR?=
 =?utf-8?B?dGpCNU40UlRNaEczWWdPMGV6UUoydm5yVUtqaFNpM0l4UHdRbTYzcThzdzk5?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c40db0-79af-44c5-4e63-08dbb37e1063
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:50:22.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOmsPJ/cqYmSgWXVlhgEeFbJErja9EO2Icz8uPP2YUb6ee1tq9cW7kCBwELvkrYQyjVGRH+LjLX0+n6BvLulEkgLds6qdBX0dD788Gc2wuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiANCj4gPiBBZGQgZHJpdmVyIGZvciBhY2Nlc3MgdG8gdGhlIGRpc2NyZXRlIGdyYXBoaWNzIGNh
cmQNCj4gPiBpbnRlcm5hbCBTUEkgZGV2aWNlLg0KPiA+IEV4cG9zZSBkZXZpY2Ugb24gYXV4aWxp
YXJ5IGJ1cyBhbmQgcHJvdmlkZSBkcml2ZXIgdG8gcmVnaXN0ZXINCj4gPiB0aGlzIGRldmljZSB3
aXRoIE1URCBmcmFtZXdvcmsuDQo+IA0KPiBNYXliZSB5b3UgY2FuIGV4cGxhaW4gd2h5IHlvdSB0
aGluayBhdXhpbGlhcnkgYnVzIGlzIHJlbGV2YW50IGhlcmU/IFRoZQ0KPiBjb3ZlciBsZXR0ZXIg
bWlnaHQgbWF5YmUgYmUgYSBiaXQgbW9yZSB2ZXJib3NlIHRvIGdpdmUgdXMgbW9yZSBjb250ZXh0
Pw0KPiANCj4gSSd2ZSBsb29rZWQgYXQgdGhlIHNlcmllcywgaXQgbG9va3MgbGlrZSB5b3UgdHJ5
IHRvIGV4cG9zZSBhIHNwaQ0KPiBtZW1vcnkgY29ubmVjdGVkIHRvIGEgc3BpIGNvbnRyb2xsZXIg
b24geW91ciBoYXJkd2FyZS4gV2UgdXN1YWxseQ0KPiBleHBlY3QgdGhlIHNwaSBjb250cm9sbGVy
IGRyaXZlciB0byByZWdpc3RlciBpbiB0aGUgc3BpIGNvcmUgYW5kDQo+IHByb3ZpZGUgc3BpLW1l
bSBvcGVyYXRpb25zIGZvciB0aGF0Lg0KPiANCj4gSSBkb24ndCBrbm93IGlmIHRoaXMgbWVtb3J5
IGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgYXMgZ2VuZXJhbCBwdXJwb3NlLA0KPiBidXQgaWYgaXQn
cyBub3QgSSB3b3VsZCBhZHZpc2UgdG8gdXNlIHNvbWUga2luZCBvZiBmaXJtd2FyZSBtZWNoYW5p
c20NCj4gaW5zdGVhZC4gQWxzbywgd2hhdCBpcyB0aGUgcHVycG9zZSBvZiBleHBvc2luZyB0aGlz
IGNvbnRlbnQgaW4gdGhpcw0KPiBjYXNlPw0KPiANCj4gV2VsbCwgSSdtIHBhcnRpYWxseSBjb252
aW5jZWQgaGVyZSwgSSB3b3VsZCBsaWtlIHRvIGhlYXIgZnJvbSB0aGUgb3RoZXINCj4gbWFpbnRh
aW5lcnMsIG1heWJlIHlvdXIgY2hvaWNlcyBhcmUgbGVnaXRpbWF0ZSBhbmQgSSdtIG9mZiB0b3Bp
Yy4NCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0KPiANCg0KVGhlIG1haW4gcHVycG9zZSBvZiBj
cmVhdGluZyB0aGlzIGRyaXZlciBpcyB0byBhbGxvdyBkZXZpY2UgbWFudWZhY3R1cmluZyBhbmQg
cmVjb3ZlcnkuDQpJbiB0aGVzZSBmbG93cyB0aGUgZmlybXdhcmUgbWF5IGJlIHVuYXZhaWxhYmxl
IGFuZCBkaXJlY3Qgc3BpIGFjY2VzcyBpcyB0aGUgb25seSB3YXkuDQpUaGVyZSBpcyBhIHVzZS1j
YXNlIHRoYXQgcmVxdWlyZSBhbm90aGVyIGtlcm5lbCBkcml2ZXIgdG8gYWNjZXNzIHRoZSBzcGkg
cGFydGl0aW9ucyBkaXJlY3RseS4NClRoaXMgdXNlLWNhc2UgaXMgbm90IHVwc3RyZWFtZWQgeWV0
Lg0KDQpUaGUgc3BpIGNvbnRyb2xsZXIgb24gZGlzY3JlZXQgZ3JhcGhpY3MgY2FyZCBpcyBub3Qg
dmlzaWJsZSB0byB1c2VyLXNwYWNlLg0KU3BpIGFjY2VzcyBmbG93cyBhcmUgc3VwcG9ydGVkIGJ5
IGFub3RoZXIgaGFyZHdhcmUgbW9kdWxlIGFuZCByZWxldmFudCByZWdpc3RlcnMgYXJlDQphdmFp
bGFibGUgb24gZ3JhcGhpY3MgZGV2aWNlIG1lbW9yeSBiYXIuDQoNCkF1eGlsaWFyeSBidXMgZGV2
aWNlIGlzIGNyZWF0ZWQgdG8gc2VwYXJhdGUgc3BpIGNvZGUgYW5kIGZsb3dzIGZyb20gYWxyZWFk
eSBvdmVybG9hZGVkIGk5MTUgZHJpdmVyLg0KDQotLSANClRoYW5rcywNClNhc2hhDQoNCg0KPiA+
IFRoaXMgc2VyaWVzIGlzIGludGVuZGVkIHRvIGJlIHVwc3RyZWFtZWQgdGhyb3VnaCBkcm0gdHJl
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBVc3lza2luIDxhbGV4YW5kZXIu
dXN5c2tpbkBpbnRlbC5jb20+DQo+ID4NCj4gPg0KPiA+IEFsZXhhbmRlciBVc3lza2luICgzKToN
Cj4gPiAgIGRybS9pOTE1L3NwaTogYWxpZ24gNjRiaXQgcmVhZCBhbmQgd3JpdGUNCj4gPiAgIGRy
bS9pOTE1L3NwaTogd2FrZSBjYXJkIG9uIG9wZXJhdGlvbnMNCj4gPiAgIGRybS9pOTE1L3NwaTog
YWRkIHN1cHBvcnQgZm9yIGFjY2VzcyBtb2RlDQo+ID4NCj4gPiBKYW5pIE5pa3VsYSAoMSk6DQo+
ID4gICBkcm0vaTkxNS9zcGk6IGFkZCBzcGkgZGV2aWNlIGZvciBkaXNjcmV0ZSBncmFwaGljcw0K
PiA+DQo+ID4gVG9tYXMgV2lua2xlciAoNik6DQo+ID4gICBkcm0vaTkxNS9zcGk6IGFkZCBpbnRl
bF9zcGlfcmVnaW9uIG1hcA0KPiA+ICAgZHJtL2k5MTUvc3BpOiBhZGQgZHJpdmVyIGZvciBvbi1k
aWUgc3BpIGRldmljZQ0KPiA+ICAgZHJtL2k5MTUvc3BpOiBpbXBsZW1lbnQgcmVnaW9uIGVudW1l
cmF0aW9uDQo+ID4gICBkcm0vaTkxNS9zcGk6IGltcGxlbWVudCBzcGkgYWNjZXNzIGZ1bmN0aW9u
cw0KPiA+ICAgZHJtL2k5MTUvc3BpOiBzcGkgcmVnaXN0ZXIgd2l0aCBtdGQNCj4gPiAgIGRybS9p
OTE1L3NwaTogbXRkOiBpbXBsZW1lbnQgYWNjZXNzIGhhbmRsZXJzDQo+ID4NCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2k5MTUvS2NvbmZpZyAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9pOTE1L01ha2VmaWxlICAgICAgICAgICAgfCAgIDYgKw0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9pOTE1X2RyaXZlci5jICAgICAgIHwgICA3ICsNCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaTkxNV9kcnYuaCAgICAgICAgICB8ICAgNCArDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2k5MTVfcmVnLmggICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
aTkxNS9zcGkvaW50ZWxfc3BpLmMgICAgIHwgMTAxICsrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
aTkxNS9zcGkvaW50ZWxfc3BpLmggICAgIHwgIDMzICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2k5
MTUvc3BpL2ludGVsX3NwaV9kcnYuYyB8IDg2NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICA4IGZpbGVzIGNoYW5nZWQsIDEwMTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2k5MTUvc3BpL2ludGVsX3NwaS5jDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9zcGkvaW50ZWxfc3BpLmgNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9pOTE1L3NwaS9pbnRlbF9zcGlfZHJ2
LmMNCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0K
