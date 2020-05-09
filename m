Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD01CBE41
	for <lists+linux-spi@lfdr.de>; Sat,  9 May 2020 08:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgEIG6g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 May 2020 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgEIG6f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 May 2020 02:58:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060FC061A0C;
        Fri,  8 May 2020 23:58:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l12so1951521pgr.10;
        Fri, 08 May 2020 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7MiLH7+SCtzdt0PBk2oBWo6WTMfe3HTrl4Wg7fT5b8=;
        b=vXdN8oypTs3z11xY+tYCbwNsJsWc09M2NTfdgk362GzYGjuOhmweKw0fBqIjtJRioO
         4Bv2v2sRxvLiDGjJmyCn4v9XqjuvHLlmlaZuKER9aC77SYKfRPygWHeEDqeDeL19wvXG
         jDY2fx0dJy2qJOM28eDgrAOcySYfq1+V+jbso60kjUwVPh0IlCO8X2HxsSQiJ+TkQnc6
         RybMCGAZu6zTMRecBvOtL6h9sG6cXQ1va2DRKE1o14L5aOXP3Hb920UtA8Fz075lIUSA
         plWojAKpTbjrEFwUcnUiTwXg7Db3GhsX7TRNppYgWIgcJ7INMfsd9Q19BWcwqPdLlQl3
         q+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7MiLH7+SCtzdt0PBk2oBWo6WTMfe3HTrl4Wg7fT5b8=;
        b=hiB6ibltfgtrFaRJIaDKOumMf+mEExmnZoSj3DPB57lCKKlUPtWCppDA7IfkGn9ANT
         MF+sMVZcmw+Df03FHnLQgv+rZXrGajhCZ2lI0s5qvfFMWrxKFrYrWiE/Y+YbdS0jPxfy
         +OJ3a3B40iLItWyIvoVc0cDPoTAiIh4hsaZvg11DzcnmEATrRiCeh7G/SkA7HndOUGsz
         T30S+DbyU2tuoI+Ch2EGxm8Sf/fKq4zzn7t1/qf9CG18ZBn34HUSpXreNECNICKPrvf9
         Q6MEQS3M5mjrq5Gq92XN+zU7lVClWaBJf2DZCMQJMXS7omiuAWJruZdvHJIPqzZNslLa
         AzAA==
X-Gm-Message-State: AGi0PuafQdPn6qrjVV0TlnLPVsndEnJdaj0yinuaNrtdaVsjXPeIkJgr
        9CncR+NPGXYj/dOG3KyX2U4=
X-Google-Smtp-Source: APiQypK3wT9LttykvZaRfxnpnUFiKYc9Ap/hkzHYXBDRd2HlFmINnaeauCt6vlHaxkkOFfT6f8Szuw==
X-Received: by 2002:aa7:8509:: with SMTP id v9mr6968735pfn.110.1589007516067;
        Fri, 08 May 2020 23:58:36 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id w192sm3811572pff.126.2020.05.08.23.58.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 23:58:35 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
Date:   Sat,  9 May 2020 14:58:22 +0800
Message-Id: <1589007503-9523-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
References: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable l3gd20 on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..d365358 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -127,3 +129,25 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&spi5 {
+	status = "okay";
+	pinctrl-0 = <&spi5_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>;
+	dmas = <&dma2 3 2 0x400 0x0>,
+	       <&dma2 4 2 0x400 0x0>;
+	dma-names = "rx", "tx";
+	l3gd20: l3gd20@0 {
+		compatible = "st,l3gd20-gyro";
+		spi-max-frequency = <10000000>;
+		st,drdy-int-pin = <2>;
+		interrupt-parent = <&gpioa>;
+		interrupts = <1 IRQ_TYPE_EDGE_RISING>,
+				<2 IRQ_TYPE_EDGE_RISING>;
+		reg = <0>;
+		status = "okay";
+	};
+};
-- 
2.7.4

