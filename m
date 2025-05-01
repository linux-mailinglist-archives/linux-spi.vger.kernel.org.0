Return-Path: <linux-spi+bounces-7814-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D00AA6058
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE459C1018
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5520127D;
	Thu,  1 May 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mStVbJ/2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBC4315E
	for <linux-spi@vger.kernel.org>; Thu,  1 May 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111731; cv=none; b=Il6nhzt7v6Xh6RydSL4izHsHct55rME5d4WBGrVKGWrsH6hvMdRkDk71sEieZ92jiDNTkAuX41j19pKA/zWKgVo6z5TIB5iRLynxvkkRewcY0/4SYAYpbb8YMhpKy9glxXlptE6FNMBOAfL7/9jvoamf5YKkKB7vpn10b789URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111731; c=relaxed/simple;
	bh=1VWijjOveKM78Pbg6yVVTbPVhW2rlfQmcQFnP8XIqZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ttgAWtF9oh3bkkp/AlZDi8c+SORGgQOM6eeE9IiA/Rw2bnSQNOOd2SDy5bwzB96yxNyZPDzh+RpVbhmIgD6lThpfQJVRR6vtgOPWF8ohOQx9GOtBb9+SFDQiNj4lGkWpB1RlfXYYIHM5kK5N77ggkgx7k3gS//27k0zVyuCf2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mStVbJ/2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso1369335e9.3
        for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746111728; x=1746716528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttrcVZYlqM0kZXU17grb522rcBK1Mj9yyOBAh163GPk=;
        b=mStVbJ/2begK4HcerftuSeurs0ZKybz3qaKT6KR9c8YFyfxtBjjtJFUxBhQZN4FF2t
         2ABBiw172fAVCRdM7klQ6LTM+0pNgpKuScRHhpcKgkDpJN48or7LKLTMC8c8jKafSZBT
         6aOsIdzRrRI7x8N+iy4bZPpQcA0SKEa2TlUOYX2snLZ3iBh3eUCCfopq6HsRmAhaibbL
         oZlgz9jnkseTa0l5FRa8eeCnW+q6ecAVYhxRPjCA8xn7Om27ZtM6DA/L9Iv/sW0gioX2
         +zLCOkekQ2hNPupsWkeNhDJvX6otHl5MdrVklFfgBFd8xVMT707pVyx4uL0ux7MBJNRP
         MVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746111728; x=1746716528;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttrcVZYlqM0kZXU17grb522rcBK1Mj9yyOBAh163GPk=;
        b=kDMQmFDoVXbBenZQzS5xTlRhoTFHn5klJe8G0XqnPs8Wvc5q46KausYFaLZsJVkRFS
         /mmNSghFNErfHnTnG3WHhmnqBExp+dnyEuOKwmfrCxEqFWrW+Eel4J/ljjZxiMskyAaI
         WS+u4qPi7cH96WAQjkzJ0T+HNz8LAEZ7NSBWTbOhDcL9DtDD+vAGL/w/OJVFpi8yp5H+
         IvATJNI30tpXVK8lQi8BjHnh1ccVJ2+xsfjWQdUSbCCch6HEjj0JHDw2OtCR+oIOe0Yc
         R57jKvmoJQF73su2S8wN/2jUqGo+qALHnuQ9whV+m8cPzb0XMvL4Hg5gyHRbpcmXPupG
         Fzbw==
X-Gm-Message-State: AOJu0Yyg16Vv26k2X8HUI8eQzVrwRQDKNyObkq239i41peyA/niW03xU
	lmfGq329PZchBcaHpof38r+qq++OoFdtAp5pr0TfLBywoDCK8Mxk+fejot9wx/M=
X-Gm-Gg: ASbGnctA7MmRu6yDNEVj6OkX/MtME/P1vRykqk/IGF46qtqInNG5p4L+nL3R8U1kaRa
	3D8hPu/d6RbKc6OOymjLM7BkG3ykyHGADQL1ao1uEG/qYB8fxoy0sZ2BC38tQQHTn/5y7r6zW8d
	SXnY3kciFazr7iElC7RMr3jzZSepdZX3v0VLgmba7BH5Fym7byrlLi1Q2ma6Ks7fCjiWCfq9h0C
	US1zwHqHhdMihFlP307nkrl+IY+nOblbjd2N4sLSsn/c9lIHCtguTgxfDnT2dYwPaB55kB1wiev
	I+/dUBEVAxD5G+LWEPzgfVid0xNccM4WPGF2Ei5yqDI9jFwFfH3gO+31WbY=
