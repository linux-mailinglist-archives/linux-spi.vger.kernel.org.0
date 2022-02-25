Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815994C3AB0
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiBYBAU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiBYBAT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A292804FE;
        Thu, 24 Feb 2022 16:59:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso3419676pjb.4;
        Thu, 24 Feb 2022 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiBHZa5nz3s5X5wtDcIiG42DYwgMJ7OeGuL/D9inyEI=;
        b=oCT9eDwoPZ9uCBJkvNKZMqGI+N2XaSrU5s3Lqs2loQn0ErNtYeqGMTt2kj3/mu7dfy
         DQ4MqvHBBzV1cGKWlhHshkjabKNo+Y5VYVIaSQAnyt2naQDMoBvhsiJICHbzhkGkuWlx
         BVY4FzOPGgyMgfH44dRMPPmouR9SihEScivLP2MRUKehLNIli2bXDhWG4Wti0Mo/NM+L
         3wV461aGepjroqRVHRbvSl6jqy59PVStcls43hNanLtLeCAUvYorTdmuCmPon887uNcz
         hXFeobyMBxRn4xsi89ERsz8hP/LflpYZJrUgLe75BijLHfNA0U70iKEhhsEXULkWyEkz
         uSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiBHZa5nz3s5X5wtDcIiG42DYwgMJ7OeGuL/D9inyEI=;
        b=aDdilA+Wqe5Rf34e8OV1wAvYOyOWqyUMceu9PjD9e9cyM3ddO9vfccvVMDbHMaJbV8
         QFmAQXE4R34qTWeRwSMbnL3xPjlv08dzUgbdh8qeK2GAEXB5+FseW9ZMbyIdwJnnEWnp
         Iti1wzV12/r43SF68IGsraVlGPa7jnMmnhEmIX5c1AbxkO431xjuIQIdzcs9SfYzi0as
         ZLounYbVWMU7OrJXipVUVxFI35Z/Nr1tooNCAnm/FCAEhHuWSuDbb3ZCDWodxKP3XULz
         I5hJ4+mn/xSjSeqYqMwkHiIJu6m5XZJk1NiCiCd3HYbyyweNFkQY1PwhjBdFNif2AtMJ
         omXA==
X-Gm-Message-State: AOAM532A00pLX4DQD5JEwQKu9I4TjZ7PMVPisefb59AUqi0lHheR4t3g
        Cz8JtE9N4LR9OFFlboGgLSY=
X-Google-Smtp-Source: ABdhPJyS07kVLUhnBXeQXLkOT/TsdkvbuP2OXSWni6R3nHkTg8wP9DMOgAQnVUP2Chfo+PyYZlaXNQ==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr4926367pls.29.1645750788415;
        Thu, 24 Feb 2022 16:59:48 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:48 -0800 (PST)
From:   Dmitry Antipov <daantipov@gmail.com>
X-Google-Original-From: Dmitry Antipov <dmanti@microsoft.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Dmitry Antipov <dmanti@microsoft.com>
Subject: [PATCH v4 2/6] HID: define HID_SPI_DEVICE macro in hid.h
Date:   Thu, 24 Feb 2022 16:59:32 -0800
Message-Id: <20220225005936.3485405-3-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225005936.3485405-1-dmanti@microsoft.com>
References: <20220225005936.3485405-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Dmitry Antipov <dmanti@microsoft.com>

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 include/linux/hid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index f453be385bd4..1f134c8f8972 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -684,6 +684,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)
-- 
2.25.1

