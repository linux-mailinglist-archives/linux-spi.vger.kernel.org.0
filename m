Return-Path: <linux-spi+bounces-9469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE0AB27EF4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A4A1C216BD
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF627E1A1;
	Fri, 15 Aug 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ASc8Q+st"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E221422B;
	Fri, 15 Aug 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256594; cv=fail; b=HWrd9LkfmY3DtMU7rakY8k9/uMfb9GsTOF0SfWbGRAT61NDrXzDuJ/bRsoHzcsQ+k2Rli67KJOhIbnp3gkcqq0RyTtf9L7AJnu3oyhlDiIgAj8LspcskmZ9WcbFrqzM0uqIkqlbZcDuD+VAi7cYQGasn3P1Xo82b7Q8Ix/7hznk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256594; c=relaxed/simple;
	bh=vasLleXku1OK6gWMbafPQuWxrEfrBA87TmAC7Hee5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=duIRqptDj6PeeM97k3Dv37XnpjXu/ZgrU3Sj+j8HbEl+9PgRlT7Pm7OfEr1Hu/jlCKYpegPZmYHETw1mMdhltQwMTUZwQEhKk0FX3bjZsNbqPQageVBh9kEcPYH0cA+vmHxMCmUbZUZHPkDSyZEemOXupwYpzsHO+fsdUaIMYlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ASc8Q+st; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca/zVEsB6jnVC6yDGNfRJdD/OHeQdCT398Ryc7dlrpJ9FzctU91B4eYtZUIj2AYSeMqRjLEwug/mDsjvU2icXhORHw9BNsUEssQtHryr7Rad7rc/9k7zYa190ifWWDTdjtQzt18+PZgoNVJS1pMggE2sR7XZasZaJYXjH/ql6V5mggX8BvqCI/lU0+A6awWE6QceX4hB4IW0ED1K0Dropw2oGfau/CkjK9WUyWyeBTxRuHMQ8WvISmEma8HMsjjeJnQetCBL1zNI2oB3ePf4U/5WooYuSC1hM7gNWz6MDgE+2zYRd8mAb03aH+rTkHbAObXTVIm4GHzkofpqLul3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BcuAMh1yExIxYvgklcShzGPZ1RNcOYSVk2ic4d43wU=;
 b=eQmZS71W6/Q3fsbEr/LgMpgd9IZb2nqP/sNftFo/N+Mk+9kizzygGvm6uHw7NcY/tfKenCTPy5ijcqWytvr86pUW3ouZCmmH9kemMHeqjlyrc45C+rslsp8OE6Xae3VLG3/sCOBCGkVEJkleJArictuES5H0oiaLnGr980I3rFlBT26BtJLvrW5ckqPmaSXcnf/qVK8LTZOp3ujrLVS1cwkA4vhsjs4FI76EZOoxFy9ropJakY3oRvvUE3nKuYHCewfIpahNHGZVhtAiLEIvM3wU2Hx4FHyHGvKJt0O7MvJQxxL6YicDliPzqcWCyOJZnK6uyM6q1HazWagZaVko8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BcuAMh1yExIxYvgklcShzGPZ1RNcOYSVk2ic4d43wU=;
 b=ASc8Q+stdnUAr3kt3sPMO0rmzH7gnsS8urnr7bB46sP7yuLOGDwMOVHFqj6mnB6fgs5SBc7nEgGNtbsVRrEIkeE1M5aBTm33lQZiY/IUzrROdI08ImwKz4tc+syOVze0y4sh6tubMG3sB+ay6qfhMsqEKzEMYmlu+MslbMrOo4VDSuM73Usx3mNM0ODdPjYZJrOWq5iMG/cs5WGIgOY1p5zBDfwQ/KE9mcW9aL1425U9kRS3b1AlYJij2i7PSnKqzmEXXVWoFg2GyC70Xu8t1sFinMcQcRWPUmQ+FYKKWh0aa16+FH2YzKQXGiyIJMLOqgSd65HwDLaDsQ1vUBEScQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10032.eurprd08.prod.outlook.com (2603:10a6:800:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 11:16:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 00/13] spi: airoha: driver fixes & improvements
