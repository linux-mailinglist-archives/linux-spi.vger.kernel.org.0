Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576CD2C326
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfE1J1U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 05:27:20 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45007 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfE1J1U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 05:27:20 -0400
Received: by mail-pg1-f171.google.com with SMTP id n2so10613359pgp.11
        for <linux-spi@vger.kernel.org>; Tue, 28 May 2019 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CIJVEqaFcuXlG2PmkzFOjP7GqCEMYy6kLdJ7KvantVY=;
        b=HaS6kgqjX5rJ44z2hupjPtRqolzhnPv6lB1DjjfdQA6eyz0fsz8tF+ymJ+w7k2EV0u
         ffkqnXm3cHouzYS9k4AGgcO6PZSLA6StcJs4LV9Pq1ukTGZWdzrDH5mijRQbXbgs8+sz
         JKA8uKs2oXT0v48CBClFu4leJoYaa2MZt6SMelMTQ18wica2swFh5sJVtUZ498IHVPTI
         xdkMvSOg/p9FzmQJbD/iFZnU0kubsbmaWTA4O/VlJOy22ytVV+yhjFQMgTK2+iZxB9U/
         E1NgJhDUGFcb48PNNt4z4ldQIeDeojdvlzKzDJuZyfCLmR3ElxfvTR3eK5FVaNCmJoCt
         z5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CIJVEqaFcuXlG2PmkzFOjP7GqCEMYy6kLdJ7KvantVY=;
        b=oFuw50gvX5oy9j7QCywrmtwd74mFJQWNBKoDyJ9qGlDioJqb5Y63uYwTsWJw/8mc/T
         t0jeATnp4KM3ZxRqq+AzlHIbFFQDiZMXkFq9tvelepyRfxo6JQ3WNLnNNfI+NXtt0eRI
         qFkrAcYRZ6ALKuUHJLyFkw/LzpJM1bx+3Of5MVAQuSF/XES+NPDTWQEAF0KBCesuIBVv
         aZkY3sE47sBFLHN+PuiNCoP0MqtPnyPegiN4Ps1daE9+AuYw7DEzNeBTa3FdAYj5uG1R
         MDS2WVUPby0CRRkeuP6rtvjA1FdeEgi8tOVz9d04ELzlNzsI0BlFjfvKahv95s0IAM0k
         3vfw==
X-Gm-Message-State: APjAAAVcWx9S/P1SyAeMRYAyFym1O8rtI90xQ5Ifb47FHmdN5M2UuOEr
        0XmQapt2UWRRZf0Icpct0acbFBbM987tOg==
X-Google-Smtp-Source: APXvYqx2KLxhjurSP8gXezzE05PEVYaAyMc0F9/TCn1hkmQjTedOgSTWEQmiTLWYCR/Wb4Gpd3aQ8w==
X-Received: by 2002:a17:90a:25ca:: with SMTP id k68mr4597517pje.14.1559035639416;
        Tue, 28 May 2019 02:27:19 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id u5sm11148161pgp.19.2019.05.28.02.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 02:27:18 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 0/3] spi: support for Socionext Synquacer platform
Date:   Tue, 28 May 2019 18:27:10 +0900
Message-Id: <20190528092713.10516-1-masahisa.kojima@linaro.org>
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
  spi: Add spi driver for Socionext Synquacer platform

 .../devicetree/bindings/spi/spi-synquacer.txt      |  27 +
 MAINTAINERS                                        |   8 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-synquacer.c                        | 826 +++++++++++++++++++++
 5 files changed, 873 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 create mode 100644 drivers/spi/spi-synquacer.c

-- 
2.14.2

