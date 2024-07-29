Return-Path: <linux-spi+bounces-4055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30AF93F06D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A3228332E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52213D61A;
	Mon, 29 Jul 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fq6M9ISv";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uC32dZuS"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668084A2B;
	Mon, 29 Jul 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243504; cv=fail; b=l1e7gjBzx80kZbBq64bocQipeKEyQl4zrSN53nHWpEGTSNzlUVNpGOlCLQpa32uY0VY1e4Gkf6NgVcWqJGn888GpBhIoImiPRjNIM4bbfi8TsifObXAlQH5Db2nDFKQArbSlle3ALO395kziQitJhonKEUkWBLDT+QLE0UN2zE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243504; c=relaxed/simple;
	bh=wzFk13fokJzQ54DJXEnDFeRirevXKat2s+3NoN1UZNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufgfP72pOg/FK5SqokRu0sk8DIYo2Od3GW0K0En2YNJorZ/TCNW8c6uDYWIEIETziNFih0r09S2kHbjxiPDDR9gP9SS93wZNlS9rrRCpCu5B+HjjD7K0iYdOo7npOlSU6eMhxlHv7Kv5MSizgCktdU61l7e1Jjm0bfO6xM64Sxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fq6M9ISv; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uC32dZuS; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722243501; x=1753779501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wzFk13fokJzQ54DJXEnDFeRirevXKat2s+3NoN1UZNk=;
  b=Fq6M9ISvmAmvCLVMh1roeIBPhpZ37rXa1AtRJ7SSd7IzhMhxwgquiFRU
   Rh/DDaw7A1V9WXyWO8nYHi+icTv+oI0Iy9QoqykRsWxSbtOVHMFiC7HGd
   zCv6brAHcTgWLJDIqVHBgZ1kT04AoxE2bpGSrv0ilOwrRXymEBeDyYIOK
   5DezMYtANaCJMjWZBe05AoiQWfC7E6yO+bhzZZOP0PX9dpiXWVM5zzecy
   3N0cQgEGOi/fElO2dHtNdneixxOCiLARIdL48q7V7G8h/S2+1p+OTo/1s
   G9TMpRUOO4dtyoD4X+88mv7WJIR0Nx5jYOCdFF3MBNL84FMG+XrAYochl
   g==;
X-CSE-ConnectionGUID: YBWlVYYeR9CPr+ybFsYZoA==
X-CSE-MsgGUID: zF6t+Sy+SYu4Wj6py4UgNg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="260701663"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 01:58:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 01:57:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 01:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0MsQeMFWRQgIPEsYFuhfmMF3K/dIn2I2R4eCYXxJk10WIzAtvp0jrN9z+m055Luv1iKVUQZmzNhZpQzw84+xrExU+etP0hlWBXXkf6VR8FQRFkWCcN3Fahg7j4XZX7c0E6RvW9jCPogxtjt4zmK0odtt9E4rYsh0OixxnqrKV+rF8gQeAt0jQRfH7DrdMDaIit+lYZ1UNf5FSg/XzyhoOT+u/YkLkABefK0qYVhULEUSUD9D4LeXQYhRyWtsZ0B3asrwCNyFa86ojNpKfduwzOj3BwHzVddmak+wXmqQ13GMTZuQdagibtD+OVIcyKte2MCDIPFsCFRzHe88HYPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzFk13fokJzQ54DJXEnDFeRirevXKat2s+3NoN1UZNk=;
 b=ILaMa2l+8FdTmoV3flJKta6pxuTHHZboMtINHpPUmwTkX7kNDy/FUQD7ciiyTmexzsOjn7ykj0b4W24By/wSpqO0B3Ey+E2fkQ1YSeUPFo31MpYBZlmflGcr0jYsCCXxW4iJp7C/FKr3dEqaoVXc7BPVGBiZ5GtpIhfq3gDJr5IG3QT17N1vWJmmPSiEpX1WccrK5s8oOWR6FkN0UCIyPHL7/NhYuWpwj5eTG3ftGfAmripl6c+2I8tBvCBsIjyUH5kKi8k4naIC/8IXmSY5SCGDdPJsKIGUKORpG/lO8PNrAdZOMaefS+PY4Dv6YDyIQQwzOholV8oA2gCObxLOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzFk13fokJzQ54DJXEnDFeRirevXKat2s+3NoN1UZNk=;
 b=uC32dZuSLXlA54WXz9OwCaO1hCklmInWuVoN0Yop15JmJrwIuRSRa6V8AQEG0R0keBhqu2syFMFwL8rOwIYNd4SnwLNLg0PxcMMIYzJKCoBFHf74H+SA5jQA6O18c0d7pV4/pZwf0eHYR93r4QktHlQKJ+JfLsgc3ItjsWdVpUzj1vSTBYrsJWUFale68XwnWMy8RP31A68oe2MUkIWoIqMUYfSEFp2gXcAUL81Ica/6VAdmXtz/BmumK7NGLBuEWnQlfOHlunDFBzBFht/TLdvQHZ/IGDL91Ynsdd/4g0+mzncVPbCS1GFYeaJROOvdsTJWXC2F2A50epXGZ04Dug==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 08:57:50 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 08:57:50 +0000
