Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9F38AFBB
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhETNOW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbhETNOU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 May 2021 09:14:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB58AC061574
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:12:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lg14so25189764ejb.9
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f54UKwJhTJXefIxJnZnXzEyYN9YjOASRp/4wqeGvMCA=;
        b=fOuKckuS4v5R11mvwAcqFCJD+eF2ZUlCYkgd7VnGA8V2ElWvV6J8+lsAKpn5NqiYfG
         0j3i2iUNN+MAoGKu+Ms1PQ7klG4/7i50/9yHoShvHX/VEEYGLSAWgYq4mW1gCr9K3Wth
         78ZvWTMNlanJxfjhNwuvQx6ystPgj7ga6MV23OjU9NhmMQNAUrZJSJ2Ao6ext5LmZcmE
         boRuC3tcn38gNsX24gjBm+x6S9MKX7IDjL6v+V9RvroegOGudxDbq2RF6TK5QC17QRtu
         l4Yi91KUBCwVGWQzDpMtR87ETMM727O30TUYar90e3RqN+QizvhR15Mx+jukj1i1nt7b
         ZetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f54UKwJhTJXefIxJnZnXzEyYN9YjOASRp/4wqeGvMCA=;
        b=uZesZQuRTIRozix/U+sg47LYCzmIziV8AgZDxHCldMsRYHbkL5O8bZb606IwCZekNQ
         0lXFBTYxPTGv/KBQZd+TZJqRqT17qheHJ95v54E6trfLFQU42MOdm+YKJc9K3CpafSzJ
         T5xqGE8MHC2hONrexTWHubm5hrkMhYDnKxL3f8AxIgM4vUWglVWurzJoM3SL/XsLMyo0
         MgFmMK6hneenThaeJot5q+89C72P30KKUfHqNMw1tOU1UCjyUvmnkz25AwV1HmSUpX6L
         rvp/jkBD8aaA4OZwHYvEXmDBF5NJw5kITgQuNYfQ4uCBPpRYmrhfkoCV/rodKh9keqp5
         g3ug==
X-Gm-Message-State: AOAM5305rHueBDuBUVxKdMxHssFg5pgMlM3RsNsxcz4j5RAXw6QeA4t+
        S4HHDeWaPiEAiEIqmMjgpc2pxoW+ork=
X-Google-Smtp-Source: ABdhPJzYb9PeusqgNwjkiUu+TC1lYwXTSPdPuxwTzkEgihPzUQUWhdBQOWqvR1G/XwAxctFqDNCIrw==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr4613069ejj.16.1621516377507;
        Thu, 20 May 2021 06:12:57 -0700 (PDT)
Received: from localhost.localdomain ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id gt12sm1362505ejb.60.2021.05.20.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:12:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v1 0/2] Export the spi-sc18is602's max transfer len limit to SPI slave drivers
Date:   Thu, 20 May 2021 16:12:36 +0300
Message-Id: <20210520131238.2903024-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

These 2 patches make it possible for a SPI device driver which uses
large transfer sizes (256 bytes) to limit itself to the maximum length
supported by the spi-sc18is602 hardware.

Tested with 200 byte buffers on the SC18IS602B.

Vladimir Oltean (2):
  spi: sc18is602: don't consider the chip select byte in
    sc18is602_check_transfer
  spi: sc18is602: implement .max_{transfer,message}_size() for the
    controller

 drivers/spi/spi-sc18is602.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

