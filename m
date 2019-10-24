Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9BE2FF6
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407906AbfJXLIM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:08:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52512 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404755AbfJXLIM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:08:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so893863wmg.2
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2019 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty8HHdcW1xvpVQo6VQZi9Y9fVgubaIPP2DR3ADcakl8=;
        b=pQNPianmV7IjonXNmeflG5c+WCkIuqaPqZ4p3cyxn14O1MgtIo5k8qBTT0tfhXrlQI
         dNg3eD2MUw3Uz3a//cTkzi7OZs8rhWnkFg9Q4MLhB+RapLWOHQROf4fYU2xlMmLjDaKr
         PBi987cnum89TArNKqYuyyaPij7CrJ5gHIxwW/X3VvwnW/2tZadszYTa6wTut0kLeCkK
         p9Ij8ujlm6/keBSF8TNdDcpdS+BCZG2DQ2Kmh5QG5RdEEnpFt/vJ55otJgsrWVPtyvCE
         ElpuaSdjTqxQ8TEHShrtI8yZIw9POby52bFrWjmVu1FXngL4Tknu7SSV4df08ESEsSE8
         /Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty8HHdcW1xvpVQo6VQZi9Y9fVgubaIPP2DR3ADcakl8=;
        b=uaT/V4HLiLcQgRQDFKi45Tr9ME+W9KggmcWc2RwxaaPjPsJ6DFyekGxj6SzsJ1RrfH
         mE0iejAK/XfAY9LeGNIDDJnNWpT7x7qPb6DKgIlbVjRZNv6hAkYwqUR11Vb+/kwdxrTB
         7rFAV/qzkOi89N8JAKntHyyoDTWJLdXG3ziXllSUC/k1tVgGTfIjHdFQUuj6TemMI82F
         bnRVpmn9d/pt8trJDqBh4KgO+2G7QPkGURfLlvBi0mIdgiYISK7jCt6Hc4HyNn7s4aOe
         2wkx48DmKFLQmVYHeWJawolG5NOX9/r27+UD7O6UVrFhvQPjwP2N/I9ZtF0pM8r5ROp4
         64wA==
X-Gm-Message-State: APjAAAV1j03RWZ6FSAJN/DLD+N0pABz5y7T+k0ObbW7VrV810elsb0P6
        O+OBwqkQSMllB6sqimCXcDfrzg==
X-Google-Smtp-Source: APXvYqwfcYBAe0pxGxppfimumQnVKkIUoG6mqibJ7hjFg868IcC9SwwecN0gfhV9zIvnvN7CSOSKZQ==
X-Received: by 2002:a1c:2008:: with SMTP id g8mr4118311wmg.34.1571915290370;
        Thu, 24 Oct 2019 04:08:10 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id 26sm2420473wmi.17.2019.10.24.04.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:08:09 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] spi: xilinx: add description of new property xlnx,num-transfer-bits
Date:   Thu, 24 Oct 2019 13:07:55 +0200
Message-Id: <20191024110757.25820-2-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024110757.25820-1-alvaro.gamez@hazent.com>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This property is used to set the number of bits per transfer (bits_per_word).

Xilinx' IP core allows either 8, 16 or 32, and is non changeable on runtime,
only when instantiating the core.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index dc924a5f71db..5f4ed3e5c994 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -8,7 +8,8 @@ Required properties:
 			  number.
 
 Optional properties:
-- xlnx,num-ss-bits	: Number of chip selects used.
+- xlnx,num-ss-bits	 : Number of chip selects used.
+- xlnx,num-transfer-bits : Number of bits per transfer. This will be 8 if not specified
 
 Example:
 	axi_quad_spi@41e00000 {
@@ -17,5 +18,6 @@ Example:
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
 			xlnx,num-ss-bits = <0x1>;
+			xlnx,num-transfer-bits = <32>;
 	};
 
-- 
2.23.0

