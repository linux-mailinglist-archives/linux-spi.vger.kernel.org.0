Return-Path: <linux-spi+bounces-7734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30BA9A457
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568FC17C7B3
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEB2253EE;
	Thu, 24 Apr 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTaMnGYg"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A35224AF7;
	Thu, 24 Apr 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479936; cv=fail; b=h9KP7PzniMI6V2dJ5xOmJuRsX2asskm0o/M7AhQ0gcgeEu2BgUdWtzppnvQHqqfex7xcMyd6zTE9NPXTCVnlV3aEwcDIjSexriOOpVv7yw1M1IVG5T3xTzdqt8vOiNNe81mrP8PJ/zJOkrDkBfYSTfdlUEXD0ijVeZmu2XRZGto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479936; c=relaxed/simple;
	bh=UO2CF2T4R+GBDa+q0lxOzRC6Kwy3H7zH55tkSSNRgyE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eMBZ419JhAjnJDwx+gn6TvAJ49rUB8Q7Q0kC9YTQb4LchzKk11ypfQCigPRQKxF7Kk1zOCj+jzy4pkr4ik0c5SeSH6Li+TOj5ZoadrnoeA+cqab+eGEJb8Sro35JogwQDUaa5ZbabVskrCD5oJw8epYBQtxfpjDebgmn7zafrGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTaMnGYg; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOuWlfq++eDqy4dDABf+LMGNBr/vuR4xCfonIPaNLpn8NVKlDW/Z8JFU/CDmFLgzFUiZFAc1f12fVqLj/ekqylckbajFJZ/+uLEJzX2GrJLavjKpCgNAJCN3SIsnzDnuFi9XljJNLvzZ35q1FeItF2Art/2aH9qnMGa10ursT3vGfgaq91mGYOVKFpuCZEQADgRi7somkWE1sP7ZQxfEtw2Iv8UWSC8JbwjTpqy8zifUr6O759DowgxgJPGPUE5fbeU1752GNMYWicaa8Js7RiaIEnqmSoNuwgqPWgUYwunPlkn9SUjIoMvLo5r8AVBavEnqZzAY0+siyUCQ6S4ahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDVEtT+ghwB7UYmNXOMxNtqKDgs/p1o6yr5FXZMUYbs=;
 b=Vns8vuHgBrtZGjzjVsRnAEo+e7Sb7DMVr0xHNu+u0aMB27fCqtmP0N4KzzkJLf6aVQgtMpV2f029SZofaiVkluyF0mDzH2kQsXiwt36sCDYj7HO+I+NlIiz0yeml2oAH+xOeLNhirzzQUWREXiiZEPOdq85q79t3TbuBuenAt9B/BTupGDJD7/Ebzun9fjNmDSQEvjvEw/CHFbj61lNF0OfXFVQoyP7nAgP6/HWcoNQzYI+9HbSa+qrpzTcc78jUtf7xcX7xDzqmP29rQNhYMgjDJWpezjUaUWUsd599TjuDTrRgnzDAHRgrt5PXb+19XGoJFPuFk6XM0X4tXkZrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDVEtT+ghwB7UYmNXOMxNtqKDgs/p1o6yr5FXZMUYbs=;
 b=mTaMnGYgjdDv++OpF8meHqAOkQAY7IKs2MYBCf9rBgLJRX+oBX2BHKwS8kHLCF/8yz0gAQy1QOfdUGhZQKYqZxe3IVwT0lxi8k8E29wEAJwnsMedXLlOlToeczM+H3I4RAUalV1QPCi8pj4HOZQgmgk3EyS/22+HL57e2CTeulx4/AFAkwBfxCQJjIMwz3KlSGODyruYqkBSuzSO7mx3tsNsOChZCleZVYQZyFk06Y0V+U3Br8rIgL8BC8A4FpPFlYRoNdmrQr6xgPVmBw5fw3iMhcSXRTLdLLrLX8wlHSIAAHibayZtXfp1oPFqO7qnQ2jV04wkJrn/+sAhrAeXcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:32:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:32:13 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 24 Apr 2025 15:33:29 +0800
