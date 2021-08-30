Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF453FBF2F
	for <lists+linux-spi@lfdr.de>; Tue, 31 Aug 2021 01:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhH3XDU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 19:03:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39659 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhH3XDU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 19:03:20 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E07A0200002;
        Mon, 30 Aug 2021 23:02:21 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>
Cc:     Pavel Nadein <pasha-net@narod.ru>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [5.16][PATCH 0/3] Support for Ingenic JZ47xx SPI controller
Date:   Tue, 31 Aug 2021 01:01:36 +0200
Message-Id: <20210830230139.21476-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This patchset introduces support for SPI controllers found in the
Ingenic JZ47xx family of SoCs. Of particular note, this allows to
replace GPIO backed SPI on the MIPS Creator CI20 board. 

Mark:
Checkpatch generates a `need consistent spacing around '*'` error on
this patchset, however I believe this is a false positive due to it
confusing a pointer with multiplication operator inside a macro.

Rob:
I refrained from adding SPI pin groups into the bindings, as I felt that
would be enforcing a policy (SPI signals can be multiplexed on multiple
pin groups on the board, per use case). Instead, I included an example
pin configuration into the relevant commit description.

Other controllers already present in ci20.dts do specify their pin
groups, but I think this is bad practice. Do you have particular
guidelines on this?

Pavel:
Feel free to add your Tested-by, if you still have your CI20 setup
around :) I tested this driver with two SPI mode MMC/SD card readers and
also with the spi-loopback test driver. 

Cheers,
Artur

Artur Rojek (2):
  SPI: add Ingenic JZ47xx driver.
  MIPS: JZ4780: CI20: DTS: add SPI controller config

Paul Cercueil (1):
  dt-bindings: spi: Document Ingenic SPI controller bindings

 .../devicetree/bindings/spi/ingenic,spi.yaml  |  72 +++
 arch/mips/boot/dts/ingenic/ci20.dts           |   9 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi        |  44 +-
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ingenic.c                     | 482 ++++++++++++++++++
 6 files changed, 602 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ingenic,spi.yaml
 create mode 100644 drivers/spi/spi-ingenic.c

-- 
2.33.0

