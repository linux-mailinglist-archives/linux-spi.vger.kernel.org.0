Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128A85FC854
	for <lists+linux-spi@lfdr.de>; Wed, 12 Oct 2022 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJLPWD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Oct 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJLPVy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Oct 2022 11:21:54 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE3E310F
        for <linux-spi@vger.kernel.org>; Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12c8312131fso19824025fac.4
        for <linux-spi@vger.kernel.org>; Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwJqhNTRTFOg6KTTCmq+FiqxOKuhAXdi9Q4wCoPOfNA=;
        b=LfBzqTPrASeASfAn0654FEvZUhQFsvG64bV9qcmnJd4LbEm+rkZNvoKFu0ffJ+FNtQ
         4E6H/Gv2Q2RUfFZNewBefThDeYwq9SdFEk69iIOyc4abjB5Et0TliU2LrZpckIum6Pdz
         ut9fbok3nZ9I9AtM6ckHbIFeZvb96geiPR6f/YrmSDPz9NkoH3imxf3Bm1Q/faP/lvqi
         NjWfQnt7GfmQMkyXQB5IEfTaACIO89fSsdQT9uJKpNEORekRZz9GaeOmOB7YNA4V92f6
         2klOhMMHe1zGx/15xksX3AII8yjZ8zm+/6ZTM5rG1LhkdfocruGU+1uaC7h4N90epx+K
         lxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwJqhNTRTFOg6KTTCmq+FiqxOKuhAXdi9Q4wCoPOfNA=;
        b=KEU9HWgvv9Rgx+tK0bMfRGWeilYBMCsJw0oHWUvCTsMH3ywdKg0EaVyUb2OASRkiUA
         JCk8U4tFmPladIaWv1ZPWAm/5oLeVbPeasyQnQnuwvFDTqS/7VCa/yiBjAiU7kjXTiLG
         TBZtnpBCByvzzN8RIvazenl+hSpO9U7x2mpZCKvV8osWfk65kP5jf7k/TtrBoQItAJ6s
         l+J19JiPYd389dqElu6Mi5G6hucNTZVLRxjcrk2ljR7RqveXcg3L/jckHysrjg/IWiVX
         xHkWnNSVWKA36HHKGnSah2BUvhuNMtRXwqO7Rh0p/VVeTYNI3LruGiR8v72TBBUsqUlQ
         WX5g==
X-Gm-Message-State: ACrzQf2e2QTHYfldAEVZ6LbdjWqaIn+jPwvGtDmKALxbmyoqJikiCWVe
        qyUaQUXof5hzTFRD70ZOXJAe4A==
X-Google-Smtp-Source: AMsMyM6kEsuXW3HmeI0aeXF32Wl0YnPoY7Nc/gpj1Mziw/JRUJ4FdkB+Pc2sCFKPhLu+UaFZgU1aPA==
X-Received: by 2002:a05:6870:f5a9:b0:136:3e51:eff7 with SMTP id eh41-20020a056870f5a900b001363e51eff7mr2828401oab.241.1665588109024;
        Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id h21-20020aca1815000000b00342ded07a75sm6808541oih.18.2022.10.12.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:21:48 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH] spi: intel: Fix the offset to get the 64K erase opcode
Date:   Wed, 12 Oct 2022 12:21:35 -0300
Message-Id: <20221012152135.28353-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

According to documentation, the 64K erase opcode is located in VSCC
range [16:23] instead of [8:15].
Use the proper value to shift the mask over the correct range.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/spi-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 55f4ee2db002..605acb1bf4b0 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -114,7 +114,7 @@
 #define ERASE_OPCODE_SHIFT		8
 #define ERASE_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
 #define ERASE_64K_OPCODE_SHIFT		16
-#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
+#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_64K_OPCODE_SHIFT)
 
 /* Flash descriptor fields */
 #define FLVALSIG_MAGIC			0x0ff0a55a
-- 
2.34.3

