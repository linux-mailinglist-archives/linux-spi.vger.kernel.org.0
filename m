Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8711518318A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCLNbj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:31:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36739 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNbg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so6332808wme.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKsXFRcK8AcNaumHFcbmSoneU4WCI5BNbLya6zWwdso=;
        b=yGpVXdf/zvaZ2oK6Mt2+1GDAOyAcjE2YL1fV8629Sl0fjgJVBfCic1VwugB4VQba3I
         3QveKXHMnoAegaDY0ROjo174WbRvRCFA5sWlFur932L2a0dceZAXJDFyDaY5+5A+5YQI
         gNC2vQqUjVLeasn5PxXhMAAa7j/16lkRClmD8g5CGiEYmRvidQtzxIKvij4ppKqbZRJ9
         RkonPce8pXKdXw86YvlInePQdX8c1ic7TFrlbZy+1zYerMEU8IIr5GeiLhknxM4jhMEE
         lugULtEYx7q1Bn7ALGTjrbKvlBzUa/kFM7fjsRe4EgyRj6vQWW02NEqOYJiEk3YcI7Oh
         V+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKsXFRcK8AcNaumHFcbmSoneU4WCI5BNbLya6zWwdso=;
        b=XNeZAemjYDEEFlzfHlJs7ZhajKnDSZ4IQSAK0GPe/Ao61AovntHX7IQp+AWqb3MaLf
         zj3YlSlbGa4gE7eYnSkTsUrT0sILSPtWor1JHmkiXNkx0brAbGnl7jQL3emmdg2GeX17
         UYwyJjrwmrHYnAGuixI9RWSW3OmwLYlI2NN7lszU8K9y8s2/pQKVR4NA4hbCE5UNPi0B
         uhoDnUZOffhMg1GL5yvcOz+XffZzZf0TVq35amd67NrtPfa1HbHSZKLD1pSKIZIHU8CC
         SjvktFLxUVaOI/PgOYbUPfuaV2A+BjfVZhX2zudTeXOcte5lh3e8GUK69ERyG57ifgpH
         vhcg==
X-Gm-Message-State: ANhLgQ0OTm6au72jUWjGuSqvv9nDKJBJ6jwUUFrHTa3f5z+BhSFMiJM5
        tataEOKZWXAB1Jsks6F5vknimw==
X-Google-Smtp-Source: ADFU+vu4/CzgwwWNZw4DY6j6M6oytrcB21iZBNHToT/4H+n6Y97GqaxPnIoWB+xUtDlIT2K+uneEpQ==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr4903051wma.89.1584019894533;
        Thu, 12 Mar 2020 06:31:34 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] spi: meson-spicc: add support for AXG and G12A variants
Date:   Thu, 12 Mar 2020 14:31:22 +0100
Message-Id: <20200312133131.26430-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPICC controller in Amlogic AXG & G12A is capable of driving the
CLK/MOSI/SS signal lines through the idle state which avoid the signals
floating in unexpected state, is capable of using linear clock divider
to reach a much fine tuned range of clocks, while the old controller only
uses a power of two clock divider, result at a more coarse clock range and
finally is capable of running at 80M clock.

The SPICC controller in Amlogic G12A takes the source clock from a specific
clock instead of the bus clock and has a different FIFO size and doesn't
handle the RX Half interrupt the same way as GXL & AXG variants. Thus
the burst management is simplified and takes in account a variable FIFO
size.

Now the controller can support frequencies higher than 30MHz, we need
the setup the I/O line delays in regard of the SPI clock frequency.

Neil Armstrong (7):
  spi: meson-spicc: remove unused variables
  spi: meson-spicc: support max 80MHz clock
  spi: meson-spicc: add min sclk for each compatible
  spi: meson-spicc: setup IO line delay
  spi: meson-spicc: adapt burst handling for G12A support
  dt-bindings: spi: amlogic,meson-gx-spicc: add Amlogic G12A compatible
  spi: meson-spicc: add support for Amlogic G12A

Sunny Luo (2):
  spi: meson-spicc: enhance output enable feature
  spi: meson-spicc: add a linear clock divider support

 .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  22 +
 drivers/spi/Kconfig                           |   1 +
 drivers/spi/spi-meson-spicc.c                 | 496 +++++++++++++-----
 3 files changed, 392 insertions(+), 127 deletions(-)

-- 
2.22.0

