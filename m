Return-Path: <linux-spi+bounces-4040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D193EFB0
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF411F21E46
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140B13AA40;
	Mon, 29 Jul 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hWzlC4nT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bYNiKV10"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43884FAC;
	Mon, 29 Jul 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241062; cv=fail; b=pCsm6lFnAsd0xozAQHBy8SLqDa4F2cPMIPmaoLyjY+26g+8fjQD7//gQcjtwB5ui1pR2vRWp0EuUyPzqsrKgLliUPHGezmvbZenqorb+/bu3JCClwXee0D58jRdbrxLNJ5YL7av6HF2RxcGEhecItjMdYMLikXPOwOfZLP6z1zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241062; c=relaxed/simple;
	bh=IeBM3cQgPT6ZLmZsQFjgB6ukj7v/RglrK4T/Fqeotq8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fi7SfYM6tbSSDheUSJmG9QompHaH/XVeRuhn3PJdg61WrcjotT5EdzEhqm+WvfsHe8OA6TXtzv8bbW5yabrQhUuMJprDOySNiD2fY+g8qaiwHlfde2A6oB6H6lTXPY1jClrKAx4SzAQl/C/rD04iuKHYbzvw6rs3QIDLe+XyOXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hWzlC4nT; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bYNiKV10; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722241059; x=1753777059;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IeBM3cQgPT6ZLmZsQFjgB6ukj7v/RglrK4T/Fqeotq8=;
  b=hWzlC4nT9n797jE6Zqv1mcE6Nn/p2tVR5qWsftDKLDJ/RsRYbxASt5KM
   fyKLN64bfZJ6qSjvqCBpqfp9m1OzLued9zZ+eIq78UZZ1ZOCAeEziuYNy
   KzGmvhq/FZIoVEJONHRHt7cANOHMyrvQDRnG9ZM/+LWAjBSYaiTNkBVhT
   vfiQ2TZkLPwBqYufffLJ3orh4RG1zzt9Z4cnXgl3rzwvcarKMXdYAmqsA
   dwQ7o6QO/M6klfFpwr7y6q/LvqBbXvO7B65TLcwzhp89obY7gQp0CfkF/
   15JtuDb0uM3IhQN0e54Rv6WF+ZKejq2M1nTrFduNUBc9gU341gRzTvaKK
   w==;
X-CSE-ConnectionGUID: KvuMA+deQRK6Co6NMNMY2g==
X-CSE-MsgGUID: J0IVX/FxQFqU558UeHkBnw==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197216136"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 01:17:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 01:17:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 01:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Re2qYhwpo9I3oNjujKr+WwfjWKAO/sAXODTsbI0rUlZgGTfPeHEC42rs3h1HCiKlqeJiNBvYQ2tt0sy/S4WaJ2mLX53S2YUj8/rQsGHY4/3Kdl3zOdA4SzCSQbHa7jIIVGlVYNgp58GgUfGjEvLirlGjbDjyud81w2MVyzUVBEnVHgYDu7XWLjomzODjFfFkvnCxijUfq8JOIR2q4jjj19uxWYwBAS6Acy4xqN1XJ3BRvsXZTx9cF44umusCj2ePiv+5uWg3eu3eRpaK3u844omsvuEvWHQXZpRfC01ewFoqTMRUW77zvDOmcPF7IRO8br2qdm2aMWUOAWnPP4xOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeBM3cQgPT6ZLmZsQFjgB6ukj7v/RglrK4T/Fqeotq8=;
 b=U1mpXZ+Jrv2v9FLPzfB578+wJlqI/PDOba1khpt87yrf2U1mto+uQAaM7VcjuJP3PuMmCX6YEKWSTr+Gmxsgt6MMZCRR53Y1s34EZOyolaRvfcaERaosIE3PvmbQSjSiIqbMMq35tUDaEHkq7TvIfG5Szi+y3AFDQ06nIosa42qRHZd10k6f82m7urehSLBUXLBmWyeMR2+8hggfPvGo3n1sZVJUetrJ3RkRPe2O6xhBp4f3Uv7Lc1mw0LrliZRj7Cova9yw0Zo1EEkDQSxCvuBdo5FPKdX7EM0hKaOE0ZSfjFYMnSyObSJZ3CF+qGXZIVYP3+aGHvvCE/ILcAeFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeBM3cQgPT6ZLmZsQFjgB6ukj7v/RglrK4T/Fqeotq8=;
 b=bYNiKV10tBqKg9xBSs1tk9G0VqqwWNWOUQJBiraGR38eLy3hW6TnwrymqdPWBVHFNdbqS8wFjd35I5Cnh4k6XHpkxwLiBAvOw6BF4rpCJ/ghEdrfCmlPi7o+9K2l2HZlNqgNgSTvSn6rFvW9GjSAQjxliVr85wdpxJVqtVGmki+s933mJtTJGPq3EMxsBsZsdgnYRs92hlMzUtbU9wnj4Giz2kc/TJ/K1HemeUFKShXyJ+vh6qlVmeDG26hFH5UOqqCar+q1nuWBwzQ8qXLh5Hzp1W2lKkUsylnq/f417myHONQw6PNVA4gFTdHEv4glCRuAz7hgAsBKWxWIRUGtHQ==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 08:17:13 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 08:17:13 +0000
