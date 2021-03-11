Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE12336E91
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCKJMr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 04:12:47 -0500
Received: from mail-mw2nam08on2073.outbound.protection.outlook.com ([40.107.101.73]:62305
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231629AbhCKJMk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 04:12:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU98DeqvAkhtArar1x+s0XjYrKkUdrRamH0bRq+JeBdBD7zYQXcol3FolXHkVDZLTHMq85XiCkeZ2NbI3nST/58Mzi4LtMH0twOABI0cSPOyT0ibJB6m+hyzAaAEExRGcawbv3vArKVBSSSfWP9d0fYuyliFFXspbh5IzfszbQT1YlLEA0K1zk1uF/xihbIn1LW2auj8u5nG/FcDtGLXiVUx/6+U1JCGQKFx6lNTiQyPE6le8Qm8OyjKPLq0lL2nNdnNWgrGjb5MN7Rghh0shllC8V7Idi4IHJN1CVyvooeMLWW/Gryr5PvGDL8sF6AM6NXivLfUIazCdsDOIzD1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjBk/Yuz9KEtlPONsE751Cye6/EZ8PgTW8Teaqp4Bn8=;
 b=IYId6j3L2bVSYOopR40RFHlRdMxK+6PzL/exUfdVolbkNQN4gni9P7FGGbouOg51vvnHjx4ECMpJoPo8XUeDTh8pBTlLrii/jNLJfBeRNfvwIUJ5zZgtt+0BnQnjQqBoMA/eQvtXJgEf9ibqMegdFjF+hVQCqN8X256a7HCgoNhv0ubeVXIdFXPI9xFuw4BqmHE8oabEt1IqWYe95FC0cU/I3LhOfHjmQT3eORqf9/2IgtFbjwIEPcdNldhw5dl501Jhq8WsTtvV66NliBtssb4g1FwZtGWURwOUuduFI/5c231qD9eBd+vqu2YC+YgNsDemIGP/eigjuF1VzcexIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjBk/Yuz9KEtlPONsE751Cye6/EZ8PgTW8Teaqp4Bn8=;
 b=idiKAd0GGMt85yWf19OuxrXOlqWMkLfLBw1IqeOnwZqLfdr+pbTBCX/lfpHZyrA1qzsC4bXeHPLKjtb0LS+OXwzj6vqv1E9meLH5j9ecIykzu7a/iXRuKGdI7p4WQNjv4qx+BtnGvCcu0woJ6h9sbYqHUlgfz1O/Bcygn30QOU0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 09:12:38 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3%5]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 09:12:38 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com, vigneshr@ti.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-spi@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] drivers: spi: cadence: set cqspi to the driver_data field of struct device
