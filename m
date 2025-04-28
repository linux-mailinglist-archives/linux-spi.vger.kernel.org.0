Return-Path: <linux-spi+bounces-7780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55BA9ED7C
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5977D170679
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A4200138;
	Mon, 28 Apr 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NWAQmpza"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8C1AAA1E;
	Mon, 28 Apr 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834708; cv=fail; b=JTZuMqu/a5lL7/NtxN1By8JBagvlT3EIsAxNcIo+1rIzem5FgMJjgt/bS00LY/gFpQl2xAjHdz/6qTn+jUrdOtzsCNZEzMTfzStFAXZN5zWhseb6eNd0rujuoJFS0OngGEnMwGY3XibheB8cTIH322Rqg+4I6leYAOFCxCm7FYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834708; c=relaxed/simple;
	bh=B/M6gT8eMLmFOY5Rqm3oVXo5ZwdsYy/h76XYJC69WDs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sPmp4/kExefwZhMJwZ7AD53yvC4CjPeRPd0nfvRSQvNL43QODZ4vD9QtCHRBiMYkQxUIf/CQFh7i3QXp4mADBr2j0k9wAQJpi8PLn5mnWt3LjCrPP7+s5/ELGCrhTNYzYCbQzwNcSJVjSIIjzq552LZ5cF3w77j4davHH+MsOBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NWAQmpza; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwKaTLA1a+hOD4uwWwtTbVszcs69aIRQUCgRjV5LzdbtpJgqYbUY167jcIG51gzihXrlCbACqRYEev5VzeWFAK12UuHwHbZzFRsR0ZEcxlEXSDcxwLm0XDei9f1baHJ4ARsoacrSKSz2U1iI63WZyBAgimLxjxymo0fHOD2SyyaORDS6hNQbIf32AvdQS/cBQ6/TwKiyy/x9y9ZFZckYr5INiC5ZScqGo25aZ+9/BtCKmEqIoQwvtL7EyK7eVyoBXhnVcguxP56yRknpSG33XmYlkOda/iF9Gcs0+E2tMux+eKu9saIgKiJQT7fWfxKqgIrggpW6tAimYQdy+AuiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4OJunoDI5v3aR7o+jVqfuo4ThT+kQYd4NaqLVqeB58=;
 b=BQfwF9Nh3p6Dk+LuJDgOUBSatFKUN9VyjWCLeuzCzpwMqmhEs2kixW4K01b9VRf0xIl14b7V3l1V3zb0/ulBIJ80lti/aQR+Agcfg4GHZX03Xf6lYJQrsymNA0UBOKKhZ7PRH+Pkk+ZNAzo04AYEmsYl94fQ8LDErSc/EXjcgA9z3Q+2gWo9F7Wchjev8GdrgtgDOmpE+kWyhDJMdgJFc2HShz4HMfQ1FDCO+iOLoTfekQ8X21nh8qlbt4NXt+58tmcwMmwhz8M1KwHDG4DAu9GjuuSt/gUSNQ2/3xNVH8TrX7WcWSvewJ5tzElBAjt8PReF8PraZsYwfCJiv+PqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4OJunoDI5v3aR7o+jVqfuo4ThT+kQYd4NaqLVqeB58=;
 b=NWAQmpzaIPKKlWifXW+YFhKbbqypZxoSoj8XPK90RKWcpSVNxtM9gLBgrxsQAI8W4YLVGLVoYoSoqgT1lBgJhus2+qHlUQmGOll48Md5nqrP6WY8SpEaYKPmc9Gyie/t9Zk87+U9kJcTnwz2x73C42P7OJmS2qR0dTaRv2Zm3PJUM18ikv1tDNeom3zwLD6896we8+JBKeqdl0R8tAJGodCQyQZlTW7eqVtjEuCealUSW7jHrRYU30xC84hdUJQCJ+ZBWKzLofsg4A1tY61C3beYyJTLaLlOSJYq9vPQPX7bEn90QmaBFrIZH8BWrQsFgA4x/lFjYJcG/qJzK9jtdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:02 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:02 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v3 0/5] This patch set did some clean up and add runtime pm
 support for flexspi driver
