Return-Path: <linux-spi+bounces-4963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D798601E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FF11F26531
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374726286;
	Wed, 25 Sep 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoDcWJ54"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C9282FA
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267499; cv=fail; b=SIXz9RIIas7zophzsnqT7aPftZBFlQbPi4+oNwAF/tD1L3idbt/qpeYI4wiXd3Zs9Ro0G3iseGWpVp+jZQDFP0mVy110gt6TMxQHKJhC26osB4kHUCwBp2CrKTajWeCYPyShSHpZWwJTSaAOPUcon0U0oMoIZOJJ04ZpmPU/yKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267499; c=relaxed/simple;
	bh=tvUPg6mxngEGypryWLr1/IiQqCU1296RPzU4br66/S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IEvm2RN6ohL99EJL4WR4MBvXrwOwMkO6eh6fMi3SDTVuK0OrPccpR//RE0IGq0e5a6xQm9lCQ3Xi659PPSkdrFlUyD0JXIVgAxreMwNL0aU5y+xFTgsjD5bztMb+Ej8mpTfTQhTG0xKsUd5Ax/AsNzUAiy9LrMKjBKuWDIgQPxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoDcWJ54; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727267498; x=1758803498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tvUPg6mxngEGypryWLr1/IiQqCU1296RPzU4br66/S0=;
  b=GoDcWJ54vGRaEICviUO1pzd9te+vwwtd1x2lzdP8fTtpYJNH8em9Mtqj
   +OK14B4SV78tR09+c3bc1H8kcDK+BIEUrmXj1U8Fc+ppsdoqINAMAd2L1
   w7qw3Ot0dd0gIy25ro4jCrO0xo3DPYrKdN3OFDegEun/uMhFKRu1ImzF2
   XFfwGmvR3hNbJyiXq+NGVXqoMXcuwj2MvfcUOj5VO2Fs/iZZOPWr2Bg0L
   hhBcBQK+2tUGtkmZHyjKTkW9GD0EmBKGZk54T1cXC1m0aRkFB/JdzavfO
   +1t3g0p2Ei/Ztb0DPUCuYDP3oJVuGUxdMTCbKhqBluwMGS6t7R8rJZXvA
   Q==;
