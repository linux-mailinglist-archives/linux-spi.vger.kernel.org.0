Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B64C3AB3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiBYBAY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiBYBAX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACB2819A5;
        Thu, 24 Feb 2022 16:59:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so3487781pjb.0;
        Thu, 24 Feb 2022 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LYyiuzySTYab5AWLbomJLC5ogjyw6DZmtGr16Spi3E=;
        b=kA4ahrerTGSfUevzXA6H2Nksdb2K+8y4H8Xe552TZ11Kq+zljpuVJewrtwLwelw66j
         BXGMOhMfp5uOO5mEGvNLvdMsaLS+nh8E0XYtecGZpVI5LkBA/zZscDlq6vqFtSAdHOMX
         esiiflHUCm1zm6gxSQuKW/xl37CpWl2iQGsQQ0pQPkwKT9ENJC/L+vSy5bmgk8CY/v11
         WGSPEczMSLgoY5FmnaKEti1Myhkhqy1eWvUlgxLPcWwCLTL9R6Cm0Ska8TGJyWtLyQvQ
         JMzb7HlAjTP/kYhj58GGd1QfXokG+cK3tNI+RIhfuhmEQ+/7wKvaLvMTh0GjNXofDqd6
         xwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LYyiuzySTYab5AWLbomJLC5ogjyw6DZmtGr16Spi3E=;
        b=7lKwvc+uy3qjjvQQEim7UJ2bSt7njp3NJ00sQUwesjvIt/nG9yjfqfAgef9dO8bc5a
         xVhzF19TfzoBBTtZp3suRi9i43gGjwR5eIGlW2vgPXzfsurKoRHcPp2Mt7UycKsn4oDU
         2F9fcd4ebXe1cWCGzbyZ/TKS8vPEXyWcsG50L9wOvThJsybE+WaTJU4A0A2D6h1pvkQD
         M4upeHiJ3g7Rh+2zJaozbRAIt5RtymjTJCQZRUINapyYK1TtaDDFUM0lNx4+3gIIm6lA
         c1VU8yUWTOVLwZno6IiBb6T+b7caSw2mG9ifj27k/YyGwEIpx5xwSjhEozMHMaY9BGqY
         eGpA==
X-Gm-Message-State: AOAM532Na8EQDd0FlupxqQW/G5KNHxNQI7/jTNOhWOagMblL0O5QUsMO
        sxwXlFYEQnr5QSr9+24hrymmGDwGnp4=
X-Google-Smtp-Source: ABdhPJyHupZy2cugbsFgHGZ8p4gJ5YOcfPBkYXZtYFXlhIZnrIVfdN/VaqdAmLOmeEh0xvbMpk/3JQ==
X-Received: by 2002:a17:90a:2849:b0:1bc:50a8:6970 with SMTP id p9-20020a17090a284900b001bc50a86970mr702116pjf.193.1645750792788;
        Thu, 24 Feb 2022 16:59:52 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:52 -0800 (PST)
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
Subject: [PATCH v4 4/6] Documentation: Correction in HID output_report callback description.
Date:   Thu, 24 Feb 2022 16:59:34 -0800
Message-Id: <20220225005936.3485405-5-dmanti@microsoft.com>
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

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 
-- 
2.25.1

