Return-Path: <linux-spi+bounces-10036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AFB58FAB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A195205A5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457B221FD2;
	Tue, 16 Sep 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ME8k2pS5"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23800E55A;
	Tue, 16 Sep 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009425; cv=fail; b=bI7X7RPa7EFK7f/UHmAQqLNb+Vf9EWC6LbvLTS0kr+cKBswLhTHywsV5zSzQKFDJJqGQxbC2t4mEHjcri99cmwqD/DP5wc9aayfrajHObrS0KscRPwP/DvxGLPd5U1QxYP6mFDB+gQ9huHShHZGDbFYaGOa7Y8pvAq86W0xVCXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009425; c=relaxed/simple;
	bh=v+C+yWvRb4Htkvwj8Ip6L9w2MXB0ywRbiWe8K5uOLk4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rzjzSzAZWLVxwQZPeA67lw79j6BIMxO2Qai/ymsdXZ/QdvYHwavVzyw48X+wzR98vHNeMeJnKu/nA/glLAJ3m+SyG3yz1azK76rP3KLN0j1ABg738HJi+XjxHL6M/mk5ZSq/8/Nt6b+L1QzyMRL640R7vFQ5Yd1vne6wAoqnWVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ME8k2pS5; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIjFEA85wdS8d21ZZ2M6A0sXs475Pa8CvM0rfxjkPx3GZuJzxZw4hVWdWdCfHMM/XjVOYkrhnxa5FYZ3j/S8oaBbDrxsSlJLUScVO48aafGSbXv8TJRdpLfohsPIEhy56rDaNX+rvasHse9H38o4w0wgEnJ4WnzpH/Y5lWOJ5DrsyJjD2SJKC7wHm9GCItY12b/TojZpGhJ/htdqaMMx+t/VQxLxOH0huem0SALzVnizPL5F754V+Ns4PRLITkLTsmITmn87chWcQFpPlZ/OQfe6u41LPwzt0kSw+tum1M4ouG0VRs7wtygaJCKb06464TUXbLt2L8w9IjjgVB/HLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGrH3MvecAzmDrvqYRr85QchRdWPClvxkn6D247QW38=;
 b=hOrcPDH4c6Z5OD3KqWKXOO5qvhpCTD/QpddNEENTz3TD6nXKgLvD2he5MGjgiek7eKq0qHVYBn7Tlsw/uFvrbLVwHnEtOX92rrpUhGnR363T/BEIVJxzfBY10TmAHGx7bN7a1Q2t3Mxjn6U3sZ7iRv2+3Ydevi1thBB1kQnlRYFlIEE6HFrJRMxJMA820wxkVxJbhwaH4wFRHXUsRAwFRnxhhTW9wPkjWLuFD5hJ4EWJdV80tbumWXYWa7n5KXzTnWXeEOZ7uSO+EkYKjPW7dqYUeSHPbbPhQ2pE9B2NdrfUUqxPOwczWqqWiBA3C3t+XqZ2nOwDi+HMOwo0w/5cDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGrH3MvecAzmDrvqYRr85QchRdWPClvxkn6D247QW38=;
 b=ME8k2pS5tN/GUUG1npb1mrgvYnNr0GXuGvwXuFU1bWs9bfq5Y3AbgVNkotjfVgQGUZdniTHEbARxeYQ3bAuwJHewYmNPJakJkBfVEFUuoC8R88E1kT08t3veqsWxXn0jbbDSUfs4RZ2KP3j742gdsNn+kzUSah900ZUcgOc1V05javPDDEGsSIMiAK9+p2/+gL/0vDnDadIyJmxLjNCW9zwiYPzK9aQBmGn+As9593uPZzx4Fc4rQJ3EgxnsRMQ1+kXiFXbhs3TMUpCvBoJ8bkSrdompDj2JNQGzPu9D5lIifk8BAj/tZ+hkHvx53fFUKU7C+cmQXgphrCLcxMGbwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:56:59 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:56:58 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/5] spi: spi-nxp-fspi: add DTR mode support
Date: Tue, 16 Sep 2025 15:56:39 +0800
Message-Id: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcYyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3bSc1IrigkzdlJQi3TQLE8M04xRzy8TUNCWgjoKi1LTMCrBp0bG
 1tQByUcCfXQAAAA==
