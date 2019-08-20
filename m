Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258FE95DD2
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfHTLuL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 07:50:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45061 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfHTLuL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 07:50:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so3232599pfq.12
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V62B7MzFnAQFSzASsarq3v0djmwNSddXSYLopfjS1Eo=;
        b=ScEWrsJXHGFfgfFMY2FsWP9lREzHrPxfZO9vf5D6sHuSaUmaFMTy3r4xIei2Xn3YGf
         zBA0axb3AXgu+onhYcy2goP2JUTH9W2S8Uc1ASn4y8PVGf/ELCU1M3phdGE1RBLquzQx
         AdIPKgETAzzbisuI3l7jTCMBDOSvohxLdXno2aBhpKyPjpTCJ7aPVzD8HxLPgmV5R7Zl
         Mec6MPgw7hrCnaEUAnKw+DCBl6TAio9THMD80bJxvZDH50kGEVt8OXPW/eKPbJJF47LS
         Wx30u62HO6/i88zEdENBGt1aDnqr6dDhmV626NFEDA7ytMhNur8YA1+I5swpn6vWWG6m
         lLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V62B7MzFnAQFSzASsarq3v0djmwNSddXSYLopfjS1Eo=;
        b=anZJzaq+6AfYu9lESjqjUH0Zaxfi5bzWchgzREbaUfE88R+nG4Lnif0VX0o7FFa87Z
         nuz8K2MuEV7TVinaambkm4yFrR3/ciuSahqYkKweN6bJRNPr7BzMumHPU10lduBIOgIE
         oiQMRtft0mhOSoadbT/36hFG5jGwdH65bVprawj3ZbQeWMCQU0lX11+RqGxZ6doFvrmg
         TxGYL63ZPe91gXI7iH292bgQgyXbALB+UvozqtwtJ1Kl/Pw4K6X2rcXwMhscrXmPHdjT
         n0Ie6wcKBUDAEVbeRh0c270kzuJqsQyy2xr7ACLKYHDBo6JLBTAQfnunVwV7xsXeyZzr
         7hyw==
X-Gm-Message-State: APjAAAVfv8zERQatU+rAlxZqdh96KHU5bfjGXwOg2q8NJThbVk1O00fj
        MDPwLDiAwQ9zGGudHEgczkiswDCGEw==
X-Google-Smtp-Source: APXvYqyIq9u46qpIg74Hhl59xxqv6vSE/u8JTB2HQGcXLhPhYLNXH9xyP2FFRD2/Z8o7wjdiQbI8zg==
X-Received: by 2002:a63:7205:: with SMTP id n5mr16649825pgc.443.1566301810071;
        Tue, 20 Aug 2019 04:50:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:8e:d798:d100:fbc2:f9c1:80f4])
        by smtp.googlemail.com with ESMTPSA id e10sm23454832pfj.151.2019.08.20.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 04:50:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: spi: Fix the number of CS lines documented as an example
Date:   Tue, 20 Aug 2019 17:20:00 +0530
Message-Id: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The number of CS lines is mentioned as 2 in the spi-controller binding
but however in the example, 4 cs-gpios are used. Hence fix that to
mention 4.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index a02e2fe2bfb2..732339275848 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -31,7 +31,7 @@ properties:
       If that property is used, the number of chip selects will be
       increased automatically with max(cs-gpios, hardware chip selects).
 
-      So if, for example, the controller has 2 CS lines, and the
+      So if, for example, the controller has 4 CS lines, and the
       cs-gpios looks like this
         cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
 
-- 
2.17.1

