Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DEA322D50
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBWPTl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhBWPTh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Feb 2021 10:19:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634BC06178A;
        Tue, 23 Feb 2021 07:18:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so280856wrr.10;
        Tue, 23 Feb 2021 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Tx9yCU+y2QH0djBoX9dU74i3ce2yaqYK7nbKqQkNk=;
        b=TL7oCGLXprchebZ3OdUgGDyW8yYromAzNH+wHU50nir90LyhOyQv2uXnuBPVZPxoDK
         peIiE0nuQYKZFTVYEptyTYEWs8+yhJkDfDbVdPokIhXSizwIK0zkw/5YcdLyqd8CGn1A
         n9+fS/CSh/nrOdlwz1VsC9hHfJV+mo/jRHInjpm5z7IhQehtZdCHl8er8YtHHupWTqeW
         QKfhMmCDsz2KKfDY8/3rfgjL1GmRonVfXj9Sna8zPjurzF2NiiNV7rraZzN/qN+ROY/K
         u7GU4+/pAyV3w/vhj7Y7yzKnUQRrVmEDWhUmPYAstS1BrhHlTTJyrWhmzzKCWoyFrTqZ
         EVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Tx9yCU+y2QH0djBoX9dU74i3ce2yaqYK7nbKqQkNk=;
        b=RkLts1aBB/vcDg8GiGEbxEMu9qVGkx7m2QXZcNZaBH08tUtByEXOg6islom5w+x0gL
         awioTFcXO8Z9fIAkhyYi10SSEwhPrKdc1S4hufbVCdlTKeCqi0NhBgr6meOvhlv0WIVf
         KgOU+VJ/9y97rJ1jXDZGRYMj1jROgkCmuGUFeAn6E7LDF7d1iJYABOvB1/GhS8nM5Ein
         mitUwgOuZImOhFKOQNxneW4x13Zdl2zhXJpiLQn7R08IcB17gNx6YK0SzwG0hdfVNNVP
         SKBbU+p3qRUdKF23FVyS4tyIWAyEjJaeRg3exoqS+T07bPm7btVhAGwzTT0XPbTWGM6U
         Q4+g==
X-Gm-Message-State: AOAM533xXsJhSeLcUgyUDohBjG6ToXk2mvXIG+OebxT2mXm3cJzVHvXs
        DMw7a68ZFYzaksmMmtpWO8Q=
X-Google-Smtp-Source: ABdhPJwbrKG9NwYPkN2geDMRTGukhnvFrpt6ATqs6/5GXBtMWk1846q7TDhSUxUW/ftYmyvXDVmJzQ==
X-Received: by 2002:adf:b313:: with SMTP id j19mr3658184wrd.188.1614093533709;
        Tue, 23 Feb 2021 07:18:53 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id y6sm3018071wma.10.2021.02.23.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:18:53 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/2] spi: bcm63xx: fix pm_runtime
Date:   Tue, 23 Feb 2021 16:18:49 +0100
Message-Id: <20210223151851.4110-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Both BCM63xx SPI drivers enable auto_runtime_pm, but they don't call
pm_runtime_enable(), which results in "Failed to power device" when PM support
is enabled.

Álvaro Fernández Rojas (2):
  spi: bcm63xx-spi: fix pm_runtime
  spi: bcm63xx-hsspi: fix pm_runtime

 drivers/spi/spi-bcm63xx-hsspi.c | 7 ++++++-
 drivers/spi/spi-bcm63xx.c       | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.20.1

