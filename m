Return-Path: <linux-spi+bounces-9785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B6B3C438
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0203B1CC1
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37332242D7C;
	Fri, 29 Aug 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCBVnnm9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332120B22;
	Fri, 29 Aug 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502381; cv=fail; b=oorqGNzGtsD3sLmzE+QEzmtemUapezBlHRhV6zh9IsYbccLcIH7vlnJAjtELwQRA+rQ0RbhFrBcme/hu2ADQWtht/OIcQKDDfuoMr5hEbOb6xU1MzcgCwnZTDcOkA1wE5BgedxH4OjIR/loO3Ki56jG5giWQj22q3rX61VeqlJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502381; c=relaxed/simple;
	bh=UvwSOraDsm5Pp/QRfrX4VtN0yLgjVtLppJlGvSoO1pc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cpeiJixKgyYN7ZINiZAIE3Ced3qufQ2qjklcDxvLWRW4vhHLh/Y+5XaaFBB8ZTLvskfq0tKW+gmPM2nhNWd/8uQi4p5mXW3zU3lmlPc37h9eXWo0r/GL9+KCa+zRw0ZJzeHsvZmfWs6RZI53AE+QpClTapx+kpaAWCPQpaeQvIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCBVnnm9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756502380; x=1788038380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=UvwSOraDsm5Pp/QRfrX4VtN0yLgjVtLppJlGvSoO1pc=;
  b=aCBVnnm9UAx23CZpk0eY5dtVzCJ8xWfjEHrx+xq308mCS1DMBUmmHCDJ
   XSCBVqVSZ6E9nKCXusA+UkVH1gf7/K31wnNLeCBhFW+mtFMWFM2kFgQ9t
   ePXcCvuMLJas/G01CyJ5VFLkM1kvtK5qBf/NuYcBryvQtb/tj2vv8ZIob
   yD8ZuNGhljRThrrVhUWk3SlfD3eHVOtgO/pud+XHYzgzNl+sS7LCzbtMz
   DVcLfm2FQSRHahU9BN3yaUE8Wu4jndccFdr8FoBHZOQ/pFITmP3lrCMZt
   CijW6t8SdMC0yZjhutGlUe/MEuew9BXfvjeFVVWh21owuhcm2kaMq+4YE
   A==;
X-CSE-ConnectionGUID: bxM2/AbZRHytmjERvsclMA==
X-CSE-MsgGUID: Pham2KzKTNOvPvgJeBsiTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62631523"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62631523"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:19:39 -0700
X-CSE-ConnectionGUID: ImiVp9chQDK+jV6eerey6g==
X-CSE-MsgGUID: 7Nx/b8GcQye6Wu+kFkQBKQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:19:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:19:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:19:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8YLFnTKdDShvxfpz2zjU1L0Sy4Hy2bv9cTQTvnlkn3wZxDTrXIQTEEjGSMUNu7OMQoZgXFXLvbNsWOtEHZXvjAanTXLruuOg6b3CgZtu0EWoQ4V1yiJaGQ5A0xkbz2qpcmAnrkujsoAFIDRrBI2QGTtEFe8dsItg3Fx1nvlg9lZP4sEi6R89pT1gH1p/vLlAUY+IULPXifvcMcJFHjieGJlutPt4towvZrkBaeIjVGigW/lnZAo9E8vaqaQtN17J9UyA5T+7oMol3ACbYDazZMSeFbli60Udsg4OrCBlOIcdBYcuLoTHUtEalEb+95rljXlDhrskaQENoUETsRrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7qXbYldnwvMc5IRLUevSPA/C9nWuurB7JGm/ojCWqA=;
 b=OBWv5fJnCNqRFPn95JFOLMth4v/qXmpFArhBVEGAvbPRDIyfYvf0/d98jW6oO1eV07ylGcspof7A7jfBYS085pJi3yPHVmqlah1bVKH6r9Dk1mwDfi0IIZrJ68wO5thskhfV7qGbJoCbJuW2ovNIsYsbG/0LRbqGm7ikKGlEXka5vCVDxHBtuHdpPWVmV2+fXauFd4LDdTj54O1hujnZvd+mRo8Co/BtsPy3v9qqUgj+0Mzpb2o0ex26eG+4HsOZot3gAa0aCRSiW+lT5WE2p03qA5JtgXOQL9xjPffWfYO2BfjwnwAuaVB2GnkBMSkyfDS2ZSEyfjcccn2lmkdAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 21:19:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:19:26 +0000
