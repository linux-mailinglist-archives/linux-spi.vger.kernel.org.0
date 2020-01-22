Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E39145EC0
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 23:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAVWqI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 17:46:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgAVWqI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 17:46:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so921300wrn.7;
        Wed, 22 Jan 2020 14:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWxnPQXLd+Q1xr02wkxqUJDAE8DS8+PwJcPiG+afbrk=;
        b=I0fdhWiB41zdWDXu3XXbsSFAdjgrRW152IEIC/13IrtPI/utS9IBzUHxzsWQOORADu
         FNJW2ywG6LfuQ+Iw432bFzTM0OP/gSZYvZ+C8KnxErBOlO72oom9mSqUgI3f4YHYoc6J
         LKXwOuZAQ5jbFfmWCZIUackWR4dboT1eVR/58v1aASUJf+XrWCTiEtwxglbS5fanZAsB
         iHERNVZ5WU73kN0JJJDx8D9o1Mphl/ZyZshW3I2FFCzTbFNSZujINWTwOgsqgukTrGWw
         Ugs/edLPj9isfGj1bH39KXgbt8fAzVlmlAYGVFe6g9ydc2nqidgPuylBwQksmZxPXWaM
         8mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWxnPQXLd+Q1xr02wkxqUJDAE8DS8+PwJcPiG+afbrk=;
        b=ARnYrcL2oy53srfBhD3m1udEnaGb/ZRt2M0X6aHM8O2iP37jzGC+8txjU8dREB2+gn
         R1UnErbx6imqMYyY1kdUqmv7td7VAI4eMqpDkZxlz7+OUa4lKRXUmFxXCYImhe2XXL1V
         f08dqrAfSLoBqFaFXXdXTutdXcLXeUjBl9WzXZ7dE3VVIH/l8ImTciWzKGRqVshJv5qD
         1eWzXNArRPfHAyNq7wZWHc1rjl8Qs4HD7+w8HEexUgBEUZ6e8m3g8GI+zuAI1xOonbN2
         Zc6mZpDl8ceslcbode0PNzDF+YWD2Vkll6K+Q/hjtsryr4yTW8u4yWJbt4QUNW+SI8tU
         GVMw==
X-Gm-Message-State: APjAAAUzvhs2xY9IT2jRFnYzCVG1BQLJTujLHppMu8xZsAJ0+9TOxVI8
        aVWBrLBoMY5QLSYPkPc0MTg=
X-Google-Smtp-Source: APXvYqzB0krEdYHfsT/a9zb3dXi65M8ljwfJsmqQQOo0r/RttSk83FS5IrLrFgtXh1DnTPNL1Rj7WQ==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr13505642wrr.65.1579733166449;
        Wed, 22 Jan 2020 14:46:06 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f1sm342559wro.85.2020.01.22.14.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 14:46:06 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: spi: spi-rockchip: add description for rk3328
Date:   Wed, 22 Jan 2020 23:45:55 +0100
Message-Id: <20200122224555.6845-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200122224555.6845-1-jbx6244@gmail.com>
References: <20200122224555.6845-1-jbx6244@gmail.com>
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
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index a797a4748..5e0fab1bc 100644
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

