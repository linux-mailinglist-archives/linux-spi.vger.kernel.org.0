Return-Path: <linux-spi+bounces-5189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF79983C0
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003AD1F25447
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CD1BE85C;
	Thu, 10 Oct 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zc8wJ97j"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B711BDA91;
	Thu, 10 Oct 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556513; cv=fail; b=hZuApDX1mB+hbsm5rHLlpGBztqqLV8pq4YhvnQFci6/MWDFAdH8YYGc6eIgtD6/ZnHc8woMoXIfAJCqVkXL4MJv5Cv/nk0VX1bgR6cUfcYazef4nQWq10mZdbVd9bhoDwOJZazKeu0kDL2rj/O9Is8AhNTiRbbq5m5x2FhdsdzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556513; c=relaxed/simple;
	bh=VwrSNnzA03hgbbYWrKP7qy2KAv75KNmGS9acany21FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2QBBbm0Stbdcu16OXG6q5NKYJenEx33nlG6q/PAjrL3+0qJg/UH1K3YP137KgYOjoQBZ8fujx6SvFuMafRivnVdDKZMqqx+0RdIQeMV4L0+JBOBudBIDI8YW5fE2j8mdhl3B5qr0VcN6PiYK6lkFHwndsDDs+Rq6HXFvk5sXow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zc8wJ97j; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fon0lBu31o7dUmf+vl8uLTTrcYdtMwT6DlKUxxKtWC/52FFI+S9f03F8XyiIase1nZe7uafiV/Awhc6LReFfpGJ67ytvMNlflMCgr3Ji6/p2YNT2iQC6PyZxIoRhbf1Ji1vgn+CvcCYsogBGrrP0beGorKjt9yHQPxuhd+8NKPVU5VRxLa/OyJWSqe3LA9k3c9EFWb6zxxe47SNIbg+7tGYDPPtmyXutLqx/0kLLKdEz+/uxRjr40SfSWAFJVknVQzSt2Q42oxVOm8utwRkms6W0pqr0VTsaqjXfq94IwHWx6yuo5S6eACafWVVDT2uOXdjQBYLQCXYicsI8YyvOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwrSNnzA03hgbbYWrKP7qy2KAv75KNmGS9acany21FY=;
 b=i8y7xPVGtzqAZPZsFHVb9MKA+4Mb08NQGrdPTvJQlZbamha/WYIuqDGpM2bs/SIU0ynRyXrw38cl94MKbT+gKFVPOgUpMq+EOJqGUNnx5EG7H5hkJbUkhfuVUZdG2iRvpRARDog7EosVlnjrxDoX9KUdQHh9ikIe26AS7xp2Co+Q0kdVTr/MY56kOLL0DpmLibiO8pa2LQncfL19PLH684JfCx9XWmMhIezpV9kJbaARk4g0wR1FhvtO/D2nkhg/7QqqpeCymjN/127Txn3OAyc2U9h2UgW7XvrYgIyM68ovZ6C/9/AELxGJ9JilXgnNnirWE+dH8eebyop8ialPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwrSNnzA03hgbbYWrKP7qy2KAv75KNmGS9acany21FY=;
 b=Zc8wJ97jK/4QdiBebrE+nidtNSwdmABiGH+Gi+fll7hk4EcpWGh9arc7FT4xrJHfKZsGLhldpoH1dZRK73ZONtZbhJ3Ssm1TKlx6tN77BiyZlXNxOY+rU4jNrQDA3uMGZpInMjpuGoIAuKWwsXs89reAg8OmbclXrMD9HsPWodQ=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 10 Oct
 2024 10:35:06 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 10:35:06 +0000
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
Thread-Index: Adry+FCFJ+jxyMZCQv67eHESQhM+FQgH2SAAAfC4OWAABwXbgAAAZKjg
Date: Thu, 10 Oct 2024 10:35:06 +0000
Message-ID:
 <IA0PR12MB76990FC67F334C0FEBDFEF36DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
References:
 <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240930110408.6ec43e97@xps-13>
	<IA0PR12MB769930E81D3D66B51CDC8213DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20241010112751.01e5afa1@xps-13>
