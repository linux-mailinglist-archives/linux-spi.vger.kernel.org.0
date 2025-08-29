Return-Path: <linux-spi+bounces-9786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1902B3C439
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF322050C5
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F4220F2C;
	Fri, 29 Aug 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+z0VHAZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F5481B1;
	Fri, 29 Aug 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502411; cv=fail; b=K9wQCiKgrNtGWXT6xcrFf2aql1AALkKE0lU6EkfezCT5auN+DzY9gTe+2q+ZmSxPVZFbzIIHogMDFCeniW86thhgy2BGGX6WhmLJQgbxZvEZDxrXtzYSoNmaeGSaYFhdxArljcBaea9u7sIZtK7eeybTnZBcs+ysezcRMEYViBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502411; c=relaxed/simple;
	bh=nfb3cmzNHIX4310j+R9AWXcilVRf261Zt8Fni2wgV58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyJQx57ZoT59R3zpSFSH2OR40jV1sGiofrDDASjmIcNnYmtyvfj9WBKZVY6Xwf1oTpIg9UjTCDLS79gpQZPw0ZZKyFUzyom+8lCauTLQqopct6Il/wfxdz6mIHn9Di806/8clwCcTR/ygJQXY+2yBd2GF7XYrgr5771r8vewXAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+z0VHAZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756502411; x=1788038411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=nfb3cmzNHIX4310j+R9AWXcilVRf261Zt8Fni2wgV58=;
  b=k+z0VHAZOa+0eMoW7HqnLnML1TMU9oRiWCylP3WOmTBsdkuLfK0ltdQj
   k6kFsB6qAR9893h17O3mvfQD1/dknFDJIpdnlxpfJe8EjvCO17ZpCnElW
   5LkBb+RbGJmiWdePvS/43Q72MBLZRN3waXFH19xgXJwB7BItrp1aTJWw/
   UTyYAZPZCC3ojluR4ixxEYzOFO7rahDA9aaAfLs15Lw8QOLsBOOTqx19+
   PXLY2C5DDoWoAJGA48DUMR2qJvnuUR1ChCpwXyg4IHzEuzCBufJQ1ynrm
   5vbY+5mMf0mPMVuMQ29qDuksUP1C2bsQmAlMUDH/1PEztvmQsJlYZu77N
   w==;
X-CSE-ConnectionGUID: Rn/fZWR9TLymxEgs9UTarw==
X-CSE-MsgGUID: LuULA7GETfGExVL4yJGvFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58945490"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="58945490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:20:10 -0700
X-CSE-ConnectionGUID: LYJUBQ+ETne6bJyqhdw7Vg==
X-CSE-MsgGUID: BMHgfU/rQQay3qCmbfwhdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="194142104"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:20:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:20:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:20:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV5d7+f/2C1uEJ4jhJ3E+j5mXNj4udRnOt+npxJDbqR5reD86qZCXVn/6ov87YvgLrTig0VnxRAQql5gS9rsea+AsIUbEg1gqA5P+nEfsHBltft7XSf2YinaybIqSswy38xLH7acqSlc6TtVR6v+nNKD4+nIXu7xB0IEA8JDbb/WC7ZP85Y6Br+RNGmj1A9sw3GjDXuuswu67nzjegibZ+DZiNOOYR3rggRzxU8vc/4mrN2y8Pq0X6K8dX4fuGHnosVo+/2ELRiF7BCp/xYUvPtE45bzul+kY60x28YgnA1vAopUvUaQsAlFeKiZpsOi8BZtH3slydSmfLUwXlYOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKG9PKwYuFOPsHjCxquMdZK39ShVzSddLy/C7z1ao7s=;
 b=whIM6jTlhrtKPsoIvPwB7NFem2fib3zoVFH/6+fUtYgjWeluRsKuUz+72DjlzVlRO5Y+OsRbgDz0D9NPhGKhjw6vdLNZWxfs53Yp0uTVk3h1D6KnjKyOBbq+5kQ+L4QHpkU+jlzqqlumrKHwMuBt0lkOcZuRg2FaST4hXwtrz2Sy95S4lGjjUCW8NidflVVvhiF/3ELtyYhZBe4v+bZlvGFU1KP3E+mCWRZoqUqXYFIZpuvvsvUJ5+A6nXfM4cmUBNNp85/k6fPASXzoIDi2fG0PmqqOfkNmHFzYjrEwdRljCmdIUL2EHuQtdcv2AIBJuObPvyEPWEJiKD9kVJbwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 21:20:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:20:02 +0000
