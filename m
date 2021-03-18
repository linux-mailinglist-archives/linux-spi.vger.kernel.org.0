Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B216340319
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCRKZj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 06:25:39 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:23041
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230041AbhCRKZU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 06:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+mSUz78/b3bKYyh3d/fchkoIziIXYk1+VnnFMGpNh8VgLY+zOTHre1vRfBdYXm/Uecih5o0uq54JhQPD2MNhi6d5s9btiKlSr3KG8gPSidokQs5rI2y5u6RfiNv6MSQNzBIADaywwpCN/mI56wxwIBKHDKLFkoK9uTtJ56f1UGaZ2TzAFczhiBJoQCfZSX7NZj8TrRXHoFOPrVVJu+7PLvNNrw4ZLxDId44ycJnDjHDlnTQ5xjmco/tb86Ihx9Cm0yIB46DT2TBSAmhWgqis7rRYQVn3d7WFndp/eSC1+MDLsx7NtLr/8XYdg5HDFlIILYC9N1nYbj95+bMvLU4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0oR6/eKs3AM89sfHHKcsLq9UD7tqTZ55v6qiU2TkIU=;
 b=KvLLZh39BS9xyE0nSOMRLq57p57LEv7kn4rrx2AhGv3st9XWzhVHSBoA6IIT3PJHNukEIf9lKNix+mEQ2n2fCbcRGoX41xw24rIXFqekMzjWx4GaP0qb3pRKRwjzCF9fwGNsNtfnk738zUI/Z/lr8tKd2uxOR53dF17VOWLNwZU6KPdsN4SMORyN8idLeLVV8+XhzemLKzmFCdt25/+9uCG9/HVlBN6vqZi4wTRWWhxbYDnloTP4Mmy/n3ePPBpYrlFTAhlXGKpWuadfw6vBs+cAmxpg0CnWzrVYCAyVWuJqlRC9SPXBTzgm8gUH8OzhzRpiaNbCNeN4qt9G0eu3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0oR6/eKs3AM89sfHHKcsLq9UD7tqTZ55v6qiU2TkIU=;
 b=i8zoDjQe07YNlaCUWQXPQfWzlGwrfPyAUiR4d+635mQCGuFUlI4vyLSAKqqR9Wf/niVKhHd+5Nw5NzsuzZiU/jey/HTkvSIifvxXQB/qmk/D+OGYl29OamyziZn8pOREW68x45dwErA4ei34EZFvLotQP+oFkygQNR0I0m9smJQ=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 DM6PR02MB5033.namprd02.prod.outlook.com (2603:10b6:5:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 10:25:14 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::5e) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 10:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Thu, 18 Mar 2021 10:25:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 03:24:55 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 18 Mar 2021 03:24:55 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 karen.dombroski@marsbioimaging.com
