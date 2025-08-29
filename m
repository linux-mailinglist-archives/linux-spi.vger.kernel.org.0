Return-Path: <linux-spi+bounces-9784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB6B3C42E
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 23:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E837A5689
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F8481B1;
	Fri, 29 Aug 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzG0a1YQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A520189BB0;
	Fri, 29 Aug 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502133; cv=fail; b=MfIkkj3F9kR5Uh90UarEXnU84CSgVeIZBTRdapu+lwydxRX/2c2ZqhToqFr5pQIDidv7yrFibmC5JSitaVUc6uQmBupoVjZ0rmJvSTA2ErpRIY4D7NO7XkNMLHymGKMIjDQ7aAr+UDN+5c5R6G+Gk4sn7CGVf/rGkfPuG5GD0Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502133; c=relaxed/simple;
	bh=WVe9jt6cuVAj3XnX+QIq1KqJSoVJ2aesBtfGrdoBP+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUwdneFmnTnMEs+VKktSOQs0cANGS0JrFdGcRPJ5jimif4dL8bJNLIlHW6lvVSwb+qKsIf3oRFF4lvUeI1ZUjBZbxLTKWlJpOU9w/XcvabilHwyaXAqSZCLyZnklt8L/9M5KQ1H1ws8xNhykEYC0ko4ObHqRmEj9nnn3y+ymtTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzG0a1YQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756502133; x=1788038133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=WVe9jt6cuVAj3XnX+QIq1KqJSoVJ2aesBtfGrdoBP+E=;
  b=LzG0a1YQv+bYTIqA3zehQXG2EWD2aXFjwnGytRRRfYi3uZphm1F4O4el
   aO27oo8ZQPka+6qQ9PZorGjJTnOA/AdxqjE9oPKATIls5m+25T+15Z0RZ
   oz+BbaBEO1Jo8KNSp8MpDKfLDbyNmJXSNPjHQhNQVcmKg/0kGAqmwVze4
   iJjG07zWee9zQQu7uk8NypY8k+qmxzk3KXEDePOcwVphl2Ztcav4iDkiK
   /ATwHJpCaCIWVbK0Q/gD7cJZUP+vC8cVWkMWAUu9BZTRbemqXKf6+Gfos
   ML9ahFEpASiJH2nFiwSgndWMgYcSh3N+LgDd7dpOSiLbQu4drYsIs6Noo
   g==;
X-CSE-ConnectionGUID: OHxukYh5Rk+iwRLXIO0qtQ==
X-CSE-MsgGUID: AVleUct4RcuwHuKK9gEW1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69070017"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="69070017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:15:32 -0700
X-CSE-ConnectionGUID: nEsEAnJRSUaVi/cI/B849Q==
X-CSE-MsgGUID: MTiE2RtVTq+mC4EMs0RGYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="170381930"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:15:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:15:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:15:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVA/VEHa3kffObSmXvZk9xdFC0VnVXueIUWcitTLDf7GCYAylJKFc7ob9l9RyvKWLPZGDc52XuemH1nclROCVNKlGk6ECEoJ2jotnw/HB61eERcwmRIVXFqrqq9Rnu9qcxCyG9zfa1GPsHAGFyBZM+nbkn9VuAQbxtuMsTCypinLeN6fIPy8qcDuqw+r9HuUGYL0zqekh6ZxR1KytGpBKuLRaC9E0mId+zhM/1VzYLZuYwQ9m2NUZPw1pwExIjxWdVeElUc7ZUmkaRszmGRUwi2slmXmtCcn97uw4ZRBzws6mmHEBpuWWDJN8/r6/yLhBG570WJ254pxpM8Dtra1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8uFqlXwlA3pGsDb/ryG94yuKLj63aFSobdyKaptvik=;
 b=wbwUit/KSLhClbPSqVNV8jU9rNog6dyZYokRAoCH0T3YMjKT1LdgesvZDG7ax2yrvidAMrSbfR5A2Uz2tzkzrlUDmOgHNFDdR9wxlh7B2cNo9zSmgXYk8WO4JpXo4NQNZdmtcbT8bGHlaHAQIS/Wn7MGNMm4azpSMhv9N+///6mqFhg8BST5hB+Hr/0TT5BodT55Q0EPPk5WzlGSe2eE30I1fxjd+PhdU1aJXq33atFWS5zhiwdnDxmoBgMuv0kn4Fao6wZNDWCw3m5IEgXjtjfU+kWm03rybG9BgLn8wiUTNwMiSjnQlnQjc1cFhVhHahCkiRS9H1RDQjhPSA75WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 21:15:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:15:27 +0000
