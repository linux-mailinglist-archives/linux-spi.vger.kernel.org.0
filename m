Return-Path: <linux-spi+bounces-5521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC79B26BA
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 07:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D71C2130E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14018E368;
	Mon, 28 Oct 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XzIXjF8g"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC415B10D;
	Mon, 28 Oct 2024 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097726; cv=fail; b=G1hDcbK8BbmfTqD/ctcyQtryv5ZRn9DeXGobiET1H+QTkYO8nV4WRziW+iXFUgUckxv+eLGiAAzF5Wov2XgHR9P8ixPBxG7q+9jVr2Kc9zg+ddZwle4ySTPWtpSFGkr6vK3ZlaNVa7afXmGICl1SfprjFRR9WnUiPssWVeGUz8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097726; c=relaxed/simple;
	bh=xgvKJYJqA+YcbzGgzjeFTaDZe5QEY7UW1jyGe0rdH2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Liu5AulClxnic56Gpi/CunM5sJpQAQ/fh+20hOxSBP0WjAceYSk+vc+Yl+oLz/QBE8Q4FbQfqPVNoUqYtQDPOcMzQcFnKj4r3QyeJbv1gSsXTG62xhd0G7ssbg75X4HmbnH07aIwEMvTEfUv8pmGKj/4l6OihmAdpBtXrRtNWh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XzIXjF8g; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkeZBkGINqKQYqct2k/DpA6EMqsaZizrSpb2tLP2WOlC+liaI+dvOr2v0lRB+Z5+9nO9a2D+jopa+BzKPX0szw9wzjpFcMG+6CKaMMe+n8ZNHaKPe+6e9pQnMHk9hjkWE82WVQSig1rhauuOl7EI2yoIvHM+sJuBLdoppPc7ealaUQEGlB6fLrEkjfcpDWIkbQ2HbXd3xqHIPn5iCENTuQcqmW8lbo5WFp7LizYDUqAM1adFbhRlMoKNSHsegSaKJyR44+sXA40gB+pNQtPYz8MJTkGnLAAeAOqnE26N3iC6KlAjBdU7vqNAaBSsfGZs7z5+uPgA0Sq9NZgPJTsg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgvKJYJqA+YcbzGgzjeFTaDZe5QEY7UW1jyGe0rdH2c=;
 b=OeoXqRVeQPKEL1MKa4oN8wAjjnnlQ2YbbLIRaqafjYmgxHD1ou7W7Fvyjxv6k8TYLPy3j5dim6cgFNdit/U0/eZZEJG7Mv8mOQYB4vh1upaBGWWrTEHQg/BlLQftR0C23Atz15SqFdglxhpefq2d7Cf0td7B33BoIcvSfHoEtQeHse12WNq0gOn5oITQbbeKtr8AerxnVkhFG0UAsnQ4kIu5cyLo8Vki4/LT5Nj98x9F3hEa8lsU3gz9BdMEbTMxDVu7Sg2brXrvUcqGuFDW5NkLVdEmNkxBu79dwv1ADCiHYCMsqlXaEtqLuOhc+LDpTrP5uFPt0Yy1Scf9cqSkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgvKJYJqA+YcbzGgzjeFTaDZe5QEY7UW1jyGe0rdH2c=;
 b=XzIXjF8gueLb2g3Rn4nWK7MayX+WezKgDT7QMqwqGWxiczbGF41y8x758OPg+1BP+SYHo1WCfS51wiiwG934EzaJYQ5Bk5Z0mfrikpihlEyvd3f+kwI7rIShlCP6Cru4aOWCPJouyJ+qZVzsaBl5tJ4eNKKmPtLYhhJKl7z5ZJ8=
Received: from DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) by
 CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Mon, 28 Oct 2024 06:41:58 +0000
