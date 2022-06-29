Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB4560299
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiF2OZf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiF2OZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:25:33 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF8F24F2A
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=Y2iBeHtXt/HOW6c9/CVKzJeCYgYhl2qHO61V2nD40/E=;
        b=dAayAWHCThfxuE13tfCKfNOrIVHXjqslfT5MkmqIFsXdHhYxaa3T1Xrz1QPM0jaEg0J09kZOG5ToQ
         ept4PSllGQJ25pfqxuwF8U1rB1FNUbGvVP+CWwU3+zdpFADhng0cqWN7Tfht/oyuLzho0yyCmO8v91
         QnY08qy6QOFIMAzfbxDeU84B9XwZ9cWo2f4x+R6Y6mcjFt9uZILGRvVJhPplYCTuFxF0/kEm6/wgv3
         YbwKfc3IYN2hZL0w1yEOXJNRRVoWksERubHztBWfQHPJpKdXYq+C26LyZLbump1hklpibVLCgyzAgt
         zy88IV7JhkOMejAFgnEmZF72NVbG/bg==
X-MSG-ID: 53596b02-f7b7-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH 0/3] Fix some coding style issues
Date:   Wed, 29 Jun 2022 16:25:16 +0200
Message-Id: <20220629142519.3985486-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series fixes some coding style issues. No functional change.

David Jander (3):
  spi: spi.c: White-space fix in __spi_pump_messages()
  spi: spi.c: Fix comment style
  spi: spi.c: Remove redundant else block

 drivers/spi/spi.c       | 106 ++++++++++++++++++++--------------------
 include/linux/spi/spi.h |  82 +++++++++++++++----------------
 2 files changed, 94 insertions(+), 94 deletions(-)

-- 
2.32.0

