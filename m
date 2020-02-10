Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A67156E06
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 04:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJDmR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 9 Feb 2020 22:42:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43808 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgBJDmR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 9 Feb 2020 22:42:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so3143586pgc.10;
        Sun, 09 Feb 2020 19:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVQEipw/V1PQdbjb6en5Z/xUaGnvev/S0+E9pKZWIS0=;
        b=FBwUU0EayhWh6m7f/Slaih/Rk3y2igeCeNTgiT46TI3WzaePHxJfR/FGXk2G5QpHl5
         waETacbFWZzlzcun0cB/l9T1Shzzs95/kbZXeo5UWUCYYtqIldMBC/UeekPdtjrHlVwt
         qWsIPljMUmrSDw7JAtVKEtC9T+YnchWHEuXTccnyukNpGPHs7iHfDuTyLdALdOEOf2GD
         532Yz4kGIfvRdjvik8/VUovmUgY03ea3z9I0G0/aPf4GnAkzZRb18oR02MV2VktV1p82
         mJHJ7S105sFGIZB2X3i//f+75P9y1jlcP5Mc62/ObeBtwRlQWAmaHu0+aWMkUHp8WiaJ
         mD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVQEipw/V1PQdbjb6en5Z/xUaGnvev/S0+E9pKZWIS0=;
        b=DvlkFyMiM2Czadr5fzQL3YY9Qi0J2W8HuLBrVLHIHqGa5s8Vj1aOduuYM4TPOiGg69
         9Kgy/P6v/DfP9hMelfVsQhftQYUleuIlT9DagcBdgYBP6iTZRmA3SkJFTPQit4EOf2XG
         tQF9ZvL0MYzpLsAnOy3GNG5WtP2Bav/pF8YQ/bYtmhTV2HA7Upf0V6oMlKmDUPzpJBKn
         y9JBLhKgODokzmbtWDHLqUOF21j3Jk6EVXaFsENzin9bKWJ2LFwKkxV8NZIys01j6uDn
         FsXK30J2mDHGiCQKwEBHTQ5Z4a5EcN9tGuZcRA6yBSqUwPZFs5MJxMGVWNFm2hoHniS5
         v51g==
X-Gm-Message-State: APjAAAUReejd28RrqnStcZVFEuOhEuJLfh9T3nNJ2i3g5QtYNYnkrUzQ
        RkZmL8Czv8ncESRsMaUTFwF6ymcwrc8=
X-Google-Smtp-Source: APXvYqzudRw6ObqKjB1jeC2DAZO04Vm2f+aQBDuW+Nv/Fc10RTwkTAka+gCQLj1QqvzLBwBWkUoGXw==
X-Received: by 2002:a63:c846:: with SMTP id l6mr12136278pgi.144.1581306136810;
        Sun, 09 Feb 2020 19:42:16 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id j14sm10179880pgs.57.2020.02.09.19.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 19:42:16 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v4 0/2] spi: add driver for ar934x spi controller
Date:   Mon, 10 Feb 2020 11:41:50 +0800
Message-Id: <20200210034152.49063-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This controller is a superset of the already supported qca,ar7100-spi.
Besides the bit-bang mode in spi-ath79.c, this new controller added
a new "shift register" mode, allowing faster spi operations.
This mode doesn't need all the bit-bang code in spi-ath79.c and needs
a different clock setup, so I decided to write a new driver for it
instead of extending current spi-ath79 driver.

Changes since v3:
1. restore pin state in probe to terminate unfinished SPI transfer
   done by bootloader.
2. replace clock binding with ath79 pll as this is the actual
   clock binding used in all SoC supported by this driver.

Change since v2:
fix binding documentation check.

Changes since v1:
1. change comment at the beginning to C++ style
2. rename ar934x_spi_transfer_one to ar934x_spi_transfer_one_message

Chuanhong Guo (2):
  spi: add driver for ar934x spi controller
  dt-binding: spi: add bindings for spi-ar934x

 .../bindings/spi/qca,ar934x-spi.yaml          |  41 +++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ar934x.c                      | 235 ++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 create mode 100644 drivers/spi/spi-ar934x.c

-- 
2.24.1