From: <Varshini.Rajendran@microchip.com>
To: <Andrei.Simion@microchip.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<tglx@linutronix.de>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>, <richard.genoud@bootlin.com>,
	<radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ychuang3@nuvoton.com>,
	<schung@nuvoton.com>, <Mihai.Sain@microchip.com>, <arnd@arndb.de>,
	<Jason@zx2c4.com>, <Dharma.B@microchip.com>, <rdunlap@infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v6 00/27] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v6 00/27] Add support for sam9x7 SoC family
Thread-Index: AQHa4YRtEsAhUT6p0Em4gn0OaGWz+rINXGWAgAALVwA=
Date: Mon, 29 Jul 2024 08:57:49 +0000
Message-ID: <b46f65ba-3d1a-4b00-b6c2-10787346d6e3@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <f49f5585-ab7f-4f3e-990e-4ba32ee503d7@microchip.com>
In-Reply-To: <f49f5585-ab7f-4f3e-990e-4ba32ee503d7@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|MW3PR11MB4651:EE_
x-ms-office365-filtering-correlation-id: 732ea712-d0e1-437c-ea4f-08dcafac8632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZS92TWZJMDFzWXdIUmYyamgzSFFNK0JISnNEaGF5dDdGakgyRXVFTHMvR3Jh?=
 =?utf-8?B?Smg2Wm5rUUxTeFlEQTVtTWZMUHFsWnR0dkJSZWtRV0tmd3EwVjNnQ2RGbWwy?=
 =?utf-8?B?MkNYMnR2ZXA4bVVUc1BLQ090eE1sZlpPd2Z3ZE5tVzdHM3pRejNJd2NLKzAy?=
 =?utf-8?B?ZGVpZVJKNk8xcjZ6Qm95eTZVOGxmbUwxSmVKYkdHTTRqZHAybkQ4RlNBTE0y?=
 =?utf-8?B?UHBEdDdJV2FqdXpDbm5TWUdZVGp2VWFTYll1d1gyQXNxRVVtRm1jd3hJYXBu?=
 =?utf-8?B?R2ROZ056ZFhpaEZVclBJTmkxekhoVnltbmF1bitGRmVpY0VmcWpoVUtmZmQz?=
 =?utf-8?B?T3BKS0JHZ2JZRENEQVRKbnZncmtwbU5ZWDd0RWdDTGxWdXIxTDNlOXFjV3dk?=
 =?utf-8?B?MVZSK2Q2dE03L1dOSkRRSmhWWms3UE04OHBEQXRGbGw2MzFleHdPaU5Cc3ZI?=
 =?utf-8?B?WnkzQ1JvS2phdHRDZDJhS2VLUFRIcGd5VXoreE5QR3NBVHQ0U1FhenkzT3Zp?=
 =?utf-8?B?WHpvMnViNURDL2NUU2sxS2lrMm1HT3YrWkZqejVPN2svcW1SZXczcTBQbXkv?=
 =?utf-8?B?cy92bkVKUmdzRDBzeDhLNGRsZmluZEtRakZpVWpVTGtSY3kyRktZREdzeDNV?=
 =?utf-8?B?eVY4UHZWOUVpSjQ0bkJyYnJIZUtza3dwUHZiMGxkdTV0MFo1Y0gwbEorWEVG?=
 =?utf-8?B?S3Bpa1J6ZHJwendUWWZlOE1INlhCVlpsSlg5Q1gzditQYllJY1o1Z09rSHVu?=
 =?utf-8?B?NzBWV1pDRThyTCtDbXR0bEJOeDlnbGg5WHplQ1NzSG5WQ05rTHY0aU9JUmNw?=
 =?utf-8?B?MWlZdDczMGUvcmJKMW1yZEl2bDVIL3Q0TTBua3I3NTdXNVBnT1ljM3o5R0JP?=
 =?utf-8?B?eC9Bb09kSVppMDNqTnpHcEVLelRaazZwSmR5L0ljdjJFQy9ZcGU4a0phZVcz?=
 =?utf-8?B?b2lrUGtPVkZEYXlZZDV2bnpwZ1FpZVFkZklNQVNFTkI4V3F2Vng3WVptRndz?=
 =?utf-8?B?VUROMFY0TXIyTyt6Y3ZxSkRXcnBKMVdqMDZ0MHlwcGUzeVRVY3RPRnVTcHl4?=
 =?utf-8?B?NTNvUFEyajluSEJzS2RHdjRPR240MTNDdndPejh2WXBFVU9sNnZ3OGlOblFu?=
 =?utf-8?B?SHArZjBpM0RYQ0NEMExMNTBBM1FDWkN2S1BkRVVCbnI0bFFaZSt0SXRvdmdJ?=
 =?utf-8?B?WFZQZ3MzK3hhT0RWb2Q1UVhEemxtSkpCMi9mSlNWQnVBSk01dnRkWG5ZNnpv?=
 =?utf-8?B?bGxuVDFEOEgrSUpDUUVSQ1pzU1I3OGdabGFmZDVDN2JYYkFQOHl0djk5T0tw?=
 =?utf-8?B?WE04aTU2STRxTTJDRXd0Rk9JbzVDcFM3OGFNM1laNCtEVEllZVBuWFEvQytK?=
 =?utf-8?B?aVJ1YzlwQ0dvV1B0SWZ2L1Q3cUtCbjhLTFZTRzJicnUveFNBRXgrUEk2ZThz?=
 =?utf-8?B?cWZ0UkY1OHFNd0FFVVZDdVJNUm5NNHBNeXhvZE9xOFJvR0pYNVFPVXNJSEU0?=
 =?utf-8?B?M25kM21ENGlWKzkyRkNyV0tLSEJCZHlHUjI5dFdlWVJUcDBEaWRUSktBcEtC?=
 =?utf-8?B?eCtSQVBNYnczZUlGdk9LVkt4NnlsSmZudGNSS3puRkpEaTFIQ0lRMVp5cDZ6?=
 =?utf-8?B?bkRIOTZpMzNMeW1KTS9XcWd0K1JUVjQxbEd0RmE5WlBaSWV4UkE0THlhdUp0?=
 =?utf-8?B?bEg3R2pTWVl1aTd5b0g4bTZmcG5xWHRBSTk0UFk4WDZTejNoaU9BSlhGY3FR?=
 =?utf-8?B?dDJkWVI3UkhWVmgyQUwyWkN0ajJ2ZDloTjg4QkJyUG93UHJzQkM0a2w1U1ZH?=
 =?utf-8?Q?RMLmEWezabxc9btw2g2lK/GllWwmZZu2RYmp8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0w1am5vN0pzeC9Ra3Vxdi9YUW1IVDRxTWE0QTNyQldvNHVKajhNU2piN0Vz?=
 =?utf-8?B?RFBvUmhyNm91ZkpwREhNYVNoUkFtSGJmQVlOVDFBa0pyV1RlL3g2b2F6NTA5?=
 =?utf-8?B?SUtUY1BROU5QbmpVcjdyWGdneGtod0thL2lJbFlZMkJML0ZlZnZFN1FnWUlF?=
 =?utf-8?B?MThDRVJBMDgvbVN6b1hBenpNVGZMNkQxZWc0VlhTRC9MaWttM2FzRlR5b3Nt?=
 =?utf-8?B?Mlo0TXpMZTByc2tHMnE0bHRxU0R0dUxJdHJxbjhpRHEzbGhTMWdFem4vcDZs?=
 =?utf-8?B?TGw4NC8xbVpVb0NEYlRYM0NKaVVzM0hiTHVEQ2tmUnprZzBKa3RyYXk2NVFK?=
 =?utf-8?B?UnVJZE1Mc1RhZTJ3dmhNeCtuUUgrbGZTazY1eEgwaVg5Y1lTbldtR1ppZGsr?=
 =?utf-8?B?M05mNHMzaHJxb1ROQ2FyR3VQdm1mc3ZYWW5xcmRla0h2REpmVjhlcFphUk0x?=
 =?utf-8?B?YTBNT1ltN1VWaktVc2dNYnRXM09mdlVxREhWQkhseXR5SWFtUlJMK2NvRGZ0?=
 =?utf-8?B?TzlzZ3EvNXVnbXdiVDFhVGRFRVpnWW9YZksxcmNFdi9Ha1BVYkVJOS9pRXdR?=
 =?utf-8?B?bVpaQnlzbDBFQzV5STIrUmhBN1lEZ2RYMVR5eiszZTJ0RGxxbURVbE9tOFdZ?=
 =?utf-8?B?a0pLN3ZOdVFBUUEzcFJYNExEREl3MHQ1Mko3L0RWTkNSeG9LMzBxVDZDSEVa?=
 =?utf-8?B?RHZxenNZRDVndVp6WUZPNk12Y3ptMG53SHNEM253eHgwUytpbmZ5UHo5cTE2?=
 =?utf-8?B?d3dLWXdjZE5PaUQ2SGVVTHUzM3BCWlR5NXJIWjM4eEVKQnlzMkozbnY0QmYw?=
 =?utf-8?B?WDY2QUZLUkQyQnk2cUFscjAyK1hpYTlQd1kyK3hONHl4N3QyMmd5cW1OZGJL?=
 =?utf-8?B?R3kwNGxLSWRMaUJWQjU0WTIvTXNkMHMyVjV6MEVoV3c5MTBLQnMvR01yVFZa?=
 =?utf-8?B?Smkzd2ZTRVcvOTR6RkJOdEI0dWZHQjNBTld3V2RuQ3YxeXhhSjB6M1UrZ0Rw?=
 =?utf-8?B?bDBOVWcxRHF4eis0aEpNc3ltbkM5MFZtd0ExdlJRaTkzbW8xY2NRNVFIQVpL?=
 =?utf-8?B?ekRqNHZVQndMZGVHak45c3B2bzZoUFFmTi95bHM2RWFXbENDcERiSS9zY3hO?=
 =?utf-8?B?MEZwak96U3JjamhGc1dIWHh4aUwwTC9mbUlKVFhYMGpaSm90c3cwUkNYQnM3?=
 =?utf-8?B?Q24wTlpITHRZQ1RpSXgrODFPcGFrU0UvWGVNK0xtdFdBWU03aHRaQjlCbm5V?=
 =?utf-8?B?MHJTSURJdy9wRVcvRVdGcUFsanVzR05Jb1prYzd1Mlk1SE1Nd0laRUlzZFZL?=
 =?utf-8?B?aDJrZ1ZrenBOV0FLbUVzNnhyWDNzK0l1dlZjeVdDK2l2WkRPa05rUFljVXFF?=
 =?utf-8?B?NWorN2gyU0h5M3g3ZlNXd2JwYVpTK21mZW5ld1NlWFF3djZpRTQ1c3pmTmQr?=
 =?utf-8?B?VTBUY1lmOEVmQzQrUTRFZ3ZYZzRvMVJQdkRtQ2UzYXYvUlBwSW5LZlduZXlC?=
 =?utf-8?B?cDRjaTZNaWo2V2VoTjd3M2g2a1JiazZCYkp1SGhkMGJ2c0RyWDhKMkV4MTBD?=
 =?utf-8?B?RWFrOUtVbis5RERjb3dianB6YXZ1cEUvWEVsU2krQ0o3cmUvV2VWK2tSbGI5?=
 =?utf-8?B?SjVJMUJRMVVLUTZmRnErVGsyMjZ3aUl0Z2JCTjZQODRBaU42ZEoyR1lKdThh?=
 =?utf-8?B?QnJuMmlTcFJCbmtBQmVpR2JhdHdBOWpGanQwdHpWYUczdzlBbk0zQnE4Vlcv?=
 =?utf-8?B?TVhsS2hFelUvMWRCYjJ0RS9tMXZlSUVtdTJ5aG1hUjhpSTBOV3lBWUttUVNR?=
 =?utf-8?B?bUxNakNTc3B6RmMzdzEvTUVvTDI2c1QxUlZhaFBaNGFWYXg4QmRyUmtZQTBK?=
 =?utf-8?B?L01FOER5dkRwMWVRbmZIZ2k4MlMwK2Y3YjJyQ3lDK0NrelRHWU1iNmlCejJz?=
 =?utf-8?B?cDJRK3NqVndEcHgvNldBNm5rb0c2ZTFGbEp5Q3pVZnl1UWZLSkJ2RU5CbDRX?=
 =?utf-8?B?SHFPQnlXazJqL0ZBdWJtdVovSzZQNEE1a25CUVRUaU9NK2NpWjJWR2dTTHpI?=
 =?utf-8?B?MUxWSnRFUWNkSjhZbmRlczc3dThDeC9EV2ZVWFZzVTJtSWRIWktHQlBkRmp0?=
 =?utf-8?B?REcvcWJsejh6b3BlQVZYZk5CZ2N3ZTJ5VUQyc1Q1MmRQYjJ1aks2ZHZkUTVl?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3704DBA6F7D79469EC474B356ECA2ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ea712-d0e1-437c-ea4f-08dcafac8632
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 08:57:49.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1FUmMkajU2V/6Fuatxc0y/tRFRUdPzhLyU7Ib2KQp0Fs20kVpJ67p9E92n8wwlGCQvCP0/q2itTqK7wrMMcJkey7hwjjllE4V8NhlRMUPI7Ce/OGXyaxFu2Y0dmNBQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651

