Return-Path: <linux-spi+bounces-3626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9F91ACB6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6467A1F25112
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A061CF8B;
	Thu, 27 Jun 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="VBNJIO+g"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA971991A9
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505730; cv=none; b=DTwJtahZjlR9ty/DiNEAdVSNz8amwOt6mo2bGWB6oOtIZzKJ1TdP/5kabJm8Zf5RMefBO4kYnQmcMhAW2m/paCmmb1WJkrMm1vLEhq6n85ktsWaOsxAjf0WTtPTQPOdX41pTAfmg5X3eUKsg7mmxxeyCgFt40E1tCJb3PbYDO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505730; c=relaxed/simple;
	bh=6L0Sq0uGdlO6s0H2kQb8Zs+pOHHRT5L1lBZlRrwLdjw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i0Wua2KEN6vyDCyAfvGcY8rA55L0+2CyiuG8/nub1bNFifhhVIFaxp9P5FCiqwwH1CCNUcaa5Z14fyobHWJBYXOxEjp7AS8eVqQo2D5cZYkL0mYJOJT5TKXpqOJ4GGTjW1nbTfjl4/9+4PxM28A7Yj/wF9gCr2FviGW0c5C5kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=VBNJIO+g; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f3d395dcf9so5452939f.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505727; x=1720110527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUpdxD/vt8vb3o0iHNh6vpn1Bo9wZjlrsPnUUEvSog8=;
        b=VBNJIO+g9xc3AMfhuPvyZoMXy50C4c//b4fNAgjVSbyyqjZ9zz/QKALda+K/MT5/tH
         7fhkNpGeGfK7y1aNTgC9ATDGBuAg+sHiOP55DCZ1E7MTVbdIeVhFzJFB8VHLEZHbCGjx
         rhHEDu0synqDmXS+WkPJlA47Q1gaSUj3k8X6ZWS2m3L/4tbMvOWhfXGqTJQjl/gHjtTN
         ZHjigxJ38IV4nZXdeIw+vFCY7Xjl3Vzw4KFuu8l7ksOS1yOk6Wc3q7FXPEt5V2mKsjeS
         tGuJdAGBdP2D7JeJVvQSLvbr4wiy4RkpiTQg94BpSDBt7abh0kkJUBJXT0dJI1FN+MUG
         OLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505727; x=1720110527;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUpdxD/vt8vb3o0iHNh6vpn1Bo9wZjlrsPnUUEvSog8=;
        b=M0FM00UmN5f0njG3TTXqH3SpFwbHS/CWSFrA36P/pxQtvetRQoLhATTsAVtu/HOFIB
         MudA3zPhm9iwwOieOE4RcWW0lJXyrkAyUKbmZ00OVvESEfY5uvXq/yPA7zTS4lys62jl
         IF7RWVvV4PUuacZNq+wYDcfe8OPrK/WIusDJ7OwQWUpZVtJkMo5b+xdKZhxhPC+JiVoH
         eCd91Xw5xdDC5uKBBXEBsrbh445n77hfpcJUJr6cNwjeWMUP/qO0syTJd9mc2rg7sDDV
         O/kQsiAaLuvE4YDNhEVlSZcpknk3fyTAZl8u3gCDJa4Uwq4xU9oMWBqhciyDrSmjJVhx
         pMlw==
X-Gm-Message-State: AOJu0YwjQIV/MJMHUGTOfgMHW0jxocMkynBp/7iWxmR26OpKkfpzXgSf
	5lx/bkRhEanjc7kgybAdX2sFc3DX2G9NbfX8QMlWZREuwCS4lUpUoeqdoJDglQ==
X-Google-Smtp-Source: AGHT+IG/NP7Q9ndMN8U8905daJyfOiw/jL6qOK9LSfylvJLbvyGyykC23VR8Ye7SCw/wI8bu8sqT2w==
X-Received: by 2002:a05:6e02:b21:b0:378:cf86:357b with SMTP id e9e14a558f8ab-378cf8636b9mr52805245ab.3.1719505726976;
        Thu, 27 Jun 2024 09:28:46 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:28:46 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH v5 0/7] misc: Add mikroBUS driver
Date: Thu, 27 Jun 2024 21:56:10 +0530
Message-Id: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKSfWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3dzM7KL8pNJi3eLkosSS5Azd4oJM3cQUi2RLi5TkVCCpBNRaUJS
 allkBNjY6trYWAHPgoiJmAAAA
