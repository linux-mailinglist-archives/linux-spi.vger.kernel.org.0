Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1AE2FF5
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfJXLIJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:08:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392305AbfJXLIJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:08:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so16823923wro.0
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2019 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crqpJF/gwHkmsomaDb8OpyO/FffTCuDAexg/TaLh4BA=;
        b=fEC4Tv4PTMH7uhAUOrLRmfrjzOIjEAo80TJRvbjAe0+PBa9ZsbWovwYosARMsOsKU0
         ax3a/Qn8GrdCM1hVoth6F/J9gYdu7oSOFJINMLxSjPMy6znHJ0i4Dk6jXPHcHLNu3Jt2
         g8ovXhJ/VULZ7Vj7abgJRQaI6Bv0ZEEbg8cLJX7fsUOHzSpoP5LgMk8m4YuGiJ2S2jQL
         0lVDqFMvKkmzN/yaVNfSnIiBVUe6NTidS6xfQiF50GllIp4OETjlCuOpN4YMERuXsibv
         GCTH7mOX1NSJbzXt18qgnhep/hA1GFgqpDltF9LrXgp1tQqAb3s6Qw8JJkSQ0zFtvPRg
         8V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crqpJF/gwHkmsomaDb8OpyO/FffTCuDAexg/TaLh4BA=;
        b=HqX+36NTnc4KpiDV87TFi8wYWyzXXH00WDMGpTqcZzjjOV0VINTA8T3IyfRQGwCJQ6
         thOEgd6bM4M8RkibQxbF2nmuHUkEHHp44iDOYKndLc6C/RK/WR1Wd2b/A7WCs+XzJY6J
         81iy9Q6CGLAjNCJouRuFcJDPi59ABkS8eeWMRDeRKG+h7MijXcHOyg4UsD4fusFyR+rz
         cXjlgoVHbNGy4e0w6Pz66k0KWk5ABF3hFejAzkgJrNN+Sqk5nQVi6r+JR+7X3GBkwr03
         cQaUVEFnlJr6twYDNF1S/pvkAdxY53bMfGedg7mJqyrhFyStmeqEyFQgfuUQHE/tIdf6
         X00g==
X-Gm-Message-State: APjAAAW8RUP/7/HxnruVlvq3EnWAkdG0bkQK4fBDWcEYFDt/9D4bXomb
        T55SKdhlaSMDV6QDuUR3QVfNXqjUdkA=
X-Google-Smtp-Source: APXvYqzyzUJN8n1oom1/IBXRdUqoiC3M42qRkqVkBeyNaoa+BBzO4nLXhb9mUSbNw78q4yC5OYQaJg==
X-Received: by 2002:adf:9044:: with SMTP id h62mr1491565wrh.91.1571915286700;
        Thu, 24 Oct 2019 04:08:06 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id 26sm2420473wmi.17.2019.10.24.04.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:08:05 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] Allowing Xilinx's AXI Quad widths different than 8 bits on userspace
Date:   Thu, 24 Oct 2019 13:07:54 +0200
Message-Id: <20191024110757.25820-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

We had a couple of days ago a nice discussion [1] about a patch that I sent
that was in need of clarification. I've taken into consideration all the
conversation and I believe this small series will manage my ultimate goal
(being able to use from user space a 32 bits wordwidth SPI slave with
Xilinx's AXI IP core) while being explained enough and through the proper
procedure.

I assume there may still need to be some discussion to go on with this, but
I thought it'd be clearer if we all had the code upfront in its current
state.

First patch documents the new device tree property, while the second one
implements it.

The third patch, that could be applied on its own regardless of the first
two, solves a bug that appears only in combination of spidev usage and a
master SPI device that does not support 8 bits as datawidth.

[1] I have not been able to find a link to the archives of linux-spi, sorry

Thanks,

Alvaro Gamez Machado (3):
  spi: xilinx: add description of new property xlnx,num-transfer-bits
  spi: xilinx: Add DT support for selecting transfer word width
  spi: set bits_per_word based on controller's bits_per_word_mask

 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 4 +++-
 drivers/spi/spi-xilinx.c                             | 7 ++++++-
 drivers/spi/spi.c                                    | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.23.0

