Return-Path: <linux-spi+bounces-7171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA97A65640
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50936189A306
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199524886D;
	Mon, 17 Mar 2025 15:44:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F38248883;
	Mon, 17 Mar 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226265; cv=none; b=OMfMGr8jUtRQtpdXaVwCK5+pc3iLbl9ZKzoZv9272cYhVEc5lpN/oHBqgVmVTcq1C4mkxsYqb1Yp69j264gk/IsAQCj5We2kiNuKZq1kogQH/dj6p/3VD9cs/zB85YuptU1bouAGYInYJO6b2WXWkxgWDistEORKvMkr4s6DuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226265; c=relaxed/simple;
	bh=Yt1KXNfSOwvnDNME+PJy2ehJR10EzFKlKzItQXv+5DY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iuN+z8Gm5p9ImZSfkTZ21MW8wC3ineagpM9cT5UQ90sFHbYfxq+26gMlV8HDWEo7oqLygdWIC8WTMriF+l1tv/qo2FcJmaNSn87un/Kbrt69b/4Rv3JrUP4sQLvQUbzvgLV7lkGkeaDpZ5dfxHLfKL3VyfSREQ/JaZoowbixQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso7821228a12.3;
        Mon, 17 Mar 2025 08:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226262; x=1742831062;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf4n6jQkPZoi8a7nXdJipbJAESK50gmsqkR/lMgCfZs=;
        b=jKBawq4GiK8jWRIMvrGpXJ3yaZGr9VjzQcjUPCjrplGz5mQ+q5ivZP4UauTiz1PJQx
         +37WBFDSvOiYDKh36UsInIUNUMnVLR0hljGCTx2z7nmMXlkUiLqpQl4UHqmPLqjc7atT
         7k8fyjbjlZrNdiiEMwxmkr2XTMQoY2Rg6EtpEKfQD+tFkj+N/MRTjB9lXDORJhJsXmLT
         pZo2UQx4DV03k4dvjxcUnoGYu5c5QZGYhwkOf6LKNtS3ayvXsxOARmlv8f5IOXBxNZQD
         VrtYk0lSyIqirWBvA7lde2qJ6T8V057yCm9jOIY8gPlGKBQNnNlEzaLgDpMlQQE+hZeW
         2csQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP4n7rLk4V2N0G+VhnD1f6ja8a5J0q1dmGRnUlsH/1kuwJIeBW1G83DKBxiod6RSyFFpUUDWNoxw7h@vger.kernel.org, AJvYcCXdkCFjCSi2mcsuYNGRU8JqBPauLGgB7zMZ98TzQ3U2hOiVJF2Sct4ngRBGdxot80apc1Fi5jjMRe+XZqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBKt92hZy2krZvpvkG4fowI9sqNif0K3wTGtboVcxdaewpGKh
	ULwwpyaZLbMnMyehzY16XHExvb2vCw8l5/Y2KbPyqc73wl0Te5t3UjYwpA==
X-Gm-Gg: ASbGncuuPtd2JGkEu/qVzRYH26W5p1lpAyKpLcdDdp21q3FSPi3DbDa1JgToXN3WBpu
	acMzdOLqycqvt1RyNh7PvcJ8dVKdrPViYQg18O3erbIQ6gYL7gbp+7+eY3C0S8IvHZzccjoXYNv
	wka7UroYIYyXqujtBRxK/pDKVCyWthOsERle4Pb2uGPQSLri3QCOrG/gjAjo88rUGWcCNresU00
	MF/eLko8qCjhWiYbC+YwuoEbluRW5Vvyg5bnxvj9AVBtNb6W/3QzvWPhQLMEHUFqrKyaUHu7kvz
	aIAN1AvF/G0qBtkt0rdLJh3YOOE05wmKpWY=