Received: from DM4PR12MB7693.namprd12.prod.outlook.com
 ([fe80::57b7:d9aa:1cd8:ed14]) by DM4PR12MB7693.namprd12.prod.outlook.com
 ([fe80::57b7:d9aa:1cd8:ed14%5]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 06:41:58 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "tudor.ambarus@linaro.org"
	<tudor.ambarus@linaro.org>, "michael@walle.cc" <michael@walle.cc>,
	"broonie@kernel.org" <broonie@kernel.org>, "pratyush@kernel.org"
	<pratyush@kernel.org>, "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com"
	<vigneshr@ti.com>, "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
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
Subject: RE: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Topic: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Index: AQHbJ3xBTx+wL/tjcU+OTs1kcRvpc7KY4TQAgALT50A=
Date: Mon, 28 Oct 2024 06:41:57 +0000
Message-ID:
 <DM4PR12MB7693C526AE5D9DE4A09B4BBFDC4A2@DM4PR12MB7693.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
 <20241026075347.580858-2-amit.kumar-mahapatra@amd.com>
 <ba6d1274-08ab-4754-9d5a-92f0ebab88d3@kernel.org>
In-Reply-To: <ba6d1274-08ab-4754-9d5a-92f0ebab88d3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7693:EE_|CH3PR12MB8756:EE_
x-ms-office365-filtering-correlation-id: 27b6bc4d-3b51-442d-ba69-08dcf71b9ec4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXcwTW5YTk82c0U0Slp5djZGd3haQWcwNHhwNFRHUHRLdm5GdkZRSmdteE1x?=
 =?utf-8?B?TDFPdEZveHg2MURHTCtoVUdvOG9tZkZEM2ZwZWw5R1F4UVQyRjUrUmM1dVZZ?=
 =?utf-8?B?cVNYclloTXRia0IrNUFWeEZxTGJRN1JWcXJKcEV5UkVVNEVWZ3QrMFY1dmpF?=
 =?utf-8?B?aWdzQzdGZ2tlT2VVVTQ4L3NsV01nUWRtUTg5cDdkMklQd3hqbWUvTWFvWnk0?=
 =?utf-8?B?NUh1S2twak40UlI1UW9TS05ZcW5HRUxNL3cwbEh6bG1QRjU3NTZFOUNOWUdt?=
 =?utf-8?B?NFFQaFVkUmJOaTFWOS9BWU54TTZzUDJWQW9xNE9BYWVuOEVrNUlQMXlmK2No?=
 =?utf-8?B?TG1Sd1U5SDZTSFdrOHp3L0VkOGlZKytybzFudHJXNWZxOXJBQ1VVTTVVYU9E?=
 =?utf-8?B?WERhNlFYTzM0R3FFNnVGeWYwOXhndXY3THZ1NmdaTmhjcEhDd2pDZXQyakE4?=
 =?utf-8?B?bDB1clFudUR6VENIVDFDMlB2aHZCbG1mSW5UNWE5VDdKa2Y3aWFqazg2Q0M3?=
 =?utf-8?B?UE9YaTNyUXFVQzVQNFhlZWtiU1lIbTVKbXpPdnpHc2UyNXphNHFmR21XblNP?=
 =?utf-8?B?K3pUcVpGTFlmS2VJeEhqZm0xN2dBc1FvRk8vWmNuaG9IaTZEN1B6STRHMU95?=
 =?utf-8?B?Z01tQVFUVGJzbzlBcUFGeXY1S05hMWU5Z1AzU3Y4WmJzNkp0dS9YeTZwamNW?=
 =?utf-8?B?K3Z3M21wVWxYemJNYkZseHdhNGIyemNXdkRQOTV5eHV2LytvcDA0TVd4aVVr?=
 =?utf-8?B?L0U1Z0FMemllSGZnT21aMC96RnFwbUpOWmFxbjRwS1RyOUJhTXNpd3JQS3Yy?=
 =?utf-8?B?akZYUFhXbGNkbHVmQ001d1N1aUFJbkQyRk9aNHhZd3JYOEZLNEhmblkwcUll?=
 =?utf-8?B?YjUzSitjTld1K2l1ZmFoN2hlYldSOFY4MjdtVG1wM2JqeHVMVFhqNmhaTklP?=
 =?utf-8?B?dGo0T29yanNiUHdSOTZkK2FYLzVpdWdnUWk0SE5VMEI3bnJONnBja0pUbjB6?=
 =?utf-8?B?Q3lDenNZZE11NC9hUTdnMi9hZ0NQN3RLdEZmMWU2QUlOTzY5UVp2L0VKQ05r?=
 =?utf-8?B?bldtTFB5RnRmVmVqNHUzV2QvTjJsRjI1bzhXTk5mdmpiRTV3M2lLYWsyU3Vm?=
 =?utf-8?B?eHB2ZmZWWlQzSk91ay9mZU9XTGlJZE1jcDBnU2NReTc1M1FxSTAvK3pEd0c4?=
 =?utf-8?B?aS8rR0tlMXRaYTUrZGgzRU1aYXUyVVIzVkdnSHFWK1F4OGhJcG5CMHJzZ3d1?=
 =?utf-8?B?Y2h2RWlWaGQ2azdZUVVpMDFzYklpc04yZ05mQXlnZmsrZUdGcnJpL3lYOXNo?=
 =?utf-8?B?WnBEK0RyQjFpbGNuSGRCdlcyUHYzQ25LUUgxSjNCdktsbDF0YklpREhOTnI5?=
 =?utf-8?B?REVxWG96Tm0zVmFhM3FPSm5lUWJxQmZCV2pHaHpjL3hVc0VrTTlaK0IyTFdm?=
 =?utf-8?B?TkdxeTg1cjBlcGYxMllkd2ZSdmdIZ1dOZXJJRFN6TE9Sbno1UjJ0N3RGOGdv?=
 =?utf-8?B?REU3b2R2YXJRbkxubHJ2WnB3enA2YTFPTEdHcU9aMXprZ0NhVXN5V3R4YTk3?=
 =?utf-8?B?T21wM29PZEJxV2FUZDlOQlZjOTJWVUNCWUQ0L204MlZHMUhZeEhlZmM4QzB2?=
 =?utf-8?B?aEFERHN4eDFKMXVtSkNKc3JkMEdnbzg1ZlB2bUJFbjBuN1daQVdvQy9mRmE2?=
 =?utf-8?B?a21WcGVTK2gvSEtUdnBYOVg2b2xLSmk4Wi93MDJpakZrTjhUQy9vd3g2UkJj?=
 =?utf-8?B?YjNteVhya3JKS2RpVG1nek81MXVYYVVpZkU0T1RPUTdUZHRaaGh3VFlmUnI4?=
 =?utf-8?B?WS9rOU1qTWZCbEFIcTNJb1hZVTVMb2JXWU5QeWV5R0ZKcFB5cEdUS245eDIy?=
 =?utf-8?Q?qimIA6LWuMXHt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1Y0NldueVROL1JITjNaUmpXZXZwWTVnWHZVZHdiSkxrUlEwUmo1VUIycmZ6?=
 =?utf-8?B?YXdLTDRsbTNYRHAwOWRiUTVac2ZnNjE5YU82aW1lOGhBaWh4OWtrUUtwWmhn?=
 =?utf-8?B?LzYvUExmT3RscFRYaERVaWdNM3A5aSt1NitMSXp3dGRWNFRQc3VGS3dXQzVh?=
 =?utf-8?B?MEw3WjlUZUlYekpNRTUzSDdWc2oxZkloK0FFWm0reXQ1M001ckxmUU9hSWFt?=
 =?utf-8?B?cmFySW9nSVRNSEhEYnVOUUNGZTYyUU9WSGx6cStrSmc4WEVZSWZZbnR2cm5n?=
 =?utf-8?B?ZTdpaDdpaTN6OUhCbHdQOXNJOWd0OVE0aXVOYkxkbllUR1ErSUVDRC9WaW4y?=
 =?utf-8?B?Y2E1Qmh5a3c4UEJtMnYvN3htR3dPamJtVDNjZ1dQWUUwZ2YxSSt3TnVkUXBo?=
 =?utf-8?B?VnhrZ1U2YXVZRGRhR3dxVkMyYTR4ZW9yK1d6N2tjWGtLdkJsK3MzRHRybzFu?=
 =?utf-8?B?WkVnZktEeFhyenJ5dDZ0dnpFaXZ1VHRvWVJFS2ZWR21WbEoxSDRkRVN5SCtM?=
 =?utf-8?B?WEdqVHlXMGFKWUpheFQxWFRuWUVheEt6enUwNlltb2IyUnB2cjRDdXJleCsz?=
 =?utf-8?B?NmpNWXUyWTMyWmNOVWRjUFUya2xPMnhVNUFHWmRVN1N2UkNUUzY5ZVg5ejRD?=
 =?utf-8?B?UDJjUk5ZakxsYkJqMDdYbUpZbTNzc1Q3eVBDSjJrbjRUc3dGQkpLQy91VXFZ?=
 =?utf-8?B?UG9zaDB1YXo1bGhRYmlWTktjWGswRE8vMmdOR05PdGprTzhyNFU2bUVhbkxF?=
 =?utf-8?B?SU9xV2xyc0lvOG9jUVd4Vyt2M1NTZnZVUTFvUnNNcHFjNnJLSGZwaGdCeldO?=
 =?utf-8?B?eXE4Q2R1NWduVThMc3ZyWmhVVmFsVDlPYlhJNjY4a1h4YkxRWW1JKzU3U1hj?=
 =?utf-8?B?RmQybXhEcXdRVGJwZ21kMDdwTEw1eExQV1lDR1g2bFYwU0tRQ0lGWjduNEto?=
 =?utf-8?B?cWlJcURkVDE1bENUSVNLcDF6cG1pZmt4YkNPTUQxWVQ1d3hYWFRjaG5OVkZX?=
 =?utf-8?B?MFV4azVOdmhQY2JNQW0xa2tFMUxzSHRadVRxRWxCc2pVd2dHRi9DVC9QWWFM?=
 =?utf-8?B?MWRyWnFLYTFNdVZIek5LcUVEK3RyYWZocExlSStZa1JUTGtvMEV1RjdXZjQz?=
 =?utf-8?B?eGJEeUVib09pWUJFVkVhSWF0NmlodFJiNjRIU2tncFp1VzJ0bGtZeXhKT3cr?=
 =?utf-8?B?b3lvUVBLanJzMnZ6SVhTSEZxbUNoL3RFMFI4VmZMQXJ4bWZPQk5UWkxQUkJw?=
 =?utf-8?B?MWtMSVNkaDZpZkkvcEJ3eSswWGU4SEpqdjNXNUpha3JoeUtoZld2MVJ6TG1x?=
 =?utf-8?B?R25FazJzWFIyWmhyeDJ3WUJKSTRocG1wYkF0cmJBb04xOS8zYXEzU2FGUVVZ?=
 =?utf-8?B?RWNHbGM1eHh3TWhCUUIra0djNUcxNmtib21xTnRjeTIvNW5rWUZaNk9ZQVhM?=
 =?utf-8?B?TVEya0I0bDRqUHdLUXlMSTM0VXEwTmIyK0lYeU1kbkZ6VHRuL2plQkNNSjJ1?=
 =?utf-8?B?TUZEcXhKb05OVWVLanI4R1Y1VjNGdmk4ZStRSzQ2ZFVRUSsxZkcvVDFiRktm?=
 =?utf-8?B?cHBlUDJhU0VITzFqa0xHcWFIemc4NkJiZEF6WktVTlNnZWxvaFQ3c3Y1eTJq?=
 =?utf-8?B?MkpId1U3aFpSWmx3L0F0bHFvNExHaFNFQnp0dkF6NXJjMWduMm1oZXdHMjF1?=
 =?utf-8?B?RC9zdk5BNzErbWc4MkF6bkUrTjdMQXFReFVsc1hhMjI5SkxZZWZWOVMzOUdW?=
 =?utf-8?B?UklCY1RHS01xeTRWOEt0NzZ1ZU1lUmhzOVRtQXIwY0VQeUdoZG5uL3NCRmps?=
 =?utf-8?B?Y3BnLzlHVG40eUlOY01abnk5WmRXMTFxNWR5RVE4MDF0RjgwSGdmZWxJd3Zp?=
 =?utf-8?B?WWxDRy9xcElVZkhnNXNDVDlPMEZXZzJwSFlMRUlnMEVqNWJxUDVhSGNvTUhC?=
 =?utf-8?B?VlR2Q3dTQTVUTHlHa1FDOCtKVmc5ODliOWdORzNNR3c3Q2hEUkhQeWpKUk5C?=
 =?utf-8?B?RFZUY3IyT281cEh5dGlnK3UrR1RESXAxTXNObjRpdWQvY2tYVXllZzdSdGZz?=
 =?utf-8?B?aVR5Y1J5SjB4ekpObnQ0cGRTUjRJeHRRV1JxVXAxRnFvdGVKT2tIanE5cGhE?=
 =?utf-8?Q?kom8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b6bc4d-3b51-442d-ba69-08dcf71b9ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:41:57.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwLbOWlJdwmdE64wC5eFaohQKuDn1oeErYm7e8kz/w8AZtDg8IwAwImRCwP2W8DYkkQunqSpZy6emiv5es1HqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756

SGVsbG8gS3J6eXN6dG9mDQoNCj4gPiBUaGlzIGFwcHJvYWNoIHdhcyBzdWdnZXN0ZWQgYnkgUm9i
IFsxXSBkdXJpbmcgYSBkaXNjdXNzaW9uIG9uIE1pcXVlbCdzDQo+ID4gaW5pdGlhbCBhcHByb2Fj
aCBbMl0gdG8gZXh0ZW5kIHRoZSBNVEQtQ09OQ0FUIGRyaXZlciB0byBzdXBwb3J0DQo+ID4gc3Rh
Y2tlZCBtZW1vcmllcy4NCj4gPiBEZWZpbmUgZWFjaCBmbGFzaCBub2RlIHNlcGFyYXRlbHkgd2l0
aCBpdHMgcmVzcGVjdGl2ZSBwYXJ0aXRpb25zLCBhbmQNCj4gPiBhZGQgYSAnY29uY2F0LXBhcnRz
JyBiaW5kaW5nIHRvIGxpbmsgdGhlIHBhcnRpdGlvbnMgb2YgdGhlIHR3byBmbGFzaA0KPiA+IG5v
ZGVzIHRoYXQgbmVlZCB0byBiZSBjb25jYXRlbmF0ZWQuDQo+IA0KPiBJIHVuZGVyc3RhbmQgdGhp
cyB3YXMgbm90IHNlbnQgdG8gcHJvcGVyIGFkZHJlc3NlcyBmb3IgcmV2aWV3IGJlY2F1c2UgaXQg
aXMgYSBSRkMuDQoNClllcywgdGhhdOKAmXMgY29ycmVjdC4NCg0KUmVnYXJkcywNCkFtaXQNCg0K
PiBJdCdzIGZpbmUgdGhlbi4NCj4gDQo+IElmIHRoaXMgd2FzIG5vdCB0aGUgaW50ZW50aW9uIGFu
ZCB0aGlzIHNob3VsZCBiZSByZXZpZXdlZCAoYW5kIHRlc3RlZCwgYWx0aG91Z2ggSQ0KPiBhc3N1
bWUgeW91IHRlc3RlZCB0aGVzZSBwYXRjaGVzIGZpcnN0KSwgdGhlbiBwbGVhc2UgcmVhZCB0aGUg
c3RhbmRhcmQgZm9ybSBiZWxsb3c6DQo+IA0KPiA8Zm9ybSBsZXR0ZXI+DQo+IFBsZWFzZSB1c2Ug
c2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVv
cGxlIGFuZCBsaXN0cyB0bw0KPiBDQy4gSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hl
biBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQNCj4gZW50cmllcy4g
VGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQg
TGludXgga2VybmVsLg0KPiANCj4gVG9vbHMgbGlrZSBiNCBvciBzY3JpcHRzL2dldF9tYWludGFp
bmVyLnBsIHByb3ZpZGUgeW91IHByb3BlciBsaXN0IG9mIHBlb3BsZSwgc28gZml4IHlvdXINCj4g
d29ya2Zsb3cuIFRvb2xzIG1pZ2h0IGFsc28gZmFpbCBpZiB5b3Ugd29yayBvbiBzb21lIGFuY2ll
bnQgdHJlZSAoZG9uJ3QsIGluc3RlYWQgdXNlDQo+IG1haW5saW5lKSBvciB3b3JrIG9uIGZvcmsg
b2Yga2VybmVsIChkb24ndCwgaW5zdGVhZCB1c2UgbWFpbmxpbmUpLiBKdXN0IHVzZSBiNCBhbmQN
Cj4gZXZlcnl0aGluZyBzaG91bGQgYmUgZmluZSwgYWx0aG91Z2ggcmVtZW1iZXIgYWJvdXQgYGI0
IHByZXAgLS1hdXRvLXRvLWNjYCBpZiB5b3UNCj4gYWRkZWQgbmV3IHBhdGNoZXMgdG8gdGhlIHBh
dGNoc2V0Lg0KPiANCj4gWW91IG1pc3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1heWJl
IG1vcmUpLCBzbyB0aGlzIHdvbid0IGJlIHRlc3RlZCBieQ0KPiBhdXRvbWF0ZWQgdG9vbGluZy4g
UGVyZm9ybWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBtaWdodCBiZSBhIHdhc3RlIG9mIHRp
bWUuDQo+IA0KPiBQbGVhc2Uga2luZGx5IHJlc2VuZCBhbmQgaW5jbHVkZSBhbGwgbmVjZXNzYXJ5
IFRvL0NjIGVudHJpZXMuDQo+IDwvZm9ybSBsZXR0ZXI+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=

