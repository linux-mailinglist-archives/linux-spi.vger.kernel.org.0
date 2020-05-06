Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF81C659D
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEFBlm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 21:41:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48881 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729515AbgEFBlm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 21:41:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DB70C5C0194;
        Tue,  5 May 2020 21:41:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 05 May 2020 21:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=6qof28feycOj7oXv4ybcTJHnjd
        qJ6zUx8IqfTWIbE1I=; b=UmLgQNSZr83RxSjsk/oMMVG/Fv6CFzYFJdYaKQN47X
        Qd6kBINKPkMQWIWeEI9vlKC+59gIcOeTJPxn0gNfplW6B+ClsMSGXNnSDsNb9Zej
        SolI1ozO5NsjzsIEwI7QyDi1gOKUZ6C6tVDOiaHxr/AqTwVRi8UsDOfk2PtanBnq
        vHMtCRIFOTISHTZ1iQZA73N8ltjsuMj0A2JaHkbGhXwI3qd5IopC9vX3ULvBq8MR
        9ZZUN+q+uoUyggGtgiquCi7YoVhMI3aBenOq/FYS72KzoxubMIk16R3uYXsv4mgk
        +YMG9p3i76Tf6hJVNM6RlmVvPG91Zd/RFaWZjtL/X8bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6qof28feycOj7oXv4
        ybcTJHnjdqJ6zUx8IqfTWIbE1I=; b=AyPqnU6ViPiTRpOqgOcOE1RV0vSeFzoM9
        jKdq1aIUyHJdIoA3GwkJjbGmc4zwXkajr+cJFhzmY8wbYn4FaONr2F6CphmULmby
        tYnwbwcY+UeBGZ0TcqrgngNVNe9rxqDJFwBtnu4pHYu4fPC2Iz1IvCufuWugOSya
        XR3+oHhMdGyySo4GDebg6VN4hnJWSRxkMhFJ2hNKDif3RnepE2uT/FwE0nVxGzGV
        XD3kaHZqdTuKwHITPDev5lGCDOQW11WRYXV6M7V3K2ziIuBmBW1EskclaaCnkwJw
        6mR/l95uv/0AiYoGOlT1y6SbGOxnC39aIeaUi9KpB//cXXGWt0mNA==
X-ME-Sender: <xms:0xWyXsPT0uG2QQMl9jHEXXyMfVI20Q4VaZYsi63d3viCF_CtmOUnAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeejgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecukfhppeejfedrleefrdek
    gedrvddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:0xWyXuGBRUnFQhOgMmRjyZhcfsDuCxFNsKogtavSyrqr3lIMQylUGg>
    <xmx:0xWyXoqNPqkFiEdaiO2r6QBDwKExGVom4AUAmqccAxgnV8WK4-bcTw>
    <xmx:0xWyXkj_SWp2zTAuTsccebd-EJ_F4LJkGsIbzg3U4LLRMMxUOOvYDQ>
    <xmx:1BWyXv4u30d07gof82_-xf0McKCXgyRolVH7-md8LZFcNNL0ylrd-g>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D3D630660F2;
        Tue,  5 May 2020 21:41:38 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] spi: sun6i: Add support for GPIO chip select lines
Date:   Tue,  5 May 2020 18:41:35 -0700
Message-Id: <20200506014135.2941967-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a setup function that can be used to support using generic GPIO
lines for the chip select.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/spi/spi-sun6i.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ec7967be9e2f..fd4e19434942 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -171,6 +172,31 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
 	}
 }
 
+static int sun6i_spi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	/* sanity check for native cs */
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+	if (gpio_is_valid(spi->cs_gpio)) {
+		/* with gpio-cs set the GPIO to the correct level
+		 * and as output (in case the dt has the gpio not configured
+		 * as output but native cs)
+		 */
+		ret = gpio_direction_output(spi->cs_gpio,
+					    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+		if (ret)
+			dev_err(&spi->dev,
+				"could not set gpio %i as output: %i\n",
+				spi->cs_gpio, ret);
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
@@ -470,6 +496,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
+	master->setup = sun6i_spi_setup;
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-- 
2.26.2

