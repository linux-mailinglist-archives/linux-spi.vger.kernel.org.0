Return-Path: <linux-spi+bounces-9470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34CB27EF5
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EA93B29B4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A5264A8E;
	Fri, 15 Aug 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wvr3i3ww"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA124225A4F;
	Fri, 15 Aug 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256594; cv=fail; b=cZF+zLQ0Q4fFcv4yod2QUyXVUAZcs/T6+m787WzS2zC/VnX0l+aVzbub86PE7FZtUIbSIt/T698rcYImp0JZW94lyPC2Rz+TzihPE8jn2ElsUNbuyfmrC099e3XU6znOuWsrwrSgu5Sbx26peeeJmYnlLwcM6dW+5oErJWu/GS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256594; c=relaxed/simple;
	bh=jS/jYd7TgwICK3msvYObWdyxC0Iov9l3TYyQoO6zPyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIk61kmVwWBqaT9PWg+0dsoQft3XmOg7Rt6SHwUFv2dCLsFIQszbzfPn/ujoVs8FgYDuxg50LaVDQcDQ7a4Rt55mJRqRSu1kTIWkhmuAvz5hJXC3stMYwruOecOvfWV9SrabHhz8ZIvNY0qWkGxvz05twGMR/rT5wyZDOJsI61w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wvr3i3ww; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipWsaq4sd93akc45mCBG34ms6M4bWrd+jI5GK4S1i9lUJTBZuTdys6DMdFhz9jLv4hNfPQVARRGPzesWg+IRkdLfh1blqv+p/OYo/ql8PiXzfqZqouV/nd2biW7lsqMGuTB6HQgZw7WFiJPMe+HdBPvPGBIkKBhnqhHVJosf30XUzKV5VVt/RPRsnQR8q1uREiknHnuPU7qScZnYNjjyu69tpWdxJlzoX1zJj+tEbohPABbJK6dWveFbsxTImRsqkzJ2YHgwUgAzrbti4Z3WkN3Dsf/UpXfNS9b6Krncx4xh8Ry1EtwzeTSzPnssnY0lqaqPQKA925OH6ONVCPMg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV5pB9izq6cqcYHxxa/YlBOPEBZmhK72B1Nq3bQdp4o=;
 b=jfDXdWVNYWo7MIt88udkLWBj9DhwpzcqwE2UzgzDbnSh3OYp8pwGFMdUDupA/2L7dWJEvyvEi0tdxaUOF9jFxZUoEkKgHZAA0tDnbfzkDNdlan3Az7ntIARbNzi+OeEmwVslXF4k+aOU674CIToKzvlTyd3erJ/kzJ/2GJ6YDiqxd6UBLeWsqJ+NTSXJwShwnh2TSNyu3ICYxdrfLAwGwvuzv0toDF9nNuckI/cFfcMGkd8Z/W+nj0yVIItTuRt0lT5WEaV+u8ic6flEiJlpr7Rme3JVlnVUH7jEZbqbXo7dImoXNeWjDP0j01lopGdOupa94pkcsRbA9PfqGPDh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV5pB9izq6cqcYHxxa/YlBOPEBZmhK72B1Nq3bQdp4o=;
 b=wvr3i3wwraVj2uqZS7rTgz7SnV/yesEWJl6yPKVzaMAap24E7VuFp8M3LqXU9/asu9+zz8aF4f3DgRUrtaS+FDA2G13xwhRepQmDDJyjJAkxUxDm/grjW9MLpAjn/fuwA78z01/VLQz9EljsXKSlQoUj+tlkvYvZCTgibCFjol0U+QE7g4reoc5Ip14RdLsKpzkW2nHVLLfQ+1VC/iYwNxylCdSS1ZcsuXv/dbYmGwSGJCEi7/316UhmXMRZE0NMpbDiSdoHXvr+hD3O7jFZq+UU9VMwkhnvKKQv9vS98r8o4nFIZPWw60ejzICjpyKEfdTIjaTMBlHpmlVlujPBFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 02/13] spi: airoha: add support of dual/quad wires spi modes
