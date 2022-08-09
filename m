Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D058DCF9
	for <lists+linux-spi@lfdr.de>; Tue,  9 Aug 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiHIRUy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Aug 2022 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiHIRUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Aug 2022 13:20:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B3237E9
        for <linux-spi@vger.kernel.org>; Tue,  9 Aug 2022 10:20:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n4so13288269wrp.10
        for <linux-spi@vger.kernel.org>; Tue, 09 Aug 2022 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sHMkwp3NTmTV/xVMwqTRrDVuL8/D/PiDUhfkbp4j2rc=;
        b=XtroOFWIeD/FFHW2xP+1bOcSThi+rmn9mJ57T/c3OIXw1gF+5WvaBOcwq5GwjKbJ0P
         is9NMLJzP/Qo/p6/8iXdSm6+JQPrg73dE0eWaaIW2N/icGvmUlZQK2/H4X4GDDps9UOB
         0kq14E1slsCe5YfVVjY6uPjOB4GrpTUDlQrwWUgJaDNKxrmKBjkjiR006B6RTVLHx9px
         iXaTq1doW6zm1vb74VyQuQyCVMvCgMWzarx8FpBaq5t/tExGEd1lCi3R4Y7HwfxAAuP2
         LJ3ziyTKqhA4Q0ROIZJcq4NReSDGBKi0O8I9c8KvH1wIZQVxtBWJydL+43Hr43sTOkog
         fgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sHMkwp3NTmTV/xVMwqTRrDVuL8/D/PiDUhfkbp4j2rc=;
        b=dPZ9mco3nNcIVAO+CNl+318vcVB1B5EIe+NaRKI2tY8cSGDjsUZPMW/8gGVQibjMrZ
         Gyhe3qAcSwGG4rua5lWLXmHGUO3lOJWQnnT4IeZEyn5oBQV6SLuh0Na28gBDuX/NzeDL
         TFnkj9k0+P7QnEx1O6926kld0fehsEgqfJV9Yp2vFwV+uAOJ8aUxT+zZeSmY0HtAd5eQ
         XlhAMrMpMXVGiORz06ldCDGGG3lOwByagzAB4cmH0RHPn3H8okQGBWFtkT5VnzCYyRtT
         a/qUur16dpbI3ScvmObt9KsTlgKnzchxw3aW6MXub03LLCxxi9xhk6yiszREfW/ialLr
         s2Cw==
X-Gm-Message-State: ACgBeo2sdMFlY7a7rb1FD8puqeFLQnlC1NDpm2sG4HurSNWOHft5N3Z4
        0fjkWGDyKeZgS6mTDE0ZCRdW3w==
X-Google-Smtp-Source: AA6agR7te7yif/yib4C7IySe6UqMjagxvMgnKemsdomvzBKdmWEkXfKrO5pAusHmStkPSJnzDSwiKw==
X-Received: by 2002:a5d:595f:0:b0:220:619d:da07 with SMTP id e31-20020a5d595f000000b00220619dda07mr14966336wri.10.1660065650358;
        Tue, 09 Aug 2022 10:20:50 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id b3-20020a05600010c300b002206261cb6esm13915030wrx.66.2022.08.09.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:20:49 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH 0/2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
Date:   Tue,  9 Aug 2022 19:20:15 +0200
Message-Id: <20220809172017.215412-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Between SPI transactions, all SPI pins are in HiZ state. When using the SS
signal from the SPICC controller it's not an issue because when the
transaction resumes all pins come back to the right state at the same time
as SS.

The problem is when we use CS as a GPIO. In fact, between the GPIO CS
state change and SPI pins state change from idle, you can have a missing or
spurious clock transition.

Set a bias on the clock depending on the clock polarity requested before CS
goes active, by passing a special "idle-low" and "idle-high" pinctrl state
and setting the right state at a start of a message.

Amjad Ouled-Ameur (2):
  spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI
    signal states
  spi: meson-spicc: Use pinctrl to drive CLK line when idle

 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 15 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 14 +++++++
 drivers/spi/spi-meson-spicc.c                 | 39 ++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.37.1