In-Reply-To: <20241010112751.01e5afa1@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|SN7PR12MB6743:EE_
x-ms-office365-filtering-correlation-id: 52816863-7c89-4ef9-57c4-08dce9173550
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3A0N01RRlBQVlFEeWllYXkzSXNOa3Z6L0JnU1dHbWVsWjlTbmdXbWEyNVBX?=
 =?utf-8?B?MHJIbXpaWlhnRzZ2N2VVQjR5dlV2OXlvV2hpSHcwRlVwU0swd29heTlWSFNi?=
 =?utf-8?B?enB3eTRaMEtMeEt1TStXRlVpUWpvSGRUWHpCT09KYlQ4cldPUllhUnUzYXEw?=
 =?utf-8?B?bmRvM1QxUXhWSmtONGJLQ1UzbTJQUHFyUGxDbk1GVlpZVmNVY2lCa29mWVU5?=
 =?utf-8?B?bDBhYTQvQU9zaUsrYkw5S0x2MTRGRXlzZksyM1c1NnpQbk5IaGF3ODN2b3ZU?=
 =?utf-8?B?SSt4QzhsRFVFcG9JcjNZWjRzZ3VYRHcyTDR4cTRkeC9zalZpWS9yREVja3hY?=
 =?utf-8?B?dWE1U1lJV0R4bEtaN1BoZGgwL0NDRWRsZmVlSlNndzREUnUvVmxFQk53SXoy?=
 =?utf-8?B?ZDc2Q1M5d0pseTFnQnkyd0FWeFZMVzhRSGtlTGxMK0k5M1AwcjBPaDVrZGxt?=
 =?utf-8?B?THh3SUcxZk5hcUcvSlFWYmU4a1dLZzBnQ2dtWUJ5RC91dmp4NE43SGJENERn?=
 =?utf-8?B?WkV6cjVCMFBLWEtsdTNXNktjQUZFYkY0UnlCelJ3QWxpSFJJR25OK0M2Q0gy?=
 =?utf-8?B?S25SWThkRGgvNnp0RG8zYmV4bFVmUzc0SXUrUVMzSDA5WGZOQ0x2ZUhCYnM5?=
 =?utf-8?B?WW02Q3d5UGVUY0hKWTFkRitOUGpNRnd3QURWUGxOYm9lOTNDWHc0TmgyL0Zu?=
 =?utf-8?B?NXg4YzQ2YnE3VnA3L3g3c2hGQUFtMmkwNHpWbXNZTnN1ZzR2RE1rZmNVS0t2?=
 =?utf-8?B?TEpQL2pmbVV3NTZzQ05PY2lFNHFlZWdNQS9EVFh3TDF0T05aVFRWTEpkVCtj?=
 =?utf-8?B?SXl3S21oWWI0QXhCZENZeVcxUmJ2WXBncXBnU1ZFWUhXOS93RW0yTEh6eFBB?=
 =?utf-8?B?NnZidURERmhZQTkyZDZBeGRLY285K0RsTmRYbG5ORXl2L01GdGxJclBVUnZJ?=
 =?utf-8?B?VnhOeDFkT2t6c1lZTXJsWDJaUGdjQnNLZnZnWUdkbkJEeWFRNmFoYStjR0Z0?=
 =?utf-8?B?NWl1NmFSVlRSbXc0M1lJeThYR2FtbGJJUjVZOXloeVRCQkprQU5QMVhLcjkr?=
 =?utf-8?B?bnFISG80QXZmY2VEUWJNR3FXWlJBVzJLekk4a25vMHBxWld0YkJ4SFcxalkr?=
 =?utf-8?B?dGJUWlBjV1RHVDlpTlh6VTBJeE9EVEVGTVo1RndRemVUSVBVZVhVRXdNc0Q0?=
 =?utf-8?B?SWJNcVhyOG94eHNSdHVDTDFFVytpMko0dnFTK0h1ZVlWakN4UnRkbk44NVN2?=
 =?utf-8?B?RktpemRPTFRISEh2dVhVNEtUajlVMWFRV3h4N3lPQTJCV2NMeU1QdS8rcit1?=
 =?utf-8?B?VXhIaUhMVVpuN25id2FsR25HdFh0b2V1WUk5cVMxNVBMMnBsa3FuTzYvWlVJ?=
 =?utf-8?B?Q0YybHZVN1lrQys5WU4vZWZmd3hJb0FSVksvRFFSZlVkNlJiWit6UHF2dWFX?=
 =?utf-8?B?RW84a0tYbmpGTFhhVlB0cXZoK3MxZ2E3MnE1eUYwOHZDamRBM08wQlJzRWg3?=
 =?utf-8?B?aVJjYlA4dFhoOVBsZGs0TUZIbFowdDZMUnpTdE9JZG5sWnFnN00vY2dGWnA5?=
 =?utf-8?B?VEZQMU5PYitENFhURWJ0N3VSKzBCci9GSlBGQ1BtN3pXcTM5dTRCNUtKVC9S?=
 =?utf-8?B?RDBHMFJLa0MrcjdnZ1lNKzJFQ3l1akxlbFhBb1FpNS9EdjhBNXNkTm9hR0VT?=
 =?utf-8?B?dlc5ZHV2cDFNNTF3S3pCK1l0TDFLUFdVZzV5WjBNNzBZUmJwVm5tL1ZoSXVV?=
 =?utf-8?B?eTQ0Z05SVXlrMEkyUTNMajA0NERoUWcycENpSXRaZ1dTb2NCaW5HNHJpQTlM?=
 =?utf-8?B?U0FWUi8rNHZLNUpaMHdIUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtxWlh6bjhXNlJRVENRYjdTcU4rOEQrZm1udTVZV1Fwc2pVc0p0UFgwZnhP?=
 =?utf-8?B?c29ScjVrdVV3RHVOSENzNEJibTRMMkhTTzI0UEJaREtTN3YvNFlRNGliUGdM?=
 =?utf-8?B?amlqRS9LWE9meGlDTERKWE0vYmwzSEd6M21GUUhDMCsyeDVPaCtuUGlYdDNY?=
 =?utf-8?B?SmRLaUxSZVNVcTZYRmhuUm5PQ1VNY2ROVnVrb0ZHTGJuQzVNMGdHODVZUTBQ?=
 =?utf-8?B?cHh1QTZBV0ZFdzRNVHg1aDVEQ3dFZ2p6UHY5YVZwd3hDUzhTZnF4SHpIRm9v?=
 =?utf-8?B?b0FseGNBVHFJWUZZQmlqdnBFMEhZUThaVnJNWGhKVTRBWURDUG9sMWQxUnh1?=
 =?utf-8?B?eHEyRHRhWS8zbHZJQnQ2N2hucDJqRWFoempCMjBqVi9IZVJrSytuSHF5MERY?=
 =?utf-8?B?bUhoNHRldmp4N28yOXJnMFR4d3ZOU2ZhSVVoVE5vNThFcFc5MFI0RFdPN3kr?=
 =?utf-8?B?bTMvNkx6RnhsNFJsa1BhblhvV0JhbG1DNk9wcDIwR2NXaHJyU3FZSzhsRElv?=
 =?utf-8?B?bUhWQytRZmljQ2huSXhEczlvd0tvRGZQd1g1SXlXbGpmcVlpYjNMb0VWSWNu?=
 =?utf-8?B?M1dPakJDWFlyM1RtbkVaYWlJREgrUlpYU0RUYTJ3L3NmV2tPajh1ZUJGVXhp?=
 =?utf-8?B?WHhJdDl0VjRwbDUzQnEraVZBUG5XUDdVVGdzQTRsTVBJK0s1M2d1QTJFRTd3?=
 =?utf-8?B?aXN1REdVZmVjUmo5VmtNU1JkSFhHMEdFYkRlWkc5NjFaeUtCT1VoMnBub1dM?=
 =?utf-8?B?cERKVWszYkF4eFFxS0lXMmxwUVJNYkxldExyVVlJZFlEZkplM0dWb2dYYzkz?=
 =?utf-8?B?N0JCQ0s0ZGVpMitiT1pvSzF1K0J4YTl1cHFWVTZUWDBZOUVOYnBUTGN6MTZi?=
 =?utf-8?B?aTNOc3FMaER4V2tZZjhveEhudCsrYnRwOXI5TWtCUEJlR2ttUTN5VVpuTmZq?=
 =?utf-8?B?c2Zla0dEaTg4eDhNSS94SnZUL3UyaDRHdlRPVHE5UW9xdXV4RlJqNG9EMVpE?=
 =?utf-8?B?RExFYXVtMFFYTTlMcVpPYm9TMUo0ZHJ3R2ZYTm9Ec2srSEFSeVVqdnhwQXhh?=
 =?utf-8?B?REpqdk9jazdzREM5U0NsSE5uSEUzSDVNTUg1b040OXBNQ1RwUGt0ODNUZHlw?=
 =?utf-8?B?Wm1USW43a0pKWXRINmx1dmpSQ3ZMUFJGTW1udWcxUVFCQ1kwc0R5VnRyRml1?=
 =?utf-8?B?ajRtY3hsQkptZEZ3elRQUGxISUpWV3NGUW93YjcrVDRwNkN5ZkRmSk5jQlpP?=
 =?utf-8?B?ZEN1VXZiTWtzdmxpQ0N6MHZPbDNMK20yaUFwQlVTN0t6Q1FsK1FFWVhiVTB2?=
 =?utf-8?B?LytRV0lTd1FacyswY2hiV1EzaEZxUGpER2NOQitqSmhOZkNPamU4bnB3T1pr?=
 =?utf-8?B?RFFibjA2QVI3Vzg2RUp3ZEhOeXM4UVVpaHNFaG1CZ2RFeTZmcmI3SGQvd3pl?=
 =?utf-8?B?dXFyL0RkM3RTQmpDWEpmYWZVOFBoR3c3aytxVnpxSWk3WStaM0d6cDErSDdV?=
 =?utf-8?B?UFZQN3ZCcEZESU9OOHU2YmlaV09MZ0lwMmw2Z0pxSnhqNE9FYjlrOS90dEUw?=
 =?utf-8?B?YnlJdENVeGp0bEhmWElzSzlhRVB2WXBJWGVSb29Gald4dVNzbFBWaGkvSkZX?=
 =?utf-8?B?M29VUjUvMDhaeU5LQ3o0a0xJVU5EblhmeUo3WWJCN0orWXRVbmROUTJvUXpX?=
 =?utf-8?B?NGxrV2l2QVQzbVM4TVZ3MGNKQWpuOWpXNTR4VkduM2hzRDRRdEp1TUZ5YzVw?=
 =?utf-8?B?NVRLLzVocnAvdmw3R3dSQTZ2TFJ3SVFNOUpCYkEyNTVxWGVteWd5MHpLdGdr?=
 =?utf-8?B?R0dtdnB1TkhjOUNmdDRWQ0FPbnFQTDc4b3E3ZDlTa09ONVVpY01TNW5GM0l4?=
 =?utf-8?B?ZHhoZ2tUT2I4SmJLVTdwV0owaFl2c05idUZpZlBBdTVXaWMzOXRGM0NRRWQv?=
 =?utf-8?B?ZFZ5aTdQTFhrZHNoWU1rb2J1Ym9oUkxuTnpPRmszWEd5VUUzV01KZElFcEZJ?=
 =?utf-8?B?OWV5MlJFMFIwVFBTRThma09FZlAzMTRMcEkwcStFdDhkZlVMV0FIQlVGbUtL?=
 =?utf-8?B?eE5JOWZheWc2Sm9xdHhad3JrNGRBQVJXMFZIcjFjQkdyNWpUMTlBT3N5WEJw?=
 =?utf-8?Q?/rCk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52816863-7c89-4ef9-57c4-08dce9173550
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:35:06.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVMGfezyX2/5gW1BZzg5VJIXjv4LwYYd0k+i2xmn4piLw8pDZ8X6ic/i9xQ7wx4PYdS2Uk9nIA2RXXgwyLNeew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

