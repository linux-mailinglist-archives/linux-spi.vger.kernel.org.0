Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7937C1CEE4E
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgELHhE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELHhD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 03:37:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F77C061A0C;
        Tue, 12 May 2020 00:37:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z1so5985223pfn.3;
        Tue, 12 May 2020 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4ch8j5fUt4KnjnT79HJgzesM349QfaUvm49nNEOTbM=;
        b=liGnZv9V+YlD0rTxwCsrqKX9T7b/uFKEWEmcLhyUVdVM4OLuljhp0H4BIxzOKopWpH
         qD2ZsbfwZ04LJWj410Nwng4Fj9Ivnzfe8nuB/uggi+t82UEiUK9OrHzDBFeHv6X+IgCy
         nP91XfVq24+2of3EHWR5g9MciEg4KN/4Hi7UXzwcIJ8JJKjjYWhxj0wQmjrA7ZCfsJl7
         QsIDHvh8F8md2YbeJHHd6wUlJhmUwiFyJlZxsC2TiBbtqn6qtDtIUAzMhajplC8uB0dx
         cajfYKfQWnF9mJF1n+U0VlcM1/3fYMjkfqOL2LIiUMViyVHWMe2/Ot3Qiy+rmcwbLJfT
         PDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4ch8j5fUt4KnjnT79HJgzesM349QfaUvm49nNEOTbM=;
        b=bA4MLynIBQexfio03y8qIMT22iKyAlBA1saz6JSOYA7owTOOY9vs/AYwO99YpmEb18
         q1lPv7ns07wA5ohz+cWJlh/EqxfdraR5ILVAniVrJBzblOm4Vd51yi8pf6mxqC/EnB5g
         tlNGif47wAtk0/n7LELpTYDIBvbR8PtDtLQNzoYLyl+bAmKNzG3D4szxfthi3a57Vvtu
         RydUJ3FZq8HVSkaFIebCbPpTvfiOMNTyXfdKjJVznPrj3gUPzgQb2f6gfMJvW4vDhpw3
         fFrMKeqYmn40qsZL4TockGs7TIfa89W2P6FkqORNmaNl3SBi8scatJ1s2FcXlHhYxq0Q
         UpRQ==
X-Gm-Message-State: AGi0PubZ3vS0zDMK5W+mUGwYtd9fQ2lnspSG3ZYp6/PT8i3iO4+S5d4Y
        SAPtDMgmENkFnfsPZPFjE0A=
X-Google-Smtp-Source: APiQypKyQ9WN5ToMhvq2wklP3XUxBEgEbvE5+fep2zT8czr9PcuMmduH6S9XdVQSc2xZkkJ2D80wig==
X-Received: by 2002:a62:1657:: with SMTP id 84mr19158275pfw.51.1589269022679;
        Tue, 12 May 2020 00:37:02 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 5sm11732471pjf.19.2020.05.12.00.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:37:02 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon.minfei@gmail.com
Subject: [PATCH v2 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
Date:   Tue, 12 May 2020 15:36:49 +0800
Message-Id: <1589269010-18472-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

L3gd20, st mems motion sensor, 3-axis digital output gyroscope,
connect to stm32f429 via spi5

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Hi Alexandre,

V2:
    1, insert blank line at stm32f420-disco.dts line 143
    2, add more description about l3gd20 in commit message

V1:
    enable l3gd20 dts binding on stm32f429-disco

thanks.

dillon,

 arch/arm/boot/dts/stm32f429-disco.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..1bfb903 100644
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
@@ -127,3 +129,26 @@
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
+
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

