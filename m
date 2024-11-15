Return-Path: <linux-spi+bounces-5704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4679CF5A4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 21:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0281F22664
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700311D9346;
	Fri, 15 Nov 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kkp4vBs2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8E1E2609
	for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701932; cv=none; b=Dl0UDSPHxPuFbtoNia2NzsI3dd6B78bJ3QDkR8WTELS1rFjeC+P3IXZiV7Rtvu01CQWLh4yk0phD5Rr4C/+lFg0T7ClUJIZnxA1ozdpVJ7o+Ddro8Dsg6bEib1G8YiPf9mRv5jJO2CzhFdGxKl5M9P/9uUkz+/WOUyOtSPg5LLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701932; c=relaxed/simple;
	bh=3Ni7PT0axBtuHvRncCE5DWh0E9rbAEHiA+isJunCRHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XOrmpDDNSF2PLkhO57NPvYukqZoFarEbylNIuQAG0JmNvuqOe4YebXGi+Rdg1SNNFrl1fJtTairc5EsO0pHa2P5/9cQ0DLxA9dDM79jeRcWaeKDssJBwG3HMLtIngkI7aYPIRrsEs+lPwVmsSCFXo7x6Og01CL6ec2xItx1EuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kkp4vBs2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ec1ee25504so504758eaf.3
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701928; x=1732306728; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUdI24Fc01rV8+2ozp3YiQjyTDz4RClZ9j2UmHM3EPY=;
        b=kkp4vBs2vghluPAJtKK90SGw0tK3BJidZR1P0l7kIsOooIY8D1CWH01cThzXlOMJpC
         bnsKPsf1TuEbxNPSUVEh5MK0PL566LCXvrgTghpPflbbIvMY9aBf/HaT2It5P8vqvdgU
         ABCw9X/PL8xdJtJl1+DuL8WIEyyeHjN9Z+6Url6RwopEk4Jtou48CbsXLxs7Hj7/gKPq
         swk60UFY7k/YZqPwJdxkfCGr+thp0LLpr5lAHtFnBv/+/oZo1EYAs+BIb9cSqOU67yHS
         aCQjSs71cNMD5VVqSX1+KqoerfzU5P5UHJhDcFiuTSjaoVc0LRuEuHBuPmsGJzZPr05Q
         Db0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701928; x=1732306728;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUdI24Fc01rV8+2ozp3YiQjyTDz4RClZ9j2UmHM3EPY=;
        b=HH6xP91bMInJPm5RUEyPwxXNoIIOFFFaB3FfZi63iDwaBw/ynRgw/ELIkTPcMLhxBM
         mTJIPubzv6qo3vbxQSGGf95+JSbQW1IAJsPFtKpeCZ0K00LcLY1E7QYdy5hOb3uD5J5Z
         Rn1HSho6Gtu60Eu5ZbaDFpwoEuB6elGJ1kx0TkL3odCer6v3OnNk1ZXINDZzsssCRzSv
         HufOHQGNkuXNfjoH2xk1n5F+Lxoa0TiJmgSnrSDBvWr/qlbv7aNPoVYrxj95Gim62HmF
         oZXGSexRKHvgGHhXKTp3IQ3cvaSWT40h93g0WRjhU4iaqaBzYbUJxfiwGIDd17G3x1/v
         tfTA==
X-Forwarded-Encrypted: i=1; AJvYcCWN5ARmGgjLehk5j7nlYOh1FMsvZiCZ1sNl+CU83DeBwQBLZP0/LBwhTzqILldVN8Wou5RUUYPho20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68dizwV9ea+czULxDxZX9rzPOMD0xI2YMGI5vIY6YFl4ZPIu5
	Ji945XqFGEDU5C5t0fQr05V2/TabbMcP6ktU3ttmMwcjVzYJxLJXTzuQK8jwQJw=
X-Google-Smtp-Source: AGHT+IFUja7/dvg8AIw0VHQ8Lb/HKthQzctuYLuTqPCTOrmcEocRyzaIPnu3nWrxg113jaeXYkpXdw==
X-Received: by 2002:a05:6820:260e:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5eeab0fbd99mr3752213eaf.0.1731701928109;
        Fri, 15 Nov 2024 12:18:48 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:18:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5 00/16] spi: axi-spi-engine: add offload support
Date: Fri, 15 Nov 2024 14:18:39 -0600
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCsN2cC/5XRS07DMBAG4KtEXjPIz6TJinsghOx4nIzUOMUOU
 auqd8dtoUWIBSxsebz4Zvz7yDImwsy66sgSrpRpjqUwDxXrRxsHBPKlZpJLzY3g4LfYjzBZilu
 KCHlHgHE4H+cQtrP1IMGGHlXTcmesY0XaJQy0v3R5fin1SHmZ0+HSdJXn2//5qwQOm4Y3tmy9V
 ubJ2cOWXMLHfp7YucWq7mwj5d9YVdhGS47a+FC37hdW31jBpfobqwsbNkIa17bBWPGDPV0TSvj
 2XuJfrjHd0++qSzchFBDNYH1flq5bA9O8IvgFHEVPccgwovWYwNetlBgaL5TuVsG+/+VNE7AMd
 nJl7E/ulaZdKuKEccnQWCVtLetNL+uu/FExnM0IZeKJlq6KuF/giypvOH0AfUrSx0oCAAA=
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

