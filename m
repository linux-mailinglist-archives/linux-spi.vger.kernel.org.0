Return-Path: <linux-spi+bounces-10986-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30684C2F124
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BA4D34CF51
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069B2741A6;
	Tue,  4 Nov 2025 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aubhFkEj"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1A2727F3;
	Tue,  4 Nov 2025 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225648; cv=fail; b=QgfnvG+JfzMDSXrleMGOAND1/OVHFaa99oTzdA+TyPc4xs6V3Tq3L5DDkWzp/o/fjCijCkpWmvDogT8ud1mpkpECap2obfYgU+Gg4cGOOk+Q+2xLXs0Dxax4Vvc94SN4zC39y0Nn7MQy+8nrwQq4+zgL17bRT6coGm7vYmfEtrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225648; c=relaxed/simple;
	bh=O4H9Xt7hvUH24pdTYtgQtceTm+F+5xT3MOp9F07+XQk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T4d7RUf2bMoY/9P8Ds5UV2Dr5B8/b7rbiRUadHTgRVgEPlzYh7OD+1n5sRGk7IZA7onsoC5XANKed7k6tpQXZhLxpy7LiI2YvFEElaSgqkyQS3iiwDSjrlJHhXbI5AuKcKrBlWUvZwej5rCj0Ckq0cpIce0UyU6Iodo3enmsd90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aubhFkEj; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxyZ72jL+YasXFnBvnVAkVT8pem7fSsRCuXq92Dnr+C/NixX6edTaAbuSbzx6db8zYtgd8+ByiBGWb3N+QifDaCsxg0/XLjrEAvBUOIpigglD8JLSco7K59XnSDpgz4Xtm3OMz9dXFp5FOg75eJ9QumF9+ZA0VWkc9x1EtOxEkmCZH3hPj6PKlujnOlo9s7OepVEy89ON5Tyx2jegA8OuPqKstraZ56/00k2/BMtrttEqb5ASMulmj42TzutYptsWRZuHoH7QpEbi2LPNbA7EsGYLQlewKQuo5bNcj82JDw/Zy4QKQDrVlSXzJgOMZtDuQLx3VSspftFY0eIuNxePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR4VD8W0nG3bvfqruf3iQlVqhcnkd6UBxyLs6bM948k=;
 b=qE4czTKPPDVp0sfjIZ4rbGYkESPKsuJE8Ix3D49Qm53rB/gih0ZP7rhGwoFmk42v3DtxlFpIj6OHKllIZ2RfPIOEay7AqBv6bmm7OCj/XT5q6dSctv4QTd9q4ggpOsfo0/L4U7ag4wAbKBEWufW9x2ttChI8qnKbVQXmEdAlUswTO3PEGb+OP9CYmF5lVgclXJZIcLDvBoStsSfV1TX98NA4tJLdAoyFPM6XiVN2ml1QF6DN4Ew5wNhkp+/ijWtbSze2P5EMEbOcOeeLKE2uv0V0Ws9XBKCOtCKLbEOny6vJYg0ali975qem4fukdCHL247bnNklrs5lnmxZQ2SL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR4VD8W0nG3bvfqruf3iQlVqhcnkd6UBxyLs6bM948k=;
 b=aubhFkEjTdKg8bxhK4zCSIKHN9gohI3tHrC5sA2rh7MAjp0v1IxRDlQ56AE11wEB24n+Kkkr1FhZiEgFbwRBFXx1bKFzHAcCvvhKlby0FQNq8ML878LZ6pwCzybIgtu50HKKVS1zlDQXcliHg5NCCR2MkEmuKGrbmN3fe9xAOytHTAyW8lWBg3x26Z6TWYGensyv5P0aNSu/8ngxYSNpEVrMxN7k5FABZizLVl/1tUTSOg+/JEE7KEbEIMHKRBsDg9eBDWnho3jRqz/d0kWzUZta3bOxSGa5D4/xT4+HmdPXvVe2BSco5MbAHtl/coOPIWP/Rx8U9Wsfog2q5U/rDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 03:07:22 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 03:07:21 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 04 Nov 2025 11:07:37 +0800
