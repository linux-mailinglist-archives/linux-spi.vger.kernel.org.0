Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3321ED974
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 01:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFCXdl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgFCXcR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 19:32:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4331C08C5C0
        for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2020 16:32:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so2654627pgv.8
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2020 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cI/V2fP2M6XP0OWA+3cSpTCBqMiFhr0WbfahcOkSkY=;
        b=VCJ2fVD0K76VRnrhhqYKoqGSd3oNzMCvSb1PkzjzEgKS3lEBs2i8o2SVDUvF/dPkga
         xv+arE7KCC4Hh7ilymPh7gR+E8iYUVZKNocdJw2iUCCPqK5/4h3Nv2ZjF0IFcbTj05JQ
         cxiJdjSZ+hZY3fifzFTCh10vLiNWMDPHcLw74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cI/V2fP2M6XP0OWA+3cSpTCBqMiFhr0WbfahcOkSkY=;
        b=ZvV0hHtSJthyIzfPVVrqvYtnlz8P6wZ09A6EQ97OfsloBFM84G5/+5ROzOClm01WHF
         wFZqokhS3qvaLeZcM4wpYIF6OuUkKQvFuT5RchvWAuX8g3C2hyT5+vuJFQ1GQHPxR61p
         mEss1noKNKRHWt8Qs1JA+W1kb/Jf3CZLNOqnG4vWpGLKGxyCER9nicvViWpiP9Fdbkso
         CD+vS9fcPYVfJMo8JEycz/w5Zy1pJa1vXizB5+lebV6hCEYx1cN8TjLI1bF+UXZNFI/+
         fioq2BZQMMq7BtjsVY3we//Hw7uKQx+uXZdAB9kOBCqh4DEOIzb/vsQWYYmcg7gu9CJh
         sj6g==
X-Gm-Message-State: AOAM531aoLxYXRi3qRppPU7NB+ynVGQsmvSiHYV+ku0R0890vQUgSbKf
        ud7mVXkhq+RPpssjnuNR45cuTA==
X-Google-Smtp-Source: ABdhPJwP1oJJWA9CCPnffeDQAD6N9ckmvjh4MOBxgBDDG5Bisi5j6kln17qF8cvddpC2X+a/wgv1kg==
X-Received: by 2002:a65:4488:: with SMTP id l8mr1683466pgq.327.1591227135199;
        Wed, 03 Jun 2020 16:32:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x25sm2353911pge.23.2020.06.03.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 02/10] drbd: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:55 -0700
Message-Id: <20200603233203.1695403-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just initialize this variable to NULL.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index eeaa3b49b264..0067d328f0b5 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1604,7 +1604,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
 	void (*last_func)(struct sk_buff *, unsigned int, void *,
 			  enum drbd_notification_type) = NULL;
-	void *uninitialized_var(last_arg);
+	void *last_arg = NULL;
 
 #define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
 #define FINAL_STATE_CHANGE(type) \
-- 
2.25.1

