Return-Path: <linux-spi+bounces-2670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE58B7FAB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C5B22DBF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F3180A65;
	Tue, 30 Apr 2024 18:27:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB901802DC
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501673; cv=none; b=NBp4Gh+yLhkSXniVdWXfEfpjgjBj3SYjj9eXNwwSFFyzfPtaVqFeWiVix/CgAXkst2tmrVjrhLoaUY91ctjlpJwb2+TNthdamv6zLeWmNkzJL66sipXetWgzqeLy69ElNKV5QkN71z/b86fv23YNEQAvN3IoykhX2yGFlstM8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501673; c=relaxed/simple;
	bh=+26Enj+K/4PtmaKhSDoa6xLK7NIqKIPQRYFitKr3Mao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJK8ljAWxmHo8YQVp7YB2kg6badQw3DWq2DL1F21LRUcQoppbD23Z3WgGLzuFt99R/8aeCDhmsDN3/IQj9wIFaQE8e6Cxtzq9Wl8N/Q7wTAwLn2Hmssf2kW9ofB3gSnHA9yXQJGKUDfgzCK6eumPc36Uy1l8ILLQsuNnDRKTmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
	by unicorn.mansr.com (Postfix) with ESMTPS id A0A8D15360;
	Tue, 30 Apr 2024 19:27:43 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id 8286621A4DE; Tue, 30 Apr 2024 19:27:43 +0100 (BST)
From: Mans Rullgard <mans@mansr.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Jander <david@protonic.nl>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: fix null pointer dereference within spi_sync
Date: Tue, 30 Apr 2024 19:27:05 +0100
Message-ID: <20240430182705.13019-1-mans@mansr.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If spi_sync() is called with the non-empty queue and the same spi_message
is then reused, the complete callback for the message remains set while
the context is cleared, leading to a null pointer dereference when the
callback is invoked from spi_finalize_current_message().

With function inlining disabled, the call stack might look like this:

  _raw_spin_lock_irqsave from complete_with_flags+0x18/0x58
  complete_with_flags from spi_complete+0x8/0xc
  spi_complete from spi_finalize_current_message+0xec/0x184
  spi_finalize_current_message from spi_transfer_one_message+0x2a8/0x474
  spi_transfer_one_message from __spi_pump_transfer_message+0x104/0x230
  __spi_pump_transfer_message from __spi_transfer_message_noqueue+0x30/0xc4
  __spi_transfer_message_noqueue from __spi_sync+0x204/0x248
  __spi_sync from spi_sync+0x24/0x3c
  spi_sync from mcp251xfd_regmap_crc_read+0x124/0x28c [mcp251xfd]
  mcp251xfd_regmap_crc_read [mcp251xfd] from _regmap_raw_read+0xf8/0x154
  _regmap_raw_read from _regmap_bus_read+0x44/0x70
  _regmap_bus_read from _regmap_read+0x60/0xd8
  _regmap_read from regmap_read+0x3c/0x5c
  regmap_read from mcp251xfd_alloc_can_err_skb+0x1c/0x54 [mcp251xfd]
  mcp251xfd_alloc_can_err_skb [mcp251xfd] from mcp251xfd_irq+0x194/0xe70 [mcp251xfd]
  mcp251xfd_irq [mcp251xfd] from irq_thread_fn+0x1c/0x78
  irq_thread_fn from irq_thread+0x118/0x1f4
  irq_thread from kthread+0xd8/0xf4
  kthread from ret_from_fork+0x14/0x28

Fix this by also setting message->complete to NULL when the transfer is
complete.

Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 34fca94b2b5b..ca13ca47e745 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4521,6 +4521,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 		wait_for_completion(&done);
 		status = message->status;
 	}
+	message->complete = NULL;
 	message->context = NULL;
 
 	return status;
-- 
2.44.0


