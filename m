Return-Path: <linux-spi+bounces-5751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98A9D2CD5
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 18:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C236EB25E31
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CE1CCB4E;
	Tue, 19 Nov 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GNDqVLgF"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AEC1CCB35;
	Tue, 19 Nov 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035767; cv=fail; b=KrTlk4Jy245slD7ba7kLxPsvE32Zq3n1+x59C/wNQbJYZISteHUlLCaoigN+bmO+kHdVsWABP9k4rAmxcoDcjEoLRlfFsle59e7kGM1MCX1+akV7bncdZ1mJN2Rfye6mrCTCY3iKembwqIONlChSP06m8z0Cio6WAuLtL0LM2JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035767; c=relaxed/simple;
	bh=iDpqEjn2xsmsYdOi+tbJBgf0T+aJ9YgZIzbxrGDkiQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LP+mtRF9vjvmi9hFOVPPT79Jwt08utgOJhCfpRNzfILJAzhEqUSZWeo8ozlgNytLwstYF+uSYRJRFtveLHeRFpQE6Pl7waob74ISgH7E1NyaSmo4+E2//pfOujome1cc8OxlBp4ebNfnK3adEgEOoVVQOx7I24u0h8jpQilD9RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GNDqVLgF; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkfHtykhBdMrRqcpMu6SaJO1945j3O0VaqWAVCTL16Y85Aw2MNqovgH1FczSjKnp0Q/JJ1AizpYO5qlFJqR8KqVnjyk8QaxsyvA4ZV2HgWwr+p52r+7ao5mrYOzYPvPCpDp6U6qUYwf4E+bG40GvEss4+xusRKex4NbJtEPOC90JWxjtXJzqw7B1QNPXhfreg606D8EhSszsmyV/Hx7FKXkUkTGsBqNE75tE4hE+/nsZ0OUju4AFyi47tOEcTVakz+HLgwFjzW01aMTRZPHIkMnYR1yY1fmM+yGjMrmVpjN3mntaalAw0YGj7ngKDQcHglYbRSGdTEtDkwd16+8+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDpqEjn2xsmsYdOi+tbJBgf0T+aJ9YgZIzbxrGDkiQk=;
 b=DsQy6L/JLRAXcbDIm5NCmh6LJ4vSqMVNjQMcsT7ZftS1QXUvQ2nx9+qoYiPzXCs7WcdAGJu2S2U9CAgmBEFjjEONGJed96HCOHSftA4Ua88lu8E7D7azTj7bwCpH0a78dUN6OwaQORW9UN9kKyJajR/nS8FQziqv8IFUZX4Ow/wUEf3NksBzeXIzxU9pqpzG8AbsEctRFAIQmTConaiDm9ONu6egq1cdUJt5mp2NM4MHgFg4k0/vcthivJ1OfcCPc6E+YVrBAhB1ppaKaOxf3GX5HJV0s86bGE+UbSr04b8vbzph7dal5FuMrnk9U00/YneRYCDi6TlI6xbL8J8oVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDpqEjn2xsmsYdOi+tbJBgf0T+aJ9YgZIzbxrGDkiQk=;
 b=GNDqVLgFdROLPu3cnIb8rtRq/QIdrEJ8DDPmUaJo2QAnABdoHCop1456LOzMemRJwe30dhmBZcNrtZrHX8ZNpO0xfHVAMWJmBPRKVFTU+t1RzysC+djroWOrw9OMembMMIJbnvL9FuxM6srhFViwvNIOuYzoxluKc5IANs88E7s=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:02:33 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 17:02:33 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "michael@walle.cc"
	<michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "Abbarapu, Venkatesh"
	<venkatesh.abbarapu@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "beanhuo@micron.com"
	<beanhuo@micron.com>
Subject: RE: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Topic: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Index: AQHbJ3xBTx+wL/tjcU+OTs1kcRvpc7K9LE/QgAFrroA=
Date: Tue, 19 Nov 2024 17:02:33 +0000
Message-ID:
 <IA0PR12MB76994483BBB757BD9F691513DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-2-amit.kumar-mahapatra@amd.com>
 <87frnoy8na.fsf@bootlin.com>
