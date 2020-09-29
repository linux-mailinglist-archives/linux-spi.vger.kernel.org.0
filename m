Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A827BE2F
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgI2Hir (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 03:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI2Hio (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 03:38:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2FC0613D0
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q123so3705049pfb.0
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdWBWycOR7hqnrWkAS/968ffsGtggCj05eK2mj3BCB4=;
        b=FqiS1pLOELhsie1j6o0jtnJTPSFx3IPvc4aqCryfkmmJUh1B0/lgotSCCfhx3/lgVg
         /G1mZmxmqphDiydxkCMDJ/7kqffyAyd9SWG8sQuPAER7/AQ5jD2KhfpSHEZZQwSfYDIx
         izDMSK863QYUkA3qK4I9TsLnrk+Ew2iNq3bW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdWBWycOR7hqnrWkAS/968ffsGtggCj05eK2mj3BCB4=;
        b=TDtHc0+tjCfsp/Ur/qeIBb4958CTSE6Vcw4+y9QDqi8mQp3RxgBmpLhVLYhgIpAGeT
         1zBd8ukC65XK47CwJJpa+1uXw/e9T5ASQWhkeswdf0+8Jbs4Y5fzvjZkGvnnifNzpHrx
         BuG26OcoUIKxOgtrwSGeZtEDiaNybTOgZI7Bf7Y4pyKtqRnE5rPWiVxOc15Ju4rDLQGw
         oQUL34G956QF8vnkrdRDMVgtnAlt9rFGi9Uma3U06mjYMqZUwY7ljN2xj7Vsq5rJHJId
         uQt8OdRPRKtTebW+6/rJ+xcHnJlc7cHhtfpvtKDYHgfwxZ/rCl4toIQykuwbWvPehgwa
         RLpQ==
X-Gm-Message-State: AOAM532dHNvNNRps/DSNugjLvp6fmSylXydHEkL6sbGFSJkP89WxoDKf
        /ygLnfdsXwfFdaXCMqE000yfTw==
X-Google-Smtp-Source: ABdhPJwNuDHXRv+fMFFWAdjedaKH/6FBQiVK43v8u2Xp+S4IkbmZzClOGt3qLT+WtsqfLXTRl0SFGg==
X-Received: by 2002:a63:5420:: with SMTP id i32mr2335677pgb.149.1601365121972;
        Tue, 29 Sep 2020 00:38:41 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id e13sm3737317pjy.38.2020.09.29.00.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:38:41 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/4] dt-bindings: spi: add mt8192-nor compatible string
Date:   Tue, 29 Sep 2020 15:37:52 +0800
Message-Id: <20200929153320.v4.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200929073755.3741416-1-ikjn@chromium.org>
References: <20200929073755.3741416-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add MT8192 spi-nor controller support.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>

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
2.28.0.709.gb0816b6eb0-goog

