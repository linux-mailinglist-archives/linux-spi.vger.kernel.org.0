Return-Path: <linux-spi+bounces-10204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D9B8FA5A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F972176473
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DF27B35F;
	Mon, 22 Sep 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TWXuQjRV"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF25286D69;
	Mon, 22 Sep 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530855; cv=fail; b=BluJ+LlRkeuqhzwAS1sfPUaxxFm5T+WMsKxQi4VxQ4AoHEvS5UTLx+QWTLmD10QesZeHgHzLJ+TBx+CoeoOijaj87K4RbHNBVgUzpGj43acr5M6Bg6yk2lHst2WPkFObk6IdwHNgxh0DNI41ofTbknIqhVSG4VO/GM0UhNQ0FOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530855; c=relaxed/simple;
	bh=tdzobF3xzy0eobzxfR96Pss6YzSfYNTdOGJ04f29828=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hD8Y//sudRz4mlU8mnpBDtnVzzixkU3hq2UavrufQZxp0seGleGdjQuHbHqc52D2cGoL/+iiccPwYD+8XLvDTr0BHVsza1nN/EnrMVNy7HAl9f3IbLv+Lh5NufxDGQZmbVje4P7J8LQS15I6bHGa5pjszoj3oF9vGfXMNpiwAsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TWXuQjRV; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5+KfeH8rPcGE6YIuxxZUeN2E+NtSp9dpv0mMriecNXQPzGEv0bxSp8kQpkvR8O9OJjOrOayfSJjB2x8Pc5rXD8hjC5qvxQo4xfyPMnxSuyn9JnxOVyarhFS7lZ+8TSuF8DvP1FK7fPvguMQ2wrtcHjDZsPh1G+X0n+Wv/e/hwN4Yi4NOG/eVw4h384jVWxCIEehOGnhyOkm0GRH21FRc9Ipr3UAl+4RznHabwwMPhqcI9t6vlMtPc+rzAm9mIg5WUxOVfnaCR1TNvpZHwq6paPDrHVcAtFit+qv2KgjQTtLnfp1EkWZPvae0EXXNRc8CtO7I11CsnLvCW+gQfoJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtosikZgLWOzzNWbohYIpf6A8XA6YbSww1zTr9mmfMw=;
 b=QxcjkNDx+prnAYnoEWKUGxXlCrzicVBziCJq4tE4gmA2eeDPktB8NZc9+8rpSs0fctwEAioAUUw2hkwmPlzmCQrz3bRgCLZHJCkz7Se/eCMfpJuReng28vFyB7/sZethjcduKzdibd0mHvurDu8H+C4LVcEp1ZkuGMPIfas0ppcg6b5tCwNVJ2iqFr4TA3pZiSARAQVBU8TREPOPfDuJkkoADmbs8cIIfzhN33MuR7iEcM7Bzk8fB+Pw/ezUp9D99X1sJ4HWwbcHv6BUHZbU3YLxjEMY8NvfXoccxFq2wWHfPWpNGYgmJPmBZ1s584IXRxptRNeRpvp0dQIcoLKZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtosikZgLWOzzNWbohYIpf6A8XA6YbSww1zTr9mmfMw=;
 b=TWXuQjRVerQ2ikR2n4YEBfjYbhSrH2Zf4Ds1ZNoA9e6/NBAw4za51hGhl5lyWH1hUhOTKm2izQ8LYS5b5n2LfHuAvU3qs0N+rtejWetjCHtSXD5Sjr09TJFMTQRt6/roZTc8HMGWoyvGoUlClN3wQT++GqxOP+fYLSq8ONiPXpyl7E0IpV7jTM7QF8vLL0d3v6lBdSWWNnY3DkSqx/FptKOxxZIpralKZ8e0IbA4lG87ad6KIJ2u6M7VCY2H610jjnRwlyxB20oxT55h2adzqgX0l0DFER5JeaU4hqOv84m9ZXlTgBGKLJeVJENRHCUeVUI3f5PrZ/wGDxfOaQuEVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:47:32 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:47:31 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 22 Sep 2025 16:47:15 +0800
Subject: [PATCH 3/3] spi: spi-nxp-fspi: limit the clock rate for different
 sample clock source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-fspi-fix-v1-3-ff4315359d31@nxp.com>
