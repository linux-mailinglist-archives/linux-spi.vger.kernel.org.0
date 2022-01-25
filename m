Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245E49ACCA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377174AbiAYGzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 01:55:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377471AbiAYGwq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 01:52:46 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P6WBkb019284;
        Tue, 25 Jan 2022 06:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ThflQSCApvmPaFLmqSS9hWP0pmIgPjLRvPUl62T1ilQ=;
 b=CEwQiFtYcguk57pyxvTGRMgkaMbCN7DyFAP65UWbWFb8K18IKVtm+VyKmmU2oFgLzHFY
 ddLnrHhs2lrgcGmFrGyTELf+v2SO6beP59ynhXoBUrp6bW59Si9AaTrvqJBt0/QScccR
 X6MZZ+XKWu7Nnq09MTKzU+acT0a81MYOai8PkfnEMoSNhXO9U+BGkgaF8b7RJJdXqUjt
 sGIokFlgExHlIUa22aI5iKhwVgGl4U3hwyoXtsUnpDLwn3jea/xhQM+pZMu3EPQtDpD3
 qPNiEOZMil2n+3l5SKBQvh4OmwNFajsziGMawGPOdeNKCCINxVvFPOAGYzyyYRb2+6Cc dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7at5v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 06:52:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P6ou38034407;
        Tue, 25 Jan 2022 06:52:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3dr71x5et4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 06:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOTRHODg2Pt9tvorp/yjYWwjLw1ZkACuUtCQiwyxsW5k+Cr4HfKDt5LtzkBf40gH6Lzgn6qJ8EwRKMWMvM1AmFKdah3HYnCyRgVhLChNGS4opzws390QOl9Iq0JfXfY6r0Z17AkCli/LNg5DR4qdvnxSZCozLOiFUm5Xp3yUhM01Tci0NnSYI9kiHiwvazSRU7NQAdhW+ANVbccrwBh5HYeuQ+oTNBK4I5LoHmk1mw7attrQa3jQ4srM0WPab7rB8kFCCP/kGGfUFRL3czwDQUW10stMYqkPyKxoBQDoNxJDg/QqaKbKSBt9PlK0pGiYahcoUfQBeKeb7dlBGDAIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThflQSCApvmPaFLmqSS9hWP0pmIgPjLRvPUl62T1ilQ=;
 b=HEkMJu1hgbt/ts+OZuyFRNBtTWT6fHPRQrie5AH+PpzeBoQ3/fiJEgM9SA5JzyKcyGO5tad96hJJvJ4mV63dxHKie2T6umdf/b51X4S5RJkOIGW+u+7CNlne6x8CVlz4fvJBEinW36Vsi3+DdWfhhy2OC983nWfhucl6gR4OXkjWRfZWahhCuGT+2r0u2sSQJ+cONoEAKbgGehgVf2l4aysNRPDFpIXBB/c4/sYPs8JodM3ATj64hOuBmEPwaaJuS2NsAb35mzQOn+e7c/LYXUb9faNJ9TrVH2MZXk2WcJV7FwoVeUMz4hlVn6PNk0N1wRoS+5PD86PwrMMg+fKG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThflQSCApvmPaFLmqSS9hWP0pmIgPjLRvPUl62T1ilQ=;
 b=woo8BQ/R4qpadzFt9HC+GgqMbxRaxl6ROIlqGN1JHvFf3HVT7gKyafMStkSrRGIumFH6RTDhxRAcaTsL8TXRs18oIqPFwZmUoDyGk7tZTwce9KNI4+HToEF/ONMc+87Rhsmup6U42QUR8xMDVPR2QHDxfq3lceIt1ba4zrrA6jM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4756.namprd10.prod.outlook.com
 (2603:10b6:303:9b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 06:52:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 06:52:26 +0000
Date:   Tue, 25 Jan 2022 09:52:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: spidev: prevent spidev->speed_hz from being zero
Message-ID: <20220125065202.GA8807@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cdb0ef-33d4-428e-1be5-08d9dfcf3e38
X-MS-TrafficTypeDiagnostic: CO1PR10MB4756:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB475610C6658EA24A840E156B8E5F9@CO1PR10MB4756.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoorRhwGdparNNohuNIbQRDomFASiOdPgPr/592fivfPQbWlit0Q/jBcklsfRpgcLjBkPlB3e0Mt+OWs4UPeZpOMjUFfFVAqO9u5Xb9qorhTExFeL+G1GTVhMoHmwOVleQATGRtsxcyDsNYlNpeXlU4NLJIPRv2S+KtznfxLcEw2JLqvcsAUpilhF8TLlVVomMNjQnE11v1RrzGzIdwovGufp3ttnjiZk+RBC1f+OQ57W3igdlG1PGrvfTFZ3PDRQ6hOmUml2RF624kK37SB8V7+f9MWBGVClBBF7VMyfPVmYT9Oe0TOWCN/ozHI7pkqGHyBgAILzVimM+kGZT3Bfm/U50oIA+a3YlQAqA/8uof37+akU/HrfIDTDC9hQmtjnVwiO5ZbBhB12beGlf+z6zpp1eY7ljUtaaEascCSA6WzxShM55w6K/UzuUWmfwTuv7KJll31bKz6B89PFOua1maXE37SS9C1TuNWkuknA6Vp9d91wusQfkUsvKsxq/miszJ8XOtvIw1b5rL02EcBVyhUJYzh9NfHlVOG53wsu9Q+GDUZmElKRpHn+1KIRPOlR8RPwlDX2U1R/67FrqrIWkFQGHHoWVvlG1mDDHhEz2D8EUEhGvCgixMtPL/Rue4eyNvj5agCwv2EQMT5mJ/RB9s5cWHcLaoTj68AW4ytzH065GERfgYVCCZ+Jmsiv0lKaFTuEPTrluO33UmPn84KGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(38100700002)(38350700002)(26005)(86362001)(316002)(8676002)(44832011)(1076003)(8936002)(66476007)(66946007)(4326008)(66556008)(33716001)(6512007)(9686003)(52116002)(33656002)(5660300002)(508600001)(186003)(6916009)(2906002)(6506007)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYlGRlJ4zhRuYFi2JUDQC1NPVBkYS2HcATIYRxIIthIuuGu7M908UmahnSsk?=
 =?us-ascii?Q?ez7Ab/giZr4IRsiMCPXyO+NrUdSK86WU1gyl+9Dl9yTjipQVpD3FHporvbDx?=
 =?us-ascii?Q?2qc5YMZmGkjimtH+OgrdXMJSFAoeUyOU8FF9qxDnAJ0qIw/qKoq+y1Sw6v2g?=
 =?us-ascii?Q?yfLwkCsDQwQ/G6l16dW9ts+Wn2C++CLWmKGDHEjaTM3sk/6lT5QT8/3NhEq5?=
 =?us-ascii?Q?R1GGaoU0XeewmAnb7bEc77vBtpwqrwTEk/S0V+gcFVDwy01rlS+/xdor2cXW?=
 =?us-ascii?Q?SWPLdaUoF+HDb1LWA50br3TXQTK3PjSEGfaQuToSVk8PnvHKHk155UP+vVzq?=
 =?us-ascii?Q?Zjh2FT2b+BDRdcEMQV/pQ7cil4Xv2CjzmpeG/Rf7cHYpkugTgl3uzUyMyxEx?=
 =?us-ascii?Q?OlW0Bd97me6c9Q+eWbxL9H6MMu+qM1qOuTXxHnbdXFSqlO0Ga5sC4q+XmEmY?=
 =?us-ascii?Q?fvmkfCAyvpFpi45PHAMC5ZZDlMwZON8Dz8mfBwzTwUNaqwklWLbVJAJU7yQW?=
 =?us-ascii?Q?iRZlmsoVwATcBaM52XjF8sbRkAtpFhAKnyvYXtFLPYNvxWTBF4VxNmz7BIdi?=
 =?us-ascii?Q?oxZHv2M3THwVqYLqZuFAOXCu7n1pYaYxZhjIj2VdI4qkO36p0FmAYh0cD0lM?=
 =?us-ascii?Q?d6iUFO/GIJjvjy4d3DGwSoVEOe4EmN5tljdgtO2d+zIp11JjggwoHsrMe+Aj?=
 =?us-ascii?Q?8TJm1S8mkab/rO2BXbbQrPEbt3gjJMwXo9PF/9z7wregj5+Nicgb4MgVv925?=
 =?us-ascii?Q?pUBV/b8OAiyGV+7881eN4QoT+mVhRdK9SeLBeFVJAtnjw8RV7YFCNhM6sLKX?=
 =?us-ascii?Q?3ckooulv4bqfyOr09l1UdJWbG5MLk6sjJ7Z40agNiWrKqJBufzVhsRvtv3KH?=
 =?us-ascii?Q?0o0HX+MwgyrY1y1yMd+icQR1PsAfhW8nQcXhBtO/J0oh0RrWPFXleAV9/43d?=
 =?us-ascii?Q?d8bw6WxFRjaQSIAzl4VywacHlEFRlFyu4RayO/a69d9QnJFD0G+u6QoNNF/T?=
 =?us-ascii?Q?JIoRv7rpV9PbjnhAvm2p0ophcvpe1Vl8fowY1GzOK6/Ucvgw3lHsxlOR8JKc?=
 =?us-ascii?Q?+zpUxzPkQ8Jp4HKIGXP247kJf9RRMddvv+vpzABu+QM4ZtnFpfmK0nc6Xb5r?=
 =?us-ascii?Q?XRNmgjamynKQrdzE0V4ftb2sQogkx3AIxT55yyDE3xpww3pXegcw1PFGsMox?=
 =?us-ascii?Q?ymXH4QBBOOuYF0Kn00wCAJqovlWa3S6mq7XaPqP8CSfypIdP8ZE9zyKD7YOY?=
 =?us-ascii?Q?j8LW/QnJb4h5oJoRp5XioiMdb2gaOQHJVAohHgo+zTLwK9Ztmi0hSghuB61J?=
 =?us-ascii?Q?PLORh02d3VkM4li9ncNIAOeH+wN3hVvhZrSaCBgqCrTnRfFJa+8ccaC16Gwe?=
 =?us-ascii?Q?3ZJ3NZ1Cajk1ccio976Ie2cWUJQ9EPtWuJEetVbXgRurZ3nRlGYHI8LTaHub?=
 =?us-ascii?Q?6oyB1MudALT4s042SyopgJ39Ym8eGVhW/dAcZ9ELap0mYzQ+rNfHyv+BYBUW?=
 =?us-ascii?Q?mgwa7IR/f3pR5J7uhy+FXTR6cxQFK0dfDL5weBiURP/ZbeUVfevUKyDYIbSt?=
 =?us-ascii?Q?38SOzvQmIroLMZpo2smyrf7X0pKDzN7eYMptObzAODWiTtOjOED0WQt8LVTk?=
 =?us-ascii?Q?MYoYXCY6zx3gt5TSn0brGOOmMlJsXhRXEKUqfLuFtQ3dl1mVbIP48Adw/ikN?=
 =?us-ascii?Q?Iu96oKH+1aFjNOuNfsOKT/oH71A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cdb0ef-33d4-428e-1be5-08d9dfcf3e38
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 06:52:26.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozK/gDeaO+MYVupep9fWnJbF8JcFk4yXxTfHB/Y4yqf8EKEkpJ+B3qkFWqWSdh61ScPDpoZsS+tKRVPnZ/lXnjkiw16Fi7BQHzgMskxPgO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250045
X-Proofpoint-GUID: 7zSnTJ1-nnli4y3D486Dxga67QSO8lI-
X-Proofpoint-ORIG-GUID: 7zSnTJ1-nnli4y3D486Dxga67QSO8lI-
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A zero value for spi->max_speed_hz or spidev->speed_hz does not make
sense and trying to set that can lead to divide by zero crashes in
a some of the drivers.

drivers/spi/spi-s3c64xx.c:874 s3c64xx_spi_setup() error: potential divide by zero bug '/ spi->max_speed_hz'.
drivers/spi/spi-fsl-dspi.c:613 hz_to_spi_baud() error: potential divide by zero bug '/ speed_hz'.
drivers/spi/spi-xlp.c:146 xlp_spi_setup() error: potential divide by zero bug '/ (spi->max_speed_hz)'.
drivers/spi/spi-orion.c:162 orion_spi_baudrate_set() error: potential divide by zero bug '/ speed'.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's hard to know which Fixes tag to use...

 drivers/spi/spidev.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index a5cceca8b82b..dd824db63fbe 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -453,22 +453,29 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				dev_dbg(&spi->dev, "%d bits per word\n", tmp);
 		}
 		break;
-	case SPI_IOC_WR_MAX_SPEED_HZ:
+	case SPI_IOC_WR_MAX_SPEED_HZ: {
+		u32 save;
+
 		retval = get_user(tmp, (__u32 __user *)arg);
-		if (retval == 0) {
-			u32	save = spi->max_speed_hz;
+		if (retval)
+			break;
+		if (tmp == 0) {
+			retval = -EINVAL;
+			break;
+		}
 
-			spi->max_speed_hz = tmp;
-			retval = spi_setup(spi);
-			if (retval == 0) {
-				spidev->speed_hz = tmp;
-				dev_dbg(&spi->dev, "%d Hz (max)\n",
-					spidev->speed_hz);
-			}
-			spi->max_speed_hz = save;
+		save = spi->max_speed_hz;
+
+		spi->max_speed_hz = tmp;
+		retval = spi_setup(spi);
+		if (retval == 0) {
+			spidev->speed_hz = tmp;
+			dev_dbg(&spi->dev, "%d Hz (max)\n", spidev->speed_hz);
 		}
-		break;
 
+		spi->max_speed_hz = save;
+		break;
+	}
 	default:
 		/* segmented and/or full-duplex I/O request */
 		/* Check message and copy into scratch area */
-- 
2.20.1

