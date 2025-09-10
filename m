Return-Path: <linux-spi+bounces-9959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013FB51096
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEAD3BD3D6
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A7309DC1;
	Wed, 10 Sep 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EZocfgW+"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA030DD2B;
	Wed, 10 Sep 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491603; cv=fail; b=l52q4xE3DQ68TRlt2hlDIQ6PhpHSoNeCKsIqNnox/YiIQEK9TAmkygi5CDa3Ukzfl4Ags9RIAWJPK2NI6HsL8+zOauAO7XekK6BLmbAvOBCiBBVJkranRfs6sPTMA98nGDVLZ4TNGbiI5ms2D9RwSiKz0bRKIj8AjWYgp9uiKwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491603; c=relaxed/simple;
	bh=8cdtUXaSwNAt5nYzAXeLmDPvaPI1h2gjGIgIfVl8xEc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkhs/pb2PUoNCBMK1AA2xsJXTjjOjL/47SGFx7oGj2E54eOCTGWGcbTweUI77dJO6nkwzNTDshkojQfxZeZRzUulqjcMqnCsCFwNLdhiD1EZgzj1o/kN/bfl1U1wsIQ7Tvb8JdDpUq5ru79DBsaCnj5gBt3dVGtXXR7MmfWkXEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EZocfgW+; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liJrSzseu20Ko0/dno5Y201//oQA/cgEIWaxnpV2AnoRCCmEA4EdbENY7EpxCdIc7155qFm9eFtwbXjktJs+kHiZ1FQgSZ+6NAIHgBSgOZeZxV8IGcikuhp/lP6kSp0MIt6NMiTNlZjG+tKTFWrNOHwL93QX2z0A8w41I+uusFA+/EcK7V0+Yr2VpV2WoUhswj7akxM1Blny2FcFiKufubNIPhXcb4hWES2jtwE2aqIqkc9pAW4hKLxSSwl+uEZrk6zCjVTaYEx0N73ilLhatyWRR87GZVENgTpEJ5KZXAwWHkT+cQLeg+lg/W+gNMCZ7C/NhNgeAYuZx+sfkfVuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4uobWq8nd+oQySvH7JRTdlq+iFFh//jl3Oo29NZb3U=;
 b=W38WqaMSqdnz4kuUHW5H8eUMUQXQ9W/yH8xLC1VhcJG0ffnIsmcy5uCFPOKkt3hySdtG9U7MwbV6rdvhomk9EFPsnRR6aQvHFl4FP0OwsPtC/TDGGByJA0I41Uk1yCb7u7VsEZ0fH2m/SDiXovmtycYR9YGHmJiLLst8sAdYIQuo5ycZQk1hV/MZ6xFZADmWa7Ahu7+M822sNxvA2FQhFPhBxzFkLdAg4p4pEopd2EsSfTB3utTvlDQeyWb/qgN8M4AgJs2J/hvlQm8l7iLXvxVf+4C8+LlfUmADQXRGbdh0vmOc6E8SrAGyLlpOFK5hGcuYk/OwfK6GM/X789CXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4uobWq8nd+oQySvH7JRTdlq+iFFh//jl3Oo29NZb3U=;
 b=EZocfgW+j7q4AuZPLSf8YPQdC7fIvRBs9H1Gejfea8BKKCMXXJe7glNpkAD08L/og0cPGuY4RylPcUhhuqYlrJpRBWN10MlOJBOvC+5g8SKakVcshUU3cyXTQ/zmMpMBfcfu4uLOkFKi7albFq9AcGzdUHadWZWuQOB1uC5UUlvTYMKe8mLPurnYxBzdyNsusCt3YZl5vE661pX/EKc40/g1UEhxzILcajNrGDb1W8BKZCxvjlkTDjo9bLPrck3GeLD0L2aeHWyJuOfeE8Ch/b0HV2soutH+9OCr7GSk1WUrQ3JxuqeyGwu3hw/cQb0Zp31DToyrxDe9UKp8GRFmXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH2PR03MB8087.namprd03.prod.outlook.com (2603:10b6:610:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 08:06:38 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 08:06:38 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH 1/1] spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled
