Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011271E0580
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgEYDp5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbgEYDp5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:45:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B2BC061A0E;
        Sun, 24 May 2020 20:45:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so82146plb.11;
        Sun, 24 May 2020 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=L1v+SFIcuOBtC5uNb1/F9JwnI/MV2Y6r7KptSWJmyzbRBYesYs+bXxJUS4ItcP+FPT
         k2IVwpaEgQcZpIgX2E0nirnEIobOUQ4e/qQdA0x4hwmSnzKtTyzAZi8p0oTy3OOlJuRw
         9I5G0UpR1rGvA3BHzYOtSr5wiFI1hzoOIVYgloKziD7+HX2iVNwO1P4IAzl+gUmomQOl
         T7vo1xrCFWwOXCzPsh0LyH9KcnrN8yPtbib1XiSgVcErdtxLZl2AETvmALganitVM3N0
         ePpnyIyaNXbuk7rdgWBPzbsC9fzXx6cZVtiDu0SPRxJL32R/xBFQ/NM8l97RIbYBBFgA
         xiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=P5/M12RYoL5M3x+FolxYuBIL8cTJoS+24++MZ1Plhl7pAR5AZVEFumFCTbdb/6GqFZ
         o5A0Yf7+Mc0ku79Vm+tc+PWab07MuaLq4tpaTQ9+0H4yehg83GECmJJaWd/Qwl5+ZvrB
         ipkfbptOYteiNdv1PKiKih5EfYi0kxj1vIjYsjVFn1o9wCDv/L+Qi/NeRa1gjnzWD/vj
         S4C9/ttDsgsrEcjg6hrgj/O5SdYf1AOqSSxOJM+iHqaRqQLGQNe3mafvweLDEFAXUMwU
         qQvLMyP1NGKbCbUa8nWQrGzVNJcY0g/79UDTWcp7i/9Gs5Z459L8xONof1CbNyzXAkZi
         KpNQ==
X-Gm-Message-State: AOAM533T52d0hvM3uAuYys9IBc44EAU5hoKuyhNzrB8FoSU4UPXBm/Kz
        R6IEvIA0tpb6F9+lSXSW4pM=
X-Google-Smtp-Source: ABdhPJwkmS1ZHDjTueCXUPGhysWGmBYPKk9BaU4KH5QdoOaLDJ+q+4xaTLSo+sj1pCIJ1ykv9lAZig==
X-Received: by 2002:a17:90a:a013:: with SMTP id q19mr18863765pjp.120.1590378356618;
        Sun, 24 May 2020 20:45:56 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:45:56 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 1/8] ARM: dts: stm32: Add dma config for spi5
Date:   Mon, 25 May 2020 11:45:41 +0800
Message-Id: <1590378348-8115-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable spi5's dma configuration. for graphics data output to
ilitek ili9341 panel via mipi dbi interface

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d777069..5820b11 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -660,6 +660,9 @@
 			reg = <0x40015000 0x400>;
 			interrupts = <85>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			dmas = <&dma2 3 2 0x400 0x0>,
+				<&dma2 4 2 0x400 0x0>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

