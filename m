Return-Path: <linux-spi+bounces-10027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E43B584B4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB69F1A27630
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230027AC2F;
	Mon, 15 Sep 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQz73Mq2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6D26AD9
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961461; cv=none; b=oNSFc+8rK/qd8wX4+9dY3T6EbAbcTDm66rW2ZAGTt1/BFuHNcAFTXMY6SA3BK6FUxwMkIOBf4BgjEZDREzLuSNLVEVzXx05oeAGtPBxWETCmD9KhuuTnwp1TEjrXniG6TidTsw4qb7JvcZFoyTBBcE5fzpj/Zedjp9Ac6XfIucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961461; c=relaxed/simple;
	bh=wXEh5XUO1GSsuM+gJYa63BqTnJOA2KRhkUcKEMYt4j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTDvDlFiNB7S/FohXbheW6WBxStKNLV4GaWwxXw/s3QUyb9LGeT0LCnBW9ibSDqiirgGc55LBA0aegCB8MVxuXsKp8K6p5vkeOiihku7DOnCrTzye1VB3Wchltlbd2qn+ABKXZqrRZrDhaXieqEXZp+KN/Gyraq4LqiWL6oi9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQz73Mq2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c28f390eso607059166b.2
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961458; x=1758566258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NE2v9TO71EUWF2H1Q7iKY20vLhOzqrYlcvab2K0WToU=;
        b=gQz73Mq2cAD46LHh356EwS/vufKMDX2YG2nighS91EkQ+H/WTlpcEnOzGxTNkcxzOV
         VIshwBesSukq+wR0qsNwrXEaXf5CRmbwfsI6lWKFiUCTjlysS9H0M/oQ6Zis1s0LHEL3
         7c9+V8Pmgmgp0Tf59f2YeIDWUh3sKqcCq+S+ijDfQWRmC5BkBD70do4BB6mgxosfKGK6
         AYlJ5RFe8xvvV+nJvNwMMbvaW3oE8k8L0v0E1fqV4EYrRWGbMiJ1QU0GMmUMr9IpbUsL
         a0WL9B0kcHQxIl9Zd3GkMnZFFAGggmPxDgPo50Stm/ept3fY6YSatbwNYF6fh/w4N+qo
         iNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961458; x=1758566258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE2v9TO71EUWF2H1Q7iKY20vLhOzqrYlcvab2K0WToU=;
        b=h4tA87GZm0Zr1i064KjItGoVN6cAfZ/kw65jEndhQl0azgOrwlPel58iFA+C8yamy6
         OAYkb1Yjp/w1yKJINwW63LnVOgs1+xe4smnweQTodvBRjwPFrPiIR6m1sQ/UwBs3Zvlw
         ZjwVtSn/ux1iA0g+V6pLesQ772ozpwKpx/bZLOYcvmdOTAJ3Iow9xomSHodHuKP/JrlT
         b68W3hcyNpbVGdDzZPsgJ54EntowJcAJuCSrYN8CttGHLhyaxhAlXtgcWabsjBLffR7n
         rV4DElNL6iZAgxOwVrFFJXlYMvwtFxAJjOeV391VSWrOY5Y9PUXUt4SFM1J/ysyO8TH3
         KMjA==
X-Gm-Message-State: AOJu0YwKCQaTCI330Aj8qhFNlaSe1+xOm1lhzLP+ys1Sg0uh5cQJo1GM
	2YUhnfCPZaRvz+g41OwF58ixPmlglug1WidIS7Z6savBs/S1H1h0ANRVfehhAQ==
X-Gm-Gg: ASbGncvZQx8Zj/UdfgHbJFnK96UmBzMsXKv38ZOSKw1ljCXlQ2AkNzP2cDgMXT8YQMF
	ujmnj6lYWtHM7iasDFOW6T+vnsAvsNVpdmdpWqtA5vOLZD8Kc49U02K54dQRo6cgNEfn3re9b8O
	l1QfBUh9bgDe/3f2EIxXa2C9rD9DMNwQeKUk+M8iFg8K4jKVO91R2xNlCRxyyKf1ayauNNu5qHZ
	XNDX6ohFh2H5CpwU0lThCZ4nWraYRiu6U+N5C2hz06Pyghu34qqlBlGx4/LamzWCOU3gujuEgD2
	fNu51R3H4pLJUce/RjcXHQfLzo8qsRW9l07tWlPDNbjDyaJ1VVKFhyU8exN4ZcxdKPKXvVZHnLa
	0CNbs+LwB95ckL54F0C4D/8mNCgZrupMHb5ULVBj1Y1ds464xAwW2EkNtspEXtBgjfZWp5cDLbv
	Ci75qO6fYT8DnxxA==
X-Google-Smtp-Source: AGHT+IHuWqt68O/G0TZOS+N0wRIMM5ma2QAVQE27OJdGEIQLiGVw+tgoMFYVE8WVnKyG+/zMJSyrSA==
X-Received: by 2002:a17:907:2683:b0:b04:6858:13ce with SMTP id a640c23a62f3a-b07c37fd474mr1435431366b.38.1757961458201;
        Mon, 15 Sep 2025 11:37:38 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715cesm977888466b.48.2025.09.15.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:37 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/7] spi: multi CS cleanup and controller CS limit removal
Date: Mon, 15 Sep 2025 20:37:18 +0200
Message-ID: <20250915183725.219473-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims at cleaning up the current multi CS parts and removing
the CS limit per controller that was introduced with the multi CS
support.

To do this, store the assigned chip selects per device in
spi_device::num_chipselects, which allows us to use that instead of
SPI_CS_CNT_MAX for most loops, as well as remove the check for
SPI_INVALID_CS for any chip select.

This should hopefully make it obvious that SPI_CS_CNT_MAX only limits
accesses to arrays indexed by the number of chip selects of a device,
not the controller, and we can remove the check for
spi_controller::num_chipselects being less than SPI_CS_CNT_MAX in device
registration (which was the wrong place to do that anyway).

After having done that, we can reduce SPI_CS_CNT_MAX again to 4 without
breaking devices on higher CS lines.

Finally, rename SPI_CS_CNT_MAX to SPI_DEVICE_CNT_MAX to make it more
clear that this limit only applies to devices, not controllers.

There are still more issues left, but these can be addressed in future
submissions:

* The code allows multi-cs devices for any controller, as long as the
  device does not set parallel-memories.
* No current spi controller driver handles logical chip selects other
  than the first one, and always use it, regardless what cs_index_mask
  says.
* While most spi controllers should be able to handle devices that have
  multiple cs that just get enabled selectively, but not at the same
  time, there is no way to tell that to the core (ties into the above).
* There is no parallel memories/multi cs flag for devices, so any
  implementing driver needs to check the device tree node, making it
  impossible to register these kind of devices via platform code.

Changes v1 -> v2:

* rebased onto current spi/for-next
* kept the initialization of spi_device::chip_select[] to SPI_INVALID_CS
* reworded the reduce patch to not be a revert anymore

Jonas Gorski (7):
  spi: fix return code when spi device has too many chipselects
  spi: keep track of number of chipselects in spi_device
  spi: move unused device CS initialization to __spi_add_device()
  spi: drop check for validity of device chip selects
  spi: don't check spi_controller::num_chipselect when parsing a dt
    device
  spi: reduce device chip select limit again
  spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX

 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi.c                 | 75 +++++++++++++------------------
 include/linux/spi/spi.h           | 16 ++++---
 3 files changed, 42 insertions(+), 51 deletions(-)


base-commit: 34c2202f5ca2325511a0e0b8802492eec17a2c76
-- 
2.43.0


