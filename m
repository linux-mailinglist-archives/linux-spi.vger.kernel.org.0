Return-Path: <linux-spi+bounces-2644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3468B6B07
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F61C213B6
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E411BF5C;
	Tue, 30 Apr 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpyNNrZ5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E018EB8
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460633; cv=none; b=ar4pcwm61U5DUJJWENOTcjCBKMRmErCGxZIWz2yWYX14DFMNBhk/0n30Mb7I+Crj4r9zqUR6879QxbO40MADgYOdwmlwM4fJzKpROHO1U2DeqWWRXgyWktTr58UQg9+oMzaNsF3eT0JbHyDRh5hb92TCHc0TBrscBeNo/ik1JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460633; c=relaxed/simple;
	bh=G1k8CpKdg+bfIUwSdRenW5CRY3jxZAX4mgXlxWT1N1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dME1IueKh+589+74QtbtWEv182FZ4GrMiwu7JAf83NweirZXp4obK0FUPGqaeX4VkzijROXmjXOPjJiJhZquZBhqMMqgnVHJubV4E5rBzW67KbzoUwLhi4rOlLMBoZGaHnhCIrqxrkGiYlZEfnEFwpKuhcMdep/L6GKrwbxzx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpyNNrZ5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be74097cbso7331017b3.1
        for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714460631; x=1715065431; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IInDItLrXNZ4XNBWelveHBo8SDn/BQxqaWUl2OaDTB0=;
        b=DpyNNrZ5bpOiRbBkrVTpbFIVOWpuGiP3dTdf9esZJIu/vAw50WNmipAMnd/RYNxn6m
         DF8048f71D0d6v6MTo1Cnmi5CtnUt5zRCYZqidwaGvXCdIKfMhwmgrhNJ/IG0wZhzewa
         tJOfjAhlXdC4hF9OdP2YcIRyVldnwIwN/WZWDFia0xfz9hLIak8wO2n+CAoLnfxBNV0c
         N1/74Dmj2tcCm1K3g/z///EbMLpGBMywsQl5hCJxJU6e0dEO+TbvdmYu6hp3noEh+K1P
         VvS9ljT3zjNT2F5v92kzkixciv1IgJnu+mWhworADvCkEwdtx8Hrl5JRysSCK3ZEy0Ox
         cpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460631; x=1715065431;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IInDItLrXNZ4XNBWelveHBo8SDn/BQxqaWUl2OaDTB0=;
        b=tyAUQFPzBJt0Mva+AZBwrd6aEKKL8yGEbmhdjoWfYoEgAVT2HRwvcOTMVXCOeeM/No
         7mFen/+gHXMdCmJgg5d3wjG4xwGh2sAydr/jjtLDEYtnNyPwU2LsxE/c2A/YxHzWL/sJ
         8nXul16nkVGTSI5PEOi/hOmNs69XQg+5ahNuFruiq2NPLYncThtGy0hgJU6glQnFuXwc
         D2g1kM1gJQEF/D8Gpg2a++nI2VwOvRw6LgNPs/NZJ8tquOZNAf35L7k4kk7/OUU2DJAT
         qsKDbh67rh5SfQ6ibtpsa8D+n0ceky2Y163wAY/MZh9ihINw0MwEKFHi9vOz6d0vSW2B
         5Mlg==
X-Forwarded-Encrypted: i=1; AJvYcCXeamdn4xFdJ8B9svzDKejM/jDbWJ7LhwVgdfdLGWN3XE13Qemhn/jdB3prfNzEgL8CeXbcm/eG+t5pzxF//eXuLnixYH4LoaBa
X-Gm-Message-State: AOJu0Yw6RkBl4khsll/3PNa2qaE6krI/FyQOalOtnn40Y9m5xtAjj20v
	HGCeuDpwofzOHZxflxyvazOC+ukjjMJ5r8jCCzqa0fnLWYE9AkymfIeLI7wpIhE=
X-Google-Smtp-Source: AGHT+IHNrNxsl7eqKfYPVs0+J4/3qJ1v/ED7s2T5bVKKWAFeZIDesnnJwNxwvf70mUgFPuqrS/Htrg==
X-Received: by 2002:a05:690c:6f84:b0:61a:b7c8:ea05 with SMTP id je4-20020a05690c6f8400b0061ab7c8ea05mr15025816ywb.35.1714460631276;
        Tue, 30 Apr 2024 00:03:51 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10610674qtx.18.2024.04.30.00.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:03:50 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] ARM: Modernize the PXA Spitz a bit
Date: Tue, 30 Apr 2024 09:03:46 +0200
Message-Id: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKXMGYC/x3MQQqAIBBA0avErBswFcquEi1EpxrICgcikO6et
 HyL/wsIZSaBsSmQ6Wbh86jo2gbC5o+VkGM1aKWtstrievGJO0XBxBJ8ThjdYEJvnFJdhNpdmRZ
 +/uc0v+8HrGy7CmMAAAA=
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

A few ARM machines still use global GPIO numbers to define
GPIOs, convert them all to use GPIO descriptors instead.

This machine uses some input devices so we go the extra mile
to use software nodes as desired by the input maintainer.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (3):
      ARM: spitz: Convert Spitz board to GPIO descriptors for LEDs
      dt-bindings: ads7846: Add hsync-gpios
      ARM: spitz: Use software nodes for the ADS7846 touchscreen

 .../bindings/input/touchscreen/ads7846.txt         |  1 +
 arch/arm/mach-pxa/devices.c                        | 16 ++++
 arch/arm/mach-pxa/spitz.c                          | 89 ++++++++++++----------
 drivers/input/touchscreen/ads7846.c                | 31 +++++---
 include/linux/spi/ads7846.h                        |  1 -
 include/linux/spi/pxa2xx_spi.h                     |  2 +
 6 files changed, 91 insertions(+), 49 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240424-gpio-leds-miscarm-d983c739001d

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


