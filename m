Return-Path: <linux-spi+bounces-11426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437EC75348
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 67043325C5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2593644B2;
	Thu, 20 Nov 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="X8z/tpKU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3F36213C
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654319; cv=none; b=HA17+OeaZsKwab+zBT5ru1A3t96qUxopwl9TRWEGGRzdadR5WvVNm/Vqi6G+J8Mw4PMSOsByPVnRVHVy+GBrQ9E5J+yLe9K5+hvyMmZfIrs4h0E577w5LuQt39uYsuy/Elg92QTYpZgLJxdDdwo78vjvWiaU5dPDZzYyD8lHRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654319; c=relaxed/simple;
	bh=uPzdYBC6E4XepqZlvRuIW6P2PBSjJWkbAqDhA2f0Q3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQLYJSO7tlWX6Daf+K2qj+6YKN00ixl/jbic99UZKY8vhe72Rm5Ze8oudTFoOZeKuDSBS3111ws/saSqJIIamPVBx8+AkJ45X2V/HK8Z+mTYmMzW5uwZKp5a+6a4B6lqPEA+GQZo8Ya/ihjF7vdQbvEPP0/DsL2GF4gdBBWgnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=X8z/tpKU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so7826975e9.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763654315; x=1764259115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MFhP+e1GLg3I4lzWFY09q7GFkpOYU5+AuflKR7IySs=;
        b=X8z/tpKUTTqT3z73OIXaLW1qdJCAJMoa/IJVoCkO8rRgokm735wFmTkVqLMUh5xkUd
         t7Bv0yU9JvqHhPKdJaQDrIbvVZiFtp4pTA9nfaMtm7CuS63kBP/63x7O2CarAmz8MmRu
         NE8KqwdcyZBFmEAYqfscZCUoRfoZwt86EG994=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654315; x=1764259115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MFhP+e1GLg3I4lzWFY09q7GFkpOYU5+AuflKR7IySs=;
        b=JV2e9/KD3weZ/6GNuRXiUwr2IYBUFybwxXJhsR6hwnEU2sfIqVFMcS6JJ80XCYuxdf
         duSZVi9KnZgTcrZuA+clpdHi/Y1PUmzAkbbojGQhw6bCAywDdkeDZSnI3YCm9yWaRmWW
         kAn0tIJ5ucJXZYdCQqYwcuVq8tVcPwHQVkyqHLDxfh4naplMlLkjWVHN4//NAU40ZTbt
         Agt1IS1HbRBB4KL52E1zzfCIi0J2IUZ9BfoA8pPqYUAq2zDwrQpxz3tWFW+Tf8D7Mz1B
         SBFFU/QaXh8yStnisGutqlzHT2c5e7L/h38qgN9p4QHeQmD5Kz7V0XPIE5ri7XOK1oPx
         ywMA==
X-Forwarded-Encrypted: i=1; AJvYcCXBbO9cGvgadtWWVi4eMNP/VFtGT/ZIaGCU/x75GkqeI0sLlKBGL+BjgLFAMNeuk3XWI8RIFKKRYv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkFJMxj640JwWquoV2K1kbMO1ihFx7UPr13NDhihhIlcwg0Iu
	4TjVtGNv2hPzFx1ec+ae9xC/1YSBU4XHcnFhkoxjYLt7tSm4Y+CwZgTilVihaSHJlFY=
X-Gm-Gg: ASbGnctsnNDlnvgVKhrSR//SlHOb6GOOTEPRQVhP6ZZ988ZU4ENpYW4pl5cHdqjIcWm
	dkzvO2BPeibMOjezYPcxk74uYtd8CGtfqltCgbW2V6hyL3Jt3IDNjtzQVWCn1W1XvgvJ2c2Elsy
	ev1hbttP3HPGzxosiaZ7ezca6KSkxv+085a4iGM61RGwW74hmrxdm+rAeCdNLZD7Dl3kzrbCpVL
	j/D6CzUIC6fn9rhiNUuuVm0Xdv0c+lj68aB1By8eGq6QAIYozVfKghRVCCL30jupFv0vsgcaMQT
	vUBISHVb4bHX3rTMqWNmpDd35Dq+/AJOP1D5T2zF59dx6Zs39Xe1o1OKeO2MjitLnlS1aoTGN4W
	3/1GXNWV0mfUJODzSxUQ4aO2TZfD6mWzZZ6dOBF8lwNR9Mqt5NIGmXnMaZEgiHu1UMOddu4rU8X
	rZWsn9BVChtYRJHEIiT9kEGU9ZSS6I1TNq+1ZuANa0RfvF
X-Google-Smtp-Source: AGHT+IHLGhbeSdiUjWR7kKS+/cj5B6fBPMN3SWhcUsAyNW9dSM9wygMKznRi/DZk0P6gk1llzMP//w==
X-Received: by 2002:a05:600c:1caa:b0:471:13dd:baef with SMTP id 5b1f17b1804b1-477b8a9b2edmr41014445e9.26.1763654314985;
        Thu, 20 Nov 2025 07:58:34 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm55552185e9.8.2025.11.20.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:58:34 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 5/6] arm64: dts: qcom: agatti: add uart2 node
Date: Thu, 20 Nov 2025 16:58:24 +0100
Message-ID: <20251120155825.121483-6-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu@arduino.cc>

uart2 is used in Arduino UnoQ as an interface between microprocessor and
microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 8bf5c5583fc2..992a157c571f 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -562,6 +562,13 @@ qup_uart1_default: qup-uart1-default-state {
 				bias-disable;
 			};
 
+			qup_uart2_default: qup-uart2-default-state {
+				pins = "gpio6", "gpio7", "gpio71", "gpio80";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_uart3_default: qup-uart3-default-state {
 				pins = "gpio8", "gpio9", "gpio10", "gpio11";
 				function = "qup3";
@@ -1315,6 +1322,23 @@ &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 				status = "disabled";
 			};
 
+			uart2: serial@4a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-names = "default";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+				status = "disabled";
+			};
+
 			i2c3: i2c@4a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x04a8c000 0x0 0x4000>;
-- 
2.52.0