Message-ID: <9f01e881-f073-4c2b-b53a-667f09d76f07@intel.com>
Date: Fri, 29 Aug 2025 14:20:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3 net] microchip: lan865x: Fix LAN8651 autoloading
To: Stefan Wahren <wahrenst@gmx.net>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-spi@vger.kernel.org>, <netdev@vger.kernel.org>, <stable@kernel.org>
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-4-wahrenst@gmx.net>
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
In-Reply-To: <20250827115341.34608-4-wahrenst@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------85ZOXBtvmvVHKNNOrzYn2mBZ"
X-ClientProxiedBy: MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df94f63-d5b4-482f-2c80-08dde741d110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3dXOFdyM29ET0hycFNoemY1R3hLS05sd21SeDMyZ2FlemZxU0IwaG9ORG44?=
 =?utf-8?B?enV4eEJFTkc2Wm1KM1NhYTBRc2tNbjdweFZSNGduaTM0eWJkVm1jMTZWRUZi?=
 =?utf-8?B?dnRrd09pRGZJRkVBWmRGTEJXdDZYTHJEYVUzeU83eVNzZktYMkQrZWZYTVdG?=
 =?utf-8?B?NC9pblRiejdLb2F6TVN6WGZvUTRWQkFDenp3WFVMeTE0N3dLQzJHWUJEcXhE?=
 =?utf-8?B?cHlNa245d0xpZ056TURhZVVxdHFJTnB6c0E3eWRTNDhycHlUMkRuMktxbHpv?=
 =?utf-8?B?V1JFOFRsVzArWVlLa1ZKTUR0N3Rzc0s5MTBVODA5V0NFdEN4VTVNeVdId0k0?=
 =?utf-8?B?azhZUlA2QTYrQXI1QnBIVlpic240ODlLbytPL0VVOENibU1BMkVrSFowNFc2?=
 =?utf-8?B?c2ZqT21vYUZ3Mlk2aWJsNXhtRGVTeTRCU3JFRHRSWFlLK1VzMzZoWFJ6QmJr?=
 =?utf-8?B?bC9zTkNsa0svVEZzOEZ2OHVBOGIxekp6azNZaVI3Yi9zeVd1bS9pQ2p4RVB3?=
 =?utf-8?B?akEvWkxQZDRnQ2tWNUFCNTY2Y2wvTU9lTjF4MFVpQW1NQ2ZqRWFHRFNjSkY5?=
 =?utf-8?B?U2VBTlJ5TVFoTFQyUEp2Q3R6T09pNVdydTEvOVdZN3NrcFkwVUF4WkRCNm40?=
 =?utf-8?B?cGx1RkFEUW4yNmNNWE02WE9Rdko3Q3RXa3hNSTZBdExwbFRoWkg1YkNGT2hP?=
 =?utf-8?B?NGN4YlNVVm4xSVdpVXVXdjErWTloVDhWbExQUnYrdFhzVXVEK3hldW80azlU?=
 =?utf-8?B?V29lNGhkd0x5MnVLeTk3WmtuKzhZK2xiUWN6MTVFbWw0azVIeHlwOTNBdXhq?=
 =?utf-8?B?R2JpRnN1VFJENHdvWHQxTVNLZHVYYlhQUzRDTlFRSmxMeU5qL2VEOHZnNU9G?=
 =?utf-8?B?ZUhtZWdNN2ZjbSthdk5EMGlrUUtoRGl4N1EwKzRKbmtVbTdHbE1CUFNsRlA1?=
 =?utf-8?B?T0dzK3A1K09IVDBxa1pFU2k5Q2x6VU9tWWl2VjVHTE5BYi9mZ3ZNc0VxR3NT?=
 =?utf-8?B?WU5UQk1sc2tvRThDVUh6aUFSdUorMjZ5YXM3dlIzNitKTXhGWDVwKzFYZ1gx?=
 =?utf-8?B?RkpITWYvMnZLSHFpUUFyUzZEdVgwQlF2U1l6VkpiMjFjRHB3WkcvU21yT0ww?=
 =?utf-8?B?Y0N2YjZ2Y1IzUURlSS9ZSjdRMkZNOHJrMzdqcXNlM3p1Sk95dkN4MXZLK09v?=
 =?utf-8?B?dVczOEpkQnlqc3hyUGpxeDNFY21RQ1JxNG5tZ0JMV0p5MjNBUXRnMkluYTB4?=
 =?utf-8?B?WlFoek1OZStQbGpZNTdXKy93Z1p5Nnlrb2hTRlFvQ2RCUVBQdkxkWTVRWjRa?=
 =?utf-8?B?b2FWMkF5dzBwcnFZSHJ2d0xFVmJzTm1FcnU2MTFBUHJMWmVPUkhpUDdVRVpH?=
 =?utf-8?B?V2RsTlYrMkEwYlovRnp0T3Zzb3d6MUFBSlRRalk0L2JsQ2ZJWktIUXIrVkhw?=
 =?utf-8?B?bldXWWhDRDBlOVZzYmVvVWNlY21iL2lzNlp5eGk5TWM5Sy83VzhtYXIrc3RG?=
 =?utf-8?B?dThUcU1nVmRTSjUrM2FTR3pSSnppQVJOZHUwN3plVnNuKzVmaUdEQlg4TFFn?=
 =?utf-8?B?aG1WTTRLakhCT1l2MnUrcm00WUNSNDZzZm5hQ29sby91Qm05eEhpS3RMVDNN?=
 =?utf-8?B?R2Z6RmJzeTgvekxXRmJwdHFuQ2FZWkJWN09WNEVIcTN4NUpTamRMMy9wa2pH?=
 =?utf-8?B?dHg0WEw1VS9XbHlFV3paZFZuVWpHWWlZWTVYYlVOakxWNGZCazlLTGhMRFdS?=
 =?utf-8?B?QUw2amlKUXZjWGpyZExTMlh1dTZmd3JIbVVEZldDczJ1VmxVakhvZEp6eldt?=
 =?utf-8?B?bkpmbEFsckJYSHJRemxEUGtTL0JyWGVJSkRRL3Z6b0NqeUV6dFJxclYxRG5S?=
 =?utf-8?B?UWt6RWtDOHMwQzdxcU5BNTI5V1pKRG9LQzEzRXJDUWcyaG00aW9oUUxFc1pn?=
 =?utf-8?Q?TfxVtLbClXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtKb3FmTC9UUEFDMU02UW8weXRnZ0xuWDlIenhSdGUyMkFHREFvZE9BV2dW?=
 =?utf-8?B?NVI0SklqZUNlU2hKUFJFYmxVcm1PY1plVzZ6WnNJdnVKM21BeEpoSTNuT1Z0?=
 =?utf-8?B?N3RLOFo0a1J5K1RybHduaUFyd3Z3Z0JvVzJ0S296cXQ1UHZqeUtqaHd4Z21h?=
 =?utf-8?B?RXNxUUZaeitibDdUNG1aQzNJbTVRbm5pZGg5Q01USElzWjdmdTAxWG91aFZR?=
 =?utf-8?B?TFUycmMvZVg0K1lMaGpmVjRwZVIwd3M5am1rMmNycUlvQ0RVVHZjV0tETGUy?=
 =?utf-8?B?aituUk1YR0h0c2NqTWNWa1BSaEVLMWdNK1lqZGcxRkJPZVdlaXVmRUFsYURz?=
 =?utf-8?B?Q1E3bS9MSXEweFpLcDRjNTRjWS9TYU0vUG40MFJpMEpJcWo3cUU0b1Z2Q0lv?=
 =?utf-8?B?eW1GamxmQUxaUDdSVEpXK1RwbFFGSzVaeGFlRWRrTkhLVGVWOTJ5clczQzhN?=
 =?utf-8?B?MzVlRDBWK01IYVVxVndxR3MwMWlicWZ2dzhUYU9yb0ZMT0o0cGlsVzMzV25i?=
 =?utf-8?B?YzUyckhzWnN1Nk01ZGowRU9ZQ3BKTFdUZXU1TFdYSlR1RkszS0JZSzVRNHly?=
 =?utf-8?B?QnRZMUNJQmRGU28ycHp6RmFWU0NvOHlDeGlWWXQ5ZncvUWRBNkI5MGd3Y2d5?=
 =?utf-8?B?dXJjdzIraWJvS3Q2Uk51RlNwcGRWVlNlNVJ2V0lsejZ2UjNqOUtoRXdmQmor?=
 =?utf-8?B?YTdQV1NEMVlNWHY5cWhtTDdyaUs4VEZDVi9GY2pESjBSWmhDM1Erd2h0elps?=
 =?utf-8?B?OTM1US9xQnNXVkttbnhxS3dTZzF5bFkyUzBCNmJIYkdZVVdLbmVJOHljbXBJ?=
 =?utf-8?B?bGdTeURKS2ZCa3EwZnJBT2hPaVRWL1I1UHowcEdKK3MwV0RvbVM1cjNtWmt5?=
 =?utf-8?B?dGNCZVloMmZUQnM3NkxVMWcyV2pteGJwaDlBMmVHSndvSDZjMXVRUWljU202?=
 =?utf-8?B?M1BhSDZnV0lFNHRsQlhERW5wckt4VW9NSzVGeHJsWGtPdnB2dzZkZHRzQTI2?=
 =?utf-8?B?QkViZDA1L3lyelVjTmJTODF5bVFoNGo0YnhFd0ROWHdtcFFpUVMzVmdFZUhp?=
 =?utf-8?B?YTlyak9TUnZ0bFB6S1pyWityS3BhZFBCS00rRWx0Y25TSEE0U005b0NPUTg0?=
 =?utf-8?B?UGl4L0ZiRUNYTVFZQUhFVlNmWFU5ZlY3Uk5scklKbmtIZklveEJwUXFWQlps?=
 =?utf-8?B?cUFsREVrTnlJQ2ZQVVdGRGo2ZDNhWi9LTU0vYzMrVXZpeXNrazdrN0Zkb1Jk?=
 =?utf-8?B?WUVwTVlJUFMrelg0dXdjdlNEc3h3ZmNBZ0hacms1RStQQlByeEI5eksrb002?=
 =?utf-8?B?b1AzY2NraTViZnBzUEtqRnB4YW1RTVlNK3BSUDlTZG9SdXpsSi9hSnpJaS9y?=
 =?utf-8?B?SzdNejFDTGRPNUtxay9qeW1mWU50eDZZbHo5bXBHME9taUdTZ1RySUtNS2JY?=
 =?utf-8?B?VDVNbmE2TVV5VC9tbytWU3QwbVpVTGxMZWptb09jM2dVcDN3MmlIT05ONW1n?=
 =?utf-8?B?Q0kyZTdZbDFueVlsbnVNci9iazZadW42YmlhcFNTZ21CbmZnR3c3b2V4alhK?=
 =?utf-8?B?a1pXQnNuNVVscW9IS2txZmk1TUpJR2tjd1BIZlE4UE4zenhHeXltYXc5SjBr?=
 =?utf-8?B?ZmhNOU4wSFVYVzJuaXY5eVp4YjF5amRoZ0xSSEdpMmhNN3pESTNzYXlLaDV2?=
 =?utf-8?B?eVo5YkdlZGIzbG1TL3h6SHhoMml2Q2pjdExGL3VtNzlvN1lla1pqbUxxbE5w?=
 =?utf-8?B?b3ZrMjhLZHBwSGlsN1B3aVpLR2VaVlBvcmRxV2M2eUZXOHFicnV4aU4vYU9x?=
 =?utf-8?B?VXA5cWhvYS9xQTFnb2xwdTJ1eS8ydmRWT0NYRXFqckdlSXlkbktmazdacVRQ?=
 =?utf-8?B?YkhhbjlwRkVPOTk3WHFGekRUYzFxeU42TERNTlczcGZVSVEwandIQ3puUDFZ?=
 =?utf-8?B?R3JtMDhVNmtvUEs3RU1NNjNDOEt5dXh5NmQzOHZ2Y3RNQWpsajhjeUVtNkoy?=
 =?utf-8?B?dTNJcm1naHV0SFgxVTE2bFQ5N05mcGUrVEhnVXJpbFZCR1BPTDVCbFZBNW05?=
 =?utf-8?B?YmczZER2dzZVd1lmSXZRTmd5cVRXOFpIbVZOcnNIekQwbzMvV1g5SXJvMGRU?=
 =?utf-8?B?WkpiQ2E4MWRqTFFkWnZGRXEvVXMvUHdpNlVlZU42ZHp6bjd1bE5KeW9XclVD?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df94f63-d5b4-482f-2c80-08dde741d110
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:20:02.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMOP4F1YX9sHlVw1uAYs0dXI+KaDFRf0Ue784JzXxfwf+Ukn6n44jU5XL5U8C3lcMH05Z5HcZJHu0NezlHFBuVPBLt/gdtd6u6vIBQX5s/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

