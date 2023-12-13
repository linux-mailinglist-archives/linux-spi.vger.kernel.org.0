Return-Path: <linux-spi+bounces-255-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D527D810D02
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616A81F20FF6
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9F1EB51;
	Wed, 13 Dec 2023 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FkmB3nzW"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B966AB
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 01:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY/y3uPUSBnBhnlztBrbaxut4AeGrO3WoEbTh78OJhWQV5FTr2g3gWtznEV0q/bMjtKqIxlCaVnYVQwoy/L/O7KUeU70r9Fhn3wWKDsxZqlDT0L2rnoTBhLpYIiHRMoeE3l9JUKo9dTyLCl+XLpbNN6vj9s6GRTReDQLXsKHa2Ukurmkufv9YhZKbZvSxQibDvSCFfAB4mlpJJXq6HunurEJX6XyzxtFTLnXRGetK1hivg9ghVa/fAlq0soun4YCWrGjChMAy+cNbO5xPUI5NsZR5dHIhkLll5NUgqbTD8cgXNbb2lZU5mkYm3SCehJ71mYAojOQErJAdgD21oMEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KpzkMiciGbnaSAyvVpum8Oh+dRFTGCaVP+G3gERGiE=;
 b=iqhYku7QDjb+6qXa6cw3ZMFJT8MXP6MhsCJeLnVrVktVhNteJhvNbP5UayteS4euzVLdixTKj6QgXRGhjcNDc8hwEwNsmYv1eNUqKQLY9GNR9cdFZ93j6sTlg9vlRAgcqPEVVVrNHyMECeIuCa3FlmOig6pyPbBIMMr+oLZ2LHp0byb+0Ea5zIk9qpGJrPBsUWmAc+J0VLW5xB539ZNB0NnLbIRLHF8WXQUK9+JetityVrjy7/JHWsEbV0bNSHKm3rzTASSgG9CDw8Y+0aMU0OONUzqvfnm3DFJAmCq5mn4w4GdvlUW1zcdbROI4XO1U42gUpV1jW4rWYGgd8c2lQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KpzkMiciGbnaSAyvVpum8Oh+dRFTGCaVP+G3gERGiE=;
 b=FkmB3nzWlS8dX+of6GAwkDghGv/mExFbbiEjl/duznUabHF3riHQXUCX/4gT5/8kepPzZN+iTS4NIehxOSK5QbI7ESmj9fiQ+ZAml4uUWZQJHo6++gKdZXm+TTJTNWdrTJDkLROnyv2XBT74jHI/JQI5ad+bsyaEDaNVAt4B4lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:08:39 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:08:39 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	yogeshgaur.83@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Date: Wed, 13 Dec 2023 17:13:43 +0800
