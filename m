Return-Path: <linux-spi+bounces-9526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A91B2BD4D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CFA18994B4
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D413218A9;
	Tue, 19 Aug 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XzOUv93L"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012025.outbound.protection.outlook.com [52.101.126.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AA320CD0;
	Tue, 19 Aug 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595315; cv=fail; b=FbRzROXYvaSW43J3ELBB03vdzDBbcxfPnqVDIedXubc8xfJu1L6VPX76W9OhW3ROACo8CqOlyf8h/lTMHjpUG4dsiF5rUZjfzms0MlcaXknUQWrLlA0Nuw9EMYjGSSop7jYTJ3O2RCkEcWBqpPZAHooa+DmlLeSaVt478Cs9HTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595315; c=relaxed/simple;
	bh=wPR2XmFG68QY8JdXEmaSiYRf6pI58YwKcbULG2ZDeNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dG6vZp7288YLQajzkbS46scC+jYXYcDdPvmF950jUzykYCVeHneepIohJVdYIwz56Q2FiN6kfNSNkqqAmItMk0dWPivbwb7R6DOF0Q9h1Jec6L+E7+ZSOnAwawigdtaxfoLG6+qwf/qmLqfx/f282Qjg23CToD0n/LIEoJuEZZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XzOUv93L; arc=fail smtp.client-ip=52.101.126.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzzI4dPvEyMFjxCgfoVZj1mk+mK1KgIh+DYofwr9p2maoS3g/SQDaTZiABU5eWHTJ1Fso4B7g2BmI1YnjOb6LI0Akc6kHkAFvzDIrEL3FD0bsZ3BWcBNA6iu7Nu8CHGH+2s+hJvocPme+LS8oJ1yeJdYzkCtzKWtkzbbnZPWGH8apVtHDUEt8GBCspF8TnEaJkulHo1XUo1YWekvr6IyB+cshMMjvaxcYSvawXTfr8dsj6xIQQkGC+hoNV8NrRDrkjJIltYbPyGK3zIRSCd2m36a6tQyL4cbkFWl34WCAYVmI1OUU641ylw0l/Jzfx2mIE7X51kzTwLYGxq7Pz/Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clo0UEbSIY/7rMBrFy1eB7+fUbxnAQ+r0EemMUNAz3w=;
 b=gPvoLENyHjdZTd1kcj0fU5G+AX8q3L2HgvJJBKDyzvLLYCz+eNeL2Q2d91lK5S77X/B1EqpYwuxLCnzWDQtHTjh+WkPcd+3GOV3fvvMSCcAFCCIS5zb/pSo2YPJx8u6aJn6va6dlxXdxYu6w3kGiIbM/eiOTStPSDDdukhQTyaCcJgJ99OVqtiZ1x81s2PWuir7hiDmoFm6sf7szNtVs6jWUN8+iRqcjYjAxBXP3mOHx9rgNDoqO9J7Po3pBVS1ZxebqZUMSHlAMh0zFxqUNdmOeR1aNp8i5TtrOi06M/EEU952r/3TJ60hFp5vuKQC2w+7R115R/6ah3HIKSgYUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clo0UEbSIY/7rMBrFy1eB7+fUbxnAQ+r0EemMUNAz3w=;
 b=XzOUv93LgTtm0LnCzIeXGvv4O4T2ABDNMe5AEiZZr+Ued6c6DqRtjlUGkhrx8eZLeT21SMDohUBY8W1bHue3NnCcHLub5eYIK54gwjT5PB3llk366W2ziGWkYDjVAJLE5pIVyYEckI2kKlJCOaQEWwExXsS73kPldCkKbGYzqS1TkQTiUIq/i95IAFBzofE2dOmZTGUDsTJz0OYnhUm9F5sNAHmKbJQdBx4UzVlvYujDYIKSyOH+Z0Ka56K1M1jD2OYuCpgvqCustaflduu4DQpv6nl0nd9hUvNF3ZnQM2W2Gcm7rapUxOQ2B0vp54H3i9ekoAf4hyAgbaKuwICATg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5054.apcprd06.prod.outlook.com (2603:1096:400:1bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:21:52 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:21:52 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-riscv@lists.infradead.org (open list:RISC-V MICROCHIP FPGA SUPPORT),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v1 3/6] spi: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:20:40 +0800
