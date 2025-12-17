Return-Path: <linux-spi+bounces-11982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C86CC73B4
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D66318D403
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32A33D511;
	Wed, 17 Dec 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBxsvmDa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6372E06EF;
	Wed, 17 Dec 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968372; cv=fail; b=c3llGqyaYCd7aTYRn8odHafaudJN6ebBycLuyeh+X7G86wnqk1f/bV0w0xWmmRiij9+RjTsvFabunnJVE6nDsn4nVRKvf6ncHKfd1hjPvPeabhQNtwHUTWm11QzB1OSdjl5skvBM4BCRXsorYci05U5Y13QiC9M08C1M2eQy2y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968372; c=relaxed/simple;
	bh=yHYukKqHlU91es5S9xF4418RECWXbtNbtMLlQVCvMoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUgLAOO7Ky8A71GBHqdkGZn8uKc/myp+OljvCkWHAIHkSFV5ikctzhf/utuSsBJmbMOTsWoC0DtLg+k/7GkxgQ9D9HYw34RlVLlLmR74rk8vzg+wlnlRcMP3FbfYH72o50QlXNVEGc0O+ouJO/Zs2wnYTTDtXzV8kLFfp1vzo7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBxsvmDa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765968369; x=1797504369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHYukKqHlU91es5S9xF4418RECWXbtNbtMLlQVCvMoc=;
  b=OBxsvmDa6bgtDoV8Cb5XUAw4V1pVO9swbV/XGFi9wUgYya6pQuiG+wuX
   Rx8gkop7f9JkXOddmV0vHb6b0pMNC+wEuiJ4k1OylHX1Zjbkm9VYJqRsE
   49q/RDABDHdG+BeB/u0UMKy9cIUyuKJLS28yRpwiZDAbaeEegNB69vY59
   pYL4fJ79PdjG7eicCBlAVtfsuJIFgM/7G33nTjRTfmHNShi9No511Prq8
   PMtCSBBi9yjemN7x9tepiPOBnbRNvUT6dBhOsuD3VowxLvJu62vmCfQsn
   EYLYKehhs2LCKxwC38mlRfFDRc6BXDezCAoBG8sHEY4XI00fA9stD8xTu
   Q==;
X-CSE-ConnectionGUID: NdegNOfKSjW1/sTiE0b9cQ==
X-CSE-MsgGUID: hQfhneBhTJCSWIGnviN5vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="78541509"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="78541509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:46:06 -0800
X-CSE-ConnectionGUID: xAfJPDsSQUyNjGK1Gaphkw==
X-CSE-MsgGUID: rlhYScnrQQSuk3wqqqA5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197366779"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:46:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:46:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 02:46:05 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt1oGYKezQWrFiOtWMyVL/DFRxZTUNuvN3e6/cFabSq4OAIqe6zB+5cgUJPR4Z2Zgsp4uPgV5gJLx6myJUc9NSzYHMx+tJyyRNeVOgzmmjRZecNyMSXVjMX5KtGJQ80vSvXOHl4fnYc9Ilr/ZFIGL3sml1zdiyOoLICd/2fxkwDQ4pqxChg56FYeEkUcAEG6wybrwTOSUaUcyIYgo+r8MUoYQps6csqLmOj+UI0gdhj50au94XS9gyLxmiUOEFB0NKlmd3UQyXm3KiDv+lTtLSZE2H4Ur/mvCTxN5HVS3IIypqi3+X5orC4tTH9z8DW3jiyk17HWXSZ6KvtuWMiuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C+4r5WZcIwTSNkRjvjPSbvev9rhCJuu9ya1hJqVq0A=;
 b=hOt7Yr0bbPSSmjOfz2P29RpLvy/NuRxF6c6QGnkCROPlC4jVoAqqo48yDU9IWVjWQ3tdNyHa4hrG/LSyrwJaFIbSzQKNlGnZdowOrwLBbEY+E9N77p2t2zO/VOn62V3xp7eQGreM4pMnDuBLC1Ou8xYXFxoMTEeTc+ziXcjXqrQ9NYuyr6wgkIul4GsrYrKPbJXwGfrsaNeZ0Pa1BVKkGXF039QMYTROBcF9axLWDQbGdlJDjDSeYwPtheB7cErsC46gGcTxFGm+DV1EdhyPOW6vGz4O/Dw+5d7gd8aSPQ3wa21A1GR+/zLnK5fHzGm6Y6i6C8TmOQkRpAGT2WLU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:46:03 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 10:46:03 +0000
