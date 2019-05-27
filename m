Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A772B6AC
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2019 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE0Nlb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 May 2019 09:41:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE0Nlb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 May 2019 09:41:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so8589855wrm.10
        for <linux-spi@vger.kernel.org>; Mon, 27 May 2019 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtDy3UqUv5LCOqIXsFJGqcQMLOz550V0nprsW2J4Uqs=;
        b=wRxTnBMZt4cyd6WSY+pJUHPjaTqxPDKslWD4fOAz8Cl2ktdI78Ttpi98/VNQZgMMhd
         aQZroMDNgYrSKNN5UN95MemKkMASMsxQPlnFHtESyOSQnBMvR+HaF9LfzxQO1c/R6x+5
         DGyUbTd4JEs885rGAnMICBiTHoU6mN9oX61c/ZpdNQZEn6+z7S+yrQ7mYPyF4AFE0pJG
         CB2QHL0pbFzN2w4+t7iQj+VufoK2s2CXmf7xai5IiJu57Os/SDq05AU1LFq0ruYrW/aD
         v/VEf+IplThk/8c87IVibob6n5cg4dHuQIgDwqlNxehqAI/Ci4ALdnMQ72C6SfthBx7w
         i9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtDy3UqUv5LCOqIXsFJGqcQMLOz550V0nprsW2J4Uqs=;
        b=dLza0jG3lNFQC9UuMdjwQYUFpCcdiA5oqE/MevzJapPwy+WWLAJjlk+oYM3JjlHNBc
         kmFG6zrW2ZDpI2B3fsCAt9q3XY18KaRM4FZAgsb2cbM15vGrZdxexeheggPVW2v/MykR
         bsipgqSycmjdXX5QbiwzSeoinSPa2csP6HM9S94G3rIUhzKEhFKfRPgQak8eELYjovR8
         yKfvYc3wDr/cBIyJxrMDbGecZUii43pEbuxCcYHrUqspYt23Rpi6HGFUlFowgRyFVkjF
         AIDI9007MdDcEAZNJGDUWaxyUIX9RCXqY20/M/pIM/yHt60f6dJCJNSAB7Tu+BrjnRu5
         Ishg==
X-Gm-Message-State: APjAAAX+9ifu+4K7XymRYHY4CIo9kLxBTkjZeps9LnuOkVniVEXu0H06
        uNO53PiQBZ0He/VJwLUxmZNnXIGmSdiPNg==
X-Google-Smtp-Source: APXvYqwDoS1XKkP03Qo+GoG8JiTCdQ46ynTcTBid/U8fuWfQmDWA+axN+IkEGbAUdXNQUif5PkUSqQ==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr21780561wrr.122.1558964489668;
        Mon, 27 May 2019 06:41:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm19631838wmf.14.2019.05.27.06.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:41:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] spi: spi-meson-spifc: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:41:24 +0200
Message-Id: <20190527134124.3034-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- Moved to a single C++ comment block

 drivers/spi/spi-meson-spifc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..f7fe9b13d122 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,15 +1,9 @@
-/*
- * Driver for Amlogic Meson SPI flash controller (SPIFC)
- *
- * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Driver for Amlogic Meson SPI flash controller (SPIFC)
+//
+// Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
+//
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.21.0

