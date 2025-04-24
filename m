Return-Path: <linux-spi+bounces-7729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A40A9A443
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D4F17524A
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2D218AAB;
	Thu, 24 Apr 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KprA0/p4"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0A1F4624;
	Thu, 24 Apr 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479922; cv=fail; b=n/1xr7lAkeFHbks4FJBuXKBb393FcVhThkMY5ySZcQhIzBM3ADnY+QVAkpGBw1QaHlja3DJqJsqGnrf6qO28/InHJFn7i02FFYbfn7uixijhCbXBd1/lGxD20PXaGo3vlNVzf9+dwt6xK/fG1zZHyrEGGS4D1UxgJgjHQqwmX2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479922; c=relaxed/simple;
	bh=QSUYbTRNUuYPfUY49SfN3FixUjMX/wmyEPem56RdUFM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uasf1aM+ttONVVYfWHNn9umsR0HlZHLIFM/SQgWOguv6fxZMmXtO+QTeInzr6YiPJ3FdAxS+PJ8l34Sn9V3+W/B37LPFmK5ZGK2MTtCns0YGYnl2Pp+X496n7SWiV9xRI8CXGCyDD6Ptlldank9AoMR6+qsx1+CoWr9dXEGgju8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KprA0/p4; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJsy9OaEimgTNUFzXOSn8rbC6bnpzxndfiuRk5wedIw+MRc2PXll5mSXq4bnAtQOEUWO5ldh5rKQzUcd8VqtF4Tp1N9H9QfXLjfoaykkVyAGZ+vVX6PjskUun3/Z/Y+XKymKcuZWCPAhBUlaydIa0YSIaT+ZjMVYmCwx6+RDCFinQO7OGqhj+hLvjJKULsAzfm5pC8I7nWlDLSHe0RIl0vd4wwTHywwtVZGEpDWVs32wNAm3Tk8MmX1Cx1ONc2XYEVzWicctvvGPmjt7hNTKuTj1CrPgig8bKr8nBOzeA1QaufbRoqRVM+zcDBWzOKZIyPeW9i2/JEBcsuJhmAxgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPDu5BNtgTCO7L+9AY/w0AJuLhaBo6AWpsFJAua7BA0=;
 b=W/I4G0vagBmSqB4Ie7+OjF4/cKZC2Y4Y3jfXcISApS4zTVUn0TQeaD8eTn9kquR3wzDHUyszZapomSl1i5Zl6R2O3nikLob4WcNoeDoJF7X4y3/pkfGgv2s0nYXessUKSbuRYS+ElPsQBpGslPI7hUDo+cJA4UkEP8ofZQ7dzO0sUHi2cAHzJ4Ltuukwf/8AORS6ACIzohm4z1h7j8H2YPJ4R7Tx485FRQOSXpVuzB8nXU/clJioCPVJwJ/spsCLIuXtOWZf7KnnDAOGsYQcq1BknFYWFLl73PxHJCjLZxPqjzs6sURp9qklakWCUulDTugxlHbwE4LyRMH2IUvAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPDu5BNtgTCO7L+9AY/w0AJuLhaBo6AWpsFJAua7BA0=;
 b=KprA0/p4OO6bfDN7zigVYC8+JZ7KUacnL1zNHrKWgoxXSQ07NbqFqJfX1RkQVXLeMRZVqsrC2n6YPPgXibwEPcgcBPmNrZgV+34v0oyC99g955KeKLCiEyf/OBx79/4hcd4qEc4YAwJrzDwxVj39/krySB0hMJVX0xOkcpFuNFuWjBESzND/kXcIOZD9sGJEuA4MazoIsW4y0RC3CRFYiUTLaolchXF9g9cYOz4e+dZXa26h5blvLQj3f6X8BH0ock6+LZy/bj0MRC2fpw2Ymv3BYJN9MlaszOO1Nm61g354E1wmmgmKtyUJBRpXv8zvnKkc56vqUWjc6hhT9KVC2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:31:57 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:31:56 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/5] This patch set did some clean up and add runtime pm
 support for flexspi driver
Date: Thu, 24 Apr 2025 15:33:24 +0800
Message-Id: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETpCWgC/1XMQQrDIBCF4auEWdeiY6Skq96jZBF0bAbaRDSIJ
 Xj32kAXXf4P3rdDosiU4NrtEClz4nVpgacO7DwtDxLsWgNKNLJHJfyTSgocps3OQll/wd61XTt
 olxDJczm4+9h65rSt8X3oWX3XH6T/oayEFDggGS2NHJy+LSWc7fqCsdb6AcNtnH6mAAAA
