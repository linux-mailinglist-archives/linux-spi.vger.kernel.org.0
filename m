Return-Path: <linux-spi+bounces-5187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30671998221
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD11B2D468
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85451BE864;
	Thu, 10 Oct 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BlLGzu7B"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A61BDAB1;
	Thu, 10 Oct 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551884; cv=fail; b=hejQVJC7BompwXdaICrtL2aBG+SdzL5NrRIM3ae7V6sRWbOcTQbo4+tR//JQ/mOY/rbyYwzHT+sngb142gvhHlxWR4Fxa3FirE+abbAEmVYcNScQHfeviHcp8YbB8CBIkG1qA8lHw8YtB7qDtSZAAxksGPogpBhhRMX0R8/p8MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551884; c=relaxed/simple;
	bh=5+w/Tiqs70ngPj4Hm5zOUzmKXeqJbGzzDDwQnbw9sGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hqm7ThB27wtP8En3aF9XzmVMGkqrNhJXlFJFX7tjURLyFiGjjJK5l8hDpwQbGbewglCazxPxcMarmDhdiT21RIzSwyEGeSmOVmO8kNDURO8M0h8WyS8u9x22AMzh8ExqCIFnS6nlgUoldLAq8A8KcolpufInBbzmjJCW3msrc9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BlLGzu7B; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA5/T6/f9vHxGq1csV+5S0RfpDjV90dCQa9SXLycSTp8fpmVg0STwWtb7Zyq6pdCgwTSJakzrcXVHs4me5gqJjBkL2gbQkTBsO8c3AVi26sO+RkSFlHS7FsAjrC4cYuBSLWbLY5P9miyvZUO1vesCw4G9yJFSdH7R4t5pXeUY3CELBS1aPOnUhv6oTDTnnE4nnwcSDHM9qxot1fJ+J2EaULGfayqekIL/xZXUl5kJf036VInwjNe5VIrSSaPWl9xfJWqwL4VBFB/X66wRrIstasrCT7IEUFjGu2rH/2wZPtbExy3FYUrsIsbeU9bKKTKXi9aTPrfFENLDnkFhD6eUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+w/Tiqs70ngPj4Hm5zOUzmKXeqJbGzzDDwQnbw9sGc=;
 b=xi0G2eLTMjsRKDE895+vc+KQ0QQu0J8xQW2TPwF+NpIZ1ZtY7GMVHb3TGAVDA0OLSSL5L/Lr4Q1kcU3Mk9eSxMNhvPuRJ+klB8kEvtsPyzW6Jk8ZkRl/kbEfvlTuBuRsHFMAbs8c5CjG4hWDXYroFDYi/5KqrSHoUL3cuPmagXAXUcYNbdt+wIwccAptZHgLxlGdUgcAvrLYBElHjKVec9KbxVBpChiiC2RcjomrDxbUR2fDw+oDvXMG7eIteTcS78hWS826PJViVLMHwLAfv7cENB6Wbm8orQVsOB/yZG3HHdTKnNz/2bS2MIGePnkebrq42gV8kjvLphIwozxVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+w/Tiqs70ngPj4Hm5zOUzmKXeqJbGzzDDwQnbw9sGc=;
 b=BlLGzu7BkVm28vtTZU83KdFLteTtojGA+IMBn0ds5oAtZte6tP/LSu9qEb/in1G23xOAPVjSHHvIm5Is9IZtp/Ha0+M/dCm0SKilUxZIVj/uykHjWZ9HoKOTqIvM+sifqJ/IRQK/uVKqcYjINF29hKkIJ+rOKeu6IdlYqoCF93g=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:17:58 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 09:17:58 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, "michael@walle.cc"
	<michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>, "cornor+dt@kernel.org" <cornor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
	<conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: Add stacked and parallel memories support in spi-nor
