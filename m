Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA8179827
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgCDSmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:42:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36313 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSmQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 13:42:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so2958890wme.1;
        Wed, 04 Mar 2020 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Taz9B582B17QJFHq4vnyy3ks6+/Yxqr+YFZUhRft8sQ=;
        b=JOyfmgSGO+maesgkLYYDa0CJeG7EdGd6AzUXmExJB2vvYlruA9zcJHaLaBClmeMSEs
         q1SjIwXR4xJfZLtV5cXNlVWfBv1EWzNZj7Rnh5EnLDHTGsYSlDX8njy2SoiOjEX0qoJs
         fQeoeP1NW8tmls0GKQkkLWdpUU4NADd7UwAuXobByJrORXReSn6EuqRrBC9wZ4dmUnVf
         mgHxVCrA0eSDGpUREUE7knc8U4GsHJsZmuypfQKeij2bPTwllOH0Zcvs1fC3PbH3oF1J
         R24Umg04leHsDw7iUWZm7DPtnqwGavl/ldcx8UG21M2VWrkZQ/qpApMVzzu0jscUjmLs
         kmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Taz9B582B17QJFHq4vnyy3ks6+/Yxqr+YFZUhRft8sQ=;
        b=i+aYYx9IBeTgh0aVW1acoWb19RRUIrxWpWdkv44qZbPLF+zWTuR/mFT0SPyjTvzVMz
         DSZ8dwd1igNItoUhpYq/dOSYrC6eCZiPRxY6KUWUWXigkMX5FRebuzflZdtGAXEtvorL
         FDxWHqhCoJVC8FXbL+r2wv5ITpz4vEU63GmXtoG25RIaGsetfUShqfH9oOGGzA5Bbw1e
         hG19hYukrKzF27fTzJj2HADs/Kk91budlMKX+BHk2hYWfzlcmwA9x6mM8cC2jFB8eQWj
         39LK6mydff4EXlckNruEIYZLsgR7a3kr6Zws8SFOpNvDvymoVwk51H+Ir/r316XdC+Ab
         mwnQ==
X-Gm-Message-State: ANhLgQ2CKsVQ9Dcx5RQsquI7A8RYG8Gox/IRLnF4j2+EMQJ6dyAx/kdi
        NnCQrHupH25wNTa1zDkb5ZI=
X-Google-Smtp-Source: ADFU+vu89SUtNLXOa0wDBls7mVKttadFUyRVC8wIrTXOR1+RiC1XClyH+9OgoeF0Ll5q4Sa3ayoZlw==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr3634960wmk.121.1583347332383;
        Wed, 04 Mar 2020 10:42:12 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v11sm28175848wrs.54.2020.03.04.10.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:42:11 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: spi: spi-rockchip: add description for rk3328
Date:   Wed,  4 Mar 2020 19:42:03 +0100
Message-Id: <20200304184203.9548-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200304184203.9548-1-jbx6244@gmail.com>
References: <20200304184203.9548-1-jbx6244@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The description below is already in use for rk3328.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3328-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3328 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v3:
  remove some comments

Changes v2:
  add acked by
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 456896e2d..81ad4b761 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
             - rockchip,rk3188-spi
             - rockchip,rk3288-spi
             - rockchip,rk3308-spi
+            - rockchip,rk3328-spi
             - rockchip,rk3368-spi
             - rockchip,rk3399-spi
           - const: rockchip,rk3066-spi
-- 
2.11.0