References: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
In-Reply-To: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758530860; l=2012;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=tdzobF3xzy0eobzxfR96Pss6YzSfYNTdOGJ04f29828=;
 b=cCttyTWf2kqvZ0V5csBkvj5uE7FHTTvcLr3iqRK+nyaPa+Ne1NxUobl9R/sqERcM0f8/NabGs
 VX7QSEpyv/GDaWfHHYXeERHxok+sIlHT+x9f6h72plDErnfHdxDwDA8
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bb4cec-ab8d-4951-002f-08ddf9b4ab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUcrM1prQzFUeEdYaG56a2VJaERHdDkybGVDSWZ4WUtERklaVE91Y0dDVG5i?=
 =?utf-8?B?RklVZVdkZUFFb1lBWm1VcDFjYTh3ZEFyV1IrTUlWd3FCdUp6QWJiZHZSOXdK?=
 =?utf-8?B?Z21wWjRvNlRlZ2o2SWpJck4xd0hzU1djalNDQkIvNFRhdjd4VWRVbmc2V1R6?=
 =?utf-8?B?MVFqN1NPWnpxbHJjUUJ2azdGOFlUMHo4U0tnZk5PK2xtY3YzMXFsSTBCOGgy?=
 =?utf-8?B?RnRiK3pXajN6NDYySXROaUNBZmY4ekluTjRLTXora0NXQlRiNitWSjIvZFlj?=
 =?utf-8?B?eGFHV1FmNjRsL25MU1FPdU1LQ2xud1llWGxpWE1xNmthcnJCaWczbEx0U1RV?=
 =?utf-8?B?aHk4dTF2NE9OUURMNy93eDByVVNyMXdzWjdINlUvalE0ZU9Pd3N1RWdmTmph?=
 =?utf-8?B?ZzRvR2RNV1dNR3h4VldUSkxCelpleGxKQ1gyVy9hNXhGaUVyUHpleUFSdDNi?=
 =?utf-8?B?TXpBSCtFUHVLYStGd042bkk5aWRJY00xR2dCdE1pNG1JM2s5ek9xaUVIZ0hl?=
 =?utf-8?B?RnRBZlNaQkRPMnBwQUxvL1dSZkFvMzZENWgrUjB2bkNvdmx6eEZobWE1ZURS?=
 =?utf-8?B?d2MvM1dySzFocUY3YW45R2xOSUZuRlV6dlBaTXlqTUcrQ1dIRkV0OXNwNEpu?=
 =?utf-8?B?SzhKNFVrQWY4ZENOcC9oTXhnUXBwUWxPTEpXMTlBMGk5b1F2USsvTkdRK051?=
 =?utf-8?B?Q2huT245ZDcxbTBhaVBHZlM3K0lVYkh4bzMrZ0Z3elZQUEJwNWRRTHFqYzhB?=
 =?utf-8?B?SXU3V3prcml2eW5tRVhCay94eDdhaFhJK1doVXFEVksxSThEeU1uZVlwZDlM?=
 =?utf-8?B?ak1Ma0RXZE1KVEp6cXhheWh3WmU0U2M2dit5cko0am5YVEJ4WnVnWjRpWUVs?=
 =?utf-8?B?UzNGdUFpSUlHcjM5ZFVQVDdoUnRURHdHYUVGaWVPcklqT3VKMFZXLzYxaGs4?=
 =?utf-8?B?V0gvL3V0RnRxQmRtUGVlQ0pIcDZRRllwcm50NWxoMzFpVHhwVDZRRk14YSsx?=
 =?utf-8?B?Q2hjdHZYVmVtVHQ4MXlnRHFibXlLNlJUeDlKc28vSEtmSko2NVVlREphaXhZ?=
 =?utf-8?B?OURYQXdjWTJyZ1RRQ1JJZnVBMExzYUpOSjF3Z2EzdDFiVUx6Wk03aWNtV1ZK?=
 =?utf-8?B?ZVhYaThSR2M4TUM1WEdQeEZHaVhIbDl1TkVhby92ajlRNmdlYzlhQkJNRDQr?=
 =?utf-8?B?NEJZY09ZUzJlUkJhRmlEeVNrcEYxTXcyRm50ZnNIWG0yNzF0ZHN3M3p2U21E?=
 =?utf-8?B?ZnlFQXVvQnVpcXQ3T1BUNERHK1VKc3VCdkhpT0piSURPSE92NUx0WllHTjV1?=
 =?utf-8?B?VzdzNFU4YUNjVVl4OTlaVzhUM0pXRkxLV05pVnpZYzlmclgxRWNKVE11ekE3?=
 =?utf-8?B?akx4cEtja2VZR1pYUmtUZ1k5STNGRGlvTlhHSU9pRVNhTzQ4MVJFQ0VIOG95?=
 =?utf-8?B?WGI4UUhrUkdZUDBMTjJEcUFWZFFvN2JwODVDekQzcVRHUUF2ZGxQS2FTUHY0?=
 =?utf-8?B?RDI1MDVUOVdDaU51U0NZUDhDYWpGYkJnYkd1d29GZ0Npbld0a1RMYlRURmNu?=
 =?utf-8?B?UnAxL2J3a05HUzVVSWwxbS8wVXNQNm44V3JqV09tOXBGQUNwbGcyOHorZm0w?=
 =?utf-8?B?VCt3RGE4dWM1VUMzRDdGdWFpdFBsdFJsMFNJbzBoQTh6TUJkR1h0QnVINzZo?=
 =?utf-8?B?eDM4R05PWVBVSXZNcFJ5SVI5MkhMRHFBYUZJZ01zUGQ5S2s3UFBWQ2dHRThW?=
 =?utf-8?B?YStWNU02VEpMT3VubmQ0QTZkRFZYNjlJaFkwYWVQY0dFTU8wU2x5Q01lL3pC?=
 =?utf-8?B?Q29hM3kybktaelZleUw2VVRrUS9BV1JyN0NURGMyTVRpb1R2MTNiczV1RW5M?=
 =?utf-8?B?M0Q2RlVUcmdCSEdXeTVERERDWVFkZ1NPZUZ0Tm0zVzFJYW11bFlaZzhyMktC?=
 =?utf-8?Q?uzH4nSiL8J8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmdXZjc5SEZwQnRrbmpOQVpUbHZrWjBPc0ZodzQ4WWJhb3lqaGp3SDhuMkNj?=
 =?utf-8?B?TkNuWUdtajk3MGFXdTQvbXd2R2gzYURCVk5abDNGZG1jcEhTOUxXV0xiaHR2?=
 =?utf-8?B?dElMU1VmNXBnTVQvbGNPRnhaNnRiWEovL252OVd2Q0lkYmJNVlRkUitFWFZz?=
 =?utf-8?B?dEpOblBUQVB6aTNaWmZxbHMrNW1TUnB5eEVHNkkvd1RXZ1B1TURHckVwWWtu?=
 =?utf-8?B?QVNwQ2MveGtVMko1SWF4VDJmM05RL2NpNG9tT3FMd1hIK09zNUFBMk5tczdH?=
 =?utf-8?B?RUYveENhazdBNkR6bGc2dm9zYXF1VUFCSUFub0VIdjk3U044UnVURFRJZWtk?=
 =?utf-8?B?MzloTnRFYTh1NUd3MzAwZnNRcUtCbGZ1aS94Nnlkbys4MGYvR2IramJqb2Rk?=
 =?utf-8?B?N2E1SEYrbnBnLzVEckE2MWtHb3lXQnRWQTg1bmNhMTNMVk9DWVErMXd6SHZC?=
 =?utf-8?B?WXBTRUoxNW4xYlVZcXFDRENoQTUvY00ySWdPRHAyTFQycEt1K0ptaXZPbzlk?=
 =?utf-8?B?RnU0VHQ0TlRsaEY2ZnZldHYxamR2WjhwMEFkSS9xcUJObFRhSDIySmVXZW0r?=
 =?utf-8?B?RHJuVHF2K0lZMkdQRXE4cDRyRUd3dkJ2SEtaRTZNNEpCcjFoUUlvOUx0WmNX?=
 =?utf-8?B?RU0yYkVWd1ZQSlNhRXdZekVUUXBIc1lLTUw4cWZybG0vSXJwams4TmQ1dEhk?=
 =?utf-8?B?NnhzMS9LMjhQcDZrOUVmMWZ5UWF6WmlUVXZhOGxsRDZxbUFFZFVabHVTdDNK?=
 =?utf-8?B?c2xlY2RHOFBmUjZ5MGkwMFE1cEp6VEQzaGtzSThpU0t3Nk9hUC8xU082V3ky?=
 =?utf-8?B?QzE4TENWTlJubXZ3VnFUQ0M5UXdicG9jSkNWOGxxNk92V2JUUTJSK0FkQyt4?=
 =?utf-8?B?OUdBWFphTnFQNjZqVUZFRUQvNFNXN1F1Z0VxQ0EyZmhhZWpsaFhlZ2ZmSFhB?=
 =?utf-8?B?b0dUUHdiaEdsa3I2bzVHMkZZVy9wUVZ2V2EwMXc4UitlWHdLZzFmQW9aQUJv?=
 =?utf-8?B?eXpUbW9WcjZDdkFQWkNKSkZSTGNwaXJnbFpUaG9mLzNZR05DTjlhN2RCOWt1?=
 =?utf-8?B?REV3QTNxdVQxZDZWYjZDV2ZFVXZRS1hoRCtqRzNaSHVNTURMN3VSUktMcVRy?=
 =?utf-8?B?R1lBU3ZOdlhINldmZENtd2RaQUxjVUlvMHZCTmJTOHdOQ05vR3BhWU5jMWJ0?=
 =?utf-8?B?MWhya1UwQ0FDbVdyTmNZeHBhcmZnMlhVNmNVQlBiVVlCckVFM1hGZEszZ3lR?=
 =?utf-8?B?R1hvRnBob0dxNlNPMlBibXhkOUhpdlA2QU91eEVRcTNzRzBQZ3RRWFR4NGxs?=
 =?utf-8?B?QjdTUVF0S0FEeElhWFV2YmQxTFRWVytPdkx0RUxtMzBwaTc4Vy8wcXJtcTZq?=
 =?utf-8?B?dVZMRjVEcEpNYWgrOWZCSWp4byszcWZSOS9ORlRBK2UrVHY4Ny8zb1FBem9u?=
 =?utf-8?B?ZTM3Qk9hRTQ0Mml6b2lSWkphc0w1SDJEQmQrR3FHZXFtT3BYUWRnaTRoektj?=
 =?utf-8?B?cFFMSXg1K3o0NjNGNVNJRzRBWFRocytwK1krYkpFUk91KzNDUjlUWlJNaWJn?=
 =?utf-8?B?RGhnMGpCQkhra2VLTXQ5ckxvTy8wK1dFNVVPT1hRandld0lsTEwwRHQ5dHFZ?=
 =?utf-8?B?YngrVnpjV3dJZ09RRDBuaTQwUUVSVWZhZ0xkWDJRZ0g0eTMrLy92V0x3a21p?=
 =?utf-8?B?eGlUWVdJUlg4eHpHTGZub3prZ1F1UXAvQmMveGJySk5KMS9ibEdOdnJYQWk2?=
 =?utf-8?B?YURhZkJEc25JcTRIRkFoajlqaE96MXE5Zmo3aVBRSDZ6M2tmd09paEVjV1Zo?=
 =?utf-8?B?bUQvckYxWGc5UUowVW9YdFIyUzJidmNBZUtHNUlubnBUam1xVmNzc2pOeUhj?=
 =?utf-8?B?N3RpSGRvLzRPYmoxQXR0YkFJOWdwSnNRdUNnQmVzenp2UHdEZGZOL1NnUlV1?=
 =?utf-8?B?bXhQdDdTUGVjaTluZUJuUkJkd0doaFhRVTNhZnpmTEJTWWtLTnhzS2N6ZHRn?=
 =?utf-8?B?L0l0YmJGMnhEQjNUL1pnY1E2aHhhMStCZi9iWnZxb2RSSEJPdnd6L2pxajZS?=
 =?utf-8?B?TmNNbjlnNmNMajJiWHlXSUtPZjJmMXFmRGtpejJ1Z2dqM2VSM1JtaS90ZEJs?=
 =?utf-8?Q?/urLrfjDLxIup33x/myIfY2BC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bb4cec-ab8d-4951-002f-08ddf9b4ab0f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:47:31.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiBI5LUXZKq0Bd3yOiASnIhi5LdB5q0AGMM4efHE8aF9aZKZnNFmUURyALdZNxWbgwK96iExEXPTelNgHYxBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

