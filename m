Return-Path: <linux-spi+bounces-10041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E000BB58FB4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD6A1BC1F35
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E58283CA7;
	Tue, 16 Sep 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dMi7i310"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3819283CB5;
	Tue, 16 Sep 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009443; cv=fail; b=d1+oQzANmit2XqCrB3knhVXx7X38b63uy4tYuJJX7i+HxIzSJtjFfgrUQArpXwTC0yL9LYr2N+LqRUv/x7qJ+NhXXgmbUezPtZCoI5O9NIQkfbMoxmVMXNjvoRL4AMpJgl3nVPuNea1UtH4H4Ou7LVhrfbGuabpdJtw6N4f3vN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009443; c=relaxed/simple;
	bh=cPHhHavchVVN1S7oU6xrj+qaINK2dLQQJRfUUZWTkf4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WYEoBSeD/UBwzQd0Qwjh000ao+4xOscuYSkYaRdMfxqxaJXUMrsu9WAs9sIaLluv1Vqs9ePecPIIZEZFtV3BOwAMtQsC+0LLMciW6Axp1l6lNiSN8AhvsOXc3xFViwbaMcPpkf6RSQRf3h1/YsTOs40YeHMnA2fY9BLYSbTehbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dMi7i310; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA8PrfgY1WL26y2Q7uB5pXV+HtYP8NDQYloUJefjO0gWiMRLyc2I6L1S+yLt3634Yc2+66WLo+/Olns5DFoFvEgDYtz11jRudxNNnNwwyugd1L0W/32LryVcQRd+Ai4UrvaJ6vpLYvGZoF+hhBA2Bz3EYkb6h3tidTTrSBlm0d8OJ6+4vwBO7Dvx7CD+4PobOI3pytIG03/i5szA9ba5hW4Cs8wiTjGarPCVJMZ7BZWMw38bTFCiHInifVIRjyx/+AlJ2qXf5OBFPfaAxeis3rwU1+O2gJx/lwaA5eFEgCbwKw4+i8g4jdoS2hfxn0b9oGhiIXmCubldw+CmbLd+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evTS4P1MEoF9wL+lU7zvsQ2sEoHbHUV23F5cERj8BP0=;
 b=gsY6slFnSgf6osBeESaEwwqM3A0EYUGJR1H2N7h8xL+6w+l4jM36fUCrk5V0/X4onUW31E73sliI2syQyKJhLPZyOP007zqzEdRllbIG1ZOZKhNxAU0/ggwKtLAV3jqSaUrzESeWjuuD6p/zVeziHq5X98Bff6lX0kMC5FBHaJ3FcuUaUWcIAip8e4zYMi5Td2ZcTJHw2bx29WsoKn8vl9eUL7CFklntxRgHt4bDH1fB9YQ69nH8zctMJrNXOlGh7FwZln9qMouqFwtiN95/Oul0C0MCd/8LPdwPA/OxQ2BzO5SDJlobHaKrAKM/tyZvyNB4aTQ7qoRkYcKbbaIFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evTS4P1MEoF9wL+lU7zvsQ2sEoHbHUV23F5cERj8BP0=;
 b=dMi7i3108e4Kia4F2veWD0Z1nHhpCt2aoAVL+vpeg+o4qr/CgrhGk5viyeIK4zy9kXCceDU4IFjQZrdvqqIeG5OSPvD3dsT5lo93v097CE2dal9TaU6IIbPXLpIhVzyqnFBVe/3ZUsj9AefY6qH6a3TV+YgAamKQ9qlc7e9vfTTzvNG7iE77uF4xSo8zbcdDv95Fqxjok2o8fnWP69Fkb7LiPkwW/QVE8cbSSyPlLvSq1bgzjaNMBYBDeaCQ2gbS0Gi5cKueJli28Nd+iOJZ1d5+uhSPM4P7/MUf4e5/DOhtLIXEfxuf//RqsuaHq362UlcZebfrlcTYj028+bLCpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:57:13 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 15:56:44 +0800
