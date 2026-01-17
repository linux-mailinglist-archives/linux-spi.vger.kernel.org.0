Return-Path: <linux-spi+bounces-12462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B4D38B3E
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 02:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D7B8301D2C4
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D2286891;
	Sat, 17 Jan 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="TvWb1U3s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E21FF30
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612919; cv=none; b=U3lMMD2GAoNJ2BJHguJbQ9iUJsqCDMbvlVTUzJ2EAwzUWlZEKNxbHdh3wUHwo4ENZ4eg4/5KRZAgQtmLeoLJ3Fity9BaFLGpfCSjnTQx0l1O4IlrYkaExJRmBI9Ovxa3HxGKLnihuFKDXmeOFOR4QXRV6ILjqV5nCF8uB0/npWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612919; c=relaxed/simple;
	bh=JYVo7nUGr4sfiI4JHulrwy94BfbUiXUSmDrNzijCMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nkw//izJLuHeSlcROWuHmdxsvZEAVRkDIbwzRc3oxlnWB4OWtymR4c0Yf4vbHF7Q3vwkE6zZi7owe7tU8Oc2TLwv32f5DvJ5OMyf9GdSYkUQsmpGrtGhad9y+g+7bJgoPx4DbfnInfRniBzq+6JrrSffxXq2j9XmqnlK3JM80Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=TvWb1U3s; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f42e97229so5850226c88.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768612913; x=1769217713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxRAE+6J1/VR0TMOgZgPO8SPeLk5GzHQqIi3etGBIWY=;
        b=TvWb1U3s0E83Zq4jmD8n8+0ABQw9CaipDfzkue4pJqB5kjhI9nhJqbSTJP2NQxVKjr
         d3Y0NrtH9oOGiCT7DlEEYhSVgUBZ+XSvYc6MZtpzXAYMpAtSQeRTIG1zacWs5QNAUvV1
         Q/4zPinQCUM7cABz60etKt2jnB2WOC4oswko0/fc98n2lGpy9HyASDvNaJK9m0ED2Mkn
         gilE5qtLp2JmZiNKUGKQZ3JnvlhudbElxKyM9TAaqFFroeBBR3yEJjAHfz3w2lSSDSLi
         nc/vAQ8hHB6UliT7v+4zgFgfZIVq4R5K7ZL0lyryVYjMUs4oBN8rZDYbqELtcPjE4/qB
         WLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612913; x=1769217713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxRAE+6J1/VR0TMOgZgPO8SPeLk5GzHQqIi3etGBIWY=;
        b=ZjUbnpefgYB/IH9GRWGjfPOPS4fNi3shiLK43EdmkKPKK6rienl7IGABsexJCBKcPq
         EseVY57Xyc46ApcIDG5stlRurfzEa5oZswU9jK+L6rNmR/lt1m+aigeC8x3UYavLX0nX
         CSKPYLrXIzMbbEZZNAj8e9RAFveBxsKNgmpka9jZ5cphpWITGmT4fkFD4heGmEZcVTXG
         NDdQ6+pRoncoWBNInP9iCtro0IoeK7HEvhb4piz8wATsCRNt5Pv2zOdu3kTX5dr8HQ06
         axT9M/uAY8tjCQMYQOWG71w3SDvdfLAP3OCSokZq+NN42XpFi2+Byfins+Bjci/EhV7A
         GQFg==
X-Gm-Message-State: AOJu0YwrwjP3xx3d120p5UL48xYRxqrKM2XIXVg5nra6Hc21BaUXfbc9
	HaF4w7t0Igrw86TsY8XRGtT4ex0IpXaHfCqPcW90skRHGmTj3NTzotFcYoWs9erHvtQ=
X-Gm-Gg: AY/fxX5oSS7Pwc8LqEm01goJFJQfTmxT2w1L76W6wbon3o9RVSxLvhV0GDbWlWkMRJh
	A6fkIjFXPFaKGxjpLKh9zLiLaqmdgzaaiPoh0c36GCm8EwNVlM9L2OHWtvQDxSENBa93DlyAPa0
	XPl3+VOx8zxyEhUdUK2XX9AmUEJN5kMCAaPOooDoTzBZTf+8n9/FmQDNimgobDqz8e2vGwVreBE
	LsY5k/9p4P6kSLMJrK2JUDA4Ws6FC5J8iHXQZJ0F5LubZcl59LvphXodS/dLCQNvbDL3fjSyNP+
	PtlfWSXoFNjhveVqBXzLykd8sblrjbKlMFrMTQivTBzgXws1qs+p8PudO/GMtXNlACdR5Wefbj0
	SHlQeXBTMX8SCJqALX7O1sVdt7yZ/oBEzNgjAdXysp9gHPkW9+u63BZqy/zPBPVyRaNJH46krOg
	Nv9v557uHT12s=
X-Received: by 2002:a05:7022:322:b0:119:e569:f279 with SMTP id a92af1059eb24-1244b3802e2mr4430875c88.34.1768612913075;
        Fri, 16 Jan 2026 17:21:53 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm5370810c88.5.2026.01.16.17.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 17:21:52 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 0/3] spi: xilinx: make it work on non-OF platforms
Date: Sat, 17 Jan 2026 01:21:33 +0000
Message-ID: <20260117012136.265220-1-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes make the driver work on ACPI based systems.
Making the interrupt optional makes work on systems where interrupts are
not available or broken.

Abdurrahman Hussain (3):
  spi: xilinx: use device property accessors.
  spi: xilinx: make irq optional
  spi: dt-bindings: xilinx: make interrupts optional

 .../devicetree/bindings/spi/spi-xilinx.yaml          |  1 -
 drivers/spi/spi-xilinx.c                             | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)


base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
-- 
2.52.0