SGVsbG8gTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
cXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBPY3RvYmVyIDEwLCAyMDI0IDI6NTggUE0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8
YW1pdC5rdW1hci1tYWhhcGF0cmFAYW1kLmNvbT4NCj4gQ2M6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbGluYXJvLm9yZz47IG1pY2hhZWxAd2FsbGUuY2M7DQo+IGJyb29uaWVAa2VybmVs
Lm9yZzsgcHJhdHl1c2hAa2VybmVsLm9yZzsgcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNv
bTsgUm9iDQo+IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IGNvcm5vcitkdEBrZXJuZWwub3Jn
OyBrcnprK2R0QGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBzcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUuYmVsbG9uaUBib290bGlu
LmNvbTsNCj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWljaGFsIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gcGF0Y2hlc0BvcGVuc291cmNlLmNpcnJ1
cy5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54KQ0KPiA8
Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb207IENvbm9yIERvb2xleQ0KPiA8
Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+OyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4gU3ViamVj
dDogUmU6IEFkZCBzdGFja2VkIGFuZCBwYXJhbGxlbCBtZW1vcmllcyBzdXBwb3J0IGluIHNwaS1u
b3INCj4gDQo+IEhpIEFtaXQsDQo+IA0KPiBhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tIHdy
b3RlIG9uIFRodSwgMTAgT2N0IDIwMjQgMDk6MTc6NTggKzAwMDA6DQo+IA0KPiA+IEhlbGxvIE1p
cXVlbCwNCj4gPg0KPiA+ID4gPiAtIFRoZSBzdGFja2VkLW1lbW9yaWVzIERUIGJpbmRpbmdzIHdp
bGwgY29udGFpbiB0aGUgcGhhbmRsZXMgb2YNCj4gPiA+ID4gdGhlIGZsYXNoIG5vZGVzDQo+ID4g
PiBjb25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiAtIFRoZSBmaXJz
dCBmbGFzaCBub2RlIHdpbGwgY29udGFpbiB0aGUgbXRkIHBhcnRpdGlvbiB0aGF0IHdvdWxkDQo+
ID4gPiA+IGhhdmUgdGhlIGNyb3NzIG92ZXIgbWVtb3J5IHN0YXJpbmcgYXQgYSBtZW1vcnkgbG9j
YXRpb24gaW4gdGhlDQo+ID4gPiA+IGZpcnN0IGZsYXNoIGFuZCBlbmRpbmcgYXQgc29tZSBtZW1v
cnkgbG9jYXRpb24gb2YgdGhlIDJuZCBmbGFzaA0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgbGlrZSB0
aGF0IG11Y2guIERlc2NyaWJpbmcgcGFydGl0aW9ucyBwYXN0IHRoZSBhY3R1YWwgZGV2aWNlDQo+
ID4gPiBzb3VuZHMgd3JvbmcuIElmIHlvdSBsb29rIGludG8gWzFdIHRoZXJlIGlzIGEgc3VnZ2Vz
dGlvbiBmcm9tIFJvYiB0bw0KPiA+ID4gaGFuZGxlIHRoaXMgY2FzZSB1c2luZyBhIHByb3BlcnR5
IHRoYXQgdGVsbHMgdXMgdGhlcmUgaXMgYQ0KPiA+ID4gY29udGludWF0aW9uLCBzbyBmcm9tIGEg
c29mdHdhcmUgcGVyc3BlY3RpdmUgd2UgY2FuIGVhc2lseSBtYWtlIHRoZSBsaW5rLCBidXQgb24N
Cj4gdGhlIGhhcmR3YXJlIGRlc2NyaXB0aW9uIHNpZGUgdGhlIGluZm9ybWF0aW9uIGFyZSBjb3Jy
ZWN0Lg0KPiA+DQo+ID4gSSByZXZpZXdlZCBSb2IncyBzdWdnZXN0aW9ucyBpbiBbMV0sIGFuZCBJ
IG5lZWQgdG8gZXhhbWluZSB0aGUgTVREDQo+ID4gbGF5ZXIgdG8gZGV0ZXJtaW5lIGhvdyB0aGlz
IGNhbiBiZSBpbXBsZW1lbnRlZCBmcm9tIGEgc29mdHdhcmUgcGVyc3BlY3RpdmUuDQo+ID4gRm9y
IHJlZmVyZW5jZSwgaGVyZSBpcyBSb2IncyBzdWdnZXN0aW9uOg0KPiA+DQo+ID4gRGVzY3JpYmUg
ZWFjaCBkZXZpY2UgYW5kIHBhcnRpdGlvbiBzZXBhcmF0ZWx5IGFuZCBhZGQgbGluayhzKSBmcm9t
IG9uZQ0KPiA+IHBhcnRpdGlvbiB0byB0aGUgbmV4dA0KPiA+DQo+ID4gZmxhc2gwIHsNCj4gPiAg
IHBhcnRpdGlvbnMgew0KPiA+ICAgICBjb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0K
PiA+ICAgICBjb25jYXQtcGFydGl0aW9uID0gPCZmbGFzaDFfcGFydGl0aW9ucz47DQo+ID4gICAg
IC4uLg0KPiA+ICAgfTsNCj4gPiB9Ow0KPiA+DQo+ID4gZmxhc2gxIHsNCj4gPiAgIGZsYXNoMV9w
YXJ0aXRpb246IHBhcnRpdGlvbnMgew0KPiA+ICAgICBjb21wYXRpYmxlID0gImZpeGVkLXBhcnRp
dGlvbnMiOw0KPiA+ICAgICAuLi4NCj4gPiAgIH07DQo+ID4gfTsNCj4gPg0KPiA+ID4NCj4gPiA+
IElmIHRoaXMgZGVzY3JpcHRpb24gaXMgYWNjZXB0ZWQsIHRoZW4gZmluZSwgeW91IGNhbiBkZXBy
ZWNhdGUgdGhlICJzdGFja2VkLQ0KPiBtZW1vcmllcyINCj4gPiA+IHByb3BlcnR5Lg0KPiA+DQo+
ID4gSSBiZWxpZXZlIHRoYXQgaW4gYWRkaXRpb24gdG8gUm9iJ3MgZGVzY3JpcHRpb24sIHdlIHNo
b3VsZCBhbHNvDQo+ID4gaW5jbHVkZSB0aGUgJ3N0YWNrZWQtbWVtb3JpZXMnIHByb3BlcnR5LiBU
aGlzIHByb3BlcnR5IGhlbHBzIHVzDQo+ID4gaWRlbnRpZnkgd2hpY2ggZmxhc2hlcyBhcmUgc3Rh
Y2tlZCwgd2hpbGUgUm9iJ3Mgc3VnZ2VzdGlvbiBleHBsYWlucw0KPiA+IGhvdyB0aGUgcGFydGl0
aW9ucyB3aXRoaW4gdGhlIHN0YWNrZWQgZmxhc2hlcyBhcmUgY29ubmVjdGVkLg0KPiA+DQo+ID4g
Rm9yIGV4YW1wbGUsIGlmIHdlIGhhdmUgdGhyZWUgZmxhc2hlcyBjb25uZWN0ZWQgdG8gYW4gU1BJ
IGhvc3QsIHdpdGgNCj4gPiBmbGFzaEAwIGFuZCBmbGFzaEAxIG9wZXJhdGluZyBpbiBzdGFja2Vk
IG1vZGUgYW5kIGZsYXNoQDIgZnVuY3Rpb25pbmcNCj4gPiBhcyBhIHN0YW5kYWxvbmUgZmxhc2gs
IHRoZSBEZXZpY2UgVHJlZSBiaW5kaW5nIG1pZ2h0IGxvb2sgc29tZXRoaW5nIGxpa2UgdGhpczoN
Cj4gPiBQbGVhc2Ugc2hhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KPiA+DQo+ID4gc3BpQDAg
ew0KPiA+ICAgLi4uDQo+ID4gICBmbGFzaEAwIHsNCj4gPiAgICAgY29tcGF0aWJsZSA9ICJqZWRl
YyxzcGktbm9yIg0KPiA+ICAgICByZWcgPSA8MHgwMD47DQo+ID4gICAgIHN0YWNrZWQtbWVtb3Jp
ZXMgPSA8JmZsYXNoQDAgJmZsYXNoQDE+Ow0KPiA+ICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1
MDAwMDAwMD47DQo+ID4gICAgIC4uLg0KPiA+ICAgICAgICAgZmxhc2gwX3BhcnRpdGlvbjogcGFy
dGl0aW9ucyB7DQo+ID4gICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25z
IjsNCj4gPiAJY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gxX3BhcnRpdGlvbnM+Ow0KPiA+ICAg
ICAgICAgCXBhcnRpdGlvbkAwIHsNCj4gPiAgICAgICAgICAgCSAgICBsYWJlbCA9ICJTdGFja2Vk
LUZsYXNoLTEiOw0KPiA+ICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4g
PiAJfQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4gICBmbGFzaEAxIHsNCj4gPiAgICAg
Y29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KPiA+ICAgICAgcmVnID0gPDB4MDE+Ow0KPiA+
ICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQo+ID4gICAgIC4uLg0KPiA+ICAg
ICAgICAgZmxhc2gxX3BhcnRpdGlvbjogcGFydGl0aW9ucyB7DQo+ID4gICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25zIjsNCj4gPiAJY29uY2F0LXBhcnRpdGlvbiA9IDwm
Zmxhc2gwX3BhcnRpdGlvbnM+Ow0KPiA+ICAgICAgICAgCXBhcnRpdGlvbkAwIHsNCj4gPiAgICAg
ICAgICAgCSAgICBsYWJlbCA9ICIgU3RhY2tlZC1GbGFzaC0yIjsNCj4gPiAgICAgICAgICAgICAg
ICAgcmVnID0gPDB4MCAweDgwMDAwMD47DQo+ID4gCX0NCj4gPiAgICAgICAgIH0NCj4gPiAgIH0N
Cj4gPg0KPiA+ICAgZmxhc2hAMiB7DQo+ID4gICAgIGNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5v
ciINCj4gPiAgICAgIHJlZyA9IDwweDAxPjsNCj4gPiAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
NTAwMDAwMDA+Ow0KPiA+ICAgICAuLi4NCj4gPiAgICAgICAgIHBhcnRpdGlvbnMgew0KPiA+ICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQo+ID4gCWNvbmNhdC1w
YXJ0aXRpb24gPSA8JmZsYXNoMF9wYXJ0aXRpb25zPjsNCj4gPiAgICAgICAgIAlwYXJ0aXRpb25A
MCB7DQo+ID4gICAgICAgICAgIAkgICAgbGFiZWwgPSAiU2luZ2xlLUZsYXNoIjsNCj4gPiAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwMDAwMD47DQo+ID4gCX0NCj4gPiAgICAgICAgIH0N
Cj4gPiAgIH0NCj4gDQo+IEknbSBzb3JyeSBidXQgdGhpcyBpcyBwcmV0dHkgbWVzc2VkIHVwLiBU
aGUgYWxpZ25tZW50cyBhcmUgd3JvbmcsIEkgYmVsaWV2ZSB0aGUgbGFiZWxzDQo+IGFyZSB3cm9u
ZywgdGhlIHJlZyBwcm9wZXJ0aWVzIGFzIHdlbGwuIENhbiB5b3UgcGxlYXNlIHdvcmsgb24gdGhp
cyBleGFtcGxlIGFuZA0KPiBzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbj8NCg0KQXBvbG9naWVzIGZv
ciB0aGF0LiBIZXJlJ3MgdGhlIHVwZGF0ZWQgdmVyc2lvbiBhbG9uZyB3aXRoIHRoZSBleHBsYW5h
dGlvbi4NCg0KSSBiZWxpZXZlIHRoYXQgaW4gYWRkaXRpb24gdG8gUm9iJ3MgZGVzY3JpcHRpb24s
IHdlIHNob3VsZCBhbHNvIGluY2x1ZGUNCnRoZSAnc3RhY2tlZC1tZW1vcmllcycgcHJvcGVydHku
IFRoaXMgcHJvcGVydHkgaGVscHMgdXMgaWRlbnRpZnkgd2hpY2gNCmZsYXNoZXMgYXJlIHN0YWNr
ZWQsIHdoaWxlIFJvYidzIHN1Z2dlc3Rpb24gZXhwbGFpbnMgaG93IHRoZSBwYXJ0aXRpb25zDQp3
aXRoaW4gdGhlIHN0YWNrZWQgZmxhc2hlcyBhcmUgY29ubmVjdGVkLiANCkkgYWxzbyBuZWVkIHRv
IGV4YW1pbmUgdGhlIE1URCBsYXllciB0byBkZXRlcm1pbmUgaG93IFJvYidzIHN1Z2dlc3Rpb24g
DQpjYW4gYmUgaW1wbGVtZW50ZWQgZnJvbSBhIHNvZnR3YXJlIHBlcnNwZWN0aXZlLg0KDQpGb3Ig
ZXhhbXBsZSwgaWYgd2UgaGF2ZSB0aHJlZSBmbGFzaGVzIGNvbm5lY3RlZCB0byBhbiBTUEkgaG9z
dCwgd2l0aA0KZmxhc2hAMCBhbmQgZmxhc2hAMSBvcGVyYXRpbmcgaW4gc3RhY2tlZCBtb2RlIGFu
ZCBmbGFzaEAyIGZ1bmN0aW9uaW5nIGFzIGENCnN0YW5kYWxvbmUgZmxhc2gsIHRoZSBEZXZpY2Ug
VHJlZSBiaW5kaW5nIG1pZ2h0IGxvb2sgc29tZXRoaW5nIGxpa2UgdGhpczoNClBsZWFzZSBzaGFy
ZSB5b3VyIHRob3VnaHRzIG9uIHRoaXMuDQoNCnNwaUAwIHsNCgkuLi4NCiAgCWZsYXNoQDAgew0K
ICAJCWNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciINCiAgICAJCXJlZyA9IDwweDAwPjsNCiAg
ICAJCXN0YWNrZWQtbWVtb3JpZXMgPSA8JmZsYXNoQDAgJmZsYXNoQDE+Ow0KICAgIAkJc3BpLW1h
eC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KICAgIAkJLi4uDQogICAgICAgIAkJcGFydGl0aW9u
cyB7DQogICAgICAgICAgICAJCWNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQogICAg
ICAgIAkJCWNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMV9wYXJ0aXRpb24+OyAvKiBMaW5rIHRv
IHRoZSBmbGFzaEAxIHBhcnRpdGlvbkAwICovDQogICAgICAgICAgICAgICAgCQlmbGFzaDBfcGFy
dGl0aW9uOiBwYXJ0aXRpb25AMCB7DQogICAgICAgICAgICAgICAgICAgIAkJCWxhYmVsID0gInBh
cnQwXzAiOw0KICAgICAgICAgICAgICAgIAkJCXJlZyA9IDwweDAgMHg4MDAwMDA+Ow0KICAgICAg
ICAJCQl9DQogICAgICAgIAkJfQ0KICAgIAl9DQogIAlmbGFzaEAxIHsNCiAgICAJCWNvbXBhdGli
bGUgPSAiamVkZWMsc3BpLW5vciINCiAgICAgCQlyZWcgPSA8MHgwMT47DQogICAgCQlzcGktbWF4
LWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQogICAgCQkuLi4NCiAgICAgICAgCQlwYXJ0aXRpb25z
IHsNCiAgICAgICAgICAgIAkJY29tcGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25zIjsNCiAgICAg
ICAgCQkJY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gwX3BhcnRpdGlvbj47IC8qIExpbmsgdG8g
dGhlIGZsYXNoQDAgcGFydGl0aW9uQDAgKi8NCiAgICAgICAgICAgICAgICAJCWZsYXNoMV9wYXJ0
aXRpb246IHBhcnRpdGlvbkAwIHsNCiAgICAgICAgICAgICAgICAgICAgCQkJbGFiZWwgPSAicGFy
dDBfMSI7DQogICAgICAgICAgICAgICAgCQkJcmVnID0gPDB4MCAweDgwMDAwMD47DQogICAgICAg
IAkJCX0NCiAgICAgICAgCQl9DQogIAl9DQoNCiAgCWZsYXNoQDIgew0KICAgIAkJY29tcGF0aWJs
ZSA9ICJqZWRlYyxzcGktbm9yIg0KICAgICAJCXJlZyA9IDwweDAyPjsNCiAgICAJCXNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCiAgICAJCS4uLg0KICAgICAgICAJCXBhcnRpdGlvbnMg
ew0KICAgICAgICAgICAgCQljb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOyAgICAgICAN
CiAgICAgICAgICAgICAgICAJCXBhcnRpdGlvbkAwIHsNCiAgICAgICAgICAgICAgICAgICAgCQkJ
bGFiZWwgPSAicGFydDFfMCI7DQogICAgICAgICAgICAgICAgCQkJcmVnID0gPDB4MCAweDgwMDAw
MD47DQogICAgICAgIAkJCX0NCiAgICAgICAgCQl9DQogIAl9DQp9DQoNClJlZ2FyZHMsDQpBbWl0
DQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg==

