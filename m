Return-Path: <linux-spi+bounces-9540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93AB2D715
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 10:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E930722E23
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA12D9ECE;
	Wed, 20 Aug 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="njBx461P"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020077.outbound.protection.outlook.com [52.101.84.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D72D9EF4;
	Wed, 20 Aug 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679797; cv=fail; b=lQGm3syUeBupzP6Zcj6goiouxvRBMjcZj7x0PwlJNNx2rsU6tvA8yUfiC8v+OIxnxZxejgdV0bUADyVb+pEkJmmLf/O/VqENeqBqtn7PsfuxrPt5bKH4vwDYsXBNC1VD1CvvJ8YiwU3422BX/VHGU4FuNnSWIJpcv+5x+wl9xOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679797; c=relaxed/simple;
	bh=93BIzvvcmD4NH+EcBcepX0QfgQqchsI2UtD8hhIhaCw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DRcHzhNddqvxi/0N4ZUtsJUORABeVwi/vLnqfX7yXsz1RfVlhVNJrfpIKtMj1AaJ5m7UhjZf8YSxv5yC1ftDOlQXYAofKVe6ziAqTYkUVCzUcZcXRKkEGSAUt53cmAujm3DTpTeUHyWHC997uG5oMonaN3rdFe/TAR50zEUy6i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=njBx461P; arc=fail smtp.client-ip=52.101.84.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmCHRgTr+OVjAXYAc5Rh80gGlZGW4q1HvQ7emJ6P8qcm2hT8/xItIUdKxunuzQVkVVObBuPwgkXDq0ZY9mmCpuRNO+85ziZ2WIZK7KsLg7XAyupZjvs2FHggkRwkpiDAmSG/FDDqrKos1+6A9OooqNI4N56VVn48r9NEyd96NVa+bu6AJkiFi72Vzo2Ou3R89IofmaB7bcZTRvOr1wA1Ve4jKVyOoLI01+yLjbHKxLX/4sDfvhfc/Wek0//IRfrY2EhOJFcLeRr5GxAkFiLn+Rl7HzZpHVNIHBNdT25y4qOFpdNAuB5KMiMGPQ13QuKHRnO7CM7RwNWg5bpY1QLbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYFT01QIhahf1Uxsqb6Ng23a3/kyHMsfDS7EToFoG80=;
 b=nusXWZA47NCJu49DEYvsjZEbepauUJMLO5EqSMHd6KC/HLdntzB25SS/ernkJdEbO1kTgikzaHiznvvQCtY2w4qZJUcJpAhax4lQDVRVo5FR3VzqIQmUp4mY5oGGwn84PxijvovHMpK1xNasnq4vKqBA+s3OJ2BpcHz8Pr/O6qtLImG4j5gYAtg66bMD5OHmZV5zzbs7n+y6UMQWn4e8a3cd/iD2nTGQ+4dsL0RjtSbM42V557j3W+h4AEyDknIg65+V0aJXTnuomlJ1ewPjgHwBuk+XZT1D4nZ2x4AeYJ0m05PA3CKMkPbYQv1cxD+IvVJmEi8XNLq7bXQB6+/GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYFT01QIhahf1Uxsqb6Ng23a3/kyHMsfDS7EToFoG80=;
 b=njBx461Pe5I7JA+HKfImWMAXE0/upVcRWqtomERRPIuOc7sAavPodr7JC3jO+l6/ixm0a6y/q9rKxmG1mpznHZ0aknJafykK0Qutb3lh7IQxcQ40s40mXnuDgwSY6V4I1qX6VfsKTaJwh3hkh8OtEIAlWPSJ5wUTwLs3sbakgiv9oFO6Vflso3YIJbAVQ6VmS4s0aB+RB3MJf/BKhge7Jgl55C3Pq3KA3MjT/jYRGU3sX0qh+r2JQgDKqeLBLJDCwTtJj7cJI+PjKNIuO8ckJz3nU4p2LXrBlsJRNUPVZOHFZkHQQ2dnbQ06UU2HXC5LbcZz2mk1AjCIvgdnEkSbQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS1PR10MB5746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 08:49:49 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 08:49:49 +0000
Message-ID: <4fffe2be-ff3c-4d06-b7a3-c0c9a69d0ead@kontron.de>
Date: Wed, 20 Aug 2025 10:49:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS1PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4978690e-840b-4f0b-0739-08dddfc68532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NiszTWVVN0FManlvZGc3Tk5jK0hXdGxlbFpjcVgxZFNUTTRyQWpScUsrbEtN?=
 =?utf-8?B?Z0RpL1k2Y1RvZDZrSVRRUllRbmF5TTM5bTlwdm1DQ093cFAyeTdta04vcHRs?=
 =?utf-8?B?ajJWMk9xNGYrOWFCeTBqalRVbFFIV0ZSaGQxYk9pdUZaTGtRWjM5dnl4WU1B?=
 =?utf-8?B?cVdaU1pvcGoyS3ZnWk5RUG5qbHBhM0ZPaTJCNWoyU1ZSY2U0RlFlMjZpMTBz?=
 =?utf-8?B?UzRjRlZ1dys1b2ZQZkVuUUswSGhtOUZ2OGo1SnJ5UDhwdnVwOTRPRTVyTmRq?=
 =?utf-8?B?RzBYQjljNFdnZmdzUzBRRndSWitnNTBzditQYitaWUp1aWhPS1BPMWJjUllN?=
 =?utf-8?B?d3pYUGhLcDhzekhEa0o5TGYrb0lyNFRoVlYvMjdLTEVrazdlU2JteXdpNnpG?=
 =?utf-8?B?VUZWUFlXa2FnV3U3UTdmYWdENEJPeFhFSi85eHF0ZEl4MnhvaytGQmJaYlJo?=
 =?utf-8?B?S05mRXUwcWFsbEJERlNYSkRoNEdFOFkyb2dwUG4wQ1VxZHpMNk0rTWluZjV0?=
 =?utf-8?B?VjlDK0hFWHBwVjFFWWxzK3lsUkZxOGZzTDRWMVNNRzc1NzZPWUEyWi9WYUo5?=
 =?utf-8?B?TCtNQ0dYZWxwbXo4MzdBcjFINENHazdVdGtJOUNyTkdFY0RJeWY4M2pyM09R?=
 =?utf-8?B?M3hOSy9iUDVIZ0dmYXljczF3K2JLd3k3bTFNUkI4Slhjd1NYbFc3c1JWUTla?=
 =?utf-8?B?S2NFWmhrb2dNeXl0WXZlc01ycGUzZHBrM2NkNW11eXFZOUxtZkNoK0FrR2l0?=
 =?utf-8?B?dHhxcWNOT1dDRHdvVnIyOW9hVU9yQ3psb2ttRng4UHUrTlluaVF5S2pxWC9z?=
 =?utf-8?B?RnpFZnJNU21TNXVHenJDMHViKzhyS1hmZkxPejI0K2VxbjB3SFdjWHVKNVhE?=
 =?utf-8?B?Nld4R3NJWkF1WGtqcy9acWVIWHkvQjUydDN4YkFmWFpRbytja0xQeWo2ZHVx?=
 =?utf-8?B?bW9BYmNjZ1dOREZXU3pCS1BQeDdQcHFmRWlEMUliUHorSEpLZkhyb05MbVp6?=
 =?utf-8?B?MW5UdmFkOGNjWHRPZUowYWxzMU1iaG9jaTBiSGFlVm5CUHo4QWpaY0crUHpU?=
 =?utf-8?B?NTNCUlNNd2p0bGZnM3BUSTNKVEE2c1pibWt3R05ET1gxSHhjSXdURzArVHp5?=
 =?utf-8?B?LzJRVDBUZjRzYmpGd2s4S2ZsUmlkRnAzME1UU2NZN0EvbE1LOTBHME41bEZm?=
 =?utf-8?B?S2VlOExSbk54eGQ5b3hiM3UvdU9mcGV5a0JlWjA3Y00vQ2wySFVzUG40d0w2?=
 =?utf-8?B?TEhRL2NSYXRXZ0NFWlY0U2EwblpRVlhja2hwZUdiYzhIL0dvaXYxeEN6bUV4?=
 =?utf-8?B?V0UrbHB4Y1M2NTdGQ0N4b1c5aVErT2xHQVJVWDZEUWxOWld2dXYvZUhqeDFU?=
 =?utf-8?B?SDhTWll1aVYrb082RkNvc21yV1dEdFozVTlmYVplYllWa0N5TXMrc25ocTN1?=
 =?utf-8?B?SXVlTmR3RG1PR0xpVnQyYVdXWmVYYnl2QjdiMFE1TCsrUVc2VEFuU0tkUGxZ?=
 =?utf-8?B?TUtqaGtLdWJtYTJ5NTRYaloxZmF3ZGdKT2pkK1pMa01uMkpRSTlsc2xIMHk4?=
 =?utf-8?B?U09YaDB4Tyt3WWNjbFhGTjhTR1FCdTN4ZlJUZFJPUDJoTG5GNHJnOW56Z0lh?=
 =?utf-8?B?WUVDR1Z1YU85Zk9rZ0M2RlNtbUlaSlVsbWlNcE1GRm9lbnJ2TExiOWNreW5w?=
 =?utf-8?B?Z0FweHNEeHBWNEQzWTQ2bXZqM1YvYlBKVVZQSHkyTEh4MW5mVFRBMkFNWHJ1?=
 =?utf-8?B?K3J4QWs2WStoVjFVajBZeG8ycS8zUk43eHJlMjJpaWVtZnJLdnRxbnBjSFVS?=
 =?utf-8?B?Z0EwejlmN3hyTEQrdzNJNFBVQVlMMEhCUWVHTEhoK25Md0VMSkl3MDNnOUZ3?=
 =?utf-8?B?T3MyUS8vdDJmbE5YcWhDWjBtc2Fkb3JMSzNIV25OalV3UDJBTUF4TndUalAw?=
 =?utf-8?B?YXo1cXZlZ29Ib25lN3NScytFVDkzRzlYdEd3d1pzdk04dkxPYW93dU5HYnV6?=
 =?utf-8?B?MnNpeFkzQThnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHFTT1lVaGxuNm5mOFhIS0tSbFpLZ2pOV3R4ZkRPekNsdlNrSVNTVDlpM25Z?=
 =?utf-8?B?Q0F0SjBYb1UwQXQrRTdnMjZ4aFo0cS9QZFBKMzlkQ1NySkt5YzNnL0pDa2h0?=
 =?utf-8?B?QlhxL3h5Q3UvUlE2MTg5YTlwSStMT3ZTTXZPWE02UHdxR3JydFQrMXd6OFdR?=
 =?utf-8?B?S0h6U3M0aTZkdlpGSXYzR1NDaXI1alRMY2g2T05rODNTbXlWZThleEVicWtJ?=
 =?utf-8?B?R09mRHFLaGJpejAyZWhTeHJ2Q0hxeXhlVndBSnJWMWQvMUsrWUttOEZwOTF1?=
 =?utf-8?B?WVNVM2laWm1VRzRHdTVMVUdIRlJmdGZKandMR2djSHE4cVJDM1RwcHBGMjVE?=
 =?utf-8?B?TmJqbnk4MXpUc2wzd3NkWWd4SGVPUzhkYkVsVDBjR3doYnZKYkFub3p0UU5m?=
 =?utf-8?B?Z2llano2OEJ3VC9rNUVsM2FFdmNIRWxVZmtMdnNIV2pEUUVYUDRHeDBtQXkx?=
 =?utf-8?B?VzBVdE02cVVnRzJ5ZDNua3ZubGsrZGk1M1JSOTlYUzZwMEgrMXVWb2tIbEZw?=
 =?utf-8?B?TUpzY2dMVm02VUl6aW0wQWY0SDhGV1JnSzJhMUJsTmlFblZwdktDb09QK0pT?=
 =?utf-8?B?blJKZmg2WGFQUEd3NjhSQWU3UU4rRzROVGtOeDJURW1HNkxVUnRvT3ROM2g4?=
 =?utf-8?B?NmhuMUdZdHZ6bU4zckFzQTZzN2FIY1BHUGdKdnJMTFBJclV2cyticjNoaWxJ?=
 =?utf-8?B?OEpZbzZRWmRCbEtOR0RFV0hCUXhJNkVGR0N2d1BTaG9RME5VNnBBWnFKd29s?=
 =?utf-8?B?d1ZhMVhnUFNjNGo0UWVQdHFneGFvWmthN2xKUlY0a1BkOEFRMHhVdzRsKzl6?=
 =?utf-8?B?NUQvTW5iVk5Gd0tJSDZpbGxaMFUvQnIyeW9NaDc1Z3pMb241NElTelJjSjg5?=
 =?utf-8?B?eE12aHhlNy9GRTlLMmNiQ1VYOUMrNFQ5dTkzZFFvaDBsdzRNdUNsVG8rdkhK?=
 =?utf-8?B?a21ybmhIQ0ZHbmExeW16cE9UZ0l6WVB2NHZBeEZZQUJub0hieGZ1b1BuclRo?=
 =?utf-8?B?aFhtMjFTcDJmc3dHejRXQlBIWDQ2NVNsSXVWdURGWnpkVzNZZnJ2Y2J0Q1RP?=
 =?utf-8?B?bUw3WTdJQWptMzYrcTBSQlVOckxIOE5vanMrUE5PQk1JbVlVZGhLSytJQnNR?=
 =?utf-8?B?Q3JvOW9GYUNuNFBycTFTcU9aRjFyZ2U4Y01zcE14MEovK28rM1hodng4aEJ6?=
 =?utf-8?B?RXhvTGl0RU96aWFUQVNWcEgvVWJiYXhZamZwL0d5dFdpMzNWcTVtUngxRVJS?=
 =?utf-8?B?WUdyaGVDaHcrZExsRW5TbXRqNENMZkkwMUoraUVRRVBCeTRhMC9pSWRoL1c0?=
 =?utf-8?B?bVg1SW1WNmcxSGgrWVlSYTZwMHBCbXBxQlNrM3UyamlibFRUWEFPd2ZuWnNU?=
 =?utf-8?B?ZDloejdhSTdXZzNlWjdQSWZuUDhlRi92WmNuYnVKTzkwa0dqZDczQTBuRzJP?=
 =?utf-8?B?MVlTTG9HaUdLRThyK212R2dmN0J4cXBqdm14OGtyTUFuMXkvdTdxNm5uK0dt?=
 =?utf-8?B?cm5hcGp5U3MvMXVKcFF5T1g0bDRTWWhOQ3ZxdklyZ1pGbXJkcExRdHViU01i?=
 =?utf-8?B?N2d2OUYwR01tOHkwc1NSamtNSktySzd5RGZ0Mm8zOGdBZnRYRWo5a3FGamdt?=
 =?utf-8?B?WUVHbHZQY2pVRksrNkp3NlRnNkJ2c2h4UmlKbUdtaDArenFOdm5iY1AraU5Q?=
 =?utf-8?B?TExKakZTUmpRRFk5Zkg4bTRTa2NOMERCTk8veGMzREtmN0lzU1Q2WVR5U09n?=
 =?utf-8?B?QkNzTTdXWHZnL3ZpeXlBdzNPWktxN2NybWtxZFdhN0wwYUlDN2ZjNXFyd3lv?=
 =?utf-8?B?eTZRbnUyWlpkME1iNC9vZ29uMmd4L3EyemVqWkh5c0s0TEtOdDJ2eFRrc3F5?=
 =?utf-8?B?eWlhQXdkUnhuWGlVdEdYRXdZeUJRUGNkZnprMXluVEJkMmt3c2dwa3pNUCtx?=
 =?utf-8?B?OWR0cGZsOWhwWEdnNFBhUkU0ZDR5Vzc5TlRnUmZoTGdnenREaU1sQzk0V05k?=
 =?utf-8?B?QUh0RVVFanVqc2t5WjI2bURRSndsamU0ZTUyTUxCQnh3OE9FZytmU1pSTTJl?=
 =?utf-8?B?YXI1bWozelNsNHpzMjg2NzdoT3RmZUF0aXM4by9HaERuNmRJVGFlbHZoRTRv?=
 =?utf-8?B?RDJIMUs1UUpEbXRZQURLczBQaDZVVzNaa21SdmE4VjA3TEFIWU1HZWNoQ29N?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4978690e-840b-4f0b-0739-08dddfc68532
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:49:48.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vax29f1GroTk9QfLc6LUvH3++u4Dy4NqqMh66KogY3cEQoDX01sf3idnEhyJy/2ha7hq3lqRE/9ktTOo1G5hPZC7QrymSCT9xaLUevGq4aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5746

Am 14.08.25 um 08:54 schrieb Mikhail Kshevetskiy:
> This driver can accelerate single page operations only, thus
> continuous reading mode should not be used.
> 
> Continuous reading will use sizes up to the size of one erase block.
> This size is much larger than the size of single flash page. Use this
> difference to identify continuous reading and return an error.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

