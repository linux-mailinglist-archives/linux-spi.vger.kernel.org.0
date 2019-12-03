Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB62A10F60D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 05:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLCECn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 23:02:43 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:53004 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCECn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 23:02:43 -0500
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB33ipI7008708;
        Mon, 2 Dec 2019 22:46:25 -0500
Received: from pbmxdp03.intersil.corp (pbmxdp03.pb.intersil.com [132.158.200.224])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffj009-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:46:25 -0500
Received: from pbmxdp01.intersil.corp (132.158.200.222) by
 pbmxdp03.intersil.corp (132.158.200.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Mon, 2 Dec 2019 22:46:24 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 2 Dec 2019 22:46:23 -0500
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
Subject: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Date:   Mon, 2 Dec 2019 22:45:16 -0500
Message-ID: <20191203034519.5640-4-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034519.5640-1-chris.brandt@renesas.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912030031
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPIBSC clocks are marked as critical because for XIP systems, the
kernel will be running from QSPI flash and cannot be turned off.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/r7s9210-cpg-mssr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r7s9210-cpg-mssr.c b/drivers/clk/renesas/r7s9210-cpg-mssr.c
index 14093503c085..153d3a49eee0 100644
--- a/drivers/clk/renesas/r7s9210-cpg-mssr.c
+++ b/drivers/clk/renesas/r7s9210-cpg-mssr.c
@@ -93,6 +93,7 @@ static const struct mssr_mod_clk r7s9210_mod_clks[] __initconst = {
 	DEF_MOD_STB("ether1",	 64,	R7S9210_CLK_B),
 	DEF_MOD_STB("ether0",	 65,	R7S9210_CLK_B),
 
+	DEF_MOD_STB("spibsc",	 83,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c3",	 84,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c2",	 85,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c1",	 86,	R7S9210_CLK_P1),
@@ -112,6 +113,10 @@ static const struct mssr_mod_clk r7s9210_mod_clks[] __initconst = {
 	DEF_MOD_STB("vdc6",	 81,	R7S9210_CLK_P1),
 };
 
+static const unsigned int r7s9210_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID_10(83),	/* SPIBSC */
+};
+
 /* The clock dividers in the table vary based on DT and register settings */
 static void __init r7s9210_update_clk_table(struct clk *extal_clk,
 					    void __iomem *base)
@@ -213,6 +218,10 @@ const struct cpg_mssr_info r7s9210_cpg_mssr_info __initconst = {
 	.num_mod_clks = ARRAY_SIZE(r7s9210_mod_clks),
 	.num_hw_mod_clks = 11 * 32, /* includes STBCR0 which doesn't exist */
 
+	/* Critical Module Clocks */
+	.crit_mod_clks = r7s9210_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r7s9210_crit_mod_clks),
+
 	/* Callbacks */
 	.cpg_clk_register = rza2_cpg_clk_register,
 
-- 
2.23.0

