Return-Path: <linux-spi+bounces-11253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14AC63C21
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3747F36858D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016C333442;
	Mon, 17 Nov 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gv9jQxZ5"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17542329C7E;
	Mon, 17 Nov 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377452; cv=fail; b=pkvKJI8yKeUjqpPs8GCtbxtY8g8qxL/XYZcLzIYeGLamGNlmsF973Jeow3cCmP3ZWi3Go0/tY/6AnmRQGVBSLMEOSKkH3zBnzuNzrkNFf5XAEsM6/kwuOTTn0EVQjsPHzllM2G724xsw9aZDUE15zF4WA7HSBP/PDroxXKHSTFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377452; c=relaxed/simple;
	bh=EtY9Pk873qFDOpVXeU4Lp2VqegiuO6K8kbAoFc0/XpI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Hw06u5Xwl4Y2w64EiJccuPKI4+JLjMuh84dGL1dEq2uLcadB3F9STzIiEJJOuEIVGOQ8Z8NdcVv9x46XMI2Rb3PK7rCfDfxxmw6JGoY0ArVD4jF4Rtfeaw0X88VoWU5sJ7ADQs8J/0pM3grMB4BMhww6Xv2UNmbN16QupqiMk+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gv9jQxZ5; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsMhuD2btFKH202Ey/WYb/GM97hGsXDHp8N2PLnyJXLfxTmRTwWWQ0JPaBBP1pRDL30eroXxPIsW74bYNDafQ4LxzZuQsFFgusgkg2SionDk5rTajQGCvMQ5DFvC54bGWey2/FOnLr1MxX6+kcotAjk98ucSgaQkPlj4ruvFePS7NvZma2fyhLwPBkAwn3Z+uL7U8bMbdAaEKbNMVAbQuo9442AwuLwSgJXhrSysaRRDNmlZyvW37bMkdLpo08sR6pdVu+mAHSIJ7tQ69aO4M8WwCRfwOxc783zpWiCKkzIvYZg3gu6PIFKhhxDbnAfhOIgkJUcP0Du7vBXuQloz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyF1S8O8JNCHu0bhnq+e/IGDAnLwfCg18iAjgrNkDNM=;
 b=n9VZQz9IUgShjsZALlnmUEn+ZSj8Bypqc7kTeirn0Oy/uOeb6oaT5+YSQMqeOKkXmGbDvZNfF9ZqzS5cqcoz3RHiZ/0xiBdWV9vf0W5XW7lYZB9mdFu/7jeKJdOB6OqUzBWdzTpbNsosIA/NYVvkk2WmMOF94gJIcDYh6fxCOVcmX79RDnH948492RgM7x+JML+cXwiBbKUGFjXbCyl5BABck1rTwyRMnz31MGTmSp31wS9g0WxzQNCZ5z2rn3GXig3htkmrLYj1RWUaR1WwTD5m2enBiS7hDtAt7ihL5Mls2eNatymdDkDIzNbjnf2YZJCIK1/4Xas/cWRg8xEBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyF1S8O8JNCHu0bhnq+e/IGDAnLwfCg18iAjgrNkDNM=;
 b=gv9jQxZ5CpMVBeUvsJWI8KeTn9QahOcpIBNCOpbpjMe0QcsbUYvstCa2WDIL90FcXECHl4vRXb4e37Ds+mejO8Qr0jrIqTOLF7JgjrL2u09fB0nidnra46T1baZPziM6dA70/NpzUj+IMJlEgJBO2dSUiBFfiBmkNWwfGeBeXXTTcjjD99ztcvwtVWdjEwGYNWjyeYoc6O8NB4747uJhw1g6Rku3XZPKYB6PKNDWF2GQOFkF3IYnTPxQFHLz9fUvE8upgLYkWuhowa548i5UerBw5toocdTfWZO90WLnnUDrU2ygnr5wCBYRpwFYsDKVhY8qmWbZ4lBwaQplzh5mjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:04:06 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:04:06 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 17 Nov 2025 19:04:24 +0800
