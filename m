Return-Path: <linux-spi+bounces-8304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24346AC4811
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 08:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB4218962DF
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D9C10E0;
	Tue, 27 May 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IZ4LSRXf"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B61A5BA9;
	Tue, 27 May 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325944; cv=fail; b=vBXByK/4nb/0PzEpMPjh/X++CYDm6liaifHaXZV1jpCr3Xg7ufxsyYv7O2boAVdaABmASw/e3uNJNDKfL7h5ZsdZWq28uNQ3RrZ5OdZ1gP6zxBfsqq52SVBiHWR7Ejw30rg5vRL/AlUZmBCdF5s3L1YyzqaLbC2wgzjaIAt1ZS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325944; c=relaxed/simple;
	bh=68o/fBbN34Iw+JPDYeiGkBrXOuHx3E+/33jobLBZ9c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsrZquq6DNIvdYP4ec92Zj9ak1wz0Z/hr736k+tVu8FUpaX/AdBLOZVYMZTtaK1DVB8/w09KSPMQRrcotc4+5FyuiDe7EXoCr7iaoBUmDnL5RGb4Yu5BPDRGndVgFwxTnDtAtRGi381Pm+iJ7u7hBtTbwmyovsJyXmEzret+1RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IZ4LSRXf; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPnLhOsoMxYsM0eTiHSiySpjMHZz8Ap0ZZmEN2Ly8VtcK2lqQxjp0JE1Vk8Mf8OJBDB656mBefHbiWPcZs8MfMRRIIyi60BssinSZu7dAAX7aIgs7BEsPeGOzT5oQol3ArbLzj73fwtEVTUmKvdoAj8T366s8vv1TSETv0Gfyd6ncLQu8okhGjAB2BxxvpheC8tCnyw5O+HZuprCLuLJwv0vedU1PQ6K6IufL8GTpfqq2h2WgXyp9IqzBuI5dBceheR0ZabR8BT9tFgMz3QCc6heVBUShmDa97yalqEI+LTZuMMPKeUI/vTbZm4HN71zdBuN3CSUuaT3okpcfuSuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68o/fBbN34Iw+JPDYeiGkBrXOuHx3E+/33jobLBZ9c0=;
 b=Q2Vl3HIuOYeXkiQ1GREJAdPZnDSYjBuMCLRGswaGSNr7EdtzfCWownwe1OUmTNynyRm7TY8IkLPVeuc4rtU8bVklBODkgixpMu9sT/xziyl3pm0e5psMQiuBMtXHfmWy8ZN+M3q6qjXDcDZA+Ile8iMTauEnAvQ6zA6AF9j5LXclWL5Ji2Q2lUautRv2ZiH3ouqYOW7AoRPK6of9UFuDbS6fNohg/JYr8eoiSTdw+wr32r43XfBU6R1ClYSQvN98mlloAWn1SODgpl0Z9p7fth8osrW8TyRklxsyletKXCTPb2d6Lb8RPFMJ8LQSGTgJXYcVpLnw6yaFPAu9ebY2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68o/fBbN34Iw+JPDYeiGkBrXOuHx3E+/33jobLBZ9c0=;
 b=IZ4LSRXffje0QYo3VEFHWTpCd/4f84N2k1bXjzSosvpkT9nY1o10n7FftcYFvAPilR1r/4NyL6t7iOnAIVaKsB5qXnQwX2sBg6gov4ZORgwuvnznk/N8/0RiUDB0HqhDlZLQE1Q9OyvYvrTOnlMuJJs9XK1pulALgL3+Iesf0WQ=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 27 May
 2025 06:05:37 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 06:05:37 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Thread-Topic: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Thread-Index: AQHbywb9dprIEt0NbkSOfExrWnOpALPezReAgAWyaKCAAGWfgIABGyNw
Date: Tue, 27 May 2025 06:05:36 +0000
Message-ID:
 <IA0PR12MB76991D522A8E47DDA3800EE5DC64A@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
 <20250522-dropout-hertz-6f1db9256655@spud>
 <IA0PR12MB769903933CC9200FD082143BDC65A@IA0PR12MB7699.namprd12.prod.outlook.com>
 <6b71bbef-84f6-4255-b8b2-cf50c5183235@kernel.org>
