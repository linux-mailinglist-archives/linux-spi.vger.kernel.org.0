Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6824E70
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 14:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEUMAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 08:00:22 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33811 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfEUMAV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 08:00:21 -0400
Received: by mail-pf1-f177.google.com with SMTP id n19so8982547pfa.1
        for <linux-spi@vger.kernel.org>; Tue, 21 May 2019 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wTQQ4tnUOPEumtOcTObZa2COSR0xStpAo/AQeMIbjEU=;
        b=k+Yu8IuOc79cazlM098CDNWfWGpY55r1WuofoQgG1SjtZxxBCY5xBfdPFo+EZagOdu
         ZCr2rGO42i5Aaytz4ZLlAAOm45b7zX5KP2zGlbpIcTHN5N4I3xLkEyBunfwXAQ4jvq/h
         TLOgV3SadGJsEjheOGz33nmInvCkh10MabOIy4Fx98pTjjv9da7Z7oL6MXO1alfJzQ71
         wt9yls0RNAEHOajdArPhgeHZgaf97g8xT8OTmbvbGSWmF22HbwAnw3tdbGhNpCDwtwjl
         XtKdkFhrFZG2do6fRubiIGoOhlj+4mZZ+gB7+kubcOTYw2OnqK7sHxFpFzHe6hxgmUsv
         ZVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wTQQ4tnUOPEumtOcTObZa2COSR0xStpAo/AQeMIbjEU=;
        b=Id2bFHAn2osmnn+dzxHRL7Yuokv09QAuvyVWJJ8qxmVnbnywYagJihjHD42HmyE9+h
         ++uLJQvvLBijggd5ckfT5Sp4vXbg018UItp9MPbY5sJPgRDLshe5pcrutfE3Ny87jL5g
         Tjmxz2VUqjTYzSbFt5wyllmdFxzHLZjcOT8Ow9GF1vrEdWixK9PVDoDn5aikUrVhmMsb
         YFfH7rOEJDWZka+D+g1JxV+Y4y3/2XqNR6g+atR0hIRoQUCdVwsC8roGVW9utd2LqST/
         RHfkezQwfPjUD6FZGnUgVcq0GW7EtDkSTDnbfjmsmPiMxkDOS3uQ6F+i2pmfMX2tbH+n
         MNOw==
X-Gm-Message-State: APjAAAWu0lYSIWtVRUZKR8QwBaES7ZKWaVbm1NprOf/aMBsN+dD8W4E7
        ts0Xrb6Km71sDDX86ORhOUTk/IDB3zh1MA==
X-Google-Smtp-Source: APXvYqwA0+w2DMWmkEEF1qpIcAjH3V4da/BTGY/0b04rbv502u22DWIPBmJudQe87bT7xvOp+aMkaQ==
X-Received: by 2002:a62:4281:: with SMTP id h1mr87260377pfd.162.1558440020178;
        Tue, 21 May 2019 05:00:20 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id v16sm3466356pfc.26.2019.05.21.05.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:00:18 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 0/3] spi: support for Socionext Synquacer platform
Date:   Tue, 21 May 2019 20:59:55 +0900
Message-Id: <20190521115958.22504-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

 Support for Socionext's FIP controller intended for flash device interfacing.
The controller can operate in 'direct' or 'command' mode. One mode directly
talks and provide a read/write i/f to the flash device. Other works as plain
SPI mode. This driver runs the controller as a SPI controller.

I took over this driver update from Jassi.
Although more than a year has passed from previous version,
it would be great if you could review this patch series.

Changes since v4:
        # Supported interrupt based data handling instead of polling
        # Added prefix "SYNQUACER_HSSPI_"
        # Replaced data read/write access with readsx()/writesx()
        # Updated clock source handling, explicitly specify "iHCLK" or "iPCKL"
          and removed array of clk

Changes since v3:
        # Convert IS_ERR returned from devm_clk_get(iPCLK) to NULL, that way
          we can call clk_xxx(IPCLK) without first checking for it being valid.

Changes since v2:
        # Made iHCLK clock property required in DT, and iPCLK an optional extra.
        # Hardcode max number of slaves to 4, as specified in the manual.

Changes since v1:
        # Changed licence header to C++ style comment.
        # Removed redundant lock and transfer_mode backup member.
        # Fixed divisor to allow upto 254.

Masahisa Kojima (3):
  MAINTAINERS: Add entry for Synquacer SPI driver
  dt-bindings: spi: Add DT bindings for Synquacer
  spi: Add spi driver for Socionext Synquacer platform

 .../devicetree/bindings/spi/spi-synquacer.txt      |  27 +
 MAINTAINERS                                        |   8 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-synquacer.c                        | 731 +++++++++++++++++++++
 5 files changed, 778 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 create mode 100644 drivers/spi/spi-synquacer.c

-- 
2.14.2

