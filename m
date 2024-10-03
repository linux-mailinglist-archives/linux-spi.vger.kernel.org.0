Return-Path: <linux-spi+bounces-5094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEF98EA91
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA9B21049
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC83126BF2;
	Thu,  3 Oct 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhXz1WZ0"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F883E499;
	Thu,  3 Oct 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941356; cv=fail; b=NwYPU/ipB4kqK/fqDpxtwCAKn/jdpBJTOAFwzeYrSxlDOfl16hFdQHYOLJDRdLcctphSMcJtoEwgMKTeDHOok31x1TszXHFnOidhXW9E+euixCU82pKK2uvpXxbs8DnxFrsrBTG+GvxSh4saLC9eRS2+PgL+v13jlwWuir/unzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941356; c=relaxed/simple;
	bh=RFhwDSQ2BjVQvU2C48/h3pwvfhNk8TzYTSfHvFnJajU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0zGJ94+BUIga9HhuIE1FJFwrOX2w36RWVTGWtn3JASLu5zhERcys0KQPsKEj6rm38Ub1ZYXOrn/OEJehYr5g0kfP7omUw+sCKbq062d6J/i4LR5SfIdpSBJbeh6Ns04F72JBMKWOcO1ECJDi8PaeDiCiTai7Dpa9yRj2bxmCMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhXz1WZ0; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g57fHhw8uXjaG1VRxkJvWF93bQqdOxffPCVelP+bKn4sHVh2e1QYt3tloBTX/MCvw4nURtG8duPu1O1i4ctB2HkC0HE/FzmVz/NLwV1EDj2SFAq2U86qNNMmPkGmnrbk2LkoDFG5YVmaBQw+XumEGey8oEq/Eqy8k1fy5d95IbVx2gr7Y5ZDGyRgX58mOWYBcuyfzzwF6WCmI9LOGIqdlYE28kFqTygJ+5jtikEOFxpLzU5cWXV1M4tGHmSItL4Lptk3gUjPSM2zsrTkZCDh8Oi5cgPrw3uKkjpEaxzQuoqUxLBI2LAQ5d7SbUu4nThz1pknqQDK+9anwbgqZ3v6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhwDSQ2BjVQvU2C48/h3pwvfhNk8TzYTSfHvFnJajU=;
 b=UamUIUSIVZBoCj7tnbJqpo/Yj2y3h2vZz8VAK5J3XRGEV3TijtQhR8ZVZD7OD1m+fl0of5Xnn0nfL+6k58LzmYBiWyVIo8SyTuZ94LpYHDYlKR6DiRhfIQ8dFo9b0zLjSH47GNANA4FssFxS/GkuMSnp9L8J/tHx4WbrzyOH6VtW+5W2pNPfum3CwIdePcM6yYsEMZ/5Od+qNLBSNISmBOA1GejNJp8qL+bTBnHHmvoWpZ4vl2X3c9U6jclnLy6Q9thjBGzswnJNiyO141Xv1a45lSc0p5ID6gUBk1RP1XfD2tDI55679qL9IaliJ8YP8YtU5+SysAkrEJxqxHE+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFhwDSQ2BjVQvU2C48/h3pwvfhNk8TzYTSfHvFnJajU=;
 b=PhXz1WZ0NWEd/fuFHr+DRA7GZj+rf8fqWdjt36u+Lew+4TibKpf6T1jzcIN3myUcrGNQQueqGxfaA8RL5t6WHzzt/qAwJm0TOOt3J/Q7pIHzIwOINqIC+7YYayVFtjCy41GZGae5rrcFW98PYWT3T0YzHB7X4xnMRDeYNyg6IBU=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:42:28 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 07:42:27 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Topic: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Index:
 AQHbDbS6IWXQrG+wX0CC5AjhvyS/qLJnJHoAgAE51XCAABg2AIAC3+PggAGMU4CAAMdKAIAC1yFggAASSoCABAjYMIAADHKAgAAJvFA=