T24gMjkvMDcvMjQgMTo0NyBwbSwgQW5kcmVpIFNpbWlvbiAtIE03NjY3NyB3cm90ZToNCj4gT24g
MjkuMDcuMjAyNCAwOTo1NiwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4gVGhpcyBwYXRj
aCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgbmV3IFNvQyBmYW1pbHkgLSBzYW05eDcuDQo+
PiAgIC0gVGhlIGRldmljZSB0cmVlLCBjb25maWdzIGFuZCBkcml2ZXJzIGFyZSBhZGRlZA0KPj4g
ICAtIENsb2NrIGRyaXZlciBmb3Igc2FtOXg3IGlzIGFkZGVkDQo+PiAgIC0gU3VwcG9ydCBmb3Ig
YmFzaWMgcGVyaXBoZXJhbHMgaXMgYWRkZWQNCj4+ICAgLSBUYXJnZXQgYm9hcmQgU0FNOVg3NSBD
dXJpb3NpdHkgaXMgYWRkZWQNCj4+DQo+PiAgIENoYW5nZXMgaW4gdjY6DQo+PiAgIC0tLS0tLS0t
LS0tLS0tDQo+Pg0KPj4gICAtIEFkZHJlc3NlZCBhbGwgdGhlIHJldmlldyBjb21tZW50cyBpbiB0
aGUgcGF0Y2hlcw0KPj4gICAtIFBpY2tlZCB1cCBhbGwgQWNrZWQtYnkgYW5kIFJldmlld2VkLWJ5
IHRhZ3MNCj4+ICAgLSBSZXZlcnRlZCB0aGUgSVJRIHBhdGNoIHRvIHRoYXQgb2YgdmVyc2lvbiAz
IG9mIHRoZSBzYW1lIHNlcmllcw0KPj4gICAtIEFsbCB0aGUgc3BlY2lmaWMgY2hhbmdlcyBhcmUg
Y2FwdHVyZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcw0KPj4NCj4+ICAgQ2hhbmdlcyBp
biB2NToNCj4+ICAgLS0tLS0tLS0tLS0tLS0NCj4+DQo+PiAgIC0gQWRkcmVzc2VkIGFsbCB0aGUg
cmV2aWV3IGNvbW1lbnRzIGluIHRoZSBwYXRjaGVzDQo+PiAgIC0gUGlja2VkIHVwIGFsbCBBY2tl
ZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPj4gICAtIERyb3BwZWQgYXBwbGllZCBwYXRjaGVz
IGZyb20gdGhlIHNlcmllcw0KPj4gICAtIEFkZHJlc3NlZCB0aGUgQUJJIGJyZWFrYWdlIHJlcG9y
dGVkIGluIHRoZSBJUlEgcGF0Y2gNCj4+ICAgLSBBbGwgdGhlIHNwZWNpZmljIGNoYW5nZXMgYXJl
IGNhcHR1cmVkIGluIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoZXMNCj4+DQo+PiAgIENoYW5nZXMg
aW4gdjQ6DQo+PiAgIC0tLS0tLS0tLS0tLS0tDQo+Pg0KPj4gICAtIEFkZHJlc3NlZCBhbGwgdGhl
IHJldmlldyBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcw0KPj4gICAtIFBpY2tlZCB1cCBhbGwgQWNr
ZWQtYnkgYW5kIFJldmlld2VkLWJ5IHRhZ3MNCj4+ICAgLSBEcm9wcGVkIGFwcGxpZWQgcGF0Y2hl
cyBmcm9tIHRoZSBzZXJpZXMNCj4+ICAgLSBBZGRlZCBwd20gbm9kZSBhbmQgcmVsYXRlZCBkdCBi
aW5kaW5nIGRvY3VtZW50YXRpb24NCj4+ICAgLSBBZGRlZCBzdXBwb3J0IGZvciBleHBvcnRpbmcg
c29tZSBjbG9ja3MgdG8gRFQNCj4+ICAgLSBEcm9wcGVkIFVTQiByZWxhdGVkIHBhdGNoZXMgYW5k
IGNoYW5nZXMuIFNlZSBOT1RFLg0KPj4gICAtIEFsbCB0aGUgc3BlY2lmaWMgY2hhbmdlcyBhcmUg
Y2FwdHVyZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcw0KPj4NCj4+ICAgTk9URTogT3dp
bmcgdG8gdGhlIGRpc2N1c3Npb24gaGVyZQ0KPj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1kZXZpY2V0cmVlL0NBTF9Kc3FKOVByWDZmai1FYmZmZUpjZTA5TVhzPUI3dCtLU19rT2lu
eGFSeDM4PVd4QUBtYWlsLmdtYWlsLmNvbS8NCj4+ICAgdGhlIFVTQiByZWxhdGVkIGNoYW5nZXMg
YXJlIGRyb3BwZWQgZnJvbSB0aGlzIHNlcmllcyBpbiBvcmRlciB0byBlbmFibGUNCj4+ICAgdXMg
dG8gd29yayBvbiB0aGUgbWVudGlvbmVkIGlzc3VlcyBiZWZvcmUgYWRkaW5nIG5ldyBjb21wYXRp
YmxlcyBhcw0KPj4gICBzYWlkLiBUaGUgaXNzdWVzL3dhcm5pbmdzIHdpbGwgYmUgYWRkcmVzc2Vk
IGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4+ICAgQWZ0ZXIgd2hpY2ggdGhlIFVTQiByZWxhdGVk
IHN1cHBvcnQgZm9yIHNhbTl4NyBTb0NzIHdpbGwgYmUgYWRkZWQuIEhvcGUNCj4+ICAgdGhpcyB3
b3JrcyBvdXQgZmluZS4NCj4+DQo+PiAgIENoYW5nZXMgaW4gdjM6DQo+PiAgIC0tLS0tLS0tLS0t
LS0tDQo+Pg0KPj4gICAtIEZpeGVkIHRoZSBEVCBkb2N1bWVudGF0aW9uIGVycm9ycyBwb2ludGVk
IG91dCBpbiB2Mi4NCj4+ICAgLSBEcm9wcGVkIEFja2VkLWJ5IHRhZyBpbiB0Y2IgRFQgZG9jIHBh
dGNoIGFzIGl0IGhhZCB0byBiZSBhZGFwdGVkDQo+PiAgICAgYWNjb3JkaW5nIHRvIHNhbTl4NyBj
b3JyZWN0bHkuDQo+PiAgIC0gUGlja2VkIGJ5IHRoZSBwcmV2aW91c2x5IG1pc3NlZCB0YWdzLg0K
Pj4gICAtIERyb3BwZWQgdGhpcyBwYXRjaCAiZHQtYmluZGluZ3M6IHVzYjogZ2VuZXJpYy1laGNp
OiBEb2N1bWVudCBjbG9jay1uYW1lcw0KPj4gICAgIHByb3BlcnR5IiBhcyB0aGUgd2FybmluZyB3
YXMgbm90IGZvdW5kIHdoaWxlIHZhbGlkYXRpbmcgRFQtc2NoZW1hIGZvcg0KPj4gICAgIGF0OTEt
c2FtOXg3NV9jdXJpb3NpdHkuZHRiLg0KPj4gICAtIERyb3BwZWQgcmVkdW5kYW50IHdvcmRzIGlu
IHRoZSBjb21taXQgbWVzc2FnZS4NCj4+ICAgLSBGaXhlZCB0aGUgQ0hFQ0tfRFRCUyB3YXJuaW5n
cyB2YWxpZGF0ZWQgYWdhaW5zdA0KPj4gICAgIGF0OTEtc2FtOXg3NV9jdXJpb3NpdHkuZHRiLg0K
Pj4gICAtIFJlbmFtZWQgZHQgbm9kZXMgYWNjb3JkaW5nIHRvIG5hbWluZyBjb252ZW50aW9uLg0K
Pj4gICAtIERyb3BwZWQgdW53YW50ZWQgc3RhdHVzIHByb3BlcnR5IGluIGR0cy4NCj4+ICAgLSBS
ZW1vdmVkIG5vZGVzIHRoYXQgYXJlIG5vdCBpbiB1c2UgZnJvbSB0aGUgYm9hcmQgZHRzLg0KPj4g
ICAtIFJlbW92ZWQgc3BpIERUIGRvYyBwYXRjaCBmcm9tIHRoZSBzZXJpZXMgYXMgaXQgd2FzIGFs
cmVhZHkgYXBwbGllZA0KPj4gICAgIGFuZCBhIGZpeCBwYXRjaCB3YXMgYXBwbGllZCBzdWJzZXF1
ZW50bHkuIEFkZGVkIGEgcGF0Y2ggdG8gcmVtb3ZlIHRoZQ0KPj4gICAgIGNvbXBhdGlibGUgdG8g
YWRhcHQgc2FtOXg3Lg0KPj4gICAtIEFkZGVkIHNhbTl4NyBjb21wYXRpYmxlcyBpbiB1c2IgZHQg
ZG9jdW1lbnRhdGlvbi4NCj4+DQo+Pg0KPj4gICBDaGFuZ2VzIGluIHYyOg0KPj4gICAtLS0tLS0t
LS0tLS0tLQ0KPj4NCj4+ICAgLSBBZGRlZCBzYW05eDcgc3BlY2lmaWMgY29tcGF0aWJsZXMgaW4g
RFQgd2l0aCBmYWxsYmFja3MNCj4+ICAgLSBEb2N1bWVudGVkIGFsbCB0aGUgbmV3bHkgYWRkZWQg
RFQgY29tcGF0aWJsZSBzdHJpbmdzDQo+PiAgIC0gQWRkZWQgZGV2aWNlIHRyZWUgZm9yIHRoZSB0
YXJnZXQgYm9hcmQgc2FtOXg3NSBjdXJpb3NpdHkgYW5kDQo+PiAgICAgZG9jdW1lbnRlZCB0aGUg
c2FtZSBpbiB0aGUgRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KPj4gICAtIFJlbW92ZWQgdGhl
IGR0IG5vZGVzIHRoYXQgYXJlIG5vdCBzdXBwb3J0ZWQgYXQgdGhlIG1vbWVudA0KPj4gICAtIFJl
bW92ZWQgdGhlIGNvbmZpZ3MgYWRkZWQgYnkgcHJldmlvdXMgdmVyc2lvbiB0aGF0IGFyZSBub3Qg
c3VwcG9ydGVkDQo+PiAgICAgYXQgdGhlIG1vbWVudA0KPj4gICAtIEZpeGVkIGFsbCB0aGUgY29y
cmVjdGlvbnMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+PiAgIC0gQ2hhbmdlZCBhbGwgdGhlIGlu
c3RhbmNlcyBvZiBjb3B5cmlnaHQgeWVhciB0byAyMDIzDQo+PiAgIC0gQWRkZWQgc2FtOXg3IGZs
YWcgaW4gUElUNjRCIGNvbmZpZ3VyYXRpb24NCj4+ICAgLSBNb3ZlZCBtYWNybyBkZWZpbml0aW9u
cyB0byBoZWFkZXIgZmlsZQ0KPj4gICAtIEFkZGVkIGFub3RoZXIgZGl2aWRlciBpbiBtY2sgY2hh
cmFjdGVyaXN0aWNzIGluIHRoZSBwbWMgZHJpdmVyDQo+PiAgIC0gRml4ZWQgdGhlIG1lbW9yeSBs
ZWFrIGluIHRoZSBwbWMgZHJpdmVyDQo+PiAgIC0gRHJvcHBlZCBwYXRjaGVzIHRoYXQgYXJlIG5v
IGxvbmdlciBuZWVkZWQNCj4+ICAgLSBQaWNrZWQgdXAgQWNrZWQtYnkgYW5kIFJldmlld2VkLWJ5
IHRhZ3MNCj4+DQo+Pg0KPj4gSGFyaSBQcmFzYXRoICgxKToNCj4+ICAgIGlycWNoaXAvYXRtZWwt
YWljNTogQWRkIHN1cHBvcnQgZm9yIHNhbTl4NyBhaWMNCj4+DQo+PiBWYXJzaGluaSBSYWplbmRy
YW4gKDI2KToNCj4+ICAgIGR0LWJpbmRpbmdzOiBhdG1lbC1zeXNyZWc6IGFkZCBzYW05eDcNCj4+
ICAgIGR0LWJpbmRpbmdzOiBtZmQ6IHN5c2NvbjogYWRkIG1pY3JvY2hpcCdzIHNhbTl4NyBzZnIN
Cj4+ICAgIGR0LWJpbmRpbmdzOiBhdG1lbC1zc2M6IGFkZCBtaWNyb2NoaXAsc2FtOXg3LXNzYw0K
Pj4gICAgZHQtYmluZGluZ3M6IHNlcmlhbDogYXRtZWwsYXQ5MS11c2FydDogYWRkIGNvbXBhdGli
bGUgZm9yIHNhbTl4Ny4NCj4+ICAgIGR0LWJpbmRpbmdzOiBtaWNyb2NoaXA6IGF0bWVsLGF0OTFy
bTkyMDAtdGNiOiBhZGQgc2FtOXg3IGNvbXBhdGlibGUNCj4+ICAgIEFSTTogYXQ5MTogcG06IGFk
ZCBzdXBwb3J0IGZvciBzYW05eDcgU29DIGZhbWlseQ0KPj4gICAgQVJNOiBhdDkxOiBwbTogYWRk
IHNhbTl4NyBTb0MgaW5pdCBjb25maWcNCj4+ICAgIEFSTTogYXQ5MTogYWRkIHN1cHBvcnQgaW4g
U29DIGRyaXZlciBmb3IgbmV3IHNhbTl4Nw0KPj4gICAgZHQtYmluZGluZ3M6IGNsb2NrczogYXRt
ZWwsYXQ5MXNhbTl4NS1zY2tjOiBhZGQgc2FtOXg3DQo+PiAgICBkdC1iaW5kaW5nczogY2xvY2tz
OiBhdG1lbCxhdDkxcm05MjAwLXBtYzogYWRkIHNhbTl4NyBjbG9jayBjb250cm9sbGVyDQo+PiAg
ICBjbGs6IGF0OTE6IGNsay1zYW05eDYwLXBsbDogcmUtZmFjdG9yIHRvIHN1cHBvcnQgaW5kaXZp
ZHVhbCBjb3JlIGZyZXENCj4+ICAgICAgb3V0cHV0cw0KPj4gICAgY2xrOiBhdDkxOiBzYW05eDc6
IGFkZCBzdXBwb3J0IGZvciBIVyBQTEwgZnJlcSBkaXZpZGVycw0KPj4gICAgY2xrOiBhdDkxOiBz
YW1hN2c1OiBtb3ZlIG11eCB0YWJsZSBtYWNyb3MgdG8gaGVhZGVyIGZpbGUNCj4+ICAgIGR0LWJp
bmRpbmdzOiBjbG9jazogYXQ5MTogQWxsb3cgUExMcyB0byBiZSBleHBvcnRlZCBhbmQgcmVmZXJl
bmNlZCBpbg0KPj4gICAgICBEVA0KPj4gICAgY2xrOiBhdDkxOiBzYW05eDc6IGFkZCBzYW05eDcg
cG1jIGRyaXZlcg0KPj4gICAgZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250cm9sbGVyOiBBZGQg
c3VwcG9ydCBmb3Igc2FtOXg3IGFpYw0KPj4gICAgcG93ZXI6IHJlc2V0OiBhdDkxLXBvd2Vyb2Zm
OiBsb29rdXAgZm9yIHByb3BlciBwbWMgZHQgbm9kZSBmb3Igc2FtOXg3DQo+PiAgICBwb3dlcjog
cmVzZXQ6IGF0OTEtcmVzZXQ6IGFkZCByZXNldCBzdXBwb3J0IGZvciBzYW05eDcgU29DDQo+PiAg
ICBwb3dlcjogcmVzZXQ6IGF0OTEtcmVzZXQ6IGFkZCBzZGh3YyBzdXBwb3J0IGZvciBzYW05eDcg
U29DDQo+PiAgICBkdC1iaW5kaW5nczogcmVzZXQ6IGF0bWVsLGF0OTFzYW05MjYwLXJlc2V0OiBh
ZGQgc2FtOXg3DQo+PiAgICBkdC1iaW5kaW5nczogcG93ZXI6IHJlc2V0OiBhdG1lbCxzYW1hNWQy
LXNoZHdjOiBhZGQgc2FtOXg3DQo+PiAgICBBUk06IGF0OTE6IEtjb25maWc6IGFkZCBjb25maWcg
ZmxhZyBmb3IgU0FNOVg3IFNvQw0KPj4gICAgQVJNOiBjb25maWdzOiBhdDkxOiBlbmFibGUgY29u
ZmlnIGZsYWdzIGZvciBzYW05eDcgU29DIGZhbWlseQ0KPj4gICAgQVJNOiBkdHM6IGF0OTE6IHNh
bTl4NzogYWRkIGRldmljZSB0cmVlIGZvciBTb0MNCj4+ICAgIGR0LWJpbmRpbmdzOiBhcm06IGFk
ZCBzYW05eDc1IGN1cmlvc2l0eSBib2FyZA0KPj4gICAgQVJNOiBkdHM6IG1pY3JvY2hpcDogc2Ft
OXg3NV9jdXJpb3NpdHk6IGFkZCBzYW05eDc1IGN1cmlvc2l0eSBib2FyZA0KPj4NCj4+ICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbCAgIHwgICAgNiArDQo+PiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCB8ICAgIDYgKy0N
Cj4+ICAgLi4uL2JpbmRpbmdzL2Nsb2NrL2F0bWVsLGF0OTFybTkyMDAtcG1jLnlhbWwgIHwgICAg
MiArDQo+PiAgIC4uLi9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxc2FtOXg1LXNja2MueWFtbCB8
ICAgIDQgKy0NCj4+ICAgLi4uL2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy55YW1sICAg
ICAgIHwgICAgMSArDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zeXNjb24ueWFt
bCAgICAgICB8ICAxODggKy0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYXRt
ZWwtc3NjLnR4dCAgICB8ICAgIDEgKw0KPj4gICAuLi4vcG93ZXIvcmVzZXQvYXRtZWwsc2FtYTVk
Mi1zaGR3Yy55YW1sICAgICAgfCAgICAzICsNCj4+ICAgLi4uL3Jlc2V0L2F0bWVsLGF0OTFzYW05
MjYwLXJlc2V0LnlhbWwgICAgICAgIHwgICAgNCArDQo+PiAgIC4uLi9iaW5kaW5ncy9zZXJpYWwv
YXRtZWwsYXQ5MS11c2FydC55YW1sICAgICB8ICAgIDkgKy0NCj4+ICAgLi4uL3NvYy9taWNyb2No
aXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbCAgIHwgICAyMCArLQ0KPj4gICBhcmNoL2FybS9i
b290L2R0cy9taWNyb2NoaXAvTWFrZWZpbGUgICAgICAgICAgfCAgICAzICsNCj4+ICAgLi4uL2R0
cy9taWNyb2NoaXAvYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS5kdHMgIHwgIDMxMiArKysrKw0KPj4g
ICBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2FtOXg3LmR0c2kgICAgICAgfCAxMjI2ICsr
KysrKysrKysrKysrKysrDQo+IA0KPiBIaSwNCj4gDQo+IFNvcnJ5IGZvciBkaXN0dXJiaW5nLCBJ
IGRvbid0IHNlZSB0aGUgcGF0Y2ggd2hlcmUgeW91IGFkZCBhcmNoL2FybS9ib290L2R0cy9taWNy
b2NoaXAvc2FtOXg3LmR0c2kNCj4gSW4gbGludXgtbmV4dCB0aGlzIGZpbGUgaXMgbm90IGFwcGxp
ZWQgeWV0Og0KPiA6fiQgZmluZCBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAgfCBncmVwIC1p
IHNhbTl4Ny5kdHNpIHwgd2MgLWwNCj4gMA0KPiANCkhpIEFuZHJlaSwNCg0KSSBkb24ndCBxdWl0
ZSBnZXQgeW91ciBxdWVyeS4gSSBhbSBhbnN3ZXJpbmcgaW4gYSBwcmVzdW1wdGlvbiB0aGF0IHlv
dSANCmFyZSBlbnF1aXJpbmcgYWJvdXQgdGhlIHNhbTl4Ny5kdHNpIGZpbGUgcHJlc2VuY2UuDQoN
ClRoaXMgZmlsZSBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2FtOXg3LmR0c2kgaXMgYmVp
bmcgYWRkZWQgaW4gdGhpcyANCnZlcnkgc2VyaWVzIGJ5IHBhdGNoIDI1LzI3LiBJdCBpcyBub3Qg
eWV0IGFwcGxpZWQsIGhlbmNlIHdpbGwgbm90IGJlIA0KYXZhaWxhYmxlIGluIGFueSBvZiB0aGUg
dXBzdHJlYW0gcmVwb3MuDQoNCihQLlMuOiBTb3JyeSBmb3IgdGhlIG5vaXNlIGFuZCB0aGUgd2lk
ZSBhdWRpZW5jZSkNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEFuZHJlaQ0KPiANCj4+ICAgYXJjaC9h
cm0vY29uZmlncy9hdDkxX2R0X2RlZmNvbmZpZyAgICAgICAgICAgIHwgICAgMSArDQo+PiAgIGFy
Y2gvYXJtL21hY2gtYXQ5MS9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMjIgKy0NCj4+
ICAgYXJjaC9hcm0vbWFjaC1hdDkxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAgMSAr
DQo+PiAgIGFyY2gvYXJtL21hY2gtYXQ5MS9nZW5lcmljLmggICAgICAgICAgICAgICAgICB8ICAg
IDIgKw0KPj4gICBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYyAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDI5ICsNCj4+ICAgYXJjaC9hcm0vbWFjaC1hdDkxL3NhbTl4Ny5jICAgICAgICAgICAgICAg
ICAgIHwgICAzMyArDQo+PiAgIGRyaXZlcnMvY2xrL2F0OTEvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1zYW05eDYwLXBsbC5j
ICAgICAgICAgICAgfCAgIDQyICstDQo+PiAgIGRyaXZlcnMvY2xrL2F0OTEvcG1jLmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMTggKw0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAu
YyAgICAgICAgICAgICAgICAgICAgfCAgICA3ICsNCj4+ICAgZHJpdmVycy9jbGsvYXQ5MS9zYW05
eDcuYyAgICAgICAgICAgICAgICAgICAgIHwgIDk0NiArKysrKysrKysrKysrDQo+PiAgIGRyaXZl
cnMvY2xrL2F0OTEvc2FtYTdnNS5jICAgICAgICAgICAgICAgICAgICB8ICAgNDIgKy0NCj4+ICAg
ZHJpdmVycy9pcnFjaGlwL2lycS1hdG1lbC1haWM1LmMgICAgICAgICAgICAgIHwgICAxMCArDQo+
PiAgIGRyaXZlcnMvcG93ZXIvcmVzZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgIDQg
Ky0NCj4+ICAgZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYyAgICAgIHwg
ICAgMSArDQo+PiAgIGRyaXZlcnMvc29jL2F0bWVsL3NvYy5jICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMjMgKw0KPj4gICBkcml2ZXJzL3NvYy9hdG1lbC9zb2MuaCAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICA5ICsNCj4+ICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hdDkxLmggICAg
ICAgICAgICAgIHwgICAgNCArDQo+PiAgIDMyIGZpbGVzIGNoYW5nZWQsIDI4NDAgaW5zZXJ0aW9u
cygrKSwgMTQwIGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
Ym9vdC9kdHMvbWljcm9jaGlwL2F0OTEtc2FtOXg3NV9jdXJpb3NpdHkuZHRzDQo+PiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2FtOXg3LmR0c2kNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtYXQ5MS9zYW05eDcuYw0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYw0KPj4NCg0KLS0gDQpU
aGFua3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4uDQoNCg==

