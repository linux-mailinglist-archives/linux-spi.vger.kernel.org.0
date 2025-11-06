Return-Path: <linux-spi+bounces-11088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A87C3C1A2
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EA13ADF4D
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05C29BDB6;
	Thu,  6 Nov 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="OdOBHfbu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712992874FB
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443087; cv=none; b=PeFjTZ0S8gU41yqxJeO7aZy7ZCcxVtL6lCXj/mAI+0U2/c/kTQbtHy8nrpA30cV8y4M0Tw25EDYvYqKgZhgDoaXwzdFkthqADiNW7HTlG8ZPEksGsd2k84oiWpCHADCTjzheF2ZeKm6Tjpyx4MJmSSHb4M1iNN8zglHceM3SIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443087; c=relaxed/simple;
	bh=q7sHWixTWPakJjpCcPxaoq8AAo162rx3AhfF7uVu25c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFzhJLO63T0DA256X0zc8z50vkEWzM6u2bn6yeAs0F+XYtAYWc6yVHJzBwGM+Rx+0wBLU4UMHefyYxcGZyFXCTZ97wSVwArAarungyHHdXNEY7VFysidEi7BmKDftaCiLavz4V4awjZprEPzG4+hadxnNmPfHqVCz/v+xwg1LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=OdOBHfbu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4283be7df63so593217f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443083; x=1763047883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiPq/j8AAJTo8QumL7Ou0ccmUXufOZkM5RLHegjZVMs=;
        b=OdOBHfbueRgB62YMyO/xKfh2Zf+yMHwDrCxlE6ZShHQdhZuWQ+n15KOGbvk9ITW06D
         dVs6oN2MurfkC2rWyFo4uH1t2CBIsqJfl2SOQ1XRs7Z+kukQxdL1/zT7M15GG/YjdUe2
         rv0467B33Xhgc8vcR/we4HLVvNo1TL/ytPIYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443083; x=1763047883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiPq/j8AAJTo8QumL7Ou0ccmUXufOZkM5RLHegjZVMs=;
        b=vO6yJhlUKvtnKPGgRpXdku/jPzXM76LWSkKkR1JtfJVdLZM0VqxcNXRBMt9fT7Bqxs
         M5b707UyzDDt22ct2QqIvh1BJ6LIk87euAIXuoRoTP3I/NhYwoCyu2Dsy+1OP7J4yyjB
         6aH2bq63YwQ98AegSfQAdwB/7oLK80v/DmCt/xkgf03UIyA7qCI4vYKHZBxLFUWTUwtw
         bo/rHuVXDD2XWLH2vRdJFtkzZHNdZjI8aRAp0MUWe6T1E3VlAbQjgc76lIS/esz+4q6R
         s2RMOiE2WmRjcWjT/bi3Wrm3K0wevrDpg836nDAB7wCBQDd5ZHcVyk86W90ySjMQDvWc
         StqA==
X-Forwarded-Encrypted: i=1; AJvYcCVnV7vCnMybNCq/hkHCDWKVk7Vw0x+JG2pJN/j777MeIGwfLuoQRnjyNhCDA7zXC7wvtjQENHzLtvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD211hGQOX+0rNKyngQrU4VFQQZ8/uPx+hoZLOUnuvZM1t+Th2
	7kUKxFCaUpsNYFo52H5cRC2C5Fx1hmLIXtZ6abXS7OuT2kiG7FEU6SefSkfWNxvaHIQ=
X-Gm-Gg: ASbGnctynNQR57JVq5UctYFZoa/CFLEMnUEMi3p2ak2W3X1ktCAEBnRutiRlYGkHxqd
	8ApRfiHGmueoISFL+SXsJSd0AyXGmEFgwJ95Yds9abelo0zYkpHYZzkrxyG/DmaZ9RL+New286+
	428Bl2Vo+pKLzAJUIxXV777z/78ATX16jsOIcvabLTH+1hspVb2tDrPmGqePsTnnT5OofshuFQc
	D2bC+vw4AFDK1Fze+EghlvojKrWFt1mj4+fbyzddMn9NwZy5ybKJBGxprW6lC389Uix5ZTlJFeg
	RdzoQUnSDPXdNVno5pqmYD69/XvJE+FiXCbaQhrgsenGeORq3unmV2JflLXOsqrZZz0u4xjyoPx
	daDHNUcYox0z3Ou31BwBYnBSGnS2q81N5iJlBU/04Lo9l5gwOegK2AQtABH42pqelSujuR6Ogjh
	bonGv4odWDbyig5EHou0KvGOZE
X-Google-Smtp-Source: AGHT+IEDkfl3qHSikpIA1Fyk7Grp63BtfKWcdxvISif02sG/ljkZgpwjNMkZU5Sn7DWLfr/nw/w+YQ==
X-Received: by 2002:a05:6000:2c07:b0:429:66bf:1475 with SMTP id ffacd0b85a97d-429e32c6cb6mr6521748f8f.3.1762443083270;
        Thu, 06 Nov 2025 07:31:23 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:22 -0800 (PST)
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
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 0/5] arm64: qcom: add support for Arduino UnoQ SBC
Date: Thu,  6 Nov 2025 16:31:14 +0100
Message-ID: <20251106153119.266840-1-r.mereu@arduino.cc>
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

Riccardo Mereu (5):
  dt-binding: trivial-devices: add arduino spi mcu interface
  drivers: spi: spidev: add compatible for arduino spi mcu interface
  dt-binding: arm: qcom: add arduino unoq codename
  arm64: dts: qcom: qcm2290: add uart2 node
  arm64: dts: qcom: unoq: add dts for arduino unoq

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |  24 +
 .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 467 ++++++++++++++++++
 drivers/spi/spidev.c                          |   2 +
 6 files changed, 497 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts

-- 
2.51.2


