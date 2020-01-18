Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571B3141A61
	for <lists+linux-spi@lfdr.de>; Sun, 19 Jan 2020 00:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgARXJC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 18 Jan 2020 18:09:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgARXI7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 18 Jan 2020 18:08:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so25940278wrl.13;
        Sat, 18 Jan 2020 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zieK1rZ40R+8dR9w9wxIfPfmZcLHznAHvHJSGV+7afI=;
        b=WcOPjCFxbQWN8I82H5+ql2IT5LtNNZEE54Ef1UQEznrAlFFQXvjOAAp7l95UefDFNS
         sM8rfr3puhtQih9QwjB8lgLbpQW+1pl84qKR1dtOyHoj80fgXj14bSdwyBPtD4nCBgAu
         r4JKfQzwqy/2UdJotQ4fW8GH+X3hrxLYIAmUk8XmbYO67tu4LW/XAwM3qUfWN6L4jWVi
         uLNlfl1Bqm7jOCu8h76EFoIQkUw8VSsfYlFjJ8qj0gZ+6vmWVgbnVEB+ZG5tk2ovR5AQ
         VWv4+iOzUpx7qNTcWQhFq02mgr0DZvKT89oxZ7tRKJ8XbA8m5m/BtpgAU6aHzrPrFkiy
         Lmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zieK1rZ40R+8dR9w9wxIfPfmZcLHznAHvHJSGV+7afI=;
        b=k9d05YY1R+Oldzoj5eAqKOugxY398vK0rMbavKOAOFs8lpfQQNpbIPNmFcQFDzSJ7V
         rQ+yQxoX2BEqmbnmDnTSJYbmB/sNeq27Wgbq3h6A6M/iFSafVXGdC0eneZVgHhudhUkh
         MYFKhsmhI/WPIaqNBS8Pw6i1bS8bldAz2i+Gd67G2r49+CU+EvYHYR1B6AjQSRw/7R+z
         41ziMIvxpqQ/Ziwo3EeylGUszVYDknaNNoLzdt7AlqVTmcth0tRU5lyDA1JHoYCJ4EGS
         f4iLkqn0qnDCiBlVqi2eLxuCq4Nsvy13qCEK9LE4o05bm/73DH/jeoO6iG9AxaKTpMeG
         y2og==
X-Gm-Message-State: APjAAAWoTNxOuD18BenqFzpJCmzu1R9A6NoyqaFpHA6L639QcjTb8sfV
        +IJtCfpnQP/Ord4mzYba5mM=
X-Google-Smtp-Source: APXvYqwUVkfqKTEe+IdcTJGpN/Oh1StsZugRXWPB63ViZ0Prt/rRHknvczy59Jrcs1kniRrGyk/cBw==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr10351910wrs.11.1579388937355;
        Sat, 18 Jan 2020 15:08:57 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x16sm5746408wmk.35.2020.01.18.15.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jan 2020 15:08:56 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/3] dt-bindings: spi: spi-rockchip: add description for rk3328
Date:   Sun, 19 Jan 2020 00:08:48 +0100
Message-Id: <20200118230848.15326-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200118230848.15326-1-jbx6244@gmail.com>
References: <20200118230848.15326-1-jbx6244@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The description below is already in use for rk3328.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3328-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3328 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 24d9567a6..27b2d1df9 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
             - rockchip,rk3188-spi  #for rk3188 SoCs.
             - rockchip,rk3288-spi  #for rk3288 SoCs.
             - rockchip,rk3308-spi  #for rk3308 SoCs.
+            - rockchip,rk3328-spi  #for rk3328 SoCs.
             - rockchip,rk3368-spi  #for rk3368 SoCs.
             - rockchip,rk3399-spi  #for rk3399 SoCs.
           - const: rockchip,rk3066-spi
-- 
2.11.0

