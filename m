Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600002020E9
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jun 2020 05:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbgFTDdl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 23:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732897AbgFTDab (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 23:30:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EA6C0619C4
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 20:30:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so4818878plk.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtJf1eB0YMlrdncO0Lr6J725DqMYoYaHrhw5Cgkkruw=;
        b=gTDQzS0R9OidQMG5e9+VmFfSSG04SBfqJ4unRxfvhHa8h+BRhqOurGCqtRjRXbtwmM
         6qHaq3suirfdF4p2vTK9nVPvab/ze983kHVbVbdpqZ9jzfmQ209tdPY06qFcE4o+7kX3
         tZECKumwZls9OBAgYV/KhQ2bgAnw8dWiC5t0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtJf1eB0YMlrdncO0Lr6J725DqMYoYaHrhw5Cgkkruw=;
        b=DcNXuhA34GjxvRYu0viKChRZJE4oT2MhC5dRYTbfF0bh+iZpbi9aUBg9t/Z/28URE/
         AmDg4HXR9Nu2DeaE1tS6iS07eDxXzq/DcIjJwphWMrXyoHmtnMepIWwygGV4ODQtidIl
         u6KG2niWIPEJCT8AgLS1grgso7Fsz59hCZw4ENkbD/Pn9SzAF1qfzkFHmscngxdwYRGT
         7aJuoc1TfG9c9nvwfjkMMpANVQ5bN9ULmP6emkq9aQnhVBhGaemtVLkalpQWrYaF44D+
         HwhGMJvvkiIpoA9VK4tU0H4Kxsmo+RJBA5CRHo0pMJm6ElcI7ZVc/hU4ywSFSd5yAp2I
         rUJw==
X-Gm-Message-State: AOAM533NWf45kvgTeusDM7/XVXch9qlueaKF2eNaIhsuwgDwzcL+3+4O
        rAMIHxlk+6BvcDC8IbBcNpt/oA==
X-Google-Smtp-Source: ABdhPJwKgmzNQXi/vbnAMFC7g+mel4lUeVcAQfzdBe9z4BUHWp/ZcsnxA9mdYSIljSqJHt1Xu1z0+Q==
X-Received: by 2002:a17:902:760c:: with SMTP id k12mr806735pll.129.1592623820805;
        Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 137sm6119819pgg.72.2020.06.19.20.30.16
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
Subject: [PATCH v2 02/16] x86/mm/numa: Remove uninitialized_var() usage
Date:   Fri, 19 Jun 2020 20:29:53 -0700
Message-Id: <20200620033007.1444705-3-keescook@chromium.org>
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
to removing[2] this[3] macro[4], refactor code to avoid its need.

The original reason for its use here was to work around the #ifdef
being the only place the variable was used. This is better expressed
using IS_ENABLED() and a new code block where the variable can be used
unconditionally.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: 1e01979c8f50 ("x86, numa: Implement pfn -> nid mapping granularity check")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/numa.c                | 18 +++++++++---------
 include/linux/page-flags-layout.h |  4 +++-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8ee952038c80..b05f45e5e8e2 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -543,7 +543,6 @@ static void __init numa_clear_kernel_node_hotplug(void)
 
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
-	unsigned long uninitialized_var(pfn_align);
 	int i, nid;
 
 	/* Account for nodes with cpus and no memory */
@@ -571,15 +570,16 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 	 * If sections array is gonna be used for pfn -> nid mapping, check
 	 * whether its granularity is fine enough.
 	 */
-#ifdef NODE_NOT_IN_PAGE_FLAGS
-	pfn_align = node_map_pfn_alignment();
-	if (pfn_align && pfn_align < PAGES_PER_SECTION) {
-		printk(KERN_WARNING "Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
-		       PFN_PHYS(pfn_align) >> 20,
-		       PFN_PHYS(PAGES_PER_SECTION) >> 20);
-		return -EINVAL;
+	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
+		unsigned long pfn_align = node_map_pfn_alignment();
+
+		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
+			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
+				PFN_PHYS(pfn_align) >> 20,
+				PFN_PHYS(PAGES_PER_SECTION) >> 20);
+			return -EINVAL;
+		}
 	}
-#endif
 	if (!numa_meminfo_cover_memory(mi))
 		return -EINVAL;
 
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 71283739ffd2..e200eef6a7fd 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -98,9 +98,11 @@
 /*
  * We are going to use the flags for the page to node mapping if its in
  * there.  This includes the case where there is no node, so it is implicit.
+ * Note that this #define MUST have a value so that it can be tested with
+ * the IS_ENABLED() macro.
  */
 #if !(NODES_WIDTH > 0 || NODES_SHIFT == 0)
-#define NODE_NOT_IN_PAGE_FLAGS
+#define NODE_NOT_IN_PAGE_FLAGS 1
 #endif
 
 #if defined(CONFIG_NUMA_BALANCING) && LAST_CPUPID_WIDTH == 0
-- 
2.25.1

