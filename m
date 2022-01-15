Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAA48F468
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 03:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiAOCbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 21:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiAOCbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 21:31:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0087C061574;
        Fri, 14 Jan 2022 18:31:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a7so11879049plh.1;
        Fri, 14 Jan 2022 18:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyT2GuPTXkTjkm6mgXba55Gka6UiyKyqHH8exrFhwZs=;
        b=W75GLu+42tfV7cdy0kMarHl6U6ipEYPQhL//Lte1qZZshjUFLREEmVQ0p1bKSGjiwS
         GHpnItl400LO03SBGzStQ2U4mAzJpxrbd9YmB9dnSjqSmXbCcHOEMc80dHUKn7V2vQE+
         WV2zAqHdaOd8Awu4CgzXs1otFs50NKbvmfP5FCcN/B7TNQIrs9HJBOl+6r+i7GxKxbU7
         BOWadq50jfBZ+598VvdlY8a56Tv31Esn1K9vPjxhfjPed4tYgu/FsGLw/9VevlpUmmns
         sFMLZcYVZptiNBTVFlqA/TdSmxFM8msW0Jt3AbANnD8r3RhGUmExhGBx9pyweGR1r71i
         sT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyT2GuPTXkTjkm6mgXba55Gka6UiyKyqHH8exrFhwZs=;
        b=JIZrbQo8412HgUoGe62I2WVsxC3mYCVBlpb2foBv4/ZN6r3BB+K3i9806oDIUVKaTj
         0V6tDfi/JomWV0XJEu/3xTcobczo4HT7PhVlwpIL+j1SRzgBsmjeeE6raDJad4m3LAb5
         EzbcVobw0Gy9k9U8fBSuXWk/dn9jn3dHHc0uWOKHSeeUtmeRt8FQfZvU9ZLmppYn7syt
         5CC+IxXQAFceJ4VA3A3w5xQS/BwyO0pJJTqz8OD0+qNUw+GgtQJZ3sPClAS1RMjPyCnq
         Nm60orAA90HHUjBxEPWOMyMwoKEysnl2/2xNtrl9v97dqHMqog9iRaZrlJl33oMSsZNP
         W0+A==
X-Gm-Message-State: AOAM5305ddBWZM4nsps63AM7wD4X6HcNSJatKNNJnBm7zWo/VWLWXB2j
        c3tWOZUfcHJ6f7KuH/NVty4=
X-Google-Smtp-Source: ABdhPJzuAtQHkhAuLnzRJW08GmXAXOoEbangJqsM1EGK5mbdC0xHs3alWE8z3y5WYVAWU5T61CBWjA==
X-Received: by 2002:a17:902:bb97:b0:144:d5cb:969f with SMTP id m23-20020a170902bb9700b00144d5cb969fmr12152844pls.36.1642213903222;
        Fri, 14 Jan 2022 18:31:43 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:38:6d64:e944:7a7c:3d])
        by smtp.gmail.com with ESMTPSA id oo14sm6874500pjb.34.2022.01.14.18.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 18:31:42 -0800 (PST)
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
Subject: [PATCH v3 1/5] HID: Add BUS_SPI support when printing out device info in hid_connect()
Date:   Fri, 14 Jan 2022 18:31:31 -0800
Message-Id: <20220115023135.234667-2-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220115023135.234667-1-dmanti@microsoft.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Dmitry Antipov <dmanti@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index dbed2524fd47..65350ad985fe 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2005,6 +2005,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_VIRTUAL:
 		bus = "VIRTUAL";
 		break;
-- 
2.25.1