Message-ID: <5f3aacf4-5885-48b3-9af8-36208fb464a9@intel.com>
Date: Fri, 29 Aug 2025 14:19:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3 net] microchip: lan865x: Fix module autoloading
To: Stefan Wahren <wahrenst@gmx.net>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-spi@vger.kernel.org>, <netdev@vger.kernel.org>,
	<stable@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-3-wahrenst@gmx.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250827115341.34608-3-wahrenst@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------KKXqhr5kBdA3V71R8sy8NibS"
X-ClientProxiedBy: MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 70623b21-47d2-4bec-5c73-08dde741bb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3NxMnlNejZ4dTc0TkpFYjcrKzdJY1A3eStlQ2dweEdWTU1MTlVPOC9haVg5?=
 =?utf-8?B?RmVRMkNoWTVJeFkxM3NEVnY4QWRjamxyQXJUSVJMVGx6aWVobnBLWTV1c0VZ?=
 =?utf-8?B?SXdRZlRDU3VRaUVwNkp0Mnpla251VVVCaGx0N2dIR0hUWFlOTDlMNGRiVXdr?=
 =?utf-8?B?b056eVlDUXo5KzQ0Y2g4RW9jRGNVd2xnNjJEeGc0Q1o2WUkyU3dzOUlkcjVa?=
 =?utf-8?B?QWtwWWJ1M0lidzBmTzYyRUFnVlVJM2RIaVB2ejJSUnlLOFYrNHQ3cDlTOCtq?=
 =?utf-8?B?OFZuNGFTb2FPTWVFenJ6SkhySU05ZjZoTklYRDJlOEdBTnhmZ3N2UFIvdGIy?=
 =?utf-8?B?UzV1UHJNcHVJQ3ZyYjJUYUlsYjh4VHVyTTNoNExMbVF4UmdWVDR0Sy8xMWcx?=
 =?utf-8?B?Qm5pNnp4UUdKSnBlY0Y2dWYzMXhWVUNURmM3VG9rQ0xGL2swTGozNjdWRDEy?=
 =?utf-8?B?QjQ2aTZBZ0FZb3hFTGo2Wm1JV0VJd0VEcjR5WWVpVWRJaVU1ampOQVp3Y0tN?=
 =?utf-8?B?a2RsVWlGc1BncG1RUzhyaDBuY0s0UXZhemVQRU94N2IxbGtZM0JpUGpyT2l6?=
 =?utf-8?B?RUpDZUZHNWh2a1N1TDNaYjZrRjRlV1dROWYrV09ub2Z6VmZ3ZnN2emVoU3A2?=
 =?utf-8?B?QVBnditUK0RzZ01UU1JoU0M3MWJsbTVRYy9qODJTRm91RGJuQ2ViQWJtQUo5?=
 =?utf-8?B?bFVONFVvVFZtcnhlMklSRnRzSWhzYnp2ZDkzRFJpMGJTTWN2bndxa3p1NnVn?=
 =?utf-8?B?RFh1QlB2NTBkUWVxQUFaMzJ5cGhzWlBteEJzc2JOMURHM0txK3ZuS0FBdlFK?=
 =?utf-8?B?SzhLK2FlbWxvTnoreWZHVXVKZG1GWXlyZG1YbUFuWGNBKytXUEtNaEFFQW9X?=
 =?utf-8?B?OC9TUjV4clNSNnovWE1CNm43WkdRRFVla3NNZzFZaFh1eGJiWFpZZnY4cTFl?=
 =?utf-8?B?c0pveCtHb2hLMXZkUGRBR21ONHpLbUhjRml4cERrYTJkUUdkTWlSajl3NTJT?=
 =?utf-8?B?dXZkSVFlRk9uTElTOUtZZnZEUDFxeUJVZXA3QVdaTUUzdmpzZE1jblcxR1o3?=
 =?utf-8?B?K01uUVhDTnBWbHIyRyt6NFJEY3BiM0VEQ2tHcGNtNDRoMlBmVDhKVWR2VlJW?=
 =?utf-8?B?cm43bTJ0K3MxMGE1ZlJ2NVJjajBNVlhBak9mM25HWUJ4WmpEMWpQUE1MWWdq?=
 =?utf-8?B?N0krZ29QQkhxV2pqK2Q3eS9XQVNCTjR2a1dPR0dsS3RCVGNGT3lxQUlYRzlV?=
 =?utf-8?B?ajVCc09RY1pjSCtVRzdGSE9uL0RISXlOWE40dEVIc2FhM29FTk1uL1B2WkNW?=
 =?utf-8?B?d2c2Q0xDSXRJazh3QW9EaitDTXZoY3pmcUpEc00ydHMzSTkyMHpLQkJ6YnVj?=
 =?utf-8?B?dWVzcGFlZ0xqUmJIdm1MSk5adlZuZHdMRXlwdWJKbkluRnFSRTNTdWtSQ2c0?=
 =?utf-8?B?SnBsNXpFdVJ5WVcwSDF0TDFnS2hQQWdtUTUxNGV0VkxXckJmbUljL3FXVXJI?=
 =?utf-8?B?UWt3Q1FkZ25QcDlqR2NvMkptc2JYOXRhU1Eva25JTGx6bmFFUzV6RHFRbFl5?=
 =?utf-8?B?a2xIWGFkdm5sZG5pRHZWQ3dFanB1bjZWYWFmV1M5WkZMZlpvdE02cUVTalR2?=
 =?utf-8?B?THJiOXA1MzJacjV2YU9aeWZIOVZKQWVMZ2ZWUm5IS1dMWlIxYUdUNlFuRzUz?=
 =?utf-8?B?Y04wY25jOWtBbjYxRlcwM043elVpZ2UzUExzWFRxTWJLVCtDd0IxZHJncW5M?=
 =?utf-8?B?dE1jUFFucDk1ZjFzOTBxa0dXK2xUUWp1cFdnOU01d3hyaUZra1VKVmZ5UzE1?=
 =?utf-8?B?ZHFteHN5VHNzVTRwRUxWLzlVQndCQnZaMHFRdkZ0akQ4d3Jaa0JJeGhURWF1?=
 =?utf-8?B?RGlWTTZNZHJNOElnMjZIbDd6L0hkUTd6L2YwdkcraWo1K09McHhqSlp4ekhF?=
 =?utf-8?Q?heibUOMklpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtLUDVFOVhlN0JHb2xTd1lHaEl0cm1Qa3ZSN0wydGR2ZG01NEN1VWhPM2Ja?=
 =?utf-8?B?SUlyTDFhakZVc2J4WWtMSkt2WlMvb0s0QmpvYjV0eHBxZ2I4RHkvNVBoVjNK?=
 =?utf-8?B?YUlBYTJqUGFkSFJSWXMwRGpqSUVvNFh0d2xnMzlOMTVBSU1wWkE0TDIxOVRQ?=
 =?utf-8?B?WkxSaHl4QWRqV3lEUFFvbFdIdkhZM1Z5bU5SR3VVVTdTblVzNlpDSHg4N0tP?=
 =?utf-8?B?YkcwL2h2c3czdnZWTG9RczNVMzhtYlZVYjlFMWZScEl1YXg5MW5nSHhkcFNT?=
 =?utf-8?B?L3pmdmQ2TzF5YVFCdnhoY0ZIbVA5ZGFpbUxVSTdFZmRxMGRzb0Z6UnRaWjVE?=
 =?utf-8?B?Y0lvZ0tPN1ZnNUtvLy80OE9wUE5MUGdNckdPL1QyMTRRSHhZNytLSWV6cFZV?=
 =?utf-8?B?R0l1NSs1QURwRkM4a2tYNmM2OWJsTzBTbUdDSUs2alQzMnQ0eExkcDVKYlhN?=
 =?utf-8?B?aWdiWFVXbmZ6d3I2dzJoWVMrTEoyZnYxam1rZ0hHeW83MjA2Nkp0OENCUDFx?=
 =?utf-8?B?UlJXZERMbWY4WldlUkgzM040OXVQV0kzSnVQeHc1NWhzeEY5NDM5TkQ2aXJI?=
 =?utf-8?B?UGlHbVB5R3NoWlA2QVpPNzZSaEIrOEUvcEtCc3ZPdE1zc01lWHNGR0kxSkRO?=
 =?utf-8?B?bVd5UnBIYmtVcnNlSWVLUFJhd2wzUGhMQklwbFBCUFpjS01vV0lzUW5UM3BL?=
 =?utf-8?B?eWVaTVplT1gvQzlZYVJjQ3A0S3FzWjNSM2RIVHdGRGNGdmRKam44N2Fzc0lm?=
 =?utf-8?B?K2VXQS9DOFk3VERQY3Q1Zi92bFFhOXhVRnJGNHZDdkQwdmFtRW9oNEhjaEl5?=
 =?utf-8?B?aSszdE14MUZ4VGNLVndNNTRZcXNOcVNJdjRGUE9mR3RrMXl3cHRyOW1PUDI1?=
 =?utf-8?B?Q1k3SVZWVzVzWk9uaGdGMVJtZ2dnUjdZeE5kcDJwTWN2SWpmZnRlb0N5UVBZ?=
 =?utf-8?B?dHZKVFZpbWdyZjMzSldiaHg0VmppVVJqVTYrUmQ1UmRYV3U5aE9JWUk5TzZ1?=
 =?utf-8?B?Mm4wemhzbXlWaXYra0RwajVYRzVTenhGN2VRZ1lKOVhTTFJsTEtiNW9lWWo2?=
 =?utf-8?B?akJ4Y0thZXFCSWF2eE1DRmdtdEc4Z3NxbzR0MkoySWQ5Y3lLOGJxMVVkc3pl?=
 =?utf-8?B?T3lIL1hiYkdERWZOeks1eHQwQnpDUEY3MExQUFY0SVg3UlNLQktaay9DWVlR?=
 =?utf-8?B?eHFUUnRxMWtFa2IvSmtVVzlSRDJQdzFFY2ZyRXNKNHBDanp4b01mZXByVXhK?=
 =?utf-8?B?Z3d6TXdhYzBnRjhXanRxVHUzclNWOFlzeTdJRS9xNVZFM3VCOHhIWEI5UDcz?=
 =?utf-8?B?OXkvamJqVGg2VEdkdlhWTXJsT1lpcmVGbkdTUEhhNjNGOENNL1B2STN4QlVh?=
 =?utf-8?B?Rm8zZUpxSHhDSmZHOUF0ZTBmcVVMY01hWGMxWmJjU2RneUk2VWtXZDNGYXdi?=
 =?utf-8?B?K2trVkVBbkYyekM0RXRPclVhdVV6cFFSUERnQzh6YktpdllZeDQxMEtEa2tO?=
 =?utf-8?B?MkJuQnRtK0Erc09EMDh1bnB0amh4RWdOVFJPb2JTK0FIMGQxM200N2VEN003?=
 =?utf-8?B?VXRrSmZzWWFPaDlmZlZZeWpXODhmNXNPa3lOUlYxNTZIdTR4VkwzRzZiVVpq?=
 =?utf-8?B?eklJcjQvQUVnTkdQbUZUbVpnZis2N0ZhWTAzTGNDZExZdG81dy9EQ1N6WlhK?=
 =?utf-8?B?dzd4WHZEdW9PRzBHT0ZzZTZxUExpd2hscWNtZ1B1SlhpZFhDdWdEeTJ6NHNG?=
 =?utf-8?B?Q0tQaXQ1djAweWdvcDkzbVdXdytIbXVRK3dXRkZEeFJMRzlhVHRrempDZXNz?=
 =?utf-8?B?MWh6MlUrQ29ZZEw3Q3JOamp5M1pqT1QvOXdNZGE5RTJVRnhYK1lMN21WWFFa?=
 =?utf-8?B?YnhHRnV5RHlNMjFLVkNUZURuRGRpT040Y21UV0V3Ymx5WmxLOVlWOFZIVWZK?=
 =?utf-8?B?WXFzL3F0QmhwS2ZZVzdUY1M1WWtoRzZxajBrSzlNOFBtb2JuMldMYXRLVXor?=
 =?utf-8?B?aWxLQ0hZNkdBa2RQSFNET2cxeWhIQWdRRFA0N1pnTkFwVWdJTlBuN0hmdEVz?=
 =?utf-8?B?SE9rV3czWVZwQkpQbVJ6L2VjRjJmSzlIZXE5SEE4STJQZkNjR2FMM1RiNzNq?=
 =?utf-8?B?UmcvS1QrSnk5c245OVUxZWVyZTUzTE5mclhzM2YwNjhQMTdZaVFkUDVSOW1k?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70623b21-47d2-4bec-5c73-08dde741bb5c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:19:26.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRoN483SYdR4oHSWY52SA9fV4CpkDYUUBJeqHEI76h/+eGUePvPi7NvgMNFEJYBlbDxdqppHFlaiWQRL9dPh8L9i4EX7SEomtmCroI8zkac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

