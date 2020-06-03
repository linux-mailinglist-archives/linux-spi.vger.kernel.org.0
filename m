Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F133B1ED92F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 01:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgFCXc1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFCXcX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 19:32:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A3C08C5C0
        for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2020 16:32:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s23so1165492pfh.7
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2020 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzsXBVjaZ9OyhsxAhNYMGGdoHV1Ey3EdXUcZrl9vzVM=;
        b=fiQwobOmB8JfoctwPcv9w7of7+WQd9TYcia/JYyZCbsrU9Y8/1P+jBMjyrycCzGPks
         k3E6rjY6DJsSHcxaDq1Tu7Q/DfBMxQ8rMeh/wfYcOaVB5kbniYqtcSsHt+OsYLHdKBZx
         t2PGOxXperAYxdbLB/SYYU6TMLn1K13kfox0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzsXBVjaZ9OyhsxAhNYMGGdoHV1Ey3EdXUcZrl9vzVM=;
        b=EjXN+Ot0hvuZFVYn+dHefj7mLe3F12HdOv/0Rn6xoO4i8DZhADAzXpbmF7JaGl/jVV
         6zeH9A/0HXqEZQ3Oitomo+yJbESB4Tp0cYj7AcQHJLNAbsHBKe21exQFPZnoWCm+60GL
         yjqhY58loA7qZXyoeZnqwMRo12vSDKnx8PdIaC5NW3GzaIMVked/SPUuq/JIO5FPCiED
         CKbJ39Fu2+RYR78SUSdDXHT9DDWPj1vh2KkziUi4UhP1B1PtW5bH6ToqkkX2HLAXshzJ
         pdYVHyDmb8ZGCb7XY8BI6yEmQS+b4xTz6a/d8hvUxDm6vFxw3/tLQeyDGW5x+BbrfDwI
         AUJQ==
X-Gm-Message-State: AOAM531F/+ruDcPoyUK2UHMuwTy1TTfPx/eDSOmWChq1wlPbVdSPKAcD
        1ziq0s7wt92gCnMV8Gu3mdFvOQ==
X-Google-Smtp-Source: ABdhPJx+2U9hKaJOBj6eBoL3ylJxwEvHjFbKnopLLfUC+crlAi7qwt10Oa3/8CNVIO6wXkejTT/bbA==
X-Received: by 2002:a62:27c6:: with SMTP id n189mr1466796pfn.277.1591227139068;
        Wed, 03 Jun 2020 16:32:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm2647707pfn.76.2020.06.03.16.32.15
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
Subject: [PATCH 08/10] checkpatch: Remove awareness of uninitialized_var() macro
Date:   Wed,  3 Jun 2020 16:32:01 -0700
Message-Id: <20200603233203.1695403-9-keescook@chromium.org>
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

In preparation for removing[2] the[3] macro[4], effectively revert
commit 16b7f3c89907 ("checkpatch: avoid warning about uninitialized_var()")
and remove all remaining mentions of uninitialized_var().

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b83be177edf0..e9f8146600d0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -838,7 +838,6 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
 )};
 
@@ -4075,7 +4074,7 @@ sub process {
 		}
 
 # check for function declarations without arguments like "int foo()"
-		if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
+		if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
 			if (ERROR("FUNCTION_WITHOUT_ARGS",
 				  "Bad function definition - $1() should probably be $1(void)\n" . $herecurr) &&
 			    $fix) {
@@ -6271,8 +6270,7 @@ sub process {
 			if (defined $cond) {
 				substr($s, 0, length($cond), '');
 			}
-			if ($s =~ /^\s*;/ &&
-			    $function_name ne 'uninitialized_var')
+			if ($s =~ /^\s*;/)
 			{
 				WARN("AVOID_EXTERNS",
 				     "externs should be avoided in .c files\n" .  $herecurr);
@@ -6291,17 +6289,13 @@ sub process {
 		}
 
 # check for function declarations that have arguments without identifier names
-# while avoiding uninitialized_var(x)
 		if (defined $stat &&
-		    $stat =~ /^.\s*(?:extern\s+)?$Type\s*(?:($Ident)|\(\s*\*\s*$Ident\s*\))\s*\(\s*([^{]+)\s*\)\s*;/s &&
-		    (!defined($1) ||
-		     (defined($1) && $1 ne "uninitialized_var")) &&
-		     $2 ne "void") {
-			my $args = trim($2);
+		    $stat =~ /^.\s*(?:extern\s+)?$Type\s*(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*\(\s*([^{]+)\s*\)\s*;/s &&
+		    $1 ne "void") {
+			my $args = trim($1);
 			while ($args =~ m/\s*($Type\s*(?:$Ident|\(\s*\*\s*$Ident?\s*\)\s*$balanced_parens)?)/g) {
 				my $arg = trim($1);
-				if ($arg =~ /^$Type$/ &&
-					$arg !~ /enum\s+$Ident$/) {
+				if ($arg =~ /^$Type$/ && $arg !~ /enum\s+$Ident$/) {
 					WARN("FUNCTION_ARGUMENTS",
 					     "function definition argument '$arg' should also have an identifier name\n" . $herecurr);
 				}
-- 
2.25.1

