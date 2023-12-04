Return-Path: <linux-spi+bounces-130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE9803926
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E4E1C20A71
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190D2C84D;
	Mon,  4 Dec 2023 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dzewng9i"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C981A4;
	Mon,  4 Dec 2023 07:49:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2C621C0007;
	Mon,  4 Dec 2023 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701704955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uAGdgt+I/FApVPjEn+TtquabCiU9dNdphhb+6gwWsYw=;
	b=dzewng9i4EqrGrI7U26+ezMVs6x6/3s4jaXre8VgL/aTVNruO2zRawJbRcJgq4bV2tpo3l
	lfH36NHYMjJyoVacC4tRIgl65IihSn2+vTYHebeYlV8MW2ZDelu4DWmawec6qqEcFX/qmN
	37uZcdZD4PrEfjxnkuNNaEO0Lzleb/nKo+ZBU3Tzq6ENsZxtUw6sHh5AK8vhLF5/jzWrxK
	m6TpWlf/UIXGZQmC1Q8/SZTWghoXYhlbXCq/MOFB0oKTs8yRepdbyVPuQuZjl9PmUYfvmM
	F1XJVTvQbT+oN6WzrWmDZfFGzl4cow19HqYooS20St3ghZ+LDzB/PORnypv1nw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: ryan.wanner@microchip.com,
	broonie@kernel.org
Cc: thomas.petazzoni@bootlin.com,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	haavard.skinnemoen@atmel.com,
	akpm@linux-foundation.org,
	dbrownell@users.sourceforge.net,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: atmel: Fix clock issue when using devices with different polarities
Date: Mon,  4 Dec 2023 16:49:03 +0100
Message-ID: <20231204154903.11607-1-louis.chauvet@bootlin.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: louis.chauvet@bootlin.com

The current Atmel SPI controller driver (v2) behaves incorrectly when
using two SPI devices with different clock polarities and GPIO CS.

When switching from one device to another, the controller driver first
enables the CS and then applies whatever configuration suits the targeted
device (typically, the polarities). The side effect of such order is the
apparition of a spurious clock edge after enabling the CS when the clock
polarity needs to be inverted wrt. the previous configuration of the
controller.

This parasitic clock edge is problematic when the SPI device uses that edge
for internal processing, which is perfectly legitimate given that its CS
was asserted. Indeed, devices such as HVS8080 driven by driver gpio-sr in
the kernel are shift registers and will process this first clock edge to
perform a first register shift. In this case, the first bit gets lost and
the whole data block that will later be read by the kernel is all shifted
by one.

    Current behavior:
      The actual switching of the clock polarity only occurs after the CS
      when the controller sends the first message:

    CLK ------------\   /-\ /-\
                    |   | | | |    . . .
                    \---/ \-/ \
    CS  -----\
             |
             \------------------

             ^      ^   ^
             |      |   |
             |      |   Actual clock of the message sent
             |      |
             |      Change of clock polarity, which occurs with the first
             |      write to the bus. This edge occurs when the CS is
             |      already asserted, and can be interpreted as
             |      the first clock edge by the receiver.
             |
             GPIO CS toggle

This issue is specific to this controller because while the SPI core
performs the operations in the right order, the controller however does
not. In practice, the controller only applies the clock configuration right
before the first transmission.

So this is not a problem when using the controller's dedicated CS, as the
controller does things correctly, but it becomes a problem when you need to
change the clock polarity and use an external GPIO for the CS.

One possible approach to solve this problem is to send a dummy message
before actually activating the CS, so that the controller applies the clock
polarity beforehand.

New behavior:

CLK     ------\      /-\     /-\      /-\     /-\
              |      | | ... | |      | | ... | |
              \------/ \-   -/ \------/ \-   -/ \------

CS      -\/-----------------------\
         ||                       |
         \/                       \---------------------
         ^    ^       ^           ^    ^
         |    |       |           |    |
         |    |       |           |    Expected clock cycles when
         |    |       |           |    sending the message
         |    |       |           |
         |    |       |           Actual GPIO CS activation, occurs inside
         |    |       |           the driver
         |    |       |
         |    |       Dummy message, to trigger clock polarity
         |    |       reconfiguration. This message is not received and
         |    |       processed by the device because CS is low.
         |    |
         |    Change of clock polarity, forced by the dummy message. This
         |    time, the edge is not detected by the receiver.
         |
         This small spike in CS activation is due to the fact that the
         spi-core activates the CS gpio before calling the driver's
         set_cs callback, which deactivates this gpio again until the
         clock polarity is correct.

To avoid having to systematically send a dummy packet, the driver keeps
track of the clock's current polarity. In this way, it only sends the dummy
packet when necessary, ensuring that the clock will have the correct
polarity when the CS is toggled.

There could be two hardware problems with this patch:
1- Maybe the small CS activation peak can confuse SPI devices
2- If on a design, a single wire is used to select two devices depending
on its state, the dummy message may disturb them.