Message-ID: <81510775-c277-4dfc-bbe1-d3b75debc140@intel.com>
Date: Wed, 17 Dec 2025 11:45:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] ASoC: rt5575: Add the codec driver for the
 ALC5575
To: Oder Chiou <oder_chiou@realtek.com>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <flove@realtek.com>, <shumingf@realtek.com>,
	<jack.yu@realtek.com>, <derek.fang@realtek.com>, <broonie@kernel.org>,
	<lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
 <20251216071853.3929135-4-oder_chiou@realtek.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251216071853.3929135-4-oder_chiou@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0049.eurprd03.prod.outlook.com
 (2603:10a6:803:50::20) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5b5cf3-0613-4f1d-459b-08de3d597947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cml6V1dPdHRkdCsxTTE4VHlQYVhwM1BYc2MwZm9mbFBITTNSM1VKelUvZ0Qr?=
 =?utf-8?B?YlhDQ0JwbStFOHlYLzFXOFlGQ1lqOW5jS0kzamFKQlZ1NGlHeHN4dkg1b0dO?=
 =?utf-8?B?dHBJRFM2bW5sSTFRSWl3TmxDQnplKzRZZG9JSVJiOUw1RnlZYS9yODFGSmE0?=
 =?utf-8?B?TzRrNmlLMVlvbEdadytJZVFyZExKeldkd1hrQ0wwSmdPTHB0eGpDK214K2RC?=
 =?utf-8?B?WWgvRFpRVDYweVArQkUzWEZKbHFMdEUvVlVDWmNGSDIrbkVtTjY5dUJOMXZw?=
 =?utf-8?B?VUtrVzgybHRmRUdnVzd1RktWTnl2OWpMUWhFclExRk1lcUd5RmZuZTc3SU1W?=
 =?utf-8?B?cWVNeWJsNnBLRVI1OXBPZlN5QXRGczhJamIweUx5ZVpibnpYWTZZckNpcitZ?=
 =?utf-8?B?djBod2Q5R0d2aEl6SGtmRmpOQldaQyt1K0NDYkNvWUVvaldZMmVBblg3YzJM?=
 =?utf-8?B?MmJCT1NLS2VFcnRzU0F4Wlc2ZmNOSmE5RlVOTTRPcWloUG0rT3VXL1EzVFFw?=
 =?utf-8?B?anBkZ3gzcWpGcU1qcGJQTlpCclFTYUNtcDNXZDB2cW1lc1laZTZtMHdpbmkr?=
 =?utf-8?B?SFVpanlCZTBLbmZUNmc4WndwN1V0a1JwQnpiSE9UYlVwQ3dFVkdhM2FkOHlp?=
 =?utf-8?B?VG9GQmg0UUZTUFR5VDQrNXh5TG1oamFrcWR0VDllMVlIN3VaSHN0bkpudnM5?=
 =?utf-8?B?cmsrYjdIalYrMWxhUnBadmFFTXpDQmdYOTZ6RmgrT2lqajluSllpT0tFTFVB?=
 =?utf-8?B?ejBJc2Y1OGhoSjhpWHEyZi8rdGxXelV6UW1SRFlBN015SUMrNm1LU2UzQzUv?=
 =?utf-8?B?WVpLakFKSnNGeStXREYvMzE2V0JBWkJBUlFnOWV4dlBlM1ZXQXFOTlZJa3ZP?=
 =?utf-8?B?dnpXU0dpTThQbzBHY1dFK091TnVrMXVsUnJvYnBTcjUvUnRTYTAzdVR1OTAw?=
 =?utf-8?B?UEFWOVN6ZGtBall0Mjdkc0o0Vzc1VHluekdxL2xLeFJpMXlmczh0VTNCL1Uy?=
 =?utf-8?B?dTR5Wit4ZjY3bGVnNWZQTDVwWHdFNXlSei8vRzNUWlNqVTVTYlhsVWZ4bFND?=
 =?utf-8?B?WnV1dlFvWXIyTDM0eFRsVDRyUHgzdE1vaGlWNEZUdTJ3OUxKbmhOd1NvVS9D?=
 =?utf-8?B?OFVpYytTNDc1bFpIKzZIYjJSRWRxOFBFWEV4c3Frd01pYzJVN1J4bXhBRU9i?=
 =?utf-8?B?N3UvOFpnQ283Y2xPL29pWE9OL1FHVGFBcnNZMTZPZXFwZE13ZDJNSUEvVUxw?=
 =?utf-8?B?WWlJbk12cnF3azFzN1dBTkc3dmJuNHk4VmFoa0tMZis4QUNON3lIcHMrTk9D?=
 =?utf-8?B?UUJhNDBUenpTYXF4UGJNUlJwWkQ4SU5lTEczOHNKMlBOV3NFMHNMWnYxS3RC?=
 =?utf-8?B?OW4zYUtDV3BUOTR0WmwvSlByb2x0c2pBREd5Uk5XZGtxaXRnMlNPdTVtUUVi?=
 =?utf-8?B?OTVpbW9LNGdmRkVFWE1hbFZ4RkpmSDZVWGFTdjZiMzJxZXdTZ1FLeTczSU91?=
 =?utf-8?B?dTl1SVBVSjcrVk9VV3lySlRWRC9CY0Q2WHVsZExDOUFWa1pHbFNYbTJYVnJX?=
 =?utf-8?B?cTczZlVqWGp0Y3B4ZlUxTmVqdEI4SStRQk1GWk80M3FMUmgyTGpLSzdSajMz?=
 =?utf-8?B?UjlJdTJMUTVmQ1pqZ2F6RE1ybzdlOXVPaDNpa3l3Q3lWSjY3blczSUlYajIr?=
 =?utf-8?B?VDR6ZUduNVZUTVlrMnpjZHVPOFFtNTRTZE1EcUNlUDU3TnVqbkRKNGVVU3py?=
 =?utf-8?B?OFJoZDZTbTg5SEFJcmpDc0VnNHZsWDNQaDhUalFoS0hHTzBwSXVzZjFlWXVp?=
 =?utf-8?B?a3ZaUDY3emcxMkxySjJrZk9EbURHYXFlTzI1U1hYeDh4NVZtbE94eHBxWGhP?=
 =?utf-8?B?T3QrV25tUU1IaUpmQWsrb1YzVWw4OFM5WmxqRXE0dW1JQUhCS3JTbm45TWRC?=
 =?utf-8?Q?VQaqWIS14F7bvwWIPWruji1q7NFte5g7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJwS3VKOHQySk52aVJEWG80VzMrQ0I4VWRKQUtXcG8yeVlFUkhDSkQyMjBQ?=
 =?utf-8?B?b0xaMU01UDlvbStVdElacVdlbVIxbzdzbFNTcVNHbmpGa3pkU0ZmSnFuRFRU?=
 =?utf-8?B?bTJYNEpxMGNnTkVBN3JuM0lITHZVS0plMThtRTlTTzJmVzl0WkNQMGtxNXBq?=
 =?utf-8?B?NklVL0M0ZUZoeGxCSk5pOHpJSURnZDlJTnc0L3Mzdkt6U1Fjd1ZzallaRXNN?=
 =?utf-8?B?MGxBdHJsNTF5MTFiRnhDV1BSUDYxM3REOE8wV1JNMFFXaEZwZWFrSUxzNHFi?=
 =?utf-8?B?MUhkWFhoN24wL0FubHdIb29NenFYNnNQU3FxaEIxaFV5cERqcmZJdEFZQmVJ?=
 =?utf-8?B?UUxGcHFGVzN1dVlrd3RJT1dYVGVERjA3czZVQTdhQUk3S05mYmpCK2IvbEw0?=
 =?utf-8?B?R2ovckdCaVpoS3IrNUR5V1VINE5mazZmemc1K1JhQ2R6Ynh1TVJla3pTWStZ?=
 =?utf-8?B?Z2NSSlVHbnFZbk4ySGlJLzhrd0hkMFphTTZQaGhRd0MyWk1QdEZZTW95Z2o4?=
 =?utf-8?B?V045emh1V0lZb3d4MmIwUUFSTENESXN3aGw0elo4QzZJTWlkZzdMOGRzNnpa?=
 =?utf-8?B?QVRNUnhadDFUZEw3ZGpwdUNSUHdqZmY3VjZNeHdyZm8vNmF2UUtINm9LY2tJ?=
 =?utf-8?B?SmVMVEU4Vmg2OFAxMHAzUnRCQWJjOFFWMHozRkhFOTN3Wk1sM1lpMGxJbEp1?=
 =?utf-8?B?MTgxZGxrVVBxSERlZG80YzdxZFZ3eXhXQ3Y3RkJHMHV3RlBlVitQZUpZQXdO?=
 =?utf-8?B?YkZsaGtVTmNYQjhZc1ZzREhkbWZWemd1bGM5ZDVlOGJiM0NGZHE0ODB6WElE?=
 =?utf-8?B?NHA3MTc2RkFZYTFXQWpnNWcwOHRqYVVqM1krVkxPMTJHcmRmTXZGQ3hsTlpZ?=
 =?utf-8?B?Zm9DeVBGZEV4dTZNSWVsQ21ReHZFUEdmM1lGejNvZENKQnFCOW9FbzZnQWxm?=
 =?utf-8?B?RHJtZE8yNHpZRkcycjQ2bGNnQng4UUMxRWdwWDd5WDZtK09CVXkxUEFENWRj?=
 =?utf-8?B?SElscXBvdFpFOG53d1dYT3FZeXhNZWp2aTlFZldsWDlxdWdYL0EwZVoyUFJm?=
 =?utf-8?B?b0JDVFgyczhqOENwc09kU3FRL01JZnAxUEdRaUk3OExOZUlLS1orem9CQVpR?=
 =?utf-8?B?c083cUtRdUxTVU9xSDk2R3VzVkhIOE8wemY2UW9lbWc3SnQ0TUx5T2o3SWhJ?=
 =?utf-8?B?akRkU0d2Nytua0pSRnhSWWRxaFFQUUliU1JpdnpjMms4OU5wSmRTcmlCSE50?=
 =?utf-8?B?a3VBZTNwQy9KNFRlL3orV256OGdkb3gyK3M5T0JBVFlsVjNWeVB2VnZpdkRZ?=
 =?utf-8?B?NHFhTjc5Wm5xNEo1U3pLM0o4bGNUMzIyZzFqVE41VHE0UUVwT1h4SDNBTHBQ?=
 =?utf-8?B?a1U0S0x0dXc4dEcwRThqUHpYSmZoMVNmM252bUhRME0vZzE2byt4UzVXekxR?=
 =?utf-8?B?bVp0ckdBaGtiQ0xsUHRUa3dmUmFpNkVrYm5DMFdRVlF0V3crTk1rRWQ3VEd2?=
 =?utf-8?B?emo5bnpQcXpkYktvTXhSZHF3eVU2WnZXQmI1RzhtM1hKZDVIcC8yZDE2OHZH?=
 =?utf-8?B?eGp1V2dKYlBnYllpVUJjS3FqenMxbDFFWnZ5Z0g0ZEZiOXZVUVE1NXJEeG5W?=
 =?utf-8?B?TFBnVkt4TTZzSEV4YzZCTUt1SEQxSFBLenVCUHBOWlFyR2NPcGpNZ2wrK2Yz?=
 =?utf-8?B?WDgreWVEMjVBTDI1STFicjdKdklFaE5BL1lzN29hZ0dqc2lxaVYvaUZJVXc0?=
 =?utf-8?B?SlI5ekJ4OHJMQzVWZmM1OHo5VVl6Uml0QWl5dFcrRGU4dEhQc3k0NG9tSWh4?=
 =?utf-8?B?dXZpT3RSd3hXVlRlbGRxcnpCTW8waE5TY0svRHRNTS9MbGRQbGJzZ0EvbldD?=
 =?utf-8?B?TndrSGZnekNoc0hubllqVzZaOHI5bmxHcU0rYi9LYjg5RjRpcXcyTXErZThy?=
 =?utf-8?B?bkVhZzBKS1ZpMXlhSVBudnNnYWdhMTlpc0I4bnIrM3hCY291K2ErZ3M0Z09o?=
 =?utf-8?B?SnE1S1dORmkxS0V1eHA2V1NaaERiWnZIZFVCZXU2SUNNUUR6bnV2eGJLMDRo?=
 =?utf-8?B?ZXgwR24rMWY4UEVMMFZTNlliaFJYOXZKY2ZVT1lRci9ScUNaOVdncTgzWlZE?=
 =?utf-8?B?a2hkMDFtK3Z6YVFPb1cvVDJYdTZxNERBVmk5N1d1MDBaejlvRlA5ZFY0VWN5?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5b5cf3-0613-4f1d-459b-08de3d597947
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:46:03.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwZSuTC1sa4kFu8GWrxjSkPAsOebMIRjF1kmIqikhP9Cj+RO5kJZ5RanPnLmReq0m2DCUzG5S5kulFeIjapl1IFUPrTrD4kgUIBwbnPGgVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

