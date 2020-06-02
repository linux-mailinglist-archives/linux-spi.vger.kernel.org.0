Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7431EB731
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBISe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 04:18:34 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4398 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBISd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 04:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591085914; x=1622621914;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=3qntvJu5hZf6NiiWOF/rC2X4oeQHa+Lu7499eTjv9dQ=;
  b=O8RnlUql8MHu4ivlcaz3fSTq/OC+JBAwmp89yUeCM1cLXYvzaWwCqwtG
   b6iBEavwOFDOKc85BQ2cL/CAaDQmxheKBJbK3RO3cHIi4YDvfUr+1pqDu
   e7lQuFcUnpXMZHa3/EVawlyaQr6bJoMQiHJ86jrJb1GiGsSPGiB9AZZCo
   4XKTHw4ZIK6b9OPdYoxhWSVawZvOQNZaDKI53uA/1UQt6OpPuXmzHPmzb
   PTRgx7/2CslEGlEmJc4iF1BTCHySAns6HD1pp60Ok7u85ZSArzVgWJkkh
   fNN567VvoIykUr2k67kGZcUWpLn8bYlMD1UnppKKNhiZEnCYgckLCKDVh
   Q==;
IronPort-SDR: s5o+IBS6/JNEQ7wKvOXOhREeKVcIIXGYbDHcjkfYBX+4Md5mh2V0jTi/yJ4zR4C2bigz2aXE7v
 bQ/zdJb9USgfM3zycHBzgTSHso5olRyqpbKltfn1KjWvu0ioDCQYa4Lha3ZrX/8zJf8Yof60Jg
 v2TJrOvldDzsRi1wLnDaELNo/BL8Qu+Rps1l8Z7SkV1R/rlQj+sgCIysZn7EPkcS1XZGEKusKC
 RX7TMKlCMA19r11DALUQaakzlb5IbjVNp4DJGLmeaVuTO//xrQJNxiICDqOnH6g12EmMaWycAj
 jyE=
X-IronPort-AV: E=Sophos;i="5.73,463,1583218800"; 
   d="scan'208";a="77876474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2020 01:18:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 01:18:32 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 01:18:30 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200529162130.hsjcde27xhohl6jl@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/10] spi: Adding support for Microchip Sparx5 SoC
In-Reply-To: <20200529162130.hsjcde27xhohl6jl@mobilestation>
Date:   Tue, 2 Jun 2020 10:18:28 +0200
Message-ID: <87img9q3sb.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> Hello Lars,
>
> On Wed, May 13, 2020 at 04:00:21PM +0200, Lars Povlsen wrote:
>> This is an add-on series to the main SoC Sparx5 series
>> (Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).
>>
>> The series add support for Sparx5 on top of the existing
>> ocelot/jaguar2 spi driver.
>>
>> It spins off the existing support for the MSCC platforms into a
>> separate driver, as adding new platforms from the MSCC/Microchip
>> product lines will further complicate (clutter) the original driver.
>>
>> New YAML dt-bindings are provided for the resulting driver.
>>
>> It is expected that the DT patches are to be taken directly by the arm-soc
>> maintainers.
>
> Regarding our cooperation. It can be implemented as follows. Since your patchset
> is less cumbersome than mine and is more ready to be integrated into the generic DW
> APB SSI code, it would be better to first make it through Mark', Andy' and my reviews
> to be further merged into the kernel version of the driver. After that I'll have
> my code altered so it could be applied on top of your patches. When everything
> is done we'll have a more comprehensive DW APB SSI driver with poll-based
> PIO operations support, new features like rx-delay, etc.
>

Hi Serge!

I think I would be able to work on the SPI patches this week. Should I
base it on the current spi-next or 5.7? Then address the comments and
send out a new revision?

Thanks for reaching out.

---Lars

> Thank you one more time for the series you've shared with us. Let's see what can
> be done to improve it...
>
> -Sergey
>
>>
>> Lars Povlsen (10):
>>   spi: dw: Add support for polled operation via no IRQ specified in DT
>>   spi: dw: Add support for RX sample delay register
>>   spi: dw: Add support for client driver memory operations
>>   dt-bindings: spi: Add bindings for spi-dw-mchp
>>   spi: spi-dw-mmio: Spin off MSCC platforms into spi-dw-mchp
>>   dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
>>   spi: spi-dw-mchp: Add Sparx5 support
>>   arm64: dts: sparx5: Add SPI controller
>>   arm64: dts: sparx5: Add spi-nor support
>>   arm64: dts: sparx5: Add spi-nand devices
>>
>>  .../bindings/spi/mscc,ocelot-spi.yaml         |  89 ++++
>>  .../bindings/spi/snps,dw-apb-ssi.txt          |   7 +-
>>  MAINTAINERS                                   |   2 +
>>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |  37 ++
>>  .../boot/dts/microchip/sparx5_pcb125.dts      |  16 +
>>  .../boot/dts/microchip/sparx5_pcb134.dts      |  22 +
>>  .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 +
>>  .../boot/dts/microchip/sparx5_pcb135.dts      |  23 +
>>  .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 +
>>  arch/mips/configs/generic/board-ocelot.config |   2 +-
>>  drivers/spi/Kconfig                           |   7 +
>>  drivers/spi/Makefile                          |   1 +
>>  drivers/spi/spi-dw-mchp.c                     | 399 ++++++++++++++++++
>>  drivers/spi/spi-dw-mmio.c                     |  93 ----
>>  drivers/spi/spi-dw.c                          |  31 +-
>>  drivers/spi/spi-dw.h                          |   4 +
>>  16 files changed, 644 insertions(+), 107 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>>  create mode 100644 drivers/spi/spi-dw-mchp.c
>>
>> --
>> 2.26.2
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Lars Povlsen,
Microchip
