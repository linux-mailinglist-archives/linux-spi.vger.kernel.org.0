Return-Path: <linux-spi+bounces-9450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C306EB272D9
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC6623A16
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52A281376;
	Thu, 14 Aug 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ioMyd0A4"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B04248F4E;
	Thu, 14 Aug 2025 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213145; cv=fail; b=MLBwkmqZBEA/IZe1ltduQ3CwoHW4Chgh+aKKC9ie9UVwHFu6G55joAeC0/ZRDESeHUbNtayqqiHDo9sqbTc8ltauvOb7p5tGYll/z0WNWVYbughV76SVR+MqomzfUC52LKgYwhIp8tUOvyBdCQ5xPQ2e/400yuvleo9xFqKJiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213145; c=relaxed/simple;
	bh=xzy2zf7RsVLWv4UjXpjkTlH+0jjtU4PHTMMrytLuE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwaoxW3cPbdF3uHWHExvAM+00sLG44FvcBp1aGviDXiITWUwHZSqVzhl9pXHdKJ1b4P9oCN+Uc1fPEHyttI0gOfQm1cvf6FXsTbwhyuDRJfZkoocNIfSTtc1cLRexRehKW5dACWTE0Dti/4qLFs7Lqh8soGI/naKbC9+plFcr0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ioMyd0A4; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thGXFXVTkQQ+Rp4mF9WIiw357k/Bh/MA/CZ4WYDa3ILVJV8lKLFoNs5kVvI2NLTaLXG8VRoWbSgdsShSWoUYyTzXc4YOsQP1svyPFD2ug92b7etvWA1mHvNXRznXWfJh0n/KFt9nnaggAqEgRrUGy6KbUzyY3Xzz1DjrXMct3iaG061k+7GIEP0bFTHiCz13IekKvFbDAMfWOJxo58wEHC/55rFxLiL5rLaXBCIUb+GKMd95y7fABI8zpUFdoh4IAPpOe4RIJpSbHzZbco1eWF/DogyG1n39NKNFj/msu2b005XdBS0rb6WCV+8yfBHMl1ggTdNxxRHJgNzMx023ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfxV8KENwIydT5a0Vq1/8pyIQMv+yY2Yi6hKhT5+n3U=;
 b=uVnHTnD3eVhnF6bZtELQqLNqozblGOQYuuAMMQYdBr1sx0t+yli945ivsGqoPY9HRapxgs9bUv69pLEU5C5resRvwKZnkY/QxpKyioi5viDdpoisICA6ulm6j7UDh2aDfvdTMXhG/G2Pw3HTFWnE5SuBxhUljy0nCFWP3BlXgs8cr8NTseS5SC16ejoliB+FHtMPNqxt88Y1G938+TlYRLNOmXfG7pJLfeV2H+cMUwTvPUntqNzcCxl8OT+CMwJp0T23rV/GfSTw7+30xc4Wk0j7y9mYDHb7QhQkngGJVHEFdr6gQpWjWFHxjUXEYnxLl/dAZAl5U3I8eLWxZgp8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfxV8KENwIydT5a0Vq1/8pyIQMv+yY2Yi6hKhT5+n3U=;
 b=ioMyd0A4QrkkCv06wrap4xD4jnTZxGPjDj1qoFIFiNGKYbEtDNCNDmEdFUfocj+OyU2DhQVAgwfABXKU0RRh6raTAIGEH4PdliyMuHGHTeGc9R4Io9k8XL1yG3ZR29g+U3Qx1IP+3T9ZCbFDpIEJGrlA0t3UjF5zJwTJA7H63ZSuX1hTDbZ2FtHPcj6xoI+PRsFlPYjSELC6aKkajHcT3g5HN7soBr2FyRplxkSxHo1ozi08IUWTCMDvqoIJAxWwEycGlp2/jLZ5qMF1ApoHG3tMVl3BKIZrRWePADaNs2v4AiN2pi5O3ute2SHj2xvaCHQdvaQNuU6boFOsshVSJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 01/13] spi: airoha: remove unnecessary restriction length