Message-ID: <fe740e46-6cd2-4a54-9802-0ec771ecb213@intel.com>
Date: Fri, 29 Aug 2025 14:15:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3 net] net: ethernet: oa_tc6: Handle failure of
 spi_setup
To: Stefan Wahren <wahrenst@gmx.net>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-spi@vger.kernel.org>, <netdev@vger.kernel.org>,
	<stable@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-2-wahrenst@gmx.net>
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
In-Reply-To: <20250827115341.34608-2-wahrenst@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------j7WgDEV4W5nsZ1bioj3bKxPo"
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b13da8d-d440-4033-70f1-08dde7412d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBOQ24vb1lGa25RRVMxRlJiTzVIaGx0WTRrSkx1UjNrK2Y2ekxUWmdlZ3ho?=
 =?utf-8?B?eURTTTJldzBaYjBlMDVMZjNmZ0J2Sm13TlRNL1A3V0MrbEtqMW1xMmlmdnN6?=
 =?utf-8?B?RkwzNUtJK0JqMzdmaGVLdGFLcVNhbWU2N200dFhneXdwSzlyZjg5QWxicUlx?=
 =?utf-8?B?L3JOcmhEK3ZxOTJnb2ZYN3lBS1dWcmU1LzJLdXVYMXhZVmdtRTE5NzhMVUNn?=
 =?utf-8?B?elF6MjRqK2ExTnI5YnVPdnlsWGkwQ2dlOVBWRmxLWWhYZTd1VDRMUXJkN2tv?=
 =?utf-8?B?NU1vb1VHZWdUd0YrZEQ0SXNyY3Zydk5jdGR0WEhRMHhlY2RxVmlYS1pvU0JT?=
 =?utf-8?B?SnRSdjl6azRwb3BLZnlkQnlveDJKazEybTZ5N2hyMkVxaSs3emVCVGJDUE8y?=
 =?utf-8?B?U1FHZUtHbTRHWk4zUUJaQ1kxdHV4ayt4Q3BwMnlyZTNLb242VUhaSHA2Q3JI?=
 =?utf-8?B?MHlWWWowMVd1ZjJrTzNrTWE3MWVhWk0wVDFzeTVzS1Vub3hXNUEzZlkwb0xE?=
 =?utf-8?B?TmtrL0lqOHMrVTJGMUp2QXZEUS9WQi80NjVxTk1zYllTUzV0R3BCWXZXZnc0?=
 =?utf-8?B?Wmk1YkVuRytTb25iVnMxWXVjUElqaGZCeDhZZFhGK0lFNnJGZ2NQM2hWaVgw?=
 =?utf-8?B?NTM5M0dPcDlDZWk3TjRWdHVJMkhjZnpOUS9RZyt2TGN3dHlPMGMwNnh5R0Iz?=
 =?utf-8?B?SUFqaGNZU2hBV3pMSmhrMS9HZ2NFcU93WXJiV0NWSnNPcEtlb1VlaUxzSVlr?=
 =?utf-8?B?TlVxLzNBNk45ZWZ2Q3IvRHRwZzdlVDU2QnFPRmhnZElJYnZ0STFmem5BaFhn?=
 =?utf-8?B?c0RSVzJxdXlXTFRTaUVWV1JXWUZqMlArRGZNbmpoQitCOXd3UnhXMFBWdEpR?=
 =?utf-8?B?K1d3NVFvcU9RdVdpd0tFcnNjVVd5UGFLYndoSm1VRC9XTzd4YXpJNm9GL0tK?=
 =?utf-8?B?NVJDVmgxc3F5dUkyZzFRS3JwZ3BKZjQ4cElqeWhTWDAzckNmZFBuUTRKcmRh?=
 =?utf-8?B?Y3c1dVM2MDFYcXRzRHNrNE54ZVJKUURmdmxvaWdETytET0JnQTRsTkRFTE9n?=
 =?utf-8?B?VFNNVk5ia3RtYUo4eG5QU2hzckRyZkl5UDgzZ29aRjlLT2xzcklReVczWjJJ?=
 =?utf-8?B?OGlkTnZGT0RINU5Dc1dGbWtxMERNVXFqaTZZRmFQRTNCLzM1Y09oV2ZGLzFO?=
 =?utf-8?B?Ym5qMWZBOWVJbW41UG5EcVZrcGFFUmZXdFpWYUEzNWVIVGpGMXZ4QXNzMWgy?=
 =?utf-8?B?U0V0V2cvV3M2RzA1WjhzTHNDL29NTGhkOUYwNEtFM3R2cENSOUZReTVIczVU?=
 =?utf-8?B?eC9rVFRTbXNzeks0aVljYVN1ejZtZ3lEcjhnUXZRU2duUGR2RVRPbXN4bC82?=
 =?utf-8?B?cGIxc0VLYlkxR2VXRHdzR3FDcHkwRUlpSjJDdEJQNjkvczJFTFU3bzVlZEc0?=
 =?utf-8?B?ejB0RzJZcjUyMG9qdmRCMUJnd25rWGsxWTRJeW9sTFJSd1RJUERPeWpTeFI3?=
 =?utf-8?B?aG1jalphclM4RUd1QzM0ZmpLUHlUaGtMcWdIUnlaZkd5aG00cVowK3JMbHZj?=
 =?utf-8?B?WHBuZGRXdHhUTlgzMFRud05SQm9nbkxmc2EzMkxGM25LaWpVcGtTRm9JUXEx?=
 =?utf-8?B?a2RvMTc3VFBhSTRkZ2duVk93T1pqUCtJWnE2RDVTRVlIcFpWNGJoOFdSN3Bi?=
 =?utf-8?B?Z3gvYTU5VGoxRzBkSVhDaCsvbEJOZmNHQkhYZTNRUjIxMEJOTGJpVElTN1Nz?=
 =?utf-8?B?ZU9aRWsvYWY1eTdwRkdrdEdvUWJvVi8rMklTd0dNUzg0dzM3Tjc1OXNCalI4?=
 =?utf-8?B?M3VZY08rM2VMOTU1MWtVQVI0cVJHM1lRM1VTYS9BMEpKb1FBanFibmtXRzRE?=
 =?utf-8?B?NWx0QWxBbEhOUTNDQThuZnVtazBnZGcyeEY5SlFvUCtmSnBIenVURmVZWEZI?=
 =?utf-8?Q?KTOMR6mBiUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZVamYwQ3FRNUJhRGxxbW1tMkluRWUzWkhDcyt0WW1kMlNQQmUwNnZNWUFH?=
 =?utf-8?B?U0NMNFdrMU9MVVphYnJXczl6K0QwUk80WWFERjhUMGZKOUZmNDBFOU54bVhy?=
 =?utf-8?B?M3FsazZUV2dlaS9lVzQyc2ZCYjhYU0d1Qmc5bXl6NUczZmQ2cE5VUEdFQnBE?=
 =?utf-8?B?Q05kU1ptNWZaYlRSTmZpbytKWFNTcWVKWm0xeWJGcEhZTWRMelBvcjdBeTg5?=
 =?utf-8?B?UndTY2Fxb0tEUjVvcWJ5NDdpS05hWTJMd3FOM0NWcVhvbjFSVW92Ync1Q2sz?=
 =?utf-8?B?R05jV2o5R0g1U1ZXcHNtSmhZN0tuY25SYmxBeGU5a09NSVdBSzFnWUtqa1pH?=
 =?utf-8?B?b3JlRkhIRWxCK2lqVStOVkdZRnRKaHk1NjNCaUVPeC9lbnN4bzBQdzlOY08x?=
 =?utf-8?B?R0NTTkdzbzlrM1RuRGVVOEY0QlVoM1o5eW0wL21NRXR5RDhuMUJTdFlGREdn?=
 =?utf-8?B?M2wxdUppbG5Gb0hudkJxWVVkQ2RkZGZ6RVRNdVdXUVVPSmJlTmNqT0JBYW9J?=
 =?utf-8?B?UUp1V0Vkd1pKTVpHeWZwUW84WE9pY0NaeGIrQlNDSFZsdHJPdXMzS0xVYkI3?=
 =?utf-8?B?YUJBb1FHTy96RXVUMm80Skk1cURYdHdtd0QyMzNHS2lzNUVZQlV6bVlQNmk4?=
 =?utf-8?B?QkFGMDJNbHczeVVPU21oaHNGbTFDQ1Z3WWV1dGhOMEliZ3JJbkxtVUpuZDBD?=
 =?utf-8?B?ZUFDVUQ0RzNERjFhckxDSW9ISVYwdFJucTg2bWMvcG5wWVN0TC9VSWgrV05y?=
 =?utf-8?B?eVpOd2ZsaWRsYU9mK3NEd1RFb0xUZTUxQlZSZFlTOUo2KytkNnhXYy9aTmxZ?=
 =?utf-8?B?amI5WEhtQ0hyby83LytWc2wzYkR3MHp5SDVkRS9hRlVqOGcxVzd5ZnlHU1FX?=
 =?utf-8?B?SmhEeHN5aDR5dm9FblFIZm00djBhRXlXU1VCMVV6WDI1cGR6TVdjMmlYV2Jt?=
 =?utf-8?B?eEg4WkdzbkNZQWRmaXQ3cFRYWVc2R2dLejBkRFhXM2VTTU1PLzMybzhkM0lL?=
 =?utf-8?B?WkdrcDZVVTJhNUlXYXBURlVtcEFvb1V3ZTJhVit5RHNzK013a1hwR0g1d2NC?=
 =?utf-8?B?MVF0Y05kazR1YVZ1N3J4ODhUU2pzRWxVVjQ0ZWlSTXMrQzljMk5wMjRMczFv?=
 =?utf-8?B?Z2R5RkdUWGRsNmM4K1lpZitZZjJsRTJmRTFreHlyeGIzQ3h5ZzEvRFkxN1pu?=
 =?utf-8?B?eWtxNFRWenBTanJ6WS81YmNHTHM4cjlmOCt3cEYwREpVL0cxc00xWVE4cVhY?=
 =?utf-8?B?aHk0RTNSVEtIMVY4UWVJU3Q1UlZ0dVNGR0IvUnUyblBLNUhYaExmU2VLVW85?=
 =?utf-8?B?cnJieGtzOVZGUTcrTEZQbjBoeHJXWnRycG1iZm5jUURzYnI3Ukg3a3R2QVRT?=
 =?utf-8?B?Q2lCSEVXMGVyTmJoYUZBU0Y0ZVVhUFp0Q0xqWHhXOGQ5bGxtUVJqK2loNGFK?=
 =?utf-8?B?OFZGVTA5cGVsZkx5R1gvdTYvcUR3N3Z6aFhaNUU3L3BuUnQxQm51VmRjMlhs?=
 =?utf-8?B?cmlmNGtBVCtieEppelI4VTJnck83Nm1zVXNsSXMyaFJZSkZ6UWo4R3F2MjUx?=
 =?utf-8?B?ZHdkVnhtcXNpZkp2QVBndmhQUzFDR0FSdmlWeGRxRDVBYWlLZUZYT1dURGxq?=
 =?utf-8?B?bFpLQ1BEWWNKWTUvYmlDYlB1Z2R4M0lwNXBacEcwMkhVb2dFRVpMdTRCQ0pv?=
 =?utf-8?B?eG1aVXBFZjNJTDBua3MwampaclVQaWZEeUp0UlpXSzdEUnMxbVlmRGd1ZWNk?=
 =?utf-8?B?YlE1SGljK05qZzRicHowc1dmSFFNbUtqbFJmdTNWTzIzcVowdmdOaG5iczJi?=
 =?utf-8?B?NjAwQytJYVlqeHlibVZVQVdPTXdvR0FKeFFLeFZRVGE5aEtBSzNiMFVwUjlo?=
 =?utf-8?B?cFNPdWJYODhKVzJmQkhVUjhNSklaMFVDalh0UWVGMGNoWWQ2cDBuYzRRVFdI?=
 =?utf-8?B?S2dLbkxGaUlsYmhhdFhTRjJ0SjNZNUlTTnM3QkpDbnJPeGhyYzdlT0ZzMUhF?=
 =?utf-8?B?OEtQUFg3SllpRlBRT0Z3bVo3L1NMYlBRZFBjb3gvMURjLzFhcVozdWdpR0xD?=
 =?utf-8?B?ZEJrVnF2U0xtSFk0UzlKWncwWVpMcWtjWEdkUVdXWFI3MVp6c2hYQUpydkp4?=
 =?utf-8?B?SmV4UlFiWXJ5NXJML2RVMUdkRyswQ3U4UG9RYXBjdkpZOHJSOCtaQ3lzUnQy?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b13da8d-d440-4033-70f1-08dde7412d68
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:15:27.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3O6pjqcYFceSgFPr28Ta2HK1JucLRbxo7Utrl/DEMwmiAgP+2GaxTO3vu0iN3Qbm37v1a5b/dbsei2swLiaaDnHWkYgPO5HRijBYh12Yfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com

