Return-Path: <linux-spi+bounces-3552-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE9156C1
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5221F243AD
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2519EED7;
	Mon, 24 Jun 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWVhYpZF"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A03A1B5;
	Mon, 24 Jun 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255361; cv=fail; b=qcR+EndJi9qksgZ+9Muji9ReJ57Sg0f4jEJsBaAqICta0VzD284AkBo36oYyykzGKKMM+M/3tpqxePEWr3rZPBPj8gM0cMwkjF6zi1FOJ1XnVxuK5biJ8fXB+P/M+Hv3FgC1g/MVrJnaFXn2heTRcnDMrujP+FQmEKfbCt8jZVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255361; c=relaxed/simple;
	bh=KH2tDLFerBCE5xeJDaw6oNnMcLC+yp8zFvep6kWpmPE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=a9B+DoMv/fVvvdBlmxCoD38qNNRvJpJJ1cF/cB3IWAP7/fXzPlc0/ZNXnPmEfwjSFI4hkBNJ2GwSrneFUyQG7CWsBn0tkCFCKePwYgl9rup6IX7wBzHVeGf7TVJFvTcJL3zXDrvrV5zANijpfuYGghpvR18yRRqc1fbCskFR2To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWVhYpZF; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwXQMzsop7w9BB1ocfaxMld8kgMbskqQU7P4M/1Bo40bPcMHXtDlIZlS373bUm07wjF/NZXv+ZmyS9M3Yanj5OmKhj+hHOExJXXSc7qNfF92Lh+TIQ8ItMwz4IeBywrZRBOrK0EzRwUWqw+hnPhc5SMBcadvHE7mu3iqxzh9johZ0Mw6jKLs1CZHqCxaTgKK+IZ4MYEpw6CD53mkvTdpfzxEhFTTEKn7rZiTvRGo8s2xCmYDG3/qCeS4bZ/d2JBmwgr+2rqUaMeuNPCXkC9CrMd7baiZSLe4BB2xOWA2/y7kHwgIPlFcGLHqihdP+YpLvHp4S2cLd6R6F2InfzWY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeq3x3Ko75+ioUzj7Wo1IGhCYqPF3AXjc0imEPKtTX8=;
 b=PDTfuVzzXHi+ieOfetue23AH7b03qWo5umziQgkUH0VWdPHBUIfST6rTN4LuTdjsGRIOO9dzymt/2EBszeRXAcyahlal18gmOG2jZ1uymwBuceoOSb3Dh7Pan8sO2y65FM1cI9w++3MpT8X/rw4yumfCKj4F5xPly9zlFYvls4RXcFWnKIZZQDgIkoGdt6NP5gq8ByLxRo1sAuUHboOqmewyqKoMUEOvm4rKbFci0OVjVcF4jH+FXrqseRxMIXFbW6AxhSP+2Zf7C2sUefpJsovuByVm52cvXTdVe3rzLAVu/X7HU9c47G0LZd0/qETeiKwGdUu1L2dstXlWHLW9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeq3x3Ko75+ioUzj7Wo1IGhCYqPF3AXjc0imEPKtTX8=;
 b=RWVhYpZFmSWm5bj9gDo9RoLG/51SNgWemvOiFRi3d76O7yUoVIyBfdrbxszYiRr1NUK0OcoGpMUtwDajEB8vYf92Dm050Us+XCQicMzNpnY4btqF6Vd63JEajM4JGGRwuNbpeh+Xqo+RFwHPhSA4J/FiGFGZhQZPu+R6keZuHVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10138.eurprd04.prod.outlook.com (2603:10a6:800:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 18:55:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 18:55:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] spi: fsl-dspi: Convert to yaml format and use
 common SPI property
Date: Mon, 24 Jun 2024 14:55:26 -0400
Message-Id: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7BeWYC/2WMyw6CMBBFf4XM2poyLY+48j+MMVCmMolSbE2DI
 fy7hQ0mLs/NPWeGQJ4pwCmbwVPkwG5IoA8ZmL4Z7iS4SwwoUcsyV+IRbq8wsmg7Qx1KQlUQpPf
 oyfK0lS7XxD2Ht/OfLRxxXf8bEYUULda1LW3RVqo8D9N4NO4JayGqHwvlbqlk5Q021lidV6R3a
 1mWL8tvVV3SAAAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Kuldeep Singh <kuldeep.singh@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719255350; l=1972;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KH2tDLFerBCE5xeJDaw6oNnMcLC+yp8zFvep6kWpmPE=;
 b=GSSICJiMmlxwfFGfRXN7QcQ0sLrCXSPd9azGddT5KlsbeXi12tIRxGdpXMHu61d4BnQc0fb6j
 WvFhLdEsrQMDpu7bwkoQlVDfBA+U+0i/j7caoidVI9drnFq0TaC5IIS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10138:EE_
