Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284571151DE
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFOFU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 09:05:20 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:49592 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFOFU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 09:05:20 -0500
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB6Dh7bj000784;
        Fri, 6 Dec 2019 08:43:07 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffmn5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 08:43:07 -0500
Received: from pbmxdp02.intersil.corp (132.158.200.223) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Fri, 6 Dec 2019 08:43:06 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp02.intersil.corp (132.158.200.223) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 6 Dec 2019 08:43:05 -0500
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
Subject: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Date:   Fri, 6 Dec 2019 08:41:59 -0500
Message-ID: <20191206134202.18784-4-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206134202.18784-1-chris.brandt@renesas.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912060118
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPIBSC clocks are marked as critical because for XIP systems, the
kernel will be running from QSPI flash and cannot be turned off.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
 * Removed spibsc from critical clock section
---
 drivers/clk/renesas/r7s9210-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r7s9210-cpg-mssr.c b/drivers/clk/renesas/r7s9210-cpg-mssr.c
index 14093503c085..261d88ae990b 100644
--- a/drivers/clk/renesas/r7s9210-cpg-mssr.c
+++ b/drivers/clk/renesas/r7s9210-cpg-mssr.c
@@ -93,6 +93,7 @@ static const struct mssr_mod_clk r7s9210_mod_clks[] __initconst = {
 	DEF_MOD_STB("ether1",	 64,	R7S9210_CLK_B),
 	DEF_MOD_STB("ether0",	 65,	R7S9210_CLK_B),
 
+	DEF_MOD_STB("spibsc",	 83,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c3",	 84,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c2",	 85,	R7S9210_CLK_P1),
 	DEF_MOD_STB("i2c1",	 86,	R7S9210_CLK_P1),
-- 
2.23.0

