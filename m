Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3B145EBB
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 23:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVWqH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 17:46:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgAVWqH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 17:46:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so979463wrq.0;
        Wed, 22 Jan 2020 14:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUZxqXCTw8R6QCBbI197sah0uzk3QRUQFWT9ZOyB7Yw=;
        b=ogBzJA9dCiPDKlIna4Bucj5L7dAS8xsMTknUwWz+zmlCHETAflT6aML3KdCaPEEPl9
         i5+uApmpVcAOXZvfvzYqcBYYc9wFZaKZvZjyRNZyYFrHrPDoG3q8LIlbdhjAv6sHyXaM
         Me2d4nLWFV8X/iMcUaIf0w/aqa1CO7il0kH6GPQ0/R3gOwy0eF4JD3ikRQFgdhv/GdP3
         l5o1wEVwOL3uucpfwD3eDRxPDpNI5NkfIPkyTMIzOZsRJBd7VjDEns6XKkvBPn0MZ3zl
         5e/8PZlOmhvGX15QtBygZgvWoYLIvV5cwS8EP2mV/8ZSinC3RLgqudno+ItfJKXiNZRN
         3kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUZxqXCTw8R6QCBbI197sah0uzk3QRUQFWT9ZOyB7Yw=;
        b=sI4XLRePSQe8u/YCg2vXFH/ubHKtGkIYd3RQ71Kb/WiExY4JHYaV01spF29pymQezs
         /bsOnzcA1Y0ejcvxlkGLL6xzoaRM5KXM8rogbxAo4lTi2ivLzq2RM5WWQJzi+g8IHmJ1
         zkqJVq7dL+ejW8auIsRGV3MVywtTad0RLeFUETbMZ4hGM7gPP8uhEHy4nXPEOelaaU6g
         au1vRqcXIWXo3BBra1ekM9IYPBMOSCCyAsKNmw+AVdK1+2Y5JrBMzLc2UM/JeL5H1BTo
         yFSArKQgTKcxprvjhW1WJRmDeywssMbxHJBjSJonhByzz8gjh7pnj+jwP0P8/nDIkVU5
         7E6w==
X-Gm-Message-State: APjAAAUR9BAwszJkM02SgWUwfcdojInuL0K6/CkRcwr3BV/piFgS7L6D
        uHq82Wa0Q7diNy+unZZVBjI=
X-Google-Smtp-Source: APXvYqwv+FPTcvtz3itSHxg+QI3+P6dzgJihxCbSWochxhZPiMdt4J9IWnoCeRlGJMyGwNcYMl+E4w==
X-Received: by 2002:adf:db45:: with SMTP id f5mr13294137wrj.418.1579733165530;
        Wed, 22 Jan 2020 14:46:05 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f1sm342559wro.85.2020.01.22.14.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 14:46:05 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: spi: spi-rockchip: add description for rk3308
Date:   Wed, 22 Jan 2020 23:45:54 +0100
Message-Id: <20200122224555.6845-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200122224555.6845-1-jbx6244@gmail.com>
References: <20200122224555.6845-1-jbx6244@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3308 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index bca8c6142..a797a4748 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -29,6 +29,7 @@ properties:
             - rockchip,px30-spi    #for px30 SoCs.
             - rockchip,rk3188-spi  #for rk3188 SoCs.
             - rockchip,rk3288-spi  #for rk3288 SoCs.
+            - rockchip,rk3308-spi  #for rk3308 SoCs.
             - rockchip,rk3368-spi  #for rk3368 SoCs.
             - rockchip,rk3399-spi  #for rk3399 SoCs.
           - const: rockchip,rk3066-spi
-- 
2.11.0

