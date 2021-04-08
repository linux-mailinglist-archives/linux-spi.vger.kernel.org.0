Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888C357AFF
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 06:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDHED7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 00:03:59 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:29248
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhDHED6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 00:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw6mZXyuMSjCJ7RhFYqBiwS7cRPV9HL22Fs6OipOssAtcQKSt0qqz2KC+OCnzLlBJYzOb0T789CI2u8TkIQubprciTNnhje4d2aZCutPhZpaIMXasHbYckUoWT74Csc+WpbKXwXVUY+OwJBEtOpBVbn42196tq2Sd+Ig3Wb4r6LoY+NKSMogig5TY2fcAdFYJAmRg7kNUwrvn8xpPSAFK+rw6gVJOBV/wLuEVh5WY/dHLJXDoSSp6bNCcxanqia1p8zxE5nbcOJduLTbh2IAbxNnSmGvn2Y+gRtY5vPErsMq1LaW3LzDDspR4g9AO4JGdxnpGKNbMszzy0fNrXBQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKJB8EfHS8zqr1Yx+KwOdHNojrW/K/l2Aa2Q9eDZwm4=;
 b=jrkNdH/ZHVJV9HWMjkWzOfhSOwsCXQplkgMPtXOst4FAqgCU2lRvQ24IWqRsvn1hFQ/78OmmzvD51gOMRBFHem0cRviNdSlYea88OUGnEjKOYJfL/x8aSnrxLJUeTV5RzhMinSaqknWVkwUg62wryuMMtFTz9ad4IQTgx5NCcFNJdqL/reeCl3TwPtoDnEO/dJl3oQMLIZ+fQIwI3zsGGJ0BIzQRBMtgb5HNGmqimmV+RPQyFJGQov5IiX29eo//m2usikb5uZ+A9WcQSfDbiHcv6U7Ct99yrmgiQXsKX7ZDgLYFqf4VGqrD6ufVrOo+6juwyl+2pcL9ZYE8q32OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKJB8EfHS8zqr1Yx+KwOdHNojrW/K/l2Aa2Q9eDZwm4=;
 b=nOqGKVW38t75TfQQ9RjSJPg/CPi4H3hBl5xcBJcv7MwQW5JrYj8AwIM1obDR7r0gUV4bxXX5q+Bya/FBjE/0qEj+h9mYl4c9cysvSNHHBXJA+by6HOj55StK4+HZ3VU+K36ikVOrb2hXMZ0vPQ0r1aLRact6W+qi+cq0x5cqbQ0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1942.namprd11.prod.outlook.com (2603:10b6:903:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 04:03:45 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:03:45 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 0/4] spi: spi-zynqmp-gpspi: fix some issues 
