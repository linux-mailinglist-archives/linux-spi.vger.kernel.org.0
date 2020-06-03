Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34BF1ED931
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 01:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFCXc3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgFCXcZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 19:32:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B7C0085C8
        for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2020 16:32:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1371967plo.7
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2020 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wgSseUcyTd9Drk76fcV4j2VbriV8jy/HYEGQ0NYaFk=;
        b=UstK7WLaEjDWaKH3+++ddeAXtqpiyFxQfl0O2lazw1LzLA/AjfOlogFybdXuhuVdpb
         rFJfQt4LgPRAzCjKoGukk2COBz4+5z1QncnyZ/CR0mBbgUwuOWUYwdicuZEexScuGgS/
         olVZGdjTE/8GbLwCvMROC7gFScCzYDYjU2Bl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wgSseUcyTd9Drk76fcV4j2VbriV8jy/HYEGQ0NYaFk=;
        b=nCsNjLm/JciUrssP041tnbiO1XOUQvmxMs3SpjlLRVG96dYKqbYh1POzTH1I70XyH9
         /cYtan8pDZjyqYOAPMBmI2z5Yb0P118ucZ5OXoz3q7C21azYg2FRds5Kpn1ZbN/hlxag
         HPcFsiwvgg3PWq9dACtZomrVzKF8xcr8NlE0Hljg2FLh6mTPuEmpX6NpKzAMLkd0EB+2
         UYS3rukRGYpnuoH2DSwP8z7646Nld+dZ74eqzOvK5AA3gZWdyeJ+DYeBgU/3kZ1Igc4W
         ftRiseea++wvhpwBbD3j1Qbza0+ZeyZNwEgni2y/6FqQTpFY59mAJJej3LOPKmOPq5uE
         S1AQ==
X-Gm-Message-State: AOAM531Pdg7he1n73N94MgfX3r3HtRq/liVN5SjeVoDP5j/b2geObPkZ
        eVw+eBKBfTXHYNy8tCIQlD11XQ==
X-Google-Smtp-Source: ABdhPJx0hlq73lYT8fOS+tXn65Ai8YEmL5/PSXJN4dJgAWJCbi3pNRJVeupDCakZZ2YluWv4rvJ6+A==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr2149275pls.304.1591227139667;
        Wed, 03 Jun 2020 16:32:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k19sm2867022pfg.153.2020.06.03.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
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
Subject: [PATCH 10/10] compiler: Remove uninitialized_var() macro
Date:   Wed,  3 Jun 2020 16:32:03 -0700
Message-Id: <20200603233203.1695403-11-keescook@chromium.org>
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
(or can in the future), and suppresses unrelated compiler warnings
(e.g. "unused variable"). If the compiler thinks it is uninitialized,
either simply initialize the variable or make compiler changes.

As recommended[2] by[3] Linus[4], remove the macro.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-clang.h | 2 --
 include/linux/compiler-gcc.h   | 6 ------
 tools/include/linux/compiler.h | 2 --
 tools/virtio/linux/kernel.h    | 2 --
 4 files changed, 12 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 790c0c6b8552..019f444b500b 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,8 +5,6 @@
 
 /* Compiler specific definitions for Clang compiler */
 
-#define uninitialized_var(x) x = *(&(x))
-
 /* same as gcc, this was present in clang-2.6 so we can assume it works
  * with any version that can compile the kernel
  */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..ac3e29ae32de 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -58,12 +58,6 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
 
-/*
- * A trick to suppress uninitialized variable warning without generating any
- * code
- */
-#define uninitialized_var(x) x = x
-
 #ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 180f7714a5f1..29cbb73f2ae0 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -108,8 +108,6 @@
 # define noinline
 #endif
 
-#define uninitialized_var(x) x = *(&(x))
-
 #include <linux/types.h>
 
 /*
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6683b4a70b05..1e14ab967c11 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -109,8 +109,6 @@ static inline void free_page(unsigned long addr)
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 
-#define uninitialized_var(x) x = x
-
 # ifndef likely
 #  define likely(x)	(__builtin_expect(!!(x), 1))
 # endif
-- 
2.25.1

