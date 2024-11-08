Return-Path: <linux-spi+bounces-5657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4E9C1F28
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D097428549B
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC51EB9E1;
	Fri,  8 Nov 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UovKnhRJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7871EF93A;
	Fri,  8 Nov 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075946; cv=fail; b=lbtqf7OGFccquLdc3/rjMU26J4nQoYYhqhIo9nvlibrDiD8L8m40seGCBuO8skxtG2oOghCClhKCM2PNJdmSVnN8hlbYbt3ClH8wtsaddvulS6Hf76Kcq+CcogljG7D5NoDPHGZI4gD6s0VLiJdTkmNL8yADKpgjfncTY/VsweM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075946; c=relaxed/simple;
	bh=kjgLXUEhLfGmecLCDlS2vvI26YDO2JleTNAXKhU/YlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uztSd65N3VR31F0E8HwKYMPIIgywfvm8OGCCFxchM2vgqwMTniDCQ2OK9cDt5kqdAaJub+fPDmLuL8wQbN6Tksn/yIUWQSuIr8t+Up8Kb6yfZjrQWzZV9PH/v74j/sGsYrVeAFmyK/LkFpBYwlIQ7f8+VMVRkESxQYkKgL3vaiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UovKnhRJ; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJQv+opoaE9+pPeA0581+3n1TvGmTRhaovsH7LexXmpN3BiVkRPDQRzyykBpJbtUW+4DhPy1l2o/O2ec/IKXGd6SmOFcQZ3h9zA1tv7JQIsDqRoUgVPGsHKbqw34UwHqequEWQwYb1oKRdhyRmSFdnvu/KiJYls26uGu6aVEYEyZWjg4fCZEZsFTHoXXSUG7VjUX+IeAc8+sgA+5p8in5u29ag78us4JueQB43MCnvr1FQLti8ZrEy+J1eSKECS5SLAjeVPl2VYs7ZhN0v/g+ljLNnZGGVBOEcuQZvNfm7HW2uBFT4pQYVNCcnyJ5V98tLtxd6NZIcIJSIGfumT1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjgLXUEhLfGmecLCDlS2vvI26YDO2JleTNAXKhU/YlM=;
 b=uwjQYQiYL3FmUWbVUD57Z/cfBtMpsWhtOPAbzH9pPe1/Hvx6QlxsMWps8UojBrhhgSokzy7zrNvlg2h9JqJTRLp4fru9ANOGA1WHSf16ODh5SUWTm6sPVagygn3hnuMFIZCkyQVaaGZzhOrIRMS75kyvY2prQD37PZrTuKJupdLKph7FJKZ7flpnHA+PqApMWR8Jd9eoU9hF1rEZHgtY4sH2UcqTLTrsEFDn0vTVa+5p2aSJmyyJ8S4s7ii5+Hht3UDMFbePtk/FGY7G8i1+n06fwL5azZf5P2vInYNjM0Gla5rHPG277ZPBscpUFIEDmj/wdZirsOBNuC4uGzBThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjgLXUEhLfGmecLCDlS2vvI26YDO2JleTNAXKhU/YlM=;
 b=UovKnhRJ5Agf32hrSk0l8tJ7m/75tbyv1l1CfsN0iC31ixOW5LXwa6Sq+HZc+nsI8yo8m2tE33MVXjorV6QF9cPf0oLbfuGHK/lUS9BMFytsn3f7O3gZOINVPmAaWCsHSc4NhFJNiqHCinLWp0FcbvbpKIHlBqYIItCm5bHpmLk=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 14:25:39 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 14:25:39 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "michael@walle.cc"
	<michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "beanhuo@micron.com"
	<beanhuo@micron.com>
Subject: RE: [RFC PATCH 0/2] Add support for stacked and parallel memories
Thread-Topic: [RFC PATCH 0/2] Add support for stacked and parallel memories
Thread-Index: AQHbJ3xB9LmpIkfrvU6wQ9mSvcxe2bKtfYCg
Date: Fri, 8 Nov 2024 14:25:39 +0000
Message-ID:
 <IA0PR12MB769954DFDA43110B1066F1C9DC5D2@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
