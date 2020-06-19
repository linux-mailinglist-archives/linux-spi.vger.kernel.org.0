Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7A2007D1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbgFSLbt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:31:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58666 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgFSLbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566303; x=1624102303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UfVOSLTcqF6xKAGoXoeHxnEVgPiigXyHa28boyXOH6Q=;
  b=G4Ze1grzQ9Fpz8HZMFNR73zB+KgdMi6tC6aOheNjlTu4JGBdFDLzosjk
   xGYp9trZIrt7xWkrGu3H2F8wkvsWiU1tfBU3fWK6WlWnGRG0IAl+Y43eo
   wwY4aXMgAkd1UQma1f/vQ88vAbSRd8gJl43m/fNG8lz+THLjWqe8B7E5U
   efjZVScb6kTQjEuoy57R4V340zIGA2sXVlDtpPqlZlTXbpzqf2AptMDUr
   OVPijVc9hcL4g17TWLb75GKNgbAYYsKgFw+Kt+zjdwYZbCjIhz5ehsAbR
   MwwdbF7QgINdbJQprs6fmfkWWrEb06EPZZs+b5phLv5UAsZxFpcbeogrX
   w==;
IronPort-SDR: OC/IJX71ViysRevrfGLlaWcMy5Nz1nSqUhqRmG9vQjTkpyGFoX5wfRZGRLk0ZSps4TDWUYMd5g
 w0312+f0izYSgJgl4K3gm9PrWhV90FhwXMPC0QHKlJNgFQmg2WwsQ27tc9twYFRJLGa8XvsAN3
 GMAHXJcOlF9G6b5guyyz15UgAz15ZJucXxDD1SoZIqsRStNwZR1+A9ZSeGRbIjQknL4khuw90X
 rlRvojNCLunFOFFbh1+uIGODUaW3SNv5xd63EBOkksGBpBOxjlWvIaGbeJYE75eZxaOzHeGg7c
 j0c=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="84298522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:26 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:24 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 0/6] spi: Adding support for Microchip Sparx5 SoC
Date:   Fri, 19 Jun 2020 13:31:15 +0200
Message-ID: <20200619113121.9984-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200615133242.24911-1-lars.povlsen@microchip.com>

The series add support for the Sparx5 SoC SPI controller in the
spi-dw-mmio.c spi driver.

v2 changes:
- Moved all RX sample delay into spi-dw-core.c, using
  the "snps,rx-sample-delay-ns" device property.
- Integrated Sparx5 support directly in spi-dw-mmio.c
- Changed SPI2 configuration to per-slave "microchip,spi-interface2"
  property.
- Added bindings to existing snps,dw-apb-ssi.yaml file
- Dropped patches for polled mode and SPI memory operations.

Lars Povlsen (6):
  spi: dw: Add support for RX sample delay register
  arm64: dts: sparx5: Add SPI controller
  spi: dw: Add Microchip Sparx5 support
  dt-bindings: snps,dw-apb-ssi: Add sparx5, SPI slave
    snps,rx-sample-delay-ns and microchip,spi-interface2 properties.
  arm64: dts: sparx5: Add spi-nor support
  arm64: dts: sparx5: Add spi-nand devices

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  24 ++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  34 ++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  16 +++
 .../boot/dts/microchip/sparx5_pcb134.dts      |  22 ++++
 .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 ++
 .../boot/dts/microchip/sparx5_pcb135.dts      |  23 ++++
 .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 ++
 drivers/spi/spi-dw-core.c                     |  20 ++++
 drivers/spi/spi-dw-mmio.c                     | 113 +++++++++++++++++-
 drivers/spi/spi-dw.h                          |   2 +
 10 files changed, 271 insertions(+), 1 deletion(-)

--
2.27.0
