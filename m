Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04F22102C
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGOPGh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOPGh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7841C08C5DB
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so5946545wmj.2
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRvTJfssab5Y/CSiD8kCb/7tb1fC8xBCKdijnh6hB8k=;
        b=BF2RTKCOfZ8Rm9yLgkbNV8cuXjX4Jeia930iQEPzWmJSLrXa4ySqNPOZ1SZz4xt/LD
         KtyCw36bQyMkTViQB37YRaG9s8XWqdNaH3DzV5nfALDDqeD+uz2U0Z5puu6c+SIOsIS6
         T4CeAZfLRfYMweBso/ZdIIeChrdXnM6f/1tIsYSKko6xBs+ELXTc3cSvr/pwntM4x7ji
         zSPz1uk5l0CqbpvmSkslxtlZJDET5F74ICRin0AAwGEmgLC3CZtlVcbMu8PybMUfxI/U
         5U0+aPOXQRuY6AY8fDavAvui4v5zUTpZSKUpKc7YVKaeAwOVjPXh5SeKH2NfEkcqNw86
         +Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRvTJfssab5Y/CSiD8kCb/7tb1fC8xBCKdijnh6hB8k=;
        b=Tynpq28Od/MROb+wJX0zbtSunvNHLkeaoFDuGR0Sdgx063f4cmm5swtIsuRbC0p/Rq
         Sg7ca2X59yPsSAS7BKCJ185L7bQ1LGpm7zPmitUTFREWQvJk4S3B1i+nLW/8np1z6Kek
         XRp4j/die+utyBswTp643qEAlLDzg+eopF/XVZ6rK8THJUdq9X/IFFmTmrd9pF82EluW
         9mYbCLXiG3cDoZtgPGXgjOZIX9Ro9Sb/mcXQdNmiVsKVegzf8v+gxloHUBOyMpc64oJy
         jomFOSvSNsOo8o0Sj912wfT2nIVUwHl3VIwMY9ucwhORy49VBhsn3S+EJYkT5JmKXp26
         PVbw==
X-Gm-Message-State: AOAM531iBLRyUuBO92T/n/ebv+4KQ0xY0HYH0U37zzNd6JmaY5gI9cxV
        jRMoZIIl/ifW+R6ImPvi5KRnnQ==
X-Google-Smtp-Source: ABdhPJzOoFptPuUiAhy7TR/n4BljiYkEMvNeuBQSWGiNufyADYxFeRx7E2+ui19Bo+DZlamOpSm8kw==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr9263475wmi.85.1594825595356;
        Wed, 15 Jul 2020 08:06:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/14] Rid W=1 warnings in SPI
Date:   Wed, 15 Jul 2020 16:06:18 +0100
Message-Id: <20200715150632.409077-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/spi.

Hurrah!

Lee Jones (14):
  spi: spi-loopback-test: Fix formatting issues in function header
    blocks
  spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard
    comment blocks
  spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
  spi: spi-ep93xx: Fix API slippage
  spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct
    meson_spifc'
  spi: spi-meson-spicc: Remove set but never used variable 'data' from
    meson_spicc_reset_fifo()
  spi: spi-s3c64xx: Add missing entries for structs
    's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
  spi: spi-pl022: Provide missing struct attribute/function param docs
  spi: spi-zynq-qspi: Add description for 2 missing
    attributes/parameters
  spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
  spi: spi-topcliff-pch: Add missing descriptions to 'struct
    pch_spi_data'
  spi: spi-at91-usart: Make use of the defined 'struct of_device_id'
  spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when
  spi: spi-amd: Do not define 'struct acpi_device_id' when

 drivers/spi/spi-amd.c           |  2 ++
 drivers/spi/spi-at91-usart.c    |  1 +
 drivers/spi/spi-bitbang.c       |  6 +++---
 drivers/spi/spi-davinci.c       |  7 ++++---
 drivers/spi/spi-ep93xx.c        |  2 +-
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 drivers/spi/spi-meson-spicc.c   |  4 +---
 drivers/spi/spi-meson-spifc.c   |  2 +-
 drivers/spi/spi-pl022.c         | 14 ++++++++++----
 drivers/spi/spi-pxa2xx.c        |  2 ++
 drivers/spi/spi-s3c64xx.c       |  9 ++++++++-
 drivers/spi/spi-topcliff-pch.c  |  8 ++++++--
 drivers/spi/spi-zynq-qspi.c     |  3 ++-
 drivers/spi/spi-zynqmp-gqspi.c  |  6 +++---
 14 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.25.1

