Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D263F5B0B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhHXJ3S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbhHXJ3O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 05:29:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05BC0613D9;
        Tue, 24 Aug 2021 02:28:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n12so440735plk.10;
        Tue, 24 Aug 2021 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5stGDS23SnfomsC4fdxwor1QYn4i/qRq+0VkZa4KXkY=;
        b=MPgzRjKNrs1r7y2M7ftbqg3k/oiRUBrXJtlPorFNW0mZaKRv3dq7CH3rmaz9ZezQGX
         VEnZmTC5yZ3oMY2gY6TgNYtfRvn840MH7TLeUbSHRf8yOr05pnT1vsE24oKQnwPpgrQ8
         MAMKXdSFXFwotX/AyrUE+hQs4fYn2OFjvQNWqvJR90k6qSgMW9aT+SOOVBur56r2aCiH
         lb+5k1wagRLSq0bXc6vWKSifBacITiNIkhPgobT0nzhoguARKaZ7w52jGpu1SSh2pfDM
         Lyuxt1RDDTcjPducm+pQxT2x3ZwK40pVV5o1ovDdTR6lTMUXUbaZLCa9KO+ZCVXy5H30
         E53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5stGDS23SnfomsC4fdxwor1QYn4i/qRq+0VkZa4KXkY=;
        b=En5mbYfIA/6GzqzfsfRGgcaYAAaBF5Mcj1r2riC8jDd+r9i7ABEaqFSRr6VxHy0D9a
         XWQfihDiXQej8fMj198kQeKOL6NKmCeG49Tah+vSIun0dZ7ISazH7z/7XyxcEjD8gb17
         H7wCU1nRIUQCvWP1s9Y1G5BtX2c2Ke7KFgbzNk5wbx6TLPeri/tOcr/vsVWMLIyiqnrD
         3LvpfkGbsVxWTPKyo4JxarNSjkYk0wo4ikA4lSh1fMXWVLcPrd6VbXwu2Z+QJOcwMccL
         pItPrwx2Mn3ILkVOrHp/NKlLq32aVRvQ0CE9tnjomtgvN+o6TaHiRFeO23M5so6tPCL+
         LGNw==
X-Gm-Message-State: AOAM531b8+KRHM4Jc40YN1ydsB4BeDULBhMRbqeZPFR8gQKSiVfSivMg
        638WrJWO/yYAFoGiLi4hiRA=
X-Google-Smtp-Source: ABdhPJyF3YORae+mW7D8rJstf8F9nPEjv5C6XR0PDnT/C/aqTruY0FfIepOoo4TlxGgqJ2blvB1bhQ==
X-Received: by 2002:a17:90a:9dc6:: with SMTP id x6mr3556197pjv.122.1629797310230;
        Tue, 24 Aug 2021 02:28:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w5sm21270053pgp.79.2021.08.24.02.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:28:29 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] dt-bindings: spi: add sprd ADI for sc9863 and ums512
Date:   Tue, 24 Aug 2021 17:27:45 +0800
Message-Id: <20210824092745.2093640-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824092745.2093640-1-zhang.lyra@gmail.com>
References: <20210824092745.2093640-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch adds support for sc9863 and ums512.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
index f464fb6033f9..5149a28c3ee2 100644
--- a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -50,6 +50,8 @@ properties:
   compatible:
     enum:
       - sprd,sc9860-adi
+      - sprd,sc9863-adi
+      - sprd,ums512-adi
 
   reg:
     maxItems: 1
-- 
2.25.1

