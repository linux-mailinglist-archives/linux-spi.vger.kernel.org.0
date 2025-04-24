Return-Path: <linux-spi+bounces-7730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DCBA9A445
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3664B17708D
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB4221FD0;
	Thu, 24 Apr 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YCsuKRPZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37921FF3C;
	Thu, 24 Apr 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479925; cv=fail; b=QmXMQQja+A65iNSmBa8c84GAUkvyjisY4se/yEOoDzpAUYulWPRKFmMWug9FP/xIImuEAj6r05ItJDH3V421DEFpk+eJP3H+RxhDjInRH+HiV1AbxvXVrU2Edm8V/75ziE3oF6LaEKZUMtp8+0gkltJ6LZButdaehPTEuK4k46U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479925; c=relaxed/simple;
	bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sCaYx8FNaY2BsMjhpljQtcYqli6ljVcjBqRyUacfvZVD2VIKJalPlIaR8vxhfqMJ5kpcCyv1C1gkqj9SWjeXsNdCxsWMzNPrES9UcIgW5QcSzogRsxCaaqqyYb0RYkokgYkFZ1xtwG3q83FDj32N8p093s/H3XJqt0HfGR1EKnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YCsuKRPZ; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMmboskBjVtXodqExxEIY3w36yJTjAnicAwMQjE9+0AGQvMg8UJYg4iGu98dlvWOjRyk9zpVH1CaKs+J6C6wFkCPjOP6V5HVAW0N0cA2+COXb8nNLbHC7yGqqQN9zJ5Shkr3RicmLIwIyZ0H9fSupCIOpM+oDKb7Y3x92WHIyhN1lH6YRL4J9UMLyeI1vjS+ikZzJUqrg8/lyo7m3PdmUka81HsREZd13suD5QPxzxQGtyRyVLs5rWnRVVi49hk9S2tv0D6BFGN67fnH1Exat25HlRiaHgqqgi9Qe/YLsE233tlTwAoDE7HWjNac5ski28CWKcaS+9C8s8NjGceg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=S9w3dGYpfAlZBWFJ2d/3YAvGKeOY7WHG6xEZgX3pM5twWHxBsHcrtZoSIznBo9fusVh55+uWF1/nyffWauEuaWoWL2++F9r06RspM2Nic7qjbTmq9RMHJIWdf7cx363f5MNJNlq66L/XXq6KvUrfjo2Dsrk+85l4/ZGJ3GCx2p64a18pg0gBHGUe/DE6Z0382PhTYpL2MReP+WDub2g3Psz/vuQMgEXRpSQ6ez/WjTNe6CaSzCa6lpaUjey/anEamhCI8mMhZMNl1a6xTqwF8VaheCnDDpo4KGLY5NqiNi/1PWVdxsi72gSctp5FAsMqqxg2s9MMHZiU/y6QCiB+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=YCsuKRPZFrf4Pi4TbDFEqvLIleoSSgpas5y7yZnnuvy63y5DofqkRkEYIHATFt699JfrWz/DmfHI2uSaxGTIAFrOeyCaG8X4WElLHTmGNlNlpGEAzJG3cF58oPio6rSv4lGOVa3G16XH4MaBENhf3S6uR4K3+4mdeQM70Df8qcQ9084UZUlCSaEd5q40pesCMjqoQ+1LCzWGjg2PDsss8rT9+RLIx3Nc1lpbiuRNY2yY5woUQXRHoF8Bwpf45aJUISt1WT2NUuDCCWXIGQgVYVGC+HHiYCqyDgXroADco/4SNEZf2FMccBN0RGN4gBlQNPL6s5CSymnhWV6y1tyItg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:32:00 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:32:00 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 24 Apr 2025 15:33:25 +0800
