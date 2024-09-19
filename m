Return-Path: <linux-spi+bounces-4862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E897C481
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 08:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307B82827E7
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928918F2D8;
	Thu, 19 Sep 2024 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2BQRNfa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06A18C354
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729012; cv=fail; b=BbX08CBMZ3roEYa479Va+SB5ypbzinVABt9ThXVj1IGEKeHfkdea1uQmN8G6R7dG7aT9XAkDIEozHKZkHqQ6rTAH7maHXrU0sbTKdUQS4Ry1Zuc7rw24cbAUtcUggoHTEb7WQ7NBWRDRPbRO7zy4mhUgCmTeI+Bldp1EmBy5sSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729012; c=relaxed/simple;
	bh=3H2lqMR9uq6m1mRGI3Cl5d0gH6GE90CbnAWTsG+PBVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lp2PNhYdPlINhVDeMv+lFqXYEGzyzr6em9DuYusEenw0gXhUceEkm6YcAxg4eVLTKhUazPUJUI+Nx3HxVUtQYZH0XNCot8Vh9243ohQlxU9z7NOcX2MPOE4hwXbk5aoBDknB7TEhwfBSRsOO2eOk8MD3rlpPqKoMYMxjGnHFqBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2BQRNfa; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726729011; x=1758265011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3H2lqMR9uq6m1mRGI3Cl5d0gH6GE90CbnAWTsG+PBVk=;
  b=G2BQRNfacJjF4eOmvbMt5gKLGWW9wI9ssOGhGLbPUBf+5ynacd1+mk3n
   i7vJG5JD+FrzTclUl/zMIsqblmD8gw+EKQL9JxilSoQTqcrIT/peoJYFi
   PzDsCo6eAgz6zA1NzgsEOJRIF7Fdun8xSkvyHoY+8REetoyKXBvQwCsPZ
   o0YTPAu4kH3+Po8uFvby/U4Xn1AS+RNtI6domhjQ5FjSqvXUPkaZjHJKZ
   kEIQD56j+rOBYNepABokffCIq+KKD+privBn6VhhaIKBrkZDncQTjN3w5
   td9LxroE/aXfOriVomYMydYhRhULoJXofq2LrjqmWcPkQCI6LipoGKsW6
   w==;
X-CSE-ConnectionGUID: gvK+r9+mSs60664sy7p6Ww==
X-CSE-MsgGUID: dEAdLcooSnydeAvEPEcHtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43142163"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="43142163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 23:56:50 -0700
X-CSE-ConnectionGUID: I/Vma395QuukSCFEoBfCuA==
X-CSE-MsgGUID: wOOSDInqRNWkVOYYoSHxZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="69435183"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2024 23:56:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 23:56:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 23:56:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 18 Sep 2024 23:56:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 23:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgMPUyEdUqHwsxeEPRskZT+qcWpaIuhcqMdI3yQULf7NfWTHn2na3alJ82vIxlG7WYaRm8FHnZOx55upEBiDMwfRyN0KAe4xM5CKzm0SmallgaWhXSmEa4+fA0V1tQc+7xUd21z+Ov+dz6uWE8n3oLP/qqDWBcYiiIY57oemITojefr0K40rTs/XqZyC403ytVpqUyTcy1kmsaBDgoMuL99NSXu2g3L0t8/Sr2C5CjVEkpm6eZ5vqRwECere/f+VAJ04HRJ/YUoQErjlsPjfZZUFg5zMoAPEhMG82rhw9RfzCu3B0Er88k8O4SVHaxjQ+TZ0myVGJCyMPkM/Smc+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H2lqMR9uq6m1mRGI3Cl5d0gH6GE90CbnAWTsG+PBVk=;
 b=St8eW1D9seVD0SzVyktRK/nA8KOBWTZUM6aO+RKqRFqsxwyp+A3sgv10Cb4mwMviLjsT1sTfNBD2uaWQYcculhVu7tzZ3zPaiGYNWu6Gcsh3iwuhXdQyQByTmrVQix+jHijXq3yn8SqDylqr8OtBUDfZzm0VdyhruKHN/fQo+wSbQz3WivdCHLAaNA7AOKuRV6u2xRALOzBS5oHvjNf3AWl6C/rRO/fOd8rFMqoRLstKVmz8oD6QBqD/NrNRmQcmyck4K/kAk0KHDe9mOtz0n33BmSlBVS5IUQ88sJ9g2CFDMMeJ3yyoNycUb+hG5XEGbkar5TcmBwl4+Pmz9jh5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 06:56:39 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 06:56:39 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>
