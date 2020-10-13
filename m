Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85EC28D1D9
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgJMQJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 12:09:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731478AbgJMQJO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 12:09:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CAE464F4C12807697711;
        Wed, 14 Oct 2020 00:09:06 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 00:08:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/6] fix all errors except one reported by dt_binding_check
Date:   Wed, 14 Oct 2020 00:08:39 +0800
Message-ID: <20201013160845.1772-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When people add multiple or common YAML files, they usually perform a full
dt_binding_check. Unfortunately, some YAML files cannot pass the self-check.
The errors or warning are listed below. It is necessary to eliminate them,
so that people's time and energy are not wasted every time when execute
comprehensive dt_binding_check.

This error is fixed by Patch 1:
/root/leizhen/linux-next/Documentation/devicetree/bindings/leds/leds-lp55xx.example.dt.yaml: led-controller@33: multi-led@2:color:0:0: 9 is greater than the maximum of 8
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml

These errors are fixed by Patch 2:
/root/leizhen/linux-next/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.example.dt.yaml: ec@0: 'typec' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/root/leizhen/linux-next/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dt.yaml: cros-ec@0: 'extcon0', 'extcon1' do not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/root/leizhen/linux-next/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dt.yaml: cros-ec@0: 'ec-pwm' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/root/leizhen/linux-next/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.example.dt.yaml: ec@0: '#address-cells', '#size-cells', 'regulator@0' do not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/root/leizhen/linux-next/Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dt.yaml: cros-ec@0: '#address-cells', '#size-cells', 'ec-codec@10500000' do not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

These errors are fixed by Patch 3 and 4:
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.example.dts:21.13-30.11: Warning (spi_bus_bridge): /example-0/spi: incorrect #address-cells for SPI bus
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.example.dts:21.13-30.11: Warning (spi_bus_bridge): /example-0/spi: incorrect #size-cells for SPI bus
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'

Patch 5 and 6 fix the dtbs_check errors detected by Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
/root/leizhen/linux-next/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: slave: 'cmd-gpios' is a required property
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
/root/leizhen/linux-next/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: slave: 'cmd-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml

I have no good idea for this one, so leave it.
Documentation/devicetree/bindings/pci/xilinx-versal-cpm.example.dts:43.62-47.30: Warning (pci_device_reg): /example-0/versal/pcie@fca10000/interrupt-controller: missing PCI reg property


Zhen Lei (6):
  dt-bindings: leds: choose correct color value of multi-led
  dt-bindings: mfd: google,cros-ec: explicitly allow additional
    properties
  spi: dt-bindings: spi-controller: explicitly require
    #address-cells=<0> for slave mode
  dt-bindings: misc: explicitly add #address-cells for slave mode
  ARM: dts: mmp2-olpc-xo-1-75: explicitly add #address-cells=<0> for
    slave mode
  dt-bindings: misc: correct the property name cmd-gpios to cmd-gpio

 .../devicetree/bindings/leds/leds-lp55xx.yaml        |  2 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml      |  2 +-
 .../devicetree/bindings/misc/olpc,xo1.75-ec.yaml     |  8 +++++---
 .../devicetree/bindings/spi/spi-controller.yaml      | 20 ++++++++++++++------
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts              |  2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

-- 
1.8.3


