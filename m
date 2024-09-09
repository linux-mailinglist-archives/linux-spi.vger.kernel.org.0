Return-Path: <linux-spi+bounces-4730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408CF9713CD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFC11F26A57
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6061B4C44;
	Mon,  9 Sep 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sWB8J+z2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEB1B3F3F;
	Mon,  9 Sep 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874299; cv=none; b=nmtdmHGTimfL2nEUmBlwLeq3l+PJ7LtiD9FnzuQRPIiAqbvxs+HualqURMHhGTXADp+Kk/SOAUUo40p1DB7Os/mr5TdeKBYjhm+70pmqgopu+XiYiLWJDEpAJTWpxiFaR577EBO8uAXSlRXl4JEaln/1C6hAq+WsIxdwhxT3HrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874299; c=relaxed/simple;
	bh=TsyW1TFBiD90rgjYgtjmliFN7Joc+FW2854FM3bo/Vg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKr6ajYy9/EGWM8984CbtYF4ysOg/IZCNd6b21hLz+OLncWXa/PRioreHlb2cFJcQtEp6367ncDDwgoDGkUcLpcwGK8tufPpy3FdzQBx7j8JPbHkc8jrit+GCBsJ3ao5jk5Ovsl/Qi4oUxoWymM/+H+tcoUAQPhTTIICojKpoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sWB8J+z2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4898XIlO029746;
	Mon, 9 Sep 2024 05:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=R/Y/R
	CqP6fEFi5qguj7p5UdxxCiZxW/C2oW7QtO1vvg=; b=sWB8J+z2hFbQ45u9EuPMq
	Xn1gPMimzbs9CS0fBnUdr7f1k28VeJuRsMN1Dtgx6YHiNFCeDndgv5aJflGnqPsF
	aI2s3RtVTEcdfl5W9NlYOQl6549sory94eR8liRc1i7Ydxs3YQDvxqLAVfKuDL7J
	r/H4EP9Nx5bEHufXIijOmj8gcTtAFIKPUePb3m36Xg2rVjuq3//todypLlY1x1NP
	6oNtaO4QmYzTvt6LSQCnF/3IbUg9sawHbPQca6N/t1qg0vA3KPd9ImP8LYk9lo8/
	po6is0C88aGP92bG+sa/R/KLVwDmOo28MnYu96pplQS1o6RPd/9wmwDpLdm+9awT
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41h55cbp0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4899VVLM004595
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Sep 2024 05:31:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 9 Sep 2024
 05:31:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 9 Sep 2024 05:31:31 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4899V8G1019340;
	Mon, 9 Sep 2024 05:31:23 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mark
 Brown <broonie@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 2/3] input: touchscreen: ad7877: add dt support
Date: Mon, 9 Sep 2024 12:30:12 +0300
Message-ID: <20240909093101.14113-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909093101.14113-1-antoniu.miclaus@analog.com>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3QcqUTIZq4A3S5Nqod_3O9008AQECdah
X-Proofpoint-ORIG-GUID: 3QcqUTIZq4A3S5Nqod_3O9008AQECdah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090075

Add devicetree support within the driver.

Remove old platform data approach since it is no longer used.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - remove platform data instead of making it optional, as suggested.
 - use touchscreen_parse_properties and touchscreen_report_pos
 drivers/input/touchscreen/ad7877.c | 150 +++++++++++++++++++++++------
 include/linux/spi/ad7877.h         |  25 -----
 2 files changed, 119 insertions(+), 56 deletions(-)
 delete mode 100644 include/linux/spi/ad7877.h

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 7886454a19c6..bb1799bcace3 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -25,11 +25,12 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ad7877.h>
 #include <linux/module.h>
 #include <asm/irq.h>
 
@@ -174,6 +175,8 @@ struct ad7877 {
 	u8			averaging;
 	u8			pen_down_acc_interval;
 
+	struct touchscreen_properties prop;
+
 	struct spi_transfer	xfer[AD7877_NR_SENSE + 2];
 	struct spi_message	msg;
 
@@ -353,8 +356,7 @@ static int ad7877_process_data(struct ad7877 *ts)
 		if (!timer_pending(&ts->timer))
 			input_report_key(input_dev, BTN_TOUCH, 1);
 
-		input_report_abs(input_dev, ABS_X, x);
-		input_report_abs(input_dev, ABS_Y, y);
+		touchscreen_report_pos(input_dev, &ts->prop, x, y, false);
 		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		input_sync(input_dev);
 
@@ -667,11 +669,118 @@ static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad7877 *ts)
 	}
 }
 