CC: "De Marchi, Lucas" <lucas.demarchi@intel.com>, Oded Gabbay
	<ogabbay@kernel.org>, =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?=
	<thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, "Winkler,
 Tomas" <tomas.winkler@intel.com>, "Lubart, Vitaly" <vitaly.lubart@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 00/12] spi: add driver for Intel discrete graphics
Thread-Topic: [PATCH v6 00/12] spi: add driver for Intel discrete graphics
Thread-Index: AQHbCEBwjiL58qCD30W6M47xUSkoLbJdkXWAgAEdrEA=
Date: Thu, 19 Sep 2024 06:56:39 +0000
Message-ID: <CY5PR11MB63661407645579333EFFED35ED632@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <ZurZZ1pzmbWifjAD@finisterre.sirena.org.uk>
In-Reply-To: <ZurZZ1pzmbWifjAD@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA0PR11MB7744:EE_
x-ms-office365-filtering-correlation-id: ab03df70-68b3-437a-ebd7-08dcd87835f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTFaL01SR1Ntb1dLWWFUeTQrKzg1WkZ0TG5FRGYyYlhSM0dlVTROZTZlR0t4?=
 =?utf-8?B?Z2FWR1VvbG5Sa2FDRnpqUlRJZW9uUmpNMnNwNjhuYWhNOG5Nc011N05DaDRS?=
 =?utf-8?B?c0xLaTE0ZnNDY0VDaWJLOUcwcHFrN1V3OUJVVmRmd1B1V3o0QTlyUjE2dnR2?=
 =?utf-8?B?NW5hS1gwMzBTRWl1MXh3TllTVEdsS0h3VDNaVlFZQ1FYa09KcG1rNlEveVp6?=
 =?utf-8?B?MmtIUUdQa2Z3YjRrOHl5T3FNcGQ4NDVyYkdhL0ZZMkYxQlh0cC9UOWNYa0dy?=
 =?utf-8?B?ZWVCVllvT2tmbUR6R0pPTUR6bHd4ZDV4QTcrS3hNV3h3RHVwbWxadkE5U1NJ?=
 =?utf-8?B?YXJGOEhlK1R6YmFaTzBZYVNWdjZhSlBuSWtubGptUHE0UGlPeC9JczJOcnJF?=
 =?utf-8?B?d0RBSnVtcGpBUWN4TTkvejYxUWN0bTB6cFRoMkpVSW5lVDVuY0RRMTZqT1lE?=
 =?utf-8?B?T1hMZlBXczJvSDRyZ0JEZ0FhZUFoOXMwd3hzVzBMV0huWlNFMUhZejd2RVY1?=
 =?utf-8?B?clVhTm00VUtkQW4veis3SEdCYzhuLzB0M0hwZ3kxMUM4OVBvMDg5MDZKdkdj?=
 =?utf-8?B?eTVuY2hOTHhrazNvaVFPcWhWS05DUlJOR1MvazZoaG1SMDN6R2NXdEJEd0Uw?=
 =?utf-8?B?K3c0WTU3bXNKWmpsWVpINE1FY0NJaHA1OVV4NE04c0kwbkN6NXFFWkU2RVBw?=
 =?utf-8?B?S1lmU3NGN0FEMzM5ZElwOFpBa1c1RzVBVWp6am5xN3dscGdmQ2RhS0pUdDQ3?=
 =?utf-8?B?ZUovVDlRZy9jTlcwTjZJc1VoWEZhdU1tMUFoS1hPTUR5U1JrRjVVaTlMUGJv?=
 =?utf-8?B?ei95STJWdHltUXJRQnJBS21QSWxkZzMxOU4rK2ExL0JWdWVPRmF5bHdlYjBR?=
 =?utf-8?B?OHRnWU5GWWcwTnFRTmpwdzk5ZHdjVS80Wmk5TXMzRUtLUEtiaXEwcXpSalJX?=
 =?utf-8?B?bUhTeWhNa1l1bWRQNWFQdTRLRFpQN0d1eXRQemNKY00vMGF6L3Z5azE3a3lh?=
 =?utf-8?B?NTJMMWV4U3Q0M3Y3NEJXR3JCNnE3Z2tvY1BCZ2JHeGtaTWVxMVhMaCt1cVhy?=
 =?utf-8?B?TUF5dkNtMVdoR29XWlZ2a2hvOW1Kby9SRUFlc1NZS1k5d3k0WC81Q0xtQmlE?=
 =?utf-8?B?dGlnYmFkNVo3M3B1bC9VS041bkwyalNIK3BHcHJlM3FwYXNNNzB1T0E2dXpY?=
 =?utf-8?B?VnFoSm1GcFVVaWZsSXBpcG1LWlRkazgyd3Q2NFlXelNzeW9IUkdTWVlTT0Vw?=
 =?utf-8?B?S1c1a1FtV2hzNWJVM0ZWRkdhbTRKUm5nQnNxL3RzK2JaTC9OMWdCMmZqckNm?=
 =?utf-8?B?QmVSS2YyR2M0ZU5ySWF4K2UvT0orQ01CZlB1SzlrQzc1T0RlTGY0V0tOaXI3?=
 =?utf-8?B?VDVCNVc4dS9EQzRCVm1ZcHRXZ2xBcUpkcE1TYnVwWlU1b21aRUlYWTBQbS8y?=
 =?utf-8?B?aWVHbWFibG5EcEN2ZmF4ZHJvdXlqbzRiNmlUTGs4cnI0OEVEQVczekRMMzdp?=
 =?utf-8?B?UGgwdUZVTzViWkZoSlQxUnBySW51STZ3NFVCU3laNnVqV0VSamlsai8zeC9v?=
 =?utf-8?B?SE5uOWJyQWdtNHY1MzdFWTIyNUlJRXNXNFJ2d1hFZzBJZkVlbVE4bmFnZnFZ?=
 =?utf-8?B?cS9kVFNlZi9Leld6Vmc0MkNJc09GL1J0WjFmc2pGNjl1VnliOFk2V1dBZVcz?=
 =?utf-8?B?aThuTVpxa0hHKy9qZDMvOGYxS3d3SUpaSExhOUZUWEtaTU9MdWY4bXF6Qm9y?=
 =?utf-8?B?MktEcGtXUnNQYStLeXhKTU9MVW9veno4Z1E4TkNJckM4TlR1QXZqZWt6Wkdu?=
 =?utf-8?B?d2tUZ0Q1ZHFuZThTZFlsMzVLNld6L3BPckVTZHhMSW1wWDFQMWIzdmExRXV5?=
 =?utf-8?B?QWUyZHdxbCt1QjhWVjRTcHpqSEVIMXdacisvSnFXQzdId3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGw1b1JzS3kxVVFnMDBxWGdkeVArcklybFpTdVZNZnBualVoTS9oSmlLN3VK?=
 =?utf-8?B?TWVxNG5XM0o5dGxQQUIzaWViQ21kcGFoMUYyNUZoaExRMVVwK09vVElTa1RG?=
 =?utf-8?B?QXk4eVhTV1pJejErNzFnK3lHZENkNEhjRC9DWE5aLzFuNzQyeFU2a0JYcWg1?=
 =?utf-8?B?aFVmalFpS2E3RExqT2JUZktKdnh6aGY1Y2lwOERqMm9pSitVYldFTjludlIw?=
 =?utf-8?B?Wm5UMHdyTUhPZ1BheFZoT3lyVmJNVWFIYmQ3UEg2OVRRRHZrRSthNktIOXp2?=
 =?utf-8?B?MlgveThiMTl5blo2SFJzOTZDRVk3QktRdnQzcEZsQVJReE9ZemFKVVg2NGVF?=
 =?utf-8?B?RmxXZGlrRGZ0cWI1Y1RQZ1VwS2FKaTlOOXpxM1ZNeHVubTFweGpMNEo4MnRB?=
 =?utf-8?B?b3drbzRGWW9HbE9DQUE1Rk05eDdMZFhoT3RVZGhKeVMzYkx2TVI0c1FodFVH?=
 =?utf-8?B?Nm5pRFR1aWhGMXF5SldGZ2owQ2lvT2VSU0o1OURPcjBFSWJjeVo2Mlh5cnBS?=
 =?utf-8?B?LzZzMW5RU3BnaWpoZDFpRmZOdUVIZ01PcVdCQ2I0MWZGV0U5WVFDbWRoQ3lF?=
 =?utf-8?B?RExEZ0twc0lsNzBRQkJ1UTJ4RGR1WHJoZEZFRHZNVmg5M0ZNcjVtalN4LzU0?=
 =?utf-8?B?NnRjQkRCZWxnb2I1bUtMazFIRisxM2FTdEhZbzZmeTFKWWljOUs2Z2ZacWFD?=
 =?utf-8?B?N3B4ZHZvaG9jUnJHNGVyaVNuRy8vZkQrZnlKQVJ1MCtUNWNvVGlOQlNSSGtn?=
 =?utf-8?B?TnVGNzNnNFF1MUtCSTNydkZZWTBHRlZrOWVSYU54TVBzRlhvOFQ0d2hOaFc0?=
 =?utf-8?B?YXY2SkZrOXY3L3N5QnAzaE9lcWd0V2xucXRLSE5xdkpuRVg3UDliVWlIVGU3?=
 =?utf-8?B?WUprNk1LbmJwMGNJYm00RUFGMlZrNkM3dXgvVDZEZ21xZVBiTUptN3JVelFU?=
 =?utf-8?B?U2dkMFAyTkFuTmtmZW03blBzazRVbFdJeGJ6eE1OeFJweldaWWNjdWRmNkhB?=
 =?utf-8?B?cXg4RUt2eHQ1Vk1icjBua2JXVGpHTWZOdkt6aHRzYTA4eGpYZUw2Yk9GRnps?=
 =?utf-8?B?NXV1ZkF5b1lmeVI0Y2lIaENhcEZTaE5NZk9CblVFcGY4SWYzS2Jxd3hwYjhr?=
 =?utf-8?B?RmpQcVhic2taZGtDSEJDbkdhN3RCV0dYR2Vwall3LzdaTUZtM3RUdTJROTZj?=
 =?utf-8?B?QVdyeEdPMERQNmxCQW8vcjRjL3ljazZ1SkZIc3FlT3dDMWdzeXFPaEtFV3JE?=
 =?utf-8?B?Z1gvUkFyRmV6OUhaczBUUHNuN29iWFcyYW5YZlY3RVB6T3dUVHp1QUZPT2dS?=
 =?utf-8?B?ZUVGNGY4TzIxdDMvWnoxd2duZXY0L042dVB1WnJJLzdMSjhMSHdDa3BpZ1F5?=
 =?utf-8?B?NEdhNnRteVBXZWg2SzNHaFc4YklPZGlvUEZsSWt1MTRoNWZCWm5QeGdjV2Z3?=
 =?utf-8?B?Qm5VTDY1dy9Mbld0WGlwK09JbEJENXZMVmlJR2hzRFZIbEZ4Qi85YldLNmdo?=
 =?utf-8?B?clpabUxxL1lhNzlTWlBpcUdBMVZvMmQvZ0hBNFpCUSt5YStmUkxvSlBpWHZF?=
 =?utf-8?B?VVl1Qm1QMHVJRDRadU4zNXdZQkNTMlRnMFI5NDFQandSZXFVLytoOFFISy8x?=
 =?utf-8?B?Nmd4RjdOTWs2WGo2LzZOZ0F0T1lyZUNuMkk1cXRnRjdaWkhqTHRYMXViVUdJ?=
 =?utf-8?B?MGJJZ2JPN3hvemZiMGV3R3d2MmhqWXVYajhXU21BUzM1dk9XaTJwZ2ZZRnVx?=
 =?utf-8?B?Q2RRVW9tRllhc040MndOaEc3SXJSNVB3WDlVOFIyTUxNenlXQm12UmxhaVRU?=
 =?utf-8?B?L2ZjN1VTVWtZNS9Ialo2ZGlxQWJQRmVwaWpjVEFORXBOSEV4K3BWYktuaWZW?=
 =?utf-8?B?RFlFQ2p2aS9TTEhydFhCZzZFNDdPaUJWM2R3NUYydEo2aWlXckI0cG5QeDUy?=
 =?utf-8?B?NnRjVS9QRU9kZmtlOVFacklzU1R4Z3EzRzNXLzEvSEdIWjVVd3MxMndnL0lD?=
 =?utf-8?B?NUdWbG5wazc0cHJvWHVMWVkwelU5Y3dUVUg0Rm9IWFhEVHREUEtUc0ZpVXJh?=
 =?utf-8?B?WnovYmdGK1V6K3JvZVNuZEtUaktCT25nVkpBTmtsN09JT2FvbFVtTWIwVlRh?=
 =?utf-8?Q?ITdbcjuM2XicJEs3AErTcOkJs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab03df70-68b3-437a-ebd7-08dcd87835f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 06:56:39.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKKrn8KP71ZXjI9iZju9apw9d11nUx6/bMr3DtxXXKAzxifhFOhiUiJrrOgTwPTOBR1kHcjMh88vgXDSi1IMS2LzazMWvtzKTrCjIqvHVeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

PiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAwNDo0OToxNlBNICswMzAwLCBBbGV4YW5kZXIgVXN5
c2tpbiB3cm90ZToNCj4gPiBBZGQgZHJpdmVyIGZvciBhY2Nlc3MgdG8gSW50ZWwgZGlzY3JldGUg
Z3JhcGhpY3MgY2FyZA0KPiA+IGludGVybmFsIFNQSSBkZXZpY2UuDQo+ID4gRXhwb3NlIGRldmlj
ZSBvbiBhdXhpbGlhcnkgYnVzIGJ5IGk5MTUgYW5kIFhlIGRyaXZlcnMgYW5kDQo+ID4gcHJvdmlk
ZSBzcGkgZHJpdmVyIHRvIHJlZ2lzdGVyIHRoaXMgZGV2aWNlIHdpdGggTVREIGZyYW1ld29yay4N
Cj4gDQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoaXMgZG9lcyBub3QgYWN0dWFsbHkgcHJvdmlk
ZSBhIFNQSSBkcml2ZXIsIHRoZXJlDQo+IGlzIG5vIGNhbGwgdG8gYW55IFNQSSBBUEkgdGhhdCBJ
J3ZlIG5vdGljZWQgaGVyZS4gIFRoZSBTUEkgZnJhbWV3b3JrDQo+IGRvZXMgaGF2ZSBzdXBwb3J0
IGZvciBTUEkgY29udHJvbGxlcnMgd2l0aCBzcGVjaWZpYyBmbGFzaCBzdXBwb3J0IHZpYQ0KPiBz
cGlfY29udHJvbGxlcl9tZW1fb3BzIGJ1dCB0aGlzIGRvZXMgbm90IGFwcGVhciB0byB1c2UgdGhl
bS4gIEVpdGhlciBpdA0KPiBzaG91bGQgZG8gdGhhdCBvciBpdCBzaG91bGQganVzdCBiZSBhIE1U
RCBkcml2ZXIuDQo+IA0KDQpJIGhhdmUgaGFkIHNvbWUgdGFsa3Mgd2l0aCBNaXF1ZWwgb24gdGhp
cyBhbmQgaGUgd2FzIG5vdCBzdXJlIHdoZXJlIHRoaXMgZHJpdmVyIGJlbG9uZ3MuDQpNaXF1ZWwg
LSBjYW4gdGhpcyBkcml2ZXIgYmUgcHV0IGluIGRyaXZlcnMvbXRkLCBhcyBzcGkgY2xlYW5seSBk
byBub3Qgd2FudCBpdD8NCg0KPiBUaGUgc2VyaWVzIGlzIGFsc28gc3BsaXQgdXAgaW50byB0b28g
bWFueSBwYXRjaGVzIHdpdGggbWluaW1hbA0KPiBleHBsYW5hdGlvbiwgbWFraW5nIGl0IGhhcmQg
dG8gZm9sbG93IHdoYXQncyBnb2luZyBvbi4gIEkgd291bGQNCj4gcmVjb21tZW5kIG1ha2luZyB0
aGUgZmlyc3QgcGF0Y2ggYmUgYSBtaW5pbWFsIGZ1bmN0aW9uYWwgZHJpdmVyIGFuZCB0aGVuDQo+
IGJ1aWxkaW5nIG9uIHRvcCBvZiB0aGF0Lg0KDQpBcyBJIHVuZGVyc3RhbmQsIGJldHRlciB0byBo
YXZlIHNtYWxsIGFtb3VudCBvZiBiaWcgcGF0Y2hlcw0KdGhhbiBiaWcgbGlzdCBvZiBzbWFsbGVy
IHBhdGNoZXM/IA0KDQpJJ2xsIHRyeSwgYWNjb3JkaW5nIHRvIHlvdXIgY29tbWVudHMgaW4gb3Ro
ZXIgcGF0Y2hlcywNCmJ1dCB3ZSBoYXZlIHRoZXJlIHRocmVlIGJpZyBwYXJ0cyAoY2hhbmdlcyBp
biBpOTE1LCBjaGFuZ2VzIGluIFhlDQphbmQgYWN0dWFsIHNwaS9tdGQgZHJpdmVyKSBhbmQgdGhl
eSBzaG91bGQgY29tZSB0b2dldGhlciBhcw0KdGhlcmUgaXMgbm8gcG9pbnQgaW4gYW55IG9mIHRo
ZW0gYWxvbmUuDQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoNCiANCg==