There weren't any major revisions or this time around and there weren't
any more long discussions on higher level design, so I've dropped the
RFC label and started polishing things up a bit more. So hopefully we
are getting close to a final version.

---
Changes in v5:
- Dropped pwm patch. A variant of this patch has been picked up in the
  pwm tree.
- Addressed review comments (see details in individual patches).
- Added some polish, like MAINTAINERS entries and updating ADC docs.
- Link to v4: https://lore.kernel.org/r/20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com

Changes in v4:
- Dropped #spi-offload-cells and spi-offload properties from DT bindings.
- Made an attempt at a more generic trigger interface instead of using
  clk framework. This also includes a new driver for a generic PWM
  trigger.
- Addressed IIO review comments.
- Added new patches for iio/adc/ad4695 as 2nd user of SPI offload.
- Link to v3: https://lore.kernel.org/r/20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com

Changes in v3:
- Reworked DT bindings to have things physically connected to the SPI
  controller be properties of the SPI controller and use more
  conventional provider/consumer properties.
- Added more SPI APIs for peripheral drivers to use to get auxillary
  offload resources, like triggers.
- Link to v2: https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com

Individual patches have more details on these changes and earlier revisions too.
---

As a recap, here is the background and end goal of this series:

The AXI SPI Engine is a SPI controller that has the ability to record a
series of SPI transactions and then play them back using a hardware
trigger. This allows operations to be performed, repeating many times,
without any CPU intervention. This is needed for achieving high data
rates (millions of samples per second) from ADCs and DACs that are
connected via a SPI bus.

The offload hardware interface consists of a trigger input and a data
output for the RX data. These are connected to other hardware external
to the SPI controller.

To record one or more transactions, commands and TX data are written
to memories in the controller (RX buffer is not used since RX data gets
streamed to an external sink). This sequence of transactions can then be
played back when the trigger input is asserted.

This series includes core SPI support along with the first SPI
controller (AXI SPI Engine) and SPI peripheral (AD7944 ADC) that use
them. This enables capturing analog data at 2 million samples per
second.

The hardware setup looks like this:

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  AD7944 ADC      |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus ============ SPI Bus          |
|  |                     |      |   |                  |
|  |  +---------------+  |      |   |                  |
|  |  | Offload 0     |  |      |   +------------------+
|  |  |   RX DATA OUT > > > >   |
|  |  |    TRIGGER IN < < <  v  |
|  |  +---------------+  | ^ v  |
|  +---------------------+ ^ v  |
|  | AXI PWM             | ^ v  |
|  |                 CH0 > ^ v  |
|  +---------------------+   v  |
|  | AXI DMA             |   v  |
|  |                 CH0 < < <  |
|  +---------------------+      |
|                               |
+-------------------------------+

---
David Lechner (16):
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      spi: dt-bindings: add trigger-source.yaml
      spi: dt-bindings: add PWM SPI offload trigger
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: add SPI offload properties
      spi: axi-spi-engine: implement offload support
      iio: buffer-dmaengine: document iio_dmaengine_buffer_setup_ext
      iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_ext2()
      iio: adc: ad7944: don't use storagebits for sizing
      iio: adc: ad7944: add support for SPI offload
      doc: iio: ad7944: describe offload support
      dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
      iio: adc: ad4695: Add support for SPI offload
      doc: iio: ad4695: add SPI offload support

 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  16 +-
 .../bindings/spi/adi,axi-spi-engine.yaml           |  24 ++
 .../devicetree/bindings/spi/trigger-pwm.yaml       |  39 ++
 .../devicetree/bindings/spi/trigger-source.yaml    |  28 ++
 Documentation/iio/ad4695.rst                       |  68 ++++
 Documentation/iio/ad7944.rst                       |  24 +-
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |   2 +
 drivers/iio/adc/ad4695.c                           | 438 +++++++++++++++++++-
 drivers/iio/adc/ad7944.c                           | 297 ++++++++++++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 104 ++++-
 drivers/spi/Kconfig                                |  16 +
 drivers/spi/Makefile                               |   4 +
 drivers/spi/spi-axi-spi-engine.c                   | 314 +++++++++++++-
 drivers/spi/spi-offload-trigger-pwm.c              | 162 ++++++++
 drivers/spi/spi-offload.c                          | 452 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  10 +
 include/dt-bindings/iio/adc/adi,ad4695.h           |   7 +
 include/linux/iio/buffer-dmaengine.h               |   5 +
 include/linux/spi/spi-offload.h                    | 164 ++++++++
 include/linux/spi/spi.h                            |  21 +
 21 files changed, 2132 insertions(+), 72 deletions(-)
---
base-commit: 172b9942b1a943f2971b1b655f3907f2f568e95b
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab
prerequisite-change-id: 20241113-iio-adc-ad4695-move-dt-bindings-header-d6922ef7d134:v1
prerequisite-patch-id: 9dd88581d962cc5454c3577dc5ef59413db467b5
prerequisite-patch-id: d71deacf6bb4e90e8059a12a94ade36866729fa0
prerequisite-change-id: 20241111-tgamblin-ad4695_improvements-7a32a6268c26:v2
prerequisite-patch-id: 9752467c406cec438286e5c3efa7c0cddf8a9b3a
prerequisite-patch-id: 7e6d36bfc262e562cb74d524e96db64694064326
prerequisite-patch-id: d864ef9f8a7303822d50d580a9ebbd8d304c8aa6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


