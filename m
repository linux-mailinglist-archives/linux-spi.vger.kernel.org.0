Return-Path: <linux-spi+bounces-11983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD90CC742C
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D12631FDB2A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19189363C52;
	Wed, 17 Dec 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nC1P3Gv2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5B3624CB;
	Wed, 17 Dec 2025 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968729; cv=fail; b=E0m/aGHObxQ3x5sdsTt0PowicybRRLsKTgwzFMoNQXzpfRIxa7Yf316yRZSGyKBk28a5W7phT6vL2gd2Hg4eGc1a1FlCvxVIfZhCPiYaa84uKSTpf4YKF6t1X9u6BFPk7PSU5odFNNKvdrkiQCbZCkDmreSs5omAjcUgwAJbKXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968729; c=relaxed/simple;
	bh=gUjaNC1mMbwbBCXFzbiNGkzMI0H6OYUmM7+VB1NBbPM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ob5BLwEn75/PH3v2QfaVGIB4o07Vu7WmeeuHOCdndMR5gNsjjbI4kjiKCftm0EKT7l/+MtK7ykhbUUzIWi8V5t9Z1HNAMbB3j9zqo7wY3wi4HIVfNuCjwysx2TZE+hWzQvRONgTWnFGfDAaiQ+0m4CZqIY6FKWvnEpv4lj8FJhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nC1P3Gv2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765968727; x=1797504727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gUjaNC1mMbwbBCXFzbiNGkzMI0H6OYUmM7+VB1NBbPM=;
  b=nC1P3Gv2Ez/+V1yn3QxyNcEM5lDDMMhqBBk/PZjREtmWs8EG4xTcqjTI
   wKQqUTURC8A5kOw2aT1B2wwEL16ZntX3+2qErJ7O9P8eXgy5lBRdQ2ZX7
   d7EOI7a574KESw46gMylLB3/T2oc/Wg0bitJjOO1wclTx8Y2sLg1bJpK6
   HSWjfWZF0F7D2rpmt45xfSbPNsfWIpzDAr4FGSOgeWsVdBpIu2BcMYUK3
   5ua6TSC/Um11H0CXsC57bZhKgPpMrh1bRfE1UBU8urOzsgv9xMAUEGxiI
   rtX2cgleQ95IReow5FlBHjVyZHmNbQHbUyllQf9drZ2fQBqaQdfDA2mdx
   w==;
X-CSE-ConnectionGUID: kUPk/tYFQZ2fIsyEhCqEhQ==
X-CSE-MsgGUID: ovUAcaDpQ3u7wKSFdSXOGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="55475912"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="55475912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:52:04 -0800
X-CSE-ConnectionGUID: qzxbWm5uTX61lnBZxJ90FA==
X-CSE-MsgGUID: dqY5Wg/1QxitCzEHGS86IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="198763869"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:52:04 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:52:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 02:52:03 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi8rSRTpfc6WDEuISmCC4dzov3Iw7jMRu9j4MdExcoyw5RMYk0HA6+Uu30XF7qnrjPIE34Evh82tYictvXaPE7vSvgnnF4Ojs7/+MWVgWecvYsAqxpmWddO6M7KQdBxR9nBy7HssIvr1BeBY99AqX+U4NivX1gXNAypEGDW6DhtQf3BOmtZtPyZcAa9VOrwLK/xJgQXlR6sIu4CbX0dIurIy9UfhvlIw2vFo9qTtHJEXXivwFZiMRhxXB3PnjVgCaRzEtpXLGRCZ2Co9cJuHnWMgDmbT9t/8ekf/CEnNLnVwdfRGj5Di3N4I3XhnZDLGzh1Mka69+I6BtPkTAhWtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paJBZmPMmgwK98luQLJul71OnI+wTT2KVX7AnFBkzvA=;
 b=uCiSquhdmgZa2Qy2LECUb0vLncrkx6ZrjvUSfZnX3OFolkRDqO+JQ6Hce9rr2+W4PU0mJ1iSKE3dEPaEc3ivOlpfNvSwj/qf9Eulx1oCC8y43VrERRPghaaPE30PjXPRJdqvlhfyUTcdohN3WhFeCN0GzGaG1DPVrxRPdzCKABmS5Iqs84sU/kHj6hpcs4PGQztmb0gc3QQ/dVuEV5sFt8jmI1UrytCKpT4K8aeD7B37stDwmXVI+A7nF0DoThfpWZgM5MwswyGIiDL2Qf1q5CNy5vhxSjvUsN9MZNuk4rh8swQGB3jAPdqozwk8ZVl6PGs+36LqSmJbPyNkVTqctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:52:01 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 10:52:01 +0000
