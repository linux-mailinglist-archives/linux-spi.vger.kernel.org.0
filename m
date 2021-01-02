Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100852E872E
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhABLzH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 06:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLzG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 06:55:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47CC0613C1;
        Sat,  2 Jan 2021 03:54:26 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q137so20712067iod.9;
        Sat, 02 Jan 2021 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjq47Z+cVurscJY++LQtiaCWJOefRFw0FC6F4fr2FBI=;
        b=fuz6hm7+C7tDxz9jA94wOKMo+W+j6n8SVUg+qlb6kctnADvsMg2KxNfNQHMJGhQOcs
         HH3J2LwzhlpTBkyjwXBXD8eLRdvBAz0/9VJacFAAVfOxH7npOOEW2PJ9cIsWoe1KXkte
         CpW6Lg173VDzUX2A+7QiRuV9HlUVmwa7NgIzXQJPbDpvAiLPc1sx7OUkLCMwZ4Fdxckl
         0mUnn2iVJfC8RrTgItdrRNGaUC21bCoGZ7VgjWHabPoZfiB4TaFju0qOugaJVzjYnQ4S
         GlxPwuJ3Z0rbblYydNQ37wvTQ13BJn0SRB/9ZXEo9Lzf1bx5NFRMWjEp3vrHi7DhtkXp
         OGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjq47Z+cVurscJY++LQtiaCWJOefRFw0FC6F4fr2FBI=;
        b=KgX2oR/qurKIRtE5iYRF2sv3s0xrhpiQU3dO/1HzJu9MWAoVqxIg2U2frISYkEwlbZ
         jVg37lUnNstKEI3Sm8xcjboN7DxnWeO4pAhQTmhUjxqcfhfDFyIz3J2xzqGBHcD2v+Zd
         7o9HvNVOaF+6C1YKhpotVMmT+TE5RCpPttAXAiayQPhkDNN2c/kTGdsCXqHV3XFUZjWu
         7KTpEi7235xqyyitPKuvlWoA/Y6iW3gOq2WR1z6bxZDy67jbV52WvZze23Bnn2QST8FO
         7xYIRl1tQxPcxQrzU0iWjqnc0tzVOhbvyDawtzP8Qdqoode2CUqoF9onGmLNW0l8ZCop
         iBkw==
X-Gm-Message-State: AOAM533yibYkNH6rjfXdcpi1QOQ0z3ZV5jEuBpna+qq4h6Rp6v+rkK6T
        mbpeEdcAHUPGOmOyRCl+OFHXpe5hsRIFnA==
X-Google-Smtp-Source: ABdhPJxNwUqtteAT+PKtpP0t7DaIWHFrSK3vamgKoJrUVRjNR9zRRAEWYe8+hXOX01XYgt1oeRSKkw==
X-Received: by 2002:a6b:b8d6:: with SMTP id i205mr51909864iof.135.1609588465180;
        Sat, 02 Jan 2021 03:54:25 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id l9sm37218245ilg.51.2021.01.02.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 03:54:24 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, biju.das.jz@bp.renesas.com,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH V2 2/4] memory: renesas rpc-if: Update Add RZ/G2 to Kconfig description
Date:   Sat,  2 Jan 2021 05:54:10 -0600
Message-Id: <20210102115412.3402059-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
References: <20210102115412.3402059-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Renesas RPC-IF is present on the RZ/G2 Series.  Add that to
the description.

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/memory/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

V2:  New to series

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 3ea6913df176..d55252f349d4 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -202,9 +202,9 @@ config RENESAS_RPCIF
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select REGMAP_MMIO
 	help
-	  This supports Renesas R-Car Gen3 RPC-IF which provides either SPI
-	  host or HyperFlash. You'll have to select individual components
-	  under the corresponding menu.
+	  This supports Renesas R-Car Gen3 of RZ/G2 RPC-IF which provides
+	  either SPI host or HyperFlash. You'll have to select individual
+	  components under the corresponding menu.
 
 config STM32_FMC2_EBI
 	tristate "Support for FMC2 External Bus Interface on STM32MP SoCs"
-- 
2.25.1