Fixes: 5ee36c989831 ("spi: atmel_spi update chipselect handling")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
A possible solution to avoid the small CS spike could be to hack the
spi core and swap the blocks managing the gpiod (spi.c:971-987) with the
one calling the set_cs callback (spi.c:989-991). This way, the controller
will send the dummy message before the CS is actually activated. This
solution may have side effects on other drivers; I don't know if there are
drivers depending on the current order.

We could also introduce a flag to limit this reordering to controller
drivers requesting it.
---
 drivers/spi/spi-atmel.c | 82 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6aa8adbe4170..23050ebb778a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -22,6 +22,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 #include <trace/events/spi.h>
 
 /* SPI register offsets */
@@ -279,6 +280,7 @@ struct atmel_spi {
 	bool			keep_cs;
 
 	u32			fifo_size;
+	bool			last_polarity;
 	u8			native_cs_free;
 	u8			native_cs_for_gpio;
 };
@@ -291,6 +293,22 @@ struct atmel_spi_device {
 #define SPI_MAX_DMA_XFER	65535 /* true for both PDC and DMA */
 #define INVALID_DMA_ADDRESS	0xffffffff
 
+/*
+ * This frequency can be anything supported by the controller, but to avoid
+ * unnecessary delay, the highest possible frequency is chosen.
+ *
+ * This frequency is the highest possible which is not interfering with other
+ * chip select registers (see Note for Serial Clock Bit Rate configuration in
+ * Atmel-11121F-ATARM-SAMA5D3-Series-Datasheet_02-Feb-16, page 1283)
+ */
+#define DUMMY_MSG_FREQUENCY	0x02
+/*
+ * 8 bits is the minimum data the controller is capable of sending.
+ *
+ * This message can be anything as it should not be treated by any SPI device.
+ */
+#define DUMMY_MSG		0xAA
+
 /*
  * Version 2 of the SPI controller has
  *  - CR.LASTXFER
@@ -304,6 +322,43 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
 	return as->caps.is_spi2;
 }
 
+/*
+ * Send a dummy message.
+ *
+ * This is sometimes needed when using a CS GPIO to force clock transition when
+ * switching between devices with different polarities.
+ */
+static void atmel_spi_send_dummy(struct atmel_spi *as, struct spi_device *spi, int chip_select)
+{
+	u32 status;
+	u32 csr;
+
+	/*
+	 * Set a clock frequency to allow sending message on SPI bus.
+	 * The frequency here can be anything, but is needed for
+	 * the controller to send the data.
+	 */
+	csr = spi_readl(as, CSR0 + 4 * chip_select);
+	csr = SPI_BFINS(SCBR, DUMMY_MSG_FREQUENCY, csr);
+	spi_writel(as, CSR0 + 4 * chip_select, csr);
+
+	/*
+	 * Read all data coming from SPI bus, needed to be able to send
+	 * the message.
+	 */
+	spi_readl(as, RDR);
+	while (spi_readl(as, SR) & SPI_BIT(RDRF)) {
+		spi_readl(as, RDR);
+		cpu_relax();
+	}
+
+	spi_writel(as, TDR, DUMMY_MSG);
+
+	readl_poll_timeout_atomic(as->regs + SPI_SR, status,
+				  (status & SPI_BIT(TXEMPTY)), 1, 1000);
+}
+
+
 /*
  * Earlier SPI controllers (e.g. on at91rm9200) have a design bug whereby
  * they assume that spi slave device state will not change on deselect, so
@@ -320,11 +375,17 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * Master on Chip Select 0.")  No workaround exists for that ... so for
  * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
  * and (c) will trigger that first erratum in some cases.
+ *
+ * When changing the clock polarity, the SPI controller waits for the next
+ * transmission to enforce the default clock state. This may be an issue when
+ * using a GPIO as Chip Select: the clock level is applied only when the first
+ * packet is sent, once the CS has already been asserted. The workaround is to
+ * avoid this by sending a first (dummy) message before toggling the CS state.
  */
-
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
 	struct atmel_spi_device *asd = spi->controller_state;
+	bool new_polarity;
 	int chip_select;
 	u32 mr;
 
@@ -353,6 +414,25 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
+
+		/*
+		 * Ensures the clock polarity is valid before we actually
+		 * assert the CS to avoid spurious clock edges to be
+		 * processed by the spi devices.
+		 */
+		if (spi_get_csgpiod(spi, 0)) {
+			new_polarity = (asd->csr & SPI_BIT(CPOL)) != 0;
+			if (new_polarity != as->last_polarity) {
+				/*
+				 * Need to disable the GPIO before sending the dummy
+				 * message because it is already set by the spi core.
+				 */
+				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), 0);
+				atmel_spi_send_dummy(as, spi, chip_select);
+				as->last_polarity = new_polarity;
+				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), 1);
+			}
+		}
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
-- 
2.41.0


