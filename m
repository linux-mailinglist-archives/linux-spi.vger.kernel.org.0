Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6122EEA0F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 01:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhAGX7y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 18:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAGX7y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 18:59:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7208C0612F5
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 15:59:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so4724408plk.5
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+8d2HurmLuY/fjmxjePAkINENkGN3Pzqi7ebx49cCY=;
        b=CKsRpny0W3qEoMZ3k5PEtqHfo8t69e1shu/9KLTONKOxB/S/AgzMlChZplWwWdFx/x
         4XdDlPAGvA5eLw2CjTIqGZEJDNSErKRUnRVtcjTGM+8YLdCuMep5qLMgHWeR4+BNow/6
         3sdWYk5liQfpx+H/9fJAIAt459EJUqN8pfNKq0ZbESYrY01ELl40pMNAhs2b8hqS7CgS
         EkxIMoUq3ZeNlpnleTfWo0i2U+Fp2+f/bylMYjHlTvbSZA/BuzllghsZmnG2l3uiL067
         Ma/DoY+eXp0mjwJjJxQWvLM9oD/TPRdbWJrgtKPcCbw4APKHAsb+9/IKdzUFxuTGNMbh
         8Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+8d2HurmLuY/fjmxjePAkINENkGN3Pzqi7ebx49cCY=;
        b=mE6X4ytIKODTjUl4XRUCiBOb2M/V60Tb4GABgMstD1bSduMOhiX6cfV/jnemAo0IsL
         iN6o1La1fuzTm4grTFnpoIG7O09TUn7iVktEpLOrkMoxnJ3+QR4GH2n8Uizz0ZJCBqXy
         sld1nNe1qj2JFWPxJwqLX2vTCx+mWmPRBkk5BmSsVWgq4feGML02FpCwMgGurYssdj5Q
         GnR5f8VkdziPrfpcaFFPabfEjmrBT9BU6+3DaaQbLBJcnlUaYVsko8E1NcONc22YpZew
         RDssenOuJrDJfcuziexFfeLlMVIEG9mmDIgasb3rk5IbJ6J4zAvllaeksUfnKMZ4RdEA
         5leA==
X-Gm-Message-State: AOAM531X7SfEfVtvTCBEbhLjelmpTrcHiIMBybR+TGkLRoc9gYHqgJZR
        HnbqWoa/eunrC+/gBWoJ0to=
X-Google-Smtp-Source: ABdhPJzetQAFGdnSIb5NP1F1agOCW+TZUH0FGEVsGuGgipmIrUBL7jVjaqb1BMvkq2J5gt/jKOgH4Q==
X-Received: by 2002:a17:90a:ea02:: with SMTP id w2mr872195pjy.99.1610063953408;
        Thu, 07 Jan 2021 15:59:13 -0800 (PST)
Received: from x2.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id bf3sm6448195pjb.45.2021.01.07.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:59:12 -0800 (PST)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: spi: *: Call the dedicated transfer completion function.
Date:   Thu,  7 Jan 2021 23:58:29 +0000
Message-Id: <20210107235832.839221-1-plr.vincent@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I started this fix on bcm2835.c and, because of its simplicity, thought
I should check other controllers as well.
This patch set should fix all occurrences, as of v5.11-rc2, of an SPI
controller driver calling
  complete(&...->xfer_completion);
when it could call
  spi_finalize_current_transfer(...);
as requested in Documentation/spi/spi-summary.rst .

While I did build all modified files, and these should be trivial to
check for correctness, I have not exercised all codepaths.
I have exercised spi-bcm2835 IRQ and DMA tx, but I am still hunting
for another issue which causes completion timeouts at spi/spi.c level
which seem to affect spi-bcm2835 dma transfers (both before and after
this patch set).

Regards,
Vincent Pelletier


