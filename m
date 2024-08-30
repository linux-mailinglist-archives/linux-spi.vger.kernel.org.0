Return-Path: <linux-spi+bounces-4451-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F96568C
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 06:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEDC280F76
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 04:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D879D1;
	Fri, 30 Aug 2024 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jl2DSlsm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA41D1308;
	Fri, 30 Aug 2024 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993316; cv=fail; b=mRlCyMByvzb92oZVDuHupGPL4fhQHuCIe0HPFXXoJ8yHWx0NMbhkLqvIJtxQWEbB30l9GRNV/ilVAxUHhXM122/XajEJb82OJld2O2LvHbHTHJecqU3ZI32aJOISmuigKXF+AFm7hFVxR6GlaUsIh1M+TSIoEaYkBv/R+1MuwuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993316; c=relaxed/simple;
	bh=+aqcSNnpXZJVueVTij0I7GlN1auFynvdcvEYhrkT09Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd/JXg2c8OdUEUHG5yRjxDytvgVZ7bnPPMzSpv5EYbF0SygcvK3GSPGAMQ2sXhwD9mwtWbKyLVHSluGyM7JtXiEKwFF00NZ8DTn/aomVa7WYvFUTIxUerNa+GcxUN4vH3nf1cPvzyI/ncWchs+wAmil6Jsbz9NgtoMLbuj5VTQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jl2DSlsm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724993313; x=1756529313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+aqcSNnpXZJVueVTij0I7GlN1auFynvdcvEYhrkT09Y=;
  b=Jl2DSlsm7OggIlWDkql2FNpumXbTBetnaou8C+MJHC5QvQWodOCNFgLc
   TGPn3+I2MRuo1SOgm1kNVZq1URBnI2btdMIuV0I2Mbl9yb+Vyw3FmKrHf
   O+IQwJQUbwuWtVZ4Vs15olavtnmDglGNdqXp902tV/Ydh+XgQv7DUtTJG
   sCh7amn8s2ugDj8FcRXuEnk/Vay6Dbk4ThH3q4AHg9GgAU7vBCv/BD+tV
   Mi7k9zd9lH8MF7rWLTX8gQuaNGAL4YNIu/Z2hz/Z8CAbp4ZEsY+hgNpnU
   P58/YZUuK9wtH/gu6XBqkun/rW2Z+XVsKNx/tBFY9Fl3J2j6pg3vowDM+
   A==;
X-CSE-ConnectionGUID: ptidLZKWSkaHpl+hPkSS1w==
X-CSE-MsgGUID: kjVqGmrbTQmRm0u3uuzpzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35028431"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="35028431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 21:48:32 -0700
X-CSE-ConnectionGUID: CFFtdLNpTe+u3ZqToENKkQ==
X-CSE-MsgGUID: PS9VEduxTGy/pjIAogCOCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="63480587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 21:48:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 21:48:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 21:48:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 21:48:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 21:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5fv2vIjhaDpTr7DXilxKJMJgp5zY+JVrMtTpXgMvFI9iTlvPO1qQ6FZjXgFB/5/mH5LRNKy+fvsAWIRqOd+jx/mjJXdijSeHBx1kmnaG0ZxhcjQRULOS9BJr7LOrKNzDQTUz125RmN5vrI5SlyTQGGWIHVIN046EFeUFrc0vGT2w9nZ3jFfuiDek5mkbZDTyJ8s6PMjuSs/niF64VYkMX+CRlmGK57EqCD9NgKg8wMwuJLKH22pgVs79eIRi9LJQ0CGR8p7eG3ikIIH8mYT7p/rW1UV2QbSVuoz0Lw9gotkBHewtwO7PcfDa1VJP1NSUzf63zq9HuLFL/M/1bgDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdNu4i9oKGa2X3AwMdhlIn3JqaDAV4HvzXMV1/X4Lf4=;
 b=tkaYqsMBocnSGEZqXc/p9WyQUf86FIiModdJKnqdSsyO2b2Ct1loWRRKHg3IYQw6j7IpDMUQWuauAVNimB+9Rh6a4Z4Mz7+SbD75rMYWpZIRTeH7XYRr49A0QnpzUGQqSY6WbzyhxXY81sMopfWjOp+QkMcWpsBl+S7bTugT32Q2YbNWPidl5N/IeKB0r2N/ryTpVyRHMiad7TPxYSxPLtB4EhayULShokhRUWd4smLgRTKUhBmIOhCZ+hvxHjJy4/nwCgTHVfI5K5SIo+EFE55Y0U+lmJwndEtgvD/RO5HfHy7v57Zkt37ia6KNUNJ2rX6FNZ23DOKw2ruPrqDr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:48:27 +0000
