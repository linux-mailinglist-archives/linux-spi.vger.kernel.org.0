Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBB6D3C4C
	for <lists+linux-spi@lfdr.de>; Mon,  3 Apr 2023 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDCEJ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Apr 2023 00:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDCEJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Apr 2023 00:09:26 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601D83F7
        for <linux-spi@vger.kernel.org>; Sun,  2 Apr 2023 21:09:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5416698e889so528654397b3.2
        for <linux-spi@vger.kernel.org>; Sun, 02 Apr 2023 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680494964;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvFnphnDJhIRgXZm0virLekdKTOQfW5+pHsWaTGGeTM=;
        b=kUeJ2lwf7zRBsYvmzFyuhvCEE7VnpCUYH76GnherL1ruTmM1Q+L5tsiaPdC/GPoqsV
         htWO6WAJiLZ8g8ZFLB8GefKVE3XzbSa6vOy9Z3lcXegrB6UvIFAKz9/wBfd4mrXlfRrB
         hDN/hdPEgV4KST6mXOybEp8IObsyB6LY92r0a/qXB1ZGp2/9tDNf2DyvFFdS5U+djt23
         O8L3WPpxorS17h6DSYn5Itwh2DbSxUWfUYDRF0IAWAZBfMrPKF0ldhBSdk7xmuWk5/IU
         +z55dONWjivicjeZO+Vu9ijlURBjxHM7awcwYi+c5zKLk2s8LSujyoMdAla/zFmSDweD
         GI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680494964;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvFnphnDJhIRgXZm0virLekdKTOQfW5+pHsWaTGGeTM=;
        b=1lSFojiOStDcapmBwtz9MNB10oq9euhoYKUNlACSf7KBe/inDPFsw8kbD4E2RZgwQT
         nNQeBYol+7XXJmwieR17EeGnD1LYI06c8Qy9lFO2iSoiBEh5YKmN4PU0bT4GLR5Chmcm
         oIm/atvyQPNcgr8QsuX4zoMu4cVTUTmDipzmdgn053ltzSf+jvPgaScydCR2K6v8LvtP
         p7T6G28Yi9pwzFGUAKFcTlJGenTozM0L4oKIQlUR/CY/oJIKzEFOP/llp50Lr2BuLeWX
         RAbQFYGSqWbzEuaIJ654EEshiXS8RXkl5fbbDRwWjlzi4/aojGOIGNzIKO+1hp7g49Ds
         /yiQ==
X-Gm-Message-State: AAQBX9exH/ukk6UBG+Oo03xezFdILi+J6PkMXUpKIjwCb6Ew8bhcqJO5
        c660z2xVvoh2VJlsZwO8eOOgi33fTUaz2iyqO46aFQ==
X-Google-Smtp-Source: AKy350b9JFkPWrokQWdHW/mPTI0m5GQey0wVu1tdgM2llpJ1XCUx9QOk9xLJdiiSpZr/zZH11ZwiyYXKVXSHDk5itwo=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr17689756ywj.0.1680494963814; Sun, 02 Apr
 2023 21:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Rohit Ner <rohitner@google.com>
Date:   Mon, 3 Apr 2023 09:39:10 +0530
Message-ID: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
Subject: [PATCH] spi: spi-loopback-test: Add module param for iteration length
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <manugautam@google.com>,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
+                "only run tests for a length of this number in
iterate_len list");
+
 /* run only a specific test */
 static int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -1033,6 +1039,8 @@ int spi_test_run_test(struct spi_device *spi,
const struct spi_test *test,

        for (idx_len = 0; idx_len < SPI_TEST_MAX_ITERATE &&
             (len = test->iterate_len[idx_len]) != -1; idx_len++) {
+               if ((run_only_iter_len > -1) && len != run_only_iter_len)
+                       continue;
                FOR_EACH_ALIGNMENT(tx_align) {
                        FOR_EACH_ALIGNMENT(rx_align) {
                                /* and run the iteration */