Subject: [PATCH v2 1/5] spi: spi-nxp-fspi: remove the goto in probe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-flexspipatch-v2-1-e9eb643e2286@nxp.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
In-Reply-To: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=4520;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
 b=VLw7pidXB8Jqsl+z6xMnvl1vH/mrPU7Ni3qayDG8iuJR1492g6x4/2V6ijAIKepo9O5K2fErL
 7UyZaT71w0uCnfYwYpMVvnv5Rd2sFWVdV237z1sYnjisccNtitrO2Js
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
X-MS-Office365-Filtering-Correlation-Id: dd2e8777-9105-41e5-9cc3-08dd830219ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2YyOTNHZEFYRG9ZSWlhcjJPUzhpa29LOTVzS0pjYjU5Y3dGYWlQUmdubUhS?=
 =?utf-8?B?Wk14ZW5CNjdlSXEyKzl0Q2FFWmNOaFlaWjkrYmV0cDZzVlJqQW9rUHBTMEk3?=
 =?utf-8?B?YnFZZ2ZCM1ArU0c3OXRBdFFXMnRPTlZiQVNvQmtwVG4vVkNZSlFxdGZVT0F5?=
 =?utf-8?B?TXhMQTB1Vy85YU9GSEFnQ3hSRk4yd29hUkJiNE5LclF0VnBWeUdQcnZ1elNO?=
 =?utf-8?B?TlR6UUlJdFZnWGQxaVo1LzdMdGpmd05kc2d2ZStzU3FuN1dHTW8xU0dUOVp3?=
 =?utf-8?B?dDBHUTZIS0dlbXo3MjloTmpFdmorWStjOUplMjk3ZjZTdXdGMjRySmVZM05R?=
 =?utf-8?B?NStMbExLOTc3UVZaQ3NWcm0rTWdUMDd0SnJpU0JoM3RWSUNXWUg5VXU0T3kx?=
 =?utf-8?B?TmZBblNxbFEvVkR2YXFMR0pUVXVoZG01VnBSazdIQ1FMZUM3VHluWW9hMmo4?=
 =?utf-8?B?bHN2dTNmRVJ5YzcvY2tYanJTcUFaM2tWVFdkYlhvV0dGWVE2eXZacTE1ZzY1?=
 =?utf-8?B?N05Ma1MyK0FkZXZGZ3RSS2lqcE9RNzV3TjM0Y284ais0TjEvemJSQS80UWVy?=
 =?utf-8?B?UThmK1Yycm5ZNXNuTEs5QmtNaTduNVRqQmRXUTYzbWp0MFo4alBocEdNcnA4?=
 =?utf-8?B?Q242R25HVkpNVjBUT0JNanFGRWlmRnRJYXhkZWo2MWtITW1ESFkzeUhRWkxM?=
 =?utf-8?B?b282ZHZHWWhrcCsrVllXR1F4QzdxeHM1K0hSWGFwV2kyWjE2SzNtTlQydkNt?=
 =?utf-8?B?T0JIcGtRM2dqcE8rdjNOQU5TUWNhVFd3a1NzWFVVdVhWSGZFWENQL2ZYM3lH?=
 =?utf-8?B?QW14bWlub2tFekpTSWlBVmt3cG1oMHMydFJQUmpkb1c1ZmErbmlYZmFIY2hQ?=
 =?utf-8?B?Sm5mRGdKU0J6ZnBMZWpzT0QwdjVqT0dRZlljN2wvdW5qeUZ0d0pFOWllc2VQ?=
 =?utf-8?B?NjI0amxIb0hRUTV2Qk9uRzJ3Si9DYmppUWRkSjJKZVhvWHE1dDM0Q0ZTclI2?=
 =?utf-8?B?NGRNSGdTcjFQdGpzNzcxYmhORXBRdXg5NzZrbDRYOVVPenBFQXAvaHN2cEZE?=
 =?utf-8?B?WkxYWEJ0ZGZRWVZ6V0kyNExYS21UMm84TXFReVdCRjFPbnRrV0I4Qzl0d1dl?=
 =?utf-8?B?MFM2TVdlS0dnVnVSMVB0bTgyRFl0VEE3b0prSjd1OE85SkFJNjhjclpGdlBO?=
 =?utf-8?B?OHl3WE1ocVAycjBZbWtNTFc3eEsxanZPREN1enh0LytJQThRcTh2djNiRXNy?=
 =?utf-8?B?UlRHTm1mdklFM01JUnJ5QkFjaytkcTdEd1dDT3FpUVlFTGxDc1VPa2pPeVU0?=
 =?utf-8?B?ZnZvejdZTHVkNk1EVEZPTk9BaFVOd3dXOHo1OE9kWU5ZMldSemdsRFE5bGMy?=
 =?utf-8?B?Ui8vVVRwZEk2VUtEN1k5TGtUSTYxc2JxUjR6YzNObHRRMWdMNjh0TEYzVWth?=
 =?utf-8?B?ekJaU0RGUjUxUjYzR2s3a3kxc1FrVUp0Rk5DZ2huRWtGOGpoSllRZVZ0a2sy?=
 =?utf-8?B?MFdRWE8rbStPYVNvSm54dTdwZ2ZuOHpXUStKSUx3K0JnSEVta1J0RWxabWN4?=
 =?utf-8?B?VlMydU5Ib3d2YlZSNmRLU2tQcXdOTXZyVWR6SE5kQ2NycHVweDFQYTI2Y0Fv?=
 =?utf-8?B?dWNENFlpa0ErcnVQUUF5V0JFa2RiY2FBRXZqem56L2puT1VYcEZ3TUJ5L0Nx?=
 =?utf-8?B?ZDZieEZRNmNVNWRYbi9CY0xFTG51bWs5d0hKdzc3ZWxzN1VybjRkdUhad1NS?=
 =?utf-8?B?V3lvanNKc295QnljM1JRU3VtOUZYNDQ0TDJrUGNJbkoxVnM2c1lXbngyM3dp?=
 =?utf-8?B?dGZCV3pIdkRTOTFzUEhjd29TdHVHa0pLdU5tK0dLaEFtbktnbWI3dGN5ZDFD?=
 =?utf-8?B?eWtoZnJzaUd2RDhySTdsc2t0dWZHTzc0WE1FTUJzZUJZSDd6OEVxMTZJUHlk?=
 =?utf-8?B?eWEza3BKcVBMeEZTV0dDZWwxTXdTSWJRZGdiMWJ4aDdpWW5md1hBUXBpYkRC?=
 =?utf-8?Q?JNDQtjyU++kmxHWCOesztxDjScLq9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3p6SUhFUTh6VUJUODkrVDFqY0ZsNFRJN3BxV2tiK1Z3S3Nla0lrbXZKd3Zz?=
 =?utf-8?B?VnZSQXNMVFgvL0F0eEswRTdtRDl3NDMyZDBCeFVvbkowdnQ0L1VzNmlLT2c0?=
 =?utf-8?B?UG1ncjBsTEJQMlJYWWZ0dEd3UnFnM01yeEVlR0xhaG44UlAzN3hpd0l2cFpw?=
 =?utf-8?B?TFdUYWc1MWdkUXFYMGxaa1lIVHFLem9TRGkxbkVMM1hjdzNPd01vTWdYYzJz?=
 =?utf-8?B?WGpxcE1uQjJLc29kdmcwdGl5N2ovV1B1VGF0ZWM2d0h4MTZmTHRCU2lqeURW?=
 =?utf-8?B?Q3dueWd3SXBwMWc4c0VoNzkyR1JXeWZpaERPYmw3QkkybUQvWVFWU2o4VlRz?=
 =?utf-8?B?M1NaVVJ5T2RkajBrcmlVNjhxZTkzYmEvd0NiTHdUMkdQWVFNMUJYZUtTQ1Ry?=
 =?utf-8?B?dXY0ZnFuYjRPelhsNXI0bFFDSFhoQzdJNkNHOGJGVnpJelpnMVJXQ0tqRUpx?=
 =?utf-8?B?RFpaT1BaOHVkN0Rjb2VhQVNvR3lJSEQrUGw2c3Jpb045V3NyYkpJY0s3QjZn?=
 =?utf-8?B?a29SYTBxcGtjUFdEd1FOYlFEajdwZmcwcXhpdHpnKy9aZ2RRcDZmS1RSK1RY?=
 =?utf-8?B?eXZlclFCWGg3MWJKem9tUmk1bU5NMTZwelFhcktOSXpLTU5uNE1VMnlDV1dp?=
 =?utf-8?B?VTR0K3VPU291QUlrcXlLR0ZoVk9hd0dnS280UTd4QnUra0dVN09VN1NIVHhy?=
 =?utf-8?B?RWROb28yVlBpUDRFSEtLUEczanp6bWFBK2dtVW1wSFhSZVJsKzdvVTRDS2R1?=
 =?utf-8?B?VENJeE5HcUVDTmxwSDR0TUlXSzBLc2VOenVFMGdLUnplY3dBVDV1aHA0cm83?=
 =?utf-8?B?Q0cyV05ZTER5OWF5L1FIa3ZPeTNlUGl6WEZGUm85OHF2SjQ2MzB5N2lEbHAy?=
 =?utf-8?B?WVdTaW4xVFhZbFF0aUhzVkw0Z3hOS09iZlU4U3ZMbjhUWkxRWnZaekFRVHBJ?=
 =?utf-8?B?YVNzVnRTL3NjOGwvQm9nbmVNeTNWSFFxTXlRQUNVYjZ4cXdGU1laYjRMVU9i?=
 =?utf-8?B?K2I3WVY4TS9zK2FhaW8xdHhPZTNadEZ3eEZidXFaVEUyaGdEMzRJYmhtN3Yz?=
 =?utf-8?B?TUlEalFlSGZqWkJjZlVGRVUrZEhpOUZ4SE9Za3l2VXloMFdINGpoSlI2QWlZ?=
 =?utf-8?B?VmtsNGlnUGZMbmFjNjROQm1GL2xxSWhyc1pKaGx1Q0hhVWF0THNsNktMNGlw?=
 =?utf-8?B?clNvampKQ0lVUTNPV3A5cW1tdGpmVk1Qck9kNEs4NlVOcko2bTZZN084Qk43?=
 =?utf-8?B?UWxucURsV2hBY3FuazhVVFAwS1NsWndhbHU3TDl5OVIrRThDdnpoVDdwemFC?=
 =?utf-8?B?L1QyN1VXa21ENVhncTl4MnhaTmlQaTBZZXBMNFBGWTFWRDdqUGdUOHZ3RTU2?=
 =?utf-8?B?MjlJVWs2d09vR1dRdExXcUozc2QrRC9iVFRGZHppbnltYXY2YWViK1gxL2hJ?=
 =?utf-8?B?TjdWQmZNKzNRN01xbHRONm5zVVR4ZzQxMnhwWWN4QmVQUEFiZ2dNRVVHenpK?=
 =?utf-8?B?WUp6QkYycFgzVDl1TnE2YVhBUXQ2a0RkNHhVVzhCNUdvNVpqUTBydnREVExH?=
 =?utf-8?B?U0pqUUs5V0RkSjZWbGFtSmp4QVh0c0pmLzhvbGk2dTdyS2IxbG55VStqbDJw?=
 =?utf-8?B?alMxeW9SdVVyVmJ3UytSVmZSRDdRODFlaHFta2RNNllnOVJmV1VjR2FiS2px?=
 =?utf-8?B?TUxCdEZLbS92RWlUQ3NHcUdKMm9yL0xtYllGS3NRZ2RRQ2JzQzE2UW5SUGl0?=
 =?utf-8?B?ajRaT1ZPNlp5WlFiSmxFV0VUK3lXWmpSWmNPeEc4bmVSQWhwaWl0WUdEZWNk?=
 =?utf-8?B?Uk1qUk4vVFZHQTVqQ2M3MGtBVDEyVEpSWGJLa0FKV1BBSzNneHFYWFMycUpC?=
 =?utf-8?B?eHVrMm9lS1pva3NjMkpWQlVrcityRU1NS2x1UWlKN2FXY08wYk9CUWZnNXhO?=
 =?utf-8?B?WFZZaU1Pbm8yV3pYVzljSmJKa1l2bWVjeGtzMTRYYVBlWW8wV2wzbWQxY0Uz?=
 =?utf-8?B?MlZhd0RtQWdwRHh1UVc3RjVHc2J4ait3RXZXdHlMWVZFenFsNUVzalowSW1q?=
 =?utf-8?B?ajd0dEdKYU5XcTl0R1B6YXNLYk1WZ2gwS1BrRHZXYnJmYitWSGxteXpTTW5v?=
 =?utf-8?Q?eUidvn2cxF5AtyAR3YfkDrV7t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2e8777-9105-41e5-9cc3-08dd830219ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:32:00.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeJwCQlTihRVTkLHoQMhhcx439uBwfox2+2iQgAXFLc3Q2oARuTOPOpOLHQtioDHXC7DX1CyHjThZMCZuEJtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