Date: Wed, 10 Sep 2025 16:06:32 +0800
Message-Id: <910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1757491372.git.khairul.anuar.romli@altera.com>
References: <cover.1757491372.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CH2PR03MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 94655851-8c14-4f64-9c48-08ddf040f7bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIwkWJSm38uNe40bqA6DUH5aCUg6Ac2TD45SBGN8wdwUwVlADvECdJupJh2p?=
 =?us-ascii?Q?xEZgrjnRdNOz/50EnCq0aAnjY9TJwZMM+c/GKcg+gv0LqlZKxA+orYES7jop?=
 =?us-ascii?Q?APeum/VsMoVf4n4LR6ja5WbtKpMChKCKVjALVb6Z2plxBCsgk0s+shBzSNYq?=
 =?us-ascii?Q?uP0t4VTlcYhnpRpJMbmQJ9meAlIHQQK44ROBwm6XfxjYkUXn6UbEj12Z8Z62?=
 =?us-ascii?Q?L0iEr+mrYUO087Ilge/xdSTAhfFV4iMGw5heBXCRMhPDUNbm2KCBsl/EgeAC?=
 =?us-ascii?Q?p8PztyZ3DSJKzX7mS1zZyNsJEabgK4Fw/+DyA6kjVMySk5aezNZNN6mq8aOQ?=
 =?us-ascii?Q?1aGJNMXavPJ8Vkq2sNIUoIak/2a5R/s+grnIS2JTxKDrIAUfy+7B5DdEL7E5?=
 =?us-ascii?Q?9FCWrwTOWQDhXPIKMZ6eGoJLoqjAzPkAdoISw7zOKNEJApOxBbZCar68gXEH?=
 =?us-ascii?Q?cAQfw1LMIoS1ohccG0iXpFoUgNjKe6LR8VgHqqn4pjWGzWjDgj+mVxF9/54L?=
 =?us-ascii?Q?UJmtTFkiu06SC72RDrZ/7foIWFqDThC5uOSCa858bo4q16VGlJ4sdyrCBeIp?=
 =?us-ascii?Q?FMC5MKOw3jdEfDEc/QFU5uq+M7W9ZhLvKG8CT8tHctKQqwcW51SAqeWnBZPA?=
 =?us-ascii?Q?Vn6iBY+/R9WHH2gbu6a3C3H21NUSMj4NV82DadcTBhwWmAUhRwbtpzJv+h73?=
 =?us-ascii?Q?jdRcXekinDCuR5Be3xDtPbXc1lzu4xX5VTa7XP3WGUe2FoduIXX6PflKc4VW?=
 =?us-ascii?Q?kNyDCkduRqoQfq90Vlzjg+qb2HxumLw1Hon2e7QZZN2Be7WEOhoGaJJ7HKgk?=
 =?us-ascii?Q?gOw88mYqfCFIqTKN33s9MnYHXBDQBKhsY2JM2M7KJ7vzjU8dWIQJdrGP5XsC?=
 =?us-ascii?Q?fjKs1gdkA9+0Y1xWYOuAzYd2IKhRLYB0+uryG0IEdrot7+GuMAL3CzZfDoKx?=
 =?us-ascii?Q?TbY+y213LB90DzpxLXcm3eLlxBg20RSpJ4putlitCmNtvJKAzPMGvD3MQcdF?=
 =?us-ascii?Q?PlF9o/3VRNOwz8YeHnna19Z7NwaKtslYX9mCFhjrBblQS8UUUCi5i+62dxvC?=
 =?us-ascii?Q?+OAHazuGoajGeg3LO7+0v/3pmieVMP4MzYuIVLvENtotzUM6qWgasX66dOIc?=
 =?us-ascii?Q?qt9LQoL5QNWCTGvJqAav+7T1d4PJfA1ZWlzBHX9B1v1ZRVtThiq36YwBhAJs?=
 =?us-ascii?Q?BXIro4qB5V7cS3YiyWi49YrakA6O094NdiPDNGhnSPBIld3edYe3pNpXwTeH?=
 =?us-ascii?Q?EmxaYKXHcfRIWtbo34IrFEtJyswu5kCxbqfeVFi5EZVtGOZjvP+1Krxfi3kG?=
 =?us-ascii?Q?Ef/d4vR9IdnJQ6SOwsqoOMVzXTsKUgAXNxUyW4uahUjQM+nryQMKzTf3hX5Y?=
 =?us-ascii?Q?Mm+JlRNQEDrsmn8pcW6ZhWFt9Ttk/sEoJ4eXRx+j1giYWzatvG+eDbNSBKCJ?=
 =?us-ascii?Q?mko1TEQSCCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgUAyo0kYrZuaEGNx2KnQbFqk/4QU+xdMSaD9e35GvYeoQ6Nqce4FrbEOUlQ?=
 =?us-ascii?Q?ApmkDYH/3asWeYJN7i34giI/bIRmDo7zuf9TxMj1NFyrDCayBWZL+X89Rlo2?=
 =?us-ascii?Q?nXR7nzxHfhsd6oZxO5vOEWisJOxNUf7dr5zE9yLx2FWalNqv7LVYUWfVHnc6?=
 =?us-ascii?Q?2yb/iAVqIztfV834IKK3lbpLUNEaVca8JCeOqn5AnYoeefPZrFjJbbinAEOd?=
 =?us-ascii?Q?oLhNmzj70iqWWAeDFivFyjs6n8yD5Eo4tCipbCnSqcncPFARhkiPL8nz4pWu?=
 =?us-ascii?Q?ShSeMTReAmA18wZBkQzFjysXWvHsPkeOlHtl+XvQq7PDeXDQiSX/FFsH1vSV?=
 =?us-ascii?Q?da8aYI4tr31Spkz5aznodEJ88UUG5sNaQ/bYCaGi+h4e4uQIngvUDfldXgsP?=
 =?us-ascii?Q?3axxDdJEcge5Mu6Th5N/ery0lHM/jc/qOOz+DYx1DLYkcSWPkafals2hGhwq?=
 =?us-ascii?Q?LBOhaEm9wQ7eiOvYZWSAvSCmZSREiMeFSIvGfxVX17nIMB14EzwOy8t4wNn+?=
 =?us-ascii?Q?+hW3TlBJhPOdPud0rlMJn9PBFX5Sc9uRn8dwgGvRvUyY5bx9xL/wi33D9GCG?=
 =?us-ascii?Q?wGvVYITkr+G81l5RsATvRViL91rlPk9DDnqKKqiV5vszV695CPUcEVEkB2uY?=
 =?us-ascii?Q?Y5pd52DZmnpOg6fcyGcI3CdguW65X74QWJfBp/mxs3s/cLtXXGtHraSc8NHs?=
 =?us-ascii?Q?1XzQrCgTWAHmQj6pW0zfSmPO9wrviN7SYd/te4bGGLEUcavF98HyBIHVjAs3?=
 =?us-ascii?Q?8+Wx/h21BQUn2sNWztfjUNZDE8WZrz4w8j6toKG04KZSRqwcY3DroElilj7+?=
 =?us-ascii?Q?3wiisZlD94UCd2ri1u1+3lm+IKE6FhFvXGr/04laZiB9dZ3h1jZrTv0wi20Y?=
 =?us-ascii?Q?vYxXeSOYOFbV8D7cra/7CUptl6hdnC/5SdzucN0LAjVTFQlbh7m+D30um3jz?=
 =?us-ascii?Q?/l7s12dyTjj8fSU6YuI1hpxZhXAqeO1EY0rTCveRr3oE1jEv/ls9Bh9ZgATT?=
 =?us-ascii?Q?wJAaXXGBRnk31qOlweR3x5jVqvFM73OYFZk+Pp4FTRbrjp5MkSeKTHRpBuvq?=
 =?us-ascii?Q?+7D5Po6gtC+RG0K7UZVgdBwvw4YHv8Bbwu0aMdBbjTr9fJ8T2r6V504kNC/G?=
 =?us-ascii?Q?R2iIiGJLY1JAmjtcHwCb3qS9qHeqWMvgCqyk65M79rub6znS7eMmNMw35mNu?=
 =?us-ascii?Q?86plIbdcVw2elV9ns0enZeaxAfV2+Iewo3OeeHJdfxajK4l8XYnQMPS361V+?=
 =?us-ascii?Q?/eWmrg3zeQ9AZ6DbiOj80kVMe/f7Pt6KnX0TW9bdUtBaZAfrOwrsKxbjMJYF?=
 =?us-ascii?Q?0xWp7vaCzNQaImvG/g3GpH29fwDKdIOeAfBc8iYG0qCUzXfzhjNoZ/1SJTDI?=
 =?us-ascii?Q?D4zU5iwCtRZxvRtzfUA1WCWZwoJydw7a91jK4D0LfCaVcuDLp0TlTd5wUFmw?=
 =?us-ascii?Q?CxLM//sMTY9NwByI9iqJL/ZftYDc9PdqlgEDNwhooVZ+jLSAQ2KDo1xNrnjl?=
 =?us-ascii?Q?r0BhGD7QahcnpCmV0eaDsVFyDLT9ARls4i9TL2MdpNyV/1j3Yogf1j2EHDbA?=
 =?us-ascii?Q?zF5aY30ZbnDihOo+kLsjuYzfCPACFkUkh/qfjuBViZIiRe6uKakipXXfmzqg?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94655851-8c14-4f64-9c48-08ddf040f7bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:06:38.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRKlSjwRAQPdVuyeRBF7BNKZaSp86QLSG/m4UoY0wz+A+AR0IFgPvJmuE1VuDFaYgZgb+vZvfEaTKtPLe7xaVReKJjdo7WJ/TpSwvh3Ewik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8087

Enabling runtime PM allows the kernel to gate clocks and power to idle
devices. On SoCFPGA, a warm reset does not fully reinitialize these
domains.This leaves devices suspended and powered down, preventing U-Boot
or the kernel from reusing them after a warm reset, which breaks the boot
process.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Niravkumar L Rabara <nirav.rabara@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/spi/spi-cadence-quadspi.c | 53 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9bf823348cd3..d288e9d9c187 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -46,6 +46,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_DMA_SET_MASK		BIT(7)
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1468,14 +1469,17 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata = of_device_get_match_data(dev);
 
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret) {
-		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-		return ret;
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			return ret;
+		}
 	}
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1491,7 +1495,8 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_put_autosuspend(dev);
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1985,11 +1990,12 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	pm_runtime_enable(dev);
-
-	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_get_noresume(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
@@ -1997,12 +2003,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -2013,7 +2024,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ddata = of_device_get_match_data(dev);
 
 	refcount_set(&cqspi->refcount, 0);
 
@@ -2026,14 +2041,17 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable(cqspi->clk);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
@@ -2112,7 +2130,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
 			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE,
+			| CQSPI_DISABLE_STIG_MODE
+			| CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.35.3