X-Change-ID: 20250421-flexspipatch-1cf724d4213d
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=1217;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=QSUYbTRNUuYPfUY49SfN3FixUjMX/wmyEPem56RdUFM=;
 b=+wxRZ0i+cntSKe+e4Q8ATC7g00xLbcP6AbPjZAfw0moy/ApS8NbmRTF2sCJATEhqX3jmvumNe
 cg/WFYM+05MBSH3yU02NyKUdYNI6uMafb4iIDTzz5pkJnuTqpvqbZ9x
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3417a005-e36a-4fd4-c265-08dd830216c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm53Vk1Zck5aY3pieGNwOVFpRDJid2d0eW11NkMzaFZsYVlQUXhuMHRWYmpW?=
 =?utf-8?B?M050TFRaalIyVGFmVDJOTlkwRTVLRkExaThKcDNEZ3RhWittUXdpMWNiREpv?=
 =?utf-8?B?T0ExQWlWN215ZEV5NjVhblM2am9Yb1R3MVRnRUV4R2pWek1iVzZtc3Q5MlM2?=
 =?utf-8?B?RFhhblJldVdhWmxwRFRxd08vS01kZm9qdzJwT2VtSFd0Wmk3S05FcGNXeWFG?=
 =?utf-8?B?ZUlGMzhMS2pGWjN5a2QxeG1nRUFOcUVXYUovM2EvK0R4em9Cck5Jb2x4dHQ5?=
 =?utf-8?B?bzk1Vk45Z3pzS0VGd0pxdWVtV1VZSjl0ZlZ0MVhSSGRzVXlvTmM0TFJXSHlS?=
 =?utf-8?B?bTRVZkhJeFd0cEoxbzdIUndwNHJtTkdLTXVEZEFqZVB6VHZoRmN4UmUyM2E5?=
 =?utf-8?B?RVRNZWVaQXYzRThJd2I1QlczekpjQzU4SjBjZlprV1R4Nm0wRVoyYmFhSnNq?=
 =?utf-8?B?eURSOWJURzk2K0FsR1B3Z25mUW43N1Naamh6L3NncXpnYW1VMjB5SU9zdHpC?=
 =?utf-8?B?STdSZXJoV2FFR0dpOTdSY3pYNkxwM1dTUkp2Z3NSU0x5eFlOSHFXNzNpWTBx?=
 =?utf-8?B?RXhJMkVhUDhFUzdkZ2JmWnZwYUh6SmdnQUVSVER5aU9QWXRDWFpDdEtBZXpV?=
 =?utf-8?B?M0JOUVJOTlNja2krbmRpVGIyTVZLYnVXWFpuL3dhWEZRaE9rRE90blcyYmpZ?=
 =?utf-8?B?eDhvOExFSmhuTlp2U1B6UWJuNHlMc3RCNHk3SVkvUXI1eUdoQnBlZGlyUEpF?=
 =?utf-8?B?R2ZmazkyN1ozK1M0OEhRa0JPbjZ1T0t4QlMvR2p5cEhZNU9PZ21CR1NLNGF3?=
 =?utf-8?B?RGgyZmpzaTRZV0NOc3RKdDVSZzJVOEZENTd1VGVTeG04encyTmJ2OXJCbW9V?=
 =?utf-8?B?UCtob0lFeTNTb3ZRMnJnWUxLbWxiY3pEcFZBMlhKODRUTXNyM3llc1d6dDN1?=
 =?utf-8?B?MnNuOVp4dlkxUFhuTXVLT2JpUFcvOWhQV1FMZ3cxa2g0TlVlZzE2V1lBTVFh?=
 =?utf-8?B?czF4QkYvTlNNNytOOFhoYWFJbEpzOEZxWWlSMTFKV2tBbkVGQ1FBUXdCTjVo?=
 =?utf-8?B?K2xJNnNNT0l1eW9FOGFiYS80VWpuNlp2U1dpcGFZWng3ODA5UkdWN3hIeTU4?=
 =?utf-8?B?M1o4azhjZ0w5WEFtU1BWV3BJT2s0ZWl3VzdmRUVTd3A3Z3hFQ25pYnJMZ0g0?=
 =?utf-8?B?V2tDVnloeDdvRmlYRE5DTUk4SWlTS0M4TUphakpwTkcycHJvaHFraGx6dVFS?=
 =?utf-8?B?djJHNUo5b3IyYWVEa1pSS1NNUDg5Mlptc0NITE0yeGxmU293VFF4VFFIV0Yw?=
 =?utf-8?B?eGMzNjJaQjdKTFdzTWRMVzR1YUErR3dMT3ViSmE3b25MeDM2RGsrak9yUTQ2?=
 =?utf-8?B?QUVOeXNiRHQyT2o5WlFRbVZIQjR0RXowR1E4TmxXbUNqL3NmayttZTc2Vmwy?=
 =?utf-8?B?NVJPNkpuY2xhN243Nm11RVkrYjRPRDdUQkVidndOUm9oRG0rQy9SRWlvZXow?=
 =?utf-8?B?alBURTJKY0FwR1hDRUxnc2FUNS9pc3NQZTJ2M1BRb1pRZW1nNVZBaXg1eDN0?=
 =?utf-8?B?VFhQRmxLWUZTOVZDNkkrWHp3eFlEcmFyWjRnTTE5K3k5S3M3bTJRemlMUFJn?=
 =?utf-8?B?ODlkNGl1YndHQ2doVmMwVUpTTTM5YnpvMDF0WXZoV3pNTk1BZGIyd0M2NkRD?=
 =?utf-8?B?NDNndDJLZzMrYm5LNDBlZGhmMHQ4b1QzQTJFc281cmtiRWR4WEZjTnFWYnQy?=
 =?utf-8?B?M0NvSUVlMzEyZnRTZlJwQnFGelRDNDdPeFMybHI4MjBhbGNOQkF2aWtjRTR3?=
 =?utf-8?B?VHNCdnVyK1BEaVB4RlQxYkduTzBKV1h3TU1TbjcvcUV2VkppTVZVWU1FQmVH?=
 =?utf-8?B?ZnA3L2FxNG0xMnlUa3dkLy91cTN4QjZNNE5HaWptYldTK29JTVB4aXVGaWxL?=
 =?utf-8?B?Tm8zRDl3d0ViL1ZiaGdab2Jza25xMEFUZ0hLVTZ6WVFwclEwenRHWWVNR2o3?=
 =?utf-8?Q?0Q0Cvhb10HsmSq5X7/HY5Vy0EUExgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBOL2pTb3A3WUtFVWkvTmJ0ZS90VEJwd01GWElKZk1oZ3NqeERIcnlQQW9j?=
 =?utf-8?B?S2ZRUFJIUldHbmZpSVdJQlR1RjR6MzhaSDlybnN6SUVDU1NCS0xxMDFRS1Y3?=
 =?utf-8?B?WG1HVDdKR3RwazNqVlYzSFZpZU9rb0RFTGlldlFyR0QyOFdMYXYrelhRQmZi?=
 =?utf-8?B?T0dWejY3Smx3bUUzTmZCeHlnYnRLQjZ6YStueWNRNDhZOHVSN001akFYU3dN?=
 =?utf-8?B?SFJhTDl6MXo3TTdOM0ZYZ1p0c21iY3c1UytXVzZSaDVFMFNac3J4WDFWZ0FZ?=
 =?utf-8?B?M2xKNzBnbjNPZWV0THRkL3hxK2lVWC9tMmczTjRnYkFHQ2F1RDhxSVVVUDhl?=
 =?utf-8?B?SHJnZ3dPRlB3V05DM2VXZEVsQWwzRWszSzU0Q2QvWWIxdVN3R3VqY0pYMzU5?=
 =?utf-8?B?RFNyRytRWC8rUzJjYVZmb3pGQzgyU2N6MnppNkRwYm8rVE1pVmlUNXVPYXg5?=
 =?utf-8?B?VkVGck1vc3dsVkhqd1k2a20rZXVOUFZFVldEMzhrN3VSV0lVQjdDTmpoYjMv?=
 =?utf-8?B?QVRkL0ZjTmpEQnhOTXN3VTlsUnIvTU9PcitxcDEzRG04dVMxOWo3L3FvMHNB?=
 =?utf-8?B?eGtMVlRsUjZ0VFkwVC9tK0FOL3hFOVpuUjBMbDIzdCtJekpmamduQ092QXY3?=
 =?utf-8?B?cnB1TWJxeUI0T0NhbElvK09lbDUyNlBYVXhOU3ZLUlB1TEVkZm1YdDZlemFW?=
 =?utf-8?B?b2dyZVhTdmFUUTRtTStocmt4ZUoxZjl2TXQ1Q2VhVU5LaHgyWnZORHVRVnhO?=
 =?utf-8?B?cVY5c0h6R0laakFqaFhvaFpSUzc2MVU4ZEhJNEFBcXMrdFp5WnJkRDdpOW1r?=
 =?utf-8?B?RkJHeFZnREdhOHVkTDJkRW1mUXQyM1BVQzJrcHI3SUU1SjNIaUVPYlFBVFls?=
 =?utf-8?B?ckhGYUFNMjNST1E4eWFCQjRpVlcyK1FqWTE1N3I5SDdianhZdmtkUXQ1b3Vn?=
 =?utf-8?B?R29kdkF6SnNnOUpZT1dBWHB4UEdESDlkN092dHo3MnFBNzZPdGhSVTM0eDZE?=
 =?utf-8?B?SkpYUnQrNE5OaXB3RWxRL0N6YTZucVZIWi9zaktWSmIzeVdwM0VBWGU2a2VB?=
 =?utf-8?B?NURZUjNWdWs0eGt2c3VHZDdaRkRadWEvRTNKeVg3Q0FTQUZJL0gvaEdWaHZK?=
 =?utf-8?B?WDNxVEhvQUVycmQyNkJNNm1qNHU1SlBma01zZ2NqZE9WVVpNUXltdE5aL1No?=
 =?utf-8?B?eFJRc2Y5cThldmRGSTZ3Qzk5aFRnUDJOZ1FWelYxalpLNWFQRUJWbjh2VVRN?=
 =?utf-8?B?c2FZblovZngrZmV1aHJnYXc1Unl1YjU0S3NjcTJLdUdJc1hqT3VxZERpRnF3?=
 =?utf-8?B?enZYYTYvNjFvd2FyN3pKb3k3c2FHNGlhbEJWcXBpUlhaOG1ZdlUzWmNyRU1N?=
 =?utf-8?B?c29wTHFQNjlSUDR4ZFd1MkdTdTNBQlZIR0FlK0pMekphMFlIV1h2eW5WZzVs?=
 =?utf-8?B?czFLQ3NWMGpaM2RkWDgyWit4RjlNTUJEMTZCVmRlSUZublZBeUN6RFlKZTZB?=
 =?utf-8?B?ZE82SlF3Z0RHd2lYYWc5MVQyMkZvMnZTbGtMQlJGVkg5NXVHZVNOVHJiT045?=
 =?utf-8?B?dU9rbzVQUzFtRTM3UXdnenpWMDRUc3l6NkY5UHFUNUlzOVFiS0huVUlsRnVK?=
 =?utf-8?B?Z2g5L1V5T0xRR2t1aVFoSkordHNCYUZZS00yempua3A0N3ZWYndSdlFnbzZV?=
 =?utf-8?B?blBOSUZxZHE5czBualMwRlNvMmxDU2hSclFYTFE4cXNwZlcxZWpUWXdBV2lY?=
 =?utf-8?B?UmV1MXN2Mm9qK0daZnBYQnlyWERCVXRDTkJvUWpTbWpPY0JXOEVmVWtoMEwx?=
 =?utf-8?B?eldzVDlGMHArbW85RkVjeFFUUmx4dXlNZTJ2V2lQNU83Zk1tSGJnM1RWQVVN?=
 =?utf-8?B?MEp5QXZPcWxKUWR2M1hZUStEMVZRN3dURnRiYU1NTEVHVzdUU1l5cWlSWlQ3?=
 =?utf-8?B?SlhJY0pwSzRUOTRaTmNoRHRpYmVYMmJrYnBXNE5lWVBKVlR4anROejFZeFhD?=
 =?utf-8?B?MnpvMzcyMEh5bVhkTkZCSEtDMnBreU53eTRISkt6UTVxckJhWnRwSzhIclJr?=
 =?utf-8?B?OW9YaTA1Q3ZIREcybDN3K214eFVXSTFpK0FKNHJVdDNFRm1iV2xjMDhrK0h4?=
 =?utf-8?Q?5K8dkee5OpD9lx1yIahP9PLqb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3417a005-e36a-4fd4-c265-08dd830216c1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:31:56.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79YGgauh2G3wgAMM4oeTbqfNcr1eoiVfxgoUNfZ84cDPOMx7n+di9QYyOemxpC0DFUE70wu7cb85w/6KOKhn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

PATCH1/3/4 to clean up the code, make the code more readable
PATCH2 add the runtime pm support
PATCH5 use devm_add_action_or_reset() to replace remove() callback, this can avoid
       oops when do bind/unbind test

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
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

 drivers/spi/spi-nxp-fspi.c | 191 ++++++++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 80 deletions(-)
---
base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
change-id: 20250421-flexspipatch-1cf724d4213d

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


