Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F7620E2
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2019 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfGHOwb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jul 2019 10:52:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:23640 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHOwb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jul 2019 10:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562597549;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6pzzV3F5EfwqtRQ+eYzsmhoB0OfwD44/ng46XwlROa0=;
        b=LFU1SKgK9KHPssHHdPZJGWCTPGBDJlpHHFtEZeA3/0jeE1RoqvpfUK5SaQOwCUag0P
        RWbmADBVLF8pOixHly/M/wifNgCkub9ZCKig9cjOopGGnjcItPa69LJQIWQtSo2XV54h
        COgwHf1yicl9ac3MDok30ihWsacq36Is5ZDTSUJ7gQhcmXzvXa5Lwh/IVe6uobJPtuyk
        1tQCLAhblCk+2J5MhCQi5cI8Tjwl6iblFzd4sBhUdiYLsyGnt/CJL/fruIFJz5uwTCAk
        cR1p/aOC7GUTx/3nXyrcQOaGYVaEZtkA9QP6nsLIPuPTdpnGpx1sXQNmq737T/6i6y/d
        RrNA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyOEF/R66y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id V09459v68Ek7X7F
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 8 Jul 2019 16:46:07 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     letux-kernel@openphoenux.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/2] DTS: ARM: gta04: define chosen/stdout-path
Date:   Mon,  8 Jul 2019 16:46:04 +0200
Message-Id: <21ed570c5920346bf9dc1284c8dfee2e6ef79a51.1562597164.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1562597164.git.hns@goldelico.com>
References: <cover.1562597164.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This allows to remove the console= entry in the kernel command line.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 6473d8dfadc0..9a9a29fe88ec 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -24,6 +24,10 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	aliases {
 		display0 = &lcd;
 		display1 = &tv0;
-- 
2.19.1

