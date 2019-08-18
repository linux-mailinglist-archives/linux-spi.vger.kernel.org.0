Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0F91890
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHRSBX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:23 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37628 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRSBX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id z23so1068980wmf.2
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u8XzTVZBfrqeJlvd3wmMlaRx+G+WVfGIT6cw2vvd5hE=;
        b=dfWS8BzhbaW9DDbY2Y2M/VqBPU+ZIoI2BeHtkz1VWJRyrXeilydI2fJHpE2scCnL+6
         cMSDgJ9rydiizMAEu0mq1ZjBdnsL2Pkx3Hy7zApdPBSbKGT8OvrEKYlO3H4sA4t4vMZ2
         LAAp0mNm3XLVgHEATvi1h4RLcAOC6hqDO2RUivAU0INJj6x0OMuMl3GYA5PS9qnWhZDC
         fWSkvf7YOILK4tM/Cg69zV5YleTsKuBPenEBW08kI36ebq5LmTjYzLoqHyWPP7AQGETp
         UXciQStqSUP2HPX/AGXHuD8hhvtaBNOzj7S+qYyy4nRFgxT07o5PNXUJgdXSlEs9jduk
         x51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8XzTVZBfrqeJlvd3wmMlaRx+G+WVfGIT6cw2vvd5hE=;
        b=DncAtc8TDjQIog7S9g3+F/5ipsO1blbLogNeuRXkFJEJDeQqpUzaIDjujb0vnf7z4R
         cJJTgOKQsAG21WNumNig5xeW5uavAhY92bUFucO9EQJbmp8mo1Ztc2s/tuK/GeDIuEKp
         UiqxVW+V4H41GK6MTc1D7p0h75AxyJs3NQ9GEaOC0Vj2NU93zV8lFxtwYEne7AEzuhMq
         QNXcFCw4xXSuAcz9Uk4jWIZurTRFErF7fPAQLcQMVhpRBTbhV+ngmgNoQlC21gtd8gCR
         Fo97WzseEP+sMwPH7yUKrwMbVY+27pSgSEAYEfnVGMuaPs23E0wzFlR2yO4TOuid2kcc
         zE9g==
X-Gm-Message-State: APjAAAWKmHtIneDFjLPkNo1mr3gyykoIIdcnX7YVru7EpTORhEzMg451
        2NgRH++cnUVkPgSmELoX1BM=
X-Google-Smtp-Source: APXvYqwaegMAzP9236yUMAr/dwO/i2X6Ar9I0e0IoKjQd0H543PDA2hHdKCrnM3pTT30giOrt8e9mw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr16966221wmc.6.1566151280946;
        Sun, 18 Aug 2019 11:01:20 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:20 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 00/14] NXP DSPI driver cleanup
Date:   Sun, 18 Aug 2019 21:01:01 +0300
Message-Id: <20190818180115.31114-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset was broken out of the "Deterministic SPI latency on NXP
LS1021A-TSN board" series. It contains a few driver cleanups (mostly
cosmetic).

Vladimir Oltean (14):
  spi: spi-fsl-dspi: Fix code alignment
  spi: spi-fsl-dspi: Remove unused defines and includes
  spi: spi-fsl-dspi: Use BIT() and GENMASK() macros
  spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR
  spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and SPI_CTAR_*
    macros
  spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()
  spi: spi-fsl-dspi: Remove unused initialization of 'ret' in dspi_probe
  spi: spi-fsl-dspi: Remove pointless assignment of master->transfer to
    NULL
  spi: spi-fsl-dspi: Replace legacy spi_master names with spi_controller
  spi: spi-fsl-dspi: Use reverse Christmas tree declaration order
  spi: spi-fsl-dspi: Fix typos
  spi: spi-fsl-dspi: Move dspi_interrupt above dspi_transfer_one_message
  spi: spi-fsl-dspi: Reduce indentation level in dspi_interrupt
  spi: spi-fsl-dspi: Remove impossible to reach error check

 drivers/spi/spi-fsl-dspi.c | 657 ++++++++++++++++++-------------------
 1 file changed, 314 insertions(+), 343 deletions(-)

-- 
2.17.1

