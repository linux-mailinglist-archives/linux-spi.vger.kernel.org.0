Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9716BE2FFA
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407981AbfJXLIT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:08:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45850 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407979AbfJXLIT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:08:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so20616076wrs.12
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2019 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0g0gCs8B4ctO3mEDC1r9JFPGQsTmec9MZxSlQMJySuI=;
        b=q6R1IYFmN/ds2zlqqez18/pHwy/xbiQ8xOSdgsm+z80kzmWgpKtFvMa63dX331/ygb
         Hg6iXRsiP0Ty2sIGTSDQ1CbIh6h2bFhdpuAbkvLrZ23yzbcfdXc71YdMgoavnZ40+1n8
         DsKL78sc3enLuHRO48cRZHupSR1NBeEmbS9HDSiVfh8HASsJQ7/Ydl4hbe+3j2/jYub0
         sDfxaNyyJJiUB1CueXm7vO3Hg7psGn7HONQunBLMWs5q2jEgbmFEYddO8lp3aRsJMYy2
         I3jCaOYS8xV9v0qhnzzKrx2hWFbwDE6deAp7yUQFKAQT32TXs3cexKj4kjrHXvvV+l9m
         JkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0g0gCs8B4ctO3mEDC1r9JFPGQsTmec9MZxSlQMJySuI=;
        b=cZ3UWeJWhO5z3QQ6ckC4fkhoL+cbzP/SK8GSroZyMSIUG75A56sgIvRunNobYARuc5
         Rimd6ddUdSid88Ms0YtV/bZjPEYXkVeykOG8GSTCVa+RsPisICSRC+xydxPfnxy6Ac3A
         WOqcQnCB98y2YIlre+P53yxoRPleO8yl3rUPdxCMZpXcrFG6T/keS3rzPU3CTWDQsOQw
         N87elDuN4iNxSjjqaFgWUTL+od2GhWvOVpya5pTmKuHGs8JdQKg0bJTIVNttqLxL77IS
         fHuJU6SSTkvABg7sxTBQlqfc98gUmi3SJ508agZTgzasjbWrkawzgMLBRhCv+266JY+r
         CqZQ==
X-Gm-Message-State: APjAAAX3ObtnfN8NWMEgx9wyCHHn2YYgLfVSHENVOzsAxUHYRJMS9lqB
        13YhknuXUgIH1SpdVXk1j+6nrw==
X-Google-Smtp-Source: APXvYqy6r1/sFGykdET/5TS2/1rs/lXJ4rNqwhvc8V+6YO8twZAfZ0tTFcsqZtAqeEGHnButg6a4oQ==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr3267191wrn.261.1571915297016;
        Thu, 24 Oct 2019 04:08:17 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id 26sm2420473wmi.17.2019.10.24.04.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:08:16 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] spi: set bits_per_word based on controller's bits_per_word_mask
Date:   Thu, 24 Oct 2019 13:07:57 +0200
Message-Id: <20191024110757.25820-4-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024110757.25820-1-alvaro.gamez@hazent.com>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

By leaving this value unset, a default value of 8 was being set later on.

If it happens that the SPI master driver doesn't support this value of 8,
there will be an initial inconsistency between the SPI master and the device
itself. This isn't a problem for most devices because kernel drivers
associated to any device set the correct value themselves, but
for device drivers that do not change this value (such as spidev that
provides a userspace accesible device, which doesn't and can't know the
value it has to use), an error is raised:

xilinx_spi 44a10000.spi: can't setup spi1.0, status -22
spi_master spi1: spi_device register error /amba_pl/spi@44a10000/spidev@0
spi_master spi1: Failed to create SPI device for /amba_pl/spi@44a10000/spidev@0

When this happens, the expected /dev/spidevX.Y device isn't created,
and thus the user can't use the SPI_IOC_WR_BITS_PER_WORD ioctl to set the
desired value.

This change sets the initial value of bits_per to the smallest word that the
controller allows, so of_spi_parse_dt sets a value that is usable by the
controller.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f9502dbbb5c1..794e20e54237 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1792,6 +1792,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 	spi->max_speed_hz = value;
 
+	spi->bits_per_word = ffs(ctlr->bits_per_word_mask);
+
 	return 0;
 }
 
-- 
2.23.0

