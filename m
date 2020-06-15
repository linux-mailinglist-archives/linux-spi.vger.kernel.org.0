Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F541F910A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgFOIIN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgFOIIH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 04:08:07 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F2520757;
        Mon, 15 Jun 2020 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592208487;
        bh=iJjCtGA60IxEMe6LqJFvQCe1OucL9pzPXJCoK6sfAig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7dwvejmsHWlpMyATQrG+75DTVF8FiwOvhgsTE7tJQWKORGU7ymV3YxpI0TXd3HaI
         eS4YSCU5aHUSjyuEs3ANjls/o8cqQcuILm8bp/1DC74kSNgzqhlLRMb7+600nLnz7g
         HbCCS5bOwKcSEwP9U8l+vonOPtPCMKSmYxaaLmAQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/3] genirq: Do not test disabled IRQs with DEBUG_SHIRQ
Date:   Mon, 15 Jun 2020 10:07:19 +0200
Message-Id: <1592208439-17594-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592208439-17594-1-git-send-email-krzk@kernel.org>
References: <1592208439-17594-1-git-send-email-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Testing events during freeing of disabled shared interrupts
(CONFIG_DEBUG_SHIRQ) leads to false positives.  The driver disabled
interrupts on purpose to be sure that they will not fire during device
removal.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch.
---
 kernel/irq/manage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 761911168438..f19f0dedc30d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1775,12 +1775,14 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/*
 	 * It's a shared IRQ -- the driver ought to be prepared for an IRQ
 	 * event to happen even now it's being freed, so let's make sure that
-	 * is so by doing an extra call to the handler ....
+	 * is so by doing an extra call to the handler.
+	 * Although the driver could disable the interrupts just before freeing
+	 * just to avoid such trouble - don't test it then.
 	 *
 	 * ( We do this after actually deregistering it, to make sure that a
 	 *   'real' IRQ doesn't run in parallel with our fake. )
 	 */
-	if (action->flags & IRQF_SHARED) {
+	if (action->flags & IRQF_SHARED && !desc->depth) {
 		local_irq_save(flags);
 		action->handler(irq, dev_id);
 		local_irq_restore(flags);
-- 
2.7.4

