Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215553F7F93
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhHZBAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 21:00:53 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49378 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234396AbhHZBAx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 21:00:53 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17Q0Srsu017128;
        Thu, 26 Aug 2021 00:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=bFMi6/1RnUwrKZ1RaAKFYB8NEbjz27JwQHDRZjrjubg=;
 b=lJsAbrs1wBUcukHotgkeHwle1DP4ujQlWEozT0R941B0TVeV6kSWpF2atp64RnlhxK3U
 nHhWuPyG/jTszmB35yl5/utyYg3MBkBQniHX8c2gKLiNc0ftGVKo7FPaknZqEGSnP3Gt
 8o8mTfMeEg0759V4U5p1M5ZjNB0UZ2JTMxYc59hErsqT6W1Ovg3gfYbW17O2GCeadD+u
 HcjeQSUqV6PejMKrmU2jryEZyGaOBmzojptec4OO9H4cmmiXKfcCBuW97XrzwVF59T34
 oXnZbCaPGDYneJWxwPRq2yoXAwgauxmq1aFICR0X9rr3pxvDm1+ZXhWCk1F2kCsgzWHT fw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-0064b401.pphosted.com with ESMTP id 3an7e4h12w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 00:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFr+SX679s+3M2MCBwLHwP+Se6ORAENJBoPLjiggTBimmD3yrVtqVPrOKi6fuiVn8PjTs/GiZUnaervJDPG+BoF8ZQJjpPvlOvSHIB4IgtLw+ZHvYHnAVtEUBSCDG7Nqc2qECUoppM+MFjhgnjERb17qhgrMAEFtdqGmcF9pBph6Tz3MgUD9rBHVV/8AU/cE/gFYGtc15QypYVtBvQJ7ces8bFQJpXKJv4ZwM82saaDLvbKfBKZRRvcagiVm21p8lcrAlbNCgjT4riNjn6xzpJqZkVOSdjXmbL+6gm270IvmlcLDG+yobrfmBnMRSroJN02krttX03nJQu66cCZD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFMi6/1RnUwrKZ1RaAKFYB8NEbjz27JwQHDRZjrjubg=;
 b=FgbQlQfsIMXkVw+pR4cgyj8Lr0fiHe+PHZT+cH9EIJXlNjHRDyCHfSPIqNBZlEOpURxtia9SPmz4QRvWMvLJ1OqxctyQxWJhLpP9/w5CZ0R1EBiI7z/Ggsc2S4W9DeyC1NgkGEmCBGoJMu5yzqcF5O9W568YG/Dwk7UeoBXPEBFnxVbQHk/BGg+vUW3/fGsyqugYF+B9Q5HM7CTCFFKQmDmiamvkt2OtnxI4gVNvtYWkPXqxqL6Aheio4c22LwI4XTiIb5/ADQ1wLXC8bKLtg2f7JpzeFqvT1YCBADfjaTRAQCk0q1nFA6ZKXjnXfY3asZ3p6po+QeTk+WXwa48Uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1607.namprd11.prod.outlook.com (2603:10b6:910:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 00:59:54 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 00:59:54 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [RESEND][PATCH] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible
Date:   Thu, 26 Aug 2021 08:59:30 +0800
Message-Id: <20210826005930.20572-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR03CA0066.apcprd03.prod.outlook.com (2603:1096:202:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 26 Aug 2021 00:59:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 643f1751-1ec6-493c-d32b-08d9682cd0b4
X-MS-TrafficTypeDiagnostic: CY4PR11MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1607180EFD16FBC8479AFA55F0C79@CY4PR11MB1607.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0xfMMbKJhC6Dy/eR1G36SSnRxrDxs58Sz6o79vWcLLrR0VBfirSUVxU8A9kfsHfF+zcDnx1ydjepiIDO1QfWi64n8FC2bkL5jBbTELOFztSQ++HYoSXkVMr9Hu5cjsfmAfSUfIKEuewNvKebDfletapKfRcC601sne6l17/I67SmHZ6ZnuIZ8zAiPcGaYgze87OrYRLLydEJ0tJeQI8RTCWpdiFNQLP2D2sstxfJrV+N4mWS26645OkJTy48HgtSu5b/gPvvGjF61gKl0rn2TYjXGIRM4OB8xZwrE0orFm3VOQEk1h789qANuLVfrBPtbxuV4LF1L9t+3l/kYg3ZTUPVi8EQ9SGdj4aMVukjCGBLcTaof6zi5JqBl3/gCQKM60phO6RcWLwB5QVJTZ1GFd/QKKKnuoBgUZmjXQUteZ4zFKB4VJ1e88UsenH6za3UkFIpv4LJ3hCESSEa0AruEVKShY6hbwGwqHxFGnCHg5+RyMzxYR2/G7o8l0pICehHAW2va4GOlzkLvVUI/wMh7ZcsOBWqw53grcdEZbAGI1AJkK4IcJ3ip0AwFOfvwJ3styioMgMZm6SICtc8v4LFBxnqzkM7WqCSM+uohD1PfNgi+4VammiGVYykLqQ9ulu6zU/5Gon9H0tH7sBSTwWZC+q0aUkbawpEtmwvW9u69QMAnWLdvFgZAKZZeBsZEo7cn60A4bVctpUZ/gxuPAJ/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(38100700002)(26005)(6506007)(38350700002)(66476007)(52116002)(66946007)(5660300002)(186003)(8676002)(107886003)(66556008)(1076003)(316002)(6666004)(86362001)(2616005)(4326008)(478600001)(36756003)(6512007)(6486002)(8936002)(83380400001)(9686003)(2906002)(956004)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgJeJKJrGVtI4Udb3N7g1t+f6yDgTJUVrU73aX419RAuOP3CSJ0X+7hgRb2V?=
 =?us-ascii?Q?yPloIQ5Ddp1dhtNjSHS73MP1PGdfl18E02wSh6ptFl/q7fXOJjasPfgdGbOO?=
 =?us-ascii?Q?le1MolGDFymGawMkUIyS0GS6dUBNV7hkQeLj5v/J7lmtv1Tk7/BBfWwCE+Lj?=
 =?us-ascii?Q?3dZYxAWc5O/EP2PBpQ0bx++QJ+RTW8mATQEhJZHQoJk8vr2Z6XChRTlOC09q?=
 =?us-ascii?Q?4aLqKGrIpxZPU5ZeZfdYRFmHJCPDaxZMyYzYJuVMiWktLbn3y7bp4PAA+/RH?=
 =?us-ascii?Q?krHwsocbCCsXIA1EiwE2eO7TuJpLGfIQYgrko5sLcaxjODVvtcXqEGR9ie05?=
 =?us-ascii?Q?or5llTytLgT7wNx+wY9XDMy5neGGg2jMa1079pt/dYu3xcsknfZqj5aHAlTD?=
 =?us-ascii?Q?h+GahlKeISA154wv6MCKoVh/Kud8L4/UL8WnXh98zlSIlYEWaDUe2FwcojAk?=
 =?us-ascii?Q?Imw9r4S/3NTxaWY/6+qxmf/tGssyCsnPnjVNCLLdEEiyD1vpn2xkTmooziTp?=
 =?us-ascii?Q?klCiFVkLdStSlaHS8QElRKpV9Tf/m9b0GvsPXJCh8LC8RM+pCysXhqC6U4o8?=
 =?us-ascii?Q?YC2rKAwhmOGwZQhgCmI9Dq3/DqrnWAitbNU8+2tAygz5UXIEe5rOwMcuip0a?=
 =?us-ascii?Q?SfJP3L9Fwhu2u01EiPyeX+jmoR4HXPKBCoF/d0f+NDQfMpG0Kt265p5IWbrN?=
 =?us-ascii?Q?lepKEsM/4GMllyHe/PJTONxlDhRCq2nDuJY7o7NAaSwiQl/OKN0TZga/QWo4?=
 =?us-ascii?Q?5ERK6IJ1/Dkj91DJjCB0uX/ZPkAX/nLRYDGeHTGI/S7mjCIXWYlBljiIIi9S?=
 =?us-ascii?Q?N9oSNwEMhjQUxcvueuVmWG8yXsjHqGwgCCXyY+zJYQveIrSCLLhdfIMUYHkl?=
 =?us-ascii?Q?hFD4uJMb8GeJgqOi0E4dAWlmoiT8amqKhLJWagflwb5FJVIlUzHBYc0HtWtJ?=
 =?us-ascii?Q?oH0fm4ehE5Fzx6Kd49tnuwd3JSp2D9mwlsV4vDYyAE5lxd76uUhiwUpSEZq7?=
 =?us-ascii?Q?bHAj1cFyUxlcHpzxSp5EoeObn1ZaEZmV5FefRMBgWZCnX6KYL/LBPzLeLl8k?=
 =?us-ascii?Q?k+jzylc8mFfP5s5ku5/s+5hn2mmt1nDf/WslIi88cwacQu+aGt4O9BB9s3yL?=
 =?us-ascii?Q?u4HoAnXA34J4a4znWAvnUuf3Xz/3dtPKisqZNPy3yNv2s6U4ViIKMXvF7fF5?=
 =?us-ascii?Q?09j9clm54oFaIkaLnt8PMZ+VDv3uV/WY1BQ7w54Y0xkFgdt2IxFd4/0LlHiu?=
 =?us-ascii?Q?1zAxFLgZRfpl+2/WW3GJYx7/qTzfFPqITg40LjFEXgSxjSEqUA9YTy1iPM2Q?=
 =?us-ascii?Q?CvpJp0n9bfOtX2Di/Ezc/BCB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643f1751-1ec6-493c-d32b-08d9682cd0b4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 00:59:54.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9In3yjqvS3TqTpC0rrO8KBdG/IcaFA5h6NERvNrak/D1/guH04uMZ0NmBIfqkPQCJC8XMfXf119zuYwi8HIhS+CvldeSKj0tn5xyVBv3gDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1607
X-Proofpoint-GUID: GF720EHcLMa49GliHIZuZXl2kFp6hGjO
X-Proofpoint-ORIG-GUID: GF720EHcLMa49GliHIZuZXl2kFp6hGjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-25_09,2021-08-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260004
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function wait_for_completion_interruptible_timeout will return
-ERESTARTSYS immediately when receiving SIGKILL signal which is sent
by "jffs2_gcd_mtd" during umounting jffs2. This will break the SPI memory
operation because the data transmitting may begin before the command or
address transmitting completes. Use wait_for_completion_timeout to prevent
the process from being interruptible.

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 9262c6418463..cfa222c9bd5e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -545,7 +545,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
@@ -563,7 +563,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
@@ -579,7 +579,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 
@@ -603,7 +603,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
-- 
2.25.1