Remove all the goto in probe to simplify the driver.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 87 ++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bad6b30bab0ecb90d0aaf603b6de5bc834d19de6..00da184be88a026bf562c9808e18e2335a0959e9 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1161,10 +1161,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct resource *res;
 	struct nxp_fspi *f;
-	int ret;
+	int ret, irq;
 	u32 reg;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*f));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*f));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1174,10 +1174,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
 	f->devtype_data = (struct nxp_fspi_devtype_data *)device_get_match_data(dev);
-	if (!f->devtype_data) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!f->devtype_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, f);
 
@@ -1186,11 +1184,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
 		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
-
-	if (IS_ERR(f->iobase)) {
-		ret = PTR_ERR(f->iobase);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(f->iobase))
+		return PTR_ERR(f->iobase);
 
 	/* find the resources - controller memory mapped space */
 	if (is_acpi_node(dev_fwnode(f->dev)))
@@ -1198,11 +1193,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	else
 		res = platform_get_resource_byname(pdev,
 				IORESOURCE_MEM, "fspi_mmap");
-
-	if (!res) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!res)
+		return -ENODEV;
 
 	/* assign memory mapped starting address and mapped size. */
 	f->memmap_phy = res->start;
@@ -1211,69 +1203,46 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the clocks */
 	if (dev_of_node(&pdev->dev)) {
 		f->clk_en = devm_clk_get(dev, "fspi_en");
-		if (IS_ERR(f->clk_en)) {
-			ret = PTR_ERR(f->clk_en);
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk_en))
+			return PTR_ERR(f->clk_en);
 
 		f->clk = devm_clk_get(dev, "fspi");
