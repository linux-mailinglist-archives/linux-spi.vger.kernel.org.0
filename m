Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C057B1315
	for <lists+linux-spi@lfdr.de>; Thu, 28 Sep 2023 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjI1Gds (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Sep 2023 02:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjI1Gdj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Sep 2023 02:33:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EE9121
        for <linux-spi@vger.kernel.org>; Wed, 27 Sep 2023 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695882817; x=1727418817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X0OCR/i+UkhcxINPctFZoMFF6Ulqait/feZOUmWdQT0=;
  b=b7Dp09c7Jlq6K6HVCnOBAyuypXZGYO1vU8rcrZdK8DumBlajSWF2Z2vn
   Cw0C2hwEurEmIjn6MkBHSl4ji79V3UxzKvO7z7PxLzHG2/Py9lhVYZvpI
   VshdXOROk6TSgXX8M8kZqMNSxV1UlHf4S+NHDCcVayA+wY2MmyFyHCt0e
   AJH8SoMvLN4fzR62BFpKgl4fhId0RrBX4E1q8U1+c1jHE/yxcmGlDAB9X
   boSHObAxLi9E+8xtQv4BsylI6vQSTvlsOVqg9Xl0ysxTWgkceq2ntJ6c5
   K29PNCtC9sMUDOOuC66mKhNzMBZ4IA0xVDDX3Icm/lHGHtcbLPG4sjvij
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379270503"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="379270503"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752854394"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="752854394"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 23:33:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 23:33:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 23:33:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 23:33:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 23:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrteK/bguNYsJN7UNC3dlKuHjIuLjNTnbasYJSovZYRZwDDABFmmsEoXzRNWAHPc2cKXj/fMJ93DHjPj6zkRA6AErnrV/sateFtL5EM7o5b7KWUeLuljpqQOsk0P+BIZjGna3Gw6zn0tr2+azh3AEjabGFC5BWqDFQNXW3i6Cy3FH6nDr3fagRSsnqR2cfPTgxBKAYDFElW80PfBDUVEra++GXBxBiIB1aPe6n6JOq0UpcFSXQ+oHn/2MUTTMHwCK42JQ/XNT3sE+njxwhT0p2R0SHtSK1Bp0HRb3oyW5hdsPnzA5Zi+7DLIxNVFKE4psOddvOuvKGO/chZtA7L29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0OCR/i+UkhcxINPctFZoMFF6Ulqait/feZOUmWdQT0=;
 b=hfmrQW1j+nQFBVbYdA3wkD8oQfFtXSd70CL9X7yk6ganPgyfIRP+WHAHHPTj70Avzw2zThsCj6WMVuNEyNSwE/HJL5H/U1Rmq0BTV8DSn/+yff7E/Yft5HneDJvqEjjlZCW6pT/sa3yPP8IPV4jz+c8sjx2fDNjb9qWNM2XUqibt2kHQZ5NorLxmjxFItei+VyWFoC+8okfDPnHlp+PFgBbEXN9ArXilo8m0XdV6JHOe3SAOEkQFHiSer9vD5S247Gbf/fcP688sfpmRujUyifw1NKVbny1FhzNncw/QZMo3gs4lVbm34m/GBmpGc13nXgJAXcR/Sq2d61NoLe8UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 06:33:33 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 06:33:33 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>
CC:     "Winkler, Tomas" <tomas.winkler@intel.com>,
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
Thread-Index: AQHZ4+SNVk9MU21kAUa7uVQ5Wh8gOrAVP0OAgAAQigCAAc3FgIAAEJ0AgAAB+wCAAARvAIAMk8IggAAlTwCAABcL0IABMV0AgAk58QCAAGiDgIAABMMAgAEFesA=
Date:   Thu, 28 Sep 2023 06:33:33 +0000
Message-ID: <CY5PR11MB63666F5E7317859AFDBE10B2EDC1A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
        <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230912152102.0dfe7558@xps-13>
        <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
        <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
        <MN2PR11MB40938110726F81D8CE305FB8E5F9A@MN2PR11MB4093.namprd11.prod.outlook.com>
        <0682443d-5219-4aa2-a932-ee3e04c0760e@sirena.org.uk>
        <CY5PR11MB63661B36FFAE9455504DACD6EDC2A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <ZRQ+LzIoD+J0BzVp@finisterre.sirena.org.uk> <20230927165350.470bea0f@xps-13>
In-Reply-To: <20230927165350.470bea0f@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ2PR11MB7671:EE_
x-ms-office365-filtering-correlation-id: 0df7ed5c-d149-47de-af36-08dbbfecd6b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1953h5XKtVavQhJcjGeENEvI6yzvMRXkD7qzVz532ecX3VywKLcugJdFpVVq4Z9XSH5/zQ45nPOusEpVflBIf89nGxFVWWIiznA6zsMSDz/7YMofd29nk0tCzkyl9LuqDQtEjDGX8vKtZXe9HwguVvGtKxEpqRR+x0nGIMVVSmeH6TfuVJmfWWvr4OoQA9pX+XtPHj6vAowUQmBWsO4ITVU5o6ypkZXcTWEt1V9hlv07Mc6s/5Atx4kKcyipbvqTr6sUyn67HIMPYvhG9QXVA+hou4JnBTJDZd1pZ0/XQXlXf8ySHFwootV8Qm5ZMnGt7kEKnGswg/A+KexEOZIp0odzbbvGYbGtZ8wEYtbXqBtEp8mnmbpMvJpa5U6JngxePrP3VsK04GCW8XLEanfhWa4+UN38SmWLOdfSzXpL7EwnrtCTEW8noXcFtiUjzKn5MONKJYlzGLvLEPrxLMXWZsRLpNY0YIjDNL4zGAm1od3FQ2/A62xPR8U2Nba4DaLx4EqCe+JC6lQgzKitkHjkPDiDIHNcmnPh3oYC7XXDlav4eu7Rd9YztuH3EVTYNNuQGpERtqCOAZi++X/01Yz99ma2g/YTAHPhjBzy0PmKhIAidzeOZA5/Kp5zylY33Zwn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(5660300002)(6506007)(55016003)(82960400001)(66946007)(71200400001)(7416002)(83380400001)(122000001)(38100700002)(38070700005)(9686003)(76116006)(110136005)(54906003)(66446008)(66574015)(64756008)(66556008)(52536014)(316002)(26005)(66476007)(4326008)(7696005)(8936002)(41300700001)(478600001)(8676002)(86362001)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHpSK0k1b09MZ3lhNWVCQS9adlc3VjN5S0pkaUlLVUxrQXY5YTB6TDAwOWVP?=
 =?utf-8?B?aWtaaEtpWjAzdFI2OUpKbGgzaThnSXdiVDBYN0plN3cwc0ZjNzdGZ3hYVkp5?=
 =?utf-8?B?YXR5ODA2b2krVHNkNHlYNFpBeitFWlljK1l0Y0djTDVwZkEzZ2drNVdHK1VH?=
 =?utf-8?B?WWdHNklHVzE3TEhBY0lnZldsK1FwaGduelUrVGhMQysvemRBYll5L3lnYmhv?=
 =?utf-8?B?QldybXRDUkFZay9PNlNJaWNlcXRqQjhqUnJ5Vm01S0dnSm1IUVNZNlBWK1du?=
 =?utf-8?B?YlR3L0hVR1NMTkxnSjZERVRqSEZNMzA2WWo2bXk0K2ZlQnk0RXFhSzB3bW9u?=
 =?utf-8?B?T2RIRWV0SUMyQjdZSnIwaWZQYmhFWVpQM2RrL3QrRUwvcVc5dGN3cmI5NEds?=
 =?utf-8?B?WkhaU0tTUWhSV1R0M2NVS3lMd2duaUFyZVFCZ25RU1AxVGJCdHAzT3Npc21x?=
 =?utf-8?B?eXc1ZlhFYUhoQzFrQkg5ZWxzMVQyV2p6VVJRUUJWcndaajVuVkpOZkl2ZFcx?=
 =?utf-8?B?QmQrbkpSa00xcTh5MTJoaW8wbzFrSEJmMHZTQkhmOGlyWkVHZ1dJYnQ0SlVV?=
 =?utf-8?B?VTJyMXhLMCt3cWQxMUtCNjFyc2RZbjE5bWwvdWg1cHZJVEUvUjg5TUx4Y3pY?=
 =?utf-8?B?UHJhZ3NyRHc2OHlhQU9kR2h6VlROQ0JjN1pGWWwvWm50emFRYzI2NGFrU0dr?=
 =?utf-8?B?MXZPSE9NRWxBUU9rWlZ6RkxmdE5rZ0NxZTZNRmRqVC9kQUhtQXUwRSt6UVBz?=
 =?utf-8?B?cGt2d0xrY1Y2dGN0V1VuS2dkeDFNZHpvem1Sa0JXRWcrNngxQkVkaW5rcWIr?=
 =?utf-8?B?bHJ4dHI2K09adzI1ZUxJWVJGeWZ5dEtzNU9RUHlGN0l0Tk1lZlNlWEplcnNP?=
 =?utf-8?B?TmxiQmdudnBpQnVJWDJXYVpUa3pKeGVOMFYyb05xMVAxSnBJandYektrazVt?=
 =?utf-8?B?RXg0anFTM2JwVFZuRVlGcGtoaElpOXNjSUx4MWEzRkR1bzc3RVFGNS9vSW82?=
 =?utf-8?B?TUpEYkJSRXllQUNnNEc4bWlwNDdYdkp0Wk1XUkk4YVdYbWpNdk5MeVJ3RVJV?=
 =?utf-8?B?K2F2eGlWQ210V0l5bjVETFZJdHlBdW1MdDZTL1hrSFNYemZnTHpTVlB1Q1B5?=
 =?utf-8?B?MDJOcVFZeTU0V2tHZ2hvWURHcnVXN2s1aWFCY1VUaEQ2bUl5Ri8xVm1yWktY?=
 =?utf-8?B?K0djWHpOZVkzZkt5M29oRkNuR1l3bVRSM0g5RTliRmhYVzRBYkVaZWdmMWZD?=
 =?utf-8?B?WWRTNW5WVmRLK2xENVV3SnJ3VmJIS1pjS2p4Q3E2ZWFlelpVcVJMMkpYVlRN?=
 =?utf-8?B?b1NJVjEzbWtIR2lhQzM5OHgxdlhScEl6dGY3K09tUy9jTlpOSnZaVFRQck4v?=
 =?utf-8?B?Q08yeHZoVXAxRlc0SEpGT01SODN1YnFjQTlHcURETTNIblVOczdMYzNzY2kv?=
 =?utf-8?B?Zitia2NjWWZMVjdkcXV5NkZFQUFLSE41UHZCbmhIcllRbmpJQUdSNEcwbng1?=
 =?utf-8?B?cnIyejREcWc2bXZPVDExQkdqcm1udktnWWUzangvYmlLbEtISGllNm8xMVVV?=
 =?utf-8?B?bmJMbGozZHlnd2k0ZWZ0TDJUUzZ2TUdsSEtKTWx2dTNRcGRyczl1bnZiLzZ3?=
 =?utf-8?B?NkZPVk9kZlQ0Q2dtVVVmci9VKzZtKzl2NWRmSWtxMEJiK1dXVjkreWdvcGtL?=
 =?utf-8?B?RG9DcXdjN05vRzVjS3BHRlMyaWpwQXJyNnNyaWRwaGw1c0V0dU5FVHlXdlp5?=
 =?utf-8?B?Sk5QUnRpL0dvTjduY2E4bm0zSEl1aytEMU9ENFFBZk0waGN3b0k0Q3A2STBX?=
 =?utf-8?B?dkxpUkZ4UitLOXRyTVl4UUprV0xBY29GMGRmQW1CTFlwQ3Z0OTJZckRzT2o5?=
 =?utf-8?B?QXlMY1dwNjlobEd0a1R0aFJXQndqSlFXQzV3MmVleStFSDY3L0szZGp1UlZJ?=
 =?utf-8?B?b1VpdDJNaE1yNVA3QW1wb0ROakdwNlQxeVBhY3YwMkFwOHA4YVNJWGNiNkx1?=
 =?utf-8?B?QktQNFcvMlF5QWZ4REcvZmVQamttamdpdWJMM29JNGtTNUsxRkJReVNIQVBQ?=
 =?utf-8?B?cDhrQ3lwVWlrT1FDRTVJMFZWZFRBbTUxQnhsc1VaSDVJSWhxUk1wNnhJS1lo?=
 =?utf-8?B?VEl6UjJNY3RPaXhjbWVzWWoyUHFnSWxzeXpvQ21kekVMOVpMM1pjR0o2T2Jh?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df7ed5c-d149-47de-af36-08dbbfecd6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 06:33:33.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBlflgfP5SAHO6av6MB/Fcwd8mPnJV2TZwS76FQtRYVg/CmmwqFFfN96Xzo9uAQ+cVnQqtFikE5vSpzlyxHFg9dKDXWbOamdZ2AgTLoXpJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
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

PiA+DQo+ID4gPiBUaGVyZSBpcyBhIERpc2NyZWV0IEdyYXBoaWMgZGV2aWNlIHdpdGggZW1iZWRk
ZWQgU1BJIChjb250cm9sbGVyICYgZmxhc2gpLg0KPiA+ID4gVGhlIGVtYmVkZGVkIFNQSSBpcyBu
b3QgdmlzaWJsZSB0byBPUy4NCj4gPiA+IFRoZXJlIGlzIGFub3RoZXIgSFcgaW4gdGhlIGNoaXAg
dGhhdCBnYXRlcyBhY2Nlc3MgdG8gdGhlIGNvbnRyb2xsZXIgYW5kDQo+ID4gPiBleHBvc2VzIHJl
Z2lzdGVycyBmb3I6DQo+ID4gPiByZWdpb24gc2VsZWN0OyByZWFkIGFuZCB3cml0ZSAoNCBhbmQg
OCBieXRlcyk7IGVyYXNlICg0Syk7IGVycm9yIHJlZ2lzdGVyOw0KPiA+DQo+ID4gU28gYXNzdW1p
bmcgdGhhdCdzIGZsYXNoIHJlZ2lvbiBzZWxlY3QgaXQgc291bmRzIGxpa2UgdGhpcyBpcyBhIE1U
RA0KPiA+IGNvbnRyb2xsZXIgYW5kIHRoZSBmYWN0IHRoYXQgdGhlcmUncyBTUEkgaXNuJ3QgcmVh
bGx5IHJlbGV2YW50IGF0IGFsbA0KPiA+IGZyb20gYSBwcm9ncmFtbWluZyBtb2RlbCBwb2ludCBv
ZiB2aWV3IGFuZCBpdCBzaG91bGQgcHJvYmFibHkgYmUNCj4gPiBkZXNjcmliZWQgYXMgYSBNVEQg
Y29udHJvbGxlciBvZiBzb21lIGtpbmQuICBEb2VzIHRoYXQgc291bmQgYWJvdXQNCj4gPiByaWdo
dD8NCj4gDQo+IFllYWggaW4gdGhpcyBjYXNlIGl0IHNlZW1zIHRoZSBiZXN0IG9wdGlvbiBpZiB0
aGUgT1Mgb25seSBoYXMgYWNjZXNzIHRvDQo+IGEgdmVyeSBzbWFsbCBzdWJzZXQgb2Ygd2hhdCB0
aGUgc3BpIGNvbnRyb2xsZXIgY2FuIGRvLg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQoNClNv
LCB0aGUgYXBwcm9hY2ggb2YgcGF0Y2ggc2VyaWVzIHRoYXQgc3RhcnRlZCB0aGUgd2hvbGUgdGhy
ZWFkIGlzDQpyaWdodCBpbiBnZW5lcmFsPw0KSXMgdGhlIHNlcmllcyBzdWJtaXR0ZWQgdG8gdGhl
IHJpZ2h0IG1haWxpbmcgbGlzdHMgdG8gcmV2aWV3Pw0KSWYgc28sIGNhbiB5b3UgcGxlYXNlIHJl
dmlldyB0aGUgc2VyaWVzIGFuZCBldmFsdWF0ZSBpdCByZWFkaW5lc3MgdG8gYmUgbWVyZ2VkPw0K
DQotLSANClRoYW5rcywNClNhc2hhDQoNCg==
