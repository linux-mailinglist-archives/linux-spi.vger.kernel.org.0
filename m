Return-Path: <linux-spi+bounces-9609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B906B31C5B
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3288E1D40ED0
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FD2E3B06;
	Fri, 22 Aug 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="bFaWu1Ri"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023141.outbound.protection.outlook.com [40.107.162.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17E305E05;
	Fri, 22 Aug 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873413; cv=fail; b=fO0rBEhGqSPoelmUw/uemd43F93YP6BKYULCIGVYwdWS2Q7Dr82mN7n5+QSggYyY3o+sfMXMDG2JUZgknZhSBkWTOtgcojdAsTt+Zzs12t3g1AzNZZWdAcoFwq/ozg/EQKZ1Z0oApKqC6lmBR1sWegpk+4t0Xe93bk/pHemzTMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873413; c=relaxed/simple;
	bh=6O9uPjdcxRKfIFKI4IOIoWio5idHlzGSjEDEEzcj1PE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1JaEm70VRGRo1MfCz+SSdB9LJwLjenviz8BOItCCnuEIerdh0fQXJMYZlm1/DD1TK5G1+UV4delU3qsIse97QY4r6sM/2jASJb3cbyFfZv5JQdpgNXz6j9BpHLTm3aHFzDrKo7G+6QTP/qjNml5Li9TKCzRFxTy9wJjjFOO9/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=bFaWu1Ri; arc=fail smtp.client-ip=40.107.162.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfScwJl4bPiSjivgHbhRt3kR8hTpihomgAGB5rNpSW76QGDwljHOjeLq6ij8vBgpqTpVIzWqrZlViUIKzPV8mO7JER2szQVK2nd/wvnY8083E9X6YTRYq49xjP0/onYq1pj5yZi2Kwcyn7GhWpdyeESBDkgDQOx9ZPI6wCNUyukK61OCb7SKIKnCGwtom+WyBaOcL0QEaX+z9PE0zRpy+hRyRrhQ4a97CZRbw6utyMVP+wpsjP0kfHK7YYSygJW6GAkEp22usY79ZhEqmDW9/34qY434pYTfGl7U8p7zQnymFBNR2hBti6GFFnrKXhNUw/7JG9ZAQxpjInzexhK+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+lStRgYIP8b4uo65IQQMCBpFKfv6IGr4BSRA0rCXWw=;
 b=ke8GwBDAsFSpFP5AqfS6G7vYbRCShuKfD9zyzCUa8VN6Xr0hKIK5icMJ/q1o9GB7rWl0HWONzJqKHvciKsqAEQlzH+F57y+HoUm5ZkPEjwliU+O2kaWrHIxMib70k0rH4l1yWHre/1ppI7h0j2tFZUSyhtMVLNRCdO7cWtBxP1MasvpvMPt/esTiQZ+roEbBZqZhme1DLpRMzf+W3jIdIJzgLWvraNZzQHz1Gi8kHhx/pP/DfZ7xkZdakbcmXpT9j2ErX+ittR1D7A+cOUAAbg/4C24QUEp8llLrtHTJEVtt6tCf2qS4qj6YU6L0Iv3DIUWJSfFfH24HlTB/xYlw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+lStRgYIP8b4uo65IQQMCBpFKfv6IGr4BSRA0rCXWw=;
 b=bFaWu1RiWZJarbUDkuV+KP75HPz96UpFOuTJTs738Dz4oIxHOrW1e0pErRip1aSDxg6owML8ModF/xCZp5ysPzqZTf2+W1jVo8PE4BOfcXsfnblsM/8xDBp/Oyu50OCE5Ue7S7qXJXgZEU/7AFZcYGA3zkd61iSPIp7SaXLlHHLD3v0J/5yB6XQSVOOcDoRE4GgOGU8/5qWGVLpcCDukimy3Btcl+WE2vb6zMnxMEqIu+Z6XFLOqFisqN+w9BTjHJjQpLKKtEAeFH0+FdxU1HPXylND4IW+XbaXQTgdbUssNej3YAg7wY1ODZqF2CrPLBCUFBtwGUzttYB4Hvm6rwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9404.eurprd08.prod.outlook.com (2603:10a6:102:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:36:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 14:36:47 +0000
Message-ID: <9fd1c355-d206-4a2a-bfa5-1e1f15729a1e@iopsys.eu>
Date: Fri, 22 Aug 2025 17:36:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
 <aKcEYn_hX0ZIusne@lore-rh-laptop>
 <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>
 <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <1d053317-24a6-4bba-aa30-ad42460ec19b@iopsys.eu>
 <aKhtP1G7as9b2c4f@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKhtP1G7as9b2c4f@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::26) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 453d427b-c413-41da-6cd1-08dde18952e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZkNzgzSHNHZVJLQXFranY4YUx5VHVvamlIeThmYmNLRDl0NzRla2JmQ3p5?=
 =?utf-8?B?Z2FZc0JxS2xqU0pxYkZ1RTQ3VUdtQUFpL1lodW1aR2lFK3B0WWpnVFJTWk94?=
 =?utf-8?B?TlZtd3ZJV3JkYU9pRFFQTTVGS2hiZkhGc2tpUWphekdxRS9rbFZIM040VU4w?=
 =?utf-8?B?NklsdUVUZ1BxNWp2cUNkVlRRU2hFdlNMT1kxZTJDdm0wTjVGVmpoRFgwdFNC?=
 =?utf-8?B?TU9LMWxzRUhrQ1VjUU9YQ1VUVytsbmVVeU1Vd0xVYldZVVRRQThtc0JqMWVt?=
 =?utf-8?B?d2ZKa05WQUJLMGpwelZJaFBUOWlYN3B1THZkYit4MjlhbEJmZWxucjMrZHha?=
 =?utf-8?B?VzZ0a3c4Vm1OQWx0U1BIR0JUbUNtTnBMdFRLSFo4NTFNYlpGcDh5TzdOdEsz?=
 =?utf-8?B?VG9VRy9ERnFhYWJCaldPQ1RKcXVWV21nc0hwY1Z5UkxDVXNTbS9kTkNvK1dq?=
 =?utf-8?B?NHhnSEVjU2xiOTE1NHVIbDU2RklvTUxMaU1xRmlGU0Q2U3FWOFVmSDdDNmlW?=
 =?utf-8?B?N1dLZVhOTXRpT2wrM0ZiSTJ5cnVsakJMN1BkUXU0NG4rNW0remJXbzlrTWhS?=
 =?utf-8?B?OUJZMVRZYWxkYVNUTlNUcVNMMEx0R1dpcThHZkIvSnJKV085Tko2YVEvYUh6?=
 =?utf-8?B?UWN3MWNyY2JHZTQyZnAxTHo3bmNMZlBDeHhUNnNnSTY3NlZZdkxCYzR6WjFE?=
 =?utf-8?B?d0R3UTQxMEl5MitYaG11VmwrcG1CUU9iZU1nN0cvV0w1RlhKRy9zNVI4NHdj?=
 =?utf-8?B?OXBJendGM3hTZk9HQk9uWDJyYmNRdU1RTVNaNkF0UTRNSkhmS2w3Ymh2UEc2?=
 =?utf-8?B?VUNpbUJueHF2cmhzT2tLWDdrYkg3MkI5ZzNQVjJDYzdKa1hPOGpzZE81bGpQ?=
 =?utf-8?B?TVZwNmZOK3RWUFEyQmhiNWdlVGhFREkrNlRGWlNSRGF6QS90bDBxdDJtY0pC?=
 =?utf-8?B?eTczUnZRdEtHWmd4OU1kaHZWRE0vMGkzSzYxZ09LUzVCR2s1Vyt3KzZPQ0g2?=
 =?utf-8?B?UjVGbGthNDljcEszR2pUOUpFMzR0M2ltdEFMNm9CTk9KY0lBZnhqeHgrNlNm?=
 =?utf-8?B?aFJWc1NkcGlJV0RoZVdzRTBJNU12QTRQSnBNdGRqOUxMN1BXbkJuaktKMnlh?=
 =?utf-8?B?d0RmRFVqZmU4NHl1UHAvdTZDOHpMQ1IraUVLVFR3WGJpelZRcEgzOGtkeEs0?=
 =?utf-8?B?L0NRVmpQQjR1bzV6c3NvMllBYXJRVktDQjVnVGV5eUlKTFlCd0lwSS9lQ25R?=
 =?utf-8?B?MWJPTW04S0tTQTdKNm5EMmxodmFYRjZDOS9ZMjAraGJMSlZuSEdIbzZ5YWc3?=
 =?utf-8?B?ckR3c1RzMElQZ2ZxWGN4Vnk3Q0tWRzFrbHR1WUgrWlNKRFVOLzBvZG9oSUdY?=
 =?utf-8?B?NXYvZVZjZ0t3ZnNWdVpKaFMrbnp0RWY1eG83MG5SSkk2UE9qcUZkdE1BdmlI?=
 =?utf-8?B?SUliT0ZWUVRFSUlHSlR2cEFhK09ZM1owTERyRWFIbHRPM3NTVk5JUHVUbndx?=
 =?utf-8?B?em1XTFptazQzUExmRlRwak02eEFEQ3p6U0JoS2dISnlZU2JhdnNlc2ZoTC85?=
 =?utf-8?B?ZG9uclozU05QSm5xdmpCWnBSZW5PSStaeWt0cTZOdmhQZndmWHpuUFI0UjJL?=
 =?utf-8?B?WnVTMFR1Sytndnc1K3lhYWhyUGJ1ZTN2UDQyOGoxL1VtZzR1MWZwVDVIeWpa?=
 =?utf-8?B?NVdZY3NqNmtHcE5LRFdlTTJaOHI2SVhXUDlKSFRveFpjcXExaGRhZ3dPSzBY?=
 =?utf-8?B?WHFXVmhjTzlUelRrN1BCVFdDRmNzWk5SbUQxSjZ2Q2VKRWFEMldTQVdYV2RU?=
 =?utf-8?B?Q21PWUJyakl6aVZiOG1kb2d6Z1ZUNkxjRDhVM2ZKd0d1c2xwUjZ3RE5seHgr?=
 =?utf-8?B?eDlmckczM09CSE5ObnQvczRzZXgxQjhZV3hIWk1VVXNhUGhRYUd2dVhOYVdh?=
 =?utf-8?Q?qxPWPG0eME0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTBQdjFRWEFTbHIxMVlNVnc5dnRCdXQzZ0F1RDNRcUhoV2JSQlhGYlRaQmh5?=
 =?utf-8?B?UFN0Z1hldXFSdDFXbVMwRTRRL2E0WE8yV1JMMUNnZWxRbE11WVM0VmFpVE9q?=
 =?utf-8?B?cjU0L2JXVTRjby84QmFibnZPR1hGTWxZZDNqSzFVYXB1M2czVS9rTTFubzdn?=
 =?utf-8?B?d29Xd0NLM2pHUWYrMmx0Vjl0VmxaMDlsbEpFOE1sRmh5SytMT3ZyVzUzZVV1?=
 =?utf-8?B?Z0k5VXRWaVZqcjY2SWNkRStTRFZ5Tk4zUEt0UG4rWFJodXlOeDFsQlFKRzZx?=
 =?utf-8?B?WU95V2NjRnJyaEdSZFc4K3FHd0JVSmRjWktxS0JJWlNxcHlIZkxKL3JQakpB?=
 =?utf-8?B?UE05RkRMYVM1NTZ5aVVNZmFRcWNsQUJaQWY1TitsTHBtZWFXbEIyTGV1NS8v?=
 =?utf-8?B?dTQzL05WQkd3OEVubWowZ3RqbmkvQkZycGJyaktSN3h0bmxCKy81MkxYNUw5?=
 =?utf-8?B?aFFVZnNhNWpxcVEvMTkxeEVPRjFSWWRsZVhMRTJrd2pybDJoc01LZnNBZXVz?=
 =?utf-8?B?elBMU09XYTZBYUJSVnhtTXZ3R2lGLzViOG5QT3ZZSkQzOFZlanNqaHRxa2Nq?=
 =?utf-8?B?RDhTMXI2M3ArVjZrTHdPMVovcFRZNUNBSmdoMVpFWStnVUdYSUlKRzN6SmN2?=
 =?utf-8?B?L0VQT2F2dG0zYXVZYlhtWDE0REVUK1R6RDhUMlhHenA5VnppZzVlTE5abjRN?=
 =?utf-8?B?T21vc0lwK3F3WjFnZFgvUCtONW10ZEc2Z3F0Vzh0WjM2bFZMWkxOS01BQ295?=
 =?utf-8?B?Y003bU0ycnFtbGxOV1FzSFBDYmdYNWFIUEVGWHVxQmNJYWgvcTgydXJ2blVY?=
 =?utf-8?B?STBkU1ljOUZKaHByWUpCK1ZjRTBHNlNYLzlzS0hKNThEQ2pEU3JIVEFhY29h?=
 =?utf-8?B?YXNtaXlQdDlXNjMrME9VTjgrWjRSa2xxZHRRYnQ1ZUo2a0thMXJXSy9RcjBr?=
 =?utf-8?B?TGVqNm9CaUFlRFVOM1RnRGU3d0szYzN5RWcvZUNuVjhnTi9MMThKOXJ0a2ZK?=
 =?utf-8?B?T3E2UFJCb3FycmU5NjgySXhpQXJlZ3E5azFEYmk0NkJ6MXkxMGw4SDI1Tkxx?=
 =?utf-8?B?K3pIOUVoNHh4a2VINFhwa0ZNSnN2QVNyYm9Id0xkbmJ4dU9ONk9HKzgzNGRv?=
 =?utf-8?B?RytkaktyTXF5Q3NrMFA5ZUdmcnhEcTZFMThOUEhrL1M3by9kOUhZaXFtUmMv?=
 =?utf-8?B?bnlRa2tQcUpCUVdzaGIzUVhsRHRWc0R0VlVJakJNcDJORFl2UDE5NHBBVDJa?=
 =?utf-8?B?VEJMZ25YTWRLQjlrSmxNS1c0YXF3eUxmdFZ1SVdDaDFFNEZ2cWVZS0V3MWpx?=
 =?utf-8?B?T053YWJScGJlMTk3ZExSZEpxbERIbUFKZURpSUFDdGtMV1JoSXpBVGM1TFZ4?=
 =?utf-8?B?TldTSHJ0VDFXSm4vUVM3N3ZSUEw3UTlTTFlkWExIQVkxZ0pTZ05HMmNNQWNv?=
 =?utf-8?B?aVN4QkRmVW0rL214ZXlLTUxoTjBxZUFZbjZ2dlpTSnB4N3pyY1M1TlN3Mnpp?=
 =?utf-8?B?MVJGYUJlamxTQWdScXJGY21jNllBMmJOUUg1WC9sZk9HaHlSK2lFck9uN1Aw?=
 =?utf-8?B?R2VzWXM3NVRJcjFPL0RxVWtiVm9QRkhJYlZ6bTdSREFGZGV6NnZNTCs4R2lY?=
 =?utf-8?B?ZWVIS0tESGFQS0xBZWtNM0R4SllUc2dOYS80cXkxaHVzSWFVNlZEM1MwVk1T?=
 =?utf-8?B?aVM2RDRrQzBncnFvSGwvOExYYk1lY252TTNweXprL2RrZkhoZVVseU53OS92?=
 =?utf-8?B?UXNsSEw1aTNJbXZaMWtZYUxwZk9IUzlWQzhuMHArM2VuWkFDSXZtNkNkUVV0?=
 =?utf-8?B?YkJaUFRrajFCd0JjMXJmMnpQQ1p3OFk5VFlDcFBRS2RQRmNqM3BYUUdHc2hM?=
 =?utf-8?B?cUZLSU5oclhCWWtsMS9EcDlhQXQ2Y2QrL0VIWXhYMmpaZkNzc3NEN25ueWVG?=
 =?utf-8?B?M3ZFMjZRZXBPN0hwV0tqVGYvd0hUQlVPa0liNjZrbTMxUjRmQmRCSi9hRm9X?=
 =?utf-8?B?ZEpQRjVmQlUzOExOUXl3Qk9tZXJGK1phRGZZV0FrN0UzbC9qK0V5b2hjczVS?=
 =?utf-8?B?dHFydnJyTm5TSkVsSTA0LzFibWsvdlYwOUJ6SW5XOFd3RHh6VkRDaU9EL2VD?=
 =?utf-8?B?VWQrY1dIMUhseUxWYmhvT0hpK25VVnc0M3hZaktKSHpZSkN3Rmw0TUpUbFli?=
 =?utf-8?Q?yLRHjZ4eFv0IqRqWBSQNo7s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d427b-c413-41da-6cd1-08dde18952e4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:36:47.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbJIO715haTBuf/xVswRDj9eCHKSIaDqrlZkOv8pF9L0uyO2FSy1SiikIsLcDZ0lKLirmYcWVim86VHwNOyYz15lhjFFSEPbdeYK5s9XBcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9404

patch 7 (spi: airoha: fix reading/writing of flashes with more than one
plane per lun) is absolutely necessary for my flash. Without a patch

[    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
2048, OOB size: 128
[    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001350] Creating 2 MTD partitions on "spi0.0":
[    3.006159] 0x000000000000-0x000000020000 : "bl2"
[    3.011663] 0x000000020000-0x000010000000 : "ubi"
...
[    6.391748] ubi0: attaching mtd1
[    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID
header, and the data does not contain all 0xFF
[    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a
severe VID header corruption which requires manual inspection
[    6.434249] Volume identifier header dump:
[    6.438349]     magic     55424923
[    6.441482]     version   1
[    6.444007]     vol_type  0
[    6.446539]     copy_flag 0
[    6.449068]     compat    0
[    6.451594]     vol_id    0
[    6.454120]     lnum      1
[    6.456651]     data_size 4096
[    6.459442]     used_ebs  1061644134
[    6.462748]     data_pad  0
[    6.465274]     sqnum     0
[    6.467805]     hdr_crc   61169820
[    6.470943] Volume identifier header hexdump:
[    6.475308] hexdump of PEB 0 offset 4096, length 126976
[    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted
EC header at PEB 4
[    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
[    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1,
error -22
[    6.529294] UBI error: cannot attach mtd1
[    6.533450] clk: Disabling unused clocks
[    6.537583] Waiting for root device /dev/ubiblock0_5...

With a patch

[    2.980791] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986049] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
2048, OOB size: 128
[    2.994452] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.000820] Creating 2 MTD partitions on "spi0.0":
[    3.005614] 0x000000000000-0x000000020000 : "bl2"
[    3.011209] 0x000000020000-0x000010000000 : "ubi"
...
[    6.403811] ubi0: attaching mtd1
[    7.474901] ubi0: scanning is finished
[    7.487134] ubi0: attached mtd1 (name "ubi", size 255 MiB)
[    7.492649] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976
bytes
[    7.499538] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    7.506326] ubi0: VID header offset: 2048 (aligned 2048), data
offset: 4096
[    7.513281] ubi0: good PEBs: 2047, bad PEBs: 0, corrupted PEBs: 0
[    7.519379] ubi0: user volume: 9, internal volumes: 1, max. volumes
count: 128
[    7.526603] ubi0: max/mean erase counter: 2/1, WL threshold: 4096,
image sequence number: 1061644134
[    7.535729] ubi0: available PEBs: 0, total reserved PEBs: 2047, PEBs
reserved for bad PEB handling: 40
[    7.545041] ubi0: background thread "ubi_bgt0d" started, PID 619
[    7.545882] block ubiblock0_5: created from ubi0:5(rootfs)
[    7.556540] ubiblock: device ubiblock0_5 (rootfs) set to be root
filesystem
[    7.563598] clk: Disabling unused clocks
[    7.573181] VFS: Mounted root (squashfs filesystem) readonly on
device 254:0.





On 22.08.2025 16:14, Lorenzo Bianconi wrote:
>> On 22.08.2025 09:46, Lorenzo Bianconi wrote:
>>>> On 21.08.2025 14:34, Lorenzo Bianconi wrote:
>>>>>> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>>>>>>>> This patch series greatly improve airoha snfi driver and fix a
>>>>>>>> number of serious bug.
>>>>>>>>
>>>>>>>> Fixed bugs:
>>>>>>>>  * Fix reading/writing of flashes with more than one plane per lun
>>>>>>>>  * Fix inability to read/write oob area
>>>>>>>>  * Fill the buffer with 0xff before writing
>>>>>>>>  * Fix reading of flashes supporting continuous reading mode
>>>>>>>>  * Fix error paths
>>>>>>>>
>>>>>>>> Improvements:
>>>>>>>>  * Add support of dual/quad wires spi modes in exec_op().
>>>>>>>>  * Support of dualio/quadio flash reading commands
>>>>>>>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>>>>>>>    during driver startup
>>>>>>>>
>>>>>>>> Unfortunately I am unable to test the driver with linux at the moment,
>>>>>>>> so only the following testing was done:
>>>>>>> It seems to me this is quite an important rework of the driver. I would prefer
>>>>>>> to have some test results for this series. Are you able to run mtd_test kernel
>>>>>>> module for testing?
>>>>>> I'll try to build latest openwrt with this patches  and mtd_test kernel
>>>>>> module and try it on one of our boards.
>>>>> what board are you using for testing? If it is based on Airoha-7581 you could
>>>>> use the following repo for testing.
>>>>>
>>>>> https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable
>>>>>
>>>>> Regards,
>>>>> Lorenzo
>>>> What tests do you suggest to run?
>>> IIRC I run all of them. Can you please report even if there are some
>>> improvements (or penalties) in read/write speed
>> Do you mean to run it twice? with patches and without?
> I mean I would suggest to check if there are any difference in read/write
> speed (so yes, you need a baseline).
>
> Regards,
> Lorenzo
>
>>>> I have a single flash I boot from. It have only 2 mtd partitions:
>>>>
>>>> [    2.980849] spi-nand spi0.0: Micron SPI NAND was found.
>>>> [    2.986102] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
>>>> 2048, OOB size: 128
>>>> [    2.994493] 2 fixed-partitions partitions found on MTD device spi0.0
>>>> [    3.000856] Creating 2 MTD partitions on "spi0.0":
>>>> [    3.005651] 0x000000000000-0x000000020000 : "bl2"
>>>> [    3.011247] 0x000000020000-0x000010000000 : "ubi"
>>>>
>>>> Most of tests are destructive. So If I use "bl2" or "ubi" partition for
>>>> test, next time I will be unable to boot :-(
>>> yes, I flashed the device after carrying out the test.
>>>
>>> Regards,
>>> Lorenzo
>>>
>>>> Do you suggest to patch u-boot & linux to have more mtd partitions?
>>>>
>>>> This is the results of the only read-only test I found.
>>>>
>>>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_test.ko
>>>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_readtest.ko dev=1
>>>> [  159.121706]
>>>> [  159.123220] =================================================
>>>> [  159.129053] mtd_readtest: MTD device: 1
>>>> [  159.132898] mtd_readtest: MTD device size 268304384, eraseblock size
>>>> 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock
>>>> 64, OOB size 128
>>>> [  159.147008] mtd_test: scanning for bad eraseblocks
>>>> [  159.152141] mtd_test: scanned 2047 eraseblocks, 0 are bad
>>>> [  159.157549] mtd_readtest: testing page read
>>>>
>>>> Mikhail
>>>>
>>>>>> Actually patches can be divided on to parts:
>>>>>> * fixes of current driver (patches 1-10)
>>>>>> * change of behavior to avoid reading flash page settings from SNFI
>>>>>> registers during driver startup (patches 11-14)
>>>>>>
>>>>>> The changes are based on the code we are using for more than 3 years. I
>>>>>> adapt it to latest linux/u-boot code.
>>>>>>
>>>>>> Up to now the only known issue appears on en7523 chips only. Here a
>>>>>> corresponding patch description (not added to this series)
>>>>>> ====================================================== spi: airoha:
>>>>>> en7523: workaround flash damaging if UART_TXD was short to GND We found
>>>>>> that some serial console may pull TX line to GROUND during board boot
>>>>>> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
>>>>>> booting in RESERVED boot mode. It was found that some flashes operates
>>>>>> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
>>>>>> affected by the issue, Winbond flashes are NOT affected. Details:
>>>>>> -------- DMA reading of odd pages on affected flashes operates
>>>>>> incorrectly. Page reading offset (start of the page) on hardware level
>>>>>> is replaced by 0x10. Thus results in incorrect data reading. Usage of
>>>>>> UBI make things even worse. Any attempt to access UBI leads to ubi
>>>>>> damaging. As result OS loading becomes impossible. Non-DMA reading is
>>>>>> OK. =======================================================
>>>>>>
>>>>>> Regards,
>>>>>> Mikhail
>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Lorenzo
>>>>>>>
>>>>>>>>  * Driver compiles without error.
>>>>>>>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>>>>>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>>>>>>>    additional fixes for continuous mode.
>>>>>>>>
>>>>>>>> Changes v2:
>>>>>>>>  * minor fix
>>>>>>>>  * add comments to code
>>>>>>>>
>>>>>>>> Changes v3:
>>>>>>>>  * add patch to prevent continuous reading
>>>>>>>>
>>>>>>>> Mikhail Kshevetskiy (14):
>>>>>>>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>>>>>>>   spi: airoha: remove unnecessary restriction length
>>>>>>>>   spi: airoha: add support of dual/quad wires spi modes
>>>>>>>>   spi: airoha: remove unnecessary switch to non-dma mode
>>>>>>>>   spi: airoha: unify dirmap read/write code
>>>>>>>>   spi: airoha: switch back to non-dma mode in the case of error
>>>>>>>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>>>>>>>     per lun
>>>>>>>>   spi: airoha: support of dualio/quadio flash reading commands
>>>>>>>>   spi: airoha: allow reading/writing of oob area
>>>>>>>>   spi: airoha: buffer must be 0xff-ed before writing
>>>>>>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>>>>>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>>>>>>>     REG_SPI_NFI_SECCUS_SIZE registers
>>>>>>>>   spi: airoha: set custom sector size equal to flash page size
>>>>>>>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>>>>>>>     during driver startup
>>>>>>>>
>>>>>>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>>>>>>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> 2.50.1
>>>>>>>>

