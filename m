Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135CE1154BB
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLFQAY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:00:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56124 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfLFQAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 11:00:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so8338594wmj.5
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2019 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIA0NWCCK4h1Z/JZPXdHERLAqtudgTBcQ16Z5dk400I=;
        b=k+OCABUOgXU2D0H91QEc8C4MBpcCEGP4BtU3hy4jh+nQXUZhONkKwJvVhLEylHMIWe
         4hL9OkcFNYRFW5O13eLzUsQ+6LCpgBnPusEFHz5FPKRgK5vtYn4a2QVARTJka2mLHekc
         gu8I/LQDV9pRztsvXDcvIOHndW3RnPo1o1QfT8pZ/NDzuGXG+2t6UzOqsOrhhjWATi2Q
         5p0WMHuaZ0lnfR7tzkQqDgg6hiBx4xkXLZp0EWYz0cPk5wtpVQpv6Ecl9/ww7GGvUvch
         KXILmz55BX2btblZTaJL/HjFXZhciOuIo4+hbK0TFncZakBphZdJ7GK4nwQ+Uni7+YEM
         CIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIA0NWCCK4h1Z/JZPXdHERLAqtudgTBcQ16Z5dk400I=;
        b=NuYBt3DncDJC96+c5EhfS4ar5ZE0welGk2cokPHZo9rHUKjYIHFFQwp1XlP6zDVKU1
         d3Ty4tBbm0TOCcPi3OxIT9lCub0Hm8td3yCp1u0kmx2svOtJeByBj3jUsvx7SwlA9COQ
         90Pc5o853TmHb5b0gZQym9MeGtVtU3AZPdeK9UvqDBD1OceySymZpfQQFMEi4J3PKY+y
         dn5u1u0KnqDxu8LlhLdBIL1WsC8s6j3NPAc8WA5YTKAVZc3ga5X3Flx2wbbjjtgbr2PH
         JhzmdwITZEYg8JQvcQDsBgbPpI7fnNqfjRdq0L8FJremg0bTWubsLlk4p9EdnqMcgYPo
         eLxg==
X-Gm-Message-State: APjAAAWdmkaCt/SX+XcYDGQ3eulTD68kyhA4X3oUsADHA2CKauTbn5ID
        bEwr1aat36tWBrvuueZZ8zI2hg==
X-Google-Smtp-Source: APXvYqw74RI7bZwglD8R2ii0dsT+fkEoVrUANmipbT37cvligxfRIUroUVQN1eZpKoeIMBQyb6Rcdw==
X-Received: by 2002:a1c:f316:: with SMTP id q22mr11570892wmq.103.1575648022396;
        Fri, 06 Dec 2019 08:00:22 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id d19sm3891496wmd.38.2019.12.06.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:21 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/3] TI QSPI: Add support for large flash devices
Date:   Fri,  6 Dec 2019 17:00:04 +0100
Message-Id: <20191206160007.331801-1-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Large devices are bigger than >64MB in size.

- Fix the SPI clock generation in order to produce the desired
  frequency.
- Since the TI QSPI IP block only maps 64MB of MMIO, use MMIO
  below the 64MB boundary and software generated transfers above.
- Optimize the software generated transfers for dual and quad
  I/O read operations. The speed-up is 3.5x for quad I/O reads.

Tested using raw accesses (mtd_debug) and JFFS2 FS read/write/erase;
in single, dual and quad modes.
All accesses have been checked on the logic analyzer.

Jean Pihet (3):
  TI QSPI: Fix fclk frequency
  TI QSPI: support large flash devices
  TI QSPI: optimize transfers for dual and quad read

 drivers/spi/spi-ti-qspi.c | 83 +++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 20 deletions(-)

-- 
2.23.0