X-Google-Smtp-Source: AGHT+IGZ0ehud/ximXE2CMIJErpM4SI/FhJUBgX6fJOCUs66uW5nSEtDJMw+MUC0zHgypjkuk3SDZQ==
X-Received: by 2002:a05:6000:1866:b0:3a0:86f3:451f with SMTP id ffacd0b85a97d-3a09007e244mr2089279f8f.12.1746111727129;
        Thu, 01 May 2025 08:02:07 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a4702csm1033190f8f.40.2025.05.01.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:02:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/3] spi: Minor smatch fixes
Date: Thu, 01 May 2025 17:01:58 +0200
Message-Id: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaME2gC/x3LwQpAQBRG4VfRXbs1RoRXkcVk/uEuDM2VlLy7y
 fLrdB5SJIHSUDyUcInKHjNsWdC8uriAxWeTNbYxjak4sm7unFcOckPZokfru+Br1JSnI+EP+Rm
 n9/0AxdzydWAAAAA=
X-Change-ID: 20250501-n-smatch-fixes-2e9e6d8fd3e3
To: Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1VWijjOveKM78Pbg6yVVTbPVhW2rlfQmcQFnP8XIqZ0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE4zple8GyUEoL6IZq4zjpqAic8P29xT7tLZY/
 oehltltRHeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOM6QAKCRDBN2bmhouD
 10owD/9FVZ+pJ3mQzWF33wBIVcZ98/gdePGTPJk3U6ZXnM4XdSM93A8EysytmRSKp7mhypSC09S
 FG1Wog7SPakZpceFVwWPPrGY2hKwztfjXSqNvvBc+8dZrFaSEWCfcDXQbj/U8stZYVvLnWn2n+M
 ePWBE9BgqY4tVnCYizR8Ly6Uz4vq8Hd/oonDUaOetnq0k31z+QKYnGXL5MYWNJmVaqadmvjOHie
 hYusnzCyascIXdMkQmABsoD7Iy9WYp3xqi2jEk2Z7FrsHT26YGL7QlJei96DEMbhQDn+D8g3oJD
 MI+V1U5WUI/iy+w+1Y/10hyKKJocJDHxkobU93xbfHaHcJkB8r9of/gU698FNKF+Lh/b7WY96NZ
 zI7PcXajVysujp5u87R79aAfMiB8YZGZ0+gHy7vU5Q+ySZO2e9jGenhmcyYk1+zg+iL9mjK5fe7
 J9UUK1JDjVstLr133cuD1nGE6Sw7v0IgMS4aNWFpqvRaVMcnNE5/cB/TilOQGRX+TLUJX9QzSpC
 OpyD2tAVGgC1kI3A6okSAkKk4B7c6ZtK7Nbvd8lpdDjN8GZzoSJV07M4Ym4+7PK8ZwK+KFXnA4X
 si/kVQaqYfcvNnfJTrn7Lb0S+Q9BAXayQixDMKbVa8YjDsHsPbI2vn87cfFbihe7Be5gkOtN1q0
 4Oy9BANH0Pd/Djw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few fixes.

Changes in v2:
1. IS_ERR_OR_NULL->IS_ERR in cs42l43
2. Drop patch which was already fixed in the meantime by other person

v1: https://lore.kernel.org/all/20250104205437.184782-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      spi: atmel-quadspi: Fix printed error code during DMA setup
      spi: cs42l43: Make handling missing spk-id GPIOs explicit
      spi: cadence-quadspi: Assume device could match via platform

 drivers/spi/atmel-quadspi.c       | 9 +++++----
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 drivers/spi/spi-cs42l43.c         | 4 +++-
 3 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: 6b7e080d43429e85b40355986026eb69ef775df9
change-id: 20250501-n-smatch-fixes-2e9e6d8fd3e3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


