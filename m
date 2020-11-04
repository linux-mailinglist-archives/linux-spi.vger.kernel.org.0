Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C032A67CA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgKDPfi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbgKDPfh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Nov 2020 10:35:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24135C040203
        for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2020 07:35:36 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kaKos-0004O4-79; Wed, 04 Nov 2020 16:35:30 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kaKor-0006cL-I2; Wed, 04 Nov 2020 16:35:29 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v1 1/2] Input: ads7846: convert to full duplex
Date:   Wed,  4 Nov 2020 16:35:27 +0100
Message-Id: <20201104153528.25362-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104153528.25362-1-o.rempel@pengutronix.de>
References: <20201104153528.25362-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Starting with following patch, the ads7845 was partially converted to
full duplex mode:
3eac5c7e44f3 Input: ads7846 - extend the driver for ads7845 controller support

Since it is not touchscreen controller specific, it is better to make
this conversion consequent for complete driver. This will reduce CPU
load and make driver more readable.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/input/touchscreen/ads7846.c | 193 +++++++++-------------------
 1 file changed, 62 insertions(+), 131 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 393ab337a9c4..e9a520c9ad69 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -62,19 +62,25 @@
 /* this driver doesn't aim at the peak continuous sample rate */
 #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
 
-struct ts_event {
-	/*
-	 * For portability, we can't read 12 bit values using SPI (which
-	 * would make the controller deliver them as native byte order u16
-	 * with msbs zeroed).  Instead, we read them as two 8-bit values,
-	 * *** WHICH NEED BYTESWAPPING *** and range adjustment.
+struct ads7846_buf {
+	u8 cmd;
+	/* This union is a temporary hack. The driver does an in-place
+	 * endianness conversion. This will be cleaned up in the next
+	 * patch.
 	 */
-	u16	x;
-	u16	y;
-	u16	z1, z2;
-	bool	ignore;
-	u8	x_buf[3];
-	u8	y_buf[3];
+	union {
+		__be16 data_be16;
+		u16 data;
+	};
+} __attribute__((__packed__));
+
+
+struct ts_event {
+	bool ignore;
+	struct ads7846_buf x;
+	struct ads7846_buf y;
+	struct ads7846_buf z1;
+	struct ads7846_buf z2;
 };
 
 /*
@@ -83,11 +89,12 @@ struct ts_event {
  * systems where main memory is not DMA-coherent (most non-x86 boards).
  */
 struct ads7846_packet {
-	u8			read_x, read_y, read_z1, read_z2, pwrdown;
-	u16			dummy;		/* for the pwrdown read */
-	struct ts_event		tc;
-	/* for ads7845 with mpc5121 psc spi we use 3-byte buffers */
-	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
+	struct ts_event tc;
+	struct ads7846_buf read_x_cmd;
+	struct ads7846_buf read_y_cmd;
+	struct ads7846_buf read_z1_cmd;
+	struct ads7846_buf read_z2_cmd;
+	struct ads7846_buf pwrdown_cmd;
 };
 
 struct ads7846 {
@@ -694,16 +701,9 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 	int value;
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+	struct ads7846_buf *buf = t->rx_buf;
 
-	if (ts->model == 7845) {
-		value = be16_to_cpup((__be16 *)&(((char *)t->rx_buf)[1]));
-	} else {
-		/*
-		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
-		 * padding; built from two 8 bit values written msb-first.
-		 */
-		value = be16_to_cpup((__be16 *)t->rx_buf);
-	}
+	value = be16_to_cpup(&buf->data_be16);
 
 	/* enforce ADC output is 12 bits width */
 	return (value >> 3) & 0xfff;
@@ -713,8 +713,9 @@ static void ads7846_update_value(struct spi_message *m, int val)
 {
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+	struct ads7846_buf *buf = t->rx_buf;
 
-	*(u16 *)t->rx_buf = val;
+	buf->data = val;
 }
 
 static void ads7846_read_state(struct ads7846 *ts)
@@ -782,16 +783,14 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * from on-the-wire format as part of debouncing to get stable
 	 * readings.
 	 */
+	x = packet->tc.x.data;
+	y = packet->tc.y.data;
 	if (ts->model == 7845) {
-		x = *(u16 *)packet->tc.x_buf;
-		y = *(u16 *)packet->tc.y_buf;
 		z1 = 0;
 		z2 = 0;
 	} else {
-		x = packet->tc.x;
-		y = packet->tc.y;
-		z1 = packet->tc.z1;
-		z2 = packet->tc.z2;
+		z1 = packet->tc.z1.data;
+		z2 = packet->tc.z2.data;
 	}
 
 	/* range filtering */
@@ -1008,26 +1007,11 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		packet->read_y_cmd[0] = READ_Y(vref);
-		packet->read_y_cmd[1] = 0;
-		packet->read_y_cmd[2] = 0;
-		x->tx_buf = &packet->read_y_cmd[0];
-		x->rx_buf = &packet->tc.y_buf[0];
-		x->len = 3;
-		spi_message_add_tail(x, m);
-	} else {
-		/* y- still on; turn on only y+ (and ADC) */
-		packet->read_y = READ_Y(vref);
-		x->tx_buf = &packet->read_y;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
-		x->rx_buf = &packet->tc.y;
-		x->len = 2;
-		spi_message_add_tail(x, m);
-	}
+	packet->read_y_cmd.cmd = READ_Y(vref);
+	x->tx_buf = &packet->read_y_cmd;
+	x->rx_buf = &packet->tc.y;
+	x->len = 3;
+	spi_message_add_tail(x, m);
 
 	/*
 	 * The first sample after switching drivers can be low quality;
@@ -1037,15 +1021,11 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	if (pdata->settle_delay_usecs) {
 		x->delay.value = pdata->settle_delay_usecs;
 		x->delay.unit = SPI_DELAY_UNIT_USECS;
-
 		x++;
-		x->tx_buf = &packet->read_y;
-		x->len = 1;
-		spi_message_add_tail(x, m);
 
-		x++;
+		x->tx_buf = &packet->read_y_cmd;
 		x->rx_buf = &packet->tc.y;
-		x->len = 2;
+		x->len = 3;
 		spi_message_add_tail(x, m);
 	}
 
@@ -1054,28 +1034,13 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		x++;
-		packet->read_x_cmd[0] = READ_X(vref);
-		packet->read_x_cmd[1] = 0;
-		packet->read_x_cmd[2] = 0;
-		x->tx_buf = &packet->read_x_cmd[0];
-		x->rx_buf = &packet->tc.x_buf[0];
-		x->len = 3;
-		spi_message_add_tail(x, m);
-	} else {
-		/* turn y- off, x+ on, then leave in lowpower */
-		x++;
-		packet->read_x = READ_X(vref);
-		x->tx_buf = &packet->read_x;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
-		x->rx_buf = &packet->tc.x;
-		x->len = 2;
-		spi_message_add_tail(x, m);
-	}
+	/* turn y- off, x+ on, then leave in lowpower */
+	x++;
+	packet->read_x_cmd.cmd = READ_X(vref);
+	x->tx_buf = &packet->read_x_cmd;
+	x->rx_buf = &packet->tc.x;
+	x->len = 3;
+	spi_message_add_tail(x, m);
 
 	/* ... maybe discard first sample ... */
 	if (pdata->settle_delay_usecs) {
@@ -1083,13 +1048,9 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 		x->delay.unit = SPI_DELAY_UNIT_USECS;
 
 		x++;
-		x->tx_buf = &packet->read_x;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
+		x->tx_buf = &packet->read_x_cmd;
 		x->rx_buf = &packet->tc.x;
-		x->len = 2;
+		x->len = 3;
 		spi_message_add_tail(x, m);
 	}
 
