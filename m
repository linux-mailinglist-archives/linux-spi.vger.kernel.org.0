Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74B202065
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jun 2020 05:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbgFTDae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbgFTDaY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 23:30:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B47C061258
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 20:30:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so5296029pjf.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 20:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYIu82vaLERDRRVNezIsYro3B9HeZTQxC/aBbKcbPE4=;
        b=AtmMokfEBFiCVkYDMGVHGJuJS9fKp3FifwZogKQ2q6x4hzDovnsRDnERm9pIhMX5VI
         ToWY1NArXw8XqplWnXUVi18xafByHCkKQ3jNMc0A7Q42LSaPw/Owem45vKA8WDI8WLVz
         orkNoFzi4U8cu25M9SMeU7hdywlADX44zclAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYIu82vaLERDRRVNezIsYro3B9HeZTQxC/aBbKcbPE4=;
        b=B3Cu+dQ71p/1kVjD0TRDj3M6MoaiLz5ijKPKyT+F/e7BLG8kIV0L2PGEViwKIyks+J
         +DGxK8kRDgTp62QUY4yZDRKUBLVXUhUvbJ0fTXJ7zFv8TPM69t+P5SqK4Tj9i4qjW6VP
         sPwnN3X1fvvxyHl6p7TyP2YT8Z1+94AR0K8BXm8uUaDBdVrUF1Ah2xbROk4ix6jjqoEC
         ENoFLZASxvyCkj6tYu8MJWTtffGwIrFootgPsu3eXCSg3qMqDkF3hSwLqu1QvL56Sqts
         edW1J2Zj3fs2a5JX9d7VbEVLi5rUJkvUPy905LziVrNG9DPDCHHQ8RQKhWfLBM71tlfL
         LQqQ==
X-Gm-Message-State: AOAM530KEv1v1iV6KXGbbUoDgpG+Fv18I4o6W/3Aic6Nt/gWirWviY+Q
        ke/H9jZReL8cfF0TUZjn5Iv+OQ==
X-Google-Smtp-Source: ABdhPJzr2vJct8/WkWUzne3Cmk1hS4+0nx/CV5ignmOUO6jPnss1JMiZ2KbcObWfeGsMcluI2vysoA==
X-Received: by 2002:a17:90a:d244:: with SMTP id o4mr6477083pjw.186.1592623819315;
        Fri, 19 Jun 2020 20:30:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14sm7848572pfk.211.2020.06.19.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:17 -0700 (PDT)
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
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 04/16] b43: Remove uninitialized_var() usage
Date:   Fri, 19 Jun 2020 20:29:55 -0700
Message-Id: <20200620033007.1444705-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
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
No later NULL deref is possible due to the early returns outside of the
(phy->rev >= 7 && phy->rev < 19) case, which explicitly tests for NULL.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: 58619b14d106 ("b43: move under broadcom vendor directory")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/b43/phy_n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index c33b4235839d..46db91846007 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
 	u32 rfpwr_offset;
 	u8 pga_gain, pad_gain;
 	int i;
-	const s16 *uninitialized_var(rf_pwr_offset_table);
+	const s16 *rf_pwr_offset_table = NULL;
 
 	table = b43_nphy_get_tx_gain_table(dev);
 	if (!table)
-- 
2.25.1