X-Change-ID: 20250916-flexspi-ddr-f841f3d79aef
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=1740;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=v+C+yWvRb4Htkvwj8Ip6L9w2MXB0ywRbiWe8K5uOLk4=;
 b=fnaUcYe5ndT6u5y86N9aDFZXrkVdsmux7b8qyhvGPIkmSAkeeSPW5My31x5j2vh4EzwxYey1E
 rIvQrih2R4DDIDrqxLyROPsoJuFJqWmDDPOUv1wstFKHaucEe0B0jow
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
X-MS-Office365-Filtering-Correlation-Id: 646dc792-f100-4293-aea0-08ddf4f69ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0cvQmtsMXdlbkoydFZucGtYNzNhTXB4elV3eHJuWHNyaFRWR3hjWWI5dGhP?=
 =?utf-8?B?NDlLZG5ReENLT0t0K3hjSUNuaVF3V1VHdUJVS1Jjazd2Qm1Yclo2MGNJK1lx?=
 =?utf-8?B?QjllSjJaTDRvbGpFUWZpK2JGRUpnWkgzTHo1YWYwMGVuT2pVT2tPcjFOU0Fi?=
 =?utf-8?B?QUxQbFpsSU9rK0lHM2pXR2tuRnJwS285ellsNGpqTW5od214TjVqdTQ1VUlV?=
 =?utf-8?B?cDJjN2FMaXQzNS9sZWRBZG1LRFh1R0d0WDI0VStCVjlUbkNaYlRCYXpQbkxM?=
 =?utf-8?B?MTJwdFVzcG9GeWYvZGxGTUpVMGY3VjNZaFJEdVdvdkZkZFJzYnhIQTNIMGZr?=
 =?utf-8?B?V1lYZjkvdjJKWWlwUURHcFlsbzJjcGRWNHpVcTZ1MncrNkE2clp1N1R1YWo1?=
 =?utf-8?B?QnRRRDRVcnhQdHVGa0JCVWVpTFlScDZXVmRtdU40cFh2SzArMXZQR3dXdzQv?=
 =?utf-8?B?ck5rUWc3dUtVeWVSTVJVcUlUeVpkcWt4RTJpSFRHaG9JMy9OcS9kWXF1bDZs?=
 =?utf-8?B?b1JpUVV3K0dzRGxmWUVZaS9jUnVtMXhsc2ZHNlo5ZFUvWkZiSDJXTDdoNE5E?=
 =?utf-8?B?bkZVUlhTNlpoRnVicHZqUTlOWCtpMkFnTnBiVmJ3a3hjVGkwdExROVprOU9E?=
 =?utf-8?B?Y2VUOStQcWx2bEgxMHhmMXJsejFqWGYvYVBDSExKd3pGVnhpT0xSSDUxTmRo?=
 =?utf-8?B?b0xNVG1idGJqYStNRDZJTm83YVNMYkZkUzFBZi8rcFp5aDJHQ0tuRUYyZU0r?=
 =?utf-8?B?Vkx4VWZhQnpYRUZrNTZXTU45cCtocGRmWElFbWR5MXFRRDhOd045dmNsakN0?=
 =?utf-8?B?NWxQSlpvUEV2QVkwWS8wb2hDMk1zd1ZzcTNNeWMwamQyaFJtMU5DMVE4UzlD?=
 =?utf-8?B?YUZVVEdpZklZU0hNOTdCdWNlbjZQNXV5TTFMbTJLZ0lJUkcxRFp4ZEdWVmt5?=
 =?utf-8?B?NXNvQ2srcFQrUS9wWW9ZbE9LeCtCOWZpcStHQXJXWnZGUlFUcVR1NkpROUJx?=
 =?utf-8?B?bmJXUU5YL1h4eTZJRFJTM092eTBYMU5URXdRZkx4d0NZbG9od3E2bjdoQnp0?=
 =?utf-8?B?V2RsUEx2NU9IdWs0QUorZVJtZUk5L0VHbHZXL0xBQUpMSklEYkowUjJTdjNp?=
 =?utf-8?B?a3ZPUzdYSlZQOWZ6MXFtL0hSclpqS3dVVTRCWEpzTllrYkJMOHpwd1NoV1hV?=
 =?utf-8?B?R00zaWJlZVo2K2NRSTh1Mk9tL3JGWThkTTFTL3JZUkhrTHljN2ZPbmFYdnQ5?=
 =?utf-8?B?RG5VRkFrN1BJczIvdzhFeHM3RDlwcW9xMm1oK05WUWhTRVV0TjRpSDl5UHV2?=
 =?utf-8?B?NC9rNlNHTTlpZitPVERPbm90MVE4MUdQdktQL21kL002SERwN0pYWVV2R1ZM?=
 =?utf-8?B?TkRJdm9RZFYxbHRvb25PaWxiVVRibFdXV2g2WlAwS1lzUk80K3pBMm02b2xa?=
 =?utf-8?B?SUx5azZzUlVwWVRROUZiWVRFNTRuYllIb0ZSL2pid1dFZUUydGFIQ3N0Y255?=
 =?utf-8?B?c3Awb3NsTzlKWk5NNlg2VEw3UnNNRnB3aHpCRTkwS290dGJaSWt0REt5eTNi?=
 =?utf-8?B?Y2FqaGNzWnBhUUlVc0FjcFRhQ2hjaDZ0YTVhOHp2Zm5sM2ZiSjBITWZvdEJo?=
 =?utf-8?B?aEdVV04yd1VxVStYUU9KeUNvb25sMXBWU3VQQVJNZ2IwUklpejNQeFNDK29n?=
 =?utf-8?B?MEt6RjNZTmd3RnRjazZqajFTSDJLWThQRTFTc3JuTjV3djFteXd3QXpyR3dP?=
 =?utf-8?B?QkpzNjlZNWVGTzBkd3BuTjJOL1U4TVJuY2lXQXdlamUwWXErYzdWL1Zsb3pk?=
 =?utf-8?B?RUZraU1VK0RuMUxyUDFmNG44M1BhUi9iYVFWbEh6MFFMWWNOTGF5WkYxNk5a?=
 =?utf-8?B?TXFxRyt6aTZSd0J6NVNpNkV1WXZiczZwcm94ekI5SmFhbjljeU9UZWFYaTBl?=
 =?utf-8?B?cFFua0FIZWEzcHU4aW90MThvaGNyK2h6c2cya0Rob0VuYksrbHZkMGxmazha?=
 =?utf-8?B?OGllL1NuZDVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpCMlBONGFTVDlVblU2SWlZWnVPTHVwYkVZMXVpeS9hcWpKbkg2aGRDQWdv?=
 =?utf-8?B?d1JyWHhaSy9ieTFHVlFxUlQ2QWNLZWJYOU1yRGxGRExjajFJeDZFcXc3TFNw?=
 =?utf-8?B?V0lJZjdzRm8wcm5DcklqS0VQWUxCOUg4VEgxcFNnOFBWVkE1ejV4SlRUUU55?=
 =?utf-8?B?ZU9lb3BXTkdiQU5SUDJydFplTDR1cCtDT1djNWVaNk5sMUtQeEl1QWxJWnYz?=
 =?utf-8?B?cjY2WUFyeFdvN0F3VzBrb0V1dVZRSFlFS24wdlZFbmQ3T0lvVkozTHk4Vm1w?=
 =?utf-8?B?MTdTY3JtMFpQdVMvZU81ZjAwYVlPNFBsdjJKK2FLeHhWc2hwNnQrblQzaCs4?=
 =?utf-8?B?VDNRWk05SFJFN29oNUx0R2N3NmZNd3psdFJuL2tjcUJNZmhrcXVkTUtiSkdu?=
 =?utf-8?B?N3huZVJjbGZvSHZqNlNKaVJ0am5TQW9ZaEprOUVSeXJuZFg0cXIzM1BVZHJs?=
 =?utf-8?B?dVNxcGdyTTdCUlBycWVUNXVPNmRMcWVlY0xOODF1Rk0rcHoybHMzaDYxZkgz?=
 =?utf-8?B?TWVmRFRVa0drSVM3QkFaNUlZeEZkU3VNN3Y5UGlZVVgwUjNUN1MzdTVVYUVx?=
 =?utf-8?B?V2ltVzZVRmpXckU0c3NFTFJOUmZ6Y0lVZ1lVYjZOM1FvK0ZFbFBtMXYxbWg5?=
 =?utf-8?B?T1l3dnMwL0llbXEvZWkyd1pNR216aXI0N3ViZk5xWDZYaFByNGt2UkdYWUcw?=
 =?utf-8?B?OHdURmsyZ1hQNUw1M0FHbDJ2SXR4NjZtZkoxWnVVUUNiLy9JeU1HdXpaQ0lh?=
 =?utf-8?B?YnBuRmhrM210Qk51dnNUTXRjRk9YdzQ2SWNDN0owbTdPalVBT3Z6aExpQUV1?=
 =?utf-8?B?enhmZmVWMm04dml1L1F3OThqbHpmVXhiMlhzQlRwSDEyaGlXSVVuS2d6T1pK?=
 =?utf-8?B?RFR4WlorQjdKYk0yTmtzVlpDVThENldYZW8xV0RvWWFIQmxmbGpGK1hOZXRQ?=
 =?utf-8?B?dDQ0Wkc3Y24zdmYwTFFOTHQ0K2lhZHNGNU5XNlJuYWhlMFFsbzljODk0c2s0?=
 =?utf-8?B?SjhWdzFoVEhNTXZWTVlJVWVoTFgzUXFpS2JMU2Q2MjZwamZCNHhXK3pOMzJB?=
 =?utf-8?B?amh6Ny9GZDJkZStxRk1xTWxzQlBJRHRtLzZKRW8rYjRhczRRTVdVRTVMVk5F?=
 =?utf-8?B?S3BiWGcyMWFiTGNNUDZlYkxCVWNNaHJmNzNtQzJ4SXd5aVZ2Y1RQVUZ4RWdT?=
 =?utf-8?B?SFVDOStvbFlIQ3BpdWNWeU5MQzFDd3J5VlNzSCtEbk5nak1uMzMyRDNHN204?=
 =?utf-8?B?NEJEWFJQajVjRVBuTnNDS0NTaUFhN3dEMThwbldlOUNodVZJMmNJNXRlRkJU?=
 =?utf-8?B?Y3N2enlsaEtqTS9hUnZ5a2V6Q2xiREpFZ1RvbEErSVVNeGpGNkVzQUJjWWFL?=
 =?utf-8?B?TEcza244VGQ4Y3YwR1F3VUxhRzNGeUNMeHFJYk83R2xUSko2anBsbmhxSUFB?=
 =?utf-8?B?N0xtcXNCL0w4OHJUK2svRmEvejBnTTNqcDVKemQzc3RCWTUwcVg4S2RLbUtH?=
 =?utf-8?B?ckgyaDIxTnZLNm1aaGFPWU9jaUc1K0Zjcm9HSnFWaGFLdVpsaWZ1REZRU0Nu?=
 =?utf-8?B?TWRrODk5NTZMNEFXOWdVQmE4Z0syNVZjaHVmS1VRV3RKc2xPdUQ1WVVqSXVV?=
 =?utf-8?B?K2QwSWduNHdjNDR1d2daSnkvcVlsdkJRcUlKcVJNZi9VQU5tSXRTb0h1VUZi?=
 =?utf-8?B?bHB2ZTY1MzExYTdESm0zM1UwWC9nODhSaENua0o2SW8yREc5Y3B2a2NOTjhE?=
 =?utf-8?B?am1MOGZ2TEpCelNaUlBtVmxBNmpWcUlUbzArR2kwazhOdlFqSTh6Rnd5VGdi?=
 =?utf-8?B?cFV2cC93MFA5NzErdzRFaHFoNk9pZlZPUUtHblBsRmVUeWNTOS8zNG9GT0I1?=
 =?utf-8?B?dUtPOWVCamlwUWpwaXA5ZnFwQlZhM1U5bWo2SHVjYWJETFhLczl2WE1VNEFL?=
 =?utf-8?B?ZnhHc0F6WXl4NTkrUVRnZTNJbFU2WVRsMnlZQTAwNWRjb3NLRTVnUldlbjg0?=
 =?utf-8?B?L0UrdjlnRnJabThyVWJ1Q0ZabG5QVy9NOUxDbE0wZWpoVkJkKzY0V0dRcE1W?=
 =?utf-8?B?dkNCc1FVMndTNnRaeUlJcmpITTQrcGg0SFpFRzdyb2tUTUtUdjNqN3RtL0pu?=
 =?utf-8?Q?vDvcw5xixErNfe1ecV9GfCB0g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646dc792-f100-4293-aea0-08ddf4f69ca5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:56:58.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDZmLh9g3nE07vDgaergPI1ZrlyRSAtD+epFswAX3IEBJpQYi1tvRW0oOXZn7PTqZGdLFbcbE9pVxq/MXrLtkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

