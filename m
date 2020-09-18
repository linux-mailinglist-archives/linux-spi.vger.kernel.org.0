Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B526F849
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgIRIbf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgIRIbe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 04:31:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB3CC061788
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r19so2633899pls.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvN8pxwgE7chvCn8eA4GpYEwznUZIJ/VvKJ2b3Qxwd4=;
        b=ho/WCQgsyP2T8AA27LL0ARkfh0DQbo2WgLWH5gjFVNaznwRwo+t+ptG595Pu6YLKGw
         qhehK+iBJs4G/tcDQjcXcOnFdqIanY7E/JPg24pUtibT4vfys6d71/FmGjVFn0E0Mzgh
         hpmCCmwd6/MU0P3i5PsfOmM00Dv5mJszaEVeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvN8pxwgE7chvCn8eA4GpYEwznUZIJ/VvKJ2b3Qxwd4=;
        b=YbwKQh5tTSHIoD3MkOfOkByK4uIPdlNZAcSGD0jhBMDm23Q06qrKV3Fo4EPf04lACL
         AlNc74PVzVcm7dWjkyC5yuDJXYvqJyLYM+eRKRxP5tMpdX6kvTB5B9Emty1ZDafTjAGJ
         G6ZbXGZc3c3C0QIqfKmq0BiHTVU1UOGP9G2SzWN5m+t45M4wia8up0ya/cngkMV+2jaA
         Xi9ooUtjbKw7Iq+OXdqEEwY64N1+FoErdqFaO1CMGq09x7V0ndio4PIru5g6e+6eGWiJ
         hJMIAruSTc8i4cOHQamH1gjv9UVi+deOIo3Y6Fng7u3tOtz0Ow/iskVx4YahM9TiRiB3
         yFZQ==
X-Gm-Message-State: AOAM530HyhqPqAvWxN2roomT54sTArZu6ljSX/lUKiNXNYus4bZwODpw
        /XUwPQojgwvtQKFwa/LPxEr40A==
X-Google-Smtp-Source: ABdhPJyawkWvCG6/EAZZzyOFtimPgIC4x1PEVJj+jcavaFIrRX3LyKeVJ3w44lldJhWt/SyimTAQ2w==
X-Received: by 2002:a17:90a:764d:: with SMTP id s13mr12124753pjl.58.1600417893754;
        Fri, 18 Sep 2020 01:31:33 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:33 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/5] dt-bindings: spi: add mt8192-nor compatible string
Date:   Fri, 18 Sep 2020 16:31:19 +0800
Message-Id: <20200918162834.v2.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200918083124.3921207-1-ikjn@chromium.org>
References: <20200918083124.3921207-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for mt8192 SoC.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 42c9205ac991..55c239446a5b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7622-nor
               - mediatek,mt7623-nor
               - mediatek,mt7629-nor
+              - mediatek,mt8192-nor
           - enum:
               - mediatek,mt8173-nor
       - items:
-- 
2.28.0.681.g6f77f65b4e-goog