Subject: [PATCH v2 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-flexspipatch-v2-5-e9eb643e2286@nxp.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
In-Reply-To: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=2545;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=J8Ud1vZfwI+2gILbpmyg4igG8KXXP6V/mjMQU/4wy7E=;
 b=6trq19sOhlpxlG8D52TqKfV++AZsvV18RtSepTIjv7y9dTimzKGSFGTG9CKb69k5IVOH3qvi5
 8vwYsUA+V/DBLoDBhPVl1Es5LAsQhwU1oCcDQ/Wc48cvpfhYYbW3efm
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
X-MS-Office365-Filtering-Correlation-Id: 25fb4920-7f9f-4e4a-afbd-08dd83022139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFUvMWJkOEtCaVBXTHQzV3hxTGFWVG1XRk9pZSswV2Fobnl6Z3F2MnFzMEJx?=
 =?utf-8?B?czNqYlY5OHZsc292ZGY5WU1hOU0zZzJRK2Z3c2pBdmQvaGlHa2ZpRFN5ZDg4?=
 =?utf-8?B?OHNuZmNDc2lyenhOeEtTWmJEbjI4aVZyZFk2OXVjcFdvM1JQbCtEdFMwVVJq?=
 =?utf-8?B?U2kxTERhdEFLZkhWY3JnQmtnRDRXNmY3OXoxcXhQVzJOUU41TXpLWDlTQ3Jy?=
 =?utf-8?B?cUMwd2FWNkNMSWIyOXJ4a3kwb2JrMmFJbWJCTHZ2ZERvSFVYaWVJMC9CaEhL?=
 =?utf-8?B?dEFiSGcrTXNKQWdNT0hFZkhIdnlsbnlYMDV4K1JBbkhFK0J4LzUvOUozcVVl?=
 =?utf-8?B?Z1k2QWxTd1ZpaS9LdTFCakEwTmZMa1UvdDRRNHE0UVVKK1pZYTNiWDJIUkJC?=
 =?utf-8?B?MlREZkx5eVlsaGNnbzMyVWN6cWhGMHFINHZONjczMWdPak5XWlFsSWluL1pw?=
 =?utf-8?B?UkhENHl4Wk9OSVhZNTRvaWpnYVg4QkVJQ1prbVhPQzR2ek10SEc0d2FpVmRr?=
 =?utf-8?B?dmN6ZndnTUlHSWVCOG5PaGZmOTlGRFFkcDBLQk9SQ3Yza0d1OGNBbElmbkgy?=
 =?utf-8?B?YzljaEZUeStWckY4WndvQXU2ZDNVOHhIRmJoaGVGNFE4NEN0VDc2SFM0bDRq?=
 =?utf-8?B?Qmx5aVh2d1lCcEZzUkw3bC9ZNHVYeEsyci9qWkZhRUNGVC8xblVMeVY2R09u?=
 =?utf-8?B?SXlNWHMxQWVMaGl0L0F5KzZQb1dVaGRTWGQwcnFEVTNBdzdCeGdaSnl3WjEx?=
 =?utf-8?B?NUpheUc4cUZrazB6bEpxQ2ozZUhmOXA4Z3FRWW9XTjFpRG10eEdSalJGNEdz?=
 =?utf-8?B?RlBlSk1KTC90bmRMNTNOVklFZHU1bGEvOEZwbHZGbHVHcURnQUtrOUMwME0z?=
 =?utf-8?B?N21weVJTOGV1K2Y1MXBtTXpaMDV5RGl4dlpkbiswZTVKbUsyUEpxT0oxSktj?=
 =?utf-8?B?amVPNGxlanY4TW5aNjZOc1Q0cG1OVkJ3TFVXMTdPbVovZS9GaFNUODFDRWUw?=
 =?utf-8?B?WENyRXkvZHdxZnFSNDJlbkpCVlBLekJTbzFYYmhyTWpWelZaRGNzb1J3TWFl?=
 =?utf-8?B?anZZTnVjSkh2Y0grOTFmL2RBVUh5TXhtUEJrb0Z5cXJQbWJuZXp6WXNmYlhk?=
 =?utf-8?B?MHpzZjBMdHdMVDJlSjJ4NEI0Mi9GOW9sRU83UHlSY0ZTSW5QZU92cVpESDlB?=
 =?utf-8?B?b0NmbWh1bkcwSUhVcHk0VWpoZmgyRnBaeHdSeHR1NG5QWGdSQ2ErSWtlWU4r?=
 =?utf-8?B?b1IxODVBYWkvWGRmOFZBZ3pCck02M0dNYTQrQWd4ZVF5WXZXejR1NDdqL2Rt?=
 =?utf-8?B?S3orQ016Z0lpWHYySmZvYjhLZ0NrQ0d2NDNQc1N0ZlVybVZ3UHVWcHp2UG5q?=
 =?utf-8?B?YWxseXk2QVR6elNsRndEcTNSMktxOEd2dEtPeDNWQ1lIa3puMjJRMGUvMm5F?=
 =?utf-8?B?ell4SFFnRlR5QWcyOHV6U1MxTytHNmprYTNjSmR1UEUxSnlmM2tybzdTa1Fs?=
 =?utf-8?B?NFVmRmdZVFVId2FxcE5YNzZnSkc1bzJJenNvdzRQQURiYndXQ1NmbVRZNkF0?=
 =?utf-8?B?ajVLTkQ0RTJ0ZEJPaFMxalpnWk5iWFFzL2VkWWRUcGN2dERIWkU4NE1hd3J0?=
 =?utf-8?B?a3NhZk5DR1BLd2twMmQ0ZWlPUSt4RWpRY2V6bGtZN3dYMmpxV01vRVY4K1VX?=
 =?utf-8?B?SWVEdkg1QlBtUkpYOWYyR2JPNVFrOHZlVE1PK2VwaG1JZUNxdlRKcmFXT0N6?=
 =?utf-8?B?UHlNV2Q3MjVxVHVSOUg4dXZvNmJpMTlFUmZKMUFWTW54M2pIVGR5Q3lxZlBl?=
 =?utf-8?B?ancrM2kvaUM0QXVrNFNUbkFMbi9wM3p1dk40MWRxYVZRb21JOGJLTStNSXha?=
 =?utf-8?B?ZWx2bFQ3V0dLK1IzLzkzTnpIVndnUUNuZ3RUMWphbmU3VXBnVG9YYkdUcFRU?=
 =?utf-8?B?WXhSWEVGUG04OVJlZEptTnBuMkdYSFdJSjJFU0ZUaE5VY0F1di9aZm9zeU9R?=
 =?utf-8?B?TklJMi9MbjNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFYxK0ZhRzlSWk5vT0t0aUsvekoxdUhJdnJRNUxnNlhBc21ra2xwWTZERHF1?=
 =?utf-8?B?TEZKQldObTZsRWNIcG8wN3VuQVJaR1JFZWtwbDk5NUY3S2RMbUFMdHowSGxC?=
 =?utf-8?B?dDlhU2J6QTJHNktxZllsU2Urd2tNeXJqUko1ODJpRjNiYUFNbkltVzE2THc2?=
 =?utf-8?B?VmtOVUJDMlhTM01TYzZmNzhqbDRrZ3JqUjFoY0ltVlBRN09OZ2JGT09LUHdC?=
 =?utf-8?B?L053cnNqTGd5ZW5FWmVBUis3WU0wUkZvV3pYVEJTK3NGakFHNnRYM20yMkNS?=
 =?utf-8?B?Zkl3OXZQcjRuWnQreUxkS1pTSG9tVVIrY3d4aFp6bFBtOVVxQnp6MjZidTBV?=
 =?utf-8?B?d2RudXJYRzRrWW8wQ0RXOER3VjI2cmlIazAxSGlMWkV1SXJ3cFo3L0tOVEV1?=
 =?utf-8?B?UDdyZTF4ZjRiQWlrNmtiSVF4UVNDNUYxOG51SVVEeGJzTDVZWVA4WFN1NEhI?=
 =?utf-8?B?VmtPd0xlZUMzdjJXVUE5YXduQnBIOVF1SEs3ZVR3YkREYWNXOXVpd2JHd3VN?=
 =?utf-8?B?SUt3TmRkdFJpMjg1czJyYUtrLzRKdzNrVVlwYngySmp2V0NwVkt1N2pqSHZv?=
 =?utf-8?B?MEU0K0hiOUo1S2x4bG5OMFN0TXAvMlJGdUhKbXI4TWVZTUE2ajZtWHdCTGlM?=
 =?utf-8?B?dVNJQkVGc2U0VjRoV3pyR09WQ0dzb05LSStIYk9SVElNa1JXWGtjZWE0QlNU?=
 =?utf-8?B?aGJ0Vk8zVGVON0ZaVk12NVUzU2RJeWJyNit1L0Z2SngyYnRwUjZPT3BFRThV?=
 =?utf-8?B?cmZ5RE8zMmJSRTAvQXpQMVJIWW9WR2NlTE1tOFFieVJ0YWd2UUN3UHlBc1VX?=
 =?utf-8?B?RWVIQm9qallCanhZNTBZVGtUTFE5RE1zUWZxSFM2TXc3ZzU5Q0FqK0p2bzZj?=
 =?utf-8?B?Zjh6RjViS1Q1RUdsOUZNRUdBNEMvNVRNaEYyMmtCVHVVVFprcjFRWGZYMGc1?=
 =?utf-8?B?WG5pYmJsVGVSQXFwa0IySjVQbFREZnI4NWFPVWxBellTQnk3WjR5eXNNanJw?=
 =?utf-8?B?VitFM2VwWDl6cWtJMEYvL3ZSNzQrZzh0bFVFaFJ3ZXZFTnl2eG9mcStoOTc0?=
 =?utf-8?B?MWEwYVVxZXVqcE1HRlJKcmFuaTlYQ0ZZaVJlTURDRHdLNUFQeHM0R3cwSWRw?=
 =?utf-8?B?V0NQbFFzcTB1WmZJWnZkekQyZTRxNW1LTllUUVJpNWtHSDRLSXN3aXVMTlJG?=
 =?utf-8?B?WFpHMjFqeWh3K2ptS2Z1Q2o5MHpnZGJsaTdxeEVUZVM5ZGJwNUpRQ0ZQR01S?=
 =?utf-8?B?VWt2L3RLVzQyTE9QVkFMcEg0eEZidUY0SjVzUk16OVBnMFJBbU8yckxyRUJT?=
 =?utf-8?B?cWdzdmRIWlRKTllvNys4dTZLeEE1Wkk5bjdPRTMydWtnbitIL0ZiZ3VIMW43?=
 =?utf-8?B?YUVQc3lIeDJKdlhvN0ttU2t3Skwyd1RYcm9uN0RSam1pKzFmcWpxZllwRjRj?=
 =?utf-8?B?c2FjdGVVb1FHYnJDR1JVeS9BNWpGREl5Q3draWp6S3Vtc0N5bWRiN0Vhc2pq?=
 =?utf-8?B?YXI3RXRVUlN0TGVVdHE3T1B2cHdKOGtsNlNFZTFERVhoWTVpR1c4TGxla3Rt?=
 =?utf-8?B?bWZQM0FJODkwbUhsZTBwdTlVRUZiREFLYnE3TlF4K3JTbmtqUExUbXFwVDk5?=
 =?utf-8?B?eUhNNWVWenhSVm1mRk9tUXdwT2lVdlBOQzBORFZTR1UyVUlsS3dndk1ZTjkx?=
 =?utf-8?B?eXhuQ2tycE9aeHlPMnpvVkhkNDJGYnNqZkFzVkpXUVY0QzBJaHovSkUrTXZ2?=
 =?utf-8?B?ZUhzYzdrL01DYlhvODhvMVpuQ0FDSVpUNUk5eGF5aDJ6Ykdtcm1zYnFGWjBY?=
 =?utf-8?B?RmI0S1pLTCt5TVpXc3ZsbVp2djBYcUw0SDJVcXNLMUt4NTdpYTRzRTQ0UE53?=
 =?utf-8?B?eFJhL1FCTkhsa2ZuQ21zTVBzdzhXMmM1Y0NlNDBhdVZseU54TFFsVHBZdTAr?=
 =?utf-8?B?a1ZvM2cvdWE4R3M5eEdxQXhRZGlZQjNYREFpSlhFUmxGUWtSd3NZa2ZGRTl0?=
 =?utf-8?B?UVNicWdKL1hXTmZzZ3BpajBHVDEyU0xSVjVsM3FucllidHp4OHBpak1CeFFX?=
 =?utf-8?B?MXRYNERHdW9aaTdyNUIwRHdkV2R0NWVEc2NnZklDc09HbzAxOFh2dkZzZHg1?=
 =?utf-8?Q?1ReyqyNHl5hNg/xT5MSPuGwUf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fb4920-7f9f-4e4a-afbd-08dd83022139
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:32:12.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hasNsyEoOO6GUGtyE7+y9uQd0R7YnoA0A6lZsegLm4kFduNlGstduRsYyKEJAU1UNI9XV1Bso4yng5r0upDmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

From: Han Xu <han.xu@nxp.com>

fspi driver use devm APIs to manage clk/irq/resources and register the spi
controller, but the legacy remove function will be called first during
device detach and trigger kernel panic. Drop the remove function and use
devm_add_action_or_reset() for driver cleanup to ensure the release
sequence.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 5be7809b4a494e22ac79c07b99cfe8b2fa430ebe..15dc32b7a830079764520df10a143af1f2feeb43 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1168,6 +1168,24 @@ static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static void nxp_fspi_cleanup(void *data)
+{
+	struct nxp_fspi *f = data;
+
+	/* enable clock first since there is reigster access */
+	pm_runtime_get_sync(f->dev);
+
+	/* disable the hardware */
+	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
+	pm_runtime_disable(f->dev);
+	pm_runtime_put_noidle(f->dev);
+	nxp_fspi_clk_disable_unprep(f);
+
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+}
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1263,25 +1281,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
 	ctlr->dev.of_node = np;
 
-	return devm_spi_register_controller(&pdev->dev, ctlr);
-}
-
-static void nxp_fspi_remove(struct platform_device *pdev)
-{
-	struct nxp_fspi *f = platform_get_drvdata(pdev);
-
-	/* enable clock first since there is reigster access */
-	pm_runtime_get_sync(f->dev);
-
-	/* disable the hardware */
-	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
-
-	pm_runtime_disable(f->dev);
-	pm_runtime_put_noidle(f->dev);
-	nxp_fspi_clk_disable_unprep(f);
+	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register nxp_fspi_cleanup\n");
 
-	if (f->ahb_addr)
-		iounmap(f->ahb_addr);
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 #ifdef CONFIG_PM
@@ -1365,7 +1369,6 @@ static struct platform_driver nxp_fspi_driver = {
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-	.remove		= nxp_fspi_remove,
 };
 module_platform_driver(nxp_fspi_driver);
 

-- 
2.34.1


