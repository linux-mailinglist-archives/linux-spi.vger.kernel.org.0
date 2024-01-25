Return-Path: <linux-spi+bounces-740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA783B695
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 02:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D31C1C21410
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 01:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD61876;
	Thu, 25 Jan 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlF9QuT0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B4ECC
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146540; cv=none; b=Vp+fOk9tk6JHl739mT64F7MAsSrljOAbBacMUhcUZywPUodxQ6Dh/aHi7VUSGA2Syqg0wqgUdjzbx66kZiY3M/RZ0H3beOECdlSQo+wucmaR8nGatjerm+ubhSyNfG4UvWZHSpmP/Eya53aTKQ5CElbK93nj+16AF8jEWOdfAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146540; c=relaxed/simple;
	bh=ImPV6ylvDLNKhmYcU5bvYmZGFnnlYjliM2xywtcdAl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WSltNNmlo2x7/AVGgTBVNt9qr77Y3yOVjYRM8aLMS8JZuci8sq+IPjmqqwn4tZamUlTP9UjsHlblibL6qAM2PCrMaIBajWCU0g4IivAJHcKL38SCb+3kJA2O1Jf3RaijT/dM/tMpDxmSGFm5gObYCDGchn7dZxH5PvEVBT+uCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlF9QuT0; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-214ccadb6a9so196945fac.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 17:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146537; x=1706751337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5NL15WLk6NkJypOkLe+mhvC699JlR9mZPB9t6UM0NU=;
        b=ZlF9QuT0jqYVCjLdwbvTfu3DWRrw/QMxuJDkLkLrIf9w2yM4ZCaOGOc6pWYsCdCnrP
         ZMvInpleH2CQEFqN1vJH25EDdoCzkD7VdWZtCucBY2+0OUWXOu3RuXfUnNq8+dWD2H6y
         uNcZiMMNIDEIchRWjqEw1zRNZTtvDqgm3NUA4KbDqWX3Do5pLNLGl1yKoPR4AD4c42m6
         SmXjIJ2uay1TpxgeJLusxwzyCRgiZBWU9VIFdGD1IkwN8P7kUo/9bNvCOnUkuXEwCxo5
         2Jvvv+EuMT1RbDPN1Jzn22PyWPYYG4y4pxl5efmyDWb9E02wcOy6eMQysMDOQZ5TesRm
         vv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146537; x=1706751337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5NL15WLk6NkJypOkLe+mhvC699JlR9mZPB9t6UM0NU=;
        b=Wr4LRf3pJyJXZIxXNaeWFh2ltAIdCjYApai3IDdP8KUyuKTWv2F3QjLY+G7+xYtkmh
         YwXMK3Gll6OTx+Yr/V6HAbegsJohNdUwyyQorhABbymUQJcUhLzHEs7SrSEv9uKCq/8r
         I1VHzPbmFgDAxSm3Y+Ks6kwWE02o24ftNMppulj0puDM+zUO6Z+1zVQI7fuNKKVs/1tZ
         Iaz0h0Oi0mcLHZJLVB/ylESbXHBYEapOlaauhkYX1kLzAQMZFqeja/szcbWG/L8kcboW
         rqrzdOACyZ3JYmPAMxGjWrZCtF65i+wBv9YKzJb6DVB2/orCU/fFob0tT+6SAeXShErU
         z5xg==
X-Gm-Message-State: AOJu0YxO3Ri3NOn6Ksn+C6VrJ+3CxQg2GfK6oN5TKsRz6V4LYjr4EH7v
	FrgekHXdIzLJccTS6fZ5jDLSQHmeQ9Es7hgt6l00FRBEu79LT9oqI8JpfpX1K2g=
X-Google-Smtp-Source: AGHT+IF9XQTNJJ/f8xT4W68lLb3MvI4ACc9ioQKWxUFT2QjM9BvvZGNao/6NUeDg1g/nqtz/28pKUA==
X-Received: by 2002:a05:6871:782a:b0:214:88e7:ba98 with SMTP id oy42-20020a056871782a00b0021488e7ba98mr202211oac.107.1706146537573;
        Wed, 24 Jan 2024 17:35:37 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id n25-20020a0568080a1900b003bbcaf2f27fsm2817304oij.27.2024.01.24.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:37 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] spi: samsung: Add Exynos850 support
Date: Wed, 24 Jan 2024 19:35:34 -0600
Message-Id: <20240125013536.30887-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SPI support for Exynos850 SoC in spi-s3c64xx driver, and add the
corresponding bindings. It was tested using `spidev_test' tool in all
possible modes:

  - Polling mode: xfer_size <= 32
  - IRQ mode: 64 >= xfer_size >= 32
  - DMA mode: xfer_size > 64

with 200 kHz ... 49.9 MHz SPI frequencies. The next 3 approaches were
used:

  1. Software loopback ('-l' option for `spidev_test' tool)
  2. Hardware loopback (by connecting MISO line to MOSI)
  3. By communicating with ATMega found on Sensors Mezzanine board [1],
     programmed to act as an SPI slave device

and all the transactions were additionally checked on my Logic Analyzer
to make sure the SCK frequencies were actually correct.

This series is supposed to go via SPI tree. All other related SPI
changes are independent from this series and will go via Krzysztof's
tree.

Changes in v2:
  - Collected R-b tags
  - Split the initial submission [1] by 2 patch series
  - Changed bindings patch title to "spi: dt-bindings: ..."

[1] https://www.96boards.org/product/sensors-mezzanine/
[2] https://lore.kernel.org/all/20240120012948.8836-1-semen.protsenko@linaro.org/

Sam Protsenko (2):
  spi: dt-bindings: samsung: Add Exynos850 SPI
  spi: s3c64xx: Add Exynos850 support

 .../devicetree/bindings/spi/samsung,spi.yaml       |  1 +
 drivers/spi/spi-s3c64xx.c                          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.39.2


