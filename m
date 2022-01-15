Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA648F472
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 03:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiAOCbt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 21:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiAOCbt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 21:31:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D991C061574;
        Fri, 14 Jan 2022 18:31:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo15863095pjb.2;
        Fri, 14 Jan 2022 18:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LYyiuzySTYab5AWLbomJLC5ogjyw6DZmtGr16Spi3E=;
        b=jpb8ngPDg5sBk2N2+l4ikHcCswMle9uZ87K5oKIDuO2ou6D1LqhBiP6y6EhaY5pN5I
         dXTLZf5Pi+o3CZVsS6NuzaKZEddLtK0V7fu+fAiYkeYVTf5Nq/2hNex8VWTqQtCGI00o
         VzkqtckNr87jJXxjl6CZN3ovMvJof8rrE/XHbuERfQfYe7Vp/oUIj8FjKlTrW1Aek4ib
         MyBlXa818RXplm2+AbU/ynNEViXUL4bszVk/XRBBswAKHoKzOO38QDWM87G8Qya1L4iw
         /io8sycgRRqq810riY39TYZ0IvOEL+voCwM6Ej2eT7vmH6QHjPAMEyXIwcnGJflQEf78
         e/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LYyiuzySTYab5AWLbomJLC5ogjyw6DZmtGr16Spi3E=;
        b=egy9y4AmLs9pmS5xddThZpX1VxWOOpMQe4OBzx1hZjSf9ntGfyO8dG5UKiUW/nTwtd
         +/jNEtggsx3WtsatHyn0pMjV3W++mJnnsPXtYLXJpdx549CXdiHQLPzYyrVZ0LxLck/U
         wiEXzMZnB90cbyWoR9zbragi+Wk1wsWlHaFp+GkE5DvtKRr3NUT+5swraSdqIrX7RLcW
         kOLv+DppdYRePgPL5smYR0G8e/wXXGySL7HPdRV7BoRyupXpG0RSXzpcvCZU98sTQb9P
         A2XqgL/7+EojgYzgWk7Y/OVAGNcjYfSJWENOjAdPFcZ27hX8gBapM22tPT3IRFa7fxx2
         un9w==
X-Gm-Message-State: AOAM5304cBxhGn8600KUXHvMgW4Y8Ia7ubG49mcNAym7kUl2GFF+BKpU
        dE8zoOcH2HSdTkH0O4uaWXaccdSlByQ=
X-Google-Smtp-Source: ABdhPJy3CBwXwP3ySNgs3tgbKhuu162jzusA/2ZGuzdIA+G7SY72orWpxHg5O3mCkHtL9w64HCmDzw==
X-Received: by 2002:a17:902:6b83:b0:149:7cb1:9582 with SMTP id p3-20020a1709026b8300b001497cb19582mr12322638plk.29.1642213908729;
        Fri, 14 Jan 2022 18:31:48 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:38:6d64:e944:7a7c:3d])
        by smtp.gmail.com with ESMTPSA id oo14sm6874500pjb.34.2022.01.14.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 18:31:48 -0800 (PST)
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
Subject: [PATCH v3 4/5] Documentation: Correction in HID output_report callback description.
Date:   Fri, 14 Jan 2022 18:31:34 -0800
Message-Id: <20220115023135.234667-5-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220115023135.234667-1-dmanti@microsoft.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