From: <Andrei.Simion@microchip.com>
To: <Varshini.Rajendran@microchip.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <tglx@linutronix.de>,
	<lee@kernel.org>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<richard.genoud@bootlin.com>, <radu_nicolae.pirea@upb.ro>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ychuang3@nuvoton.com>,
	<schung@nuvoton.com>, <Mihai.Sain@microchip.com>, <arnd@arndb.de>,
	<Jason@zx2c4.com>, <Dharma.B@microchip.com>, <rdunlap@infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v6 00/27] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v6 00/27] Add support for sam9x7 SoC family
Thread-Index: AQHa4YRtSmVG9iS+jk+c9jmDaTLeKrINXGeA
Date: Mon, 29 Jul 2024 08:17:13 +0000
Message-ID: <f49f5585-ab7f-4f3e-990e-4ba32ee503d7@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: 82f47e64-0633-479b-4c6e-08dcafa6d9c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmhHSWpIeVlweGdraTlEZXRFQkZHZEVwQmZmeUZrbUQyR203NmUzbHBOSEhz?=
 =?utf-8?B?by9tWFdzNTNrazdoQkJtQjYxWWZwVUJIYjZaaWJJUDFRWWV5UjVHOTFtcitI?=
 =?utf-8?B?QUQ1VVV3L1kvUGRJVmZ4L2VDM3VaYVVMN0x0eVluOUtqK2dHSnNpMVpIZUlv?=
 =?utf-8?B?ZituajA1QkZFWEtmOEFwZDdBK1VHOXUwY1U2bnRickp5clV6YWJTemEzRXRw?=
 =?utf-8?B?SEt3ZmJLRDExWkIzR2M3U3gzT2hyMEhQL215dTROT0RON3Y3KzB3UVZvVS91?=
 =?utf-8?B?eGFLM2hOL3pLRkloajdvQ0o2eUdQSFVwU1htdHhKeUxpVmd1cDV1cWtlMmJt?=
 =?utf-8?B?Z1lKeHExa01zQlJobWFjZkUxN210SmtSN1dpaWd2Q2NtQStjdTZRVmZ2YWVn?=
 =?utf-8?B?dFo2RmhxeVV5U3dWbTBTNU1tWmxSNWNNVFl0bjNSazI1RXh4RHdWZXViSUpl?=
 =?utf-8?B?V3MzRkdjb0llc3R6RUk1SFRPQ1ZZVjFqVWxIQXh6bUZKYU5xb211MjdVMTIz?=
 =?utf-8?B?U0dZVDdGa01PNlBUdmZVdjJwbkJTZnpieis0SmtETDFxMktvektBeUpPZjN2?=
 =?utf-8?B?bzlpTEVCOTF5d0l1TnlPcks1UUlsejNVaElPdG5KM2NMTjRjaUJyUUdMK3Rz?=
 =?utf-8?B?REdEblNWWkVMc0pUQUNUS0NNT3Rsc3BUVEpwT21PMXZKSEdwNjhlSVRUTUtB?=
 =?utf-8?B?NHgxZUJUanZ0SVlZTmIva3V5a29TV3k2QjdTcExGYzZsSi8zWW9XUGFCTUkw?=
 =?utf-8?B?OGlIb0IzdHUwYm0xMWF6d3VpUGJQRWl1SWplR2ZmMXhIR091TkxPbUI2eHAr?=
 =?utf-8?B?RWZxTTZkckk4LzZoMVR4ZlZOaG10d2UzL2gvTTQ1ZmVlOVhTc3J2cU55RnJG?=
 =?utf-8?B?ZkpFZjVTN1BsZGdLWnRUQmE3TjEzS0xvUUJuaE5RZWFKVVR1WmVPYlZuVk5o?=
 =?utf-8?B?QmtkMkl4eElaMTFwWCthNitqOUpCT3hzUmkyMGxESzg1VXdDeGlEK281OGtT?=
 =?utf-8?B?OVlDWC96VFlOYjFaeUZOdkQ1enRlUG1MTjZKUGxieVlPK0xmalF2aWtBVG5y?=
 =?utf-8?B?aFVwdEhocllETnZZa055TjIxVkxRZGRoc1Bld2w5b2Vuek9vbXZjSDczTE9I?=
 =?utf-8?B?QUc0YjlpL016TVQyQ1BtbVdzOWxRQmVVM3hFaHhhQkZpY3NsUGlGZWU1dnBn?=
 =?utf-8?B?NDZsTk14U1JpdGRoNWt1bjE0YXZrNEhUUWNtVWZZS1NnTDRzY3M3bjdKUTlU?=
 =?utf-8?B?TzVrMFFsaGZEMXdidmRoeDJPZExRdFNibnVaRnQ5b3AyT00rZGZCSkx4V3FV?=
 =?utf-8?B?SkRBYkxwcGYvUlRydVNVTU9CZW93QUxTSVFBaDhLMUg1b1ljcHVJTWlFUE5j?=
 =?utf-8?B?VDJ6UC9JQ1hpdll5T3NVWFBLQTFTNTVZOHBuRHJXUHBoMk9mKzl2TGl4QUc2?=
 =?utf-8?B?L2xWUmxDNTgyQ2lYSnI4cFdrT3ByL2FMVGxOUkYzOUJCTHVzZ3l5blZpSlJa?=
 =?utf-8?B?Q2V6RlRCMTNkcC8yRFpLc0UyeDFzR28wZkR1SS81K1J5TG5xb3RPYVI3RlVo?=
 =?utf-8?B?Q0JGS1FkS3p4d3NKZG1SdElSRWdhaWJ1dXVocmtWcmR2YytmaUQ5NHdoUytq?=
 =?utf-8?B?cjJCRTlrQ3Z5STIxcFdxUm5ybU44UUdwUkJKOFI3UFQ2TzFva3VJRGFkOWdL?=
 =?utf-8?B?NGdUdE9MbTdoa3R5SWhVbDBHeUphOFh2a25OMGM2TlgzQWw5ZzZobXNIL2tC?=
 =?utf-8?B?enRvY3dVSVZmb2hTam1TRkhiSWIrUCs3R3NHOGZaMlJLRXpFZ1ppa1FsZTdR?=
 =?utf-8?B?TXNMOGtWQWFZS3lhR20zM3haYk9JWWRDOUpBQVh5azNkZG45bXEvdW9yVThx?=
 =?utf-8?Q?dxPDBf04ZJL4p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVWb0pmRzJsNG1nVGtSU3FITXliaExTYXBMZmNjRTNuQlUrK2ZuS1plSEpT?=
 =?utf-8?B?QS9xRWU3OG5mTlQxSjloNzJUUkVDeURhVHBvdi9VQmF4VldDNCt6aW9xMkFa?=
 =?utf-8?B?MVhZODhuUmpqYTBXNW9zRTd3ZUNySXd1VGg0WGZHQW1hNjRCaG9YYzNHb3k0?=
 =?utf-8?B?M08vVlJzVjBxU3Q3TEJFblYxdGYyTDVyd0krQjJIcW5zSnNZOTVJbzlhNm1K?=
 =?utf-8?B?eWN3N0N5TG5MMW1aaE01SjVNUHFaeS82OUFEZG5qNXpTeHZRc3Z4WENpWWg1?=
 =?utf-8?B?MGMydFFiT0NRNEZsVjNuOVBpRlNEQStsTUJKaG04b052U3k0eWZGM3c0bmFq?=
 =?utf-8?B?Z1NiTnlUeTBQQnUwL3duczFpUndkenM3dm9WM3lJRU1jRkJkakEyQkRKYnIy?=
 =?utf-8?B?RXdUYU9SZitYdlZwbXovWXZ3M3FtdzBvd0g4d2p3dWR4b25NUVViSlhxclJz?=
 =?utf-8?B?SzBjSG1US2lhdkNkYTFXRXMyK2VLOTlwZDYwditWVG5sUUFaVGdscmY2ZGxh?=
 =?utf-8?B?Q3pVT1hMejJDSUdkdkRLWUQxVkVJTkFoSnh4cTR6TERuUDFST1pUQW5STlNT?=
 =?utf-8?B?bThQcUd1OVZKeXljNmhOUXFsbHl1UFZqdXVzZzRWNStZb3NDRVdKT2JHZ1NG?=
 =?utf-8?B?Ti9jeUp2aE5YQmR2LzVKR3hYL3hna0tQSkZaWE1SNlJOZnFuZjcvRjBpanJR?=
 =?utf-8?B?MXpUVEN6SmlKeFJYcjZ4N0dvZFArU1BVODluUkxicGZVaHI4Zi9zNk5MR24v?=
 =?utf-8?B?TVhLSEpDeHc5UW5VUVAyNFR1ZThRTnRzZ2drTlR6dWZhNG9MZkRvMFNCWFEw?=
 =?utf-8?B?MWFCVThhSmVUQ2VsYURLQzJtNExDM1kvaUpYdFZ2bGlib3lCY1Rpak9nQ3B6?=
 =?utf-8?B?SnAwRllVNGZnTXJNRElwMHJiUEk4RWhUR1ZrWEZTMzNhbFhHV2JGWHljUWlM?=
 =?utf-8?B?NDV5dkQ2R294ZHR1ZC9aQ2Q3N05mL0E2b1RBQ1NoeGVjYmN5TVFLSVBzMk5O?=
 =?utf-8?B?YmJib1B0UzY2enVFc3FYUW1WcU5TbEJWb3VEM3pka3pSNnlZbGx2dUlZK2Jl?=
 =?utf-8?B?MG1LR1B2Mm5NQUk0WEhKdk5YRmpIcFhGRkpWVmlDdWhsQVM1ZS8yajlGS3JM?=
 =?utf-8?B?eWVWSFJoVmdWWlZ4cnV3aXREU3ZreGRsOEtPTndMNzBndVZ0c2dmdFJ1bm1B?=
 =?utf-8?B?aTlXNnE3R1ZpMEhmMWZORGsySjZ0UFZzMW05MkJHamEyWGxIMUEyZnJqZEpW?=
 =?utf-8?B?Skd6UmJ2Q2dLMnI0bHNsSkJZbTJqYVNveFR4WUp4ZTNaYVp0RCsyVncxVXZC?=
 =?utf-8?B?c3JxdGFQOXZMZWlYVE9LMk1BbFE0cnN6bEJBenh3eGhxMlhGZGdQbDYrL0V6?=
 =?utf-8?B?cktVOGtnd0w4VEpqTm5BZnFkL3ZDYjFXYkYwNjJHcC9ocm9hY2FicHZVRFA0?=
 =?utf-8?B?ZzJ4U2Q2OEJrZm5YbklMbEs4My93bzNUb3FNV2I4N1pRc2cwSjdtNHhyM2sr?=
 =?utf-8?B?TmpTTzgvWmpMOWJNNDhrMXN6TW5wYUlnRHlZS1lHYmRNc2NLOUZrQkpzaDUw?=
 =?utf-8?B?V1dWVWU1M2dYUnlpZFIxd0hTVXBwMndMYTFFWE5MeFRhSHBGZFpqdFYzV1p0?=
 =?utf-8?B?TGJFaENQZ0ttRmFxeHpNN3o3R3E3ZHhWT0hsR3NwdHdncjAzb3NrZHhibjdy?=
 =?utf-8?B?Tk1VSXg0dWZHeXpDM0RpOWpDMWtVQXJuMGJYMzkzTmVJZWxHOFptZFhweFpM?=
 =?utf-8?B?L2t2WUhydjdUYnZtRFlkWk02S09IUzdQRUpiTnJ2QVVyYzhnbHk1Y3JQTERZ?=
 =?utf-8?B?STVxY0h0bXc3R3dmZm1ZSHVhakhrbEIxeVdHeDFKTWxTYThBSmI0engxU0l2?=
 =?utf-8?B?QzVoaTJxWkVDZmFuTXhobnZZc2ZIZ2taWktTR0svNE9LcXFvRDJoWlNFWGZm?=
 =?utf-8?B?Nld5YmFyTENUMFV3bWxoWUU5UExCenJ0MnJ2NXBQT010OWFNSEhTRi9DSlFD?=
 =?utf-8?B?dGo1MXRMOGt0VlNHRG8rTjIxOGxiLy9nVktpbEZVOU9Bb2lmak5NK1dqYTFx?=
 =?utf-8?B?RDVzdi83c1BrdkM1VDhJN0V0L1EyU3RpRW5ic3RTRnc2cDJrdDFBSDhTSHZ6?=
 =?utf-8?B?Z1pkS3ZYWUNmdFhXQWdqdXo3RElPVnFHeC9KNTVUR0JKdW1QbWs0UzA1Wkxa?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13BEE5FE2D229048A87502C39D0C0016@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f47e64-0633-479b-4c6e-08dcafa6d9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 08:17:13.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGqrl7mCte14AQ8585a+VZ4IEaHScYPdIG24sWlUDXUpDkaTUvP2PsjKVH6ayAspBa4makMn4CKgRZq+1dYzW+iDZzn/YG8kjPEFqEsteMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202