To: Mark Brown <broonie@kernel.org>, 
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>, Ayush Singh <ayushdevel1325@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3133; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=6L0Sq0uGdlO6s0H2kQb8Zs+pOHHRT5L1lBZlRrwLdjw=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZMosT+CUWXVSMJGjq9tKbgX5wbQOfkFSHJzJ
 M6Lpr4lSvKJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TKAAKCRAFzvXHieVa
 dDPSEADOhdIzmUBFnxSIcJR4m04KytgV7RKB4+4aOmzBOCQ7VbkwIT81Iz7boFGgeAa4jyTCiSc
 BkNR12LanbOTWCLkV1LBNUKuSz6HbOY1oGPFZl4HlM2e7mmUQofdR1/59gdzgUU53CKYzeIF2F8
 CcmRMxr9L9SxQsw/N8UQqfBdUovt4BqvYzSeV9J3GBgNHe8BIh0Cpi/ZK7ubJ38dy4Wte+W+HbV
 uthvOaVphSnAB5kPxQ0oeBYzLSt0eHod2xXB/Q7jEg+aTNdqztzUWkx2FK2OMDXSybaUC1evOjb
 xLaZoEBZJe2wAynuaKCLIR0PfLyJJCZxNbZC+0Oyc8cnD0K+3gJbt0QYS0OFwWCLN6GqicWarxR
 OdTbbehcht4bkdVdRpOJ5sI+B7ojEj9HWcrKkKyGPaRinXy83u6E5DlzEXooBXI4zwE7/8bn9WL
 WllGzUnfMWKs2ElMR183ajbsrftcKrRdFPJ/u80J+RhvLscW0FQrwIRycBybfajWIGPzHs6Qs7y
 ibm3pVSLRjeI4H6xMH1kXScjNPXaBEUTfip3vAnakuPgNnfwWZXswoGMlWNxeWQm6sIKEevE0vJ
 K7qmP0BOR0U/wcjPq6By7XGtmUXcYosrbrHYx925AwpbbQLhgqxJPRUw8cG2N3qrEtQ8F651cOO
 IoSKa6byTSTFmnQ==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

MikroBUS is an open standard  developed by MikroElektronika for connecting
add-on boards to microcontrollers or microprocessors. It essentially
allows you to easily expand the functionality of your main boards using
these add-on boards.

This patchset adds mikroBUS as a Linux bus type and provides a driver to
parse and register the mikroBUS board using device tree infrastructure.

The patchset is based on work originally done by Vaishnav.

Link: https://www.mikroe.com/mikrobus
Link: https://docs.beagleboard.org/latest/boards/beagleplay/
Link: https://lore.kernel.org/all/20240317193714.403132-1-ayushdevel1325@gmail.com/ Patch v4

Changes v5
- Complete rewrite to use device tree instead of mikroBUS manifest.
- Only support for SPI.
- Adds `mikrobus,spi` compatible property.

Changes v4:
- Better commit messages
- Remove clickID, serdev, pwm, regulator, clocks etc. Just the basic
  mikroBUS driver.
- Fix a lot of memory leaks, unused variables, etc.
- Create accompanying PR in Greybus Spec repository
- Switch to 80 columns formatting
- Some other fixes pointed out in v3

Changes in v3:
- Use phandle instead of busname for spi
- Use spi board info for registering new device
- Convert dt bindings to yaml
- Add support for clickID
- Code cleanup and style changes
- Additions required to spi, serdev, w1 and regulator subsystems

Changes in v2:
- support for adding mikroBUS ports from DT overlays,
- remove debug sysFS interface for adding mikrobus ports,
- consider extended pin usage/deviations from mikrobus standard
  specifications
- use greybus CPort protocol enum instead of new protocol enums
- Fix cases of wrong indentation, ignoring return values, freeing allocated
  resources in case of errors and other style suggestions in v1 review.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (7):
      dt-bindings: connector: Add mikrobus-connector
      dt-bindings: mikrobus: Add mikrobus board base
      dt-bindings: mikrobus: Add mikrobus-spi binding
      spi: Make of_find_spi_controller_by_node() available
      spi: Make of_register_spi_device() available
      mikrobus: Add mikroBUS driver
      dts: ti: k3-am625-beagleplay: Add mikroBUS

 .../bindings/connector/mikrobus-connector.yaml     | 107 ++++++
 .../bindings/mikrobus/mikrobus-board.yaml          |  20 ++
 .../devicetree/bindings/mikrobus/mikrobus-spi.yaml |  37 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |  94 +++++-
 drivers/misc/Kconfig                               |  16 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/mikrobus.c                            | 361 +++++++++++++++++++++
 drivers/spi/spi.c                                  | 209 ++++++------
 include/linux/spi/spi.h                            |   7 +
 10 files changed, 750 insertions(+), 111 deletions(-)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240627-mikrobus-scratch-spi-ad8c98dcec98

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