For different sample clock source selection, the max frequency
flexspi supported are different. For mode 0, max frequency is 66MHz.
For mode 3, the max frequency is 166MHz.

Refer to 3.9.9 FlexSPI timing parameters on page 65.
https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf

Though flexspi maybe still work under higher frequency, but can't
guarantee the stability. IC suggest to add this limitation on all
SoCs which contain flexspi.

Fixes: c07f27032317 ("spi: spi-nxp-fspi: add the support for sample data from DQS pad")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 96b3654b45abcaf53266ce9acac8d6578a19458a..b6c79e50d842fa2d0aa9cbd16f9e5f28405ef710 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -406,6 +406,8 @@ struct nxp_fspi {
 	int flags;
 	/* save the previous operation clock rate */
 	unsigned long pre_op_rate;
+	/* the max clock rate fspi output to device */
+	unsigned long max_rate;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -687,10 +689,13 @@ static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
 	 * change the mode back to mode 0.
 	 */
 	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
-	if (op_is_dtr)
+	if (op_is_dtr) {
 		reg |= FSPI_MCR0_RXCLKSRC(3);
-	else	/*select mode 0 */
+		f->max_rate = 166000000;
+	} else {	/*select mode 0 */
 		reg &= ~FSPI_MCR0_RXCLKSRC(3);
+		f->max_rate = 66000000;
+	}
 	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
 }
 
@@ -816,6 +821,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
 	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
+	rate = min(f->max_rate, op->max_freq);
 
 	if (op_is_dtr) {
 		f->flags |= FSPI_DTR_MODE;

-- 
2.34.1