T24gMjkuMDcuMjAyNCAwOTo1NiwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPiBUaGlzIHBh
dGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBuZXcgU29DIGZhbWlseSAtIHNhbTl4Ny4N
Cj4gIC0gVGhlIGRldmljZSB0cmVlLCBjb25maWdzIGFuZCBkcml2ZXJzIGFyZSBhZGRlZA0KPiAg
LSBDbG9jayBkcml2ZXIgZm9yIHNhbTl4NyBpcyBhZGRlZA0KPiAgLSBTdXBwb3J0IGZvciBiYXNp
YyBwZXJpcGhlcmFscyBpcyBhZGRlZA0KPiAgLSBUYXJnZXQgYm9hcmQgU0FNOVg3NSBDdXJpb3Np
dHkgaXMgYWRkZWQNCj4gDQo+ICBDaGFuZ2VzIGluIHY2Og0KPiAgLS0tLS0tLS0tLS0tLS0NCj4g
DQo+ICAtIEFkZHJlc3NlZCBhbGwgdGhlIHJldmlldyBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcw0K
PiAgLSBQaWNrZWQgdXAgYWxsIEFja2VkLWJ5IGFuZCBSZXZpZXdlZC1ieSB0YWdzDQo+ICAtIFJl
dmVydGVkIHRoZSBJUlEgcGF0Y2ggdG8gdGhhdCBvZiB2ZXJzaW9uIDMgb2YgdGhlIHNhbWUgc2Vy
aWVzDQo+ICAtIEFsbCB0aGUgc3BlY2lmaWMgY2hhbmdlcyBhcmUgY2FwdHVyZWQgaW4gdGhlIGNv
cnJlc3BvbmRpbmcgcGF0Y2hlcw0KPiANCj4gIENoYW5nZXMgaW4gdjU6DQo+ICAtLS0tLS0tLS0t
LS0tLQ0KPiANCj4gIC0gQWRkcmVzc2VkIGFsbCB0aGUgcmV2aWV3IGNvbW1lbnRzIGluIHRoZSBw
YXRjaGVzDQo+ICAtIFBpY2tlZCB1cCBhbGwgQWNrZWQtYnkgYW5kIFJldmlld2VkLWJ5IHRhZ3MN
Cj4gIC0gRHJvcHBlZCBhcHBsaWVkIHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzDQo+ICAtIEFkZHJl
c3NlZCB0aGUgQUJJIGJyZWFrYWdlIHJlcG9ydGVkIGluIHRoZSBJUlEgcGF0Y2gNCj4gIC0gQWxs
IHRoZSBzcGVjaWZpYyBjaGFuZ2VzIGFyZSBjYXB0dXJlZCBpbiB0aGUgY29ycmVzcG9uZGluZyBw
YXRjaGVzDQo+IA0KPiAgQ2hhbmdlcyBpbiB2NDoNCj4gIC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAg
LSBBZGRyZXNzZWQgYWxsIHRoZSByZXZpZXcgY29tbWVudHMgaW4gdGhlIHBhdGNoZXMNCj4gIC0g
UGlja2VkIHVwIGFsbCBBY2tlZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiAgLSBEcm9wcGVk
IGFwcGxpZWQgcGF0Y2hlcyBmcm9tIHRoZSBzZXJpZXMNCj4gIC0gQWRkZWQgcHdtIG5vZGUgYW5k
IHJlbGF0ZWQgZHQgYmluZGluZyBkb2N1bWVudGF0aW9uDQo+ICAtIEFkZGVkIHN1cHBvcnQgZm9y
IGV4cG9ydGluZyBzb21lIGNsb2NrcyB0byBEVA0KPiAgLSBEcm9wcGVkIFVTQiByZWxhdGVkIHBh
dGNoZXMgYW5kIGNoYW5nZXMuIFNlZSBOT1RFLg0KPiAgLSBBbGwgdGhlIHNwZWNpZmljIGNoYW5n
ZXMgYXJlIGNhcHR1cmVkIGluIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoZXMNCj4gDQo+ICBOT1RF
OiBPd2luZyB0byB0aGUgZGlzY3Vzc2lvbiBoZXJlDQo+ICBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1kZXZpY2V0cmVlL0NBTF9Kc3FKOVByWDZmai1FYmZmZUpjZTA5TVhzPUI3dCtLU19r
T2lueGFSeDM4PVd4QUBtYWlsLmdtYWlsLmNvbS8NCj4gIHRoZSBVU0IgcmVsYXRlZCBjaGFuZ2Vz
IGFyZSBkcm9wcGVkIGZyb20gdGhpcyBzZXJpZXMgaW4gb3JkZXIgdG8gZW5hYmxlDQo+ICB1cyB0
byB3b3JrIG9uIHRoZSBtZW50aW9uZWQgaXNzdWVzIGJlZm9yZSBhZGRpbmcgbmV3IGNvbXBhdGli
bGVzIGFzDQo+ICBzYWlkLiBUaGUgaXNzdWVzL3dhcm5pbmdzIHdpbGwgYmUgYWRkcmVzc2VkIGlu
IHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4gIEFmdGVyIHdoaWNoIHRoZSBVU0IgcmVsYXRlZCBzdXBw
b3J0IGZvciBzYW05eDcgU29DcyB3aWxsIGJlIGFkZGVkLiBIb3BlDQo+ICB0aGlzIHdvcmtzIG91
dCBmaW5lLg0KPiANCj4gIENoYW5nZXMgaW4gdjM6DQo+ICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4g
IC0gRml4ZWQgdGhlIERUIGRvY3VtZW50YXRpb24gZXJyb3JzIHBvaW50ZWQgb3V0IGluIHYyLg0K
PiAgLSBEcm9wcGVkIEFja2VkLWJ5IHRhZyBpbiB0Y2IgRFQgZG9jIHBhdGNoIGFzIGl0IGhhZCB0
byBiZSBhZGFwdGVkDQo+ICAgIGFjY29yZGluZyB0byBzYW05eDcgY29ycmVjdGx5Lg0KPiAgLSBQ
aWNrZWQgYnkgdGhlIHByZXZpb3VzbHkgbWlzc2VkIHRhZ3MuDQo+ICAtIERyb3BwZWQgdGhpcyBw
YXRjaCAiZHQtYmluZGluZ3M6IHVzYjogZ2VuZXJpYy1laGNpOiBEb2N1bWVudCBjbG9jay1uYW1l
cw0KPiAgICBwcm9wZXJ0eSIgYXMgdGhlIHdhcm5pbmcgd2FzIG5vdCBmb3VuZCB3aGlsZSB2YWxp
ZGF0aW5nIERULXNjaGVtYSBmb3INCj4gICAgYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS5kdGIuDQo+
ICAtIERyb3BwZWQgcmVkdW5kYW50IHdvcmRzIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gIC0g
Rml4ZWQgdGhlIENIRUNLX0RUQlMgd2FybmluZ3MgdmFsaWRhdGVkIGFnYWluc3QNCj4gICAgYXQ5
MS1zYW05eDc1X2N1cmlvc2l0eS5kdGIuDQo+ICAtIFJlbmFtZWQgZHQgbm9kZXMgYWNjb3JkaW5n
IHRvIG5hbWluZyBjb252ZW50aW9uLg0KPiAgLSBEcm9wcGVkIHVud2FudGVkIHN0YXR1cyBwcm9w
ZXJ0eSBpbiBkdHMuDQo+ICAtIFJlbW92ZWQgbm9kZXMgdGhhdCBhcmUgbm90IGluIHVzZSBmcm9t
IHRoZSBib2FyZCBkdHMuDQo+ICAtIFJlbW92ZWQgc3BpIERUIGRvYyBwYXRjaCBmcm9tIHRoZSBz
ZXJpZXMgYXMgaXQgd2FzIGFscmVhZHkgYXBwbGllZA0KPiAgICBhbmQgYSBmaXggcGF0Y2ggd2Fz
IGFwcGxpZWQgc3Vic2VxdWVudGx5LiBBZGRlZCBhIHBhdGNoIHRvIHJlbW92ZSB0aGUNCj4gICAg
Y29tcGF0aWJsZSB0byBhZGFwdCBzYW05eDcuDQo+ICAtIEFkZGVkIHNhbTl4NyBjb21wYXRpYmxl
cyBpbiB1c2IgZHQgZG9jdW1lbnRhdGlvbi4NCj4gDQo+IA0KPiAgQ2hhbmdlcyBpbiB2MjoNCj4g
IC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAgLSBBZGRlZCBzYW05eDcgc3BlY2lmaWMgY29tcGF0aWJs
ZXMgaW4gRFQgd2l0aCBmYWxsYmFja3MNCj4gIC0gRG9jdW1lbnRlZCBhbGwgdGhlIG5ld2x5IGFk
ZGVkIERUIGNvbXBhdGlibGUgc3RyaW5ncw0KPiAgLSBBZGRlZCBkZXZpY2UgdHJlZSBmb3IgdGhl
IHRhcmdldCBib2FyZCBzYW05eDc1IGN1cmlvc2l0eSBhbmQNCj4gICAgZG9jdW1lbnRlZCB0aGUg
c2FtZSBpbiB0aGUgRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KPiAgLSBSZW1vdmVkIHRoZSBk
dCBub2RlcyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGF0IHRoZSBtb21lbnQNCj4gIC0gUmVtb3Zl
ZCB0aGUgY29uZmlncyBhZGRlZCBieSBwcmV2aW91cyB2ZXJzaW9uIHRoYXQgYXJlIG5vdCBzdXBw
b3J0ZWQNCj4gICAgYXQgdGhlIG1vbWVudA0KPiAgLSBGaXhlZCBhbGwgdGhlIGNvcnJlY3Rpb25z
IGluIHRoZSBjb21taXQgbWVzc2FnZQ0KPiAgLSBDaGFuZ2VkIGFsbCB0aGUgaW5zdGFuY2VzIG9m
IGNvcHlyaWdodCB5ZWFyIHRvIDIwMjMNCj4gIC0gQWRkZWQgc2FtOXg3IGZsYWcgaW4gUElUNjRC
IGNvbmZpZ3VyYXRpb24NCj4gIC0gTW92ZWQgbWFjcm8gZGVmaW5pdGlvbnMgdG8gaGVhZGVyIGZp
bGUNCj4gIC0gQWRkZWQgYW5vdGhlciBkaXZpZGVyIGluIG1jayBjaGFyYWN0ZXJpc3RpY3MgaW4g
dGhlIHBtYyBkcml2ZXINCj4gIC0gRml4ZWQgdGhlIG1lbW9yeSBsZWFrIGluIHRoZSBwbWMgZHJp
dmVyDQo+ICAtIERyb3BwZWQgcGF0Y2hlcyB0aGF0IGFyZSBubyBsb25nZXIgbmVlZGVkDQo+ICAt
IFBpY2tlZCB1cCBBY2tlZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiANCj4gDQo+IEhhcmkg
UHJhc2F0aCAoMSk6DQo+ICAgaXJxY2hpcC9hdG1lbC1haWM1OiBBZGQgc3VwcG9ydCBmb3Igc2Ft
OXg3IGFpYw0KPiANCj4gVmFyc2hpbmkgUmFqZW5kcmFuICgyNik6DQo+ICAgZHQtYmluZGluZ3M6
IGF0bWVsLXN5c3JlZzogYWRkIHNhbTl4Nw0KPiAgIGR0LWJpbmRpbmdzOiBtZmQ6IHN5c2Nvbjog
YWRkIG1pY3JvY2hpcCdzIHNhbTl4NyBzZnINCj4gICBkdC1iaW5kaW5nczogYXRtZWwtc3NjOiBh
ZGQgbWljcm9jaGlwLHNhbTl4Ny1zc2MNCj4gICBkdC1iaW5kaW5nczogc2VyaWFsOiBhdG1lbCxh
dDkxLXVzYXJ0OiBhZGQgY29tcGF0aWJsZSBmb3Igc2FtOXg3Lg0KPiAgIGR0LWJpbmRpbmdzOiBt
aWNyb2NoaXA6IGF0bWVsLGF0OTFybTkyMDAtdGNiOiBhZGQgc2FtOXg3IGNvbXBhdGlibGUNCj4g
ICBBUk06IGF0OTE6IHBtOiBhZGQgc3VwcG9ydCBmb3Igc2FtOXg3IFNvQyBmYW1pbHkNCj4gICBB
Uk06IGF0OTE6IHBtOiBhZGQgc2FtOXg3IFNvQyBpbml0IGNvbmZpZw0KPiAgIEFSTTogYXQ5MTog
YWRkIHN1cHBvcnQgaW4gU29DIGRyaXZlciBmb3IgbmV3IHNhbTl4Nw0KPiAgIGR0LWJpbmRpbmdz
OiBjbG9ja3M6IGF0bWVsLGF0OTFzYW05eDUtc2NrYzogYWRkIHNhbTl4Nw0KPiAgIGR0LWJpbmRp
bmdzOiBjbG9ja3M6IGF0bWVsLGF0OTFybTkyMDAtcG1jOiBhZGQgc2FtOXg3IGNsb2NrIGNvbnRy
b2xsZXINCj4gICBjbGs6IGF0OTE6IGNsay1zYW05eDYwLXBsbDogcmUtZmFjdG9yIHRvIHN1cHBv
cnQgaW5kaXZpZHVhbCBjb3JlIGZyZXENCj4gICAgIG91dHB1dHMNCj4gICBjbGs6IGF0OTE6IHNh
bTl4NzogYWRkIHN1cHBvcnQgZm9yIEhXIFBMTCBmcmVxIGRpdmlkZXJzDQo+ICAgY2xrOiBhdDkx
OiBzYW1hN2c1OiBtb3ZlIG11eCB0YWJsZSBtYWNyb3MgdG8gaGVhZGVyIGZpbGUNCj4gICBkdC1i
aW5kaW5nczogY2xvY2s6IGF0OTE6IEFsbG93IFBMTHMgdG8gYmUgZXhwb3J0ZWQgYW5kIHJlZmVy
ZW5jZWQgaW4NCj4gICAgIERUDQo+ICAgY2xrOiBhdDkxOiBzYW05eDc6IGFkZCBzYW05eDcgcG1j
IGRyaXZlcg0KPiAgIGR0LWJpbmRpbmdzOiBpbnRlcnJ1cHQtY29udHJvbGxlcjogQWRkIHN1cHBv
cnQgZm9yIHNhbTl4NyBhaWMNCj4gICBwb3dlcjogcmVzZXQ6IGF0OTEtcG93ZXJvZmY6IGxvb2t1
cCBmb3IgcHJvcGVyIHBtYyBkdCBub2RlIGZvciBzYW05eDcNCj4gICBwb3dlcjogcmVzZXQ6IGF0
OTEtcmVzZXQ6IGFkZCByZXNldCBzdXBwb3J0IGZvciBzYW05eDcgU29DDQo+ICAgcG93ZXI6IHJl
c2V0OiBhdDkxLXJlc2V0OiBhZGQgc2Rod2Mgc3VwcG9ydCBmb3Igc2FtOXg3IFNvQw0KPiAgIGR0
LWJpbmRpbmdzOiByZXNldDogYXRtZWwsYXQ5MXNhbTkyNjAtcmVzZXQ6IGFkZCBzYW05eDcNCj4g
ICBkdC1iaW5kaW5nczogcG93ZXI6IHJlc2V0OiBhdG1lbCxzYW1hNWQyLXNoZHdjOiBhZGQgc2Ft
OXg3DQo+ICAgQVJNOiBhdDkxOiBLY29uZmlnOiBhZGQgY29uZmlnIGZsYWcgZm9yIFNBTTlYNyBT
b0MNCj4gICBBUk06IGNvbmZpZ3M6IGF0OTE6IGVuYWJsZSBjb25maWcgZmxhZ3MgZm9yIHNhbTl4
NyBTb0MgZmFtaWx5DQo+ICAgQVJNOiBkdHM6IGF0OTE6IHNhbTl4NzogYWRkIGRldmljZSB0cmVl
IGZvciBTb0MNCj4gICBkdC1iaW5kaW5nczogYXJtOiBhZGQgc2FtOXg3NSBjdXJpb3NpdHkgYm9h
cmQNCj4gICBBUk06IGR0czogbWljcm9jaGlwOiBzYW05eDc1X2N1cmlvc2l0eTogYWRkIHNhbTl4
NzUgY3VyaW9zaXR5IGJvYXJkDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0
bWVsLWF0OTEueWFtbCAgIHwgICAgNiArDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
YXRtZWwtc3lzcmVncy50eHQgfCAgICA2ICstDQo+ICAuLi4vYmluZGluZ3MvY2xvY2svYXRtZWws
YXQ5MXJtOTIwMC1wbWMueWFtbCAgfCAgICAyICsNCj4gIC4uLi9iaW5kaW5ncy9jbG9jay9hdG1l
bCxhdDkxc2FtOXg1LXNja2MueWFtbCB8ICAgIDQgKy0NCj4gIC4uLi9pbnRlcnJ1cHQtY29udHJv
bGxlci9hdG1lbCxhaWMueWFtbCAgICAgICB8ICAgIDEgKw0KPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL3N5c2Nvbi55YW1sICAgICAgIHwgIDE4OCArLS0NCj4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21pc2MvYXRtZWwtc3NjLnR4dCAgICB8ICAgIDEgKw0KPiAgLi4uL3Bvd2VyL3Jl
c2V0L2F0bWVsLHNhbWE1ZDItc2hkd2MueWFtbCAgICAgIHwgICAgMyArDQo+ICAuLi4vcmVzZXQv
YXRtZWwsYXQ5MXNhbTkyNjAtcmVzZXQueWFtbCAgICAgICAgfCAgICA0ICsNCj4gIC4uLi9iaW5k
aW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sICAgICB8ICAgIDkgKy0NCj4gIC4uLi9z
b2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwgICB8ICAgMjAgKy0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9NYWtlZmlsZSAgICAgICAgICB8ICAgIDMgKw0KPiAg
Li4uL2R0cy9taWNyb2NoaXAvYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS5kdHMgIHwgIDMxMiArKysr
Kw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL3NhbTl4Ny5kdHNpICAgICAgIHwgMTIy
NiArKysrKysrKysrKysrKysrKw0KDQpIaSwNCg0KU29ycnkgZm9yIGRpc3R1cmJpbmcsIEkgZG9u
J3Qgc2VlIHRoZSBwYXRjaCB3aGVyZSB5b3UgYWRkIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hp
cC9zYW05eDcuZHRzaQ0KSW4gbGludXgtbmV4dCB0aGlzIGZpbGUgaXMgbm90IGFwcGxpZWQgeWV0
Og0KOn4kIGZpbmQgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwIHwgZ3JlcCAtaSBzYW05eDcu
ZHRzaSB8IHdjIC1sDQowDQoNCkJlc3QgcmVnYXJkcywNCkFuZHJlaQ0KDQo+ICBhcmNoL2FybS9j
b25maWdzL2F0OTFfZHRfZGVmY29uZmlnICAgICAgICAgICAgfCAgICAxICsNCj4gIGFyY2gvYXJt
L21hY2gtYXQ5MS9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMjIgKy0NCj4gIGFyY2gv
YXJtL21hY2gtYXQ5MS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiAgYXJj
aC9hcm0vbWFjaC1hdDkxL2dlbmVyaWMuaCAgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ICBh
cmNoL2FybS9tYWNoLWF0OTEvcG0uYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDI5ICsNCj4g
IGFyY2gvYXJtL21hY2gtYXQ5MS9zYW05eDcuYyAgICAgICAgICAgICAgICAgICB8ICAgMzMgKw0K
PiAgZHJpdmVycy9jbGsvYXQ5MS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAr
DQo+ICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1zYW05eDYwLXBsbC5jICAgICAgICAgICAgfCAgIDQy
ICstDQo+ICBkcml2ZXJzL2Nsay9hdDkxL3BtYy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDE4ICsNCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtOXg2MC5jICAgICAgICAgICAgICAgICAgICB8
ICAgIDcgKw0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYyAgICAgICAgICAgICAgICAgICAg
IHwgIDk0NiArKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2Nsay9hdDkxL3NhbWE3ZzUuYyAgICAg
ICAgICAgICAgICAgICAgfCAgIDQyICstDQo+ICBkcml2ZXJzL2lycWNoaXAvaXJxLWF0bWVsLWFp
YzUuYyAgICAgICAgICAgICAgfCAgIDEwICsNCj4gIGRyaXZlcnMvcG93ZXIvcmVzZXQvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICB8ICAgIDQgKy0NCj4gIGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5
MS1zYW1hNWQyX3NoZHdjLmMgICAgICB8ICAgIDEgKw0KPiAgZHJpdmVycy9zb2MvYXRtZWwvc29j
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAyMyArDQo+ICBkcml2ZXJzL3NvYy9hdG1lbC9z
b2MuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgICA5ICsNCj4gIGluY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svYXQ5MS5oICAgICAgICAgICAgICB8ICAgIDQgKw0KPiAgMzIgZmlsZXMgY2hhbmdl
ZCwgMjg0MCBpbnNlcnRpb25zKCspLCAxNDAgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEtc2FtOXg3NV9jdXJpb3NpdHku
ZHRzDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL3Nh
bTl4Ny5kdHNpDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1hdDkxL3NhbTl4
Ny5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYw0KPiAN
Cg==

