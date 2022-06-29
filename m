Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE056099B
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiF2SpW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiF2SpI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:45:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B435396A2
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:45:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so166927wma.4
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPnaNl2N6OCS49bYwYg25LRRooD0U5t+6njnQfYqn3w=;
        b=cun3Fr5kbB1kc8fHUe1Pp/5QcguZXRCH+7TrDGk+ZMirUtgQL36YLVbJCyhLZkOBJy
         LhvI1GVPT1ZTiqmhJOU4Q4LLd5pGvHUxjtjZGRI3dGMdUZcBN86wcFBgUizT8kZoHfh+
         rzleb2gxRvUVaOsxtxjzB3eOBv6fv6XHPIx7hcXbCi9kY8hS+dv7hGMpXyC9zsYxLjVV
         OdIhzsTDSyIcq3kRndNjuRbrJ/XkT7HQi3aadRk0Mm5KKIz0aoZlheM2JjydatfBmbmE
         b2/Cw63ViZ4v3295nkIXbKulmCKxxxTgoEJn+r+AuOx8BCV+qEspBTkmWddspDZSYqKX
         yfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPnaNl2N6OCS49bYwYg25LRRooD0U5t+6njnQfYqn3w=;
        b=Ss2N4UhZdyoJdfj+8WVZ2ydNx4X5euBS80uGNU1kLPurkc8J8anBqeX9k+ehAA+hYL
         Pi0S8k0p6XbiBG5u1f69isrrQ2AQHYTZWkDZa2AZB3QFMQddw5LlILjfdeLdvpYH5+Rc
         9zugAE28D8apCsviBbWc3Vza/uEX90i6OK/bZ0iMSGtVv1gBLpiX30gyWiEUeu0mLLu+
         egmhixPJ968Ie9B/VFtiBBlNqXdZObxi7YcQ4N7vvOhKTFye94Le6pVK6GSjLVtWSjqi
         RNwRISZ9jvxvro6HbFrRvAAZNWlgIC1KkoGMqoZPcvuzQLOYi9mcqVlo57XHqhrvwutI
         wyTw==
X-Gm-Message-State: AJIora8bEa24ADvDJj77yJsgGqz7Z6YiMPf0K4DVGkmlt2U0tfAcwa3w
        mtUaKYuvXpl4SIYTGSCa7+HqgA==
X-Google-Smtp-Source: AGRyM1ssGrLiDWDuNuov06ew/GRkUp9AxME43xf1zuFe29c5Ad1nznXlVQLFaI/03jH4fxep5tbDyQ==
X-Received: by 2002:a05:600c:886:b0:3a0:49d7:d8b9 with SMTP id l6-20020a05600c088600b003a049d7d8b9mr7557614wmp.115.1656528300967;
        Wed, 29 Jun 2022 11:45:00 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:45:00 -0700 (PDT)
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
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 15/15] riscv: dts: canaan: build all devicetress if SOC_CANAAN
Date:   Wed, 29 Jun 2022 19:43:44 +0100
Message-Id: <20220629184343.3438856-16-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Testing & checking the Canaan devicetrees is inconvenient as only the
devicetree corresponding to SOC_CANAAN_K210_DTB_BUILTIN will be built.
Change the Makefile so that all devicetrees are built by default if
SOC_CANAAN but only the one specified by SOC_CANAAN_K210_DTB_BUILTIN
gets built as an object.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index c61b08ac8554..befe4eb7527b 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -1,3 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb, $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))
-obj-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .o, $(dtb-y))
+dtb-$(CONFIG_SOC_CANAAN) += canaan_kd233.dtb
+dtb-$(CONFIG_SOC_CANAAN) += k210_generic.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_bit.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_dock.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_go.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maixduino.dtb
+
+obj-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb.o, $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))
-- 
2.36.1