Message-ID: <c0a28aa0-118c-4304-9681-6b21b6e2659a@intel.com>
Date: Wed, 17 Dec 2025 11:51:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] spi: export of_find_spi_controller_by_node()
To: Oder Chiou <oder_chiou@realtek.com>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <flove@realtek.com>, <shumingf@realtek.com>,
	<jack.yu@realtek.com>, <derek.fang@realtek.com>, <broonie@kernel.org>,
	<lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
 <20251216071853.3929135-2-oder_chiou@realtek.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251216071853.3929135-2-oder_chiou@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:802:2::42) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0407cd46-a59f-4416-794d-08de3d5a4ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFNVSUJ0dWZRRXdGaE9qT2YxL3I4R25CNi9DR1NjTW1uODU4TGplZWJRcTU2?=
 =?utf-8?B?TmN4UXh2cTNzanNsM3E4bi9GSkcyUE1xRzRJYmt1NEtldmh5TUJYZHpBcWky?=
 =?utf-8?B?bGtTZkQzME1QWFhXKzJyTEkwbys1ZXJvV29HZ1JkWm5SR3h2WUhwWXFkclBq?=
 =?utf-8?B?U1lTejF4Smd3V2ZzVTZOMm1YeWwwLzgwSzZOcE54YXJ2Ry9LQkxoNDFZeXli?=
 =?utf-8?B?VDgwRjVZMXZkU21aUEhtZVVacnE0MWc0MWt4SHp1MDl1MWt0clJkcHBoU2ls?=
 =?utf-8?B?Vk1vYTJGekcvTFNkQTFiTi9vaDdLdEFsbXNyWTlyZVZKcnpRNUpJRzlKZjhH?=
 =?utf-8?B?UFhRTCtEUEpiSUp4cDYzRnlmaTkrYlk4c2lrdHBYTFRPWXFNT2VhZzR0dkJp?=
 =?utf-8?B?dkhsNFFtdDFwSXRQek9QL01wSU1Rd3NEa1U0T1Y3U3piK3RwUktDUGRpaEpz?=
 =?utf-8?B?SlVudU1VcUVwOGdTdTJmbEY3OEJ2U3FoOE8vU1NFdFhoY2hYMU5JcVFPWTZQ?=
 =?utf-8?B?UEM1MVpxbGlHaE5ZcTZ1V0dtREpkeVFrVms0dDd0WVFFa2U3Rzg4Sy9NMFpa?=
 =?utf-8?B?R2hhNFBtWFhDT3Z2YW4rMkpLc1YwWk53SUN6VVFDT1BuZjhvUXRhQXBjVERE?=
 =?utf-8?B?MjNiTlFhNmw1a1RkNTViMS9QYXhmWDFVaVk4SmxFV2s1dDByTC9yS3BJUis1?=
 =?utf-8?B?a3BNd3gvYWtUbUV1YTlHbUZTWU4wRzVmcGNjU2FNRER4bVBFNE9jdzIremlk?=
 =?utf-8?B?N2pEWTE5TWNSMVBrSkNPZkpWWjVyQkQzV2o0MEVWMFRGSDBqVm1NOFJValla?=
 =?utf-8?B?WHI5dHhjS2NOV0J4UmZXSy9oU0lla1JxcEJYM211WkJ0OTIvaVhVME5PWlBB?=
 =?utf-8?B?V1Jtc1VWbjJZVlJlNXk4REM3Z2pEZk9MMWhxemFKUU5TWFRlNDBiaFdHeGkv?=
 =?utf-8?B?d2VVUmpGV1F1WmcxVGJ6eVdTMTRvTG1lS1duZSthMW9FbGNuam0rOTNjUmhB?=
 =?utf-8?B?R1dOejlTUGI1MlhSUFQ0cGdsY1ltQ05lSHN6NXYyN3RwM2prRE51dWFkbG9u?=
 =?utf-8?B?WnlieExMV3VSQjY0NGNaeGExSmxrUXdmN0c4d1E0b3ZiemhTaTU3S3lZR05v?=
 =?utf-8?B?NXhTWlliVjZLVnhaWmpMTzFyZzQ0SGN1c3k3TmUxZk1GNXB5cENoTE92ZzJp?=
 =?utf-8?B?UmREaHd2czg3bitYSUdYYzVBRmRsMGdQN0pPUXlDM2hCTzFjdGVsMFBTTnRS?=
 =?utf-8?B?SlNDaGdhc2QrN1FkcnVVaVE3eDZyeE9URWp0NjA3LzF2VjgxTXNUT3ErVHNC?=
 =?utf-8?B?elBVeSsveE1wWkwxUVo4cWVtQ29sRU9PM3pwN2hrV0g4bmpUdjhJS0RIRGFQ?=
 =?utf-8?B?Y2tTYnM2bTRBcU1XZEJMVXEzby9rNXhkelRsRkVYWmgvKzNTTTBjdm14cWtR?=
 =?utf-8?B?SDVqUm5YV2d0NnYvZkw2YW04UHpxWEFSbXBKc0xaVytXL3kzUkFWbXBkVXJw?=
 =?utf-8?B?blJpWG5mVEdHQVpkeTRJazUxaHNUelBZWEdsUDg2UTVYNGpZYTk3SGw1UjVC?=
 =?utf-8?B?ZmwyUkZxdGpZTHBrTUVJTnluQjV1T0tydjErU1Zwc3ZaNTlOSkFteFplTW9V?=
 =?utf-8?B?aDF0bFZsZGNQdWNYOEFuazIxblZmK01QSHJmWUtoQzFiUkxsR1dJa3M3a0NO?=
 =?utf-8?B?RDdSZjJLekZObStiaTBhRTR3OExyaUJEMHp6NVZjSHhITGpHMXNINTFUeWln?=
 =?utf-8?B?a0pEaVJvMU03QUdkUmdWaEoxTGN6QUFTWGVDMHlSMkFsZ2VDS1hvN1docWE3?=
 =?utf-8?B?RTBITmFPVFZpRUFJUjRtQ1owYkhabnJVUGNJK1ZPNUgxeUd3aEJ3NmJtblpN?=
 =?utf-8?B?VnJpUzVkVjZZZFBjSytaWWRNUFJmZTMwU3dZZ3ZBRG9qejk1d1FaYm5ab0JZ?=
 =?utf-8?Q?0he7msuoSdwu5jwN93Z7W4tRc+5uKz3s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktyS3Z3WnplcjhGcG5vQVZ2QWxub0tDL0ZEYUdtRzA3RWtPNXQvd25iUytn?=
 =?utf-8?B?akhSNEprd2tteGZPVm02b2hQeHpmS28yWUhlZi9wOVV0aFhsRVB4U3RIdUVy?=
 =?utf-8?B?cFNzOTBtUTRjOCtWcFNvYVpKV2FCaitlN2hBZURXdzBhVU1Ec3RhdTlXQ0FU?=
 =?utf-8?B?a2tCREVrRGpaRERWU3lCUnVud0diRjJkVC8rcHA5OWhnUVYzWGRPV0U5eGp4?=
 =?utf-8?B?M3MxK0x2M2N1RU1RK3puODl5UFlUVm9pRlZWL01pQmYrL1hlc2xTWGQzVkZ6?=
 =?utf-8?B?dXVDQ3Q4ckoveU9pd1ZOTHcwU0RENjUvU1VEcnhVV25xakx4UVFtZEtXTGcz?=
 =?utf-8?B?TzdIOHMxQTE0YzBPcVR6TnV6RzJhTzZEMVh5cm1BNVBRbWpsMTRuR29XMjYw?=
 =?utf-8?B?dzVMbGJ5NE1TUEMzNFN1em0ydTdyM043WGJpM1IzakFNRXg5VnFtWVN6by9R?=
 =?utf-8?B?UzZYSHpPb2ZwZVhaVEV1NWZkZytsNmZVdmx5bW5jWmtZUS9tSzNRNnBQWEh6?=
 =?utf-8?B?am1KbFkyTHpkVFNteWppUDkwdk01TGdVNnl2K3hadlB3Tk1GWU1lSFVFaEFa?=
 =?utf-8?B?enp6bkUycXlMYUhQL05obEhHbzlWTjAybjlXak5tbmxhSXZiQnE4Q0QrZDMz?=
 =?utf-8?B?V043dnN5T2ErYSt2Z3JaUCtlYW9UVnRGbjMwY0tLV2JSV3o3Mi9UQ1kzejdU?=
 =?utf-8?B?MUg5SFBiRDhQaXJQV3ZnTDVsN01ndDhpL2dtdlFSTEI0R08vSFBhOUNZR0NZ?=
 =?utf-8?B?TUZQK1MxQ3k4ME4ySjNzem1MTHNHd0ZZbnlDOU1EdzM0T2NKQ29uSS85RlZu?=
 =?utf-8?B?NWZUa1RuSGtaRStEQktqWkhpaU9BZzZBOUtYaE1qdHBMQmZPRDVkS1Q1Nm9p?=
 =?utf-8?B?SUk2VFBJZEhaOE5Fd1F6eHVrY1NTM2xPSkdoaVNSVmQvOG5HZDJaQWp6TW1W?=
 =?utf-8?B?T0xVRUZYOTZ3M0V5VEtYYUEvaHlJUmNJQ1pWMTNTVUtjd2IxR3luejZza0sr?=
 =?utf-8?B?a2FNUnZBYklEcHJRYjhoRzcxZmpaMTVCdnpzcmp6Q1RxQVA3eW5WQ0RMYU14?=
 =?utf-8?B?Q1lVMHJhanJyMnEzZHdhSzE0bW9CZm92cldheSt0THFmNFBrN1BKMWkrNEpY?=
 =?utf-8?B?RXg3VkJ4dEVVczN6RjErS1FQZ1ZqSUkvdUFueHZUd3VsZkR3M3E3NjV0aVJk?=
 =?utf-8?B?cWx3K2lMMENyTzlERFVTZzB2aklneGw1ZGNNckViMjhZRTErMk5nellmaUVR?=
 =?utf-8?B?NThxQmladnpvVXRmamRsdmM0NGdGTDkyanJWQThJMXMyQjR1eURmWFg1Y0hs?=
 =?utf-8?B?VFg0UHVxWlBNRjZhOU1MalZ5RW1BSXNhdjl5V09OTTF0SDMyUUFsZXo2bEFm?=
 =?utf-8?B?ZFJXOWVaVHlpMmg3UWZ5UUtSQXJqR2hOMHY2Y2YxRjN0cTdHcjRZRitMMDcv?=
 =?utf-8?B?bmJHeDNMbzh4bWlRQitoMW8xbjh2aElQbTBtQlQ4NFJlMmEzTnYyb1FtWFdu?=
 =?utf-8?B?NkFPZVNpSkkrZW5IaC9xU0tvNWZ2d2JKVEtGUkRLb0FvdEFROUxGZFF5aVR1?=
 =?utf-8?B?WHo0YWZUNG5WV1g3TXpTZ2Y1OEJqZExXNGpZeVdjQkRsQ24xLy9mSjRsSjJ4?=
 =?utf-8?B?Wm95V2JtL25VOU1GQVJZR3J5WUpjUXh1ckxZSkJJRW8vYjJGaUZFTE1aNFFF?=
 =?utf-8?B?bjRtVkVXNGZnUm1uTXlUelI5WERnZE9xZ1E5bEhLYUFhTWJtVWVWanpQNGRJ?=
 =?utf-8?B?dnlxZ3htV3k2dmg1T29hSHJ4U0hvSStzTzhLeVBLUHB2NENmNER0ajBoL0tG?=
 =?utf-8?B?cXVha3Q4b3ZwUUFwZzIxcm5YSkxGQ2h2OHdtYzhXalpBMkgvTnlML1ZFM3RE?=
 =?utf-8?B?SmRvOUFsM25RNFFZMHRNSStaQnR6c2RWYlN3c0NBYkJieXpYN0VFTE5RTzFz?=
 =?utf-8?B?M2hLelFPNFJvR1ZuRXNZVWh0NUp2Z1ByOTlvZjJRTGhsMEFzNEt5VXM1bWpL?=
 =?utf-8?B?aUhLUmk4UDg1MXNodEVXN3dCVW9CSVV4VFhUSEd2WU5kQm5NUTFZU0poTGx1?=
 =?utf-8?B?NWFyMFA2ODdOR1I1NkRHcmlza2drdVlIYVNHYzQ2bFd3ek4rdWVBUzRMWk1n?=
 =?utf-8?B?RkRJOWV4SUI2THZQdGZWTDZuSGtiK24xeUMvdTV6ZlI3c0tPT04zZUdGendn?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0407cd46-a59f-4416-794d-08de3d5a4ead
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:52:01.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWgJ1Cz9TXiex8YGuhQIxDsc7wxiI8IN/XjiIKqPGRwPaNk/8NAcpVADCuR4cP6R3MeZReiAoATg5MAncur/c5q4ZaQv48ITumvlWIaaCbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