Subject: [PATCH 5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-ddr-v1-5-69358b5dc862@nxp.com>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
In-Reply-To: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=2064;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=cPHhHavchVVN1S7oU6xrj+qaINK2dLQQJRfUUZWTkf4=;
 b=yF7FqCek+y42NMIwMqek8z25qa0rGOBX3MzNyq2+Aw/FC4SQrTmzhQKsFajgPc/f+6vmsATfM
 2AyYJ9HAKiAC8Y8mlBvhQXiAl15iLx+BGd52bV8t45vQ288S38Y3HWK
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: b50e2f9a-a955-4e90-9081-08ddf4f6a560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVoVGw4NklpUFU1SkZGOWJvMlJvN0hDY2JPem1tUDNqRWZjOWdzalhHcjFO?=
 =?utf-8?B?SkpOTEtmbldLZUwrakFYczMwUWZ5Q3Jpa3ZoUEJqakxtRDA3Z3E5bEowTGFv?=
 =?utf-8?B?ZmNEUmtrb0g0Q0pkRkp5Vyt3cmQ0eUZqQmV5anBOREd2STJ3S0V6WmdJWjh5?=
 =?utf-8?B?UTNISUVhYXloTHpNS0JGOEVvQzdwQUxFb1d4Nmt2OGFoQjdXQ1NKZTNwYk92?=
 =?utf-8?B?OXA1NjNTMzg0YysrK3JnSkJ6a0w2VVBZK0tDK3BzU2wwejJCbElObGFsM1JV?=
 =?utf-8?B?eDEwT3NqZjlLcnd5SzltMGtXbFN0SGZ0YVFUR2NkQWRORkU4aUY2RU1YL2Fx?=
 =?utf-8?B?dkJrUGk2bEtYQ2FuRGR4MVpTTEJ3QkdWYmpCTEkzenlQRnA2QmN6YVJuWmxE?=
 =?utf-8?B?VUhjV09tRHdwN01TZUxYczVwNXJydGJlSFNqUXNYaDZJSGVsZFNmZkxwZGJr?=
 =?utf-8?B?OEc3Yllnb2pvVTNqU2JDTmd6SE8ydXBUQm90dTN3V28yY3lQMmhlR242dnBF?=
 =?utf-8?B?OUhFM1BIZm9XTTVOdEZobVNKdkNERmVBa1B5M0t6Zy96UHFIaS9BZmk4Q2FK?=
 =?utf-8?B?TnJqaGRyZGUrWWZlOURlSy9xUnpGOGxKQXN5VndHMkwxR3daV2lvWTZibkVJ?=
 =?utf-8?B?ZzNpYU1jTGtXSUQ0RkJ4MVYxV09PdWVpcGl0Nm42ako5cmFReFlDSk9RSG9E?=
 =?utf-8?B?cmVBaENva0h2TzYwZ1FnVlZxenFyYzRqZHNVYlQ5TXgyaFIzYVNJQUowek9p?=
 =?utf-8?B?bVZyLyttcEtFcVRwYmxSSkpvL3BHaXlLRE4yMVNqYlhxNUVKREsraG5qelEw?=
 =?utf-8?B?Y3ZNWGo3QTFGNjRBczNuY3JkdDEzZjQ2Y2VzdWhaNEZTc2dsMlBZY0gvV1B2?=
 =?utf-8?B?TElCamZhcS83NURHaG9Bd3hEQUlJMVREVWFpYi9QM1Zoc0VUSW5VaE4zUDVP?=
 =?utf-8?B?aTFHcm1xa2d2Yk1YeXlnRS9lSHN3dFNKRnErVTFlSkQ3ZStZWkNvU3ZzTkp4?=
 =?utf-8?B?WXdsZzhXaFR3NHFpcEthVmZlQTJaem14Vnh3UXFqNzZrRC9ZZUZSa1BOanhP?=
 =?utf-8?B?VmhkWkdwdHA3TzRxR05Nd0JWcE5UWlM4U1lkeWJjZk9qZkhWcFhtcjNHZDNi?=
 =?utf-8?B?N2NmZ2hMeis5U2liV0Q1Q1VwMGFJM3h0K1hxeEpOWTk5Q01XSDd6aGY5MW1w?=
 =?utf-8?B?Z0tUMyttMk1MU3htTkdSdS9xR0xyUzhMem9wYnhQM0JqdmhONzlwMlR1WVov?=
 =?utf-8?B?cFU1K0l0L3RVYnVSaGVvMTdwRUIwbDVHUU9pazBHcEtMTDF6cnM1MHNQa3dq?=
 =?utf-8?B?WU5wajd3N2FHUzM1emtONUZtUTB5ME1vTFNyZUlvS2NMNEY4cHpzeTB6R05F?=
 =?utf-8?B?Y29HZ2g2K21NZEF1dVhTRHY4bEtyaFBoeDhPUE1FY2FyUjFhR05SdGRpcmFy?=
 =?utf-8?B?R0NTcDg4WVN4bWFvajE2WUNvWWhiQUNycWh1SjFERmFWTnUzN3Q3WXVjUm1O?=
 =?utf-8?B?a3M1WTBOcXFMZjA2VFAzcEFUQnV1eE55MGhkdzA4RDZaODh0dDRmVDRGQ3FD?=
 =?utf-8?B?ZGJKSVBXWFZZdjNUMWZnUVhQNTJoRUZSNXRyRFRnd3BrMCtxRndPaklyZ2xx?=
 =?utf-8?B?dVIzeThzeWw1Rm9CN0N3S3hCcnFLZjdIcERkLys2Mzlzb2gzWXBtcjhXUkZZ?=
 =?utf-8?B?cUhCUkU5MjV2ZmU1bU1meFYyTk04NHBlZG1PWjFHVUJIMEFiZ3lKcHQ4STJI?=
 =?utf-8?B?a21aMkJGY2R4Vk1ubW5PK2hkQ2hoUVNqRFFTRzFsOStQVGd6U0tiTWlRbFFI?=
 =?utf-8?B?S3VwaGpyMWlzWHNTOVloTTdRYWVtQnhjZVUrWnRFdWNacnMxcmxwbTdLTGFR?=
 =?utf-8?B?U0hrN3U5K3JXdHcwVjlhMXpoNkJtSDVWaFJzRGtvWVdyM3VXUmloN3hFRUti?=
 =?utf-8?B?NkNjNVVXdlhOSjV6amVYQlRlQmFkRDhEcWxmaEhnQ2tLdTk0UzMrcSthM1ZV?=
 =?utf-8?B?VHZaRXA3YS9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cThsZzh6TURrK2RQcUtPTDUxVFhJMXVxRGNSdkQ1VXpTandER3NEOUs2T09p?=
 =?utf-8?B?N0psamwvQnYyWjNIZDlNNEdlZTBNb2xRSllyeDZjSktKU2VDQi9lbUJ3akRS?=
 =?utf-8?B?aHk3TVcxYTd5WUdVQTMwVXptVGJNZUV5eDNZVFZudG8zM2Z0OTZRMnl6c0lI?=
 =?utf-8?B?aTVVaVNCUlc2UzVncGswaE1ReFhtYXhsL1NSbGxLbXJCd2FDL0tDeFNKOVYz?=
 =?utf-8?B?bGJZUTIvVTJWR21ZcU1pb2JabzdnK2s0T2FpV2tMemxMY1VzbTd3TlI4R1VW?=
 =?utf-8?B?dCt5Lys4OGxtUk8vRmN6TXRzME9RUWNQM3BWWjZPL0VNYmE2VWFpT0VXY3Vp?=
 =?utf-8?B?NW14TGRqdGozVmo2ajBxVDU0U2dVejZNUEJqR2xPazFEN3FYUWdCNUsxOTFH?=
 =?utf-8?B?TU5DamlUc2t5VHpySTlQaGppcVJlc2xlbGI5SFdySTZkYldlRzhtOXdoakY5?=
 =?utf-8?B?VGJXWHVMNjYrRnJDN1hLbFR0Wi90Y2xpSVRFTFd6emJjWGM4TFd0WnJqUis0?=
 =?utf-8?B?TnBSL2Zwdkt2cm4zSHI1QVdoRjJqa0xmenlWRjF4alYrVFk1WjVzbUpFMW9R?=
 =?utf-8?B?K1JIOW5TOTNndXJEcGdUZkJsKzhiVFFmamRXN2UxWlM3Y2haNVo0QytlNTB6?=
 =?utf-8?B?WFNKdEVvRXd6amxzTjRFbFVYd0dpNEhQcmphd2RaR08yNitkekJBOW9Qc2p6?=
 =?utf-8?B?cXFidFRGaFhUT2lNdnhseEo3aFdhRkV1OWlRUFU3M0o0SDNodzVPbllKdFlu?=
 =?utf-8?B?aFQvcytUTGFPWW1mWHVwSmU0c0l1cnRKeVRsaEtCbjFUemN5cWs1dG9EZEk2?=
 =?utf-8?B?UXNYUGRUUnlPNzJ1Uno3SVdrMEJIRUcvVFlhcnhPY0dwOXlUeCs3S3QxZTVw?=
 =?utf-8?B?Z3JjckVqUmdlTlJtZk5vdDFMTEtyN0ZsNjVreUpsRzVabjB3NFdzSDlrdUVi?=
 =?utf-8?B?RUNISkVicGc2SVJJRFM1dmtIa243YmZZMThSZXRqOTQ3WDl5WTBMMmxBUkNx?=
 =?utf-8?B?MnlyQVcrRlFyd3Y1SnFrMytLOENrQTFMQVRxb3hwMDR0ZUpjalBPZElOVldy?=
 =?utf-8?B?d2NXZnl4R1JMUTU3bmZCTUU3eDlhdWdZMXJjUmE4cDFsLzErS2RNaWR5YmVW?=
 =?utf-8?B?REI2VDR6MXVhN1FkUHdhRmxDT0d6ektlYUQ0OER1aWFHK091cjNSRzM1Skor?=
 =?utf-8?B?MUtmQXBibFUwZ0h5OGVlaWFpUm5jaFZ5VTgwNDkxLzB6NXRhd3EzenpWM0U2?=
 =?utf-8?B?NEVrRXRDNlNXTFA2N2lIb3ZTM2VhaFAreldMMGlobENGdGw2WGpVZ3pmNkRv?=
 =?utf-8?B?WHRlRFI5Wmtzc2RsZkZNY3hERXF1djNYSDJ0Uld0TUtVaDN6Zy83aHhBclpX?=
 =?utf-8?B?ZkUybE0xRjd2bEdYQVY0V0tpSmdNQlQyNGRnWVZEOVpLL1hneSs5MFZiQUZM?=
 =?utf-8?B?S0cxOEplb2M5czA3c29YOVIwNlBxSmhzTUE1bG1aMnlZWFN5REpzRzRTck1a?=
 =?utf-8?B?L29VZ1d2ZzRZTFpIRkdhaU1TSHQ4R1lTSHBrS1VIWGJndm5LT2c4SkVFUEFq?=
 =?utf-8?B?UDgxTjFvT0w0aTM3QnV4MUVOamloc1lHN1VVK2ZmRG5wdjNTcmJLeWduZ1hx?=
 =?utf-8?B?eGlNZUtGRnYvWDJubGo1b2YvS2dqcjNnZVdldS9jcEw1azlZaUNOb2pYRHE3?=
 =?utf-8?B?ZU1wYXk2cmtuemRzamJRNWlpUWlUUW4wQVBicTRjTms0QlVlTVJMZVozTkVk?=
 =?utf-8?B?dXAzbUpFcTZSTmlsWGVqZlRnYnBlcHpGTDBNelJvUU9BZHBoekc5dkIxbVE3?=
 =?utf-8?B?eU8rR0JUbmNzM2xza2dCR1dRTUdtWlZoWG9OdUo2ak5mL3ZhQTBKa2luOE5Y?=
 =?utf-8?B?L2RrNTFlTzdlUSt1eEc4S3d4d3BiK1YvVmJCbTBwalFtUkhaOGxOUkRJZ2xO?=
 =?utf-8?B?WHIxWExhYkZ0RlBxMkRCZmd1Kytzek1OQTczdExkS2o2YitXSDQ4S1FBbjBL?=
 =?utf-8?B?NEdtSDQxM1I3aWN6ZFV1S0hpTENJV0RrRG13Z0tOeitPRHc1R2NsV0dreE5s?=
 =?utf-8?B?OW5qTm1Kck1qMnMzK3pKQllEOC9pNlBrZmxHcWNjRXBaS05oQm1wQjhVVEQz?=
 =?utf-8?Q?xwqQkaW7/FDjGdzszQCtkanSw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e2f9a-a955-4e90-9081-08ddf4f6a560
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:13.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSjMr4zbnYZ6fQ252AtX2AUSWrBPFHs55MNecQxoswAPFr7Cz0nBPQwDr2mjARs1QRvyebjo0EZ7umrCjdDgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

Add OCT-DTR mode support in default, since flexspi do not supports
swapping bytes on a 16 bit boundary in OCT-DTR mode, so mark swap16
as false.

lx2160a do not support DQS, so add a quirk to disable DTR mode for this
platform.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 15b094e8e892f0b61c1f320bba897fa1f588be91..389cb20872db6d9653a146eac7182b9a4574496b 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -330,6 +330,8 @@
 
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
+/* Disable DTR */
+#define FSPI_QUIRK_DISABLE_DTR	BIT(1)
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -344,7 +346,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
-	.quirks = 0,
+	.quirks = FSPI_QUIRK_DISABLE_DTR,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
@@ -1236,6 +1238,13 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 };
 
 static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.dtr = true,
+	.swap16 = false,
+	.per_op_freq = true,
+};
+
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps_quirks = {
+	.dtr = false,
 	.per_op_freq = true,
 };
 
@@ -1351,7 +1360,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
-	ctlr->mem_caps = &nxp_fspi_mem_caps;
+
+	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
+		ctlr->mem_caps = &nxp_fspi_mem_caps_quirks;
+	else
+		ctlr->mem_caps = &nxp_fspi_mem_caps;
+
 	ctlr->dev.of_node = np;
 
 	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);

-- 
2.34.1