Date: Mon, 28 Apr 2025 18:06:42 +0800
Message-Id: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJTD2gC/12MywrCMBAAf0X2bCTZpNV68j/EQ022dkHbkJRQK
 f1304L4OM7AzASRAlOE42aCQIkj910Gvd2AbevuRoJdZkCJhTSoRHOnMXr29WBboWyzR+Oy1w5
 y4gM1PK678yVzy3How3O9J7XY90j/jpISUmCFVGhZyMrpUzf6ne0fsGwSfqfmL8WcUkXX0mhCP
 JSfdJ7nFzon9LThAAAA
X-Change-ID: 20250421-flexspipatch-1cf724d4213d
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=1491;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=B/M6gT8eMLmFOY5Rqm3oVXo5ZwdsYy/h76XYJC69WDs=;
 b=zIR6UmUvgn/4g2I7m0azFzA1zzuMO9dIZP9X18t0b51lBPqW1orm5+qF6oOy3lH6rvFzzJtBn
 fWlPXfHaN5aCGOnfKZvUsBgNIDGnAdSWbB96TarFufkxnfqTrbxKDBy
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: ad29728f-16d0-41b3-4359-08dd863c23ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9WMS9MVGQxQ1FBYkNLSnFqVjQ1RDJSU3BiWW9rcFRJM1J3a3VHN2Y0NWxV?=
 =?utf-8?B?MENSNDFuOURWRmZscjFwY2E0aVBDZnNPMVJ4NXUyd3pvVHkvOTFVWUVzVXNX?=
 =?utf-8?B?Ym0zNWZ4bnE0NnBOcGRUZEkwM2lhS25TYThFbXlpbkVGdmI5OEdUSlp2bWs2?=
 =?utf-8?B?M1QvemFnSGxXeUMvK2k5bU1UbHFYbHhFSFhWUTVEKzZsSWRXajFaRUNESUxD?=
 =?utf-8?B?N2cyMndwOE1ZaEVzRytaUFlSNTFpNldwY0s4SW5ReVNJZG5MS0xETnBDVytC?=
 =?utf-8?B?cmc4TEZmVFpIc2IxYXhxN1Y4b0lmU2FtOVRCUG5MYWtObXZIR0w4T3p0VFJ0?=
 =?utf-8?B?bENLMk9YNGVCekxlMWpLcExGR09obGRPQWVvakNSeDRFUDlRcDZ1QVdScFRs?=
 =?utf-8?B?MTJ6dGVJTXJNRVNWbmU3cTRZaUtFNFBPL2VFOWlRTHFLR2RMdk01bWRqQ3Rh?=
 =?utf-8?B?ME04ckxRaDJxT3FObDIvUnJRTjJJSWs4NnJLRVoyc1VNa3J6T25kWThuaGRI?=
 =?utf-8?B?ZVdsMlhuTzJhYnhNQkFZaUUxK0wyVFpiWlhRZjUvSmVvVGZyOFA4U3kzR3Zj?=
 =?utf-8?B?VFRzdm9FZ29CcFI4cWpQc000WTNtdlZUaml5bnRFaVR4aDRyajVTeFJYNFBZ?=
 =?utf-8?B?YlllSWtYQjZYWFhrRzM1c1ROOTVnYy9EeDVFaU1TRWZIUFYwY2puRHlQOHE3?=
 =?utf-8?B?dURkRG5sN2JQSDhaZFUvZ1ZzTXU2Zkl3dE5mOUxvUnBPR2pOMG1YRGg2c2ty?=
 =?utf-8?B?VHlJaytVRytFaGJaU0NyTDRERC8yMGNIa29xODVzWnNOd0ZUVXRJOTlqaXJn?=
 =?utf-8?B?QjcwdG9nK3hLY1A5dm9DeXlqRUg2bXpCbFBlcnc2SCtDYXB5SjZKWFdnMUtB?=
 =?utf-8?B?YVN2MlB1dmVqZ28wcklCbUEwM0U1dnBnOTdEbUFXY1A2MHhzZUVQSVRqZkd4?=
 =?utf-8?B?VG9SYlpqb3AxRWg0alpCMC8rZWIvZTZHbklEazRCQWJDK1pCSGpwY2hKQ0RM?=
 =?utf-8?B?c2JxRkVFdnRrSkM4c0k0TjBqSlBPVnk2Qk9ySzNqcmZKazhFa0E2Y0NLcHVs?=
 =?utf-8?B?d0Fkcjc3TGtEY05aUnNFa01rNVJ0TUxnWGhqaUNPaTFYb0FsQU9SNWpocGtz?=
 =?utf-8?B?a0RPZmdWai9mZEJpbW4xY0FMMGY5SXZqMDlIcVFBSWFWL1k5RHYwM2ZNNVNi?=
 =?utf-8?B?T1FCNnBWNy8zK0x6T0pJQi9DTDlYOTBkelFDaUY5UVdXTHV1TFluWnVHSVVr?=
 =?utf-8?B?WGErUG1wN0JuZ2lLVGZvd0N3bm40Q2dIM0l1Z1YwSitWcmdvaWJ0QmtNdFcr?=
 =?utf-8?B?WGZLQ2VUaVBKRXV1UmRwTk9oQzVTRk43cGR3bWhUd3d6T051SXg2b0RCOE1H?=
 =?utf-8?B?UHVkWTlwU1Z2dnBmUkFKdHlPcjU2dHoxNVlidHR2bmFyZU9XOUk3b0hONHJ5?=
 =?utf-8?B?NFRJeHNHUWl6bGJKQm1CbGlQblhKQjJ5Wmo4czkvL1J2Qk5CV3k4SldFQzVp?=
 =?utf-8?B?eVUrS04yN1dBcDEwL0dNdTJlVEhRd0RzOG9xdnFJMkoyN3JWVGRyL2dVRDZK?=
 =?utf-8?B?TGRpYnVJN1E1dU5VNDk5RGUyNzdCTU9va21Cbm9qblNQTGl2ZXQyRkVCdXRs?=
 =?utf-8?B?MDJ0M1RUZ3JTeGZuRUVSSkVabTBhODBBSXdPNFZnZFUwVVNMYnYrQkYxQStF?=
 =?utf-8?B?VnJmVFdMZ29iWnpnWlF4WitiSFJDZTFuM1FjV1BNUDlvREdtQThqM3dHWHJS?=
 =?utf-8?B?TDZlcG53NmVFNEcrUWR2VmtnZ1lNSWVaVlBrVmtmaG1oMGdsajJJVmhIejYv?=
 =?utf-8?B?dGdYRkJnZFdNSVlBVkthQVI5bDhSaTRUUkRyajhPRmxqS2hNcDIydFJaakhQ?=
 =?utf-8?B?dFYxTlVydGlvNHNKcHUyZE9iRjZuL2RFVThScGc3K2VBQWRHSmxMdzBYRVp4?=
 =?utf-8?B?YnY4NEh5L1VzQlB4bGZTK2VJc0FCK1VSWEM5VG5hNU51SE9ZcytUemd4MzZX?=
 =?utf-8?Q?oZbT4HwOqRq0SfyK1yUKnV1gYRkQMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdyT1pNQUNaUUJTbzk1K0NBU1k5dkdCNW0xOHF2M1MrWjlYd01STjZXaGtX?=
 =?utf-8?B?VkpTMUNEcGhhTXVCSk9zbmF1WnlMdGdhUmxiZE5ZTnFzY002UXdyNndHWWc3?=
 =?utf-8?B?Vk9XMDMzTHJTa0VSVTA5U2JINFNpM1JSYVU0OU5LMTVHVXNzSHMzcXNvdi9G?=
 =?utf-8?B?K3pVRllwU0NTTnptUEJ5OUptMFNFRm5sdmc2N3JvMTdVWnRXenRlNTRMK1lo?=
 =?utf-8?B?VVU0R3NMcDU0NUR6ckl2cmJBR2IzcVBhNkxzalZzbFpNQVVSTzVhYnJpZkhU?=
 =?utf-8?B?enN4UHRmVGY4WmIySXdMVXRHenU1andQUEN1YjltVHc5YlREcEw2VG5abG9o?=
 =?utf-8?B?OUptRmtpeTRCV3BTM3BNbXRzRTU2Z05JSXdrUG8wRGw3VFBCb3BvREFaMlVo?=
 =?utf-8?B?Wm1GSlVONTZYRFlPN0Yxejk5TWl6a1JtUEwza2ZZSElWbXIvWTdmeFY0L2hi?=
 =?utf-8?B?Qk9nREN0YmwrcFBsK2twbXdBK1Vwc25aZDFnVzc3L214T3ltNWhuNmZMQUw3?=
 =?utf-8?B?cHJubHl4dlNuY1RuaUpjWGFhcG0wNVRGZnBHYThrTmZPeFN3K2d2WGFxaU45?=
 =?utf-8?B?Z2pBb3VJT3I1SGRSMWpUWnZLeGphamhMYlZKWHFCbTlsQytWdDE5SnoxRjRF?=
 =?utf-8?B?VS9MaWcxdzRRTTh6WHJOQ1ovT2NJb2FFLzRldXA5VmxFWXhjM2tLUTFURXI1?=
 =?utf-8?B?dTl4NG1kdFYzVDFmczFyOW9Wbms4ZlhqZDZBRmJGS0t0SG1nVUlUNk5nQVFm?=
 =?utf-8?B?U0Q1L1FWN2lzOStWVWhtR3VtVVp0SnJzendJbFhqMXVDL2VXUUtyZld2WkJy?=
 =?utf-8?B?VzZROStpTjQzTXM3ZXFLTzFCRjY4dFlvandBbUlwUzRNUEhnREJ4dHRwWGYy?=
 =?utf-8?B?Yi8wWkloR3Z5b0JBV1ExZ0ZlKzNMNzRNR1g2ZnFBTTJIUkp3VnlERFhvODRW?=
 =?utf-8?B?aVBVS3FabEgzaTNUdWI2bFFHcWxxM3BzV2lNZk4vTXRGSGdlc2lLQUt1Qk1s?=
 =?utf-8?B?b2pVaE1FbGdyMHlLMExwSTdFR2I2Q2pCNVAvTEk2UzhsZDJTUmNqMG10WWY2?=
 =?utf-8?B?UE5VRFFLdy9nQWJaNWFMR1VnTGRnZUEyai9xb2VIazRPb0JCejZiSU8zTTlU?=
 =?utf-8?B?em9FcTdVMXlXd0NzYVRwOWREbVBpMHMrS2M2OEM1VXdHVDdxV0VyYk9BMUZ3?=
 =?utf-8?B?S0w4emJGN0NwYmdLUVVtbFFLUndlMGVoWitFbm9nd3hjRDluU0tJVE1RTi9N?=
 =?utf-8?B?VEVmMVVIYUZWa1J4RHQ0SU9XR3gvcktOdjdscG5PUkNyTlNzTDBHNERNT0k1?=
 =?utf-8?B?d2VIQ0UrTW5QQXRtUHNvK3NrWTgwRXdHeXhIaVh4a2IvUkZyL3FGNVZZa08z?=
 =?utf-8?B?ck5WQmdDZ1BiMDFMdGtDbHREWFlPWmxST2dOVFJEUGpLQW1ka3piVzRuNUdk?=
 =?utf-8?B?YndrdGRpUUdzNEdKZGFkRmt4Y1pCd2NwRldBT2ZKZDBJTzZ1OEl5bFZ2UHFD?=
 =?utf-8?B?Y05GeEh5U25LR3ZoQ1N1dlVXNkVnVW94SkZob01KdDRIaEhQWHNJSFdzVjhj?=
 =?utf-8?B?dk1CNEZTcFBZeitHMUM4USswVExYUVVmMTFYUk50TmZrelA1disycWpYU2Ir?=
 =?utf-8?B?aEtxZUxmMTJnZG4xMVBmLzlEOE1RQ1F1VHdjeFpFZ1JBRnM3NHFjcWZLRlRR?=
 =?utf-8?B?QlRmSUNvZ0VKcnhnd1FNK3FOQTc5SzM0ZFRqa0xEcXZHRXcwTlBGcjBDakJp?=
 =?utf-8?B?bGZ0dVEzbE5seXVKNU5lRENlNEdpYXJ6WGxSSHhnRFJXNVpwVVVmUU4vTW8r?=
 =?utf-8?B?V3hYSkxYMkdVeTl1RE0yTFlMWnVwbGR5RjVkdTIyZVQ3d2wzUHVPazduVFFG?=
 =?utf-8?B?VE0xaUkvQ1EyMHhNU2M3R3l3RDdvTzF1RUNZQmRSRGlIN2IzaTZaSzJpTzV2?=
 =?utf-8?B?dm4vcElRQkdNOFVzWHlna0YyaWtZUXV2QTdYYjdlSUgzdVdhbU5ZbEQyam1j?=
 =?utf-8?B?U05IT2psZjBFbWYxWkZIdDA2ais5eS9FZ3dlWm5wQ1JZUHFNYldjam8xUlRr?=
 =?utf-8?B?RWlPbUNPbEFHN2I4MHdSVG9tVGNSRjN2ekVReGNoV3ZLZDJ3WjhieHByZ0NG?=
 =?utf-8?Q?sfrpDBkrPJ+lyDu9tfVGi7xl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad29728f-16d0-41b3-4359-08dd863c23ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:01.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XYe36u6XBJuDd6ObMz/393nWpk5TofUqLmrmWurEZmDUHQF9OI9/TAwuwHrstElgG/ZymOjQgWGqibdNpc2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

