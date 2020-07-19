Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6282253D8
	for <lists+linux-spi@lfdr.de>; Sun, 19 Jul 2020 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgGST4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Jul 2020 15:56:53 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:51287 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGST4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Jul 2020 15:56:53 -0400
Date:   Sun, 19 Jul 2020 19:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595188611;
        bh=TposCOyDf9Rxr5ih6p99q34q6+pJI5tfjSeeVkfpM9A=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=vBX4m7koySBoj2Xk9zvIgyhZIKVZgUxehC8Vj35UvYEKEtX+L0/v3HRofLjmgQy+j
         Vz21blaUM0rn36dWsd981a3/xKc0A7NBASXzA8IQFIeUTGWeUJKtCb6VL2IuSx047a
         kNMrVAy99OApy0bRO6miaiTbTUKurK9gvLaqBW00=
To:     broonie@kernel.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-spi@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] spi: correct kernel-doc inconsistency
Message-ID: <20200719195630.148075-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Silence documentation build warnings by correcting kernel-doc comment
for spi_transfer struct.

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/linux/spi/spi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aac57b5b7c21..80d0d045b96f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -329,6 +329,7 @@ static inline void spi_unregister_driver(struct spi_dri=
ver *sdrv)
  *=09every chipselect is connected to a slave.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
+ * @buswidth_override_bits: flags to override for this controller driver
  * @bits_per_word_mask: A mask indicating which values of bits_per_word ar=
e
  *=09supported by the driver. Bit n indicates that a bits_per_word n+1 is
  *=09supported. If set, the SPI core will reject any transfer with an
@@ -841,12 +842,7 @@ extern void spi_res_release(struct spi_controller *ctl=
r,
  *=09processed the word, i.e. the "pre" timestamp should be taken before
  *=09transmitting the "pre" word, and the "post" timestamp after receiving
  *=09transmit confirmation from the controller for the "post" word.
- * @timestamped_pre: Set by the SPI controller driver to denote it has act=
ed
- *=09upon the @ptp_sts request. Not set when the SPI core has taken care o=
f
- *=09the task. SPI device drivers are free to print a warning if this come=
s
- *=09back unset and they need the better resolution.
- * @timestamped_post: See above. The reason why both exist is that these
- *=09booleans are also used to keep state in the core SPI logic.
+ * @timestamped: true if the transfer has been timestamped
  *
  * SPI transfers always write the same number of bytes as they read.
  * Protocol drivers should always provide @rx_buf and/or @tx_buf.
--=20
2.26.2


