Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58D2007E3
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbgFSLcN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:32:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58684 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgFSLbq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566305; x=1624102305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjTc0lDvbX2q6sDCdQDYyLFYSA/iqLUPgJ9XmdVLoX8=;
  b=fbXKb2JhmOJ8+KZo1cGdijzi7T0KE0eEqXrnroCP9Rzc8BI1YYSDbMW5
   6ZCHXS2ffSo91E8U30wp7BduqMzBPxHrFMLkLaUd7+P9rDzM6XL3DDcJH
   UUsGz0UUF79BPf41oc9u9+ar3r8PtzKGS3vQk9GXapbXiYlzOWdv8N/2V
   x1gNmbJjvY4Ty3kvLbe8yDYlgUmXlfULmGISTRtpHTFRVrbtssuobZwAF
   hI4jW3cNnx8gpDweCKIUcc6pqH0sYsSnWf6KtJ2dn7HndT6CMzlv5xkoq
   NBaY1ZybeR0Q/aELudI/3OXBM+1yx807ZyGhp4n/tnGI4pf1e6orWkVEK
   A==;
IronPort-SDR: 5tCxH3ZJH1R1MOehWYbR4JGvWH+LB4qV1roaxoIyERCaBUOysCw7AgLP7tYaRj14i25qWM+vrV
 u2kq8M87IAhUemDJBkbUetsqUXoYpITgnjXHPd2NsWGC8UFo6mXVOi3P13s+yX4cTB4TwkPyYl
 ORM4KQcnCevmqr0r1/qIToyhzUabojpcvQID7dzgMSZ8QCtiG5K19zeMxHarNB29P65aMf/l71
 YvJCZGmp5nikwJRhgdvarphCqsAepOmPQhO09ceA3xtUqdKa0Io+xqK7JGhcpDRLDG8bD2/4d1
 2KI=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="84298531"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:30 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:28 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 2/6] arm64: dts: sparx5: Add SPI controller
Date:   Fri, 19 Jun 2020 13:31:17 +0200
Message-ID: <20200619113121.9984-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619113121.9984-1-lars.povlsen@microchip.com>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds a SPI controller to the Microchip Sparx5 SoC

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 7e811e24f0e99..2404bcc08b89d 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -14,6 +14,7 @@ / {
 	#size-cells = <1>;
 
 	aliases {
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -155,6 +156,19 @@ uart1: serial@600102000 {
 			status = "disabled";
 		};
 
+		spi0: spi@600104000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "microchip,sparx5-spi";
+			reg = <0x6 0x00104000 0x40>;
+			num-cs = <16>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		timer1: timer@600105000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x6 0x00105000 0x1000>;
-- 
2.27.0