Date:   Thu,  8 Apr 2021 12:02:19 +0800
Message-Id: <20210408040223.23134-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 04:03:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9698d2c-5271-4fed-2a72-08d8fa434dbf
X-MS-TrafficTypeDiagnostic: CY4PR11MB1942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1942FBACA902AF9D4953E1A0F0749@CY4PR11MB1942.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ8K36QaE1iKWYwEQJe/zLsNMAU7uJMXeMIxLds0i0N+kF0JJAkC0Er1j6N2hk6A/x9vmoQeAeVeAFCHANcXTb7Xsh3Se6weckeJ95LHtrTVsKipulgQpF3Aqg8LIo0nzpsne0DM6Cn6xqibtSYL+RgyuZ6SoGJXsamocBEthpMv5C/pB+jowVFOnXLpEv0vOwvQfc1kDRgNsBoKj2tCpipuZ8tLe5SqVLRHdKTtqdWHHijV/BAzCruagGEsRoqqxz7c0g1r1mnIRvMS1OcVmHhbcqVquhbT2t3o9yt0KAOP2olPNILkpOIuPZrXoZ3cUyovDfzoKNu9WM0l7Q6QXjBboqeVyybRj7vFWUzDqxYJv47wzcxe1AohCaLxc7ikDFN6M0yiyIET9rNsFcMfbpaq5zYuZ+lJ6PgpoWPTGmqMIAtvYrNVF3Ie1PiwHSqwpm1sPRDlfhPeJYBXSJKEw6u9TQcTvxLPHMo75qjwq3m+RIRSLpV9Txtn0OhHE7/EgPiBnqBSlBK3oxih0CRibpMugQ+UD1AGYSGyBhgEBfgZUpvVR71xQUOc0RjKXWbD4r2/8NypYc+XCb56mYZOUUmrodK9ogMt2+qqw+pePlQYPtS/Q9NAncyUIO1RMpccC8WylYjfC47rvWl2BQPcSJNS47kR3sv5wibsbP/7NtaVnokp4RRUhqtN95hXt+Wj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(8936002)(6666004)(83380400001)(52116002)(107886003)(4326008)(5660300002)(956004)(110136005)(2616005)(6506007)(316002)(26005)(8676002)(38350700001)(16526019)(1076003)(66946007)(4744005)(4743002)(86362001)(478600001)(186003)(38100700001)(6486002)(2906002)(36756003)(6512007)(9686003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nKDQ/qOyHz1RqJEqp2qd14Znij9Zsid5wDWtEnGnklqDx7JODsFXPybOT6Zj?=
 =?us-ascii?Q?DjAHa7XAAUV9lLk9zmvOL+Fmb1alksSPc0PRWyEsV2wXCGVm9Ip1c6U2yQiY?=
 =?us-ascii?Q?k7nt+5faQX0DbnclFkVD+QjVALTPAayrPl5weFB4yXYrrT+EViYyTfq+f1hN?=
 =?us-ascii?Q?QEmACx3TFXn6itSodkhQXHwa3xWvP6cJb1kOMFmiKm+qX5wJE0Dp2ZwAk4x2?=
 =?us-ascii?Q?RT0ovZ1Y+Rbgjmb+sOUnKiFRdBqTAiBerSZvbUhqBNGdfu7Y6q5jsiBYeugW?=
 =?us-ascii?Q?EsX+CJXvSWcGkkfKqsbvSFm7s5kPnqDkz7wOPJQhO3ok50ROiUb4MjBdRpxJ?=
 =?us-ascii?Q?SrjJCsv0I1cl2uvfKoEVWo9wWq0JJHSMfCa+SAtm+3/LxdTOhCPgt50Pi08u?=
 =?us-ascii?Q?cDqX6xfTOiIw60nuN+jFKlSvs4WfqM1hv5ptzIADWB4Bl3STJCN8n6lSRkh2?=
 =?us-ascii?Q?2Vfd6aXozQzJOdvxBw58pZWtPV/BlIWeJ6q9YoxjS7ZEHREesNQsVhUmcx0W?=
 =?us-ascii?Q?2Su0mQrdlnrhbjUxFh3bG4Tjmui0FHNbn4noKgaiCABIEEjNaSTQw42HE/JR?=
 =?us-ascii?Q?Iqcbkmgw3+jSLnsBRbd7S4byz15mzclSG83OzAoy2QCzaSVL2PqdU/Wmhv1T?=
 =?us-ascii?Q?fz6JbWYY3Mb5n/k73LPGmVpMrdHwRh3GY4YZHhPgS93CZLMEsRMGGNoVoNMI?=
 =?us-ascii?Q?0UBJYG8ynMBzbO59EGclBb+Bz98LB2d2mcH74oQmuy8qBk/rQFtPPKr48ESz?=
 =?us-ascii?Q?EjSd1Xg6kjtCeerWrNRnWPUwCHC9gc3bhpbx/3LeSAQ6Jc0TBH7ts/OXSUSE?=
 =?us-ascii?Q?kYwz2r/vQgcopbOi8pg4i8tvSNDARV626JYzmQJw7jlHr7RpIMEZtXvzO/WR?=
 =?us-ascii?Q?I6QkLSxXXf5olETGljfnf63PVNQZC92pdmO1XI3XkU5qtNYVIzEs+A3Hz0SD?=
 =?us-ascii?Q?LrF6XJhhWCqMjNVCQruCKLO5DQU82w0IUBdOk2sFCeVOp1zjTfzySa5051m5?=
 =?us-ascii?Q?bH2zaOWMW/53awnmZavPwbLwUNEkSR43MD5Wv1/TXYLBecc9ChMrqJgczXf7?=
 =?us-ascii?Q?xZzLoRXS9bJPEkkdEqCaRtfR02V86oWvukQBOCZXc8Ku8FHFs3jgukEhYBky?=
 =?us-ascii?Q?E+sYdyZWQiRCuaEE6ZVmigi6NAgbNSRESvJWiPb374C1p09L7KZ3qsby+6yw?=
 =?us-ascii?Q?vYDxSYtLS+g4slRGJ+/Ok/9ISvH0vU7HywvGHVk2ImzQGgkFLQs0XGKTzG1Y?=
 =?us-ascii?Q?ES6Bz5HhRKtQ58xuUWGhpAffzjAT4UXLTE1D9HCvebCVkVteWM+j97iQIH8q?=
 =?us-ascii?Q?uDl5V3Eh14ZgpOuce3fB6C8j?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9698d2c-5271-4fed-2a72-08d8fa434dbf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 04:03:45.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovpfrIZ283gclthrG7JHwp39zvAIBZ1TAX64plk6nTmyqLn9U3aSPQup+bJ1oficaaboOgdFUG3J65AeWuXbdDazEeBwQLnzc8zufD1HW1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1942
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Hello,

This series fix some issues that occurs when the gqspi driver switches to spi-mem framework.

Hi Amit,
I rewrite the "Subject" and "commit message" of these patches, so they
look different from the ones which you reviewed before. I still keep
your "Reviewed-by" and hope you will not mind.

Regards,
Quanyang Wang

Quanyang Wang (4):
  spi: spi-zynqmp-gqspi: use wait_for_completion_timeout to make
    zynqmp_qspi_exec_op not interruptible
  spi: spi-zynqmp-gqspi: add mutex locking for exec_op
  spi: spi-zynqmp-gqspi: transmit dummy circles by using the
    controller's internal functionality
  spi: spi-zynqmp-gqspi: fix incorrect operating mode in
    zynqmp_qspi_read_op

 drivers/spi/spi-zynqmp-gqspi.c | 53 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 26 deletions(-)

-- 
2.25.1