--------------KKXqhr5kBdA3V71R8sy8NibS
Content-Type: multipart/mixed; boundary="------------jeVzhWVvqxuksfIHGBxQw7WY";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org, stable@kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Message-ID: <5f3aacf4-5885-48b3-9af8-36208fb464a9@intel.com>
Subject: Re: [PATCH V2 2/3 net] microchip: lan865x: Fix module autoloading
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-3-wahrenst@gmx.net>
In-Reply-To: <20250827115341.34608-3-wahrenst@gmx.net>

--------------jeVzhWVvqxuksfIHGBxQw7WY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/27/2025 4:53 AM, Stefan Wahren wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from spi_device_id table. While at this, fix
> the misleading variable name (spidev is unrelated to this driver).
>=20

spidev likely is just someone short-handing the spi_device_id. Makes
sense to call this by the driver name.

> Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microc=
hip's LAN865X MAC-PHY")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Cc: stable@kernel.org
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/microchip/lan865x/lan865x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers=
/net/ethernet/microchip/lan865x/lan865x.c
> index 84c41f193561..9d94c8fb8b91 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -423,10 +423,11 @@ static void lan865x_remove(struct spi_device *spi=
)
>  	free_netdev(priv->netdev);
>  }
> =20
> -static const struct spi_device_id spidev_spi_ids[] =3D {
> +static const struct spi_device_id lan865x_ids[] =3D {
>  	{ .name =3D "lan8650" },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(spi, lan865x_ids);

Right. Without MODULE_DEVICE_TABLE, the tables used by userspace won't
populate with this driver. That results in failure to automatically load
the module.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> =20
>  static const struct of_device_id lan865x_dt_ids[] =3D {
>  	{ .compatible =3D "microchip,lan8650" },
> @@ -441,7 +442,7 @@ static struct spi_driver lan865x_driver =3D {
>  	 },
>  	.probe =3D lan865x_probe,
>  	.remove =3D lan865x_remove,
> -	.id_table =3D spidev_spi_ids,
> +	.id_table =3D lan865x_ids,
>  };
>  module_spi_driver(lan865x_driver);
> =20


--------------jeVzhWVvqxuksfIHGBxQw7WY--

--------------KKXqhr5kBdA3V71R8sy8NibS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIZXAUDAAAAAAAKCRBqll0+bw8o6Oth
AP9oElvafSUM+KrIpLE+BaEatZumk1LG384dAYog7YRfXAD9Eu6MvgluZiBHg7jUJBdKT5jQm4vQ
xnQuWNJnnOXQeQM=
=2+2y
-----END PGP SIGNATURE-----

--------------KKXqhr5kBdA3V71R8sy8NibS--