Subject: [PATCH 2/2] spi: add driver for NXP XSPI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-xspi-v1-2-1502847ade40@nxp.com>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
In-Reply-To: <20251104-xspi-v1-0-1502847ade40@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762225682; l=46375;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=O4H9Xt7hvUH24pdTYtgQtceTm+F+5xT3MOp9F07+XQk=;
 b=+8I+XO7Z87pN0DqCYm7qWOuJHc6p6Yjzp6UmsFugVkws9sT3ItcUwZKmyAQ8nmuYJkjIAJol5
 XFXw5nP02oiBmRyjdKbyxYg2N89/GlFEmCPNHr39wIHcm2LfEbbn1iX
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a2c382-fade-4f7d-1abd-08de1b4f4501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjl3cTdveG1MZ2l3cnJaQThZZXB3d1ZLZEdCSHp3NDBtdWUyQnQ2b0R2U2ZN?=
 =?utf-8?B?YWdNOVVGNjVSS25WV3VQRVFNL1JTSVdHVW9vOCsrTFM0bi8rM3FNWmpITDc4?=
 =?utf-8?B?M2xZdlRkaTZxdkpvYTZha3hhNkxVcHo1T1J0MFVJTDMrcnpSNm9uOFhOdDQ3?=
 =?utf-8?B?a0Y4Y0VZL3lVMHNHOFdjZDZCbFdCRWp6dG14Q1AzZnphdkdNTGdMZG11M3BP?=
 =?utf-8?B?WTVUd2ZCYzhqd0ZmYVpHT08rWEhhTTZaNkZ4SytBdWxLNmJaSUt2bGNBWXF2?=
 =?utf-8?B?bUY0SUFzQkw3ZGVvTTdjR2EvQ0lCdXJudks1YUM5a2t6WXBBM1RLOEZqVDRa?=
 =?utf-8?B?eXYzR3E4RVBUZUE2OUI4MkRUazlMZGd2eXpPeUZYM0RzZXlHa0RNVGZLbG9D?=
 =?utf-8?B?eWlEd3ZaeFZ2UkI4L04rZDdVUXBWR3NVUmhzVXJsZkRTdHNhOXE5NjdhaGxw?=
 =?utf-8?B?U21OWURQODA4aGVXRTN6OHBHM0QybERzb05GWVFzSUhiRGZ5Y3BkelN5MXdl?=
 =?utf-8?B?M0F3dy9sU2dvYjZTK3AyS05TTSswN0FRdjcxc0JhL2YrS2ZRSU92eTJpSTFm?=
 =?utf-8?B?WmJMeWRZdytxS0tRcmVIektVWktxZnVCenJUM1NvZmNhWXMwSGh0Z1N1bVdq?=
 =?utf-8?B?d05TNG52TWR0V0ptaGxlRzhPUXRtRi8rakMxNUc2R0J5RHhVM3lheHJTTU1s?=
 =?utf-8?B?UVlXYytVaS9DS0NkWlkxQnZDOWJnZHdYZURXa2NhbCthTndQb2Q3SExScjBO?=
 =?utf-8?B?aWJ5VHVCUE45NnBJMzdEQnl6dnc0MEF6aG4rY3lKbFhZaEs1TzVlcGpLZzF2?=
 =?utf-8?B?ajlmbnNEN0JnVmVtSE1PTWMySUUxQjNkQkVHNExnRGxVWDRkWGhBK0RvOGlS?=
 =?utf-8?B?V2FoVzNKb3hKRnQzQU9kYlVQRFhOOTFkN1J3eWNUWExRSWhwMU9mdHYzUTc3?=
 =?utf-8?B?b2tSUHJMdVByOXdSWjBLT295cjBoNSsxc2x0MVkvZ3FjQXpxdWZWdjJWVTN4?=
 =?utf-8?B?SUNraFl3dnBoM2ZFNklDblVKZUZJTFJwVlkvK0drdXdXa2hZSUZxRkZlWnN0?=
 =?utf-8?B?Y1FRSHdoZk5TcDFJbzZ2OGVTa3VWd2ZvQzlwM0xEdWp3Uy9pb3dzcVFjdTlh?=
 =?utf-8?B?M0lySTNIbmtGRzZLKzIvekpyMUt4MkRLL1pIczZ2b0YyT0NSYXplWm0weE9O?=
 =?utf-8?B?c2c2aHpoOHFjQUV2MStLUjRneGFwd1JVd1BXTlNiT3ZaNVRkdXJHcG5Obzd5?=
 =?utf-8?B?MHBWSEw0cFJNV29XOVdBSStWanJ3YWxlRlllSVlRVWhGTTBZNmIrYUpadDQw?=
 =?utf-8?B?Sm9aZkUySnQ2UnJHaVFoT2pOeWVGdjR2K292a1N6bGp0aU5HcUNJSXEzTEg0?=
 =?utf-8?B?WURaakhVTWgrNURvL0JnUG0xK3lyMWVuRDFjZVhiK3hza3ppdlhQOHBmL1Rv?=
 =?utf-8?B?SFlheFpTMEQydVNXSU5ESm11TmdsN2dtWTc1V2dRVERDSllGM2J5YlJKd1BI?=
 =?utf-8?B?UHc5cTdxMCtJSW10ekhDSGZoNTFJQnVjK2h6ZWNlMFlBeVo3d2ZNNnRscGNT?=
 =?utf-8?B?bUI3aTlVQXVkLzBTckxhNkQ2OHRaa2hXNFRZQzFRS1hHWWRrWXNSSytEbTh5?=
 =?utf-8?B?Y0RuRm5vOGc0aFY1bmVzY0Z4N01uTUV4QzVRb1RMWG9zbHVRaTlGUG0xTXJB?=
 =?utf-8?B?UDRMakRlT0NwaldnbmpSK0YwSEtPUk1pRkNUUEdaQ1daU3ZWM3BLQ2NLVmVj?=
 =?utf-8?B?bk1ySUpQeFZ3K3I0b2FQNU1QVTZWQkF2ZHJFam5MaC9IWGJYYStyUXREOE4x?=
 =?utf-8?B?NGRpQ3dpSFJOM0Y2R0Q5NVdSVUkxYThaQWxZQVdld2NLT05US1VkL2ZpMEVo?=
 =?utf-8?B?VEVUWnFSVzVmYlVrTWdlQmh4R3BFTmVFM2c5MitGdTV0NTFUTHVjNFZmSGVz?=
 =?utf-8?B?SmQxRVpNQkluMFNCU01hSWkyU0g4Y2srRnU0UHRSM0RKbng0Y21TZ2RXUFlS?=
 =?utf-8?B?Qk9Hb0kzWEs4cHJqV1BOeHc0cFNvOUV6TEZENW9TZ1JEUEVzeS9KZCtPcnFY?=
 =?utf-8?Q?RNfjzV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1RZK0hPZ09XdVdrcWF6bXNLZUZ3WXd4M0JyWVNEK3NIZVlYcEtyVzFKZTht?=
 =?utf-8?B?TmxYNERQOE9IcW9NTUVpaFRQTFVZT2pkZFRaejIrblEzZXhRU1I4Sk1Ec2k4?=
 =?utf-8?B?SFd4UXNPWnhNd0VxUE5EYUIrOTQrbWhlQ3Q1NFlYY3NXOEFLZjZaT2hBK3NZ?=
 =?utf-8?B?NEZadm9vVjNzS1d6UGs2bG1UQXRQblUrOGNLd0dkdHZtQ3MvbTI5MnFsTmhI?=
 =?utf-8?B?a3Z5QkZxSlFWblZTUWNPOEZ2RVpYdlBoeVNZeFY2ZFlOMWR2ZUtocVdSOStO?=
 =?utf-8?B?ekY1bENNcEZZMENNZlNJaGo0b0NZL3FYNWEwK0xWLzVRNzB1anFxeGwzZWZT?=
 =?utf-8?B?V3NnSnZObE1Pak5LZDBKK1F0YXQrM2NkMzkwNkUwYkdXd1hnQXZHU0RiVm5x?=
 =?utf-8?B?bThSQy9MalhkTWd4UGZPUmJUeXVDRXZ1RUs0Z21ybDMzOGpIVHhhNEtGRmFt?=
 =?utf-8?B?U0dCSVVDYTlrdHdqSUlqMkpEdG51SHJGYXljTXhMdStTQjdzUTVLSnlIR2NL?=
 =?utf-8?B?SW9SeVNoMUNOTENpRldTMWdWMzRKSHV6UnIybElJT2ZyZEZDTnR4L2d5WXMw?=
 =?utf-8?B?ZDhKV0IzRHRrWkxZblg5SXEvWmNEYS9uZkJ4d3hYeTVFbDk1c2Y4b3lSVVN6?=
 =?utf-8?B?V3JXdjJ5ODBGZE1zZmFPVzlHTCs4blJobHdsZjFYSUpnZk5XTk9ZM005WHVt?=
 =?utf-8?B?K1lhOHNVTDJNakZ2aHFlcGtXMlRidXZjNzBNTDRoR2NPRjBGbm9PeW05ekRs?=
 =?utf-8?B?RkVEYVNWUWcvMGFYdlE3eElPaFZGMndvVzRwbVZGQllxanFRWTArM0g5NTZF?=
 =?utf-8?B?YlpCMnBKRzhWNjJVV1R0ajA3SmsvQnc4T3puVE94Qm9jRHZLWGJ1WUlyWTFs?=
 =?utf-8?B?L2UxNVpHdXhnWnlTVmNSTGpraVpCZjNsbWFJOWU5MUt0T2wrQ2Q4OVIvNFNv?=
 =?utf-8?B?NGRyU0JzcG9pOVByTVh6ZE01d3ZJQWFPTW00YWxYYzNvMEFMRit6QUNPYUQ0?=
 =?utf-8?B?V3M2VnhoaWg1QjBjeWQrak1mdTdCZU1WaUtsN2dmeDl4TjJTb3ZBQnMyaDIr?=
 =?utf-8?B?Sm4yOHVleTFjREZCOXZCREtFWkxrVU9tR25Lc1ZkVFpMTmtDZ3UrMnpudWpN?=
 =?utf-8?B?RUxTcmZxYWd0MS9xckhKVFUwNUgxTjdYRFh4cWlnZzYrUnp1cFNxU05ZQWps?=
 =?utf-8?B?SEJVU3ZNVEpsQVRPbU84a0VCUU04cjlKS2toVlE4Z3NUVGdvYnJ6ZFlrbW1j?=
 =?utf-8?B?bDN5bGpBSGVQakhWOHpXVDRaOGs1bURnTFBmbXhiVFcyOW5udVNhUGp5My9o?=
 =?utf-8?B?MXhxVUVpOU1pRnJjZk94Y0VNdHFSNlpRQUlsSVRWbE1IS3BuTStuYVVRWmwz?=
 =?utf-8?B?RHBxeVNYR01XZW1aZjFOc1BrVEJIbVE4eThEb25BYTk0MWNVbHBSeUNYK3ZB?=
 =?utf-8?B?RE4rMU8vSVJiTVBORGZ2OG5NQWhSK0wzak55L3Uxd2R1eGZYZ0tQdjZWY1Ru?=
 =?utf-8?B?MStuVTdtMytNb2tkekprMjdBa0FhazBoa0dpTXFYTUhrWmhVTnZrYmhXR3lB?=
 =?utf-8?B?VGloTExmeUdoZEV4MFVwREZXV2RXV2xxZ2RycCsrOCtpUUdUZWRLc2w2Q2lW?=
 =?utf-8?B?cldYeWZ0SWFuUkZIdWRuUTIvN00yanBMSnhFbGtzMmJXamxXME1xdzluMWh1?=
 =?utf-8?B?Y20yZ3ZHODRORFdRSW1wUy9pUk41Tkw3MWhsc2szcitxdHhaSzhaSlI4bERL?=
 =?utf-8?B?b2xiSXpJcldnYWtqWFRjNllvUm8vcVJNK08wZlhzdUh1bk9IcU94WTc5SGdj?=
 =?utf-8?B?SlpZTEpZS3dXTnlld3lJSlUrMlRuQmpxNy96L0tod2hyQkdhaGtKbnI4S2Zv?=
 =?utf-8?B?U3ViME9pb1Y2eFNkOGFSemdDSDNNN2lqakU5c3JLOWg5TFVRZStKd08yS2c2?=
 =?utf-8?B?bFVQODdyYkRYVDgrbnpJeStkYkZyZi9Qa2x4K1didFNJanliY0t2M2pJMGo2?=
 =?utf-8?B?a1dJVjY4WEFhbE1WVTR3eTNXb1J1c0RJMjUrSnRKTWZxdUM0THVSTUVraFp0?=
 =?utf-8?B?RDBIM0h0VUtUS3lhNU5aNTA1VEFWSFljQ0g4WXdXaXNRbGxyYndyNzJZY3ox?=
 =?utf-8?Q?xGNemk0GV5lDPtf/WyN0bwMNP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a2c382-fade-4f7d-1abd-08de1b4f4501
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 03:07:21.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObjoWnTsMALIPJJjbcjpYuxb5M/LLf+MMB4z0FZw57MyrP8F27RbZjq2A+If8dVOTVZXQkAKcpmlI1blwREsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806

Add driver support for NXP XSPI controller.

XSPI is a flexsible SPI host controller which supports up to
2 external devices (2 CS). It support Single/Dual/Quad/Octal
mode data transfer.