@@ -1101,14 +1062,10 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 		m->context = ts;
 
 		x++;
-		packet->read_z1 = READ_Z1(vref);
-		x->tx_buf = &packet->read_z1;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
+		packet->read_z1_cmd.cmd = READ_Z1(vref);
+		x->tx_buf = &packet->read_z1_cmd;
 		x->rx_buf = &packet->tc.z1;
-		x->len = 2;
+		x->len = 3;
 		spi_message_add_tail(x, m);
 
 		/* ... maybe discard first sample ... */
@@ -1117,13 +1074,9 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 			x->delay.unit = SPI_DELAY_UNIT_USECS;
 
 			x++;
-			x->tx_buf = &packet->read_z1;
-			x->len = 1;
-			spi_message_add_tail(x, m);
-
-			x++;
+			x->tx_buf = &packet->read_z1_cmd;
 			x->rx_buf = &packet->tc.z1;
-			x->len = 2;
+			x->len = 3;
 			spi_message_add_tail(x, m);
 		}
 
@@ -1133,14 +1086,10 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 		m->context = ts;
 
 		x++;
-		packet->read_z2 = READ_Z2(vref);
-		x->tx_buf = &packet->read_z2;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
+		packet->read_z2_cmd.cmd = READ_Z2(vref);
+		x->tx_buf = &packet->read_z2_cmd;
 		x->rx_buf = &packet->tc.z2;
-		x->len = 2;
+		x->len = 3;
 		spi_message_add_tail(x, m);
 
 		/* ... maybe discard first sample ... */
@@ -1149,13 +1098,9 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 			x->delay.unit = SPI_DELAY_UNIT_USECS;
 
 			x++;
-			x->tx_buf = &packet->read_z2;
-			x->len = 1;
-			spi_message_add_tail(x, m);
-
-			x++;
+			x->tx_buf = &packet->read_z2_cmd;
 			x->rx_buf = &packet->tc.z2;
-			x->len = 2;
+			x->len = 3;
 			spi_message_add_tail(x, m);
 		}
 	}
@@ -1166,24 +1111,10 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		x++;
-		packet->pwrdown_cmd[0] = PWRDOWN;
-		packet->pwrdown_cmd[1] = 0;
-		packet->pwrdown_cmd[2] = 0;
-		x->tx_buf = &packet->pwrdown_cmd[0];
-		x->len = 3;
-	} else {
-		x++;
-		packet->pwrdown = PWRDOWN;
-		x->tx_buf = &packet->pwrdown;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
-		x->rx_buf = &packet->dummy;
-		x->len = 2;
-	}
+	x++;
+	packet->pwrdown_cmd.cmd = PWRDOWN;
+	x->tx_buf = &packet->pwrdown_cmd;
+	x->len = 3;
 
 	CS_CHANGE(*x);
 	spi_message_add_tail(x, m);
-- 
2.28.0

