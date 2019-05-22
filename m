Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BA26D4C
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 21:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfEVT3N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 15:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732760AbfEVT3J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 May 2019 15:29:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136FF21841;
        Wed, 22 May 2019 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553348;
        bh=wq8EJPOPKziaYiEPgTwLEWSXWJS5+zpOe0LkYK2Rmgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etk/5uwd3wMuAEprfEZAy6O134djDy45Hent3tJ52/Bs8Gy9/nI/rD0Flq07h1qAu
         9K2lE7s00x0JqtkubY7F8DwuBzf5m0j+vyHLBlnTf8Ej8AZyvaaHJKmOnViscZqx1E
         WsoI0gxQEq6wLv/NWKvMXmlsTZYpw6FOfEIN6RmI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 017/167] spi: pxa2xx: fix SCR (divisor) calculation
Date:   Wed, 22 May 2019 15:26:12 -0400
Message-Id: <20190522192842.25858-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Flavio Suligoi <f.suligoi@asem.it>

[ Upstream commit 29f2133717c527f492933b0622a4aafe0b3cbe9e ]

Calculate the divisor for the SCR (Serial Clock Rate), avoiding
that the SSP transmission rate can be greater than the device rate.

When the division between the SSP clock and the device rate generates
a reminder, we have to increment by one the divisor.
In this way the resulting SSP clock will never be greater than the
device SPI max frequency.

For example, with:

 - ssp_clk  = 50 MHz
 - dev freq = 15 MHz

without this patch the SSP clock will be greater than 15 MHz:

 - 25 MHz for PXA25x_SSP and CE4100_SSP
 - 16,56 MHz for the others

Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
so the max rate of the SPI device clock is respected.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c0e915d8da5d2..efdae686a7619 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -938,10 +938,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 
 	rate = min_t(int, ssp_clk, rate);
 
+	/*
+	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
+	 * that the SSP transmission rate can be greater than the device rate
+	 */
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
-		return (ssp_clk / (2 * rate) - 1) & 0xff;
+		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
 	else
-		return (ssp_clk / rate - 1) & 0xfff;
+		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-- 
2.20.1

