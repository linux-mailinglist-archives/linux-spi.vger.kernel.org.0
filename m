Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64348F46B
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 03:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiAOCbq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 21:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiAOCbq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 21:31:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC13FC06173E;
        Fri, 14 Jan 2022 18:31:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c3so14649048pls.5;
        Fri, 14 Jan 2022 18:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiBHZa5nz3s5X5wtDcIiG42DYwgMJ7OeGuL/D9inyEI=;
        b=kU8Q55dyUC5aVkq5aDKL62T2v0vJUVTjSeqyx1fzpEFUSJH3N1GXLBl2FxU3xf5+he
         0cXhfjaaW+kCy+XXUuH/cyn3gwHci11IkTkVo9wugDnAuEOercNMjyDTVM8DJ0kaNKpV
         /wmNF0mTYFOVc+pRfhjok2jWGKM8CbBh0C6gC60nrby2TZ5ecjScRDgwKgTXL3kbl3Lc
         wCnGlFKbiNalznE7g2uK+UZeUdZnh8qcLnSXahqREktB/0tQL0GpXQlQBSc2DTW9D3rJ
         lqSTQ9Wbg/ZwvmegfgTUznSHJYyh8DKxLcflwtEQaAa1ulJRk13fJzWntLKk7OqKcR40
         ZvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiBHZa5nz3s5X5wtDcIiG42DYwgMJ7OeGuL/D9inyEI=;
        b=k4lS3WSLKWA0RJ6JSafi8erbPqjvz2dt+wzlpiMkL352zLlAsy+HzTaM3txNxD3Z+k
         TH8vkscDoP6eRXDd/FHB1xkyyQvMWL1EH0jx5zg3vLTvBSKpvlj1McO+pUeH6QdVF6MJ
         /KVLYWfAH1nsEDfwYFe6aA77IpfgtKttL26ZvLE4CZApIII/0fntLOoidsqGE1qS8Dno
         v8b986XTc5K4sSLs/WB1LA5gQ3x/bUGMV2rOWqbD5CCyT02IhGiPGSzTrqfXG9L3WT7u
         fkk2GZhPcVfq3i6jBGXISzZwhx1DWGHdoGrCOAbOyi4iOehyYgff8Qf3Tvin61DQcCUJ
         XhTQ==
X-Gm-Message-State: AOAM530LEMfLXXJxo8mLN6Jr1P4deoNE2gnBjXvgy5Rugnc/WzZ/yLlx
        mUhsWMyXkhDG3EX0LP1IDNM=
X-Google-Smtp-Source: ABdhPJxuq0h8hT6yf+3toAYZJXIx4SIBUE47sb9uPx7FLwZTwL+AiOzbDrUOEQEzAB4yhRrYWEwkkA==
X-Received: by 2002:a17:90a:b389:: with SMTP id e9mr7121153pjr.41.1642213905485;
        Fri, 14 Jan 2022 18:31:45 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:38:6d64:e944:7a7c:3d])
        by smtp.gmail.com with ESMTPSA id oo14sm6874500pjb.34.2022.01.14.18.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 18:31:45 -0800 (PST)
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
Subject: [PATCH v3 2/5] HID: define HID_SPI_DEVICE macro in hid.h
Date:   Fri, 14 Jan 2022 18:31:32 -0800
Message-Id: <20220115023135.234667-3-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220115023135.234667-1-dmanti@microsoft.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

