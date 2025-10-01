Return-Path: <linux-spi+bounces-10420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA298BB1FBC
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E0D3B877C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D6313D43;
	Wed,  1 Oct 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mDNLZ0SI"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499E2BDC00;
	Wed,  1 Oct 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357458; cv=fail; b=Bkzqur2b+f+yfTeJ18oyzkv0DngeOXFLuF17VF5fZOk5LSjByPBNHZ0A9av0SLOfgM97GPG7RY4tqM/gDlFSD8mhdNnjkkRpw7NcHV6CATTMRl/iRuldyWXIBjIt5+ZI2orZDU8Ea4BhYjMMwZfJpnS8yXtDtIhGz04Y1vUo9gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357458; c=relaxed/simple;
	bh=7yFHZDTm9S6W8TJZL/M1/sCMtKCsZubnBVOvfenNeoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJZXh3eEj8zHStxp5k/LD5uqucfImlJw5vpoQIC5M02K4gokzqcCYtyq1vPMmdPdspeHEa62lFqKRTsO70wMSftF0RkhgMwjdAao5d+AlWnzoRzloJveamUMctg/UriKsuS8PKv6dvFuzE/dZbuhXHsMuxkyRXz8QNNf1vULK2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mDNLZ0SI; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwuDoFka4l+b55zrMBDzOpqXPP+EM+HjSp1tAae6oxWakzWVaUarCnXJcturthLCRdz4mOxLcqWKeCH5Sz8UjP18M7baCuws9ruXA65c+rQJtfggIlAHMk4bXT3vN4/3uUcJ3yuh1aY+TJkFJdbOegDxhlODjn2wAVn6/qdL9rBTbgtfa/6J7kOun1eyX+Fkv8DM51ihd2uyS7MpCTG2Dx2uEWY4aXzOcs6OZ/BUdy34pooz5kg3J0MpQY7cI0Z3awYv2XoCeROzKF0NuRCTA1j0G8nINedQvou/bTbbPhHrtx/CiqLG5OIxAWG2N+sR9dpj9Ux7I5OOxvUrrdlaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux1isKseYcwD6TYau7kY/FyTZaKVnyeDUD3WyihxIOc=;
 b=DvSNU2yVwtn2Nubw9hNZJ/CunEslb9uxYz6GhXGYCfGQ2x4vANMuuSXIvsmonjWV7C/3n/bA9z36SdjRkc5MJNnJcm9NyVaPgSoDFcv9MSMyJXvQGbiMmwrXxUQI7Z0KvVHNhb/cfJpmo410ZGUIAzImR1/QkGlKzhJEyOIDfKyiVCvcgY2kfh+vODOo/29ec9MNoBLEvI9jo5Jo33oC71atG4HZUr9j+PawuDXvSYCPw63m5I6tcIOx4UBx0uCYXYTWU2+VseDwq97ywDbRUlUR5NXivKaGxHLThXpxayRedz0RUmvGgOjd676wAFfk4oTr6MEoB7xsE6lkgdZIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux1isKseYcwD6TYau7kY/FyTZaKVnyeDUD3WyihxIOc=;
 b=mDNLZ0SIqdJWWmUaLvvqh91Q3vNmQ1K0KpHhWUvDlAUQ/4QcjY0geti8VJq098aDYlyTrLLarNhGUvwpit+sT6JDKWPhCHMnRp+BwuKVYtsPdyNRD8m93W8kjD8r98zvbHToIJ/bLyAYbHDJpXiBMY/dhFSLPRE0UsjjwdgilFLjmE0ReUgtlTLaXpcVuD2poZwsp+97gqJsnmJOJEmQp+Nr1cZ9XxOOUfhjTre+aWH2amsPwLBeB+uJlMor/zshW3bVcGTzZBibq5FW7CXk2PTDjQMXbYc9kmikfZs36ynhgqZ7Pe2fpng5Z/fxEIAInfYWHjJHVEmkJWlVMt6DOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 13/13] spi: airoha: buffer must be 0xff-ed before writing
