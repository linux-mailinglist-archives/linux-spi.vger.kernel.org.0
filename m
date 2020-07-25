Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1F22D511
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 07:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGYFDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Jul 2020 01:03:06 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:25454 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGYFDF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Jul 2020 01:03:05 -0400
Date:   Sat, 25 Jul 2020 05:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595653382;
        bh=cZEUnqWvcfeQjd0qbFRicNbcxrZw3RQsQq3i1JQ+XK4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=M3TVbWRuWnMTR0T8b+HCIoTPMSZfUMpSmb52y4OxxO8LujtKa/uyiKm8bh0qfogBp
         FNTQNa2xU8DzaNEEHPN2jHPuHSb4vj2kiR5WjQzrw+pal1dLWGSYpwliK38xoFxrKQ
         2jXP3GcXTcTn74Cia1W4xNYD9uiO+U7rfMUmArcA=
To:     broonie@kernel.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-spi@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH v2] spi: correct kernel-doc inconsistency
Message-ID: <20200725050242.279548-1-colton.w.lewis@protonmail.com>
In-Reply-To: <20200720143655.GA5949@sirena.org.uk>
References: <20200719195630.148075-1-colton.w.lewis@protonmail.com> <20200720143655.GA5949@sirena.org.uk>
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
index f8b721fcd5c6..99380c0825db 100644
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
@@ -846,12 +847,7 @@ extern void spi_res_release(struct spi_controller *ctl=
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
  * @error: Error status logged by spi controller driver.
  *
  * SPI transfers always write the same number of bytes as they read.
--=20
2.26.2