--------------85ZOXBtvmvVHKNNOrzYn2mBZ
Content-Type: multipart/mixed; boundary="------------513d5kV7jxK0Kf0VwQmqwXDd";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org, stable@kernel.org
Message-ID: <9f01e881-f073-4c2b-b53a-667f09d76f07@intel.com>
Subject: Re: [PATCH V2 3/3 net] microchip: lan865x: Fix LAN8651 autoloading
References: <20250827115341.34608-1-wahrenst@gmx.net>
 <20250827115341.34608-4-wahrenst@gmx.net>
In-Reply-To: <20250827115341.34608-4-wahrenst@gmx.net>

--------------513d5kV7jxK0Kf0VwQmqwXDd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/27/2025 4:53 AM, Stefan Wahren wrote:
> Add missing IDs for LAN8651 devices, which are also defined in the
> DT bindings.
>=20
> Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microc=
hip's LAN865X MAC-PHY")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Cc: stable@kernel.org
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/microchip/lan865x/lan865x.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers=
/net/ethernet/microchip/lan865x/lan865x.c
> index 9d94c8fb8b91..79b800d2b72c 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -425,12 +425,14 @@ static void lan865x_remove(struct spi_device *spi=
)
> =20
>  static const struct spi_device_id lan865x_ids[] =3D {
>  	{ .name =3D "lan8650" },
> +	{ .name =3D "lan8651" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, lan865x_ids);
> =20
>  static const struct of_device_id lan865x_dt_ids[] =3D {
>  	{ .compatible =3D "microchip,lan8650" },
> +	{ .compatible =3D "microchip,lan8651" },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lan865x_dt_ids);


--------------513d5kV7jxK0Kf0VwQmqwXDd--

--------------85ZOXBtvmvVHKNNOrzYn2mBZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIZgQUDAAAAAAAKCRBqll0+bw8o6Els
APsER3HaiujTsY2lkNaYpiV3IzpuFgRCPnZcO5oCOc0PgwD/e6dbsyoF9AmgA6sZ/BkKNqKeOiWI
b4+lc1I/ErIY6Q8=
=HNzs
-----END PGP SIGNATURE-----

--------------85ZOXBtvmvVHKNNOrzYn2mBZ--