Date: Fri, 15 Aug 2025 14:16:06 +0300
Message-ID: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: f42802cd-7b11-4dd8-027d-08dddbed2d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+z9pD4EDZg5HemnNv2FWiUpXWP9GxZgZf+eM8BoOH/aCFIoXajRR9t0qhgl?=
 =?us-ascii?Q?3mMxyBEB/DuR7FHgNdat9H6DnlZOQ9bNGyuBsylxsHepOingQl7q61li1qim?=
 =?us-ascii?Q?Z8P2qQwaUv9OjoY9tgaHlSD4ojw9dDP1blcgaxri6yXO8JG602jpfypP86ND?=
 =?us-ascii?Q?S+Sp1b5ZdJgvIMzPqDjftVwNWrnP5ZzvRMGsM1/2e72uT4nk7flcl8PsN2ns?=
 =?us-ascii?Q?lSQNIK9Prq+LVe9dRZIMA2AbEJ28/ZruVaGdLfH2lTZat7cQZyi6GwEDDQ1l?=
 =?us-ascii?Q?u191b9/vp2KI0W3TaHTidFV5MNh+wlvfYsIfnxCyudGrt9yr/5w04KNMZxBm?=
 =?us-ascii?Q?e9Uv47uII+2jmh+W5hnspvJjC9PjIIfLmwtIm1cAXFRb8iM+FG2BnYVDn8bM?=
 =?us-ascii?Q?jfoGPrVWjxvGOz6zUIBvvcUrYk5wAvRQ2lk5jG9UUSwnEw59MZ+68puT0FbZ?=
 =?us-ascii?Q?p8esF0lXKVRXkO+e9Xk+vzRCAb9wtoEkA/XhOFoR/3qrZGJKkRuLxD5FFG7Q?=
 =?us-ascii?Q?LAAvGimyoaMbwgDKfKVSaf3y3Ei4DPavXIwpkmFkFeD7v43xZjeCJCJyLdzJ?=
 =?us-ascii?Q?vI7etpoNJVaWZS/Lu5tJZl10jJ/1+Ecnn45UTp6lUcOAZjiBTL9/PVVVVqJC?=
 =?us-ascii?Q?QoGTlFT2URXo9K+4Am28aEzRb+fWjGbxxJw/whch6YCAGOXTx1th0DOhssUP?=
 =?us-ascii?Q?90OVTb3y2c5HAgPIWOZmGpVvRvyES4svaCsdjspvIM8qLEkB3HxvnC4DedSS?=
 =?us-ascii?Q?miARxZtxWa8S45opMr7CDMEKgBZNOCq22e3B0GF9TGTfI21E5R0/rcGAwc53?=
 =?us-ascii?Q?QBH2tKNTFgnnN/U45FtEoVQApcwBRBQ3zm8LrS7PV3twPg/BoL2a2Mlz8l6k?=
 =?us-ascii?Q?AEmjQubfUvBIELqbTaF2HQkZPGV18acqo2rt/w8UMf8Cvj9Pc+P4X05GOsUc?=
 =?us-ascii?Q?OnXrf6hnWte7UiH3J3nkY9JqBvOJpM1z44NTAn7Y3tciIDF5Wey/dG1LZaoN?=
 =?us-ascii?Q?ghuzW4f/ZS15Yf96KpSROj2UpDfZ4tFhk/8KJpXuA36xqs5x6THxc+eLMSYM?=
 =?us-ascii?Q?3krX2Ujw8u/915MG4FI/x+ajXK6kCUTbpQc8m9msdUFbVoS0a00FBbIVzBK9?=
 =?us-ascii?Q?Lx0sF/P02jF45UyhV46lRrhpP26EJfJgOZJ8ubaFjffwGjUdTIEthHm/JcSF?=
 =?us-ascii?Q?pdrex+evCUlU9CJvq8v9v7HsIXc/swPV5L7eKyLwj4RZfaTo3M89TeVvVkzj?=
 =?us-ascii?Q?4UYbu/Ti+cKzL4nxa81rC1ymQZnPA+7pMKBPBdrp3Mo2iKwW3qPOhWfBLuNQ?=
 =?us-ascii?Q?pLPFZy0PYheKj6C27CuyM+ZH+AU52CBOiBwbf33XX1f+BIIcK2JTqvWlNmNu?=
 =?us-ascii?Q?D1Zn5HyYjOeB5WLQDjRF0IKaLMWloSpbzzIXfHBFg3MGCrE4gPlJthwmqaCA?=
 =?us-ascii?Q?3YGX3pBIb9Nb8MJYX3MKF0ohTOsFz6m7+jt3irqUs0cGQLZP758z6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPdYfPgXpLVNVvRjJaIpCPD2/i48VrqDnPF6+qlUiGb11kZZbu8wRI1APriJ?=
 =?us-ascii?Q?VRcRSg8YXHcjCcXQZ4hxVkZlJHuKSBVneIEuPGjwz9lBawWdcMCLGQkzsOcJ?=
 =?us-ascii?Q?dm15/qzxjV6BQTEOoYHzj5tXNiO6buZPZ/fEscEbN9hRM5acy0/a0r6x7Nx5?=
 =?us-ascii?Q?hIqZMadvFByMYcOml/nTgEC8S/h8z3bM7Ss//k1VDNatb19VGskrso1iLBil?=
 =?us-ascii?Q?aNOAHiQ5XxJVwZ3NXPQjom9/sOtf9x49CpjpHF2LKLDcVjIQfxMK7CktAFBV?=
 =?us-ascii?Q?YXIg2vYRZQOsBjjuuHtlyDMXBVnKgTTHzAKU2to+Gh9a/IBjKgND8d1zkUeX?=
 =?us-ascii?Q?bDgcneVntu6sh1zXiRduFjyiCr5aVKQrPXq2T1AReUZQF6Ad0eG92U3noPXf?=
 =?us-ascii?Q?vwgh82mXoebA1spEz9FB7AQQ0M/enLl7Jt5DTKr69OsprFAKEYcrciIApm97?=
 =?us-ascii?Q?2Byzcb8k8GCEJIXmPzvkOLSjU5H++TbhvEsF05CvjEMnlMGwup9aVQLFSKsF?=
 =?us-ascii?Q?GIhOfZWjrDcpOz+Axh8/o6pt+Y5Ks8WRCC7fI/6JeRuqiyR+0ZSmIVX8BZzX?=
 =?us-ascii?Q?XMPk2S9Qsk6s4Z42XhStcCiQOodZD4AGB7sCttCBDQghZA569Cb5dp10rpVe?=
 =?us-ascii?Q?hN0/pzgcUYzTh/5Yurx49UVMzjvu0vRlwos9DNaiqY0x2mbgg7sz+RMFtHQB?=
 =?us-ascii?Q?anOunlY9WWnUggL3VKEprHxyUqeer/mdBfYTOUQaO9T1FwweZNA2kiYP9Au4?=
 =?us-ascii?Q?K/0D428AlB8rOcj3aI2zWVGNK3qf6KQXduAhx9OHxCofyedg2r7hKIxB4wsW?=
 =?us-ascii?Q?U6vu47x2HgPicbkxAqxlVCkG3Ceh36smFus95hjNtMgy6brpQ3Ov1RDyF9Iv?=
 =?us-ascii?Q?farR9Be2hh2jtjPKZ66iuFJMEof1EInjOblkpZ3Xfl7A1GLS8d1V/rnx3SXg?=
 =?us-ascii?Q?fuBST9PqmOZpgl4xasQTj7HjtYOS6AXoYLQPe7hHUMtRWsAh5ElS1oTUPxwX?=
 =?us-ascii?Q?ultdk2gNBg1lt9tyIZaB0ppVObVmqFd2SIof9MajCgRhOROkc2B2cI2qs8Vz?=
 =?us-ascii?Q?sN8H+C35eQ3TK9/rV0IRV7LsBCGMsLPd4A9mSlGPyKIA3mOtDsRy+5BJILhW?=
 =?us-ascii?Q?teP+o48Cwb0DNDucepg7v5rckvJTSBznk65BEPalxV8oht3v80yaRsmfL3HL?=
 =?us-ascii?Q?zeQrevXnyKBu7HE6AsvIpXfpRuP5h81WsImDDoILAhx2RAY89oU6NTTHHaTR?=
 =?us-ascii?Q?lxLP9fP2OPHShceA8bZYUDXmccdUsYi1tHvRDHiyiyrIejtFQPz98PeNsZgN?=
 =?us-ascii?Q?LS3FW9kXBgtwmUuXV3/5lQ7WjXPbrnsdzG8qnJS5Z/BI6+nIanIaNanN+akB?=
 =?us-ascii?Q?+EaTuBiyecxFe7EUJxmAbsaDlA0chGcwzjnf2bLQxBf5qgjCGTdb2LAyqLA9?=
 =?us-ascii?Q?p3S4rOaM9CxcimhrcZE6Xq2VEhi/GhOaHU3t6+ld9z1r2hHQqxWeLlYFj6oK?=
 =?us-ascii?Q?/quEE3GaPiNdcq/905Rg6eed6bIqghPPevi+e61QevYGKgv3R4dLbL/y6RYJ?=
 =?us-ascii?Q?03A8n0sbvKwrPFtTUV3xLB/rXkqYxFYf/uFJBkksDpifr61GjoSGOqPqihBx?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f42802cd-7b11-4dd8-027d-08dddbed2d4b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:27.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xclERnqUu4+YxSxRNkPrNQMRtvPhx5LpEtH8MrtwMGgVYixAgtHhI2FwoG+J/5DCxm8NDXj5EWgX/OAhuJe3/o9AbWwuZZpK6GRq5Oivjb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10032

This patch series greatly improve airoha snfi driver and fix a
number of serious bug.

Fixed bugs:
 * fix reading/writing of flashes with more than one plane per lun
 * fix inability to read/write oob area
 * fill the buffer with 0xff before writing
 * fix error paths

Improvements:
 * add support of dual/quad wires spi modes in exec_op()
 * support of dualio/quadio flash reading commands
 * remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Unfortunately I am unable to test the driver with linux at the moment,
so only the following testing was done:
 * Driver compiles without error.
 * All changes were tested with corresponding u-boot driver. U-Boot
   SpiNAND driver was modified as well to matck linux-6.17-rc1.

Changes v2:
 * minor fix
 * add comments to code

Mikhail Kshevetskiy (13):
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: unify dirmap read/write code
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: allow reading/writing of oob area
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup

 drivers/spi/spi-airoha-snfi.c | 504 +++++++++++++++++-----------------
 1 file changed, 256 insertions(+), 248 deletions(-)

-- 
2.50.1