The difference between XSPI and Flexspi is XSPI support
multiple independent execution environments (EENVs) for HW
virtualization with some limitations. Each EENV has its own
interrupt and its own set of programming registers that exists
in a specific offset range in the XSPI memory map.
The main environment (EENV0) address space contains all of the
registers for controlling EENV0 plus all of the general XSPI
control and programming registers. The register mnemonics for
the user environments (EENV1 to EENV4) have "_SUB_n" appended
to the mnemonic for the corresponding main-environment register.

Current driver based on EENV0, which means system already give
EENV0 right to linux.

This driver use SPI memory interface of the SPI framework to issue
flash memory operations. Tested this driver with mtd_debug and
UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
flash. NOw this driver has the following key features:
- Support up to OCT DDR mode
- Support AHB read
- Support IP read and IP write
- Support two CS

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 MAINTAINERS                |    1 +
 drivers/spi/Kconfig        |   10 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-nxp-xspi.c | 1430 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1442 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a47206cdb290b27ac6829d3a92289ca65d28d46..4a08d20a18509addcf6beb655b9a85ea4fa34925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18629,6 +18629,7 @@ L:	linux-spi@vger.kernel.org
 L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
+F:	drivers/spi/spi-nxp-xspi.c
 
 NXP FXAS21002C DRIVER
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d8f00c850c1453845680192007342221e80da86..f9e958e574ecb12f3fba75633c1206223cec820d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -480,6 +480,16 @@ config SPI_NXP_FLEXSPI
 	  This controller does not support generic SPI messages and only
 	  supports the high-level SPI memory interface.
 
+config SPI_NXP_XSPI
+        tristate "NXP xSPI controller"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This enables support for the xSPI controller. Up to two devices
+	  can be connected to one host.
+	  This controller does not support generic SPI messages and only
+	  supports the high-level SPI memory interface.
+
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8ff74a13faaa88399723f9e944f9198076c3e543..9323ba633780daadcce2b04f5492ae0647259211 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_SPI_WPCM_FIU)		+= spi-wpcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_FIU)		+= spi-npcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
 obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
