Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F536C036
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhD0Hi1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 03:38:27 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:49886 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhD0Hi1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 03:38:27 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id A958BF3AF1;
        Tue, 27 Apr 2021 15:37:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2750T140648996910848S1619509055243892_;
        Tue, 27 Apr 2021 15:37:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <01111ffee587bf109de715e58a149324>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 3/8] dt-bindings: spi: spi-rockchip: add description for rv1126
Date:   Tue, 27 Apr 2021 15:37:28 +0800
Message-Id: <20210427073733.31419-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427073733.31419-1-jon.lin@rock-chips.com>
References: <20210427073733.31419-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The description below will be used for rv1126.dtsi in the future

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 1e6cf29e6388..4ed5b72a8494 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - rockchip,px30-spi
+              - rockchip,rv1126-spi
               - rockchip,rk3188-spi
               - rockchip,rk3288-spi
               - rockchip,rk3308-spi
-- 
2.17.1



