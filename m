Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAA4B4844
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 10:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiBNJxA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 14 Feb 2022 04:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbiBNJwH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 04:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0B567351;
        Mon, 14 Feb 2022 01:43:26 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E6xHvJ019148;
        Mon, 14 Feb 2022 09:42:55 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e71jvjy18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E9dnvj001480;
        Mon, 14 Feb 2022 09:42:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64h9kgmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E9goYJ32309750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 09:42:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3935EAE063;
        Mon, 14 Feb 2022 09:42:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9386BAE058;
        Mon, 14 Feb 2022 09:42:49 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 09:42:49 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.60.190])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 2EF672201DE;
        Mon, 14 Feb 2022 10:42:48 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 08/10] spi: aspeed: Calibrate read timings
Date:   Mon, 14 Feb 2022 10:42:29 +0100
Message-Id: <20220214094231.3753686-9-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c4xQS6wqhs9W4Phka2h_uKnU39BjKZZA
X-Proofpoint-GUID: c4xQS6wqhs9W4Phka2h_uKnU39BjKZZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1034 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

To accommodate the different response time of SPI transfers on different
boards and different SPI NOR devices, the Aspeed controllers provide a
set of Read Timing Compensation registers to tune the timing delays
depending on the frequency being used. The AST2600 SoC has one of
these registers per device. On the AST2500 and AST2400 SoCs, the
timing register is shared by all devices which is a bit problematic to
get good results other than for one device.

The algorithm first reads a golden buffer at low speed and then performs
reads with different clocks and delay cycle settings to find a breaking
point. This selects a default good frequency for the CEx control register.
The current settings are bit optimistic as we pick the first delay giving
good results. A safer approach would be to determine an interval and
choose the middle value.

Due to the lack of API, calibration is performed when the direct mapping
for reads is created.

