Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14135357B03
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 06:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDHEED (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 00:04:03 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:30209
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhDHEEC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 00:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlbhtfnKZYpr6rbHbKZouBmHNanhXPsXu4dt5tIm7kxGhmg6GSbSYptg15NLQBXXee0oavdfNyMLbTD9KSTofrOIYI+uZA7q+DRByn3DqN+tsJCVni8hQzeBXiKf29WTNoHGrvWCP8Ld8hNCssFZmamE03PoTyTsWa8EFWN2mvE2SQY5IbmV4xwbn+xNalqB9zjwlRL/Lt0vN9T2PXowwGVudd3NcXy3Drx0yLJbaED0x6y9gkdeKoLEfiTQq0rBrvQX+nCrM1G3s+/z+orCBM6kEfPd6rTxt7IDD2sHJuOdAIjc9+DaOHlzGEWh9O0bFSWgNQLTNnrlIn3AHnY8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J58pVr3GsM+c4wehfY+pfXqMm5nm7A9vpYsR6zaLSzE=;
 b=ECFpvI7D/5+vOZlQs95nd4Q5ybLEoA+qOpegKoiXwkP+uK++KRRZdkZI36WFQvgQZ7OYwWwr7Qq0HqW5nLGZqaSJRJyWXsUDBF6SSHB16Qu2viXWFxkBO1j1/VcsbN5HsFLtoZ/EHZWVG5PO+RHAZqjaGT/NnXe2Xh7AFqIbo9HZQ8m2v9sSGpOIfH1xS9MNodnkpPpP9okzchmHeyWs16pc3AgHeKJdsAl4g/spnblw+jRhtZvZu5kKtDXWwrN9hQXk9HJaV9oP27Kxw+cx8OvxfpsDvvAGx4/BY3pLMeqywMpoi7W84+RwY6sxOW2bvBpjXh1Pq+mCWlNKKRT/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J58pVr3GsM+c4wehfY+pfXqMm5nm7A9vpYsR6zaLSzE=;
 b=dZbJvi+p2iq+pPvM4NPWrfKPtDu0afe0DY4SLzODekWvd1nyFdKtYgVS4gfw8DE4mtb6eCULb5kOksRNArtGPir95M2ovv8LZxLyk9K552FvECOCCLIE6AFkqGAX3AMJb6HmI7sM1bGsOhUdTJHAJFuk0Z7p/ck/65ogCYNRcmQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 04:03:51 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:03:51 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 2/4] spi: spi-zynqmp-gqspi: add mutex locking for exec_op