X-MS-Office365-Filtering-Correlation-Id: cea39006-6c3d-464a-a116-08dc947f45e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDV1U2trdnhXRGtHc0I4RTNtbFR4VldVTk5LTURHd3JjZTROald6S0xjR3JF?=
 =?utf-8?B?WmRBbm1EZFhNaVpWcFlVOFNVZ3BWS1Fwd1pVbVcvZWR2NVBnVlI5Mzk5WmE1?=
 =?utf-8?B?aDVtWTB5NXg3azVLU2tVSTRrR0pqNmJHVEZGSW9rWXJlNmc2NnNOc2hJUWQr?=
 =?utf-8?B?QVZ3cWtCQVkvRm8relQya0F1MTlTMXozcGt4NmlNYkZ3Q0NVUFhPZmRYdHRI?=
 =?utf-8?B?WmRNUjNnTW5wZWtOOW1PVXBVczVEQlRreTJ5dS9VMVYxa1JqNmFRZ28xcmc0?=
 =?utf-8?B?cnNIdnFhM0h2WUZEeEc3bHlrUEd4UEpzUVY0VTJ5OXliRU03SERTVUlPYnhB?=
 =?utf-8?B?WUlIUEhTcE9mN1BrVUF6Z3BwcmhhaEdpMkJVYkRocFFibnF6YnhOWDcwZHNX?=
 =?utf-8?B?dGQxV2NreTlncXdoQWt6V0JIMGd2RTM4RXIwc0VFOUhFSnpOSEMxSHk0SC9O?=
 =?utf-8?B?TVc0SzhTWVVDS3RQcFE4VklXbnNMeFZ5VXBCU0dDeEYrcWZkdFluUmNnR2l4?=
 =?utf-8?B?dW9WM3NaLytVVkd1cEdsVkhrUTVIV1hMRWcrczZsL3RwNzlCQTZ2cVBWb0Nx?=
 =?utf-8?B?M29DZitXcW5FQ1NoT1ZEQWd6QVdKM2lGMGQzL0J3VEh1NW1tWjhNMXk2bVZI?=
 =?utf-8?B?eFp6b2dGV2Y0MStTWHArdURVYkxHaUN2YXlZSFh5akRUMnBScE5JUXFJQjZ0?=
 =?utf-8?B?cnZvV0tHZDVObVh0VWgvZE51N044WVdHcy9UN0U2MjdaNGZhTEU2NVZmeG5S?=
 =?utf-8?B?MGY5dFdmQ3JDdlgveGpTc1lrL2Jrd21IMFp2Ni9ZNGEwamd1cWxicVhqeUpZ?=
 =?utf-8?B?MHZOajJoQ3VtcFRnS09ONlYrZWIrbmc4UjRUUmt4aTdFZlZLVldlNEVsakor?=
 =?utf-8?B?T1hzMUxxOGtlVDAzZC9Cb1Z5SlhHdWNGS0thTnV6UUFBdkxOWXRSbVF2MVRN?=
 =?utf-8?B?bGZhR1hyN0dMSHQ0ZzZNVkpLbnV1TW1kUTBrR0FPWFhLRmRQdmc5VnhvM3BM?=
 =?utf-8?B?T2NBdkNlL0FVRGtzTXdtNlBLTGhLcFQ5K3huaEV2Vi9OaVhvMnA5ck53ZkZW?=
 =?utf-8?B?TUJMM1RHUll5U3NackNNeTVaSEZvd0dvR052YksrRGFiNHUwZC9OYk5yU0Vu?=
 =?utf-8?B?eTNmNS9UR0RSMm1DSUVyckxwbzk4b0RFUzJDMmJialdvRHBidm1BUThWUk9I?=
 =?utf-8?B?bkc5R2ZncDBVTXZtbk9qTm5uTDZZZW54N3F2eXRnOVJabUUrY29GNFArQjJp?=
 =?utf-8?B?cGU3ZXlJa0QvaGFId0xqdE95ZmNmMmFzTFk2OFFmZVpXZTVZTjlCZXdCTFJ0?=
 =?utf-8?B?Qlc1R3QweDZVNWk5TWdQd29VK0J3UzZEYzNaMG5nbCtHa3Q5Nnl3MnNwcmVW?=
 =?utf-8?B?L3dqNElmbjQ3bDNQOGhScWtnOHIrdml1YWV2cjFXcWRvZkxzSDV3Z1BIRXRT?=
 =?utf-8?B?V2hLZVRpaS9xcXpRNm1pdU5pT3FJQ0VtcC9BNG8xMHk0dFZVMEJsMEV0RGRz?=
 =?utf-8?B?ZEdCYS96TTVGcEdReVQ1NTQ2c2RBanBSamticW5kQkdSY3owa1JDT0xUZi95?=
 =?utf-8?B?MnRobWlSUlZEZklsVlJRcVhpUmRpdmJWNTBwa3lxcGN1dmZzVCthT0x4VWZ0?=
 =?utf-8?B?K3dCTGFSaVdVcXI3WmptRWtiSTNpUDJkdEIyK1hqOENWdWxTeFpGZ2lDaGNY?=
 =?utf-8?B?MmJta3BTSUZBb3Bic3V4d0JVNFg4WGlKQkxPZlRkTVlpWFBmZ2c3QnV4bW5K?=
 =?utf-8?Q?jh2n7NTadGyY9zpSVFZwdkhViBaZvJnwx6rsRTG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ZYV211bFhJTFZiUGdMQTdyZ0dwdUZ1SHNYVE5PaXlOaE10ZE5NZ1BXQlpW?=
 =?utf-8?B?eEp6QWRvK09HZE9GWCt0UUwvY2FITDNVaW1KbEdwUWRXU1hGdlhEbFgzN2dy?=
 =?utf-8?B?R2kySStrWTFrZDRubW1lcFZVZExJUC9SS1I3VGVFQTFRUjVQeEFOMncwWmJu?=
 =?utf-8?B?SlN4VE5uYkw3eVUzcndHY1ptRHFOOVNNcmt6ckFtK3BsSXpncVovMU9JaVdw?=
 =?utf-8?B?R1VPdm9IS0RIUTQvU1g2Ynl1RUxYQUdwZzA0VmlaY2JWSmFlTFFVejBqYngv?=
 =?utf-8?B?R1BqUCthYjJqUVVWZGsyS3ZUbTVEcndsclkrQjZYOVNIeFhtYUZyYmpNdGd4?=
 =?utf-8?B?a2JYTUw0NmpXWU45aUU5dk9hY1RkNjdPOVUvOWRscW5LV1pFTytTZFZGSFUy?=
 =?utf-8?B?R1VtU1ZOekxXSUVSTW9lbENiQmcrZlNrN1cyM2FyYlNacU5qNlE1SFR5VndS?=
 =?utf-8?B?RjdaN1lWZlM2UER3TG9sUUh5cFlqY0k3WlBmNS8rbTRLSEJVUldwczVuVDZp?=
 =?utf-8?B?YVQxZTU1UWJZZU90RDEweVk0ZlkyQlRnTm8zZVZRbHZpVU91dk42aGF4ek4x?=
 =?utf-8?B?aUljVnEvSjhmVUE3blVqb2lkUzNqVUVTRjJDU0pReHR1WHV0NDkybWRwZ05Z?=
 =?utf-8?B?UHozZGMyUVREV3dOb01PbkEyNzlmS2RSSk9qSXo0dHRGRXRKNlZUR0RJU3ZY?=
 =?utf-8?B?NTB5UVVnd3laN1lkZEEvMTVUME9hcldZcW9VRm1iNm1Wb295NGZhM0VBTFVY?=
 =?utf-8?B?T0FJVENxeGRaWVZoQnkveVQ5ZDQ5MlRxQnFteTJUTXRma0ZJWGkrV1JTN2d2?=
 =?utf-8?B?RExrUFNlWXdqUTlzUnRjT05NUkpwaXBrb2l6SkdwTkRlVjgybTBzMmJZWm9i?=
 =?utf-8?B?d1I5cVpwOVd1cjVGL09rR0hlT1RIWDRGbzNkSnhRRnVna1E0ekdCelp2aSt3?=
 =?utf-8?B?bGJMRmo0Skp3OVI5ZlhjNHdsODlhcGVuazNiNjN6cUZBaWJDYXJSSVVIRHBp?=
 =?utf-8?B?Zm45MGJXNGtGdU9oU1E1NTRiMXFGckE1d1VKWDhVd3dPZUplSEdab1JkSWJo?=
 =?utf-8?B?Q2l6ZVVPNnZ6ejgwWnl2Kys0U0RFY0xwZHloQ2JYZjdhMWlnRmJQdHR4YTJ5?=
 =?utf-8?B?Z0Ntcm9FS0xjK1JOTVh3Szd0UDZrc2RvZTNkQnc2QXZ3RFQxV2VWSkZSQkFU?=
 =?utf-8?B?a2NYU0V5RFd1N2ZRajQ3Vm4reUZMcWZIVTlwejJybUVmRFQrVmVTdlVzalBl?=
 =?utf-8?B?WVV5dEZ5NXV4T1E0WThNZ1VKUXJqQlRLaTF3NXkxb3kxMVNyZUlMZmpTMUN4?=
 =?utf-8?B?YlNQZFJpMFd0Um16WFB4eG83N25IR21uandiQnI0MXhLVE9oMmM2VmUrTnFT?=
 =?utf-8?B?cnhYN2ZqQUR0VGVlM3NJYnpzNC9mQ3NMQ3NYNFJKays5cjFzWEpmNmtVZFpS?=
 =?utf-8?B?Wnk2eVdhUlJ4Q0wzSStyQ1JHT3BlbkM4MnJXOWtVNW9GN21OVldENU1PRWNC?=
 =?utf-8?B?cWpqbXB0Q05oT0xlVklJWnNvYkVDMFhJWTlzczRKSkJORWJZS2JTanpkL3px?=
 =?utf-8?B?NU5MSWNscWE3VFVhL0N4STk0d0xQSUxnbDg1UkFnaGVyb1d0MENMcm9iRXhR?=
 =?utf-8?B?aS9JYzh6cmo1T2J6ZEVtSU01Z2pkZDdWYzNIcXF3YzUrb2p4cFZrSDBZc0RS?=
 =?utf-8?B?eVBrdnNLYis0ZFZWTXQzYVMwQWtkSCtkemIzUUVqdEUxNi8ybFlHajdKczRn?=
 =?utf-8?B?RXV5M1U3REtEb2djdzJKYlRqczN3VExPZHQ2aURqazhFaFJ1SG4vZzhLbG9i?=
 =?utf-8?B?VGFiVWdoaFJmbVV1N0toY0ZBRUNxdnFpdGtRV3RweTROWmZnZXVpQ3dSSk1x?=
 =?utf-8?B?Y2kxMDJKaDZZOEJZK0dpM2NSa29oaiswRWVVRTVldFRCYXNSWTdLSStoaXpL?=
 =?utf-8?B?VUtpU3U5R05sOW9hQ0ZnS1ppYkpEWFdzd2wvblhCdmJsdmpMZ25abi9GMENa?=
 =?utf-8?B?aTZYeUhSMHRDN3lyYzZEcXpaNGZIdXFQekYrK2NWVC9XNjBOREJJUDR5UmM5?=
 =?utf-8?B?MjBsTjh3aFJMeWtDSDJvT3BjaGlHS3hPdDhpSFNUUjlhZkZscTFHMW1qRHRN?=
 =?utf-8?Q?4nWwdIyEZFvqPhmdKoCrF/KOS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea39006-6c3d-464a-a116-08dc947f45e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:55:53.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/LmO/tWvBdrT2Xg37idWpWv8TFs1MCiUu8OPhp2vFGYuyBT+zNhzvFsFnw6p1p1zUOrFnUgS4MYFtlP5T7djw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10138

Convert fsl-dspi binding to to yaml format.
Using common SPI property spi-cs-setup-delay-ns and spi-cs-hold-delay-ns.
Update driver and ls1043 dts file.

To: Vladimir Oltean <olteanv@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: olteanv@gmail.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- See each patch
- Link to v3: https://lore.kernel.org/r/20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com

Changes in v3:
- using Vladimir Oltean's https://lore.kernel.org/imx/20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com/T/#t
  for fsl periphal part to keep compatiblity.

- Add common property and depericated fsl private property.
- Link to v2: https://lore.kernel.org/r/20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com

---
Frank Li (3):
      spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
      spi: dt-bindings: fsl-dspi: Convert to yaml format
      arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns

 .../bindings/spi/fsl,dspi-peripheral-props.yaml    |  30 ++++++
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 103 +++++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 -------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 MAINTAINERS                                        |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  18 ++++
 drivers/spi/spi-fsl-dspi.c                         |  19 +++-
 7 files changed, 167 insertions(+), 71 deletions(-)
---
base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6
change-id: 20240613-ls_qspi-bdced20e235e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