In-Reply-To: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|PH8PR12MB6748:EE_
x-ms-office365-filtering-correlation-id: de463a0d-1b81-4584-255f-08dd00013823
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlpycGtLQ1lvaDdPOWNvejEzbmk2TTdHTlJiamNCUGtSTmUzdDRRWVY4cVJK?=
 =?utf-8?B?SWFDQThURm94UXhjcTNFL2VOVGxES2NoVEo0ckRnQ09BTTZ1Wk1nU21FUmFZ?=
 =?utf-8?B?QUhwcXJmWU5tckM5R1FRMFRsQjNRN0dvcUd4QzN6L3hmRWxkOHVGS3VLSFNx?=
 =?utf-8?B?MWRrZVdpTk5OLzhwaXZ4dHAwUUlqM1JwRzczQ3VBbEF1SUc1aFFsTEZVK0tj?=
 =?utf-8?B?NVphK0hWQm12OW5KbEtnNmpCWHVuY2tFRkUyaFNYamJTcnV2VlFHTEFsUFcv?=
 =?utf-8?B?dURNSzNNMi9tWnNXYlFUL1hRcjJhMjNDekUyRThXdFZRSnF3K3NGbUdoS0dD?=
 =?utf-8?B?YXdOamt5T1BGd2prS1RUclVwOGUwUTdaYW5ydmNwWWxaUXVNek40bmNPTnlH?=
 =?utf-8?B?cXI3Y1hYMGx5cThnNWJaOHQ4Ui94MDlSRHdBeWFHNENJRHdYMkJhR3d4YXB5?=
 =?utf-8?B?ZnVaVFBveXVUWGNIT2tUaFZvQ3VCdW5GRnNKSEtDSmVIZ2RwZkNIV1FOZmpI?=
 =?utf-8?B?UXFuTWt3aUJIbE9vVEh4RElaVnJvaFpPNFlpZFh0R2NPdUF4M3NTMFhobVdy?=
 =?utf-8?B?NWtKdTJSRzN2RXRtNGtwSWZYN0JvQWExTFJvZkYxT3FQcDdreWV5aDZxbW9r?=
 =?utf-8?B?UFRNQUtPZ1VFQXN4bjJTMiszWXVNTjhhVko2VjdKOEFYRm9VbkMydDdrdGlt?=
 =?utf-8?B?VkJ4R0phYm4xaWFldXFhUURYTTFjU1BtUjRTb3JyU2E3NGxBS1lST2ZmSHpi?=
 =?utf-8?B?ZTdKUzlYVkQ0UW13Vy9tV0szMlNLRmQwZUlYMjdHVm9QdE9vMjhPZWZHRHd5?=
 =?utf-8?B?cFcxMDJMbXNPK0grSU9kQjZlOGduQWRHQ2huRDVWUkM4cHFpT3ZjcmwzSHNo?=
 =?utf-8?B?aXduYXNLOGtsMTlYZE8yekcxWFZVWTYrcUhEUHlDYkwraG54VDR3RjdIM1lI?=
 =?utf-8?B?QWV6bnpqM09ONE5GT0VMMHE2a0dGekhUL2RNeE1CUDNQZ0RaQnUya0pGUGJ5?=
 =?utf-8?B?M2hhbUVNZE91Lzl6UlViOE5pNkhGeE9XUTdrZ2tJeThwTkpYbDFtYmhkQWJ0?=
 =?utf-8?B?YmloNk94UVZjVnJWWjJIcmdtTVFZQ2F3Y3hEbkVpZWkvRE4yeml3MEFGU3NC?=
 =?utf-8?B?VFAvdEQxSHQxYlp1N1UyNGs4RXAveFFTT2k4V2J4ZGl5VmR4WitlMGs0aTFn?=
 =?utf-8?B?YkNCVTlWcm9qOGplQy9lZ3FCeTVhUkNUSXpUM2JiQjV2dGEzcERWcGhxUVlu?=
 =?utf-8?B?blAwVjg2YTdxY3J5UExFSXFaRG1CbitPZEJxSjk1T2JlVGovc2ZMalVJRzBY?=
 =?utf-8?B?Wm5GbmVzRUFuZElnRjZobTBBY2MzMGw5YWxVRVZURGExcFU2bUw4UE9VV2Qr?=
 =?utf-8?B?b2pwV0x0UHJreFNabWhoWmhzUlpHRlorb2RnYjNreE0vVVhnZ29vZkN0NzZK?=
 =?utf-8?B?bzU1QitUQ3VYYSt6cHF3aERoSjU3UkNBQnRrNUtGWnI3VkFwUE1WRS9TY0hr?=
 =?utf-8?B?YW9jbHpzTjFOeFFFc1BKQTZIeHFpcUpEbnA0OG5NQS9FMkZReXhmQ0tHWkN2?=
 =?utf-8?B?NHVsMXNaWDVpRVdYb0IxQXRFS3FYc2I5SXVuOWg0cG80cUlHWEIxWWhIdXdX?=
 =?utf-8?B?QlNydVk1MG1WcFYxMGdyMFFkVGVyRGgvVGdHd1lsc1RkcHhxcXlrbnczWW9W?=
 =?utf-8?B?WlpySEVTQ0YxWFVpOVFudHorWm5pTkZORjV3Y3F5U05OUW5qQWVmSmU0bWJ2?=
 =?utf-8?B?bWwxekdhK24zclA3MkdtK0wvQmpZOEpHRm9udklsaEQ1bFIzaXV2ZzFNcHFM?=
 =?utf-8?Q?K8H0NkW0He2OWRAjailiG41Zplq4K9Ba8Ouq0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGcvVVplUzFGeWFDaE51dGxpd0hPV1RFU2ppSEVvZm55WEVyNjQzNGV6bTNv?=
 =?utf-8?B?VEcrVVdwOENqa3ZVc1hmVjVxK3pWaDV5aHFkSW1sWmJvditUOEpmMmVra3Nw?=
 =?utf-8?B?dzhMVjlyYjlvZW9adjBiY2d3YlIxZm9JeGNZL2JEbGJUWndzUlhvSTNlNW90?=
 =?utf-8?B?eWZzbzVwRlFrRWVsNGo4R1pwM29NcnBaa3hmaVlwOXFFYkNYSE5tS3pUZ21h?=
 =?utf-8?B?OVZMeGc4UDhhMWJHdGttQnVzZXc5VTVML1dJazFPV2c4U1VmYllQMmlnaWhs?=
 =?utf-8?B?bHFOTHEyZ1RZcmhKd2QvWElDV1oydlREWWdSbDhIZGQ3d1lRdStlMm84ckM5?=
 =?utf-8?B?OGF3YWNtbXQrZ2dwY05RZUd1RE44SFFIL0s2YzlmQ1VDRXlkRnFXR2M3c3o0?=
 =?utf-8?B?b1FKMDZsT0ZzdlIxUGZacW9qMjIwZnZOT1RqYWlrMkV1Z3RhVkZRdWtCeE5H?=
 =?utf-8?B?VlJ0cFhqVWJjc0M3dXZKQTFCNUhCdjRCc2VYSXVPdS9WMFpOSWhTdjRPcjNC?=
 =?utf-8?B?OHdHMER1SDNmZ1lON0UrUGpjTTJrak1XdnE0bFF4OTdtMWhQV3Rtb2FlYjZJ?=
 =?utf-8?B?MkJKVUZFZ2RHNVhEeG1GdkFGSW5MV0d1REp1NzFDb3BYUWQvc2dxL0xaa3I5?=
 =?utf-8?B?dkljUy9rSFFqSm5JYm9zMDVQTFY1bGlQSVR4ZEJjQWx6Q0tXSnVWM1pNS1F6?=
 =?utf-8?B?a1o1L0RyS2hrQ21ZS2sreWcxSFdrNEcwY0FFMkpPYkFGdnFqQTdHV2FvY28v?=
 =?utf-8?B?dW9CcU52V2hrbVdvd2haUFhSdmtxT1lHTys2VjdQc2oxMTd2dWJRM3pvdHdC?=
 =?utf-8?B?eENxWURZTUJRUlNYK3VabUY1Vi9DS2RPS1pVNmRkRTI1UmZ0SlRPb3dJVGZD?=
 =?utf-8?B?anVLVVNZbEpIcWIvVjkyZHl3dlMyWnBqYTNya08wY3c0RFdaT2VRRk9XTVhx?=
 =?utf-8?B?ZmtJY3JQN2gxbFA3NFhzcmtwTkFLczNCZC9uaXpqM0ZXU1VxU2Zvb2RDUldN?=
 =?utf-8?B?WlBuT0YxdU8ydGJJWEVOQmpTUnhLMW1WV01BRU51SWhnVm5vZUlEd0tWM3ZB?=
 =?utf-8?B?V0NyVFRFYlRVa1Nic2FGN1RtRDJ5VHpzc2ZlZ3k5a3dzUEc0UUJuVEtncFY1?=
 =?utf-8?B?bEtBbzU0RWhVblRicEhUSVhJRDBkOG1ySXg1TWJONXRhUk5QSGEzK2UzVjNG?=
 =?utf-8?B?anNXOW1vem1sV1lUWlIxWlR6b1hwdUNHWjJ1emhCMDNTZWxBNWZ4azlEZ1ZN?=
 =?utf-8?B?dEpjb0RwaUZtVHRScUIzZzljeUdJeEpWYW9aN2lsa0xidVhuakNORjEvS2lj?=
 =?utf-8?B?TGhKbmFFRmkzU28wQW03R1dPdDd5eUJoUGwrYlExZ0xJN05Oc2NHN0VwWjhS?=
 =?utf-8?B?dEo2NWJrY0NhcVNRbDJzOTlVWEpoZ3AreGpJZXphSVZZTmcxajNVQnc4dHNE?=
 =?utf-8?B?MFM5bzhkbzBTQ3ZsRkZwdzdsOEZwYXR3NkkrVTdURHRNVm81THB5Y09iUHBQ?=
 =?utf-8?B?SmZkaVlXOFpROWJhOEdpVXBWUDlkMzcxRlBtZmRtQkpHdG1YZENEMDUvOENV?=
 =?utf-8?B?eXhRU2RLb0JRcTMvbks3WGEzQjhxZmtKeGNlbVREV1FXb1dtNzRnVk4wVnRU?=
 =?utf-8?B?SFpTc05qazZYMkkxelBsdmo2R0NublB6eFJ0a205cG1DSE5CYUFteThJYUtk?=
 =?utf-8?B?bzdiZU9OQisxU0tNMjZVT0YzNnRuV1NNeExjdng3R2dGOXo0ejVUZExtWDBa?=
 =?utf-8?B?dW9JdTV5SU15RG5MbUUwbm4yWGZWc3NTczRCYUdzVDJVbHdENCtQeVBScG9l?=
 =?utf-8?B?UjVhWUw2U2NqZ0NiWHB3QTl4OHBGbmY2aUJiVkw3U2ZzSkZJd2w1azE2RDVy?=
 =?utf-8?B?dFgrVHRIQ1U5L0s5aXZnVnUrMm5qZXN0c2VieEZWUFJoazBXdDMrenIzU2F4?=
 =?utf-8?B?TVNCdE5rUG9wVWRkaWlxVUNWc0ZweUNrcms5ZjVsRzdOb3JIV1F6enp1ODg0?=
 =?utf-8?B?ZW5EZjVUTlpzU2x6cEprSFFkMGdrbDhYUWhFVzdtUlg2cHEzbVlrQmJBZG5r?=
 =?utf-8?B?c1p4cG90RnhBaVFiQXVjRlpYamtRV3RnZnc1RndyTkhUTzZzRnJUcnZDeFEv?=
 =?utf-8?Q?RPck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de463a0d-1b81-4584-255f-08dd00013823
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 14:25:39.3047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJBbhiJVcedxA/tSV6Uu/YmeJNxSdTVp3YysoF1EpM1mNJyZVxH8E7bn1a3pq072GQZrQ6RmlXjeuwGCu15W1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748

