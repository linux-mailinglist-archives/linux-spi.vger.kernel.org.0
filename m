Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9F54C8E0
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiFOMrw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82470DFB2
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=rWP8SIc4tXwNCMNAbl35i0g2wYwLCLqNasTse1jQaXk=;
        b=fn7ditzzPrt/mFgV3VOCN97dXsSeR2xJsLl93spy7V3AeHADAqbVCIjEw8Q/UYZ85RM6OGDAOHMaM
         R3ScyB82znLs4AsGJekkNvZMcyOILKPBbeiAEIIkZoJDaV87H8sXa/3u1C6UXVNlEj7hCeDMAVYoyg
         G/y+atTzNxkSi5qwDbiTdAEcBCLwp+DaZOg7MUnHYJ0OHXCE92ywJm53/5IMTYHf9vJxvRnHCz4uYQ
         P/DiaYOzyog0fRyWBIbjeFRG+hNJJkckhCTkvzcbZeOycz6xbE0Xq9KQsCJpwy9Dz3PSD2U1kvvYpj
         P8ixnnGYAuDzFYedr20kZ4gZpkEBFIw==
X-MSG-ID: 530ab9cc-eca9-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Date:   Wed, 15 Jun 2022 14:46:23 +0200
Message-Id: <20220615124634.3302867-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These patches optimize the spi_sync call for the common case that the
worker thread is idle and the queue is empty. It also opens the
possibility to potentially further optimize the async path also, since
it doesn't need to take into account the direct sync path anymore.

As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
controller attached (MCP2518FD), the time the interrupt line stays
active (which corresponds roughly with the time it takes to send 3
relatively short consecutive spi_sync messages) is reduced from 98us to
only 72us by this patch.

A note about message ordering:

This patch series should not change the behavior of message ordering when
coming from the same context. This means that if a client driver issues
one or more spi_async() messages immediately followed by a spi_sync()
message in the same context, it can still rely on these messages being
sent out in the order they were fired.

---
v2:
 - Avoid API change to spi_finalize_current_message
 - Fixed NULL-pointer dereference for drivers that rely on ctlr->cur_msg
 - Removed intentional printk() statement
 - Split out into small patches to document how code is morphed
 
David Jander (11):
  spi: Move ctlr->cur_msg_prepared to struct spi_message
  spi: Don't use the message queue if possible in spi_sync
  spi: Lock controller idling transition inside the io_mutex
  spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
  spi: Remove check for controller idling in spi sync path
  spi: Remove check for idling in __spi_pump_messages()
  spi: Remove the now unused ctlr->idling flag
  spi: Remove unneeded READ_ONCE for ctlr->busy flag
  spi: Set ctlr->cur_msg also in the sync transfer case
  spi: Ensure the io_mutex is held until spi_finalize_current_message()
  spi: opportunistically skip ctlr->cur_msg_completion

 drivers/spi/spi.c       | 305 ++++++++++++++++++++++++----------------
 include/linux/spi/spi.h |  24 +++-
 2 files changed, 202 insertions(+), 127 deletions(-)

-- 
2.32.0