On 2025-12-16 8:18 AM, Oder Chiou wrote:
> The ALC5575 integrates an audio DSP that typically loads its firmware
> from an external flash via its own SPI host interface. In certain
> hardware configurations, the firmware can alternatively be loaded
> through the SPI client interface. The driver provides basic mute and
> volume control functions. When the SPI client interface is enabled,
> firmware loading is handled by the SPI driver.
> 
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>   sound/soc/codecs/Kconfig      |  10 +
>   sound/soc/codecs/Makefile     |   3 +
>   sound/soc/codecs/rt5575-spi.c | 119 +++++++++++
>   sound/soc/codecs/rt5575-spi.h |  26 +++
>   sound/soc/codecs/rt5575.c     | 359 ++++++++++++++++++++++++++++++++++
>   sound/soc/codecs/rt5575.h     |  54 +++++
>   6 files changed, 571 insertions(+)
>   create mode 100644 sound/soc/codecs/rt5575-spi.c
>   create mode 100644 sound/soc/codecs/rt5575-spi.h
>   create mode 100644 sound/soc/codecs/rt5575.c
>   create mode 100644 sound/soc/codecs/rt5575.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 061791e61907..14f3d09e7117 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -212,6 +212,7 @@ config SND_SOC_ALL_CODECS
>   	imply SND_SOC_RT1305
>   	imply SND_SOC_RT1308
>   	imply SND_SOC_RT5514
> +	imply SND_SOC_RT5575
>   	imply SND_SOC_RT5616
>   	imply SND_SOC_RT5631
>   	imply SND_SOC_RT5640
> @@ -1783,6 +1784,15 @@ config SND_SOC_RT5514_SPI_BUILTIN
>   	bool # force RT5514_SPI to be built-in to avoid link errors
>   	default SND_SOC_RT5514=y && SND_SOC_RT5514_SPI=m
>   
> +config SND_SOC_RT5575
> +	tristate "Realtek ALC5575 Codec - I2C"
> +	depends on I2C
> +
> +config SND_SOC_RT5575_SPI
> +	tristate "Realtek ALC5575 Codec - SPI"
> +	depends on SPI_MASTER && I2C
> +	depends on SND_SOC_RT5575
> +
>   config SND_SOC_RT5616
>   	tristate "Realtek RT5616 CODEC"
>   	depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index d687d4f74363..a6406bc907a9 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -253,6 +253,8 @@ snd-soc-rt286-y := rt286.o
>   snd-soc-rt298-y := rt298.o
>   snd-soc-rt5514-y := rt5514.o
>   snd-soc-rt5514-spi-y := rt5514-spi.o
> +snd-soc-rt5575-y := rt5575.o
> +snd-soc-rt5575-$(CONFIG_SND_SOC_RT5575_SPI) += rt5575-spi.o
>   snd-soc-rt5616-y := rt5616.o
>   snd-soc-rt5631-y := rt5631.o
>   snd-soc-rt5640-y := rt5640.o
> @@ -686,6 +688,7 @@ obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
>   obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
>   obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
>   obj-$(CONFIG_SND_SOC_RT5514_SPI_BUILTIN)	+= snd-soc-rt5514-spi.o
> +obj-$(CONFIG_SND_SOC_RT5575)	+= snd-soc-rt5575.o
>   obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
>   obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
>   obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
> diff --git a/sound/soc/codecs/rt5575-spi.c b/sound/soc/codecs/rt5575-spi.c
> new file mode 100644
> index 000000000000..c8eadb2f59a6
> --- /dev/null
> +++ b/sound/soc/codecs/rt5575-spi.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rt5575-spi.c  --  ALC5575 SPI driver
> + *
> + * Copyright(c) 2025 Realtek Semiconductor Corp.
> + *
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +#include "rt5575-spi.h"
> +
> +#define RT5575_SPI_CMD_BURST_WRITE	5
> +#define RT5575_SPI_BUF_LEN		240
> +
> +struct rt5575_spi_burst_write {
> +	u8 cmd;
> +	u32 addr;
> +	u8 data[RT5575_SPI_BUF_LEN];
> +	u8 dummy;
> +} __packed;
> +
> +struct spi_device *rt5575_spi_get_device(struct device *dev)
> +{
> +	struct device_node *spi_np;
> +	struct spi_controller *ctlr;

Reorder to achieve reverse-christmas-tree notation. Waterfall to a 
number of functions found in this patch.

> +	struct spi_device *spi;
> +	u32 cs;
> +
> +	spi_np = of_parse_phandle(dev->of_node, "spi-parent", 0);
> +	if (!spi_np) {
> +		dev_err(dev, "Failed to get spi-parent phandle\n");
> +		return NULL;
> +	}
> +
> +	if (of_property_read_u32_index(dev->of_node, "spi-parent", 1, &cs))
> +		cs = 0;
> +
> +	if (cs >= ctlr->num_chipselect) {
> +		dev_err(dev, "Chip select has wrong number %d\n", cs);
> +		of_node_put(spi_np);
> +		return NULL;
> +	}
> +
> +	ctlr = of_find_spi_controller_by_node(spi_np);
> +	of_node_put(spi_np);
> +	if (!ctlr)
> +		return NULL;
> +
> +	spi = spi_new_device(ctlr, &(struct spi_board_info){
> +		.modalias = "rt5575",
> +		.chip_select = cs,
> +		.max_speed_hz = 10000000,
> +	});
> +
> +	spi_controller_put(ctlr);
> +	return spi;
> +}
> +
> +/**
> + * rt5575_spi_burst_write - Write data to SPI by rt5575 address.
> + * @spi: SPI device.
> + * @addr: Start address.
> + * @txbuf: Data buffer for writing.
> + * @len: Data length.
> + *
> + */
> +static int rt5575_spi_burst_write(struct spi_device *spi, u32 addr, const u8 *txbuf,
> +						size_t len)

