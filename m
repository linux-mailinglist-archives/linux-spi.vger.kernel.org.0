Return-Path: <linux-spi+bounces-5176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02513997AFF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 05:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BB52821A3
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 03:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2773E479;
	Thu, 10 Oct 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QM99LONl"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471D1BDDF;
	Thu, 10 Oct 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529464; cv=fail; b=d92sk0gqjEdmkaBkJooS1kfYgOZxHMMAMXiDQoLjXqSLIQsol5ZKb5U5FNO1B8UQ0xloG1WKA269pQJkiTwUthdKCPqlNcN6NC1whFqL+7YXIAx6kq7r43wfcBg7v3SrFtaNmRKvZU9l0lGcjVV6elK8FISfoxubqo0fTRTMEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529464; c=relaxed/simple;
	bh=wOwkk1DeYOGwtS31h3S+X1FpglkLJEzzqhhG/kW+UWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwoQPedop010VyYQIAJQkCZHSyy0/O06Z4ZBWOlDWcazvWLdlvGfq+KsXgmhRfibIHmoNIgAPSvRdEoZzTcG5+10IfIwOsGrgZEAyLoI1Nyi2FNMk2DWdMjf3WNDYCuObdBywHfG65BAPWjUTjXueGYxIEqt9eYzvxPZg4FR8nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QM99LONl; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/P87YxKLO9WEJef2uuon1+75uJbZhoTT/3AEC6hifCgsV4QjsKsytmoUeFVDiD4DFCNfIDtUpGrAxyQgZ3vLsf2sCJXwGAXAlW+Q0ySgBUYHQ8jfxUqWAtdOzdq30F/+JfkPoWlb+2NEW0peLVkQMWx6tIhCDJhWbJX9jaOzp1LXNPFlBRwu3e9lAKGLahaE1sh/PYB2vmI69ukZhybicUUKC3/fcdnHdK0KpOMdjk/K140Tpf+Bt8CZoz1E2w51CoiDv29TRnWOFAmc32WdPzl8ACv7dfKpUhLl3dPGbCDsRCU+a5lDjNiMms2yFWAAfD2LOamUp9YHHFXNMrjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOwkk1DeYOGwtS31h3S+X1FpglkLJEzzqhhG/kW+UWU=;
 b=Sm//0eE3BfyS3Nv+eCg1aH9rtozqhvtGxffLnlny9sY9UGB7fE9jWBzveb9OdslSFH1MLUGSL+DNvx2AHThGCVp4P6rk2iEskPjVzAGB4UhYxwNH0nGx8wfKn8skxhdmUvwK7IlHJJ6P0nkGZaO2Lj4ZQYzX13vBHEiwGRBrVr5HFQZ8cfuC9erAm4pVQHCX8kfc9i8+01VI6kPWolEQGU/UrVVIIWLihllvNkSu1FkRXvo8IOQv9RiFloj+bLKQgQIRTwWIHJROcdIKxVS6q/sSNhLKS9vSeaWjxM1S0eJA/pzUzEgL8rfQYA2H3rspTXkkZglMabShy5D71iaI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOwkk1DeYOGwtS31h3S+X1FpglkLJEzzqhhG/kW+UWU=;
 b=QM99LONl4Ut7EufwzxDsSkltU2deV+K+mbyNIWjk+Foh5c97JqCZJrCDyQJWv7oZK1DCXIkzcKZ6tbD/O3zfgePZXZvToTWTwx4qlATiZHAb6TNvkywzpIklXvUoI60/ak6VRqWBj0PqXggM+LXJlFK9IukLgDDIicCtb+Q5d/dyV2AOInjAWAnQeBxbfVBcy/67vh6HR6uWZ3mpsIz7q43ZkE3NDqlvCpBvC4VJ4FOJhHauobk5F6A3aKLt1AcYVABLoNyTqIcj1kNw9mCKjqNkp8k1fTuaRIeNvcVEbrLhHmAQqMqpMhlxOyxoKKpqooSYIi827H6ohJAQGsIMtw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8303.eurprd04.prod.outlook.com (2603:10a6:102:1c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 03:04:17 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 03:04:17 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Han Xu <han.xu@nxp.com>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "singh.kuldeep87k@gmail.com"
	<singh.kuldeep87k@gmail.com>, "hs@denx.de" <hs@denx.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>,
	"stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH v3 4/4] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Thread-Topic: [PATCH v3 4/4] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Thread-Index: AQHa/3hOKHvkM1q2dUypugVNFHEy/7J/gcqg
Date: Thu, 10 Oct 2024 03:04:17 +0000
Message-ID:
 <DU0PR04MB9496B2C010944AB1FDE6A22090782@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
 <20240905094338.1986871-5-haibo.chen@nxp.com>
In-Reply-To: <20240905094338.1986871-5-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PAXPR04MB8303:EE_
x-ms-office365-filtering-correlation-id: 194eed8a-d6c6-4465-f822-08dce8d83ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?L2JSbEMxbXdWQWtXbWpUZFZUN0I1TVM1blVqbkVnZEFqRXE5SWlkNUxham02?=
 =?gb2312?B?SHBnckYwa25ucmR2SkFVK2dnR29xRjdjRlpqWk0rMm9wVVRmYno5Tk5oYVY4?=
 =?gb2312?B?QXI5d1BYNCtyckJVekZQcWs5aTBNMDdPNjljcEJ3R0tVRXFJcCthNGxIaFlx?=
 =?gb2312?B?WWRjMFl6WkNHeXJIVkV0L24weTRVSTR0RElHaGsrRk5iNlNRcGJza1liSThG?=
 =?gb2312?B?cUlYNkVvSytSdG9RTGlhb3JmT0poU3JnN21pOHZZYjVic05tV1ViMlNBQVVB?=
 =?gb2312?B?c2IwanpzM2F6UDMraXVyRFJ4ZGU4Ry91bVB0c1NOZHBjZ1VNZzVBUVdXeVNr?=
 =?gb2312?B?Y0ZOaG1YcjJzMkM1QW1VU0V0UWtOLzU4UVh0SHAvc0pHcVpqZ2NwQ1U5bElD?=
 =?gb2312?B?ZlZQaWVJK0JoY0dSUUJqZ20xWVVCVHJWaCthdllvakVyQzRINXkvRDRsMVpY?=
 =?gb2312?B?alQxMVpMeU1ySVEwbFZyTHlSakhEaGVuWTlIdjVsVEVMakRMNGNqNXpBRHdC?=
 =?gb2312?B?OHJlOUxHd0lxR0FJclJNdGUxeGZlT1BBNG15RHFzNGUyNEY3Zmp1K3NWZldh?=
 =?gb2312?B?L1JCTklRQkhIa0F3cklDQWFEM3VIb0lCM1NNQW0zTEdWZTJrc0VkdmVxK0ZE?=
 =?gb2312?B?WHBrN1pCU3pJUWpseEJUOWR4Zk5hck03QnNEUG5kT01KSFZQSG5UMUpOTC9r?=
 =?gb2312?B?TzlXVVZtdFVmSTRHV0tiMUlBQjljaW5qemJ2Y0xseDY1dnBhMWVXRjVYNnB2?=
 =?gb2312?B?Sm1ldjBPMVBPVGdtcmRnK3Urc2pOaFJ1V2h5S1J1cXpDOFFNbStEeHFNL2Vo?=
 =?gb2312?B?dDZTKzY1NG5JcjV1aHAxaEVQOFhVMXBwVkFQWm9QQmlGNFRNU3FwdWxiKzBj?=
 =?gb2312?B?ZWNobWVaVlRZdmdrZ1pmb0ZGZDVkd2pNdUdKMy9va1VQRmZpN1RSUDN3R0R6?=
 =?gb2312?B?eFNyRWpXd2RiSGVadkl1amhFN3VZai9UVjJjT2hTUzVUaG8yclA4Vkh1UFVo?=
 =?gb2312?B?dm51bzVDK2JQVkc3QWMzL21HNEd3Yk4reVBTMDRzZW9ISGZGRjlqSkI0cVdS?=
 =?gb2312?B?Sms4SDdzdS80WHdtZGExUFI2VVlRODVKWmNDTkRFZnNZWXhYTTkzdTBwUU9T?=
 =?gb2312?B?bDRULzlqSHdNVUhiT3l0ejRnTWtmRXBHUzhKVFpkZVJYaXdtbjdNMG1OZHVh?=
 =?gb2312?B?bUZPVm1zQk0yRVZtSURjaXhsQmJob2JWUnE2NmczWUVKWG4vUkNzZEZvMnF3?=
 =?gb2312?B?RjlXWjNuUlhKMWM1SU1XM3AyZ1ZVTExqRU1QYVFrc2pBb2FrRFFuWFVNM0hG?=
 =?gb2312?B?OG82M0JId2NPTzNDVWxGQks4NVcyek5ibytkSk9kRVNkU3F6cDF2N0RkN1g5?=
 =?gb2312?B?ZkxjcWp4SGRZekg0VjJIbHFJbmZicDZxVWZmYW1Rd2FYYU85Z1psclFCR2w2?=
 =?gb2312?B?Yi9RVnoyQ0JSTC9MbEd2eDdGS2FhQXNuaWtPWXRYd2JmR0pYQjRKckM1VlUz?=
 =?gb2312?B?NHNGTmN3SXZjYUc3VXhzSTlCTHpnUmhCd2Vvc3JBR1BIaHF2WjdxSm5PKzlZ?=
 =?gb2312?B?REp6YitHQmt3cmNwV2FXWWpwOFFhY1o0aUk1MTczaFpLaUxEaHZPSUpwcyt1?=
 =?gb2312?B?OVJQdW8yZFBneXdLUFpRcFlndlA2OFRMc1FGOG12SUJGMEI0L3Q2RlY1dWhQ?=
 =?gb2312?B?ak80ZmFmNjZRaVorUEZDak56d0FqSmt5SXhibWlBVTVibldnUTFpR2NjSmxI?=
 =?gb2312?B?UEUvSlpwSk5ZU1ZzcWFzc0tqVGh0YWJQN3M4SzhldGYySHMzaE5sOEdwdnJY?=
 =?gb2312?B?ZkRzVnFNdVV2eStmMi8wZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3NUN0p3ZmZTbGhHcEdWVVBNMkFOc2EvZWEybkFEY29SZStwdFlyY1RlbmQr?=
 =?gb2312?B?SHVGVFh4b1hVTUQzbmVjVkgzd29Tbmw3ZmFXLzZXQXF6aEQ4Vi9IdkxobDgv?=
 =?gb2312?B?WSsrWVlwUG1zNHU2eUlnaHVSbXVjL2F4SG5kakxxTzRsWlBMUDZWelJ3SEtG?=
 =?gb2312?B?STJnRHRzcjB3VHkyNWpnT2gxUCt4UE9zTldQcWFSN0YrbXRDdGVtWnBLNFdo?=
 =?gb2312?B?Qmordm9mWUpsNC8vekxaN3VmWmpNRXA3K21MTnpqSWx0QTZxdlFTRGE0T1Iw?=
 =?gb2312?B?Tm9CZlZSek9XYmxpSWQ3TUE5dURKanFwQjBoTitGVitUQ1p4RjBYZ2hhRG95?=
 =?gb2312?B?MHErZlZ4NWlYMEJtei9hUEMzai9SNXVEV0o1WVQzckVCTGRzZEJYSUxNVy9z?=
 =?gb2312?B?aGpISmtvY0o3ZVVYU2hPSGRocjlpckthVDhHMFhjYU9hTHBDNnc2eE5zQkZt?=
 =?gb2312?B?cmV6NFlXSkxaZkhNMGRLZS9DbE1zRk85Y0sxSk5hZzg4N0ZPQ1J6TDJlUTRK?=
 =?gb2312?B?VTlEeWdiQkh0eWZLRWgvVzlBd1VaSmU3UFRHWW5mZ0VTR1huWXF3NWw5cFhw?=
 =?gb2312?B?bDJtekxEMjlTTmJFSHlwckUydFV3R094N0FVRGtNNStmTzdaSVNSRFpDczBW?=
 =?gb2312?B?aExQZk9JUVlHUXBseitUT0pVR3RBS2xOK2piT25GMmlFcndlQk9leTNrK3Bo?=
 =?gb2312?B?UzVlSDhOSzhnWE1zUDJleUlzOE80Y09sakE4TWY3dHYxVzYzckpnUzZqSmRv?=
 =?gb2312?B?MjhWS2M3d2pOQWpWS0s0TVZXNTZWUERuMlFneFhqM0NWUVFlUGRYK3lDWERy?=
 =?gb2312?B?SXRSaENTY2Q0b29xUmpiTjJqY2NYRGw1b2dqNG42ZWxQNnE3NmZHSENFeWt5?=
 =?gb2312?B?dUpqR0p1bVloejZVSFZTMnVOZXJwd1Nvb2VVeUQ5R080SVNMc2R3L3lBS1kv?=
 =?gb2312?B?SlZ1MkhmN0JydHBXK0VON2d5a0RGVWxicWdsYXB4WW9hR2h2UmczQUxpa1h3?=
 =?gb2312?B?UyttY1pmN3MwUk92U1VqbkJGdlZQUFg3Snd3eHlDZHR2bG9ZazlHMnhHL2tN?=
 =?gb2312?B?SThWUlRseE5pdDY2akVSQlI2WVovNldJZktpYXVra09OSHhsSWo4a3VINmVj?=
 =?gb2312?B?ZVdrcVR0UDY3cmhMNjRaeExIU2dGSjFxdGJYVjBBNlc5dTZiNS9tU3YrN0E0?=
 =?gb2312?B?c2R6VjJWeVJFR3IzdTNmaXZDdlJ5UGRvTTY0QlgvZkVRMkQ3TDF1alJzNmpp?=
 =?gb2312?B?cGJ2MGF3bzdpWEk4eC9pSExuTjNGNlcvMzZJdTJPMEJCbU5QQURQOHhQcmFG?=
 =?gb2312?B?L2tOU0JuKy9ldEVoNXZGdnYyZ1dEQS96OWFVYzlEdUtjWDlQMGQ3WWhBVkxV?=
 =?gb2312?B?RzNMb01qNjl0ckQzT2lnNTN2QkFFRXVxZG5uMk95UTkvT1JWYlNlNitmQldN?=
 =?gb2312?B?SVpqTEpGYncwRk8rbEJiY01ibUMzSU8wdWtwa3R2UVlJU1JuMlFlMGlnNlox?=
 =?gb2312?B?ZnlRQWk4cUU2aWNESkF2TkhmZTBMTkV4aFUrRFkwY3p0clVsREsvTmlrTnpy?=
 =?gb2312?B?aGtTejRGUEhJVmRuYlJQSy9MS1Q0UUhTYWtjU1U1RFNoNUwzVUdmUDNKczZv?=
 =?gb2312?B?TEJkclFtVGNTbm8vajJNYkdjWEdLMDMvYmxGUGFYOXdCblFpb3BKUDVzRjls?=
 =?gb2312?B?dGczQXkyb1B5Zk1CR242ZjY1SFh5dGxhTUdqV1IrTXNmaGdUb0NmdXJLMzdK?=
 =?gb2312?B?a3RSaGNSZmthNXllNVlHb2w0U09TRTNCazBIQVBCVWloQ01HdXRFU0FMZXRL?=
 =?gb2312?B?RUpBQW9PL0tQdVliamJUa3I3cCtaT1NNMXpST1BPeWtOL2F6Wjl6WGQrNEI0?=
 =?gb2312?B?d3gxQ29HbFVBSUlJeWR4NnhIUWNwckY2NWpVay9jbzFkcHgvL3ZPaEdvZEd4?=
 =?gb2312?B?WXhEd0pOMFJlTHdoZE9kN1gyT1hiNDBsVFdIcThMbTh2UzNVV1EvS0YzSXVP?=
 =?gb2312?B?RkIzck5ic003M0dWc1kwcTQwbTZaL0tpL0xsQnJ0MURHd0IrbFN0Sm16YUVz?=
 =?gb2312?B?V3d2SHBxS01VZnZTc2F1b3NSc2NmS2dSMURNMjlhNm01K0lJUzd6R2JFeHAz?=
 =?gb2312?Q?Wd/E=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194eed8a-d6c6-4465-f822-08dce8d83ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 03:04:17.6931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOpEYTGgSKaLIzMQRhmm3AITJTaU9SoudTWjmhaQBndXZkOA/5Wh4nu91UiJrlA5xVeST0AcKNE1HGBYchoL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8303

R2VudGxlIHBpbmcuDQoNCkZvciB0aGlzIHBhdGNoIHNldCwgb3RoZXIgdGhyZWUgcGF0Y2hlcyBh
bHJlYWR5IGFjY2VwdGVkLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
Pg0KPiBTZW50OiAyMDI0xOo51MI1yNUgMTc6NDQNCj4gVG86IEhhbiBYdSA8aGFuLnh1QG54cC5j
b20+OyB5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IHNpbmdoLmt1bGRlZXA4N2tA
Z21haWwuY29tOyBoc0BkZW54LmRlOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14
QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+Ow0KPiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT47IHN0YWJsZUBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MyA0LzRdIGFy
bTY0OiBkdHM6IGlteDh1bHA6IGNvcnJlY3QgdGhlIGZsZXhzcGkgY29tcGF0aWJsZQ0KPiBzdHJp
bmcNCj4gDQo+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gDQo+IFRo
ZSBmbGV4c3BpIG9uIGlteDh1bHAgb25seSBoYXMgMTYgTFVUcywgYW5kIGlteDhtbSBmbGV4c3Bp
IGhhcw0KPiAzMiBMVVRzLCBzbyBjb3JyZWN0IHRoZSBjb21wYXRpYmxlIHN0cmluZyBoZXJlLCBv
dGhlcndpc2Ugd2lsbCBtZWV0IGJlbG93IGVycm9yOg0KPiANCj4gWyAgICAxLjExOTA3Ml0gLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgICAgMS4xMjM5MjZdIFdBUk5J
Tkc6IENQVTogMCBQSUQ6IDEgYXQgZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmM6ODU1DQo+IG54
cF9mc3BpX2V4ZWNfb3ArMHhiMDQvMHhiNjQNCj4gWyAgICAxLjEzMzIzOV0gTW9kdWxlcyBsaW5r
ZWQgaW46DQo+IFsgICAgMS4xMzY0NDhdIENQVTogMCBVSUQ6IDAgUElEOiAxIENvbW06IHN3YXBw
ZXIvMCBOb3QgdGFpbnRlZA0KPiA2LjExLjAtcmM2LW5leHQtMjAyNDA5MDItMDAwMDEtZzEzMWJm
OTQzOWRkOSAjNjkNCj4gWyAgICAxLjE0NjgyMV0gSGFyZHdhcmUgbmFtZTogTlhQIGkuTVg4VUxQ
IEVWSyAoRFQpDQo+IFsgICAgMS4xNTE2NDddIHBzdGF0ZTogNDAwMDAwMDUgKG5aY3YgZGFpZiAt
UEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTDQo+IEJUWVBFPS0tKQ0KPiBbICAgIDEuMTU4OTMxXSBw
YyA6IG54cF9mc3BpX2V4ZWNfb3ArMHhiMDQvMHhiNjQNCj4gWyAgICAxLjE2MzQ5Nl0gbHIgOiBu
eHBfZnNwaV9leGVjX29wKzB4YTM0LzB4YjY0DQo+IFsgICAgMS4xNjgwNjBdIHNwIDogZmZmZjgw
MDA4MDAyYjJhMA0KPiBbICAgIDEuMTcxNTI2XSB4Mjk6IGZmZmY4MDAwODAwMmIyZDAgeDI4OiAw
MDAwMDAwMDAwMDAwMDAwIHgyNzoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgIDEuMTc5MDAy
XSB4MjY6IGZmZmYyZWI2NDU1NDI1ODAgeDI1OiBmZmZmODAwMDgwNjEwMDE0IHgyNDoNCj4gZmZm
ZjgwMDA4MDYxMDAwMA0KPiBbICAgIDEuMTg2NDgwXSB4MjM6IGZmZmYyZWI2NDU1NDgwODAgeDIy
OiAwMDAwMDAwMDAwMDAwMDA2IHgyMToNCj4gZmZmZjJlYjY0NTU0MjVlMA0KPiBbICAgIDEuMTkz
OTU2XSB4MjA6IDAwMDAwMDAwMDAwMDAwMDAgeDE5OiBmZmZmODAwMDgwMDJiNWUwIHgxODoNCj4g
ZmZmZmZmZmZmZmZmZmZmZg0KPiBbICAgIDEuMjAxNDMyXSB4MTc6IGZmZmYyZWI2NDQ0Njc1MDgg
eDE2OiAwMDAwMDAwMDAwMDAwMTM4IHgxNToNCj4gMDAwMDAwMDAwMDAwMDAwMg0KPiBbICAgIDEu
MjA4OTA3XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiBmZmZmMmViNjQwMGQ4MDgwIHgxMjoN
Cj4gMDAwMDAwMDBmZmZmZmYwMA0KPiBbICAgIDEuMjE2Mzc4XSB4MTE6IDAwMDAwMDAwMDAwMDAw
MDAgeDEwOiBmZmZmMmViNjQwMGQ4MDgwIHg5IDoNCj4gZmZmZjJlYjY5N2FkY2E4MA0KPiBbICAg
IDEuMjIzODUwXSB4OCA6IGZmZmYyZWI2OTdhZDNjYzAgeDcgOiAwMDAwMDAwMTAwMDAwMDAwIHg2
IDoNCj4gMDAwMDAwMDAwMDAwMDAwMQ0KPiBbICAgIDEuMjMxMzI0XSB4NSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gMDAwMDAwMDAwMDAwMDdhNg0KPiBb
ICAgIDEuMjM4Nzk1XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMWNl
IHgwIDoNCj4gMDAwMDAwMDBmZmZmZmY5Mg0KPiBbICAgIDEuMjQ2MjY3XSBDYWxsIHRyYWNlOg0K
PiBbICAgIDEuMjQ4ODI0XSAgbnhwX2ZzcGlfZXhlY19vcCsweGIwNC8weGI2NA0KPiBbICAgIDEu
MjUzMDMxXSAgc3BpX21lbV9leGVjX29wKzB4M2EwLzB4NDMwDQo+IFsgICAgMS4yNTcxMzldICBz
cGlfbm9yX3JlYWRfaWQrMHg4MC8weGNjDQo+IFsgICAgMS4yNjEwNjVdICBzcGlfbm9yX3NjYW4r
MHgxZWMvMHhmMTANCj4gWyAgICAxLjI2NDkwMV0gIHNwaV9ub3JfcHJvYmUrMHgxMDgvMHgyZmMN
Cj4gWyAgICAxLjI2ODgyOF0gIHNwaV9tZW1fcHJvYmUrMHg2Yy8weGJjDQo+IFsgICAgMS4yNzI1
NzRdICBzcGlfcHJvYmUrMHg4NC8weGU0DQo+IFsgICAgMS4yNzU5NThdICByZWFsbHlfcHJvYmUr
MHhiYy8weDI5Yw0KPiBbICAgIDEuMjc5NzEzXSAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4Nzgv
MHgxMmMNCj4gWyAgICAxLjI4NDI3N10gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhkOC8weDE1Yw0K
PiBbICAgIDEuMjg4NjYwXSAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweGI4LzB4MTM0DQo+IFsg
ICAgMS4yOTMzMTZdICBidXNfZm9yX2VhY2hfZHJ2KzB4ODgvMHhlOA0KPiBbICAgIDEuMjk3MzM3
XSAgX19kZXZpY2VfYXR0YWNoKzB4YTAvMHgxOTANCj4gWyAgICAxLjMwMTM1M10gIGRldmljZV9p
bml0aWFsX3Byb2JlKzB4MTQvMHgyMA0KPiBbICAgIDEuMzA1NzM0XSAgYnVzX3Byb2JlX2Rldmlj
ZSsweGFjLzB4YjANCj4gWyAgICAxLjMwOTc1Ml0gIGRldmljZV9hZGQrMHg1ZDAvMHg3OTANCj4g
WyAgICAxLjMxMzQwOF0gIF9fc3BpX2FkZF9kZXZpY2UrMHgxMzQvMHgyMDQNCj4gWyAgICAxLjMx
NzYwNl0gIG9mX3JlZ2lzdGVyX3NwaV9kZXZpY2UrMHgzYjQvMHg1OTANCj4gWyAgICAxLjMyMjM0
OF0gIHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKzB4NDdjLzB4NzU0DQo+IFsgICAgMS4zMjcxODFd
ICBkZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKzB4NGMvMHhhNA0KPiBbICAgIDEuMzMyMjg5
XSAgbnhwX2ZzcGlfcHJvYmUrMHgxY2MvMHgyYjANCj4gWyAgICAxLjMzNjMwN10gIHBsYXRmb3Jt
X3Byb2JlKzB4NjgvMHhjNA0KPiBbICAgIDEuMzQwMTQ1XSAgcmVhbGx5X3Byb2JlKzB4YmMvMHgy
OWMNCj4gWyAgICAxLjM0Mzg5M10gIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDc4LzB4MTJjDQo+
IFsgICAgMS4zNDg0NTddICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4ZDgvMHgxNWMNCj4gWyAgICAx
LjM1MjgzOF0gIF9fZHJpdmVyX2F0dGFjaCsweDkwLzB4MTljDQo+IFsgICAgMS4zNTY4NTddICBi
dXNfZm9yX2VhY2hfZGV2KzB4N2MvMHhkYw0KPiBbICAgIDEuMzYwODc3XSAgZHJpdmVyX2F0dGFj
aCsweDI0LzB4MzANCj4gWyAgICAxLjM2NDYyNF0gIGJ1c19hZGRfZHJpdmVyKzB4ZTQvMHgyMDgN
Cj4gWyAgICAxLjM2ODU1Ml0gIGRyaXZlcl9yZWdpc3RlcisweDVjLzB4MTI0DQo+IFsgICAgMS4z
NzI1NzNdICBfX3BsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcisweDI4LzB4MzQNCj4gWyAgICAxLjM3
NzQ5N10gIG54cF9mc3BpX2RyaXZlcl9pbml0KzB4MWMvMHgyOA0KPiBbICAgIDEuMzgxODg4XSAg
ZG9fb25lX2luaXRjYWxsKzB4ODAvMHgxYzgNCj4gWyAgICAxLjM4NTkwOF0gIGtlcm5lbF9pbml0
X2ZyZWVhYmxlKzB4MWM0LzB4MjhjDQo+IFsgICAgMS4zOTA0NzJdICBrZXJuZWxfaW5pdCsweDIw
LzB4MWQ4DQo+IFsgICAgMS4zOTQxMzhdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiBbICAg
IDEuMzk3ODg1XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gWyAgICAx
LjQwNzkwOF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IA0KPiBGaXhl
czogZWY4OWZkNTZiZGZjICgiYXJtNjQ6IGR0czogaW14OHVscDogYWRkIGZsZXhzcGkgbm9kZSIp
DQo+IENjOiBzdGFibGVAa2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHVscC5kdHNpIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OHVscC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHVscC5kdHNpDQo+IGluZGV4IGUzMmQ1YWZjZjRhOS4uNDNmNTQzNzY4NDQ0IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4dWxwLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHVscC5kdHNpDQo+IEBAIC0zODQs
NyArMzg0LDcgQEAgcGNjNDogY2xvY2stY29udHJvbGxlckAyOTgwMDAwMCB7DQo+ICAJCQl9Ow0K
PiANCj4gIAkJCWZsZXhzcGkyOiBzcGlAMjk4MTAwMDAgew0KPiAtCQkJCWNvbXBhdGlibGUgPSAi
bnhwLGlteDhtbS1mc3BpIjsNCj4gKwkJCQljb21wYXRpYmxlID0gIm54cCxpbXg4dWxwLWZzcGki
Ow0KPiAgCQkJCXJlZyA9IDwweDI5ODEwMDAwIDB4MTAwMDA+LCA8MHg2MDAwMDAwMCAweDEwMDAw
MDAwPjsNCj4gIAkJCQlyZWctbmFtZXMgPSAiZnNwaV9iYXNlIiwgImZzcGlfbW1hcCI7DQo+ICAJ
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

