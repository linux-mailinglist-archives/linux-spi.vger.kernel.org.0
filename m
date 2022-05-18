Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23C52C7E3
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiERXqN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 May 2022 19:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiERXqJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 May 2022 19:46:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2081.outbound.protection.outlook.com [40.107.114.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1351836B
        for <linux-spi@vger.kernel.org>; Wed, 18 May 2022 16:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGi2fATSWzMraXCWmGbx9BaJgyn0Bj1I2Q1xRutfoOnbmnRDkMXoib8t9Jefzo1sPnn5xwaOUz5itbcCnuuFGMkUZGiHpyPdoCYpGtQkQyzW/bcmDhA2GMKG1K26QayqyVEuieRX9QwSNCjZMuPFWYYtAZxYXflnp6FwZfYA7yIROrXctDSDVgYHCGv31BQGvmViL1YBmNWgbuFu2ut79RVKMY+1y2xkIDiR9A81DozXu8M8rfhqCx5UslQi6Y+SDEXu0MKvpclyNjvOkgweZkmYbluY001TfBOokjEWHjmpNCm+atj1BdQSjbMTO0eUPMqD8tFuo6VEFzqs6JLcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuY+Yh+orEktOnEv2O26AujRUeUO31j6OZF3lljocmA=;
 b=dVqJEkju2LMJu5m6KYbQNd5nSysh2oTZ9djtUDYMuNhuI5SGv28+SbhPBJTnBU1yB7w/Y+yZbrqD0S0Z5ek0OLGqeH7lKzPju8HsbIyslMr0yOtr/eKwTmhvd7e8zJz6UxTFSWcBzNodiFrNTy9FWWm7aA+Rpdx8aShpjBdVC1GmBYUZBInL7BR2qLBXdljVcSLgScJOyz1XWY83jCDY32Tuc/vS/e2hwwTBPBUfF75lX15uhcIlYsjqYhxyWN73GCNGE9tcwK+kpRoo2U/ULTZq4lBKiL7qE76pngfmMTsWAQRw6VP33aQjfk++VPcH75gaEDC3CGqRJ+TZxsKfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuY+Yh+orEktOnEv2O26AujRUeUO31j6OZF3lljocmA=;
 b=TKMfO2Ld/SGzJwsaEs5U1Yck6C77wni8Bil+9Plxz6/2QS1IlZqPkk9xQJXCrHKxALRY6IZzIkajBLWA3HR7URKiG7ep2BFkIrOzEpszNhI90xc0EY3uRua+O/55LwJWuHKC8Z/XJx+evxtuuMG1RnZX5YOETa8KXCmT+AC2Omg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB10342.jpnprd01.prod.outlook.com (2603:1096:604:1fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 23:46:05 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::454a:4886:9e9e:aca0]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::454a:4886:9e9e:aca0%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 23:46:05 +0000
Date:   Thu, 19 May 2022 08:46:04 +0900 (JST)
Message-Id: <20220519.084604.966119051165023533.atsushi.nemoto@sord.co.jp>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2] spi: spi-ti-qspi: Support per-transfer and per-slave
 speed_hz settings
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.8 on Emacs 27.1
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:1::15) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fbca791-7646-40d6-1987-08da392892f5
X-MS-TrafficTypeDiagnostic: OS3PR01MB10342:EE_
X-Microsoft-Antispam-PRVS: <OS3PR01MB10342E14B68A06A84CBA6457EBBD19@OS3PR01MB10342.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wl2P+S3rlW9dPze5XkG+tz3kPtwv2r3C8lU3lFX13Mr/lD7Uj7r1NHWfWhqEwJHx1g5YZw7sNnJnWeqnRkAgTrWv1+L+yXjRuAaQfR+tETBjEwuDd5jcHbKZZa54fV1MMFPeX+Kzwsyg7RXo/dhiqSz9DbHYrV+hqMU6altybnt5/tBdA+KWwA0hkT5WqPP8bvpZLJD/EUotLMCQdJm3GGcFVYXaS0/4U1JfXZKZjVrekQ486uC5BFY/eSJfiTECztfrrjiH8pTWKGunYSMvnYo8WHgNkvl83davy9Rw1Er80kVPM7q9Jo0cMRyRoXDeprkJV8Wm+BXhLYSHymPjH30VRvpEhdCyJ2sgIG2bvEv54AWGoSh2qaKCOObSgC6fRFHWJ3sTIELuNeGLOSKr0JkDrV7vkcIav3HpLm4r5b3ZYNT48QxFtpuJJ0D4PuCNROoFME4p7lGmJU1+lj9M/mkjUdbInwunx54yxmAL2MlYa1LaBZVfVgAW6G+uSVoQaKCWOndwri2FWwtm0dlZcvW092BxzMm03hjD+ZZWj3H8Jxr3OjHaaPJHfsEPcw9BSccsF2wnllV406OK45o59Rfr1JIovJ7PoiOMWqQgoOlKVg/MHkCF7tswAA4+5i1jbQXYN4gl/bLuEkRJ35FjuGRWJSdb465oa6ryuK+fE+YYAGImdisufeQxO8+76JM8QsiQ4gJYTq2KkRIIg0olmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66946007)(103116003)(6512007)(8936002)(5660300002)(6486002)(83380400001)(4326008)(44832011)(508600001)(8676002)(26005)(36756003)(6916009)(316002)(54906003)(38350700002)(38100700002)(52116002)(186003)(2906002)(6506007)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mO3rXeI59+/bkTMnTcfyy4mNq0zHx1Ln9ZV0xl2Y8Y7YyvNqRjY4Tx9OGjrx?=
 =?us-ascii?Q?nQFV9f7RSk8PI6X8VYeF4YLACxFEgoq9ujiYZh4IbTrZyWpASScv9D7LfKS4?=
 =?us-ascii?Q?fa5O3rp20YS2N6ymq6Juxp8+QWqgHdkY1Nfwws9Oi/zni9hhQYBva3InyZso?=
 =?us-ascii?Q?zoNt0S+bm4nR2sX/11KO5LcgzceXahBJVWfMSzV7wXbRS6/5MXTOpKmcfI3Q?=
 =?us-ascii?Q?zhPx1umLOFZ8Thh4LFXDF9zrdFQ0YDGaBd+EX5eBtegi46/hsHGxNn5Fvjwp?=
 =?us-ascii?Q?XRdtgm6Or+LnHv+IJLhAwnJS6I7WRjarRaq4MqAQxjk+H1i5zzfnV4/jlNhJ?=
 =?us-ascii?Q?qDuVjqSG+FJltPSYCvYv4TCLzrcMi8uAU+FBLk70QEOni9Dy9wbs3S+zwkFu?=
 =?us-ascii?Q?9Jx9rUXgou3JHsNt2+SdzrkP6IZPMqy0cGcnPAK6y7DQVDajt+DAY7cYEnxL?=
 =?us-ascii?Q?KLJp4XDqJW6S9+9Kk94xAveMN3sYLPa3o0i3sIYt1rYhXC03+BbzfKfgICT1?=
 =?us-ascii?Q?IjrAscD7y4KJTvKD9zFD5lr/d1GRpfZ5VSjntLrBUvHCezW10qKlNd64u/mt?=
 =?us-ascii?Q?UL3OAQpkn2hOcoLc8vd1G5dDrf2XyyQaV1TZN/CrMIJN2okY0XoCTCJVs9qx?=
 =?us-ascii?Q?/xmUjh0mOlQ7iFzIcKXDiwIuneNvGprgetr6XRfNutwWXin9MAmhkO753tBy?=
 =?us-ascii?Q?CBPBCTj9dUUFm7z+DR/f++2iTxfH+fmpWVB45EjSfmm+zhJiKZJhQPSH4kM6?=
 =?us-ascii?Q?i+RnfTgmThkdSFtLtFxxlqw8TqSRtBI0qxvWw8r1jrGJTzprHe0vvgmh1cV1?=
 =?us-ascii?Q?PUpDrpdWnh+tJOUFkhn+G44QLaBKwCESQ3c1bMvIppCmcz0+2yffeM+X5G3I?=
 =?us-ascii?Q?FmVHNdorsEpa8siyUya7EIF42bMeakusv2yTnscCfBKvQHjQq6myiMOvkjtI?=
 =?us-ascii?Q?jtKGt5AYg6aZuaMEJ2Xqos/WCIGm3ESSTCgiZZyUEp8p7HB1GgWVR2t0A5U2?=
 =?us-ascii?Q?14xMTztifyiM84XgoKTyXxNIaJk8Trg+Fz5ibhXcGz++S9h5YI//jLPNukhI?=
 =?us-ascii?Q?YyqpJhzDTTASNBWYi7i2GK9JUiari2eJxl0yz0ppVCPaIsV/jW8asCOtEAyj?=
 =?us-ascii?Q?zwEd66YP9LylNoyJnxTftn80RbaszO2m73e67QV5iCL8xMV/bdmFBvbvyBx4?=
 =?us-ascii?Q?iIiKeJapYaC3QE1qE0UqmIZ76ldJwru+Z9z8OCqj87UtjI8a1EObp/yu745x?=
 =?us-ascii?Q?8HlpusxGR6cXll/vFfqTBD3wPn0b3R4NIVXVvYpJDK2TXgr1w4WCRJ5AjlbF?=
 =?us-ascii?Q?nx4YNCrqPLlxSyAcsCriRbsyqBoNu7UAaDXkHqBAsPvZeM/Kpsm7tMGB0bB2?=
 =?us-ascii?Q?PpthQgkQpdWeh+qPuTvOdSbQ8xhNqCjIV1xKQaoFDqYAoNZjIG9yNLO9tYoQ?=
 =?us-ascii?Q?st7RiB9fjaySufwSukbHnowRJXenBpYwI/qsnPI5kECtDgS1jS8qb1VQzE9k?=
 =?us-ascii?Q?7t7F082tFQZ4Za9O31BCGm7j0ReyYErgpaooB7UdPvPSTIDZgLhZT/ND5R0w?=
 =?us-ascii?Q?4eQWX/fUfRot+lzQSo9ggwVXKFWpcA9VARi6Fk4cgKIVh3PsP5E9iu/uEg04?=
 =?us-ascii?Q?SXx/VdWue9i+P2D4nWQgIqrobVrk+plXtBTDFr3FVaUDE0wKSe/slvTHEcok?=
 =?us-ascii?Q?GBPGeflI5l+lvvW5e/EH12lf2kcKb1Lyq/be24NABKkDbQMg+pm/HMSAKfod?=
 =?us-ascii?Q?vSYB7FsSjlgPP3FowL4Njne2SrLYQHw=3D?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbca791-7646-40d6-1987-08da392892f5
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 23:46:05.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkUQFWJ/4E+8AgfwfEKNyNSuUNE5sakoY/rLk6p/ptI+is+b0JFWvdugkYy3+aocdV6W8Ej6WnNbrqOpdwvshj6I4mFFVZYrrB1sXZzksl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10342
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
Changes from v1:
 - rebase against broonie/spi.git for-next branch
 - use pm_runtime_resume_and_get instead of pm_runtime_get_sync

 drivers/spi/spi-ti-qspi.c | 75 ++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index b5b65d882d7a..60086869bcae 100644
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
 
 	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0) {
@@ -178,18 +159,6 @@ static int ti_qspi_setup(struct spi_device *spi)
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
@@ -200,6 +169,37 @@ static int ti_qspi_setup(struct spi_device *spi)
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
+	pm_runtime_resume_and_get(qspi->dev);
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