In-Reply-To: <87frnoy8na.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|CH3PR12MB9172:EE_
x-ms-office365-filtering-correlation-id: 1a0a1741-0d2b-4031-4b54-08dd08bbf5ce
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzB3TVRMR0lLR2JQV1hNMW8zK0x2QUZrK25uTU5VTjhCNUxHbzVTTFArR28z?=
 =?utf-8?B?U2EzSk9GbmppalJwS3VQVDFaYmZ2WXRHSStXRnZIQWtxTC9JVDdIcU50L2Ez?=
 =?utf-8?B?ZDJKcE5hMXFZbitudEo4U3M4YkVsY2F3ckdiQlFITzdHTFhTTzVMZFJEN2R4?=
 =?utf-8?B?Vmg0SjNFZTM3b2Y2ZXdBTS83V09NcUVQMmtFZHBNa0tUZTJxdWtlU0FaelRa?=
 =?utf-8?B?TWh4YW5ERWErSGJkc3NqWTY0R2ZpRVdUU3RDMEVJV05GOVJnRWtiY2hmYVVm?=
 =?utf-8?B?RDZQaGVOSWY4YWRhWEY4c21WSTVYVmVMVW5SUktJTnhkSnhZVmVTbm9GYkkr?=
 =?utf-8?B?QjRxZTBnTzFqOFptbldqWVphanZCSldXc2tNYTU0ZVpiWTdNZm9NNUxKZE5h?=
 =?utf-8?B?YldkZjdudHlhNjFza0RJMkNQTHlsV1VRWTB5NVpPdXVwekh1WnNtY2c5cXlQ?=
 =?utf-8?B?WVM0TCtsNDNGdEUrSjVWQWNzRXk3STJtdmlBYXgyWVl1RzEwdmNzUTU3cDJo?=
 =?utf-8?B?NkhGUFFPclNsdjlrelNVZlp1NnZVVGI4RXBESTMrWFdrdjFFZVJuckJuR2Jt?=
 =?utf-8?B?MFFZb3JISGZyeEZNVDZremJwRi9ZWkdsS3JPUmE2cFBPdk5nWFJhdVN0WnZq?=
 =?utf-8?B?OUVzcDNPODg0QjBRbkxuR3M3b1NTZGxGVFN6OC9hZlVjUUw5KzA5dHZFMTdT?=
 =?utf-8?B?aml2S1h5Ukh0NmRNU2NnQkFJZ3VrZnI0NTRYNUxqNW5GOFVCNXFZOTJvOTZZ?=
 =?utf-8?B?c1pmRGsyV1hCMDJIZktKbkpBUTBIMWUycStRNVBJTXJTRTgyelB4bGNnaTJo?=
 =?utf-8?B?VU1YUDhLckxBTkxMR3JlTEtvT0U3MllONHZNSEc5QlBkOWVaTlFLUkVqSWdx?=
 =?utf-8?B?VkZlTlUrWml5amVCKzY5Yy8rTWFtZVBuS1hMM3JFaGw3MUorZUhhcHJWdUc1?=
 =?utf-8?B?cnBJRytKTGo1VlpDWVV6OUY3emhSMVV3Mmd5b3grc1M4MkNoQ3cwTVV1c2tY?=
 =?utf-8?B?dGtTV1E3NHA3S25KYzhONHZUOWZXYkJ1VFRKVzFVNFVobDgxaXRCUk9pQmtN?=
 =?utf-8?B?M0pJMjZTVTVWVmVidDhLUloxVW5oTnRoYXViaytNemVaUHBmWTBHeHVzMTBL?=
 =?utf-8?B?bVZObmFmM3hOY1o2a3JBaGxMdU9VakR0T2RjamxOY1gyd0NMcGdieWhzREwz?=
 =?utf-8?B?UWFORmhLd0NiTWJIeUJjbURIYnV6Zkx3WTBYQWk1dHNiUWdWVlRsZHZhOFZZ?=
 =?utf-8?B?WCtCVW81OHo3VldjdGhrQUZKMGplRmdBVmlhOFJ3TnZVelpyT0c1ejJvV0Z1?=
 =?utf-8?B?SXk1ZGNHNW1XVG8ydHNFTHdFNmxRZDlIYWo0VUM2N214cHA1dnYvZUJsMzlk?=
 =?utf-8?B?MTBWMVJDQ2JUdEdYN2xxMFpCRFlLT0Q2TVB5eHF6QnRmVXFoc1hydXFUSWlE?=
 =?utf-8?B?NWpXMjV3MjRBUExXbDJRSnlIRFVaVXQ0ZkVRV01MdUlHNEU4S2k4NDZEUzdR?=
 =?utf-8?B?bEw0UmNnSTAzNDRkdURqNTBxNExML3ZaTW1wV1ZkNWJpTDYvdjZENTQvMkRQ?=
 =?utf-8?B?K2FPS2dqZmY4dkxZa3ZoeUlBT01mS3ZhQ0N0d0xSZTRKMEh0UmxjVStDa2RU?=
 =?utf-8?B?UWdhMGRwMmVBZWRrVXNFOW9YRmdEMGNuTFdoSGtqOFVQR0hvQnhNQ2Y1Z3l6?=
 =?utf-8?B?akdabjNhVllvNnZNTXZTWHlkQ0doVG5qeHBCSXdrUHdlcHpuWGRHeFBxSkZ1?=
 =?utf-8?B?NWZ6UEhKZXpXNG1SL1gybjRpVlhNSGVMTVlvK3lSZS9laDlKUGU1WEZTVmY0?=
 =?utf-8?B?U3BnQ3NMTEYwaGF3QVJ1ZkdOaW5RQ0FtWlQvcUluNjNySVZSc1QvWHZLOXM4?=
 =?utf-8?Q?LYJyUeAOZ+qKM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzAvOGtJOFgrQ2NGOElkMk1ab0pHWjg1NDJ3N2JtRU56Qjlsdis1YWJNcHhr?=
 =?utf-8?B?aitVTGYwc1llWHV0Q3RTQTdRWmJ1Q2VZN2ExZEIxOWVvQXF4VjJPaWRWbTZZ?=
 =?utf-8?B?cXZ2b3NKY3VXSmxkR1BVT2tQTjJZRkV5TnRPMytUV1IrWk1nakJhMU9BQ1l5?=
 =?utf-8?B?bnNKM1JyalNPb3hya0hOSXVleGNpZlRnTkFkTk40THJnQzBHTkFHRm5TcHk3?=
 =?utf-8?B?SUJNRFJjbTFZaUpvTWtIRG1OcnJya2U0bEN4UXZCa052RFMrSWdHOGlNVHQr?=
 =?utf-8?B?ZVFkNlpibExER1cyLytITWZ4RitONUtodTBwZC85QjA2WU9vRzV2YUtWZmE0?=
 =?utf-8?B?YXJ6WkdwT0F4aTJydUhzOUpyRVpFL0pIWHlLdDhWcnNOeExvN2pWVEFpNmdh?=
 =?utf-8?B?YldlbkVFUmExa3VPcGpEK0ZBb01HelhvVkhLRit0T0gvVWt3ODV6Mk1MYkdP?=
 =?utf-8?B?VFlqa252NnIzSHdTVjduZWI2ZGNmM09VeHo5RFN0V3E1VmJYejRuL2Myc1A0?=
 =?utf-8?B?MldzVXRnNkpwYjlkU29aWTBWSkFFMXJjK0wwcWlkTElYaW5vUDZtNjRTYXhj?=
 =?utf-8?B?aGpwREdhNlhhV2Q5ZG1QdnJaVlFxNW0xaUk1VVF6bFVqQ3lwazQzc2VYQ1pI?=
 =?utf-8?B?U0MzV3pWR1NGb3hqRFplSzhlbVRBUnlyNCtXNFozUWtFQ2l0S0VLSTR5am5P?=
 =?utf-8?B?VVl2R3dGb0lkQ3BQUys0RXZhZjcwU0dzQmNPRGMrL3RTUDkxRmwxQUdwZ0U1?=
 =?utf-8?B?bzFUdXNzSjF4N0hOWFlkSUZ2ZVpOUG9VYlNCaHBNTnFLVVZORnE2UVpGWGha?=
 =?utf-8?B?Ni9Lc3EzTXc0UklwTk8xbUtVSHRqSWRDbnBrMkgxVE5jN2c5N3JUWFNHWlox?=
 =?utf-8?B?TVdDWUNlSXVyYVNnWTlpMDJjVDNwWjlSV2FIby9CSDBNdzdPZGt1U1E3OGp0?=
 =?utf-8?B?dTBHQTJzNVpKQzhnQUpTS212YXQ3Sk5Gd3dFcSs4SkJOOHEvek1mOEwyQmhQ?=
 =?utf-8?B?MUFWbEgwc0JkOFFoTFVkbEx5YnFvUnNOTHNuS2ZOWmI0azNrZi9UenFnbzhP?=
 =?utf-8?B?WXFLdEZMaGVYaEYvcDAzd21JTHR6M0tmUjhSNlZ6Z1MzZ2x5Q1NyNkVORTZM?=
 =?utf-8?B?aVh0WUdNM0NXYmpnd2NNM0VVRjBpSGhrODFKdWY2Y0lsZit3TU5WMVFXNlJm?=
 =?utf-8?B?TS9mTmx0Vm02M0Ewc05KY0ozSVhzbVBtYnoyN0hvMkdBbmJpQm5mcHFXQ0dh?=
 =?utf-8?B?eHgyZVNXQS9OZ1NSWFZtTElidW14UlFBMVNiU0oyMWtDMEZXOTQybC9CNTZQ?=
 =?utf-8?B?ZHFJREJFN2hjc21UQnpmb0hIZDlYOUZld2k2cnNkU1lEOCtZUDRsdTdxdFVO?=
 =?utf-8?B?MmxhbHVpRzhORDNISW9xT05XaWsrVW5XRUxyL0l0cGJPZWt4eGNSM1hCUllR?=
 =?utf-8?B?Rm9TZHcybXpFNFZZL2xLZFdVZURCbWM3T25tZ1pBSWpFeDdOT3ZXR3d0dVcv?=
 =?utf-8?B?VkNDV011NXlOSnhjWFNWd3YwdCtXQ0FMeEREM3JqYlhjc2NJeHdONFdrSHVJ?=
 =?utf-8?B?elp1d1FxQlFkUE93a3IyTTFrK04rSzBIQ2ZwZVI2VG9sNmsxNjg2dlBHM3Jr?=
 =?utf-8?B?SExxZkxuVzJGS2swUE9HdkRjYS9KNEZ1d1RDSE1uYXVOQWpRS0VGWTg4aHlj?=
 =?utf-8?B?TU0zRXNUOGNjbnpmN2VtbXg1bUo5aHlhWmFUbngxWXpjOVVsNnhtS25ob2lH?=
 =?utf-8?B?aU9IVVQ5WmF1dGRWMEx5SzhFYlovU0FjSXc2cjBDTVR1S21Dc2hKaXhzY244?=
 =?utf-8?B?aHZmSkUvRm9rZ2E4dXlDTW5vOWJRN3dRK1BTYXk5NUpUWkRsZndWcFp6emFn?=
 =?utf-8?B?OXJWZmVnWTl0amRvN2pGd0hyZG00MGk4bksrOTdTSGVHMzFReXNFOW4yRlhB?=
 =?utf-8?B?eTFDTms2NWlHRVNvTnY0c3RyOUdmQWk0Z1JvZzNZSFV6eW12TWpzT0RFS1A3?=
 =?utf-8?B?LytIMWZwcXdLVVIwWkpKMGx0Y0YvVWpORFNsWDN5bUlhNmpTREowMjM2dUhi?=
 =?utf-8?B?ZlZrU3ExbWp0dlB5aHFjVFNNdUZpL0trZU9ybXVYcFZkR2s1bldaNFc2MHpT?=
 =?utf-8?Q?owSA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0a1741-0d2b-4031-4b54-08dd08bbf5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 17:02:33.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6t6sVWTf2CEF2Xq/Mrr4w53VvMxNWmZMUVneDnq/rDilKpC43P70YySzt8BQFjAAL8U/m49b+NFtGOhRVkrP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