On 2025-12-16 8:18 AM, Oder Chiou wrote:
> Some devices are primarily described on another bus (e.g. I2C) but also
> have an additional SPI connection that serves as a transport for
> firmware loading. Export of_find_spi_controller_by_node() so drivers can
> obtain the SPI controller referenced by a DT phandle.

One nitpick below, otherwise looks good.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

> 
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>   drivers/spi/spi.c       |  3 ++-
>   include/linux/spi/spi.h | 11 +++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..ecb5281b04a2 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4771,7 +4771,7 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
>   }
>   
>   /* The spi controllers are not using spi_bus, so we find it with another way */
> -static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
> +struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
>   {
>   	struct device *dev;
>   
> @@ -4784,6 +4784,7 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
>   	/* Reference got in class_find_device */
>   	return container_of(dev, struct spi_controller, dev);
>   }
> +EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
>   
>   static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>   			 void *arg)
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cb2c2df31089..1eb04a96cc1c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -882,6 +882,17 @@ extern int devm_spi_register_controller(struct device *dev,
>   					struct spi_controller *ctlr);
>   extern void spi_unregister_controller(struct spi_controller *ctlr);
>   
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +extern struct spi_controller *of_find_spi_controller_by_node(
> +	struct device_node *node);
> +#else
> +static inline struct spi_controller *of_find_spi_controller_by_node(
> +	struct device_node *node)

For both declarations, just make them one-liners. Fits the limit, even 
for the inliner case:

static inline struct spi_controller 
*of_find_spi_controller_by_node(struct device_node *node)

> +{
> +	return NULL;
> +}
> +#endif
> +
>   #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SPI_MASTER)
>   extern struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
>   extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,


