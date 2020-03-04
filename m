Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9E179824
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgCDSmO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:42:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33097 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDSmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 13:42:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so3766879wrr.0;
        Wed, 04 Mar 2020 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0UatWJRIzkcWGUuRmNqWrdQb/4B3d2GrjC9oWPA9fFA=;
        b=bu7AzKrEyWTLSQWup7Y583C+Z80x7nj+gl8okSAguu48FQinboxTn8wHQch3TOJyNC
         me9wGMP9R8Y3tNo7xuMfNOpnim3WB9zW6bfXkodb851c1qFe94gra0/00vMB8Vs542tn
         Z9zlqoXG90D5OaMNL7AGTXDTbywHoUJ0DjgLNaS95f3u12T1AKAhQ91hTIbur0j8jkXh
         zJgJEFGx2AJed/Yxw7LkAgV4OmpbHYZ4l1Gjolav8pNzQFhq4XGWJU2vzZ4FnqbwGOxL
         vuQ2r5ciLliE2QoWKKQwB3Jhve8SAbGU8igivsH9cBhmCNLtCl92eq2d5FbtMqSkJows
         pXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0UatWJRIzkcWGUuRmNqWrdQb/4B3d2GrjC9oWPA9fFA=;
        b=bGbSvuoSC5MOA7bcPUyZS+Pno8ha4edL3m2RnnhPWFW8bVzoH3469YS2/uG62UVP2h
         EMJqq3dTPSc9cOZ7O4n+14aQQp0wkfdt59POgJ2NUU/MDZVb8h9+CmFrKHsyZa5qBMm+
         /tqB1A72koaxGH57KgRtcFacHH3GX+1cfUx50sh8pQ15VtnW3OjrweIEKgj1pQmqAq6e
         y8QwiWjld10tIl1bWZWh7YebJhmJ09xhERolHw9WCs+Xb8U5advvg6J7akZ7MneRPQMS
         FupVBLlZ+KotFCQaHDnvZQulty1Ox5rEYHbWbNLl1zZb907wzTwxPUKbpAdvI9nRy9F6
         Z7ow==
X-Gm-Message-State: ANhLgQ3nQaWm5DijNsRkaRomUXchzqdZEPf57FB3wexUYzsH9JfF+VDa
        /eV9efnHRYObs9iztTXXikQ=
X-Google-Smtp-Source: ADFU+vu2xLFs0sTZU9LUPGXLq1/B03boUDmHmJpVrmdihRJCfutuFIrYDce+tXyeVYoLabi3eyl4qg==
X-Received: by 2002:adf:fa07:: with SMTP id m7mr5254056wrr.384.1583347331260;
        Wed, 04 Mar 2020 10:42:11 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v11sm28175848wrs.54.2020.03.04.10.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:42:10 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: spi: spi-rockchip: add description for rk3308
Date:   Wed,  4 Mar 2020 19:42:02 +0100
Message-Id: <20200304184203.9548-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200304184203.9548-1-jbx6244@gmail.com>
References: <20200304184203.9548-1-jbx6244@gmail.com>
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
Changes v3:
  remove some comments

Changes v2:
  add acked by
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index bd1450c12..456896e2d 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -29,6 +29,7 @@ properties:
             - rockchip,px30-spi
             - rockchip,rk3188-spi
             - rockchip,rk3288-spi
+            - rockchip,rk3308-spi
             - rockchip,rk3368-spi
             - rockchip,rk3399-spi
           - const: rockchip,rk3066-spi
-- 
2.11.0