Date: Thu, 3 Oct 2024 07:42:26 +0000
Message-ID:
 <IA0PR12MB76992D9DDE6AF254FA884A52DC712@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
 <20240928-postcard-lively-c0c9bbe74d04@spud>
 <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240930-unbalance-wake-e1a6f07ea79d@spud>
 <IA0PR12MB769964FA23FA8B889B47539DDC712@IA0PR12MB7699.namprd12.prod.outlook.com>
 <1195de0e-4a14-446f-bd1f-0116d4abf18b@kernel.org>
In-Reply-To: <1195de0e-4a14-446f-bd1f-0116d4abf18b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|MW6PR12MB8998:EE_
x-ms-office365-filtering-correlation-id: 742765c2-e48a-4b3c-3409-08dce37eed7d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXBWcUphQVd0enUzSGxDbjl3K0l5akk1bWZoekFVK3poYlJDTlBZa3hoMmNq?=
 =?utf-8?B?a0Q0N3FuZHgxWjdsL0VTSUE4VUZXSHU2ODFWSjNQNW1OSEluL0xOZWNaN2RJ?=
 =?utf-8?B?S2ZQcHNnY24vTTMzcE5BbHYwUFRQZlloOXVlTUJhcjlQRjZFdER2OWN2dCtO?=
 =?utf-8?B?d0FqSDV3dXdiNlRqOS9la2VYQkNKa1RXOXc3VGdaRE1jS05kaVExQ3o1a2pF?=
 =?utf-8?B?TGM5aDJXaHRzMWFNSDV0THM4VlFvZVBPNlN2eHlzNXBtQ1VORU5MNEMvTkli?=
 =?utf-8?B?Y1RvL2lzMVArUmZYRVVyaUQ4M05wOWlZMUJRVDJZQUlqRU5tLzJrd25EajhW?=
 =?utf-8?B?M2h4aUdOKyt4UXZwQnBvRDV4YlRlZXpQaE5VWUdBbytjVDdzUEZ1eEVCTWVZ?=
 =?utf-8?B?OXB3UkVSOGhkZXIrdHFUMEwzMStJSFZEK1JNR25uMXdxSUc1czBwWjV6S3F2?=
 =?utf-8?B?TG9EdUw4WDhheFFudnNGT3dMdkZ0OU9wZzdOMzhPcXZhZkxsUk5iU1ZlY0xj?=
 =?utf-8?B?SlU3YVZvOFNOb0R2aEZyT0pPQ1U0Y0JiSEVMOW80UjJaS3lQNGRBenhRUTly?=
 =?utf-8?B?VUtZTjZqazZxQ3Q0R2gvRm9MUHVXWkFBeVFZOWdxNEljMExabFBaeWNxc21S?=
 =?utf-8?B?eEdkOWFydjFmK3owalZ3RVhhM1ZOc1ptbXlnVDJFandCL2t4WkJ0NWwwdk5F?=
 =?utf-8?B?TWpZWm5qajdWZVgzdjc3Wm5WQmpMUzVNTVN0KzRCWno0ai9CYllYYWlybHQz?=
 =?utf-8?B?M3V4ck9YY2RBd0NpZjcwM2Y0Q2t5amIwalFhMktJS0ZvZXpmQnRuQ00vR3Av?=
 =?utf-8?B?b0dJazNxa1VjQUpxRXNxRWk3MzdVaFNLVXRubzJOVHBYcXZ4WmN2WWV2R3pL?=
 =?utf-8?B?eGJReDNqbThpWWFYdGcvOFNDN0RXaDN2WlBHVUl1eG94eno4L1FtRW04Tm50?=
 =?utf-8?B?Z0tuS1ZWSDhZYkF3OGJqV09FMkY3UUJkU3FYNE5WaDZMTlA5ZUJ5Tkg2NmVv?=
 =?utf-8?B?Q05TcGJLOG05UENGb3F4dDBoSlI1enRFd3V0Zkg2aTZ1VnVaWkxHL3J3V3Bt?=
 =?utf-8?B?OVBDd0psTzBvZEdZWVI2N0lmTm1HTmI0b1FQdSs0VllTelp5MjcrTDNWSHFS?=
 =?utf-8?B?dE53bGxRQnRWNytuMXNIa3l4KzY4WkdOdVlCQU5qZ044R3hweHNhU3ZxNVYr?=
 =?utf-8?B?MUZvY0ZJK2lEZVdQUVNEenNhbnZha1IyVVJDZFBwOGRVNnZYalFlTHZBcXRs?=
 =?utf-8?B?Q05TRG8vNVF3N1VHbHZDUURwS1NMV1UxK1lET3hpSzE0bm9tWkM2T1JQYkpF?=
 =?utf-8?B?RnJpNjhwMWVDd2g0REt0WjlndkZwb0FYL3J2aHB0TVlzRW1xck1tdUJ3WFJn?=
 =?utf-8?B?bWl3MFdFZHQ5emxoM0VmTkdKZVdLLzBld284WGNvNWxkQUplQzFjT1NBdkpw?=
 =?utf-8?B?TFZ3YmFHaTVacFpESVZjUHdjditma3FFR2lJZ0MxaHFrY0RBdEQvSVBZQml1?=
 =?utf-8?B?dTU3Q2RmYXlxRTB1TjBLdWJlMzYzK3IwTFpwQmVJNUdUKzcvTDFGVDYzU0Mw?=
 =?utf-8?B?QTV3R2JPQ20wc0FxUjlCYXBhK3JMbld5bHEvamN1dVlJS1BrSzlUcHh5NkdV?=
 =?utf-8?B?dWR4M0VZclNVZmNCU3cxVVlhM1dvcDlaUTM3QlRYRStuOEdCZ0oxeUdrQnNM?=
 =?utf-8?B?RVRqeTVmSDA3Y1l1aUcwMVdNRit4Zlc0VTZmT3Y2QUREWjBzKzI4QkFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXhWVjVwd0tFTGwwSzdpay9pL052dWZGVVF1eEs3c3RHK3ZYM3JRL0JUdzV2?=
 =?utf-8?B?YWpKMU9rbWhZL05JMm90ZGNMTC95T1V6dTdsL095R0FNZ2xma21JL2xxZ2o4?=
 =?utf-8?B?M2krK054NGk3YWIyam1vOG1MY3ZPRDR0aFEwQWRDTjBBYkVKb2JXZEkxajlr?=
 =?utf-8?B?RFFTUFRkYitza29HRUN0cWRGTERyOFVUeWZtbTJTYkYxZE9UOVpnV2prQ2hR?=
 =?utf-8?B?REZoYTQyQVFHWHZnNmlNOFR5dXdXamNyOWNaQzNyVTNMVnQ3QU90NmlEbjQ3?=
 =?utf-8?B?QTYrS2tVMFZVdjBpTWZYZzdDTk9XY1BBaDAwWmpralhIbGErb3BTYmpBQjdr?=
 =?utf-8?B?L0ZHLzlmUTV4ak1OT2EyVklSMlNSM3YxUW5nd3QxUlpEMmNLTWN2aDBXSGVX?=
 =?utf-8?B?YmhoSEhnNVFReitvK2piaGNrNmpvczN3MmVZSUp4akVST3QvYUQzdmJZdjEy?=
 =?utf-8?B?NnZTT0JneXhxMkJQNk5hME9aMjZjQnlMbElHNWdqbDNhMHNqVXRibjVYcjdy?=
 =?utf-8?B?eTZFZ2hRNC90ak5PVWxwdkhjbm45eTRRUnVqL01nRk15dHRLU3pCQlZueXdz?=
 =?utf-8?B?cE1QZlg4WU5KSms2M2dWRVpjWW1MOUlJWjhkcG84cllWYkZxcFRzYmwwUTVX?=
 =?utf-8?B?REdOZnJUNnJzSUNTVjh6b3dVNzJMTjJEMlBPQTNrOWh1ei8rV09Gd0Y2WS9k?=
 =?utf-8?B?dktpVjZpV0JPcnhRZlkxcWlKTzdrNXc2bVF6clp3amRBQ2NxL01MQ2xuM0RI?=
 =?utf-8?B?bXQ3cTlMUnBEbEtGdFpNb1RCRFB2Q0ErdnNVa3FsckkxZlVOV2orTVJjWHhp?=
 =?utf-8?B?blJPWDBjUHFFekd1SmVCelRyNXpxQi9MN05GTzJHbkgzREZmT1ZtbFcvR01l?=
 =?utf-8?B?SW1EZVJmQlVOUGtvTHZYKzduMTczZmJZOWl5QnZMbW1tT3IxcEtzYngxVU9F?=
 =?utf-8?B?N0V5M0JnVTJOZEljeTV0V3Z5ekczL0RKUGdTYXdyeG9rcDRCb2hIMjFzNnRP?=
 =?utf-8?B?b3pRcDVoOUZ6SnZWekU3YXFIVTkrZ1ZlRWQzS25GYnVQdGdUQXFVdE9QaVBG?=
 =?utf-8?B?ak5tZDAyaCt5YWd3L0sraEYvSkZPR3YwZms3cmlmYjFWY1FXVXhOeXI5S3l4?=
 =?utf-8?B?UGxNeWoxKzVIUGFhdGN6WW9hSzIyajFrZkRXK2VnS05qUW40WC9GdkNzMTQr?=
 =?utf-8?B?dmZnTDZndDE4aWdPSVNocll5TGpUZWRSSVk1SUMvLytaeWxRWkxoUVpQcTdm?=
 =?utf-8?B?Vk1ZdDY2Q00yQklEN2hPeDlvWVR0WGtDY3JGRHlvNFdBcUtMOG1wT3VMSFU5?=
 =?utf-8?B?dHJMcmVLbGdFK1BZRk0wejA2TFp1MzRIZEF0TllOd2hHNTZMaU5xY2R4K0w2?=
 =?utf-8?B?L2hTb2xqVkNyZmkvZzdpOVM0V2IraUsxZm15S0Z4bDhFdWthS3UrK29xTzRC?=
 =?utf-8?B?N1R5emo4cmpEYW5YcERaYnZZcGxra1pETVZNSUxUUTVVdEZXZUVNekdiWXp1?=
 =?utf-8?B?MjAwWE5rdmZuNkVuY0Q0Y3F2MmVDeXRhSmRqMXVPcTR6bklwNng5akxhQmZu?=
 =?utf-8?B?cFM1ekI1aUpMSmx6NWVYMEkwVnBNRFNBd2VKbDRxT0ZlL00xL0taVDFjNS9Y?=
 =?utf-8?B?WjhkemcvYVNSK3pOTTZ5TDIybFdyZ3RTTmxTTlVINEVhem5hd1VLb0Iycmx2?=
 =?utf-8?B?WlpZUFlsVUhCcExtWGpOWElkNmkzWEZTUXlIbWFUb1haamErTjhHMFRsR3pD?=
 =?utf-8?B?VXZiNDdieTBydG1SQ0RLWGhDaEtuSm1Rc1pySWY0ZEFUb1dld3Z4a1BxRmNq?=
 =?utf-8?B?eG1haTBtdk4xaXZOWWp4eXU5WnBibmszSE1jQVZXVW5mQXVmL0FSNmU0eDcz?=
 =?utf-8?B?RVBCeXBwaEk4Q0pueUxVRW0vWm5nL0pDWklFTW5XZjcvRWJQZmpRQjI0TjZz?=
 =?utf-8?B?V2tZN3RPam0rSnJXVElhL2hpMkVBTFFKUHFwcVhXd3NmSENkLzFSUWJTRWNT?=
 =?utf-8?B?Um1CZlJrUHdXTjRGRmtjYjQwS1BMOEZsL05zaUNXZU4zME85Um9scFUydXRp?=
 =?utf-8?B?b3RScUVJaU5PVno4V29Ba2ZpNVArOWdXc1E3emZYVGZaV0w0SmZFeC85UEow?=
 =?utf-8?Q?GCSI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 742765c2-e48a-4b3c-3409-08dce37eed7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 07:42:26.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVhZEpV2Xxi0KJLGwZ0LA7ovwuAu1yfHPUsDkd9xYHqR9MqscU8Na4lY6V+i0cX3zg1l8fpu56tUzNgRL4QiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXks
IE9jdG9iZXIgMywgMjAyNCAxMjozMSBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxh
bWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vckBrZXJu
ZWwub3JnPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC0NCj4gc3BpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkNCj4g
PGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGR0LWJpbmRpbmdzOiBzcGk6IHhpbGlueDogQWRkIGNsb2NrcyAmIGNsb2NrLW5hbWVz
IHByb3BlcnRpZXMNCj4gDQo+IE9uIDAzLzEwLzIwMjQgMDg6MjMsIE1haGFwYXRyYSwgQW1pdCBL
dW1hciB3cm90ZToNCj4gPiBIZWxsbyBDb25vciwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+
ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDI0IDEwOjEwIFBNDQo+ID4+IFRvOiBN
YWhhcGF0cmEsIEFtaXQgS3VtYXIgPGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+DQo+ID4+
IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBicm9vbmllQGtlcm5l
bC5vcmc7DQo+ID4+IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4ga3J6aytkdEBrZXJuZWwub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+ID4+IDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29t
PjsNCj4gPj4gYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGR0LWJpbmRpbmdzOiBzcGk6IHhpbGlueDogQWRkIGNsb2NrcyAmDQo+ID4+IGNsb2NrLW5h
bWVzIHByb3BlcnRpZXMNCj4gPj4NCj4gPj4gT24gTW9uLCBTZXAgMzAsIDIwMjQgYXQgMDM6NDQ6
NDdQTSArMDAwMCwgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0KPiA+Pj4gSGVsbG8gQ29u
b3IsDQo+ID4+Pg0KPiA+Pj4+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6
IHNwaTogeGlsaW54OiBBZGQgY2xvY2tzICYNCj4gPj4+Pj4+Pj4+IGNsb2NrLW5hbWVzIHByb3Bl
cnRpZXMNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBPbiBNb24sIFNlcCAyMywgMjAyNCBhdCAw
NjowMjo0MlBNICswNTMwLCBBbWl0IEt1bWFyIE1haGFwYXRyYQ0KPiA+PiB3cm90ZToNCj4gPj4+
Pj4+Pj4+PiBJbmNsdWRlIHRoZSAnY2xvY2tzJyBhbmQgJ2Nsb2NrLW5hbWVzJyBwcm9wZXJ0aWVz
IGluIHRoZSBBWEkNCj4gPj4+Pj4+Pj4+PiBRdWFkLVNQSSBiaW5kaW5ncy4gV2hlbiB0aGUgQVhJ
NC1MaXRlIGludGVyZmFjZSBpcyBlbmFibGVkLA0KPiA+Pj4+Pj4+Pj4+IHRoZSBjb3JlIG9wZXJh
dGVzIGluIGxlZ2FjeSBtb2RlLCBtYWludGFpbmluZyBiYWNrd2FyZA0KPiA+Pj4+Pj4+Pj4+IGNv
bXBhdGliaWxpdHkgd2l0aCB2ZXJzaW9uIDEuMDAsIGFuZCB1c2VzICdzX2F4aV9hY2xrJyBhbmQN
Cj4gPj4+Pj4+Pj4+PiAnZXh0X3NwaV9jbGsnLiBGb3IgdGhlIEFYSSBpbnRlcmZhY2UsIGl0IHVz
ZXMgJ3NfYXhpNF9hY2xrJw0KPiA+Pj4+Pj4+Pj4+IGFuZA0KPiA+PiAnZXh0X3NwaV9jbGsnLg0K
PiA+Pj4+DQo+ID4+Pj4+Pj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+Pj4+Pj4+Pj4gKyAg
ICAgICAgY2xvY2stbmFtZXM6DQo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICBpdGVtczoNCj4gPj4+
Pj4+Pj4+PiArICAgICAgICAgICAgLSBjb25zdDogc19heGlfYWNsaw0KPiA+Pj4+Pj4+Pj4+ICsg
ICAgICAgICAgICAtIGNvbnN0OiBleHRfc3BpX2Nsaw0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+
IFRoZXNlIGFyZSBhbGwgY2xvY2tzLCB0aGVyZSBzaG91bGQgYmUgbm8gbmVlZCB0byBoYXZlICJj
bGsiIGluIHRoZQ0KPiBuYW1lcy4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gVGhlc2UgYXJlIHRo
ZSBuYW1lcyBleHBvcnRlZCBieSB0aGUgSVAgYW5kIHVzZWQgYnkgdGhlIERURy4NCj4gPj4+Pj4+
Pg0KPiA+Pj4+Pj4+IFNvPyBUaGlzIGlzIGEgYmluZGluZywgbm90IGEgdmVyaWxvZyBmaWxlLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IEF4aSBRdWFkIFNQSSBpcyBhbiBGUEdBLWJhc2VkIElQLCBhbmQg
dGhlIGNsb2NrIG5hbWVzIGFyZSBkZXJpdmVkDQo+ID4+Pj4+PiBmcm9tIHRoZSBJUCBzaWduYWwg
bmFtZXMgYXMgc3BlY2lmaWVkIGluIHRoZSBJUCBkb2N1bWVudGF0aW9uIFsxXS4NCj4gPj4+Pj4+
IFdlIGNob3NlIHRoZXNlIG5hbWVzIHRvIGVuc3VyZSBhbGlnbm1lbnQgd2l0aCB0aGUgSS9PIHNp
Z25hbA0KPiA+Pj4+Pj4gbmFtZXMgbGlzdGVkIGluIFRhYmxlIDItMiBvbiBwYWdlIDE5IG9mIFsx
XS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBbMV0NCj4gPj4+Pj4+IGNocm9tZS1leHRlbnNpb246Ly9l
ZmFpZG5ibW5ubmlicGNhanBjZ2xjbGVmaW5kbWthai9odHRwczovL3d3dy5hbWQuDQo+ID4+Pj4+
PiBjb20vY29udGVudC9kYW0veGlsaW54L3N1cHBvcnQvZG9jdW1lbnRzL2lwX2RvY3VtZW50YXRp
b24vYXhpX3F1DQo+ID4+Pj4+PiBhZF9zDQo+ID4+Pj4+PiBwaS92M18yL3BnMTUzLWF4aS1xdWFk
LXNwaS5wZGYNCj4gPj4+Pj4NCj4gPj4+Pj4gU28gaWYgaGFyZHdhcmUgZW5naW5lZXJzIGNhbGwg
dGhlbSAicGlua19wb255X2Nsa19hY2xrX3JlYWxseV9jbGsiDQo+ID4+Pj4+IHdlIHNob3VsZCBm
b2xsb3cuLi4NCj4gPj4+Pj4NCj4gPj4+Pj4gIC0gYnVzIG9yIGF4aQ0KPiA+Pj4+PiAgLSBleHRf
c3BpIG9yIHNwaQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBZb3UgaGF2ZSBkZXNjcmlwdGlvbnMgb2YgZWFj
aCBpdGVtIHRvIHJlZmVyZW5jZSByZWFsIHNpZ25hbHMuDQo+ID4+Pj4+IENvbm9yJ3MgY29tbWVu
dCBpcyB2YWxpZCAtIGRvIG5vIG1ha2UgaXQgdmVyaWxvZyBmaWxlLg0KPiA+Pj4+Pg0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+PiArICAgIGVsc2U6DQo+
ID4+Pj4+Pj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgY2xv
Y2stbmFtZXM6DQo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICBpdGVtczoNCj4gPj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgLSBjb25zdDogc19heGk0X2FjbGsNCj4gPj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgLSBjb25zdDogZXh0X3NwaV9jbGsNCj4gPj4+Pj4NCj4gPj4+Pj4gTmFoLCB0aGVzZSBhcmUg
dGhlIHNhbWUuDQo+ID4+Pj4NCj4gPj4+PiBUaGV5IG1heSBiZSBkaWZmZXJlbnQsIGRlcGVuZGlu
ZyBvbiB3aGV0aGVyIG9yIG5vdCB0aGUgZHJpdmVyIGhhcw0KPiA+Pj4+IHRvIGhhbmRsZSAiYXhp
NC0gbGl0ZSIgdmVyc3VzICJheGkiIGRpZmZlcmVudGx5LiBUaGF0IHNhaWQsIEkgZmluZA0KPiA+
Pj4+IHRoZSBjb21taXQgbWVzc2FnZSBraW5kYSBvZGQgaW4gdGhhdCBpdCBzdGF0ZXMgdGhhdCBh
eGk0LWxpdGUgZ29lcw0KPiA+Pj4+IHdpdGggdGhlIHNfYXhpX2FjbGsNCj4gPj4gY2xvY2sgYW5k
IGF4aSBnb2VzIHdpdGggc19heGk0X2FjbGsuDQo+ID4+Pg0KPiA+Pj4gQXBvbG9naWVzIGZvciB0
aGUgdHlwby4gV2hlbiB0aGUgQVhJNCBpbnRlcmZhY2UgaXMgZW5hYmxlZCwgaXQgdXNlcw0KPiA+
Pj4gc19heGk0X2FjbGssIGFuZCB3aGVuIHRoZSBBWEk0LUxpdGUgaW50ZXJmYWNlIGlzIGVuYWJs
ZWQsIGl0IHVzZXMgc19heGlfYWNsay4NCj4gPj4+DQo+ID4+PiBJbiBteSBuZXh0IHNlcmllcyBJ
IHdpbGwgdXBkYXRlIG15IGNvbW1pdCBtZXNzYWdlICYgY2hhbmdlIHRoZQ0KPiA+Pj4gY2xvY2st
bmFtZXMgJ3NfYXhpNF9hY2xrJywgJ3NfYXhpX2FjbGsnICYgJ2V4dF9zcGlfY2xrJyB0byAnYXhp
NCcsDQo+ID4+PiAnYXhpJyAmICdyZWYnIHJlc3BlY3RpdmVseQ0KPiA+Pg0KPiA+PiBUaGVyZSdz
IG5vIGRyaXZlciBoZXJlLCBzbyBpdCBpcyBoYXJkIHRvIGtub3cgKHdoeSBpc24ndCB0aGVyZT8p
IC0NCj4gPj4gYXJlIHlvdSB1c2luZyB0aGUgYXhpDQo+ID4NCj4gPiBXZSBhcmUgd29ya2luZyBv
biB0aGUgZHJpdmVyLiBPbmNlIGl0IGlzIHJlYWR5IHdlIHdpbGwgc2VuZCBpdCB0byB1cHN0cmVh
bS4NCj4gDQo+IFdoeSB3b3VsZCB5b3Ugc2VuZCBzZXBhcmF0ZSBiaW5kaW5nIGZyb20gZHJpdmVy
PyBUaGF0J3Mgb25seSBtYWtpbmcgZXZlcnl0aGluZw0KPiBtb3JlIGRpZmZpY3VsdC4uLg0KDQpB
bHJpZ2h0LCBJIHdpbGwgc2VuZCB0aGUgbmV4dCB2ZXJzaW9uIGFsb25nIHdpdGggdGhlIGRyaXZl
ciBjaGFuZ2VzLg0KDQo+IA0KPiA+DQo+ID4+IHYgYXhpNCB0byBkbyBzb21lIHNvcnQgb2YgZGlm
ZmVyZW50aWF0aW9uIGluIHRoZSBkcml2ZXI/DQo+ID4gSW4gdGhlIGRyaXZlciB3ZSBkb24ndCBk
byBhbnkgZGlmZmVyZW50IG9wZXJhdGlvbnMgYmFzZWQgb24gdGhlIGNsb2Nrcw0KPiA+ICwgd2Ug
c2ltcGx5IGVuYWJsZSB0aGUgYXZhaWxhYmxlIGNsb2NrcyBpbiB0aGUgZHJpdmVyLg0KPiANCj4g
U28gaXQgaXMgdGhlIHNhbWUgY2xvY2s/DQoNClRoZXNlIGFyZSB0d28gZGlmZmVyZW50IGNsb2Nr
cyBhbmQgZGVwZW5kaW5nIG9uIHRoZSBtb2Rl4oCUTGVnYWN5IG9yIA0KRW5oYW5jZWTigJRlaXRo
ZXIgY2xvY2sgd2lsbCBiZSBlbmFibGVkLCBidXQgdGhlIHB1cnBvc2Ugb2YgYm90aCB0aGUgDQpj
bG9ja3MgYXJlIHRoZSBzYW1lLiBXZSBjYW4gaGF2ZSB0aGUgbmFtZSAnYXhpJyBmb3IgYm90aCB0
aGUgDQpjbG9ja3MgKGF4aSAmIGF4aTQpLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGFyZSBm
aW5lIHdpdGggdGhpcy4NCg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCg==

