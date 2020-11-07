Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305B02AA36C
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgKGIOs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIOs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736887; x=1636272887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzB7t56mVd9ZzoA3Nl5yo11GGSsnbn0Toc+QuUpGUBE=;
  b=UfQByc8Zupo+8vcmRRqHJqTakf3V/wKT7AWMy0HXW+IjE6WVW/XITGdB
   +oPWA1tB19jtV6DTAf1C2b67wbbjh4E+vLV87bxKaBuA+8cWujXaSEBSW
   4vWWTOdyvutepavCD5+3bS3yo13+lbi9jI5iigbbOThGdpH5b57MW4Xkc
   6UNRtkoVz4/Xwvqe6RzErIiolkno3gzfY2lwWTrn6bBz0Zf3QAKqs9Kn1
   3+YT01orQLXuTF6Zg4M3tSN0vzxHNnwFumaPCA4+RHZKphCHwlE4BYodc
   zg7HvQefRLBZFIaPMgafKo3/tp4XdOmFiAsfFNtowYQ+OifX5mOO3kahT
   w==;
IronPort-SDR: ZSD+opTt/gbxzFX9IZ84mAJCitX6u2VwvuVJVSiWWz3tcrXv4fMO9WWZNgQecMqk7DlHdZPhiu
 jp+vLH4ed8Cf9FLQjq3WZvWNLIrNWN/eYX0FcM8okojngnXMdxb2PxGE9w7xymAuhGagYUQLaM
 eqopja16OlGP0ILUrRSvUn2ZkLJscZZpXHu0zVgn6dcUnMm054ZtZI1kJTBBf/IPry48/d2CFv
 kh0eWA6AShVVrqNdidrRwS7Uxfcq1x59hkl2jkvlbY2N0ixJ96P+XAs966p1dhu7pDTsBaeUSu
 FeE=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564376"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:47 +0800
IronPort-SDR: JrSgH3YALJZ3onO3oco2ABbQTOh1jAf5pZkuhmq8OUXKmFuVlztkeN33YCsBV7wzmKc9gFwNrp
 syq3UWb7pYp9L1i64A6d6mixKJXXN32AOCO37p2n98SSyNV/6WEumKrmzS4MRsS4ZFc4pMuOeS
 lrb7h+Ino8LZ0AsF+eDkZm5VLCBHFmoJ0tp3GoB0aVJ0hm0ZlKyz3bFw6dyfME2RnAiLem/5wH
 Do2E38B5APZOhKCAwy6nT8PtomQq48/BTRxyXDttm6vD8uUA12VH/1SCkNWLw+/Wnzlhcv0mws
 7pF2VFwDUf8LxSmRlrSUM4gT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:38 -0800
IronPort-SDR: B0Mfujx6UxJh3cJWVh4zNTPfCD5sD9aEoBo4eyW2xNfgr34VaQ5gkGoFqmf+P7pvJpzQzfYCkt
 UuKEt7LhYCIlvZTWCxOgx0ATflrP+6cTrv/tlkSOAtdqHaP7ofdeAFq4fWIyY9lPVOdT4LEcHE
 ZD7Lyu1Vj0LqoYB5mXvedUwpL+ZgnAIa7ecZwl0rikOIwXwhQjeUnJ5IiLAarLSHNERvOuKdwI
 90nGHP04/rx0PDIZHjR1Zv+LrvNLgMqgoox+UBMnA50cZf2AumzqZuYGOpETAyMAlRNLeRiSV1
 +14=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:46 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 09/32] riscv: Fix SiFive gpio probe
Date:   Sat,  7 Nov 2020 17:13:57 +0900
Message-Id: <20201107081420.60325-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the check on the number of IRQs to allow up to the maximum (32)
instead of only the maximum minus one.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/gpio/gpio-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index c54dd08f2cbf..d5eb9ca11901 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -183,7 +183,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->regs);
 
 	ngpio = of_irq_count(node);
-	if (ngpio >= SIFIVE_GPIO_MAX) {
+	if (ngpio > SIFIVE_GPIO_MAX) {
 		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
 			SIFIVE_GPIO_MAX);
 		return -ENXIO;
-- 
2.28.0