Received: from CO1PR11MB5204.namprd11.prod.outlook.com
 ([fe80::c4f8:ffad:95dc:2aae]) by CO1PR11MB5204.namprd11.prod.outlook.com
 ([fe80::c4f8:ffad:95dc:2aae%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:48:26 +0000
From: "Ma, Hao" <hao.ma@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
	<broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
	<haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "Li,
 Lili" <lili.li@intel.com>
Subject: RE: [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data on
 probe
Thread-Topic: [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data
 on probe
Thread-Index: AQHa9Ic72Ug2MJkiMUq6N+WNNxlum7I/RIXw
Date: Fri, 30 Aug 2024 04:48:26 +0000
Message-ID: <CO1PR11MB5204FD6B12B682AAFB5B813F8B972@CO1PR11MB5204.namprd11.prod.outlook.com>
References: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
 <20240822113408.750831-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240822113408.750831-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5204:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: bc23811d-b888-4697-0be0-08dcc8aefc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|41080700001|15866825006;
x-microsoft-antispam-message-info: =?us-ascii?Q?zs9RZYdhEzm1IgE7mpOyO5hEtYmbhD2vvtaDPrpyiEq6lGWhSBXlHjXpr6g8?=
 =?us-ascii?Q?UGE0LZAyt9SMHIYhyLec+Gx+a+lbaF6oIRmxuhZMiqbjcyIGuVKiB05LyQPM?=
 =?us-ascii?Q?OXjFs0vv9PP31JuiKEPJilkECSjsIGydHmNSgIPnt/3WPcRzLE+OEDiOCROt?=
 =?us-ascii?Q?+p9IqnWeQGQGYqXu+QOz7ATXNk7BfTbPIlBK8979U+zvJu0+jlcGeiVl7pp/?=
 =?us-ascii?Q?MbRoOYCFxNC7axnjGlao6GqaJ3ZfYw1uLBzLtD5+tTXLr28AZfibnJyXXciw?=
 =?us-ascii?Q?9A4jRW4EQm66LudW/A9O9Vxi5vKHBwOAxGMWONWTwbSV9QKeJWHCuG0LT1XF?=
 =?us-ascii?Q?VmNraHjJQsoiuR/Lyg2kCzStTHOwVjUNpI2QxAQ1Y2cBQaDvscE5fCn8Wlpi?=
 =?us-ascii?Q?5bttQ5cat3dcZQd/OyfYVwW9K+QM6TGUi7J1fdONUkAlkOL31YVouR4Jp83F?=
 =?us-ascii?Q?iFsRoFs/KhxHPNv59mf4ZyCG/lnYPF4TeE6UkUGzWlcerLNszUeKlo/s+RLl?=
 =?us-ascii?Q?ySxVHBDA2xCxm7MsbHRu2CECXqs2Gme1Z0xcEL6nO8hAmiXeE1dfG4BqZmhi?=
 =?us-ascii?Q?WZpw4Ov8jTA6TBJFBLHGmDBZeC0hw7Aww/3rVLHQf2xqtk4NACYmIM2/Dfpu?=
 =?us-ascii?Q?a1d4SJ+0Y/B4i+irgbBMZUqqmr3DZe39MPuyjVvnMs3uHOKc9pqKixw0tPrV?=
 =?us-ascii?Q?kpEU+g7jbiOMrA6yfjw7jV6p9DjOBEOzsyGrOx58QtcL6XrED1pAfTeXd9l4?=
 =?us-ascii?Q?+ChAOqN/46QaqeD/8EiVHUksB/4iDjtcNoxVAIN5FwfWdyQvAm62XV0wEalj?=
 =?us-ascii?Q?yXKV+qADVPZwL3sYPb6df9dRvP9fgAVTkuyXTGa8KfBF9QUxdwxKhi3oN7yM?=
 =?us-ascii?Q?2kv6OEzcA3meIvqZ6dcCpUt7lJfEPJuZJMeBs/aqS5n6zo/++FBnV0P59Z0d?=
 =?us-ascii?Q?tH90e4uKY6dhYuyUdWObpx9KZxIKr0F0y5Rq5K7OapI1Ejfl/1XA4XbrjpqG?=
 =?us-ascii?Q?8PNk30y0uDQ6cRZZLtKQgWlTk2dt19S5hLkQMCNBvBSoPR8LcoWBY82VadD+?=
 =?us-ascii?Q?/efz/3kzbGtUY28MsMoBsE7I/WDM1H/Q8l0yfeFFbe6v+FGMYQDhrf0TY0Aj?=
 =?us-ascii?Q?oyqYJX0pjUIc4IlL2NfsAHizILr2ssagBSGCYZ9+i0tsftMiZ3wgOIhWBfUe?=
 =?us-ascii?Q?mkE32R3UiNe3+sE4xb9c7fI//nzFpkgWHo5gQUpaPVvCN71LifDYw66CZmwe?=
 =?us-ascii?Q?3LSb7YiFC/SicdqA3hFn3Shp3hyTc3V0+ySTLUdZRUZmENKbJx1Gzf3oi1su?=
 =?us-ascii?Q?8lG7DoaMTSsRvusEERAwTli2ZwjNuEjyXxD/OllCsgGQpR9OiUHOAlWTipcc?=
 =?us-ascii?Q?YwqPLmIwHiW4ynIM0D76ZvbAx39pinX7c81i2wM7uE2j6gNvIcFHKRSYkV6z?=
 =?us-ascii?Q?uyJlGu6BaqONA8i6QvRbg9X6J7uEP0NVXhgz6iRUnplORLRCtnz5rw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlnVD8I3Gfzq1RNHbBqjSln5nn0CG+swGVzim2kF39D6d4WiXjkytGFnUb7k?=
 =?us-ascii?Q?nDz/uZhcHqZN9RSpL13LrFYoFmZSufOZUrGikGrm5UCXvzs/PDHndlnFgiP+?=
 =?us-ascii?Q?PsYqoSgfNL5oAj6yFohByqHZ5Sz5fxWN3qLQ9aTVD+oVicgL/D2djfQ+cSCC?=
 =?us-ascii?Q?p3gt8t4AG8CM0ZxAl818ykimLMCPjThxcNn1rvvC4BuCVOPsl3BwpeCvYbfT?=
 =?us-ascii?Q?+OS7CvVBRUT/uh8i9C8wMF9mhKXnqNwz86URf+VQE1ODSx0k2cGAUI/qBScy?=
 =?us-ascii?Q?3SkFGvJxa43XX+weBZflC/NsY2WUOJ8R9ffhUOcf/XzoYKzZmjes49EgRn+T?=
 =?us-ascii?Q?/P7sPmm/W++Z/iBw5s9ic0P/u7+e70G/NqQkBbvq1Lcz4jeHs0hVWPUzuUQT?=
 =?us-ascii?Q?RuPg3PeHM/WcXY+zaiUq3R6G2jTmphskUG1fu/PFIjao8hmBcJqbCdLVW4Dz?=
 =?us-ascii?Q?fxDMIbkyd5Y/UJQUV1JPZ3xC16tyiLWErwqvLEFPrjRBBPqh6cYS4bPGokca?=
 =?us-ascii?Q?kQNYSsurAEJduHDhMH0yMwrZBxmND7RSjegMtbnj+O7DFP2KGeEOddZpSnrI?=
 =?us-ascii?Q?IGLsMHkxeiI1UvSuXfsphAUvN4De6P2H7KanOlUDN5PYFTMZW87sQu0FEXas?=
 =?us-ascii?Q?iZl1V3MAZOgV17PpG5H8quujIklHs42bHj415+Y/wdy+c0SBNnNudpa1eIYF?=
 =?us-ascii?Q?8fnujY08+PFXWKc4qH8Stepn7Piw+zJN6/0lsGNEl+HKzj1sKiO0vNe4sp1K?=
 =?us-ascii?Q?kKebxOAimm887j2n8v1TDlNWwMOiTb5FMniT3eX8tukX08+UjHNM9Q9FaMGK?=
 =?us-ascii?Q?olZfF4+vMstKWy2zIRH00Hh49FoqMWJ/Mu7WY64U6vg6edIwBAwkbkKmO8PG?=
 =?us-ascii?Q?r7Deb5AzYcvaETiVWFUPBCY7VbtWtjf0dI0ABtEhfsGQTgz1XLklGRK7lKNy?=
 =?us-ascii?Q?Oaz0YPSJSXj6PlqTcVQsFt4e5DKvsweRlhc1CBAybUm3/lNbeFJgq5cLb9Wc?=
 =?us-ascii?Q?ApZfAShWgEa2psD4PNBeNKdj06kfK3e6uG/vXjaL7ALjDyS1WpIuE/JL0RMx?=
 =?us-ascii?Q?KKEKK4zdWL+QDjwxHpIUxs3H73MTMunvQe2v3U29pT6rtg+9hZwre4c1UIxm?=
 =?us-ascii?Q?5rNGj9NQJF1X7hVKzP1QwVq+CXHJr60HeFeXxvJbSBuXYTQaGCK9UB/ywjld?=
 =?us-ascii?Q?L8p9MbLReVrsXX3hYNvePhQYDmQZq6z/lsTEAwm9A+dB/+mzQtwV9VUM5shs?=
 =?us-ascii?Q?u+PF6QujgFR7IvWdB1Iiltb0V5xK3RB5FgWSlBEP4WZPyVSVe5Psq9x2WmHK?=
 =?us-ascii?Q?DeapvbTRH0IVrB5SIqaTC/PMZJ41KiJEL5+sEExER2LzRljMdi9L5ir5QEQv?=
 =?us-ascii?Q?KnkY1so/rI02A4x8WNMD7Z0Sh+oaLfCugH7nLjDUiumJq4xJ0hFzmRzWsqcL?=
 =?us-ascii?Q?8Wy4GKA9ZSLdusPV7D2j5zK/2+iIo5Dp7Vt3giv8RwGf8byq4c35wOu6BLa6?=
 =?us-ascii?Q?o0PxGOMqbdQ0bDrwncZ5wcM6sbkcOikItW5tx+4LY3mHGKJs2ICKdo9IxsPD?=
 =?us-ascii?Q?+/8jg5TGjzth6Ow7HQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc23811d-b888-4697-0be0-08dcc8aefc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 04:48:26.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOp5BiVzR7TFh5ewBl7Pxge8PxW1AG4k2gssptEFTl2BfDCBkfC2+d1MrKKu+8kAGkjRumV0E/zCYWpj/XXGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

Hi,Andriy,

I merged following patches and tested it works.

      [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data on pro=
be
      [PATCH v1 2/2] spi: pxa2xx: Move PM runtime handling to the glue driv=
ers


Tested-by: Hao Ma <hao.ma@intel.com >



Best Regards!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, August 22, 2024 7:31 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Mark Brown <broo=
nie@kernel.org>; Linus Walleij <linus.walleij@linaro.org>;
> linux-arm-kernel@lists.infradead.org; linux-spi@vger.kernel.org; linux-ke=
rnel@vger.kernel.org
> Cc: Daniel Mack <daniel@zonque.org>; Haojian Zhuang <haojian.zhuang@gmail=
.com>; Robert Jarzmik <robert.jarzmik@free.fr>; Ma, Hao
> <hao.ma@intel.com>
> Subject: [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data o=
n probe
>=20
> The platform_data field may be supplied by legacy board code.
> In other cases we override it, and module remove and probe cycle will cra=
sh the kernel since it will carry a stale pointer.
>=20
> Fix this by supplying a third argument to the pxa2xx_spi_probe() and avoi=
d overriding dev->platform_data.
>=20
> Reported-by: Hao Ma <hao.ma@intel.com>
> Fixes: cc160697a576 ("spi: pxa2xx: Convert PCI driver to use spi-pxa2xx c=
ode directly")
> Fixes: 3d8f037fbcab ("spi: pxa2xx: Move platform driver to a separate fil=
e")
> Fixes: 20ade9b9771c ("spi: pxa2xx: Extract pxa2xx_spi_platform_*() callba=
cks")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-pxa2xx-pci.c      | 2 +-
>  drivers/spi/spi-pxa2xx-platform.c | 6 ++----
>  drivers/spi/spi-pxa2xx.c          | 5 ++---
>  drivers/spi/spi-pxa2xx.h          | 3 ++-
>  4 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c =
index 616d032f1a89..c98bb214b6ae 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -297,7 +297,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>  		return ret;
>  	ssp->irq =3D pci_irq_vector(dev, 0);
>=20
> -	return pxa2xx_spi_probe(&dev->dev, ssp);
> +	return pxa2xx_spi_probe(&dev->dev, ssp, pdata);
>  }
>=20
>  static void pxa2xx_spi_pci_remove(struct pci_dev *dev) diff --git a/driv=
ers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
> index 98a8ceb7db6f..f9504cddc7ba 100644
> --- a/drivers/spi/spi-pxa2xx-platform.c
> +++ b/drivers/spi/spi-pxa2xx-platform.c
> @@ -63,7 +63,7 @@ static struct ssp_device *pxa2xx_spi_ssp_request(struct=
 platform_device *pdev)
>=20
>  	ssp =3D pxa_ssp_request(pdev->id, pdev->name);
>  	if (!ssp)
> -		return ssp;
> +		return NULL;
>=20
>  	status =3D devm_add_action_or_reset(&pdev->dev, pxa2xx_spi_ssp_release,=
 ssp);
>  	if (status)
> @@ -148,8 +148,6 @@ static int pxa2xx_spi_platform_probe(struct platform_=
device *pdev)
>  		platform_info =3D pxa2xx_spi_init_pdata(pdev);
>  		if (IS_ERR(platform_info))
>  			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform d=
ata\n");
> -
> -		dev->platform_data =3D platform_info;
>  	}
>=20
>  	ssp =3D pxa2xx_spi_ssp_request(pdev);
> @@ -158,7 +156,7 @@ static int pxa2xx_spi_platform_probe(struct platform_=
device *pdev)
>  	if (!ssp)
>  		ssp =3D &platform_info->ssp;
>=20
> -	return pxa2xx_spi_probe(dev, ssp);
> +	return pxa2xx_spi_probe(dev, ssp, platform_info);
>  }
>=20
>  static void pxa2xx_spi_platform_remove(struct platform_device *pdev) dif=
f --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c index
> 16b96eb176cd..e3a95adc5279 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1277,16 +1277,15 @@ static size_t pxa2xx_spi_max_dma_transfer_size(st=
ruct spi_device *spi)
>  	return MAX_DMA_LEN;
>  }
>=20
> -int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
> +int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
> +		     struct pxa2xx_spi_controller *platform_info)
>  {
> -	struct pxa2xx_spi_controller *platform_info;
>  	struct spi_controller *controller;
>  	struct driver_data *drv_data;
>  	const struct lpss_config *config;
>  	int status;
>  	u32 tmp;
>=20
> -	platform_info =3D dev_get_platdata(dev);
>  	if (platform_info->is_target)
>  		controller =3D devm_spi_alloc_target(dev, sizeof(*drv_data));
>  	else
> diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h index a4=
70d3d634d3..447be0369384 100644
> --- a/drivers/spi/spi-pxa2xx.h
> +++ b/drivers/spi/spi-pxa2xx.h
> @@ -132,7 +132,8 @@ extern void pxa2xx_spi_dma_stop(struct driver_data *d=
rv_data);  extern int pxa2xx_spi_dma_setup(struct
> driver_data *drv_data);  extern void pxa2xx_spi_dma_release(struct driver=
_data *drv_data);
>=20
> -int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp);
> +int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
> +		     struct pxa2xx_spi_controller *platform_info);
>  void pxa2xx_spi_remove(struct device *dev);
>=20
>  extern const struct dev_pm_ops pxa2xx_spi_pm_ops;
> --
> 2.43.0.rc1.1336.g36b5255a03ac