PATCH1/3/4 to clean up the code, make the code more readable
PATCH2 add the runtime pm support
PATCH5 use devm_add_action_or_reset() to replace remove() callback, this can avoid
       oops when do bind/unbind test

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v3:
- change the PATCH2, switch to use RUNTIME_PM_OPS instead of SET_RUNTIME_PM_OPS
  remove CONFIG_PM/CONFIG_PM_SLEEP, and use pm_ptr for PM ops
- fix a type for PATCH5
- Link to v2: https://lore.kernel.org/r/20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com

Changes in v2:
- only change the PATCH2, add #ifdef CONFIG_PM_SLEEP for nxp_fspi_suspend() to avoid build error
  if CONFIG_PM=n and CONFIG_PM_SLEEP=y, no change for all other patches.
- Link to v1: https://lore.kernel.org/r/20250423-flexspipatch-v1-0-292e530509d3@nxp.com

---
Haibo Chen (4):
      spi: spi-nxp-fspi: remove the goto in probe
      spi: spi-nxp-fspi: enable runtime pm for fspi
      spi: spi-nxp-fspi: use guard(mutex) to simplify the code
      spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep

Han Xu (1):
      spi: nxp-fspi: use devm instead of remove for driver detach

 drivers/spi/spi-nxp-fspi.c | 189 ++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 81 deletions(-)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250421-flexspipatch-1cf724d4213d

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


