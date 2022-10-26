Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB860E0A1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJZMaJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiJZMaF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 08:30:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD88399E2
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 05:30:02 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666787400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ov97DnXbeyGTG04tM11Ln/jh5+1InwlVZS0bgIBezJg=;
        b=H5K1W4Cm9JehfQEWdD3JP6WVgPrM9kFr5EEYsU1GHWjvp5S3EJJsX+UelFTgHiTTwR+4Qb
        Rc9mex2KbCjHIujfUj8syikXQ0QXFf0NTk4/tJuJ4raH/us0mVvQeAFshpYBD79cBnRUQK
        GluAMsPMwAV47rDz5dUyzCQWRyqLK2NM1wAFzsyArUHxMnacdRoapXk2BNhwzjbjXuJ2nD
        g1HFZrIVWqzVGjWxFEGAxXW09R41rhU5khLVMSUdohfxS6F/HIZCAloCsiB3gknmLAdG0N
        RD/SoM2wVSMTriIsBc2fOkEdyTVTi25lPZkMYp3aOsaOpDQ6SQ2HgMIgXeZUWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666787400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ov97DnXbeyGTG04tM11Ln/jh5+1InwlVZS0bgIBezJg=;
        b=G4yN5cz8jnwKBRs5tFswA0D7E0P7d4Yh+iR9N4+jwQw1fc1YkY+LzxQHMELyF9XUha1MyR
        d8+eQkIP8Vsb0BBg==
To:     linux-spi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] spi: Remove the obsolte u64_stats_fetch_*_irq() users.
Date:   Wed, 26 Oct 2022 14:29:51 +0200
Message-Id: <20221026122951.331638-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Now that the 32bit UP oddity is gone and 32bit uses always a sequence
count, there is no need for the fetch_irq() variants anymore.

Convert to the regular interface.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5f9aedd1f0b65..dabe89666efdb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -127,10 +127,10 @@ do {									\
 		unsigned int start;					\
 		pcpu_stats =3D per_cpu_ptr(in, i);			\
 		do {							\
-			start =3D u64_stats_fetch_begin_irq(		\
+			start =3D u64_stats_fetch_begin(		\
 					&pcpu_stats->syncp);		\
 			inc =3D u64_stats_read(&pcpu_stats->field);	\
-		} while (u64_stats_fetch_retry_irq(			\
+		} while (u64_stats_fetch_retry(			\
 					&pcpu_stats->syncp, start));	\
 		ret +=3D inc;						\
 	}								\
--=20
2.37.2

