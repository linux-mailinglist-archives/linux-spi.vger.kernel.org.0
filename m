Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404A515406F
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 09:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBFIjB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 03:39:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35889 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgBFIjB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 03:39:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so2225081pjb.1;
        Thu, 06 Feb 2020 00:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwGyHmGXfASIaRJuQY6L3gHfMqGpjQ8XwHA8GdO3X0M=;
        b=KtIIxuuRoKtbZHisofd3Pl2bTYEcpTmy1wF14kxJuSeuZN40PbwtM3axETID8KGIDE
         0HUpsXxKTecPjTUEaeJ2Icf6auWOjJGHPGDb0/f+nFXwYFXyxaVhaDkgr1q+C8HIla2g
         t74BrZCV/B6Mrnki4QYhMWNPGYvXYU7RYu2jN+Ay8Hc3c7emrZIdEeEocZJdJKdKw/yI
         pV7AKDIqlHXEkmdKlb2kyx3ch2IQYDx70Adw11rv4hGDo41SOjOC766Cc5cRXiH93yJk
         J+4RHtGgxuT8ADKebKgfDxzKM69VfuUzxCtMUFvnxz69+3AuGHnC/R7iG6Y9i0ARM/BK
         jeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwGyHmGXfASIaRJuQY6L3gHfMqGpjQ8XwHA8GdO3X0M=;
        b=jNz+tkRLasQF6ajYRkS4w3KI/CFuNGflG0M9Vx2/GhbtQrp5UgBu0ToSK2UwKm6axq
         d5eR09olG+zbhl3mIBIgDen1Th7Jr/5d+ByrBPaTU70x18YxQxOpUNOPwGtTP8aDlvdT
         goOxg26JNRWic8v3fF9Ut6S52rs3pN4V+P+NGKBSunaf1FL8z8D6CcyAcg4LhDEBetAw
         TY8PNXX7LTlIiwiDANv7XLbW9KXGZTY233fHHBuoKRUo6yX4TbGTmfDhOZYjs3GvwHGF
         fSdUeeGmb1U4uMflXZcfHQPgeDD1uO6Pf+R06a/SGIc7wZNTrviSWs8TC6qZv7UBskLC
         Rd4Q==
X-Gm-Message-State: APjAAAUbYKccZE0t+By4RbemGMuzhWk9yIUWkwltOyG47GrU1N2JJv78
        hr8ZWujISe1GmgUGHvw5QclciUhOhiBNpg==
X-Google-Smtp-Source: APXvYqwel+KlR93iMSA/Mz/DvVQAx8knXFQc2QhmrHwXCA5syYxUqt+Uy6RIll2QhNRErJONC+JVbg==
X-Received: by 2002:a17:90b:30c9:: with SMTP id hi9mr2833551pjb.81.1580978339267;
        Thu, 06 Feb 2020 00:38:59 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id y9sm2387631pjj.17.2020.02.06.00.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:38:58 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/2] spi: add driver for ar934x spi controller
Date:   Thu,  6 Feb 2020 16:38:20 +0800
Message-Id: <20200206083822.204534-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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

Chuanhong Guo (2):
  spi: add driver for ar934x spi controller
  dt-binding: spi: add bindings for spi-ar934x

 .../bindings/spi/qca,ar934x-spi.yaml          |  40 +++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ar934x.c                      | 230 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 create mode 100644 drivers/spi/spi-ar934x.c

-- 
2.24.1

