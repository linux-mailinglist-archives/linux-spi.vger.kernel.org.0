Return-Path: <linux-spi+bounces-11504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE6C845D2
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E9A3A46AD
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2ACA4E;
	Tue, 25 Nov 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnLvGXa2"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024C2857FC;
	Tue, 25 Nov 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065220; cv=fail; b=eDf9PIRbWwQkKJAr+L/xRgnqCvgSq8kuNmdVU7G5Rw0GLigGnZOm4IbEOmp1XPli5nLMrk+FDCdvSIN85fjF4b+LdSHeGBI8ZfygqTzV+uG1Dh/xelnEhXkJWJo4UIaAAjEniYwUF8hmO1G4ze8uLrZKbzVPhFwSlhUZxhFExp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065220; c=relaxed/simple;
	bh=/DSYn7si1X+REN8R9XL2YDmrnfH5JX1CynzNH8kKXX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eWWZh/Huoht76t97A+xLyrjjkOQxiDpf+GSRHeAnD3wAEyt0PYEIOS+KpHyWJkpb+2sAvtJFpSOP38r8ai4B+IsNUeBgF2EeGloZ3G2IKhC61ADF9Zqah2p6cocO7FM63EudtAEo/J0dt2opn6o+Zr4xRSCMNQ1Nbkz4QfGnSz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnLvGXa2; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySvqnKTkd2w86wVThPa8jhYXq57rEPjJWn3+4Ok+yAp+9ggrkfFgHte3hIUWOcjWgMjZJsxYrMKCDYgKvZ+eSiMpn/6xyr2ueQHkEmRT2l7e0HgDBFM3S6a9LJ397zXULUiuf4h0VtMhLn6LseJDPIK5HEV5lqW328mpsTBX7e1qej5EkxMzBXZ49yUf6baHnITnq9eQOcOVvD7gHYYjMWjwEvY/HZufXU+n4MpEyGrzrLtZrXokOouGVeHkWU6UPtK+5qwb3dpgjaIQhMBzXXJ/bUMEGW6XMqWaHSWZgp9gRdPdMeGgNlFfX7XthEKaUMT8sHSKj1ITdAVLc29uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyNfWaDXBNg2JzSiIwjDRCNRFWKZLpTdnIGSPYl16y8=;
 b=kMzOznMUZx9+wsG1yoL3aCIOanBmmBVwlUT2CZIX6EWYGa3egZsEqJpY0pYnxP19m3/5rct5rGPEYGyHc934KuCzkvffZ7ul9K4FbLdjshcdBIuHJhz0XaJKqib9WB9w3/ITo0IJmX4E++8qUNAKE12ZEgwMkzwZv0TVxxdMDi5Z1O2V3uv+fcWLliO8Ve1nD8CbLIVsaEWFwfWb1uwcJL+KC7BiL9k6xyyAjvAVG5qU6a/2QAjFbWsmW8ldir4T+T9h395J2qnDlgU357ZQA2z7LoLvhLWUMmRETds/B6hxf330Z+/baOIEJ+5bVIIUmey9MGAGdByYvuJSPpMYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyNfWaDXBNg2JzSiIwjDRCNRFWKZLpTdnIGSPYl16y8=;
 b=FnLvGXa2Km8wZbq+QOssNVrz87IlTJeoKfm0MGEL7ngklk7VK549UdqbfVrr2eoLkjMX6oWKcA+3EEo24d6w6/aTASSzZi11sbfA/LDdQFfB8whI/1R9rMBD2HfiaM4PuKvwKgoJJCTFb3CWBd9wULmVvoaZm8BUezA89I2gykwMg/gai4rsUpUOfX1iaGsND9Up0DG6ttpu4k7oQteFJKEmOCdr6VOzHeIqbO1rJf2xVsEMfV6Ii/4g9Xp2O3KMaFqWLzakfvCTClnK3zTi4j+RpSnSBprMXIh/guLsBSJlH2U6A18KF+iY9MXuV1WjaUdrcJl/hjvihs3leLlbeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:06:55 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:06:54 +0000
From: Carlos Song <carlos.song@nxp.com>
To: broonie@kernel.org,
	frank.li@nxp.com,
	hawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH 0/6] Support ECSPI dynamic burst feature for DMA mode
