Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4214C3A9C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiBYBA2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiBYBA2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6A2819A5;
        Thu, 24 Feb 2022 16:59:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso7134568pjk.1;
        Thu, 24 Feb 2022 16:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6EWyaMMYxkR6QrMTTPuTdCMdFqQCShfK75s5KB/a8bE=;
        b=iYYYyzct1rtnaZpyXdDkdwkSaiIq3evKHmOH/5cvawQxAR7NXtzbuE+79MrNsEorq6
         kxbt1/Gcba227rimkySrhpSRiGNBNNnsHzh6IIReC9X87nYWye5oBVxQMd4RlVszQmgf
         xxqhyOh2yIqz6yYsEHTQSmADgaVZyvu+78ebE2UpnaAr0u60Wn6YD3y9F6dPThNeXbiT
         yXmCM/7gM0LhSnpgg9HT9Z/gLypO/yNOPBk/h2IS3Om+SCXEDtAFoLhg3eoubR9NR1lv
         hmpTiGnuRydO9IQ57gZkTZPqDPb9XbnXUWqmnZgSNyF1okA5GRnRH4ctWoqqIGxazzkQ
         B6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6EWyaMMYxkR6QrMTTPuTdCMdFqQCShfK75s5KB/a8bE=;
        b=0zXj1tS+TNZYRejowC//buQFTz1GuFV2aBdHy5h21mEaas2vzION1f5epPfG540T6N
         Si8jQ1GIL2pfc7vUmKVc/6u65fp/UbY0KvCX3BYrh318ttYS/MzkhqNm6zRTyWX6LCXo
         j2XYGwjvPfNwLMBIS2/tVZ6Lmy4HgAZt7nfPnuHHquYuaDDXkIXjwgisN1mtUt6rS3Lr
         RaAYOGOAamEqeU8MHQlHq0li612F6icbqP8om+jIp9OGYvLjpr4zGwsqGLUojnF05E9I
         Fqp+3B5267TwoTRp58LX/bOcVmUe5jbu1+9mzut+jkLTg3+QabDLrU85j2BRjVa7yHGS
         C2jA==
X-Gm-Message-State: AOAM530gmgmZgkhaagRVTy04YmF0wLqaqaqYwu2YPoS95LXibUIz+diq
        YCH7FfWYi5cFejLgZSqUfQo=
X-Google-Smtp-Source: ABdhPJzFh/y51RKbBE4tS0+AHOx5+Wqi0e85dya5bsiwNEplJof1+O5GnWW4yryTtinnJG3oiciE1A==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr5291975pls.81.1645750797131;
        Thu, 24 Feb 2022 16:59:57 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:56 -0800 (PST)
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
Subject: [PATCH v4 6/6] Defconfig: add CONFIG_SPI_HID=m
Date:   Thu, 24 Feb 2022 16:59:36 -0800
Message-Id: <20220225005936.3485405-7-dmanti@microsoft.com>
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

This enables building drivers/hid/spi-hid as module.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..25249a4b0c8a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -805,6 +805,7 @@ CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_MULTITOUCH=m
 CONFIG_I2C_HID_ACPI=m
 CONFIG_I2C_HID_OF=m
+CONFIG_SPI_HID=m
 CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.25.1

