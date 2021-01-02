Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A32E8732
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbhABLzF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLzE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 06:55:04 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF97C061573;
        Sat,  2 Jan 2021 03:54:24 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id k8so21040547ilr.4;
        Sat, 02 Jan 2021 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+jIrXGESdOQtBefzWtZLA4kpu1nBEQulHABKRZimnA=;
        b=RL1E/y8Xffsed+lHHUOonOwgsSpZs4tjgzclG0xxW7rVYNjE3I24cwMZ/Y9UiWynOm
         WtC9dca8thAfnfeSN+zYP7ZTVEf9Jyk0HPmzZ/S4kxcRJoafQbfMEIt9wAQeOxW6b5Vh
         BxO+8xP/xUeYf7DHCMT5x54HFuQcE6XvNsiu3qE0LJ1GEkClpbIFJhJ7zdUP23Q+nB/H
         Q/OnspaAPRFDFzaXW+9WrOUxOBfrZhrANwFZUAm23GOpwNp57GgKv+jRCaVCbVIR6fP+
         TE8yTz2AdkTtf1gD3aV0v7E1b4uF3DFOBgpy3PAx8el71u76gkhf1czdItQJKvUEteof
         CxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+jIrXGESdOQtBefzWtZLA4kpu1nBEQulHABKRZimnA=;
        b=St70b+eS75asYRF8qag37TJ33ZcMktv95uHhOou0Kf9JldQfLdh1YQR4b2wKXIRw9N
         RdoK4VYo2tyreFE3Bn0TwdDGfNt24Of6WBn5Q4rL4A3P9EL0Rmfp2s7tiG1ssHxmKjWP
         VuyG1KEeKUgPurVRvCbDWsr6KXez4qViQVkbOYuSS8zn5FtY6hNK45DC2A+t6Z2V0oij
         ylno2pEdQ6gZ+aDZmYL+eR6WM4b0ihxaNZUWnWDnUodHN7ms0pQ50OFPQJFkiKXIf5Mk
         4O+FTq2ncNY0vJXGXuGQCfCF2gtV/qbRJMi9kZlomCc3fiyyVk2j7f8Jou+v7IyrqIXb
         6YoA==
X-Gm-Message-State: AOAM531Xe75H/VDUQbtx/IrHRbcsJ4v+wbzsWwHWSSvgwkvqP36d3HRs
        vTDQmOHjihRUY6D+wtLLYqQY6U24Mtxu4w==
X-Google-Smtp-Source: ABdhPJyBe3ahe0tS1nlWYwA0x4B+LRuX2MnMLeazUjjQETd7K0c8kTHLw8KP26oXfSLIYVMKz0ZyKQ==
X-Received: by 2002:a92:ccce:: with SMTP id u14mr63354835ilq.152.1609588463278;
        Sat, 02 Jan 2021 03:54:23 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id l9sm37218245ilg.51.2021.01.02.03.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 03:54:22 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, biju.das.jz@bp.renesas.com,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH V2 1/4] dt-bindings: memory: Renesas RPC-IF: Add support for RZ/G2 Series
Date:   Sat,  2 Jan 2021 05:54:09 -0600
Message-Id: <20210102115412.3402059-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The RZ/G2 Series has the RPC-IF interface.
Update bindings to support: r8a774a1, r8a774b1, r8a774c0, and r8a774e1

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../bindings/memory-controllers/renesas,rpc-if.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

V2:  Updated renesas,rcar-gen3-rpc-if to include RZ/G2

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 6d6ba608fd22..990489fdd2ac 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -26,10 +26,14 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r8a774a1-rpc-if       # RZ/G2M
+          - renesas,r8a774b1-rpc-if       # RZ/G2N
+          - renesas,r8a774c0-rpc-if       # RZ/G2E
+          - renesas,r8a774e1-rpc-if       # RZ/G2H
           - renesas,r8a77970-rpc-if       # R-Car V3M
           - renesas,r8a77980-rpc-if       # R-Car V3H
           - renesas,r8a77995-rpc-if       # R-Car D3
-      - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 device
+      - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2 device
 
   reg:
     items:
-- 
2.25.1