Subject: [PATCH v2 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-xspi-v2-1-e651323993fe@nxp.com>
References: <20251117-xspi-v2-0-e651323993fe@nxp.com>
In-Reply-To: <20251117-xspi-v2-0-e651323993fe@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763377498; l=3817;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=EtY9Pk873qFDOpVXeU4Lp2VqegiuO6K8kbAoFc0/XpI=;
 b=RN42q+zBJG0MuNfrcrJ2SSgvOwlgxu1bzizJMbePiRwXr204yxav20nsOIgivl5iCDQxPbNus
 SnAQsavil4pAx+FiDvF5X6rR19F5EhdVd5eNvJnXYg5Lbkmki/ge48C
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e90d967-594d-4baa-8020-08de25c906b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3BudVU1NWlDSEZnYlRqY3VCY2VjZ2dlbDlTUU5JeFRyMmJVdForU296L1dW?=
 =?utf-8?B?YmZPcWhhUHVSS2p6Z3pHV3c5S054OHdhWWljVmJoaDllc1lSYjlzSU1xSXpU?=
 =?utf-8?B?ZkoweGthR2Y5b0M5a0tvM1ZIdjVyR3d0Wlh6dXhweEdiUUJmUUFmQXZaUWhC?=
 =?utf-8?B?dG5XMmlNWmhvdEs4WWNBbDFpQS9lOUwzRG5Ka0htM0RNOWRwK1ZMT0swQXlV?=
 =?utf-8?B?Qi9sVHNmblNla3d1ODAzK3ZTN2lNaEZjQVR4a0ZuSW1JK0xseUtQY3hwUVN2?=
 =?utf-8?B?YVF5aktZOE90UlN1aXNFZ2g5L0kxNGxXcjRZNE9xTCtwVGdZdHNsQk5iUlhF?=
 =?utf-8?B?MHlJcGZEdzJFbFZWL3BhOTVxeG0wRU5IYktOZjd2NHNrd1VxOEFJeVBjR1FQ?=
 =?utf-8?B?YURwZm9MNG9xSFRMcHZBZGtMekxKL0RMeTdvclFWVkd6UWUzTHpmb29MVGx2?=
 =?utf-8?B?UmVCNlBBc3hDZlNybVFGa3ZzcU9zTXJxaGplaTduRjZqeGt6ZHp0alZGRUhD?=
 =?utf-8?B?SlpwejcrcjZtM2Q0NFNJOU1mQS91bWRLZW9MTUg3bWh2MDlqQStKNWpGZ2Y3?=
 =?utf-8?B?RnRHWXZCejZnQ2RFUC93VWNYQXBkcVNWN3hFSTIyeFk2VDc5RjVnRkZQV0cr?=
 =?utf-8?B?QUh4cU5jSDJVVjh6RU1QOHozZURjcUNyVWRRSkVsd21RY2dGTzI5RVAxcXZZ?=
 =?utf-8?B?VTYyMHBoazF1SzJWaXRWNzNPNUx0UlNEY0Eva09vQi9KakZWc2hCcGZDR0to?=
 =?utf-8?B?Zys5ekwxNWt0Njc0WGhHRDdrSkowRzB0TDlSL0pLd0srY1h2d1I3cktNcFpR?=
 =?utf-8?B?Zk9QS1A3YnM2LzNRTWkzakFKNnNnUW1JUlFlUjVMbjByYjVFTTcySm80Rmd2?=
 =?utf-8?B?cFU4aG1XdVZaVktaZDFuM3FKSjlpM3BtSEplMU5zdkVEZjZiL2lpKzRWL002?=
 =?utf-8?B?MENhdjVVajFheDg4WGlIMVdUcWZTQkZwM2tTRU51VUczbVVoZFNGeFExMEhv?=
 =?utf-8?B?VzdMdmlhVlFTQi9NSFpob2pZOE15OTVRQ2xuZlVXY0tobTdpRktKWlNTUE5M?=
 =?utf-8?B?SVN0R2RvN3BXQ2JaK0loaDUrbWx5VjBmMk0zSG1SMzcxd3pGODlzTHNBVmJG?=
 =?utf-8?B?WXRHV0J5NGVhWmFsUlNPeUw1NG9KNjRNeVVBQ0tNa1dkdlU1NG4wTEVDbVMy?=
 =?utf-8?B?c0hPdGpJMG1iTmtrOVlBb0taY1BEZVpHQVhyZ1Vud1czVlM0aDBEaGdpTUN6?=
 =?utf-8?B?ZmxQOG5QMGI4bGdvS3BoYTVZMEduZEdjakc5VHhQSkw3QzdDTmU3WjJuVGIx?=
 =?utf-8?B?WW9VOFplc2UyQmh3ZkhoYXNWQVJDYWVNYTdYVm51akVKVUZYMDl6QWhHOWov?=
 =?utf-8?B?M1JDcXpsV1Rsc1VPQVJjbUc1a1NESEVZSlRHZWNJVlpLR3NJZmp0NFJnY2Jt?=
 =?utf-8?B?VE03WndMbENxdkRUQ3JBQzhPUDl6Zi9GYUZTZ2lmaGgwRzY5b2FmRG9NTXlC?=
 =?utf-8?B?UGlVSTE5dnNBTlA4M05EQTZRNVBvMWhkMUJBWVhuSXE1R0tjelZsSHJ6Smhh?=
 =?utf-8?B?ZDRrTzQ2VmF5STBsWVZpcmExRkhPMi9wVmNxR0ZaLzk4Ynl0R0w5endlZjI1?=
 =?utf-8?B?QXBXR20zYTVaUTRqRFNrVDFiTjNha2ZJTm5mT2lGdW43UjY4UDQxZWJhYmMy?=
 =?utf-8?B?eVN2R3NUYjRkQTYwUjNQdXhpbzE4NmxDaW9BbTZpU0pKc0s5REpNaWV3K2Iw?=
 =?utf-8?B?WWVJNFZpdkpMMGttUmVvR0VGeWc1RmFtaWV1R3ZmdVBqUDFhQlNDNzR4TXBR?=
 =?utf-8?B?OGdwNjEreG5vc1hhZWVGdjZJY2VpZVA4WnNrUGpWSzZ1bU40UjBCUlpmSnY2?=
 =?utf-8?B?QTU3SEJKRzVxMEZMYzNXZ3dCUTIwRVFSTnZNbDc0bythYllqenN5RGJVbGEy?=
 =?utf-8?B?VW5Ed1FNVTUrWmkxQUxkd2tLM05QU0p0YnJLaGdXSkN6bmMzbHh4OGR4Z013?=
 =?utf-8?B?QVNvdlY1a2lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZDbkxHb0Q2a3d3TzRjb1ZPazlFenUwZnRzTG9EQS9USldsL0pCWnhpR0JU?=
 =?utf-8?B?Z01WS0E0TmhVak9ZNzRuTFRaYUpLTVgvZjUydU1SYkFtcFNrSjc4eWpYcHZv?=
 =?utf-8?B?dGw3MDkyNlZ6NjRPeDJuSmpaZ2FXSXBsUnN3cHJUTEhsOTROcC9RWjdRaG9D?=
 =?utf-8?B?Z0RxajcvWngrT2R2L0ltNHJyZGVadUNOTUlqMDVyNGZrcm5hVEhiUXpwL3Ew?=
 =?utf-8?B?QURrQzJzREoyZ0JWRThWbm4ya3lucTR2ZDVTYnVZQmFzRDdNQ3VDMHVJcGwv?=
 =?utf-8?B?allUZDd3M1FNdUR1VnZwaDgzVmZMdVRDQTBjcXNJSkw5TjdKalFSN0hJYlJk?=
 =?utf-8?B?YlJmK0hWSk5hR3F2eTZpRUhaRWdrVVptdERxUkVUWGd5OEFweWZmdGRRVUhj?=
 =?utf-8?B?ajJqMVY0Mm42WmZYZ2EwTHJQRU9MQU96UXJOaDR0dWlGV2F4U3d3L2FMNm90?=
 =?utf-8?B?NzQ4K1RJUy9CM2gxOTZiYmJ4cDJZUndiRFI5eGFCMk9mVS9Md3o3cSs3MzZT?=
 =?utf-8?B?VmNtNVdFMSsxWGlkVkpJVkdXOFpUaWNYZ3hLck5LV2xiUzdjRW9IbWRzVkhB?=
 =?utf-8?B?aGVYak83UkZvamwrYmpsaU9rU1VGenJudTNRNFpUMFUxeFBiWEUydW5USzFw?=
 =?utf-8?B?R0VMUkpDdUMvSHZKNTdBQXh2Yk5jVHpOWVNwaDdTeGF2c3N1eWdFVVZ6aXRF?=
 =?utf-8?B?dHZYMTlGRGJSYU1venY3c1RndE9IV2QrWnpkbmhpVG05TW44M3d1d3YwL3Q4?=
 =?utf-8?B?NmwvWWNYWDh4T3lldFk2WWFqWjRPSCtYa21vek8vK1VUY0xTQlo0L1d6dzdi?=
 =?utf-8?B?NlNtSjFyZ2pYYXYvUVAvSzFST0VLYnRlOGl4K1BEbHV5VkVTS2FPMW9PSFpV?=
 =?utf-8?B?VTNxcE5iZ1gvMjRqVWVYU09EOGZJMGRjeWpVU1M5Zi9ic3M2Z3Vja21QeVBU?=
 =?utf-8?B?ZXBmZmNvNjUrWFR2ZFA1UUYwbGdqRHlXRWhvVXV5REpLc1ZEREVTUWFWbTlI?=
 =?utf-8?B?aWU2bDd5NmhVYlFvVUdlTVJjblNPNDZuNVQ2R1BVZ3dMRU9kQWVJYmNlR3hn?=
 =?utf-8?B?ZXNkYUVlaGM2SjFGdkdGMXZTTWFWaGc1aEtCT0dsdjc5V1hJNHBRb1lXclY2?=
 =?utf-8?B?VlM4NW8xV0xnWXBoQ0NWbExVQ3B5dG1JYkJ3aTVYU0xXRlNVNldYSTQ1bThF?=
 =?utf-8?B?UzcySHR5c2ZLaWY0OHJ0K2QxVVdkb0o4Qjc4VlVhT1VITERnZ1hsSldTN2hL?=
 =?utf-8?B?M2VrcTdZMFJhRVFLVjR3eU42RjhqSitHb2wzQWpXQjdQd2ZMWWpGK0VLalRs?=
 =?utf-8?B?dkw4T3ZUemE0eFRaY3lyU3NabFBqOEF6a1B3M3dRcVNpR1BBekZ2YjdTM041?=
 =?utf-8?B?Tit1WEszY3dwUnBCT0JSL1A1RTA3eGRQVFUwMXV3VzJVT3I0c1JxODM3RjVU?=
 =?utf-8?B?QTl1RHVrcFAvUTZQL29YYmduM09udk1lNGtRWFdEVlFOUnFkaW9EbjZ0N1h4?=
 =?utf-8?B?ck9vc2dyaUxtM3NhMGtiT0gwSnhaSitJM2QzOU5Cc2NRSG5sZ2poVzArcGpB?=
 =?utf-8?B?RUgrWkh2UHpUWC9lU0JGN1BodzAwL2YrWWpudXJFY3NPK0JwZ0IralVOMHZY?=
 =?utf-8?B?RVRtNnRlVkl1WWpjNUJ3a3lDR2dHKzNKQ1pLN2Vyc05pY0YzaHYvdW9STTZQ?=
 =?utf-8?B?NmhEaEczZW52dG40T0ZGbUdSelVFOEZTWGprdVpYQUtWSGxLWXFvUUs0VDJj?=
 =?utf-8?B?TzVoK2ZaS1pQTlRFUEY4VnZ1R214czkxM01nMnZYT0FBaTJDRjM1VkgzVUhu?=
 =?utf-8?B?Nmo5OElyRmlMNnd0VGVjTHBIRDdlZXU5cTVUeHRobnlHKzBJelI5Q2VQeWk0?=
 =?utf-8?B?bkhJeWl0Q2FlV09yMXRydzRnRFdKVEdEblAvcVp6L0QyeFFpbWNWZDFreDYv?=
 =?utf-8?B?NjNLTlFkRmhxQU9qb3pLQ2xCUFVTUW5GOXMyQm1peHZOU1RwTnJJcjFwVnUr?=
 =?utf-8?B?eHNZS1A5YTFsUWpkZUE0WE1uM3hlR2ZuTUl4dEtIUy9tK2lOQXZOSDI4RkNs?=
 =?utf-8?B?bHd0SkNCRUxobEFDT1pJWmJxYUpvSGtKVjZ2OFBTbzI2NG9tYlp4U1pKSHVW?=
 =?utf-8?Q?Gqc7Ux3igY47A1Bxe7NKX+tT1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e90d967-594d-4baa-8020-08de25c906b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:04:06.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02bTMZ18wLU1MiV2gcFjrNiERYD2z3XzEXtkdo3HLhyvj18w5OWn93hgtfDi37vivYmsn/pNz8X6gZyGhRLmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851

Document imx94 xspi that supports interface to serial flash
supporting following features:

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
- Single Data Rate or Double Data Rate modes.
- Direct memory mapping of all AHB memory accesses to the
  chip system memory space.
- Multi-master AHB accesses with priority.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0f4b162c85855c55d06c6ea1a2417af5121fab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,imx94-xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP External Serial Peripheral Interface (xSPI)
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Han Xu <han.xu@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,imx94-xspi
+
+  reg:
+    items:
+      - description: registers address space
+      - description: memory mapped address space
+
+  reg-names:
+    items:
+      - const: base
+      - const: mmap
+
+  interrupts:
+    items:
+      - description: interrupt for EENV0
+      - description: interrupt for EENV1
+      - description: interrupt for EENV2
+      - description: interrupt for EENV3
+      - description: interrupt for EENV4
+
+  clocks:
+    items:
+      - description: SPI serial clock
+
+  clock-names:
+    items:
+      - const: per
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@42b90000 {
+            compatible = "nxp,imx94-xspi";
+            reg = <0x0 0x42b90000 0x0 0x50000>, <0x0 0x28000000 0x0 0x08000000>;
+            reg-names = "base", "mmap";
+            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&scmi_1>;
+            clock-names = "per";
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <200000000>;
+                spi-rx-bus-width = <8>;
+                spi-tx-bus-width = <8>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 836ec73c604d6db452c63fd155d6ae9625da24e8..8a6ce2fdd6e46e94f8a1631cd0bf8b12980a64ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18701,6 +18701,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
+NXP XSPI DRIVER
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+
 NXP FXAS21002C DRIVER
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1


