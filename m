Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB9172FD8
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 05:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgB1EiZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 23:38:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46253 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbgB1EiZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 23:38:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so715891pll.13;
        Thu, 27 Feb 2020 20:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srFQTDpYVngqG0eYKY8zeXeTxEow1+Q6Yy9to892+K8=;
        b=OGuISWEli9eLWMchX3FyKGExfAxWPgMbRqfnKQ71+WgTo0dAEu2wLJuIhrKoGocX7C
         NgR5sxtUyB2qc+ar05E0dailbAMsC/Kwdrk8MOBfQ4vYqgtPKQVDCZtupwPoBDBSJaHY
         5N3TV62amf+JgPDxaRZ8kRVzgFexamdDBZnLMUd4UHpeSeFtwRVdcFnfvP7jDC5JxKXB
         GprPn9waSFKdqTuaDbE50CEKUjlPN4vQKSkRzh1HrfX0oIkzMyIVOEFMVnYflBo8FWGe
         ldlX01IUa/AEq4++DIRco4fmEed+VmzvnXwDP4sNJG4uEuNpeZa3AdkdoTFZjyMu7OSo
         lYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srFQTDpYVngqG0eYKY8zeXeTxEow1+Q6Yy9to892+K8=;
        b=Pvqt70CAE30X5SEstTqe/AoHXrntr5wiFDRDQWsFO/s/n/UGPMuvzvBU558YBSAJoa
         Nw5+hiU0mLazPgN8Y5/yBYI+haBkBmWL26g4AyO/tgHQq9tpmSksdTb4os28j1A3o4cY
         xxp3jTo9F9zuK1QOwaY6BJ609BhJvXXinQ1IQz/oCmM7RBpR7IU+qIvaD9PjWZV2Wbia
         88tpx4Ivy3RHq0mFpj51yCzk3mjI/1v7kqByvtNXD7B1LBYOn11RZT6U2ES6eVubuABL
         j0zWAg48d9LLLCyX2izeKXTn2/KbWspRRhe+PSeRKbIiB6Y/SuIoOcAgChpfRZ4Z2rK/
         a1YQ==
X-Gm-Message-State: APjAAAXMsVnTooazmTR59kQ1n9uno1WxP78I40PfxhcUfnd/rgFwFTQk
        uVu3UvGHmG1GomfXTSOtrlM=
X-Google-Smtp-Source: APXvYqyvibBkO+TV6UPsBt0A3f9XT3QV3cG3heDfSZwLqQ1gjV5l3PPpcjCz6rPkJXCg+y5fzWLizA==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr2715072pjq.5.1582864703657;
        Thu, 27 Feb 2020 20:38:23 -0800 (PST)
Received: from localhost.localdomain ([240e:379:962:6595:7b84:9990:1a82:371c])
        by smtp.gmail.com with ESMTPSA id 196sm9069047pfy.86.2020.02.27.20.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 20:38:22 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/4] rewrite mtk-quadspi spi-nor driver with spi-mem
Date:   Fri, 28 Feb 2020 12:36:32 +0800
Message-Id: <20200228043636.559915-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds a spi-mem driver for Mediatek SPI-NOR controller,
which already has limited support by mtk-quadspi. This new driver can
make use of full quadspi capability of this controller.

1st new commit makes spi-max-frequency optional to match current
binding doc and make this new driver compatible with old driver dt
bindings.

Changes since v1:
 two new commits.

Chuanhong Guo (4):
  spi: make spi-max-frequency optional
  spi: add support for mediatek spi-nor controller
  dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
  mtd: spi-nor: remove mtk-quadspi driver

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  34 +-
 drivers/mtd/spi-nor/Kconfig                   |   8 -
 drivers/mtd/spi-nor/Makefile                  |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c             | 565 --------------
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mtk-nor.c                     | 689 ++++++++++++++++++
 drivers/spi/spi.c                             |   9 +-
 8 files changed, 717 insertions(+), 600 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c

-- 
2.24.1