+obj-$(CONFIG_SPI_NXP_XSPI)		+= spi-nxp-xspi.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
new file mode 100644
index 0000000000000000000000000000000000000000..4f60dc61baba5b09bf9949a6afd1a65d55a7ed83
--- /dev/null
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -0,0 +1,1430 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * NXP xSPI controller driver.
+ *
+ * Copyright 2025 NXP
+ *
+ * xSPI is a flexsible SPI host controller which supports single
+ * external devices. This device can have up to eight bidirectional
+ * data lines, this means xSPI support Single/Dual/Quad/Octal mode
+ * data transfer (1/2/4/8 bidirectional data lines).
+ *
+ * xSPI controller is driven by the LUT(Look-up Table) registers
+ * LUT registers are a look-up-table for sequences of instructions.
+ * A valid sequence consists of five LUT registers.
+ * Maximum 16 LUT sequences can be programmed simultaneously.
+ *
+ * LUTs are being created at run-time based on the commands passed
+ * from the spi-mem framework, thus using single LUT index.
+ *
+ * Software triggered Flash read/write access by IP Bus.
+ *
+ * Memory mapped read access by AHB Bus.
+ *
+ * Based on SPI MEM interface and spi-nxp-fspi.c driver.
+ *
+ * Author:
+ *     Haibo Chen <haibo.chen@nxp.com>
+ * Co-author:
+ *     Han Xu <han.xu@nxp.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+/* Runtime pm timeout */
+#define XSPI_RPM_TIMEOUT 50	/* 50ms */
+/*
+ * The driver only uses one single LUT entry, that is updated on
+ * each call of exec_op(). Index 0 is preset at boot with a basic
+ * read operation, so let's use the last entry (15).
+ */
+#define	XSPI_SEQID_LUT			15
+
+#define XSPI_MCR			0x0
+#define XSPI_MCR_CKN_FA_EN		BIT(26)
+#define XSPI_MCR_DQS_FA_SEL(x)		((x) << 24)
+#define XSPI_MCR_DQS_FA_SEL_MASK	(BIT(24) | BIT(25))
+#define XSPI_MCR_ISD3FA			BIT(17)
+#define XSPI_MCR_ISD2FA			BIT(16)
+#define XSPI_MCR_DOZE			BIT(15)
+#define XSPI_MCR_MDIS			BIT(14)
+#define XSPI_MCR_DLPEN			BIT(12)
+#define XSPI_MCR_CLR_TXF		BIT(11)
+#define XSPI_MCR_CLR_RXF		BIT(10)
+#define XSPI_MCR_IPS_TG_RST		BIT(9)
+#define XSPI_MCR_VAR_LAT_EN		BIT(8)
+#define XSPI_MCR_DDR_EN			BIT(7)
+#define XSPI_MCR_DQS_EN			BIT(6)
+#define XSPI_MCR_DQS_LAT_EN		BIT(5)
+#define XSPI_MCR_DQS_OUT_EN		BIT(4)
+#define XSPI_MCR_END_CFG(x)		((x) << 2)
+#define XSPI_MCR_END_CFG_MASK		(BIT(2) | BIT(3))
+#define XSPI_MCR_SWRSTHD		BIT(1)
+#define XSPI_MCR_SWRSTSD		BIT(0)
+
+#define XSPI_IPCR			0x8
+#define XSPI_IPCR_SEQID(x)		((x) << 24)
+#define XSPI_IPCR_IDATSZ(x)		((x) << 0)
+
+#define XSPI_FLSHCR			0xC
+#define XSPI_FLSHCR_TDH(x)		((x) << 16)
+#define XSPI_FLSHCR_TDH_MASK		(BIT(16) | BIT(17))
+#define XSPI_FLSHCR_TCSH(x)		((x) << 8)
+#define XSPI_FLSHCR_TCSS(x)		((x) << 0)
+
+#define XSPI_BUF0CR			0x10
+#define XSPI_BUF1CR			0x14
+#define XSPI_BUF2CR			0x18
+#define XSPI_BUF3CR			0x1C
+#define XSPI_BUF3CR_ALLMST		BIT(31)
+#define XSPI_BUF3CR_ADATSZ_MASK		0x0003FF00
+#define XSPI_BUF3CR_ADATSZ(x)		((x) << 8)
+#define XSPI_BUF3CR_MSTRID(x)		((x) << 0)
+
+#define XSPI_BFGENCR			0x20
+#define XSPI_BFGENCR_SEQID_WR(x)	((x) << 28)
+#define XSPI_BFGENCR_ALIGN(x)		((x) << 22)
+#define XSPI_BFGENCR_PPWF_CLR		BIT(20)
+#define XSPI_BFGENCR_WR_FLUSH_EN	BIT(21)
+#define XSPI_BFGENCR_SEQID_WR_EN	BIT(17)
+#define XSPI_BFGENCR_SEQID(x)		((x) << 12)
+
+#define XSPI_BUF0IND			0x30
+#define XSPI_BUF1IND			0x34
+#define XSPI_BUF2IND			0x38
+
+#define XSPI_DLLCRA			0x60
+#define XSPI_DLLCRA_DLLEN		BIT(31)
+#define XSPI_DLLCRA_FREQEN		BIT(30)
+#define XSPI_DLLCRA_DLL_REFCNTR(x)	((x) << 24)
+#define XSPI_DLLCRA_DLLRES(x)		((x) << 20)
+#define XSPI_DLLCRA_SLV_FINE_OFFSET(x)	((x) << 16)
+#define XSPI_DLLCRA_SLV_DLY_OFFSET(x)	((x) << 12)
+#define XSPI_DLLCRA_SLV_DLY_COARSE(x)	((x) << 8)
+#define XSPI_DLLCRA_SLV_DLY_FINE(x)	((x) << 5)
+#define XSPI_DLLCRA_DLL_CDL8		BIT(4)
+#define XSPI_DLLCRA_SLAVE_AUTO_UPDT	BIT(3)
+#define XSPI_DLLCRA_SLV_EN		BIT(2)
+#define XSPI_DLLCRA_SLV_DLL_BYPASS	BIT(1)
+#define XSPI_DLLCRA_SLV_UPD		BIT(0)
+
+#define XSPI_SFAR			0x100
+
+#define XSPI_SFACR			0x104
+#define XSPI_SFACR_FORCE_A10		BIT(22)
+#define XSPI_SFACR_WA_4B_EN		BIT(21)
+#define XSPI_SFACR_CAS_INTRLVD		BIT(20)
+#define XSPI_SFACR_RX_BP_EN		BIT(18)
+#define XSPI_SFACR_BYTE_SWAP		BIT(17)
+#define XSPI_SFACR_WA			BIT(16)
+#define XSPI_SFACR_PPWB(x)		((x) << 8)
+#define XSPI_SFACR_CAS(x)		((x) << 0)
+#define XSPI_SFACR_CAS_MASK		0xF
+
+#define XSPI_SMPR			0x108
+#define XSPI_SMPR_DLLFSMPFA(x)		((x) << 24)
+#define XSPI_SMPR_FSDLY			BIT(6)
+#define XSPI_SMPR_FSPHS			BIT(5)
+
+#define XSPI_RBSR			0x10C
+#define XSPI_RBSR_RDCTR(x)		((x) << 16)
+#define XSPI_RBSR_RDBFL(x)		((x) << 0)
+
+#define XSPI_RBCT			0x110
+#define XSPI_RBCT_WMRK(x)		((x) << 0)
+
+#define XSPI_DLLSR			0x12C
+#define XSPI_DLLSR_DLLA_LOCK		BIT(15)
+#define XSPI_DLLSR_SLVA_LOCK		BIT(14)
+#define XSPI_DLLSR_DLLA_RANGE_ERR	BIT(13)
+#define XSPI_DLLSR_DLLA_FINE_UNDERFLOW	BIT(12)
+#define XSPI_DLLSR_DLLA_SLV_FINE_VAL4(x)	((x) << 4)
+#define XSPI_DLLSR_DLLA_SLV_COARSE_VAL(x)	((x) << 0)
+
+#define XSPI_TBSR			0x150
+#define XSPI_TBSR_TRCTR_SHIFT		16
+#define XSPI_TBSR_TRBFL_SHIFT		0
+#define XSPI_TBDR			0x154
+#define XSPI_TBDR_TXDATA_SHIFT		0
+#define XSPI_TBCT			0x158
+#define XSPI_TBCT_WMRK(x)		((x) << 0)
+
+#define XSPI_SR				0x15C
+#define XSPI_SR_TXFULL			BIT(27)
+#define XSPI_SR_TXDMA			BIT(26)
+#define XSPI_SR_TXWA			BIT(25)
+#define XSPI_SR_TXNE			BIT(24)
+#define XSPI_SR_RXDMA			BIT(23)
+#define XSPI_SR_ARB_STATE_LENGTH	3
+#define XSPI_SR_ARB_STATE_SHIFT		20
+#define XSPI_SR_RXFULL			BIT(19)
+#define XSPI_SR_RXWE			BIT(16)
+#define XSPI_SR_ARB_LCK			BIT(15)
+#define XSPI_SR_AHBnFUL_SHIFT		11
+#define XSPI_SR_AHBnNE_SHIFT		7
+#define XSPI_SR_AHBTRN			BIT(6)
+#define XSPI_SR_AWRACC			BIT(4)
+#define XSPI_SR_AHB_ACC			BIT(2)
+#define XSPI_SR_IP_ACC			BIT(1)
+#define XSPI_SR_BUSY			BIT(0)
+
+#define XSPI_FR				0x160
+#define XSPI_FR_DLPFF			BIT(31)
+#define XSPI_FR_DLLABRT			BIT(28)
+#define XSPI_FR_TBFF			BIT(27)
+#define XSPI_FR_TBUF			BIT(26)
+#define XSPI_FR_DLLUNLCK		BIT(24)
+#define XSPI_FR_ILLINE			BIT(23)
+#define XSPI_FR_RBOF			BIT(17)
+#define XSPI_FR_RBDF			BIT(16)
+#define XSPI_FR_AAEF			BIT(15)
+#define XSPI_FR_AITEF			BIT(14)
+#define XSPI_FR_AIBSEF			BIT(13)
+#define XSPI_FR_ABOF			BIT(12)
+#define XSPI_FR_CRCAEF			BIT(10)
+#define XSPI_FR_PPWF			BIT(8)
+#define XSPI_FR_IPIEF			BIT(6)
+#define XSPI_FR_IPEDERR			BIT(5)
+#define XSPI_FR_PERFOVF			BIT(2)
+#define XSPI_FR_RDADDR			BIT(1)
+#define XSPI_FR_TFF			BIT(0)
+
+#define XSPI_RSER			0x164
+#define XSPI_RSER_TFIE			BIT(0)
+
+#define XSPI_SFA1AD			0x180
+#define XSPI_SFA1AD_TPAD(x)		((x) << 10)
+
+#define XSPI_SFA2AD			0x184
+#define XSPI_SFA2AD_TPAD(x)		((x) << 10)
+
+#define XSPI_RBDR0			0x200
+
+#define XSPI_LUTKEY			0x300
+#define XSPI_LUT_KEY_VAL		(0x5AF05AF0UL)
+
+#define XSPI_LCKCR			0x304
+#define XSPI_LOKCR_LOCK			BIT(0)
+#define XSPI_LOKCR_UNLOCK		BIT(1)
+
+#define XSPI_LUT			0x310
+#define XSPI_LUT_OFFSET			(XSPI_SEQID_LUT * 5 * 4)
+#define XSPI_LUT_REG(idx) \
+	(XSPI_LUT + XSPI_LUT_OFFSET + (idx) * 4)
+
+#define XSPI_MCREXT			0x4FC
+#define XSPI_MCREXT_RST			(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
+
+#define XSPI_FRAD0_WORD2		0x808
+#define XSPI_FRAD0_WORD2_MD0ACP_MASK	0x7
+#define XSPI_FRAD0_WORD2_MD0ACP(x)	((x) << 0)
+
+#define XSPI_FRAD0_WORD3		0x80C
+#define XSPI_FRAD0_WORD3_VLD		BIT(31)
+
+#define XSPI_TG0MDAD			0x900
+#define XSPI_TG0MDAD_VLD		BIT(31)
+#define XSPI_TG1MDAD			0x910
+
+#define XSPI_MGC			0x920
+#define XSPI_MGC_GVLD			BIT(31)
+#define XSPI_MGC_GVLDMDAD		BIT(29)
+#define XSPI_MGC_GVLDFRAD		BIT(27)
+
+#define XSPI_MTO			0x928
+
+#define XSPI_ERRSTAT			0x938
+#define XSPI_INT_EN			0x93C
+
+#define XSPI_SFP_TG_IPCR		0x958
+#define XSPI_SFP_TG_IPCR_SEQID(x)	((x) << 24)
+#define XSPI_SFP_TG_IPCR_ARB_UNLOCK	BIT(23)
+#define XSPI_SFP_TG_IPCR_ARB_LOCK	BIT(22)
+#define XSPI_SFP_TG_IPCR_IDATSZ(x)	((x) << 0)
+
+#define XSPI_SFP_TG_SFAR 0x95C
+
+/* Register map end */
+
+/********* XSPI CMD definitions ***************************/
+#define LUT_STOP	0x00
+#define LUT_CMD_SDR	0x01
+#define LUT_ADDR_SDR	0x02
+#define LUT_DUMMY	0x03
+#define LUT_MODE8_SDR	0x04
+#define LUT_MODE2_SDR	0x05
+#define LUT_MODE4_SDR	0x06
+#define LUT_READ_SDR	0x07
+#define LUT_WRITE_SDR	0x08
+#define LUT_JMP_ON_CS	0x09
+#define LUT_ADDR_DDR	0x0A
+#define LUT_MODE8_DDR	0x0B
+#define LUT_MODE2_DDR	0x0C
+#define LUT_MODE4_DDR	0x0D
+#define LUT_READ_DDR	0x0E
+#define LUT_WRITE_DDR	0x0F
+#define LUT_DATA_LEARN	0x10
+#define LUT_CMD_DDR	0x11
+#define LUT_CADDR_SDR	0x12
+#define LUT_CADDR_DDR	0x13
+#define JMP_TO_SEQ	0x14
+
+#define XSPI_64BIT_LE	0x3
+/*
+ * Calculate number of required PAD bits for LUT register.
+ *
+ * The pad stands for the number of IO lines [0:7].
+ * For example, the octal read needs eight IO lines,
+ * so you should use LUT_PAD(8). This macro
+ * returns 3 i.e. use eight (2^3) IP lines for read.
+ */
+#define LUT_PAD(x) (fls(x) - 1)
+
+/*
+ * Macro for constructing the LUT entries with the following
+ * register layout:
+ *
+ *  ---------------------------------------------------
+ *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
+ *  ---------------------------------------------------
+ */
+#define PAD_SHIFT		8
+#define INSTR_SHIFT		10
+#define OPRND_SHIFT		16
+
+/* Macros for constructing the LUT register. */
+#define LUT_DEF(idx, ins, pad, opr)			  \
+	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
+	(opr)) << (((idx) % 2) * OPRND_SHIFT))
+
+#define NXP_XSPI_MIN_IOMAP	SZ_4M
+#define NXP_XSPI_MAX_CHIPSELECT		2
+#define POLL_TOUT		5000
+
+/* Access flash memory using IP bus only */
+#define XSPI_QUIRK_USE_IP_ONLY	BIT(0)
+
+struct nxp_xspi_devtype_data {
+	unsigned int rxfifo;
+	unsigned int txfifo;
+	unsigned int ahb_buf_size;
+	unsigned int quirks;
+	bool little_endian;
+};
+
+static struct nxp_xspi_devtype_data imx94_data = {
+	.rxfifo = SZ_512,       /* (128 * 4 bytes)  */
+	.txfifo = SZ_1K,        /* (256 * 4 bytes)  */
+	.ahb_buf_size = SZ_4K,  /* (1024 * 4 bytes)  */
+	.little_endian = true,  /* little-endian    */
+};
+
+struct nxp_xspi {
+	void __iomem *iobase;
+	void __iomem *ahb_addr;
+	u32 memmap_phy;
+	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
+	struct clk *clk;
+	struct device *dev;
+	struct completion c;
+	struct nxp_xspi_devtype_data *devtype_data;
+	struct mutex lock;
+	int selected;
+#define XSPI_DTR_PROTO		BIT(0)
+	int flags;
+	/* Save the previous operation clock rate */
+	unsigned long pre_op_rate;
+	/* The max clock rate xspi supported output to device */
+	unsigned long support_max_rate;
+};
+
+static inline int needs_ip_only(struct nxp_xspi *xspi)
+{
+	return xspi->devtype_data->quirks & XSPI_QUIRK_USE_IP_ONLY;
+}
+
+/*
+ * R/W functions for big- or little-endian registers:
+ * The xSPI controller's endianness is independent of
+ * the CPU core's endianness. So far, although the CPU
+ * core is little-endian the xSPI controller can use
+ * big-endian or little-endian.
+ */
+static void xspi_writel(struct nxp_xspi *xspi, u32 val, void __iomem *addr)
+{
+	if (xspi->devtype_data->little_endian)
+		iowrite32(val, addr);
+	else
+		iowrite32be(val, addr);
+}
+
+static u32 xspi_readl(struct nxp_xspi *xspi, void __iomem *addr)
+{
+	if (xspi->devtype_data->little_endian)
+		return ioread32(addr);
+	else
+		return ioread32be(addr);
+}
+
+static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id)
+{
+	struct nxp_xspi *xspi = dev_id;
+	u32 reg;
+
+	/* Clear interrupt */
+	reg = xspi_readl(xspi, xspi->iobase + XSPI_FR);
+	xspi_writel(xspi, XSPI_FR_TFF, xspi->iobase + XSPI_FR);
+
+	if (reg & XSPI_FR_TFF)
+		complete(&xspi->c);
+
+	return IRQ_HANDLED;
+}
+
+static int nxp_xspi_check_buswidth(struct nxp_xspi *xspi, u8 width)
+{
+	return (is_power_of_2(width) && width <= 8) ? 0 : -EOPNOTSUPP;
+}
+
+static bool nxp_xspi_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	int ret;
+
+	ret = nxp_xspi_check_buswidth(xspi, op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of address bytes should be equal to or less than 4 bytes.
+	 */
+	if (op->addr.nbytes > 4)
+		return false;
+
+	/* Max 32 dummy clock cycles supported */
+	if (op->dummy.buswidth &&
+	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+		return false;
+
+	if (needs_ip_only(xspi) && op->data.dir == SPI_MEM_DATA_IN &&
+	    op->data.nbytes > xspi->devtype_data->rxfifo)
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT &&
+			op->data.nbytes > xspi->devtype_data->txfifo)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+/* Instead of busy looping, invoke readl_poll_timeout functionality. */
+static int xspi_readl_poll_tout(struct nxp_xspi *xspi, void __iomem *base,
+				u32 mask, u32 delay_us,
+				u32 timeout_us, bool c)
+{
+	u32 reg;
+
+	if (!xspi->devtype_data->little_endian)
+		mask = (__force u32)cpu_to_be32(mask);
+
+	if (c)
+		return readl_poll_timeout(base, reg, (reg & mask),
+					  delay_us, timeout_us);
+	else
+		return readl_poll_timeout(base, reg, !(reg & mask),
+					  delay_us, timeout_us);
+}
+
+static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	u32 lutval[5] = {};
+	int lutidx = 1, i;
+
+	/* cmd */
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_SDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
+
+	/* Addr bytes */
+	if (op->addr.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR_SDR,
+					      LUT_PAD(op->addr.buswidth),
+					      op->addr.nbytes * 8);
+		lutidx++;
+	}
+
+	/* Dummy bytes, if needed */
+	if (op->dummy.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+					      LUT_PAD(op->data.buswidth),
+					      op->dummy.nbytes * 8 /
+						/* need distinguish ddr mode */
+					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
+		lutidx++;
+	}
+
+	/* Read/Write data bytes */
+	if (op->data.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx,
+					      op->data.dir == SPI_MEM_DATA_IN ?
+					      (op->data.dtr ? LUT_READ_DDR : LUT_READ_SDR) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_WRITE_SDR),
+					      LUT_PAD(op->data.buswidth),
+					      0);
+		lutidx++;
+	}
+
+	/* Stop condition. */
+	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
+
+	/* Unlock LUT */
+	xspi_writel(xspi, XSPI_LUT_KEY_VAL, xspi->iobase + XSPI_LUTKEY);
+	xspi_writel(xspi, XSPI_LOKCR_UNLOCK, xspi->iobase + XSPI_LCKCR);
+
+	/* Fill LUT */
+	for (i = 0; i < ARRAY_SIZE(lutval); i++)
+		xspi_writel(xspi, lutval[i], base + XSPI_LUT_REG(i));
+
+	dev_dbg(xspi->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x 4:%08x], size: 0x%08x\n",
+		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], lutval[4],
+		op->data.nbytes);
+
+	/* Lock LUT */
+	xspi_writel(xspi, XSPI_LUT_KEY_VAL, xspi->iobase + XSPI_LUTKEY);
+	xspi_writel(xspi, XSPI_LOKCR_LOCK, xspi->iobase + XSPI_LCKCR);
+}
+
+static int nxp_xspi_clk_prep_enable(struct nxp_xspi *xspi)
+{
+
+	return clk_prepare_enable(xspi->clk);
+
+}
+
+static int nxp_xspi_clk_disable_unprep(struct nxp_xspi *xspi)
+{
+	clk_disable_unprepare(xspi->clk);
+
+	return 0;
+}
+
+static void nxp_xspi_disable_ddr(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Disable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	reg &= ~XSPI_MCR_DDR_EN;
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	/* Use dummy pad loopback mode to sample data */
+	reg |= XSPI_MCR_DQS_FA_SEL(1);
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+	xspi->support_max_rate = 133000000;
+
+	reg = xspi_readl(xspi, base + XSPI_FLSHCR);
+	reg &= ~XSPI_FLSHCR_TDH_MASK;
+	xspi_writel(xspi, reg, base + XSPI_FLSHCR);
+
+	/* Select sampling at inverted clock */
+	reg = XSPI_SMPR_DLLFSMPFA(0) | XSPI_SMPR_FSPHS;
+	xspi_writel(xspi, reg, base + XSPI_SMPR);
+
+	/* Enable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+}
+
+static void nxp_xspi_enable_ddr(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Disable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	reg |= XSPI_MCR_DDR_EN;
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	/* Use external dqs to sample data */
+	reg |= XSPI_MCR_DQS_FA_SEL(3);
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+	xspi->support_max_rate = 200000000;
+
+	reg = xspi_readl(xspi, base + XSPI_FLSHCR);
+	reg |= XSPI_FLSHCR_TDH(1);
+	xspi_writel(xspi, reg, base + XSPI_FLSHCR);
+
+	reg = XSPI_SMPR_DLLFSMPFA(4);
+	xspi_writel(xspi, reg, base + XSPI_SMPR);
+
+	/* Enable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+}
+
+static void nxp_xspi_sw_reset(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	bool mdis_flag = false;
+	u32 reg;
+	int ret;
+
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+
+	/*
+	 * Per RM, when reset SWRSTSD and SWRSTHD, XSPI must be
+	 * enabled (MDIS = 0).
+	 * So if MDIS is 1, should clear it before assert SWRSTSD
+	 * and SWRSTHD.
+	 */
+	if (reg & XSPI_MCR_MDIS) {
+		reg &= ~XSPI_MCR_MDIS;
+		xspi_writel(xspi, reg, base + XSPI_MCR);
+		mdis_flag = true;
+	}
+
+	/* Software reset for AHB domain and Serial flash memory domain */
+	reg |= XSPI_MCR_SWRSTHD | XSPI_MCR_SWRSTSD;
+	/* Software Reset for IPS Target Group Queue 0 */
+	reg |= XSPI_MCR_IPS_TG_RST;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	/* IPS_TG_RST will self-clear to 0 once IPS_TG_RST complete */
+	ret = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
+				   XSPI_MCR_IPS_TG_RST, 100, 5000, false);
+	if (ret == -ETIMEDOUT)
+		dev_warn(xspi->dev, "XSPI_MCR_IPS_TG_RST do not self-clear in 5ms!");
+
+	/*
+	 * Per RM, must wait for at least three system cycles and
+	 * three flash cycles after changing the value of reset field.
+	 * delay 5us for safe.
+	 */
+	udelay(5);
+
+	/*
+	 * Per RM, before dessert SWRSTSD and SWRSTHD, XSPI must be
+	 * disabled (MIDS = 1).
+	 */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	/* deassert software reset */
+	reg &= ~(XSPI_MCR_SWRSTHD | XSPI_MCR_SWRSTSD);
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	/*
+	 * Per RM, must wait for at least three system cycles and
+	 * three flash cycles after changing the value of reset field.
+	 * delay 5us for safe.
+	 */
+	udelay(5);
+
+	/* Re-enable XSPI if it is enabled at beginning */
+	if (!mdis_flag) {
+		reg &= ~XSPI_MCR_MDIS;
+		xspi_writel(xspi, reg, base + XSPI_MCR);
+	}
+}
+
+static void nxp_xspi_dll_bypass(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	int ret;
+	u32 reg;
+
+	nxp_xspi_sw_reset(xspi);
+
+	xspi_writel(xspi, 0, base + XSPI_DLLCRA);
+
+	/* Set SLV EN first */
+	reg = XSPI_DLLCRA_SLV_EN;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	reg = XSPI_DLLCRA_FREQEN | XSPI_DLLCRA_SLV_DLY_COARSE(0) |
+		XSPI_DLLCRA_SLV_EN | XSPI_DLLCRA_SLV_DLL_BYPASS;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	ret = xspi_readl_poll_tout(xspi, base + XSPI_DLLSR,
+						XSPI_DLLSR_SLVA_LOCK, 0,
+						POLL_TOUT, true);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL SLVA unlock, the DLL status is %x, need to check!\n",
+			xspi_readl(xspi, base + XSPI_DLLSR));
+}
+
+static void nxp_xspi_dll_auto(struct nxp_xspi *xspi, unsigned long rate)
+{
+	void __iomem *base = xspi->iobase;
+	int ret;
+	u32 reg;
+
+	nxp_xspi_sw_reset(xspi);
+
+	xspi_writel(xspi, 0, base + XSPI_DLLCRA);
+
+	/* Set SLV EN first */
+	reg = XSPI_DLLCRA_SLV_EN;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	reg = XSPI_DLLCRA_DLL_REFCNTR(2) | XSPI_DLLCRA_DLLRES(8) |
+		XSPI_DLLCRA_SLAVE_AUTO_UPDT | XSPI_DLLCRA_SLV_EN;
+	if (rate > 133000000)
+		reg |= XSPI_DLLCRA_FREQEN;
+
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_DLLEN;
+	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
+
+	ret = xspi_readl_poll_tout(xspi, base + XSPI_DLLSR,
+						XSPI_DLLSR_DLLA_LOCK, 0,
+						POLL_TOUT, true);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL unlock, the DLL status is %x, need to check!\n",
+			xspi_readl(xspi, base + XSPI_DLLSR));
+	else
+		ret = xspi_readl_poll_tout(xspi, base + XSPI_DLLSR,
+						XSPI_DLLSR_SLVA_LOCK, 0,
+						POLL_TOUT, true);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL SLVA unlock, the DLL status is %x, need to check!\n",
+			xspi_readl(xspi, base + XSPI_DLLSR));
+
+}
+
+static void nxp_xspi_select_mem(struct nxp_xspi *xspi, struct spi_device *spi,
+				const struct spi_mem_op *op)
+{
+	/* xspi only support one DTR mode: 8D-8D-8D */
+	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
+	unsigned long root_clk_rate, rate;
+	uint64_t cs0_top_address;
+	uint64_t cs1_top_address;
+	u32 reg;
+	int ret;
+
+	/*
+	 * Return when following condition all meet,
+	 * 1, if previously selected target device is same as current
+	 *    requested target device.
+	 * 2, the DTR or STR mode do not change.
+	 * 3, previous operation max rate equals current one.
+	 *
+	 * For other case, need to re-config.
+	 */
+	if (xspi->selected == spi_get_chipselect(spi, 0) &&
+	    (!!(xspi->flags & XSPI_DTR_PROTO) == op_is_dtr) &&
+	    (xspi->pre_op_rate == op->max_freq))
+		return;
+
+	if (op_is_dtr) {
+		nxp_xspi_enable_ddr(xspi);
+		xspi->flags |= XSPI_DTR_PROTO;
+	} else {
+		nxp_xspi_disable_ddr(xspi);
+		xspi->flags &= ~XSPI_DTR_PROTO;
+	}
+	rate = min(xspi->support_max_rate, op->max_freq);
+	/*
+	 * There is two dividers between xspi_clk_root(from SoC CCM) and xspi_sfif.
+	 * xspi_clk_root ---->divider1 ----> ipg_clk_2xsfif
+	 *                              |
+	 *                              |
+	 *                              |---> divider2 ---> ipg_clk_sfif
+	 * divider1 is controlled by SOCCR, SOCCR default value is 0.
+	 * divider2 fix to divide 2.
+	 * when SOCCR = 0:
+	 *        ipg_clk_2xsfif = xspi_clk_root
+	 *        ipg_clk_sfif = ipg_clk_2xsfif / 2 = xspi_clk_root / 2
+	 * ipg_clk_2xsfif is used for DTR mode.
+	 * xspi_sck(output to device) is defined based on xspi_sfif clock.
+	 */
+	root_clk_rate = rate * 2;
+
+	nxp_xspi_clk_disable_unprep(xspi);
+
+	ret = clk_set_rate(xspi->clk, root_clk_rate);
+	if (ret)
+		return;
+
+	ret = nxp_xspi_clk_prep_enable(xspi);
+	if (ret)
+		return;
+
+	xspi->pre_op_rate = op->max_freq;
+	xspi->selected = spi_get_chipselect(spi, 0);
+
+	if (xspi->selected) {		/* CS1 select */
+		cs0_top_address = xspi->memmap_phy;
+		cs1_top_address = SZ_4G - 1;
+	} else {			/* CS0 select */
+		cs0_top_address = SZ_4G - 1;
+		cs1_top_address = SZ_4G - 1;
+	}
+	xspi_writel(xspi, cs0_top_address, xspi->iobase + XSPI_SFA1AD);
+	xspi_writel(xspi, cs1_top_address, xspi->iobase + XSPI_SFA2AD);
+
+	reg = xspi_readl(xspi, xspi->iobase + XSPI_SFACR);
+	if (op->data.swap16)
+		reg |= XSPI_SFACR_BYTE_SWAP;
+	else
+		reg &= ~XSPI_SFACR_BYTE_SWAP;
+	xspi_writel(xspi, reg, xspi->iobase + XSPI_SFACR);
+
+	if (!op_is_dtr || rate < 60000000)
+		nxp_xspi_dll_bypass(xspi);
+	else
+		nxp_xspi_dll_auto(xspi, rate);
+}
+
+static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
+{
+	u32 start = op->addr.val;
+	u32 len = op->data.nbytes;
+
+	/* If necessary, ioremap before AHB read */
+	if ((!xspi->ahb_addr) || start < xspi->memmap_start ||
+	     start + len > xspi->memmap_start + xspi->memmap_len) {
+		if (xspi->ahb_addr)
+			iounmap(xspi->ahb_addr);
+
+		xspi->memmap_start = start;
+		xspi->memmap_len = len > NXP_XSPI_MIN_IOMAP ?
+				len : NXP_XSPI_MIN_IOMAP;
+
+		xspi->ahb_addr = ioremap(xspi->memmap_phy + xspi->memmap_start,
+					 xspi->memmap_len);
+
+		if (!xspi->ahb_addr) {
+			dev_err(xspi->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Read out the data directly from the AHB buffer. */
+	memcpy_fromio(op->data.buf.in,
+			xspi->ahb_addr + start - xspi->memmap_start, len);
+
+	return 0;
+}
+
+static void nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	u8 *buf = (u8 *)op->data.buf.out;
+	u32 reg, left;
+	int i;
+
+	for (i = 0; i < ALIGN(op->data.nbytes, 4); i += 4) {
+		reg = xspi_readl(xspi, base + XSPI_FR);
+		reg |= XSPI_FR_TBFF;
+		xspi_writel(xspi, reg, base + XSPI_FR);
+		/* Read again to check whether the tx fifo has rom */
+		reg = xspi_readl(xspi, base + XSPI_FR);
+		WARN_ON(!(reg & XSPI_FR_TBFF));
+		if (i == ALIGN_DOWN(op->data.nbytes, 4)) {
+			/* Use 0xff for extra bytes */
+			left = 0xffffffff;
+			/* The last 1 to 3 bytes */
+			memcpy((u8 *)&left, buf + i, op->data.nbytes - i);
+			xspi_writel(xspi, left, base + XSPI_TBDR);
+		} else
+			xspi_writel(xspi, *(u32 *)(buf + i), base + XSPI_TBDR);
+	}
+}
+
+static void nxp_xspi_read_rxfifo(struct nxp_xspi *xspi,
+				const struct spi_mem_op *op)
+{
+	u32 watermark, watermark_bytes, reg;
+	void __iomem *base = xspi->iobase;
+	u8 *buf = (u8 *) op->data.buf.in;
+	int i, ret, len;
+
+	/*
+	 * Config the rx watermark half of the 64 memory-mapped RX data buffer RBDRn
+	 * refer to the RBCT config in nxp_xspi_do_op()
+	 */
+	watermark = 32;
+	watermark_bytes = watermark * 4;
+
+	len = op->data.nbytes;
+
+	while (len >= watermark_bytes) {
+		/* Make sure the RX FIFO contains valid data before read */
+		ret = xspi_readl_poll_tout(xspi, base + XSPI_FR,
+						XSPI_FR_RBDF, 0,
+						POLL_TOUT, true);
+		WARN_ON(ret);
+		for (i = 0; i < watermark; i++)
+			*(u32 *)(buf + i * 4) = xspi_readl(xspi, base + XSPI_RBDR0 + i * 4);
+
+		len = len - watermark_bytes;
+		buf = buf + watermark_bytes;
+		/* Pop up data to RXFIFO for next read. */
+		reg = xspi_readl(xspi, base + XSPI_FR);
+		reg |= XSPI_FR_RBDF;
+		xspi_writel(xspi, reg, base + XSPI_FR);
+	}
+
+	/* Wait for the total data transfer finished */
+	ret = xspi_readl_poll_tout(xspi, base + XSPI_SR, XSPI_SR_BUSY,
+					0, POLL_TOUT, false);
+	i = 0;
+	while (len >= 4) {
+		*(u32 *)(buf) = xspi_readl(xspi, base + XSPI_RBDR0 + i);
+		i += 4;
+		len -= 4;
+		buf += 4;
+	}
+
+	if (len > 0) {
+		reg = xspi_readl(xspi, base + XSPI_RBDR0 + i);
+		memcpy(buf, (u8 *)&reg, len);
+	}
+
+	/* Invalid RXFIFO first */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg |= XSPI_MCR_CLR_RXF;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+	/* Wait for the CLR_RXF clear */
+	ret = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
+				   XSPI_MCR_CLR_RXF, 1, POLL_TOUT, false);
+}
+
+static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	int watermark, err = 0;
+	u32 reg, len;
+
+	len = op->data.nbytes;
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT) {
+		/* Clear the TX FIFO. */
+		reg = xspi_readl(xspi, base + XSPI_MCR);
+		reg |= XSPI_MCR_CLR_TXF;
+		xspi_writel(xspi, reg, base + XSPI_MCR);
+		/* Wait for the CLR_TXF clear */
+		err = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
+					   XSPI_MCR_CLR_TXF, 1, POLL_TOUT, false);
+		/* Cover the no 4bytes alignment data length */
+		watermark = (xspi->devtype_data->txfifo - ALIGN(op->data.nbytes, 4)) / 4 + 1;
+		reg = XSPI_TBCT_WMRK(watermark);
+		xspi_writel(xspi, reg, base + XSPI_TBCT);
+		/*
+		 * According to the RM, for TBDR register, a write transaction on the
+		 * flash memory with data size of less than 32 bits leads to the removal
+		 * of one data entry from the TX buffer. The valid bits are used and the
+		 * rest of the bits are discarded.
+		 * But for data size large than 32 bits, according to test, for no 4bytes
+		 * alignment data, the last 1~3 bytes will lost, because TX buffer use
+		 * 4 bytes entries.
+		 * So here adjust the transfer data length to make it 4bytes alignment.
+		 * then will meet the upper watermark setting, trigger the 4bytes entries
+		 * pop out.
+		 * Will use extra 0xff to append, refer to nxp_xspi_fill_txfifo().
+		 */
+		if (len > 4)
+			len = ALIGN(op->data.nbytes, 4);
+
+	} else if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN) {
+		/* Invalid RXFIFO first */
+		reg = xspi_readl(xspi, base + XSPI_MCR);
+		reg |= XSPI_MCR_CLR_RXF;
+		xspi_writel(xspi, reg, base + XSPI_MCR);
+		/* Wait for the CLR_RXF clear */
+		err = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
+					   XSPI_MCR_CLR_RXF, 1, POLL_TOUT, false);
+		reg = XSPI_RBCT_WMRK(31);
+		xspi_writel(xspi, reg, base + XSPI_RBCT);
+	}
+
+	init_completion(&xspi->c);
+
+	/* Config the data address */
+	xspi_writel(xspi, op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
+
+	/* Cofnig the data size and lut id, trigger the transfer */
+	reg = XSPI_SFP_TG_IPCR_SEQID(XSPI_SEQID_LUT) |
+			XSPI_SFP_TG_IPCR_IDATSZ(len);
+
+	xspi_writel(xspi, reg, base + XSPI_SFP_TG_IPCR);
+
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+		nxp_xspi_fill_txfifo(xspi, op);
+
+	/* Wait for the interrupt. */
+	if (!wait_for_completion_timeout(&xspi->c, msecs_to_jiffies(1000)))
+		err = -ETIMEDOUT;
+
+	/* Invoke IP data read, if request is of data read. */
+	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		nxp_xspi_read_rxfifo(xspi, op);
+
+	return err;
+}
+
+static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	void __iomem *base = xspi->iobase;
+	int err;
+
+	guard(mutex)(&xspi->lock);
+
+	err = pm_runtime_get_sync(xspi->dev);
+	if (err < 0) {
+		dev_err(xspi->dev, "Failed to enable clock %d\n", __LINE__);
+		return err;
+	}
+
+	/* Wait for controller being ready. */
+	err = xspi_readl_poll_tout(xspi, base + XSPI_SR,
+				   XSPI_SR_BUSY, 1, POLL_TOUT, false);
+	WARN_ON(err);
+
+	nxp_xspi_select_mem(xspi, mem->spi, op);
+
+	nxp_xspi_prepare_lut(xspi, op);
+
+	/*
+	 * For read:
+	 *     the address in AHB mapped range will use AHB read.
+	 *     the address out of AHB maped range will use IP read.
+	 * For write:
+	 *     all use IP write.
+	 */
+	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
+		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
+		err = nxp_xspi_ahb_read(xspi, op);
+	else
+		err = nxp_xspi_do_op(xspi, op);
+
+	nxp_xspi_sw_reset(xspi);
+
+	pm_runtime_mark_last_busy(xspi->dev);
+	pm_runtime_put_autosuspend(xspi->dev);
+
+	return err;
+}
+
+static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (op->data.nbytes > xspi->devtype_data->txfifo)
+			op->data.nbytes = xspi->devtype_data->txfifo;
+	} else {
+		/* Limit data bytes to RX FIFO in case of IP read only */
+		if (needs_ip_only(xspi) && (op->data.nbytes > xspi->devtype_data->rxfifo))
+			op->data.nbytes = xspi->devtype_data->rxfifo;
+
+		/* Address in AHB mapped range prefer to use AHB read. */
+		if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
+			&& ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
+			op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
+	}
+
+	return 0;
+}
+
+static void nxp_xspi_config_ahb_buffer(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 ahb_data_trans_size;
+	u32 reg;
+
+	xspi_writel(xspi, 0xa, base + XSPI_BUF0CR);
+	xspi_writel(xspi, 0x2, base + XSPI_BUF1CR);
+	xspi_writel(xspi, 0xd, base + XSPI_BUF2CR);
+
+	/* Configure buffer3 for All Master Access */
+	reg = XSPI_BUF3CR_MSTRID(0x6) | XSPI_BUF3CR_ALLMST;
+
+	ahb_data_trans_size = xspi->devtype_data->ahb_buf_size / 8;
+	reg |= XSPI_BUF3CR_ADATSZ(ahb_data_trans_size);
+	xspi_writel(xspi, reg, base + XSPI_BUF3CR);
+
+	/* Only the buffer3 is used */
+	xspi_writel(xspi, 0, base + XSPI_BUF0IND);
+	xspi_writel(xspi, 0, base + XSPI_BUF1IND);
+	xspi_writel(xspi, 0, base + XSPI_BUF2IND);
+
+	/* AHB only use ID=15 for read */
+	reg = XSPI_BFGENCR_SEQID(XSPI_SEQID_LUT);
+	reg |= XSPI_BFGENCR_WR_FLUSH_EN;
+	/* No limit for align */
+	reg |= XSPI_BFGENCR_ALIGN(0);
+	xspi_writel(xspi, reg, base + XSPI_BFGENCR);
+}
+
+static int nxp_xspi_default_setup(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Bypass SFP check, clear MGC_GVLD, MGC_GVLDMDAD, MGC_GVLDFRAD */
+	xspi_writel(xspi, 0, base + XSPI_MGC);
+
+	/* Enable the EENV0 SFP check */
+	reg = xspi_readl(xspi, base + XSPI_TG0MDAD);
+	reg |= XSPI_TG0MDAD_VLD;
+	xspi_writel(xspi, reg, base + XSPI_TG0MDAD);
+
+	/* Give read/write access right to EENV0 */
+	reg = xspi_readl(xspi, base + XSPI_FRAD0_WORD2);
+	reg &= ~XSPI_FRAD0_WORD2_MD0ACP_MASK;
+	reg |= XSPI_FRAD0_WORD2_MD0ACP(3);
+	xspi_writel(xspi, reg, base + XSPI_FRAD0_WORD2);
+
+	/* Enable the FRAD check for EENV0 */
+	reg = xspi_readl(xspi, base + XSPI_FRAD0_WORD3);
+	reg |= XSPI_FRAD0_WORD3_VLD;
+	xspi_writel(xspi, reg, base + XSPI_FRAD0_WORD3);
+
+	/*
+	 * Config the timeout to max value, this timeout will affect the
+	 * TBDR and RBDRn access right after IP cmd triggered.
+	 */
+	xspi_writel(xspi, 0xffffffff, base + XSPI_MTO);
+
+	/* Disable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	nxp_xspi_sw_reset(xspi);
+
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg &= ~(XSPI_MCR_CKN_FA_EN | XSPI_MCR_DQS_FA_SEL_MASK |
+		 XSPI_MCR_DOZE | XSPI_MCR_VAR_LAT_EN |
+		 XSPI_MCR_DDR_EN | XSPI_MCR_DQS_OUT_EN |
+		 XSPI_MCR_END_CFG_MASK);
+	reg |= XSPI_MCR_DQS_EN;
+	reg |= XSPI_MCR_ISD3FA | XSPI_MCR_ISD2FA;
+	reg |= XSPI_MCR_END_CFG(XSPI_64BIT_LE);
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	reg = xspi_readl(xspi, base + XSPI_SFACR);
+	reg &= ~(XSPI_SFACR_FORCE_A10 | XSPI_SFACR_WA_4B_EN |
+		 XSPI_SFACR_BYTE_SWAP | XSPI_SFACR_WA |
+		 XSPI_SFACR_CAS_MASK);
+	reg |= XSPI_SFACR_FORCE_A10;
+	xspi_writel(xspi, reg, base + XSPI_SFACR);
+
+	nxp_xspi_config_ahb_buffer(xspi);
+
+	reg = XSPI_FLSHCR_TCSH(3) | XSPI_FLSHCR_TCSS(3);
+	xspi_writel(xspi, reg, base + XSPI_FLSHCR);
+
+	/* Enable module */
+	reg = xspi_readl(xspi, base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, base + XSPI_MCR);
+
+	xspi->selected = -1;
+
+	/* Enable the interrupt */
+	xspi_writel(xspi, XSPI_RSER_TFIE, base + XSPI_RSER);
+
+	return 0;
+}
+
+static const char *nxp_xspi_get_name(struct spi_mem *mem)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	struct device *dev = &mem->spi->dev;
+	const char *name;
+
+	/* Set custom name derived from the platform_device of the controller. */
+	if (of_get_available_child_count(xspi->dev->of_node) == 1)
+		return dev_name(xspi->dev);
+
+	name = devm_kasprintf(dev, GFP_KERNEL,
+			      "%s-%d", dev_name(xspi->dev),
+			      spi_get_chipselect(mem->spi, 0));
+
+	if (!name) {
+		dev_err(dev, "failed to get memory for custom flash name\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return name;
+}
+
+static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
+	.adjust_op_size = nxp_xspi_adjust_op_size,
+	.supports_op = nxp_xspi_supports_op,
+	.exec_op = nxp_xspi_exec_op,
+	.get_name = nxp_xspi_get_name,
+};
+
+static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
+	.dtr = true,
+	.per_op_freq = true,
+	.swap16 = true,
+};
+
+static void nxp_xspi_cleanup(void *data)
+{
+	struct nxp_xspi *xspi = data;
+
+	pm_runtime_get_sync(xspi->dev);
+
+	/* Disable interrupt */
+	xspi_writel(xspi, 0, xspi->iobase + XSPI_RSER);
+	/* Clear all the internal logic flags */
+	xspi_writel(xspi, 0xffffffff, xspi->iobase + XSPI_FR);
+	/* Disable the hardware */
+	xspi_writel(xspi, XSPI_MCR_MDIS, xspi->iobase + XSPI_MCR);
+
+	nxp_xspi_clk_disable_unprep(xspi);
+
+	if (xspi->ahb_addr)
+		iounmap(xspi->ahb_addr);
+
+	pm_runtime_disable(xspi->dev);
+	pm_runtime_put_noidle(xspi->dev);
+}
+
+static int nxp_xspi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct nxp_xspi *xspi;
+	struct resource *res;
+	int ret, irq;
+
+	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
+
+	xspi = spi_controller_get_devdata(ctlr);
+	xspi->dev = dev;
+	xspi->devtype_data = (struct nxp_xspi_devtype_data *)device_get_match_data(dev);
+	if (!xspi->devtype_data)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, xspi);
+
+	/* Find the resources - configuration register address space */
+	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(xspi->iobase))
+		return PTR_ERR(xspi->iobase);
+
+	/* Find the resources - controller memory mapped space */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
+	if (!res)
+		return -ENODEV;
+
+	/* Assign memory mapped starting address and mapped size. */
+	xspi->memmap_phy = res->start;
+	xspi->memmap_phy_size = resource_size(res);
+
+	/* Find the clocks */
+	if (dev_of_node(&pdev->dev)) {
+		xspi->clk = devm_clk_get(dev, "per");
+		if (IS_ERR(xspi->clk))
+			return PTR_ERR(xspi->clk);
+	}
+
+	/* Find the irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq,  "Failed to get irq source");
+
+	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	/* Enable clock */
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable clock");
+
+	/* Clear potential interrupt by write xspi errstat */
+	xspi_writel(xspi, 0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
+	xspi_writel(xspi, 0xFFFFFFFF, xspi->iobase + XSPI_FR);
+
+	nxp_xspi_default_setup(xspi);
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable clock");
+
+	ret = devm_request_irq(dev, irq,
+			nxp_xspi_irq_handler, 0, pdev->name, xspi);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq");
+
+	ret = devm_mutex_init(dev, &xspi->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
+	if (ret)
+		return ret;
+
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
+	ctlr->mem_ops = &nxp_xspi_mem_ops;
+	ctlr->mem_caps = &nxp_xspi_mem_caps;
+	ctlr->dev.of_node = dev->of_node;
+
+	return devm_spi_register_controller(dev, ctlr);
+}
+
+static int nxp_xspi_runtime_suspend(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = xspi_readl(xspi, xspi->iobase + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, xspi->iobase + XSPI_MCR);
+
+	nxp_xspi_clk_disable_unprep(xspi);
+
+	return 0;
+}
+
+static int nxp_xspi_runtime_resume(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	u32 reg;
+
+	nxp_xspi_clk_prep_enable(xspi);
+
+	reg = xspi_readl(xspi, xspi->iobase + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	xspi_writel(xspi, reg, xspi->iobase + XSPI_MCR);
+
+	return 0;
+}
+
+static int nxp_xspi_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int nxp_xspi_resume(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	nxp_xspi_default_setup(xspi);
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		dev_err(dev, "select flexspi default pinctrl failed!\n");
+
+	return ret;
+}
+
+
+static const struct dev_pm_ops nxp_xspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_xspi_runtime_suspend, nxp_xspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_xspi_suspend, nxp_xspi_resume)
+};
+
+static const struct of_device_id nxp_xspi_dt_ids[] = {
+	{ .compatible = "nxp,imx94-xspi", .data = (void *)&imx94_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, nxp_xspi_dt_ids);
+
+static struct platform_driver nxp_xspi_driver = {
+	.driver = {
+		.name	= "nxp-xspi",
+		.of_match_table = nxp_xspi_dt_ids,
+		.pm =   pm_ptr(&nxp_xspi_pm_ops),
+	},
+	.probe          = nxp_xspi_probe,
+};
+module_platform_driver(nxp_xspi_driver);
+
+MODULE_DESCRIPTION("NXP xSPI Controller Driver");
+MODULE_AUTHOR("NXP Semiconductor");
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1


