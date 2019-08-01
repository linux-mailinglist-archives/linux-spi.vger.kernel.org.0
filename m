Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B357DCEC
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfHAN4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 09:56:51 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36993 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfHAN4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 09:56:50 -0400
Received: by mail-wm1-f50.google.com with SMTP id f17so63272678wme.2
        for <linux-spi@vger.kernel.org>; Thu, 01 Aug 2019 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIm81eDhukyw6fbCl/+3h+QPFrHXYcRhnM9vCZm0FBU=;
        b=13O0vL5DX2cs4dd++hzfRHv1CPifo+nEBZIfEK/xPAm8LBOTVk9bmKI2ZMbRTH1Qny
         gGc5Etb+oieTHOJzEcqzxWDGO6QQqX8ZqANnbyLDBv2TvisCVoaDgG+Sk1kHTmon4u7p
         23GDtno64u2hTvVK4IASbns2pDTl99MQ9lBi+m6sVEXUkUpyjOdGM2BNfLvVc5T/fqbP
         9RYMi1RBDw8zjzxwomGDcNw8yXfmP3fnwqKgmxCfWTSa6c7Ru6292ZJe91J3mLvVO1do
         1LdLqXyr4MpjfSurQz0trb5nuP2J9ZMxqd5XwmuOpZpWwQRuERRQeyL/kh7Wen7RuCof
         AwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIm81eDhukyw6fbCl/+3h+QPFrHXYcRhnM9vCZm0FBU=;
        b=niSbbzCwv+vUIWhi1i4ZqJuLvOVD4+LmV8M+f1KwIxcbuzCeXQUGpdZ0gOrmB9mYXK
         VVw6YZTYBQC5P886/YrTp7lfBDnmmnGOVdjE/gLuWiceIMxzqFYoNiTueJFmHowPM7fU
         W/ADTLXXhF1QEXTS3QpXTJbiazE6yXWMDQPUDX0hO+VgG1W1DG+UW9v3chFN2I2QWvRu
         82DQQdbV5WXG6JhDViTNmQdRO+0QJschkxbEgQaa1F0J/2wX/K9H0NhH43j4OK+K/GDa
         C3pDdb/2lZG3Qzfp2mPVIMbNSmdsqe40MWIlZ9x3cYvGQCQKujAFG10B9m1GBWWnMpf0
         FoYQ==
X-Gm-Message-State: APjAAAVdu//Ts1Qk3posBswOAs6ad33Rw4O+YEYIKXP25sdmOPVU1ab+
        YS3upBxV/Fz3jm+OQnjsqAC8Iw==
X-Google-Smtp-Source: APXvYqz463HiGivdjA4sUX+UrCKICPNW2Wd+t3590qMCqsuXMkM9GjxeAukrBa4PObzWj+jGQXbYjg==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr111159574wmh.132.1564667808166;
        Thu, 01 Aug 2019 06:56:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6sm69659952wml.9.2019.08.01.06.56.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 06:56:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        jassisinghbrar@gmail.com, kishon@ti.com, p.zabel@pengutronix.de
Subject: [RFC 0/9] dt-bindings: first tentative of conversion to yaml format
Date:   Thu,  1 Aug 2019 15:56:35 +0200
Message-Id: <20190801135644.12843-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a first tentative to convert some of the simplest Amlogic
dt-bindings to the yaml format.

All have been tested using :
$ make ARCH=arm64 dtbs_check

Issues with the amlogic arm64 DTs has already been identified thanks
to the validation scripts. The DT fixes will be pushed once these yaml
bindings are acked.

Neil Armstrong (9):
  dt-bindings: mailbox: meson-mhu: convert to yaml
  dt-bindings: rng: amlogic,meson-rng: convert to yaml
  dt-bindings: spi: meson: convert to yaml
  dt-bindings: reset: amlogic,meson-reset: convert to yaml
  dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
  dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
  dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
  dt-bindings: serial: meson-uart: convert to yaml
  dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml

 .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 -------
 .../amlogic/amlogic,meson-gx-ao-secure.yaml   | 42 +++++++++++
 .../devicetree/bindings/mailbox/meson-mhu.txt | 34 ---------
 .../bindings/mailbox/meson-mhu.yaml           | 53 +++++++++++++
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 ------
 .../bindings/phy/meson-g12a-usb2-phy.yaml     | 67 +++++++++++++++++
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 ------
 .../phy/meson-g12a-usb3-pcie-phy.yaml         | 61 +++++++++++++++
 .../bindings/reset/amlogic,meson-reset.txt    | 19 -----
 .../bindings/reset/amlogic,meson-reset.yaml   | 40 ++++++++++
 .../bindings/rng/amlogic,meson-rng.txt        | 21 ------
 .../bindings/rng/amlogic,meson-rng.yaml       | 37 +++++++++
 .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
 .../bindings/serial/amlogic,meson-uart.yaml   | 75 +++++++++++++++++++
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 74 ++++++++++++++++++
 .../bindings/spi/amlogic,meson6-spifc.yaml    | 57 ++++++++++++++
 .../devicetree/bindings/spi/spi-meson.txt     | 55 --------------
 .../bindings/watchdog/meson-gxbb-wdt.txt      | 16 ----
 .../bindings/watchdog/meson-gxbb-wdt.yaml     | 37 +++++++++
 19 files changed, 543 insertions(+), 255 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.yaml

-- 
2.22.0

