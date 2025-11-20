Return-Path: <linux-spi+bounces-11421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85EC75465
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2834F408E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DAC340A70;
	Thu, 20 Nov 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="MqNy79CO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494635F8C0
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654312; cv=none; b=Luk6+oE2CnkMiAvCXutW0y6KSmdvU/bRbcZTssNw66K7gE+CP3aBWXfQu2V7iEQVjnvuL4A0aag7oSkq4Dym1HnJ6T8ml2CyLY2S8yvkjYa/SkgTR5qvJsZoLo3ck08e8KTAfNIJDSEKdEZ6U0N2Y4ZRKUpumR8ODQQdT+FRSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654312; c=relaxed/simple;
	bh=w7YFrkfbyTCvfyB41gavemDY8lfBuU4oxXFueWjMa9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq2FugJphSni5IwMUgp1OPkAJsGj1/gP7CPNYlwFm41Byh6RGw5PrY9hg5JE2jegvufMfGT8btBjXWMdga2kkI7gwlfGHFl5yxSGu/lwwUxqWCK49iOAUGVeco3AmtOzDNw0YyXQutRnU7k+IXHlx5LUuZKg5rUchA42dO4hgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=MqNy79CO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219db05so7261085e9.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763654309; x=1764259109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hexUd/mEPKRNcSZxwjjDeUDQ0Dgw47XrMHUrWKRSBc=;
        b=MqNy79COfZ4sJe+gRWcQ3dsA0oEMcFxTj8lwFl2heKsWF53trncCcm8bJuxye4ElTR
         FPoSmEA9wJmxDqcWkxUZBX8urWeju0/kt+FYVxTnRI7aNRCkaBypSGOEx4oxV/mOgQMv
         jd/VwKcyhjmk5lCHqVjaCIV2Tv3X7OTuPp5w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654309; x=1764259109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hexUd/mEPKRNcSZxwjjDeUDQ0Dgw47XrMHUrWKRSBc=;
        b=NuvG848lXlTfagNyAe5ezcyb5VF/nuHClPkqbBo2e16klcrBaEM1+H3Hdqsn4Qd79M
         ae1OpW2BaKUuyCV68S6YwjmaBqzS/ZIIYSX5oSkHhMgGtW3ciQbPTTXTr7da6yH/kpZ0
         3SRfKRbKJwvN3355+cB98iPBUSt5Q8CxrkD1MG8qr6aUefbFZetZKEVFtHcwS2q+Czvy
         nAZal1Pu4zIGn+Jfr0NkqdNI5ymnMc92MVd6z6sTIoL/GBaljG7MvQIpMQr00g5wWCMp
         jNBkchOylOOnFGH4JXLz5uqYenngmDIEsh9tlDCSi+AbU2Rv+1GJv84ASMI2nxQdeBwD
         k5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT/L6QV+1/gJ6gk2YBSOkgHvDaTJwCen9Ha2+dKVJ+5KMZVtRr5w1NRhDsTWVqk41IUdN382b9ifc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywANZbdjRj3C7PM05PRmA5WZHC6kGfoB7X4fnLeDxWohWtbY9r
	G1m0QmqeGsecTikIF+GGQe/WB/b+wC/L4Mipg9GyeZ3xqCEnn9+8G0aC6Dvi9zp8iGA=
X-Gm-Gg: ASbGncvu3rmCr2k4/yLu14TUxYLHLNBvkfoC4yMikXBGAPtUKROD8mbUu/xUy0Tnks1
	Ky1koo6quf+OtJQMU1vB75dwMHlC9Ui7VPvjwyV/HQYW83/SXd36iLrtmKNeNQf2hap/gnv4JGG
	UXPSLFoWpoup7N22tgLQJpFibVajTXWeY3XkBnMkCRwFa+Fg9KYwaGh6dnceZ4YL2QdQ1tcnLRr
	pkCHIgpreqKgJTAS9qVzWpMHBM1lTqep2i/RWytqp4DIZdNrQSIhrF3a7p23X7J124tajJC1I29
	7wPhgmpt2YuRfaZycf4ttrn2Ei3vnINMPEtV8yUWqY3la1MvYHya4etzhZ7P8dHCjV2vSMA3bmT
	xcjbH8ppy/SN8syCHVproDgtmrfKCsvFTY/+k5WU5owIeGSREYhZ0qDg3AiAPulr1Opm/m5mprT
	QAtiRGW/jT6OUX8fR2evsqPGS81+tldLZd/QlA9j2yXR7H
X-Google-Smtp-Source: AGHT+IG4NhfTIea5v4MrG55J2UDtrIq+RFeJgaP8RzHC/SVzuCvbfTRCVSDl01OcSMHk5n0jCxfnRA==
X-Received: by 2002:a05:600c:1c14:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-477b8aa0ed3mr51319355e9.30.1763654308687;
        Thu, 20 Nov 2025 07:58:28 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm55552185e9.8.2025.11.20.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:58:28 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
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
Subject: [PATCH v3 0/6] arm64: qcom: add support for Arduino UnoQ SBC
Date: Thu, 20 Nov 2025 16:58:19 +0100
Message-ID: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu@arduino.cc>

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

Changes since v2:
- In PATCH 1/6 the vendor name has been corrected to "Arduino SRL".
- In PATCH 2/6 and 3/6 commit message has been improved to clarify the
  purpose of adding "arduino,unoq-mcu" as trivial device.
- In PATCH 6/6:
  * the qcom,ath10k-calibration-variant has been changed to "ArduinoImola"
  * leds labels have been changed to simplify usage for users and make
    them more consistent with future Arduino carriers for UnoQ.
- For every patch, warning regarding mail mismatch when running
  checkpatch should be fixed.

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
 .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 459 ++++++++++++++++++
 drivers/spi/spidev.c                          |   2 +
 7 files changed, 491 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts

--
2.52.0


