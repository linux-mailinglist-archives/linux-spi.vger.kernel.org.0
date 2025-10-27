Return-Path: <linux-spi+bounces-10844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50FC0D09E
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62B9188C64B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A32F6922;
	Mon, 27 Oct 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PnkgtcBE"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651224E4B4;
	Mon, 27 Oct 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563005; cv=fail; b=EARinHkPP5dTHUTnPRzZy8v07APfAg+m6FXgJ9OWW7puQ7jyqQA/n/hkfS2cYVZ4c6PvLLb0FQrp0FL3Utp53ZvERPwZf3MBkfvjpEKNnMKBPwdMwwbUO0m/h3otnrgoCjPl0eGGOz0Jj9TQvdvri/5uyK9aHV97DILNOery7X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563005; c=relaxed/simple;
	bh=4NG6GuAHdERBznfOGqSKirIT0kKLYWtpVXwxFt3GmI8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HD8dO8zNit9PJ0ALsd25QKbipV1xDbIQxK0SVTKPzHhzp0g7V9hsy+UftmQLkxnk83kQjO7Eju1gFNJ9+z6vgZCE/DEucMrI0JMWJp4FIbPEdXiHJpcQTAoSq6t+wsqHLbgzjkvVu9c2FEkw1i0qPSstY0EmtastH/cdM8AxntY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PnkgtcBE; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR/xGNhg/Q6UY0JpPV3ik/GeTBURkptp2Pnx5d/6m5TgrTVoWwQBmH3spLl8wj/XVfUJ/n7Cn89w56VSXacWcqo7sIC7mhSv8s5vb0NIV7kajRmzNguVs7B/PXglrrRWggaZSzilHAoNivKLqbMa7KEGLd1xnK3FFasOMMC7LnmTgdYMxdx/LUOfff5UweQoSfa2K8gFuqD8WK0+ok+u1gIDDNPItByvzUMYQDo2tqPsHEAM33Lpc8DhUPcVcWuuadHRSGUkLtTs7uCb8zNDGR7VXLKFfOG2HfymDGmeEeQn6nqbA8QOF7yvS5DTPF01EoFD+6yE2cj98PVxVsL8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDZTOEDmPmZPull6hPj0t9GD5g3xM8zEmpRPi9oD0C8=;
 b=o16yDWzFhFFPyqNHkp5sRWhS19BFw/czcOR4Cs29dA3cSc4yqF6DnpJnjI72qM7wAIw0n+bfYXq1l5qMkqRsJopzanH1WDJxV4yNYclsMm9/GYZfExAoGjzjTSOQm9Rs6uLIGiTHwSa3eC/0ghdYqxFnj4fe+zeX1DiiaXsgu+q21jjr2nrIA/NcHp6VsQgooTxmGraLRvP5NaqJUgcGo1ihx13u//yjUttZYISg74yy22Vs6L5LpzBOtLvUbZrtCzd2y5hRKlnm3oK9z1+yUVlWYgpEPngXqiKTQhHrLso/+lzdG0OIFpSVVCVpqR07cPY5O3BTmUP6i6R+2cOE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDZTOEDmPmZPull6hPj0t9GD5g3xM8zEmpRPi9oD0C8=;
 b=PnkgtcBEEsCrbILCixkjxwATgvZuzI39vK2d+5Q2xfIgcEJs1uQQWaQA/2L4jxLlUK7RNbBUcCnX9hWOA5nCi4MfEc2xegMGO1qt3b2t7uNiT6yAr+0Zibz4B2VJ/lLoLJhfs6lvgu0PsIviGj0ORUOcCjiUhhpKtXVepGW7hgVPi2Fta+P0m7rXaVBB/UtLtnlksZ1QsOG5NA3aG/loGfEbfIhV7DawA61qw0aCNSu2yBr3jL/Oa78hCvlm+Vee1g7snCU7d2hzFTPg7lioJWnUcZc5uIk/5CETmWfl3og9y1Jxzbrm0f1eGApAIYwB9oTlVX2LVjP3ekHyTpMM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS8PR04MB7830.eurprd04.prod.outlook.com
 (2603:10a6:20b:2ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:03:20 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:03:20 +0000
From: carlos.song@nxp.com
To: mkl@pengutronix.de,
	frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: imx: add i.MX51 ECSPI target mode support
Date: Mon, 27 Oct 2025 19:02:56 +0800
Message-Id: <20251027110256.543314-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|AS8PR04MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acff2ea-572a-4d7d-973c-08de15487001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SEajAo+QL0pnsvrsUPAw3bPkLdSKCTBS6IPRBqvHlchnGX6FIyc5uwQk+t6P?=
 =?us-ascii?Q?JqaLeQcyxg1xxYDOikdilFL9FMjG1awb1ob8y2nj3SC/R8HW7rkf9UmEgrAD?=
 =?us-ascii?Q?kujMP7KIRUrrCqx7xQYoAUiTOBxCczYJHpkE9LKVfT9TTH9CEqYnCKIKnzXZ?=
 =?us-ascii?Q?S4zUCYH69u5z5x/D7TQ1X7MNg049q70fqGz9wk6txygMl7kDxAJ6ASBw+6p/?=
 =?us-ascii?Q?b8gwWsYyskvqT9nWM9d6HJtiMD/oW6MvVYiXVVAROV5iY+8BdtEzXrNnjPAx?=
 =?us-ascii?Q?N7mCXdLzIcCGVC7N+IaMCple8szBeCeDatQoEKQGre2rjcatf7ZbuNVa5pke?=
 =?us-ascii?Q?U0xLa9Ph/D+7daVtyOOZ3DJ2yfwEZap106ADBOIxydJfzeZD2rGy3cuGuOOJ?=
 =?us-ascii?Q?TCtE++UBTBMh8Zkl1w6Ox/HTCisMFCBqvDTpZjGADERaXxo2NEX7Dku3zjsq?=
 =?us-ascii?Q?9W6xssLrRh0KdAWzXK9enizNnz6NtBSt2AO2Bf7EmKRC04GtM9RNSBCxX4B+?=
 =?us-ascii?Q?PXohmEWj1sTHmzCEJlFGBPY5Ngik2ZC8946YmFna1erP9D6tsI043PM2+1Ma?=
 =?us-ascii?Q?LkDcFRecOk0+JPnPcYOLBpz8XO/7QLkTcI5bihbQ7FnlqradVtbjxI8/6zju?=
 =?us-ascii?Q?cIXN8YKNKTNMWUroQH26zaot+F1usn+qg0PdH+PVVQ2THrM6VKDAkIsdUrxX?=
 =?us-ascii?Q?9U2Lo3yQVMrpCL/uvVtsF88eFVQOxcsHnIFSZGv3SjudHhLdWhjRcKkMihfz?=
 =?us-ascii?Q?ThvQbIE7v+tNu2ZXNUP8uc8Cgw17E2S0zC0Ar7CZmwo+5EqcOc/UwxAmJ5TH?=
 =?us-ascii?Q?oQoifj2bogury2xga1pz7tE0gjoBF0IJqtx2L266IvSjRR4dqcuT0W2c/znG?=
 =?us-ascii?Q?F0tqqNEveqExDY4BLMHBCInfbvQJlnaf12ILNCa811EfTvwT8o4fp4fzlU+A?=
 =?us-ascii?Q?zSIrx/u0i3rDnZz963zSZqqIVVQpCgRxzCP2o4MceNScCL60GoOClc55Xesa?=
 =?us-ascii?Q?kSMEoc4B1k37fWRk4W5Ae0EVl5y2nVkVJTTUFvHpkFEoh6u7n5YyIGjC5WaD?=
 =?us-ascii?Q?k5sEDspJOvkjvfu8HUzywVQ6gh4XHC2YNu8B7R8W6ODlYHEjbskYHMoLDDjx?=
 =?us-ascii?Q?zfRzWTFTYDE8aitIMHCCaScbOHxpWI+jWWrM8S8N4M6plONu6JDrhvY18kgD?=
 =?us-ascii?Q?LAQ6L8HB4Fk35XwHGasPcqGYZEtvnx/bzJHW41yNl26BLjpoog4xR4BG47jt?=
 =?us-ascii?Q?0uWv5zjFK2CA8Ix19trv2XbdTY44meRuYo8hCoKlOXWSuiRLF6CLWr+4mMAS?=
 =?us-ascii?Q?LbMK9p01Ghm8aC8iqqJBtc3+XA9JsfJdwFFwzFl+J7vqia/aCoRWY08kzqMu?=
 =?us-ascii?Q?JQUkIxLMChhYHt13JH5hUtZWhYqIPfartUHY9oDLBDucH6Us3w/YtmcdxC9i?=
 =?us-ascii?Q?kTKkuq0jgOsT5iKa4sgWHhE9fuuBQadn9n1XF4BXTHkuOO1RYoR9O2Uwvgqe?=
 =?us-ascii?Q?Kn7A14VvGfM6yfHo4vsXff5INdRERU8zLlg7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqJNe50hm4hOyKvG702e27iK78R2ADaJo5QFlOhYxZsoUwOkv0OVAi+TB2OS?=
 =?us-ascii?Q?B5f7LZwiMH1LBsLpPy/CsNTkQq21HbI7YJEgSxDM8+LB2sVCVgBrxEcW9nha?=
 =?us-ascii?Q?cpfWhr5vKNI6XR/PxFnOfy6ggdX458JYetsokXDtLpwPyQYl4gVh4N9EzUEG?=
 =?us-ascii?Q?r78JQkWKilSzaR9BHXW3NLPMlN2VhdmJ/ThHL0H1s/icxlzSpb/frb93SnAb?=
 =?us-ascii?Q?Ir6HoVTwjY9RVJ0Z0qA7J08Dnk9fJJY6+vrd4yDqUQVGMMS56+RrU6UPpLHc?=
 =?us-ascii?Q?tZfee/r2+E7WIV/rHgW4+tS1nJ/7473ITZkVioMj3845ahKYhfUkW69xV9pv?=
 =?us-ascii?Q?O8nZB7XbWAQEvbIMcH67IBr3kkGlHhI3FcgjVndrnGbEV0+NX9oJHRl407Py?=
 =?us-ascii?Q?mw5AMOn5IeUDUK19cRinE/eRmlOre1P/7kaze/cCXsRcaJh50d9ZJWeI7l4r?=
 =?us-ascii?Q?SfYrtUL2ErdOtIiLlAHXowQx7Eq3CjqzCT/TeyyMudljM3i2eRTtVIjuzH1+?=
 =?us-ascii?Q?upfsrHroUkUfDPWJ3HMUbahMu1ysNhzSh573JVrMjj5Yg8/9395ACQ5M5oRj?=
 =?us-ascii?Q?TaCXWTzKe3pur724YHrWQm+MkULlE8hVHZ82blQR2yBRhMNTWX62/U5RxLDs?=
 =?us-ascii?Q?wKz2TS2Pqc+8bChSEXFf6nt2LqO1NOnu2KKlkRHOkTSZ/fDsD0EROIdV2MVS?=
 =?us-ascii?Q?+qqpsB9g9wnVxOFs0LFDsuq1Q8wwlFvJVAKz7O6HOEFbqjGe/nVPesJLCSAh?=
 =?us-ascii?Q?Ed5LjnBkUp1PURcqtVZ6su+tJJ+g8BW957YPBn76YJfrNK1InOCXzTb7V3Qx?=
 =?us-ascii?Q?HJhRyMo6l4BZX5XqUsUYuysHt9AAfAXj4M/LRAZf5/ZKgVD6d0GqVsaNiQgu?=
 =?us-ascii?Q?5wTx0CE972kwy2WxjNkXplLQuEyj75cL//aEG/ds/lhJtflMwBvHzZRVzR/g?=
 =?us-ascii?Q?bE57JI00lJHAVzVP0wRxAGpj1+4oi626v+qPu9qySpQMCEX5QFEzBwKgMzjP?=
 =?us-ascii?Q?wF/i5jNplhsrf9U+k9Lva2nrg5ri/53qsgJRCTIYTDbVpWPAXBKgCqjTa0RB?=
 =?us-ascii?Q?p7BM8XMk68XMdoYaYop9wOGnOYx3aTfHbJXJYn0WVfCYWbWj0pMfMYOwrQLu?=
 =?us-ascii?Q?DBnXTH830/CFc174AThyEdyp6qzTGu1ISQu3ruYthxnVOkOuiTh3BANM+QFv?=
 =?us-ascii?Q?8nJOatXdjZE+PXNpUdIfq93GKhq+JLbXc3ee4OvKeW5qtJKBg1Ho0clVSqH5?=
 =?us-ascii?Q?FGs46YEMN/aiwt8wxTpD2B61rF7Mrwt/zauXi6Oe7hbmruSPVYpzT0XyPXiL?=
 =?us-ascii?Q?w3lg9eYv4+kj0YcOt3w8EpoUXrQWJgpvnRh6328if0NMiQxRvx0zS3cmAUmF?=
 =?us-ascii?Q?/Jfo6P+rH6fIKMp6WsfLizj1UgxC783NexnoAz8+yqt44cfGWtVWDDXqRX/y?=
 =?us-ascii?Q?XuQOR9XocE3r8yspKgLEiGlEZysyR7HCXYcR3n/b3IJV4F/lZ1WE0ZEfr3RA?=
 =?us-ascii?Q?4sDQzMIeHHrbiMozS6NGzOlaRYTtFNAj9gvBzKDYhZP57naj0ec7dfu/xdnQ?=
 =?us-ascii?Q?LMgbtEDudebeoFH0RyiLd0BCHZoQWhAJ/DH0L5ds?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acff2ea-572a-4d7d-973c-08de15487001
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:03:19.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FfO9eEXJ6aMUak4Iq2rflAS1+O+eOMvPbfo2Lpx4cj4NFSlQiaFMaVw1ez7+GiP0BTr484hS9HHzIwZfSuCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7830

From: Carlos Song <carlos.song@nxp.com>

ECSPI in i.MX51 and i.MX53 support target mode. Current code only support
i.MX53. Remove is_imx53_ecspi() check for target mode to support i.MX51.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for V2:
- Change patch name and commit log
- Remove target_max_transfer_bytes from devtype_data
---
 drivers/spi/spi-imx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 64b7e977dcc1..9a1113ea4ba2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -594,7 +594,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * is not functional for imx53 Soc, config SPI burst completed when
 	 * BURST_LENGTH + 1 bits are received
 	 */
-	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
+	if (spi_imx->target_mode)
 		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
 		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
@@ -682,7 +682,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
-	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
+	if (spi_imx->target_mode)
 		ctrl |= (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
@@ -1375,7 +1375,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->rx_only = ((t->tx_buf == NULL)
 			|| (t->tx_buf == spi->controller->dummy_tx));
 
-	if (is_imx53_ecspi(spi_imx) && spi_imx->target_mode) {
+	if (spi_imx->target_mode) {
 		spi_imx->rx = mx53_ecspi_rx_target;
 		spi_imx->tx = mx53_ecspi_tx_target;
 		spi_imx->target_burst = t->len;
@@ -1649,8 +1649,7 @@ static int spi_imx_pio_transfer_target(struct spi_device *spi,
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	int ret = 0;
 
-	if (is_imx53_ecspi(spi_imx) &&
-	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
+	if (transfer->len > MX53_MAX_TRANSFER_BYTES) {
 		dev_err(&spi->dev, "Transaction too big, max size is %d bytes\n",
 			MX53_MAX_TRANSFER_BYTES);
 		return -EMSGSIZE;
-- 
2.34.1