Date: Thu,  2 Oct 2025 01:23:46 +0300
Message-ID: <20251001222347.3386506-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a1df31-f970-4485-6168-08de01393c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XwM4zMsYdWX/H6Y+K/fOeETVtwac3xtusO7C/wmorlm3HJiNbzkH0vFzHsbh?=
 =?us-ascii?Q?rqfoK/205YJFZ/JHkCoSxIHolKL0dM4sRMnc5ZeIMSI08HhEy9/LMVrT2Jyk?=
 =?us-ascii?Q?U5ZCBsbcB0bEHh8IHzC1bGUtG5oap03WEXpEr7HjOBFwQbUu9PUBLGjMGD3B?=
 =?us-ascii?Q?hbCCHUXmenDiRDUNqJyd49wQ1dHHKJAnKII1wn8kcJDknXeHgnNIj2xZ/m3m?=
 =?us-ascii?Q?X1g4BKFf0p3Jd4y7vQL7kz5ll8R6K0dUCLmhEdU6SVM/AYbUOS9fuwyrf2YY?=
 =?us-ascii?Q?YV3S9fPdoed0ailWglT4htFu5HNWX4fM7AdQgKuNq+4uckUzvDntvr8L5d+d?=
 =?us-ascii?Q?QTCI+aOdL1ZwF3SJ1j+4kA8M8p6I9IchHTZe31BMj+WVx4zUJNdSA0O4hOQI?=
 =?us-ascii?Q?wz9+u9Iqsr1luxkHU+odgA1Plzawvbd7olj2jifg3BnPG4FKLhFReWd7s58c?=
 =?us-ascii?Q?0FRnTmChdjrwjlC+yU/Bjz7IGSb/bXNvHoCLgMmtWqacgwoR2/LOiXCPhnUM?=
 =?us-ascii?Q?Tjh/XJzqz+lNKt/ucS3ueA3We7ysLLVLTDMIU8fxEfbQzxuqYqtUWJs79o0u?=
 =?us-ascii?Q?rYrN75KRFl00rtVupWXBnH01f0u1ulzNaAbJpH0Xt2Edtf1GWB7dZsJ6dn4n?=
 =?us-ascii?Q?zeOgdl6IPRmjpips8zCVMPhfmnFOi18skugFysmdgRV/vIR4RwTOzoOt4IXQ?=
 =?us-ascii?Q?k7LusXsHuTiFfAF5U0hzj9nVqrFMxOfbHLtcYO4ArLHz6gCK+T+T7uFhojqw?=
 =?us-ascii?Q?KFqXBJvThOOwe1u9XS85541d7D3Q0/z2CHmT2ZKxJ4TiZn1M/9uFQWSWpzgs?=
 =?us-ascii?Q?tea/jS3+NEP2x9QUsjQpWSdxyOUrafjrtXvb2T5q7jPSOMbw3vP8tF2jWot9?=
 =?us-ascii?Q?NxbWVZrJ/TNd+atazSEccXs+gLXQN57vuPh4Ntq7MGHQHBVV08zMuVA1TkA+?=
 =?us-ascii?Q?RO/fxSlvQKPmFEGWqn1ZW39ulh9wvdGh5VzsFM4RFUolT1wJz3KuBgeRtsjO?=
 =?us-ascii?Q?zrRf/Zoyl/oUBsPXyKfzzT9WVLPjxnLVtpHZeeI0M9S7WbI0NVNPLH/A9XsJ?=
 =?us-ascii?Q?TwT6CxvhN/kZjaP7QcGBexCoJuOrR9COA7MnVzAYubThIRSeBEYZmfvcT6uc?=
 =?us-ascii?Q?qQ5f4MuxLIcmuZMoxOQM1ok/LNVW4RZlK8ffp0EaS+iB7row/j43Cft2QDFd?=
 =?us-ascii?Q?ICc33LPI2yV6POvUu/kuu94yTrVPaPQEd/vAgBL+QfJ4mpCBDay3CfXLyGP7?=
 =?us-ascii?Q?y3PAneuIg/uSd6Z9Q0oWxl73PUNjFK0eM7kNhs1Qh1gI1+VT3kEpdEoyKKUO?=
 =?us-ascii?Q?MLjsNxly0Pt/C+FFZ5gbf1ghTUUBaXuqc6QqvBXd71sL6I0yVm8tf0V4p3Da?=
 =?us-ascii?Q?agWx4a70UV19umCUEJJtu7vxdjux5AThSffSYW8JQu2WC8cnj58Zjkl1h1so?=
 =?us-ascii?Q?E6tomPyWY2T8qmbsbFJSeSWIezunLZv+CVA0JQEi6ntlHPR0bqec0YFXh/wc?=
 =?us-ascii?Q?cDmCLq6taTG0nX+QsrqoslwIFeU8wa9vXtIp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UbdRM79pDUH8z8V59IejjUr3KL441vc6JJW/ksgN3mSwvKle7cqtGQadyZCO?=
 =?us-ascii?Q?oQhpbw+Frvx2y31xWL+o0LcO5RskbS0bQq2UJc8jiiyQjbOynEk50XGoO4hi?=
 =?us-ascii?Q?Odkvb/QM4u1GRHr9i4Ejd0lOYHQ8WSJeF4NeyRS64ZVQNhFZey+pLpw0dm+A?=
 =?us-ascii?Q?9llc6K2Y3vemicvdOso+38BxGey7l2p+brK4HApTVB55YnGNpqEbfYpwPbYv?=
 =?us-ascii?Q?tRK0xsQkh1NPGNHvce/vS+9Mhq7eUmb862BnkguaSy2epckEdasB5JroRgdj?=
 =?us-ascii?Q?wr3/WUtGe+Pj9nHA12ePKNMAUHIv77dcBS3o15w4qGNSHvYz+6gAahSQ72P1?=
 =?us-ascii?Q?QlXFHtprDaNNvqTmk7XWAWBjgBw37O+xkZTYLrqLLCdX/u3uTGnMDRzND0ac?=
 =?us-ascii?Q?c8uU+MrEsk7atbtpDph7hNIaGjeLpokG+/NmrGn3B/GPJweONKxHVfrWPRQy?=
 =?us-ascii?Q?cvtwzKOdAR+DI16PkQSRsW2SJ+VlSkLNPcqeVJAf6H14YQCnkThb2tPM03Dq?=
 =?us-ascii?Q?NaeXutSMli549D2HpHkYHFD2B/NO3wEIuN4sOwleufTuG2PQGg7cZS+cckbL?=
 =?us-ascii?Q?/wlpy2k8JnvO8DAVMIt/ofSd5YIkjaKagvwTwAvtNxgWdD4u0IO2RgUoA5g7?=
 =?us-ascii?Q?W/oSUdIO10vFDJCLHwB7qQfVtnH7aoxJxRFiESj3mT6i9iLivkUYanHRXcbX?=
 =?us-ascii?Q?JU2xU7SPhpQnsU2Dyeq2ASHLiDlF5cqB95mZXy0/098ZDyaA6Oa/Tf5IeGeJ?=
 =?us-ascii?Q?HYIZYbcCnM3ZUECjefiepO1npqY/3j9YBH2+H9L3FPNBNdUTEVXaJhLyeSkP?=
 =?us-ascii?Q?dY53/ZhDAYEOtU+7MD9fUSW3OjfY0SQaF4eHdgpnyf1W6hcZiMoQ9E79KY1C?=
 =?us-ascii?Q?6fNt1kuGKzCzGgb1mbEVF57gRmtNgvC6/w8DnIwDxqp/LRUbwHYbxe6O8vVP?=
 =?us-ascii?Q?wGEk0iCo4wg9AyTg3GH1GwhOHv7m2hYgqiG/OK2DxOcFp6Dmf6GciicB94tm?=
 =?us-ascii?Q?xjXgMgndM0eWbnFDGvUXLO/o8YqU+XmjbUQxsGBw19Pcx7lj/UPNihhKlo9I?=
 =?us-ascii?Q?uS1au+Vn2XtznhJk6Ss6lWPjpJOrf/onersQ2HJe4Lwnp0q1vuPNnmvTf0Se?=
 =?us-ascii?Q?WsEdt/BLBCUSLz/UVlzjemuXqWrbMHZy+7u3h96Lhe0ZJOpNGDoiAdKDQDkX?=
 =?us-ascii?Q?cIHxZdQx7o2AppuzFlAaEssmgpEtRYa/g7ta0kqikWm+vbMb8tlST7yzYtoW?=
 =?us-ascii?Q?YLpg2sDeB2t52i/NEJZZHKUc8N9jaAFxDFIR2yeBnRmocZ+272H8BWY0BhUT?=
 =?us-ascii?Q?FUoPRad+K1SBrjXXCvH011T6M5X6NEimCN1FkwYUiJxxtauaetS5jwe9O/rM?=
 =?us-ascii?Q?fZyXFBF4TtHEsSTtSbG8bpDa37ai1Xl9Oeg4kLeHQBX5vvpYjlzR73FgOSoS?=
 =?us-ascii?Q?g/LWiBL41PzaaL6WWuJMQg+gkaPir/7eQBYf/TT1D0SgxiecUGHF8rbjM+j3?=
 =?us-ascii?Q?9fyhEh3udWaVNNstpdGk7A/1/QutzMo6Gk9a3/yDGWdfyXtTc1qf0WMvn4mb?=
 =?us-ascii?Q?WmrKM/AhBZyrsUcdeL7P0WYRApTWBwDpYBJT2nGuF4mzqkG/0/I+dyU4oipG?=
 =?us-ascii?Q?fsJIKQNrojenutUK6+6j54o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a1df31-f970-4485-6168-08de01393c85
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:07.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBjXzwalB+TnJP8lT3wyDJ9yhT+0kaCQBvdLqUT/b55iLJFexuDrWD6f56lBAZfc+0Z2N6u3xxHp4U2fvSnKG9woEt6xmnAnd/qFyM8n3pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..8408aee9c06e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,7 +776,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0


