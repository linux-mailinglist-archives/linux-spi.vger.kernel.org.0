Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB25A4FC930
	for <lists+linux-spi@lfdr.de>; Tue, 12 Apr 2022 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiDLAVk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 20:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiDLAVj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 20:21:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2087.outbound.protection.outlook.com [40.107.113.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C913D42
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 17:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbarWaqpld9SYkeIzAQrFYF8k98bezgS0Cd1G3ESRqi93eEk6b4mFdE1NymnUeMPRopsC+vkmSwD7mjipQjA2iWtwJjnZniNWHjGA62lObY3Q6emUNhvQ0Rsdfsa4ielzl0nJFW/QZHORTUW/UTyWDJSY5uSHiVXcQHaef3orF6fipmW7O3fzvcySLdg2q137guXnWoXCcxkJt77bb/SA+pSJ5GFoyqwaNPLRA0q+EFxHHHPUHeirHjVsndRL9KmBnBhFVFAM7NHg9RiYKXybdM7go2SzInKMu6mdWSV2Hox7MP32jEqt8h6MfS1uMtXhiraH4+DNFMi/s1Faj/qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftA+w5J84J3wTl6BmAE2u64kHKRlXv1CQP3PUcs7Aes=;
 b=AWqEVxWa+im1RJhmJ/I9T6oeb3ysAFcKXGmtdUqd+Xine1SJugRRZGY4vYgHcORFGVFyoc6QCUIFzHonHg+qTyyZiVzF+Ia1nRGyfJXv4JFpsQVSuyKzENGmpkJ4ijE6hupYB/lT5uAsWnVsPebNTplQgesEpA5yB8L8cjvZeCU1A5LO2Nw/vqWFXi9qg5NfwwUtSQOILYyz0rOl7EXKpiA9xYeDNk5Z3gR+z0qp8iaKrs4LeJuxVons3G5ZnUCyAmTFhCPmjhe94lGOqvYS1z9ND5Yp4BjgNi1D3w6HY9QqOHla2BXzUmr9wOxP8pYsJeIlMFi464qz+rBMrPFXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftA+w5J84J3wTl6BmAE2u64kHKRlXv1CQP3PUcs7Aes=;
 b=M8SmnfkmnRETgDibIe3GJd0ndef7Gehpvpa8PkBX0/vF6f/AGdNEm70rfquyuHxL2Yra5yzfnStvNkmKmbl9y6N3YfyRd55dY+fpioMXjc59FAsS18ybE1ORGHR3A22qhucT6mNVKHtqPs/8MSxSx7t15yydDrqJ1+idzS9Z2J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by TYCPR01MB7483.jpnprd01.prod.outlook.com (2603:1096:400:f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 00:19:19 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::10db:eac0:e6e8:bda0]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::10db:eac0:e6e8:bda0%4]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 00:19:19 +0000
Date:   Tue, 12 Apr 2022 09:19:18 +0900 (JST)
Message-Id: <20220412.091918.2014954664735013611.atsushi.nemoto@sord.co.jp>
To:     linux-spi@vger.kernel.org
Cc:     Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] spi: spi-ti-qspi: Support per-transfer and per-slave
 speed_hz settings
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.8 on Emacs 27.1
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0025.apcprd06.prod.outlook.com
 (2603:1096:404:2e::13) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb58836c-526a-42cb-4eff-08da1c1a1646