In-Reply-To: <6b71bbef-84f6-4255-b8b2-cf50c5183235@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=01aaa140-bdb1-4e78-89d6-d40b5f6e9f83;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-27T05:49:48Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|SJ5PPF665EE4E73:EE_
x-ms-office365-filtering-correlation-id: 221adda2-7816-41c1-4fc5-08dd9ce48001
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0dmOEo5aFVwQXBHWU5hc2J1d2QzRUVFZTdQOG9YWStXd2RJV2FOSnBUcTFE?=
 =?utf-8?B?N3RVd2F2OVRycEJnQklCZ0ZCb01ISFVmZzNtRlF4UGdTeDN6L1NlWVRoN1Zi?=
 =?utf-8?B?VE0vdGd0cnJzelljT3JzTytSY2liTWRtbEhWanl5TjFLTCsranFWMEFTaU5s?=
 =?utf-8?B?MWFkNlYzcDVyREh2Z0g2RXk0cDdWTHc2VHl2MENuSGZRek1oU21GaGdGMUNJ?=
 =?utf-8?B?ZS81eTBMQ3cyWEZ3UlBSRWVoY1NKbGw2Z3czT1BrWFNobGFDMGdEWmNYa1Zz?=
 =?utf-8?B?RDAwS1VSaFJWT2FFdlR4QkkySWJzejc4N1lxemRhK2s5VjBub24vL0RXNHJS?=
 =?utf-8?B?Z0hNY09rbXRDaG5FWERoY21NbHVzN250S05ia20rdFVLbVZoeGEyMUttU3RK?=
 =?utf-8?B?UzJZelVlWmxNM2xxTGVPcmRXUE4rbjA0alVoeWFRNHczamhVVkV4eWlEcXpM?=
 =?utf-8?B?NXFXMWlOWW9pT0dkWStoNitnVXFjWUJnektIYkdDVHM5MmZuNm45YXQ0ZlZE?=
 =?utf-8?B?OFMzaWFSaUJyTkpyTVlGMG11dTdNQUc3eHdPV1Z1eUI0VXdSZXE2SDY5Nmcr?=
 =?utf-8?B?VGgrK1hlN3ozY3ZPQm1HTWpGUW9NRnQ0WUg2RThyTkF2ZHNUMmxMNDRiUWNS?=
 =?utf-8?B?Z2w0ckNRTkZ5dlp4WVAxcEt6Vy85dlV6QWZXb09zd3RMcGNEMmxjTERudExY?=
 =?utf-8?B?Q2Y0aVdYY3JlVFJJWUxmQjB6R2JOTGtiK1BuR1lsU1hGY2JlL1RaZGVENkQr?=
 =?utf-8?B?a0lLaWMxblRCRUNxOEVNc1RGeHB4WlF6MVhKTTZGTkVBT0IwS2t5cDI0SmFy?=
 =?utf-8?B?bjdDMlpaUTdhNVpFdmt6WVdmeHRVTmhPemowU0pEbC94YTB0RzA3VElPMHVq?=
 =?utf-8?B?bXRRN0xHdzMyTElPMHZySmcyZXc4QjlVVlRlNmxqVmk3M3dlNXVHTUF0bDNs?=
 =?utf-8?B?ZE53VWh1aVJ0MUM1RVFKTktuYm04a0lRUldCajVmRXJhRUtIdWpTN0YyUldX?=
 =?utf-8?B?SXdra3pzUUlPc09VdWQvbUExTmlKLy9OUTlOc1lVRDFIVkdvb0pKZHF4NXZB?=
 =?utf-8?B?b3UzcFdiWWpGalFVays3c1p4YWhGZ0JuZXlyQlZPZFg2K2MxUzE1aEQ5S1ZX?=
 =?utf-8?B?Q1JrSit3TlFYNFdDWGQ2dmZhSDVnZGlrUXBVbS8rYXIzbDRRVi9DTVNpam1P?=
 =?utf-8?B?MC9nSExwN1VDeGNrZGp4WEl3dVN6bE5XTGZCQU5ZMGVON09mQWc1REtucGdB?=
 =?utf-8?B?UGZKL0dDRHJXQ09Vc2V5Q2ZVOGhZRzVVM2ErNmZTNzVWS1ZUbDdNNmN4Z0k2?=
 =?utf-8?B?UEc3TlBKRjM0eGppVHJsaW5BNmFSNFlpazhJYjVYbFpLMjhlZkZWblNmM2pz?=
 =?utf-8?B?b1dxaXk4R05iWXRiOGs5ZjdEcnVmb084MDZqeXBISDBLYUdxOU5zL243NDRH?=
 =?utf-8?B?T01vbXUvNzFWd2xMUWd2WU1pQ3JacTNwSG52NzhhKzRuNmFvR1Q3Ky9UNEtJ?=
 =?utf-8?B?WElkdEZMNjU2QUtTYkZVVDNMV21NWHhKeHZEYUFwd2dpSUZvZkpYS2l6a0Jl?=
 =?utf-8?B?VzVwem1IYlVPNGdrbU5FSDZrWU1HbC82dEFpMFo1b3NRZEUrTmREbmJyYm5x?=
 =?utf-8?B?MnBNdjZQOEV6VHRkaXRnbDFrbTY0MWFCZ2tLclZPdDlJZ1dIMk4xUjkvMW9S?=
 =?utf-8?B?dnI5MDkydWlvRkRLb29NcTRMby9OZ2VuUFRUd1h1YnE5Sy9KUjhuZXJjdHdM?=
 =?utf-8?B?TEE5ZnNRT2dXdFVIU0JXRXRhbVdIWnEvOEZUQktsQzZDdUtmSXNVZWNpbVFu?=
 =?utf-8?B?a0tQTENrbml5dHAyZHVSbkNsUzh5c3FEcVVPRmFNMG1xbEh5bmdhWWNmOE1C?=
 =?utf-8?B?cjNqRHFBODFORkFpakFMVlFJaW9KWnRlRWpKbTJGekJpQU9NTC9rMzFINXBW?=
 =?utf-8?Q?qYuuPbSfxoiQHfbZcAHG9y0+GC86SZmn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzlxMHR1TnNpWGc0VWZnMDFzTDUzYUZUSjNmZjVTeXA1Skp6UWhCNzJLY2hT?=
 =?utf-8?B?LzFrNDdEZFpNUUhtNERPRkxXOGh0ZzFLaDFLaGlZNTg0SUVnc1Bkb3c2WU5Q?=
 =?utf-8?B?VW5PQVdKNlhMNXpIbmZQdEV6cVJ5bXlNaUliTzZScFBwRkQ2UEVuN01obzlH?=
 =?utf-8?B?d081LzZqV2g4a1JyTTNja2hJTnBBRkFMQ05vNTZGcGJnd1BQOWJFZGo0SlVP?=
 =?utf-8?B?YjZzcEwrSVVWWUVJSDVhejhQc3l2ZzUwd0hvUlJRc2pURzc3eDhHMWRVZ2dw?=
 =?utf-8?B?SUVDdnVuRTFYc2tpblp3bjRBVmp0SHhVblhkMmxjL0NVVHp2TGxkblF0VUth?=
 =?utf-8?B?WnhSZ1VmMHptVDNrWktLdWdqbW13cnd2c1ZxY0hUbzRSbjhVZ3RKcW5tSmJt?=
 =?utf-8?B?TngyT2VFaU1hQWgzamZVWUZrRnB3eXQ0dDhVS2xBa3VNVm1BUHk2ZnM4ZW4w?=
 =?utf-8?B?QXIxRm9ON2NoMzRIaGdwNDREMmVSejBVbkVrOXJXQzVQMXVDM1hPK0hoZkhp?=
 =?utf-8?B?ZmhmWkhaU0RLL1R2MkZBa0FmSXBwdDRXSmZOYUFRKzZIUDlkRk5hSnNnVml0?=
 =?utf-8?B?QVpqNHNPU05ZMHhyenpRc3FDWE1CN2IrbUVQbEFKZWRmQURhSW04OWpxTnZh?=
 =?utf-8?B?d1lUdlRqeEZHZmJiWi9lNTNRTk4zMitCSDM5cVFndERtaEw4ODFpNGhPVTFL?=
 =?utf-8?B?NHdHaW96Z1BKNlhwOVQ2UVpmYWlHWkRCR2swd1RKWDNibWp2MzNHWVdTYjJn?=
 =?utf-8?B?U1lvVFE0OVFmSUdUaDVIU242WHV5bVRMVXlWQkNiK0QyREpEcnZxRzE2aGN6?=
 =?utf-8?B?ZzNYRjNTOFBMVTZzaHdIUTlpMXlhMmV6NmhRMDU1eDdVVGlxSnVDMjN1YXlh?=
 =?utf-8?B?QVptVWE2bUFwQ2h6a0hzNWdDNEZ1b0RmeEJkTHlRczRCRktNTGZNSHBCaVJC?=
 =?utf-8?B?SXhzbVQ3U3VCSk9aNnltMkpoTmlkY1lTU2twb2EwbEd1K3o0aEFyRFhXdmtY?=
 =?utf-8?B?SkxSQWMwRzRJNElBb0twbVlxUm9rMWVqM210dVpoWVJSNDE2Vk9ibGVxend0?=
 =?utf-8?B?dkxISVpTVG5UZDVXVkZMUDVjdmZwUmpKa3ZGZlY2L3NHRldWTDhOTEswSHFU?=
 =?utf-8?B?a0g0bE1FcE13aEZzQlZiVXZ0MEtnVHJFd2tNSHpsc2VLZGEvMFhoVjFxSEdw?=
 =?utf-8?B?WW1WdWNwQ3BFR243OXlUZ3pqTWtJb2xqbXl0RmYvaGxueG9PVUh4REdXZnJm?=
 =?utf-8?B?dWZPazAwdjNIM1BjSkw2b1IwZjlsVngySDN5QXNGSkxiYytoWUsyRDFaRXM0?=
 =?utf-8?B?dWQ0TEdoRUZzTFk5NGNTWXlrZTVzMzNvbktaZk1ZdWFIbG1rRHM4Wi95a1cw?=
 =?utf-8?B?UUV0MGhyS1d3RjJxUFVobmtvMWpqUmMydmFxZjBZSkxsWmhOOFZNSXg1aHVT?=
 =?utf-8?B?YklINGhSbzZrQkdhbnJ0Z3hOdzU3ZWprK3o0N2M1bTZOYjNhanpWcFJhWnRX?=
 =?utf-8?B?MFNDRE9RK1pLR0ZoS2pxYUNtUEtCTEdLNGVUbzdrU2kwRTE1TjV6aWZUamdz?=
 =?utf-8?B?SkViVHNwdVVGbFo5NDlSSk9Pam9IQWJnaXUwU3l4ZVNVMTRFUnRtRVBGS2ZS?=
 =?utf-8?B?eVFJS0NBT29sR2dxZjI2bXR3clQ5d0VYcHBhT0FoSWQ3MHVuNTQxTGRncFp5?=
 =?utf-8?B?a3dCd05WTEx1OGlPZWZkYmJ3d25HOFEzdzFNTVBMcHpPbzRWUDA3b1ZjZWVG?=
 =?utf-8?B?SjZ1V3JmeGJiNXAwTjVGeDdpeUs1eHRYRUNBZi9GMFYxbE0wdmlOVk5ZNUJ1?=
 =?utf-8?B?TmFHdnFpYVJpdDJoc1YyeEY5emZnY3JsRStKclFybGs4dzBYK3lnWVphVUE3?=
 =?utf-8?B?am1selF2ZHZDVkp2NlZlSWc3SHM4WlBmcklkMTNRcTJtbDBFQnRlVFVsWGE0?=
 =?utf-8?B?aDBQR1hUOSsvOFI0UG1URkhmMjk1OXpkcEFBclBaK3FMV3dOVXk5MUw3NFZ2?=
 =?utf-8?B?RlNjMVhIdElQKy94WklsczFTd3BCeTBUbUdCblIvSmdSam96c1RVS0NpTkVY?=
 =?utf-8?B?RFd0QkFXQ2lsQ1RMaFBncC9tcDBuUTlMbEVvTXFtc0hhbGREMVU1MnNvcFNl?=
 =?utf-8?Q?rXqM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 221adda2-7816-41c1-4fc5-08dd9ce48001
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 06:05:37.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3va90dVy7vdWYhmCM38e/KF51A06IuIGvynCjAOggzUWwLCD4E0hcjhTEr1cWeLagWStaLddsWBq+V70VlyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBzcGk6IGR0LWJpbmRpbmdzOiBjZG5zLHFzcGkt
bm9yOiBVcGRhdGUgbWluSXRlbXMvbWF4SXRlbXMNCj4gb2YgcmVzZXRzIGZvciBDYWRlbmNlIE9T
UEkgY29udHJvbGxlcg0KPg0KPiBPbiAyNi8wNS8yMDI1IDA5OjA3LCBNYWhhcGF0cmEsIEFtaXQg
S3VtYXIgd3JvdGU6DQo+ID4+PiAgICAtIGlmOg0KPiA+Pj4gQEAgLTEzMiwxMSArMTM5LDExIEBA
IHByb3BlcnRpZXM6DQo+ID4+PiAgICAgIG1heEl0ZW1zOiAxDQo+ID4+Pg0KPiA+Pj4gICAgcmVz
ZXRzOg0KPiA+Pj4gLSAgICBtaW5JdGVtczogMg0KPiA+Pj4gKyAgICBtaW5JdGVtczogMQ0KPiA+
Pg0KPiA+PiBJIHRoaW5rIHlvdSdyZSBzdGlsbCBtaXNzaW5nIG9uZSBvZiB0aGUgdGhpbmdzIEty
enlzenRvZiByZXF1ZXN0ZWQgb24NCj4gPj4gdjEsIGNvcyB5b3UgcmVkdWNlIG1pbkl0ZW1zIGZv
ciBhbGwgcGxhdGZvcm1zIHdpdGhvdXQgcmVzdHJpY3RpbmcgaXQNCj4gPj4gYmFjayB0byAyIGZv
ciBub24tdmVyc2FsIHBsYXRmb3Jtcy4NCj4gPg0KPiA+IEkgYmVsaWV2ZSB3ZSBjYW4gcmVtb3Zl
IHRoZSAicmVzZXRzIiBhbmQgY29ycmVzcG9uZGluZyAicmVzZXQtbmFtZXMiDQo+ID4gcHJvcGVy
dGllcyBmcm9tIGhlcmUsIGFzIHRoZWlyIGRlZmF1bHQgbWluSXRlbXMvbWF4SXRlbXMgYXJlIGFs
cmVhZHkNCj4gPiB0YWtlbiBjYXJlIG9mIGluIHRoZSBlbHNlIGJsb2NrIFsxXS4NCj4gPg0KPiA+
IFsxXQ0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iLzBmZjQxZGYx
Y2IyNjhmYzY5ZTcwM2EwOGE1N2VlMTQNCj4gPiBhZTk2N2QwY2EvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zJTJDcXNwaS1ub3IueWFtbCNMDQo+ID4gMzkNCj4gSSBk
b24ndCBzZWUgYW55dGhpbmcgZml4ZWQgdGhlcmUuDQoNClRoZSBpbnRlbnRpb24gd2FzIHRvIHBv
aW50IG91dCB0aGUgcmVkdW5kYW5jeSByZWxhdGVkIHRvIHRoZSAncmVzZXRzJyBhbmQNCidyZXNl
dC1uYW1lcycgcHJvcGVydGllcy4gQXQgWzFdLCB0aGUgZGVmYXVsdCBtaW5JdGVtcyBhbmQgbWF4
SXRlbXMgdmFsdWVzDQphcmUgYWxyZWFkeSBkZWZpbmVkIGZvciBhbGwgcGxhdGZvcm1zLiBIb3dl
dmVyLCB0aGUgc2FtZSBjb25zdHJhaW50cyBhcmUNCnJlZGVmaW5lZCBhdCBbMl0gd2l0aCBkaWZm
ZXJlbnQgbWluSXRlbXMgYW5kIG1heEl0ZW1zIHZhbHVlcyAsIGFnYWluDQphcHBseWluZyB0byBh
bGwgcGxhdGZvcm1zLiBCYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nLCB0aGUgZGVmaW5pdGlvbnMg
YXQNClsyXSBmb3IgJ3Jlc2V0cycgYW5kIHRoZSBjb3JyZXNwb25kaW5nICdyZXNldC1uYW1lcycg
Y2FuIGJlIHNhZmVseQ0KcmVtb3ZlZC4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxk
cy9saW51eC9ibG9iLzBmZjQxZGYxY2IyNjhmYzY5ZTcwM2EwOGE1N2VlMTRhZTk2N2QwY2EvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zJTJDcXNwaS1ub3IueWFtbCNM
NDENClsyXSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi8wZmY0MWRmMWNi
MjY4ZmM2OWU3MDNhMDhhNTdlZTE0YWU5NjdkMGNhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zcGkvY2RucyUyQ3FzcGktbm9yLnlhbWwjTDEzOQ0KDQpSZWdhcmRzLA0KQW1pdA0K
DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

