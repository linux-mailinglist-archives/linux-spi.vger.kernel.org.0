Return-Path: <linux-spi+bounces-11204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086BC5D14C
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE54E28E1
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5D2EDD50;
	Fri, 14 Nov 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="VSvcuPab"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D6139579
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122747; cv=none; b=dt6fQBMIm9x+6BDsbFQPG/zTMl48nvAUNJTHeHWY1NilgzTgYPr3q74ulWD2ziMEEWS/Y2hN87tBQURehuCQ5Qwsy8Hc+g9PyZ/oh31h7LcS2wyapuiUqHDJ+L7I0UsUR/JbcEoanEl/V5FkBwHukhldRJWyJM82gGWhldGr9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122747; c=relaxed/simple;
	bh=SGlJYLihZT4+phmoB/86SGMUspoJUqlO/5liLNI0JaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Im0kwNxmTllI5FZqcc04wyjQZyqMr2ZPmDGZRRCEo3QiOQGWmgKyrl6A9mBtPpgJHETodMK+bUO+ASjIy6MyovTLTnLIYUhBV2PIpUWMvWICsLBZNhnOmKPjsFblKPbUThrVlk9CtpVLe1AFi9Zh2Rd7c6qsg4PCny2RGNqsZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=VSvcuPab; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73161849e1so322226266b.2
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763122743; x=1763727543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHSvtON0daRkXUkTRexT/Sc3xyec4Q2i/7798OEMzyc=;
        b=VSvcuPab+M3XrP0erU44T66QaAvKrYgMiBHlSdAxXl9ZEz9Hv1+etnsi0iLQeC1oAN
         jEnOn6G2KUW8fZOyajGb4RuM/t3Ati896X5E0AYq+R5wmVNe68hrQs+W1ETULReoZdSj
         2cZfuHT6I0I7ewHjPpSFzRX1Ap75Liamsdprs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122743; x=1763727543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHSvtON0daRkXUkTRexT/Sc3xyec4Q2i/7798OEMzyc=;
        b=VmE1JZh2GkkTHnFV51AZ60clUyikasJ4KSe3PEEVl1jubx+JnNnLVwFbS6me5GevVY
         +i3BnTWjUSKp2GdsI9ljkwg4zmxmJLfko/sp/eU8TpB8TgVuh4dWaEt/RwEWLubS21NH
         7LtLUKOCYzdu8Kc5qgbePHIGJQ7fHsxS6e2UxqDcD/JKyzLUb2ISClmXtI+5o33YYYLS
         K3mLYi4kFCqyxqgeUvtTzN+59pZfAmZK4eHyX5QWp7omOBtpC6WostgVZOo5UBseaPDc
         MYStRNY4Lf3kZU5LVLrTAZkz1WdQ8P4hJNnIH+QT0Ssul3Ioa8/AFKbvW9A6Qgv1F/k2
         lP+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKx6xY0cqX/sJcemWDGfVknqsjSIW7liTBxyzNgU20OVUDKfJz9r8gTRGvOJIA4kITozHQIhdtoZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfbBUAijKEbXfaKq6llXe+7TvFJvDwEqEmBz534qC9BVbWute
	oInvfx/T3F4/k6zsmDn3XW2l/bReWHAzzCS8ykI9oAcdueRnJ8BXHSJQjhic5chFXQ4=
X-Gm-Gg: ASbGncuiW5H5brGJETrnwJZC2rHkm1DIl9mkgj+AM6/C+X0rQqRrZ1Y0F8a486ZulCK
	5YkDtsSfLbnFFsMEiNteXpAjjNrYqnNj4NeU4rcjx6uAfWPCZEmh9qYpOFiO93TfFT0YjlxVaA0
	hGwAflQCorb0+s66RuFSOPyppVFDT8K3p/T8CaW1ee8OwDZL/zCB7MIiOU8KtSAmpEbW5r+bWaD
	989rJ4gLxVdlZxJmCIw+2IbU1MOSZqkiRip5GeSKD/2pC7AajDhjE84pQWNGLusuV3xIB9E3sRw
	IgIFeP7WdbAbOIUIl/FZ1yc3rOVCXPTJ6EhnODBsELSrCBhCfeFPRF/evTO+lDqeCeS8UFWlzMu
	NlEsGzLjK7DG69C53TFmZd8637rOAZlS0jgcB5stVnuA1qWCNlLtiaRS4U7lmyrgUaDZpTL1toy
	W9krWFvNuuhrtg8mQcGIAMUucZlc+5xiVknVirWHWaaAwK86zZbuL6QANRz8aCliUVee8XiA==
X-Google-Smtp-Source: AGHT+IFxpDudTXwIWPtFNvkoyi2MCTPSB82q+cheaWh8DndjD5+q+I3FMC5nPCdsc5ZAOVqgxrhpjg==
X-Received: by 2002:a17:907:3cd5:b0:b73:57eb:688 with SMTP id a640c23a62f3a-b7367949dc5mr287626866b.53.1763122738505;
        Fri, 14 Nov 2025 04:18:58 -0800 (PST)
Received: from riccardo-work.fritz.box (host-82-52-164-74.retail.telecomitalia.it. [82.52.164.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed6315sm375295666b.64.2025.11.14.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:18:58 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH v2 0/6] arm64: qcom: add support for Arduino UnoQ SBC
Date: Fri, 14 Nov 2025 13:18:47 +0100
Message-ID: <20251114121853.16472-1-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for Arduino UnoQ single board computer.
UnoQ combines Qualcomm QRB2210 microprocessor and STMicroelectronics
STM32U585 microcontroller.

In some files we decided to keep UnoQ code name as "imola".

As this platform has a microcontroller connected to the microprocessor
we needed a dedicated spidev and to add uart2 to qcm2290.dtsi file; both
are used as interfaces between microprocessor and microcontroller.

Some GPIOs on the JMISC connector have been defined but not used in
qrb2210-arduino-imola.dts; this is meant to facilitate carrier dtbo
development for users.

Changes since v1:
- Added PATCH 1/6 adding Arduino vendor prefix to
  dt-bindings/vendor-prefixes.yaml
- In PATCH 2/6 and 3/6 changed compatible in spidev and bindings
  to "arduino,unoq-mcu"
- In PATCH 4/6 changed commit message to clarify imola as UnoQ codename
- In PATCH 5/6 fixed a typo in commit message
- In PATCH 6/6:
	* added chassis-type="embedded"
	* ordered nodes in alphabetical order
	* dropped unused led labels
	* fixed error in commit message (qrb2210 instead of unoq)

Riccardo Mereu (6):
  dt-bindings: vendor-prefixes: Add Arduino name
  dt-bindings: trivial-devices: add arduino spi mcu interface
  spi: spidev: add compatible for arduino spi mcu interface
  dt-bindings: arm: qcom: Add arduino imola, UnoQ codename
  arm64: dts: qcom: agatti: add uart2 node
  arm64: dts: qcom: qrb2210: add dts for Arduino unoq

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/agatti.dtsi          |  24 +
 .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 456 ++++++++++++++++++
 drivers/spi/spidev.c                          |   2 +
 7 files changed, 488 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts

--
2.51.2


