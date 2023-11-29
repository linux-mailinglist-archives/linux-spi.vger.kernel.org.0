Return-Path: <linux-spi+bounces-98-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C77FDD0E
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088241F20FA7
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FD35888;
	Wed, 29 Nov 2023 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1bQ8XuE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOCVYsOv"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FC10A;
	Wed, 29 Nov 2023 08:32:30 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701275548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTLB0ThBnn/pS6UUkx2HH5EKbiVm5lM2rnyIrBkr1Jo=;
	b=H1bQ8XuEF942xI+G9ZqJRqKQ3B2FFQApYvp6F4ALDrqkxG9HVD4bb+/74X3Ww1FrjOjdqS
	5tkCduWI8+MYUw8G53XpUJqrI6p0+Zk9wew+pkXZdROi/EiOHjn47vYifynqiXiKPQS1DH
	tR/kn23pB+uvYzG/TSrfhr/zSnTOOQyuBmXR5euAPDpOvpsT8+qMJK4Ar2UUSCUiRv7m6Y
	tie5qXYC5LZhZ0xDsc8MsNYeG40v1LCpuC/FaSnXkD5cwxndGFRKbHaVTvRrjyd+wZuA09
	4wSpbyYaW5QUATAHyyX/tsoWP4ZAjWAYn4xJ+cssyXMDwH6GTXXpv/bJx+OjDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701275548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTLB0ThBnn/pS6UUkx2HH5EKbiVm5lM2rnyIrBkr1Jo=;
	b=sOCVYsOvhKSU1/uBKMPHkYKPx/vPtJ9O6KFYns8bQZW93oRsaP3z/ZXWLZVOdRpUVr9sCA
	+pT7cslBTCqhq2Ag==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
Date: Wed, 29 Nov 2023 17:31:55 +0100
Message-Id: <4b420dac528e60f122adde16851da88e4798c1ea.1701274975.git.namcao@linutronix.de>
In-Reply-To: <cover.1701274975.git.namcao@linutronix.de>
References: <cover.1701274975.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default message transfer implementation - spi_transfer_one_message -
invokes the specific device driver's transfer_one(), then waits for
completion. However, there is no mechanism for the device driver to
report failure in the middle of the transfer.

Introduce SPI_TRANS_FAIL_IO for drivers to report transfer failure.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: add document for this new flag

 drivers/spi/spi.c       |  3 +++
 include/linux/spi/spi.h | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8ead7acb99f3..a4b8c07c5951 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1361,6 +1361,9 @@ static int spi_transfer_wait(struct spi_controller *c=
tlr,
 				"SPI transfer timed out\n");
 			return -ETIMEDOUT;
 		}
+
+		if (xfer->error & SPI_TRANS_FAIL_IO)
+			return -EIO;
 	}
=20
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7b4baff63c5c..5d65a6273dcf 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -461,10 +461,13 @@ extern struct spi_device *spi_new_ancillary_device(st=
ruct spi_device *spi, u8 ch
  *                  - return 1 if the transfer is still in progress. When
  *                    the driver is finished with this transfer it must
  *                    call spi_finalize_current_transfer() so the subsystem
- *                    can issue the next transfer. Note: transfer_one and
- *                    transfer_one_message are mutually exclusive; when bo=
th
- *                    are set, the generic subsystem does not call your
- *                    transfer_one callback.
+ *                    can issue the next transfer. If the transfer fails, =
the
+ *                    driver must set the flag SPI_TRANS_FAIL_IO to
+ *                    spi_transfer->error first, before calling
+ *                    spi_finalize_current_transfer().
+ *                    Note: transfer_one and transfer_one_message are mutu=
ally
+ *                    exclusive; when both are set, the generic subsystem =
does
+ *                    not call your transfer_one callback.
  * @handle_err: the subsystem calls the driver to handle an error that occ=
urs
  *		in the generic implementation of transfer_one_message().
  * @mem_ops: optimized/dedicated operations for interactions with SPI memo=
ry.
@@ -1040,6 +1043,7 @@ struct spi_transfer {
 	unsigned	len;
=20
 #define SPI_TRANS_FAIL_NO_START	BIT(0)
+#define SPI_TRANS_FAIL_IO	BIT(1)
 	u16		error;
=20
 	dma_addr_t	tx_dma;
--=20
2.39.2