X-MS-TrafficTypeDiagnostic: TYCPR01MB7483:EE_
X-Microsoft-Antispam-PRVS: <TYCPR01MB748324247E96D9BE319AB843BBED9@TYCPR01MB7483.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0egUuPUGDM1WNDcIJ0tfgakFoQ1rFyKC/+1uLoykzuXO53qzCNVPjwoV5irpG2yh/zzGHwsKQiQQStCB0j3RvdyYtnUUQyfK3C5kZWqdpgV/XvhRMq0ScVp9JwspE/O5DrzwB2afIRcvG5+JV7jqzL58dbNYZdnya10hU1ZAUu+0UsKFLmRJZ3XuMk5Aw/gbtbLIyCIKnwEWc0xz5PjiD+OiVmqX44PMvmZZrNFjnCw29hR2DtRZAduAB2wJcptF/cUJv0HJqaIvRkawcyCaRajhNbvvXNzNLssR0lbScHWoy6w7DrRIETSOETetAUjgxiTG9dM4EXFSpJMS3DyyhAq2SgWKzB3vIg0jqzzTTcgG5OvCOcqEdD0/qpAFsLwi/9bdSRQnQSqbMPnXeTaHtAd0Uf2stgwinlUEgW6AUC0Jqh4wBHDFc+3xyjJBq9ZnuvAXeERhJGlUTTmj5KOgiEUgS4zXRHXgYXkaLxL6iwXDilxOEefiNggI3Ndr0ObGr37Xl3kAOIS5gNl9L81f9gftukLGm0EHFbTYLot7Qga3n7AIMwTy82ebnDXV+ydEwJNvDTytK1gphHYsL8y4D3uclA/Df9pR2MshSiKUswccTsfeWPo9yIUvpnJku1D08RP5mzxsHzqSPQxGBpbj37MaA+/uluYd8Qo8YrbKBAdDz5iENx5LR9+CPUpqkPyd3akLfN/ujWKbJ4V3+YmUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(2616005)(103116003)(52116002)(6506007)(2906002)(5660300002)(83380400001)(36756003)(186003)(26005)(6916009)(316002)(38100700002)(38350700002)(6512007)(6486002)(8936002)(86362001)(508600001)(66946007)(8676002)(66476007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2BYZr6/yX9fpiszk0bQdwf6Y734wyecJrKj1s2HsOyy4aOnKbKQteRNr0HQ?=
 =?us-ascii?Q?i1UBULKPrZNXtSflqaMzgUSq4bLjdJ85Ocif2NwxCn8iagaATX/apgOPnJsl?=
 =?us-ascii?Q?rHpt5nOhga7vkilz8PJMlYgLywD639pUh0X+tpzitTsglZtSf7x1+3TXf3/P?=
 =?us-ascii?Q?iqAysVpqXkz1WblfNLS06w9PKSvpjcVLs5NBbQBUsrgvTVn3qM+qHHdtMDk4?=
 =?us-ascii?Q?qQsmiw/PvVJcIvSvz2nEstJBfqI8QEsmtXTGzEt+KiKdd/GmXE7iV3F9hohG?=
 =?us-ascii?Q?1U8kjUIrm+LY2RBnhq/rf9+KqKXBCqqDVV2et+ef66JEefBDaILG+QkfoKZ/?=
 =?us-ascii?Q?JsrU2VpzEKX7RHDIhhaUgxJ3n8KSeS8VqYSqSECzCbEnPo+wQyyHuXm1Wcol?=
 =?us-ascii?Q?1JZJ5Xu8+eChuNWpQOvAWigKGut65iWdpmptZ0B4vXfxMc9DKm5tD6Vfj++m?=
 =?us-ascii?Q?wVa1kH3mQ/D+pCb3QOa8qc0r6vc3EYLMSPrmSHYDm68lQ64yYyhzcNcN0zWo?=
 =?us-ascii?Q?xuR70BhLdk+Inyz1bPRLlyyBHt32eaLo1e7x0YlM3lD/i2ThOuFTDKeVj9Ol?=
 =?us-ascii?Q?UtcjSTzgJDzfU6BuMg4ZdweV6idrJT3YsJPiIuh8+u4TtTDTawQAk29/zzpW?=
 =?us-ascii?Q?h/M+T7c8R0HBZtjXKVD4T/buWiYfvxvmvDbkDQ26bW+FfGqBQBg+l8Mv2qAO?=
 =?us-ascii?Q?ID/k3VSzKRY+cwsUu6ndbTJ6sheVyu1gQBHoL8jbO3MaTwaOs15htOA12IjS?=
 =?us-ascii?Q?np1uhagCdhylg+t8gZCOSFhlIOX41C0UV2G9ERnoiOEVN5iVhGm5x2HblXPW?=
 =?us-ascii?Q?xyRCu+K/o7DEqTqLm0Bmn1Fg8m4oiqH5W/7+dl35aeJJQUErz4gALsYCKAfn?=
 =?us-ascii?Q?EYpWGLpQQj6cYLxo0utGsXmvIopEzIOqdIg6mqFYsyWiQAfdY5lwwic4b8+M?=
 =?us-ascii?Q?6yDkjxvy5eQPfdlO0FFrB6zRLyR0Bn5QLlWtv0wgwyOhnxogD34BNthNlcN/?=
 =?us-ascii?Q?n2cADq0GsvOawuFSSsS/X7d3/9IyO/su6evOjUlfEsBbpEhDNunedcXqL79f?=
 =?us-ascii?Q?J0okY1AE8BsocrU4UkD1DHnaRGgUnIC7E44U6u4q/bH2GIwVCQEYtJWagfNg?=
 =?us-ascii?Q?FNJjo5Rccuga75ENYQcRn+uZsTvxZCGdXvWRQI3osGvcHWYvzzvwDTtFLsE1?=
 =?us-ascii?Q?gd3LPUp2sD6IWKRt+dMfJyWCJNed1ImnhH/pMqP/h1hD4Hx3VF6WLkaSnbRC?=
 =?us-ascii?Q?esO4kNP2OzJKXva+XNrNbsWS7WpjxaGBUW/F5OBCA/rSeZCqqOJSkDpnjt9a?=
 =?us-ascii?Q?twfPanOtf+GUEeq2O0j+ie6NWkrRBAs0drBVv9MHiRJ6HpLkyXBa655gICR2?=
 =?us-ascii?Q?1+Tq4dBRwHcl51P4H7oh7s0PIAOhFsq7XHumJZV9yx41t1D0MvOI4tk5toBo?=
 =?us-ascii?Q?QPXtn3x9+lWo1khEvRt78uA/MLxRwpFBxVI1sjIgC1iusf3RxyGe5n9T+Vyv?=
 =?us-ascii?Q?hhYWDoofTqUO8HNC2rBxEYV9ZBtmw0IdMB5gGIYp7Qjk0wfP9F5TuThQeRTw?=
 =?us-ascii?Q?yJs/HEgkhsq2oOwzEVMQ6Ojn2GRMCQmbchxoiVmJwZgEn0uODF3fWTs1uYyU?=
 =?us-ascii?Q?H3VnNIlOVcdsimuU74GM2sIg+8GlxzIdoiID24Z0hkCnqIYVJKgYIbvOjrDM?=
 =?us-ascii?Q?opu7zfR99f8cO559jnYbq56swgrA3ichEMbEEl+tM+PNJ/5BTwagaX3GSk43?=
 =?us-ascii?Q?hTAXSAqmmlMy4J1cKmsHmSR6LqawnRA=3D?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58836c-526a-42cb-4eff-08da1c1a1646
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 00:19:19.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9ZFdFf3njq+FmYOi8qn6VEiF9KqyWLG2X9tj0A3MlWsafV4cwRSUqy4A85DrzmiuiZo6obw3vRzXtPxKPiN0L5qxzTV0RGwZYrzsNMzipU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7483
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-ti-qspi driver initializes its spi clock by the
spi-max-frequency property from the controller node, and ignores
per-transfer (and per-slave) speed_hz settings.

Isolate clock settings out from ti_qspi_setup() and call it from
ti_qspi_start_transfer_one() and ti_qspi_exec_mem_op(), using
per-transfer speed_hz and per-slave max_speed_hz settings.

Also drop spi_max_frequency from struct ti_qspi and use spi_master's
max_speed_hz.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 drivers/spi/spi-ti-qspi.c | 75 ++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e06aafe169e0..b285af776344 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -57,7 +57,6 @@ struct ti_qspi {
 	void			*rx_bb_addr;
 	struct dma_chan		*rx_chan;
 
-	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
 
@@ -140,37 +139,19 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 static int ti_qspi_setup(struct spi_device *spi)
 {
 	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
-	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
-	int clk_div = 0, ret;
-	u32 clk_ctrl_reg, clk_rate, clk_mask;
+	int ret;
 
 	if (spi->master->busy) {
 		dev_dbg(qspi->dev, "master busy doing other transfers\n");
 		return -EBUSY;
 	}
 
-	if (!qspi->spi_max_frequency) {
+	if (!qspi->master->max_speed_hz) {
 		dev_err(qspi->dev, "spi max frequency not defined\n");
 		return -EINVAL;
 	}
 
-	clk_rate = clk_get_rate(qspi->fclk);
-
-	clk_div = DIV_ROUND_UP(clk_rate, qspi->spi_max_frequency) - 1;
-
-	if (clk_div < 0) {
-		dev_dbg(qspi->dev, "clock divider < 0, using /1 divider\n");
-		return -EINVAL;
-	}
-
-	if (clk_div > QSPI_CLK_DIV_MAX) {
-		dev_dbg(qspi->dev, "clock divider >%d , using /%d divider\n",
-				QSPI_CLK_DIV_MAX, QSPI_CLK_DIV_MAX + 1);
-		return -EINVAL;
-	}
-
-	dev_dbg(qspi->dev, "hz: %d, clock divider %d\n",
-			qspi->spi_max_frequency, clk_div);
+	spi->max_speed_hz = min(spi->max_speed_hz, qspi->master->max_speed_hz);
 
 	ret = pm_runtime_get_sync(qspi->dev);
 	if (ret < 0) {
@@ -179,18 +160,6 @@ static int ti_qspi_setup(struct spi_device *spi)
 		return ret;
 	}
 
-	clk_ctrl_reg = ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
-
-	clk_ctrl_reg &= ~QSPI_CLK_EN;
-
-	/* disable SCLK */
-	ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
-
-	/* enable SCLK */
-	clk_mask = QSPI_CLK_EN | clk_div;
-	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
-	ctx_reg->clkctrl = clk_mask;
-
 	pm_runtime_mark_last_busy(qspi->dev);
 	ret = pm_runtime_put_autosuspend(qspi->dev);
 	if (ret < 0) {
@@ -201,6 +170,37 @@ static int ti_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
+{
+	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
+	int clk_div;
+	u32 clk_ctrl_reg, clk_rate, clk_ctrl_new;
+
+	clk_rate = clk_get_rate(qspi->fclk);
+	clk_div = DIV_ROUND_UP(clk_rate, speed_hz) - 1;
+	clk_div = clamp(clk_div, 0, QSPI_CLK_DIV_MAX);
+	dev_dbg(qspi->dev, "hz: %d, clock divider %d\n", speed_hz, clk_div);
+
+	pm_runtime_get_sync(qspi->dev);
+
+	clk_ctrl_new = QSPI_CLK_EN | clk_div;
+	if (ctx_reg->clkctrl != clk_ctrl_new) {
+		clk_ctrl_reg = ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
+
+		clk_ctrl_reg &= ~QSPI_CLK_EN;
+
+		/* disable SCLK */
+		ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
+
+		/* enable SCLK */
+		ti_qspi_write(qspi, clk_ctrl_new, QSPI_SPI_CLOCK_CNTRL_REG);
+		ctx_reg->clkctrl = clk_ctrl_new;
+	}
+
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+}
+
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 {
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
@@ -623,8 +623,10 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 	mutex_lock(&qspi->list_lock);
 
-	if (!qspi->mmap_enabled || qspi->current_cs != mem->spi->chip_select)
+	if (!qspi->mmap_enabled || qspi->current_cs != mem->spi->chip_select) {
+		ti_qspi_setup_clk(qspi, mem->spi->max_speed_hz);
 		ti_qspi_enable_memory_map(mem->spi);
+	}
 	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
 				op->addr.nbytes, op->dummy.nbytes);
 
@@ -701,6 +703,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 		wlen = t->bits_per_word >> 3;
 		transfer_len_words = min(t->len / wlen, frame_len_words);
 
+		ti_qspi_setup_clk(qspi, t->speed_hz);
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
@@ -851,7 +854,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
-		qspi->spi_max_frequency = max_freq;
+		master->max_speed_hz = max_freq;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-- 
2.30.2