Alignment or, just make it one-liner. It fits the limit.

> +{
> +	struct rt5575_spi_burst_write buf = {
> +		.cmd = RT5575_SPI_CMD_BURST_WRITE

Missing comma at the end.

> +	};
> +	unsigned int end, offset = 0;
> +
> +	while (offset < len) {
> +		if (offset + RT5575_SPI_BUF_LEN <= len)
> +			end = RT5575_SPI_BUF_LEN;
> +		else
> +			end = len % RT5575_SPI_BUF_LEN;
> +
> +		buf.addr = cpu_to_le32(addr + offset);
> +		memcpy(&buf.data, &txbuf[offset], end);
> +		spi_write(spi, &buf, sizeof(buf));
> +
> +		offset += RT5575_SPI_BUF_LEN;
> +	}
> +
> +	return 0;

If you intend on ignoring result of spi_write()s, then I see no reason 
why rt5575_spi_burst_write() shouldn't be a void function.

> +}
> +
> +int rt5575_spi_fw_load(struct spi_device *spi)
> +{
> +	const struct firmware *firmware;
> +	struct device *dev = &spi->dev;
> +	static const char * const fw_path[] = {
> +		"realtek/rt5575/rt5575_fw1.bin",
> +		"realtek/rt5575/rt5575_fw2.bin",
> +		"realtek/rt5575/rt5575_fw3.bin",
> +		"realtek/rt5575/rt5575_fw4.bin"
> +	};
> +	static const u32 fw_addr[] = { 0x5f400000, 0x5f600000, 0x5f7fe000, 0x5f7ff000 };
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(fw_addr); i++) {
> +		ret = request_firmware(&firmware, fw_path[i], dev);

So, in v8 or earlier the ordering of operations was different:

	request_firmware(fw1);

	regmap_write();
	regmap_write();
	regmap_write();

	rt5575_spi_burst_write();
	release_firmware(fw1);

	/* Proceed with loop for the remaining fw2, fw3, fw4. */

What changed that suddenly the ordering could be simplified?

> +		if (!ret) {
> +			rt5575_spi_burst_write(spi, fw_addr[i], firmware->data, firmware->size);
> +			release_firmware(firmware);
> +		} else {
> +			dev_err(dev, "Request firmware failure: %d\n", ret);
> +			return ret;
> +		}

Please refactor this construct. When facing else-return, favour 
returning early to reduce indentation and make it easier to read the code.

	if (ret) {
		dev_err();
		return ret;
	}

	rt5575_spi_burst_write();
	release_firmware();

Much better, isn't it?

> +	}
> +
> +	return 0;
> +}
> diff --git a/sound/soc/codecs/rt5575-spi.h b/sound/soc/codecs/rt5575-spi.h
> new file mode 100644
> index 000000000000..3b296bcac9a6
> --- /dev/null
> +++ b/sound/soc/codecs/rt5575-spi.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * rt5575-spi.h  --  ALC5575 SPI driver
> + *
> + * Copyright(c) 2025 Realtek Semiconductor Corp.
> + *
> + */
> +
> +#ifndef __RT5575_SPI_H__
> +#define __RT5575_SPI_H__
> +
> +#if IS_ENABLED(CONFIG_SND_SOC_RT5575_SPI)
> +struct spi_device *rt5575_spi_get_device(struct device *dev);
> +int rt5575_spi_fw_load(struct spi_device *spi);
> +#else
> +static inline struct spi_device *rt5575_spi_get_device(struct device *dev)
> +{
> +	return NULL;
> +}