Date: Fri, 15 Aug 2025 02:11:58 +0300
Message-ID: <20250814231210.4174427-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b35a57-fa85-43c3-9b8c-08dddb88048d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ar56LikOwGIyl0dM2nxzEs6yhTYukTStVJJZil6+ZQfVzw6zOR8nIM0F1IUH?=
 =?us-ascii?Q?YS1PvWpGmgdKPq9ediSlJt9PBO/hp9MhwlrPLSrqVK7neUI0rNh7B9bCAFXp?=
 =?us-ascii?Q?nNu3zgBvsMIG+nwITzqACzlyrhGVdlHBAaQJA0EBTbh7RYviRNkvklOqvXs/?=
 =?us-ascii?Q?dS0cVwnEXW+sS/q6KpbtHHnroWfg0SvuYH7A6AMRo8cBD2V6zwHuGVucspKF?=
 =?us-ascii?Q?RtVoyLzlO/8yVe5A+OUs4hpFbLY5g4FXV4oiCYEJik8RpeviZZRso1gRwtAg?=
 =?us-ascii?Q?3EPuJS2nTlwSDPFO2dtSkoDCLE835o3J2kceCiQOyhvdMOK9o6QgujPOffWX?=
 =?us-ascii?Q?jkkA1Gpbkg7gaCa9uMfQteMB1MPmcVyy4tRLKrhtf3xLSIhnerjpyMwDVzfo?=
 =?us-ascii?Q?UQ0Z4hK/gs1DgGEWNHT2AVlorD/N7KbZsIdbiCDCc1HIGJss9Lt8d1yIQA8k?=
 =?us-ascii?Q?kInthUI73+PmhM5U5JFJCv3Ft7Z2GBlGn20PQqmXEv7zlrE5EaenGI/pM4oB?=
 =?us-ascii?Q?fxR2vyAebFH86H+XzWvyBalg2SmbaXZQ2qfp+p9Vi2JHDxP441slZq8hA/n6?=
 =?us-ascii?Q?pkWVOoxHVzrLyKMAUwuzgiIcsIjCW9EPHgjFK9+eI1lH7HRfywwLbNw1wZCj?=
 =?us-ascii?Q?erKevjloqrqy8EsvEXrb1YHC8HaTQNLiNRH4JcW6J07FVCBqEQhf7mTAUcEI?=
 =?us-ascii?Q?3hYdhT+wEg7ybXkQ6r7XXjp5DgaMTwdsvNnWbBCCwfJQMoUhTViF5IMVc9aQ?=
 =?us-ascii?Q?pzOiM3b34Url7hiXBCtW1JCgwXGE6up0wDGQTXSCCcJGvn+8pLJ/wyzeRNZj?=
 =?us-ascii?Q?AxWgnE/4rx6NmFCDAmszE9ShVfSWMv81Ih9tsT6aJlvBUfU7HFydnkaZdp5o?=
 =?us-ascii?Q?VwIs8XwjvCVFGpHrzAPDTGcs4dCvKwIxnn+n5T7bZKYwFzwy9aym2ct5bPir?=
 =?us-ascii?Q?wWKXEVmIHrGTd78682htJfNhnqEfYCG6L9wAzGasQ6tEpY5yAVicJpra8fxt?=
 =?us-ascii?Q?R+W7N1JgN5l0UdAW0U6ObbKvSWyUFTA8k8tKX8Slum7JqPkNUO4T3ji2ohZk?=
 =?us-ascii?Q?qHSpctOfJnFS7YRuxvfWBOHS/S+4H2P4XOMhHJUILRLS347pTCL5Iizzm84b?=
 =?us-ascii?Q?RaBC4emSWcFXE3lPw/bFmmN2NBDxmSn3KgkRkf0/wDZDQRZtXOXViCVYSXmh?=
 =?us-ascii?Q?721d0LwxdOWhLCKyRn6B+ROJEpEnaWVSiAEfyCHVYT4UW2GX/K5hBXQVim+W?=
 =?us-ascii?Q?MJ7WfYQGkwrlApwK28K4Txjj+z/Yx43kRiiN3PHKK6KojMxXY+mAXpTypqbX?=
 =?us-ascii?Q?8NOSW/D21ZblUfFCDTdCVoyNzZOY7pnw9aETTuu0eWm76ZsxHLqM3H9aJHPG?=
 =?us-ascii?Q?hmwgT8pjbabOGS4xj/l2TV//0s/2wjWOB/Q7t4um3VNgeAzdbuRpXage8GKD?=
 =?us-ascii?Q?JuFQhb7mF+UOphYyT3nhkqbk/v+KaSC3P+ZK7A6L+l9aI37Y0uzItQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+QXyGhcKLdPmhRsMwz0anPiOd9ZMzKTqjFjBWPGhFp3U9wK4Yko1LnXS2l9?=
 =?us-ascii?Q?c4t5aK2srhnUS4yu0zSzv6m9C1Rp7djmMkVAdnoVcfjsfPjumT5mG41pFEmt?=
 =?us-ascii?Q?IvDjXZ97HsDmsg5tYEYnBNEDENXwomu4Qkk9NmaNy6SHGmbBqrhetqhh7Msa?=
 =?us-ascii?Q?Sa36IptaQ7dCm6a0V5dS5wc37VV0Hh7/TV3RK/cSpBpXG3WCnu7K/BRBcHu9?=
 =?us-ascii?Q?8Dw3bBXnBex7kdz9I9VfRzYLaRKzjTsKu78o6Tz2jNTuV1wsAzvbF++W+xRe?=
 =?us-ascii?Q?vkABantNP564JW/qZRVtXkbA2YLAlTAcm8cFptJ5CSnm38F7Q/as0Hkjdii+?=
 =?us-ascii?Q?S7oEDJtetffHzWGo1955x2FW4a0LHwA3WIBISn4xvp1RWSI+6mKJQwar4L0N?=
 =?us-ascii?Q?Q/zTMbDb5pBmdSI/2UWJi91k+mSDgz7UUUI9oRSO6vBpnpZfIfQOYqKa+ICe?=
 =?us-ascii?Q?1VlELG82MmGHJ1IT15r8LsVmJAI6x5Y1JPrMyWuUzwqzSKlFrblS+dtC89KO?=
 =?us-ascii?Q?7cXVjRPfWpC6x87WV6p7NYsvZM6DaarNQRUznJS4resuVvawJhZzaqUZWksm?=
 =?us-ascii?Q?qOMuVC76C0sZTJJO3OwTjBpl9Ij1kU3xoTcGoYNQ0jrKT2rUzz34SJ++e5SC?=
 =?us-ascii?Q?p5xxw8Id7QXKjgaAHYp+GB+jbusLGPx+JQYgg4rZpgXM98dcm4+tE6ODk1HM?=
 =?us-ascii?Q?TeO86ptq7Yehdpldc/BagPypUADbD4vF7syIoJCwuWwhflpwdpe1nwQ73JVJ?=
 =?us-ascii?Q?4NjNS2bWhOu6vthisUdj8SNk2cUTVOOV6jTShOr2QNlrU202CZqSzndl0Ss6?=
 =?us-ascii?Q?H3jpM6N5bCtZhGcibPukIgzfNVxNxjxO89HePY0H1D9Zj/9rKzC8/cQeGiia?=
 =?us-ascii?Q?XCjsIUD4aFmpUXuew3JcZaFKLF9iZ4FfFYh7borGn9F1iUYhAMJZ81eLVR4N?=
 =?us-ascii?Q?Nh2BBlHgNMyB0f/UfFm+q3IpoCF+hjSNLvJB2dTJILYvae1iScZlOwpW6675?=
 =?us-ascii?Q?IOY1bTr1mdLAbsn7jXyo2nRLSuhmu+O+MCH0tTv4VLOtgF7nr1b7x3osHikc?=
 =?us-ascii?Q?MsKBGfYjWbRvifTJPuQEGpydtxeDA/AnUuxLWbGYpUbtL+K21kYGQCNA9i2n?=
 =?us-ascii?Q?f8ajymWUq1aKidPYOibuYK+9blomFEYvQSnegrgSHxlA70p3jR46KVrmWRcv?=
 =?us-ascii?Q?MfrdgEtOjeM2uHAWFVwmTNXgR3DDYB31R/54FCpA5hsKlWeo1N+5BUsVrFPZ?=
 =?us-ascii?Q?VrFJi3NWd2atjIULxiRvns7kDINli+VnzwCjALawJVvIUo5XNLBgSqDuaXI0?=
 =?us-ascii?Q?C9cjLSR7A+sQG53Hofy8x3EUfeYEh3pLb1R3WI5Cl22mYOQRXKKCDQnHlobO?=
 =?us-ascii?Q?cICefT6Om7kBfh1gZQLGEk+mJGyMeYFOZsbjVdodBfnzNI/thz5AmuxtjtT3?=
 =?us-ascii?Q?k1XQhFU+3p86w8Cbbzn02zCR3wptyzwY5dYugjGMsYJRRkpflDt1PaR60V4x?=
 =?us-ascii?Q?OlAlfU0MGlfaq2laDxmaPJ3PN5sDLfreLTIKzNmPMEmd774BnYZyqwZ0U8di?=
 =?us-ascii?Q?pTScVf9iiuFO6c3PfAOFmUT7S5rYd3yzTHtffbPWsLYWlnaDZ2fGEwc7AlrK?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b35a57-fa85-43c3-9b8c-08dddb88048d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:19.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIf5KhCrgEL9tpQNDiwtIDDcYBNK7vI7pVqIqZDOckQ+Yt73W1KAAdseN4kfuola1fTOe28uVRuKNzMkTOpSoJJmEoUZpgxrxFXyTcqsm+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..09dbbca8bd2b 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.50.1