Message-Id: <20250819092044.549464-4-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 64025fde-6c08-436e-437c-08dddf01d55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2a35NhVO2B8lQeLOPnycGICAPRs5GGxpaY0+zWqZCHNk2Q312BIODi9z3lt?=
 =?us-ascii?Q?bYizgfeTNhHcApzO9KAlHg8fr2DH3kKaHSx25qGp6TO17veAwGRe5PVj8JYZ?=
 =?us-ascii?Q?ZGfRgnPqbIDk/iyKKHa5P/bKjFWIgGke9FAmJP8iwCQx07QvHdGZSFdMP6Q+?=
 =?us-ascii?Q?KybWJ7qqIuy1inHYYW77tVtNh3HqDElfOFSt7zB1a4fRxTwQfSPNRtjJNo/K?=
 =?us-ascii?Q?cGYpTGW8g26j3TWsHd8XVHRL0OGXpBTYU+NZkdTlagJDHYny9/etnR4IREBV?=
 =?us-ascii?Q?CGlMfdcWWJ1u3r1P7kgsS3kxBvrK8zbK8xxhvlmMIzDSv5yUNdqnrqJQQ/dG?=
 =?us-ascii?Q?7KkF000HQ2JkiCYEbEKDvN66g/Ycvvf8N5S+4t0ico2XVuZ2MrN4LLtsJkMG?=
 =?us-ascii?Q?tO8A26ynuOhwEpYZD2PgVqzrZLWVywua2XtcvSZpiej0RZzydIabB6pPE18a?=
 =?us-ascii?Q?AkkKjYs4dyLffdAOGj0USJFkayVoytG926xTxusmxSrO26gnGr9sVWozuUeg?=
 =?us-ascii?Q?sQfxRfrb91iW/XwrfEzmM3NuLo0bWzJ83a0iv5/hsEsWGbpMlxzmh+qGZ17a?=
 =?us-ascii?Q?8yAZOnrirm0u0Fqy5uDgsareMIZD4Emnts9jyEFkdVqgBLYxo3bGfohk1Udz?=
 =?us-ascii?Q?LGCYpzJ+3d4rvgRoLMhI0FkPsc3q2Uv/IGE/d03WynycWhplq7GexuUMP14I?=
 =?us-ascii?Q?KZtlFjQaatR3UAHStD6AAzrWMG1G270qYi47LAn2bgfIMAQKA2Ce+i6u2LFC?=
 =?us-ascii?Q?v3BjHI4cg6HuY4lMQwNQsRGpFzZnDqNvtxJqosAHxKMuZoQTs48lzPM5WoqB?=
 =?us-ascii?Q?ZXJxfKh3ynKoTvRPb8EbxrcwHmatSoVh+9yDi3SwwmaCyaI09RvRaPzl0qVk?=
 =?us-ascii?Q?MKgQRX84Rv3DzjxVdJIPxH5bpd5JJhl6nC2I52KEJesmcNN5U0UnVhhKNJD1?=
 =?us-ascii?Q?08r5u9RUmk0WWQG4W45GZZPiN7PLcqR2waKc+drP0KKrsasHPUBYoc8nrfme?=
 =?us-ascii?Q?oh/kBavp36jmLiD7+zW/DdJCqzuPC4NVI9pt8N2Le5ZWzQOUJDGdIPtpCTvV?=
 =?us-ascii?Q?MTvc5VCHmf3/tOjqgsmvTTC0mK2GsDixnVDyff6kLAOAnmaWIx+9Emt7e23p?=
 =?us-ascii?Q?mVEvfkGraxg8HY/DZ36a6i7MaP87afdt2qvrZ3WJCd0ekwa4r8EtVqgzstxn?=
 =?us-ascii?Q?/PfJA+Z2vPMl8URLK8caJ/y+z2EtEv3atf+N3gEsAWR/OREXc1r9BLKcmddB?=
 =?us-ascii?Q?nnG6wqW9M6FlJtilbygcu3PVki4UFofBo0jTsWQem4nbjWW1isLckvBXsUue?=
 =?us-ascii?Q?dQdN+fGZyIn9GSU6SLu2dt6ioa4lvZQ+jHwTaUqDyS/rZIABXgj6+YkUYfrs?=
 =?us-ascii?Q?yz80HnYN+GLxGDeK3VlMutFpPfKEFArQXGWvM37fnegNcWIQ2q0v/BIqz9jq?=
 =?us-ascii?Q?ReCFXUGpcdo/A2Tz8OsxrvxgzRHv3lKJ1mVPqDVMod3HoKGIRa57Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7weEzWnkUr74voxe+NxPzpo6HyC+20qqwYIOd3B8tzR7PXMR+5eYomOIq4PN?=
 =?us-ascii?Q?QPH3TP3IFRSM0IxbzczzWYsna3NQIIr6tpABd04kzRpkWVeNvibn8S740fc9?=
 =?us-ascii?Q?o8oO69AvlgB4hLNFhSuVzcvFthMGnIQV2egZRMVuXL0FplfgqwgGbA3qoUhF?=
 =?us-ascii?Q?pD2prieA4pjhgKI9O2hT+bdv2OmoxpvQlvhv0qk1absC7gyXiRNazYtquUeX?=
 =?us-ascii?Q?JfK99xKm/DKvX0iqnNGiaqfpXMnh3xAYlrKkZazrY6gjg//g5mjiWL0GVo1Y?=
 =?us-ascii?Q?NqNKYkq6Bc/oq3fzBAfWQMeEtKQ68u1KMXohtgLceG+gyo2peCSD4xVqzssC?=
 =?us-ascii?Q?3hRs+qECGTup5J6H/OyKabEL1cLg53Wxgq/lMHkPVEdezva10TLpxu1Gc5LN?=
 =?us-ascii?Q?hIMBNos0ep65xYL2zagCUsjW46+d49eNAD3dGJGjzBo9SVr3e8a1MfXFbB0u?=
 =?us-ascii?Q?Z8qd1KFdzqBz7xHNifYBqclxe++8myy/vxh8qmGGlI+YXHlNoaIc3ABlH5se?=
 =?us-ascii?Q?oqsJRKcpEgK2MuHgX8H5d6QBuW2NKyc+/eQ2Y1oUTmbp9wZm06Yji9huwVka?=
 =?us-ascii?Q?Qrsq5E/amUdtbD5GsArGTLToMUVPjSERCWLbF/xTSibonhBYTCqBdychon8R?=
 =?us-ascii?Q?MGYgh7OsQ0w2k5f5bTtedQd9Js2cGjprqD0qSXO0Q7jZYAk2fh7M09Hm4/CA?=
 =?us-ascii?Q?YXnT0Zwac9z0vv2upz/gH4mQruke88zKnXshz9d+G8eFu85agPcjBcJJYBYW?=
 =?us-ascii?Q?dhHCZb0ykRNye6q+4LPdxiQAxp1DLwPQKmZg2PwdD/M4EFg/iwFpnl6S2dIf?=
 =?us-ascii?Q?4yxGhgIihT1w1959OkFplzMYeLO+CcTkcEOzxdIWtP//oYdjCtROYIc1p4ri?=
 =?us-ascii?Q?hBEMSKQ/ksEB60GUrOpccF1Uk1GXXafvX8DNIYH8BpvdPDMajQs7AGCbxtkW?=
 =?us-ascii?Q?1DTTomX86wUXTmBQ5nqWXzp0U2WDM0/my6N1v0LKCNHCIANpFxRq3Mo5uCnT?=
 =?us-ascii?Q?+83bk4kHL2fzqF/WLVF04z0kTHjpBdR9W77Dwz1OzEdsHhaAH+3EFlVpUoeh?=
 =?us-ascii?Q?J6IkgC0KYTuk71qQhuWANfc2EWqHBTtmVIH4JYa+yE/Piw3hBpCO43KsjbzC?=
 =?us-ascii?Q?tIpZGSMnRIu/oWERXFWT3FGwJUlxx8cCaiAdeLuNd9jfcsB2G53jvq98qZ7Z?=
 =?us-ascii?Q?bCSSQN6TSJgbldE8FfT5HNi4PN25sI9K7rL6a/6B6RMJvfSRZGhuWmnUIg1/?=
 =?us-ascii?Q?915uxMJU/E66S9nGObwROGHTbuLO5cCd6pFKGotdyNxVvmi1uE4fbNDRTFU1?=
 =?us-ascii?Q?HgQPw3ydlBCqlImh1XPE+KQ1VxfgzWIeqgDYyUyeyyAbdS4J0n+xcIhJVadu?=
 =?us-ascii?Q?pI4WL12ngaT1qNML+lTbcXnaZEIT4ADSHCSzh5LbQcpR2kNVeS5b9EzPRjmQ?=
 =?us-ascii?Q?hIyGZ65ZmPrusDFYqpa8e0kG56P6Bkvv5UxR89YRsTWMAZ5Kbh3JRxfHArVE?=
 =?us-ascii?Q?+PDWCNA3qQQf1E4Vvic+rBTwFQZOahociFm71+JRApFS2fj/2bo8lBKmID+1?=
 =?us-ascii?Q?ZgKp4EzWwL6UfAynVpp7hpJbaKHTINSHjZ1Lde4h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64025fde-6c08-436e-437c-08dddf01d55b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:21:52.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXa+hMSu3FhFIxRdbKLVxd3ccfgXsnp+HuIGRDl0/ZFkb67vEs9Ql4LfXg2fYrhYkjWf8VoZ3wMEjh2H5WS8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5054

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 3 +--
 drivers/spi/spi-microchip-core.c      | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index d13a9b755c7f..0a6f65c77eac 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -701,8 +701,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!ctlr)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate host for QSPI controller\n");
+		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctlr);
 	platform_set_drvdata(pdev, qspi);
diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 62ba0bd9cbb7..9128b86c5366 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -534,8 +534,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate host for SPI controller\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.34.1