Missing newline.

> +static inline int rt5575_spi_fw_load(struct spi_device *spi)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +#endif /* __RT5575_SPI_H__ */
> diff --git a/sound/soc/codecs/rt5575.c b/sound/soc/codecs/rt5575.c
> new file mode 100644
> index 000000000000..c3a9ba22a90d
> --- /dev/null
> +++ b/sound/soc/codecs/rt5575.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rt5575.c  --  ALC5575 ALSA SoC audio component driver
> + *
> + * Copyright(c) 2025 Realtek Semiconductor Corp.
> + *
> + */
> +
> +#include <linux/i2c.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +
> +#include "rt5575.h"
> +#include "rt5575-spi.h"

(...)

> +static int rt5575_i2c_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct i2c_client *client = context;
> +	struct rt5575_priv *rt5575 = i2c_get_clientdata(client);
> +
> +	regmap_read(rt5575->dsp_regmap, reg | RT5575_DSP_MAPPING, val);
> +
> +	return 0;
> +}
> +
> +static int rt5575_i2c_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct i2c_client *client = context;
> +	struct rt5575_priv *rt5575 = i2c_get_clientdata(client);
> +
> +	regmap_write(rt5575->dsp_regmap, reg | RT5575_DSP_MAPPING, val);
> +
> +	return 0;

