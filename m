Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EB63BDF
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2019 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGIT0f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jul 2019 15:26:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34148 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIT0e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jul 2019 15:26:34 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so454614iot.1;
        Tue, 09 Jul 2019 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJCxWDqrIACeyw572XUN88X748QX9Vah3vz0WR7ceS0=;
        b=YCpxB+sehO4NnSiV+g6W2Xa1MMwpIoZVq4FwBkp5z+xJL6Zpqqvnvgf8JkCc5Ir2+4
         6+Kdo5oY++mF2hqWIZJKiB3YgV3qlMZP5IwaQXpePNtKhCg1H8waZrxzEzQVB21xz4sX
         wx9dfDY+V/TIH4jsTmpj+KFKLwagRI8f2oxd8L/uQwuEEjWIrUJMas3MIHDlIKD4t2Jl
         LlgGwdVednr2sStHoPAxe76UzOLfdtwUGw0ZYDnoOo2MjA0RBFn/FcVELjdOV15xGWqk
         cqUPrEtqnl8MCREIJjcXMP4lG/Xaf8nQ1ma3hlAZoi6qvmbVrxGYag1DzAELMfNoSrDi
         yIbA==
X-Gm-Message-State: APjAAAWhsSV3b3jMrtJa2tp7f80aX6xuTE46q/n5LnryDJfHRTv2v02Y
        g8IHB69hKdeE99ZAfo4uu5EHrCF1CQ==
X-Google-Smtp-Source: APXvYqzFQYn+xq0I9wKEnggnMxeBx0XK0qbhuePWj72qrLE7hJHFol3dpjQxB5aYLpvyr7Hg82Dl9w==
X-Received: by 2002:a05:6638:3d2:: with SMTP id r18mr30146201jaq.13.1562700393681;
        Tue, 09 Jul 2019 12:26:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id c17sm18671708ioo.82.2019.07.09.12.26.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 12:26:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg
Date:   Tue,  9 Jul 2019 13:26:31 -0600
Message-Id: <20190709192631.16394-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mixing array constraints like 'maxItems' and string or integer value
constraints like 'minimum' don't make sense. Also, with only value
constraints, it is implied we have a single value. So lets remove
'maxItems: 1'.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 876c0623f322..a02e2fe2bfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -73,7 +73,6 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        maxItems: 1
         minimum: 0
         maximum: 256
         description:
-- 
2.20.1