-		if (IS_ERR(f->clk)) {
-			ret = PTR_ERR(f->clk);
-			goto err_put_ctrl;
-		}
-
-		ret = nxp_fspi_clk_prep_enable(f);
-		if (ret) {
-			dev_err(dev, "can not enable the clock\n");
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk))
+			return PTR_ERR(f->clk);
 	}
 
+	/* find the irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq source");
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't enable the clock\n");
+
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
 	if (reg)
 		fspi_writel(f, reg, f->iobase + FSPI_INTR);
 
-	/* find the irq */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto err_disable_clk;
+	nxp_fspi_default_setup(f);
 
-	ret = devm_request_irq(dev, ret,
+	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
 	if (ret) {
-		dev_err(dev, "failed to request irq: %d\n", ret);
-		goto err_disable_clk;
+		nxp_fspi_clk_disable_unprep(f);
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
 	}
 
-	mutex_init(&f->lock);
+	devm_mutex_init(dev, &f->lock);
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
-
-	nxp_fspi_default_setup(f);
-
 	ctlr->dev.of_node = np;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret)
-		goto err_destroy_mutex;
-
-	return 0;
-
-err_destroy_mutex:
-	mutex_destroy(&f->lock);
-
-err_disable_clk:
-	nxp_fspi_clk_disable_unprep(f);
-
-err_put_ctrl:
-	spi_controller_put(ctlr);
-
-	dev_err(dev, "NXP FSPI probe failed\n");
-	return ret;
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 static void nxp_fspi_remove(struct platform_device *pdev)
@@ -1285,8 +1254,6 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 
 	nxp_fspi_clk_disable_unprep(f);
 
-	mutex_destroy(&f->lock);
-
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
 }

-- 
2.34.1


