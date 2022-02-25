Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C14C3AA7
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiBYBAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiBYBAQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C12804FE;
        Thu, 24 Feb 2022 16:59:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4so3458922pjh.2;
        Thu, 24 Feb 2022 16:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyT2GuPTXkTjkm6mgXba55Gka6UiyKyqHH8exrFhwZs=;
        b=INX2p11o5cxymZOBn5JdiSz4t9cclINTplxsmdL1XPsEy5YFGJsgX9fPWHvAmSG342
         sIs8q4ZZGt7ncnxL1bM4PixnbA58s+BXbWtd7Sa9Qw/Y2v/IF8VMxnmyGfNegxynBOB+
         /w0aGuEEtrwZe+VwhK501ZPDtVpJsymi2Qa1xiFT4n9Me4IIVh8lRsefqv9AaW9dhh4N
         g6C65x7fw4OwN+bguVgP/EuoXgj5sWpftI+oV7t0ZptCcy8S4huTa6y875yrEMUNIChn
         tSVMF3LBSiccWDr2Xe/hGt7mYdv/9zAzUw6hp2xO/9xmJYIXtpaEkUPRP2W1QegkC2a1
         ENdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyT2GuPTXkTjkm6mgXba55Gka6UiyKyqHH8exrFhwZs=;
        b=N0blV/vpUzsD0etyEU4xR68whdpHZYtqvdodxGYyeiGKg7YXrSm2JEn2Rz5Q+wDZLg
         s92ZUb9BAmoUMZK/HJAdo4iNeIivLHu7vp2pYZc+sPLL4YzN7filtUQADIkTNVjVApd6
         uFLrkOeaZ58JGBPD45ojKjey9bgPhbMgqmyfgjogf48csNE7r0ZutUE9pZ41XRpgdNY5
         TAvYMx1D1t97br4aBz/OzHTukgfh+eMKc/9EzzW7wEUn4TDSYP3EWhYn2WcUWCaJJ+bT
         nyaDM+CJRyZhVPPWBB2LlDxnb2IdzA8pJys7VlXzNbm55hBAzZh8Cn5G0Vwt6gCN0Y8H
         WCig==
X-Gm-Message-State: AOAM531tns+Ws4FHsK+8A7SDZDIDYzJE+Xk2wbF6CDuW4dCHOSEo3sWl
        P9LMXSbHNaOrYgVGpuTQicI=
X-Google-Smtp-Source: ABdhPJyzrKjtyL/s5LlgGiZaXsisYkfPP5OGOZFr0WRnbRaRTX+pgHBLEX43sM5iWvml6X3M6JBxHA==
X-Received: by 2002:a17:90a:2c0c:b0:1b9:fa47:1caf with SMTP id m12-20020a17090a2c0c00b001b9fa471cafmr735590pjd.34.1645750784632;
        Thu, 24 Feb 2022 16:59:44 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:44 -0800 (PST)
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
Subject: [PATCH v4 1/6] HID: Add BUS_SPI support when printing out device info in hid_connect()
Date:   Thu, 24 Feb 2022 16:59:31 -0800
Message-Id: <20220225005936.3485405-2-dmanti@microsoft.com>
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