Date: Fri, 15 Aug 2025 14:16:08 +0300
Message-ID: <20250815111619.45001-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: ab205835-ef3f-4102-0571-08dddbed2ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZBRLK3GHfq5vWUAcGGGorvkEIfBG/mui+tdhGp7Bl1SOVfZYD1CiohUuBAt?=
 =?us-ascii?Q?rL8hHyJFTu4LLxnlAV+ZjOhd1vHs2pEk3uuizUZXWCgGxF8YJs0/h9TZ6Tmi?=
 =?us-ascii?Q?pDPBvh3hKO+AsuqaouGZKSkbFjvcu63vtLOrBG6aNc/L/22pMpZ3HbDsmcSc?=
 =?us-ascii?Q?WbUKt1a1l0nToVSxVkCgNwqikyJPnpJENqBkf0vILTveeptNpyZ6HIamLsl0?=
 =?us-ascii?Q?8ZqhHwGfp/m3nqTtY3jkiAUqIh6WyWimsBqtNLKv9tb2vTdVr1P7Lt+OklWj?=
 =?us-ascii?Q?aeCY8bSqrULDhoOSUnfrOuTaQ8R9WFGDs/J0EZSzPH+VN8en0fypb+YRcmX1?=
 =?us-ascii?Q?dGnUumrxkKWOv7YgJcyuzFDVZiLY2NgblbxNKXQt0DhjlPEFUTJQ9gaPizIj?=
 =?us-ascii?Q?mjNUWWfJ9VC6D6B/c45qDzgrrYjjnY4LhlRN8vNwNtElCPAOpCHxVaQ1oBBw?=
 =?us-ascii?Q?0073lDgyMOcFy1D+EzLie0fZBcFKeNUwiz3RYPMS9TbtvJNZ0tI/3ZKAxHqJ?=
 =?us-ascii?Q?qSFFVz8SQbUrZALs7pJW3MTs9aWO6ZbJVk4KOUorRu1tQLOkVs+W7eHrBjqe?=
 =?us-ascii?Q?D0EGOz5pa/1owvi20eQya9G9ZfPANdS78lI5dAIFRcv/0ipWrWq8DDlmrjta?=
 =?us-ascii?Q?nxa8NN78d9AnDy13uiHiKwYJ3a3Oe8Andd7Wu+MHkVQQa0IsZITtQKXxKLB1?=
 =?us-ascii?Q?KxcacSIQRzbIiECB60XbBX05sOf5ZwXPXaQEh6hzHfuEBkCa1pfM9tE2RoRM?=
 =?us-ascii?Q?dGrLFSnNDfvzTxK00h9Bx/Y42NsEMQYhWKpdo/i/1ZMfQYIMZxIKozbxQ8IF?=
 =?us-ascii?Q?u/7K/FypkGzfQyarAIKKiwyJlr/hM4cB0DIxpGmyUClJlWOEXW8wrvlRtY6V?=
 =?us-ascii?Q?fJXtY88jtLvf9lCm4qZyGtvMKOaJwDTq6zcG5VuimUIZEU8cQIJf1P0YrdLM?=
 =?us-ascii?Q?TGzOzSJHZhulP4g0Q5Kf+86Q6yjD0fAD8/HILu3y9waSiN8zDVNBnEqVSrGH?=
 =?us-ascii?Q?Gy02haJxkY9lolhnMo6QOoEycnhAZUi5UF5aY3WZdKwM0caLZc/hmq+OHAiA?=
 =?us-ascii?Q?gaginP4AvsnwhOcg/YXapi90rSYHknm5S4c2zCX3yp+RQKYeFsbJ9DO0d6Gy?=
 =?us-ascii?Q?NBv345QwH3udlIUd/Ki+CQo4InoKvyNiTK+cZBHfbdYznviyhGAbASFziaSo?=
 =?us-ascii?Q?mZ1TU+k0ZRUzw3Rip9tz9BsN/ziRT+TajP3RJK5o70C5Ui9im+pCCNn3KJjC?=
 =?us-ascii?Q?t66Ra1tk4qgpDqH9Ws8vswi5zUEuho8PdjPE7tzwc+D0PsRUpRXA5Ev8oj82?=
 =?us-ascii?Q?v73EFAsg+00OmiFP6ajrqhO0SScue758Hg5vXR0FDKUDKgh46SyNG1rszqP3?=
 =?us-ascii?Q?fqfYHasJvvsJx7qWXxahGg8jWRQJqZFrboevf8iMTwCETQ/fQWUZvMvBsV73?=
 =?us-ascii?Q?OshV14DR0DwREbhs7I9ODoCY9KfKOQ3WpMI+Ag6lvIlu7UNiZTSV6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOfsBKGoFq9fb5OhTL7e9D0dw8qmCvTUwwyP0GJH+MsZjSCwT8ROup0hKVaX?=
 =?us-ascii?Q?JiDh97un1154bAwwNW9Rr04wqvnQLUvpM1xkOQlS9dzY90Vir5YFy6tkRu5J?=
 =?us-ascii?Q?Vw1igM/ToS6Gjd1IuiSPyPDaHYG+Nv+4COVrR1vr9neFJTpry0YjfeyxlKl5?=
 =?us-ascii?Q?ufjmCL3NC/Pv2JLLBo+RPyvjqe87F8ftYuqmjFuok7tFdvajIo0Y4oX4v+Z9?=
 =?us-ascii?Q?5c1wz4uqmhmNFHFnZ4CaHY1ueHu3PReUGGXEfvBw2sElnXznppWBunHAJz2c?=
 =?us-ascii?Q?QO+O0bvuZ9hDXXcFiH+AhmbVdkHp2b2ZZpgy7V+8vzRnDylhMP5dxwx9vrFC?=
 =?us-ascii?Q?VAvowXiFivG0aVCK4X7A0EQAtK2evPD3mCexAZYtN2N0FzUIqjO5QsUyv64w?=
 =?us-ascii?Q?Pq83KnI1FtvyVeKMc6uSCARyrdjzh1Z071WEX6xxrdBvjKXQxw4tpy8OcyX2?=
 =?us-ascii?Q?w54DrkfD1i34qtmX+fwAdphq0+N1E63KCSbBjR4r5mgFRzjwUP9Kv9XyJRIM?=
 =?us-ascii?Q?zKWa9KIz/CkXKK7JUDYe0CgFvbFUzIuhBE6k1ZVcCwjJOI/AFCamDauvOhB4?=
 =?us-ascii?Q?9UHOqqfAi1py9gyZNZWOjiUmMlR6fYdwlAnqgyPV60lkXugJdHCl46pWCEZf?=
 =?us-ascii?Q?XrwbODj8t+C2+yGS4tQHkXcAWXnIIOHMWRSD01htbIqzBfx9mS9lv1pwstPb?=
 =?us-ascii?Q?UY1cLdSdVgZnPbUbNWyVXYF2Q7cEmAHsOc7Qkd+Ywgl9Ix4BxkQ8bd64yCWy?=
 =?us-ascii?Q?LjXZ9LtiT5duDIFDUeEEa1Urya9KTLaQ6DFIBEt5JNDAruqrGWXzvbUkeExG?=
 =?us-ascii?Q?cAO5xgSivnOOEiwsHRptKTEQjclWE5aEcm1KfVQYOFOqxybn4D5OYOjkoqkz?=
 =?us-ascii?Q?mY1OtA/hsHIg+1yM+vXP8M17VOQpcw9A1bmjN0VwW+Y288D8371dJqv/Affz?=
 =?us-ascii?Q?OC8TyLmai8TS5GALrFWqLDCZiRF6l1QpcpBSX7qHPcKNYASV2cAPvkwp8ACz?=
 =?us-ascii?Q?yliv9ufutIl7x/uv29cITF8uInFLO87+9+bKQIfPUPM0lu4uW7ZPAkIWwE5A?=
 =?us-ascii?Q?fwPEIbEqBmdG+gBPdo1j/OUjKIDf660mI6QlcKSg7xGr/0iUZp5mxq+wkV3/?=
 =?us-ascii?Q?S9dhW+GaEQ+harB1vBpQ5i5WQimcbEJma5snzAzCag/uLLZPE4PFnuCNy1me?=
 =?us-ascii?Q?0n6xhXUTizW20bmpMuTvh64uUKRYPglR1rYL2WMsWLkiMxfnXFxHBazsWZXA?=
 =?us-ascii?Q?IaYG9bo7JLTVDL2Kh+M2HOY2mJhBsg0075bokMdoZNG0eBBZC91YtmKdWOow?=
 =?us-ascii?Q?nYfVKeF549hHR7UnkpgYmSAIiiVvd6W6wufbjIFCg6G91Yic+v7bTRv+ck9X?=
 =?us-ascii?Q?w2YRpMF7t+bCJiBKROZFjMPwsbIjz7pjZFQe4VssdohwRxbRgORzDU01436h?=
 =?us-ascii?Q?Wng4kaI3sjTkCcCKPU96kMcGx5IEA0cOQazfGt/eISGhSvxAMcMWgT2jwRdL?=
 =?us-ascii?Q?6EeBH4HAZUzuNNwi5zWnIPqTPlSEblt3I1UuYJOciA+t32zMe/lo8HVYVy6/?=
 =?us-ascii?Q?cgQZjb8mmnLT+JZbMH9kUamOFtLsip0hA8kVDNXoRNM0eK5OLOv9g7CqOvmw?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ab205835-ef3f-4102-0571-08dddbed2ea7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:29.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTZIkf0ZFZZHhCs4lraz3n2ziNHVFnPRODaWygBa0BlPBcCA+9jZ+Y0+rfwHlwVBf3oPwCvMTMj8Oz8APvcUegfsntpK0QHCozoDpewh8uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

This patch adds support of dual and quad wires spi modes. It will
speed up flash operations on the hardware with corresponding hardware
support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 107 +++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 09dbbca8bd2b..d9ce1d67975d 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,25 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +432,31 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -891,12 +929,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
-	int i, err;
+	char buf[20], *data;
+	int i, err, op_len, addr_len, dummy_len;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -907,40 +960,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.50.1