Cc: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index e44e80bab50f..a08c20308404 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -35,6 +35,8 @@
 #define   CTRL_IO_ADDRESS_4B		BIT(13)	/* AST2400 SPI only */
 #define   CTRL_IO_DUMMY_SET(dummy)					\
 	(((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
+#define   CTRL_FREQ_SEL_SHIFT		8
+#define   CTRL_FREQ_SEL_MASK		GENMASK(11, CTRL_FREQ_SEL_SHIFT)
 #define   CTRL_CE_STOP_ACTIVE		BIT(2)
 #define   CTRL_IO_MODE_CMD_MASK		GENMASK(1, 0)
 #define   CTRL_IO_MODE_NORMAL		0x0
@@ -47,6 +49,9 @@
 /* CEx Address Decoding Range Register */
 #define CE0_SEGMENT_ADDR_REG		0x30
 
+/* CEx Read timing compensation register */
+#define CE0_TIMING_COMPENSATION_REG	0x94
+
 enum aspeed_spi_ctl_reg_value {
 	ASPEED_SPI_BASE,
 	ASPEED_SPI_READ,
@@ -72,10 +77,15 @@ struct aspeed_spi_data {
 	bool	hastype;
 	u32	mode_bits;
 	u32	we0;
+	u32	timing;
+	u32	hclk_mask;
+	u32	hdiv_max;
 
 	u32 (*segment_start)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_end)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_reg)(struct aspeed_spi *aspi, u32 start, u32 end);
+	int (*calibrate)(struct aspeed_spi_chip *chip, u32 hdiv,
+			 const u8 *golden_buf, u8 *test_buf);
 };
 
 #define ASPEED_SPI_MAX_NUM_CS	5
@@ -540,6 +550,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	return 0;
 }
 
+static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
+
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
@@ -588,6 +600,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
 	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
 
+	ret = aspeed_spi_do_calibration(chip);
+
 	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
 		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
 
@@ -869,6 +883,249 @@ static u32 aspeed_spi_segment_ast2600_reg(struct aspeed_spi *aspi,
 		((end - 1) & AST2600_SEG_ADDR_MASK);
 }
 
+/*
+ * Read timing compensation sequences
+ */
+
+#define CALIBRATE_BUF_SIZE SZ_16K
+
+static bool aspeed_spi_check_reads(struct aspeed_spi_chip *chip,
+				   const u8 *golden_buf, u8 *test_buf)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		memcpy_fromio(test_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
+		if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE) != 0) {
+#if defined(VERBOSE_DEBUG)
+			print_hex_dump_bytes(DEVICE_NAME "  fail: ", DUMP_PREFIX_NONE,
+					     test_buf, 0x100);
+#endif
+			return false;
+		}
+	}
+	return true;
+}
+
+#define FREAD_TPASS(i)	(((i) / 2) | (((i) & 1) ? 0 : 8))
+
+/*
+ * The timing register is shared by all devices. Only update for CE0.
+ */
+static int aspeed_spi_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
+				const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	const struct aspeed_spi_data *data = aspi->data;
+	int i;
+	int good_pass = -1, pass_count = 0;
+	u32 shift = (hdiv - 1) << 2;
+	u32 mask = ~(0xfu << shift);
+	u32 fread_timing_val = 0;
+
+	/* Try HCLK delay 0..5, each one with/without delay and look for a
+	 * good pair.
+	 */
+	for (i = 0; i < 12; i++) {
+		bool pass;
+
+		if (chip->cs == 0) {
+			fread_timing_val &= mask;
+			fread_timing_val |= FREAD_TPASS(i) << shift;
+			writel(fread_timing_val, aspi->regs + data->timing);
+		}
+		pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(aspi->dev,
+			"  * [%08x] %d HCLK delay, %dns DI delay : %s",
+			fread_timing_val, i / 2, (i & 1) ? 0 : 4,
+			pass ? "PASS" : "FAIL");
+		if (pass) {
+			pass_count++;
+			if (pass_count == 3) {
+				good_pass = i - 1;
+				break;
+			}
+		} else {
+			pass_count = 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	if (good_pass < 0)
+		return -1;
+
+	/* We have at least one pass of margin, let's use first pass */
+	if (chip->cs == 0) {
+		fread_timing_val &= mask;
+		fread_timing_val |= FREAD_TPASS(good_pass) << shift;
+		writel(fread_timing_val, aspi->regs + data->timing);
+	}
+	dev_dbg(aspi->dev, " * -> good is pass %d [0x%08x]",
+		good_pass, fread_timing_val);
+	return 0;
+}
+
+static bool aspeed_spi_check_calib_data(const u8 *test_buf, u32 size)
+{
+	const u32 *tb32 = (const u32 *)test_buf;
+	u32 i, cnt = 0;
+
+	/* We check if we have enough words that are neither all 0
+	 * nor all 1's so the calibration can be considered valid.
+	 *
+	 * I use an arbitrary threshold for now of 64
+	 */
+	size >>= 2;
+	for (i = 0; i < size; i++) {
+		if (tb32[i] != 0 && tb32[i] != 0xffffffff)
+			cnt++;
+	}
+	return cnt >= 64;
+}
+
+static const u32 aspeed_spi_hclk_divs[] = {
+	0xf, /* HCLK */
+	0x7, /* HCLK/2 */
+	0xe, /* HCLK/3 */
+	0x6, /* HCLK/4 */
+	0xd, /* HCLK/5 */
+};
+
+#define ASPEED_SPI_HCLK_DIV(i) \
+	(aspeed_spi_hclk_divs[(i) - 1] << CTRL_FREQ_SEL_SHIFT)
+
+static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	const struct aspeed_spi_data *data = aspi->data;
+	u32 ahb_freq = aspi->clk_freq;
+	u32 max_freq = chip->clk_freq;
+	u32 ctl_val;
+	u8 *golden_buf = NULL;
+	u8 *test_buf = NULL;
+	int i, rc, best_div = -1;
+
+	dev_dbg(aspi->dev, "calculate timing compensation - AHB freq: %d MHz",
+		ahb_freq / 1000000);
+
+	/*
+	 * use the related low frequency to get check calibration data
+	 * and get golden data.
+	 */
+	ctl_val = chip->ctl_val[ASPEED_SPI_READ] & data->hclk_mask;
+	writel(ctl_val, chip->ctl);
+
+	test_buf = kzalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
+	if (!test_buf)
+		return -ENOMEM;
+
+	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
+
+	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
+	if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
+		dev_info(aspi->dev, "Calibration area too uniform, using low speed");
+		goto no_calib;
+	}
+
+#if defined(VERBOSE_DEBUG)
+	print_hex_dump_bytes(DEVICE_NAME "  good: ", DUMP_PREFIX_NONE,
+			     golden_buf, 0x100);
+#endif
+
+	/* Now we iterate the HCLK dividers until we find our breaking point */
+	for (i = ARRAY_SIZE(aspeed_spi_hclk_divs); i > data->hdiv_max - 1; i--) {
+		u32 tv, freq;
+
+		freq = ahb_freq / i;
+		if (freq > max_freq)
+			continue;
+
+		/* Set the timing */
+		tv = chip->ctl_val[ASPEED_SPI_READ] | ASPEED_SPI_HCLK_DIV(i);
+		writel(tv, chip->ctl);
+		dev_dbg(aspi->dev, "Trying HCLK/%d [%08x] ...", i, tv);
+		rc = data->calibrate(chip, i, golden_buf, test_buf);
+		if (rc == 0)
+			best_div = i;
+	}
+
+	/* Nothing found ? */
+	if (best_div < 0) {
+		dev_warn(aspi->dev, "No good frequency, using dumb slow");
+	} else {
+		dev_dbg(aspi->dev, "Found good read timings at HCLK/%d", best_div);
+
+		/* Record the freq */
+		for (i = 0; i < ASPEED_SPI_MAX; i++)
+			chip->ctl_val[i] = (chip->ctl_val[i] & data->hclk_mask) |
+				ASPEED_SPI_HCLK_DIV(best_div);
+	}
+
+no_calib:
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+	kfree(test_buf);
+	return 0;
+}
+
+#define TIMING_DELAY_DI		BIT(3)
+#define TIMING_DELAY_HCYCLE_MAX	5
+#define TIMING_REG_AST2600(chip)				\
+	((chip)->aspi->regs + (chip)->aspi->data->timing +	\
+	 (chip)->cs * 4)
+
+static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
+					const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	int hcycle;
+	u32 shift = (hdiv - 2) << 3;
+	u32 mask = ~(0xfu << shift);
+	u32 fread_timing_val = 0;
+
+	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
+		int delay_ns;
+		bool pass = false;
+
+		fread_timing_val &= mask;
+		fread_timing_val |= hcycle << shift;
+
+		/* no DI input delay first  */
+		writel(fread_timing_val, TIMING_REG_AST2600(chip));
+		pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(aspi->dev,
+			"  * [%08x] %d HCLK delay, DI delay none : %s",
+			fread_timing_val, hcycle, pass ? "PASS" : "FAIL");
+		if (pass)
+			return 0;
+
+		/* Add DI input delays  */
+		fread_timing_val &= mask;
+		fread_timing_val |= (TIMING_DELAY_DI | hcycle) << shift;
+
+		for (delay_ns = 0; delay_ns < 0x10; delay_ns++) {
+			fread_timing_val &= ~(0xf << (4 + shift));
+			fread_timing_val |= delay_ns << (4 + shift);
+
+			writel(fread_timing_val, TIMING_REG_AST2600(chip));
+			pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+			dev_dbg(aspi->dev,
+				"  * [%08x] %d HCLK delay, DI delay %d.%dns : %s",
+				fread_timing_val, hcycle, (delay_ns + 1) / 2,
+				(delay_ns + 1) & 1 ? 5 : 5, pass ? "PASS" : "FAIL");
+			/*
+			 * TODO: This is optimistic. We should look
+			 * for a working interval and save the middle
+			 * value in the read timing register.
+			 */
+			if (pass)
+				return 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	return -1;
+}
+
 /*
  * Platform definitions
  */
@@ -877,6 +1134,10 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
 	.hastype       = true,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -887,6 +1148,10 @@ static const struct aspeed_spi_data ast2400_spi_data = {
 	.hastype       = false,
 	.we0	       = 0,
 	.ctl0	       = 0x04,
+	.timing	       = 0x14,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	/* No segment registers */
 };
 
@@ -895,6 +1160,10 @@ static const struct aspeed_spi_data ast2500_fmc_data = {
 	.hastype       = true,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -905,6 +1174,10 @@ static const struct aspeed_spi_data ast2500_spi_data = {
 	.hastype       = false,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -916,6 +1189,10 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
 	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
 	.segment_reg   = aspeed_spi_segment_ast2600_reg,
@@ -927,6 +1204,10 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
 	.segment_reg   = aspeed_spi_segment_ast2600_reg,
-- 
2.34.1