Not an expect in regmap, but I'd leave decision to the caller whether to 
squelch an error or not.

For both, rt5575_i2c_read()/write() I'd just return the corresponding 
regmap_xxx() operation rather then '0'.

> +}
> +
> +static const struct regmap_config rt5575_regmap = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0xfffc,
> +	.readable_reg = rt5575_readable_register,
> +	.reg_read = rt5575_i2c_read,
> +	.reg_write = rt5575_i2c_write,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
> +static int rt5575_fw_load_by_spi(struct rt5575_priv *rt5575)
> +{
> +	struct i2c_client *i2c = rt5575->i2c;
> +	struct spi_device *spi;
> +	struct device *dev = &i2c->dev;
> +	int ret;
> +
> +	spi = rt5575_spi_get_device(dev);
> +	if (!spi) {
> +		dev_warn(dev, "The spi-parent not described in the DTS\n"
> +			      "The hardware configuration should be with built-in flash\n");
> +
> +		if (!IS_ENABLED(CONFIG_SND_SOC_RT5575_SPI))
> +			dev_warn(dev, "If the spi-parent is set in the DTS and it is without built-in flash\n"
> +				      "Please enable CONFIG_SND_SOC_RT5575_SPI\n");

Does this mean we always get a warning, even in case when we're dealing 
with non-SPI variant?

> +
> +		return -ENXIO;
> +	}
> +
> +	regmap_write(rt5575->dsp_regmap, 0xfafafafa, 0x00000004);
> +	regmap_write(rt5575->dsp_regmap, 0x18008064, 0x00000000);
> +	regmap_write(rt5575->dsp_regmap, 0x18008068, 0x0002ffff);
> +
> +	ret = rt5575_spi_fw_load(spi);
> +	if (ret) {
> +		dev_err(dev, "Load firmware failure: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	regmap_write(rt5575->dsp_regmap, 0x18000000, 0x00000000);
> +	regmap_update_bits(rt5575->regmap, RT5575_SW_INT, 1, 1);
> +
> +	regmap_read_poll_timeout(rt5575->regmap, RT5575_SW_INT, ret, !ret, 100000, 10000000);
> +	if (ret) {
> +		dev_err(dev, "Run firmware failure: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rt5575_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct rt5575_priv *rt5575;
> +	struct device *dev = &i2c->dev;
> +	int ret, val;
> +
> +	rt5575 = devm_kzalloc(dev, sizeof(struct rt5575_priv), GFP_KERNEL);
> +	if (!rt5575)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, rt5575);
> +
> +	rt5575->i2c = i2c;
> +
> +	rt5575->dsp_regmap = devm_regmap_init_i2c(i2c, &rt5575_dsp_regmap);
> +	if (IS_ERR(rt5575->dsp_regmap)) {
> +		ret = PTR_ERR(rt5575->dsp_regmap);
> +		dev_err(dev, "Failed to allocate DSP register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rt5575->regmap = devm_regmap_init(dev, NULL, i2c, &rt5575_regmap);
> +	if (IS_ERR(rt5575->regmap)) {
> +		ret = PTR_ERR(rt5575->regmap);
> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_read(rt5575->regmap, RT5575_ID, &val);
> +	if (val != RT5575_DEVICE_ID) {
> +		dev_err(dev, "Device with ID register %08x is not rt5575\n", val);
> +		return -ENODEV;
> +	}
> +
> +	regmap_read(rt5575->regmap, RT5575_ID_1, &val);
> +	if (!val) {

1. The 'RT5575_DEVICE_ID' check above fails, 'val' equals 
RT5575_DEVICE_ID, non-zero.
2. regmap_read(RT5575_ID_1) fails, let's skip the reasoning for now. 
'val' remains unchanged.
3. The '!val' check fails though nothing has been actually read, 'val' 
could be simply invalid.

What's the goal of this check? Shouldn't we be more precise when 
checking the 'formal version'?

> +		dev_err(dev, "This is not formal version\n");
> +		return -ENODEV;
> +	}
> +
> +	if (rt5575_fw_load_by_spi(rt5575) == -ENODEV)
> +		return -ENODEV;

Looks like a hack, not a real solution. Also, I'm surprised it's called 
unconditionally - even when dealing with device with no SPI component.

> +
> +	return devm_snd_soc_register_component(dev, &rt5575_soc_component_dev, rt5575_dai,
> +						ARRAY_SIZE(rt5575_dai));

Alignment.

> +}
> +
> +static const struct i2c_device_id rt5575_i2c_id[] = {
> +	{ "rt5575" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rt5575_i2c_id);
> +
> +static const struct of_device_id rt5575_of_match[] = {
> +	{ .compatible = "realtek,rt5575" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rt5575_of_match);
> +
> +static struct i2c_driver rt5575_i2c_driver = {
> +	.driver = {
> +		.name = "rt5575",
> +		.owner = THIS_MODULE,
> +		.of_match_table = rt5575_of_match,
> +	},
> +	.probe = rt5575_i2c_probe,
> +	.id_table = rt5575_i2c_id,
> +};
> +module_i2c_driver(rt5575_i2c_driver);
> +
> +MODULE_DESCRIPTION("ASoC ALC5575 driver");
> +MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
> +MODULE_LICENSE("GPL");

