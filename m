Return-Path: <linux-spi+bounces-132-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C717803BB1
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B941F2111E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615222E849;
	Mon,  4 Dec 2023 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yNxFS4yZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF3CD
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:09 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d8750719b6so1894293a34.1
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711308; x=1702316108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSgbctHdB3nT3F64Pa0svm72epawKOhkGz5KAA6x7XU=;
        b=yNxFS4yZHpi2urwGRYlxv3gMUuSd/nEIq6nqv/B2NaxzsqTIUBAWBcJo0xBVVN8Ojo
         GATMjxQtA2VMfCyKsLDkijbYy4NjiPqgxbtKsWn2ms/P7npV0ZhqcICMvMhf4y3NXXus
         +1cJAyhHJb95UYN70CnDPG9AwQh+hfMpO5a7Y1wRpBeFy7tV/s8vku40Kr3OsseoAPit
         26NlrOJmbE8g2YNrZHvbJfXNqWQe8SptvrqissbAIT7H0pcSIAG/FzC6pp6KIuBR3sga
         YsDI6MIRpYRn0MfBKidNb0zo/YicQ8C0Bi+6mDnq0d/8dvW+G7z56zbmU71h6YEQ62wM
         k5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711308; x=1702316108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSgbctHdB3nT3F64Pa0svm72epawKOhkGz5KAA6x7XU=;
        b=pUejrvBIc0cnXEeNzmsbreZq4QqxA5ICwMAxrrXBJHUnP72oIN0qf7/Y9XiVXl0gox
         7KV9wUDYSFX3HYNVngjqKoxpVzhs7icAGSxIhhYxPb5al6dZ+Xj8gu1C/Fso5v+fWgs/
         NE69Zr6FK9ZzdiWCkw+ZeIWa7evd2UgXfcrtWhurokO6O10BISHEJCsQMf20yEhMkG6P
         EwejBuK4vaH2kr1mSGkhKf/J6J/ZAaS0Qb+lPflKpjpNqkymJe6QSXdJeQus/IyXi21V
         ZuXWB6HsN7WOekGx7XWvktrc4e6uEUwgkulsV6QVLY9TXFyi4yM5EoMpk9LrTnSTQq4P
         xY/w==
X-Gm-Message-State: AOJu0Yz10ZNtJhDpFGdxyKtFfMATTx1QcfKuV1/bugdTpTvJrPC7IFAr
	ctzCvXrdXYZHo7xkdTg39WWG6d3o5Gj+1/Wki10=
X-Google-Smtp-Source: AGHT+IFuhLxuodlCfJZ98oWkvvbGD90kBp5dagSX7pMM4e2JBaL3lrkJk+JRFZm+pi12hlED/ZXSeQ==
X-Received: by 2002:a05:6830:2a8a:b0:6d8:74e2:b009 with SMTP id s10-20020a0568302a8a00b006d874e2b009mr7388038otu.71.1701711308682;
        Mon, 04 Dec 2023 09:35:08 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Date: Mon,  4 Dec 2023 11:33:26 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

We are working towards adding support for the offload feature [1] of the
AXI SPI Engine IP core. Before we can do that, we want to make some
general fixes and improvements to the driver. In order to avoid a giant
series with 35+ patches, we are splitting this up into a few smaller
series.

This is a continuation of the work started in [2] which has been applied
to spi/for-6.8 [3]. This series must be applied on top of that series to
apply cleanly.

Once this series is applied, we will follow up with the 3rd series that
implements the offload support. The offload support will also involve
the IIO subsystem (a new IIO driver will depend on the new SPI offload
feature), so I'm mentioning this now in case we want to do anything
ahead of time to prepare for that (e.g. putting all of these changes on
a separate branch).

[1]: https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offload
[2]: https://lore.kernel.org/linux-spi/20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-6.8

---
David Lechner (9):
      spi: axi-spi-engine: return void from spi_engine_compile_message()
      spi: axi-spi-engine: populate xfer->effective_speed_hz
      spi: axi-spi-engine: remove spi_engine_get_clk_div()
      spi: axi-spi-engine: fix sleep ticks calculation
      spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
      spi: axi-spi-engine: implement xfer->cs_change_delay
      spi: axi-spi-engine: restore clkdiv at end of message
      spi: axi-spi-engine: remove delay from CS assertion
      spi: axi-spi-engine: add watchdog timer

 drivers/spi/spi-axi-spi-engine.c | 116 ++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 39 deletions(-)
---
base-commit: 8e6a43961f24cf841d3c0d199521d0b284d948b9
change-id: 20231129-axi-spi-engine-series-2-5f0a6053dea0