X-CSE-ConnectionGUID: fNuNd0DRR76zJY6BAR5tGg==
X-CSE-MsgGUID: /MwAJBe+QgGyIqePNFgBjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="48842283"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="48842283"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 05:31:37 -0700
X-CSE-ConnectionGUID: tZ1tIbNHTKmVkkbss1n2xA==
X-CSE-MsgGUID: rjTfZMIZT4WLmJKtQiuTdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71767476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 05:31:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 05:31:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 05:31:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 05:31:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 05:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOsgB/2NbreBVe7tX0tOVrsg/6uU8SuVSkW11AHfwshRlWOxmNevtO3hDzvghHGIPqDunKWMMVrdB30TmcxPwwj/D3tZVkarvU4Pv9+LC5G8lnGrNlGQyUvhpUkX7HzD+gtYnhpTqycYkzsz8ooe1N3KajdsJEhI18Wj4hJD8J7suYnyTYw72E0qX/uxr1kbk2LiJcXXndtjgOGMqiksp2pCVFVrwAhyWcAaKipT1NAb21CwjOKTXwTzzFIPOOpeArZfFCd8OtqmX1IZnZ5XLRbLVZrHPwQRYhPPtnofkfkzNWJIDkcIe+ctSIG4uIZh7wRkEaBR7e6jSPIxR3GxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvUPg6mxngEGypryWLr1/IiQqCU1296RPzU4br66/S0=;
 b=Yc2wkNJ3mS3ihljqRBHlnzexCmWgaQsDyxAfRdWnqk8MptDyVC4us3TqY36kmwPyfX45eJ0Lq2u8f6CsU2STbPgA1a7GYXQ1kMXzTyynzwpJBEDREVwlysLQrsCR77RgdYpuyAvHBtFdeSlXdzfCVoI2rz/iOgK8NrQ46KJGTPPXQFMnuwfAIgWRo95FFZDO5caPs8AaHGfdifYmOhwN1tALi8hSa1Gia4fJiRDoEzNVt9c88sZupYliCBxe4K9403UFzH86yvVIseLLP/36x5L+s/tUc5eeGpAsKr1RlyLmAG2rmRDxZN4GPa+lyO5pnZYwW4PqK7bDsJ6DloY7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CY5PR11MB6390.namprd11.prod.outlook.com (2603:10b6:930:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 12:31:34 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 12:31:34 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Mark Brown <broonie@kernel.org>, "Winkler, Tomas"
	<tomas.winkler@intel.com>
CC: "De Marchi, Lucas" <lucas.demarchi@intel.com>, Oded Gabbay
	<ogabbay@kernel.org>, =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?=
	<thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, "Lubart,
 Vitaly" <vitaly.lubart@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 01/12] spi: add driver for intel graphics on-die spi
 device
Thread-Topic: [PATCH v6 01/12] spi: add driver for intel graphics on-die spi
 device
Thread-Index: AQHbCEBkOdP23BXKF0u0GGe7YRcJz7JdjhaAgAFVOQCAAAqNAIADTjYAgAMheYCAAx5tkA==
Date: Wed, 25 Sep 2024 12:31:34 +0000
Message-ID: <CY5PR11MB6366C8C6AB07CFEAC20323F1ED692@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-2-alexander.usyskin@intel.com>
 <ZurWk_eXSQndgA4Y@finisterre.sirena.org.uk>
 <PH7PR11MB76057D2326D436CA9749A113E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
 <Zuv9qsWJQhx7rbhJ@finisterre.sirena.org.uk>
 <PH7PR11MB760505A11C7A41DAB0359184E56D2@PH7PR11MB7605.namprd11.prod.outlook.com>
 <ZvFj1zyzSYmbNwmH@finisterre.sirena.org.uk>
In-Reply-To: <ZvFj1zyzSYmbNwmH@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|CY5PR11MB6390:EE_
x-ms-office365-filtering-correlation-id: 51f9b55f-d8de-4dca-3a5c-08dcdd5dfe00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R2Nmd053REh0a0sxcmRFdHBGd3llNEttSW11QTAvY2NFYS9aRmlZUkJBNXZY?=
 =?utf-8?B?aTR6UVBCcXU5dzZZanF1ZW84MnJ4Kzl5d05wY1hrbFRxNk4vdFVkK25hS3hB?=
 =?utf-8?B?Tm83aWM3Qy92Z0M2U0dkaHhjVWFsTjhWbklZQWtIWjA2bWEyL25xMXVCQ1BZ?=
 =?utf-8?B?aGpKbkN2K1BEaG5TQUdibEFrS1RMQW1XUDQ5TW9kN3pzbG93L0owZEh0QzdR?=
 =?utf-8?B?ejZrb0hUV0gyYkNuVFF5WEtkaVZDZFlnaFRHOXRGNHdFV0FLM3B4OWdQSTI2?=
 =?utf-8?B?NGJRemc0b29JcFJaMi8rK2FiVG1ON1BRN2cyb25VTlN1cFBhOUFyWWUzNTdi?=
 =?utf-8?B?NGNnQTJ5MHd2bW1oOXl6TlVUK05oK2dGdXo4YVE1YURoS2pNZW9Eek5tWUxP?=
 =?utf-8?B?MkFHKzVZKzFoZm94OFArbWxSaWpYS2RiUmVOL1A2SS9BRW5Sb3lKV1d0b1Zh?=
 =?utf-8?B?NzN2Z0NYOURsTlJYV2t1ZEk5RmFxV2VCMmhYNUYxbml2cjN4Q0hHTnlYTVNo?=
 =?utf-8?B?UmVPV0ZZa3o1VmhVakdHbFRHSno3VW9LRHJwWUpLWnZJUklrbXJzWXJlZGRK?=
 =?utf-8?B?UWs3bFA4c3BBVThFTHFyeHlrS251Q0daMUZobTZ4NG5xN2kyUDBwbXdEZ1M2?=
 =?utf-8?B?ZGt3b00wbk5BbEJVWVhMT2hyZ0svaUNvQVZlVDJKcHk2SitmQUJNbEtyUk03?=
 =?utf-8?B?QW9FMXVHcVBjU3luODRPa2pwN0oweVgxaEhEWGdmdXBjSUlKZ3NrczkzQVVk?=
 =?utf-8?B?dFY3bEl5MjhoWEUyK2VKWlk4NTZVendHSkxrUmNudE5YYzEzeGJ6dC9lNm0v?=
 =?utf-8?B?WTBKRG5YMTQ5TWQxaUdqREVLU1h5d09KZVpuSUp3KzlDa1djZDYvakFYdWFz?=
 =?utf-8?B?b1hXSXFGWkY5WWk1OTRBQktkY0lUK1dBL3lVNC9NR2pkejFsemExUFJlTEpr?=
 =?utf-8?B?R3lJRG1HZnNDeDVPeGljVEx5VGU5c3g2MTJUaXFSL01zdzVzc2pySzQwYm1Z?=
 =?utf-8?B?WUdKR3QvSVNwM1QwUUhCckYrbGptbTMzcXNCd1dVZmpDRDVuZDI1cGV1NTJT?=
 =?utf-8?B?VFlPcnNQekNUSlVwZXhrK3ZvR1dzUkE3QTFabDNqa3FUNzJFOCs5NSt2Vk9k?=
 =?utf-8?B?c3h6TnVTNjZJUFR1YjFrakcybG9kZFZxQzBLQS9BYldPQmV2KzlEVjVWbERs?=
 =?utf-8?B?VnF4VWVkYTUweTE3OXZHcUtHbktSN2ZHMmdEanQ2S2dnZ1FHeGdBdTAvbTlz?=
 =?utf-8?B?L0tWNmMyb0NlSk45eGZ6TzlCSjM0S2daamplZUswSnZrMGZnNzFiV0FXc2J5?=
 =?utf-8?B?NHkvTFN1TURmaG94R3h0TWFkbjZscFpwNjV2emdkcmZ6bGlqemFmMlp0cDha?=
 =?utf-8?B?UThKSURyNjJPTzl4QjdDNHhkMlJFeFUvckQzc3hYenQ0eVFRZVh0TWNINEJS?=
 =?utf-8?B?Z3YyT09Ob0psZHFQdE5VQVNoRDdERVlSMkJrc3Q0NWhILzdQQVhlOTNheERh?=
 =?utf-8?B?YTlrdjYxSjBoSWFHZVVHeVNSTmJqM3dTbEEybDNxZi9VK2lvUm9jNkgzSSs4?=
 =?utf-8?B?dmVxY001bEtpOEo5VmNJYjRJZGNicVRpLzJHbm03eU1kUXRUNGdpUkVaTFgv?=
 =?utf-8?B?bFlLSGpGbjc0WlVRcmlYMlIrcVNVcXo1dWRacklJTCtWWlhydys1RUZkQ2xE?=
 =?utf-8?B?S0MzSDQvMUZBS3lJUThUQm1tcE50K2YxYUxGdlA1Yy8zTFo5Q2NxZGx6Nzgr?=
 =?utf-8?B?T0ZpcW1KZWh2bVBUTjZVL280aU1GNTMrWXE1R0MwY0RzMjYydUswV2g2TXJJ?=
 =?utf-8?B?eXBNd20wcUlYTWxqVVNiR0xYWDlWR0IvTE5sK2o1a2FnaCtjUWhJNm9TSzQ5?=
 =?utf-8?B?N080REdLc1lOMlZUMkdZbXBONDA0bTRjanVHUTBibTdTMmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJiTTd4Y0lRcU1ieCtvRU0wTlh2OFJjMW0vUzJsdXhhVnVCUUxZWmJuZDRu?=
 =?utf-8?B?SnFKTThvU0xIL1RtYWI2K3BjOXc2b2p4Y2t1allmeDQxUzlXRjQ4b3VNSERO?=
 =?utf-8?B?WUZKVkRtZ1RpZTRwWjB3dkRnL3dnWk1VVzVNK2NuZGc0YVFydEk0Q3QzV1BP?=
 =?utf-8?B?aFVVVkdiR2xLSi96NlYxaERMS2k0YkNuNXJaQlJWQW5mREtYZCt2bVpmaGQx?=
 =?utf-8?B?RXlsVnRIRkZjQU1BZHRWSy80cnpMdVFOS3BlN3U4OHEwRzZMZ3Nnc250NEhN?=
 =?utf-8?B?UGVCQ3FGbTBITXBUVk1vQ0drTmN6THkvZ2gvMXVsU1BhT21rVGlYa1l0Y09x?=
 =?utf-8?B?aDR2dWUvRFZEajJZTnhZZDFFRVQ2WU5yZ0J2YlM0aGZESGM5YnRJY2s0VmFD?=
 =?utf-8?B?K2I3VkhKWnJmb2tzVHMvZzJaQ0x1dEt5bjZ3dlRWY3VnNVlQRjMybEx0VG56?=
 =?utf-8?B?Y2JVOVRJTWhES0pmbG9SNkk3THJvUW40akEyVlNMQjduVCs4S2VYY2RjL2xB?=
 =?utf-8?B?akF1ZGM2dHEwLzZWbE1WYnh0NDh1KzU1VG1KS0RVUnVMbnBmM1VJQVBIa3Y4?=
 =?utf-8?B?V3hYamRpSDBaMkVNalBaeUphYmppdXZkKzJyS0RXdmRXdHlmOHFyZ21ScGRX?=
 =?utf-8?B?enlCcUUzMk0xTHF6VzI0aGRiMGl4OS9OczZ5emNsTFZneTJBblE0bytyamVE?=
 =?utf-8?B?Q1p5MlFmNE5VVlBqVEtqeVJNeGh1LzNLT1JmYUJJckt4MmR3T2drbVhibldX?=
 =?utf-8?B?blFyRndGdE5DMnNCWVpWSkNidEFuQWNwQVJvczczaWJ1ZXZqUkRhSkVpbm5X?=
 =?utf-8?B?KzRyenZKeGpBMHRmcUFMbjRST1F2dUNWeWgweXdQZ0gwZ1lRQURSRW9xS0Fs?=
 =?utf-8?B?Q3l5a1RSUTl1RGNoYlkrbnBBSG5OTHdKaUdsK0FsbDJoWUJmcFRLaEtLa1lO?=
 =?utf-8?B?Sis5UjcxckhiVWRieWJ4bmtOanVXQW5kKytVZml2RTJvVlc1RHROSkJ2cGMw?=
 =?utf-8?B?VnFCR2F1SUQwcE92Zm02UGE5UDk2TUVscmM0eCt4SW45Z1VVbTNSSEJ1cENs?=
 =?utf-8?B?VVhqeC91d3FaQ05kaEp5TGNJZEZDS2owelREcHF4akkwL0l2ZGFiWWxnWFVi?=
 =?utf-8?B?MkNxajd3WTNhZVJUditMRmVsUzVmNTJNYjlOdWUzQnBvMFF4Q3NIVFNDekR6?=
 =?utf-8?B?WWE5TmVLZDBUTDJKcWI0anRyQ2t0V0tzRGc4WFhJZFJFLzRBS1E5VEM4N2M4?=
 =?utf-8?B?ZVB5Ty8ydS95R081NFBJYlh1TWV4S1NoTVRsc0lYNnZnZWFaemV0YTF2VUUr?=
 =?utf-8?B?UXV5enlKWmlvMGJFUWlvY3MyNFhGQWVKVWlla1EzK2JOSFl1VXVxVy9aY05h?=
 =?utf-8?B?WGZ6L3kwVVlobUUrUnhjSTVPSWFkVHZIY3pFR2ttMlN5OFFqbHZ6V2VRM2Vv?=
 =?utf-8?B?YnJIdkR2cjlwYUhNMWQ2cHVOM0dPOWpNcHBOVFBIMjNVZHlBUllJVW5ZeDVG?=
 =?utf-8?B?UTdlM1lVTHBvd29QREErVVZuZERyNi9wUk5MRjhQY003OFhIWmNKYTRseXVV?=
 =?utf-8?B?a1hHcmVUZWRjSjJkV2NZZlkvTlVwM1daalFwTkYzTWhUSFh6M2l1Zm1hQW4r?=
 =?utf-8?B?d2tBVWFtUGJjRzJEbmNqM0hCM3JZUzZBSjNKQngrV2NOSnN1NE9QVmUybmtP?=
 =?utf-8?B?N0dXSVhEZCtIMytoQlJHdTYvNWtEUU1OTVovSW9sdlkrQm1kWlozeXhXbitx?=
 =?utf-8?B?b0tnT3YzTGxRVjQ0VytmQ1MyU1V6b25nRjNFeWxlTHcwaFZrem82RU10YWVG?=
 =?utf-8?B?SDdWcVZMWSt4QzhBQ0tmZ0ZBaVNxd0NHb1hiOFRudlFWaTdXUloxQ1l5d05S?=
 =?utf-8?B?bmY3Q3RTOCt2aUE5UXI0blFHd2lHWkhkLzBOdXpqMHVpREdvVGhydDllSDlT?=
 =?utf-8?B?WkQyZzR0R0I0OTlvckV0L2JiR1RLNks1ZWVCampoOVREdHVqK2lwb0RxK3gy?=
 =?utf-8?B?OWJMeUxMcVBxbE0xV1BocWU2elp1ZWpnVlQzV3pSeFA0Rk8yTVRKUFFqaXcw?=
 =?utf-8?B?ZEQzQy9Ga2h2REswMWVsVTZNQVBJd085N2Jlc3RMTUkrQllqNk1keTMwdjNC?=
 =?utf-8?B?ZkR3dWlHT1Zud2pKb1FZb0doNnBVWDg0V0htQVhTWjRUQTBYamY5elJwOHNS?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f9b55f-d8de-4dca-3a5c-08dcdd5dfe00
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 12:31:34.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlC/nJeO80a376doYZLCxOc8iCTEEpFIjOuVWBAkfOQJZnR3D569xiDknVc27YAkvb6kRhF4BP2fyTgxQzt+JrYB8Zr6bMdMHQVpbiEYf1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-OriginatorOrg: intel.com

PiBPbiBTYXQsIFNlcCAyMSwgMjAyNCBhdCAwMTowMDo1MlBNICswMDAwLCBXaW5rbGVyLCBUb21h
cyB3cm90ZToNCj4gPiA+IE9uIFRodSwgU2VwIDE5LCAyMDI0IGF0IDA5OjU0OjI0QU0gKzAwMDAs
IFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgU2VwIDE2LCAyMDI0IGF0
IDA0OjQ5OjE3UE0gKzAzMDAsIEFsZXhhbmRlciBVc3lza2luDQo+IHdyb3RlOg0KPiANCj4gPiA+
IEp1c3QgZG8gbm9ybWFsIG9wZW4gY29kZWQgYWxsb2NhdGlvbnMsIHRoZSByZWZlcmVuY2UgY291
bnRpbmcgaXMganVzdA0KPiA+ID4gb2JzY3VyZS4NCj4gDQo+ID4gVGhlIGtyZWYgaGVyZSBpcyBm
b3IgcmVhc29uIHNvIHdlIGRvbid0IG5lZWQgdG8gaHVudCB0aGUgY2xvc2Ugb3BlbiwgSSBmcmFu
a2x5DQo+IGRvbid0IHVuZGVyc3RhbmQNCj4gPiB3aGF0IGlzIHdyb25nIHdpdGggaXQsDQo+IA0K
PiBJdCdzIGxvY2tpbmcvcmVmY291bnRpbmcgc3R1ZmYgdGhhdCBsb29rcyBub3RoaW5nIGxpa2Ug
YW55IG90aGVyIFNQSQ0KPiBjb250cm9sbGVyIGRyaXZlci4gIEV2ZW4gaWYgaXQgd29ya3MgaXQn
cyBvYnZpb3VzbHkgZnJhZ2lsZSBzaW5jZSB0aGUNCj4gZHJpdmVyIGRvZXMgc3VycHJpc2luZyB0
aGluZ3Mgd2hpY2ggYnJlYWsgYXNzdW1wdGlvbnMgdGhhdCB3aWxsIGJlIG1hZGUNCj4gYnkgcGVv
cGxlIG5vdCBsb29raW5nIGF0IHRoaXMgc3BlY2lmaWMgZHJpdmVyLCBhbmQgY2F1c2VzIHBlb3Bs
ZSB0byBoYXZlDQo+IHRvIHNwZW5kIG1vcmUgZWZmb3J0IGZpZ3VyaW5nIG91dCB3aGF0IHlvdSdy
ZSBkb2luZy4gIElmIHRoZXJlIGlzIGFueQ0KPiBiZW5lZml0IHRvIGRvaW5nIHRoaXMgdGhlbiBv
cGVuIGNvZGluZyBpdCBpbiBvbmUgc3BlY2lmaWMgZHJpdmVyIGlzDQo+IGNsZWFybHkgbm90IHRo
ZSByaWdodCBwbGFjZSB0byBkbyBpdC4NCj4gDQoNClRoZSByZWFzb24gZm9yIGFsbCB0aGlzIHJl
ZmNvdW50aW5nIHRoYXQgdGhlIGRldmljZSBpdHNlbGYgaXMgZGlzY3JldGUgY2FyZCBhbmQNCnRo
ZSBTUEkgbWVtb3J5IGJhY2tlbmQgY2FuIGRpc2FwcGVhciBhdCBhbnkgbW9tZW50IGxlYXZpbmcg
b3BlbiBjb25uZWN0aW9ucyBkYW5nbGluZy4NClJlZmNvdW50IGVuc3VyZXMgdGhhdCBvYmplY3Qg
YmVoaW5kIHRoZSBNVEQgZGV2aWNlIHdpbGwgYmUgZnJlZWQgb25seQ0Kd2hlbiB0aGUgbGFzdCB1
c2VyLXNwYWNlIGlzIGRpc2Nvbm5lY3RlZC4NCg0KSXMgdGhlcmUgYW55IG90aGVyIG1vZGVsIHRo
YXQgY2FuIGtlZXAgdGhlIG9iamVjdCBhbGl2ZSBpbiB0aGlzIHNpdHVhdGlvbj8NCg0KLSAtIA0K
VGhhbmtzLA0KU2FzaGENCg0KDQo=

