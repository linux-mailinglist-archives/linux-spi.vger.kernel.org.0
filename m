Return-Path: <linux-spi+bounces-6750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCAAA2FE3E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 00:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FC1886B2A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06B253F16;
	Mon, 10 Feb 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TI8M4e5V"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ECE1509A0
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229382; cv=none; b=OE22antMp8S2DYuNar4kwHG1L4gEklFX7U5K1PQknxOUPYlxbxUk9p2rujhzGV4B+AfRZh5WHS9wEnbuwu1EXch4qVRROvcwgHel4xwCkXjWaCNrDGgjJsTTfQNvdm+h6sbgDkeqE7SsowxHGtWE9uudTVmuyXX+7MqwROKFwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229382; c=relaxed/simple;
	bh=NUApKyScjyNwhZt7QISmRvCwSkmNuMrMeDDGrzDTJE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pKsR3i2Nu0bnwsbb8djy4KqhBM82+bHjCFrKKikkMw8T1/020B8S1xMcV7YEl680DetHMw4HcCeO1kk16PScUIy6gutmn9X9YbBlqHKTWJRNmTcrArdmB9YQ2+kB1biGcGOJKPy+NCna8CLh85XVYeu4L/PYv74Tb83uGRj42Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TI8M4e5V; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f6b65c89c4so1237533eaf.2
        for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739229378; x=1739834178; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOTiC9N25oxSFn8PJurmN+X05adw39aPm32FGiYhCiI=;
        b=TI8M4e5VjtidvaV7h9z0OgQwBgGfq01PiIMPInWVy2sexE5/772Y+xAJsgvqPQ9YWB
         B691eb9ytdvzwAms1p4bG2bD4kT91+Q7ANvdMy4N5VXEeeP8Rc854kWi+V+qUwAkWCyq
         +3zghMOn8cU4gbMxCuGOJEf2JQKKKitjqC5ThpTZOE5UX/C4uQ7U4earKKhJXJYpwnJn
         y7rv2TBZAbb61I4zbD1jWGqOIyhW3s32sTq4HWh59ZO5Q+4J9KSj/Q8A7PZlygXahDN4
         hZogLhb2HZitohrSEHKVJsAQRKLVXrIk96L9I45+c/IkO62MLoR4J43NwxyMVooZOvlL
         1PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739229378; x=1739834178;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOTiC9N25oxSFn8PJurmN+X05adw39aPm32FGiYhCiI=;
        b=LQog3dJZjI4TeCNetCmbTwdo8ri53HUhclWYXrIdRjr4kcDvHNL322H5pJum2rV+Nt
         Rzp5C9Hf7MbRjVO6K4aof9eaxn94KZnwuV19I97/Vq8A6NYvA3I6xZZqbXsuBkzbM8N7
         sBfTF++O5ZfVIximO40rf9IxnZ8XNoAclk0Nu8wTw0EffIq2ifcrexlLk7QxNRzYtSkG
         8+UcQzClCzQZYr3EVDMGurf9/6uBgerWF2+SEj4QK/ITm/e1xt+oCr+D2w3p/uz5FyOJ
         KIRgj0qTPaaWwv4fiFIzCQkpvby8Ta1bHuXZyGRYv3T+RqOc/nsCQMMzANSj5NbSWUop
         JPiQ==
X-Gm-Message-State: AOJu0Ywd95fdxh33/tSLcFgCcqZmXormmt6CvasM9HA4jezQAVW3sRPD
	QvAGTbG0Cs4RLWx5kZIp5n9YWpt0qmoa0a3LVb26kuJ3mm5NY/Rj/c71YptGXhCdQCXoNriUeDU
	R
X-Gm-Gg: ASbGncuch3ycpba9xjKtCF12StrlWdZ5/zVFwKfz2YtS7cwSbJvJ27mj3FZW7DMLl00
	ftaPsuBgsVDaNLafPApdswULIepmQH9u8chO7QmzeyMhD/Z1N9foNcjda59d4sFMYKlSVyaeETb
	gqAq/gPbjvu1eWYMd3i7kS7inVygf2qfukE+i6kuhE+fPxO55+TzK2psHZ3THoqN4f+RGKhDuNT
	ygfmtFkf+kN+giF/97Qbmq9AVmYmtsZtI10P/nG485prZ5ZiZ3PUsSgK+H61PvxoypjeSuKXCuP
	ScHu975P9tpmvcjNbKOcBuDNKQYDD989+6jdrQIsRQeuleQ=
X-Google-Smtp-Source: AGHT+IH5xNEjbl5fvc3vvYa7TyhbGhLexFzpDFKP8guUzeJDkdNhhSooVjDClNMHdacLxvGBKWPMkQ==
X-Received: by 2002:a05:6820:1787:b0:5fc:9430:d747 with SMTP id 006d021491bc7-5fc9430de7emr1578893eaf.1.1739229378396;
        Mon, 10 Feb 2025 15:16:18 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc545bc40esm2758043eaf.29.2025.02.10.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:16:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] spi: offload: extra headers
Date: Mon, 10 Feb 2025 17:16:13 -0600
Message-Id: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2IqmcC/x3MQQqDMBBG4avIrDuQRCzVq5QuovlTB8TITBFBv
 Luhy2/x3kkGFRgNzUmKXUzKWuEfDU1zXL9gSdUUXOhc8I5tEy45LyUmxvHTyDNighq/niNC3/s
 2o6Pab4osx//9/lzXDSk7Kn1rAAAA
X-Change-ID: 20250210-spi-offload-extra-headers-86be29913fe5
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2

Following up from some late feedback, a couple patches adding extra
headers to a few SPI offload files.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      spi: offload: types: include linux/bits.h
      spi: spi-offload-trigger-pwm: add extra headers

 drivers/spi/spi-offload-trigger-pwm.c | 9 ++++++++-
 include/linux/spi/offload/types.h     | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: d15cc2db846f73920688c045be6b4c782b68d058
change-id: 20250210-spi-offload-extra-headers-86be29913fe5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


