Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779B5504B9
	for <lists+linux-spi@lfdr.de>; Sat, 18 Jun 2022 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiFRMds (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 18 Jun 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiFRMct (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 18 Jun 2022 08:32:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4C11DA69
        for <linux-spi@vger.kernel.org>; Sat, 18 Jun 2022 05:32:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o8so8815224wro.3
        for <linux-spi@vger.kernel.org>; Sat, 18 Jun 2022 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvr7KGApLNCGFBglHD3dnfCRd3yjQwODkG+M5NRKmQI=;
        b=DDJ6xBBbhzIGoPiqSpo5MnWPGVLzU4ERv8vLSiBnnPAynNwKjWM49EcnFIFQEkgm/l
         doK52smtoMBCAMnt3+oFGMyw4xhf6W+5pMee3IBtco7DlzBypqqFxGPePkxlqPEw5tri
         SDLBm2agXeKviAcJotwY5RL1uBwFcjHga0K6SkH6mQCE6NwwTJxpZV0bQ6udBQCQ8t5X
         /ugUETlZEHQBi+kUxi5RSWCIVIQtoVjqwtn8FqK1wrZYFA5exI/WKKix1Zp5xujFsjOq
         WhKYuvAAICTLiFyGacSvPtjx9GD78ZZmFV4S8UwSg41UB0EBKvQ+vCEP9thO5HxmtSKW
         MnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvr7KGApLNCGFBglHD3dnfCRd3yjQwODkG+M5NRKmQI=;
        b=E5dlaoPKxcTCzQ9Fh6MR+oSddqrtUt+OJxJQxT1zJAqPyRquuwi3vbGThUPbhPb6BY
         2nIEec4wy58NmgR8xFsg7rH2h1hE3fULJK9R2BePvXao4R/iol9Ha/Esor2S1KedNkNo
         wK3dy4fLVnvR/6rCvNLjlxpk7NlFl/vPaLfWbfvzvhW9xx2J1DV99/X34BUcz1xHBgwZ
         8W5UDlJ1/8UQVuIYGBA3im3wbhmFhASYPHuuVJPwqWOQbg8DyulNztiyVE3E5btL6gH+
         ttk2MMtpg6Y3IbOS/KIPd6DpiMiS1oNhWjwaDRPHRzU6ZAUACZm5gUGRowMuROEULYTP
         TcGA==
X-Gm-Message-State: AJIora/DuwyHQDEnDVMVgCWZkljwiqUnRo2fvSM5A/7Mb0ODLy3Vjg3d
        8l5cfW5ThBWW1z9cIwkDv86VnQ==
X-Google-Smtp-Source: AGRyM1sRT/G1/Zc62fYFm4YsukPkHZCuylsLgzzu2NtDF1otkPHXpMjCG/oHMIlIy5/3wMzfMLCUWA==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr13471356wrx.650.1655555545465;
        Sat, 18 Jun 2022 05:32:25 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:24 -0700 (PDT)
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
Subject: [PATCH 14/14] riscv: dts: canaan: build all devicetress if SOC_CANAAN
Date:   Sat, 18 Jun 2022 13:30:36 +0100
Message-Id: <20220618123035.563070-15-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
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
I don't have any Canaan hardware, but I build tested it and the log
looked correct with arch/riscv/boot/dts/canaan/k210_generic.dtb.o
getting successfully built.
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

