Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507C83F6FEE
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 09:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhHYHAp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhHYHAj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 03:00:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5BC061757;
        Tue, 24 Aug 2021 23:59:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so3424783pje.0;
        Tue, 24 Aug 2021 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFpf8RU15NkLWOMr/fkVlT69rnqXnkxOOLlTCrdr6jE=;
        b=orAm+YPkRyT98Ylo/OKnVHcHRRmQLh761adWc6c8lBziwHPlMWA5HlfL7G+rwkuXtA
         lrX93y8ZjgaGeFI9P+PWpONKJpY1/kcwiWhsbsrsEveF5hg8Dxvpu9ir3eDQELxaJ4GU
         7SeDoYaabSVGst5ncWcLX5DbVZXhoAQb7BCtnfxPRynqzkP338A54Lb1u9WWTc4Gnrm9
         ZgPVv/dxjMvV8CIdlA5KtAdMklYjoY3EeGPNwcEcjoh7t1DixXf3pM7Lhy3tTBb9tPUT
         YOd4XyMLXky3Ly362XCM42+uvNGiTIs6ZUb0Jil/MHLim9r1YhZI/cBUFVOCTxQGYYM4
         +/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFpf8RU15NkLWOMr/fkVlT69rnqXnkxOOLlTCrdr6jE=;
        b=gcRZlwzN/pkga+ij5CpRxVXWkP3N7AJ6lp3p/sL0SPp+09YnTeFwHHf2WsMJji+KVM
         gnxgKOD8v1h2Zu1MTXqYdM0kdjR79/nmeCPfgM80Mhkh7F7fSBXR91yQoI2o5gCd+NsU
         ya0yTyG1z6VqNwV+vpJVEXJVNRss8LQ+ZakualRnKUK/Z3TdqzAzKd8FT+0OwDG1hXFK
         aKe1KI8TpRdCzU/Y7lLU4GY+0iTSgwAJfMwuukHh3wT8EKqJcXuFLe/aNFaw9PnY+JXS
         e2+qsCeK6O8PC1IIC4m0ASkPMmM3GPfNNIvivuOaij8wxjdma3iGRUkem1AI3XeiO9cC
         zogA==
X-Gm-Message-State: AOAM530vN/fcMAOifWGSPpIWSaFwi9AJ4OaOk6goQ//rtuYlEr5vkGie
        fxf7Qv7b381k0r4gCUpED1c=
X-Google-Smtp-Source: ABdhPJyxaH+Pj+OwqSQdR2Xd0ML0C0ZPFoulVdVPDYDWTVxsZ4sNu7WdufZB+9rYPYXPwIuqzlQGnw==
X-Received: by 2002:a17:90a:7c45:: with SMTP id e5mr9074287pjl.141.1629874792661;
        Tue, 24 Aug 2021 23:59:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q102sm4443109pjq.54.2021.08.24.23.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:59:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/3] dt-bindings: spi: add sprd ADI for sc9863 and ums512
Date:   Wed, 25 Aug 2021 14:59:31 +0800
Message-Id: <20210825065931.2111159-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825065931.2111159-1-zhang.lyra@gmail.com>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
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
index 3e399d31168b..fe014020da69 100644
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