Date: Tue, 25 Nov 2025 18:06:12 +0800
Message-Id: <20251125100618.2159770-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::14) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf5f44b-4fec-48f7-e6c1-08de2c0a5c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSQWb/4BoFl6TwK5dWup6PHIyzm274vHz+NNutPqHc6+oJn1RCl68fPnClxd?=
 =?us-ascii?Q?vNTqkCcLCwANwZFoxaF2JnoCw9e6P6YDDvaVYuuF63t3ji6GXpojm3aRf0I3?=
 =?us-ascii?Q?4FoQnFPw9gTyUlPVZMFea826F1akNwHFA18ejDNclwsVNscGUKJfIVRa1gGR?=
 =?us-ascii?Q?pnd1vd8c4+g+HucMwYnt22HEVTDUTEef4bspE9XkidaTjGqJxwG8IeJxNYpw?=
 =?us-ascii?Q?qdRHvP3ASbuwwsgo8g3biw9jp9669Hiz2k0NMt4btM6aXRj5VIvXLg5BDRIg?=
 =?us-ascii?Q?S1yOEjDkUEuRQzSONt8VhO0bl87KQ/1TPCirty4J+WDmxFln1575h8KFd7l7?=
 =?us-ascii?Q?4QK1F9rz/7ELg80Liv3rkVexqUDt7YnYnbU3tydyLjOmGxgF7vJDqAW2r+7P?=
 =?us-ascii?Q?LL7zFAnaoCozJ4Ci1mEbQLGbASYy+1X4K86/sDQ6JQ6rxM+VJW5E14rfNUE1?=
 =?us-ascii?Q?agt0ZPuqXxjGoG/gf0196vKorr+zFyUQuOdAXxyVXudKy+Codf/T5ZgbqtRp?=
 =?us-ascii?Q?FI6TEfIrnaa/8sbYL6ZzDRryV9MsXidRaaT+YPDJHEwHhcxQiOsN22wnw643?=
 =?us-ascii?Q?gfR5Ercb02rXTSVeybFpq57g+oq1tPiLmfk5HKFeIAgsiN+eQOQFyJMTjLVG?=
 =?us-ascii?Q?AWPnJi84fB56WivIbt5bPYMAuAFtI7CAToblPeJOtpF3fY2gBGVM+xD32VXF?=
 =?us-ascii?Q?xkJ1R5IQoEAQUnMX99I6TKw3n5ZIsVIpEdyk7M1GUmJqI7+rH3arRxucHLNZ?=
 =?us-ascii?Q?3yC3X7sWgUybJ1i7AYpyFgmmcOUFTxCTHLcCfyq3Zs6QHDoLHXQH4OiWmBUb?=
 =?us-ascii?Q?V8kK487aEJVggCfYwBjS0goEvzp98TDDWf3l7qiT9vIHFc+GYGzw3hAIwteT?=
 =?us-ascii?Q?FkoURDzYeiAPQztmXXwDFHnbbPmQOCErgaYh9HR9u4eE6UYoJx70yINBrG+U?=
 =?us-ascii?Q?x+cjX9l+LY2oV8IyUqg1ZtKZqJ3iXavAybmKZQS+JcoVFnR4Wm5rxmCVNTsU?=
 =?us-ascii?Q?XGY/aD1SCi8OlzS4g5sNXeryzxPkQtglJ+5BSdF0XAsOm2AxX2wR4xSBqIFo?=
 =?us-ascii?Q?eCKfihE3FVNDMBI08IEaJW2/cdR503rAyIHSsq9iZauI6DZ6EVjl5OGm68rH?=
 =?us-ascii?Q?fQbjBP+zaA9f3H8T9/LxDxsxZu6obWeuRHc3V7VAHgzrZQaAo2zyHY5rLvpU?=
 =?us-ascii?Q?vaCA9lstNGrKVzAGdYdFBXwwa60Cma8raDVdKHW6cqnbRidTHpoXfwkXxJ+Q?=
 =?us-ascii?Q?/xMD/Bm4SwR6oSS5gyLqXLNQ1UmuPiiGFnttmFdseeKJLJBg/97JB7ezPExV?=
 =?us-ascii?Q?LEFMxhikaWffd+le54SCg7poH/8GXrS+2cn53hDIEip+j8RD8MdhbKQ/Yp7x?=
 =?us-ascii?Q?hLBB9pzW+sMDzN3jSw1M6v0AzJZ/01XuPJh/ReyEfDnNYbGmxy98Mn9lPabg?=
 =?us-ascii?Q?4sw/tqg+oduCumG5OAx85ZdSpfYab74i0z4PQZmHdzJjQ6YHEcv5cLTWQI3Y?=
 =?us-ascii?Q?2uxNLrrYELruoHpacLOlv7wk1/tk614Fc+Nh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKxED6SHRKy+jUfZHKBOOSALYhoWToQrqpvuTAP9yWW6D9979zaS+I2dtr+9?=
 =?us-ascii?Q?LUxdwHBWgZool3rKxkPhPKhbO07YXlYpKEaFHCPbf+gFcgbGCaSI/J9kij8C?=
 =?us-ascii?Q?GCS01wfd0XZD3oeCgZWxEy7EKtnSp9IQkR8J6HrKSr6Cge91GA7BoqzQSlo+?=
 =?us-ascii?Q?GiO4RtqOBV7h47sotHPzenkbyipBGgLX7gwa+NpaeJ9axt5I3yxOwngSK0Gb?=
 =?us-ascii?Q?JILLhCearOLf/aW45sB2GgL7PKWv38xOdtnW/sDi+V6SO1RfdAUs5Vl8d1Rj?=
 =?us-ascii?Q?77q4hUsDzHOOSfkExKyX4hQYpCF6sJwHb4b/s9JMMpJ3zgEvdtOZF/q+TMRT?=
 =?us-ascii?Q?dWSO39TEz+1lPbAMoHZ/f3e2+hwWDDNerVc8jm1jmRPk85zsmJt5Jtgr5Fb0?=
 =?us-ascii?Q?tQuLvqfnWE0TddgbJrVP3Jn/+WKVQVGe5lElWVVku2WMy4hSrVqFI3nCzSIa?=
 =?us-ascii?Q?aZQ1dhkaAsJ/Z2T58OY8mAwRFv01th2W/4U6c2amIrvfshRBqhXM8PUlBzSR?=
 =?us-ascii?Q?x8it46ABHg1eximQHhJuMkItNkMHD+hmIFT5nT/PdIF0ugWr7b10Hi8REIV6?=
 =?us-ascii?Q?BMJFWp0UFi/UWSMnm95tNc0t3g0PIjJOYg2V/3YRs6NsCT9U6EkHnHpD5MP+?=
 =?us-ascii?Q?CFWka6GVh5bZgHSy9e4o6d1ww8vgJ7FW6aq3g82KRy6gW+1eEKi9bXoM2p5j?=
 =?us-ascii?Q?t5A+g3himLjojnA/3eAKu659y9pl9MfDPj7m0dSpa4cvQ8D5DuSs96bPXchc?=
 =?us-ascii?Q?fh2DiFzoqv+69tt0JYNElO3pR3XUpDPt4BfVMs4r/YrBzC/0KI8L2m5t4nHw?=
 =?us-ascii?Q?Pgj5sYTICd+ak10EEY8CuuL6vx/3aDHwAqToB9j1biZxaXaWImu+isAYGNQ8?=
 =?us-ascii?Q?CeVC1MnkTRrsI8K5Y0X5ewd+xeZktQ+yOUEGMHuJfCjn0u8d7dWeCdOKkRU3?=
 =?us-ascii?Q?hPwon9Hc0CJHQm2TS7WCN7qdVT3jXuHAq/S9sMlffJvIEIsSMh7fubc8wBBB?=
 =?us-ascii?Q?eXboJH9S7HJUMvxQgwTMa/ecSI3WKh4gUIBk5Q9AvKwa1zVEWhjD/Cu4hr6Q?=
 =?us-ascii?Q?+wm82qOwlTmSqeOxo8WRwwEbUvXZffZdjuCXcXCEbw7l0kpmCZEPk6q7X2G+?=
 =?us-ascii?Q?N6r0GL3YBuHTzfgRtrDcNnEEqigLqaPIHQ2AqacIsJuAWdFLUSjRLBlYA8Nc?=
 =?us-ascii?Q?ghfaalIc6cfAPpgAS1SmqSD5kjRjIevakW+2RhjT7VRTQGfQD5RGETZlvfhW?=
 =?us-ascii?Q?Lv/gLQWKIqJyRlMSE9iPANUNId3hTOplXKKkwY/XwfiSs0BVORoydSOkjJYY?=
 =?us-ascii?Q?DkxJYUJYXIeLU9zNM/NBRk0bBhkzM1OnXTxjH5ocr3cCt9qMPTIHvABAevdd?=
 =?us-ascii?Q?I6TvdAaYH78+gJ83mPdvmevIQBSQ6/5v5TLmfVCgI7EudiAfWfOfIw7qDXqV?=
 =?us-ascii?Q?GQkpYJYr1v0F5TobADWJR5Oh1UcjWdxdVrpoQRaKyOEWIwwlfqa7Wf6CwjC2?=
 =?us-ascii?Q?iWf5DzmSC/KMw5rSe1Hko3sZyK4QlEnK9YhM01I6Xr9fWdhsD2mfZvTo5z7J?=
 =?us-ascii?Q?Fh8/PxFjXiwh8A/SkgAsPo/mxBTs5X2Gk4qhDKSq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf5f44b-4fec-48f7-e6c1-08de2c0a5c50
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:06:54.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ1ykD4n7IhTVADyIqKRiGwPbksz9zvjy+WLvsfvNPjmwCBoAjPLchQiQv3W3Hi42IWlxA/bIMCX9S0+r7Ycxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

ECSPI has a low throughput because of no dynamic burst support, it
transfers only one word per frame in DMA mode, causing SCLK stalls
between words due to BURST_LENGTH updates.

This patch set is to support ECSPI dynamic burst feature to help improve
the ECSPI DMA mode performance.

Performance test (spidev_test @10MHz, 4KB):
  Before: tx/rx ~6651.9 kbps
  After:  tx/rx ~9922.2 kbps (~50% improvement)

For compatibility with slow SPI devices, add configurable word delay in
DMA mode. When word delay is set, dynamic burst is disabled and
BURST_LENGTH equals word length.

Also support target DMA mode with enabled dynamic burst.

Carlos Song (6):
  spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
  spi: imx: introduce helper to clear DMA mode logic
  spi: imx: avoid dmaengine_terminate_all() on TX prep failure
  spi: imx: handle DMA submission errors with dma_submit_error()
  spi: imx: support dynamic burst length for ECSPI DMA mode
  spi: imx: enable DMA mode for target operation

 drivers/spi/spi-imx.c | 620 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 513 insertions(+), 107 deletions(-)

-- 
2.34.1