Date:   Thu, 11 Mar 2021 17:12:20 +0800
Message-Id: <20210311091220.3615-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR02CA0204.apcprd02.prod.outlook.com (2603:1096:201:20::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 09:12:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd332a76-7fdc-4de8-a8c3-08d8e46dd0f6
X-MS-TrafficTypeDiagnostic: PH0PR11MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB50639C10E3295CF6580EBE4DF1909@PH0PR11MB5063.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i95xRmRCG3PGCPFdm3ZKu1gL3Tcazfv5QO6wD+UI6sfuOjM5NNKGllZbAsjT4zb6ljgqsz3sAIetFiCdFNdkZNkeR5JJc+YMfKm7RX6NPibQPvzHHGqAKfGGtwUE8dok1BYU0UVnHafcbPQdXSRqwiRtAY/hHCbZVbmGFFD3WyPUiqSlNZI+6Y3kx2zc+P1CCwFJnlK8YcRJrzTZ2JLUzSo4a/8VZJGsw+Th7ZYAJ5//C5/zZ0VmdH9sp0nS1WKscoJXiBTvk5kGqEDkAASNAV9M1LKHq7tFfI8FPagOndLmdN7TbNnN4/eKrWbG07t7l/iHy+XmRn4IpzYktzSxd7BA+6sh8xiWBVY7wVCYk7dU7Fo6OBPqvB175vTy6i47p4w+V4b8S1zz8E3dPXClALVOyrGRBq9U/MoqOBgWok/NepcXPv9Oc8dzIQspwys1NvF3cZKsBBHuLQU6WCwz9pxSiFo9TROYJ/795sBPSbdzGDwn40Ume7QvRkGZp+wlRR1Zu9ECTPhiZOfkPGf6eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(66556008)(316002)(66476007)(83380400001)(52116002)(4326008)(186003)(66946007)(478600001)(16526019)(6506007)(2616005)(956004)(2906002)(8676002)(9686003)(1076003)(6512007)(6486002)(8936002)(26005)(5660300002)(6916009)(107886003)(86362001)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J9Wudd8TfPtCOzETIfOcZb/mgSodtzhg7gmxHkpGkZpm+5Ke7MBiL2EXRsAK?=
 =?us-ascii?Q?BL65TZn3WZfJo82FlNxe8fjD1FSWVlpjb032CUw+HI+5EHewrcHSry9qFrdx?=
 =?us-ascii?Q?RdFCrDaysKpD5SY4XaHIt6nCxPlIr5xKtzAnyp543gogUcfqSgHg5DlmKiOF?=
 =?us-ascii?Q?W+A9G377X5f+rBDI6ffEGXb6LcVmSDsGbvedw3srAw7OVmHj1mvdwGlx2yna?=
 =?us-ascii?Q?s8BSpu5OQDaiHPBwzqBOAvjDPT2/zfOYe7bukvpy2w15bQPAvrie2AX8SECW?=
 =?us-ascii?Q?M1z7udlVkExZRIPwJ8PESMaJ9BrX1mK2m2xgncwXcXC966+ZWMGSebzM5/l1?=
 =?us-ascii?Q?S1sxPyCbhlXFn+Hus+4adyMx1KUKmn5RGV5Jso6Q57mxafieGOYiO1LdEgH8?=
 =?us-ascii?Q?7ZaXYJfc3F/nSaYWWZdQSNs+KfPaGisbhlcFLtSnmSkSkABRXe3sr+fRnL9n?=
 =?us-ascii?Q?CRDOUADxvWvu8vl3VE/K3FJ12etpuZuxRHCYqFxbpQd994N8RZxCjPM/rYNe?=
 =?us-ascii?Q?tatX083ShOb+0+2JIohITW8QU/R3i4+hoY3RzbmHNNQlP++TwVY09UJ5iWCc?=
 =?us-ascii?Q?3evgJrqCL0EGY1PRV16qR2S5+/8FZ3967Ud1musxhwGYursuu29idFpzW63H?=
 =?us-ascii?Q?VxXcWrzJvQlFh+RbAMUclCgbw/Y9lC9rF3L5wjObAQVeaXJfJuwXQB/Jaupm?=
 =?us-ascii?Q?eiks9YL5CabQv3y5At9YxgUGshfpdB/XOcgnKXivXG9zH7+6TsQBD2Zs59wl?=
 =?us-ascii?Q?Gar+ce18pQaQdqS0hTOTPcZZUx//38NXFjhtZe264y0ENnnlpPOMccpIpNWH?=
 =?us-ascii?Q?W7aW0REbYryvMmt9ZqUDuZZWBOgVk541FDfsVwfEf09DWwlO4u1iPX0yp2b3?=
 =?us-ascii?Q?Vj8q6bbCM/GDicTUFwkKVVhI+Fuhww5T3wynRZgmXTlraLeWY6g27X3e+Zz5?=
 =?us-ascii?Q?36VudTZMaue7hhaqM27MfyZaxTgzX+neB6bqqseSDBmwQf+GTjAUJKRfqu4/?=
 =?us-ascii?Q?RWKpI/pdF8kp2zcmECCaVodP0A6I7pOBqc78ZwmdzWSnEL9jmArLcuEZY44n?=
 =?us-ascii?Q?lz/6iExiNA3E0wXAaqV5zRlpwR0GA02GNQaM+9K7OzKV2uc+0O9LCbfASH++?=
 =?us-ascii?Q?o0TcpGyArIbj21ZyJkmI7VfKRf4hMeuvNItLig+mb66bDexZOF2TeeyoZkqz?=
 =?us-ascii?Q?IcHdjpj4w4Tawh5I8eAuQ0G7vgmg0/jRhkwRhS4fKxf0mdFkeK6zBxmzP5B7?=
 =?us-ascii?Q?vtRYBYkJy3h64DAv83THeSIfbkmk7PoVt4hGtcsuFl1IktCYG7XHI2dyjYvF?=
 =?us-ascii?Q?Lirw8dmuKXaKv+fJfdCsaDq3?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd332a76-7fdc-4de8-a8c3-08d8e46dd0f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 09:12:38.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vy6GsuJ9HJ54LynA435Tx4MjWf1y+YfhBmL8p8rqFhFl2Q72IEngLAGGX3zV8fpuGmB8wVOpw3E5lBl+i4Icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

When initialize cadence qspi controller, it is need to set cqspi
to the driver_data field of struct device, because it will be
used in function cqspi_remove/suspend/resume(). Otherwise, there
will be a crash trace as below when invoking these finctions.
Call trace:
 cqspi_suspend+0x14/0x44
 dpm_run_callback+0x50/0x1c0
 __device_suspend+0x114/0x514
 ......
 el0_svc+0x20/0x30
 el0_sync_handler+0x1a4/0x1b0
 el0_sync+0x174/0x180

Fixes: 31fb632b5d43("spi: Move cadence-quadspi driver to drivers/spi/")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ba7d40c2922f..d8b0e1f1cb3a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1198,6 +1198,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi = spi_master_get_devdata(master);
 
 	cqspi->pdev = pdev;
+	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
 	ret = cqspi_of_get_pdata(cqspi);
-- 
2.17.1