SGVsbG8gVHVkb3IsIE1pY2hhZWwsIE1hcmssIFJvYiwgUHJhdHl1c2ggJiBLcnp5c3p0b2YNCg0K
UGxlYXNlIHNoYXJlIHlvdXIgdGhvdWdodHMgb24gdGhlIHByb3Bvc2VkIGJpbmRpbmcgY2hhbmdl
cyBhbmQgb3ZlcmFsbCANCmFyY2hpdGVjdHVyZSwgc28gd2UgY2FuIGRpc2N1c3MgYW5kIGZpbmFs
aXplIHRoZSBzYW1lLg0KDQpSZWdhcmRzLA0KQW1pdA0KDQo+IFN1YmplY3Q6IFtSRkMgUEFUQ0gg
MC8yXSBBZGQgc3VwcG9ydCBmb3Igc3RhY2tlZCBhbmQgcGFyYWxsZWwgbWVtb3JpZXMNCj4gDQo+
IEhlbGxvIEV2ZXJ5b25lLA0KPiANCj4gRm9sbG93aW5nIGFuIGVtYWlsIGRpc2N1c3Npb24gd2l0
aCBNaXF1ZWwgcmVnYXJkaW5nIHRoZSBiaW5kaW5nIGNoYW5nZXMgYW5kIG92ZXJhbGwNCj4gYXJj
aGl0ZWN0dXJlIGZvciBpbXBsZW1lbnRpbmcgc3VwcG9ydCBmb3Igc3RhY2tlZCBhbmQgcGFyYWxs
ZWwgbWVtb3JpZXMsIEnigJltIHNoYXJpbmcNCj4gdGhpcyBSRkMgdG8gaW5pdGlhdGUgYSBkaXNj
dXNzaW9uIG9uIHRoZSBwcm9wb3NlZCB1cGRhdGVzIHRvIGN1cnJlbnQgYmluZGluZ3MgYW5kIHRv
DQo+IGZpbmFsaXplIHRoZSBpbXBsZW1lbnRhdGlvbiBhcmNoaXRlY3R1cmUuDQo+IA0KPiBCZWZv
cmUgZGl2aW5nIGludG8gdGhlIG1haW4gdG9waWMsIGhlcmUgaXMgc29tZSBiYWNrZ3JvdW5kIG9u
IHN0YWNrZWQgYW5kIHBhcmFsbGVsDQo+IG1lbW9yaWVzLg0KPiANCj4gVGhlIEFNRCBRU1BJIGNv
bnRyb2xsZXIgc3VwcG9ydHMgdHdvIGFkdmFuY2VkIGNvbm5lY3Rpb24gbW9kZXMoU3RhY2tlZCBh
bmQNCj4gUGFyYWxsZWwpIHdoaWNoIGFsbG93IHRoZSBjb250cm9sbGVyIHRvIHRyZWF0IHR3byBk
aWZmZXJlbnQgZmxhc2hlcyBhcyBvbmUgc3RvcmFnZS4NCj4gDQo+IFN0YWNrZWQ6DQo+IEZsYXNo
ZXMgc2hhcmUgdGhlIHNhbWUgU1BJIGJ1cywgYnV0IGRpZmZlcmVudCBDUyBsaW5lLCBjb250cm9s
bGVyIGRyaXZlciBhc3NlcnRzIHRoZQ0KPiBDUyBvZiB0aGUgZmxhc2ggdG8gd2hpY2ggaXQgbmVl
ZHMgdG8gY29tbXVuaWNhdGUuIFN0YWNrZWQgbW9kZSBpcyBhIHNvZnR3YXJlDQo+IGFic3RyYWN0
aW9uIHJhdGhlciB0aGFuIGEgY29udHJvbGxlciBmZWF0dXJlIG9yIGNhcGFiaWxpdHkuDQo+IEF0
IGFueSBnaXZlbiB0aW1lLCB0aGUgY29udHJvbGxlciBjb21tdW5pY2F0ZXMgd2l0aCBvbmUgb2Yg
dGhlIHR3byBjb25uZWN0ZWQgZmxhc2gNCj4gZGV2aWNlcywgYXMgZGV0ZXJtaW5lZCBieSB0aGUg
cmVxdWVzdGVkIGFkZHJlc3MgYW5kIGRhdGEgbGVuZ3RoLiBJZiBhbiBvcGVyYXRpb24NCj4gc3Rh
cnRzIG9uIG9uZSBmbGFzaCBhbmQgZW5kcyBvbiB0aGUgb3RoZXIsIHRoZSBjb3JlIG5lZWRzIHRv
IHNwbGl0IGl0IGludG8gdHdvIHNlcGFyYXRlDQo+IG9wZXJhdGlvbnMgYW5kIGFkanVzdCB0aGUg
ZGF0YSBsZW5ndGggYWNjb3JkaW5nbHkuDQo+IA0KPiBQYXJhbGxlbChNdWx0aS1DUyk6DQo+IEJv
dGggdGhlIGZsYXNoZXMgaGF2ZSB0aGVpciBzZXBhcmF0ZSBTUEkgYnVzLCBDUyBvZiBib3RoIHRo
ZSBmbGFzaGVzIHdpbGwgYmUNCj4gYXNzZXJ0ZWQvZGUtYXNzZXJ0ZWQgYXQgdGhlIHNhbWUgdGlt
ZS4gSW4gdGhpcyBtb2RlIGRhdGEgd2lsbCBiZSBzcGxpdCBhY3Jvc3MgYm90aCB0aGUNCj4gZmxh
c2hlcyBieSBlbmFibGluZyB0aGUgU1RSSVBFIHNldHRpbmcgaW4gdGhlIGNvbnRyb2xsZXIuDQo+
IFBhcmFsbGVsIG1vZGUgaXMgYSBjb250cm9sbGVyIGZlYXR1cmUgd2hlcmUgaWYgdGhlIFNUUklQ
RSBiaXQgaXMgc2V0IHRoZW4gdGhlIGNvbnRyb2xsZXINCj4gaW50ZXJuYWxseSBoYW5kbGVzIHRo
ZSBkYXRhIHNwbGl0IGR1cmluZyBkYXRhIHdyaXRlIHRvIHRoZSBmbGFzaGVzIGFuZCB3aGlsZSBy
ZWFkaW5nDQo+IGRhdGEgZnJvbSB0aGUgZmxhc2ggdGhlIGNvbnRyb2xsZXIgaW50ZXJuYWxseSBt
ZXJnZXMgZGF0YSBmcm9tIGJvdGggdGhlIGZsYXNoZXMgYmVmb3JlDQo+IHdyaXRpbmcgdG8gdGhl
IGNvbnRyb2xsZXIgRklGTy4NCj4gSWYgU1RSSVBFIGlzIG5vdCBlbmFibGVkLCB0aGVuIHNhbWUg
ZGF0YSB3aWxsIGJlIHNlbnQgdG8gYm90aCB0aGUgZGV2aWNlcy4NCj4gSW4gcGFyYWxsZWwgbW9k
ZSBib3RoIHRoZSBmbGFzaGVzIHNob3VsZCBiZSBpZGVudGljYWwuDQo+IA0KPiBGb3IgbW9yZSBp
bmZvcm1hdGlvbiBvbiB0aGUgbW9kZXMgcGxlYXNlIGZlZWwgZnJlZSB0byBnbyB0aHJvdWdoIHRo
ZSBjb250cm9sbGVyIGZsYXNoDQo+IGludGVyZmFjZSBiZWxvdyBbMV0uDQo+IA0KPiBNaXJvY2hp
cCBRU1BJIGNvbnRyb2xsZXJbMl0gYWxzbyBzdXBwb3J0cyAiRHVhbCBQYXJhbGxlbCA4LWJpdCBJ
TyBtb2RlIiwgYnV0IHRoZXkgY2FsbA0KPiBpdCAiVHdpbiBRdWFkIE1vZGUiLg0KPiANCj4gSW5p
dGlhbGx5IGluIFszXSBbNF0gWzVdIE1pcXVlbCBoYWQgdHJpZWQgdG8gZXh0ZW5kIE1URC1DT05D
QVQgZHJpdmVyIHRvIHN1cHBvcnQNCj4gU3RhY2tlZCBtb2RlLCBidXQgdGhlIGJpbmRpbmdzIHdl
cmUgbm90IGFjY2VwdGVkLiBTbywgdGhlIE1URC1DT05DQVQNCj4gYXBwcm9hY2ggd2FzIGRyb3Bw
ZWQgYW5kIHRoZSBEVCBiaW5kaW5ncyB0aGF0IGdvdCBhY2NlcHRlZCBbNl0gWzddIFs4XSB0aGF0
DQo+IGRlc2NyaWJlcyB0aGUgdHdvIGZsYXNoIGRldmljZXMgYXMgYmVpbmcgb25lLiBTUEkgY29y
ZSBjaGFuZ2VzIHRvIHN1cHBvcnQgdGhlDQo+IGFib3ZlIGJpbmRpbmdzIHdlcmUgYWRkZWQgWzld
LiBXaGlsZSBhZGRpbmcgdGhlIHN1cHBvcnQgaW4gU1BJLU5PUiAgVHVkb3INCj4gcHJvdmlkZWQg
YWRkaXRpb25hbCBmZWVkYmFjaywgbGVhZGluZyB0byBhIGRpc2N1c3Npb24gb24gdXBkYXRpbmcg
dGhlIGN1cnJlbnQNCj4gc3RhY2tlZCBhbmQgcGFyYWxsZWwgRFQgYmluZGluZ3MuDQo+IA0KPiBQ
cm9wb3NlZCBTb2x1dGlvbjoNCj4gVGhlIHNvbHV0aW9uIGhhcyB0d28gcGFydHM6DQo+IA0KPiAx
LiBVcGRhdGUgTVRELUNPTkNBVA0KPiAgICBVcGRhdGUgTVRELUNPTkNBVCB0byBjcmVhdGUgdmly
dHVhbCBjb25jYXRpbmF0ZWQgbXRkIGRldmljZXMgYXMgZGVmaW5lZA0KPiAgICBpbiB0aGUgZGV2
aWNlIHRyZWUuDQo+IA0KPiAyLiBBZGQgYSBOZXcgTGF5ZXINCj4gICAgQWRkIGEgbmV3IGxheWVy
IGJldHdlZW4gdGhlIFNQSS1OT1IgYW5kIE1URCBsYXllcnMgdG8gc3VwcG9ydCBzdGFja2VkDQo+
ICAgIGFuZCBwYXJhbGxlbCBjb25maWd1cmF0aW9ucy4gVGhpcyBuZXcgbGF5ZXIgd2lsbCBiZSBw
YXJ0IG9mIHNwaS1ub3IsDQo+ICAgIGxvY2F0ZWQgaW4gbXRkL3NwaS1ub3IvLCBjYW4gYmUgaW5j
bHVkZWQvZXhjbHVkZWQgdmlhIEtjb25maWcsIHdpbGwgYmUNCj4gICAgbWFpbnRhaW5lZCBieSBB
TUQgYW5kIHdpbGw6DQo+IA0KPiAgICAtIER1cmluZyBwcm9iaW5nLCBzdG9yZSBpbmZvcm1hdGlv
biBmcm9tIGFsbCBjb25uZWN0ZWQgZmxhc2hlcyBpbg0KPiAgICAgIHN0YWNrZWQgb3IgcGFyYWxs
ZWwgbW9kZSBhbmQgcHJlc2VudCB0aGVtIGFzIGEgc2luZ2xlIGRldmljZSB0byB0aGUNCj4gCSBN
VEQgbGF5ZXIuDQo+ICAgIC0gUmVnaXN0ZXIgY2FsbGJhY2tzIGFuZCBtYW5hZ2UgTVREIGRldmlj
ZSByZWdpc3RyYXRpb24gd2l0aGluIHRoZSBuZXcNCj4gICAgICBsYXllciBpbnN0ZWFkIG9mIHNw
aS1ub3IvY29yZS5jLg0KPiAgICAtIE1ha2UgbWluaW1hbCBjaGFuZ2VzIGluIHNwaS1ub3IvY29y
ZS5jLCBhcyBzdGFja2VkIGFuZCBwYXJhbGxlbA0KPiAgICAgIGhhbmRsaW5nIHdpbGwgYmUgbWFu
YWdlZCBieSB0aGUgbmV3IGxheWVyIG9uIHRvcCBvZiBTUEktTk9SLg0KPiAgICAtIEhhbmRsZSBv
ZGQgYnl0ZSBjb3VudCByZXF1ZXN0cyBmcm9tIHRoZSBNVEQgbGF5ZXIgZHVyaW5nIGZsYXNoDQo+
ICAgICAgb3BlcmF0aW9ucyBpbiBwYXJhbGxlbCBtb2RlLg0KPiANCj4gWzFdIGh0dHBzOi8vZG9j
cy5hbWQuY29tL3IvZW4tVVMvYW0wMTEtdmVyc2FsLWFjYXAtdHJtL1FTUEktRmxhc2gtRGV2aWNl
LQ0KPiBJbnRlcmZhY2UNCj4gWzJdDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxv
YWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvTVBVMzIvUHJvZHVjdEQNCj4gb2N1bWVudHMvRGF0
YVNoZWV0cy9TQU1BN0c1LVNlcmllcy1EYXRhLVNoZWV0LURTNjAwMDE3NjUucGRmDQo+IFszXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTExMTMxNzE1MDUuMjYxMjgtNC1taXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tLw0KPiBbNF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MTkxMTI3MTA1NTIyLjMxNDQ1LTUtbWlxdWVsLnJheW5hbEBib290bGluLmNvbS8NCj4gWzVdaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjExMTEyMTUyNDExLjgxODMyMS0xLW1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20vDQo+IFs2XQ0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMv
bGludXgvY29tbWl0L2Y4OTUwNDMwMGU5NDUyNGQ1ZDU4NDZmZjhiNzI4NTkyYWM3MmMNCj4gZWM0
DQo+IFs3XQ0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2ViYTUz
Njg1MDNiNDI5MWRiNzgxOTUxMjYwMGZhMDE0ZWExNw0KPiBjNWE4DQo+IFs4XQ0KPiBodHRwczov
L2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2UyZWRkMWI2NGYxYzc5ZThhYmRhMzY1
MTQ5ZWQ2MmEyYTlhNA0KPiA5NGI0DQo+IFs5XWh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9s
aW51eC9jb21taXQvNGQ4ZmY2YjA5OTFkNWU4NmIxN2IyMzVmYzQ2ZWM2MmU5MTkNCj4gNWNiOWIN
Cj4gDQo+IFRoYW5rcywNCj4gQW1pdA0KPiANCj4gQW1pdCBLdW1hciBNYWhhcGF0cmEgKDIpOg0K
PiAgIGR0LWJpbmRpbmdzOiBtdGQ6IEFkZCBiaW5kaW5ncyBmb3IgZGVzY3JpYmluZyBjb25jYXRp
bmF0ZWQgTVREIGRldmljZXMNCj4gICBkdC1iaW5kaW5nczogc3BpOiBVcGRhdGUgc3RhY2tlZCBh
bmQgcGFyYWxsZWwgYmluZGluZ3MNCj4gDQo+ICAuLi4vbXRkL3BhcnRpdGlvbnMvZml4ZWQtcGFy
dGl0aW9ucy55YW1sICAgICAgfCAxOCArKysrKysrKysrKysrKysNCj4gIC4uLi9iaW5kaW5ncy9t
dGQvcGFydGl0aW9ucy9wYXJ0aXRpb25zLnlhbWwgICB8ICA2ICsrKysrDQo+ICAuLi4vYmluZGlu
Z3Mvc3BpL3NwaS1jb250cm9sbGVyLnlhbWwgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysr
Ky0tDQo+ICAuLi4vYmluZGluZ3Mvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwgICAgfCAg
OSArKystLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

