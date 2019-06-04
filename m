Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B875F33E36
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 07:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFDFNG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 01:13:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44026 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFDFNG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 01:13:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so9610238pgv.10
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aNKVy2DGZ1XbB2jMTzpFz0RJ7NoX9Y41ZJYPxfQkxw4=;
        b=x3v6XPI3tnvxXgC+Dh9vZU6Y3AlD62dPZDzT+m0ihjUv9Y3RjKPBTLNEdZasmFI7iz
         Z9sBSSSfP7p0UtLdIkMQ8kLy078SYeKjRsSMjSpoh0MKCiB6IAklk3gEX9+R3AUF4JUe
         DUM2wHCaUG1PpaW8O2dSa5bHkYM84rZzbH1AuhYs1aU1HoJC80VfK7W3L8okw52flrWF
         trVbTotwzeLo/LhV5GKVBGnYaLczfQaNdCxEvXSS06RRNb8A5AnCPgsgnsF9RSwPXcVf
         klfWufWSC8k4Pj2D+2s3QTuByV83w8vrnP1IgQhgb6UDGxyczxMSx1frqv0n0fvTCsn4
         5dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aNKVy2DGZ1XbB2jMTzpFz0RJ7NoX9Y41ZJYPxfQkxw4=;
        b=pxlzc3j46plKGck6FQcNWFTZVX5HmDNjrwm/d9xOxpE9QJOcijG3DcY07/Or+cXcY5
         SuA34a9jMupA7nFBU0GY0hqJM73jZkg+5Xa+p3iZKm5uDHbp42RdcXT0ebI1+m1sSHTQ
         kXKvTTv4EjL2BnHYJJFJtF/ZBSeqyev1sn/dmnI/re9TruFq/C/b6NvuWZSHOwEVyatD
         SsKNRfXGtNUyaH/8Hj2fJyhJTQWU1FrXNLl/6xmsLgDNykkVrTt9hDKYl3IPg+VSn8gB
         0kJ1Chqc0GgyauUnFE2BGb7Msj9cYmM6OGThEQjOz74M6kQAsrRL456uAiYAptr+CcZo
         YwEA==
X-Gm-Message-State: APjAAAWtVfWYc5MQs8jZbRW+t1bXwFsdwChQHnV43J5Nf4Iml45I70Pw
        qB1m9bkAFvJo2OoJ08R4tpW6wMdVwsA=
X-Google-Smtp-Source: APXvYqwivYqzWUvKUdy/NOvDMYrprKVMFmKTzox0HN/hPPMyChz9SEIaa2yRg4GUtoVtpNO/vrkRiw==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr32263097pgs.24.1559625185518;
        Mon, 03 Jun 2019 22:13:05 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id 188sm694219pfe.30.2019.06.03.22.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 22:13:04 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 0/3] spi: support for Socionext Synquacer platform
Date:   Tue,  4 Jun 2019 14:12:54 +0900
Message-Id: <20190604051257.14264-1-masahisa.kojima@linaro.org>
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

Changes since v6:
        # Removed dependency to SPI_BITBANG
        # Added -EPROBE_DEFER handling for devm_clk_get()
        # Added check of invalid index(0) of platform_get_irq()
        # Set the fwnode member
        # Removed redundant error check for sspi->clk

Changes since v5:
        # Supported ACPI probing and added ACPI device table(SCX0004)
        # Removed DT dependencies
        # Removed to call _relaxed variants to access the registers
        # Updated irq name to use dev_name()
        # Updated return value for irq handlers
        # Explicitly listed the supported bits_per_word
        # Removed FIFO handling from a set_cs() operation

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
  spi: Add spi driver for Socionext SynQuacer platform

 .../devicetree/bindings/spi/spi-synquacer.txt      |  27 +
 MAINTAINERS                                        |   8 +
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-synquacer.c                        | 822 +++++++++++++++++++++
 5 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 create mode 100644 drivers/spi/spi-synquacer.c

-- 
2.14.2