Received: from [10.140.6.25] (port=50704 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lMppm-0007CY-8G; Thu, 18 Mar 2021 03:24:54 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Karen Dombroski <karen.dombroski@marsbioimaging.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 2/2] spi: spi-zynq-qspi: Fix stack violation bug
Date:   Thu, 18 Mar 2021 04:24:46 -0600
Message-ID: <20210318102446.25142-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
References: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0bc2227-850f-426b-8e6b-08d8e9f81e74
X-MS-TrafficTypeDiagnostic: DM6PR02MB5033:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5033DFC0500F0B7B0E75434FBA699@DM6PR02MB5033.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzx2uqbjBGAF3KX4KO1VNG8thjUNoS3c5I2mdg/f3Zn6XjAL+qpMLK+d2dtO3pjfdEElhWj/4zXce16Xx05rVfzz5QhOw5gwYi/hHAFx29zs43liU5csPisNvHmjzMWFQl/ifc5JQAkEeuM0wjaA6GAgrSD8Nel07HP+UKp5YEMT+EWEc7bm92sN5BgXOPlo1hcwZkfxfLHHARfj65dzTveSjNLpxna9fCYWlVCG14EQfbpxWeP3JNc4Vh2XJDnwig81mRlJyUZge0qYEIING7jVrAWFYBhtjuH+6+LLIlQEN+9XDXovyCgbpt/0HKQdIidmrw2eF09c+Z1MMUSBYUE4/emjPG9TwBosXflWJX8Sa07PynXyO+M3J0ah14ViTAXmIXcuMjKt3bSmjwsyDVXtWj3Fh0h1LeYwVcNYm4RCC3aNPuOwwN9MDbbQzBIdCv5jjf3r0Ik2EtjuHFapbJjWPYhYU/tqm6BIBPffqKnvzQ0cjflcZ5+d0dKW6WNJ+cq7I56S2Jbm/nfNxlF36Lj2QHSvp3/qUe2B4bmKNu2uzxMW2+wKaSFB2p/skKdCwOy2h8bBRP5m6t8Cri5jnVsF9jrju4DpeqAo0Vdnjvi2NEgMh0eLXOg6xiOPIzP+jZJ4sbwmhdhmk2L+OlLuyHvGEjlUlXc5HaBeFykDNlGZFEYXBk8tZujCVNQ1qALt
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(82740400003)(9786002)(316002)(36906005)(7636003)(8936002)(54906003)(107886003)(1076003)(26005)(6916009)(70206006)(426003)(70586007)(36756003)(36860700001)(8676002)(4326008)(7696005)(5660300002)(336012)(83380400001)(356005)(2906002)(82310400003)(6666004)(478600001)(2616005)(47076005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:25:14.4141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bc2227-850f-426b-8e6b-08d8e9f81e74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5033
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Karen Dombroski <karen.dombroski@marsbioimaging.com>

When the number of bytes for the op is greater than one, the read could
run off the end of the function stack and cause a crash.

This patch restores the behaviour of safely reading out of the original
opcode location.

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
 in: zynq_qspi_exec_mem_op+0x1c0/0x2e0
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.11-mars-2020.11 #2
Hardware name: Xilinx Zynq Platform
[<c010c15c>] (unwind_backtrace) from [<c0109034>] (show_stack+0x10/0x14)
[<c0109034>] (show_stack) from [<c0591848>] (dump_stack+0xb8/0xd4)
[<c0591848>] (dump_stack) from [<c010aecc>] (handle_IPI+0xe0/0x1a4)
[<c010aecc>] (handle_IPI) from [<c0343890>] (gic_handle_irq+0x84/0x90)
[<c0343890>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0x6c/0xa8)
Exception stack(0xef087f58 to 0xef087fa0)
7f40:                                                       00000780 ef7e26=
f4
7f60: 00000000 c0114380 00000000 00000000 ef086000 c0903eec 00000002 ef087f=
b8
7f80: c0903f28 00000000 ffffffe8 ef087fa8 c0106824 c0106814 60000013 ffffff=
ff
[<c0100b0c>] (__irq_svc) from [<c0106814>] (arch_cpu_idle+0x1c/0x38)
[<c0106814>] (arch_cpu_idle) from [<c0598d58>] (default_idle_call+0x20/0x28=
)
[<c0598d58>] (default_idle_call) from [<c013b744>] (do_idle+0x124/0x22c)
[<c013b744>] (do_idle) from [<c013b9bc>] (cpu_startup_entry+0x18/0x1c)
[<c013b9bc>] (cpu_startup_entry) from [<001014ac>] (0x1014ac)

Signed-off-by: Karen Dombroski <karen.dombroski@marsbioimaging.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynq-qspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 1acde9e24973..5a3d81c31d04 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -528,18 +528,17 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
        struct zynq_qspi *xqspi =3D spi_controller_get_devdata(mem->spi->ma=
ster);
        int err =3D 0, i;
        u8 *tmpbuf;
-       u8 opcode =3D op->cmd.opcode;

        dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-               opcode, op->cmd.buswidth, op->addr.buswidth,
+               op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
                op->dummy.buswidth, op->data.buswidth);

        zynq_qspi_chipselect(mem->spi, true);
        zynq_qspi_config_op(xqspi, mem->spi);

-       if (op->cmd.nbytes) {
+       if (op->cmd.opcode) {
                reinit_completion(&xqspi->data_completion);
-               xqspi->txbuf =3D &opcode;
+               xqspi->txbuf =3D (u8 *)&op->cmd.opcode;
                xqspi->rxbuf =3D NULL;
                xqspi->tx_bytes =3D op->cmd.nbytes;
                xqspi->rx_bytes =3D op->cmd.nbytes;
--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