X-Google-Smtp-Source: AGHT+IEA1ECYWcKSFTjnr3d60KjkCSPng2QfE+a5fFz0qYWv5Dza/Tw0IQFQd9r/EQwQLjOOrCM1kA==
X-Received: by 2002:a05:6402:354a:b0:5e7:b00f:9fe6 with SMTP id 4fb4d7f45d1cf-5eb1df95a3dmr173904a12.26.1742226261435;
        Mon, 17 Mar 2025 08:44:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169bcdb3sm6236151a12.43.2025.03.17.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:44:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/3] spi: tegra210-quad: Improve reset and tx failures
Date: Mon, 17 Mar 2025 08:44:00 -0700
Message-Id: <20250317-tegra-v1-0-78474efc0386@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBD2GcC/x3MQQqAIBAF0KsMf62gVgZeJVpITTYbC40IwrsHv
 QO8F5WLcEWgF4VvqXJkBLKKsOwxJ9ayIhCccYPp7KgvTiVqO1rH3njTs4cinIU3ef5nmlv7AJG
 brsZXAAAA
X-Change-ID: 20250317-tegra-1712e60604e6
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=leitao@debian.org;
 h=from:subject:message-id; bh=Yt1KXNfSOwvnDNME+PJy2ehJR10EzFKlKzItQXv+5DY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn2ENTErKv59mMRJ017rONPL1IdvLSRVa6nN4RB
 ZfnrT8wGZKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9hDUwAKCRA1o5Of/Hh3
 bbpLD/9w5o8kng58qEusrNRlV7ufN/oZRsFoRD2Y+xQE5ZbDHK2HFPkLewucQBapTj2cYLvUMQ7
 UrFXJur+qNAQhI5kXxyfzUAxME3JUNKL1/MY5g8I7S2+3XT+VMAJ/TNDeBR74jBlK98usXapEmp
 cDL0uaM70zVz9MrApeyrhDBFck81DY5jj1WTOX+M2Vh5WCSitUtXjsz9I+eSMXxE3KXwSwvwa89
 CMXBf1CoHAR+EKIG+j7AZj4I+JRPnt5kt87pN8a9ukESduXlnw517Sciq6tFlxGJAIy8QLuFOf+
 u36LSZdA/9H3rN6PrWtF5ihaiUR5cbPgUqA+TrCSlsUvcy2dglzbso8Lz6b7VtZv/uDY5uW5TuX
 HZhFVL55+Q2Z6gCwlVVfACrgJIOMhVoZB7H4qMRzc/RAhH+xUkrB8EBIZYWvTXDXrQE8ppXPxjP
 jAKMsfrNSlPoPQ7Uces7usZbpb3xQImuBurt0r+1om4UR/bOcDs1CN9A6QPwbAFwQdzbmcZ2X4e
 cjVpOopVzVudIlpNJdf1aRgNwPa6SoAHbQe95uu9AtSBaxcOOoxxsTfRs3EYmyKP0Nv6pmn/CX8
 9LpHs3e4pzoXFWW7bjGObdBZ5kBQKUom0NqQCnGX4BxVTpAiGiEZg1eeAQ+KatohO+vN3E8+fw4
 iOaWLXHstzsGClg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I maintain several hosts with tegra210-quad controllers, some of which
experience data transmission failures. Debugging these issues has been
challenging due to excessive log messages from the driver.

All my tegra210-quad systems report "device reset failed" at boot and
during recovery attempts. Upon investigation, I found this message is
misleading - the driver isn't failing to reset the device, but rather
device_reset() returns non-zero because no _RST ACPI method exists. The
first patch replaces this with device_reset_optional(), which doesn't
return negative values when ACPI handlers are absent.

Additionally, when transmission failures occur, the kernel logs become
flooded with repetitive warnings and error messages from tegra210-quad,
making them nearly unreadable. The second and third patches in this
series address this by:

 1. Using WARN_ON_ONCE instead of WARN_ON to reduce stack trace spam
 2. Rate-limiting error messages and removing redundant information

These improvements maintain necessary error reporting while significantly
reducing log noise, making debugging of actual issues more feasible.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      spi: tegra210-quad: use device_reset_optional() instead of device_reset()
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

 drivers/spi/spi-tegra210-quad.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250317-tegra-1712e60604e6

Best regards,
-- 
Breno Leitao <leitao@debian.org>