--------------j7WgDEV4W5nsZ1bioj3bKxPo
Content-Type: multipart/mixed; boundary="------------bEONn0DNu2nUF63pOsHbaIM2";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org, stable@kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Message-ID: <fe740e46-6cd2-4a54-9802-0ec771ecb213@intel.com>
Subject: Re: [PATCH V2 1/3 net] net: ethernet: oa_tc6: Handle failure of
 spi_setup
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-2-wahrenst@gmx.net>
In-Reply-To: <20250827115341.34608-2-wahrenst@gmx.net>

--------------bEONn0DNu2nUF63pOsHbaIM2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/27/2025 4:53 AM, Stefan Wahren wrote:
> There is no guarantee that spi_setup succeed, so properly handle
> the error case.
>=20
> Fixes: aa58bec064ab ("net: ethernet: oa_tc6: implement register write o=
peration")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Cc: stable@kernel.org
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/oa_tc6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc=
6.c
> index db200e4ec284..91a906a7918a 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -1249,7 +1249,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi=
, struct net_device *netdev)
> =20
>  	/* Set the SPI controller to pump at realtime priority */
>  	tc6->spi->rt =3D true;
> -	spi_setup(tc6->spi);
> +	if (spi_setup(tc6->spi) < 0)
> +		return NULL;
> =20

Was thinking this could maybe be a pointer error, but the rest of the
function only returns NULL, and that means callers aren't prepped to
handle such error pointers. Ok.

I would note that many of the other errors flows come with some logging
to indicate what failed, but I don't think thats critical for this fix.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	tc6->spi_ctrl_tx_buf =3D devm_kzalloc(&tc6->spi->dev,
>  					    OA_TC6_CTRL_SPI_BUF_SIZE,


--------------bEONn0DNu2nUF63pOsHbaIM2--

--------------j7WgDEV4W5nsZ1bioj3bKxPo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIYbgUDAAAAAAAKCRBqll0+bw8o6LOI
AP409S12A6qT9+12ORL78sWJFZEwoL/LANSSVGXUCUWIDAEA3m27IUz03KIxENgL6dFwFJXRNzxd
rcfF7cqYvItG8wc=
=jF2O
-----END PGP SIGNATURE-----

--------------j7WgDEV4W5nsZ1bioj3bKxPo--