+static int ad7877_parse_props(struct ad7877 *ts)
+{
+	struct device *dev = &ts->spi->dev;
+	u32 value, average;
+	int ret;
+
+	ts->model = (uintptr_t)device_get_match_data(dev);
+	if (!ts->model)
+		ts->model = 7877;
+
+	ret = device_property_match_string(dev, "adi,stopacq-polarity", "low");
+	if (ret < 0) {
+		ret = device_property_match_string(dev, "adi,stopacq-polarity", "high");
+		if (ret < 0)
+			ts->stopacq_polarity = 0;
+		ts->stopacq_polarity = 1;
+	} else {
+		ts->stopacq_polarity = 0;
+	}
+
+	ret = device_property_read_u32(dev, "adi,first-conv-delay-ns", &value);
+	if (!ret) {
+		switch (value) {
+		case 500:
+			ts->first_conversion_delay = 0;
+			break;
+		case 128000:
+			ts->first_conversion_delay = 1;
+			break;
+		case 1000000:
+			ts->first_conversion_delay = 2;
+			break;
+		case 8000000:
+			ts->first_conversion_delay = 3;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					"Invalid adi,first-conv-delay-ns value\n");
+		}
+	}
+
+	device_property_read_u32(dev, "adi,pen-down-acc-interval",
+				 &value);
+	ts->pen_down_acc_interval = (u8)value;
+
+	ret = device_property_read_u32(dev, "adi,acquisition-time-us", &value);
+	if (!ret) {
+		switch (value) {
+		case 2:
+			ts->acquisition_time = 0;
+			break;
+		case 4:
+			ts->acquisition_time = 1;
+			break;
+		case 8:
+			ts->acquisition_time = 2;
+			break;
+		case 16:
+			ts->acquisition_time = 3;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					"Invalid adi,first-conv-delay-ns value\n");
+		}
+	}
+
+	device_property_read_u32(dev, "adi,vref-delay-us",
+				 &value);
+	if (!value)
+		ts->vref_delay_usecs = 100;
+	else
+		ts->vref_delay_usecs = (u16)value;
+
+	device_property_read_u32(dev, "touchscreen-x-plate-ohms", &value);
+	if (value)
+		ts->x_plate_ohms = (u16)value;
+	else
+		ts->x_plate_ohms = 400;
+
+	/*
+	 * The property is parsed also in the touchscreen_parse_properties()
+	 * but is required for the ad7877_process_data() so we need to store it.
+	 */
+	device_property_read_u32(dev, "touchscreen-max-pressure", &value);
+	ts->pressure_max = (u16)value;
+
+	device_property_read_u32(dev, "touchscreen-average-samples", &average);
+	switch (average) {
+	case 1:
+		ts->averaging = 0;
+		break;
+	case 4:
+		ts->averaging = 1;
+		break;
+	case 8:
+		ts->averaging = 2;
+		break;
+	case 16:
+		ts->averaging = 3;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "touchscreen-average-samples must be 1, 4, 8, or 16\n");
+	}
+
+	return 0;
+}
+
 static int ad7877_probe(struct spi_device *spi)
 {
 	struct ad7877			*ts;
 	struct input_dev		*input_dev;
-	struct ad7877_platform_data	*pdata = dev_get_platdata(&spi->dev);
 	int				err;
 	u16				verify;
 
@@ -680,11 +789,6 @@ static int ad7877_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
 		dev_dbg(&spi->dev, "SPI CLK %d Hz?\n",spi->max_speed_hz);
@@ -714,27 +818,22 @@ static int ad7877_probe(struct spi_device *spi)
 	ts->spi = spi;
 	ts->input = input_dev;
 
+	err = ad7877_parse_props(ts);
+	if (err)
+		return err;
+
 	timer_setup(&ts->timer, ad7877_timer, 0);
 	mutex_init(&ts->mutex);
 	spin_lock_init(&ts->lock);
 
-	ts->model = pdata->model ? : 7877;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->pressure_max = pdata->pressure_max ? : ~0;
-
-	ts->stopacq_polarity = pdata->stopacq_polarity;
-	ts->first_conversion_delay = pdata->first_conversion_delay;
-	ts->acquisition_time = pdata->acquisition_time;
-	ts->averaging = pdata->averaging;
-	ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
-
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
 
 	input_dev->name = "AD7877 Touchscreen";
 	input_dev->phys = ts->phys;
 	input_dev->dev.parent = &spi->dev;
 
+	touchscreen_parse_properties(ts->input, false, &ts->prop);
+
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(EV_ABS, input_dev->evbit);
@@ -742,17 +841,6 @@ static int ad7877_probe(struct spi_device *spi)
 	__set_bit(ABS_Y, input_dev->absbit);
 	__set_bit(ABS_PRESSURE, input_dev->absbit);
 
-	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
-
 	ad7877_write(spi, AD7877_REG_SEQ1, AD7877_MM_SEQUENCE);
 
 	verify = ad7877_read(spi, AD7877_REG_SEQ1);
diff --git a/include/linux/spi/ad7877.h b/include/linux/spi/ad7877.h
deleted file mode 100644
index b7be843c88e2..000000000000
--- a/include/linux/spi/ad7877.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* linux/spi/ad7877.h */
-
-/* Touchscreen characteristics vary between boards and models.  The
- * platform_data for the device's "struct device" holds this information.
- *
- * It's OK if the min/max values are zero.
- */
-struct ad7877_platform_data {
-	u16	model;			/* 7877 */
-	u16	vref_delay_usecs;	/* 0 for external vref; etc */
-	u16	x_plate_ohms;
-	u16	y_plate_ohms;
-
-	u16	x_min, x_max;
-	u16	y_min, y_max;
-	u16	pressure_min, pressure_max;
-
-	u8	stopacq_polarity;	/* 1 = Active HIGH, 0 = Active LOW */
-	u8	first_conversion_delay;	/* 0 = 0.5us, 1 = 128us, 2 = 1ms, 3 = 8ms */
-	u8	acquisition_time;	/* 0 = 2us, 1 = 4us, 2 = 8us, 3 = 16us */
-	u8	averaging;		/* 0 = 1, 1 = 4, 2 = 8, 3 = 16 */
-	u8	pen_down_acc_interval;	/* 0 = covert once, 1 = every 0.5 ms,
-					   2 = ever 1 ms,   3 = every 8 ms,*/
-};
-- 
2.46.0