Date:   Thu,  8 Apr 2021 12:02:21 +0800
Message-Id: <20210408040223.23134-3-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040223.23134-1-quanyang.wang@windriver.com>
References: <20210408040223.23134-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 04:03:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828699d9-d9e3-4be7-f697-08d8fa43514e
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1544B6681F9CE80631111833F0749@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbrKqGIal0woYH7Lf4DCuu2W5Rm6YjdYmGfcFTlfoHRKDJclUpPlQBsx+HUy509Ua2ujCa0iXnfC5aJ1CVpjOu4jNra4qgGl+2BZjuQbjuLXxwHMjeePlPDx+XksKmLKFgwQlTqYtvNIGol0XmkaM2MAmcL2t7OwzKp+viTCtvXHvyXfkj1L2oFWO3w8Qz8xk8IAJewYfPM2usTqtcrwgvwK0UPLyLheNpNxGeioXWslB7KriNmJ904dKcSVlbPEYZkX2Tix7+i07CVOky7FQX6+m1SxuVBPS7yFGvHP60ZGmKkrlxjHP+/XZVB598XueVGqYO9B8OMnvS0Xo7H+neMR7DSvV6Cwrf+tXL56JRihA3YJFX+Q+6U2blMCdqMep9IrC9tyLWKkJrawnBq7Bcv8LFV9kUf8t/PHtiUht4yTtVGPWeGT0o7WGcVClzFlWHysaGTGFniLr3A7IZvgzxhKHDYFktZ9wvbF4O8q8Keq9fODinNo+E7oY68qabAXmVhT8bSkMkTf+/POHDbrQfS+ofFGzZJqNX5iWfLJr4j88jI6znEHUiS3feE2uKLuD29F07ewEVHBOfoEdG0gHVXi/f32wddJxdRioq2tjUWZ33rYn3QtL2wJDw3ZCa8vx5xtLe5KwD42VPCG6IycweJfC7Fi7T3YrdnUvAhZLHIejY79D2IkXPT98xKRgI3A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(8936002)(6666004)(83380400001)(52116002)(107886003)(4326008)(5660300002)(956004)(110136005)(2616005)(6506007)(316002)(26005)(8676002)(38350700001)(16526019)(1076003)(66946007)(86362001)(478600001)(186003)(38100700001)(6486002)(2906002)(36756003)(6512007)(9686003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mnyyqwngfCvmuz0FBEHLb+LC98g8EX7TcHdDYLq3FsMAsE4gTFMRziXEyyfx?=
 =?us-ascii?Q?VrZ0nBwxgWXqL8o0g5y9J/STutnoGBosv0DzNHg0aum4UZuxOpVbgkwXQRNT?=
 =?us-ascii?Q?XyyDXcHBJHtT6fgdXAzSkzYQamFZMIENzMJpwloYTnqC63JTRKWdJeng7T+K?=
 =?us-ascii?Q?kwivROU5ekIyu/6ZWACkgstk5Y1GWqzfPbBFlbWXWX6rfFZKTa7JC6WfhElb?=
 =?us-ascii?Q?yIM29GHDNVz/bjde6ATv8ZYbrkWIGYeAwZJd1bIvsy8FQqpEc3TkPwMuXyPW?=
 =?us-ascii?Q?ZsnesPs6BThTaJrzNVwwPeSsnr6OWE3TMx5d6cXe77ML7rwTc2sNNxoT6fwG?=
 =?us-ascii?Q?cRMRbtueQCNABAPKZmas0yHoEWnRng71Y5CilSXX31gNOO3cFIe58fDpc8VZ?=
 =?us-ascii?Q?1w+ZPtnwIL9gT4Y8rSWh9tC7kLtP+fdfRr3oXm9+5WgxzCbA6XzixOgfVQms?=
 =?us-ascii?Q?WwQdT4gpMdfJSDVIpHMSuulJTgIdZCCSGb0/WiTqDrYeE45E7+yLCQ+QhteV?=
 =?us-ascii?Q?dgv1wRRGvS5FUYg+1PveE0Xna1JRiERPDu8ZJOxZz4hz0vmu4p3j3S0zmAaL?=
 =?us-ascii?Q?rI6I+YcWFoSxQx1mdVt8FusTO+WI1HYEmHBhAs7bmRy7hjWTYkOPJclTYACD?=
 =?us-ascii?Q?daqwadwLSo3OaTVxl2POxZ9Fas8TGjWwpDa4fDWkrtjLLIP+o6b1RUbKCtDY?=
 =?us-ascii?Q?IQWPqJcdYZx/eck7EONtYJ9meO00hQN9HMk0j+dbePOkDGPNKdm2D04TcY7K?=
 =?us-ascii?Q?cKgebrFA18yJg05+pUGOGJQtLXGDuFx2aa4yNx+Pf1eOXmdH0Fj+AXzkvx+g?=
 =?us-ascii?Q?uSxH18wZ/VNjHiO/1hxUvSPykla4CnmsOdAmIsjraxrPxY2b6QlsckVkEolL?=
 =?us-ascii?Q?Z6iMgxANyYIzI+Artbo1D0kipNvD5KXSM4vKRh5OsjZugM9WaaMfZq/6RZ87?=
 =?us-ascii?Q?OBKYcXBTyq2Cl7Ln4B2fJu59gVGif0YyE4NxbKhPhs6mah5Tp+IlkGvA/OAW?=
 =?us-ascii?Q?68wR6E6tj8sb2zNFmkXVGeWN+Jwp0Xb5d+kBwvuIaiKMIBNS+W7G3BFxVmZw?=
 =?us-ascii?Q?wfZa3IgFhkUU8CriRJze13cQcfnKPaiCP2SmYAttJJp607+jBh2eTmlI7HPU?=
 =?us-ascii?Q?VqOSbltf8LRn0cJ9I9XllrccxBKEix1+P7pGWsdTGLxb9JsCaO3qf2HqaUeG?=
 =?us-ascii?Q?+TPl273l6L/z2XBSEnC9lqxJEaBxfq+xjc1RerUsWTa4EydlRlNCzE/JGd//?=
 =?us-ascii?Q?hTk7EfQLNQgl7/rBO0DraXiFyothbmH2f9PPW2ezQ1CV1xVCewDgYVYjYRm6?=
 =?us-ascii?Q?qphMa/afiTWe/RzP6t2b1nu/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828699d9-d9e3-4be7-f697-08d8fa43514e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 04:03:50.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9a5SO6qHMesi5yqFVgpwbzYynbO8zR6BD0FW35/Xi3fOEMSFdHvvAMkS5mT4vSDkpbIH7GWTRbNI+fA+c8xCixHD7OtOxk13BRkFic4YDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The spi-mem framework has no locking to prevent ctlr->mem_ops->exec_op
from concurrency. So add the locking to zynqmp_qspi_exec_op.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Reviewed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index d49ab6575553..3b39461d58b3 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -173,6 +173,7 @@ struct zynqmp_qspi {
 	u32 genfifoentry;
 	enum mode_type mode;
 	struct completion data_completion;
+	struct mutex op_lock;
 };
 
 /**
@@ -951,6 +952,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
 		op->dummy.buswidth, op->data.buswidth);
 
+	mutex_lock(&xqspi->op_lock);
 	zynqmp_qspi_config_op(xqspi, mem->spi);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
@@ -1084,6 +1086,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 return_err:
 
 	zynqmp_qspi_chipselect(mem->spi, true);
+	mutex_unlock(&xqspi->op_lock);
 
 	return err;
 }
@@ -1156,6 +1159,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	mutex_init(&xqspi->op_lock);
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
-- 
2.25.1