SGVsbG8gTWlxdWVsLA0KIA0KPiA+IFRoaXMgYXBwcm9hY2ggd2FzIHN1Z2dlc3RlZCBieSBSb2Ig
WzFdIGR1cmluZyBhIGRpc2N1c3Npb24gb24gTWlxdWVsJ3MNCj4gPiBpbml0aWFsIGFwcHJvYWNo
IFsyXSB0byBleHRlbmQgdGhlIE1URC1DT05DQVQgZHJpdmVyIHRvIHN1cHBvcnQNCj4gPiBzdGFj
a2VkIG1lbW9yaWVzLg0KPiA+IERlZmluZSBlYWNoIGZsYXNoIG5vZGUgc2VwYXJhdGVseSB3aXRo
IGl0cyByZXNwZWN0aXZlIHBhcnRpdGlvbnMsIGFuZA0KPiA+IGFkZCBhICdjb25jYXQtcGFydHMn
IGJpbmRpbmcgdG8gbGluayB0aGUgcGFydGl0aW9ucyBvZiB0aGUgdHdvIGZsYXNoDQo+ID4gbm9k
ZXMgdGhhdCBuZWVkIHRvIGJlIGNvbmNhdGVuYXRlZC4NCj4gPg0KPiA+IGZsYXNoQDAgew0KPiA+
ICAgICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KPiA+ICAgICAgICAgLi4uDQo+
ID4gICAgICAgICAgICAgICAgIHBhcnRpdGlvbnMgew0KPiANCj4gV3JvbmcgaW5kZW50YXRpb24g
aGVyZSBhbmQgYmVsb3cgd2hpY2ggbWFrZXMgdGhlIGV4YW1wbGUgaGFyZCB0byByZWFkLg0KDQpT
b3JyeSBhYm91dCB0aGF0LiBJIGFtIHJlZGVmaW5pbmcgYm90aCB0aGUgZmxhc2ggbm9kZXMgaGVy
ZSB3aXRoIHByb3BlciANCmluZGVudGF0aW9uLg0KDQpmbGFzaEAwIHsNCgljb21wYXRpYmxlID0g
ImplZGVjLHNwaS1ub3IiDQoJLi4uDQoJcGFydGl0aW9ucyB7DQoJCWNvbXBhdGlibGUgPSAiZml4
ZWQtcGFydGl0aW9ucyI7DQoJCWNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMF9wYXJ0aXRpb24g
JmZsYXNoMV9wYXJ0aXRpb24+Ow0KCQkNCgkJZmxhc2gwX3BhcnRpdGlvbjogcGFydGl0aW9uQDAg
ew0KCQkJbGFiZWwgPSAicGFydDBfMCI7DQoJCQlyZWcgPSA8MHgwIDB4ODAwMDAwPjsNCgkJfTsN
Cgl9Ow0KfTsNCg0KZmxhc2hAMSB7DQoJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KCS4u
Lg0KCXBhcnRpdGlvbnMgew0KCQljb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KCQlj
b25jYXQtcGFydGl0aW9uID0gPCZmbGFzaDBfcGFydGl0aW9uICZmbGFzaDFfcGFydGl0aW9uPjsN
CiAgICAgICAgICAgICAgICAgICAgICAgIA0KCQlmbGFzaDFfcGFydGl0aW9uOiBwYXJ0aXRpb25A
MCB7DQoJCQlsYWJlbCA9ICJwYXJ0MF8xIjsNCgkJCXJlZyA9IDwweDAgMHg4MDAwMDA+Ow0KCQl9
Ow0KCX07DQp9Ow0KDQo+IA0KPiA+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVk
LXBhcnRpdGlvbnMiOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmNhdC1wYXJ0aXRp
b24gPSA8JmZsYXNoMF9wYXJ0aXRpb24gJmZsYXNoMV9wYXJ0aXRpb24+Ow0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGZsYXNoMF9wYXJ0aXRpb246IHBhcnRpdGlvbkAwIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gInBhcnQwXzAiOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwMDAwMD47DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gfQ0KPiA+
IGZsYXNoQDEgew0KPiA+ICAgICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KPiA+
ICAgICAgICAgLi4uDQo+ID4gICAgICAgICAgICAgICAgIHBhcnRpdGlvbnMgew0KPiA+ICAgICAg
ICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMF9wYXJ0aXRpb24gJmZs
YXNoMV9wYXJ0aXRpb24+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGZsYXNoMV9wYXJ0
aXRpb246IHBhcnRpdGlvbkAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGxhYmVsID0gInBhcnQwXzEiOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4MCAweDgwMDAwMD47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+
ICAgICAgICAgICAgICAgICB9DQo+ID4gfQ0KPiANCj4gVGhpcyBhcHByb2FjaCBoYXMgYSBsaW1p
dGF0aW9uIEkgZGlkbid0IHRoaW5rIGFib3V0IGJlZm9yZTogeW91IGNhbm5vdCB1c2UgYW55dGhp
bmcNCj4gZWxzZSB0aGFuIGZpeGVkIHBhcnRpdGlvbnMgYXMgcGFydGl0aW9uIHBhcnNlci4NCg0K
WWVzLCB0aGF0J3MgY29ycmVjdOKAlGl0IHdvbid0IGZ1bmN0aW9uIHdoZW4gcGFydGl0aW9ucyBh
cmUgZGVmaW5lZCB2aWEgdGhlIA0KY29tbWFuZCBsaW5lLiBJbiBteSBvcGluaW9uLCB3ZSBzaG91
bGQgc3RhcnQgYnkgYWRkaW5nIHN1cHBvcnQgZm9yIGZpeGVkIA0KcGFydGl0aW9ucywgYWRkIGNv
bW1lbnRzIGluIGNvZGUgc3RhdGluZyB0aGUgc2FtZS4gSWYgbmVlZGVkLCB3ZSBjYW4gbGF0ZXIg
DQpleHRlbmQgdGhlIHN1cHBvcnQgdG8gZHluYW1pYyBwYXJ0aXRpb25zIGFzIHdlbGwuDQoNClJl
Z2FyZHMsDQpBbWl0DQoNCj4gDQo+ID4gQmFzZWQgb24gdGhlIGJpbmRpbmdzIHRoZSBNVEQtQ09O
Q0FUIGRyaXZlciBuZWVkIHRvIGJlIHVwZGF0ZWQgdG8NCj4gPiBjcmVhdGUgdmlydHVhbCBtdGQt
Y29uY2F0IGRldmljZXMuDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMTkxMTE4MjIxMzQxLkdBMzA5MzdAYm9ndXMvDQo+ID4gWzJdDQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMTkxMTEzMTcxNTA1LjI2MTI4LTQtbWlxdWVsLnJheW5hbEBib290
bA0KPiA+IGluLmNvbS8NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3VtYXIgTWFoYXBh
dHJhIDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbXRk
L3BhcnRpdGlvbnMvZml4ZWQtcGFydGl0aW9ucy55YW1sICAgICAgIHwgMTggKysrKysrKysrKysr
KysrKysrDQo+ID4gIC4uLi9iaW5kaW5ncy9tdGQvcGFydGl0aW9ucy9wYXJ0aXRpb25zLnlhbWwg
ICAgfCAgNiArKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL3BhcnRpdGlvbnMvZml4ZWQtcGFydGl0aW9ucy55YQ0KPiA+IG1sDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbnMvZml4ZWQtcGFydGl0
aW9ucy55YQ0KPiA+IG1sIGluZGV4IDA1ODI1M2Q2ZDg4OS4uZGY0Y2NiM2RmZWJhIDEwMDY0NA0K
PiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9wYXJ0
aXRpb25zL2ZpeGVkLXBhcnRpdGlvbnMueWENCj4gPiBtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvcGFydGl0aW9ucy9maXhlZC1wYXJ0aXRpb24NCj4g
PiArKysgcy55YW1sDQo+ID4gQEAgLTE4MywzICsxODMsMjEgQEAgZXhhbXBsZXM6DQo+ID4gICAg
ICAgICAgICAgIHJlYWQtb25seTsNCj4gPiAgICAgICAgICB9Ow0KPiA+ICAgICAgfTsNCj4gPiAr
DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBwYXJ0aXRpb25zIHsNCj4gPiArICAgICAgICBjb21wYXRp
YmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiANCj4gVGhpcyBpcyBub3Qg
c3RyaWN0bHkgcmVsYXRlZCBidXQgSSBiZWxpZXZlIHdlIHdpbGwgc29vbiBoYXZlIGlzc3VlcyB3
aXRoIHRoZXNlLCBhcyB3ZQ0KPiB3aWxsIHNvb24gY3Jvc3MgdGhlIDRHaUIgYm91bmRhcnkuDQo+
IA0KPiA+ICsgICAgICAgIGNvbmNhdC1wYXJ0cyA9IDwmcGFydDAgJnBhcnQxPjsNCj4gPiArDQo+
ID4gKyAgICAgICAgcGFydDA6IHBhcnRpdGlvbkAwIHsNCj4gPiArICAgICAgICAgICAgbGFiZWwg
PSAiZmxhc2gwLXBhcnQwIjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDB4MDAwMDAwMCAweDEw
MDAwMD47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgcGFydDE6IHBhcnRp
dGlvbkAxMDAwMDAgew0KPiA+ICsgICAgICAgICAgICBsYWJlbCA9ICJmbGFzaDEtcGFydDAiOw0K
PiA+ICsgICAgICAgICAgICByZWcgPSA8MHgwMTAwMDAwIDB4MjAwMDAwPjsNCj4gPiArICAgICAg
ICB9Ow0KPiA+ICsgICAgfTsNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbnMvcGFydGl0aW9ucy55YW1sDQo+ID4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbnMvcGFydGl0aW9u
cy55YW1sDQo+ID4gaW5kZXggMWRkYTJjODA3NDdiLi44NmJiZDgzYzNmNmQgMTAwNjQ0DQo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9wYXJ0aXRpb25zL3Bh
cnRpdGlvbnMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tdGQvcGFydGl0aW9ucy9wYXJ0aXRpb25zLnlhbWwNCj4gPiBAQCAtMzIsNiArMzIsMTIgQEAg
cHJvcGVydGllczoNCj4gPiAgICAnI3NpemUtY2VsbHMnOg0KPiA+ICAgICAgZW51bTogWzEsIDJd
DQo+ID4NCj4gPiArICBjb25jYXQtcGFydHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogTGlzdCBv
ZiBNVEQgcGFydGl0aW9ucyBwaGFuZGxlcyB0aGF0IHNob3VsZCBiZSBjb25jYXRlbmF0ZWQuDQo+
ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFy
cmF5DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gPiArDQo+
ID4gIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICJecGFydGl0aW9uKC0uK3xAWzAtOWEtZl0r
KSQiOg0KPiA+ICAgICAgJHJlZjogcGFydGl0aW9uLnlhbWwNCj4gDQo+IEZpbmUgYnkgbWUgb3Ro
ZXJ3aXNlLg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

