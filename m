Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5939C725
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFEJuw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Jun 2021 05:50:52 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:55814 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEJuw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Jun 2021 05:50:52 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id CF042BA293;
        Sat,  5 Jun 2021 17:49:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3122T139987246892800S1622886541484053_;
        Sat, 05 Jun 2021 17:49:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d787a4f084dd6ddce8f9d641b5ce250a>
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
Subject: [PATCH v3 6/8] dt-bindings: spi: spi-rockchip: add description for rk3568
Date:   Sat,  5 Jun 2021 17:48:58 +0800
Message-Id: <20210605094900.14279-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210605094659.13507-1-jon.lin@rock-chips.com>
References: <20210605094659.13507-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for rk3568 to applications for potential
applications.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 4ed5b72a8494..2d7957f9ae0a 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -34,6 +34,7 @@ properties:
               - rockchip,rk3328-spi
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
+              - rockchip,rk3568-spi
           - const: rockchip,rk3066-spi
 
   reg:
-- 
2.17.1