Thread-Topic: Add stacked and parallel memories support in spi-nor
Thread-Index: Adry+FCFJ+jxyMZCQv67eHESQhM+FQgH2SAAAfC4OWA=
Date: Thu, 10 Oct 2024 09:17:58 +0000
Message-ID:
 <IA0PR12MB769930E81D3D66B51CDC8213DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
References:
 <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240930110408.6ec43e97@xps-13>
In-Reply-To: <20240930110408.6ec43e97@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|CY5PR12MB6250:EE_
x-ms-office365-filtering-correlation-id: d6e62bab-6f66-44fa-455a-08dce90c6e8e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTVtVTRpRFZTS2FhNlRsR0sza3ZLWlJ3bU1hcktWVERPcjhNdEZMRXlITElk?=
 =?utf-8?B?TW5lOHN5ZVNYWkJrdVpjRGNEemY4TVhNUk5mZ1A1K2MwTzJad1N6UEUyRmlX?=
 =?utf-8?B?Ty9VYWNBTXo4bHNPeklhekFHK0ZCZTJoQ3N0SDNERkEvb0tIQzhsaXNLbGZ4?=
 =?utf-8?B?d2RLWWpTa1R0T1pzTzQvWVU2cWphYzFYcjZ5aVEwVU1HZzF6Y0x2VkNKL0hI?=
 =?utf-8?B?eW41bTVRQThEOWRQemdyVDhoZHMrak9SZ0psc1Q4VVBUM01wVWpmSzhwdkVC?=
 =?utf-8?B?aWc5SDNJM3dqWEcyb0xLM0M2L3hHUi93cm5tYTVtL3JYMzRPNmRNUWY5ck9i?=
 =?utf-8?B?SXdhYlFvMWVYK2lHR0RoYzlYcVNoOEdUQndNVWE5dVVtbnRDMjkyY0JmUC9r?=
 =?utf-8?B?RWcvWFpyckNNY29NamNBSlg5M1NoRy9hNUU2dm1Ha2ovYTQ3Q1FZRkpIQXd3?=
 =?utf-8?B?ZStNSTJxOXVPUlJTMVkrLzVXcTBSU0tndXYzZ1I2bkJ3OWJxeW1udzBSSitV?=
 =?utf-8?B?UE9Vem50UHp1akEzam1ZL3lZVHJrZE8xR0d3d084eUlXUmVJVUtDWGdXMXRm?=
 =?utf-8?B?N0N0RGszNzgwb3BJRmRoSVFMVDlFTmtScVpXKzduZWlyWnA1emNWNlYwaHhx?=
 =?utf-8?B?bTdJUU9tQ2UvQjRMMnh0QVVNUXp0TUY1QmRHa0FxOUpSV29ZbzZWQkxOeC9a?=
 =?utf-8?B?Ukw0YVBvNjNsSFhOM1cxZWc0dUN2OC94NGxYWDZ3bHNBL3NQeVNHaEpmYnBF?=
 =?utf-8?B?dmJDejltY0EwU2hhQmZxQ3NKdlNLYkxMcWhueERXVFE2SHJ5U1hCU1NGOExC?=
 =?utf-8?B?OHdLaEFVNmFJcHFoYllhRFNBMldyOVgySDgrcTBMaDBjamtUeC90bEF1OXk2?=
 =?utf-8?B?SUVaejZGQTJ1MTZXK3FCNis1UzU0eFNpd1RPZUMwaXhsOWhZcUZ6eTBxYm1n?=
 =?utf-8?B?STZTZWpseExmTkI3UG9Delc4V3NRMzk2cXBQUzdzS1pPZ0Fqamo1bldEaEdQ?=
 =?utf-8?B?K25CaFVmcFJyTGE4T29MUGlBVmZxTmR1NFlIVWR3NmRLWlFoaHhONUxuU2th?=
 =?utf-8?B?dnFFMlo2TmdsSkVrK1QzMHhvY2JsbkRJNlFJNEhncDEvdHFlVnA2Y0lxMmlu?=
 =?utf-8?B?UWk4MTAwQjdvMjBSakFWVlI3UDlDWVk4U1l4bCtwM1NzVkhNSExteWl2R1hZ?=
 =?utf-8?B?OEtpQ1ptRGFpQjh5WGlFRHhPK2FFQjRqT2h3NEZtdFIzdHlkb29KMExHZllY?=
 =?utf-8?B?Q0JTMUN6L0FMZTdGeXMyZ0taT3NPb29pL3RFT3kwWExkYVhndTEzS1VSYnU1?=
 =?utf-8?B?clAwYjBZbDd1ZEwxTGh6QkpGU0xtR1VUUExwY0QzSFEzN2ljVktIQWV2QWth?=
 =?utf-8?B?ek1xTmowQU9VZHh1Tm5mam1KSnFmQ2t6VCtCdnB0TEJpcWxIMUVHZmlSUkRv?=
 =?utf-8?B?K1Q5ZGZRZGsrWVg5WDZvNHlHbm4rSTBJYUFyL1J2Z0ZEaWx1aFdWYkQrM0o5?=
 =?utf-8?B?OFM5NmdUYzFvVkFqdUdZeE14SU1WUStJLzFLczJoaE1WMGdoQjVJZ1lYNWNR?=
 =?utf-8?B?bTYvMzdxeXB6Z2tMVmZYVVJEdE43NmNlQjR6NjNSNmZoOUo2THMwK2hDNHho?=
 =?utf-8?B?Z05IbUhBTUZxb1k1UTZHWEJYYU9OZDE2OS9Hbys3SllvbDR4SExvd3hSU1lS?=
 =?utf-8?B?anpjbTdIU1E1czBJSVoxZktpaFRNb1VBemxZZWRIdTI3dUxlTEdtOEdqVVdH?=
 =?utf-8?B?MkFHMTdqOTBET2daYUtpV1FrQmVOVUJ6RFo5MFF5eURCQjRRaXU1bWxwWFI0?=
 =?utf-8?B?bFRyOE5Zc3FoYnNtZGdZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGVNa1NMbFZxYjhwLzZUTW9JUXZNVkE1YytWVFd6a2VvaUo4WHlsTGZ0aEts?=
 =?utf-8?B?cUJiWHBoSW1YaGRaVXpEYjBnNVh0M3ZFWUgyVFZxTGtDeTJxWFA4cWl2T010?=
 =?utf-8?B?WDlpYitDaFZNTmFmdTRuVzIxdFZ6bHcxRG9xcXd3SmRoVVJMVXZjVHY4NzRr?=
 =?utf-8?B?MGt6RGhIRnBGdThucUFIOGo0VjBzRnMzV2FKZlFydFM3My9hdjlHWDB1eGM0?=
 =?utf-8?B?blo2UmZyM1ZiR1E4ZkNBNlByOHJWVms5SGlGb1ArNHlKY280ZVlMY2l0ZHNs?=
 =?utf-8?B?WXgwNFE4YmwxQm1XWEVGNmdNRkVUWUFQbHFmMjFKZU9kSlJFMWNRakxyRVZ3?=
 =?utf-8?B?czg1ZDdKWm9SZis4KzQxZ0JWNWdRQWlpWGFYRHQzV28wTTVQL1RWRHczUUdW?=
 =?utf-8?B?cDhTY3g2Q2x4UjZyb21UMDdjQ21PMkN3bnF4dGhkMXhCTkxwZWxXZVlxMTJ5?=
 =?utf-8?B?MmYySlpHRXozNmREeTY4VkM2eDE4emN1OG15NWtHSjdHNUx4aDFuZlVmQ1NE?=
 =?utf-8?B?T3ZvZ0ZHRi84WUM1QVhuTW5pdUt2aEVhQ05odkthakw1djZnTzVQMGVNWUF3?=
 =?utf-8?B?M1RWZEV0SHYvdlduNXFWOVM0NktCaUo2bmtUVFJPb3NFT29CRXdvUCtaSkFZ?=
 =?utf-8?B?TnJsRGZ0aWJwcVoveitJaktEV1FSdFYyQ3luRmNoWWdqeU0zZ0V3U3lFQU5m?=
 =?utf-8?B?R3gzRndLVVhnQTFlS0RNa1ZRV3M5OFo1bUZtdWhaU3FsUHB5akZyWXYwOWVF?=
 =?utf-8?B?c3QrR2pCZWUwbEFvWTZLZ0FNUmtTQURXLzhjSHlZZm9aVllmSW9Lczh6MWU4?=
 =?utf-8?B?ZkdaL2FSL3dSOTZqZWFRU0EwZU1NVWRXUVo1aU92RjlJRFJzOE42MVJiWng4?=
 =?utf-8?B?Vkl2ODdEQmlMQ0hpa3R5SGhJd05YMEVINWVjTmszQnJEYnFseldDS1J3aTRU?=
 =?utf-8?B?dm9zem93bzBKYmpjQlh5azBsSGloQ2ZiSnhHWng1NzlGSG9Bdk1LYkJ1bzE4?=
 =?utf-8?B?TFB1REFoSzZQNWNKcHdwa1ZHNzN4TVpIQ0dCSjVYcmFzL0hYVmRtSmw2d0VS?=
 =?utf-8?B?YmpsbFpqbkl6SjJvNXhPWDhkQ0ZUS2liMmpnSWl1YTJCNGhwemF2RWhJZDlG?=
 =?utf-8?B?RURldGdndG14YU8xYTd4WHBpT0RWUVpYZlpCV0Zlb0c2NVR2Y3A2MEJhRTRu?=
 =?utf-8?B?anMxeHlGMkNvclYxVVhXeHV3Q0gyNFpaTGZ6S3R3dGVmMDJoZGNNZ3o3M3A0?=
 =?utf-8?B?V0w2QloxZWRsenU4YlhyMEpDQnRSMGY1SHF1RlEyZFJhZ2l1OVNDbW9MZTht?=
 =?utf-8?B?QzBUakZEMVQzRzUyc2t6VHVVV09sV29lNlhhcXBqK25HL3FlKy8xSlliZDhC?=
 =?utf-8?B?V2VRMlZLMEYzQXFVYjUzNCtiUloyaWxkODBSSUlIQUZKSkFkRGhUU1lLTTlQ?=
 =?utf-8?B?MjNDV0lwRituNlVGYzZ2eStrUFFOaC9BS3ZjM2xUQk55NFJRMFpFV0VFU0ZZ?=
 =?utf-8?B?eU1kRGhENDdBYXc5bW55VFlkNGpTdEtsb050ZHlpbU1HV2NwLzN4YVErRmNw?=
 =?utf-8?B?ZTBwbDIzSFVBUElDaUJtbGlMTjNkc1NYN0ZGZkxRcm9uNWZnZVZ1TW9vQVJq?=
 =?utf-8?B?TGlUSGJ0cVpKeXlseDkvam5XWFdoMWhQeU5kSVppcEY3Zm92ZFFkNGVjSGdF?=
 =?utf-8?B?dmM3MnI4aTd3ODh3QlhMajFmdWlxTFNSSkphQUVZeStseWxrc1ZiQmVXditC?=
 =?utf-8?B?R0thV1Vqc1hmVXJKQVRxQWJ4bTdjcTBJUk9zSGc3a3NFTVhWUXJaNEgrU3U3?=
 =?utf-8?B?a1NWMTBySHBqY1FrcStrbXQ2aHZOUGVOaVNOenBPSnAvdy9hL3FVQVc5WjlZ?=
 =?utf-8?B?QS9leTQ1bUxReHkwMXlXV25xQ1p0NWdhVFc5MmlVaGJtYjVKM0p2Qm9ydnln?=
 =?utf-8?B?Nk52WkhYdGtlWkdFSGx1YVd2Tyt0UjNIaFVMeDZiRzRKN09mcitTL0VwZ3BK?=
 =?utf-8?B?WjVrRnl0RnlrakU3bTdreE8zalU3ZU5LUy9XWU5mQUNFOFZ4cW1HNnlCL2pT?=
 =?utf-8?B?cGljclFEOHJ5VkRxWHVDc2FyaE1jcitpOThJWlRyUC8weGppV3kyenlWcUFt?=
 =?utf-8?Q?SiGY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e62bab-6f66-44fa-455a-08dce90c6e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 09:17:58.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHL7jaegJMcs3Hau8NjltXHIi60n51VCsQCsZ+qJ9BPw+jvFeEjGBm/Tp8EsUHe4feDZdXDemxpD0OHGKbmdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

