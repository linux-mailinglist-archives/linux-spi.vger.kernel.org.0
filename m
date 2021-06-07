Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E180439D505
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 08:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGGhf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 02:37:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:50926 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFGGhe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 02:37:34 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 13990D1DC2;
        Mon,  7 Jun 2021 14:35:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095280056064S1623047691557189_;
        Mon, 07 Jun 2021 14:35:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <35bf0156d720a0f7d450d1a8ac0479c4>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     Jon Lin <jon.lin@rock-chips.com>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/6] dt-bindings: spi: spi-rockchip: add description for rv1126 and rk3568
Date:   Mon,  7 Jun 2021 14:34:43 +0800
Message-Id: <20210607063448.29589-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607063448.29589-1-jon.lin@rock-chips.com>
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The description below will be used for rv1126.dtsi or rk3568.dtsi in
the future

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v4:
- Adjust the order patches
- Simply commit massage like redundancy "application" content

Changes in v3:
- Fix compile error which is find by Sascha in [v2,2/8]

 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 1e6cf29e6388..2d7957f9ae0a 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -27,12 +27,14 @@ properties:
       - items:
           - enum:
               - rockchip,px30-spi
+              - rockchip,rv1126-spi
               - rockchip,rk3188-spi
               - rockchip,rk3288-spi
               - rockchip,rk3308-spi
               - rockchip,rk3328-spi
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
+              - rockchip,rk3568-spi
           - const: rockchip,rk3066-spi
 
   reg:
-- 
2.17.1



