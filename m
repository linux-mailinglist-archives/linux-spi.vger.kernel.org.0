Return-Path: <linux-spi+bounces-3555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27589156CC
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434331F23C58
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378011A08D8;
	Mon, 24 Jun 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgkIUM1E"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A61A0721;
	Mon, 24 Jun 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255368; cv=fail; b=e0exJvD+TfAYTELbSTdVjVylqVZZ1zlVQr7c7D1LAcaJ3p2xuEMKtLYskig+u/65Yg1EwVABGzB7HEe21g8FpEeuP6MUIcejQnndBuUPSLfEj9Tks3OeodCxigD94pbqiWdrSHzQSoN/L3MrdlTl+9KC2zdbEwtgr0blyybSCUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255368; c=relaxed/simple;
	bh=PmYQsY2essTluLSJg0o2TW6HFgoqik5wKzt2Zp+nhbc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T8hyNHEqUG4oKAgoC22qb24C/3QoQK8b+boHlp3Byx4W/ue0hUFbxJjAyeeBqO4UMp+wZX6vAr1R/GGy/32uy69mi7siZknK4JWtbDpS6+wvAJy/2cq78OMdpuoDYkfr37FLRXP+dgnrGixmpWe+01xwK5KUqoR3GWd8nunwDdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgkIUM1E; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8KFat6BZeWsTSo9lqHuTYGWDjke+/An15zacuX9dIaubMOiYfXdAfbklwuPLViHiu4nDLQdFWxH4VTeFS3YS7iaF3CmlbERuzOjOOxeXLVPXpJej9Mm2sn6VrbQSYiQzEzjahYu3faFNFjJfAH0zVjlUO+aM1jaj5V6VizGJSWvML8haCRAczaVG4zqUxTsCffz0OpeG0P3mzCUx5fgdqyToxb6Z2gGR2I7ilAU/mb30bUTnSgPumSjop+i2CM+V1XzFZ5LQbdjae3ECsI4ikAws5/3iG/FFjH6y0h68DNriLpFl9X3ZzsYl/2XE5eIoasbmf0vDtqUhoNEoGXcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPsewZbsIBHl0El/Tm0w7Ato0Nmg/b5xX+lTYeF01c0=;
 b=P0365FtW9eo4qMYRcUeHTbnvwzet6f/ba+KJeL8/TBE/ahrJWD8nsiS/uk/VXnWS3+tiuja82NoZL5ldf0HFMiLc4nt28/Pv5T7oEQGWImWY5QLN1KV7q6P15mdF50+FcnKvW/brg/wdvA5xu5xN6QK8SEiIcDduHn6AFoeGPbCYjjwdz+8iySWbevK1HpVxUQUwpMgCP8IB2Cjwmtfkwi7iIKRyl1vw4coF/oge7On96cFXz9H4vgfncTiMGnB5/JSHdWVXhzOYMwRut4qkXrz38fAr0MXAV1AbR6rBwsTFE/4i3fV1Ru5ZZgh7moSr9rUUqw44ocgnAvSAaF4opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPsewZbsIBHl0El/Tm0w7Ato0Nmg/b5xX+lTYeF01c0=;
 b=NgkIUM1E0zYnnWnn5Ji4NF0OKfpFWpILnH3fg/tQPfkWHrqPcy1x4G+dqD5lM88SHdvHiWe+kXgzvv7ZNa9k+YjXp3EDnKXa2rRq/MRgsbPUskFtaZIGZ+jHSfGADzi+ww17PkK7k4UTM0O36KEe1qRwZdgw6jJ7Ym6y3o93IJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10138.eurprd04.prod.outlook.com (2603:10a6:800:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 18:56:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 18:56:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 24 Jun 2024 14:55:29 -0400
Subject: [PATCH v4 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
In-Reply-To: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719255350; l=1902;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PmYQsY2essTluLSJg0o2TW6HFgoqik5wKzt2Zp+nhbc=;
 b=3x+VtoEcc8bWypZNdBf70ZWyPNFKLMRuGX3WUH6QBEvQpOVmD4jEHA8RDXzdr6Cr7mShi5y1Y
 bQyjA0KilfzBH1dj1XCiwy86alOZHlucSL3kC5BkNkZ2aHXQGmUjokv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10138:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a64650-2d65-4a38-2c0d-08dc947f4be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BiVlVHTGNnN3J0MCtsSGVTTGVVK2V1WmxxQkFURUN3eXdPYU5zRStPd1cy?=
 =?utf-8?B?SGJ0dVRybzBJMGVsbXViMDcyMStZQlk2Y3pCTDRZMjJZWUQvNW9PeVhFRDNl?=
 =?utf-8?B?b1l1ZS9TTVRPUVpMUjlzSnp6QUkvWnRNaG9ibmE4aDgyWG11dlVicUZ3ZmNI?=
 =?utf-8?B?b2xESmR2Y1FnMkNQUDd4QlVLeUxZa1N0U2kzNXN2SHB0YmZYcy8wUWN2Smdk?=
 =?utf-8?B?NXVMeHFtYVhSVmhiUWN2VXNXdmhLMTY2cDcyZTAwaTJuWHEwanNlY1ZRb1pY?=
 =?utf-8?B?b1NXbTA0YWdyaEVRUXFMaE1OMVNISzl5RUNNQ0pFcWx3RytDUkRqMUFDUTlt?=
 =?utf-8?B?b28rNmxnbHM1T092eFZjN2h0Z3F0UzdrR3ExTWUxUUNOUDhON3p0NkQ4dGpr?=
 =?utf-8?B?ZWRHNnZzalZSUnZEY0VuUXNnM1E1dnNFMnRMTktXRGVzMnVOaTJKMmpWQmFF?=
 =?utf-8?B?WXhEZVRjbFV2UWdBbzhHUkZEaWJrck1VRmp6cjJkbjNmb3VmSGF4S0tXeTFU?=
 =?utf-8?B?TUh1djYrRXdNcFpHMElobVZrZmNSVU1udEptVDRJRXR6MHFMTmpoNUtGQjEw?=
 =?utf-8?B?eW1Gc2lCczJIOUIvL1hCcSt0VjRTWFRyK3plTGZ1b2hTY0xjZnlNT3E3L2pl?=
 =?utf-8?B?aFBQZ21uS2FRRURrVVhUNlBZNzk1aXdkakZZVEUvRUdSZEhtN1NDL0cwdnA2?=
 =?utf-8?B?YTRkL2Z2TVRxazhBUnRDMWdNa3ZGZkZsUUFXbGNBRHgzQ3RqajRhOWVGVlBQ?=
 =?utf-8?B?NmhxNURYVDlpcDdwcFRMRU9vZnoxWGhIZU5nY0VpTC9yT1ZuTnN6VEozallY?=
 =?utf-8?B?N3Byc0d1SGp0Z25PRzhmN0FVYkhyQlgxU3ZGUFA5bndBOUc0a1J2emh4WmJ5?=
 =?utf-8?B?SVMrdUpoQmlnSG9FemNMbHpGRjZQNGVmK0M0elE2RG1PWVc2b2crbUFINlpr?=
 =?utf-8?B?aXJod2JGQnNyWVA5UmRvN3RLZU0xcHFjeVBQeGZYOGFYZnd0MWNndG5tMmtT?=
 =?utf-8?B?dUJsb3JMSEJwdnoyUDhPVFpYa2F2cUVBa2p5NjZXNTZKMFpjSkg2Tm1IaDBm?=
 =?utf-8?B?TUR6NFlzRE1xYTh4dXlnUXlwWkZwTTQrV0xTSU9NbEZYWUpJZ2lBbVEveUUx?=
 =?utf-8?B?WWM4MEliZC9EZVViQ09McmRmcklRcXRUN3FoMFhxSFg1d1JvaVVzd3BJOWpN?=
 =?utf-8?B?WVNYWVpza2lhQmpUU1pNemlxRmFJK3BvQmE4RmlYZm1iSk5VQm81QTMwUUJ4?=
 =?utf-8?B?RExwcGxzZDNvVFMrTGJ6cjJISk5LRmhYRnpGdGtsWWM0ZEN3MVl2QlpnK1NM?=
 =?utf-8?B?ejYxVzluSE9sRVlnQVhPbEFaZy94YmxrQnBheGwxUmc4SkYvMC9yMUEyeXl5?=
 =?utf-8?B?eThsemxQQ2VKaVRqVXJ6T3I5a0hUOEticlVxeGRWaWRBYThiSTNXeXMrWWJ4?=
 =?utf-8?B?V0Q4bWJnNDNtdlI0SFlRM05RVmk2Q1JRb2FLNkRqcEdrUXkrMjBRU2Y2b1dl?=
 =?utf-8?B?eGxRZHRTb1NKWDhzWkUzUDd6a3owYnhEaFZ3aEFISURvN2sxQmdrMm1jcjBB?=
 =?utf-8?B?Z3dQNUI3L1VVZ0c0TTYzbGlYRUNsVmJuVzEwczFVdmdmc1FObW5wbEpYbkk1?=
 =?utf-8?B?UTFKZ2ExeWJZK014YWorWm5vUUh2WWpLRllRUFR3ZGlZdHlwbm9yNDhlQUUv?=
 =?utf-8?B?L3pvR2REb3oxeVBlRWlGV3RWUGJxTjZVOER0aHlVcy8vU0VReVBtNFVpalBr?=
 =?utf-8?B?QUNNV2UxbjFTUkxydDRFNVJtd3BvUjUrWTlDb3owRWFMZG1VN0ozU0srR2Na?=
 =?utf-8?Q?8vv1suiL7Y/Gf+c8f7ZaawYFJqkvwpeLAz7n8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUUvdWwyYiswcUhRTlpwVGZtYWhQQ3JxVjBlM1d0cklyaFdlVVB6enJhYzBE?=
 =?utf-8?B?YytLOWtVc2tDalM0cTlPSDZNdGRZSEI3L1dmelIwUkYrM3lYM0FJZmpDbWg2?=
 =?utf-8?B?a3BoQktYMXptMGFGeEJvNmpIbnJRd2JvM0ZUUnpia093R3IyZEtiL1dnelpR?=
 =?utf-8?B?UElwSjlDclYrcGprR0t4N1JVYkV4UHZVb1Arb096SEEra1RKR3Zha253THRQ?=
 =?utf-8?B?YlRvMXhlU0V5M3h0Z0lIYmo3b3dnV0N4YVE5T2JKTTdYdi9VTHVLOXVtcWJt?=
 =?utf-8?B?UnZRTmtwb2NZa29mVGVrMTBRaVFtRkI3eTRLWTlFRFpVVVFnSENVbFhvQ21I?=
 =?utf-8?B?emdXdzRsSXhweTQ1QWo1Z3FyTnYrVFZvY2xTZWk3UlB2RXlzQjRQWUtwdE1R?=
 =?utf-8?B?RTV4eUd4TTlBSDg1MGtEdkNhUjA1OWVkTGx3T2h0VHRTczQ0SXFaUGZUQnpJ?=
 =?utf-8?B?SVJIK2RIRUorNzdQZDBJNkZHT09zaWNUQ0FFbFhsbGlWRVFkQllVOFBoUW41?=
 =?utf-8?B?OGZvOEVBa2gyZFBWTWtUeUNKSCtJUnRQUVRFWWlNVDFXUUk5VWdiLy9SQTFG?=
 =?utf-8?B?cUs4Vnp3TEcvSHJFUGI5KzdHODAxUng2OEs5QlN6S2ViMEV1eC9Za3FGYjRx?=
 =?utf-8?B?ZWNIb1pIVnNOTWVWeDJXWnpiYTBZQjAxVjhrSmV4b0JGR0E0M2dabm9JRUI4?=
 =?utf-8?B?clBEc1AzMllIQURxa1hrcGp5ZE1mM3dlMTNHSWRoMGMzSXErTFJsdUtrekZp?=
 =?utf-8?B?VDJiNWgySVBTYlZhQzl5Yy9iQnJiczBoWFB5QTFmckRtMTZuMUx0NWx6S2FE?=
 =?utf-8?B?OENHa0d4enpDRmlSWXdDQW1xd2pYNExNZ0JHVGl5OVp3K2w3eWpwU2UwV3ls?=
 =?utf-8?B?bmVxOVB4Vlh5ZHZGSGh6UEhYYXdmcWhubTRiRXpVNUlEUDZnWTRQV3N6UDZj?=
 =?utf-8?B?Tk1USFhxMXdXRkNpN1FML1BRcGJyRkFaUDVMNGIxS0IrcTFDQUxSeTJWZThS?=
 =?utf-8?B?REljZ2M4Vk9HYkJPdktDdzIrdkplTHZ4WXhTdnRWNGpPVkdEbUhPUXN1d3ZE?=
 =?utf-8?B?MEEyaStwQ3ZmOW9oQ0RrSVhXSlpLdVEyV1htZXlLSUY4aXRYd2NWTmh6TWRD?=
 =?utf-8?B?ZWREbHlZNE5ZU3lqV096dWV3L1R3bk9xVlJpelpENFBpU3hKRGsvNk1LWXZP?=
 =?utf-8?B?K3BXNEhwaXBlTmRaU1dDd3JTTDZpV2lOanZMRHdGV00zTEJDemdnenIwbHVT?=
 =?utf-8?B?Yk1NMW43cUJVME01SWVmUk5UMDJhOG1Fc1V1OGE5RE5PYldSYWdhMEJTVmhj?=
 =?utf-8?B?aGdlQ0d0Ynp0T1NMcElzRkpURlkwT2J0ZlhLcmtkSXoyMWlBbEhGNWFHKzUx?=
 =?utf-8?B?a1hrTHlNTGhOVldGSm05bjZBKzNHeklLT2l0U2UyNUN1dE45UDdvaUJYTkIv?=
 =?utf-8?B?UTBDL2dzaWZsOURRYmgwcXFnSVFtYlFiWXM0RDc5ZW5uOHBkV3B0NDRma0Rm?=
 =?utf-8?B?blEvS0tFUlFvQ1JlVm1kVDhJRnVaSGpMcTRnN01ORmIyT0hxZGlIdmNJaklq?=
 =?utf-8?B?ZXRaNlF0SjE0eXdZUjJ0Z2FpcmgwSjFhWjBlRllhVmIzdEtKeGFORkhPaU1R?=
 =?utf-8?B?dEJTYlRTdStKU2YrV3BhbHduQWdxeXBZNXZZYkt4Rkh1Ti9meSs5SzZra1k3?=
 =?utf-8?B?amJXcGZ2c0hoWkZUNEtyM2hSczMvWm8xaU1qR092OXk5c0hNend3MnNpMUM0?=
 =?utf-8?B?ZTBDb1ozSUN6T1VRYUlneTc2UHJRR2gydXVRTEd3TFlCTUJBQUM1TlhTQm95?=
 =?utf-8?B?SEI0NTRhSmZ1a1pIenFiUEZ6SDhURFlHRWVEa2lzU3RDQnZSMGdJVWloNWR6?=
 =?utf-8?B?SUgvVEFCT2FqdHdjSWNyK0w5YXZ4YnhXeU9WNHpPK1dDQ2pONVBNN1dwdjh3?=
 =?utf-8?B?WTd4VmVlRWlGSTRPT003Q1JTOG5zNjI2Y1ZRK092M2ZRck0xaVFNS29IUzVS?=
 =?utf-8?B?eDE0bVRFQ3NmcHN6ektYZnVDYWNyemYycGtrTG56TGl2dXU4SXYwZzU3RCtq?=
 =?utf-8?B?N2h2UUIwaUFyTnBxMmlSOHQyZXJtczJFWDZyemxZdSttVHdRUC9FS0QydnFx?=
 =?utf-8?Q?BiErGorfAqu9PiDKXwpB43DYM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a64650-2d65-4a38-2c0d-08dc947f4be7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:56:03.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AE73o6dJtwlEEpTwevF3aM1HA2++y8K1Oo+vdI+vUkmHDeLk8ZPAsk0WSF5CLNta0kI5zLkwPwe7mJ5DUnITBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10138

Use SPI common properties 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns', mark private properties 'fsl,spi-cs-sck-delay'
and 'fsl,spi-sck-cs-delay' as deprecated.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chang from v3 to v4
- fix typo at commit message
- use comments:
Standard CS timing
properties replace the deprecated vendor variants below
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 26f8540cb101b..de23f5ebaafdb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -104,6 +104,12 @@ flash@0 {
 		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
+		/*
+		 * Standard CS timing properties replace the deprecated vendor
+		 * variants below.
+		 */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <100>;
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <100>;
 	};
@@ -112,6 +118,12 @@ slic@2 {
 		compatible = "maxim,ds26522";
 		reg = <2>;
 		spi-max-frequency = <2000000>;
+		/*
+		 * Standard CS timing properties replace the deprecated vendor
+		 * variants below.
+		 */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <50>;
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};
@@ -120,6 +132,12 @@ slic@3 {
 		compatible = "maxim,ds26522";
 		reg = <3>;
 		spi-max-frequency = <2000000>;
+		/*
+		 * Standard CS timing properties replace the deprecated vendor
+		 * variants below.
+		 */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <50>;
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};

-- 
2.34.1


