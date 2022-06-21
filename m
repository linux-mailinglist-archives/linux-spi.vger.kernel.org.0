Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936C552AD4
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbiFUGMq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbiFUGMo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:44 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8631AF36
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JSzHMY73F/SPxQ/7Bw84B6uyRQF7XnUyeidi/expuW4=;
        b=alfIIZdddIcFV62cJlHBUXljM46ktYdy05Cs2GVTyEfR5wtEJGQLm6sD2+uYrxsUkekfKuLEiv/ib
         BTrgm+FLUlr8tjlh5VPdWHsbXlpUQE/FYJGn7wlAtZakl0nW+iyxxf/ClZiRZaskiRHxPSj8ZiToMN
         bft+4rj+gao/oxF/hg+AnGHcxIzaNNqZjvhwvQebrk3XkD38ksN1tMAgbU7vzzf3b9LZnWfK+/CJi3
         l0KW38H3XHSA9oTLHFCtgUhiqrgLesCOx329KtlQgsQHrHhWB7/2N7O21wLoeaudId1tnQ6tS+Drzn
         bn6y7XRJ/E+QKh1e8SU3eo4LQXNKB6g==
X-MSG-ID: 25db56e1-f129-11ec-ba03-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 00/11] Optimize spi_sync path
Date:   Tue, 21 Jun 2022 08:12:23 +0200
Message-Id: <20220621061234.3626638-1-david@protonic.nl>
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
v3:
 - Rebased onto more recent spi-next
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

