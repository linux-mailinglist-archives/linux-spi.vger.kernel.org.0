Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56855E24C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiF0Tl5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbiF0Tlq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:41:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82C17E1C
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2716235wmq.4
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=JSlI1sImVuIOJXOTiME+vQ4iJzMZIGLs79AVGgFi/4PGzp9uNq+ij4fgaq4v635z96
         iqu+qlmc2CiECMm4cbe0xKFYr+G0bJ9m5w/qt06RqK6+DYgKNGKu64YA1Ggyrg3bTcDj
         h9fgtLqXO7l+D1Ptq7BJ+bfj9GpPhEpyz0OtKZP2fdfMBXf439DK7uOf1R3SGH6PnWaN
         s/MNpEYNLa1akQZc/7jwyPlPi0BCuioZyE578J82CZOAhvUksEUtg9kPuoYFd7foZxqa
         Wz2VVt6ePjVl2/A5ZdagCh18QXlj6Gb36JemsKRegKW5rGQi0MPTcSTuEnFkg8i48gi+
         dWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=Zk5SW9HK9nbThG19wshympgJ+vwRhn2vXqnkLDYAECWAJIQohwp9N8VvzffF/KALS0
         xIEFG60hpTWLs7C8aDb6qItRezl21vcn0OYJzNAPmuR0NKrZ/YXfULYwMxfuU9CGwS3j
         RIFFTkB3ImDcfx9H3Ufw8lax1MqXTjSiSCOUHFijYqTxop171+MWdbuQ/gGqtHrAWXJn
         Y3nslHBzYiOJNtKIdS/l7JHSjqweV0rcwmB5HwZY5tA3R1Enw+Voq/CyonRU76mGzI4U
         oBlEcZlm0upiwENeRg7WD437ssmKxPadfaQWDw6B5b39CmvzwPJ7IQePrcUD9cCDWKV/
         UpIg==
X-Gm-Message-State: AJIora/gTli/ieje9PjbLdTl3wKmsL35+24BzLLMgRiFhflFd4JIStqk
        KHoSxckeqg+MRCIZDBUYlFFRPw==
X-Google-Smtp-Source: AGRyM1sG2h/mawEtIGYv6YucN+AC/fcU+GXYsZ0RG4tU7euqny2eYvUYl3sfYU/deBMVuNdMP0smIQ==
X-Received: by 2002:a1c:790c:0:b0:3a0:3e42:9c7c with SMTP id l12-20020a1c790c000000b003a03e429c7cmr17586763wme.171.1656358897396;
        Mon, 27 Jun 2022 12:41:37 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:36 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 12/16] riscv: dts: canaan: fix kd233 display spi frequency
Date:   Mon, 27 Jun 2022 20:40:00 +0100
Message-Id: <20220627194003.2395484-13-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The binding for the ili9341 specifies a const spi-max-frequency of 10
MHz but the kd233 devicetree entry has it listed at 15 Mhz.
Align the devicetree with the value in the binding.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 40992d495aa8..4a540158f287 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -130,7 +130,7 @@ panel@0 {
 		compatible = "ilitek,ili9341";
 		reg = <0>;
 		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
-		spi-max-frequency = <15000000>;
+		spi-max-frequency = <10000000>;
 		status = "disabled";
 	};
 };
-- 
2.36.1