Message-Id: <20231213091346.956789-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213091346.956789-1-haibo.chen@nxp.com>
References: <20231213091346.956789-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 475da567-a2b8-4879-2634-08dbfbbb1897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pXPR9NASk6WfRLJFv8WExf5npN5SEn61I8XJoqgopPLjqAScwh5w/xZMtYBMFBiQE0SANU0WjekCpJkKNl/C0pIb1y5F1RSWxl23CjUs9wuNYHuq7c9P2PeS+sxFoeAS/BKZBz3MRbbnQd8zQ3JPYsyxQOIfOv0tX0MlTH51RCg9I43zgGExjoaQSjhjPH1zDM5XVm1nI84Xlh7EX6V4NFR4lGLtmPi/q6VF0INWyiHyqh1/QZxomy0FxPzV1OqHtrfSO4l4/dLHhtNFSNJeGkuSEmsCDEHXdR2ZF8eZ/fDCc7gFNxfGpkwqRHiusnwFNbwMyACIOjh/7yvTKvh1geoW+MQVYGIwWLOgcIq64hmSXUI6OKyYZcZfGpwd+BmBsim/yip3k1/w4nRqRPYfugf4CM7AW08wPWnpB7wlvag1qLAwNYfrL/qRgSEdZmYpSgJoZr8JhsagHKm0XTNDBUP4YCoXDQUYLBVHWqOYoy9z7sRlFFzJHnzck7TwMFcxFoE5EDOYiDHHQjLkPVIHoxTayxAs6rYweOIdxuE8FR2Lby4JrrfM+RgV65+nS0Qf4WfmvHigbVHnaaVPthBrkGUVxUJ2s6BtjB5jRj4JDRdVI584LQbUqXIKUifGwwVm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(2616005)(38350700005)(86362001)(38100700002)(36756003)(83380400001)(5660300002)(9686003)(6512007)(52116002)(6506007)(6666004)(8936002)(66946007)(8676002)(66556008)(6486002)(316002)(66476007)(41300700001)(4744005)(2906002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuY+8/isKAFkqG8w42YlPVn1o4EZnaP2xh/ofEEvHp0Qk5Ot2ERXVqLiPuy/?=
 =?us-ascii?Q?9intdGhi+jqEMyspecrxSNQO7EM6wFnKwgyR43DYTx/20n458EQSw1R9cZRF?=
 =?us-ascii?Q?ppFy3mnTxBFsEham35MAc+Ag39cWFAau2r12MjZ6+QIVth6kgYB3cIFlpKnz?=
 =?us-ascii?Q?L8CrxF1qNadtPTZb2hr0E839umL+jL1C8DdhBHpwjn6Zc9QJnGcVIBCnjS++?=
 =?us-ascii?Q?MDbUyyM/F67BfbmlHEDZIOQfDdPij7UP7EdOEYC3W1LY4lA/DBBcSthAX1N4?=
 =?us-ascii?Q?FiflyaBqJ2byLAQZt6Db2G/aRTtfrJ46rFokWJz3Bup3qy4mfJkh4q+ouw1v?=
 =?us-ascii?Q?qTRoWDelSFME/f3WtupqnYecAdscy9PKvpnZ1Ao5k6MLQvUqHKv43erz5oak?=
 =?us-ascii?Q?8KnILeININLYT/Kfwzcev9smV/53LIloiC9s8ACUtgcZPUWcaZsNMoUSnOMM?=
 =?us-ascii?Q?VmSqu6ICqzkGLgko9zGZVim1bYVTZUEd5Nl7K28dBAQpef9IALMW+eqbiyQT?=
 =?us-ascii?Q?Q/LQ07W9JYjoAZXbnggCo0InmBo9BpZVZ0p12PLKyuiOftXX3X2Ucp39ej3Z?=
 =?us-ascii?Q?dlY9T75nU5Cv0SnQPzUvS4UuX1Hf0yGCMP0yTz0eBk7X1SHuQgUlxdJPMw/O?=
 =?us-ascii?Q?IaoRoRc4nMjPJZ0asequHiLife/Pc7/sO4lChga6cC7xAjlJ42zT14sURiJ6?=
 =?us-ascii?Q?H/tpdvvC1E+xYLkh3WKjclMvLNm0BUdlQruRa4V8Cm8x1FdhNBz37pGQCivk?=
 =?us-ascii?Q?RYsQplqWDaKrb5ufeQvH0SE/2jgGSPC989R8v/hhI1VfYYLjz3AOu8wZ0uHa?=
 =?us-ascii?Q?0NoO9evSuAH1Qd87UNuhZxg3/ypWUjj0Kh9m94t1tnrtGwfsEc1/o2PXRxF3?=
 =?us-ascii?Q?3YfQ7HexQBu/1wV7c8QJWepw0p5aEZ+a0dqA5F+vFVOy0Ax2BgJ65cVbPQMl?=
 =?us-ascii?Q?Aw0fcCZ/wl9CtUwH1DtMLyPpvRr4VxdrCu2UpDZgKrhdd6vs0ct2ENZ5L+vD?=
 =?us-ascii?Q?fCCHRtxkyY+cC+Cq8yrQs2/79x7cAyOpusuOqTtkdx8gxUmtRk7Ol5SO1SCS?=
 =?us-ascii?Q?FBZqHPZcGPuzQoLSshF4Ynj8HttmUoTttkLNL95047qKqpKioWEVOOptZCAr?=
 =?us-ascii?Q?ZeXE/9TAeL2EoKmeLqkeJFSBOSOI+EtcAauHmGLTuuFEZNbvY8bRnl21f2GR?=
 =?us-ascii?Q?T/vfmNahouj8Ygv3AGoOUoDz1O53HsRsuvdGua28QBe4esS3qayl+4Ns/NAt?=
 =?us-ascii?Q?W2TK6dCJ7b4d+ScieAlJNKwa3JnEjCR2uKpY7AuD+7zhhapSs27nRFnXFUwm?=
 =?us-ascii?Q?gjTK4fc3bfmeu+NNHtmPdNWFTfIDPCFk8HKaaaYT4vs46cDnCVu2I3oyTdYY?=
 =?us-ascii?Q?ocfpN9qXzqnrzRBWyz2/SmT8uMxrJwnaW3zoLdKw88nDQAMXQzBJupGFbtcm?=
 =?us-ascii?Q?lxaVIBbQeMcUIp8dFH08SWSeY5hFUxsAfHPCNvUoGVKt6HMlQelaZHaPAGb0?=
 =?us-ascii?Q?FFl3ry0G6vLq50fvptukamhPGzAqhIOT33xBssP00T+HamglWsl3DH7vnONh?=
 =?us-ascii?Q?PCdx1dzG906Mw8H6pk7Lml3N7lpcPKT5Ye4qNBnQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475da567-a2b8-4879-2634-08dbfbbb1897
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:08:39.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVSLNFDzm3rIgyyHYwMyE/bRqJ0i8BoFckKX8cSYCS0eyo3Mq+oDnq9aIdUP5BMMx7/36/43RmhtaTWuEf6g6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

From: Haibo Chen <haibo.chen@nxp.com>

The fspi dynamic lut use the last lut for all IPS operations, the
imx8ulp only supports 15 luts, so change the last lut index from
31 to 15.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0feecf5ba010..9d6b4d22263c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -64,9 +64,9 @@
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
+ * read operation, so let's use the last entry (15).
  */
-#define	SEQID_LUT			31
+#define	SEQID_LUT			15
 
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
-- 
2.34.1