SGVsbG8gTWlxdWVsLA0KDQo+ID4gLSBUaGUgc3RhY2tlZC1tZW1vcmllcyBEVCBiaW5kaW5ncyB3
aWxsIGNvbnRhaW4gdGhlIHBoYW5kbGVzIG9mIHRoZSBmbGFzaCBub2Rlcw0KPiBjb25uZWN0ZWQg
aW4gc3RhY2tlZCBtb2RlLg0KPiA+DQo+ID4gLSBUaGUgZmlyc3QgZmxhc2ggbm9kZSB3aWxsIGNv
bnRhaW4gdGhlIG10ZCBwYXJ0aXRpb24gdGhhdCB3b3VsZCBoYXZlDQo+ID4gdGhlIGNyb3NzIG92
ZXIgbWVtb3J5IHN0YXJpbmcgYXQgYSBtZW1vcnkgbG9jYXRpb24gaW4gdGhlIGZpcnN0IGZsYXNo
DQo+ID4gYW5kIGVuZGluZyBhdCBzb21lIG1lbW9yeSBsb2NhdGlvbiBvZiB0aGUgMm5kIGZsYXNo
DQo+IA0KPiBJIGRvbid0IGxpa2UgdGhhdCBtdWNoLiBEZXNjcmliaW5nIHBhcnRpdGlvbnMgcGFz
dCB0aGUgYWN0dWFsIGRldmljZSBzb3VuZHMgd3JvbmcuIElmDQo+IHlvdSBsb29rIGludG8gWzFd
IHRoZXJlIGlzIGEgc3VnZ2VzdGlvbiBmcm9tIFJvYiB0byBoYW5kbGUgdGhpcyBjYXNlIHVzaW5n
IGEgcHJvcGVydHkNCj4gdGhhdCB0ZWxscyB1cyB0aGVyZSBpcyBhIGNvbnRpbnVhdGlvbiwgc28g
ZnJvbSBhIHNvZnR3YXJlIHBlcnNwZWN0aXZlIHdlIGNhbiBlYXNpbHkNCj4gbWFrZSB0aGUgbGlu
aywgYnV0IG9uIHRoZSBoYXJkd2FyZSBkZXNjcmlwdGlvbiBzaWRlIHRoZSBpbmZvcm1hdGlvbiBh
cmUgY29ycmVjdC4NCg0KSSByZXZpZXdlZCBSb2IncyBzdWdnZXN0aW9ucyBpbiBbMV0sIGFuZCBJ
IG5lZWQgdG8gZXhhbWluZSB0aGUgTVREIGxheWVyIA0KdG8gZGV0ZXJtaW5lIGhvdyB0aGlzIGNh
biBiZSBpbXBsZW1lbnRlZCBmcm9tIGEgc29mdHdhcmUgcGVyc3BlY3RpdmUuIA0KRm9yIHJlZmVy
ZW5jZSwgaGVyZSBpcyBSb2IncyBzdWdnZXN0aW9uOg0KDQpEZXNjcmliZSBlYWNoIGRldmljZSBh
bmQgcGFydGl0aW9uIHNlcGFyYXRlbHkgYW5kIGFkZCBsaW5rKHMpIGZyb20gb25lIA0KcGFydGl0
aW9uIHRvIHRoZSBuZXh0IA0KDQpmbGFzaDAgew0KICBwYXJ0aXRpb25zIHsNCiAgICBjb21wYXRp
YmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KICAgIGNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNo
MV9wYXJ0aXRpb25zPjsNCiAgICAuLi4NCiAgfTsNCn07DQoNCmZsYXNoMSB7DQogIGZsYXNoMV9w
YXJ0aXRpb246IHBhcnRpdGlvbnMgew0KICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9u
cyI7DQogICAgLi4uDQogIH07DQp9Ow0KDQo+IA0KPiBJZiB0aGlzIGRlc2NyaXB0aW9uIGlzIGFj
Y2VwdGVkLCB0aGVuIGZpbmUsIHlvdSBjYW4gZGVwcmVjYXRlIHRoZSAic3RhY2tlZC1tZW1vcmll
cyINCj4gcHJvcGVydHkuDQoNCkkgYmVsaWV2ZSB0aGF0IGluIGFkZGl0aW9uIHRvIFJvYidzIGRl
c2NyaXB0aW9uLCB3ZSBzaG91bGQgYWxzbyBpbmNsdWRlIA0KdGhlICdzdGFja2VkLW1lbW9yaWVz
JyBwcm9wZXJ0eS4gVGhpcyBwcm9wZXJ0eSBoZWxwcyB1cyBpZGVudGlmeSB3aGljaCANCmZsYXNo
ZXMgYXJlIHN0YWNrZWQsIHdoaWxlIFJvYidzIHN1Z2dlc3Rpb24gZXhwbGFpbnMgaG93IHRoZSBw
YXJ0aXRpb25zIA0Kd2l0aGluIHRoZSBzdGFja2VkIGZsYXNoZXMgYXJlIGNvbm5lY3RlZC4NCg0K
Rm9yIGV4YW1wbGUsIGlmIHdlIGhhdmUgdGhyZWUgZmxhc2hlcyBjb25uZWN0ZWQgdG8gYW4gU1BJ
IGhvc3QsIHdpdGggDQpmbGFzaEAwIGFuZCBmbGFzaEAxIG9wZXJhdGluZyBpbiBzdGFja2VkIG1v
ZGUgYW5kIGZsYXNoQDIgZnVuY3Rpb25pbmcgYXMgYSANCnN0YW5kYWxvbmUgZmxhc2gsIHRoZSBE
ZXZpY2UgVHJlZSBiaW5kaW5nIG1pZ2h0IGxvb2sgc29tZXRoaW5nIGxpa2UgdGhpczogDQpQbGVh
c2Ugc2hhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KDQpzcGlAMCB7DQogIC4uLg0KICBmbGFz
aEAwIHsNCiAgICBjb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3IiDQogICAgcmVnID0gPDB4MDA+
Ow0KICAgIHN0YWNrZWQtbWVtb3JpZXMgPSA8JmZsYXNoQDAgJmZsYXNoQDE+Ow0KICAgIHNwaS1t
YXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCiAgICAuLi4NCiAgICAgICAgZmxhc2gwX3BhcnRp
dGlvbjogcGFydGl0aW9ucyB7DQogICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLXBhcnRp
dGlvbnMiOw0KCWNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMV9wYXJ0aXRpb25zPjsJDQogICAg
ICAgIAlwYXJ0aXRpb25AMCB7DQogICAgICAgICAgCSAgICBsYWJlbCA9ICJTdGFja2VkLUZsYXNo
LTEiOw0KICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg4MDAwMDA+Ow0KCX0NCiAgICAgICAg
fQ0KICAgIH0NCiAgZmxhc2hAMSB7DQogICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0K
ICAgICByZWcgPSA8MHgwMT47DQogICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0K
ICAgIC4uLg0KICAgICAgICBmbGFzaDFfcGFydGl0aW9uOiBwYXJ0aXRpb25zIHsNCiAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQoJY29uY2F0LXBhcnRpdGlvbiA9
IDwmZmxhc2gwX3BhcnRpdGlvbnM+OwkNCiAgICAgICAgCXBhcnRpdGlvbkAwIHsNCiAgICAgICAg
ICAJICAgIGxhYmVsID0gIiBTdGFja2VkLUZsYXNoLTIiOw0KICAgICAgICAgICAgICAgIHJlZyA9
IDwweDAgMHg4MDAwMDA+Ow0KCX0NCiAgICAgICAgfQ0KICB9DQoNCiAgZmxhc2hAMiB7DQogICAg
Y29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KICAgICByZWcgPSA8MHgwMT47DQogICAgc3Bp
LW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KICAgIC4uLg0KICAgICAgICBwYXJ0aXRpb25z
IHsNCiAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQoJY29uY2F0
LXBhcnRpdGlvbiA9IDwmZmxhc2gwX3BhcnRpdGlvbnM+OwkNCiAgICAgICAgCXBhcnRpdGlvbkAw
IHsNCiAgICAgICAgICAJICAgIGxhYmVsID0gIlNpbmdsZS1GbGFzaCI7DQogICAgICAgICAgICAg
ICAgcmVnID0gPDB4MCAweDgwMDAwMD47DQoJfQ0KICAgICAgICB9DQogIH0NCg0KPiANCj4gPiAg
LSBUaGUgbmV3IGxheWVyIHdpbGwgdXBkYXRlIHRoZSBtdGQtPnNpemUgYW5kIG90aGVyIG10ZF9p
bmZvIHBhcmFtZXRlcnMgYWZ0ZXINCj4gYm90aCB0aGUgZmxhc2hlcyBhcmUgcHJvYmVkIGFuZCB3
aWxsIGNhbGwgbXRkX2RldmljZV9yZWdpc3RlciB3aXRoIHRoZSBjb21iaW5lZA0KPiBpbmZvcm1h
dGlvbi4NCj4gDQo+IE9rYXksIHRoaXMgaXMgYmFjayB0byB0aGUgbXRkLWNvbmNhdCB0aGluZyBJ
IGluaXRpYWxseSBwcm9wb3NlZCwgYnV0IEkgYmVsaWV2ZSBpdCBjYW4NCj4gd29yay4NCg0KSSB3
YXMgY29uc2lkZXJpbmcgaGFuZGxpbmcgdGhpcyBieSBvbmx5IGFkZGluZyBhIG5ldyBsYXllciBi
ZXR3ZWVuIHRoZSBNVEQgDQpsYXllciBhbmQgU1BJIE5PUiB3aXRob3V0IG1vZGlmeWluZyB0aGUg
TVREIGxheWVyLiBIb3dldmVyLCB3aXRoIFJvYidzIA0Kc3VnZ2VzdGlvbiwgd2Ugd291bGQgYWxz
byBuZWVkIHRvIHVwZGF0ZSB0aGUgbXRkLWNvbmNhdCBpbiBhZGRpdGlvbiB0byANCmFkZGluZyB0
aGUgbmV3IGxheWVyLg0KDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBwYXJhbGxlbC1tZW1vcmllcyBE
VCBjaGFuZ2VzOg0KPiA+DQo+ID4gLSBGbGFzaCBzaXplIGluZm9ybWF0aW9uIGNhbiBiZSByZXRy
aWV2ZWQgZGlyZWN0bHkgZnJvbSB0aGUgZmxhc2gsIHNvIGl0IGhhcyBiZWVuDQo+IHJlbW92ZWQg
ZnJvbSB0aGUgRFQgYmluZGluZy4NCj4gDQo+IEl0J3Mgbm90IHJlYWxseSBhYm91dCB0aGUgc2l6
ZSBidXQgbW9yZSBhYm91dCB0aGUgZmFjdCB0aGF0IHR3byBtZW1vcmllcyBhcmUgaW4gdXNlLiBJ
Zg0KPiB0aGUgc3RhY2tlZCBzaXR1YXRpb24gZG9lcyBub3QgcmVxdWlyZSBhbnl0aGluZyBzcGVj
aWZpYyBiZXNpZGVzIHRoZSBwYXJ0aXRpb25zIHRyaWNrLA0KPiB0aGVuIHlvdSBjYW4gYXNzdW1l
IHRoYXQgZG91YmxlIHJlZyBmbGFzaGVzIGFyZSBqdXN0IHR3byBmbGFzaGVzIGFuZCB0aGlzIGNh
biBiZQ0KPiB5b3VyIHdheSB0byBkaXNjcmltaW5hdGUgdGhlIGRhdGEgb3JnYW5pemF0aW9uLiBC
dXQgSSBkb24ndCBsaWtlIG11Y2ggdGhpcyBzaG9ydGN1dA0KPiBiZWNhdXNlIGl0IGlzIG5vdCBm
dXR1cmUgcHJvb2YsIGFuZCBpbnN0ZWFkIEknZCBrZWVwIHRoZSBzdGFja2VkLW1lbW9yeSBwcm9w
ZXJ0eS4gSWYNCg0KSSBhZ3JlZSwgYXMgZXhwbGFpbmVkIGFib3ZlLCBJIGJlbGlldmUgd2Ugd2ls
bCBuZWVkIHRoZSAnc3RhY2tlZC1tZW1vcmllcycgDQpwcm9wZXJ0eS4NCg0KPiB5b3UgZG9uJ3Qg
bGlrZSB0aGUgc2l6ZSwgSSBkb24ndCByZWFsbHkgY2FyZSwganVzdCB1c2UgaXQgYXMgYSBib29s
ZWFuLiBCdXQgSSBiZWxpZXZlIHdlDQo+IG5lZWQgc29tZSBuYW1pbmcgdG8gdGVsbCB0aGUgT1Mg
dGhhdCB0aGUgZGF0YSBpcyBzcHJlYWQgaW4gYSBzcGVjaWZpYyB3YXkgaW5zaWRlIHRoZQ0KDQpB
Z3JlZS4NCg0KDQpSZWdhcmRzLA0KQW1pdA0KDQo+IG1lbW9yeSBkZXZpY2VzLg0KPiANCj4gPiAt
IEVhY2ggZmxhc2ggY29ubmVjdGVkIGluIHBhcmFsbGVsIG1vZGUgc2hvdWxkIGJlIGlkZW50aWNh
bCBhbmQgd2lsbCBoYXZlIG9uZSBmbGFzaA0KPiBub2RlIGZvciBib3RoIHRoZSBmbGFzaCBkZXZp
Y2VzLg0KPiANCj4gVGhpcyBpcyBhbHJlYWR5IHRoZSBjYXNlLg0KPiANCj4gPiAtIFRoZSAicmVn
IiBwcm9wIHdpbGwgY29udGFpbiB0aGUgcGh5c2ljYWwgQ1MgbnVtYmVyIGZvciBib3RoIHRoZSBj
b25uZWN0ZWQNCj4gZmxhc2hlcy4NCj4gDQo+IFRoaXMgaXMgYWxyZWFkeSB0aGUgY2FzZS4NCj4g
DQo+ID4gLSBUaGUgbmV3IGxheWVyIHdpbGwgZG91YmxlIHRoZSBtdGQtPiBzaXplIGFuZCByZWdp
c3RlciBpdCB3aXRoIHRoZSBtdGQgbGF5ZXIuDQo+IA0KPiBUaGlzIGlzIG5vdCBhIERUIGNoYW5n
ZS4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg==

