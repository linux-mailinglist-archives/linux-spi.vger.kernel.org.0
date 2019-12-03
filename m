Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5010F625
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 05:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLCEHp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 23:07:45 -0500
Received: from pbmsgap01.intersil.com ([192.157.179.201]:35032 "EHLO
        pbmsgap01.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCEHo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 23:07:44 -0500
Received: from pps.filterd (pbmsgap01.intersil.com [127.0.0.1])
        by pbmsgap01.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB33k3qb001850;
        Mon, 2 Dec 2019 22:46:03 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap01.intersil.com with ESMTP id 2wkmu327q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:46:03 -0500
Received: from pbmxdp01.intersil.corp (132.158.200.222) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Mon, 2 Dec 2019 22:46:01 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 2 Dec 2019 22:46:00 -0500
From:   Chris Brandt <chris.brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 1/6] clk: renesas: mstp: Add critical clock from device tree support
Date:   Mon, 2 Dec 2019 22:45:14 -0500
Message-ID: <20191203034519.5640-2-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034519.5640-1-chris.brandt@renesas.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912030031
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Allow critical clocks to be specified in the Device Tree.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/clk-mstp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 003e9ce45757..8e28e9671265 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -148,7 +148,7 @@ static const struct clk_ops cpg_mstp_clock_ops = {
 
 static struct clk * __init cpg_mstp_clock_register(const char *name,
 	const char *parent_name, unsigned int index,
-	struct mstp_clock_group *group)
+	struct mstp_clock_group *group, unsigned long flags)
 {
 	struct clk_init_data init;
 	struct mstp_clock *clock;
@@ -160,12 +160,12 @@ static struct clk * __init cpg_mstp_clock_register(const char *name,
 
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT | flags;
 	/* INTC-SYS is the module clock of the GIC, and must not be disabled */
-	if (!strcmp(name, "intc-sys")) {
-		pr_debug("MSTP %s setting CLK_IS_CRITICAL\n", name);
+	if (!strcmp(name, "intc-sys"))
 		init.flags |= CLK_IS_CRITICAL;
-	}
+	if (init.flags & CLK_IS_CRITICAL)
+		pr_debug("MSTP %s setting CLK_IS_CRITICAL\n", name);
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
@@ -187,6 +187,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 	const char *idxname;
 	struct clk **clks;
 	unsigned int i;
+	unsigned long flags;
 
 	group = kzalloc(struct_size(group, clks, MSTP_MAX_CLOCKS), GFP_KERNEL);
 	if (!group)
@@ -239,8 +240,11 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			continue;
 		}
 
+		flags = 0;
+		of_clk_detect_critical(np, i, &flags);
+
 		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
-						       clkidx, group);
+						       clkidx, group, flags);
 		if (!IS_ERR(clks[clkidx])) {
 			group->data.clk_num = max(group->data.clk_num,
 						  clkidx + 1);
-- 
2.23.0

