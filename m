Return-Path: <linux-spi+bounces-9108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE7B071AD
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AA17D8A9
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBDE2F002A;
	Wed, 16 Jul 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="MHmjc55F"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022082.outbound.protection.outlook.com [52.101.126.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2322727E1;
	Wed, 16 Jul 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658215; cv=fail; b=Q0iTWUkFZ0XR3EDTsTSKdBp2MLQSjhGvztNL/A0SS7UPVo+6Pxt7TOSe14PGJH3c9wFJZa5u7dtKfUAMNg2AMo+LgbfNOnEkP3igIXJbcZ9nFf9lBlGOvl3g0d5HMW0UTfmHErPUQhZ4XIz+Xh9XIyImaqjejfJBXFM8ovf9cTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658215; c=relaxed/simple;
	bh=zWATPpPwOKVWG4Pa3ZFsN/Ob8d8T3t5hcyw9kSTIU4U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lRDbjQ3jZPA7qlAW2Dpbes6jbASTL2caOWiLgxRtfpgNpWIks0OMxjpeP61mFVsEs0Rw/yDJjVaQbwqhqhsCt4QMVcp8T3o2Bb4mcspULcE57VEZ3rHBzVSmLvmKMbU+wiDb8aFnhxaGHzozZBg6bz0pAbsaeHMt7YOYNvUQuZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=MHmjc55F; arc=fail smtp.client-ip=52.101.126.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2FDn4SXSkd8vFzc/1/CNaxvddoS4gFRFG63Gq8HZMsNuh39jASD0rtHgNEEZcYKSJLPBo8su/fltO6qtIxVANpq4j+M/BZIPYVhbMkCCGhSM0LkN/sWM5+lpbonJw2ielYGPwXQJxEPwTKbo7teBdedY/VYxKc29SaaGikhOiBqUVoXCbqnl2Ykii4pL6QG82sHRIptBwSe7g5HJHvSzG3akHI8EDoa2kAloZD59dUXmwDcBIo8FOTmsgKLR4EkSjvnUHFX9whtCPjFjA7mbvL32YY0hqNS70VGmdhEUwwKpY2fxqUpi0Al2761tkv6DzF/oRY6MULv7Xf7yPva7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNCDTft8bQAwUo3qH18mNzUWbvqFz6/F1CCJbr+mi88=;
 b=rCOsd5sSwedCnMquNKNRp1JiQ1Yz0pOvCOOxWF3eyPpgKeBGN8gjivMTGkLEjBjlwFWBZsqO4C4JphBk6H8YG9L7c2rCAcTuwQqrb4snuG5Coyk7mUE8FOrWKBmvdZMS2xcJoJC1xtbTclIjiBl+fDRS/tZjVgvHdf9g6bm8NooeOQC36fvTldbcTMgOU51BRnaU2VHEvMdDLnb+0kv3xOLqKbQEnmMgZ2zztUNUYLIlK+355aNrhbSKBdpnxDseVM9kI4AQauk0HZW/P4IAQ5O50xsWwsU+pEIUIbPYFOq7B0IkyZsceUo5JUWiWZVrNhYimjTsJc7qACmkHLw9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNCDTft8bQAwUo3qH18mNzUWbvqFz6/F1CCJbr+mi88=;
 b=MHmjc55FJuEH6/q74SxOc0y3LwBoLtmCYytAQa3+TnpAI1Iq4RwbXMTECtcnJzbWcXzs1TAKV4C8Al4k3ENuYYSVBbB2MCjK5NmzjTseonjhpEGfl7OyhJLqsdzYqByUH/QynhMsUsDTh+XAP3bdmTNLSSOUGM5FGHfKJmSOaNicyJR3Yvnj3pFeDoHIq7xS9T6RajWUJoSnTgB6P/fPzRShJbcZtLxNt3jb3JihenqcGsfz8LBe9mOAg4cmF5W6qZSqxGO322rtClNmSKNHroYlY50fMOgh1+bKdRg1hqf+ZnXENCQy6O42ypAYy8TsLlk8A1ouw7HKjIPajyWADw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY1PPF5E6276BA7.apcprd03.prod.outlook.com (2603:1096:408::a59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:30:09 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 09:30:09 +0000
Message-ID: <b42995ed-d1d5-4624-88ab-4ba1b6f54ebe@amlogic.com>
Date: Wed, 16 Jul 2025 17:30:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
 <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
 <aG0hU5nbjLjTWS6p@finisterre.sirena.org.uk>
 <03b7abe4-95d5-44f4-96ec-989c736e58b0@amlogic.com>
Content-Language: en-US
In-Reply-To: <03b7abe4-95d5-44f4-96ec-989c736e58b0@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY1PPF5E6276BA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 41784350-d9f9-4759-9c2c-08ddc44b5b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1EyL2htTkRhR0J6RmpSN0ljdUQrRDJwOVFzVnVBMFpMQkpNNDVqZzJHZWFK?=
 =?utf-8?B?a25RdTByTTlBS05iWFZES2paRHJlRjNEdnlzVWtNemRObm1Ybko3aUIwZzE2?=
 =?utf-8?B?NkhBMW1zR2IzbTdNYnJ6YmRKNklEVWJkb0pjUHNVV2J1V1ZCTStIdUcwOGFh?=
 =?utf-8?B?eXg4SnR1YzMyYkJvOFozQnQzWDdCRFg2U3dmYTBXN2FmSFhjYTN3TXBHK3o2?=
 =?utf-8?B?QnFYL3BOUXJpeHFQV0hZcWFQNi85a2o4bGhRdzgyaFRZK1lVazhod21nczln?=
 =?utf-8?B?ZkxUbjAyR0p3eFZIVnpuVmhXcjlJYlFRc29zZTlNb0pmS21yd0dCV09TNlUx?=
 =?utf-8?B?d3d1N04wcjJiUHJRT3UzREdod0hIaFgxclVzM1BIU2RDS0JOWGhCZjlzaUFP?=
 =?utf-8?B?dFU2T2pLMUNldGw2NE5MNWhtZVVJMjFzNGxNLy8za045T2laYVdKZFZMYTRp?=
 =?utf-8?B?MlJSNDNXdUF6MTNzY0cyMmJ5LzhiL0ljNTFGZVI0T1B5eHhvV0FPbkR1bGFq?=
 =?utf-8?B?V1NBK3B4Y1J3NFNYNnYzQ1FLOUwyeGZtdDEzTVVGY1lFZU9tT0ZKQmI2cDZn?=
 =?utf-8?B?QWo5c0JTOUhKc3I3WGMzWmh4SFF2cWd2L1N2TkdmOFZMaGtmQlBhUTFybGdZ?=
 =?utf-8?B?RmF3U0RvVUxnSlhxRXRabmN2VitXdTJZSmMrbjh2S3lheFN4c08yOW9nVlZO?=
 =?utf-8?B?ajNETDNSVnp2U2tSdEVDTlVFVkdUdGZEdE5TTHlRVU5sMWRoN2ZGVE9zcnhP?=
 =?utf-8?B?QzR1MjExUU9DUDZaZWY2Wnh3a01GbzlSMjJleC9nNlJJSzM3NUx3S2ZMY1oz?=
 =?utf-8?B?YmMzN0Ixa0lIcWtSRGRhSFRiTWRiOUx4TDQrcjhBNldudW4wazhsaDBQTGZU?=
 =?utf-8?B?ZGJtNHdIekNSejdEK2J6SjBTT0xuVlV2V0hnTW5aVmhYNW12MWo4cmYyeG1h?=
 =?utf-8?B?MDNLMDJXN0lqcnFyKytqaytoVHA0NUh2bkpzUzUwQXVIOEpGTlk3cFdxb0s2?=
 =?utf-8?B?K3RtbjFISlhWYkR1YlhaWVQrZnVHZkVCZkQwUzlSa280cDNIQVkvbEdvaDh0?=
 =?utf-8?B?M3MwaXRTOEpFZXh4aFhOZkp4NmNkNkUvaFpYMmx0VGkwbllYRkZCL3JrOHlN?=
 =?utf-8?B?UCtpN0h5UnNSMHgzU0UwWnhuSmtFYXhvZFJwYmJXWDlUWllGVmRnc2xPdHoy?=
 =?utf-8?B?MzVFVUE4aXo1MlZuN2VOUE1ONVQrUy8wOVN3RFJBVjE2dHlocHZnUzkxVDJ3?=
 =?utf-8?B?Znh5MnVtT0JlK3lkYVhqWDhzYWFnd1VwR0FwT2dBekw2OTJIZCtPdUZpTkZY?=
 =?utf-8?B?akJ3bUtqMmJTeFVXVmhYbS83VWJHSU9CSWhCRWtVNk5zaWFNVTJCbFgyblpF?=
 =?utf-8?B?Sk1vMzNyYmsyMlo3aGtmU3FQTWZhY2pjZ1pwVTNpY3lpN0xYVDJUcEltRVN5?=
 =?utf-8?B?NE5hejFCQStLQXpUVzJCc1hBZitIckx1Z21zVFdta1o2Q3BJSnNseStKb0Jr?=
 =?utf-8?B?QnJYV2QvQXhoRGM0WjNWZ2RuWTZyUG1IcWZoeEg5Q3FCU0ZiTUY1dEFrYjlN?=
 =?utf-8?B?UXhxbDFBWUlURXp4MjU2eCtrNVltMzZ0Y0ZsVzEzbUVIcEFnRm4yczFGVkFu?=
 =?utf-8?B?UEFac2ZyMVE5YWVWc1hBMzRhK3NQMnBGcVNGRFNHV0N2RWV4aFpFdVZINENr?=
 =?utf-8?B?cGVaTWhadXlrNGRybkxWTldhU2RFVXhzUnVMWU5XMTVnRTJKUmdYMFpKbnF3?=
 =?utf-8?B?WXBzQTVJc2lLWm11cWZPTVpUWGhhQmJyV1dUeTM4MGl4RGZoT0M0aVcvclQ5?=
 =?utf-8?B?NnZ6cHRTTUQ4MVF1ZzRxMHZtNi9IeHozaEZtMGNMeTI5Vm1rc3BSbERScDBJ?=
 =?utf-8?B?V0pjbEhsOEU5S0d4dzdKaXE3b3poNnNxa3F4bEVUVUQvSmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhQSzI5VWpzNGljUWROVFBPNTRsdTlwTDBLenRDTlNGQVJ0NnQzK0FpUzRt?=
 =?utf-8?B?SW9kNWJpYU0zRDUyZ1hGc1ZGZklSSThXM0lCNWk5NmhkRitFSzdqNDBTWXdQ?=
 =?utf-8?B?MTV1bnBYT2pFSzI5MStYcndZY1c1STZnR2xkUm1CRHlyeVEwRHlQVU9DNFQ4?=
 =?utf-8?B?a3FzYnBwWHNJWUlmbm50di80bmR5QmVEaUkzVlh5UGpjeFlyL3hGZmYza0la?=
 =?utf-8?B?dXh6cG94eUg4QnlPL0ZZdWJFT3lDb0g3UGZiV2x0YzJYcXBsTVlhcm8yZU9B?=
 =?utf-8?B?cktkcU1UWkljSEtseDJWekJUbHhWazk2MGU1VVJwMkhSNUhKbDM4b2o5STc3?=
 =?utf-8?B?dVZ0QmRtTVl5MjlaZ0M2akVzQ042WFlGZDA0M09ZTG5QcGNCQ3RHTGVZMnhX?=
 =?utf-8?B?enVHeEt5WnpQM1hwaVpvd0g4eTl6Rmd4djgraTFQbkZlKzM3djA0Y2xVZGhw?=
 =?utf-8?B?WTRRMVVuZmh4U3I5T2xwbDRWRW95dW8rYTVrMHJHN3pwbjl5eXVzVk13WFZh?=
 =?utf-8?B?dkhHOUpEMHRSTVp0MWtaMFZLQ0hlTzN0VDVGOEFhc1pjbHZsSlBKd2wzSk5k?=
 =?utf-8?B?RHJXcWdlaDF6RGlyMlJhZCtrU3VPREpvSUYySnZ0SlVEL2JSbWlnaXVMcVQ0?=
 =?utf-8?B?MWR5cllvelZkanRaMmZVMjk5bmFlSlJrYzRVZEJuMW5tc1BlTUsrcWZEUXpm?=
 =?utf-8?B?KzBnV1RWWnZYU1Y0UmFyQXQyWFRkaytnN1BNRHRQMTBwMzM0T3djeXoyeFNW?=
 =?utf-8?B?Vm1JbnVFQ0oyMmRkZnpITUdVelhHcG54ZEsrQjhOSWd0N0RJL1VDSTVXd3dM?=
 =?utf-8?B?MmhMZDZPWmxmUlY0SjZ6MTloSWNSYVd6SFdBL3dBYjY1UUVGSlRlZU1FTE5G?=
 =?utf-8?B?enc4VDJFWHVJbnFCRzE2ZHl0LzAwS3c4Q2d2L2RwKzQ0aWUrK1VPVklEdVRx?=
 =?utf-8?B?THB0ZXdScG9KeVhmNklMRVZINm1yTjE5bEFUOUc2V1N4bzdPVjRSUk1OMUpT?=
 =?utf-8?B?WmhvL3Vnbk16TkZ2S21oUGYzK3JsSHVEMFRIU2l0MkZoRFREMFIrenlwb2d6?=
 =?utf-8?B?REtLd2ljQXQ0T1poc0NkOWIzM2xpaFlpUlhHRkdvRUp0L1ZFdWp2YWE1TzEz?=
 =?utf-8?B?bFZNQURrRG9jNk5jMVVpbmdYN1VoUEpUWGRaTmpSdFdUMWdjckJsbVEwVWQz?=
 =?utf-8?B?RUtabjJJbDhkKyt3KzJuT0R2aitVYTBWWklNY0Yxd1M0VVB4WEhweGNzVTBW?=
 =?utf-8?B?TlRMdko0RDkyVnNqSURTK3h3V0JnTUZqYnh6Q0JQLyt3L085NGJicmdneVRJ?=
 =?utf-8?B?aDFoM051eXVPN09IS1NiT0NxYURaU3g2RHNWYm1PcDlSNncvTkVuU0NHdTJ6?=
 =?utf-8?B?eWN6Tk1ORHR3aE9RN05rU05kYm5rR29Vb2s0dk5nZVh4OGtmRllaazVsakJt?=
 =?utf-8?B?VHdLV1FiNHNRb0tuanFXQTNJRGRwUmtNc09SdWE4SktEbndBSGtRNXNVc0gx?=
 =?utf-8?B?b2hjandQYi80WnA4S0RBZkZUQjJPK1diOVoya1B1bTBjYkw1TDJIckd6QUxW?=
 =?utf-8?B?amorZm10RXdVOGl3QVZxUzEyWHlkcDZTbXZCZmJCOXZwSUl5V0lHZUtVVmJL?=
 =?utf-8?B?bVVGTXlpdTFwVkJsRnplY1R0cHh6UmQxbU9DNjgzUVRMb2Qvai9yOGoyRWEx?=
 =?utf-8?B?eGFrMUdVWTgxNEpReFFXZUoyMDlBTmdEWVFQb2RCTGNkdUVHNllpTnBObVYz?=
 =?utf-8?B?cUxRbmVKd0VRSU4vWDhhOFlMNWh4Z0RQa252OGNDajZSTzBoWWxlcGk4eEkv?=
 =?utf-8?B?M3Uzd0lOU3M5eGxyYzNlM0puK0w0bGdsV01ST1RoeDJWYlRUZzV4VzhYcTlL?=
 =?utf-8?B?MmNVQjN5STY2dGh5NVl6ZVFUSS9TMkFjYTMvS0R5Y1JOUVRlVGF4V0d1SGkr?=
 =?utf-8?B?Y0lyaVM5S1RBWmdPYTBwY243ak9pbXlDUDFoSFMwbHB2czAza3RrZ1NjYTlp?=
 =?utf-8?B?ckNkMUVUUzdyeDFVSXhmb3BXczd5RnF1UkU3ZEh6R1RyTWRTWlBISGNYWU12?=
 =?utf-8?B?eTdZY25NV3ViSDk3T0RmV001Q01HNU13dlQyakEzMzFQNU1qVDRJa1o1VzBC?=
 =?utf-8?B?RTNVMkVRNk1zb3B0eUx5bS9na3hWZWxGQ0IwdXpIS0Y1dklGTUt1TjQ3OWEv?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41784350-d9f9-4759-9c2c-08ddc44b5b6f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:30:09.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arYxQe9QLy203fVDUWooabM7YK13KpPW9IV4DfFLXkRUTr4aDwUL0yUThj9auJjkPcS7LO6n4xh/v9N+Q5OKaaCvQXC+YyenfX4J0pse/Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF5E6276BA7

Hi Mark,

On 2025/7/9 15:02, Xianwei Zhao wrote:
> Hi Mark,
>     Thanks for your advice.
> 
> On 2025/7/8 21:50, Mark Brown wrote:
>> Subject:
>> Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
>> From:
>> Mark Brown <broonie@kernel.org>
>> Date:
>> 2025/7/8 21:50
>>
>> To:
>> Xianwei Zhao <xianwei.zhao@amlogic.com>
>> CC:
>> Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
>> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
>> <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
>> linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
>> linux-kernel@vger.kernel.org
>>
>>
>>
>> On Tue, Jul 08, 2025 at 06:34:02PM +0800, Xianwei Zhao wrote:
>>> On 2025/7/7 21:05, Mark Brown wrote:
>>>> Is it worth having a copybreak such that smaller transfers are done
>>>> using PIO?  With a lot of controllers that increases performance due to
>>>> the extra overhead of setting up DMA, talking to the DMA and interrupt
>>>> controllers can be as expensive as directly accessing the FIFOs.
>>> If the data volume of a single transfer (xfer) is small, PIO mode 
>>> does offer
>>> some advantages. However, since PIO requires the CPU to wait in a 
>>> busy loop
>>> for the transfer to complete, it continuously occupies CPU resources. 
>>> As a
>>> result, its advantages are not particularly significant.
>> The CPU overhead tends to be higher (you can avoid some of it with a
>> dead reckoning sleep), but the latency vastly improved which for many
>> applications is a worthwhile advantage.  It tends to be things like
>> accesses to one or two registers on a device with registers where this
>> wins, 16 bytes or lower would be a common number off the top of my head.
>>
>>> If PIO is to be implemented, it can only handle one transfer at a 
>>> time (via
>>> transfer_one), and not entire messages (which consist of multiple
>>> transfers). In contrast, when processing messages, the SPI controller 
>>> can
>>> handle the entire sequence in one go, which also provides certain 
>>> benefits.
>> It's probably worth adding something to the framework to be able to take
>> a decision at the message level, for writes this tends to all fall out
>> naturally since the write will tend to be a single transfer anyway.
> 
> I will try to add new API message_can_dma for framework, and implement 
> PIO for message.
> 

I tried to implement PIO mode in the driver, but it turned out to be too 
slow. Due to the lack of an internal FIFO, data could only be 
transmitted one word at a time, and each transmission required 
reconfiguring the corresponding registers. As a result, the efficiency 
was quite low.

The only simplifications provided by PIO mode were in two areas:

1. The allocation and release of the transfer descriptor
2. The DMA mapping and unmapping process

Therefore, I suggest not implementing PIO mode in this driver. I will 
document clearly in the code that PIO mode is not supported and explain 
the reasons behind this decision.

