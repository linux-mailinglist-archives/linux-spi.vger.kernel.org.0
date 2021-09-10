Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40640701F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhIJRBB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 13:01:01 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35659 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIJRA6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 13:00:58 -0400
Received: by mail-oo1-f51.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so817988oon.2;
        Fri, 10 Sep 2021 09:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxJt6NlBRoIU5qhF/LpwW5GzFZKmCRaUN2HoDgoBYA4=;
        b=HtEEltfn+kOiKXXMFMQFJ5ospb2cL6fOkzOgNebBoXP/1LqYiCRD6xwwHSGS7gu88N
         g65szAWoumbA/VtXWmZKxvPBbj5faHCLicE/DJswdUM1Ce5i9bUmcbtwe6ShyyRUBwT8
         HqMtyXres9ELkZDBOK8yXnbzjRTSNw1XFg30Lnp0kxxHg9VY2klvX2IEL/350SSOSBDA
         oDyGyhShcSIGQpxTFfpZpDVnIWUA2PoTq1+56+0u7NVGGlDKFlJr5R4HeBvrsbek9Fmh
         PYIH2zXz3iAYejwJgVcXQtOMp5O2YUzka7lvxsQGGrL4mVGDXb0rD4rjzBxm7hL+hJgH
         JeGw==
X-Gm-Message-State: AOAM530pfDptkb3fAVxep0Bn68TEJqmuAfrZAESCTEIdTEwZen6fPrNY
        lArnlaFSfIvhrWtgvdcoAg==
X-Google-Smtp-Source: ABdhPJzntCjNiJylxJsfk6Q+QwTwN6J9HrP/4EyEdhxln//eo6jZs+fDU3O9+4kn3XX6jl1vQ/2ZuQ==
X-Received: by 2002:a4a:d48c:: with SMTP id o12mr5227910oos.55.1631293187104;
        Fri, 10 Sep 2021 09:59:47 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id i27sm1354435ots.12.2021.09.10.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:59:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: dt-bindings: xilinx: Drop type reference on *-bits properties
Date:   Fri, 10 Sep 2021 11:59:45 -0500
Message-Id: <20210910165945.2852999-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Properties with standard unit suffixes such as '-bits' don't need a
type.

Cc: Mark Brown <broonie@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Mark, Please ack and I will send to Linus for rc1. After this, I can 
enable checking these automatically.

 Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index 593f7693bace..03e5dca7e933 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -27,13 +27,11 @@ properties:
 
   xlnx,num-ss-bits:
     description: Number of chip selects used.
-    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 32
 
   xlnx,num-transfer-bits:
     description: Number of bits per transfer. This will be 8 if not specified.
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [8, 16, 32]
     default: 8
 
-- 
2.30.2