this patch set add DTR mode support for flexspi.
For DTR mode, flexspi only support 8D-8D-8D mode.

Patch 1 extract nxp_fspi_dll_override(), prepare for adding the DTR mode.
        in nor suspend, it will disable DTR mode, and enable DTR mode back
	in nor resume. this require the flexspi driver has the ability to 
	set back to dll override mode in STR mode when clock rate < 100MHz.
Patch 2 Add the DDR LUT command support. flexspi use LUT command to handle
	the dtr/str mode.
Patch 3 add the logic of sample clock source selection for STR/DTR mode
	STR use the default mode 0, sample based on the internal dummy pad.
	DTR use the mode 3, sample based on the external DQS pad, so this
	board and device connect the DQS pad.
Patch 4 adjust the clock rate for DTR mode, when detect the DDR LUT command,
	flexspi will automatically div 2 of the root clock and output to device.
Patch 5 finally add the DTR support in default after the upper 4 patches's
	prepareation. Since lx2160a do not implement DQS pad, so can't support
	this DTR mode.
	

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (5):
      spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
      spi: spi-nxp-fspi: Add the DDR LUT command support
      spi: spi-nxp-fspi: add the support for sample data from DQS pad
      spi: spi-nxp-fspi: correct the clock rate for DTR mode
      spi: spi-nxp-fspi: Add OCT-DTR mode support

 drivers/spi/spi-nxp-fspi.c | 118 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 16 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-flexspi-ddr-f841f3d79aef

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


