Return-Path: <linux-spi+bounces-3869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A49322D2
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA11C22148
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA580196450;
	Tue, 16 Jul 2024 09:26:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF919752C;
	Tue, 16 Jul 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122004; cv=none; b=kZ/WM65NxZ4tzqnIOKbFvAO3MROnutbRky4kTH98g4FcHntr7GHNjrFNi42CblgCr26VK22q9hOVWpFOLUNmmSBHBm4cluJMJmJB6gAm15lztqqfPBpxb+CXf/iA7Uf4tv+TR7akZvDFIiO8DylMtrljsbul3BboD6UfRw9Wqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122004; c=relaxed/simple;
	bh=mPyAgdnCG6X0qIxb245UTKv9eD2XhiUuSqcL48hhmNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZemKxP1VXWV4xAmG0fwaEQgTxYDMfDRog4Duw3tjO2AJVByIfAYYeZ392QpSo76rIaVB043eJGncIasyagE6bI8cL4kNAWh3f24UCg3LXYA9ZsAlWRr99BC4FEkBmB/X9RubtWfkwfuIxbqH58/TXDa1ax3Gk1uOLfwVHsl6m+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADn7+fIPJZmC_qZAw--.55159S2;
	Tue, 16 Jul 2024 17:26:32 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: broonie@kernel.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	yixun.lan@amlogic.com,
	sunny.luo@amlogic.com
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] spi: meson-spicc: convert comma to semicolon
Date: Tue, 16 Jul 2024 17:11:51 +0800
Message-Id: <20240716091151.1434450-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7+fIPJZmC_qZAw--.55159S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4fuF48ZryDCF45WryxGrg_yoW8Kr4xpa
	nrG3yUWry7Gan7urn3K34DZr45Gry0gaykZryFyrW8KwsrWF1qqFy5JF4rAFWYqFZ7uF40
	9ryrWrs8Wr17GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbFoGPUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/spi/spi-meson-spicc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 8838a98b04c2..1d05590a7434 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -655,8 +655,8 @@ static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
 	}
 	init.num_parents = 1;
 
-	pow2_fixed_div->mult = 1,
-	pow2_fixed_div->div = 4,
+	pow2_fixed_div->mult = 1;
+	pow2_fixed_div->div = 4;
 	pow2_fixed_div->hw.init = &init;
 
 	clk = devm_clk_register(dev, &pow2_fixed_div->hw);
@@ -674,9 +674,9 @@ static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
 	parent_data[0].hw = &pow2_fixed_div->hw;
 	init.num_parents = 1;
 
-	spicc->pow2_div.shift = 16,
-	spicc->pow2_div.width = 3,
-	spicc->pow2_div.flags = CLK_DIVIDER_POWER_OF_TWO,
+	spicc->pow2_div.shift = 16;
+	spicc->pow2_div.width = 3;
+	spicc->pow2_div.flags = CLK_DIVIDER_POWER_OF_TWO;
 	spicc->pow2_div.reg = spicc->base + SPICC_CONREG;
 	spicc->pow2_div.hw.init = &init;
 
@@ -721,8 +721,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
 	}
 	init.num_parents = 1;
 
-	enh_fixed_div->mult = 1,
-	enh_fixed_div->div = 2,
+	enh_fixed_div->mult = 1;
+	enh_fixed_div->div = 2;
 	enh_fixed_div->hw.init = &init;
 
 	clk = devm_clk_register(dev, &enh_fixed_div->hw);
@@ -740,8 +740,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
 	parent_data[0].hw = &enh_fixed_div->hw;
 	init.num_parents = 1;
 
-	enh_div->shift	= 16,
-	enh_div->width	= 8,
+	enh_div->shift	= 16;
+	enh_div->width	= 8;
 	enh_div->reg = spicc->base + SPICC_ENH_CTL0;
 	enh_div->hw.init = &init;
 
@@ -761,8 +761,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
 	init.num_parents = 2;
 	init.flags = CLK_SET_RATE_PARENT;
 
-	mux->mask = 0x1,
-	mux->shift = 24,
+	mux->mask = 0x1;
+	mux->shift = 24;
 	mux->reg = spicc->base + SPICC_ENH_CTL0;
 	mux->hw.init = &init;
 
-- 
2.25.1


