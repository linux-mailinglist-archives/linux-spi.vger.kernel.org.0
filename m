Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2056DFF8B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Apr 2023 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDLUUd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Apr 2023 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDLUUc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Apr 2023 16:20:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BA59F2
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 13:20:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u188-20020a2560c5000000b00b8f15f2111dso8035120ybb.4
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681330830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ZxJh3TAe5K3gzUNy1jfSfsgplGS4KJVghK4pqaL44=;
        b=RqkXxES0OfNwPYeIL/5G35UUzVo7uQxrnlPEEdikcqpHvn47El4pqOr8wYq89tVYpi
         HLr5cEJ4JWQ/jdmfCM1YLMqTvSOQEdrI0K4uTEPItrANTfRQE6q78sTohPcxUfDxnoId
         GKILHRa3UsQE7QIiLjy4676jyAbppyl2apcFdIrdT81Z/GSUrMUojJAk/Mt1Efkqv12C
         LPSsNJi7gAahp0cgj6peliWo6ySRByBOpX6bsVdkpPfFNoztlWanLgJgl6nQu7EcgYix
         chFoSfKibQihVpxlLXIXEwFdvvwXm8FGIbFg35F607LmD80apOHuKs82vYA1iA7OSUxc
         VO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ZxJh3TAe5K3gzUNy1jfSfsgplGS4KJVghK4pqaL44=;
        b=YcH7Dl4wByMPBzX6xJDbC2zwIN1JA2LrUoAdZPNiT8HHD7SEXCnx9Tt34FTHNKSmk0
         epk/mzcEnRAz5AlQSto3U6VlacIDGHJedhtN8TzZbxlsv4hnxQAtxG/YikYGPECoMZrm
         XqJM1jTKwVdnhZvg4+QFP1DHuUWnQOM83+dYYAvrMCmjrcmqrkUS9BBBbcewuSmV/qZf
         P9vyyWEykCltvbaFL8HrkGIl6tpkFWzxkFyLA56m8rW9RtirqUMFOmGoeNfyIH8F/dNG
         DMZIyjy255ie67NDWG2RL7BavfuEiiZJDq1jdDt1Vx/a68qGzJTMiBrSS3P6AJ3pC9Kz
         uVFA==
X-Gm-Message-State: AAQBX9d+r00KwKLyUeJ3q7PIm1bOemhG8gUvb/FW7C7uGp4/5vlPjkVe
        nS4X71ObR+/hpy0W1awjFYwcb9yc4II9TQ==
X-Google-Smtp-Source: AKy350YQOCReGiGW58DM+oddgfzjHmmemt6sUL2CI3v1hQw0K6lwaYBsWidBXZzu5MdRQSQMY/CmhofzLYKttg==
X-Received: from rohitner.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:413])
 (user=rohitner job=sendgmr) by 2002:a81:a74a:0:b0:54c:7a1:ef50 with SMTP id
 e71-20020a81a74a000000b0054c07a1ef50mr9024881ywh.6.1681330830221; Wed, 12 Apr
 2023 13:20:30 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:20:09 -0700
In-Reply-To: <20230412202009.3750955-1-rohitner@google.com>
Mime-Version: 1.0
References: <20230412202009.3750955-1-rohitner@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412202009.3750955-2-rohitner@google.com>
Subject: [PATCH v2 1/1] spi: spi-loopback-test: Add module param for iteration length
From:   Rohit Ner <rohitner@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, joychakr@google.com,
        Rohit Ner <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI test framework is designed to run each test case for
a list of lengths.
Introduce a module parameter to limit the iterations
to a single value among the list of lengths.

Signed-off-by: Rohit Ner <rohitner@google.com>
---
 drivers/spi/spi-loopback-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 313106eb8d40..675a73cf1579 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -53,6 +53,12 @@ module_param(no_cs, int, 0);
 MODULE_PARM_DESC(no_cs,
 		 "if set Chip Select (CS) will not be used");
 
+/* run tests only for a specific length */
+static int run_only_iter_len = -1;
+module_param(run_only_iter_len, int, 0);
+MODULE_PARM_DESC(run_only_iter_len,
+		 "only run tests for a length of this number in iterate_len list");
+
 /* run only a specific test */
 static int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -1033,6 +1039,8 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 
 	for (idx_len = 0; idx_len < SPI_TEST_MAX_ITERATE &&
 	     (len = test->iterate_len[idx_len]) != -1; idx_len++) {
+		if ((run_only_iter_len > -1) && len != run_only_iter_len)
+			continue;
 		FOR_EACH_ALIGNMENT(tx_align) {
 			FOR_EACH_ALIGNMENT(rx_align) {
 				/* and run the iteration */
-- 
2.40.0.577.gac1e443424-goog

